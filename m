Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B22EB106B53F
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2026 14:13:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48DA410E841;
	Wed, 25 Mar 2026 14:13:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rwl0C9q+";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012038.outbound.protection.outlook.com
 [40.93.195.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A34110E84F
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2026 14:13:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cMOjBGO2SeGmrGIwuh3zKTmYNqI982JDtU5M/BfIVx74gRES/nYxjUeMgpTjcj5cMw0ehXM95EZ7VsLbtfDT+4kkewE6jbLsP5Bi1ZQupgKLWj3A2l6KioOfbgCLWzCIIA4q9KQkvk3uFze0cYZfMThVH9D0t6g4f0QFQSmIUgGqPWf5qwLEiAoBz0q2w78JJlvenFegzZUTKwR7STQx4dwbnOBM9dllzdLwJjHo+PNIeszmVvC0GvrICQ/JZgu08aSRlTeWiRH16WSYMsQ7B1drVMXehTI7sGJfm3VXLmGfXQa1H0NkUybt7mKEuQ8RdHmS/rZg5IQm2RqiQERv6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dfiMEJ4B3ymYIWtuHEnaBmpDvGMKDM1S/mshp5El5nQ=;
 b=owBtA0dng6Hhyy9VwzLhRRgKQ/F+40heUvS4dbG/LTPFw3+UuHi/Ta7U/TRXSX+sO7VHLLakHRbNcz1AscoVnpagyZZCnUa4xZWQxkIPmkS1cKmtAHSe3QoquFW/PtSq/BJ94CllbafQCYlVS/fcQ8iYv3AGZIsDtNQXQuV4JF+FrT5J/09uSvGClJ37gzswk8NdDiQxijfkH2DtksyXU1Lmw9sK46BmUZLkc7rrz07x/RT8hhWCOsrcxa7pOydzazSRUfwWDeC80C7Q9pg5+hwY2E2roJC5zgOFbvD3slOAlZGW7KAa+W+IafZ+XiB16wEQ1jRk2eswYwvq/1i3Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dfiMEJ4B3ymYIWtuHEnaBmpDvGMKDM1S/mshp5El5nQ=;
 b=rwl0C9q+bk4PIxRstr2+/21M7gdJgm7hxtl87n0rMmfMtlw5I71mUKV8Rc3uvXj7fhg92s7z6SRsjit1MC3VTJl+vKScez71FetRPMBbbEPvtBLKC5HDBmPlnxUhzrnlB1bisF+x0M1PSFckOeF/bVF5fwvrm+IbVYO1ItRvs/Q=
Received: from SJ0PR03CA0369.namprd03.prod.outlook.com (2603:10b6:a03:3a1::14)
 by BY5PR12MB4243.namprd12.prod.outlook.com (2603:10b6:a03:20f::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.6; Wed, 25 Mar
 2026 14:13:11 +0000
Received: from SJ1PEPF00001CDF.namprd05.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::e2) by SJ0PR03CA0369.outlook.office365.com
 (2603:10b6:a03:3a1::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Wed,
 25 Mar 2026 14:13:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CDF.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Wed, 25 Mar 2026 14:13:11 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 25 Mar
 2026 09:13:01 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <Feifei.Xu@amd.com>
Subject: [PATCH 8/9] drm/amdgpu: Add host driver reserved-region
Date: Wed, 25 Mar 2026 19:42:25 +0530
Message-ID: <20260325141226.1173216-8-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260325141226.1173216-1-lijo.lazar@amd.com>
References: <20260325141226.1173216-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDF:EE_|BY5PR12MB4243:EE_
X-MS-Office365-Filtering-Correlation-Id: 36d4a45c-866a-4a6e-2b1b-08de8a78a605
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: P5+K81Flr3HcKjUFp0390Gmw5aSxSkSwlscYKWk3G2Zv2ZnKaR1690R7oFUOyPDOsfG5FsWwrhLi6YgkZEp4xzEv/mNuB9UBWcx/8Jn+0kHFTKQZkmov49V07gcwbaV9KiKrw/LEg3D5vWx2ZZsbW6yoccsPOC0ICyZkXAZLaYLz8YI5kmremoO/JUh5FhyiplPoYXD/yjmufy2zEfXjZ1lvqTAxFbtLpFZTgsTawYUidnV/nYbbxKYTYQi24I63itPX20A+R1TMC3jSEtxeDSdQZJjV8YigKfAaiiAXeXMy2/7DfDABD+OCYhlyxpnQ4/XMxtD1shPPv3h62DSn0vFOXgEI6NsTO0A4MlXR43Ctwy+9SHpJR4SBNcR2dqo4V+9yyERtE8eqnXtqnOnsLBGmPKAI6P1nxePUc2Afx88OX2o+5JNP41eXTn6AzaKpBGAe5A/MnfNEHOpckPFk23SWSuGdTODWSEaiLMtnMzsTmwqweE+YbX6mYPg5uAn6aFYm8d6NHSAb9E3V4ABBf/znphDgYhoojLTCf91vF67ewdhEQbYBAj3UJ71/vPwBXVSd62SD8Orf+D8z4Q6vAG5r1242ThVcR6JsqwnhtMHwMKV3VT2A9C2esx9ujXTZrNGD4yxF85aNzyYyN1Ft5BENCfhtlOhp3fmaJPlA+oIEuQFb5AfQvQQnKO5uBPq3H3RQlESxGEtrB8Ne/55tqQajJAtVbym3fMGpaiijZBwxxprl3RJwMhcI1WBvep23pHW9pjVQPO5regB8R4nmTg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: s2IOjzeBHUJMqhEmyMfqaPpqb7hlIhOa06DeJi3+1rxtv381LNI+lZ1wf/kwVEd0rnIItS1uvJP/In4J90C5XkIoE6WKnUWwf9xgFUT+xJ9GlJoHf2Za3ZYndrGYzwbYijCxI8vfoL7UIQx25W9A+WQ3yXtv4NDJhOn3T14WjZtQ1dQF4JotWfsDm3E1kR8F6z8aM1Sw729RKrXNthwV9Y6a10VMJfvw0MFCjhRsAmNnUg3m3BAppiRUF3TW+zii25MYFXonud6g71K+isHB8F88EeeiwaWzvryivUKKtm4lnV3vw1RpezVW7As/z5sUONU+ws8yqg6UEvzH2I3OGZf/Zz62nO0JizM/I8MYL548/5FlwMVun7qgChjb1Qm3Igk2zRhs4Ay2l6YkJBinEdvQcqjeOgOEZD7hdODkziWC1WaLJ0GEfQaiCIk+k8fD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 14:13:11.8400 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36d4a45c-866a-4a6e-2b1b-08de8a78a605
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4243
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
index 674ceb24f93a..e38296c84895 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1735,48 +1735,6 @@ void amdgpu_ttm_unreserve_vram(struct amdgpu_device *adev,
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
+		r = amdgpu_ttm_reserve_vram(adev, AMDGPU_RESV_DRV_VRAM_USAGE);
+		if (r)
+			return r;
+	}
 
 	/*
 	 * only NAVI10 and later ASICs support IP discovery.
@@ -2313,7 +2276,7 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
 
 	amdgpu_ttm_free_mmio_remap_bo(adev);
 	amdgpu_ttm_unreserve_vram(adev, AMDGPU_RESV_FW_VRAM_USAGE);
-	amdgpu_ttm_drv_reserve_vram_fini(adev);
+	amdgpu_ttm_unreserve_vram(adev, AMDGPU_RESV_DRV_VRAM_USAGE);
 
 	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index df46f43e578c..9976d08d68af 100644
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
index e9b8c08051f3..0642db47e98d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -438,7 +438,8 @@ static void amdgpu_virt_add_bad_page(struct amdgpu_device *adev,
 	uint64_t retired_page;
 	uint32_t bp_idx, bp_cnt;
 	void *fw_va = adev->mman.resv_region[AMDGPU_RESV_FW_VRAM_USAGE].cpu_addr;
-	void *vram_usage_va = fw_va ? fw_va : adev->mman.drv_vram_usage_va;
+	void *drv_va = adev->mman.resv_region[AMDGPU_RESV_DRV_VRAM_USAGE].cpu_addr;
+	void *vram_usage_va = fw_va ? fw_va : drv_va;
 
 	memset(&bp, 0, sizeof(bp));
 
@@ -707,15 +708,16 @@ void amdgpu_virt_init_data_exchange(struct amdgpu_device *adev)
 {
 	uint32_t *pfvf_data = NULL;
 	void *fw_va = adev->mman.resv_region[AMDGPU_RESV_FW_VRAM_USAGE].cpu_addr;
+	void *drv_va = adev->mman.resv_region[AMDGPU_RESV_DRV_VRAM_USAGE].cpu_addr;
 
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
 	void *fw_va = adev->mman.resv_region[AMDGPU_RESV_FW_VRAM_USAGE].cpu_addr;
+	void *drv_va = adev->mman.resv_region[AMDGPU_RESV_DRV_VRAM_USAGE].cpu_addr;
 
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
index 1a640b76c988..4c8571582864 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
@@ -37,6 +37,7 @@ static int amdgpu_virt_ras_get_cmd_shared_mem(struct ras_core_context *ras_core,
 	struct amdsriov_ras_telemetry *ras_telemetry_cpu;
 	struct amdsriov_ras_telemetry *ras_telemetry_gpu;
 	void *fw_va = adev->mman.resv_region[AMDGPU_RESV_FW_VRAM_USAGE].cpu_addr;
+	void *drv_va = adev->mman.resv_region[AMDGPU_RESV_DRV_VRAM_USAGE].cpu_addr;
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

