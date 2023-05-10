Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55723C77B7C
	for <amd-gfx@archiver.kernel.org>; Wed, 10 May 2023 21:24:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13D5410E54A;
	Wed, 10 May 2023 21:24:22 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CB3010E52C
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 May 2023 21:24:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kf6HM2CZZ++PwVB8yuKzHJ51c8z/ktlKahRLi32CcNadnqvgwXImAyfL8mXohQ9sjanqabr75bcqaD7dEwHm73oxAvgi1hhWrmE4nEXF+Br5q31OQjtuOf3XiezQXT4y5+vnqzGI+i5jdn822otuBrcQTEa8SwrIfPzlyBA44TWlPEAnZTe6TP1ZiFP61vYX04Kqm4Mmbw9QcMY/6lnU8tt9naTnYulfP5lhLZN4+6FKZJPmAFk6lqoeLqieIY1rMGCwX13AE5yO02dbo9hal2B6Fj27y+GtobZm/D3oxkKfS4qU6CB2bnav1H6noPc3p9fT1FLoHvt+vF0qUkNfag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H4fFo0wmo8KIPV5xTKqX+UUUBcZHfGjUjZak6W+K32w=;
 b=l3puiTEyFffPwlcWIFzNv/DFg/dHriEWFFNhzeBHtIleufRaoHWIiGP2/w5j4cUrfxGjjXgZGuKYtbjBNlrd7RhilogxYN6y9pezkgskfm9AzQpClGWZddapJ/CO836jqyUy9WLn4GtXqFuYBiEkdxARCf2yqhPJ+vXF1JY0CDkmE27jOfiH4QV7FI8z6/gP3txRC73TJnwiT1SYU7ZiKRu3pw/lBqkbcEni8iF2q5NsNlF5BaC+inQiqUBJu3ReKw6GjUutmDPxlwFv2Syu8XAk1Abm5g6qR53smcGui0K2vDjaYhaBCJSFcF7GeN9D2BFVu0IvTdOGFF6iXWnmZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H4fFo0wmo8KIPV5xTKqX+UUUBcZHfGjUjZak6W+K32w=;
 b=EbKQUuIFSI/MqT6xPfRgK7HTYt56VqHzHnkkMLzuoj+Z0X0JU17qQuwThoAOAajrYanSBhkpyIOs+6rxpVVJsdRVX0iKmv2xqxeFzTuPt7ly2tWgDzZEo6ycQT+L5XSKKIyTS5cWUzZWaRCCA30B5z0looG91Mnx1kr/YirGMqA=
Received: from MW4PR03CA0208.namprd03.prod.outlook.com (2603:10b6:303:b8::33)
 by DS0PR12MB9059.namprd12.prod.outlook.com (2603:10b6:8:c5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18; Wed, 10 May
 2023 21:23:58 +0000
Received: from CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b8:cafe::10) by MW4PR03CA0208.outlook.office365.com
 (2603:10b6:303:b8::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18 via Frontend
 Transport; Wed, 10 May 2023 21:23:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT014.mail.protection.outlook.com (10.13.175.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.21 via Frontend Transport; Wed, 10 May 2023 21:23:58 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 10 May
 2023 16:23:55 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 15/29] drm/amdkfd: Alloc memory of GPU support memory partition
Date: Wed, 10 May 2023 17:23:19 -0400
Message-ID: <20230510212333.2071373-15-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT014:EE_|DS0PR12MB9059:EE_
X-MS-Office365-Filtering-Correlation-Id: 869a0879-c618-43d7-8897-08db519cddd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4E9m9ENHmQVh4670ZC1/VwVYItWr0NciklZWDBhuNIfjt7jJ5wDUsKczOO5/m80IowIgCDW7+29Cd2xgTc31MffBQnWDnvs+5OAZGnH1GSwX/Ogi/PdArMtFaCE9MUuRvPZ+SlA2ZJAegWLLSOK4XaVXKz/5H/KLe+8P8N6uPJmq7LutC7poAlp6jCQcrZzBQwDR9CNhlOfPTr0koDyHtS52VPfv5HmiM3LYh3RuXjailYYXH2fu32jJ6ocMHN23vK9CVFoXJGasGwM+JVNBMVWlRwZMoqagodGNvORKke385DZKz2IVVfdaFyoAUaofrvmOCAlnLsi0If7PJyJZDctg2bf/vujrzPYp9RAGrwGEA47ZZgd+mQK9Qu55CZu6pnX2BEBbwND4Ta713FeCQtvIjlfITkwOATtbRtMxqz7LwtFSDXBQ2dbGyct/py92ngTMQKLw3oH7KGniWZvx675NerSXPBb17IVNt6UrVli1XoApiTHy7RUDxhs+hKeVfNF6WArB1StW8zwYS2UEGVckXUPBkctnp5oFwXtM69Jzf4V3RAVOr5kAJYYfsBwopTp0QKSMQoxBcoKOThG39wDCYe+waWhOwU05e0a6am48rxadA/MK6jy72dh8GpZzQTCnsO/q25BWCIFMM22wuXB+mUmYLzOPpDWbD3xXXzUajsrQQ50p1fAHXvAcoZe1iepFty2Ti+HWLZVdr+8eWpqVjwed8be7nE5g7AXTah07JWK5e/ZEiwjUlspo4tNyomTSjJ/SvhrDb+9cbWmbcw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(346002)(376002)(136003)(451199021)(40470700004)(36840700001)(46966006)(82740400003)(86362001)(6666004)(7696005)(356005)(40480700001)(336012)(426003)(2616005)(36860700001)(47076005)(83380400001)(81166007)(36756003)(70586007)(1076003)(186003)(40460700003)(4326008)(6916009)(70206006)(82310400005)(26005)(8676002)(8936002)(54906003)(478600001)(316002)(16526019)(2906002)(41300700001)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 21:23:58.0067 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 869a0879-c618-43d7-8897-08db519cddd6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9059
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

For dGPU mode VRAM allocation, create amdgpu_bo from amdgpu_vm->mem_id,
to alloc from the correct memory range.

For APU mode VRAM allocation, set alloc domain to GTT, and set
bp->mem_id_plus1 from amdgpu_vm->mem_id + 1 to create amdgpu_bo, to
allocate system memory from correct NUMA node.

For GTT allocation, use mem_id -1 to allocate system memory from any
NUMA nodes.

Remove amdgpu_ttm_tt_set_mem_pool, to avoid the confusion that memory
maybe allocated from different mem_id.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 24 ++++++-------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 20 +---------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |  1 -
 3 files changed, 8 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 6d0c25e34af1..71b22d61dd27 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1640,9 +1640,9 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 	struct drm_gem_object *gobj = NULL;
 	u32 domain, alloc_domain;
 	uint64_t aligned_size;
+	int8_t mem_id = -1;
 	u64 alloc_flags;
 	int ret;
-	int mem_id = 0; /* Fixme : to be changed when mem_id support patch lands, until then NPS1, SPX only */
 
 	/*
 	 * Check on which domain to allocate BO
@@ -1652,13 +1652,14 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 
 		if (adev->gmc.is_app_apu) {
 			domain = AMDGPU_GEM_DOMAIN_GTT;
-			alloc_domain = AMDGPU_GEM_DOMAIN_CPU;
+			alloc_domain = AMDGPU_GEM_DOMAIN_GTT;
 			alloc_flags = 0;
 		} else {
 			alloc_flags = AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE;
 			alloc_flags |= (flags & KFD_IOC_ALLOC_MEM_FLAGS_PUBLIC) ?
 			AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED : 0;
 		}
+		mem_id = avm->mem_id;
 	} else if (flags & KFD_IOC_ALLOC_MEM_FLAGS_GTT) {
 		domain = alloc_domain = AMDGPU_GEM_DOMAIN_GTT;
 		alloc_flags = 0;
@@ -1716,11 +1717,12 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 		goto err_reserve_limit;
 	}
 
-	pr_debug("\tcreate BO VA 0x%llx size 0x%llx domain %s\n",
-			va, (*mem)->aql_queue ? size << 1 : size, domain_string(alloc_domain));
+	pr_debug("\tcreate BO VA 0x%llx size 0x%llx domain %s mem_id %d\n",
+		 va, (*mem)->aql_queue ? size << 1 : size,
+		 domain_string(alloc_domain), mem_id);
 
 	ret = amdgpu_gem_object_create(adev, aligned_size, 1, alloc_domain, alloc_flags,
-				       bo_type, NULL, &gobj, 0);
+				       bo_type, NULL, &gobj, mem_id + 1);
 	if (ret) {
 		pr_debug("Failed to create BO on domain %s. ret %d\n",
 			 domain_string(alloc_domain), ret);
@@ -1746,17 +1748,6 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 	(*mem)->mapped_to_gpu_memory = 0;
 	(*mem)->process_info = avm->process_info;
 
-	if (adev->gmc.is_app_apu &&
-	    ((*mem)->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_VRAM)) {
-		bo->allowed_domains = AMDGPU_GEM_DOMAIN_GTT;
-		bo->preferred_domains = AMDGPU_GEM_DOMAIN_GTT;
-		ret = amdgpu_ttm_tt_set_mem_pool(&bo->tbo, mem_id);
-		if (ret) {
-			pr_debug("failed to set ttm mem pool %d\n", ret);
-			goto err_set_mem_partition;
-		}
-	}
-
 	add_kgd_mem_to_kfd_bo_list(*mem, avm->process_info, user_addr);
 
 	if (user_addr) {
@@ -1783,7 +1774,6 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 allocate_init_user_pages_failed:
 err_pin_bo:
 	remove_kgd_mem_from_kfd_bo_list(*mem, avm->process_info);
-err_set_mem_partition:
 	drm_vma_node_revoke(&gobj->vma_node, drm_priv);
 err_node_allow:
 	/* Don't unreserve system mem limit twice */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 254927c596ba..395edca3b7f9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1064,7 +1064,7 @@ static struct ttm_tt *amdgpu_ttm_tt_create(struct ttm_buffer_object *bo,
 		return NULL;
 	}
 	gtt->gobj = &bo->base;
-	gtt->pool_id = NUMA_NO_NODE;
+	gtt->pool_id = abo->mem_id;
 
 	if (abo->flags & AMDGPU_GEM_CREATE_CPU_GTT_USWC)
 		caching = ttm_write_combined;
@@ -1159,24 +1159,6 @@ static void amdgpu_ttm_tt_unpopulate(struct ttm_device *bdev,
 	return ttm_pool_free(pool, ttm);
 }
 
-/**
- * amdgpu_ttm_tt_set_mem_pool - Set the TTM memory pool for the TTM BO
- * @tbo: The ttm_buffer_object that backs the VRAM bo
- * @mem_id: to select the initialized ttm pool corresponding to the memory partition
- */
-int amdgpu_ttm_tt_set_mem_pool(struct ttm_buffer_object *tbo, int mem_id)
-{
-	struct ttm_tt *ttm = tbo->ttm;
-	struct amdgpu_ttm_tt *gtt;
-
-	if (!ttm && !ttm_tt_is_populated(ttm))
-		return -EINVAL;
-
-	gtt = ttm_to_amdgpu_ttm_tt(ttm);
-	gtt->pool_id = mem_id;
-	return 0;
-}
-
 /**
  * amdgpu_ttm_tt_get_userptr - Return the userptr GTT ttm_tt for the current
  * task
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index fe32de1bf4d5..8ef048a0a33e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -192,7 +192,6 @@ bool amdgpu_ttm_tt_has_userptr(struct ttm_tt *ttm);
 struct mm_struct *amdgpu_ttm_tt_get_usermm(struct ttm_tt *ttm);
 bool amdgpu_ttm_tt_affect_userptr(struct ttm_tt *ttm, unsigned long start,
 				  unsigned long end, unsigned long *userptr);
-int amdgpu_ttm_tt_set_mem_pool(struct ttm_buffer_object *tbo, int mem_id);
 bool amdgpu_ttm_tt_userptr_invalidated(struct ttm_tt *ttm,
 				       int *last_invalidated);
 bool amdgpu_ttm_tt_is_userptr(struct ttm_tt *ttm);
-- 
2.40.1

