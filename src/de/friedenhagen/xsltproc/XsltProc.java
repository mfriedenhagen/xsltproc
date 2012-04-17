/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package de.friedenhagen.xsltproc;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerConfigurationException;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;

/**
 *
 * @author mirko
 */
public class XsltProc {

    final static String ENCODING = System.getProperty("encoding", "utf-8");
    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) throws TransformerConfigurationException, TransformerException, UnsupportedEncodingException, FileNotFoundException {
        final TransformerFactory factory = TransformerFactory.newInstance();
        final StreamSource styleSheet = new StreamSource(new File(args[0]));
        final Transformer transformer = factory.newTransformer(styleSheet);
        transformer.setOutputProperty(OutputKeys.INDENT, "yes");
        final StreamSource inputXml = new StreamSource(new InputStreamReader(new FileInputStream(args[1]), ENCODING));
        transformer.transform(inputXml, new StreamResult(System.out));
    }
}
