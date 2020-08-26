Return-Path: <SRS0=g3tc=CE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87BA8C433E1
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2020 14:46:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5854F2078D
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2020 14:46:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="3MOZx8AI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5854F2078D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F6B56EA94;
	Wed, 26 Aug 2020 14:46:49 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 144176EA9C
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2020 14:46:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fBTZ8oRQqKbIVYcpWeqLyfAGXnsAH/ngBRyocekp0nemlpHmezPsCRV3Sz6TwJnz9UrVVYXfxgMK0SCMKZZXGBaevQ1m5VPWIWwz2hoqvHkdGNAdoh5V+uyA4ztg0Em/P3AcwYGxbHnK7Ato4uF1qrsDkgfVyIHV35MijUXgtnAPKDJjyDtkML8OZEhjt5EVxC2JZZcjaV5ENoJPA2tRVJdoIsrVeMi2lgY6ASuGcbgY1mucxwrQKkTKxwlT2C6d03uXygxdkXDSRXx4djujED5ZJ82K1FDvPVTAv5xYiwuPPIxMbBZAciWfUzsdfVXPfw3ufnsvh5EaC4oOtODktQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oxBF6JcA/hgyxgrbIdlAfG18qiCoFUk86rRlNm5LjVg=;
 b=OhOAmdl26JRN3gZuGnsdum7C2tpqyg19ZreEJaWc0ROKbmmaX0IU55Tb4hh2BbLKbMJJ0hKoIVw2Nd3MnE9xWq278PvmLFwjQJp1FnuC4KLXUdBnOmE8e2w5BIwsZIT18GiT0IgCmdG3Q3AoC/+GNz0uaoCmZwCf5yH90ZelVIXlnIkk13T9pS6NQotsjwhj9FiTMMuB4mfry03DiR7kkIgIAP5we396lIjiTrDLKZkzOUuzGjxBWHxHXmonHywotZAy+9DaXYoFdBo/VYQm3vHaloxp5eh+sh8cQU2+F5P5lin0SUsu37A9lGNHlhCq9eYK5XHbulz50Q0fuUO5YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oxBF6JcA/hgyxgrbIdlAfG18qiCoFUk86rRlNm5LjVg=;
 b=3MOZx8AIkUCeInUO1dgjcBWrqbwgPWyZdOsTr/kP6moUZIOe37TIhMTYSzBly4BA1aFQHujv0IWtRo9dbUg+XIRPdrAYQXgOJx7yfmzRZgMmJ/97E1xcbf9heZOoNNxCka8A2TcUfghWwgT0Grbg8eTyr7/WIwhjL2MZ8OVk3Js=
Received: from CO2PR04CA0085.namprd04.prod.outlook.com (2603:10b6:104:6::11)
 by MWHPR12MB1952.namprd12.prod.outlook.com (2603:10b6:300:114::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Wed, 26 Aug
 2020 14:46:41 +0000
Received: from CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:6:cafe::2f) by CO2PR04CA0085.outlook.office365.com
 (2603:10b6:104:6::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend
 Transport; Wed, 26 Aug 2020 14:46:41 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT063.mail.protection.outlook.com (10.13.175.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3326.19 via Frontend Transport; Wed, 26 Aug 2020 14:46:40 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 26 Aug
 2020 09:46:32 -0500
Received: from agrodzovsky-All-Series.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Wed, 26 Aug 2020 09:46:32 -0500
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/7] drm/amdgpu: Implement DPC recovery
Date: Wed, 26 Aug 2020 10:46:16 -0400
Message-ID: <1598453182-6946-2-git-send-email-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1598453182-6946-1-git-send-email-andrey.grodzovsky@amd.com>
References: <1598453182-6946-1-git-send-email-andrey.grodzovsky@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 528135ef-d973-436b-af52-08d849ced820
X-MS-TrafficTypeDiagnostic: MWHPR12MB1952:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1952DEFD14CF23938ECB83BCEA540@MWHPR12MB1952.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TU4af5DBxUNwiU9VmqEVZ8kVFWHlium+HcjxeuPSFHWufjdRyxpDqnX+zZEwo+9oiFhbA5Gelmo+MSwdDDZI6MxI7h4qM0vYD9ERpWRcUs12nW21MqXs85cW/QD+fFiWTcm2GJovVxmZvc+E3pfbvu7T10qxb0TvomBXF3IggvfVEQ9E6U6QEbMLXZJht6fRYhGtD2Z7GqYuYW/Zum6jVVGHASSH0Scbbq4EoxpsVzeiDzoUgAIqrg9GAdyBcOLty1tCZKLvCAvMv5VmHYKj8Qt9QPJTH8qK5j9YJdnUlqP++RXoa5ZgSZEHLXrfdet/d5MmoNo3Tn+m8UmJVC5NgjbSujCxjzXLk1y2DNrFFneWHguNLtylciWB1BmcUwIgUcELUkDRikx51JXw9kgsCQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(136003)(346002)(396003)(39860400002)(46966005)(8676002)(336012)(356005)(5660300002)(6916009)(70206006)(8936002)(70586007)(478600001)(6666004)(36756003)(82740400003)(54906003)(426003)(316002)(7696005)(47076004)(83380400001)(26005)(81166007)(44832011)(86362001)(2616005)(186003)(82310400002)(4326008)(2906002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2020 14:46:40.9407 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 528135ef-d973-436b-af52-08d849ced820
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1952
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

Add DPC handlers with basic recovery functionality.

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |   9 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 181 ++++++++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |   9 +-
 3 files changed, 196 insertions(+), 3 deletions(-)

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
index 5a948ed..84f8d14 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -350,7 +350,9 @@ uint32_t amdgpu_mm_rreg(struct amdgpu_device *adev, uint32_t reg,
  *
  * Returns the 8 bit value from the offset specified.
  */
-uint8_t amdgpu_mm_rreg8(struct amdgpu_device *adev, uint32_t offset) {
+uint8_t amdgpu_mm_rreg8(struct amdgpu_device *adev, uint32_t offset)
+{
+
 	if (offset < adev->rmmio_size)
 		return (readb(adev->rmmio + offset));
 	BUG();
@@ -371,7 +373,9 @@ uint8_t amdgpu_mm_rreg8(struct amdgpu_device *adev, uint32_t offset) {
  *
  * Writes the value specified to the offset specified.
  */
-void amdgpu_mm_wreg8(struct amdgpu_device *adev, uint32_t offset, uint8_t value) {
+void amdgpu_mm_wreg8(struct amdgpu_device *adev, uint32_t offset, uint8_t value)
+{
+
 	if (offset < adev->rmmio_size)
 		writeb(value, adev->rmmio + offset);
 	else
@@ -380,6 +384,7 @@ void amdgpu_mm_wreg8(struct amdgpu_device *adev, uint32_t offset, uint8_t value)
 
 void static inline amdgpu_mm_wreg_mmio(struct amdgpu_device *adev, uint32_t reg, uint32_t v, uint32_t acc_flags)
 {
+
 	trace_amdgpu_mm_wreg(adev->pdev->device, reg, v);
 
 	if ((reg * 4) < adev->rmmio_size)
@@ -407,6 +412,7 @@ void static inline amdgpu_mm_wreg_mmio(struct amdgpu_device *adev, uint32_t reg,
 void amdgpu_mm_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v,
 		    uint32_t acc_flags)
 {
+
 	if (!(acc_flags & AMDGPU_REGS_NO_KIQ) && amdgpu_sriov_runtime(adev))
 		return amdgpu_kiq_wreg(adev, reg, v);
 
@@ -461,6 +467,7 @@ u32 amdgpu_io_rreg(struct amdgpu_device *adev, u32 reg)
  */
 void amdgpu_io_wreg(struct amdgpu_device *adev, u32 reg, u32 v)
 {
+
 	if ((reg * 4) < adev->rio_mem_size)
 		iowrite32(v, adev->rio_mem + (reg * 4));
 	else {
@@ -480,6 +487,7 @@ void amdgpu_io_wreg(struct amdgpu_device *adev, u32 reg, u32 v)
  */
 u32 amdgpu_mm_rdoorbell(struct amdgpu_device *adev, u32 index)
 {
+
 	if (index < adev->doorbell.num_doorbells) {
 		return readl(adev->doorbell.ptr + index);
 	} else {
@@ -500,6 +508,7 @@ u32 amdgpu_mm_rdoorbell(struct amdgpu_device *adev, u32 index)
  */
 void amdgpu_mm_wdoorbell(struct amdgpu_device *adev, u32 index, u32 v)
 {
+
 	if (index < adev->doorbell.num_doorbells) {
 		writel(v, adev->doorbell.ptr + index);
 	} else {
@@ -518,6 +527,7 @@ void amdgpu_mm_wdoorbell(struct amdgpu_device *adev, u32 index, u32 v)
  */
 u64 amdgpu_mm_rdoorbell64(struct amdgpu_device *adev, u32 index)
 {
+
 	if (index < adev->doorbell.num_doorbells) {
 		return atomic64_read((atomic64_t *)(adev->doorbell.ptr + index));
 	} else {
@@ -538,6 +548,7 @@ u64 amdgpu_mm_rdoorbell64(struct amdgpu_device *adev, u32 index)
  */
 void amdgpu_mm_wdoorbell64(struct amdgpu_device *adev, u32 index, u64 v)
 {
+
 	if (index < adev->doorbell.num_doorbells) {
 		atomic64_set((atomic64_t *)(adev->doorbell.ptr + index), v);
 	} else {
@@ -2989,6 +3000,7 @@ static const struct attribute *amdgpu_dev_attributes[] = {
 	NULL
 };
 
+
 /**
  * amdgpu_device_init - initialize the driver
  *
@@ -3207,6 +3219,9 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 		}
 	}
 
+	pci_enable_pcie_error_reporting(adev->ddev.pdev);
+
+
 	/* Post card if necessary */
 	if (amdgpu_device_need_post(adev)) {
 		if (!adev->bios) {
@@ -3359,6 +3374,9 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	if (r)
 		dev_err(adev->dev, "amdgpu_pmu_init failed\n");
 
+	if (pci_save_state(pdev))
+		DRM_ERROR("Failed to save PCI state!!\n");
+
 	return 0;
 
 failed:
@@ -4701,3 +4719,162 @@ int amdgpu_device_baco_exit(struct drm_device *dev)
 
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
+	case pci_channel_io_frozen: {
+		/* Fatal error, prepare for slot reset */
+
+		amdgpu_device_lock_adev(adev);
+		return PCI_ERS_RESULT_NEED_RESET;
+	}
+	case pci_channel_io_perm_failure:
+		/* Permanent error, prepare for device removal */
+		return PCI_ERS_RESULT_DISCONNECT;
+	}
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
+	if (!r)
+		DRM_INFO("PCIe error recovery succeeded\n");
+	else {
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
