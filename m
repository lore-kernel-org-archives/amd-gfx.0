Return-Path: <SRS0=kQKQ=CG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA5F3C433E6
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2020 16:06:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A12E7207DF
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2020 16:06:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="E/K8Z4Rh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A12E7207DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 513A86E4FB;
	Fri, 28 Aug 2020 16:06:10 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2046.outbound.protection.outlook.com [40.107.236.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E35586E4FB
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2020 16:06:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IkiFHCIrPvvA00lC6HvCY7i/KHlOXwAf98Ues3v9LbMMcTYeQd1OIebjndP65wkEaPxebpK62xIxt3cFdj3o1bpJcUs5zXjjyKYQouKIkzACA8jccvoNE93oC/0xEpSO0Hu6oN6RiqacL408RjZWoTW9vgsqEXPLj5qrqN2AlelTqsEjO3ny8HhIftTbbGm5ewPcCBIHjUew3IQnVf0HS9BP/XNpLZXHEok0CyJre7Vt7vOdad9UaHnprRrfViNL5U7pqyfyJGh1zzjHSw22JBC2K5jua7Q1jzojGGjqXgKRVO8Xx9bu6dwQYtEyXVRvnMejtStjqVFKtuyZYVk5ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q3+WQrR727TtCRL7A6eLBieOSpEf8pTmhS8YO2eic24=;
 b=TXw3f18Hyu+lAPSAYcqQ+UWMVbsEYp2yf/3/CDC0rSJxKUJw6uHeV7HIt22JtMvYca5Fk4qfP9P1d0iSusD475j4oBP3x/sQkDNc35JrP2yxOLnPf/SszP18M2rbNp/MiOTG2RgHZikzVs0DuWtPmieZJbZwZDqGN7thinRVx8yl8WvE6Sax/C1BIel0SZSdmI5iQQZ3gCDcxDjilfNisoNeZcN1YvYjukD+ZcbY8OGATTNTYhKSKRapXru7MGyBtuYELKDTpPE0uTm/dl1sHqp3r3WGD2RwdBc0U8OU7ztYxswSU+mAPSBB5LaRRZwR37MxOkaM57/UQVmTtD1c6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q3+WQrR727TtCRL7A6eLBieOSpEf8pTmhS8YO2eic24=;
 b=E/K8Z4RhO6l6OBa0Y5veIfJEU6NOppVaTvaK65dK5n1il/sir8Tw83n55vnrnmZgwLJZCFqsVPjPgnhFGr5Bv4a4nGFZ7g8w+b60l6sGC86rFLbdZvd2fHyoX6lJ2Hbw9CDLntjNjO9sHw8VO7I5qxe+MA7vyEi8szB4sxep498=
Received: from MWHPR18CA0039.namprd18.prod.outlook.com (2603:10b6:320:31::25)
 by BN6PR1201MB2481.namprd12.prod.outlook.com (2603:10b6:404:a7::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.21; Fri, 28 Aug
 2020 16:06:02 +0000
Received: from CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:320:31:cafe::f9) by MWHPR18CA0039.outlook.office365.com
 (2603:10b6:320:31::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend
 Transport; Fri, 28 Aug 2020 16:06:02 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT016.mail.protection.outlook.com (10.13.175.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3326.19 via Frontend Transport; Fri, 28 Aug 2020 16:06:02 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 28 Aug
 2020 11:05:58 -0500
Received: from agrodzovsky-All-Series.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Fri, 28 Aug 2020 11:05:57 -0500
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 5/7] drm/amdgpu: Fix consecutive DPC recovery failures.
Date: Fri, 28 Aug 2020 12:05:41 -0400
Message-ID: <1598630743-21155-6-git-send-email-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1598630743-21155-1-git-send-email-andrey.grodzovsky@amd.com>
References: <1598630743-21155-1-git-send-email-andrey.grodzovsky@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c38f865-1d1c-491c-890d-08d84b6c430e
X-MS-TrafficTypeDiagnostic: BN6PR1201MB2481:
X-Microsoft-Antispam-PRVS: <BN6PR1201MB2481100A56DD85583B54121AEA520@BN6PR1201MB2481.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zNwrsf+CTMTBeMWkBccwl9EPWu6x6OMunQU8dopupEwiw+C+to/FQ70SqneYUjjpQeYSa/P1/Q3aBxXmAKMft4r74q6oxv8Skw7QT21M562F3cM5gC9AcQjxKyjQKvJC+2A3l6pQRSClpo/f27lECOlelUfe7gCp9w3vo72MiHlalMIGFfEHvqoXh3m+84gl8jf37hMZbawc9B7M4+/9pCpf0dd6ufBDE2ZKQiKSUQ6/lJpEbIuWm7RSc47kGrONsMR9ygTPdE+QOhZnhiRnrA4o3ZVMVRawvGQm38XDVtg39EPNAN88RHCk9BHIjfDQw4DVRT2pobNVi6DYspm0+0DESaRZ9VEPDT88u0wsD5ELRN8vfwXSrwDqxoN/R5V8KyNe7NAaJ5XCBuqrSPxfpw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(396003)(376002)(39860400002)(346002)(46966005)(6666004)(70206006)(186003)(7696005)(70586007)(26005)(82740400003)(4326008)(86362001)(47076004)(81166007)(6916009)(44832011)(83380400001)(2906002)(336012)(2616005)(426003)(8676002)(82310400002)(356005)(316002)(36756003)(5660300002)(478600001)(54906003)(8936002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2020 16:06:02.4933 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c38f865-1d1c-491c-890d-08d84b6c430e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB2481
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

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  6 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 59 ++++++++++++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  4 +-
 drivers/gpu/drm/amd/amdgpu/nv.c            |  4 +-
 drivers/gpu/drm/amd/amdgpu/soc15.c         |  4 +-
 5 files changed, 67 insertions(+), 10 deletions(-)

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
index 06664a9..7f1b970 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1284,7 +1284,7 @@ static void amdgpu_switcheroo_set_state(struct pci_dev *pdev,
 		dev->switch_power_state = DRM_SWITCH_POWER_CHANGING;
 
 		pci_set_power_state(dev->pdev, PCI_D0);
-		pci_restore_state(dev->pdev);
+		amdgpu_device_load_pci_state(dev->pdev);
 		r = pci_enable_device(dev->pdev);
 		if (r)
 			DRM_WARN("pci_enable_device failed (%d)\n", r);
@@ -1297,7 +1297,7 @@ static void amdgpu_switcheroo_set_state(struct pci_dev *pdev,
 		drm_kms_helper_poll_disable(dev);
 		dev->switch_power_state = DRM_SWITCH_POWER_CHANGING;
 		amdgpu_device_suspend(dev, true);
-		pci_save_state(dev->pdev);
+		amdgpu_device_cache_pci_state(dev->pdev);
 		/* Shut down the device */
 		pci_disable_device(dev->pdev);
 		pci_set_power_state(dev->pdev, PCI_D3cold);
@@ -3402,6 +3402,9 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	if (r)
 		dev_err(adev->dev, "amdgpu_pmu_init failed\n");
 
+	/* Have stored pci confspace at hand for restore in sudden PCI error */
+	if (!amdgpu_device_cache_pci_state(adev->pdev))
+		DRM_WARN("Failed to cache PCI state!");
 	return 0;
 
 failed:
@@ -3428,6 +3431,8 @@ void amdgpu_device_fini(struct amdgpu_device *adev)
 	flush_delayed_work(&adev->delayed_init_work);
 	adev->shutdown = true;
 
+	kfree(adev->pci_state);
+
 	/* make sure IB test finished before entering exclusive mode
 	 * to avoid preemption on IB test
 	 * */
@@ -4853,7 +4858,7 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
 	/* wait for asic to come out of reset */
 	msleep(500);
 
-	pci_restore_state(pdev);
+	amdgpu_device_load_pci_state(pdev);
 
 	/* confirm  ASIC came out of reset */
 	for (i = 0; i < adev->usec_timeout; i++) {
@@ -4932,8 +4937,10 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
 
 out:
 
-	if (!r)
+	if (!r) {
+		amdgpu_device_cache_pci_state(adev->pdev);
 		DRM_INFO("PCIe error recovery succeeded\n");
+	}
 	else {
 		DRM_ERROR("PCIe error recovery failed, err:%d", r);
 		amdgpu_device_unlock_adev(adev);
@@ -4972,3 +4979,47 @@ void amdgpu_pci_resume(struct pci_dev *pdev)
 
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
+		pci_restore_state(pdev);
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
