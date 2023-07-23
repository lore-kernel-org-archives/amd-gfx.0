Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 342F0C001DE
	for <amd-gfx@archiver.kernel.org>; Sun, 23 Jul 2023 06:16:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A095410E055;
	Sun, 23 Jul 2023 06:16:29 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 460F110E055
 for <amd-gfx@lists.freedesktop.org>; Sun, 23 Jul 2023 06:16:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dw2+DQ1lL2csWXxa5KM41pu40uXEOVurm1TZ7HjWYfLgPhUhsTA7F3E8Uu97JmIXWeWr0eo3WzA+5gOIHcy8aJOs15rvKTmwItkfI9mM7+R3QgX7gD0AtN2pVY8x5paJbEBDiM6YRuRHaXyDCyKLj4WUUCq+T6v4M0UKe54uBO2ZEpXIe8aFpueHnq63iIrlHkSgHabjUNunGBkRONLX2absey2XhAkJo+ZStiMMQjBk2ajYkP4RkvzOgRnjTwzobqpqzesNQ+LogT+QEMkVfTq4NoxgtG3GlohSsaG8U5XboiH9BilDzkPlCAKUMmKLz895aPwDbs212Z/YbZO1xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fw3PGCyPO8LXf/8O0xZ4oYXWEqWpkXSr1wpI5rm/A7s=;
 b=RKpcyZHb7Naya1mcSrBNr03LQkrZ8rBNX/eY3Z7OaRV3mSf4LI2t5CscmX+PLOFqIvN/QSZ6ghJrJZDxXL96/4TIYbwuubWIkV/2Dm85kAgGjOgdN9pniteVgAwzhCyOIkJexv06vGPtG1oHxV+G4JFUk/xcdE+3vXTIq1cSSA0d3eUk4iGl4hJ3NNQjzEh4DYgpdXZtKajWWHFxMeypHTER00ZBcSXNC8auUy80kgis9o1A4PXQGUqaddHmu5zG5470WFGaAkq6C8o3zMWK9SrbwSv0ajRdoP/oqWhOq8sOX8S9SoMBeYNZWo/2ME3D4fCnvwxmEg6nxX5fZX81cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fw3PGCyPO8LXf/8O0xZ4oYXWEqWpkXSr1wpI5rm/A7s=;
 b=rP0W1SmwCNIYPfh560bw6cm3s/lCHrUBc+mc29/OGK14j54hvW6/Fmkd0kIqd0VcbQXXDBUUQ/5gEtnWzdUONFdCz3BW5WyFkECI7s1VNRKCvrxSwuLbXac0OBh2yoe1OL+jvMGdLlXaQP+ZLFuThe+0Fx65OKF53X+Kr5kMcts=
Received: from MW4PR04CA0095.namprd04.prod.outlook.com (2603:10b6:303:83::10)
 by PH7PR12MB5593.namprd12.prod.outlook.com (2603:10b6:510:133::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28; Sun, 23 Jul
 2023 06:16:21 +0000
Received: from CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::6f) by MW4PR04CA0095.outlook.office365.com
 (2603:10b6:303:83::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31 via Frontend
 Transport; Sun, 23 Jul 2023 06:16:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT063.mail.protection.outlook.com (10.13.175.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.24 via Frontend Transport; Sun, 23 Jul 2023 06:16:20 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sun, 23 Jul
 2023 01:16:05 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Fix ENOSYS means 'invalid syscall nr' in
 amdgpu_device.c
Date: Sun, 23 Jul 2023 11:45:49 +0530
Message-ID: <20230723061549.2017184-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT063:EE_|PH7PR12MB5593:EE_
X-MS-Office365-Filtering-Correlation-Id: 0619ff4b-b97d-47c1-1c72-08db8b44554e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2lnPaTh5Tay7eOwtvHPuL39UZdJixQH24hZ6BVUNwSivo0wTrNHzeR8Z3e6fEw4Sv7QysbmIowswTVgHDZpZkR4LRJEg0pRIPaje4BHnQ6soTlPCjtMJ2GN2vzOc+ZmHoMt2q6s9IbP9TpMeCbQnDn2f+t8ASkPgse84NtjK+W0W02Xva/ykzH6iEyVIhGn9GZAnKMY4R5dtzXvg6PJopGzEVuLEaXwoK6Pf4kPjlFMye+CyW0xe8Zm5FlfvoYRRZBfql4yem5xmn6WjD72tsguR6XKbvWfzk4BmD4RsTTMWk4UL4T/Py5ll/CmErPRuaKgem+l+O83YDGWyc/mxjvbJA8ozK9074CqtMMSJxr9IHJ0Wu8qpnCtFPF4RLucN+PeRoNWB+2uHNfLpxgQhNSt2vGIXhcYx2mAM62+vpmWSw8N6pA4kr9g7sTTp0sSakznE+2qhj9M/j4xbP15L3YT/tFVP8/+CHhYkSKrcqJqucGufYmrwu49YpITFG63R1MzP35AQSqic+n0JXvU8kO+krlCNVyY/+0oySs32qqiZXR3f5q/p9qLvxVJDnVttcw0y/9Mo8SBpLU5WOf9RMgE5fFa3ENEUU1DojLeJyzHPWrfqaQiQOuZXcASJxGcJWNqymEGbOecpcmagIETZre8n7IkyUGuvP/N1T0GXc5IVq9WzjD1NJS40cPy/GbuhY8mPmmg2v1mZ8o1dt2Y2reRyjPmKAWBUhp5NrcDs/bd66+lRoN4+blLrRHrR72x95HiuUGo3zd/g/paA7bDMuA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(346002)(136003)(376002)(82310400008)(451199021)(36840700001)(40470700004)(46966006)(5660300002)(8936002)(2616005)(41300700001)(47076005)(66574015)(426003)(83380400001)(26005)(36860700001)(8676002)(16526019)(1076003)(186003)(336012)(81166007)(356005)(6636002)(4326008)(70586007)(316002)(70206006)(40460700003)(86362001)(7696005)(6666004)(40480700001)(82740400003)(36756003)(110136005)(54906003)(44832011)(2906002)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2023 06:16:20.6714 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0619ff4b-b97d-47c1-1c72-08db8b44554e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5593
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

ENOSYS should be used for nonexistent syscalls only, replace ENOSYS with
EINVAL & other style fixes

WARNING: ENOSYS means 'invalid syscall nr' and nothing else
+       if (r == -ENOSYS)

WARNING: ENOSYS means 'invalid syscall nr' and nothing else
+       if (r == -ENOSYS)

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 60 +++++++++++-----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c  |  4 +-
 2 files changed, 33 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 1c786190a84e..ec166c797b9a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -159,7 +159,7 @@ static ssize_t amdgpu_device_get_pcie_replay_count(struct device *dev,
 	return sysfs_emit(buf, "%llu\n", cnt);
 }
 
-static DEVICE_ATTR(pcie_replay_count, S_IRUGO,
+static DEVICE_ATTR(pcie_replay_count, 0444,
 		amdgpu_device_get_pcie_replay_count, NULL);
 
 static void amdgpu_device_get_pcie_info(struct amdgpu_device *adev);
@@ -183,7 +183,7 @@ static ssize_t amdgpu_device_get_product_name(struct device *dev,
 	return sysfs_emit(buf, "%s\n", adev->product_name);
 }
 
-static DEVICE_ATTR(product_name, S_IRUGO,
+static DEVICE_ATTR(product_name, 0444,
 		amdgpu_device_get_product_name, NULL);
 
 /**
@@ -205,7 +205,7 @@ static ssize_t amdgpu_device_get_product_number(struct device *dev,
 	return sysfs_emit(buf, "%s\n", adev->product_number);
 }
 
-static DEVICE_ATTR(product_number, S_IRUGO,
+static DEVICE_ATTR(product_number, 0444,
 		amdgpu_device_get_product_number, NULL);
 
 /**
@@ -227,7 +227,7 @@ static ssize_t amdgpu_device_get_serial_number(struct device *dev,
 	return sysfs_emit(buf, "%s\n", adev->serial);
 }
 
-static DEVICE_ATTR(serial_number, S_IRUGO,
+static DEVICE_ATTR(serial_number, 0444,
 		amdgpu_device_get_serial_number, NULL);
 
 /**
@@ -481,8 +481,7 @@ uint32_t amdgpu_device_rreg(struct amdgpu_device *adev,
 /*
  * MMIO register read with bytes helper functions
  * @offset:bytes offset from MMIO start
- *
-*/
+ */
 
 /**
  * amdgpu_mm_rreg8 - read a memory mapped IO register
@@ -506,8 +505,8 @@ uint8_t amdgpu_mm_rreg8(struct amdgpu_device *adev, uint32_t offset)
  * MMIO register write with bytes helper functions
  * @offset:bytes offset from MMIO start
  * @value: the value want to be written to the register
- *
-*/
+ */
+
 /**
  * amdgpu_mm_wreg8 - read a memory mapped IO register
  *
@@ -991,7 +990,7 @@ static void amdgpu_device_mem_scratch_fini(struct amdgpu_device *adev)
  * @registers: pointer to the register array
  * @array_size: size of the register array
  *
- * Programs an array or registers with and and or masks.
+ * Programs an array or registers with and or masks.
  * This is a helper for setting golden registers.
  */
 void amdgpu_device_program_register_sequence(struct amdgpu_device *adev,
@@ -1157,7 +1156,7 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
 	int rbar_size = pci_rebar_bytes_to_size(adev->gmc.real_vram_size);
 	struct pci_bus *root;
 	struct resource *res;
-	unsigned i;
+	unsigned int i;
 	u16 cmd;
 	int r;
 
@@ -1226,9 +1225,8 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
 
 static bool amdgpu_device_read_bios(struct amdgpu_device *adev)
 {
-	if (hweight32(adev->aid_mask) && (adev->flags & AMD_IS_APU)) {
+	if (hweight32(adev->aid_mask) && (adev->flags & AMD_IS_APU))
 		return false;
-	}
 
 	return true;
 }
@@ -1264,6 +1262,7 @@ bool amdgpu_device_need_post(struct amdgpu_device *adev)
 		if (adev->asic_type == CHIP_FIJI) {
 			int err;
 			uint32_t fw_ver;
+
 			err = request_firmware(&adev->pm.fw, "amdgpu/fiji_smc.bin", adev->dev);
 			/* force vPost if error occured */
 			if (err)
@@ -1366,6 +1365,7 @@ static unsigned int amdgpu_device_vga_set_decode(struct pci_dev *pdev,
 		bool state)
 {
 	struct amdgpu_device *adev = drm_to_adev(pci_get_drvdata(pdev));
+
 	amdgpu_asic_set_vga_state(adev, state);
 	if (state)
 		return VGA_RSRC_LEGACY_IO | VGA_RSRC_LEGACY_MEM |
@@ -1388,7 +1388,8 @@ static void amdgpu_device_check_block_size(struct amdgpu_device *adev)
 {
 	/* defines number of bits in page table versus page directory,
 	 * a page is 4KB so we have 12 bits offset, minimum 9 bits in the
-	 * page table and the remaining bits are in the page directory */
+	 * page table and the remaining bits are in the page directory
+	 */
 	if (amdgpu_vm_block_size == -1)
 		return;
 
@@ -1620,7 +1621,7 @@ static bool amdgpu_switcheroo_can_switch(struct pci_dev *pdev)
 {
 	struct drm_device *dev = pci_get_drvdata(pdev);
 
-	/*
+       /*
 	* FIXME: open_count is protected by drm_global_mutex but that would lead to
 	* locking inversion with the driver load path. And the access here is
 	* completely racy anyway. So don't bother with locking for now.
@@ -3265,7 +3266,7 @@ static int amdgpu_device_ip_resume_phase2(struct amdgpu_device *adev)
  *
  * Main resume function for hardware IPs.  The hardware IPs
  * are split into two resume functions because they are
- * are also used in in recovering from a GPU reset and some additional
+ * also used in recovering from a GPU reset and some additional
  * steps need to be take between them.  In this case (S3/S4) they are
  * run sequentially.
  * Returns 0 on success, negative error code on failure.
@@ -3367,8 +3368,7 @@ bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type)
 #else
 	default:
 		if (amdgpu_dc > 0)
-			DRM_INFO_ONCE("Display Core has been requested via kernel parameter "
-					 "but isn't supported by ASIC, ignoring\n");
+			DRM_INFO_ONCE("Display Core has been requested via kernel parameter but isn't supported by ASIC, ignoring\n");
 		return false;
 #endif
 	}
@@ -3616,7 +3616,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 		 pdev->subsystem_vendor, pdev->subsystem_device, pdev->revision);
 
 	/* mutex initialization are all done here so we
-	 * can recall function without having locking issues */
+	 * can recall function without having locking issues
+	 */
 	mutex_init(&adev->firmware.mutex);
 	mutex_init(&adev->pm.mutex);
 	mutex_init(&adev->gfx.gpu_clock_mutex);
@@ -3693,11 +3694,11 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 		atomic_set(&adev->pm.pwr_state[i], POWER_STATE_UNKNOWN);
 
 	adev->rmmio = ioremap(adev->rmmio_base, adev->rmmio_size);
-	if (adev->rmmio == NULL) {
+	if (!adev->rmmio)
 		return -ENOMEM;
-	}
+
 	DRM_INFO("register mmio base: 0x%08X\n", (uint32_t)adev->rmmio_base);
-	DRM_INFO("register mmio size: %u\n", (unsigned)adev->rmmio_size);
+	DRM_INFO("register mmio size: %u\n", (unsigned int)adev->rmmio_size);
 
 	/*
 	 * Reset domain needs to be present early, before XGMI hive discovered
@@ -3951,7 +3952,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 
 	/* if we have > 1 VGA cards, then disable the amdgpu VGA resources */
 	/* this will fail for cards that aren't VGA class devices, just
-	 * ignore it */
+	 * ignore it
+	 */
 	if ((adev->pdev->class >> 8) == PCI_CLASS_DISPLAY_VGA)
 		vga_client_register(adev->pdev, amdgpu_device_vga_set_decode);
 
@@ -4034,7 +4036,7 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
 
 	/* make sure IB test finished before entering exclusive mode
 	 * to avoid preemption on IB test
-	 * */
+	 */
 	if (amdgpu_sriov_vf(adev)) {
 		amdgpu_virt_request_full_gpu(adev, false);
 		amdgpu_virt_fini_data_exchange(adev);
@@ -4771,8 +4773,9 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
 		if (!ring || !ring->sched.thread)
 			continue;
 
-		/*clear job fence from fence drv to avoid force_completion
-		 *leave NULL and vm flush fence in fence drv */
+		/* Clear job fence from fence drv to avoid force_completion
+		 * leave NULL and vm flush fence in fence drv
+		 */
 		amdgpu_fence_driver_clear_job_fences(ring);
 
 		/* after all hw jobs are reset, hw fence is meaningless, so force_completion */
@@ -4786,7 +4789,7 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
 
 	r = amdgpu_reset_prepare_hwcontext(adev, reset_context);
 	/* If reset handler not implemented, continue; otherwise return */
-	if (r == -ENOSYS)
+	if (r == -EINVAL)
 		r = 0;
 	else
 		return r;
@@ -4904,7 +4907,7 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
 	reset_context->reset_device_list = device_list_handle;
 	r = amdgpu_reset_perform_reset(tmp_adev, reset_context);
 	/* If reset handler not implemented, continue; otherwise return */
-	if (r == -ENOSYS)
+	if (r == -EINVAL)
 		r = 0;
 	else
 		return r;
@@ -5393,9 +5396,8 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 		if (adev->enable_mes && adev->ip_versions[GC_HWIP][0] != IP_VERSION(11, 0, 3))
 			amdgpu_mes_self_test(tmp_adev);
 
-		if (!drm_drv_uses_atomic_modeset(adev_to_drm(tmp_adev)) && !job_signaled) {
+		if (!drm_drv_uses_atomic_modeset(adev_to_drm(tmp_adev)) && !job_signaled)
 			drm_helper_resume_force_mode(adev_to_drm(tmp_adev));
-		}
 
 		if (tmp_adev->asic_reset_res)
 			r = tmp_adev->asic_reset_res;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
index eec41ad30406..12515e40b693 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
@@ -87,7 +87,7 @@ int amdgpu_reset_prepare_hwcontext(struct amdgpu_device *adev,
 		reset_handler = adev->reset_cntl->get_reset_handler(
 			adev->reset_cntl, reset_context);
 	if (!reset_handler)
-		return -ENOSYS;
+		return -EINVAL;
 
 	return reset_handler->prepare_hwcontext(adev->reset_cntl,
 						reset_context);
@@ -103,7 +103,7 @@ int amdgpu_reset_perform_reset(struct amdgpu_device *adev,
 		reset_handler = adev->reset_cntl->get_reset_handler(
 			adev->reset_cntl, reset_context);
 	if (!reset_handler)
-		return -ENOSYS;
+		return -EINVAL;
 
 	ret = reset_handler->perform_reset(adev->reset_cntl, reset_context);
 	if (ret)
-- 
2.25.1

