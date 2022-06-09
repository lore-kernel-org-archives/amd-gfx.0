Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DF0EC43334
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jun 2022 17:17:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8363C12B206;
	Thu,  9 Jun 2022 17:17:42 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F7B012B206
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jun 2022 17:17:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fY6KhEJquSk7ECGRMX2s+HRnwdsXE105x1xDLi+HYUaFrP7OV5QNnzNIQUjLDi9+yWzq2x/PKvsboospEeaa0NpznS75TtGJDxplDjXonZzlVWE1WagI+hTOYNhCyYInDpieaeHw1fohwJoaMmF1g0gvOajGnl9JI+BFkaPsjiBP0F9T8XaTtdimEsyOqrV3TmEdtT50mvatzNMO9N4GL8sOWfT34a4geGMa7sUPTiW0aKnQRWFND3+TvK4gaC/EgkLmGdEDnZwOlYkcpRvoj157WlKAUBwl25iG0C1QGiFSLkaOfwG8L+jsi2NKnq3PrpDmmCZGFbsewgvhGUUcLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5lkZMMSS1AfkM/gioYf7mdyS6bIQUBAPt7r+pVtD4cU=;
 b=Y1QsqTJiE2YeWNma7hs2JxpJocXetVp0eoKHCLxs+ZYJSUy14KUvMvbbZRgxseS3OS0jUTAhYAqxKmN8n+w1sB2B8Z+B2HN0BSmS66gC0HV/bD/Znd1WNUfGtqiU07mY2LGkVgsK/8qN6Ni/i8aroz+dgHiJB4ajNKU+MkMfyZxiNz5CNk0SbQMNGQh+F+L5ijHG2PCLJsOeskFR5SsAFHe7KKh0XHNVgFWZGjlIpmEMHm412A48bphFhfMMqbyfaGfgCiBOBPwJ2t1KQi6yE9Fh0X0t9lTF/t289pMmtrvs57nYuAYUsWRJKFpuAaXlspd/sE1v8zZpfK+N1uPGZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5lkZMMSS1AfkM/gioYf7mdyS6bIQUBAPt7r+pVtD4cU=;
 b=bOn9vlqPijtiaVE6Q47anrtC9t45j723LPKWtaMEfWqywlqfhiGwa+YtdgBiU1CK1PveiR6bjgiOfKSHi4R8Vi+9UvLhwaQbhEsdmL7pu+d8S4/Bm+TzZIcrjgLHJ31OI1KKl5n1nt8LEAMCSLQ6PPBEJdqBkzmoXBVPvHDMhXY=
Received: from BN9PR03CA0496.namprd03.prod.outlook.com (2603:10b6:408:130::21)
 by BN8PR12MB3106.namprd12.prod.outlook.com (2603:10b6:408:45::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Thu, 9 Jun
 2022 17:17:37 +0000
Received: from BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:130:cafe::c1) by BN9PR03CA0496.outlook.office365.com
 (2603:10b6:408:130::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.15 via Frontend
 Transport; Thu, 9 Jun 2022 17:17:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT010.mail.protection.outlook.com (10.13.177.53) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Thu, 9 Jun 2022 17:17:36 +0000
Received: from RErrabolDevMach.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 9 Jun
 2022 12:17:36 -0500
From: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Fix error handling in
 amdgpu_amdkfd_gpuvm_free_memory_of_gpu
Date: Thu, 9 Jun 2022 12:17:27 -0500
Message-ID: <20220609171727.3581424-1-Ramesh.Errabolu@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9f375605-eea9-464e-e72c-08da4a3bf330
X-MS-TrafficTypeDiagnostic: BN8PR12MB3106:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB31064ECF5BB93A6F2B404B52E3A79@BN8PR12MB3106.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sER9SEPTOEVwaygozsi1rJmgdy3cNvo1UkXs841ef9YWmBZOG9hfbYWjAmWU1ajzNA8C5sYGfucxk5kaja3w5GLN/0Sfp3N6bQVOe480Hx9PXzdtE9Ef6t9PLs4P+/zivMRhque71xAWkYDTklBYOYgYFLiKgqiHBLtsS8xLHC00FE3GxmtJbos5HDJyQGBUqHtm7x/l0lWxdKhDTW95MkicbzJPb1+iUxdcpbpRv1dPN79ABeIBAawfOX5U8x7ksE+Dz9Or7pPZ/khf4H9vlUveZhDtq0wgiqRv3f7DxPJ9tuBEyYY2KBZQnV2pYAYs8MhG58gl54jGHeEgEy86qNV5AwvxlZ+Jg3gvpn8DLH+HZvTsGqJQHT/pODpKIbiySNmZCqu0kzWNjWnq2lFYWg+ADL1bBntdhgs3NB+2FteiRApP7d68NRO4ehwkQbX36W7qA7IYlUzQg7d3NqKIVhMJhgx57V5ithR7Mv2d3awl+Olo2hlXRnegRRUR+EuN85bKu0qVbOsemBnhWQsA1Qc/0B8Dx1Z6G7A/t/cf7XzozC/dokkHY69keU9FP1jwocuYFsB4nATZXooy0Ti0stOPlm+pMaNZShZBaiQnhJKkxm6p+SukzWNri3KK1j5PiQiJ1lp14XaiRIBLPuQ7/zNVWz4Eff5QuiQvnk5ZCGQqcQ+CniiNc/qvHrCiihq+zhrH5c7wnbazfTK4DX7zCA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(6916009)(2616005)(1076003)(36860700001)(6666004)(26005)(8936002)(40460700003)(316002)(86362001)(83380400001)(7696005)(16526019)(81166007)(426003)(4326008)(36756003)(70206006)(336012)(47076005)(186003)(70586007)(508600001)(5660300002)(356005)(2906002)(82310400005)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2022 17:17:36.9315 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f375605-eea9-464e-e72c-08da4a3bf330
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3106
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
Cc: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Following error conditions are fixed:
    Ensure calls to delete a list element are safe
    Unpin MMIO and DOORBELL BOs only after map count goes to zero
    Print a warning message if unreserving VMs encounters an error

Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 38 ++++++++++---------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index a1de900ba677..78b3efecc2f9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1013,14 +1013,14 @@ static void add_kgd_mem_to_kfd_bo_list(struct kgd_mem *mem,
 	mutex_unlock(&process_info->lock);
 }
 
-static void remove_kgd_mem_from_kfd_bo_list(struct kgd_mem *mem,
+static void remove_kgd_mem_from_validate_list(struct kgd_mem *mem,
 		struct amdkfd_process_info *process_info)
 {
 	struct ttm_validate_buffer *bo_list_entry;
 
 	bo_list_entry = &mem->validate_list;
 	mutex_lock(&process_info->lock);
-	list_del(&bo_list_entry->head);
+	list_del_init(&bo_list_entry->head);
 	mutex_unlock(&process_info->lock);
 }
 
@@ -1796,7 +1796,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 
 allocate_init_user_pages_failed:
 err_pin_bo:
-	remove_kgd_mem_from_kfd_bo_list(*mem, avm->process_info);
+	remove_kgd_mem_from_validate_list(*mem, avm->process_info);
 	drm_vma_node_revoke(&gobj->vma_node, drm_priv);
 err_node_allow:
 	/* Don't unreserve system mem limit twice */
@@ -1825,20 +1825,12 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
 	unsigned long bo_size = mem->bo->tbo.base.size;
 	struct kfd_mem_attachment *entry, *tmp;
 	struct bo_vm_reservation_context ctx;
-	struct ttm_validate_buffer *bo_list_entry;
 	unsigned int mapped_to_gpu_memory;
 	int ret;
 	bool is_imported = false;
 
 	mutex_lock(&mem->lock);
 
-	/* Unpin MMIO/DOORBELL BO's that were pinned during allocation */
-	if (mem->alloc_flags &
-	    (KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL |
-	     KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP)) {
-		amdgpu_amdkfd_gpuvm_unpin_bo(mem->bo);
-	}
-
 	mapped_to_gpu_memory = mem->mapped_to_gpu_memory;
 	is_imported = mem->is_imported;
 	mutex_unlock(&mem->lock);
@@ -1852,11 +1844,10 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
 		return -EBUSY;
 	}
 
-	/* Make sure restore workers don't access the BO any more */
-	bo_list_entry = &mem->validate_list;
-	mutex_lock(&process_info->lock);
-	list_del(&bo_list_entry->head);
-	mutex_unlock(&process_info->lock);
+	/* Make sure restore workers don't access the BO any more
+	 * Ensure removal of BO from validate list is reentrant safe
+	 */
+	remove_kgd_mem_from_validate_list(mem, process_info);
 
 	/* No more MMU notifiers */
 	amdgpu_mn_unregister(mem->bo);
@@ -1878,7 +1869,18 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
 	list_for_each_entry_safe(entry, tmp, &mem->attachments, list)
 		kfd_mem_detach(entry);
 
+	/* Return success even in case of error */
 	ret = unreserve_bo_and_vms(&ctx, false, false);
+	if (unlikely(ret)) {
+		WARN_ONCE(ret, "Error in unreserving BO and associated VMs");
+		ret = 0;
+	}
+
+	/* Unpin MMIO/DOORBELL BO's that were pinned during allocation */
+	if (mem->alloc_flags &
+	    (KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL |
+	     KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP))
+		amdgpu_amdkfd_gpuvm_unpin_bo(mem->bo);
 
 	/* Free the sync object */
 	amdgpu_sync_free(&mem->sync);
@@ -2814,7 +2816,7 @@ int amdgpu_amdkfd_add_gws_to_process(void *info, void *gws, struct kgd_mem **mem
 bo_reservation_failure:
 	mutex_unlock(&(*mem)->process_info->lock);
 	amdgpu_sync_free(&(*mem)->sync);
-	remove_kgd_mem_from_kfd_bo_list(*mem, process_info);
+	remove_kgd_mem_from_validate_list(*mem, process_info);
 	amdgpu_bo_unref(&gws_bo);
 	mutex_destroy(&(*mem)->lock);
 	kfree(*mem);
@@ -2832,7 +2834,7 @@ int amdgpu_amdkfd_remove_gws_from_process(void *info, void *mem)
 	/* Remove BO from process's validate list so restore worker won't touch
 	 * it anymore
 	 */
-	remove_kgd_mem_from_kfd_bo_list(kgd_mem, process_info);
+	remove_kgd_mem_from_validate_list(kgd_mem, process_info);
 
 	ret = amdgpu_bo_reserve(gws_bo, false);
 	if (unlikely(ret)) {
-- 
2.35.1

