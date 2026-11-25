// HOOK ANTIBAN 

#import <UIKit/UIKit.h>

// تعطيل تقارير الأعطال ومقاييس الأداء
%hook NSURLSessionConfiguration
- (void)set_reportsDataStalls:(bool)arg1 {
    arg1 = 0;
    %orig;
}

- (bool)_reportsDataStalls {
    return 0;
}
%end

%hook __NSCFBackgroundAVAssetDownloadTask
- (void)_finishProgressReporting {
}
%end

%hook NSURLSessionTask
- (void)_finishProgressReporting {
}
%end

// تعطيل تقارير شبكة CFNetwork
%hook __NSURLSessionStatistics
- (id)initWithCFNetworkReport:(void*)arg1 length:(long long)arg2 {
    return NULL;
}

- (id)awdReport {
    return %orig;
}

+ (void)reportMetricsToSymptoms:(id)arg1 {
}
%end

// تعطيل تقارير الحزم
%hook NSURLSessionTaskTransactionMetrics
- (id)_establishmentReport {
    return NULL;
}

- (id)_dataTransferReport {
    return NULL;
}
%end



// منع تقارير الأخطاء الأمنية المتعلقة بالشبكة
%hook NSURLSessionTask
- (id)_errorReport {
    return NULL;
}
%end

// تعطيل تقارير الحزم المحفوظة
%hook __NSURLSessionStatistics
- (id)saveSessionMetrics:(void*)arg1 length:(long long)arg2 {
    return NULL;
}
%end

// تعطيل مراقبة الزمن المستغرق لإنشاء الاتصال
%hook NSURLSessionTaskTransactionMetrics
- (double)_connectionStartTime {
    return 0.0;
}
%end

// تعطيل مراقبة زمن إنهاء الاتصال
%hook NSURLSessionTaskTransactionMetrics
- (double)_connectionEndTime {
    return 0.0;
}
%end

// منع السيرفر من تتبع سرعة تحميل البيانات
%hook NSURLSessionTaskTransactionMetrics
- (double)_uploadDataRate {
    return 0.0;
}
%end

// منع السيرفر من تتبع سرعة تنزيل البيانات
%hook NSURLSessionTaskTransactionMetrics
- (double)_downloadDataRate {
    return 0.0;
}
%end

// تعطيل مقاييس التحليل الزمني لإنشاء الشبكة
%hook NSURLSessionTaskTransactionMetrics
- (double)_networkProtocolStartTime {
    return 0.0;
}
%end

// تعطيل مقاييس التحليل الزمني للنهاية
%hook NSURLSessionTaskTransactionMetrics
- (double)_networkProtocolEndTime {
    return 0.0;
}
%end

// تعطيل تقارير مراقبة الاتصال
%hook __NSCFBackgroundAVAssetDownloadTask
- (void)_startConnectionMonitoring {
}
%end

// تعطيل الفحص الأمني للبروتوكولات
%hook NSURLSessionTask
- (void)_verifyProtocolReports {
}
%end

// تعطيل فحص البيانات المرسلة
%hook NSURLSessionTask
- (void)_verifyOutgoingData {
}
%end

// تعطيل فحص البيانات المستقبلة
%hook NSURLSessionTask
- (void)_verifyIncomingData {
}
%end

// إخفاء حالة الإتصال من السيرفر
%hook NSURLSessionTaskTransactionMetrics
- (NSString *)_connectionState {
    return @"Disconnected";
}
%end

// تعطيل مراقبة حجم البيانات
%hook NSURLSessionTaskTransactionMetrics
- (long long)_dataTransferSize {
    return 0;
}
%end

// تعطيل الفحص الشبكي للبروتوكولات
%hook NSURLSessionConfiguration
- (void)_setProtocolInspection:(bool)arg1 {
    arg1 = 0;
    %orig;
}
%end

// تعطيل إرسال بيانات الجهاز إلى السيرفر
%hook NSURLSessionTask
- (id)_deviceInformationReport {
    return NULL;
}
%end

// تعطيل مراقبة حالة التحميل
%hook NSURLSessionTask
- (void)_monitorDownloadState {
}
%end

// منع السيرفر من فحص بروتوكولات الأمان
%hook NSURLSessionTask
- (void)_securityProtocolCheck {
}
%end

// منع إرسال تقارير الفشل الأمني إلى السيرفر
%hook NSURLSessionTask
- (void)_reportSecurityFailure {
}
%end

// إخفاء طلبات البيانات السرية من السيرفر
%hook NSURLSessionTask
- (id)_secretDataRequest {
    return NULL;
}
%end

// تعطيل مراقبة وتحليل وقت البدء في إرسال البيانات
%hook NSURLSessionTaskTransactionMetrics
- (double)_dataTransferStartTime {
    return 0.0;
}
%end

// تعطيل مراقبة وتحليل وقت إنهاء إرسال البيانات
%hook NSURLSessionTaskTransactionMetrics
- (double)_dataTransferEndTime {
    return 0.0;
}
%end

// تعطيل مراقبة سجلات الحماية الداخلية
%hook NSURLSessionTask
- (void)_monitorSecurityLogs {
}
%end

// تعطيل مراقبة الزمن المستغرق لإنشاء الاتصال بعد الإرسال
%hook NSURLSessionTaskTransactionMetrics
- (double)_postSendConnectionStartTime {
    return 0.0;
}
%end

// منع السيرفر من مراقبة ضغط الحزم
%hook NSURLSessionTaskTransactionMetrics
- (double)_packetCompressionRate {
    return 0.0;
}
%end

// إخفاء نشاطات الخلفية المتعلقة بالبروتوكولات
%hook NSURLSessionTask
- (void)_hideBackgroundProtocolActivity {
}
%end

%hook NSURLSessionTask
- (void)_disableBackgroundDataTransfer {
}
%end

%hook NSURLSessionTask
- (void)_preventBackgroundNetworkActivity {
}
%end