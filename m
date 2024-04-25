Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95543C19F53
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Apr 2024 19:59:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E6F011A862;
	Thu, 25 Apr 2024 19:59:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Mkm1B8Dd";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F40611A862
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Apr 2024 19:59:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SX0PBuZ61R6xlEDgYP5VEok70c4UeJUmMlnxdAVv2Nka1r5t+vgKi6+rpQdySj0K3a4QW0tUPL8Ppc6kowLPfOPGTKvS8B+mLAS9ZZaTvvFbSfHpzd8aUfwhyWrjJ5h5ZJR8sQD21sFvVNqL47N+YfAHWH3vTHVQKGNSKY7tknqidnQ/b7DeZE3eWg4wTeVM4oU4RlyT+uScbJlhGpl54xJL1qt+3klBG9Txge6/tgSVU52BW3V+NkDfCrKWzYek1tScCebR/X6MS8whnnL+Leyvm6vyFovsVWjKG8AXrc2SlVwCBGvUk0wnfKIqXLuyeQKEyr7XX0EcZKT8i6X9EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xZJ0DcDXLXR89nFJ1rmCAT5VvFbcV+nG/LU/O01TmAo=;
 b=hNG2ieW2MC4bvZmZx+onE1hoE+5xzB6v4PLsXhHI7kuUT6OOHlPYGP8JAcLPF+4eclL81X0gu4EfIFcZaAVKrrD2zVHQsnjsGfmhFOdgdDPI/MzA30LvZIHNPVd0wgJdH9pvgYwWHYg9EC5g0BMYgEl4eZKQZqXxc1aw/m6f40DD94TzHMCJfBfEmQi+5FJb9ENxmuxeTFCo2VJ+xlbBJXwDPuQ2dxTY5soNxb1rmNrstWq/Y3/Ou4oFG5csNd5vTqdNusxJKKZkXOaLuuc1DCgrQc7CkjdSZEodq0JK+tUszwV5X1qxnOYHWZCamEWP7xgnE3VxEMrP3VozvdGgkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xZJ0DcDXLXR89nFJ1rmCAT5VvFbcV+nG/LU/O01TmAo=;
 b=Mkm1B8DdYuOKrAKVplxVI7kj67ALVK5cwS3IZ09QoF4NBGHCLXBJ019MKD0uu1xW8XaqKghfKouCLH7A0ZrR54LiGY8loRDpZ6aOcVQB4U9Cr+i/OBzrknq02cfbbxNaXlpbFqsrAk3a6qL0n2hWvU5pXjYN7aIVLUVhbjbqeAs=
Received: from CH2PR05CA0067.namprd05.prod.outlook.com (2603:10b6:610:38::44)
 by MW3PR12MB4428.namprd12.prod.outlook.com (2603:10b6:303:57::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.45; Thu, 25 Apr
 2024 19:59:10 +0000
Received: from DS3PEPF0000C37B.namprd04.prod.outlook.com
 (2603:10b6:610:38:cafe::3e) by CH2PR05CA0067.outlook.office365.com
 (2603:10b6:610:38::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.10 via Frontend
 Transport; Thu, 25 Apr 2024 19:59:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C37B.mail.protection.outlook.com (10.167.23.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Thu, 25 Apr 2024 19:59:09 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 25 Apr
 2024 14:59:09 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 4/5] drm/amdgpu: support gfx v12 specific pte/pde fields
Date: Thu, 25 Apr 2024 15:58:48 -0400
Message-ID: <20240425195849.2787543-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240425195849.2787543-1-alexander.deucher@amd.com>
References: <20240425195849.2787543-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37B:EE_|MW3PR12MB4428:EE_
X-MS-Office365-Filtering-Correlation-Id: eb792ccc-4fa8-44f8-35b9-08dc65622c0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kdOfXWwBL71Sr6Y18vInqja8jDQxJbO80Y9rL/vLCKeATgriqHBXtYRbvnqV?=
 =?us-ascii?Q?wMm/JSuo5rWMCctlZgwE1JFw/dEmudubtp+GzXnZnAG6+o82nPwxc83QHfhN?=
 =?us-ascii?Q?ZllLRzaRxtY4hczhR12pRG/u94VU1bgvvh60B9aq+nKemktaF6dal6pVfKwj?=
 =?us-ascii?Q?KrTWX9fvrXAoJyk+u3eqnYGuFe2JktGX44FdgBiQW/Nlytq3xN1qOxIX4Szv?=
 =?us-ascii?Q?3WvGNWaY4Ob9mtiK6ft/OJJ9xZZZXkMjKxEEpPHqcoItu+VkU92njep+juey?=
 =?us-ascii?Q?jn4TELy02unNz8cmpa2UYuXls39w2LS8KFM0aqMPpp8O5JiBpnY6oc/0v/p8?=
 =?us-ascii?Q?hZct1vSmCgIX7QBv7XRyb0t+8tv9f77TiHhG+i77qDUOxUBneYoqWG3Uc2z8?=
 =?us-ascii?Q?yMprmqP2qzSj6MaqqIuf4MR01+UG7TiqRuQ49is7aOJLZBPxl8gb8/4mvLS9?=
 =?us-ascii?Q?JszSRLQ18m1XhVy0TfJaeaF/3NJRzWXw7D3teSDMgR3mchVz/lbXw+WptlUx?=
 =?us-ascii?Q?4r5L56lGvLt0ohZPzMoHQhoMylHmEasmThBiMXHDmeFQj+eWKHV9m6GuFdGZ?=
 =?us-ascii?Q?HQzAn6rqK4yMAarjUDSEffK9FdzMPiSXtnIaceWDyDK+dszSHwXr2SZtmy6o?=
 =?us-ascii?Q?FVR3G73ZKm2fq79ykxRHDyeLHBjeNVYRZqYSyBG+1uvNaRe3RYUrZi/9CqsS?=
 =?us-ascii?Q?czVTuUOPbxWrHhbAvwM6f/cP6SWzfgxq1zDouPQIDeElZSA0qbia06aI5y/T?=
 =?us-ascii?Q?RBPHqZ6yezUJIveC4DkyGrSGxApzh8CtyIrGixBtrEFaVcLM6kqQkr4cnRAA?=
 =?us-ascii?Q?W1Fx3JA0gqjyrO7FMZ75TgflKmbTZNdOoON1iHxlDcvVL22J+OEEcjM5bGhG?=
 =?us-ascii?Q?OY6isze3B7zVtdYM5+qZkuSVM5zcO/Zm53/qREwmxxBnupp1ww95pDZQAyOC?=
 =?us-ascii?Q?OAN+EEUXrGmoks/Qzz5xUEB+VK3yAy1d8o5GJRfYtpgo21GmZZGkhJZn5Pe6?=
 =?us-ascii?Q?k4YIS4fzZdm46GyAKVTDXbBmbGG1elnIz7zx4wE373dbiiOE+2s3R+qIpuP1?=
 =?us-ascii?Q?ViUmvqcRAiLXwb5Er/4EZAjvzCOqlfXFuu1+tqb7tFdrZsztdKlQPwkuKv6g?=
 =?us-ascii?Q?IFFlEyP+5piODCzpYmfbovFebGA/VtqdvIj/jo0a3rsAedvLf7g2CIMmLc2S?=
 =?us-ascii?Q?1FxMkQGXNoKFO1kkJ71VP5EuP5n4y0DsXefZ09BNoYAoxqQTnnJ0bJ4knNej?=
 =?us-ascii?Q?WCRt1zA9yG1KBCGFjSyS1im7bL9c5e+BJZN7HHZS/imF+M0wzi3WpHCC33Mp?=
 =?us-ascii?Q?VmCocEtPnTnSThoEvD2Vv+P6Dj3T+PK/Don3FqtKp5IZTosK4yGqO5+isgnV?=
 =?us-ascii?Q?wHYTCmlY1ZMJ/Uaa6Dj/1CvQz2XA?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(376005)(1800799015)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 19:59:09.9028 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb792ccc-4fa8-44f8-35b9-08dc65622c0c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4428
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

From: Hawking Zhang <Hawking.Zhang@amd.com>

Add gfx v12 pte/pde support to gmc common helper.

v2: squash in fixes (Alex)

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c   |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 12 ++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  6 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c |  6 +++---
 5 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 6bbab141eaae..8fe825479194 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -683,7 +683,7 @@ uint64_t amdgpu_gem_va_map_flags(struct amdgpu_device *adev, uint32_t flags)
 	if (flags & AMDGPU_VM_PAGE_WRITEABLE)
 		pte_flag |= AMDGPU_PTE_WRITEABLE;
 	if (flags & AMDGPU_VM_PAGE_PRT)
-		pte_flag |= AMDGPU_PTE_PRT;
+		pte_flag |= AMDGPU_PTE_PRT_FLAG(adev);
 	if (flags & AMDGPU_VM_PAGE_NOALLOC)
 		pte_flag |= AMDGPU_PTE_NOALLOC;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index be4629cdac04..9fcf194fea33 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -1015,7 +1015,7 @@ void amdgpu_gmc_init_pdb0(struct amdgpu_device *adev)
 	flags |= AMDGPU_PTE_WRITEABLE;
 	flags |= AMDGPU_PTE_SNOOPED;
 	flags |= AMDGPU_PTE_FRAG((adev->gmc.vmid0_page_table_block_size + 9*1));
-	flags |= AMDGPU_PDE_PTE;
+	flags |= AMDGPU_PDE_PTE_FLAG(adev);
 
 	/* The first n PDE0 entries are used as PTE,
 	 * pointing to vram
@@ -1028,7 +1028,7 @@ void amdgpu_gmc_init_pdb0(struct amdgpu_device *adev)
 	 * pointing to a 4K system page
 	 */
 	flags = AMDGPU_PTE_VALID;
-	flags |= AMDGPU_PDE_BFS(0) | AMDGPU_PTE_SNOOPED;
+	flags |= AMDGPU_PTE_SNOOPED | AMDGPU_PDE_BFS_FLAG(adev, 0);
 	/* Requires gart_ptb_gpu_pa to be 4K aligned */
 	amdgpu_gmc_set_pte_pde(adev, adev->gmc.ptr_pdb0, i, gart_ptb_gpu_pa, flags);
 	drm_dev_exit(idx);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 4e2391c83d7c..991e4d69c6a2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1055,7 +1055,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 				params.pages_addr = NULL;
 			}
 
-		} else if (flags & (AMDGPU_PTE_VALID | AMDGPU_PTE_PRT)) {
+		} else if (flags & (AMDGPU_PTE_VALID | AMDGPU_PTE_PRT_FLAG(adev))) {
 			addr = vram_base + cursor.start;
 		} else {
 			addr = 0;
@@ -1369,7 +1369,7 @@ static void amdgpu_vm_free_mapping(struct amdgpu_device *adev,
 				   struct amdgpu_bo_va_mapping *mapping,
 				   struct dma_fence *fence)
 {
-	if (mapping->flags & AMDGPU_PTE_PRT)
+	if (mapping->flags & AMDGPU_PTE_PRT_FLAG(adev))
 		amdgpu_vm_add_prt_cb(adev, fence);
 	kfree(mapping);
 }
@@ -1637,7 +1637,7 @@ static void amdgpu_vm_bo_insert_map(struct amdgpu_device *adev,
 	list_add(&mapping->list, &bo_va->invalids);
 	amdgpu_vm_it_insert(mapping, &vm->va);
 
-	if (mapping->flags & AMDGPU_PTE_PRT)
+	if (mapping->flags & AMDGPU_PTE_PRT_FLAG(adev))
 		amdgpu_vm_prt_get(adev);
 
 	if (bo && bo->tbo.base.resv == vm->root.bo->tbo.base.resv &&
@@ -1939,7 +1939,7 @@ int amdgpu_vm_bo_clear_mappings(struct amdgpu_device *adev,
 		struct amdgpu_bo *bo = before->bo_va->base.bo;
 
 		amdgpu_vm_it_insert(before, &vm->va);
-		if (before->flags & AMDGPU_PTE_PRT)
+		if (before->flags & AMDGPU_PTE_PRT_FLAG(adev))
 			amdgpu_vm_prt_get(adev);
 
 		if (bo && bo->tbo.base.resv == vm->root.bo->tbo.base.resv &&
@@ -1954,7 +1954,7 @@ int amdgpu_vm_bo_clear_mappings(struct amdgpu_device *adev,
 		struct amdgpu_bo *bo = after->bo_va->base.bo;
 
 		amdgpu_vm_it_insert(after, &vm->va);
-		if (after->flags & AMDGPU_PTE_PRT)
+		if (after->flags & AMDGPU_PTE_PRT_FLAG(adev))
 			amdgpu_vm_prt_get(adev);
 
 		if (bo && bo->tbo.base.resv == vm->root.bo->tbo.base.resv &&
@@ -2605,7 +2605,7 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 	dma_fence_put(vm->last_tlb_flush);
 
 	list_for_each_entry_safe(mapping, tmp, &vm->freed, list) {
-		if (mapping->flags & AMDGPU_PTE_PRT && prt_fini_needed) {
+		if (mapping->flags & AMDGPU_PTE_PRT_FLAG(adev) && prt_fini_needed) {
 			amdgpu_vm_prt_fini(adev, vm);
 			prt_fini_needed = false;
 		}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index e0e7e944a323..aadfd5cc3c5b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -113,6 +113,8 @@ struct amdgpu_mem_stats;
 
 /* gfx12 */
 #define AMDGPU_PTE_PRT_GFX12		(1ULL << 56)
+#define AMDGPU_PTE_PRT_FLAG(adev)	\
+	((amdgpu_ip_version((adev), GC_HWIP, 0) >= IP_VERSION(12, 0, 0)) ? AMDGPU_PTE_PRT_GFX12 : AMDGPU_PTE_PRT)
 
 #define AMDGPU_PTE_MTYPE_GFX12(a)	((uint64_t)(a) << 54)
 #define AMDGPU_PTE_MTYPE_GFX12_MASK	AMDGPU_PTE_MTYPE_GFX12(3ULL)
@@ -121,8 +123,12 @@ struct amdgpu_mem_stats;
 
 /* PDE Block Fragment Size for gfx v12 */
 #define AMDGPU_PDE_BFS_GFX12(a)		((uint64_t)((a) & 0x1fULL) << 58)
+#define AMDGPU_PDE_BFS_FLAG(adev, a)	\
+	((amdgpu_ip_version((adev), GC_HWIP, 0) >= IP_VERSION(12, 0, 0)) ? AMDGPU_PDE_BFS_GFX12(a) : AMDGPU_PDE_BFS(a))
 /* PDE is handled as PTE for gfx v12 */
 #define AMDGPU_PDE_PTE_GFX12		(1ULL << 63)
+#define AMDGPU_PDE_PTE_FLAG(adev)	\
+	((amdgpu_ip_version((adev), GC_HWIP, 0) >= IP_VERSION(12, 0, 0)) ? AMDGPU_PDE_PTE_GFX12: AMDGPU_PDE_PTE)
 
 /* How to program VM fault handling */
 #define AMDGPU_VM_FAULT_STOP_NEVER	0
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index 7fdd306a48a0..0763382d305a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -413,7 +413,7 @@ int amdgpu_vm_pt_clear(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	if (adev->asic_type >= CHIP_VEGA10) {
 		if (level != AMDGPU_VM_PTB) {
 			/* Handle leaf PDEs as PTEs */
-			flags |= AMDGPU_PDE_PTE;
+			flags |= AMDGPU_PDE_PTE_FLAG(adev);
 			amdgpu_gmc_get_vm_pde(adev, level,
 					      &value, &flags);
 		} else {
@@ -757,12 +757,12 @@ static void amdgpu_vm_pte_update_flags(struct amdgpu_vm_update_params *params,
 	struct amdgpu_device *adev = params->adev;
 
 	if (level != AMDGPU_VM_PTB) {
-		flags |= AMDGPU_PDE_PTE;
+		flags |= AMDGPU_PDE_PTE_FLAG(params->adev);
 		amdgpu_gmc_get_vm_pde(adev, level, &addr, &flags);
 
 	} else if (adev->asic_type >= CHIP_VEGA10 &&
 		   !(flags & AMDGPU_PTE_VALID) &&
-		   !(flags & AMDGPU_PTE_PRT)) {
+		   !(flags & AMDGPU_PTE_PRT_FLAG(params->adev))) {
 
 		/* Workaround for fault priority problem on GMC9 */
 		flags |= AMDGPU_PTE_EXECUTABLE;
-- 
2.44.0

