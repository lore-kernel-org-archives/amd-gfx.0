Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE5CCC7EE2E
	for <amd-gfx@archiver.kernel.org>; Sun, 26 Feb 2023 16:55:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3497B10E13F;
	Sun, 26 Feb 2023 16:55:30 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2060.outbound.protection.outlook.com [40.107.212.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB37F10E13D
 for <amd-gfx@lists.freedesktop.org>; Sun, 26 Feb 2023 16:55:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oYAZ5l7NdRX/7blr74pch7LwZXdEn4Z80k5Y5q2/9TVliBWMa/TTxrheAaMEhMerIN2zW6/nh+DM2w5cp8j73fjcgeIUSmhAxiw1QvZoMiOIsJ7E8Oz/CiNJu3ofi7Yqu9NrSwqg6yHWnjsS/mZ5jorBe/CyC1YTo3p+otFOVUGpEvnb8qVY3lmt3dpRfKNEBLOLL3MZ9G6oNxsJ9IHkba7RoxpNMYPuKEq5aP9GELKOBnneOMTgqQUUtzwyDaqZJzxWW30I5yqXrbrDlS2eMlMUHZk5Q9pbRvDeaoCNxfYj/dCmSvL6t1ETftd8wZnUO1YlL5mHL50lV9jFn/bdYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yfS4tjHbPQeRklT6hey/o2kPO03ferPQAUGTClN9tLY=;
 b=UELOyDxUk7wtKg8JSnuw+VbY/DUomaY4ewjnWWahtzsbsrYMBGV3/UW8Az8emwEDu+om5eJivqzEe2NRdljlie+p7cs22HmSYl0DbIb7zI/tfYzw+lq0jmBzSd1823r1FPObTQ1JInWbI29h6t17W0AnqDJu2gWyhwJbSAx1O8lxoXtnRVefaC7bA5KLV/ZPTpSYRts6iqbfprzgdPFBgswe+cujAJXP61l5jFD0ylO/uCh46WtDbdjgIoTUuc1N4u9+HwKhUFpYeKXQEuVcKIF0HoTbdqRscQJUSDqXSnzx+2EfDJdh5zmyoMpgTQdzkBjYSD4UXzQhoC0Dn5QZaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yfS4tjHbPQeRklT6hey/o2kPO03ferPQAUGTClN9tLY=;
 b=Ul6F6uA+Ux6kd5Yh99j4tuNkN6f9KSciJB3uAjBVWFYgQAbOarjwg7CF8mz/hQh4fida0AHX4uuhxWEuVx+vVK2dtt2GxRWLs+w5R2QFVKyRghRi+v/duJIFqOe+ioTdwaTYc28kfSe5lQ6VCb8ieS8Cja3uRJFRQQKPDOxK2NE=
Received: from BN8PR15CA0030.namprd15.prod.outlook.com (2603:10b6:408:c0::43)
 by MW4PR12MB7167.namprd12.prod.outlook.com (2603:10b6:303:225::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.27; Sun, 26 Feb
 2023 16:55:16 +0000
Received: from BN8NAM11FT089.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:c0:cafe::5b) by BN8PR15CA0030.outlook.office365.com
 (2603:10b6:408:c0::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.27 via Frontend
 Transport; Sun, 26 Feb 2023 16:55:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT089.mail.protection.outlook.com (10.13.176.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.15 via Frontend Transport; Sun, 26 Feb 2023 16:55:14 +0000
Received: from amd-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sun, 26 Feb 2023 10:55:12 -0600
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/6] drm/amdgpu: Implement a new userqueue fence driver
Date: Sun, 26 Feb 2023 08:54:31 -0800
Message-ID: <20230226165435.41641-3-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230226165435.41641-1-Arunpravin.PaneerSelvam@amd.com>
References: <20230226165435.41641-1-Arunpravin.PaneerSelvam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT089:EE_|MW4PR12MB7167:EE_
X-MS-Office365-Filtering-Correlation-Id: f93eba26-f524-4a2b-bdd7-08db181a3b54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZC84aV1d1t/6YCdiXCy6KHQaU0/FALPcdjv+CFqqb+eSuYdvR691Eqe7rUyx13kmi9ZJxBOz6lEoeG4rAd6UdHmy1pkSGcTjJQxHTy57pSKoKDdgrcC7N1C5EwHNjaDsWslB4MVAa+Eb7kCvF7FXXT0XG7MjX5O3qDwKTkjASGSGeh+WtjV3aRTbGvIFwiwEed+HfkSP+idsfofMCZNdtStqOcki91ZGPEFWiQH5ph5UFLsSHvwsdcuwiPYBbZADFa+MieTqrHCQKOTURRC3e3vCVs2zQ12gZeIQUbS7plJT/d8efEd1wm8t/TERExT9mKTZjEgyeHpBevP0nZsGQB29uJJk+hWq1lvHMU/nddbOCX3KdtXma6f9nseug8bCCgbpFejT9GSTlEbXnZWlYRRCCGpa2AfDEoXpK7ETtKZt8/e8pb+RfYZ6xHMDFI95UnBhbr9BGZL+bHBjKt4Swpuk4Pt0HK5PtwkNJ51GQGcKpojIgx3TNOVB6aCZD5wjb2jKoDyRDKEfARBOXZ1rkHyInj/M7hMkpObwwIWt5Rrw+tJ3J6G9OA4RQyOAOs3r3fWHu4lNUR/rHviC6ZWC6oicxq74pYuUrip+8uym3sWaQ+1XHiNMoORAslUWFE7CJuP2gwiLh/t0G2JsleXMzOsvSiR0yJbTrJTK7hBxM/ZmyRYgkHj86/gEFehRi9aC9qLN6WdVDVI0lrQP8KlV/xUV3clpKs8rppmZUv/YWT4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(396003)(39860400002)(136003)(346002)(451199018)(40470700004)(46966006)(36840700001)(36860700001)(186003)(26005)(16526019)(30864003)(70206006)(70586007)(4326008)(6916009)(8676002)(478600001)(356005)(40460700003)(7696005)(86362001)(54906003)(316002)(40480700001)(8936002)(1076003)(5660300002)(41300700001)(36756003)(81166007)(6666004)(82740400003)(82310400005)(336012)(2906002)(47076005)(426003)(83380400001)(2616005)(66899018)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2023 16:55:14.6214 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f93eba26-f524-4a2b-bdd7-08db181a3b54
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT089.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7167
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
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, Arunpravin
 Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Developed a userqueue fence driver for the userqueue process shared
BO synchronization.

Create a dma fence having write pointer as the seqno and allocate a
seq64 memory for each user queue process and feed this memory address
into the firmware/hardware, thus the firmware writes the read pointer
into the given address when the process completes it execution.
Compare wptr and rptr, if rptr >= wptr, signal the fences for the waiting
process to consume the buffers.

v2: Worked on review comments from Christian for the following
    modifications

    - Add wptr as sequence number into the fence
    - Add a reference count for the fence driver
    - Add dma_fence_put below the list_del as it might frees the userq fence.
    - Trim unnecessary code in interrupt handler.
    - Check dma fence signaled state in dma fence creation function for a
      potential problem of hardware completing the job processing beforehand.
    - Add necessary locks.
    - Create a list and process all the unsignaled fences.
    - clean up fences in destroy function.
    - implement .enabled callback function

Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile           |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   6 +
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 251 ++++++++++++++++++
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.h   |  61 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c |  20 ++
 .../gpu/drm/amd/include/amdgpu_userqueue.h    |   2 +
 6 files changed, 341 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index a239533a895f..ea09273b585f 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -59,7 +59,7 @@ amdgpu-y += amdgpu_device.o amdgpu_kms.o \
 	amdgpu_umc.o smu_v11_0_i2c.o amdgpu_fru_eeprom.o amdgpu_rap.o \
 	amdgpu_fw_attestation.o amdgpu_securedisplay.o \
 	amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o \
-	amdgpu_ring_mux.o amdgpu_seq64.o
+	amdgpu_ring_mux.o amdgpu_seq64.o amdgpu_userq_fence.o
 
 amdgpu-$(CONFIG_PROC_FS) += amdgpu_fdinfo.o
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index bd3462d0da5f..6b7ac1ebd04c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -53,6 +53,7 @@
 #include "amdgpu_xgmi.h"
 #include "amdgpu_reset.h"
 #include "amdgpu_userqueue.h"
+#include "amdgpu_userq_fence.h"
 
 /*
  * KMS wrapper.
@@ -2827,6 +2828,10 @@ static int __init amdgpu_init(void)
 	if (r)
 		goto error_fence;
 
+	r = amdgpu_userq_fence_slab_init();
+	if (r)
+		goto error_fence;
+
 	DRM_INFO("amdgpu kernel modesetting enabled.\n");
 	amdgpu_register_atpx_handler();
 	amdgpu_acpi_detect();
@@ -2851,6 +2856,7 @@ static void __exit amdgpu_exit(void)
 	amdgpu_unregister_atpx_handler();
 	amdgpu_sync_fini();
 	amdgpu_fence_slab_fini();
+	amdgpu_userq_fence_slab_fini();
 	mmu_notifier_synchronize();
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
new file mode 100644
index 000000000000..609a7328e9a6
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -0,0 +1,251 @@
+// SPDX-License-Identifier: MIT
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
+ *
+ */
+
+#include <linux/kref.h>
+#include <linux/slab.h>
+
+#include <drm/drm_syncobj.h>
+
+#include "amdgpu.h"
+#include "amdgpu_userq_fence.h"
+#include "amdgpu_userqueue.h"
+
+static struct kmem_cache *amdgpu_userq_fence_slab;
+
+int amdgpu_userq_fence_slab_init(void)
+{
+	amdgpu_userq_fence_slab = kmem_cache_create("amdgpu_userq_fence",
+						    sizeof(struct amdgpu_userq_fence),
+						    0,
+						    SLAB_HWCACHE_ALIGN,
+						    NULL);
+	if (!amdgpu_userq_fence_slab)
+		return -ENOMEM;
+
+	return 0;
+}
+
+void amdgpu_userq_fence_slab_fini(void)
+{
+	rcu_barrier();
+	kmem_cache_destroy(amdgpu_userq_fence_slab);
+}
+
+static inline struct amdgpu_userq_fence *to_amdgpu_userq_fence(struct dma_fence *f)
+{
+	struct amdgpu_userq_fence *__f = container_of(f, struct amdgpu_userq_fence, base);
+
+	if (!__f)
+		return NULL;
+
+	if (__f->base.ops == &amdgpu_userq_fence_ops)
+		return __f;
+
+	return NULL;
+}
+
+static u64 amdgpu_userq_fence_read(struct amdgpu_userq_fence_driver *fence_drv)
+{
+	return le64_to_cpu(*fence_drv->cpu_addr);
+}
+
+int amdgpu_userq_fence_driver_get(struct amdgpu_device *adev,
+				  struct amdgpu_usermode_queue *userq)
+{
+	struct amdgpu_userq_fence_driver *fence_drv;
+	int r;
+
+	fence_drv = userq->fence_drv;
+	if (!fence_drv)
+		return -EINVAL;
+
+	/* Acquire seq64 memory */
+	r = amdgpu_seq64_get(adev, &fence_drv->gpu_addr,
+			     &fence_drv->cpu_addr);
+	if (r)
+		return -ENOMEM;
+	
+	kref_init(&fence_drv->refcount);
+	INIT_LIST_HEAD(&fence_drv->fences);
+	spin_lock_init(&fence_drv->fence_list_lock);
+
+	fence_drv->adev = adev;
+	fence_drv->context = dma_fence_context_alloc(1);
+
+	get_task_comm(fence_drv->timeline_name, current);
+
+	return 0;
+}
+
+void amdgpu_userq_fence_driver_destroy(struct kref *ref)
+{
+	struct amdgpu_userq_fence_driver *fence_drv = container_of(ref,
+					 struct amdgpu_userq_fence_driver,
+					 refcount);
+	struct amdgpu_device *adev = fence_drv->adev;
+	struct amdgpu_userq_fence *fence, *tmp;
+	struct dma_fence *f;
+	
+	spin_lock(&fence_drv->fence_list_lock);
+	list_for_each_entry_safe(fence, tmp, &fence_drv->fences, link) {
+		f = &fence->base;
+		
+		if (!dma_fence_is_signaled(f)) {
+			dma_fence_set_error(f, -ECANCELED);
+			dma_fence_signal(f);
+		}
+		
+		list_del(&fence->link);
+		dma_fence_put(f);
+	}
+	
+	WARN_ON_ONCE(!list_empty(&fence_drv->fences));
+	spin_unlock(&fence_drv->fence_list_lock);
+	
+	/* Free seq64 memory */
+	amdgpu_seq64_free(adev, fence_drv->gpu_addr);
+	kfree(fence_drv);
+}
+
+void amdgpu_userq_fence_driver_put(struct amdgpu_userq_fence_driver *fence_drv)
+{
+	kref_put(&fence_drv->refcount, amdgpu_userq_fence_driver_destroy);
+}
+
+int amdgpu_userq_fence_create(struct amdgpu_usermode_queue *userq,
+			      u64 seq, struct dma_fence **f)
+{
+	struct amdgpu_userq_fence_driver *fence_drv;
+	struct amdgpu_userq_fence *userq_fence;
+	struct dma_fence *fence;
+
+	fence_drv = userq->fence_drv;
+	if (!fence_drv)
+		return -EINVAL;
+
+	userq_fence = kmem_cache_alloc(amdgpu_userq_fence_slab, GFP_ATOMIC);
+	if (!userq_fence)
+		return -ENOMEM;
+
+	spin_lock_init(&userq_fence->lock);
+	INIT_LIST_HEAD(&userq_fence->link);
+	fence = &userq_fence->base;
+	userq_fence->fence_drv = fence_drv;
+
+	dma_fence_init(fence, &amdgpu_userq_fence_ops, &userq_fence->lock,
+		       fence_drv->context, seq);
+
+	kref_get(&fence_drv->refcount);
+
+	spin_lock(&fence_drv->fence_list_lock);
+	/* Check if hardware has already processed the job */
+	if (!dma_fence_is_signaled(fence)) {
+		dma_fence_get(fence);
+		list_add_tail(&userq_fence->link, &fence_drv->fences);
+		dma_fence_put(fence);
+	}
+	spin_unlock(&fence_drv->fence_list_lock);	
+	/* Release the fence driver reference */
+	amdgpu_userq_fence_driver_put(fence_drv);
+
+	*f = fence;
+
+	return 0;
+}
+
+bool amdgpu_userq_fence_process(struct amdgpu_userq_fence_driver *fence_drv)
+{
+	struct amdgpu_userq_fence *userq_fence, *tmp;
+	struct dma_fence *fence;
+	u64 rptr;
+
+	if (!fence_drv)
+		return false;
+
+	rptr = amdgpu_userq_fence_read(fence_drv);
+
+	spin_lock(&fence_drv->fence_list_lock);
+	list_for_each_entry_safe(userq_fence, tmp, &fence_drv->fences, link) {
+		fence = &userq_fence->base;
+
+		if (rptr >= fence->seqno) {
+			dma_fence_signal(fence);
+			list_del(&userq_fence->link);
+
+			dma_fence_put(fence);
+		} else {
+			break;
+		}
+	}
+	spin_unlock(&fence_drv->fence_list_lock);
+
+	return true;
+}
+
+static const char *amdgpu_userq_fence_get_driver_name(struct dma_fence *f)
+{
+	return "amdgpu_userqueue_fence";
+}
+
+static const char *amdgpu_userq_fence_get_timeline_name(struct dma_fence *f)
+{
+	struct amdgpu_userq_fence *fence = to_amdgpu_userq_fence(f);
+
+	return fence->fence_drv->timeline_name;
+}
+
+static bool amdgpu_userq_fence_signaled(struct dma_fence *f)
+{
+	struct amdgpu_userq_fence *fence = to_amdgpu_userq_fence(f);
+	struct amdgpu_userq_fence_driver *fence_drv = fence->fence_drv;
+	u64 rptr, wptr;
+
+	rptr = amdgpu_userq_fence_read(fence_drv);
+	wptr = fence->base.seqno;
+
+	if (rptr >= wptr)
+		return true;
+
+	return false;
+}
+
+static void amdgpu_userq_fence_free(struct rcu_head *rcu)
+{
+	struct dma_fence *f = container_of(rcu, struct dma_fence, rcu);
+
+	kmem_cache_free(amdgpu_userq_fence_slab, to_amdgpu_userq_fence(f));
+}
+
+static void amdgpu_userq_fence_release(struct dma_fence *f)
+{
+	call_rcu(&f->rcu, amdgpu_userq_fence_free);
+}
+
+static const struct dma_fence_ops amdgpu_userq_fence_ops = {
+	.use_64bit_seqno = true,
+	.get_driver_name = amdgpu_userq_fence_get_driver_name,
+	.get_timeline_name = amdgpu_userq_fence_get_timeline_name,
+	.signaled = amdgpu_userq_fence_signaled,
+	.release = amdgpu_userq_fence_release,
+};
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
new file mode 100644
index 000000000000..230dd54b4cd3
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
@@ -0,0 +1,61 @@
+/* SPDX-License-Identifier: MIT */
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
+ *
+ */
+
+#ifndef __AMDGPU_USERQ_FENCE_H__
+#define __AMDGPU_USERQ_FENCE_H__
+
+#include <linux/types.h>
+
+struct amdgpu_userq_fence {
+	struct dma_fence base;
+	/* userq fence lock */
+	spinlock_t lock;
+	struct list_head link;
+	struct amdgpu_userq_fence_driver *fence_drv;
+};
+
+struct amdgpu_userq_fence_driver {
+	struct kref refcount;
+	u64 gpu_addr;
+	u64 *cpu_addr;
+	u64 context;
+	/* fence list lock */
+	spinlock_t fence_list_lock;
+	struct list_head fences;
+	struct amdgpu_device *adev;
+	char timeline_name[TASK_COMM_LEN];
+};
+
+static const struct dma_fence_ops amdgpu_userq_fence_ops;
+
+int amdgpu_userq_fence_slab_init(void);
+void amdgpu_userq_fence_slab_fini(void);
+int amdgpu_userq_fence_driver_get(struct amdgpu_device *adev, struct amdgpu_usermode_queue *userq);
+void amdgpu_userq_fence_driver_put(struct amdgpu_userq_fence_driver *fence_drv);
+int amdgpu_userq_fence_create(struct amdgpu_usermode_queue *userq,
+			      u64 seq, struct dma_fence **f);
+bool amdgpu_userq_fence_process(struct amdgpu_userq_fence_driver *fence_drv);
+void amdgpu_userq_fence_driver_destroy(struct kref *ref);
+
+#endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index 2f1aba1e9792..d4317b0f6487 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -23,6 +23,7 @@
 
 #include "amdgpu.h"
 #include "amdgpu_vm.h"
+#include "amdgpu_userq_fence.h"
 
 #define AMDGPU_USERQ_DOORBELL_INDEX (AMDGPU_NAVI10_DOORBELL_GFX_USERQUEUE_START + 4)
 
@@ -264,6 +265,8 @@ static int amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq
     struct amdgpu_vm *vm = &fpriv->vm;
     struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
     struct drm_amdgpu_userq_mqd *mqd_in = &args->in.mqd;
+    struct amdgpu_userq_fence_driver *fence_drv;
+    struct amdgpu_device *adev = uq_mgr->adev;
 
     pasid = vm->pasid;
     if (vm->pasid < 0) {
@@ -280,6 +283,19 @@ static int amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq
         return -ENOMEM;
     }
 
+    fence_drv = kzalloc(sizeof(struct amdgpu_userq_fence_driver), GFP_KERNEL);
+    if (!fence_drv) {
+	    DRM_ERROR("Failed to allocate memory for fence driver\n");
+	    return -ENOMEM;
+    }
+
+    queue->fence_drv = fence_drv;
+    r = amdgpu_userq_fence_driver_get(adev, queue);
+    if (r) {
+	    DRM_ERROR("Failed to get fence driver\n");
+	    goto free_fence_drv;
+    }
+
     queue->vm = vm;
     queue->pasid = pasid;
     queue->wptr_gpu_addr = mqd_in->wptr_va;
@@ -339,6 +355,9 @@ static int amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq
 free_qid:
     amdgpu_userqueue_free_index(uq_mgr, queue->queue_id);
 
+free_fence_drv:
+    amdgpu_userq_fence_driver_put(queue->fence_drv);
+
 free_queue:
     mutex_unlock(&uq_mgr->userq_mutex);
     kfree(queue);
@@ -363,6 +382,7 @@ static void amdgpu_userqueue_destroy(struct drm_file *filp, int queue_id)
     amdgpu_userqueue_destroy_mqd(uq_mgr, queue);
     amdgpu_userqueue_free_index(uq_mgr, queue->queue_id);
     list_del(&queue->userq_node);
+    amdgpu_userq_fence_driver_put(queue->fence_drv);
     mutex_unlock(&uq_mgr->userq_mutex);
     kfree(queue);
 }
diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
index bda27583b58c..cf7264df8c46 100644
--- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
+++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
@@ -73,6 +73,8 @@ struct amdgpu_usermode_queue {
 	struct amdgpu_vm    	*vm;
 	struct amdgpu_userq_mgr *userq_mgr;
 	struct list_head 	userq_node;
+
+	struct amdgpu_userq_fence_driver *fence_drv;
 };
 
 int amdgpu_userq_ioctl(struct drm_device *dev, void *data, struct drm_file *filp);
-- 
2.25.1

