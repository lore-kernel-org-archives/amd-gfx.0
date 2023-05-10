Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03A67C77B7C
	for <amd-gfx@archiver.kernel.org>; Wed, 10 May 2023 21:24:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EEEC10E543;
	Wed, 10 May 2023 21:24:17 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2086.outbound.protection.outlook.com [40.107.101.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49E1210E53D
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 May 2023 21:24:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mw0O2hXYt23RkeOeym0ArTwJfyLIIFy+kJv6r+sn1A7f1f6RqWSqMqqttxwjerMJyu/34vV/YgP366an7RxwrdR+pO870Hm1PXK4jVXokCObRm5lN70eOYGCKQqeylAX92/OhmKrP+i3I4BFI76e5w0ul/atrBGD+LY1cOQTg+GcP6OjUU3ouo+ghlzT/+3sk/FK4VQj5IDWPQgdr9a6tqjWgdbt+qUrb5FhpGHdzuEO8arh4jqfLPU2Z87oKWIZqyoufhzMeZYbdcepmn8M6VPWbFmNtVw5N5uvv+L1maAr9e23Zegdg+Kp8qZin4v0kUeXQBscNeZJB+lUPk1wlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kzypwQg5Qg7M4AuqUCw+l4sN0+xMNoqPQj2by7GeAdE=;
 b=Eu0tAVKCfKg2MtwsWzG79V8NWuEAmM5C/3UN1WTmq14qQKYid212RDWZSmF0QLhqyspR/N1+WxNImWdU3QRoQr6uslhGFB6TSFa/vqWSAFrbBf5DbsrUvciEdvwXRfqpuOh/ao+BPsigXFFHD/PXBmjtGtk189YrOaE1h7Viqw0HAfWOBUrM64n+iPQjo4HOItcXSRYgRBN2cKXGhtSpjSimUPOJy6ntEVoEVA3BWYukvAynbdJMWU5E6Fqinjl4MQsjlBA1Jeddjm8kpM4+yM76lpqzsoGeCNREF8jJZmCcFJLbixpQSiDFBiRnr/Qaujza5zMyShVKW/sAUA3Bmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kzypwQg5Qg7M4AuqUCw+l4sN0+xMNoqPQj2by7GeAdE=;
 b=aGi+6fp/iOqj/87amsPQem7pL64qgrfWvUdPstkCqvLzulkXJTJQI1t/fc3HDBHrngl+9Eh2b3VHZYEa7v+qHa0ZxkJC1eWHI8C/S1iOSaXI8xB9c885LzRaTCV/Kegvf0/9HaVT6023chctSSmkF9JuHMnPYMM5DCfW7MXJooI=
Received: from MW4PR03CA0208.namprd03.prod.outlook.com (2603:10b6:303:b8::33)
 by LV8PR12MB9084.namprd12.prod.outlook.com (2603:10b6:408:18e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Wed, 10 May
 2023 21:24:01 +0000
Received: from CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b8:cafe::b4) by MW4PR03CA0208.outlook.office365.com
 (2603:10b6:303:b8::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18 via Frontend
 Transport; Wed, 10 May 2023 21:24:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT014.mail.protection.outlook.com (10.13.175.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.21 via Frontend Transport; Wed, 10 May 2023 21:24:00 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 10 May
 2023 16:23:58 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 21/29] drm/amdkfd: Store xcp partition id to amdgpu bo
Date: Wed, 10 May 2023 17:23:25 -0400
Message-ID: <20230510212333.2071373-21-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230510212333.2071373-1-alexander.deucher@amd.com>
References: <20230510212333.2071373-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT014:EE_|LV8PR12MB9084:EE_
X-MS-Office365-Filtering-Correlation-Id: 3174c58d-9599-4cf3-7945-08db519cdf94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e3bQKt3UqOryMLF9ImynFMz+kB5vrROXkA5P/k6iYMpFrQKa5uKgonC/vPbXWvPV1yqbWXggrxgEpEXDyY1tii5f/CrRqbiYNjvMefRCxA1/Ra5TfvQnLMMa1Y9FsadhcaSd7bf+rjZcPasScoKVBxpHuzBM+qG7e7RewFvgJOu3n04YqUsf5DcEVdX6SOtnVS2Fmv1S3+7qZvfKHjxeYbILyLImWNcS8YPtjUtLmro66wqw482HpgH2WFI8mh4iqsvSUZqgMEuOofJn+EnqRgBBwkI7MVv+2B9symV5RDRxR2KvyEQ0XWX21Y3DHqYOpqcetC4ioVpPuv9QVdV4G3PAcSTcNK7gZK5UrWowHh3H3qhYD+nKNIZG+7gkzR/Dx7EXwl/qMbKyYRTmVnqOs2sWIQB4br2esJphrVMqQqiiKn2R2wpaPakoyqvVLCq9yANkOx9H8ve3IDPTYZV9jjwjYekspLtvsSICO961djYCXeHArUWIYBKzZREKQFGLj2E8d0WWAGUjh79ziFobLle5BLN0lVmcVge2/stfK2tqVizB97Cka7cj89AEzmdNVX21mKIVTeZ3hxKjwARdnsRESue5BamNNb5vv36+/6Xsc4nX57OwkYe+hCVj6NqejRX90Io6i1AROknoucWuxoRfIXUYi2qq5+rii6JYhuYXg5IkAWbYBpQ/br8U/Vv41de4b4Phvu44rRDmsWjr4KW9IZUQHUTj6VjeBu0f7AQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(346002)(376002)(396003)(451199021)(36840700001)(40470700004)(46966006)(82310400005)(8676002)(5660300002)(336012)(86362001)(426003)(8936002)(36860700001)(83380400001)(47076005)(26005)(81166007)(356005)(16526019)(1076003)(186003)(82740400003)(40460700003)(70586007)(478600001)(6666004)(54906003)(7696005)(2616005)(70206006)(316002)(41300700001)(40480700001)(6916009)(36756003)(2906002)(4326008)(30864003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 21:24:00.9136 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3174c58d-9599-4cf3-7945-08db519cdf94
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9084
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Philip Yang <Philip.Yang@amd.com>

For memory accounting per compute partition and export drm amdgpu bo and
then import to KFD, we need the xcp id to account the memory usage or
find the KFD node of the original amdgpu bo to create the KFD bo on the
correct adev KFD node.

Set xcp_id_plus1 of amdgpu_bo_param to create bo and store xcp_id to
amddgpu bo. Add helper macro to get the mem_id from adev and xcp_id.

v2: squash in fix ("drm/amdgpu: Fix BO creation failure on GFX 9.4.3 dGPU")

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h       |  4 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 11 ++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c          |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h          |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c       | 15 ++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h       | 12 ++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c          |  6 +++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c        |  5 +++--
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c            |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c             |  4 ++--
 10 files changed, 42 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 324cb566ca2f..05c54776951b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -330,6 +330,10 @@ int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
 void amdgpu_amdkfd_unreserve_mem_limit(struct amdgpu_device *adev,
 		uint64_t size, u32 alloc_flag);
 
+#define KFD_XCP_MEM_ID(adev, xcp_id) \
+		((adev)->xcp_mgr && (xcp_id) >= 0 ?\
+		(adev)->xcp_mgr->xcp[(xcp_id)].mem_id : -1)
+
 #define KFD_XCP_MEMORY_SIZE(n) ((n)->adev->gmc.num_mem_partitions ?\
 		(n)->adev->gmc.mem_partitions[(n)->xcp->mem_id].size /\
 		(n)->adev->xcp_mgr->num_xcp_per_mem_partition :\
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 71b22d61dd27..cf8f80e4ef56 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1633,6 +1633,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 		uint64_t *offset, uint32_t flags, bool criu_resume)
 {
 	struct amdgpu_vm *avm = drm_priv_to_vm(drm_priv);
+	struct amdgpu_fpriv *fpriv = container_of(avm, struct amdgpu_fpriv, vm);
 	enum ttm_bo_type bo_type = ttm_bo_type_device;
 	struct sg_table *sg = NULL;
 	uint64_t user_addr = 0;
@@ -1640,7 +1641,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 	struct drm_gem_object *gobj = NULL;
 	u32 domain, alloc_domain;
 	uint64_t aligned_size;
-	int8_t mem_id = -1;
+	int8_t xcp_id = -1;
 	u64 alloc_flags;
 	int ret;
 
@@ -1659,7 +1660,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 			alloc_flags |= (flags & KFD_IOC_ALLOC_MEM_FLAGS_PUBLIC) ?
 			AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED : 0;
 		}
-		mem_id = avm->mem_id;
+		xcp_id = fpriv->xcp_id == ~0 ? 0 : fpriv->xcp_id;
 	} else if (flags & KFD_IOC_ALLOC_MEM_FLAGS_GTT) {
 		domain = alloc_domain = AMDGPU_GEM_DOMAIN_GTT;
 		alloc_flags = 0;
@@ -1717,12 +1718,12 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 		goto err_reserve_limit;
 	}
 
-	pr_debug("\tcreate BO VA 0x%llx size 0x%llx domain %s mem_id %d\n",
+	pr_debug("\tcreate BO VA 0x%llx size 0x%llx domain %s xcp_id %d\n",
 		 va, (*mem)->aql_queue ? size << 1 : size,
-		 domain_string(alloc_domain), mem_id);
+		 domain_string(alloc_domain), xcp_id);
 
 	ret = amdgpu_gem_object_create(adev, aligned_size, 1, alloc_domain, alloc_flags,
-				       bo_type, NULL, &gobj, mem_id + 1);
+				       bo_type, NULL, &gobj, xcp_id + 1);
 	if (ret) {
 		pr_debug("Failed to create BO on domain %s. ret %d\n",
 			 domain_string(alloc_domain), ret);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 01029b495f5a..b02d106d5a0c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -97,7 +97,7 @@ int amdgpu_gem_object_create(struct amdgpu_device *adev, unsigned long size,
 			     int alignment, u32 initial_domain,
 			     u64 flags, enum ttm_bo_type type,
 			     struct dma_resv *resv,
-			     struct drm_gem_object **obj, int8_t mem_id_plus1)
+			     struct drm_gem_object **obj, int8_t xcp_id_plus1)
 {
 	struct amdgpu_bo *bo;
 	struct amdgpu_bo_user *ubo;
@@ -115,7 +115,7 @@ int amdgpu_gem_object_create(struct amdgpu_device *adev, unsigned long size,
 	bp.flags = flags;
 	bp.domain = initial_domain;
 	bp.bo_ptr_size = sizeof(struct amdgpu_bo);
-	bp.mem_id_plus1 = mem_id_plus1;
+	bp.xcp_id_plus1 = xcp_id_plus1;
 
 	r = amdgpu_bo_create_user(adev, &bp, &ubo);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
index 646c4fcc8e40..f30264782ba2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
@@ -43,7 +43,7 @@ int amdgpu_gem_object_create(struct amdgpu_device *adev, unsigned long size,
 			     int alignment, u32 initial_domain,
 			     u64 flags, enum ttm_bo_type type,
 			     struct dma_resv *resv,
-			     struct drm_gem_object **obj, int8_t mem_id_plus1);
+			     struct drm_gem_object **obj, int8_t xcp_id_plus1);
 int amdgpu_mode_dumb_create(struct drm_file *file_priv,
 			    struct drm_device *dev,
 			    struct drm_mode_create_dumb *args);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 3002d431ce3d..ac25314064da 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -131,14 +131,15 @@ void amdgpu_bo_placement_from_domain(struct amdgpu_bo *abo, u32 domain)
 
 	if (domain & AMDGPU_GEM_DOMAIN_VRAM) {
 		unsigned visible_pfn = adev->gmc.visible_vram_size >> PAGE_SHIFT;
+		int8_t mem_id = KFD_XCP_MEM_ID(adev, abo->xcp_id);
 
-		if (adev->gmc.mem_partitions && abo->mem_id >= 0) {
-			places[c].fpfn = adev->gmc.mem_partitions[abo->mem_id].range.fpfn;
+		if (adev->gmc.mem_partitions && mem_id >= 0) {
+			places[c].fpfn = adev->gmc.mem_partitions[mem_id].range.fpfn;
 			/*
 			 * memory partition range lpfn is inclusive start + size - 1
 			 * TTM place lpfn is exclusive start + size
 			 */
-			places[c].lpfn = adev->gmc.mem_partitions[abo->mem_id].range.lpfn + 1;
+			places[c].lpfn = adev->gmc.mem_partitions[mem_id].range.lpfn + 1;
 		} else {
 			places[c].fpfn = 0;
 			places[c].lpfn = 0;
@@ -583,8 +584,12 @@ int amdgpu_bo_create(struct amdgpu_device *adev,
 
 	bo->flags = bp->flags;
 
-	/* bo->mem_id -1 means any partition */
-	bo->mem_id = bp->mem_id_plus1 - 1;
+	if (adev->gmc.mem_partitions)
+		/* For GPUs with spatial partitioning, bo->xcp_id=-1 means any partition */
+		bo->xcp_id = bp->xcp_id_plus1 - 1;
+	else
+		/* For GPUs without spatial partitioning */
+		bo->xcp_id = 0;
 
 	if (!amdgpu_bo_support_uswc(bo->flags))
 		bo->flags &= ~AMDGPU_GEM_CREATE_CPU_GTT_USWC;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index 521a432348a0..5d3440d719e4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -56,8 +56,8 @@ struct amdgpu_bo_param {
 	bool				no_wait_gpu;
 	struct dma_resv			*resv;
 	void				(*destroy)(struct ttm_buffer_object *bo);
-	/* memory partition number plus 1, 0 means any partition */
-	int8_t				mem_id_plus1;
+	/* xcp partition number plus 1, 0 means any partition */
+	int8_t				xcp_id_plus1;
 };
 
 /* bo virtual addresses in a vm */
@@ -111,8 +111,12 @@ struct amdgpu_bo {
 #endif
 	struct kgd_mem                  *kfd_bo;
 
-	/* memory partition number, -1 means any partition */
-	int8_t				mem_id;
+	/*
+	 * For GPUs with spatial partitioning, xcp partition number, -1 means
+	 * any partition. For other ASICs without spatial partition, always 0
+	 * for memory accounting.
+	 */
+	int8_t				xcp_id;
 };
 
 struct amdgpu_bo_user {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 395edca3b7f9..ad664ef640ff 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1055,6 +1055,7 @@ static void amdgpu_ttm_backend_destroy(struct ttm_device *bdev,
 static struct ttm_tt *amdgpu_ttm_tt_create(struct ttm_buffer_object *bo,
 					   uint32_t page_flags)
 {
+	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->bdev);
 	struct amdgpu_bo *abo = ttm_to_amdgpu_bo(bo);
 	struct amdgpu_ttm_tt *gtt;
 	enum ttm_caching caching;
@@ -1064,7 +1065,10 @@ static struct ttm_tt *amdgpu_ttm_tt_create(struct ttm_buffer_object *bo,
 		return NULL;
 	}
 	gtt->gobj = &bo->base;
-	gtt->pool_id = abo->mem_id;
+	if (adev->gmc.mem_partitions && abo->xcp_id >= 0)
+		gtt->pool_id = KFD_XCP_MEM_ID(adev, abo->xcp_id);
+	else
+		gtt->pool_id = abo->xcp_id;
 
 	if (abo->flags & AMDGPU_GEM_CREATE_CPU_GTT_USWC)
 		caching = ttm_write_combined;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index 62fc7e8d326e..cc3b1b596e56 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -502,6 +502,7 @@ int amdgpu_vm_pt_clear(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 int amdgpu_vm_pt_create(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 			int level, bool immediate, struct amdgpu_bo_vm **vmbo)
 {
+	struct amdgpu_fpriv *fpriv = container_of(vm, struct amdgpu_fpriv, vm);
 	struct amdgpu_bo_param bp;
 	struct amdgpu_bo *bo;
 	struct dma_resv *resv;
@@ -534,7 +535,7 @@ int amdgpu_vm_pt_create(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 
 	bp.type = ttm_bo_type_kernel;
 	bp.no_wait_gpu = immediate;
-	bp.mem_id_plus1 = vm->mem_id + 1;
+	bp.xcp_id_plus1 = fpriv->xcp_id == ~0 ? 0 : fpriv->xcp_id + 1;
 
 	if (vm->root.bo)
 		bp.resv = vm->root.bo->tbo.base.resv;
@@ -560,7 +561,7 @@ int amdgpu_vm_pt_create(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	bp.type = ttm_bo_type_kernel;
 	bp.resv = bo->tbo.base.resv;
 	bp.bo_ptr_size = sizeof(struct amdgpu_bo);
-	bp.mem_id_plus1 = vm->mem_id + 1;
+	bp.xcp_id_plus1 = fpriv->xcp_id == ~0 ? 0 : fpriv->xcp_id + 1;
 
 	r = amdgpu_bo_create(adev, &bp, &(*vmbo)->shadow);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index ee5d4d67b423..b860ba503ddd 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1253,7 +1253,7 @@ static void gmc_v9_0_get_coherence_flags(struct amdgpu_device *adev,
 		is_local = (!is_vram && (adev->flags & AMD_IS_APU) &&
 			    num_possible_nodes() <= 1) ||
 			   (is_vram && adev == bo_adev &&
-			    bo->mem_id == vm->mem_id);
+			    KFD_XCP_MEM_ID(adev, bo->xcp_id) == vm->mem_id);
 		snoop = true;
 		if (uncached) {
 			mtype = MTYPE_UC;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 8b5453fd304a..872daaef0258 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -555,7 +555,7 @@ svm_range_vram_node_new(struct kfd_node *node, struct svm_range *prange,
 	bp.type = ttm_bo_type_device;
 	bp.resv = NULL;
 	if (node->xcp)
-		bp.mem_id_plus1 = node->xcp->mem_id + 1;
+		bp.xcp_id_plus1 = node->xcp->id + 1;
 
 	r = amdgpu_bo_create_user(node->adev, &bp, &ubo);
 	if (r) {
@@ -566,7 +566,7 @@ svm_range_vram_node_new(struct kfd_node *node, struct svm_range *prange,
 
 	pr_debug("alloc bo at offset 0x%lx size 0x%lx on partition %d\n",
 		 bo->tbo.resource->start << PAGE_SHIFT, bp.size,
-		 bp.mem_id_plus1 - 1);
+		 bp.xcp_id_plus1 - 1);
 
 	r = amdgpu_bo_reserve(bo, true);
 	if (r) {
-- 
2.40.1

