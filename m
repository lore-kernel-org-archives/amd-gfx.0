Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F7B0C43334
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jun 2022 10:01:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07C5311BBB7;
	Tue,  7 Jun 2022 10:01:17 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2046.outbound.protection.outlook.com [40.107.102.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC2E711BBB7
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jun 2022 10:01:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O831WZpoKHbZ8E+69LUDK/NwNiAvIC0NPgW2WFEhM8dG0pmo61mPMEjcLKWgv6ym0EbjV3KXe7R0DvjZHyGd/o3AtwIIYeBGU26ze3ED3jGKFJDjzom4PX8jJifGU1eDOCGZ0Bbt0H3JtTryEICLua7I9d/Ly0+eULwb0DyYjDpgrhesgvXraJyHyobXn7/hoRmdAiDTwE+pMnPt5spmwPg+ohLUh0CRjmIYrc8jIQolR16sKidQ1Kstw8sUdtQfXkE6WUPapiaP+rEomDLfeaO+tqb/wIrbSAdNNC6+IQUZCqBSIxjs5jEdFpkgxb9QK3ZU+/x3bZvo9nJk76U3qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y4cdaRtxAM2qQb4xJFsq86ERCoG5pxucBgG0OFgmAlM=;
 b=GcYYRfqfOtV7Sli3rV/kNyD3GkHT1Z2B5iR2mI20RRrRKbIspFZMuNaiuKgR3f/aLmYOIlxFpwGUcwZP9ZAt7MkaXBPr2NAsSlVcqYzgeVx/ZeQ6BcRf8A7jcTasZUekwU4x5JDgLJ0U8R4kLmUEIlWk4BVUOo+gvaC11TR7a/y5z1FVpmP5HBUyeRm76ObrbsfAlcqmVusPH2kQkbz3esa5zYMBkBW0h1WtckD9IjIBpoPg0IoitN3Q/XccabsEo2AQaYrDg6E3RtCkaqSMA5DDLOv63pulhBaeuKoE+dYyDEgz3kK0oBXsvmcwuzVvGzYP96MIRT59p1LgI92L9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y4cdaRtxAM2qQb4xJFsq86ERCoG5pxucBgG0OFgmAlM=;
 b=COueHtEdSeOPuWVP6yZjbf98a7a5YKVZnddMpwVqcuCRIiJKGi029QdERNbgI7hvLnKmIgi54Fs4O+iafsrgisI4+723MnBb3X1qaPJGsIOnnQ+kJH7Qg709mN7MrCRZCup8Nk0R2yvZz/fQl0sGqwJuoP599uttRQaQwFAYslM=
Received: from DS7PR06CA0002.namprd06.prod.outlook.com (2603:10b6:8:2a::16) by
 BY5PR12MB3779.namprd12.prod.outlook.com (2603:10b6:a03:1a7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.15; Tue, 7 Jun
 2022 10:01:13 +0000
Received: from DM6NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2a:cafe::ae) by DS7PR06CA0002.outlook.office365.com
 (2603:10b6:8:2a::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12 via Frontend
 Transport; Tue, 7 Jun 2022 10:01:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT040.mail.protection.outlook.com (10.13.173.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Tue, 7 Jun 2022 10:01:13 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 7 Jun
 2022 05:00:48 -0500
From: Lang Yu <Lang.Yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amdkfd: simplify PD and PT BOs validation
Date: Tue, 7 Jun 2022 17:59:46 +0800
Message-ID: <20220607095947.120493-2-Lang.Yu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220607095947.120493-1-Lang.Yu@amd.com>
References: <20220607095947.120493-1-Lang.Yu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d6a3790-3159-48e8-bc55-08da486ca7a6
X-MS-TrafficTypeDiagnostic: BY5PR12MB3779:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB3779224B7A80A84051B46F7AFBA59@BY5PR12MB3779.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yg/I3aewGuVTYE9dOe1e0H4RgVSzAIJKkwQlSevuZG4MlwpAPd0LN85//mi7s6ThXP3qVnb2W2sxH6GOb2OE2YHGt4PP1Y4XRKIrh9cEAXrQoJj6IEnoGd/Md73Uo60hNk2hfw2WUNFhF1tsIjFQMzf+KeSEMFGzxln4tr4zKRDhtvLMsX7pV3fBALgyejo9xctjs+waB42l1fodo0BLwiZxz0Il+mxBq2dgVp95509S7B1OsUl9W3czMKFgYCfhZhoh+UhJ2hadnXhUvxSQGC45DoGp4XWke6LQ7kOku6510L7Kk8aHPbUUiG6UD/airq31s9pxlVkrG5Mdmmi63mHnOR/bH5Sx3rYg43dnywEqGWwVBYr/CS8nKNWYbhp9XrQMSb0Qrf0kC8n6HUywHtQiwOIBRHUVNTCYs8r6oDFKQN+zlw8RV1aVuTBOYn9+0CfhVEUXggKWhSeK2JBZrLx/3q6NK+7vSwXrNU8+wh3i0h4QE4ztM8un2Mj0qDJ+C7DNTdl2t2TNXpDn0rBni0tUOgnLRxo6roZ3S8WhIU8Cf2fWNpy+F9HsOqIkO0rog2UmSzGUKvwPhaYFef7CpMD/QKomNe/63YPEBVaPjFKBF/wPWLzvMyEo+wWUoVHOxhCOOJi2//9udlW1Qv38EvwDpw09AoJjy1RUu7o+y5QDLtZtDVwMWuFfGBV4Pif/SPWp326pKlhsrmb7wbka1w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(2616005)(426003)(336012)(2906002)(1076003)(4326008)(86362001)(47076005)(7696005)(82310400005)(316002)(186003)(26005)(6916009)(54906003)(70586007)(36860700001)(36756003)(8676002)(83380400001)(40460700003)(81166007)(356005)(508600001)(5660300002)(8936002)(16526019)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2022 10:01:13.1642 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d6a3790-3159-48e8-bc55-08da486ca7a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3779
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Huang
 Rui <ray.huang@amd.com>, Lang Yu <Lang.Yu@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

1, Move root BO kmapping to amdgpu_vm_make_compute.
2, Don't validate and kmap root BO intentional, it would be
validated and mapped by amdgpu_vm_validate_pt_bos if necessary.
3, Rename and expose vm_validate_pt_pd_bos, so that it
could be used by SVM.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  1 +
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 26 +++++--------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        |  5 ++++
 3 files changed, 12 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index f8b9f27adcf5..463c1a3fa587 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -288,6 +288,7 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *process_info,
 					    struct dma_fence **ef);
 int amdgpu_amdkfd_gpuvm_get_vm_fault_info(struct amdgpu_device *adev,
 					      struct kfd_vm_fault_info *info);
+int amdgpu_amdkfd_gpuvm_validate_pt_pd_bos(struct amdgpu_vm *vm);
 int amdgpu_amdkfd_gpuvm_import_dmabuf(struct amdgpu_device *adev,
 				      struct dma_buf *dmabuf,
 				      uint64_t va, void *drm_priv,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 81bcffb510f4..9f6531597d1f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -370,14 +370,14 @@ static int amdgpu_amdkfd_validate_vm_bo(void *_unused, struct amdgpu_bo *bo)
 	return amdgpu_amdkfd_bo_validate(bo, bo->allowed_domains, false);
 }
 
-/* vm_validate_pt_pd_bos - Validate page table and directory BOs
+/* amdgpu_amdkfd_gpuvm_validate_pt_pd_bos - Validate page table and directory BOs
  *
  * Page directories are not updated here because huge page handling
  * during page table updates can invalidate page directory entries
  * again. Page directories are only updated after updating page
  * tables.
  */
-static int vm_validate_pt_pd_bos(struct amdgpu_vm *vm)
+int amdgpu_amdkfd_gpuvm_validate_pt_pd_bos(struct amdgpu_vm *vm)
 {
 	struct amdgpu_bo *pd = vm->root.bo;
 	struct amdgpu_device *adev = amdgpu_ttm_adev(pd->tbo.bdev);
@@ -389,22 +389,8 @@ static int vm_validate_pt_pd_bos(struct amdgpu_vm *vm)
 		return ret;
 	}
 
-	ret = amdgpu_amdkfd_validate_vm_bo(NULL, pd);
-	if (ret) {
-		pr_err("failed to validate PD\n");
-		return ret;
-	}
-
 	vm->pd_phys_addr = amdgpu_gmc_pd_addr(vm->root.bo);
 
-	if (vm->use_cpu_for_update) {
-		ret = amdgpu_bo_kmap(pd, NULL);
-		if (ret) {
-			pr_err("failed to kmap PD, ret=%d\n", ret);
-			return ret;
-		}
-	}
-
 	return 0;
 }
 
@@ -1175,7 +1161,7 @@ static int process_validate_vms(struct amdkfd_process_info *process_info)
 
 	list_for_each_entry(peer_vm, &process_info->vm_list_head,
 			    vm_list_node) {
-		ret = vm_validate_pt_pd_bos(peer_vm);
+		ret = amdgpu_amdkfd_gpuvm_validate_pt_pd_bos(peer_vm);
 		if (ret)
 			return ret;
 	}
@@ -1261,7 +1247,7 @@ static int init_kfd_vm(struct amdgpu_vm *vm, void **process_info,
 	ret = amdgpu_bo_reserve(vm->root.bo, true);
 	if (ret)
 		goto reserve_pd_fail;
-	ret = vm_validate_pt_pd_bos(vm);
+	ret = amdgpu_amdkfd_gpuvm_validate_pt_pd_bos(vm);
 	if (ret) {
 		pr_err("validate_pt_pd_bos() failed\n");
 		goto validate_pd_fail;
@@ -1809,7 +1795,7 @@ int amdgpu_amdkfd_gpuvm_map_memory_to_gpu(
 	    bo->tbo.resource->mem_type == TTM_PL_SYSTEM)
 		is_invalid_userptr = true;
 
-	ret = vm_validate_pt_pd_bos(avm);
+	ret = amdgpu_amdkfd_gpuvm_validate_pt_pd_bos(avm);
 	if (unlikely(ret))
 		goto out_unreserve;
 
@@ -1889,7 +1875,7 @@ int amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu(
 		goto unreserve_out;
 	}
 
-	ret = vm_validate_pt_pd_bos(avm);
+	ret = amdgpu_amdkfd_gpuvm_validate_pt_pd_bos(avm);
 	if (unlikely(ret))
 		goto unreserve_out;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 1ea204218903..697ce6825c18 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2217,6 +2217,11 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 			goto unreserve_bo;
 
 		vm->update_funcs = &amdgpu_vm_cpu_funcs;
+		r = amdgpu_bo_kmap(vm->root.bo, NULL);
+		if (r) {
+			dev_err(adev->dev, "failed to kmap PD, r = %d\n", r);
+			return r;
+		}
 	} else {
 		vm->update_funcs = &amdgpu_vm_sdma_funcs;
 	}
-- 
2.25.1

