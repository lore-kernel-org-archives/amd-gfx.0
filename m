Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAAD7C54E65
	for <amd-gfx@archiver.kernel.org>; Thu, 22 May 2025 10:41:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4387410E754;
	Thu, 22 May 2025 10:41:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XJYVWzN7";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3676E10EC6F
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 May 2025 10:41:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wNfXzXeDMWnpP49ZBsVEnSV/630+/sjLaJJOIyfkHb4ezkER0eqyL/aX5XefsyCPuT4m+GEWRc1s+wtJD80dyeydq2bSw8JrkWnbuUq9AaXu7av/JW/Crbz/lM0UFU3N47XyyLztDMw8jNpqXzLEQdMHW0qqFipLJDTM6WYCF+Y0oChv3xfJvLvh7Txs0G+54/1rDyjV2BaZspJznQXrPim40XpGSDbH1Aq0pwdYjD8zJqIwVXyzv8yPsNK3eBaTaY2Ec4psbqTTjjYXas+BHsHpvz3mBb21Ewp05+FGEvYDDp5xqaYKG1BwMBS5YmHFHIxXlo3xYTmgbhF2hJNMUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qeKcw2U2vn5zuyPEJQc/pvDQYacwKE1vesmieZOSwFg=;
 b=MO2PRiXLcC+f5kdTDDz+bvIIbpjy4MFWi/gjOdsy8N+K46Z/ClKjbPSb0Ic8FIKGQU9fpNpO0VlTLFXkdDOTr3Uv4q0wtUZMivnv4Xi+QmxyOgvAyPTZqjBTEv++zVowN7heGuKXojMegdl//dkdRblAGS21G/91YM2tk4zmBNqH3qxrtM1TW3U7pw3TWQUVs8h4eMvWPkLSM7mo4HPP0XUV/LcAW+V4BKbHzvVoJJNXXP6/qB/ZoRjk2ks8AAUuaxFJvRgY0IntrubrxMlgb9RO9RqobYLZhtcZeNW+TvJiNX9IFe2CDrAGAwvhkKvwJ3mc4N+ux/RDomMpkntCCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qeKcw2U2vn5zuyPEJQc/pvDQYacwKE1vesmieZOSwFg=;
 b=XJYVWzN701ctRKSWzcxYOMWhXboZoHW6pzKMBGaOXwN6CwqwJroKQXUmsCh7qqcvoiTPSsvuWvIa/guUeMINVtjbg91+84ttet6kR+B0Pk27uoTQVgfiupEmYoqAclEzOQEZtNz72UcpULpnz3HcvK9btKZ+ue3sgQW0KBdKkNA=
Received: from SJ0PR13CA0154.namprd13.prod.outlook.com (2603:10b6:a03:2c7::9)
 by CH3PR12MB9023.namprd12.prod.outlook.com (2603:10b6:610:17b::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Thu, 22 May
 2025 10:41:19 +0000
Received: from SJ5PEPF000001D6.namprd05.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::29) by SJ0PR13CA0154.outlook.office365.com
 (2603:10b6:a03:2c7::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.17 via Frontend Transport; Thu,
 22 May 2025 10:41:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D6.mail.protection.outlook.com (10.167.242.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Thu, 22 May 2025 10:41:18 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 22 May
 2025 05:41:18 -0500
Received: from hjbog-srdc-17.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 22 May 2025 05:41:15 -0500
From: Samuel Zhang <guoqing.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <victor.zhao@amd.com>, <haijun.chang@amd.com>, <guoqing.zhang@amd.com>,
 <Christian.Koenig@amd.com>, <Alexander.Deucher@amd.com>,
 <Owen.Zhang2@amd.com>, <Qing.Ma@amd.com>, <Lijo.Lazar@amd.com>,
 <Emily.Deng@amd.com>
Subject: [PATCH v8 3/4] drm/amdgpu: enable pdb0 for hibernation on SRIOV
Date: Thu, 22 May 2025 18:40:47 +0800
Message-ID: <20250522104048.569456-4-guoqing.zhang@amd.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250522104048.569456-1-guoqing.zhang@amd.com>
References: <20250522104048.569456-1-guoqing.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: guoqing.zhang@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D6:EE_|CH3PR12MB9023:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cc328f2-b2f8-41d8-9d65-08dd991d2fba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oUq0xKQcqdEiPq8MhTXCjsO5gUfmBw3MfIqB3MiDfmDiaaV16y8sFTef8unM?=
 =?us-ascii?Q?tfZhFZ3fWF2/1cQTNmdNl+JFP2zn9vOA6fhDUuDaxsQCnwGlmjkDCTHuxvjE?=
 =?us-ascii?Q?AZgkT9yR23ROJ/xIGOTh1FnI25nN7aYlw6XysNs/ITUwvvXg4E+EWgnQPS1t?=
 =?us-ascii?Q?TSAtYSlh/ZmESULCfL9bn2DHgO5QfGDujZZnNd3JZ1ZNnOCgDRtIrchYzjhi?=
 =?us-ascii?Q?L2pSu50C9iqErtYFcAZwXFiu189bJi3rt4YAgeYjXnqLOidl6CNg0HAAlc6e?=
 =?us-ascii?Q?STj8OFt5pU/bQxYkD2GPQSg8k89fRjOX+Xbi3xJVzzMB3x8hOmeGh2ehN8Yr?=
 =?us-ascii?Q?3KMwxtR435ilj9whgoo2px8Ccod1U/pHXIYH2K4fyzIhU/CLA38ibDBFebT9?=
 =?us-ascii?Q?H1k5x8083MRT1MLogqseKoH8F1OwYmFtHwrZHmPg12MlK/sWHV3eCBQPAzrC?=
 =?us-ascii?Q?kYpwsA2QYLdTCp9mCLI1I3NR1XTEcMefKDAH5BK30HBhDclMRrdnV4U/cZvU?=
 =?us-ascii?Q?HlRuenxzZn/QqWVwWK6yiP3MU/qavsnMmxAQYogpVbeByq8ZvGDknFq1GUwU?=
 =?us-ascii?Q?f2GYtbF1/Dl2cOmYGNoAL44OMrFbV6OVz4sL2HUeEwExbY++oj0hYhKheo5u?=
 =?us-ascii?Q?OIvAyiWrT1h3We+uzAdSd0rJiPzfOKvufvjGoG3fi93l+frDdqhMfbY4/xWv?=
 =?us-ascii?Q?b2eJAnEv4oyijA/vvZjjUqoI2s9P6T6Hs9IcO1wXD/zTA9U1ZYduY4VgZeGV?=
 =?us-ascii?Q?jSBxgAxigAkI1d1uWw2amyAs9k243iInC7sq01h/I8uMnm0KN0QDVFbLdEhA?=
 =?us-ascii?Q?k/YS9abB/If3kXZpPbCYh512QTOs6L+rOx/TiydPmF4t1A3BXslvBfSSrzSc?=
 =?us-ascii?Q?J5h2on4kjtsaYEhUwCPO6kPCylUjOvZXajgjDpLxwXtX98ahBzpPkbU3bV1s?=
 =?us-ascii?Q?8QIeP439rW/q8zj8GrlSF7VfPvhkmuuNFybHzRs4SjAmtc7TFFEVj+lt3Efw?=
 =?us-ascii?Q?L2zRlJdXh4hwa+UmVsIi80sctnR395eaZJs/iYIzNuseuuYBZAdNFxDFg7/X?=
 =?us-ascii?Q?9+d/S4H6d9u6ELJ7eu7xkKXGAhwHLRw1tlIrbQcssv4ZULb8g7XptRy1WATj?=
 =?us-ascii?Q?zpeVJSejkxaM2hmC2CGV6W/N+pVP/vgGFb7fOrOQDywq/SY/N5q0EZr/I27f?=
 =?us-ascii?Q?69bMcP1ZGJedaEERAM0wyrdtjZv6TazNS+U00vogMiNdX1QVUm6X+gg1lcDj?=
 =?us-ascii?Q?YK7HMF+YG3C3jbqoEELkh9IGePp1FBQObWzG9RAiLXXRT2yQkolRooOsE9nC?=
 =?us-ascii?Q?hp/mU2A1xF33VC7dl57GB6yhIG5FGd/z6cvKzaCzvfjh1Rxg3CTpx3XiDiyz?=
 =?us-ascii?Q?twQWVeFfK7+WH4CqeTZgEiE8yHGEBWmOHM2zpsahiD/KKjxSgT6xMPeeKTbz?=
 =?us-ascii?Q?6uWp6QYP48hc+eX8qixFWIYgh9FabDPyCcWDLgMuAT+ZEw3riolDNWMqbkJk?=
 =?us-ascii?Q?kOznRyzRVTXtwL6DYypnj3mcuCzi0du42bi2?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 10:41:18.9074 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cc328f2-b2f8-41d8-9d65-08dd991d2fba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9023
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c  | 28 ++++++++++++++++++------
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c |  8 ++++---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c    | 13 +++++++----
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c  |  6 +++--
 4 files changed, 39 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index d1fa5e8e3937..74b565283aa9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -38,6 +38,8 @@
 #include <drm/drm_drv.h>
 #include <drm/ttm/ttm_tt.h>
 
+static const u64 four_gb = 0x100000000ULL;
+
 /**
  * amdgpu_gmc_pdb0_alloc - allocate vram for pdb0
  *
@@ -251,10 +253,20 @@ void amdgpu_gmc_sysvm_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc
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
@@ -276,7 +288,6 @@ void amdgpu_gmc_sysvm_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc
 void amdgpu_gmc_gart_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc,
 			      enum amdgpu_gart_placement gart_placement)
 {
-	const uint64_t four_gb = 0x100000000ULL;
 	u64 size_af, size_bf;
 	/*To avoid the hole, limit the max mc address to AMDGPU_GMC_HOLE_START*/
 	u64 max_mc_address = min(adev->gmc.mc_mask, AMDGPU_GMC_HOLE_START - 1);
@@ -1053,9 +1064,7 @@ void amdgpu_gmc_init_pdb0(struct amdgpu_device *adev)
 	 */
 	u64 vram_size = adev->gmc.xgmi.node_segment_size * adev->gmc.xgmi.num_physical_nodes;
 	u64 pde0_page_size = (1ULL<<adev->gmc.vmid0_page_table_block_size)<<21;
-	u64 vram_addr = adev->vm_manager.vram_base_offset -
-		adev->gmc.xgmi.physical_node_id * adev->gmc.xgmi.node_segment_size;
-	u64 vram_end = vram_addr + vram_size;
+	u64 vram_addr, vram_end;
 	u64 gart_ptb_gpu_pa = amdgpu_gmc_vram_pa(adev, adev->gart.bo);
 	int idx;
 
@@ -1068,6 +1077,11 @@ void amdgpu_gmc_init_pdb0(struct amdgpu_device *adev)
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
index 59385da80185..3003aa5a53e2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -413,6 +413,11 @@ static const uint32_t ecc_umc_mcumc_ctrl_mask_addrs[] = {
 	(0x001d43e0 + 0x00001800),
 };
 
+static inline bool amdgpu_gmc_is_pdb0_enabled(struct amdgpu_device *adev)
+{
+	return adev->gmc.xgmi.connected_to_cpu || amdgpu_virt_xgmi_migrate_enabled(adev);
+}
+
 static inline bool gmc_v9_0_is_multi_chiplet(struct amdgpu_device *adev)
 {
 	return !!adev->aid_mask;
@@ -1726,7 +1731,7 @@ static void gmc_v9_0_vram_gtt_location(struct amdgpu_device *adev,
 
 	/* add the xgmi offset of the physical node */
 	base += adev->gmc.xgmi.physical_node_id * adev->gmc.xgmi.node_segment_size;
-	if (adev->gmc.xgmi.connected_to_cpu) {
+	if (amdgpu_gmc_is_pdb0_enabled(adev)) {
 		amdgpu_gmc_sysvm_location(adev, mc);
 	} else {
 		amdgpu_gmc_vram_location(adev, mc, base);
@@ -1841,7 +1846,7 @@ static int gmc_v9_0_gart_init(struct amdgpu_device *adev)
 		return 0;
 	}
 
-	if (adev->gmc.xgmi.connected_to_cpu) {
+	if (amdgpu_gmc_is_pdb0_enabled(adev)) {
 		adev->gmc.vmid0_page_table_depth = 1;
 		adev->gmc.vmid0_page_table_block_size = 12;
 	} else {
@@ -1867,7 +1872,7 @@ static int gmc_v9_0_gart_init(struct amdgpu_device *adev)
 		if (r)
 			return r;
 
-		if (adev->gmc.xgmi.connected_to_cpu)
+		if (amdgpu_gmc_is_pdb0_enabled(adev))
 			r = amdgpu_gmc_pdb0_alloc(adev);
 	}
 
@@ -2372,7 +2377,7 @@ static int gmc_v9_0_gart_enable(struct amdgpu_device *adev)
 {
 	int r;
 
-	if (adev->gmc.xgmi.connected_to_cpu)
+	if (amdgpu_gmc_is_pdb0_enabled(adev))
 		amdgpu_gmc_init_pdb0(adev);
 
 	if (adev->gart.bo == NULL) {
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
index 84cde1239ee4..2e3d0db9bc24 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
@@ -78,6 +78,8 @@ static void mmhub_v1_8_init_gart_aperture_regs(struct amdgpu_device *adev)
 	uint64_t pt_base;
 	u32 inst_mask;
 	int i;
+	uint64_t gart_start = amdgpu_virt_xgmi_migrate_enabled(adev) ?
+			adev->gmc.vram_start : adev->gmc.fb_start;
 
 	if (adev->gmc.pdb0_bo)
 		pt_base = amdgpu_gmc_pd_addr(adev->gmc.pdb0_bo);
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

