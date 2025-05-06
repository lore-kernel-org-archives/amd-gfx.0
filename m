Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F37FC3ABAC
	for <amd-gfx@archiver.kernel.org>; Tue,  6 May 2025 09:38:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39C4010E63E;
	Tue,  6 May 2025 09:38:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ty4uQADd";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2048.outbound.protection.outlook.com [40.107.102.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D03B10E638
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 May 2025 09:38:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hsMgQS2PAS/Rr/Cq6L/ZCjgbIEf3n5dt2UttoepdKDwAqihPauOPAgvzs010DMf5hI2BSDlHh95zNw8GkiPjsb7x1wm6BbPFh+OjIB7AkDhPftNmn4L23ONadr+snsAZcuIABwop+PkLaXQr3AH5SV40WEQ4udlQcXsTbwcHJefav4dwvaZmkj32Wkh0/Pk/uNGZTav2wzRaD0avSwyM9jQzvsdzPwMocH3e3WbIfA0s2gyBJaZlN1ZFRA3WXKxHQzKJMobGcdms7D74emWS6islSkXjnSDc+ABco43dzmwVjqykly58c5hJ9JQ7alapeuOpdJIZC4a5dGg5RIrvfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2lMwsU/YSgOR8m0pku6SqKYdlB5K+6pv2S/GJ4/GcP8=;
 b=IE4PyAJBovUOxLnvJIzjCh8YHTWIf9E9AgJZF1K0IIKTYogJ8vilGOUztuaKc1y5UYE9uimhHaHP4kyVqYMMiXLfrQqlN6cSbsycjl1uzav+t0p3987EnQPAAEhkEtu7pQJKlvgdESwCfTXHBKNiHaeNv6TIN1YCdliz4Ni8MjxjW+u40OA98jfYTmSVhfJSC/2Wr9RCa8jTbGMeOxOMUWrFwLzozE/+yZ5V5s6ASlRyL4F2k1i9JCWPFgeWiPD6/6wIEEgHRCqec3sGGocHDHKQa5A71i0CjAtSuJ1mQdlc1C45ZjbAZKEIfsOjdumwHOhPXKqEFwGCHdFMAzz38w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2lMwsU/YSgOR8m0pku6SqKYdlB5K+6pv2S/GJ4/GcP8=;
 b=Ty4uQADd3LynugP/+mcv6C65VSsDcXPQBO8Nr51EaVJ7P7W0Y0gBrXzgHqdI2CJhkawpOqJclbIYqjI4ezjK/r3zR3OxKuye9OzAX3GWIcWbnAvH+YsUsyZUKMSXSC5nc+zffoS4lI/2us97reveBo4L4NlUEANHLPqhXsFEGyY=
Received: from DM6PR10CA0031.namprd10.prod.outlook.com (2603:10b6:5:60::44) by
 LV2PR12MB5942.namprd12.prod.outlook.com (2603:10b6:408:171::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Tue, 6 May
 2025 09:38:14 +0000
Received: from DS1PEPF00017094.namprd03.prod.outlook.com
 (2603:10b6:5:60:cafe::c3) by DM6PR10CA0031.outlook.office365.com
 (2603:10b6:5:60::44) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.30 via Frontend Transport; Tue,
 6 May 2025 09:38:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017094.mail.protection.outlook.com (10.167.17.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Tue, 6 May 2025 09:38:13 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 6 May
 2025 04:38:12 -0500
Received: from hjbog-srdc-17.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 6 May 2025 04:38:10 -0500
From: Samuel Zhang <guoqing.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <victor.zhao@amd.com>, <haijun.chang@amd.com>, <guoqing.zhang@amd.com>,
 <Christian.Koenig@amd.com>, <Alexander.Deucher@amd.com>,
 <Owen.Zhang2@amd.com>, <Qing.Ma@amd.com>, Emily Deng <Emily.Deng@amd.com>
Subject: [PATCH v3 3/7] drm/amdgpu: enable pdb0 for hibernation on SRIOV
Date: Tue, 6 May 2025 17:36:25 +0800
Message-ID: <20250506093629.249792-3-guoqing.zhang@amd.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250506093629.249792-1-guoqing.zhang@amd.com>
References: <20250506093629.249792-1-guoqing.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: guoqing.zhang@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017094:EE_|LV2PR12MB5942:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bf18ac7-33db-4365-edec-08dd8c81b8c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GMSeQwYXYRID6I5V6RB2/TCgZ905O7O1qDMFcN3Rsy/82Ix0nPyWEeTKY8Ll?=
 =?us-ascii?Q?4Z/A9rNtmCMXHhf9pBIKApFxJShdLJjFEP1M/qcUNNl+YbYYahFEK7SRSS0q?=
 =?us-ascii?Q?yisQbO9i6/eJkFEOvR2+EEd5AndxWvTgySlnKY59rGTKRyNrTKGBWSyZuDgh?=
 =?us-ascii?Q?iqKzuykhAJ3Wvn4IA/0BupuL9s0InYtbSUkT5hHWtY2XjwwefJ+rZjrurfpG?=
 =?us-ascii?Q?i7QiThFlYBHaa7/8nDNM31nhVoY0Ui4MwqnC1DUsC/SvjGmKQsqc3J87Dfq+?=
 =?us-ascii?Q?2ejlx5FQ35MAQKCYSl70P5FpqnIVywweLiL20TDNwL/Ji76skG0aRXcnVboL?=
 =?us-ascii?Q?U7Rn0M+4Nzz/104hQLbkwDlawapbjjiQ6xHo7Prk1NRikD0E+8k56TTpEmKl?=
 =?us-ascii?Q?NYHeM+a2zpsWGTxCyNrRg8BrOecfOZCHmh9wDcVGrCjG5aUeCpIJ7vLhuIf+?=
 =?us-ascii?Q?V8H0BmSkNPEaNcwCvH1UIIEhTKKV/bmF3atIbIReYnTDYciwlrXTCRZT88zB?=
 =?us-ascii?Q?uAPNVlQXQTVQmOaYYAXV6lFlK7wnL//IPt+fAtpJFh3s4Toce7W3emSBFSSC?=
 =?us-ascii?Q?YQd66ezXTxW6kemiGXHI+AsSSUp2b8WwCPejJMT9NOcHETeXoThYC0SsmqPo?=
 =?us-ascii?Q?uAxGcG3SNmaJDiYQKyomk9Zwt4hKCDrR8FjxZcFYwO6yagDu6NDQxUtEsBpX?=
 =?us-ascii?Q?PzP1dbehI/gUopqmFCS/tjUYhWmA6dlwmCrRf8KD1s0KHY+dy4cmJUFij6fD?=
 =?us-ascii?Q?5GujHsgtR1iGY8SNOMnZdwEApGA7WGM/s+iTZCoiet0L4YMMiyYSlX30Yy/i?=
 =?us-ascii?Q?++jSNOCwrmhwY0Cm7y7JV2Y5UgxHr4bEnNjCJomYWUwneSQl4yT3fDD3LVhP?=
 =?us-ascii?Q?kAI/ycwdHELM9xsQFi1B7QVvFv+GSly43W1mqAar9MUNo4N/2v6CBmLG6YKv?=
 =?us-ascii?Q?2/y0/WPQ6LN35v7DBA0PBgYG6hhcHDdcCITV+7XheVNq+zjtd+m7Xf4r1v5j?=
 =?us-ascii?Q?kvpM4oTuYkYYH3AoY6g1JP/T7qz3ZqKXuisKX/cU6pGFRrkHslBOwRtyO2aD?=
 =?us-ascii?Q?oh2oqmHQDl4DKTY5yLLOzn52jLE9QhRwbtq1sHiZI7sEv5E8sVWwEqXxBxX4?=
 =?us-ascii?Q?mzk/m1b/TIsOpaQaBTxUQX7mLxSoU+b9R+/c9MV8oG8fGPS3Jqaltv/VWaeL?=
 =?us-ascii?Q?lN8XvzjgJlPAkk1w6hX6u7QUk3P6dyTBSMMOkZfMtKOkUv9QJtwarSukO6SD?=
 =?us-ascii?Q?Ivv9n75F2AH8iA8jIIxeIIuhZZQrRj/1f0zQ/vjFwhQLTNcHneefJ0TIJzxS?=
 =?us-ascii?Q?eBm7GcbLqZA8kndi9CQKPMrWCPsxoujf/wm/fKjXcCj0s5ktV6Wx3h8eyBqj?=
 =?us-ascii?Q?vO3YFDcph1m1+4251eQWIe8X6GEyDg/fo9dCLfPTjxm1hdAfYfd0tBjfdoZe?=
 =?us-ascii?Q?5RsOQL46LjWr0hOu76DbpMygWeIdbYyTc9KKIRxs8vHfrBLgQRV8WCgOone0?=
 =?us-ascii?Q?VTgvQEiTNc3DrVJ5wVgOQaLnO5gpsFVtvKdx?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 09:38:13.4299 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bf18ac7-33db-4365-edec-08dd8c81b8c5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017094.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5942
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c  | 32 ++++++++++++++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h  |  1 +
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c    | 13 +++++++---
 4 files changed, 36 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index a2abddf3c110..e9b775dfc6f1 100644
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
@@ -249,15 +251,24 @@ void amdgpu_gmc_sysvm_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc
 {
 	u64 hive_vram_start = 0;
 	u64 hive_vram_end = mc->xgmi.node_segment_size * mc->xgmi.num_physical_nodes - 1;
-	mc->vram_start = mc->xgmi.node_segment_size * mc->xgmi.physical_node_id;
-	mc->vram_end = mc->vram_start + mc->xgmi.node_segment_size - 1;
-	mc->gart_start = hive_vram_end + 1;
+
+	if (adev->gmc.xgmi.connected_to_cpu) {
+		mc->vram_start = mc->xgmi.node_segment_size * mc->xgmi.physical_node_id;
+		mc->vram_end = mc->vram_start + mc->xgmi.node_segment_size - 1;
+		dev_info(adev->dev, "VRAM: %lluM 0x%016llX - 0x%016llX (%lluM used)\n",
+				mc->mc_vram_size >> 20, mc->vram_start,
+				mc->vram_end, mc->real_vram_size >> 20);
+	} else {
+		/* set mc->vram_start to 0 to switch the returned GPU address of
+		 * amdgpu_bo_create_reserved() from FB aperture to GART aperture.
+		 */
+		amdgpu_gmc_vram_location(adev, mc, 0);
+	}
+	/* node_segment_size may not 4GB aligned on SRIOV, align up is needed. */
+	mc->gart_start = ALIGN(hive_vram_end + 1, four_gb);
 	mc->gart_end = mc->gart_start + mc->gart_size - 1;
 	mc->fb_start = hive_vram_start;
 	mc->fb_end = hive_vram_end;
-	dev_info(adev->dev, "VRAM: %lluM 0x%016llX - 0x%016llX (%lluM used)\n",
-			mc->mc_vram_size >> 20, mc->vram_start,
-			mc->vram_end, mc->real_vram_size >> 20);
 	dev_info(adev->dev, "GART: %lluM 0x%016llX - 0x%016llX\n",
 			mc->gart_size >> 20, mc->gart_start, mc->gart_end);
 }
@@ -276,7 +287,6 @@ void amdgpu_gmc_sysvm_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc
 void amdgpu_gmc_gart_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc,
 			      enum amdgpu_gart_placement gart_placement)
 {
-	const uint64_t four_gb = 0x100000000ULL;
 	u64 size_af, size_bf;
 	/*To avoid the hole, limit the max mc address to AMDGPU_GMC_HOLE_START*/
 	u64 max_mc_address = min(adev->gmc.mc_mask, AMDGPU_GMC_HOLE_START - 1);
@@ -1068,6 +1078,14 @@ void amdgpu_gmc_init_pdb0(struct amdgpu_device *adev)
 	flags |= AMDGPU_PTE_FRAG((adev->gmc.vmid0_page_table_block_size + 9*1));
 	flags |= AMDGPU_PDE_PTE_FLAG(adev);
 
+	if (!adev->gmc.xgmi.connected_to_cpu) {
+		/* always start from current device so that the GART address can keep
+		 * consistent when hibernate-resume with different GPUs.
+		 */
+		vram_addr = adev->vm_manager.vram_base_offset;
+		vram_end = vram_addr + vram_size;
+	}
+
 	/* The first n PDE0 entries are used as PTE,
 	 * pointing to vram
 	 */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index bd7fc123b8f9..758b47240c6f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -307,6 +307,7 @@ struct amdgpu_gmc {
 	struct amdgpu_bo		*pdb0_bo;
 	/* CPU kmapped address of pdb0*/
 	void				*ptr_pdb0;
+	bool enable_pdb0;
 
 	/* MALL size */
 	u64 mall_size;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
index cb25f7f0dfc1..5ebb92ac9fd7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
@@ -180,7 +180,7 @@ gfxhub_v1_2_xcc_init_system_aperture_regs(struct amdgpu_device *adev,
 		/* In the case squeezing vram into GART aperture, we don't use
 		 * FB aperture and AGP aperture. Disable them.
 		 */
-		if (adev->gmc.pdb0_bo) {
+		if (adev->gmc.pdb0_bo && !amdgpu_sriov_vf(adev)) {
 			WREG32_SOC15(GC, GET_INST(GC, i), regMC_VM_FB_LOCATION_TOP, 0);
 			WREG32_SOC15(GC, GET_INST(GC, i), regMC_VM_FB_LOCATION_BASE, 0x00FFFFFF);
 			WREG32_SOC15(GC, GET_INST(GC, i), regMC_VM_AGP_TOP, 0);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 1eb451a3743b..7f2b0f3d0ddb 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1682,6 +1682,11 @@ static int gmc_v9_0_early_init(struct amdgpu_ip_block *ip_block)
 		adev->gmc.private_aperture_start + (4ULL << 30) - 1;
 	adev->gmc.noretry_flags = AMDGPU_VM_NORETRY_FLAGS_TF;
 
+	adev->gmc.enable_pdb0 = adev->gmc.xgmi.connected_to_cpu;
+	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) ||
+	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4) ||
+	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 5, 0))
+	    adev->gmc.enable_pdb0 = amdgpu_sriov_vf(adev);
 	return 0;
 }
 
@@ -1726,7 +1731,7 @@ static void gmc_v9_0_vram_gtt_location(struct amdgpu_device *adev,
 
 	/* add the xgmi offset of the physical node */
 	base += adev->gmc.xgmi.physical_node_id * adev->gmc.xgmi.node_segment_size;
-	if (adev->gmc.xgmi.connected_to_cpu) {
+	if (adev->gmc.enable_pdb0) {
 		amdgpu_gmc_sysvm_location(adev, mc);
 	} else {
 		amdgpu_gmc_vram_location(adev, mc, base);
@@ -1841,7 +1846,7 @@ static int gmc_v9_0_gart_init(struct amdgpu_device *adev)
 		return 0;
 	}
 
-	if (adev->gmc.xgmi.connected_to_cpu) {
+	if (adev->gmc.enable_pdb0) {
 		adev->gmc.vmid0_page_table_depth = 1;
 		adev->gmc.vmid0_page_table_block_size = 12;
 	} else {
@@ -1867,7 +1872,7 @@ static int gmc_v9_0_gart_init(struct amdgpu_device *adev)
 		if (r)
 			return r;
 
-		if (adev->gmc.xgmi.connected_to_cpu)
+		if (adev->gmc.enable_pdb0)
 			r = amdgpu_gmc_pdb0_alloc(adev);
 	}
 
@@ -2372,7 +2377,7 @@ static int gmc_v9_0_gart_enable(struct amdgpu_device *adev)
 {
 	int r;
 
-	if (adev->gmc.xgmi.connected_to_cpu)
+	if (adev->gmc.enable_pdb0)
 		amdgpu_gmc_init_pdb0(adev);
 
 	if (adev->gart.bo == NULL) {
-- 
2.43.5

