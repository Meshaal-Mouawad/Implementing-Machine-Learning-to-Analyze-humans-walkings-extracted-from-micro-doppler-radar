# Implementing-Machine-Learning-to-Analyze-humans-walkings-extracted-from-micro-doppler-radar
(Implementing digital signal processing methods with Machine Learning Machine Learning for Radars)
* This project is good for new engineers who want to understand digital signal processing and machine learning.
* Use digital filters in radars for new students.
# Procedure :
In this project, teams have assigned to :
* (1) Examin how filter type, length and Fast Fourier Transform (FFT) order affect the resolution.
* (2) Use a Short-time Fourier transform (STFT) to identify signals in time and frequency concurrently.
* (3) Use simulated micro‐Doppler signatures to analyze human movement and to predict outputs using a Support Vector Machine (SVM).
# Abstract
<p>Three experiments were examined in this technical project for digital signal processing. In experiment 1, we analyzed and examined how the Fast Fourier Transform (FFT) resolution was affected by adjusting the filter length, the filter type, and the FFT order. An FFT Physical resolution and a Computational Resolution were discussed in experiment 1. In experiment 2, the data was given in MATLAB and we investigated the signals concurrently in time and frequency using the Short-time Fourier transform (STFT). We estimated the sampling rate and briefly discussed the Short-time Fourier transform (STFT) and the FFT in terms of how different they are. The Short-time Fourier transform (STFT) and Support Vector Machine (SVM) were discussed in experiment 3. We implemented an SVM to estimate four walking speeds using features extracted from simulated micro-doppler radar for walking humans. Figures of the STFT magnitude of each class are presented and discussed the basics of Doppler Effect as well as micro-doppler. We examined the results using a confusion matrix for training and testing and the best results are presented. MATLAB and related tools were used in this project and the code is provided in the report.<p/>

# Experments:
## Experiment 1: Fast Fourier Transform (FFT) Resolutions
This experiment examines how filter length, filter type, and FFT order affect FFT resolutions.
## Experiment 2: The Short-time Fourier transform (STFT)
In this experiment, teams identify signals concurrently in time and frequency using the STFT.
## Experiment 3: The Short-time Fourier transform (STFT) and Support Vector Machine (SVM) for radar analysis.
In this experiment, teams will use features extracted from simulated radar MicroDoppler of walking humans at different speeds and an SVM to estimate four walking speeds (classes) using Machine Learning.
## Modification on Experiment 2:
Modify the experiment 2 to create a Linear Frequency Modulation (LFM) pulse and analyze it using the STFT, then determine a good sigma value to use.
## Modification on Experiment 3 : 
Modify experiment 3 the libsvm_train_str to use a Radial Basis Function (RBF) kernel. Try different kernel parameters and examine if possible to improve the results. Compare and see if this method beats the results in 3a.

# Instructions To Use The Project Code
*will be added soon ...

# Conclusions
In the experiment one, computational resolution and physical resolution has been calculation. We can see that these two resolutions depend on the number of FFT points N and window Length L. When we take high FFT point (N), we get low computational resolution by keeping the sampling frequency same and vice versa. On the other hand, if we increased the window length, we got low physical resolution if we kept the window and sampling frequency same. 

STFT, the Short Time Fourier Transform, computes the signal phase and frequency in a more localized manner. In STFT, we shift the window and capture the time domain signal and at the same time compute the N point fast Fourier transform. Where the standard Fourier transform computes the average frequency for the time interval of overall signal. We visualized the STFT by plotting the spectrogram plot.

The radar signature on a moving object is depicted as the doppler effect. Where, the radar signature of the moving parts of the target object is defined by micro doppler effect. In this experiment, we examine the micro doppler effect of the human walking. We examine the four-class data set with the support vector machine to distinctly identify the movements of the different portion of the legs of human movement. We were able to improve the training and testing accuracy. All the four classes have been detected in feature 6.

Support vector-based classifier is used to classify the micro doppler of human movement. In our experiment, we modified SVM kernel to get the improved performance of the support vector machine. we were able to identify the different micro doppler effect of different speed of the human walking.
