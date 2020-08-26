Return-Path: <SRS0=g3tc=CE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E07AAC433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2020 14:46:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B03222078D
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2020 14:46:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="GwyssRtt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B03222078D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7051B6EA9C;
	Wed, 26 Aug 2020 14:46:48 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7520B6EA94
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2020 14:46:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IldzmWGCQRWvlAYrEYIkVx60NqU5WiveNA0jSTThgS7dYmTpQUcoYY6mWoZrf+2KaWgsMtpPCfMp0lA8okKuD3AWKmSGUCoJVLln3xS0MM8LEXxMjQ2E25pnMaye8mBzbHgJRG37TCFyMaRJZVREpbMXVQnkwsCgT0Qzk44ZInDLvCIlK/Z1+fWTk3Xf39Mfqph3JKwHpRyPH9jR1c71GN3f+DqRVB2yRskif8QZjVXuYLoQqZtsLV5d8SF95Lb1moFE4g3AN5dujdeD03trC9KikiTdr/RLdi05q4VUItr5OnSTcMGH/3kqhEfiVgokUWXXQbK6/4xjZce+86GlKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r/FqUd5Wrb2fnjPsYs7TUlp5nTKtaemZr/mhz/OIO5E=;
 b=J9EysTheH6rOD4Xz/G3Gf9MNd02RVS72PORsSqCKbuvyrT7yGJ8fbMHxDeUsFSD05tbZw9G0TJZo8pwkmJRueKVW5SrgedroQj0Y4j6DKSn4F0gxK5sPHKU/+pvAFr1+Dd2mmkc88+ExY0vBYtPNNq8cgHuMRK4ck4Hq3xbhJtLUWHiiUmoD9c7SdkXKQoTBKa+KXSVWPKBjOKY27SEqjhbNNb6BteUIJCK3fWaonFGxrhb4Mb/AayxXNsO9hKX3+VGJ2eJ1NQ3ZtaWbJg9jtdVdOdg6MO9RVLfBveYtmo60j1mC9Od+6oNevP4XC0rB8bYmbDw9ZMJi++Kh6IbaiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r/FqUd5Wrb2fnjPsYs7TUlp5nTKtaemZr/mhz/OIO5E=;
 b=GwyssRttB1DlOskLcXfh9jsZZhLKyZ80+P4BGvYx9yTNxfATH9Y34au40oheuBQaW5RrxeRIwR5/UjHSG9aKXXLW7KPHGaZP4uQ4NerM1lb6U+goBl3cb2advIsviIRl+knqmvi0R5U355VHE2+vyS/suPbZND2G86NfKvVP4MY=
Received: from MWHPR22CA0042.namprd22.prod.outlook.com (2603:10b6:300:69::28)
 by SN6PR12MB2637.namprd12.prod.outlook.com (2603:10b6:805:6b::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Wed, 26 Aug
 2020 14:46:42 +0000
Received: from CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:69:cafe::ee) by MWHPR22CA0042.outlook.office365.com
 (2603:10b6:300:69::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend
 Transport; Wed, 26 Aug 2020 14:46:41 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT033.mail.protection.outlook.com (10.13.174.247) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3326.19 via Frontend Transport; Wed, 26 Aug 2020 14:46:41 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 26 Aug
 2020 09:46:37 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 26 Aug
 2020 09:46:37 -0500
Received: from agrodzovsky-All-Series.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Wed, 26 Aug 2020 09:46:36 -0500
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/7] drm/amdgpu: Fix consecutive DPC recoveries failure.
Date: Wed, 26 Aug 2020 10:46:20 -0400
Message-ID: <1598453182-6946-6-git-send-email-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1598453182-6946-1-git-send-email-andrey.grodzovsky@amd.com>
References: <1598453182-6946-1-git-send-email-andrey.grodzovsky@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2888889b-4c84-44a5-7f5c-08d849ced875
X-MS-TrafficTypeDiagnostic: SN6PR12MB2637:
X-Microsoft-Antispam-PRVS: <SN6PR12MB2637F2C73069268B34A54301EA540@SN6PR12MB2637.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wqt5eUhxEUL+eFbfW4uIa0z8jpxBee9700tJNI2lA4F5IdNkXKZbpBnnKgZfbDoOU2le0g5xlZyPfCGz3sGbNO5CZ9Dk+tuXNlKSnklxioh3nJk3HTpaCz11U38nBUkCsWOFeox1hGM0frQg2llISIQSiFVKFaACzBx7H5XKNN/o7Mx3mvhcwk1F0+brYUCgXrJPJW8phkM4oqCxY1pKunUwRxRo1If7Cz4RXn0OdGGJqyAWxz/AlmjilPgrA1zDyubSjolTw1IYtS8THvl0y2H6Vv2xiM0s36+JeshWBSa39CMfZLFCVDB0/iXd4LqSSd5I8qIXfymOTIzTKZGSJxJpeZjHgm1MGhTEfFZH4Ypwid8+A/olU2ouyDFTO18+jPTLxeHadbLtawnGmdptWA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(376002)(136003)(396003)(46966005)(26005)(2906002)(8676002)(336012)(6666004)(2616005)(36756003)(5660300002)(8936002)(426003)(44832011)(186003)(70206006)(478600001)(70586007)(316002)(86362001)(356005)(82740400003)(6916009)(4326008)(47076004)(81166007)(82310400002)(54906003)(7696005)(83380400001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2020 14:46:41.4985 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2888889b-4c84-44a5-7f5c-08d849ced875
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2637
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
Cc: alexander.deucher@amd.com, Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 nirmodas@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

DPC recovery after prev. DPC recovery or after prev. MODE1 reset fails
unles you save the cashe the saved PCI confspace to load it after
each new reset.
Also use same cached state for other use case of restoring PCI confspace
such as GPU mode1 or VGA switheroo.

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  6 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 60 +++++++++++++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  4 +-
 drivers/gpu/drm/amd/amdgpu/nv.c            |  4 +-
 drivers/gpu/drm/amd/amdgpu/soc15.c         |  4 +-
 5 files changed, 66 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 3489622..42ee208 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -992,7 +992,9 @@ struct amdgpu_device {
 	atomic_t			throttling_logging_enabled;
 	struct ratelimit_state		throttling_logging_rs;
 	uint32_t			ras_features;
+
 	bool                            in_dpc;
+	struct pci_saved_state          *pci_state;
 };
 
 static inline struct amdgpu_device *drm_to_adev(struct drm_device *ddev)
@@ -1272,6 +1274,10 @@ pci_ers_result_t amdgpu_pci_mmio_enabled(struct pci_dev *pdev);
 pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev);
 void amdgpu_pci_resume(struct pci_dev *pdev);
 
+bool amdgpu_device_cache_pci_state(struct pci_dev *pdev);
+bool amdgpu_device_load_pci_state(struct pci_dev *pdev);
+
+
 
 #include "amdgpu_object.h"
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index d9e3994..2c088df 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1283,7 +1283,7 @@ static void amdgpu_switcheroo_set_state(struct pci_dev *pdev,
 		dev->switch_power_state = DRM_SWITCH_POWER_CHANGING;
 
 		pci_set_power_state(dev->pdev, PCI_D0);
-		pci_restore_state(dev->pdev);
+		amdgpu_device_load_pci_state(dev->pdev);
 		r = pci_enable_device(dev->pdev);
 		if (r)
 			DRM_WARN("pci_enable_device failed (%d)\n", r);
@@ -1296,7 +1296,7 @@ static void amdgpu_switcheroo_set_state(struct pci_dev *pdev,
 		drm_kms_helper_poll_disable(dev);
 		dev->switch_power_state = DRM_SWITCH_POWER_CHANGING;
 		amdgpu_device_suspend(dev, true);
-		pci_save_state(dev->pdev);
+		amdgpu_device_cache_pci_state(dev->pdev);
 		/* Shut down the device */
 		pci_disable_device(dev->pdev);
 		pci_set_power_state(dev->pdev, PCI_D3cold);
@@ -3401,8 +3401,9 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	if (r)
 		dev_err(adev->dev, "amdgpu_pmu_init failed\n");
 
-	if (pci_save_state(pdev))
-		DRM_ERROR("Failed to save PCI state!!\n");
+	/* Have stored pci confspace at hand for restore in sudden PCI error */
+	if (!amdgpu_device_cache_pci_state(adev->pdev))
+		DRM_WARN("Failed to cache PCI state!");
 
 	return 0;
 
@@ -3430,6 +3431,8 @@ void amdgpu_device_fini(struct amdgpu_device *adev)
 	flush_delayed_work(&adev->delayed_init_work);
 	adev->shutdown = true;
 
+	kfree(adev->pci_state);
+
 	/* make sure IB test finished before entering exclusive mode
 	 * to avoid preemption on IB test
 	 * */
@@ -4855,7 +4858,7 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
 	/* wait for asic to come out of reset */
 	msleep(500);
 
-	pci_restore_state(pdev);
+	amdgpu_device_load_pci_state(pdev);
 
 	/* confirm  ASIC came out of reset */
 	for (i = 0; i < adev->usec_timeout; i++) {
@@ -4934,8 +4937,10 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
 
 out:
 
-	if (!r)
+	if (!r) {
+		amdgpu_device_cache_pci_state(adev->pdev);
 		DRM_INFO("PCIe error recovery succeeded\n");
+	}
 	else {
 		DRM_ERROR("PCIe error recovery failed, err:%d", r);
 		amdgpu_device_unlock_adev(adev);
@@ -4974,3 +4979,46 @@ void amdgpu_pci_resume(struct pci_dev *pdev)
 
 	amdgpu_device_unlock_adev(adev);
 }
+
+bool amdgpu_device_cache_pci_state(struct pci_dev *pdev)
+{
+	struct drm_device *dev = pci_get_drvdata(pdev);
+	struct amdgpu_device *adev = drm_to_adev(dev);
+	int r;
+
+	r = pci_save_state(pdev);
+	if (!r) {
+		kfree(adev->pci_state);
+
+		adev->pci_state = pci_store_saved_state(pdev);
+
+		if (!adev->pci_state) {
+			DRM_ERROR("Failed to store PCI saved state");
+			return false;
+		}
+	} else {
+		DRM_WARN("Failed to save PCI state, err:%d\n", r);
+		return false;
+	}
+
+	return true;
+}
+
+bool amdgpu_device_load_pci_state(struct pci_dev *pdev)
+{
+	struct drm_device *dev = pci_get_drvdata(pdev);
+	struct amdgpu_device *adev = drm_to_adev(dev);
+	int r;
+
+	if (!adev->pci_state)
+		return false;
+
+	r = pci_load_saved_state(pdev, adev->pci_state);
+
+	if (!r) {
+		pci_restore_state(pdev);
+	} else {
+		DRM_WARN("Failed to load PCI state, err:%d\n", r);
+		return false;
+	}
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 4bbcc70..7a6482a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1320,7 +1320,7 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
 		if (amdgpu_is_atpx_hybrid()) {
 			pci_ignore_hotplug(pdev);
 		} else {
-			pci_save_state(pdev);
+			amdgpu_device_cache_pci_state(pdev);
 			pci_disable_device(pdev);
 			pci_ignore_hotplug(pdev);
 			pci_set_power_state(pdev, PCI_D3cold);
@@ -1353,7 +1353,7 @@ static int amdgpu_pmops_runtime_resume(struct device *dev)
 			pci_set_master(pdev);
 		} else {
 			pci_set_power_state(pdev, PCI_D0);
-			pci_restore_state(pdev);
+			amdgpu_device_load_pci_state(pdev);
 			ret = pci_enable_device(pdev);
 			if (ret)
 				return ret;
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 4d14023..0ec6603 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -311,7 +311,7 @@ static int nv_asic_mode1_reset(struct amdgpu_device *adev)
 	/* disable BM */
 	pci_clear_master(adev->pdev);
 
-	pci_save_state(adev->pdev);
+	amdgpu_device_cache_pci_state(adev->pdev);
 
 	if (amdgpu_dpm_is_mode1_reset_supported(adev)) {
 		dev_info(adev->dev, "GPU smu mode1 reset\n");
@@ -323,7 +323,7 @@ static int nv_asic_mode1_reset(struct amdgpu_device *adev)
 
 	if (ret)
 		dev_err(adev->dev, "GPU mode1 reset failed\n");
-	pci_restore_state(adev->pdev);
+	amdgpu_device_load_pci_state(adev->pdev);
 
 	/* wait for asic to come out of reset */
 	for (i = 0; i < adev->usec_timeout; i++) {
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 2f93c47..ddd55e3 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -484,13 +484,13 @@ static int soc15_asic_mode1_reset(struct amdgpu_device *adev)
 	/* disable BM */
 	pci_clear_master(adev->pdev);
 
-	pci_save_state(adev->pdev);
+	amdgpu_device_cache_pci_state(adev->pdev);
 
 	ret = psp_gpu_reset(adev);
 	if (ret)
 		dev_err(adev->dev, "GPU mode1 reset failed\n");
 
-	pci_restore_state(adev->pdev);
+	amdgpu_device_load_pci_state(adev->pdev);
 
 	/* wait for asic to come out of reset */
 	for (i = 0; i < adev->usec_timeout; i++) {
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
