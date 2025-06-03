Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14852C5B549
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Jun 2025 02:20:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0C3E10E5A3;
	Tue,  3 Jun 2025 02:20:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="g3yca3GQ";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 045AB10E5A1
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Jun 2025 02:20:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KIqZ+Wjlaj7Pte1EmU34rt4omFFTIunUjOMl/2jC4zoh2E5txO3glYiP1iygqHkgKgv4x+Udt1/0zi1LDBq/nYssef/uJOP8rXhMok5396zQqEQj6N78+8yTNpFFdUgmnteIhYvUuOVG76IoxIPe3OZgSSkUFv2NexDDATqAUC8/q6prS3etwo5PvROluQt4cha7WcNH2atZ6c3w89sXxEsYRRHH/67m5kG5jeXMWFX6qd30Q2kyT95Vw7JIVE2ysTeBgD2OVnp4DjQM1g7M1s9at5ee9zyDvbcKwBf3YLjQQUkuYeXt7zExDOQVJJtHMuY1uQJoPP5Za0WHqIrlfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=otgpOwZKlhejm8zyeGgqO091Qw16QoqnUOLK9ZmgmXM=;
 b=wNI6Xv2X/LSaIVkayKPPDitgXCULpKjRsaEPGtnNC4vwh0anyTLCrYuYUS9ECIe7So/Us2ntmJhtUYTkNZehqf7m9AM8RO6/SkT5/IaB+IdqPhoiLYNdOGS1PPV2Z/DqBU8fmthwjRAH8HzdTwY8yoEBmVwTigFeJKwMhQ67GCjUK/5utsFa2u7Olk6PYSJkmZl8fGdttvEpE9c8VyF07aEJ/Q9Jh9G9qwf596S0JKXCl05O3fx9C4pxnFQZWEQAh0BbabC70ZIDcCLVyhFLmzzPiEsIZrfeYPt7ouUV14VVv4eYaFxRXg3kH7LtRQ1w1kUumlt+OZHD+rPR4ggdkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=otgpOwZKlhejm8zyeGgqO091Qw16QoqnUOLK9ZmgmXM=;
 b=g3yca3GQTGmBswv70Urpl0bp3AtI1R+Yyl9Ca/5aZlOuxnnD3VpKpLY3QOTLsPwOdVgEMQiQ2vCaaTSYZRssIQ3zj2zuou8YAEIlgzdd6qNyQLJB4zBlUZsaXCtn+YWdjubrUn58EV3tlN5P0eaEbl+RAvIiSHYfdYSq52oqzPk=
Received: from CH2PR04CA0017.namprd04.prod.outlook.com (2603:10b6:610:52::27)
 by DM4PR12MB6279.namprd12.prod.outlook.com (2603:10b6:8:a3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Tue, 3 Jun
 2025 02:20:00 +0000
Received: from CH2PEPF0000009B.namprd02.prod.outlook.com
 (2603:10b6:610:52:cafe::1b) by CH2PR04CA0017.outlook.office365.com
 (2603:10b6:610:52::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.21 via Frontend Transport; Tue,
 3 Jun 2025 02:19:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH2PEPF0000009B.mail.protection.outlook.com (10.167.244.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Tue, 3 Jun 2025 02:19:59 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Jun
 2025 21:19:43 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Jun
 2025 21:19:42 -0500
Received: from hjbog-srdc-17.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 2 Jun 2025 21:19:40 -0500
From: Samuel Zhang <guoqing.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <victor.zhao@amd.com>, <haijun.chang@amd.com>, <guoqing.zhang@amd.com>,
 <Christian.Koenig@amd.com>, <Alexander.Deucher@amd.com>,
 <Owen.Zhang2@amd.com>, <Qing.Ma@amd.com>, <Lijo.Lazar@amd.com>,
 <Emily.Deng@amd.com>
Subject: [PATCH v10 3/4] drm/amdgpu: enable pdb0 for hibernation on SRIOV
Date: Tue, 3 Jun 2025 10:19:08 +0800
Message-ID: <20250603021909.841690-4-guoqing.zhang@amd.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250603021909.841690-1-guoqing.zhang@amd.com>
References: <20250603021909.841690-1-guoqing.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: guoqing.zhang@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009B:EE_|DM4PR12MB6279:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b0c512b-8b8e-45d6-c478-08dda2452429
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zpKdjnPJQ4jYUDWqDE/qSZnTX5qXLLocmmSEwpUZRCAEj5t6JL/XOwol/W1P?=
 =?us-ascii?Q?62wpRQgMbl54q/IeE/ZcCnRTdl5UjdaWf5mpoOAQ6xDSEFGxDdw0iYAtoEw5?=
 =?us-ascii?Q?hno9D4bcym4FSI12+z1d1qaw2eqa68osez25ktpDhsWhnE+jndnMgtsh5/VH?=
 =?us-ascii?Q?zKt8neKFWtBDsk1E3N71BZ75EIOYMX85VzMnC6GUby6OmckldVFjA1ZHlzPm?=
 =?us-ascii?Q?18XiNIiWnsrlmMNLP8kYAD9sCw8LE4QKqfoML+Is6eUbozJNhpwO0oTK7mtR?=
 =?us-ascii?Q?BQSeu4eAp3JcL85klgiwMQXsCRoKUctBlzumbnfr624ejLsH4oC+Q78VsOes?=
 =?us-ascii?Q?/SUsiPxB1F4eyTA2qaG32d5ln9wLKRPvoGA29TcsaGunoxzpe6xgeHN60Rnu?=
 =?us-ascii?Q?P1834Q3nbEbnONzyWRfp/955IOlsSV8mxMCc//HIskHbSK7QyuUlfC76JFjj?=
 =?us-ascii?Q?oFXlih2eWbDu25969yuNoTvkOTEGDRRjr7chlOyxDtMXSejewsU4He5nzqh3?=
 =?us-ascii?Q?edTdrQqurJZF9Y2JcbuMPe0pEkC18OOfXUehbZbBTP9BR+Aug3SiUTiK70aU?=
 =?us-ascii?Q?RUtg9E48mMkyJPlfErTnXSHsQuy1gsvTe8Ez0q+MkMMhfZY4I90cSOdvdbkx?=
 =?us-ascii?Q?cwcnNzUJ36dyQJZXeg4rIC4zCvYxk9qOXCkddUPe8pQZhRArVc2/yibjrN0u?=
 =?us-ascii?Q?quPrV4HaUUCvAz4OBYXGhtmYUOetfvfom4Sr4USf+UtIzPNrJCzGtOjqQTWU?=
 =?us-ascii?Q?vDpW4KqhUBK1+S2Ee76XXdnw0TeyqrA4lseifBanYk4BmpcoQMhb9wbCnnnT?=
 =?us-ascii?Q?3F2D/GORvd3hp+DpjJVTOkzwq3sc6IqxQlv0AOYLzUaGfiP1K0VKsGPPLgjz?=
 =?us-ascii?Q?84sxmy3L2t/XiMayGM6yEYAAhItps+whLwmjEaKfmQZ5gcqqf/JAlH+XnGMS?=
 =?us-ascii?Q?2336RSyNl84YlWSSSdUBdSfmAY4RfsyaZdYbKJv0s+a744V05iYiYef+K1C2?=
 =?us-ascii?Q?XouMbn+9cbyDsNMw6U1036BAi/krUvdtIP5vYiHnoIvFES3CuZDkXD8bju1o?=
 =?us-ascii?Q?jzASDz4aC2+rsU39cOmmwkLbkp7rbIq31Q3WaD8vTgLzhN1EywrnnrHJ4mRe?=
 =?us-ascii?Q?cp4gENAz6bcpMos0f752EUAehQusE3A5wvyUMvNeXVzYX7k+Q58S/+uw9Mj+?=
 =?us-ascii?Q?5iUF+k0QXKgTAB8qJHosWssm424AnD7WK3B8FBiuXH+uxEx1IQ/B9mBy1TRD?=
 =?us-ascii?Q?hcqrcyLlbzZbODUomw+Ac9ZDXIYNGyKVjaL8AHKFzyzqRbbn2+grkzAJO4Bt?=
 =?us-ascii?Q?CLUt+n8j/W1MqVnm38DtwuVGcI/tgL7ZIWs6+Wg7G2QpUyv5Z4vcavl5Um9Y?=
 =?us-ascii?Q?hTvr51SUEzMBRlct2zKUD8H4kmt2Bv50wGTaMWbaTPiTE4XWbJwHhhc/ggz5?=
 =?us-ascii?Q?r7eY5Gke6a8a/P2Cx3soJsNAV6spmYlut1p9FWNa7KkLu+JGj15ktw08+v6c?=
 =?us-ascii?Q?rhxcDY3Fb9DVs74ARZ0AVOXRO7z5qtOtgSAZ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 02:19:59.9081 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b0c512b-8b8e-45d6-c478-08dda2452429
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6279
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
index cb25f7f0dfc1..6c03bf9f1ae8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
@@ -74,6 +74,8 @@ static void gfxhub_v1_2_setup_vm_pt_regs(struct amdgpu_device *adev,
 static void gfxhub_v1_2_xcc_init_gart_aperture_regs(struct amdgpu_device *adev,
 						    uint32_t xcc_mask)
 {
+	uint64_t gart_start = amdgpu_virt_xgmi_migrate_enabled(adev) ?
+			adev->gmc.vram_start : adev->gmc.fb_start;
 	uint64_t pt_base;
 	int i;
 
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

