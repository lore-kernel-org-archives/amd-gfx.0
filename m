Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFC4CC54FB3
	for <amd-gfx@archiver.kernel.org>; Thu, 29 May 2025 10:03:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2781210E725;
	Thu, 29 May 2025 10:03:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5MrAFKSE";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8989C10E725
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 May 2025 10:03:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nBVveaPDsCk9SvmM3Pe6fCiVhx/4weU2Ddk5RJvtBTQtfAEu3wrNsNfD3xnL/Bclz0OW+R9D6H1MOM4ax1h5nO3FDoANauZbtEN18139VjstWrqRMo1MAiV9VMKqfQ+dsv1jIbBjrQZ63RHjJZ/tCmS9TjEJaFm1kZbKc97HaUA/te7yK6DHvgjomIYaCjvJAAt20d/+hnbTbc38XrJc5yEclrzhSk7zsGL1v9EjeltWhApCO7wLQPmK2oQuLI0yMMVc9zY/uhB1TVyIl9YnwchY8+kd4E4PyYllAvwMw4QvSMpaxo8ZzDK0LYg4x9StJsr557yr8W4f0sVKvaY3jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wzziDzWIHuNO/UA22cqYYHxuleqSrXF8Bmi/eY53Xog=;
 b=OsjvHfmWcRO7PLhHmhsS/1/vVTguLUFrkPNgGAckQ8wr8m1sCzftN566fgpbr2FBaifSpeXu+nu7BbJXDD4KCn9R+9vsxI2FWrd5yIHv/eFNNAFWvByha3DUGecgwwOUEOBPI13/L8Vu4yNqx0R5vORCqlX5vH83ZViuPLtgUPasAoHP8rmyZipFUaj2Rh7K1wWqn2+z47Id9c/iqcLNvGE/puLyZ9tA/GIKnhrJatFDzPNWBaS2Bet2r4VdTJ8t/CMPVw4e+cFwafznFFiZ/d2tg5KyY+It2cUDU6DrBJP2AeSCCNl18ZjTMLYG7wi1d5MFIlLUOL5/3esk+84E1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wzziDzWIHuNO/UA22cqYYHxuleqSrXF8Bmi/eY53Xog=;
 b=5MrAFKSEcDAmIe0YSCD3GVvzuZh442SWnJh/j2YQS3E/tHwPfIumxrxQ7vUx9n6xEMG4DjarWQetVx0oNb9bws8/V7YGKYyNxhoWIYou9gMRtm2nCHXuoFBXZJpGSAilzcgmuPNrqIOnQ6IyVP3X+rIccC5GpHo6jDbGrEFUnL8=
Received: from SJ0PR03CA0152.namprd03.prod.outlook.com (2603:10b6:a03:338::7)
 by SA5PPF9D25F0C6D.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8d9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Thu, 29 May
 2025 10:03:35 +0000
Received: from SJ1PEPF00001CEB.namprd03.prod.outlook.com
 (2603:10b6:a03:338:cafe::d7) by SJ0PR03CA0152.outlook.office365.com
 (2603:10b6:a03:338::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Thu,
 29 May 2025 10:03:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF00001CEB.mail.protection.outlook.com (10.167.242.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Thu, 29 May 2025 10:03:35 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 29 May
 2025 05:03:34 -0500
Received: from hjbog-srdc-17.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 29 May 2025 05:03:32 -0500
From: Samuel Zhang <guoqing.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <victor.zhao@amd.com>, <haijun.chang@amd.com>, <guoqing.zhang@amd.com>,
 <Christian.Koenig@amd.com>, <Alexander.Deucher@amd.com>,
 <Owen.Zhang2@amd.com>, <Qing.Ma@amd.com>, <Lijo.Lazar@amd.com>,
 <Emily.Deng@amd.com>
Subject: [PATCH v9 3/4] drm/amdgpu: enable pdb0 for hibernation on SRIOV
Date: Thu, 29 May 2025 18:02:55 +0800
Message-ID: <20250529100256.754769-4-guoqing.zhang@amd.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250529100256.754769-1-guoqing.zhang@amd.com>
References: <20250529100256.754769-1-guoqing.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: guoqing.zhang@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEB:EE_|SA5PPF9D25F0C6D:EE_
X-MS-Office365-Filtering-Correlation-Id: d256c502-00c5-4a77-3499-08dd9e981349
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IcTxJfJkas5R+LxuGCZzwlntlESbvKreh7w9PaLobSIZj6I1BRrWiQks/55E?=
 =?us-ascii?Q?zyERu5GvJQlVVfO4Et+mON7/+qrFYOomhbsAyoYxk0dPoSZyx48Q64T+6GAD?=
 =?us-ascii?Q?bwbc49ugUmt9UJ0cLeNxuWHM9Ub2om2y2/ut3yCyL6UcVenE1gBL5mC0yuxH?=
 =?us-ascii?Q?23aDR6NTNS0pgTNhTKst3n25Gsv7C3ugwha6HNOafx6GbzqQMhCgDgW/0PQt?=
 =?us-ascii?Q?aZc070mZccfW5wL4UExsSk9lAUD7rGJ/UrDnII+BlJOmzADXWH66IPq3TeNH?=
 =?us-ascii?Q?FTBCM4UJtXHjUTAqqcJo26qvnoJ/N9c1ZChNdQW+sdmQ5IE8y5ZTVtrtwHGf?=
 =?us-ascii?Q?ehK9DhZPRMlwBCpTCuHtKQtiFClI3+FX8oTvR08aonOOYr+qG7ic8VfEj6Iy?=
 =?us-ascii?Q?qG+crKn/g302OAnUzhK62iGVRG9shttcaPGAycUukrZ5Tq6aABQ0w1Qc7pI1?=
 =?us-ascii?Q?DTupJSVlrMAiCvxN9Oo6rgxYL/V1iP2u8R37S17jDJTEHfr1FfgIw4vZ4mP6?=
 =?us-ascii?Q?CQvDi+VVpLd1705N7AXUj+c7RPpEt7vb9102ipZBzPBBoEhHjIeq3WfiC25B?=
 =?us-ascii?Q?rmGnJ5QFp54mPoE7x7c2K+bAalB5S/2aD5ABcapHqDka86lTR1+EvG94xIQ3?=
 =?us-ascii?Q?iiB9p1Q0iMOhBj9XQdYbtTLqFWyZaahOvV6QRTlE48L5fWW0L25M5PldDQvZ?=
 =?us-ascii?Q?+DzqY0yS+UOz4gXZQrchULjatUXiy+uYjKlxyM/iqsOUimDzDFvP4yjDrGxf?=
 =?us-ascii?Q?dahdGfz/2JhlIdqvn2cfqqRfSqJ1lhfWa3z+pxJwwkuURtq/XvIWn7ZF0zSu?=
 =?us-ascii?Q?Gto2zQP9XtayYngoQBRJXcAgNQWAa3CovV6teJUKkv65GUJ0GQ4RTxGnPj7i?=
 =?us-ascii?Q?goHPkn1Z64VsDoB13GRDemeRGm5l223h0YoFz2QxwKnAibLdfuNzcaiFAI1q?=
 =?us-ascii?Q?wiYEIFMxo+inzJKYjymfpdIdbSM/Vpw5fJY/DDDPHBQ8N5crg7My31WjYZ26?=
 =?us-ascii?Q?30ujYkv2nuf+luy6k5GO+qBAnUvOF+qJvXYNFa1AppSVEhuiEGRNr8wiN6Pi?=
 =?us-ascii?Q?I3PkUM6i3JKd76PLtYpGoHFdrRy+P19ZwtT8/sv+E8bTjdzEz3tq7atwyTtm?=
 =?us-ascii?Q?p3K6pvXFqTSoW0sDeFyPbsIklakKVnazICnz8/EIO9ZSZe/7BGtY6THlWP2m?=
 =?us-ascii?Q?2/DCv1oslfP3io984TV8hlQZ5SuyqNdjMbpiDY7KLRDGGCbaYdcrMgfvBfBn?=
 =?us-ascii?Q?gQMiYuJ29KoIOnjSUJ8ZacgIItu7onlfNmzvjZRNgyQ+N4sseh8EVq2RuEoc?=
 =?us-ascii?Q?+QBNkhJhULT/bRzLcWswY4fj4/7HbUbP0OTodey1GjJmYiFwZpJW8Gjqca+b?=
 =?us-ascii?Q?R6NcTGDqxPLWrq4kQMSRgeM+EuvRQ3wspkkbJ9KiGtjFKMC9D8eMAmrxMxVU?=
 =?us-ascii?Q?k8TLIhvLvCdO0ACqfWj0NdlL1eN8Ni5Gf495Wc96amhVJ2GUgwpS08RDBa1X?=
 =?us-ascii?Q?2CmYY17h0hvDWz0WqmB6ZlAxlClu5pM6vcfp?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 10:03:35.0990 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d256c502-00c5-4a77-3499-08dd9e981349
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CEB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF9D25F0C6D
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

When switching to new GPU index after hibernation and then resume,
VRAM offset of each VRAM BO will be changed, and the cached gpu
addresses needed to updated.

This is to enable pdb0 and switch to use pdb0-based virtual gpu
address by default in amdgpu_bo_create_reserved(). since the virtual
addresses do not change, this can avoid the need to update all
cached gpu addresses all over the codebase.

Signed-off-by: Emily Deng <Emily.Deng@amd.com>
Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c  | 33 +++++++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h  |  1 +
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c |  8 +++---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c    |  8 +++---
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c  |  6 +++--
 5 files changed, 40 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index d1fa5e8e3937..73ff47403743 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -38,6 +38,13 @@
 #include <drm/drm_drv.h>
 #include <drm/ttm/ttm_tt.h>
 
+static const u64 four_gb = 0x100000000ULL;
+
+bool amdgpu_gmc_is_pdb0_enabled(struct amdgpu_device *adev)
+{
+	return adev->gmc.xgmi.connected_to_cpu || amdgpu_virt_xgmi_migrate_enabled(adev);
+}
+
 /**
  * amdgpu_gmc_pdb0_alloc - allocate vram for pdb0
  *
@@ -251,10 +258,20 @@ void amdgpu_gmc_sysvm_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc
 	u64 hive_vram_end = mc->xgmi.node_segment_size * mc->xgmi.num_physical_nodes - 1;
 	mc->vram_start = mc->xgmi.node_segment_size * mc->xgmi.physical_node_id;
 	mc->vram_end = mc->vram_start + mc->xgmi.node_segment_size - 1;
-	mc->gart_start = hive_vram_end + 1;
+	/* node_segment_size may not 4GB aligned on SRIOV, align up is needed. */
+	mc->gart_start = ALIGN(hive_vram_end + 1, four_gb);
 	mc->gart_end = mc->gart_start + mc->gart_size - 1;
-	mc->fb_start = hive_vram_start;
-	mc->fb_end = hive_vram_end;
+	if (amdgpu_virt_xgmi_migrate_enabled(adev)) {
+		/* set mc->vram_start to 0 to switch the returned GPU address of
+		 * amdgpu_bo_create_reserved() from FB aperture to GART aperture.
+		 */
+		mc->vram_start = 0;
+		mc->vram_end = mc->vram_start + mc->mc_vram_size - 1;
+		mc->visible_vram_size = min(mc->visible_vram_size, mc->real_vram_size);
+	} else {
+		mc->fb_start = hive_vram_start;
+		mc->fb_end = hive_vram_end;
+	}
 	dev_info(adev->dev, "VRAM: %lluM 0x%016llX - 0x%016llX (%lluM used)\n",
 			mc->mc_vram_size >> 20, mc->vram_start,
 			mc->vram_end, mc->real_vram_size >> 20);
@@ -276,7 +293,6 @@ void amdgpu_gmc_sysvm_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc
 void amdgpu_gmc_gart_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc,
 			      enum amdgpu_gart_placement gart_placement)
 {
-	const uint64_t four_gb = 0x100000000ULL;
 	u64 size_af, size_bf;
 	/*To avoid the hole, limit the max mc address to AMDGPU_GMC_HOLE_START*/
 	u64 max_mc_address = min(adev->gmc.mc_mask, AMDGPU_GMC_HOLE_START - 1);
@@ -1053,9 +1069,7 @@ void amdgpu_gmc_init_pdb0(struct amdgpu_device *adev)
 	 */
 	u64 vram_size = adev->gmc.xgmi.node_segment_size * adev->gmc.xgmi.num_physical_nodes;
 	u64 pde0_page_size = (1ULL<<adev->gmc.vmid0_page_table_block_size)<<21;
-	u64 vram_addr = adev->vm_manager.vram_base_offset -
-		adev->gmc.xgmi.physical_node_id * adev->gmc.xgmi.node_segment_size;
-	u64 vram_end = vram_addr + vram_size;
+	u64 vram_addr, vram_end;
 	u64 gart_ptb_gpu_pa = amdgpu_gmc_vram_pa(adev, adev->gart.bo);
 	int idx;
 
@@ -1068,6 +1082,11 @@ void amdgpu_gmc_init_pdb0(struct amdgpu_device *adev)
 	flags |= AMDGPU_PTE_FRAG((adev->gmc.vmid0_page_table_block_size + 9*1));
 	flags |= AMDGPU_PDE_PTE_FLAG(adev);
 
+	vram_addr = adev->vm_manager.vram_base_offset;
+	if (!amdgpu_virt_xgmi_migrate_enabled(adev))
+		vram_addr -= adev->gmc.xgmi.physical_node_id * adev->gmc.xgmi.node_segment_size;
+	vram_end = vram_addr + vram_size;
+
 	/* The first n PDE0 entries are used as PTE,
 	 * pointing to vram
 	 */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index bd7fc123b8f9..8b3c84be7415 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -390,6 +390,7 @@ static inline uint64_t amdgpu_gmc_sign_extend(uint64_t addr)
 	return addr;
 }
 
+bool amdgpu_gmc_is_pdb0_enabled(struct amdgpu_device *adev);
 int amdgpu_gmc_pdb0_alloc(struct amdgpu_device *adev);
 void amdgpu_gmc_get_pde_for_bo(struct amdgpu_bo *bo, int level,
 			       uint64_t *addr, uint64_t *flags);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
index cb25f7f0dfc1..32a3987bef80 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
@@ -76,6 +76,8 @@ static void gfxhub_v1_2_xcc_init_gart_aperture_regs(struct amdgpu_device *adev,
 {
 	uint64_t pt_base;
 	int i;
+	uint64_t gart_start = amdgpu_virt_xgmi_migrate_enabled(adev) ?
+			adev->gmc.vram_start : adev->gmc.fb_start;
 
 	if (adev->gmc.pdb0_bo)
 		pt_base = amdgpu_gmc_pd_addr(adev->gmc.pdb0_bo);
@@ -91,10 +93,10 @@ static void gfxhub_v1_2_xcc_init_gart_aperture_regs(struct amdgpu_device *adev,
 		if (adev->gmc.pdb0_bo) {
 			WREG32_SOC15(GC, GET_INST(GC, i),
 				     regVM_CONTEXT0_PAGE_TABLE_START_ADDR_LO32,
-				     (u32)(adev->gmc.fb_start >> 12));
+				     (u32)(gart_start >> 12));
 			WREG32_SOC15(GC, GET_INST(GC, i),
 				     regVM_CONTEXT0_PAGE_TABLE_START_ADDR_HI32,
-				     (u32)(adev->gmc.fb_start >> 44));
+				     (u32)(gart_start >> 44));
 
 			WREG32_SOC15(GC, GET_INST(GC, i),
 				     regVM_CONTEXT0_PAGE_TABLE_END_ADDR_LO32,
@@ -180,7 +182,7 @@ gfxhub_v1_2_xcc_init_system_aperture_regs(struct amdgpu_device *adev,
 		/* In the case squeezing vram into GART aperture, we don't use
 		 * FB aperture and AGP aperture. Disable them.
 		 */
-		if (adev->gmc.pdb0_bo) {
+		if (adev->gmc.pdb0_bo && adev->gmc.xgmi.connected_to_cpu) {
 			WREG32_SOC15(GC, GET_INST(GC, i), regMC_VM_FB_LOCATION_TOP, 0);
 			WREG32_SOC15(GC, GET_INST(GC, i), regMC_VM_FB_LOCATION_BASE, 0x00FFFFFF);
 			WREG32_SOC15(GC, GET_INST(GC, i), regMC_VM_AGP_TOP, 0);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 59385da80185..11041d0d4a64 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1726,7 +1726,7 @@ static void gmc_v9_0_vram_gtt_location(struct amdgpu_device *adev,
 
 	/* add the xgmi offset of the physical node */
 	base += adev->gmc.xgmi.physical_node_id * adev->gmc.xgmi.node_segment_size;
-	if (adev->gmc.xgmi.connected_to_cpu) {
+	if (amdgpu_gmc_is_pdb0_enabled(adev)) {
 		amdgpu_gmc_sysvm_location(adev, mc);
 	} else {
 		amdgpu_gmc_vram_location(adev, mc, base);
@@ -1841,7 +1841,7 @@ static int gmc_v9_0_gart_init(struct amdgpu_device *adev)
 		return 0;
 	}
 
-	if (adev->gmc.xgmi.connected_to_cpu) {
+	if (amdgpu_gmc_is_pdb0_enabled(adev)) {
 		adev->gmc.vmid0_page_table_depth = 1;
 		adev->gmc.vmid0_page_table_block_size = 12;
 	} else {
@@ -1867,7 +1867,7 @@ static int gmc_v9_0_gart_init(struct amdgpu_device *adev)
 		if (r)
 			return r;
 
-		if (adev->gmc.xgmi.connected_to_cpu)
+		if (amdgpu_gmc_is_pdb0_enabled(adev))
 			r = amdgpu_gmc_pdb0_alloc(adev);
 	}
 
@@ -2372,7 +2372,7 @@ static int gmc_v9_0_gart_enable(struct amdgpu_device *adev)
 {
 	int r;
 
-	if (adev->gmc.xgmi.connected_to_cpu)
+	if (amdgpu_gmc_is_pdb0_enabled(adev))
 		amdgpu_gmc_init_pdb0(adev);
 
 	if (adev->gart.bo == NULL) {
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
index 84cde1239ee4..ef3e5bf23351 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
@@ -75,6 +75,8 @@ static void mmhub_v1_8_setup_vm_pt_regs(struct amdgpu_device *adev, uint32_t vmi
 
 static void mmhub_v1_8_init_gart_aperture_regs(struct amdgpu_device *adev)
 {
+	uint64_t gart_start = amdgpu_virt_xgmi_migrate_enabled(adev) ?
+			adev->gmc.vram_start : adev->gmc.fb_start;
 	uint64_t pt_base;
 	u32 inst_mask;
 	int i;
@@ -94,10 +96,10 @@ static void mmhub_v1_8_init_gart_aperture_regs(struct amdgpu_device *adev)
 		if (adev->gmc.pdb0_bo) {
 			WREG32_SOC15(MMHUB, i,
 				     regVM_CONTEXT0_PAGE_TABLE_START_ADDR_LO32,
-				     (u32)(adev->gmc.fb_start >> 12));
+				     (u32)(gart_start >> 12));
 			WREG32_SOC15(MMHUB, i,
 				     regVM_CONTEXT0_PAGE_TABLE_START_ADDR_HI32,
-				     (u32)(adev->gmc.fb_start >> 44));
+				     (u32)(gart_start >> 44));
 
 			WREG32_SOC15(MMHUB, i,
 				     regVM_CONTEXT0_PAGE_TABLE_END_ADDR_LO32,
-- 
2.43.5

