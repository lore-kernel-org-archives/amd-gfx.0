Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67528C04FF9
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Apr 2024 20:13:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D094D10F84B;
	Fri, 12 Apr 2024 20:13:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4vBRJ3Vx";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2088.outbound.protection.outlook.com [40.107.101.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83FCC10F84B
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Apr 2024 20:13:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V21QYK8f6xuCrpQ9ZXqOR8SIYUkfrQQlyas3hS3eU65qte9657t/2FNxKD3Sb1a7WSzNElAi544oLs+KcsZohgJQfBc4+FH8ejO5fMvh26kGYTvfC6zll26X74Dn8F6Qxhoz/PefFeSdxFomX/g2R1vFRmwhZrmf23W80F4VG0HbX565cfrde4xcf2h12I5gmtUt2iTy77mKSnCDc2AqY9UVyYT3rDxrjwwHY5qnMxlgvFoUM40WJOdhj3VD+1NR56YrHxPijH4Z5GBvfHz4DGPlik6Tt5FosR6xCgaU1hQcuXeOEVsgy7YPZ+5m5uJgA9rLNwb/IdUX8qj/l2XGLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oKHCqqQwb86+q1PtjM7H2JC/fUDtN0D9SmN8JwsCwzk=;
 b=OwyuelQ5HCRZ9g44RhtDJtpSyH43QTKKab4oFTo7GMcXB9syCiejGUmpxlAWkQXiqUX/oTpeWX7CHAXRaRPz3s0lNary/fpZlGuwDgUOEg4iDvs9ErmtzxEH2gkjE1tUJCBA6TyEWxPWUjhXKcAivkQHVJ+r8/TnAyERp3SuTvtEXTXdIsk5lqXA3iQA8I6PirZ3P2Hq435k7zqYGDTasT1SrYphsXlstw3T9yD2CV7mvQ52qD7Fc1gorES4/r6WiVmPiILrn4E/EDfgbRIcNwjr0JjtCVT3JAKdWqQsuGjnTazCfiOKZhW1TYSuOW1tGK/TXXw1JLr6qtZS7wg20Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oKHCqqQwb86+q1PtjM7H2JC/fUDtN0D9SmN8JwsCwzk=;
 b=4vBRJ3VxJR20Hwd+K0wWmzhtDLob44symPtq4z/XUsOuc1LaEC3NYU1VF6KQmHyCmBzP21zE07p78z+AGxAgGcXrS4o6Crl88Xi3j6DamST0AMP0oDu4ETTCbzJhqPFu0qbCqapg2rOWz4odA806Yr3NKELEXGZZSdJsA1lczl4=
Received: from BY5PR04CA0011.namprd04.prod.outlook.com (2603:10b6:a03:1d0::21)
 by CY5PR12MB6480.namprd12.prod.outlook.com (2603:10b6:930:33::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 12 Apr
 2024 20:13:40 +0000
Received: from CO1PEPF000042AA.namprd03.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::3c) by BY5PR04CA0011.outlook.office365.com
 (2603:10b6:a03:1d0::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.26 via Frontend
 Transport; Fri, 12 Apr 2024 20:13:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AA.mail.protection.outlook.com (10.167.243.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Fri, 12 Apr 2024 20:13:40 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 12 Apr
 2024 15:13:38 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>,
 <Arunpravin.PaneerSelvam@amd.com>, Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH 1/6] drm/amdgpu: Support contiguous VRAM allocation
Date: Fri, 12 Apr 2024 16:12:56 -0400
Message-ID: <20240412201301.14154-2-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240412201301.14154-1-Philip.Yang@amd.com>
References: <20240412201301.14154-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AA:EE_|CY5PR12MB6480:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d804de6-bf4e-4b2f-5bae-08dc5b2d0b6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +plMfXOmd/2MJCvO+8DMNfwet3oQmSuNKngHsrfTzJHuAIT0x91wu8hbiCeCAx+Lhza4qZmpn+gyyBx0ZR4GAhsDzdZ22cvT0d+Njy9BkH/RVCANxMAz4I4rYCGspvVBxDFCebxkWvHIrAF2uBw1e9prJVc0do6Z3zDTPUzZxAuzi46i3ZlAyjNM3Rpj6LqacQbxadwI0uvtw/EVvHBi5TwA73vHJpWWSMQaglAuj36fXXkmUrfgWjpQ9W2KG3mrSRpj6FREW/nrFnMtpo7lL1rMqKEY4mE8hdX7EGRFGRcuL+LyA7eNZKKcibpp71OlSjm0dDjhlvRs8ScdSGKzBNVDWv+2LMzxp74TI5GEYNM33UgDXyKs8qyd9efSxSlgiWbzyHrxtf/Q2BYXcnM8UrYPJcJMpnAfkndyeeb6ftOtgDj0xPzHeSfvKtjJtkEMtvKi/+SMWaVgYI72E6LBRmDUUeHRMzsBxCGDtbm7dx5TRAQ4HSnokWXfTg7qWQI5LlU8w92cG5XQ8Ie31oo/kkzqpi3EOR2quQNDULecnv0vWKjTE15RI4CBZ1zj8ZJRUEkRMneLQlwvEWFyADCqK/mtzbA94IDGfjvpfchWgoxyUcxH/J3MUoWMSpMF1UUoRHAdD1LItdJVJYZYbxWz9y4ve+AtjRk7rbFjr5zzj2aa8iCbtNgkWXCNz1dNUT+4qjBTgEgvB2WVUReNW2eVERHiQMNME4D/iI4mhuGzU0KIpuXE7t5TLEMff68UwqAi
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 20:13:40.1733 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d804de6-bf4e-4b2f-5bae-08dc5b2d0b6d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6480
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

RDMA device with limited scatter-gather capability requires physical
address contiguous VRAM buffer for RDMA peer direct access.

Add a new KFD alloc memory flag and store as new GEM bo alloc flag. When
pin this buffer object to export for RDMA peerdirect access, set
AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS flag, and then vram_mgr will set
TTM_PL_FLAG_CONTIFUOUS flag to ask VRAM buddy allocator to get
contiguous VRAM.

Remove the 2GB max memory block size limit for contiguous allocation.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 7 +++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c     | 9 +++++++--
 include/uapi/drm/amdgpu_drm.h                    | 5 +++++
 include/uapi/linux/kfd_ioctl.h                   | 1 +
 4 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 0ae9fd844623..3523b91f8add 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1470,6 +1470,9 @@ static int amdgpu_amdkfd_gpuvm_pin_bo(struct amdgpu_bo *bo, u32 domain)
 	if (unlikely(ret))
 		return ret;
 
+	if (bo->flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS_BEST_EFFORT)
+		bo->flags |= AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
+
 	ret = amdgpu_bo_pin_restricted(bo, domain, 0, 0);
 	if (ret)
 		pr_err("Error in Pinning BO to domain: %d\n", domain);
@@ -1712,6 +1715,10 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 			alloc_flags = AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE;
 			alloc_flags |= (flags & KFD_IOC_ALLOC_MEM_FLAGS_PUBLIC) ?
 			AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED : 0;
+
+			/* For contiguous VRAM allocation */
+			if (flags & KFD_IOC_ALLOC_MEM_FLAGS_CONTIGUOUS_BEST_EFFORT)
+				alloc_flags |= AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS_BEST_EFFORT;
 		}
 		xcp_id = fpriv->xcp_id == AMDGPU_XCP_NO_PARTITION ?
 					0 : fpriv->xcp_id;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
index 8db880244324..1d6e45e238e1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
@@ -516,8 +516,13 @@ static int amdgpu_vram_mgr_new(struct ttm_resource_manager *man,
 
 		BUG_ON(min_block_size < mm->chunk_size);
 
-		/* Limit maximum size to 2GiB due to SG table limitations */
-		size = min(remaining_size, 2ULL << 30);
+		if (place->flags & TTM_PL_FLAG_CONTIGUOUS)
+			size = remaining_size;
+		else
+			/* Limit maximum size to 2GiB due to SG table limitations
+			 * for no contiguous allocation.
+			 */
+			size = min(remaining_size, 2ULL << 30);
 
 		if ((size >= (u64)pages_per_block << PAGE_SHIFT) &&
 				!(size & (((u64)pages_per_block << PAGE_SHIFT) - 1)))
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index ad21c613fec8..13645abb8e46 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -171,6 +171,11 @@ extern "C" {
  * may override the MTYPE selected in AMDGPU_VA_OP_MAP.
  */
 #define AMDGPU_GEM_CREATE_EXT_COHERENT		(1 << 15)
+/* Flag that allocating the BO with best effort for contiguous VRAM.
+ * If no contiguous VRAM, fallback to scattered allocation.
+ * Pin the BO for peerdirect RDMA trigger VRAM defragmentation.
+ */
+#define AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS_BEST_EFFORT	(1 << 16)
 
 struct drm_amdgpu_gem_create_in  {
 	/** the requested memory size */
diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index 2040a470ddb4..c1394c162d4e 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -407,6 +407,7 @@ struct kfd_ioctl_acquire_vm_args {
 #define KFD_IOC_ALLOC_MEM_FLAGS_COHERENT	(1 << 26)
 #define KFD_IOC_ALLOC_MEM_FLAGS_UNCACHED	(1 << 25)
 #define KFD_IOC_ALLOC_MEM_FLAGS_EXT_COHERENT	(1 << 24)
+#define KFD_IOC_ALLOC_MEM_FLAGS_CONTIGUOUS_BEST_EFFORT	(1 << 23)
 
 /* Allocate memory for later SVM (shared virtual memory) mapping.
  *
-- 
2.43.2

