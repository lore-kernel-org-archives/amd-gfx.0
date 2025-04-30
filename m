Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6B4EC369DC
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Apr 2025 10:19:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44B4B10E728;
	Wed, 30 Apr 2025 10:19:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5CLSUKiB";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2071.outbound.protection.outlook.com [40.107.102.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCB6D10E724
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Apr 2025 10:19:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vpQM7l+9Rlph+t31QhovXSgBW8i2QFEpw/6NNkpN/tAZ8H98MHlkj1aFco03zU0HTUea7ZKKMFQxc7nrMcP3Ipq0MMfXuwPRbkJCFENL0Oar2TPifXojs1DLCyREErldUgf3Eh7HKJ1b8hagg9V52IBA99ixCPZDYWGT8pbj0IomG1hZMa9+KReacT45FoqLj5qPAaYUFUEy3LQxpUHUGMidTPmRhEOQVxe7TGPRXzO41rx/4evDkBP5AxPma3McFdHt1DeP8Dt8m6LywShPHrQvxUuulyJLPzcJFGFZ18c1rL9Xw9I6LxpQUJXxY6ahu6ayMMvHS/uRdUllb0Nx2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m/1UbCEsw5tzM+El19Q63jN2soTh93sWrmrUbFcTe0A=;
 b=ldd5Nz/G4pP9zAF933pBL5Dq39dH1qHubj1znMyrcx1buT3Miay3DhjNR1GS8mHBcZTi0Ox+wZj+50C/349Emj0CZeIROag5UdEe/HMFSzqOJj9lApyJDnxTc0yVpUVF7tOO50JD2bRxhXBYQDt2PyuTO4vNc8g4zt88zeeyyio9dQ/iNnPTmzk3hJFFBOdXQqvMC4fTVjnfO6am570IjjNXOK0Rf8KK3s/iQpkSI1KQVwfBL44b7MenkquG2O1B5kyPpWZg9tUPm1wnyOPuhzB88+XNYeZ0nf+GAn37g6sQt7n/w0gNoRZAQw12uGWdbdPQ03R+wVYXE10lEYPz1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m/1UbCEsw5tzM+El19Q63jN2soTh93sWrmrUbFcTe0A=;
 b=5CLSUKiBEOgBhRPa0G+T/cL2Qba2O03wWnAzkTxqUCDXiulLXXVsOVCK2FUeUUMZIkHptRluOhKSmWEVlXaM2L8hkKWSYTkS2bm/E1WTlsl2/oeynKvdzDREOs+3kPwk9mCVvDyw3MXFlj3E/6vpASFEqEWoSM05OKLDWNi+WxQ=
Received: from CH0P221CA0028.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::10)
 by SA1PR12MB7365.namprd12.prod.outlook.com (2603:10b6:806:2ba::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Wed, 30 Apr
 2025 10:19:08 +0000
Received: from CH2PEPF00000149.namprd02.prod.outlook.com
 (2603:10b6:610:11d:cafe::5b) by CH0P221CA0028.outlook.office365.com
 (2603:10b6:610:11d::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.41 via Frontend Transport; Wed,
 30 Apr 2025 10:19:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH2PEPF00000149.mail.protection.outlook.com (10.167.244.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8699.20 via Frontend Transport; Wed, 30 Apr 2025 10:19:08 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Apr
 2025 05:19:07 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Apr
 2025 05:19:07 -0500
Received: from hjbog17.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 30 Apr 2025 05:19:05 -0500
From: Samuel Zhang <guoqing.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <victor.zhao@amd.com>, <haijun.chang@amd.com>, <guoqing.zhang@amd.com>,
 <Christian.Koenig@amd.com>, <Alexander.Deucher@amd.com>, Emily Deng
 <Emily.Deng@amd.com>
Subject: [PATCH v2 3/3] drm/amdgpu: enable pdb0 for hibernation on SRIOV
Date: Wed, 30 Apr 2025 18:16:38 +0800
Message-ID: <20250430101638.649274-4-guoqing.zhang@amd.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250430101638.649274-1-guoqing.zhang@amd.com>
References: <20250430101638.649274-1-guoqing.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: guoqing.zhang@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000149:EE_|SA1PR12MB7365:EE_
X-MS-Office365-Filtering-Correlation-Id: dfe53d31-8fc7-4063-323e-08dd87d07170
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JZ/diClqASL6tcHcpHijDH3PnVmJJZA+f7fJi7MGwlCt+46ftbktg4B6V6Ku?=
 =?us-ascii?Q?VYrsvC/ZbeDfbv7oLBDYGwE53WpiqlXtH5GGhfcPMPecSdRterJkyK/zUVg5?=
 =?us-ascii?Q?1BAp4E2RC15c2i2xK1cNXbpIMX255zhmRf2sJtFBOM9YW8Mg/J3Md7Zn4MyW?=
 =?us-ascii?Q?MbF9tTNxad7TlJZNQSz4VzGga3VHWGjziv8na6R6eXpZCVr8fIeWRjcqozqa?=
 =?us-ascii?Q?9/UQMXRcj/2SpTc31xHVAGVeyvuUbbhphfdGe/hZRlAV7mihpvag3JGbGF+z?=
 =?us-ascii?Q?VxlGpvALpaEX8luxfJkdIb+p463ZLl9AeNRvFUjzXi8Ut0L/AMcHTcBycUiY?=
 =?us-ascii?Q?P4fri5HnHnbcuZYLMMmpUx3YmVVR5VgG7a/gC3nl42f1E9GwQbO8zqPbX0x1?=
 =?us-ascii?Q?cGCuRKbD6WoXurOsqjufOINauiL3ZuD9s4/6Mo/XFsOrMiAEvrNq0fs6WNO9?=
 =?us-ascii?Q?BiLOdlB73imEkBy/FtQuGNaHgApKnGxEXFmYaoKoYwHk5cmUn2GKfz3BzygG?=
 =?us-ascii?Q?liPaXW14W1+dnGkR+/FpbEs45tV9GWnxq688FSn27LsB0eoPuDrqFpPCA8Sk?=
 =?us-ascii?Q?Pil7BYyeJfSFS3Srx4HgmUWRU7LkhJYDwfwKVfmiz+HM4AkCdoQgVxBs+Eya?=
 =?us-ascii?Q?dxhI82LlD7/9iFFbmSgNPrqDYuDySZPK6zkhPq9sRH3jcJJicbp/GuNRFN0m?=
 =?us-ascii?Q?/Z5/KMOlBo4Yp9AtBDIX6hiB5H8NADq2AXBnYnOFryIuC/MDpWO35vsXf3of?=
 =?us-ascii?Q?qMypDSWMPYNhMDPNPyAFY4F+0WdcHNhYXAP98m+qTc8fUMovvjMhzWcQsKsr?=
 =?us-ascii?Q?WscTGPFK76jKtSoUR7Fe8NUec70Du+7Aub3BCTkUUyIClKUuEkYtmyki1NzM?=
 =?us-ascii?Q?Z/E3+g5bbN6BVGChCJLB+c0uSdii1j2qaGScVOKxtw+XDwXnPEMMwMbBdIMs?=
 =?us-ascii?Q?lRR+Sh5685CRpGKaCdLCke7dhLXHYCv8h+tpobmySnd4xalrAkxYkXDQY99D?=
 =?us-ascii?Q?+5pCkZz40iFWsoX0gRVRPJYh3d+t/koi7L8JdWeO9nYmHoSqGI5uG0lsjHTE?=
 =?us-ascii?Q?TKkTL2LQfHs5DX3TzTNd/jtUnvbHTFjdWlDZ4wX8fTghm61fgx4hoNdX4zVo?=
 =?us-ascii?Q?FoKPCXgb1pvDhO1EVSRX0qekRND5dJ7W2X+b5gs8x+gBcAEgBkgtPz+l7kb9?=
 =?us-ascii?Q?KhifpOwoLbRiENujW5q0V8kIxWORg+1SOURrwbUWJ7ba2PkNq+3wzCHVpPc9?=
 =?us-ascii?Q?miFihvpSEdtpEFdxUGClGuNmmwtRGCGSUVhr8MAw6LdrFc0Dy7T71wdwKzn5?=
 =?us-ascii?Q?EwtTMqUfjGxSm7SQ7g8T/5rMM70BatuAraTWfEm+3drILSqAgCxpq3yZNRd9?=
 =?us-ascii?Q?2/tW48XuyyncDaj/f50rq6/di7vck6U50zzlZBid2Q0JRR0+crkzkjSXniAq?=
 =?us-ascii?Q?GaQHEsUwthzZ0ik3bFf7S2z2uhsYKIX/5nrXD5IMF4MYvTbYI+jjyJBO/U42?=
 =?us-ascii?Q?sgexlJ8yH17R236G10JtAaKGLPXKJuM5W2GH?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 10:19:08.1941 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dfe53d31-8fc7-4063-323e-08dd87d07170
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000149.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7365
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c  | 42 ++++++++++++++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h  |  1 +
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c    | 16 ++++++---
 4 files changed, 46 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index ef6eaddc2ccb..3b3f9843ef7a 100644
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
@@ -250,15 +252,26 @@ void amdgpu_gmc_sysvm_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc
 {
 	u64 hive_vram_start = 0;
 	u64 hive_vram_end = mc->xgmi.node_segment_size * mc->xgmi.num_physical_nodes - 1;
-	mc->vram_start = mc->xgmi.node_segment_size * mc->xgmi.physical_node_id;
-	mc->vram_end = mc->vram_start + mc->xgmi.node_segment_size - 1;
+
+	if (adev->gmc.xgmi.connected_to_cpu) {
+		mc->vram_start = mc->xgmi.node_segment_size * mc->xgmi.physical_node_id;
+		mc->vram_end = mc->vram_start + mc->xgmi.node_segment_size - 1;
+		dev_info(adev->dev, "VRAM: %lluM 0x%016llX - 0x%016llX (%lluM used)\n",
+				mc->mc_vram_size >> 20, mc->vram_start,
+				mc->vram_end, mc->real_vram_size >> 20);
+	} else {
+		/* reset vram_start to 0 to switch the returned GPU address of
+		 * amdgpu_bo_create_reserved() from FB aperture to GART aperture.
+		 */
+		mc->vram_start = 0;
+		hive_vram_end = ALIGN(hive_vram_end + 1, four_gb) - 1;
+	}
+
 	mc->gart_start = hive_vram_end + 1;
 	mc->gart_end = mc->gart_start + mc->gart_size - 1;
 	mc->fb_start = hive_vram_start;
 	mc->fb_end = hive_vram_end;
-	dev_info(adev->dev, "VRAM: %lluM 0x%016llX - 0x%016llX (%lluM used)\n",
-			mc->mc_vram_size >> 20, mc->vram_start,
-			mc->vram_end, mc->real_vram_size >> 20);
+
 	dev_info(adev->dev, "GART: %lluM 0x%016llX - 0x%016llX\n",
 			mc->gart_size >> 20, mc->gart_start, mc->gart_end);
 }
@@ -277,7 +290,6 @@ void amdgpu_gmc_sysvm_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc
 void amdgpu_gmc_gart_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc,
 			      enum amdgpu_gart_placement gart_placement)
 {
-	const uint64_t four_gb = 0x100000000ULL;
 	u64 size_af, size_bf;
 	/*To avoid the hole, limit the max mc address to AMDGPU_GMC_HOLE_START*/
 	u64 max_mc_address = min(adev->gmc.mc_mask, AMDGPU_GMC_HOLE_START - 1);
@@ -678,8 +690,7 @@ void amdgpu_gmc_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 				     &job);
 	if (r)
 		goto error_alloc;
-
-	job->vm_pd_addr = amdgpu_gmc_pd_addr(adev->gart.bo);
+	job->vm_pd_addr = amdgpu_gmc_pd_addr(adev->gmc.pdb0_bo ?: adev->gart.bo);
 	job->vm_needs_flush = true;
 	job->ibs->ptr[job->ibs->length_dw++] = ring->funcs->nop;
 	amdgpu_ring_pad_ib(ring, &job->ibs[0]);
@@ -1057,6 +1068,7 @@ void amdgpu_gmc_init_pdb0(struct amdgpu_device *adev)
 	u64 vram_addr = adev->vm_manager.vram_base_offset -
 		adev->gmc.xgmi.physical_node_id * adev->gmc.xgmi.node_segment_size;
 	u64 vram_end = vram_addr + vram_size;
+	u64 vram_last = vram_end, vram_pa;
 	u64 gart_ptb_gpu_pa = amdgpu_gmc_vram_pa(adev, adev->gart.bo);
 	int idx;
 
@@ -1069,11 +1081,21 @@ void amdgpu_gmc_init_pdb0(struct amdgpu_device *adev)
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
-	for (i = 0; vram_addr < vram_end; i++, vram_addr += pde0_page_size)
-		amdgpu_gmc_set_pte_pde(adev, adev->gmc.ptr_pdb0, i, vram_addr, flags);
+	for (i = 0; vram_addr < vram_end; i++, vram_addr += pde0_page_size) {
+		vram_pa = (vram_addr >= vram_last) ? (vram_addr - vram_size) : vram_addr;
+		amdgpu_gmc_set_pte_pde(adev, adev->gmc.ptr_pdb0, i, vram_pa, flags);
+	}
 
 	/* The n+1'th PDE0 entry points to a huge
 	 * PTB who has more than 512 entries each
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index 291d96168a57..778c7506bb2d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -308,6 +308,7 @@ struct amdgpu_gmc {
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
index 3c950c75dea1..42c38848763b 100644
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
 
@@ -1730,7 +1735,10 @@ static void gmc_v9_0_vram_gtt_location(struct amdgpu_device *adev,
 		amdgpu_gmc_sysvm_location(adev, mc);
 	} else {
 		amdgpu_gmc_vram_location(adev, mc, base);
-		amdgpu_gmc_gart_location(adev, mc, AMDGPU_GART_PLACEMENT_BEST_FIT);
+		if (adev->gmc.enable_pdb0)
+			amdgpu_gmc_sysvm_location(adev, mc);
+		else
+			amdgpu_gmc_gart_location(adev, mc, AMDGPU_GART_PLACEMENT_BEST_FIT);
 		if (!amdgpu_sriov_vf(adev) && (amdgpu_agp == 1))
 			amdgpu_gmc_agp_location(adev, mc);
 	}
@@ -1841,7 +1849,7 @@ static int gmc_v9_0_gart_init(struct amdgpu_device *adev)
 		return 0;
 	}
 
-	if (adev->gmc.xgmi.connected_to_cpu) {
+	if (adev->gmc.enable_pdb0) {
 		adev->gmc.vmid0_page_table_depth = 1;
 		adev->gmc.vmid0_page_table_block_size = 12;
 	} else {
@@ -1867,7 +1875,7 @@ static int gmc_v9_0_gart_init(struct amdgpu_device *adev)
 		if (r)
 			return r;
 
-		if (adev->gmc.xgmi.connected_to_cpu)
+		if (adev->gmc.enable_pdb0)
 			r = amdgpu_gmc_pdb0_alloc(adev);
 	}
 
@@ -2372,7 +2380,7 @@ static int gmc_v9_0_gart_enable(struct amdgpu_device *adev)
 {
 	int r;
 
-	if (adev->gmc.xgmi.connected_to_cpu)
+	if (adev->gmc.enable_pdb0)
 		amdgpu_gmc_init_pdb0(adev);
 
 	if (adev->gart.bo == NULL) {
-- 
2.43.5

