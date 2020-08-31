Return-Path: <SRS0=7vr2=CJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5B92C433E2
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2020 15:51:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2FBA20719
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2020 15:51:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="sjL3qZ3y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2FBA20719
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49E6B89C49;
	Mon, 31 Aug 2020 15:51:09 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38D8389C49
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2020 15:51:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pm3VxtZdJ2uo4+dFemsR03FoaJWVWXc1S1BxCN4+HraFtOEp5sh4GdM2KgmpNiw9x562AqRqr38ZUqzqWTuiadP0cN5C3EFerom0BcFQWlv6Ugi9Buj5PVi85abf4dUZrpgah5hsYzezPeiJnsBe42yi+kFz7h0Nrv+N+v+T88mLpC9nT57E3c1xHb6AZZI+HwwuFrk8iKVFM0Ci71eEK310J5fyFVmFLRnKhz3Lu6+dorttsLbYLZc7dsLisnKlsNNKs0m1xJlSi5AZ2obFxH57gACBgYTcnWxD7QwksUSqiaTjebzOCLEGfhnUo0VUpZzrllpXFDvopUIAxWmbqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=llfYHfHEbxFD68It590ZD8oDl1dt0UyloAr1QXr83oA=;
 b=lba3XOloskEi3cs3Do3svwDl+TjzPdOyCEZRX6cbFZ0Fczd5Gf7dCutg0n+Qd0cEJ/Lk/LS16FIFmfL1tYije/WQH7O3Gy9c66FrvEyGic5exdvd34vAGXzORps2Qhu1lnWnaehVLfZml6gBOnVUBqQBY1H3cE66G/ENDX1w38um+C5Zz2OeO++Y2hObf64Ss3VHirIBilO6jzMJAS7BDPJ7B0XrZNA6f2SWjWfXTWfpNtXu7TAvS7nSTGZemhzuC8SCSUs/P1cfecsyZUbp17IPxc4a3V0CjMtCnFYvP7OvM0nGYVfakkXktAAGPASRM5yqnnl0GctVQCTPbg6OOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=llfYHfHEbxFD68It590ZD8oDl1dt0UyloAr1QXr83oA=;
 b=sjL3qZ3yPUxzltLJxJDPFDbb3bAkdufIfO71vGbxnVyIBo0/Q45o5uDhjltyf9THRNAREMB96f9RvQw8vfu3NUy1Tz7PooTuXpizIOOW3zVPjJtpffJrxukS/fF3dU8KLxUgLFq33S6YZKNiqFBi4dGJp+gW9ZWbSPRnr3R7sks=
Received: from DM5PR07CA0145.namprd07.prod.outlook.com (2603:10b6:3:ee::11) by
 DM6PR12MB4283.namprd12.prod.outlook.com (2603:10b6:5:211::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.23; Mon, 31 Aug 2020 15:51:03 +0000
Received: from DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ee:cafe::37) by DM5PR07CA0145.outlook.office365.com
 (2603:10b6:3:ee::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend
 Transport; Mon, 31 Aug 2020 15:51:03 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT062.mail.protection.outlook.com (10.13.173.40) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3326.19 via Frontend Transport; Mon, 31 Aug 2020 15:51:03 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Mon, 31 Aug
 2020 10:51:01 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Mon, 31 Aug
 2020 10:51:01 -0500
Received: from agrodzovsky-All-Series.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Mon, 31 Aug 2020 10:51:00 -0500
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 5/8] drm/amdgpu: Fix consecutive DPC recovery failures.
Date: Mon, 31 Aug 2020 11:50:46 -0400
Message-ID: <1598889049-28321-6-git-send-email-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1598889049-28321-1-git-send-email-andrey.grodzovsky@amd.com>
References: <1598889049-28321-1-git-send-email-andrey.grodzovsky@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4164524e-b50a-4761-8f64-08d84dc5aa7a
X-MS-TrafficTypeDiagnostic: DM6PR12MB4283:
X-Microsoft-Antispam-PRVS: <DM6PR12MB428358F90DDF1BFB5888CC6CEA510@DM6PR12MB4283.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SHkDxDtEcObzBrqgqY5hmjcyMDiPA2Fz0piShw42ScLdWaXWiA6b8agLoE3XIphw8at7etM/TRd0rT7KJRkJhUyrvgdAcCiqo17OlnFmogV0lxDR259IhuEAznjPfZC1h27yUh5DWyWAEOZC8qfs46Uiu/+sugKkeRg8OLQiQzLDuZd39gRgigz9aR//lpmQ8yI9L9TIiy2a2jWOYlnIDG2NuHxQIhbfUiriB7+I8p83d3NqPAnmPAVDOwq9lZz7B3AyuTbyKFvixm/uqK6LsSrKGCKPouF7m727b3EE00O8o3hTGUR1LtbLsKSj5rITLgd5XJ9BlALqss3wp8925cUL4Fvlf6FEzTISxNaewE0VlTti8pobiyQxiiWRA3r6VCPA0q+8J0bJqUiAuEOuow==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(136003)(39860400002)(376002)(346002)(46966005)(44832011)(6666004)(8676002)(8936002)(478600001)(54906003)(36756003)(86362001)(7696005)(426003)(83380400001)(70586007)(81166007)(6916009)(70206006)(186003)(82310400002)(47076004)(82740400003)(2906002)(356005)(26005)(2616005)(316002)(336012)(4326008)(5660300002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2020 15:51:03.6050 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4164524e-b50a-4761-8f64-08d84dc5aa7a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4283
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
 nirmodas@amd.com, christian.koenig@amd.com, Dennis.Li@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Cache the PCI state on boot and before each case were we might
loose it.

v2: Add pci_restore_state while caching the PCI state to avoid
breaking PCI core logic for stuff like suspend/resume.

v3: Extract pci_restore_state from amdgpu_device_cache_pci_state
to avoid superflous restores during GPU resets and suspend/resumes.

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  6 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 62 ++++++++++++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  4 +-
 drivers/gpu/drm/amd/amdgpu/nv.c            |  4 +-
 drivers/gpu/drm/amd/amdgpu/soc15.c         |  4 +-
 5 files changed, 71 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index cac51e8..5e74db6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -992,7 +992,9 @@ struct amdgpu_device {
 	atomic_t			throttling_logging_enabled;
 	struct ratelimit_state		throttling_logging_rs;
 	uint32_t			ras_features;
+
 	bool                            in_pci_err_recovery;
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
index 4a009ca..0329b43 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1282,7 +1282,7 @@ static void amdgpu_switcheroo_set_state(struct pci_dev *pdev,
 		dev->switch_power_state = DRM_SWITCH_POWER_CHANGING;
 
 		pci_set_power_state(dev->pdev, PCI_D0);
-		pci_restore_state(dev->pdev);
+		amdgpu_device_load_pci_state(dev->pdev);
 		r = pci_enable_device(dev->pdev);
 		if (r)
 			DRM_WARN("pci_enable_device failed (%d)\n", r);
@@ -1295,7 +1295,7 @@ static void amdgpu_switcheroo_set_state(struct pci_dev *pdev,
 		drm_kms_helper_poll_disable(dev);
 		dev->switch_power_state = DRM_SWITCH_POWER_CHANGING;
 		amdgpu_device_suspend(dev, true);
-		pci_save_state(dev->pdev);
+		amdgpu_device_cache_pci_state(dev->pdev);
 		/* Shut down the device */
 		pci_disable_device(dev->pdev);
 		pci_set_power_state(dev->pdev, PCI_D3cold);
@@ -3400,6 +3400,10 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	if (r)
 		dev_err(adev->dev, "amdgpu_pmu_init failed\n");
 
+	/* Have stored pci confspace at hand for restore in sudden PCI error */
+	if (amdgpu_device_cache_pci_state(adev->pdev))
+		pci_restore_state(pdev);
+
 	return 0;
 
 failed:
@@ -3426,6 +3430,8 @@ void amdgpu_device_fini(struct amdgpu_device *adev)
 	flush_delayed_work(&adev->delayed_init_work);
 	adev->shutdown = true;
 
+	kfree(adev->pci_state);
+
 	/* make sure IB test finished before entering exclusive mode
 	 * to avoid preemption on IB test
 	 * */
@@ -4850,7 +4856,7 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
 	/* wait for asic to come out of reset */
 	msleep(500);
 
-	pci_restore_state(pdev);
+	amdgpu_device_load_pci_state(pdev);
 
 	/* confirm  ASIC came out of reset */
 	for (i = 0; i < adev->usec_timeout; i++) {
@@ -4930,6 +4936,9 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
 out:
 
 	if (!r) {
+		if (amdgpu_device_cache_pci_state(adev->pdev))
+			pci_restore_state(adev->pdev);
+
 		DRM_INFO("PCIe error recovery succeeded\n");
 	} else {
 		DRM_ERROR("PCIe error recovery failed, err:%d", r);
@@ -4969,3 +4978,50 @@ void amdgpu_pci_resume(struct pci_dev *pdev)
 
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
+
+	return true;
+}
+
+
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
