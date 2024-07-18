Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC811C3DA70
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jul 2024 21:06:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DDBE10EB2C;
	Thu, 18 Jul 2024 21:06:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="D5Nqo/O/";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2042.outbound.protection.outlook.com [40.107.96.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF4A810EB2C
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jul 2024 21:06:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TIIND/tpjAlyzNTakulyj+HR4PxNW92BtAAC4imMMpIAINTs2wbtOy5nEjTGE1ncEUNdINrH8esSoIo3oMLWfC3UEggmU3xAcQjETHOGbnZmoYWcFslpQmwNOKjGNLGEZAlwzvwXZJ6olpcgMydnrHkXXQEbSUJi9XoH69PxXLl9Lwu9w5u5ruTpqCZS6uyDOuCi6TIaYr+J1uQL5B+SDQjnC9/nwMlTrt68g4W6G6uLNYvbwmhtKEUBJIz7zp2rF194paGGd11BOuq5e/4fYk2C8ylZbYXvuALIDnXySf/ARpR9zKz4YJLR6CercRTe77l0u+K7YtvcmWMB+6wVmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pXUozK2lJ2PmSkYyjQABUP5JPtoAikEWiPbCa9J58sI=;
 b=MUREalAt7iD2Xrqh6obLRhitQEosgDU5Surr+hEvQYzbVI59tCaKLmZ92FbomxDn50aVf63gS8hGp04ugjSMhNdqxUjyXMstfVCgXttBFpDUr8UE0g7Ug0GSPVVcOZSNE5esWCoUqIBUycyPo10ua8SSzp0ZkhbueVH/Au8P6Ayn5ZLZ2F8K+cw30CH05wjDy5+xusfkAIjdnGce1VGqFoPxrzqKqlNbvuR3hM9Kebqdgh168PxQBWaiZGozHNRX4UYW3DGZfhRg04Diw+cOXnRsZJhJvSbnuT+AA8WSI4TBluo0RV1YimNSrNoLqdlsj0dZrIDVN6xGG1iq+HAwVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pXUozK2lJ2PmSkYyjQABUP5JPtoAikEWiPbCa9J58sI=;
 b=D5Nqo/O/eTbJ1DZfN383NGHzun5AzDPK1jb9dDro82Y9bqhg5atvdRBLsZaKz2UwiNpBFV1QQURTyaEWMf4nVNgA5sRgWIUeqSReN8aLKFI9HTB7g5x0z3vHBz4nJQfp9WeX8wnQBfb5VHP9l+PnKip4kMfnd8KUKVTgcrDz3XI=
Received: from SA0PR11CA0101.namprd11.prod.outlook.com (2603:10b6:806:d1::16)
 by CY8PR12MB7267.namprd12.prod.outlook.com (2603:10b6:930:55::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Thu, 18 Jul
 2024 21:06:16 +0000
Received: from SA2PEPF00003AE5.namprd02.prod.outlook.com
 (2603:10b6:806:d1:cafe::9e) by SA0PR11CA0101.outlook.office365.com
 (2603:10b6:806:d1::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16 via Frontend
 Transport; Thu, 18 Jul 2024 21:06:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AE5.mail.protection.outlook.com (10.167.248.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 18 Jul 2024 21:06:16 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 18 Jul
 2024 16:06:13 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <Alexander.Deucher@amd.com>,
 <christian.koenig@amd.com>, Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH v2 5/9] drm/amdkfd: Ensure user queue buffers residency
Date: Thu, 18 Jul 2024 17:05:54 -0400
Message-ID: <20240718210558.26340-6-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240718210558.26340-1-Philip.Yang@amd.com>
References: <20240718210558.26340-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE5:EE_|CY8PR12MB7267:EE_
X-MS-Office365-Filtering-Correlation-Id: 37557359-8761-48ed-155d-08dca76d76da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?w0ixMoGafZ7iZYQEYr5o8ATkrz+5fo5EgmOBnUSqpxtE//bOyEb+IFSZwOZK?=
 =?us-ascii?Q?2gHShY2POYTPmHXq38TQ8Av1n0rcuXI73tLGogdfyGvXNsRjl0cqlWKOzbo4?=
 =?us-ascii?Q?yganO7AuH6J6Qo1qi8aHqyIAo7AIhyubYMmQV523AV8KVCQoetLUjXuTjHdV?=
 =?us-ascii?Q?VD2mwJUx9zHGWowdYgxO7+2x5XMvyeWvX1M8lfYoolvUzxO+vkG8Yx5YIrjH?=
 =?us-ascii?Q?ZpKUpZ/85WbCpKY5wlB1uNRxNx6qF+dQE4QYwmL8kIog9/T1a2h8BwQbHc1T?=
 =?us-ascii?Q?sPnd0PCuiQBc8XGE3L3otpgNOXigmT7yTG0AMN3ZaNZX4uG1hEnJn1v6kgXt?=
 =?us-ascii?Q?U0Sir5sPbyuiddH1aLGz+FJa6jPr+YDxlL4fi916QWDvwGas+KsRz3ss8mRH?=
 =?us-ascii?Q?ErQMNbB4jxdVwY7eCdlNl+EFDMXPvviznZbIJrFmNBUc46e+cM1le7b7fqlu?=
 =?us-ascii?Q?g4pBT88qeLFADeBcrPKr+rgPdABhQwcWkHVkzMr/deZRCms0tyYd1q2emRqL?=
 =?us-ascii?Q?aSAIVFENsGZO8ce4OyWySSav1muNMlskd/WgYhaxQBmI5YqLVjm2MpPBz5l/?=
 =?us-ascii?Q?63PJCHeBvY0QBNwODhwEad8aDqDSVA3Zrqh6HhKUgaZomJQcA8aRJJ/MkOTU?=
 =?us-ascii?Q?S705phDN+h4qA7qQnP+X/vQTUD2C4DDdjPF0+EJRz4mUzOFHwr+tt9Dqqg3h?=
 =?us-ascii?Q?ntGEPwtFeoBGbdI/q/fBLVtIN/QoPzBvJS2TKo8+qMUIx6fVFkaNdkQOJBU8?=
 =?us-ascii?Q?M2474kLwhfGA5IAZJXbzWiCmT3bI3MWPkjkKnAFLm7AjbBlka0JZLJwAsQHI?=
 =?us-ascii?Q?WLv+I8wxoBwXr6uaKiA5NWVTKzTgiV94U5x0nB6XGKSTjwvz6OGjEwwQrvvX?=
 =?us-ascii?Q?DqQLMUJE4EppOOuj1TI8PmLV2DkaA2ey9vdxOuJdm2grINdmxqOiN/x0clgI?=
 =?us-ascii?Q?pETZcXB0QafvDtkNM86Mu3/s763ilzgTihx1tk46sHoEo/Nyajrtewu5i7+m?=
 =?us-ascii?Q?ax9vyC0dH/e3qmJUdNCP2nTjJycC8/W9c85U2c55yu0k9y76kQc173CqeapK?=
 =?us-ascii?Q?vF5rHnayz8X5LKpq6SBVoDZ8ZWyM8OrtIv/ThRONqd+5h4R5izmbgoFIU63m?=
 =?us-ascii?Q?SgU6oRiiOtIrJurSI4DBCPSq3pNP3zj05/Mj+hsRiIvPdi14lQj70ZcTeNRD?=
 =?us-ascii?Q?4xXg6IzkWwu3pbesBMCLtsqkRDqAzixe05Rf07+y0sdWInUuJPP39WIjlp9F?=
 =?us-ascii?Q?dmZ57UObzzN0cCDSUMmkYVXufow83w7GjTK/2qL/rs3IReZLmJO9g3aYOVud?=
 =?us-ascii?Q?BlOuzR9CLMGsaP/vbl9YDlkC40PJ+/4v+D1tR4/E8PTkXqeUIWKdO8IhqczW?=
 =?us-ascii?Q?G1J9y8aEgehJAEdJ6xeAgpR1dLTwtlutn/i5xZrmEbJThL3k5HnsDHBGXa1F?=
 =?us-ascii?Q?yCz3lLEVXJriyYSf3zV3pCtLf89j+i+x?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 21:06:16.6263 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37557359-8761-48ed-155d-08dca76d76da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7267
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
index 80d8080c5764..c31589043d5b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1292,6 +1292,7 @@ void print_queue_properties(struct queue_properties *q);
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

