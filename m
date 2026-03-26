Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14199106F2EA
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2026 07:55:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 897C910E994;
	Thu, 26 Mar 2026 07:55:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="26lGa7OL";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013033.outbound.protection.outlook.com
 [40.93.201.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1B4210E986
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 07:55:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HqEVxI3JUE2hy7NOkMmk7sA84qriHoHk56UiO3+8g3zoH8ZwsFab976GWfOoQDX5cnTrNBp/6w3nwja/Wy/cSdaVMyzyte5KaxcDceJvX3japEwh9lK2vnG1oh0eA7qB2ql3SuwvUrNb2e1ob1UpDvYH66CO5AFrxDskTsEgfB9mRL2uhgBHzlSOiEhUfSTy/IAuRAqQEc+erJuG/WUcsDzfeeGDTvC95dlE6wSICKoE6Ke634HwECIN25XQwryzgSNX/zibwy4fZ1cg1nv+BvQpEdO4nzGdMgjDRnCH6q7x9nit2JTeojMYff/9d3EMvqFR4zwwyaBwSNspMEiRSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1AHSjNDtzQz9wXmswQHqjbfRMH0EOLdv6Ss4TbeuZIE=;
 b=n9p6B5OFNPF2df2rfASikP98+ivRomzSCqn3Ufq4zafEdQqCET/GVUSCtjLaCk4fq22EMgjqJpxAAEG82BuvM1zz6gaent/6vvFk0/bZ8Tm5gybdyIs3WtH0rG/GkyqmbfL9rBeuw+4IdS1SPxFfjtDt6jhf4uJYD3ZEO9mmZ4Nq9yzwDi6lYWIVLhxy0TkF16ixY7nbb6RCavwCPq5snvn093ZM7H+OqnP42QGZKyqDYPD4iFjhZySdy53fbQgHD+o9HTCkKl4/TeLlL4fVjPnsap3y1ni6wZsnmdvkhSCwZedopodXfJAJ4ETNVeuwc7QGgoUa9gS/sHhQTMWK7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1AHSjNDtzQz9wXmswQHqjbfRMH0EOLdv6Ss4TbeuZIE=;
 b=26lGa7OLi5mWvh9wVEEyq4TVq6cbx61iNRH/1by/tbRI7Ar5XKwDIFkmI4WTzdWhiNcgTL3kMFQnDYO4FG2cNdU9O8l5lYjeqOWFGlS9T75U57Xp8r/CeV9vgDvFdeMwg/RjrbTebXlS3EvVUxxA0mMdUJ8+TYtWStY6BBF/LQw=
Received: from BN1PR12CA0020.namprd12.prod.outlook.com (2603:10b6:408:e1::25)
 by CYXPR12MB9318.namprd12.prod.outlook.com (2603:10b6:930:de::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.10; Thu, 26 Mar
 2026 07:55:04 +0000
Received: from BN1PEPF00004689.namprd05.prod.outlook.com
 (2603:10b6:408:e1:cafe::c8) by BN1PR12CA0020.outlook.office365.com
 (2603:10b6:408:e1::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Thu,
 26 Mar 2026 07:55:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00004689.mail.protection.outlook.com (10.167.243.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Thu, 26 Mar 2026 07:55:04 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 26 Mar
 2026 02:54:58 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <Feifei.Xu@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 08/14] drm/amdgpu: Add host driver reserved-region
Date: Thu, 26 Mar 2026 13:15:29 +0530
Message-ID: <20260326075412.1378411-9-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260326075412.1378411-1-lijo.lazar@amd.com>
References: <20260326075412.1378411-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004689:EE_|CYXPR12MB9318:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c320552-8626-4255-1f13-08de8b0cfdaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 3Ro9qmwHEaKYYkjOc4Upm66dSCYhGI3LGTsJBFXtKkOKIM7tlXg2XaZbFzpK3eOQkvL7GqvwEs9RXwWo9MxwDsjc90VJu2AdICvp3/PzvxbcQyIaaFO+yY0cRaGjIXa5KF91+VdDrEfZTkb3sdYI328C0PsPz8s2I+D8ZpUuXExlWOEYngmIS22vPI3ef/gjJ/vpZbZ+aclcSbBYamhHQE8cPmKC8RXERTMfuRf68FNseUGmwt5B/zjWlm9lGFrKH7g/4lhYG78I0/6Ku3IFUOuUIpuiFW+mLKNyuzkBm7Ghs4xAS38pLFgfWkNIFTqbn+qsRkShCN8CriPPuDW10N7AFg3jUrG94F47dsYf2mX71/X78UrBArNquSldC5lDUYPOvWY/ran6PB2euiPmLYnazijhgP2Vll9oDsWIUaiYWOruDylg5gflnF//qefkPkOkMC7lwEFtcXaDgoghfObubyLAKNDyDilvD+/8R2zABR7WpanuvR57kZZrjRCJTbr9e+ypgu7xZPXUoKvDIo+CyWg7jzwRci1seqM0KnlYPBZElVwAOCcB+UqnStkwxUFrvmwYOD8Exp2haolF+f668VbAdUJ+ISBDxSrDNItngkntYVuDNQerbt9D2gl2jImRVl4X0Z0/1Ryqhw7+eMYQqt5m/BL+dhWBnzM2+d1tJykyQvMUsmHTSpHilubNONYqaj1wgxjPMuydOVPrlnPeeuG79x73/CCrCYygIwNvoJyOkhIiKbG6bykeOxRkSZIbcKfSueP6lAaZ96vp7A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Bd3/wT/37UMoKTZw9tYe3+8qMRg6UbuxmsER5p+A7WNOdzZbIuoqFDIm3RiZ/WEjkvHF3yvZgO1X8AxnExW6wdIJs095RhQDdOHnTYfb6j9KvOGbNC8wutPd5XvHlHQHBHsyZFAjjCkeyS0DSxnXIw4ixo05qWZ3daSXgDsDO82EHTQR34oG3gb2gKTUYOHx+kDWF/haPWJnTyfcVSOKSlLk7ra7dDSCxbnQjska1EdWI6xbvD+IgwNvxVfL8NqTy+F1RnH82NHAPsbNmgR7EefGht4MmfrVxoenhf9CflGdhQwpJ/nBTY4LiRUtINWZpTBUZkid/jsdb/mKWoy9xCsidrmMMCpw5H6IYNBEVwjTmFnxbrCc/hE4Rtlw90ty1ZYdSdThpPECmHheANWqjkUweJvNXwUTe9efPzJ2JKx9ZevQkp78D7WnZva7qEac
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 07:55:04.4403 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c320552-8626-4255-1f13-08de8b0cfdaa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004689.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9318
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use reserve region helpers for initializing/reserving host driver
reserved region in virtualization environment.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c  |  6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 55 +++----------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |  6 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c      | 19 ++++---
 .../drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c |  8 +--
 5 files changed, 27 insertions(+), 67 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
index 36e1f6b65075..8ff129fadc6a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
@@ -161,9 +161,9 @@ static int amdgpu_atomfirmware_allocate_fb_v2_2(struct amdgpu_device *adev,
 	    ((drv_start_addr & (ATOM_VRAM_BLOCK_NEEDS_NO_RESERVATION <<
 		ATOM_VRAM_OPERATION_FLAGS_SHIFT)) == 0)) {
 		/* driver request VRAM reservation for SR-IOV */
-		adev->mman.drv_vram_usage_start_offset = (drv_start_addr &
-			(~ATOM_VRAM_OPERATION_FLAGS_MASK)) << 10;
-		adev->mman.drv_vram_usage_size = drv_size << 10;
+		amdgpu_ttm_init_vram_resv(adev, AMDGPU_RESV_DRV_VRAM_USAGE,
+				  (drv_start_addr & (~ATOM_VRAM_OPERATION_FLAGS_MASK)) << 10,
+				  drv_size << 10, true);
 	}
 
 	*usage_bytes = 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index f06b3ac243f2..ed11d854b769 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1735,48 +1735,6 @@ void amdgpu_ttm_unmark_vram_reserved(struct amdgpu_device *adev,
 	memset(resv, 0, sizeof(*resv));
 }
 
-/*
- * Driver Reservation functions
- */
-/**
- * amdgpu_ttm_drv_reserve_vram_fini - free drv reserved vram
- *
- * @adev: amdgpu_device pointer
- *
- * free drv reserved vram if it has been reserved.
- */
-static void amdgpu_ttm_drv_reserve_vram_fini(struct amdgpu_device *adev)
-{
-	amdgpu_bo_free_kernel(&adev->mman.drv_vram_usage_reserved_bo,
-						  NULL,
-						  &adev->mman.drv_vram_usage_va);
-}
-
-/**
- * amdgpu_ttm_drv_reserve_vram_init - create bo vram reservation from driver
- *
- * @adev: amdgpu_device pointer
- *
- * create bo vram reservation from drv.
- */
-static int amdgpu_ttm_drv_reserve_vram_init(struct amdgpu_device *adev)
-{
-	u64 vram_size = adev->gmc.visible_vram_size;
-
-	adev->mman.drv_vram_usage_va = NULL;
-	adev->mman.drv_vram_usage_reserved_bo = NULL;
-
-	if (adev->mman.drv_vram_usage_size == 0 ||
-	    adev->mman.drv_vram_usage_size > vram_size)
-		return 0;
-
-	return amdgpu_bo_create_kernel_at(adev,
-					  adev->mman.drv_vram_usage_start_offset,
-					  adev->mman.drv_vram_usage_size,
-					  &adev->mman.drv_vram_usage_reserved_bo,
-					  &adev->mman.drv_vram_usage_va);
-}
-
 /*
  * Memoy training reservation functions
  */
@@ -2155,9 +2113,14 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 	 * The reserved VRAM for the driver must be pinned to a specific
 	 * location in VRAM, so reserve it early.
 	 */
-	r = amdgpu_ttm_drv_reserve_vram_init(adev);
-	if (r)
-		return r;
+	if (adev->mman.resv_region[AMDGPU_RESV_DRV_VRAM_USAGE].size >
+	    adev->gmc.visible_vram_size) {
+		adev->mman.resv_region[AMDGPU_RESV_DRV_VRAM_USAGE].size = 0;
+	} else {
+		r = amdgpu_ttm_mark_vram_reserved(adev, AMDGPU_RESV_DRV_VRAM_USAGE);
+		if (r)
+			return r;
+	}
 
 	/*
 	 * only NAVI10 and later ASICs support IP discovery.
@@ -2313,7 +2276,7 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
 
 	amdgpu_ttm_free_mmio_remap_bo(adev);
 	amdgpu_ttm_unmark_vram_reserved(adev, AMDGPU_RESV_FW_VRAM_USAGE);
-	amdgpu_ttm_drv_reserve_vram_fini(adev);
+	amdgpu_ttm_unmark_vram_reserved(adev, AMDGPU_RESV_DRV_VRAM_USAGE);
 
 	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index b7dd61cf4b79..5dfc2a46e569 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -101,12 +101,6 @@ struct amdgpu_mman {
 
 	bool			keep_stolen_vga_memory;
 
-	/* driver VRAM reservation */
-	u64		drv_vram_usage_start_offset;
-	u64		drv_vram_usage_size;
-	struct amdgpu_bo	*drv_vram_usage_reserved_bo;
-	void		*drv_vram_usage_va;
-
 	struct amdgpu_vram_resv		resv_region[AMDGPU_RESV_MAX];
 
 	/* PAGE_SIZE'd BO for process memory r/w over SDMA. */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index d0deee062d0b..6974b1c5b56c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -438,7 +438,8 @@ static void amdgpu_virt_add_bad_page(struct amdgpu_device *adev,
 	uint64_t retired_page;
 	uint32_t bp_idx, bp_cnt;
 	void *fw_va = adev->mman.resv_region[AMDGPU_RESV_FW_VRAM_USAGE].cpu_ptr;
-	void *vram_usage_va = fw_va ? fw_va : adev->mman.drv_vram_usage_va;
+	void *drv_va = adev->mman.resv_region[AMDGPU_RESV_DRV_VRAM_USAGE].cpu_ptr;
+	void *vram_usage_va = fw_va ? fw_va : drv_va;
 
 	memset(&bp, 0, sizeof(bp));
 
@@ -707,15 +708,16 @@ void amdgpu_virt_init_data_exchange(struct amdgpu_device *adev)
 {
 	uint32_t *pfvf_data = NULL;
 	void *fw_va = adev->mman.resv_region[AMDGPU_RESV_FW_VRAM_USAGE].cpu_ptr;
+	void *drv_va = adev->mman.resv_region[AMDGPU_RESV_DRV_VRAM_USAGE].cpu_ptr;
 
 	adev->virt.fw_reserve.p_pf2vf = NULL;
 	adev->virt.fw_reserve.p_vf2pf = NULL;
 	adev->virt.vf2pf_update_interval_ms = 0;
 	adev->virt.vf2pf_update_retry_cnt = 0;
 
-	if (fw_va && adev->mman.drv_vram_usage_va) {
+	if (fw_va && drv_va) {
 		dev_warn(adev->dev, "Currently fw_vram and drv_vram should not have values at the same time!");
-	} else if (fw_va || adev->mman.drv_vram_usage_va) {
+	} else if (fw_va || drv_va) {
 		/* go through this logic in ip_init and reset to init workqueue*/
 		amdgpu_virt_exchange_data(adev);
 
@@ -761,8 +763,9 @@ void amdgpu_virt_exchange_data(struct amdgpu_device *adev)
 	uint32_t bp_block_size = 0;
 	struct amd_sriov_msg_pf2vf_info *pf2vf_v2 = NULL;
 	void *fw_va = adev->mman.resv_region[AMDGPU_RESV_FW_VRAM_USAGE].cpu_ptr;
+	void *drv_va = adev->mman.resv_region[AMDGPU_RESV_DRV_VRAM_USAGE].cpu_ptr;
 
-	if (fw_va || adev->mman.drv_vram_usage_va) {
+	if (fw_va || drv_va) {
 		if (fw_va) {
 			if (adev->virt.req_init_data_ver == GPU_CRIT_REGION_V2) {
 				adev->virt.fw_reserve.p_pf2vf =
@@ -787,15 +790,15 @@ void amdgpu_virt_exchange_data(struct amdgpu_device *adev)
 				adev->virt.fw_reserve.ras_telemetry =
 					(fw_va + (AMD_SRIOV_MSG_RAS_TELEMETRY_OFFSET_KB_V1 << 10));
 			}
-		} else if (adev->mman.drv_vram_usage_va) {
+		} else if (drv_va) {
 			adev->virt.fw_reserve.p_pf2vf =
 				(struct amd_sriov_msg_pf2vf_info_header *)
-				(adev->mman.drv_vram_usage_va + (AMD_SRIOV_MSG_PF2VF_OFFSET_KB_V1 << 10));
+				(drv_va + (AMD_SRIOV_MSG_PF2VF_OFFSET_KB_V1 << 10));
 			adev->virt.fw_reserve.p_vf2pf =
 				(struct amd_sriov_msg_vf2pf_info_header *)
-				(adev->mman.drv_vram_usage_va + (AMD_SRIOV_MSG_VF2PF_OFFSET_KB_V1 << 10));
+				(drv_va + (AMD_SRIOV_MSG_VF2PF_OFFSET_KB_V1 << 10));
 			adev->virt.fw_reserve.ras_telemetry =
-				(adev->mman.drv_vram_usage_va + (AMD_SRIOV_MSG_RAS_TELEMETRY_OFFSET_KB_V1 << 10));
+				(drv_va + (AMD_SRIOV_MSG_RAS_TELEMETRY_OFFSET_KB_V1 << 10));
 		}
 
 		amdgpu_virt_read_pf2vf_data(adev);
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
index 4873369c56e2..28f94b92716a 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
@@ -37,6 +37,7 @@ static int amdgpu_virt_ras_get_cmd_shared_mem(struct ras_core_context *ras_core,
 	struct amdsriov_ras_telemetry *ras_telemetry_cpu;
 	struct amdsriov_ras_telemetry *ras_telemetry_gpu;
 	void *fw_va = adev->mman.resv_region[AMDGPU_RESV_FW_VRAM_USAGE].cpu_ptr;
+	void *drv_va = adev->mman.resv_region[AMDGPU_RESV_DRV_VRAM_USAGE].cpu_ptr;
 	uint64_t fw_vram_usage_start_offset = 0;
 	uint64_t ras_telemetry_offset = 0;
 
@@ -47,11 +48,10 @@ static int amdgpu_virt_ras_get_cmd_shared_mem(struct ras_core_context *ras_core,
 		fw_vram_usage_start_offset = adev->mman.resv_region[AMDGPU_RESV_FW_VRAM_USAGE].offset;
 		ras_telemetry_offset = (uintptr_t)adev->virt.fw_reserve.ras_telemetry -
 				(uintptr_t)fw_va;
-	} else if (adev->mman.drv_vram_usage_va &&
-		adev->mman.drv_vram_usage_va <= adev->virt.fw_reserve.ras_telemetry) {
-		fw_vram_usage_start_offset = adev->mman.drv_vram_usage_start_offset;
+	} else if (drv_va && drv_va <= adev->virt.fw_reserve.ras_telemetry) {
+		fw_vram_usage_start_offset = adev->mman.resv_region[AMDGPU_RESV_DRV_VRAM_USAGE].offset;
 		ras_telemetry_offset = (uintptr_t)adev->virt.fw_reserve.ras_telemetry -
-				(uintptr_t)adev->mman.drv_vram_usage_va;
+				(uintptr_t)drv_va;
 	} else {
 		return -EINVAL;
 	}
-- 
2.49.0

