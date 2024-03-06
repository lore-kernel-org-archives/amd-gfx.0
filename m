Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CAC7C54E41
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Mar 2024 14:41:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9725113240;
	Wed,  6 Mar 2024 14:41:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="19qLo2fg";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 862EC11323F
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Mar 2024 14:41:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DjMLTDGTGWTp8jHCM9/o0CxheZWe/RkwfsIztDnGY5HV31uMp0qYOwdms1/glTEvJ5AYaqx1wTisWQ/DMxvHUhPp00HUr1OVZJNFIspzIg2TCA/BpixO2YROnvnjH4mLa9C3H4g6Eu32i8CyDZJjsR0JL9TLlkDCJmApXwgtNHczQ1Ax5E8Cfp2PUyIkUBmd+tyewqFn32vIj4D0CrecKsH3l/OXNUnz4zIp+6eGDvHrNBtw795a9XP4Kx01kIPgACC4++LFoGhuvGU0A2dZ/w3CkzKUAQnyc+QK1ofxJ2v95SwUWGn2KRrheHwWbG3VrrMqTdEzvtntZoyRySxWbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1B4wfVcG3nSOB+URrTo+Q/F9UP1LZp3iTOK8ehNAXFU=;
 b=mMujWRX3yb4OBfdP9f8qdHIp5b6GAj2FrG93Tq/sFvK6FtDS7Lg9PLp/eFC09COI7uCJJUOuExgK5o0Nz2zdtdmkBMiaMfNSEUOJW27Le0jo/5f7DBP9mIhsVCpXyLwzNhdzIwUnkX987JFVm9dHv5kvfzOxBX8wX/ubA9XEN5DTfp+N610J2Wr2oLIY+XoIVnFPI2SQj+dc4pQqDbRAA5FUzGUx8038G7QBj+XNYFNYxxB95FRtT+VfBzW0eZFtxLrix9Y63FMrOIFuwXYifJcJcaE3h06m/KJ60Nfz4C64x9xSaZuTtLvFyIK9cnBNiZqSRQ7diU+m5YwaWx86qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1B4wfVcG3nSOB+URrTo+Q/F9UP1LZp3iTOK8ehNAXFU=;
 b=19qLo2fgKEAj3AjxgPNb6b1A1voqqjUt73RMRHv7GGHgcIBXEX84VRJei5KBhSxa9S8URapb772hm3ZK8/T7tJeu9SYklS/OHKFNWWQm/qZ8ZpJAfFeMQjCQA+60DL/rSoZnmaXOVXgx/a1oSohtN1Neg1RrWNtGXgIlxIQpflc=
Received: from CH2PR05CA0050.namprd05.prod.outlook.com (2603:10b6:610:38::27)
 by MW6PR12MB7087.namprd12.prod.outlook.com (2603:10b6:303:238::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Wed, 6 Mar
 2024 14:41:44 +0000
Received: from CH3PEPF0000000A.namprd04.prod.outlook.com (2603:10b6:610:38::4)
 by CH2PR05CA0050.outlook.office365.com (2603:10b6:610:38::27) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7339.25 via Frontend Transport; Wed, 6 Mar 2024 14:41:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF0000000A.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.11 via Frontend Transport; Wed, 6 Mar 2024 14:41:43 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 6 Mar
 2024 08:41:41 -0600
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Philip Yang <yangp@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>,
 "Rajneesh Bhardwaj" <rajneesh.bhardwaj@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Shashank Sharma <shashank.sharma@amd.com>
Subject: [PATCH v5 1/2] drm/amdgpu: implement TLB flush fence
Date: Wed, 6 Mar 2024 15:41:14 +0100
Message-ID: <20240306144115.1007-1-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000A:EE_|MW6PR12MB7087:EE_
X-MS-Office365-Filtering-Correlation-Id: 03a9d052-0899-4e48-099c-08dc3deb8aed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RV2wldimfNNfUlsapPApknCYgXf8dH9oMN97Qw2OrbyNUhFFnwpNO4aGAuzqWOlNTaDWd60IYnfeTvMLO6eSTWCvWbaeV9Pa2MrS4MNuHwBm5xrQnXwg1j8PRnjZ4WS8khCdniTBY74zjWKk67T//JqcAPg/1gChAJSJWkfwEXPOLTWgED24cV0Pet4DlG4vrYX13jaf3n2kbbrI1vKzX92/+5JwyHIlRSN3dT+SvkgzkR+GhE54F8aXMiH/E+Wyr8dn48IMgAaQRq7ZZ8Umh0LLFF0xOkOlw+/jueyP4VcQh7G/3OTbz8LHlb3QQnhTDBzPoLV3aLqSOqcs/fjcmi0gLgUdjn6b1dubwi+zTtYo6crdvHS6U2sTSi5vwOEqPIDiJA3sp8Macv5v0lWtd8G1ApUBqUzwW4+LcisROiduCDg+cdAgJLvkj8xp/xm9D49j24WggQQV/IZ0mMIMVLoPJfva67RQ8+mVaY8vx9qLxAG1U7tZHnCohylAGVbX5zktVK13x2GNcutNPLnw2iOtHTr0RuYatTIk+PLyuKMfiSYb6pGjzHDMCN+haiILl+8bgauY1Zr73DKaZmOB71LyJHHvFmDe0NBGwwCmsilDtYd+6jyPbUFGUPOZgVQGaqxCgoXvOwjcgjtzi3e2QPXRv3pBeygOdNDEWr9/gVI5owgXB3ZM/MBXFoEDntTU/w8lmKvpNDIZz6Jp+Qe+KFiZCN6gO2FkPGP90uq1+kLtb+EqyVGmXJnyp/r50080
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(82310400014); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 14:41:43.6542 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03a9d052-0899-4e48-099c-08dc3deb8aed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7087
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

From: Christian König <christian.koenig@amd.com>

The problem is that when (for example) 4k pages are replaced
with a single 2M page we need to wait for change to be flushed
out by invalidating the TLB before the PT can be freed.

Solve this by moving the TLB flush into a DMA-fence object which
can be used to delay the freeing of the PT BOs until it is signaled.

V2: (Shashank)
    - rebase
    - set dma_fence_error only in case of error
    - add tlb_flush fence only when PT/PD BO is locked (Felix)
    - use vm->pasid when f is NULL (Mukul)

V4: - add a wait for (f->dependency) in tlb_fence_work (Christian)
    - move the misplaced fence_create call to the end (Philip)

V5: - free the f->dependency properly (Christian)

Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Felix Kuehling <Felix.Kuehling@amd.com>
Cc: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Shashank Sharma <shashank.sharma@amd.com>
Signed-off-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile           |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        |  10 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |   4 +
 .../gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c  | 112 ++++++++++++++++++
 4 files changed, 128 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index fa26a4e3a99d..91ab4cf29b5b 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -70,7 +70,8 @@ amdgpu-y += amdgpu_device.o amdgpu_doorbell_mgr.o amdgpu_kms.o \
 	amdgpu_cs.o amdgpu_bios.o amdgpu_benchmark.o \
 	atombios_dp.o amdgpu_afmt.o amdgpu_trace_points.o \
 	atombios_encoders.o amdgpu_sa.o atombios_i2c.o \
-	amdgpu_dma_buf.o amdgpu_vm.o amdgpu_vm_pt.o amdgpu_ib.o amdgpu_pll.o \
+	amdgpu_dma_buf.o amdgpu_vm.o amdgpu_vm_pt.o amdgpu_vm_tlb_fence.o \
+	amdgpu_ib.o amdgpu_pll.o \
 	amdgpu_ucode.o amdgpu_bo_list.o amdgpu_ctx.o amdgpu_sync.o \
 	amdgpu_gtt_mgr.o amdgpu_preempt_mgr.o amdgpu_vram_mgr.o amdgpu_virt.o \
 	amdgpu_atomfirmware.o amdgpu_vf_error.o amdgpu_sched.o \
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 0960e0a665d3..310aae6fb49b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -988,6 +988,15 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 
 	r = vm->update_funcs->commit(&params, fence);
 
+	/* Prepare a TLB flush fence to be attached to PTs */
+	if (!unlocked && params.needs_flush && vm->is_compute_context) {
+		amdgpu_vm_tlb_fence_create(adev, vm, fence);
+
+		/* Makes sure no PD/PT is freed before the flush */
+		dma_resv_add_fence(vm->root.bo->tbo.base.resv, *fence,
+				   DMA_RESV_USAGE_BOOKKEEP);
+	}
+
 error_unlock:
 	amdgpu_vm_eviction_unlock(vm);
 	drm_dev_exit(idx);
@@ -2237,6 +2246,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 
 	mutex_init(&vm->eviction_lock);
 	vm->evicting = false;
+	vm->tlb_fence_context = dma_fence_context_alloc(1);
 
 	r = amdgpu_vm_pt_create(adev, vm, adev->vm_manager.root_level,
 				false, &root, xcp_id);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 64b3f69efa57..298f604b8e5f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -341,6 +341,7 @@ struct amdgpu_vm {
 	atomic64_t		tlb_seq;
 	uint64_t		tlb_seq_va;
 	uint64_t		*tlb_seq_cpu_addr;
+	uint64_t		tlb_fence_context;
 
 	atomic64_t		kfd_last_flushed_seq;
 
@@ -594,5 +595,8 @@ void amdgpu_vm_update_fault_cache(struct amdgpu_device *adev,
 				  uint64_t addr,
 				  uint32_t status,
 				  unsigned int vmhub);
+void amdgpu_vm_tlb_fence_create(struct amdgpu_device *adev,
+				 struct amdgpu_vm *vm,
+				 struct dma_fence **fence);
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
new file mode 100644
index 000000000000..51cddfa3f1e8
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * Copyright 2023 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+#include <linux/dma-fence.h>
+#include <linux/workqueue.h>
+
+#include "amdgpu.h"
+#include "amdgpu_vm.h"
+#include "amdgpu_gmc.h"
+
+struct amdgpu_tlb_fence {
+	struct dma_fence	base;
+	struct amdgpu_device	*adev;
+	struct dma_fence	*dependency;
+	struct work_struct	work;
+	spinlock_t		lock;
+	uint16_t		pasid;
+
+};
+
+static const char *amdgpu_tlb_fence_get_driver_name(struct dma_fence *fence)
+{
+	return "amdgpu tlb fence";
+}
+
+static const char *amdgpu_tlb_fence_get_timeline_name(struct dma_fence *f)
+{
+	return "amdgpu tlb timeline";
+}
+
+static void amdgpu_tlb_fence_work(struct work_struct *work)
+{
+	struct amdgpu_tlb_fence *f = container_of(work, typeof(*f), work);
+	int r;
+
+	if (f->dependency) {
+		dma_fence_wait(f->dependency, false);
+		dma_fence_put(f->dependency);
+		f->dependency = NULL;
+	}
+
+	r = amdgpu_gmc_flush_gpu_tlb_pasid(f->adev, f->pasid, 2, true, 0);
+	if (r) {
+		dev_err(f->adev->dev, "TLB flush failed for PASID %d.\n",
+			f->pasid);
+		dma_fence_set_error(&f->base, r);
+	}
+
+	dma_fence_signal(&f->base);
+	dma_fence_put(&f->base);
+}
+
+static const struct dma_fence_ops amdgpu_tlb_fence_ops = {
+	.use_64bit_seqno = true,
+	.get_driver_name = amdgpu_tlb_fence_get_driver_name,
+	.get_timeline_name = amdgpu_tlb_fence_get_timeline_name
+};
+
+void amdgpu_vm_tlb_fence_create(struct amdgpu_device *adev, struct amdgpu_vm *vm,
+				struct dma_fence **fence)
+{
+	struct amdgpu_tlb_fence *f;
+
+	f = kmalloc(sizeof(*f), GFP_KERNEL);
+	if (!f) {
+		/*
+		 * We can't fail since the PDEs and PTEs are already updated, so
+		 * just block for the dependency and execute the TLB flush
+		 */
+		if (*fence)
+			dma_fence_wait(*fence, false);
+
+		amdgpu_gmc_flush_gpu_tlb_pasid(adev, vm->pasid, 2, true, 0);
+		*fence = dma_fence_get_stub();
+		return;
+	}
+
+	f->adev = adev;
+	f->dependency = *fence;
+	f->pasid = vm->pasid;
+	INIT_WORK(&f->work, amdgpu_tlb_fence_work);
+	spin_lock_init(&f->lock);
+
+	dma_fence_init(&f->base, &amdgpu_tlb_fence_ops, &f->lock,
+		       vm->tlb_fence_context, atomic64_read(&vm->tlb_seq));
+
+	/* TODO: We probably need a separate wq here */
+	dma_fence_get(&f->base);
+	schedule_work(&f->work);
+
+	*fence = &f->base;
+}
-- 
2.43.2

