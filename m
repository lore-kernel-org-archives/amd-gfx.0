Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1F72C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Nov 2023 23:33:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C12F10E409;
	Tue, 14 Nov 2023 23:33:52 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20617.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::617])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBCC610E409
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Nov 2023 23:33:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lADISRKJjMk8RUFXBTv3d30S6XfQ1yQKVRW4Il19WNbcPl+NKluU3zX8sUeEXRRqBdMZ081L8GoCFGgiYr3pPh7ZU5m6ZJXhSVCJlG10OLPB50A/iclKONq7lkJZtEmuSsFf4dF8XbAaZBEron61ZMYRtWlBqd/IBfUWqnV6Xg9/x8t+NPtW/kSjWLxeJouQtikSXLveDPuR/09+kRF8ODx+zKqIiFzMBsQkZMn09zZ6D7AK329MShwcoZWIMg3Cc3lLRDkxIIQPWEFDkvGHmtoMpO+VJjHhqpj4YPt0EmnulxvRPVGYzSR/78U6kb+/1/v2YnDFl4Cz3BFUYgTclg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rmz0jQEP0q+CfVG72TaICzXmWuqKN4z4KhaA+lkTGY8=;
 b=WWIFbtTN0pSqWYRtfrUCRMM8Ab1tbGOE26s39Wv+CpU8eqW5pvv8hv0MCzCswmxzhW390YZ9/m+AplgRa606Wusz/SLYeqMJ3oZLH8OqRV0bELrwIKnq9ig2r2aZSJP7a6vTcy1xdyqZHZh0MAa7rEssdXfOn3g1Qx6LpuKcF3lmcEPnNrEKSVuIZUi/WFAna4QjugoIYPn7XAb1FisFFIhamA8YBdRYVKxs/7hGtwxJNpofgVBB0T4AkyuFL2VkExI02d3seDSyPr7xBtSmXEtM7M+MHF/37RVg6M5AqsYtz70+XCFi+ymXFOjb8hDSc2chLxi0RcpA+lOAInJizQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rmz0jQEP0q+CfVG72TaICzXmWuqKN4z4KhaA+lkTGY8=;
 b=lR5mnR0v4qXqNXrz+h/uIeI6fo9In+pCHatCLNxvmXogTASKyfRbHOqvyxK9Sn3r4kkamnp2P1RXb694FN2QOTQ3PQYGmgxkLzbnMDDxSg/+i4s1zC+Js6HcPma+4HtO8Ue9/jmzH5z1RcWzzdtgo694VZHF4mlFALxPrzPGI10=
Received: from DM6PR17CA0034.namprd17.prod.outlook.com (2603:10b6:5:1b3::47)
 by IA1PR12MB6259.namprd12.prod.outlook.com (2603:10b6:208:3e5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Tue, 14 Nov
 2023 23:33:47 +0000
Received: from DS3PEPF000099D5.namprd04.prod.outlook.com
 (2603:10b6:5:1b3:cafe::a) by DM6PR17CA0034.outlook.office365.com
 (2603:10b6:5:1b3::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31 via Frontend
 Transport; Tue, 14 Nov 2023 23:33:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D5.mail.protection.outlook.com (10.167.17.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.19 via Frontend Transport; Tue, 14 Nov 2023 23:33:44 +0000
Received: from Harpoon.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 14 Nov
 2023 17:33:43 -0600
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: Auto-validate DMABuf imports in compute VMs
Date: Tue, 14 Nov 2023 18:32:54 -0500
Message-ID: <20231114233254.63139-2-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231114233254.63139-1-Felix.Kuehling@amd.com>
References: <20231114233254.63139-1-Felix.Kuehling@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D5:EE_|IA1PR12MB6259:EE_
X-MS-Office365-Filtering-Correlation-Id: 11f21d9b-82dc-4103-1524-08dbe56a24c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8+U7BcgdZwA4USP95vPLcGSU2I9x/zx6DC3Pul1XFAQBkDrsIpDwnzHLBCden0ZSMsrT12bAhUWjR7G7JZndWxbJw0mfnV4BDhvuebdayGDch45jUMpsxFHYFN12N9WSAhqhLiMkhaJQnCncH+R2G/tKky8ahMR+GgJPgaI11zLvwiB+r15M6vfN2tTO+xq31XyRHjc6AWgZnwiopVOZcREx1oTr4y2cPlgS6pEPK6Aieu/ktMl/Eu0uKEgaG5YThvBxVQruriBNqqVeJukramHzqxeK/P1MqDKvpmSwa1wT3CnTy3PppoNaqcECcPrP9A2ohdFzTU9xYkra5lTOBXek1t2zXPAaknlaEbYklwIEQrjLief6Vm6i/d3ru/lrbTZII2xJFTmRJjqvxHjERl1DYvyNdYyw4GdHS5BcfjCSGtqV1siOVn+DuqcfsXUJjCe270ApY0m+xI6K7Y7X0eNONGp6lsfACsor/j1v6knK57eWgcIqbS71Gg3m5/88GIfcqgLVHlSX7B7YDHVjRL1T4Lv7bajYoaUbR+q0qu3p4fLi+Uii/76xG1rb4uWK2CwAS70+naS1CSqhAfSXWTo+zqRBQsb+OP0MsHf9F70XhVwDLbXd/UMwAzQFMWpbtSvA28+62OTrp2VyyNEIB9wryapEv4+C/qjQW6tDGuZu+Q7krMr1DnbD9vpitlrvpg4yLK3h2exyNBRoUFkJme/2a/yr8Cox4XUFowCO8QUUjNWDTPHqKyEL7eNt6jnCQKaWn3hYMuO/a+FYe/Is5w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(136003)(346002)(396003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(82310400011)(36840700001)(40470700004)(46966006)(40460700003)(54906003)(26005)(16526019)(36860700001)(2616005)(426003)(6666004)(47076005)(7696005)(4326008)(336012)(83380400001)(5660300002)(30864003)(8936002)(41300700001)(8676002)(2906002)(15650500001)(478600001)(316002)(1076003)(6916009)(70206006)(70586007)(82740400003)(36756003)(86362001)(356005)(81166007)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 23:33:44.8203 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11f21d9b-82dc-4103-1524-08dbe56a24c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6259
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
Cc: xiaogang.chen@amd.com, mukul.joshi@amd.com, ramesh.errabolu@amd.com,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

DMABuf imports in compute VMs are not wrapped in a kgd_mem object on the
process_info->kfd_bo_list. There is no explicit KFD API call to validate
them or add eviction fences to them.

This patch automatically validates and fences dymanic DMABuf imports when
they are added to a compute VM. Revalidation after evictions is handled
in the VM code.

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |   3 +
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |  45 ++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c        |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c   |   4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       |  26 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        | 122 +++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |  12 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c          |  12 +-
 8 files changed, 196 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index fcf8a98ad15e..68d534a89942 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -178,6 +178,9 @@ int amdgpu_queue_mask_bit_to_set_resource_bit(struct amdgpu_device *adev,
 struct amdgpu_amdkfd_fence *amdgpu_amdkfd_fence_create(u64 context,
 				struct mm_struct *mm,
 				struct svm_range_bo *svm_bo);
+int amdgpu_amdkfd_bo_validate_and_fence(struct amdgpu_bo *bo,
+					uint32_t domain,
+					struct dma_fence *fence);
 #if defined(CONFIG_DEBUG_FS)
 int kfd_debugfs_kfd_mem_limits(struct seq_file *m, void *data);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 2e302956a279..bb83ab7a0256 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -423,9 +423,9 @@ static int amdgpu_amdkfd_bo_validate(struct amdgpu_bo *bo, uint32_t domain,
 	return ret;
 }
 
-static int amdgpu_amdkfd_bo_validate_and_fence(struct amdgpu_bo *bo,
-					       uint32_t domain,
-					       struct dma_fence *fence)
+int amdgpu_amdkfd_bo_validate_and_fence(struct amdgpu_bo *bo,
+					uint32_t domain,
+					struct dma_fence *fence)
 {
 	int ret = amdgpu_bo_reserve(bo, false);
 
@@ -461,13 +461,16 @@ static int amdgpu_amdkfd_validate_vm_bo(void *_unused, struct amdgpu_bo *bo)
  * again. Page directories are only updated after updating page
  * tables.
  */
-static int vm_validate_pt_pd_bos(struct amdgpu_vm *vm)
+static int vm_validate_pt_pd_bos(struct amdgpu_vm *vm,
+				 struct ww_acquire_ctx *ticket)
 {
 	struct amdgpu_bo *pd = vm->root.bo;
 	struct amdgpu_device *adev = amdgpu_ttm_adev(pd->tbo.bdev);
 	int ret;
 
-	ret = amdgpu_vm_validate_pt_bos(adev, vm, amdgpu_amdkfd_validate_vm_bo, NULL);
+	ret = amdgpu_vm_validate_evicted_bos(adev, vm, ticket,
+					     amdgpu_amdkfd_validate_vm_bo,
+					     NULL);
 	if (ret) {
 		pr_err("failed to validate PT BOs\n");
 		return ret;
@@ -1347,14 +1350,15 @@ static int map_bo_to_gpuvm(struct kgd_mem *mem,
 	return ret;
 }
 
-static int process_validate_vms(struct amdkfd_process_info *process_info)
+static int process_validate_vms(struct amdkfd_process_info *process_info,
+				struct ww_acquire_ctx *ticket)
 {
 	struct amdgpu_vm *peer_vm;
 	int ret;
 
 	list_for_each_entry(peer_vm, &process_info->vm_list_head,
 			    vm_list_node) {
-		ret = vm_validate_pt_pd_bos(peer_vm);
+		ret = vm_validate_pt_pd_bos(peer_vm, ticket);
 		if (ret)
 			return ret;
 	}
@@ -1440,7 +1444,7 @@ static int init_kfd_vm(struct amdgpu_vm *vm, void **process_info,
 	ret = amdgpu_bo_reserve(vm->root.bo, true);
 	if (ret)
 		goto reserve_pd_fail;
-	ret = vm_validate_pt_pd_bos(vm);
+	ret = vm_validate_pt_pd_bos(vm, NULL);
 	if (ret) {
 		pr_err("validate_pt_pd_bos() failed\n");
 		goto validate_pd_fail;
@@ -2075,7 +2079,7 @@ int amdgpu_amdkfd_gpuvm_map_memory_to_gpu(
 	    bo->tbo.resource->mem_type == TTM_PL_SYSTEM)
 		is_invalid_userptr = true;
 
-	ret = vm_validate_pt_pd_bos(avm);
+	ret = vm_validate_pt_pd_bos(avm, NULL);
 	if (unlikely(ret))
 		goto out_unreserve;
 
@@ -2154,7 +2158,7 @@ int amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu(
 		goto unreserve_out;
 	}
 
-	ret = vm_validate_pt_pd_bos(avm);
+	ret = vm_validate_pt_pd_bos(avm, NULL);
 	if (unlikely(ret))
 		goto unreserve_out;
 
@@ -2635,7 +2639,7 @@ static int validate_invalid_user_pages(struct amdkfd_process_info *process_info)
 
 	amdgpu_sync_create(&sync);
 
-	ret = process_validate_vms(process_info);
+	ret = process_validate_vms(process_info, NULL);
 	if (ret)
 		goto unreserve_out;
 
@@ -2887,11 +2891,6 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence **ef)
 
 	amdgpu_sync_create(&sync_obj);
 
-	/* Validate PDs and PTs */
-	ret = process_validate_vms(process_info);
-	if (ret)
-		goto validate_map_fail;
-
 	/* Validate BOs and map them to GPUVM (update VM page tables). */
 	list_for_each_entry(mem, &process_info->kfd_bo_list,
 			    validate_list.head) {
@@ -2942,6 +2941,13 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence **ef)
 	if (failed_size)
 		pr_debug("0x%lx/0x%lx in system\n", failed_size, total_size);
 
+	/* Validate PDs, PTs and evicted DMABuf imports last. Otherwise BO
+	 * validations above would invalidate DMABuf imports again.
+	 */
+	ret = process_validate_vms(process_info, &ctx.ticket);
+	if (ret)
+		goto validate_map_fail;
+
 	/* Update mappings not managed by KFD */
 	list_for_each_entry(peer_vm, &process_info->vm_list_head,
 			vm_list_node) {
@@ -3001,7 +3007,7 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence **ef)
 				   &process_info->eviction_fence->base,
 				   DMA_RESV_USAGE_BOOKKEEP);
 	}
-	/* Attach eviction fence to PD / PT BOs */
+	/* Attach eviction fence to PD / PT BOs and DMABuf imports */
 	list_for_each_entry(peer_vm, &process_info->vm_list_head,
 			    vm_list_node) {
 		struct amdgpu_bo *bo = peer_vm->root.bo;
@@ -3009,6 +3015,11 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence **ef)
 		dma_resv_add_fence(bo->tbo.base.resv,
 				   &process_info->eviction_fence->base,
 				   DMA_RESV_USAGE_BOOKKEEP);
+
+		ret = amdgpu_vm_fence_imports(peer_vm, &ctx.ticket,
+					      &process_info->eviction_fence->base);
+		if (ret)
+			break;
 	}
 
 validate_map_fail:
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 1d4e80f72573..7d78a5841db4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -968,10 +968,10 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
 	p->bytes_moved = 0;
 	p->bytes_moved_vis = 0;
 
-	r = amdgpu_vm_validate_pt_bos(p->adev, &fpriv->vm,
-				      amdgpu_cs_bo_validate, p);
+	r = amdgpu_vm_validate_evicted_bos(p->adev, &fpriv->vm, NULL,
+					   amdgpu_cs_bo_validate, p);
 	if (r) {
-		DRM_ERROR("amdgpu_vm_validate_pt_bos() failed.\n");
+		DRM_ERROR("amdgpu_vm_validate_evicted_bos() failed.\n");
 		goto error_validate;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
index e7e87a3b2601..8b556669cec0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -373,6 +373,10 @@ amdgpu_dma_buf_move_notify(struct dma_buf_attachment *attach)
 	struct amdgpu_vm_bo_base *bo_base;
 	int r;
 
+	/* FIXME: This should be after the "if", but needs a fix to make sure
+	 * DMABuf imports are initialized in the right VM list.
+	 */
+	amdgpu_vm_bo_invalidate(adev, bo, false);
 	if (!bo->tbo.resource || bo->tbo.resource->mem_type == TTM_PL_SYSTEM)
 		return;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 849fffbb367d..fd43921844ed 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -186,6 +186,32 @@ static int amdgpu_gem_object_open(struct drm_gem_object *obj,
 	else
 		++bo_va->ref_count;
 	amdgpu_bo_unreserve(abo);
+
+	/* Validate and add eviction fence to DMABuf imports with dynamic
+	 * attachment in compute VMs. Re-validation will be done by
+	 * amdgpu_vm_validate_evicted_bos and the fence will be updated by
+	 * amdgpu_vm_fence_imports in amdgpu_amdkfd_gpuvm_restore_process_bos.
+	 *
+	 * Nested locking below for the case that a GEM object is opened in
+	 * kfd_mem_export_dmabuf. Since the lock below is only taken for imports,
+	 * but not for export, this is a different lock class that cannot lead to
+	 * circular lock dependencies.
+	 */
+	if (!vm->is_compute_context || !vm->process_info)
+		return 0;
+	if (!obj->import_attach ||
+	    !dma_buf_is_dynamic(obj->import_attach->dmabuf))
+		return 0;
+	mutex_lock_nested(&vm->process_info->lock, 1);
+	if (!WARN_ON(!vm->process_info->eviction_fence)) {
+		r = amdgpu_amdkfd_bo_validate_and_fence(abo, AMDGPU_GEM_DOMAIN_GTT,
+							&vm->process_info->eviction_fence->base);
+		if (r)
+			dev_warn(adev->dev, "%d: validate_and_fence failed: %d\n",
+				 vm->task_info.pid, r);
+	}
+	mutex_unlock(&vm->process_info->lock);
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 1c9397198083..9d3fb161cc0a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -368,24 +368,31 @@ void amdgpu_vm_move_to_lru_tail(struct amdgpu_device *adev,
 }
 
 /**
- * amdgpu_vm_validate_pt_bos - validate the page table BOs
+ * amdgpu_vm_validate_evicted_bos - validate evicted BOs tracked in the VM
  *
  * @adev: amdgpu device pointer
  * @vm: vm providing the BOs
+ * @ticket: optional reservation ticket used to reserve the VM
  * @validate: callback to do the validation
  * @param: parameter for the validation callback
  *
- * Validate the page table BOs on command submission if neccessary.
+ * Validate the page table BOs and per-VM BOs on command submission if
+ * necessary. If a ticket is given, also try to validate evicted user queue
+ * BOs. They must already be reserved with the given ticket.
  *
  * Returns:
  * Validation result.
  */
-int amdgpu_vm_validate_pt_bos(struct amdgpu_device *adev, struct amdgpu_vm *vm,
-			      int (*validate)(void *p, struct amdgpu_bo *bo),
-			      void *param)
+int amdgpu_vm_validate_evicted_bos(struct amdgpu_device *adev,
+				   struct amdgpu_vm *vm,
+				   struct ww_acquire_ctx *ticket,
+				   int (*validate)(void *p,
+						   struct amdgpu_bo *bo),
+				   void *param)
 {
 	struct amdgpu_vm_bo_base *bo_base;
 	struct amdgpu_bo *shadow;
+	struct dma_resv *resv;
 	struct amdgpu_bo *bo;
 	int r;
 
@@ -416,6 +423,28 @@ int amdgpu_vm_validate_pt_bos(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		}
 		spin_lock(&vm->status_lock);
 	}
+	while (ticket && !list_empty(&vm->evicted_user)) {
+		bo_base = list_first_entry(&vm->evicted_user,
+					   struct amdgpu_vm_bo_base,
+					   vm_status);
+		spin_unlock(&vm->status_lock);
+
+		bo = bo_base->bo;
+		resv = bo->tbo.base.resv;
+
+		if (dma_resv_locking_ctx(resv) != ticket) {
+			pr_warn_ratelimited("Evicted user BO is not reserved in pid %d\n",
+					    vm->task_info.pid);
+			return -EINVAL;
+		}
+
+		r = validate(param, bo);
+		if (r)
+			return r;
+
+		amdgpu_vm_bo_invalidated(bo_base);
+		spin_lock(&vm->status_lock);
+	}
 	spin_unlock(&vm->status_lock);
 
 	amdgpu_vm_eviction_lock(vm);
@@ -1358,11 +1387,21 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
 		}
 
 		r = amdgpu_vm_bo_update(adev, bo_va, clear);
-		if (r)
-			return r;
 
 		if (unlock)
 			dma_resv_unlock(resv);
+		if (r)
+			return r;
+
+		/* Remember evicted DMABuf imports in compute VMs for later
+		 * validation
+		 */
+		if (vm->is_compute_context && bo_va->base.bo &&
+		    bo_va->base.bo->tbo.base.import_attach &&
+		    (!bo_va->base.bo->tbo.resource ||
+		     bo_va->base.bo->tbo.resource->mem_type == TTM_PL_SYSTEM))
+			amdgpu_vm_bo_evicted_user(&bo_va->base);
+
 		spin_lock(&vm->status_lock);
 	}
 	spin_unlock(&vm->status_lock);
@@ -1370,6 +1409,75 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
 	return 0;
 }
 
+/**
+ * amdgpu_vm_fence_imports - add fence to valid DMABuf imports
+ *
+ * @vm: requested vm
+ * @ticket: optional reservation ticket used to reserve the VM
+ * @fence: fence to add
+ *
+ * Add the specified fence to all dynamic DMABuf imports that are valid.
+ *
+ * Returns:
+ * 0 for success.
+ */
+int amdgpu_vm_fence_imports(struct amdgpu_vm *vm,
+			    struct ww_acquire_ctx *ticket,
+			    struct dma_fence *fence)
+{
+	struct amdgpu_bo_va *bo_va, *tmp;
+	struct dma_resv *resv;
+	LIST_HEAD(imports);
+	bool unlock;
+	int ret = 0;
+
+	if (!vm->is_compute_context)
+		return 0;
+
+	/* Move all the DMABuf imports to a private list so I can reserve
+	 * them while not holding te status_lock.
+	 */
+	spin_lock(&vm->status_lock);
+	list_for_each_entry_safe(bo_va, tmp, &vm->idle, base.vm_status) {
+		if (bo_va->base.bo && bo_va->base.bo->tbo.base.import_attach &&
+		    dma_buf_is_dynamic(bo_va->base.bo->tbo.base.import_attach->dmabuf))
+			list_move(&bo_va->base.vm_status, &imports);
+	}
+	spin_unlock(&vm->status_lock);
+
+	list_for_each_entry(bo_va, &imports, base.vm_status) {
+		resv = bo_va->base.bo->tbo.base.resv;
+
+		/* Try to reserve the BO */
+		if (dma_resv_trylock(resv)) {
+			unlock = true;
+		/* The caller is already holding the reservation lock */
+		} else if (ticket && dma_resv_locking_ctx(resv) == ticket) {
+			unlock = false;
+		} else {
+			WARN_ONCE(1, "Failed to reserve DMABuf import");
+			ret = -EBUSY;
+			break;
+		}
+
+		ret = dma_resv_reserve_fences(resv, 1);
+		if (!ret)
+			dma_resv_add_fence(resv, fence,
+					   DMA_RESV_USAGE_BOOKKEEP);
+
+		if (unlock)
+			dma_resv_unlock(resv);
+		if (ret)
+			break;
+	}
+
+	spin_lock(&vm->status_lock);
+	list_splice(&imports, &vm->idle);
+	spin_unlock(&vm->status_lock);
+
+	return ret;
+}
+
 /**
  * amdgpu_vm_flush_compute_tlb - Flush TLB on compute VM
  *
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 939d0c2219c0..a380c4acf8e8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -432,9 +432,12 @@ void amdgpu_vm_get_pd_bo(struct amdgpu_vm *vm,
 			 struct list_head *validated,
 			 struct amdgpu_bo_list_entry *entry);
 bool amdgpu_vm_ready(struct amdgpu_vm *vm);
-int amdgpu_vm_validate_pt_bos(struct amdgpu_device *adev, struct amdgpu_vm *vm,
-			      int (*callback)(void *p, struct amdgpu_bo *bo),
-			      void *param);
+int amdgpu_vm_validate_evicted_bos(struct amdgpu_device *adev,
+				   struct amdgpu_vm *vm,
+				   struct ww_acquire_ctx *ticket,
+				   int (*callback)(void *p,
+						   struct amdgpu_bo *bo),
+				   void *param);
 int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job, bool need_pipe_sync);
 int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
 			  struct amdgpu_vm *vm, bool immediate);
@@ -444,6 +447,9 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
 int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
 			   struct amdgpu_vm *vm,
 			   struct ww_acquire_ctx *ticket);
+int amdgpu_vm_fence_imports(struct amdgpu_vm *vm,
+			    struct ww_acquire_ctx *ticket,
+			    struct dma_fence *fence);
 int amdgpu_vm_flush_compute_tlb(struct amdgpu_device *adev,
 				struct amdgpu_vm *vm,
 				uint32_t flush_type,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index b23ba92a794c..6eec0f4ddde4 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1558,9 +1558,11 @@ static int svm_range_reserve_bos(struct svm_validate_context *ctx)
 			goto unreserve_out;
 		}
 
-		r = amdgpu_vm_validate_pt_bos(pdd->dev->adev,
-					      drm_priv_to_vm(pdd->drm_priv),
-					      svm_range_bo_validate, NULL);
+		r = amdgpu_vm_validate_evicted_bos(pdd->dev->adev,
+						   drm_priv_to_vm(pdd->drm_priv),
+						   NULL,
+						   svm_range_bo_validate,
+						   NULL);
 		if (r) {
 			pr_debug("failed %d validate pt bos\n", r);
 			goto unreserve_out;
@@ -1677,7 +1679,9 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 		goto free_ctx;
 	}
 
-	svm_range_reserve_bos(ctx);
+	r = svm_range_reserve_bos(ctx);
+	if (r)
+		goto free_ctx;
 
 	p = container_of(prange->svms, struct kfd_process, svms);
 	owner = kfd_svm_page_owner(p, find_first_bit(ctx->bitmap,
-- 
2.34.1

