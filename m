Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 102BFC71153
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Sep 2023 19:56:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9439410E1C1;
	Mon, 11 Sep 2023 19:56:51 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FA5D10E1B8
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Sep 2023 19:56:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pq2w3FgLVOvzOyqcTgyGFDLHILbx52D+h26V6cdufIznAKPMnng2Pu2G/AqfauW3jxZoGPfOVSZV4jeLNK/rqCyRkRBXQCgkpH0JDA5NggvYLvsCYsruwilTA4f67yUATtIrZSpuupWl0jgKy4asO+d+BaeMRxcgE4aYpuOqIGQXr5xbFJ7UJAkuV2XSHWPN3FDzTB/+zc3NjfBT3dxTr9c+h09I8Evs07XpbDQpGDac6lX/sKAfMdNmaYXgRV4EQDj7GhxIrCedb3wBJXW3p0Rwi7HiqUo4w/C8hb2+nzGlgZNcm75U1ZXNiLmITWo2VGpRY7IuTt4mYppGjhYUJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VGZ4CCP4i7bdC3fK9sI64/I9sEVa65GpFLnQn+arM38=;
 b=keGQcTo4KFvX3z4WyLi0pGcQy0z9FvZWei15WY9RlCSsIdoaH1rTTzy0DBz6W2JRErWgFAN5LMm5wouGbOGJ2wKzQP5+riqTiDR7Ntfj9DGjrzHRPo/W84HFNiXLgVwNZUJ7Ppi4p1ktndqCzSJQeaWuS2O3ssApBsgb6YiOeUnzLj518R1HjDmn/PzxE4V2wClmtmBX6TGzoSTV81zIn3Cy0p2Lq+n3pt2OTSYd/0OGa7o/MtNbTU3XW6G8s4Inyrn3NXu8RjHHo/YAEv8QFoIVjeEvSkBOJi3p1D+BChzziK24Bax5bcd3Hv981QA1to5dn0l/mGWJq65n/IfXLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VGZ4CCP4i7bdC3fK9sI64/I9sEVa65GpFLnQn+arM38=;
 b=zj+fTkmjEttsBbZ094kTQnO70K/EjFU9bBExOh+enyR3QbD3spEPu41Xo1A6yqH3wy5OUck/lJgEiIm6z/T+Fg4sAtrCsS/bsxM069oVNFH35bP4XZbA5PxKYgU0ulwrIfTEzC6kVYrhiRW3O6OrwznPNLK4ptlTUSzSaaaB3DU=
Received: from MN2PR03CA0029.namprd03.prod.outlook.com (2603:10b6:208:23a::34)
 by SA1PR12MB7174.namprd12.prod.outlook.com (2603:10b6:806:2b1::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Mon, 11 Sep
 2023 19:56:46 +0000
Received: from BL6PEPF0001AB76.namprd02.prod.outlook.com
 (2603:10b6:208:23a:cafe::b3) by MN2PR03CA0029.outlook.office365.com
 (2603:10b6:208:23a::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35 via Frontend
 Transport; Mon, 11 Sep 2023 19:56:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB76.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.17 via Frontend Transport; Mon, 11 Sep 2023 19:56:45 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 11 Sep
 2023 14:56:44 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdkfd: Move dma unmapping after TLB flush
Date: Mon, 11 Sep 2023 15:55:17 -0400
Message-ID: <20230911195517.8548-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB76:EE_|SA1PR12MB7174:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cafe8d5-a485-4eaf-8719-08dbb3013a42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RItc5tcoWShKt+DdSb+JiZVO89F6kXkCYYm/VAf47JDtPXBabNN0FwTzf+VL7EgUf8b5FlG7ijt2JVimcB2K+YQSDC76rdGOpTjLz56TnKGjfO7Ogg8u4hULJ2bVkRjM/NymrUe0Wro08xZgce5vAnQ1tC8LWLLIdZkcxQxouJJwN0oHHmSl9uC2PkFmPJwnP3vfR+tmqaeRvT1Vr70Pbhr5lS1Vww5aWzikS28xRX56yzdqjSTRTy5a9pkIXauhFVI9btV9WODEJ6OY+m47RWdiMSymTrW6vgXkmumcyLs+7ed73wMsxDfL0WQrVeL0wzyrTL0AUlYqlaZ0HJ02f86qW3Ulh6AV0OV/xW1McVXRuLcUa0JXejpqkr1TjAQ5iNBCyrJnKvSt4v4fkxH7v0wLuFlRXGVBrTcHWu4GparguxTWRWWqXTXuw3tUqj2LpXcqJcVqwyUQj5O+PjoFfwwkNxfI0NEGvoTU7X0KcxqgWgmOVpSIc0b3GlHmvWBMvh9yPlRK+8xzvKav4wSmQ/gzxD6auvtqa6r3ok+V8Kf5plG4EqqhtQyeHMSTTImZ8NEWoelyA+jykqKhy5CJKomygYF+7ui98JZADCB9hnYusSbUcE/5RLHDLef93b0f89aslJLDWAaqY9FfuwryT0L0Tbbk+4uBisdprasym8fDy2E22nBJgBiLPwyLqTcIryN3rAxCLITTHUjSNdac0I5gU7Y52t7QL/wwH8mv/G68blePlU9nw3LHzL0fZg2phRQuFYPf5AYTNWDcgz75UA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(346002)(136003)(376002)(82310400011)(1800799009)(186009)(451199024)(36840700001)(40470700004)(46966006)(36756003)(82740400003)(6666004)(7696005)(1076003)(2616005)(40460700003)(41300700001)(83380400001)(336012)(16526019)(4326008)(26005)(426003)(54906003)(316002)(6916009)(70206006)(70586007)(8676002)(8936002)(2906002)(86362001)(36860700001)(81166007)(478600001)(47076005)(40480700001)(5660300002)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 19:56:45.6522 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cafe8d5-a485-4eaf-8719-08dbb3013a42
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB76.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7174
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
Cc: Philip Yang <Philip.Yang@amd.com>, Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Otherwise GPU may access the stale mapping and generate IOMMU
IO_PAGE_FAULT.

Move this to inside p->mutex to prevent multiple threads mapping and
unmapping concurrently race condition.

After kfd_mem_dmaunmap_attachment is removed from unmap_bo_from_gpuvm,
kfd_mem_dmaunmap_attachment is called if failed to map to GPUs, and
before free the mem attachment in case failed to unmap from GPUs.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  1 +
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 22 +++++++++++++++---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 23 ++++++++++++-------
 3 files changed, 35 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 559f14cc0a99..dff79a623f4a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -304,6 +304,7 @@ int amdgpu_amdkfd_gpuvm_map_memory_to_gpu(struct amdgpu_device *adev,
 					  struct kgd_mem *mem, void *drm_priv);
 int amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu(
 		struct amdgpu_device *adev, struct kgd_mem *mem, void *drm_priv);
+void amdgpu_amdkfd_gpuvm_dmaunmap_mem(struct amdgpu_vm *vm, struct kgd_mem *mem);
 int amdgpu_amdkfd_gpuvm_sync_memory(
 		struct amdgpu_device *adev, struct kgd_mem *mem, bool intr);
 int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct kgd_mem *mem,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index b5b940485059..ae767ad7afa2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1249,8 +1249,6 @@ static void unmap_bo_from_gpuvm(struct kgd_mem *mem,
 	amdgpu_vm_clear_freed(adev, vm, &bo_va->last_pt_update);
 
 	amdgpu_sync_fence(sync, bo_va->last_pt_update);
-
-	kfd_mem_dmaunmap_attachment(mem, entry);
 }
 
 static int update_gpuvm_pte(struct kgd_mem *mem,
@@ -1305,6 +1303,7 @@ static int map_bo_to_gpuvm(struct kgd_mem *mem,
 
 update_gpuvm_pte_failed:
 	unmap_bo_from_gpuvm(mem, entry, sync);
+	kfd_mem_dmaunmap_attachment(mem, entry);
 	return ret;
 }
 
@@ -1910,8 +1909,10 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
 		mem->va + bo_size * (1 + mem->aql_queue));
 
 	/* Remove from VM internal data structures */
-	list_for_each_entry_safe(entry, tmp, &mem->attachments, list)
+	list_for_each_entry_safe(entry, tmp, &mem->attachments, list) {
+		kfd_mem_dmaunmap_attachment(mem, entry);
 		kfd_mem_detach(entry);
+	}
 
 	ret = unreserve_bo_and_vms(&ctx, false, false);
 
@@ -2085,6 +2086,21 @@ int amdgpu_amdkfd_gpuvm_map_memory_to_gpu(
 	return ret;
 }
 
+void amdgpu_amdkfd_gpuvm_dmaunmap_mem(struct amdgpu_vm *vm, struct kgd_mem *mem)
+{
+	struct kfd_mem_attachment *entry;
+
+	mutex_lock(&mem->lock);
+
+	list_for_each_entry(entry, &mem->attachments, list) {
+		if (entry->bo_va->base.vm != vm)
+			continue;
+		kfd_mem_dmaunmap_attachment(mem, entry);
+	}
+
+	mutex_unlock(&mem->lock);
+}
+
 int amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu(
 		struct amdgpu_device *adev, struct kgd_mem *mem, void *drm_priv)
 {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 08687ce0aa8b..645628ff1faf 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1432,17 +1432,24 @@ static int kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
 			goto sync_memory_failed;
 		}
 	}
-	mutex_unlock(&p->mutex);
 
-	if (flush_tlb) {
-		/* Flush TLBs after waiting for the page table updates to complete */
-		for (i = 0; i < args->n_devices; i++) {
-			peer_pdd = kfd_process_device_data_by_id(p, devices_arr[i]);
-			if (WARN_ON_ONCE(!peer_pdd))
-				continue;
+	/* Flush TLBs after waiting for the page table updates to complete */
+	for (i = 0; i < args->n_devices; i++) {
+		struct amdgpu_vm *vm;
+
+		peer_pdd = kfd_process_device_data_by_id(p, devices_arr[i]);
+		if (WARN_ON_ONCE(!peer_pdd))
+			continue;
+		if (flush_tlb)
 			kfd_flush_tlb(peer_pdd, TLB_FLUSH_HEAVYWEIGHT);
-		}
+
+		/* Remove dma mapping after tlb flush to avoid IO_PAGE_FAULT */
+		vm = drm_priv_to_vm(peer_pdd->drm_priv);
+		amdgpu_amdkfd_gpuvm_dmaunmap_mem(vm, mem);
 	}
+
+	mutex_unlock(&p->mutex);
+
 	kfree(devices_arr);
 
 	return 0;
-- 
2.35.1

