Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3EC2C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 31 May 2022 15:14:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A05510EAE8;
	Tue, 31 May 2022 15:14:34 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A76B610EAE8
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 May 2022 15:14:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d9OVoxMCNmbKf2uEXdbZLAXsbHo6B9MbaisxL27QZfqhNSD2KRlNwe3VcI5dlWfMJjIjarbNMQoz+Ezt26LomTokRolhMkK1/uW6I86diNuH51OdUbsU9UBlWiyDPUpiLR8d5TJW1NAAfDOxVqqeG6F5bEWsI3Xd3uDwTSJDsMYZTvodSldps0nvsAMuLpw+G2Eeh06mzoa6yb/KKyNrdD7kIyaTTr+oOTfq8+rZspK55cZSUGI4aef3klmowmT9az4FgmGDmys1y6tikvut4GxIYG0JDKIDVlEbFGQpvvyFOCXQwFcR39YoteyS3SLqmHmlgKx+Whqh5W4/wgCiCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ZCHt5Do5K/1qi0o9yGELH7aA+cAsWOWmvP/98qo7Hg=;
 b=LrTNLEpn6m1Ip0NgEWwN5VlIJ7yLvMtsS8jiGZdca05/+WHjsGFzrtK1cRDNtCZGK1y6nG+MUU4yBz40ogwXQIELMzQh6Edad9HH1XCPBJvlgT9MBep9leIlZ1Nr5si4xH9b9HGx4C7XTdIEe262dpabVsUMJCM6rHpuStqNV9+Vj6vuldhCZTUF2o9fYyjOsOlXXPGhg7FwsuD8TzQTX2AndGFnvNsBXVi+LZWd0NCTVEafkNprC2IdhcXocfPPLKmAsM7B7BZSOAgCSu19o6UCzCA0TNaI7KBCtd8PjjT7eP9aHj+C+fEPS1VbjV/uvWbCrURrheSA28sYpnIZmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ZCHt5Do5K/1qi0o9yGELH7aA+cAsWOWmvP/98qo7Hg=;
 b=E1yVhjagywhLb3IgupWL5Np8pccJxP5OvQOQkexFCmnBbMO9Ojckf0QdOvH39wi6cpi9tgtL9FESb6A4Ijn0oVoi9T67oqI7te52NyeS7oBBRIkp23eE5A3QUaK3xj3HDVFm9k4aezWtW++LbRSikOKw8Uvn4KkIUGrzFpwYJgg=
Received: from BN9PR03CA0717.namprd03.prod.outlook.com (2603:10b6:408:ef::32)
 by MW2PR12MB4683.namprd12.prod.outlook.com (2603:10b6:302:5::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.17; Tue, 31 May
 2022 15:14:31 +0000
Received: from BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ef:cafe::46) by BN9PR03CA0717.outlook.office365.com
 (2603:10b6:408:ef::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13 via Frontend
 Transport; Tue, 31 May 2022 15:14:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT013.mail.protection.outlook.com (10.13.176.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5293.13 via Frontend Transport; Tue, 31 May 2022 15:14:30 +0000
Received: from Harpoon.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 31 May
 2022 10:14:30 -0500
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Fix GTT BO CPU mapping
Date: Tue, 31 May 2022 11:14:05 -0400
Message-ID: <20220531151405.150932-1-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 42c1cbb2-7535-4d7f-9732-08da431842e4
X-MS-TrafficTypeDiagnostic: MW2PR12MB4683:EE_
X-Microsoft-Antispam-PRVS: <MW2PR12MB4683961C39BD3B1C191FBC9092DC9@MW2PR12MB4683.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6Heec6CgdwhBfwoaU07cGOQVLvQ8NulNZu9BGy/mNRnQanDjtJyYyLBubfvOCZG2g1RdQ6wQWXpxc1C/B/xOUbcfTBlfNEn1v7NvNEXa8XTWs1HkMtaWo8RwutWLkRB805OZa18qgizFTb4iZd3K9/eks9IBNRA3BMsj4FA2NGGhFWZ19wkAy7jRO/g3P4yA2dud6hDjmElucb1L+kUVlvKVGS+v+ubqlAS3T61b7hNKkz7P+rn3bf5TU8evg449B0sfoYvSuX/TGQrjU1P3ztNAKxaEJ44kndIG+h8lU7b/pjOPWDalcg8/4ixWH/GRI4aVANtR+2uyzdL+dGRi65412o9hMFt5asq1Y5AdmidsBeQDyC2pGf5nltNbIvKmDMmownf9UvL5Po5Obv3m6UeJJ61yn17mnkEFNmW6oMaBBKrbAmWUpiYGdXph6JnE03gnLKYJRIqYz610Zw5g0SF0tOwg8B7bhokrOT99W7uyhZ4iwVe+78IxP9I21Rh0+cWgM6KDyVhMzwb5acPH466e/6Bz3arLz1Euu6GSrP48aQzT/IChqi6O/b0nB6gkoL5xc+vddlWF6bsBZPuKy5joCw8TqsuIvhq9f8yKpfeIZftebjwh2NTnfudF/069J+BrsDJbzfCRDUBqlp7cOIycigtplYUulSMt2f1XJZd+1+1LeLGVQ3DfKcL/+/Tdi7MJ+dFjgLS/rCTvfLqu9w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(36860700001)(316002)(356005)(81166007)(6916009)(36756003)(426003)(70206006)(70586007)(26005)(2906002)(16526019)(336012)(186003)(47076005)(8676002)(83380400001)(4326008)(8936002)(5660300002)(2616005)(508600001)(1076003)(6666004)(40460700003)(82310400005)(86362001)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2022 15:14:30.6118 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42c1cbb2-7535-4d7f-9732-08da431842e4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB4683
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
Cc: Christian Koenig <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Leave CPU-mapped BOs on the validate list to allow restoring their GPU
mappings after page tables were evicted.

Also removed an unused parameter and added kernel-doc comments.

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
CC: Christian Koenig <Christian.Koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  7 ++---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 29 +++++++++++++++----
 drivers/gpu/drm/amd/amdkfd/kfd_events.c       |  5 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      |  6 ++--
 4 files changed, 32 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index f8b9f27adcf5..38c1a685cb24 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -279,10 +279,9 @@ int amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu(
 		struct amdgpu_device *adev, struct kgd_mem *mem, void *drm_priv);
 int amdgpu_amdkfd_gpuvm_sync_memory(
 		struct amdgpu_device *adev, struct kgd_mem *mem, bool intr);
-int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct amdgpu_device *adev,
-		struct kgd_mem *mem, void **kptr, uint64_t *size);
-void amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(struct amdgpu_device *adev,
-		struct kgd_mem *mem);
+int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct kgd_mem *mem,
+					     void **kptr, uint64_t *size);
+void amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(struct kgd_mem *mem);
 
 int amdgpu_amdkfd_gpuvm_restore_process_bos(void *process_info,
 					    struct dma_fence **ef);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 34ba9e776521..839321839ee9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1942,8 +1942,21 @@ int amdgpu_amdkfd_gpuvm_sync_memory(
 	return ret;
 }
 
-int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct amdgpu_device *adev,
-		struct kgd_mem *mem, void **kptr, uint64_t *size)
+/** amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel() - Map a GTT BO for kernel CPU access
+ *
+ * @mem: Buffer object to be mapped for CPU access
+ * @kptr[out]: pointer in kernel CPU address space
+ * @size[out]: size of the buffer
+ *
+ * Pins the BO and maps it for kernel CPU access. The eviction fence is removed
+ * from the BO, since pinned BOs cannot be evicted. The bo must remain on the
+ * validate_list, so the GPU mapping can be restored after a page table was
+ * evicted.
+ *
+ * Return: 0 on success, error code on failure
+ */
+int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct kgd_mem *mem,
+					     void **kptr, uint64_t *size)
 {
 	int ret;
 	struct amdgpu_bo *bo = mem->bo;
@@ -1978,7 +1991,6 @@ int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct amdgpu_device *adev,
 
 	amdgpu_amdkfd_remove_eviction_fence(
 		bo, mem->process_info->eviction_fence);
-	list_del_init(&mem->validate_list.head);
 
 	if (size)
 		*size = amdgpu_bo_size(bo);
@@ -1998,8 +2010,15 @@ int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct amdgpu_device *adev,
 	return ret;
 }
 
-void amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(struct amdgpu_device *adev,
-						  struct kgd_mem *mem)
+/** amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel() - Unmap a GTT BO for kernel CPU access
+ *
+ * @mem: Buffer object to be unmapped for CPU access
+ *
+ * Removes the kernel CPU mapping and unpins the BO. It does not restore the
+ * eviction fence, so this function should only be used for cleanup before the
+ * BO is destroyed.
+ */
+void amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(struct kgd_mem *mem)
 {
 	struct amdgpu_bo *bo = mem->bo;
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
index 4df9c36146ba..3942a56c28bb 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
@@ -377,8 +377,7 @@ int kfd_kmap_event_page(struct kfd_process *p, uint64_t event_page_offset)
 		return -EINVAL;
 	}
 
-	err = amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(kfd->adev,
-					mem, &kern_addr, &size);
+	err = amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(mem, &kern_addr, &size);
 	if (err) {
 		pr_err("Failed to map event page to kernel\n");
 		return err;
@@ -387,7 +386,7 @@ int kfd_kmap_event_page(struct kfd_process *p, uint64_t event_page_offset)
 	err = kfd_event_page_set(p, kern_addr, size, event_page_offset);
 	if (err) {
 		pr_err("Failed to set event page\n");
-		amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(kfd->adev, mem);
+		amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(mem);
 		return err;
 	}
 	return err;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index e3d64ec8c353..a13e60d48b73 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -693,7 +693,7 @@ static void kfd_process_free_gpuvm(struct kgd_mem *mem,
 	struct kfd_dev *dev = pdd->dev;
 
 	if (kptr) {
-		amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(dev->adev, mem);
+		amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(mem);
 		kptr = NULL;
 	}
 
@@ -733,7 +733,7 @@ static int kfd_process_alloc_gpuvm(struct kfd_process_device *pdd,
 	}
 
 	if (kptr) {
-		err = amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(kdev->adev,
+		err = amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(
 				(struct kgd_mem *)*mem, kptr, NULL);
 		if (err) {
 			pr_debug("Map GTT BO to kernel failed\n");
@@ -999,7 +999,7 @@ static void kfd_process_kunmap_signal_bo(struct kfd_process *p)
 	if (!mem)
 		goto out;
 
-	amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(kdev->adev, mem);
+	amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(mem);
 
 out:
 	mutex_unlock(&p->mutex);
-- 
2.32.0

