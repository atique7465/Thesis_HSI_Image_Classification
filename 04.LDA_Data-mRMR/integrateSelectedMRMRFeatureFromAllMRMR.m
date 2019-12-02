load('aaf_selected_feature_mRMR.mat')
load('binary_selected_feature_mRMR.mat')
load('CKSAAP_selected_feature_mRMR.mat')
load('PSAAP_selected_feature_mRMR.mat')


%integrateSelectedMRMRFeature=[aaf_selected_feature_mRMR, binary_selected_feature_mRMR, CKSAAP_selected_feature_mRMR,PSAAP_selected_feature_mRMR];
integrateSelectedMRMRFeature=[aaf_selected_feature_mRMR(:,1:20), binary_selected_feature_mRMR(:,1:50), CKSAAP_selected_feature_mRMR(:,1:200),PSAAP_selected_feature_mRMR];

save integrateSelectedMRMRFeature_4Feature_2.mat integrateSelectedMRMRFeature;