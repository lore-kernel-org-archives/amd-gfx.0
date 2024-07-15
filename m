Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85664C3DA4B
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jul 2024 12:36:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02DC110E394;
	Mon, 15 Jul 2024 12:36:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LuXiY3k5";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2048.outbound.protection.outlook.com [40.107.212.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A81E10E391
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jul 2024 12:36:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TZ9V6aY4Ku5vDKvnfi7SAJI86Z6Huhka+xBKcEdEnDo2bRzxotczHRThR9QoTc30aR/VVWqjWwvSCU3UtuUDYPDYjeilOHVwiYmqHmVCcLCWz+dIgYe42WYVFFjpUyFtrH3tiHS+Q5FVxydmyAIK/LLL5ZWAAtmqBNEMLdftJ/c9phVvorOSQ1Vjcdll8egI+Trxbl1jUWrPF2TO/a2FYz2vSbRGLN1iJmOcGri+sx0ehUAjvLAz5Z0poFMfgA0MVlStXTldCdiQJHO/zK8uKsBJWe11ThBEUQ9c+8XFR3TOrMyp+nzV6mw6hJu1hY4LRMqcuKHXRf4Yrm4KcBtfMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O/711S4xEm3dULaVjrN7W6mnq8dRPrHSz7ybgCfcf4M=;
 b=DRfzNi8tZt6LJGPHdThMbW2ordSuxepc2QHbTC5NrQFFAaqCGVr+wrCxUtVElq7bA7g4FCakmEB0JCE884Tfi/x7VbwBA/k9NXSW4NgM3I+d6Uqbj1TyPtQ9f2MLBgCBwgNS7++Wsi1kfr4k+yk5MCRiGPmmQZki1nedwLn1IDdhiNJQfSymd7G9yhMwNTnrJWHbm4zjSLrKaD7wV9i0kzR7AiAbJk1+jmkeWpwKw7Ie/eyxu4Uu8N5S48hiwFQjsnKnEKyHUryELkkLTprhoQr6c5poP9g+kfqBnCA+zd9WwO+g7B85sW30jMcyX+I+6RqtO819DFTTCPfVtnCYYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O/711S4xEm3dULaVjrN7W6mnq8dRPrHSz7ybgCfcf4M=;
 b=LuXiY3k5EET0MlP9JbJQQyh2QI7w0nyEesJTcqeKSh0vc9dIt9b1NJxxi+m+tgfmDKl5p4+1p7c3fLveTUL7/+tDdpjrm5cz9eLeQTWlV8EDvNZmFT9yT/hKu3Hjynm4heqX7cRkmPfCVdXygIAHXGYKZgKMM/vB/t/9NFLM/h4=
Received: from BL1PR13CA0326.namprd13.prod.outlook.com (2603:10b6:208:2c1::31)
 by SJ2PR12MB7918.namprd12.prod.outlook.com (2603:10b6:a03:4cc::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Mon, 15 Jul
 2024 12:36:29 +0000
Received: from BL6PEPF0001AB56.namprd02.prod.outlook.com
 (2603:10b6:208:2c1:cafe::56) by BL1PR13CA0326.outlook.office365.com
 (2603:10b6:208:2c1::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.13 via Frontend
 Transport; Mon, 15 Jul 2024 12:36:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB56.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Mon, 15 Jul 2024 12:36:29 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 15 Jul
 2024 07:36:27 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <Alexander.Deucher@amd.com>,
 <christian.koenig@amd.com>, Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH 5/9] drm/amdkfd: Ensure user queue buffers residency
Date: Mon, 15 Jul 2024 08:34:58 -0400
Message-ID: <20240715123502.7013-6-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240715123502.7013-1-Philip.Yang@amd.com>
References: <20240715123502.7013-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB56:EE_|SJ2PR12MB7918:EE_
X-MS-Office365-Filtering-Correlation-Id: 764f521d-de3b-4c73-f384-08dca4cac03e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+E3D2qRVMMV5tHWSXUM4Rp+95DMmaJsZl803bVzLW3QWD9v4bgiXHzuyG+ch?=
 =?us-ascii?Q?YhuQoeNGFKwbV5WZbzl+4kpmns7gQsYRmuban93oRjWg2peDElTi2DjlcT/+?=
 =?us-ascii?Q?wgZJBI3ECn9mYm12PPNPAn9Lq9ISukaeWbkmCK/5uiaegWLNJk1ZsdL+3yEO?=
 =?us-ascii?Q?/Pa/AP/qRe/m3dKXjrJ9Pk/rM0Smnidc6jgl7E5uM1zIFjd7Jns7A9hrfIBF?=
 =?us-ascii?Q?qm8waA+VatPMwNEVkM9+SdAMvW+YsnRaT/5LhIzV0RyKAyFmWhRsIV7z9crH?=
 =?us-ascii?Q?cdK1VD0QqACz59kD/JP8d0C2qN2UfcKLYUrTr8E05VHqtsR3GYzAVCSP5+Xd?=
 =?us-ascii?Q?Nz7hujmMAVktmG9ZD/LR11oYuks2KVabvUtsKw/hMIoS78C1WHj3ZjSyd7pP?=
 =?us-ascii?Q?SHXLon2HwC3ahnPk2/XvZijG99Ey9b/NxJ2LcH42sQvJZmA4vHwdZbXSTagi?=
 =?us-ascii?Q?2WAwV5cowD7Kdf7ztR1Qfji1BV2eDbG/aRbWxAORdFnjYVzvWUXrxHLSvHv/?=
 =?us-ascii?Q?l/neIyNHeBLqQOcu9LV19K7CZAMunB1CTUt7X3Vr8NkvMbEKLNHxhhV4syBO?=
 =?us-ascii?Q?HcrEFtL8uxFxBfmD72+Hwpkgj/Tvub6VyNa8JLmbWaNDA5PLXNWuaMakaHtO?=
 =?us-ascii?Q?iBaI25DAX3CsJO9RHlca8NEIvZTQyTSQJuKar3Na8Z6PvMPd28hV+jKHyksL?=
 =?us-ascii?Q?WWzgKg7jJXdkmERHAlS8fApWDhwH7uwQBpcMqyYwt0wyN/od2IWRR2uW39WQ?=
 =?us-ascii?Q?4FDRALH0AC7icrV0pNv9C3SMjeLXv/NkvQFzIE50JOIxsrV0YSjphsAhmOvh?=
 =?us-ascii?Q?aGbZK24CYWgQmlf3FzCBayrEfV68705iowlfmcXweIKHuK+jhEA1FFYTpPJl?=
 =?us-ascii?Q?5aKDTrOZhMeFdS3WfOtiGDmCTCH1BEialtRgXQNCiBPqtbGEYoU/8cTlOZ98?=
 =?us-ascii?Q?BLB7rU3cDsdrjawuoMGWEAKXO3mKYBVLlwN17x/c7fNbyOi/1+LOIDliAJNl?=
 =?us-ascii?Q?Tjd5cPDUlm3amLIRUzWehrlwxdIbNr9lcOc2gqgxl807iJQPLEODcUJDXlYK?=
 =?us-ascii?Q?a8wqraqlg5wxJH2MV99mrcSNmnfX4eb2QX+StpTq0gCez1ppiXLzcuMhL7hT?=
 =?us-ascii?Q?77qzXRDCWjVypS3MPFMrU5HAVrW7qLXYjqQepLfB3Vp9TxKQEWUJudceIEb9?=
 =?us-ascii?Q?fYPko414VHAMBf8oUQ5n9+zEyuMp+pDWFuuSuvf2kCnd84zRJ9ZX4iig6bKM?=
 =?us-ascii?Q?453zUpZsmE0iVzsDns9Yw2ej1frxzAT5O1rc87Iz9+k9zU+WOIU+D1+9KqH/?=
 =?us-ascii?Q?fLe3j07maLyMCl8iAYMmzQwlKkMWdLKgYPzLDq0snPoweCu73KuL5VArOinP?=
 =?us-ascii?Q?mdXFohUGfO89ACQZiTuqaUpBLDF+NYdGaStE5E+W36hu3RGVCwZSw2FqwypX?=
 =?us-ascii?Q?2/wSSSCBsnlMrotKJs0v5M3akUOC7O2g?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 12:36:29.4217 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 764f521d-de3b-4c73-f384-08dca4cac03e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB56.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7918
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

Add atomic queue_refcount to struct bo_va, return -EBUSY to fail unmap
BO from the GPU if the bo_va queue_refcount is not zero.

Create queue to increase the bo_va queue_refcount, destroy queue to
decrease the bo_va queue_refcount, to ensure the queue buffers mapped on
the GPU when queue is active.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 14 ++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h    |  6 ++++
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  3 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c        | 34 ++++++++++++++++---
 5 files changed, 49 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 0ab37e7aec26..6d5fd371d5ce 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1252,7 +1252,7 @@ static int unreserve_bo_and_vms(struct bo_vm_reservation_context *ctx,
 	return ret;
 }
 
-static void unmap_bo_from_gpuvm(struct kgd_mem *mem,
+static int unmap_bo_from_gpuvm(struct kgd_mem *mem,
 				struct kfd_mem_attachment *entry,
 				struct amdgpu_sync *sync)
 {
@@ -1260,11 +1260,18 @@ static void unmap_bo_from_gpuvm(struct kgd_mem *mem,
 	struct amdgpu_device *adev = entry->adev;
 	struct amdgpu_vm *vm = bo_va->base.vm;
 
+	if (bo_va->queue_refcount) {
+		pr_debug("bo_va->queue_refcount %d\n", bo_va->queue_refcount);
+		return -EBUSY;
+	}
+
 	amdgpu_vm_bo_unmap(adev, bo_va, entry->va);
 
 	amdgpu_vm_clear_freed(adev, vm, &bo_va->last_pt_update);
 
 	amdgpu_sync_fence(sync, bo_va->last_pt_update);
+
+	return 0;
 }
 
 static int update_gpuvm_pte(struct kgd_mem *mem,
@@ -2191,7 +2198,10 @@ int amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu(
 		pr_debug("\t unmap VA 0x%llx - 0x%llx from entry %p\n",
 			 entry->va, entry->va + bo_size, entry);
 
-		unmap_bo_from_gpuvm(mem, entry, ctx.sync);
+		ret = unmap_bo_from_gpuvm(mem, entry, ctx.sync);
+		if (ret)
+			goto unreserve_out;
+
 		entry->is_mapped = false;
 
 		mem->mapped_to_gpu_memory--;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index bc42ccbde659..d7e27957013f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -90,6 +90,12 @@ struct amdgpu_bo_va {
 	bool				cleared;
 
 	bool				is_xgmi;
+
+	/*
+	 * protected by vm reservation lock
+	 * if non-zero, cannot unmap from GPU because user queues may still access it
+	 */
+	unsigned int			queue_refcount;
 };
 
 struct amdgpu_bo {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 202f24ee4bd7..65a37ac5a0f0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1384,8 +1384,7 @@ static int kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
 		err = amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu(
 			peer_pdd->dev->adev, (struct kgd_mem *)mem, peer_pdd->drm_priv);
 		if (err) {
-			pr_err("Failed to unmap from gpu %d/%d\n",
-			       i, args->n_devices);
+			pr_debug("Failed to unmap from gpu %d/%d\n", i, args->n_devices);
 			goto unmap_memory_from_gpu_failed;
 		}
 		args->n_success = i+1;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index d0dca20849d9..95fbdb12beb1 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1291,6 +1291,7 @@ void print_queue_properties(struct queue_properties *q);
 void print_queue(struct queue *q);
 int kfd_queue_buffer_get(struct amdgpu_vm *vm, void __user *addr, struct amdgpu_bo **pbo,
 			 u64 expected_size);
+void kfd_queue_buffer_put(struct amdgpu_vm *vm, struct amdgpu_bo **bo);
 int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_properties *properties);
 int kfd_queue_release_buffers(struct kfd_process_device *pdd, struct queue_properties *properties);
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
index 0e661160c295..3fd386dcb011 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
@@ -106,6 +106,7 @@ int kfd_queue_buffer_get(struct amdgpu_vm *vm, void __user *addr, struct amdgpu_
 	}
 
 	*pbo = amdgpu_bo_ref(mapping->bo_va->base.bo);
+	mapping->bo_va->queue_refcount++;
 	return 0;
 
 out_err:
@@ -113,6 +114,19 @@ int kfd_queue_buffer_get(struct amdgpu_vm *vm, void __user *addr, struct amdgpu_
 	return -EINVAL;
 }
 
+void kfd_queue_buffer_put(struct amdgpu_vm *vm, struct amdgpu_bo **bo)
+{
+	if (*bo) {
+		struct amdgpu_bo_va *bo_va;
+
+		bo_va = amdgpu_vm_bo_find(vm, *bo);
+		if (bo_va)
+			bo_va->queue_refcount--;
+	}
+
+	amdgpu_bo_unref(bo);
+}
+
 int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_properties *properties)
 {
 	struct amdgpu_vm *vm;
@@ -166,10 +180,20 @@ int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_prope
 
 int kfd_queue_release_buffers(struct kfd_process_device *pdd, struct queue_properties *properties)
 {
-	amdgpu_bo_unref(&properties->wptr_bo);
-	amdgpu_bo_unref(&properties->rptr_bo);
-	amdgpu_bo_unref(&properties->ring_bo);
-	amdgpu_bo_unref(&properties->eop_buf_bo);
-	amdgpu_bo_unref(&properties->cwsr_bo);
+	struct amdgpu_vm *vm;
+	int err;
+
+	vm = drm_priv_to_vm(pdd->drm_priv);
+	err = amdgpu_bo_reserve(vm->root.bo, false);
+	if (err)
+		return err;
+
+	kfd_queue_buffer_put(vm, &properties->wptr_bo);
+	kfd_queue_buffer_put(vm, &properties->rptr_bo);
+	kfd_queue_buffer_put(vm, &properties->ring_bo);
+	kfd_queue_buffer_put(vm, &properties->eop_buf_bo);
+	kfd_queue_buffer_put(vm, &properties->cwsr_bo);
+
+	amdgpu_bo_unreserve(vm->root.bo);
 	return 0;
 }
-- 
2.43.2

