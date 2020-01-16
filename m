Return-Path: <SRS0=9Rk5=3F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFCDEC33CAF
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 20:30:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0BFD2073A
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 20:30:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="yfCdRGac"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0BFD2073A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C21B8913D;
	Thu, 16 Jan 2020 20:30:15 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F7558913D
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jan 2020 20:30:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZaEpe3X5NrWZTmhm4grl3apfRMLp6EisCUzYcEGQAin54HO8TTRDtPZlzn+3FDciT4ItIjZip9f4+kziQI6R0QbRXLDsgOT2IH8cYVXq7ijD4ltfZnNgsmqTkoGkxG2Uo/tZrgNH0PQLZfgghhltI2BZet+ySygo9i+sCaPDiTm4ac8HZse6ONG+9WtOA+jYO7EAPjPOxiNRJpbJODjlSUn9IeaPi78/Ufcs2hBpZ0s9vY0U5zTfLdDQXcUcY0oBvOoV9kaAloFVb+YygiUTjcAu1FyiI5XizJKjko8ZFL6UOW/5+gltpJc2WMWrRT1EekH50SSKm5usCYLkIkf/xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1gEUM434Dbqb9upRvYgbrsaHaEa8M5YtxsN17xtm7ZA=;
 b=Ne8EkO/Z/SvC3+udu5u/VGSoaO5+nVxQNNsp+h2KraWqSNtIT7NWnWVQnxdnuQh3w4jB6VV/dPcsTflo7wXBNJnzZNmm+fIrOVVzTeHPO8lUYGiURCq+zpw+ZJHqjbgxkphGbLOxwTX9pa5YChWlHcXVlsl0KOVAlE+HslDTkeo9Ew3tayey9jAxiQiLZt3zpSzJCq99TzG7PgjC1txlrfjFcB98CoL184pIrxgkzSkVqv9ntElY2QkhDhkfaX9yt/wB8v6FZ35wsAIxpJgwjlGYQP/0Q+U9zBe2N8f20+rjhUp/YSkzEyGPfo5wEoDTJhqfedRQX8e6cGuKwBH1ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1gEUM434Dbqb9upRvYgbrsaHaEa8M5YtxsN17xtm7ZA=;
 b=yfCdRGacUspFwCvSd49Vr8phFyM8mDZLRYGL1mOIeEROcJ/1vMawopSh2GV3ToHeS40LR/JedSqLjLTxE22jZ3/WWadcxzoseynr42io/xRSe41Dk9ltsPEk3Vezcott8J5nRUj5pkphkSwu4PfKJ8MBNbV1zKV9mOBc89YjD1I=
Received: from SN1PR12CA0044.namprd12.prod.outlook.com (2603:10b6:802:20::15)
 by BY5PR12MB4305.namprd12.prod.outlook.com (2603:10b6:a03:213::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.18; Thu, 16 Jan
 2020 20:30:12 +0000
Received: from CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::201) by SN1PR12CA0044.outlook.office365.com
 (2603:10b6:802:20::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.13 via Frontend
 Transport; Thu, 16 Jan 2020 20:30:11 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT029.mail.protection.outlook.com (10.13.174.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2644.19 via Frontend Transport; Thu, 16 Jan 2020 20:30:11 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 16 Jan
 2020 14:30:08 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 16 Jan
 2020 14:30:08 -0600
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 16 Jan 2020 14:30:08 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/5] drm/amd/display: Add sysfs interface for set/get srm
Date: Thu, 16 Jan 2020 15:29:43 -0500
Message-ID: <20200116202945.21801-4-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200116202945.21801-1-Bhawanpreet.Lakha@amd.com>
References: <20200116202945.21801-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(136003)(346002)(376002)(428003)(189003)(199004)(70586007)(26005)(81166006)(81156014)(8936002)(8676002)(1076003)(70206006)(2906002)(2616005)(426003)(6916009)(356004)(5660300002)(336012)(186003)(36756003)(6666004)(4326008)(86362001)(54906003)(7696005)(316002)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BY5PR12MB4305; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 58bcc8ba-bb44-4ec4-fb0c-08d79ac2e2ea
X-MS-TrafficTypeDiagnostic: BY5PR12MB4305:
X-Microsoft-Antispam-PRVS: <BY5PR12MB430559A58482BB41D85E04D8F9360@BY5PR12MB4305.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 02843AA9E0
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f2/56U91KSaJKVO8f9J0qxxmNkZlwG45pXUmhARI/lTL9KkQfLq0VTCZ+QbeZ3o03oBfelbGqkIshNwW4YfPfBYIMUAI9DlJU3EJHenLN4o+M37HfARiScfOxwEopqqGBnct1BJbD0kq2gwGd0U4tDX953A1w00gmJvenKTTMqnFjkKheDq+r7l03F9NsUG3VrZKFha9Tbq4qGU+WDaTt75LKRwrwhHAIKiGLFm7WkH8xetQlOGmm7dTsl9QVrfEcH+Fw8mDCsPFiFll5EeukljX2TrCkk4Lw2DBmzqinaCtnM5XmsqAqFrPngSQfheO2X3Yl8r7ZePM0XrPicY8q5RKG7tOuMdXBnnzExZpTT3ZlRpnSTqeh3pIVKxnyzxnM4aS/7GV/UCxIop9/WotqyFEOsatUVYH3g/tR9Zmjs+P5hemKu2Vr/RnytaVHhpV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2020 20:30:11.6006 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58bcc8ba-bb44-4ec4-fb0c-08d79ac2e2ea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4305
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, harry.wentland@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
We need to set/get SRM and linux kernel is not suppose to write to the
storage, so we need to provide a interface.

[How]
Provide interface so usermode can set/get srm

Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    | 124 +++++++++++++++++-
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.h    |   6 +
 2 files changed, 128 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
index a269916f7dd6..a191c84ad8eb 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
@@ -28,6 +28,8 @@
 #include "amdgpu_dm.h"
 #include "dm_helpers.h"
 #include <drm/drm_hdcp.h>
+#include "hdcp_psp.h"
+
 
 static bool
 lp_write_i2c(void *handle, uint32_t address, const uint8_t *data, uint32_t size)
@@ -67,6 +69,16 @@ lp_read_dpcd(void *handle, uint32_t address, uint8_t *data, uint32_t size)
 	return dm_helpers_dp_read_dpcd(link->ctx, link, address, data, size);
 }
 
+static uint8_t *psp_get_srm(struct psp_context *psp, uint32_t *srm_version, uint32_t *srm_size)
+{
+	return NULL;
+}
+
+static int psp_set_srm(struct psp_context *psp, uint8_t *srm, uint32_t srm_size, uint32_t *srm_version)
+{
+	return 0;
+}
+
 static void process_output(struct hdcp_workqueue *hdcp_work)
 {
 	struct mod_hdcp_output output = hdcp_work->output;
@@ -88,6 +100,18 @@ static void process_output(struct hdcp_workqueue *hdcp_work)
 	schedule_delayed_work(&hdcp_work->property_validate_dwork, msecs_to_jiffies(0));
 }
 
+static void link_lock(struct hdcp_workqueue *work, bool lock)
+{
+
+	int i = 0;
+
+	for (i = 0; i < work->max_link; i++) {
+		if (lock)
+			mutex_lock(&work[i].mutex);
+		else
+			mutex_unlock(&work[i].mutex);
+	}
+}
 void hdcp_update_display(struct hdcp_workqueue *hdcp_work,
 			 unsigned int link_index,
 			 struct amdgpu_dm_connector *aconnector,
@@ -302,7 +326,8 @@ void hdcp_destroy(struct hdcp_workqueue *hdcp_work)
 	}
 
 	kfree(hdcp_work);
-
+	kfree(hdcp_work->srm);
+	kfree(hdcp_work->srm_temp);
 }
 
 static void update_config(void *handle, struct cp_psp_stream_config *config)
@@ -338,6 +363,84 @@ static void update_config(void *handle, struct cp_psp_stream_config *config)
 	hdcp_update_display(hdcp_work, link_index, aconnector, DRM_MODE_HDCP_CONTENT_TYPE0, false);
 }
 
+
+/*
+ * This can be called twice, because SRM_SIZE > PAGE_SIZE.
+ *
+ * We set the SRM on each call, if SRM_SIZE > PAGE_SIZE, PSP will fail on the
+ * first call but pass on the second call.
+ *
+ * Because of this we are not throwing any errors as it will stop the next call.
+ * So it is a good idea to call the "read" sysfs to verify that the SRM was set
+ *
+ */
+static ssize_t srm_data_write(struct file *filp, struct kobject *kobj, struct bin_attribute *bin_attr, char *buffer,
+			      loff_t pos, size_t count)
+{
+	struct hdcp_workqueue *work;
+	uint32_t srm_version = 0;
+
+	work = container_of(bin_attr, struct hdcp_workqueue, attr);
+	link_lock(work, true);
+
+	memcpy(work->srm_temp + pos, buffer, count);
+
+	if (!psp_set_srm(work->hdcp.config.psp.handle, work->srm_temp, pos + count, &srm_version)) {
+		DRM_DEBUG_DRIVER("HDCP SRM SET version 0x%X", srm_version);
+		memcpy(work->srm, work->srm_temp, pos + count);
+		work->srm_size = pos + count;
+		work->srm_version = srm_version;
+	}
+
+
+	link_lock(work, false);
+
+	return count;
+}
+
+static ssize_t srm_data_read(struct file *filp, struct kobject *kobj, struct bin_attribute *bin_attr, char *buffer,
+			     loff_t pos, size_t count)
+{
+	struct hdcp_workqueue *work;
+	uint8_t *srm = NULL;
+	uint32_t srm_version;
+	uint32_t srm_size;
+	size_t ret = count;
+
+	work = container_of(bin_attr, struct hdcp_workqueue, attr);
+
+	link_lock(work, true);
+
+	srm = psp_get_srm(work->hdcp.config.psp.handle, &srm_version, &srm_size);
+
+	if (!srm)
+		return -EINVAL;
+
+	if (pos >= srm_size)
+		ret = 0;
+
+	if (srm_size - pos < count) {
+		memcpy(buffer, srm + pos, srm_size - pos);
+		ret = srm_size - pos;
+		goto ret;
+	}
+
+	memcpy(buffer, srm + pos, count);
+
+ret:
+	link_lock(work, false);
+	return ret;
+}
+
+
+static const struct bin_attribute data_attr = {
+	.attr = {.name = "hdcp_srm", .mode = 0664},
+	.size = PSP_HDCP_SRM_FIRST_GEN_MAX_SIZE, /* Limit SRM size */
+	.write = srm_data_write,
+	.read = srm_data_read,
+};
+
+
 struct hdcp_workqueue *hdcp_create_workqueue(struct amdgpu_device *adev, struct cp_psp *cp_psp, struct dc *dc)
 {
 
@@ -348,10 +451,19 @@ struct hdcp_workqueue *hdcp_create_workqueue(struct amdgpu_device *adev, struct
 	if (hdcp_work == NULL)
 		goto fail_alloc_context;
 
+	hdcp_work->srm = kcalloc(PSP_HDCP_SRM_FIRST_GEN_MAX_SIZE, sizeof(*hdcp_work->srm), GFP_KERNEL);
+
+	if (hdcp_work->srm == NULL)
+		goto fail_alloc_context;
+
+	hdcp_work->srm_temp = kcalloc(PSP_HDCP_SRM_FIRST_GEN_MAX_SIZE, sizeof(*hdcp_work->srm_temp), GFP_KERNEL);
+
+	if (hdcp_work->srm_temp == NULL)
+		goto fail_alloc_context;
+
 	hdcp_work->max_link = max_caps;
 
 	for (i = 0; i < max_caps; i++) {
-
 		mutex_init(&hdcp_work[i].mutex);
 
 		INIT_WORK(&hdcp_work[i].cpirq_work, event_cpirq);
@@ -371,10 +483,18 @@ struct hdcp_workqueue *hdcp_create_workqueue(struct amdgpu_device *adev, struct
 	cp_psp->funcs.update_stream_config = update_config;
 	cp_psp->handle = hdcp_work;
 
+	/* File created at /sys/class/drm/card0/device/hdcp_srm*/
+	hdcp_work[0].attr = data_attr;
+
+	if (sysfs_create_bin_file(&adev->dev->kobj, &hdcp_work[0].attr))
+		DRM_WARN("Failed to create device file hdcp_srm");
+
 	return hdcp_work;
 
 fail_alloc_context:
 	kfree(hdcp_work);
+	kfree(hdcp_work->srm);
+	kfree(hdcp_work->srm_temp);
 
 	return NULL;
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h
index 331b50825510..5159b3a5e5b0 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h
@@ -53,6 +53,12 @@ struct hdcp_workqueue {
 
 	enum mod_hdcp_encryption_status encryption_status;
 	uint8_t max_link;
+
+	uint8_t *srm;
+	uint8_t *srm_temp;
+	uint32_t srm_version;
+	uint32_t srm_size;
+	struct bin_attribute attr;
 };
 
 void hdcp_update_display(struct hdcp_workqueue *hdcp_work,
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
