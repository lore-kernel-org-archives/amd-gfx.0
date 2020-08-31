Return-Path: <SRS0=7vr2=CJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A21C433E6
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2020 15:51:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10F0220719
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2020 15:51:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="0PTuMEW0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10F0220719
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4E6989B01;
	Mon, 31 Aug 2020 15:51:14 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D054489B01
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2020 15:51:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jvwnvoFUAJcu0JO14nHvCCCLily5dqp5qMkTp+xShJzWBIsu/uSLV9hJMcYYm5UoTJvbkFoJsoBn5knL2kPheEkDDQ0xEsu2Wgg6zEwkwGGdU3MiSvfpkniAnQM3tTJ1yFZYUFAGn7hhAFxs/G+Sco/mhcPu5mNTTdYDxXNF8Yn2xnn+gFjxzlAL8ccca1NRVUaXop+YF2WZyi52nurQMb/sH574Mh3JzKAnfzP0Jt1zmMTEon8mJRuRCz+hNr1Wl6TmQb9BWdwDUIc6fnRJlwIn/pMrRbsuSFu8T2phovzPBJY13fHdGg1FuZ59uEIxEnrHaLrEcwwkthq5y3nqPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZpRmSTFwPBKedGqFN4HBoVcFdGvA+W7kU67afMZzybo=;
 b=io58wzroxOQCbyRjpMp1gBKmmwvMPoTw7E6UinwKSs01hQdGThm9j/lau8tbQI/UK/4Qq9P2JlMtkM4RNOC39U2IzjZHiz6y52qLMvEFyVun6wfkpCBzG8B5p/pSGovAalB9GWjHxrZiwEiiCfii82khFtz5BW40ROMoK/57AclF5jpOGTkMh5wN5kQ+K48N8CjIzCRkxo14nxcRH06Lod5i3wmAZSq5hYo3G3KmieVxu52Wbx4shbls9vZB2urQqpy06OE+/4V00eAOH6AImpJcRM+sGHptzFcEMnYz3DOtqDr4NRnIAsOEEkM/HZMStUzdtr94HlsGdkruE+Le/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZpRmSTFwPBKedGqFN4HBoVcFdGvA+W7kU67afMZzybo=;
 b=0PTuMEW0g5IZPxFFS2LNglSAuvf1O6c2eJTX+0PzObSqGWzWtyZjFDuuRxvDeVsbYKFelkeMzwdheZ0KzhJnKATddTL/GYJNFvQ0R1U7pLNChzoQcJUsAjegLV76KK8upK792vqmtXnyRshi9f0rKRbQs7ZRI/R8Ar0Dpy3B6UU=
Received: from DM5PR07CA0149.namprd07.prod.outlook.com (2603:10b6:3:ee::15) by
 BN8PR12MB3092.namprd12.prod.outlook.com (2603:10b6:408:48::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.25; Mon, 31 Aug 2020 15:50:57 +0000
Received: from DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ee:cafe::11) by DM5PR07CA0149.outlook.office365.com
 (2603:10b6:3:ee::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend
 Transport; Mon, 31 Aug 2020 15:50:57 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT062.mail.protection.outlook.com (10.13.173.40) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3326.19 via Frontend Transport; Mon, 31 Aug 2020 15:50:57 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Mon, 31 Aug
 2020 10:50:57 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Mon, 31 Aug
 2020 10:50:56 -0500
Received: from agrodzovsky-All-Series.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Mon, 31 Aug 2020 10:50:56 -0500
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 1/8] drm/amdgpu: Implement DPC recovery
Date: Mon, 31 Aug 2020 11:50:42 -0400
Message-ID: <1598889049-28321-2-git-send-email-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1598889049-28321-1-git-send-email-andrey.grodzovsky@amd.com>
References: <1598889049-28321-1-git-send-email-andrey.grodzovsky@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 752a7dee-d49d-45db-5827-08d84dc5a6e4
X-MS-TrafficTypeDiagnostic: BN8PR12MB3092:
X-Microsoft-Antispam-PRVS: <BN8PR12MB30921AB413A812B8111EDDD0EA510@BN8PR12MB3092.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lYWGZb1oUKEuPBWh3T7S8GDUevYb5iLqHiTNN9fds8TdDDz8DYABsXoC8Zbf7Zdplj9RqlWad+mnOLgYErgZ8D/sJh1xnTM6JVWDUxuZTtlrLaD1BRSPwuRpVYkBJUgHNOILmEFE+XlNrrjQYBNihWtThxyCMWJwHc76+qglfWKV8fnywTOSxtj+v3zkpmJa1jnlfcgjpCvy4U7RPor7Y8uDTOBSVrkQYdVD0tqZVhwnj4NuxeY6NNfOZLN+Hd9z6rf2blIYmr4SP3g9B++tyyGxv1QcKf3HhJFkzzkz3/q1nO0THJXbxgsM7Bgq88GTxOq23Kbhu1IZs6/SZMasoJpgj0fj79ODURGUnf0uIoi9aFzBXmGqzNmI4U0lp/hLm22iW3oULGr7EYWmru3e0Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(396003)(136003)(46966005)(8936002)(83380400001)(82740400003)(82310400002)(8676002)(6916009)(5660300002)(6666004)(316002)(186003)(70586007)(7696005)(54906003)(356005)(47076004)(2906002)(478600001)(336012)(2616005)(81166007)(36756003)(86362001)(426003)(4326008)(70206006)(44832011)(26005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2020 15:50:57.5894 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 752a7dee-d49d-45db-5827-08d84dc5a6e4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3092
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

Add DPC handlers with basic recovery functionality.

v2: remove pci_save_state to avoid breaking suspend/resume
v3: Fix style comments

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |   9 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 162 +++++++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |   9 +-
 3 files changed, 179 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 49ea9fa..3399242 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -49,6 +49,8 @@
 #include <linux/rbtree.h>
 #include <linux/hashtable.h>
 #include <linux/dma-fence.h>
+#include <linux/pci.h>
+#include <linux/aer.h>
 
 #include <drm/ttm/ttm_bo_api.h>
 #include <drm/ttm/ttm_bo_driver.h>
@@ -1263,6 +1265,13 @@ static inline int amdgpu_dm_display_resume(struct amdgpu_device *adev) { return
 void amdgpu_register_gpu_instance(struct amdgpu_device *adev);
 void amdgpu_unregister_gpu_instance(struct amdgpu_device *adev);
 
+pci_ers_result_t amdgpu_pci_error_detected(struct pci_dev *pdev,
+					   pci_channel_state_t state);
+pci_ers_result_t amdgpu_pci_mmio_enabled(struct pci_dev *pdev);
+pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev);
+void amdgpu_pci_resume(struct pci_dev *pdev);
+
+
 #include "amdgpu_object.h"
 
 /* used by df_v3_6.c and amdgpu_pmu.c */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 5a948ed..67d61a5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2989,6 +2989,7 @@ static const struct attribute *amdgpu_dev_attributes[] = {
 	NULL
 };
 
+
 /**
  * amdgpu_device_init - initialize the driver
  *
@@ -3207,6 +3208,9 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 		}
 	}
 
+	pci_enable_pcie_error_reporting(adev->ddev.pdev);
+
+
 	/* Post card if necessary */
 	if (amdgpu_device_need_post(adev)) {
 		if (!adev->bios) {
@@ -4701,3 +4705,161 @@ int amdgpu_device_baco_exit(struct drm_device *dev)
 
 	return 0;
 }
+
+/**
+ * amdgpu_pci_error_detected - Called when a PCI error is detected.
+ * @pdev: PCI device struct
+ * @state: PCI channel state
+ *
+ * Description: Called when a PCI error is detected.
+ *
+ * Return: PCI_ERS_RESULT_NEED_RESET or PCI_ERS_RESULT_DISCONNECT.
+ */
+pci_ers_result_t amdgpu_pci_error_detected(struct pci_dev *pdev, pci_channel_state_t state)
+{
+	struct drm_device *dev = pci_get_drvdata(pdev);
+	struct amdgpu_device *adev = drm_to_adev(dev);
+
+	DRM_INFO("PCI error: detected callback, state(%d)!!\n", state);
+
+	switch (state) {
+	case pci_channel_io_normal:
+		return PCI_ERS_RESULT_CAN_RECOVER;
+	case pci_channel_io_frozen:
+		/* Fatal error, prepare for slot reset */
+		amdgpu_device_lock_adev(adev);
+		return PCI_ERS_RESULT_NEED_RESET;
+	case pci_channel_io_perm_failure:
+		/* Permanent error, prepare for device removal */
+		return PCI_ERS_RESULT_DISCONNECT;
+	}
+
+	return PCI_ERS_RESULT_NEED_RESET;
+}
+
+/**
+ * amdgpu_pci_mmio_enabled - Enable MMIO and dump debug registers
+ * @pdev: pointer to PCI device
+ */
+pci_ers_result_t amdgpu_pci_mmio_enabled(struct pci_dev *pdev)
+{
+
+	DRM_INFO("PCI error: mmio enabled callback!!\n");
+
+	/* TODO - dump whatever for debugging purposes */
+
+	/* This called only if amdgpu_pci_error_detected returns
+	 * PCI_ERS_RESULT_CAN_RECOVER. Read/write to the device still
+	 * works, no need to reset slot.
+	 */
+
+	return PCI_ERS_RESULT_RECOVERED;
+}
+
+/**
+ * amdgpu_pci_slot_reset - Called when PCI slot has been reset.
+ * @pdev: PCI device struct
+ *
+ * Description: This routine is called by the pci error recovery
+ * code after the PCI slot has been reset, just before we
+ * should resume normal operations.
+ */
+pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
+{
+	struct drm_device *dev = pci_get_drvdata(pdev);
+	struct amdgpu_device *adev = drm_to_adev(dev);
+	int r;
+	bool vram_lost;
+
+	DRM_INFO("PCI error: slot reset callback!!\n");
+
+	pci_restore_state(pdev);
+
+	r = amdgpu_device_ip_suspend(adev);
+	if (r)
+		goto out;
+
+
+	/* post card */
+	r = amdgpu_atom_asic_init(adev->mode_info.atom_context);
+	if (r)
+		goto out;
+
+	r = amdgpu_device_ip_resume_phase1(adev);
+	if (r)
+		goto out;
+
+	vram_lost = amdgpu_device_check_vram_lost(adev);
+	if (vram_lost) {
+		DRM_INFO("VRAM is lost due to GPU reset!\n");
+		amdgpu_inc_vram_lost(adev);
+	}
+
+	r = amdgpu_gtt_mgr_recover(
+		&adev->mman.bdev.man[TTM_PL_TT]);
+	if (r)
+		goto out;
+
+	r = amdgpu_device_fw_loading(adev);
+	if (r)
+		return r;
+
+	r = amdgpu_device_ip_resume_phase2(adev);
+	if (r)
+		goto out;
+
+	if (vram_lost)
+		amdgpu_device_fill_reset_magic(adev);
+
+	/*
+	 * Add this ASIC as tracked as reset was already
+	 * complete successfully.
+	 */
+	amdgpu_register_gpu_instance(adev);
+
+	r = amdgpu_device_ip_late_init(adev);
+	if (r)
+		goto out;
+
+	amdgpu_fbdev_set_suspend(adev, 0);
+
+	/* must succeed. */
+	amdgpu_ras_resume(adev);
+
+
+	amdgpu_irq_gpu_reset_resume_helper(adev);
+	r = amdgpu_ib_ring_tests(adev);
+	if (r)
+		goto out;
+
+	r = amdgpu_device_recover_vram(adev);
+
+out:
+
+	if (!r) {
+		DRM_INFO("PCIe error recovery succeeded\n");
+	} else {
+		DRM_ERROR("PCIe error recovery failed, err:%d", r);
+		amdgpu_device_unlock_adev(adev);
+	}
+
+	return r ? PCI_ERS_RESULT_DISCONNECT : PCI_ERS_RESULT_RECOVERED;
+}
+
+/**
+ * amdgpu_pci_resume() - resume normal ops after PCI reset
+ * @pdev: pointer to PCI device
+ *
+ * Called when the error recovery driver tells us that its
+ * OK to resume normal operation. Use completion to allow
+ * halted scsi ops to resume.
+ */
+void amdgpu_pci_resume(struct pci_dev *pdev)
+{
+	struct drm_device *dev = pci_get_drvdata(pdev);
+	struct amdgpu_device *adev = drm_to_adev(dev);
+
+	amdgpu_device_unlock_adev(adev);
+
+	DRM_INFO("PCI error: resume callback!!\n");
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index d984c6a..4bbcc70 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -31,7 +31,6 @@
 #include <drm/drm_pciids.h>
 #include <linux/console.h>
 #include <linux/module.h>
-#include <linux/pci.h>
 #include <linux/pm_runtime.h>
 #include <linux/vga_switcheroo.h>
 #include <drm/drm_probe_helper.h>
@@ -1534,6 +1533,13 @@ static struct drm_driver kms_driver = {
 	.patchlevel = KMS_DRIVER_PATCHLEVEL,
 };
 
+static struct pci_error_handlers amdgpu_pci_err_handler = {
+	.error_detected	= amdgpu_pci_error_detected,
+	.mmio_enabled	= amdgpu_pci_mmio_enabled,
+	.slot_reset	= amdgpu_pci_slot_reset,
+	.resume		= amdgpu_pci_resume,
+};
+
 static struct pci_driver amdgpu_kms_pci_driver = {
 	.name = DRIVER_NAME,
 	.id_table = pciidlist,
@@ -1541,6 +1547,7 @@ static struct pci_driver amdgpu_kms_pci_driver = {
 	.remove = amdgpu_pci_remove,
 	.shutdown = amdgpu_pci_shutdown,
 	.driver.pm = &amdgpu_pm_ops,
+	.err_handler = &amdgpu_pci_err_handler,
 };
 
 static int __init amdgpu_init(void)
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
