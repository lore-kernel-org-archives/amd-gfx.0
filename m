Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AEECC3DA7A
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Dec 2022 19:37:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D991510E227;
	Fri, 23 Dec 2022 19:37:40 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D66510E22A
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Dec 2022 19:37:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xwmk68HXQY7BGFLqRUig4plLNMYu1g5+LE1Kz9lIM1KUJacbbH0RBrLBUrWvB3tzO9Me0It+Xk6hdgbiNiU+stiJ28PJZ/hjOMeGPmaaTZlqEvb/Hd6I6XCQJ3H0ZmkAUWG+0AF03/vnAzu4N1jw1lydVxnUZcJ4ibNOe/MsNppWuHjOon2HcVPj/P3WzMjOmvHjzoRxMYNDzQsi1eUYVQLRK2fGU+u8Iwf9JKWvh3ILJHSF7HLNQyVbtFwqzv7+3+SMxev9wiAoyz2waK+ovvI3UG9NzsxGxuZKdXO7X57Z62yi8oz2xiMtsFash8WZYcBDEh7MNFHWzYcFQeSgwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4u2zh5TkshxNIWAAe0XZybt0ivkpHOgH92Opf8hLKhU=;
 b=gVYUdbNDf1Nk1IUIjID/7BMP6jGH2LF8NxIKDYGk6DtpXS7ZepqvrcRcvkyRkFm2Ei14xY+QU7B5UPiI6MZijGSWmCmw7WJByHI+w1/R5omIDfwkXmZ6/+wcMWgo1YBl5k4cWjQZf2nPlekvLAAiMmLwAKOxxQQG6u5zG4ewhWUumm4Xcy7cNGzViwXcBh4uey16Tn3a7EglmknMJ8hDJ+6m0tLDpCaNPpzZsYWFiUoVJQgQcSMtjxLgKGOuPjgZAEUfWwM1/Yyoed/KFWQnbeDGpYW5YsbivOBMP74pNIF7YgTm3cKuqCRef9GRmn+sUwY6QpNLIdTwhwfes4cGPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4u2zh5TkshxNIWAAe0XZybt0ivkpHOgH92Opf8hLKhU=;
 b=cC4NkdwHkUHjhoJKUL44+4xOPogdMmSfNgE2yAazbTyIQNiEeQiSwL+bF7OslImpUURXlOj0ZuaJFKiJEz2kZ6XrWCtG+r+flJEHLwdOozdcczXuyuEJVt9y/gfDjIU9yOf/p4PLv95+RGtFlO47bmioFZBihuJ3BVqlzqfuYAU=
Received: from MW4PR04CA0207.namprd04.prod.outlook.com (2603:10b6:303:86::32)
 by SJ1PR12MB6074.namprd12.prod.outlook.com (2603:10b6:a03:45f::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.12; Fri, 23 Dec
 2022 19:37:36 +0000
Received: from CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:86:cafe::6b) by MW4PR04CA0207.outlook.office365.com
 (2603:10b6:303:86::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.13 via Frontend
 Transport; Fri, 23 Dec 2022 19:37:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT045.mail.protection.outlook.com (10.13.175.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5944.6 via Frontend Transport; Fri, 23 Dec 2022 19:37:35 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 23 Dec
 2022 13:37:33 -0600
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [RFC 7/7] drm/amdgpu: Secure semaphore for usermode queue
Date: Fri, 23 Dec 2022 20:36:55 +0100
Message-ID: <20221223193655.1972-8-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20221223193655.1972-1-shashank.sharma@amd.com>
References: <20221223193655.1972-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT045:EE_|SJ1PR12MB6074:EE_
X-MS-Office365-Filtering-Correlation-Id: de2cc30a-9673-462c-5c76-08dae51d24bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LI5x5jdGyLlLDDZ+wfsF7FB+Molm5BAF1+Ilzv72Bn8zR2pRsa9LeCfcOhh9rVGbuFQLhMsjlhrumzM5z9mtYK7+Np2/2ueeaGhjTlobi42XkeQWDgkVDALdqLTBQA/elsvarWusSv2dYpbB7TrpLybeBETYl31leI0sXcN7RsCdfUzs/vY6yfqgvjmN6J0dPvK+mOB/JmEF1VgGhuaqaZnNui9C654wqVqckWGalCq20uuo3SEWpVmlqFL0h9BoXPUsQPDmxZ9kGghxuZIISDdnbLOym5SO8C6rTxbhSTGZJ2ap9N9flGqU9YJCs+7HTwNpnEXlJ5wqj7jRttLA9QMRTEYNwNjf0xINosRETDypSj2X5Ma4UAD9L+UPELgl8yzMpY+5zXXCebkfe1wEjM7Eh7aCswN4IYck/nksMdKh/GYDPO0R9DL81egB4t6DNUPusDAp8g02K/i+6nOF3h5+m+5er3nOAHkfVsbb3F0I/Ww97cwwtiq01zXy4vjBeggIMcKyQH0rh8wJBbFYUzpZpP6avSvhxsnsNVGHkvugKKO8UScm81GOr4GjJ87CtLnIXrsqhviR5dvVVgp87EBlScTJ17rxSHLmKmu3evu1LDR8lGzV/df6wBuAmGCvNvVQZ/fRVwQc3Wsa15XU2NGEQu6/4VR81skqD8SsRs922ycIGLoIt5dMz+QdeSlmdHNFfX80nxZSgfcQ3BBvJXvXQ0XrDi6ddW2F3fNsyX8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(376002)(396003)(346002)(136003)(451199015)(46966006)(36840700001)(40470700004)(478600001)(81166007)(7696005)(40480700001)(16526019)(66899015)(26005)(186003)(356005)(6666004)(2616005)(82740400003)(316002)(36756003)(1076003)(6916009)(54906003)(70206006)(8676002)(4326008)(70586007)(426003)(47076005)(8936002)(5660300002)(83380400001)(82310400005)(44832011)(30864003)(40460700003)(41300700001)(336012)(2906002)(86362001)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2022 19:37:35.7960 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de2cc30a-9673-462c-5c76-08dae51d24bf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6074
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
 Shashank Shamra <shashank.sharma@amd.com>,
 Christian Koenig <christian.koenig@amd.com>, arvind.yadav@amd.com,
 arunpravin.paneerselvam@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>

This is a WIP patch, which adds an kernel implementation of secure
semaphore for the usermode queues. The UAPI for the same is yet to
be implemented.

The idea is to create a RO page and map it to each process requesting a
user mode queue, and give them a qnique offset in the page, which can be
polled (like wait_mem) for sync.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Shashank Shamra <shashank.sharma@amd.com>

Signed-off-by: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile           |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   8 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c |   7 +-
 .../amd/amdgpu/amdgpu_userqueue_secure_sem.c  | 245 ++++++++++++++++++
 .../drm/amd/include/amdgpu_usermode_queue.h   |  10 +
 .../amd/include/amdgpu_usermode_queue_mqd.h   |   4 +-
 6 files changed, 272 insertions(+), 3 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_secure_sem.c

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index e2a34ee57bfb..daec7bb9ab3b 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -211,6 +211,7 @@ amdgpu-y += amdgpu_amdkfd.o
 
 # add usermode queue
 amdgpu-y += amdgpu_userqueue.o
+amdgpu-y += amdgpu_userqueue_secure_sem.o
 
 ifneq ($(CONFIG_HSA_AMD),)
 AMDKFD_PATH := ../amdkfd
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 4b566fcfca18..7325c01efc90 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -749,9 +749,17 @@ struct amdgpu_mqd {
 			struct amdgpu_mqd_prop *p);
 };
 
+struct amdgpu_userq_sec_sem {
+	struct amdgpu_bo *sem_obj;
+	u64 gpu_addr;
+	u32 num_sem;
+	unsigned long used[DIV_ROUND_UP(64, BITS_PER_LONG)];
+};
+
 struct amdgpu_userq_globals {
 	struct ida ida;
 	struct mutex userq_mutex;
+	struct amdgpu_userq_sec_sem sem;
 };
 
 #define AMDGPU_RESET_MAGIC_NUM 64
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index b164e24247ca..2af634bbe3dc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -261,6 +261,10 @@ amdgpu_userqueue_setup_mqd(struct amdgpu_device *adev, struct amdgpu_usermode_qu
     /* reset read and write pointers, similar to CP_RB0_WPTR/_RPTR */
     mqd->cp_gfx_hqd_rptr = RREG32_SOC15(GC, 0, regCP_GFX_HQD_RPTR);
 
+    /* Setup semaphore fence address */
+    mqd->fenceaddress_lo = queue->sem_data.sem_gpu_addr & 0xFFFFFFFC;
+    mqd->fenceaddress_lo = upper_32_bits(queue->sem_data.sem_gpu_addr) & 0xFFFF;
+
     /* activate the queue */
     mqd->cp_gfx_hqd_active = 1;
 }
@@ -472,10 +476,11 @@ int amdgpu_userqueue_init(struct amdgpu_device *adev)
     struct amdgpu_userq_globals *uqg = &adev->userq;
 
     mutex_init(&uqg->userq_mutex);
+    amdgpu_userqueue_sec_sem_init(adev);
     return 0;
 }
 
 void amdgpu_userqueue_fini(struct amdgpu_device *adev)
 {
-
+    amdgpu_userqueue_sec_sem_fini(adev);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_secure_sem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_secure_sem.c
new file mode 100644
index 000000000000..6e6a7d62a300
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_secure_sem.c
@@ -0,0 +1,245 @@
+/*
+ * Copyright 2022 Advanced Micro Devices, Inc.
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
+#include "amdgpu.h"
+#include "amdgpu_mes.h"
+#include "amdgpu_usermode_queue.h"
+#include "amdgpu_usermode_queue_mqd.h"
+
+static int amdgpu_userqueue_sem_addr_unmap(struct amdgpu_device *adev,
+					   struct amdgpu_usermode_queue *q)
+{
+    struct amdgpu_userq_sec_sem_data *sem_bo_data = &q->sem_data;
+    struct amdgpu_bo_va *bo_va = sem_bo_data->sem_data_va;
+    struct amdgpu_vm *vm = bo_va->base.vm;
+    struct amdgpu_bo *bo = adev->userq.sem.sem_obj;
+    struct amdgpu_bo_list_entry vm_pd;
+    struct list_head list, duplicates;
+    struct dma_fence *fence = NULL;
+    struct ttm_validate_buffer tv;
+    struct ww_acquire_ctx ticket;
+    long r = 0;
+
+    INIT_LIST_HEAD(&list);
+    INIT_LIST_HEAD(&duplicates);
+
+    tv.bo = &bo->tbo;
+    tv.num_shared = 2;
+    list_add(&tv.head, &list);
+
+    amdgpu_vm_get_pd_bo(vm, &list, &vm_pd);
+
+    r = ttm_eu_reserve_buffers(&ticket, &list, false, &duplicates);
+    if (r) {
+        DRM_ERROR("leaking bo va because we fail to reserve bo (%ld)\n", r);
+        return r;
+    }
+
+    amdgpu_vm_bo_del(adev, bo_va);
+    if (!amdgpu_vm_ready(vm))
+        goto out_unlock;
+
+    r = dma_resv_get_singleton(bo->tbo.base.resv, DMA_RESV_USAGE_BOOKKEEP, &fence);
+    if (r)
+        goto out_unlock;
+    if (fence) {
+        amdgpu_bo_fence(bo, fence, true);
+        fence = NULL;
+    }
+
+    r = amdgpu_vm_clear_freed(adev, vm, &fence);
+    if (r || !fence)
+        goto out_unlock;
+
+    dma_fence_wait(fence, false);
+    amdgpu_bo_fence(bo, fence, true);
+    dma_fence_put(fence);
+
+out_unlock:
+    if (unlikely(r < 0))
+        DRM_ERROR("failed to clear page tables (%ld)\n", r);
+    ttm_eu_backoff_reservation(&ticket, &list);
+
+    return r;
+}
+
+static u64 amdgpu_sem_bo_vaddr(struct amdgpu_device *adev) {
+       u64 addr = AMDGPU_VA_RESERVED_SIZE;
+
+       /* TODO:Find va address for sem bo mapping */
+       return addr;
+}
+
+static int amdgpu_userqueue_sem_addr_map(struct amdgpu_device *adev,
+                                        struct amdgpu_usermode_queue *q)
+{
+    struct amdgpu_userq_sec_sem_data *sem_bo_data;
+    struct amdgpu_bo *sem_obj = adev->userq.sem.sem_obj;
+    struct ttm_validate_buffer csa_tv;
+    struct amdgpu_bo_list_entry pd;
+    struct ww_acquire_ctx ticket;
+    struct amdgpu_vm *vm = q->vm;
+    struct amdgpu_bo_va *bo_va;
+    struct amdgpu_sync sync;
+    struct list_head list;
+    int r;
+
+    amdgpu_sync_create(&sync);
+    INIT_LIST_HEAD(&list);
+    INIT_LIST_HEAD(&csa_tv.head);
+
+    sem_bo_data = &q->sem_data;
+
+    csa_tv.bo = &sem_obj->tbo;
+    csa_tv.num_shared = 1;
+
+    list_add(&csa_tv.head, &list);
+    amdgpu_vm_get_pd_bo(vm, &list, &pd);
+
+    r = ttm_eu_reserve_buffers(&ticket, &list, true, NULL);
+    if (r) {
+        DRM_ERROR("failed to reserve userqueue sec sem object BO: err=%d\n", r);
+        return r;
+    }
+
+    bo_va = amdgpu_vm_bo_add(adev, vm, sem_obj);
+    if (!bo_va) {
+        ttm_eu_backoff_reservation(&ticket, &list);
+        DRM_ERROR("failed to create bo_va for userqueue sec sem object BO\n");
+        return -ENOMEM;
+    }
+
+    sem_bo_data->sem_gpu_addr = amdgpu_sem_bo_vaddr(adev);
+    r = amdgpu_vm_bo_map(adev, bo_va, sem_bo_data->sem_gpu_addr, 0,
+                        AMDGPU_MAX_USERQUEUE_SEC_SEM * sizeof(u64),
+                        AMDGPU_PTE_READABLE | AMDGPU_PTE_READABLE);
+
+    if (r) {
+        DRM_ERROR("failed to do bo_map on sec sem object BO, err=%d\n", r);
+        goto error;
+    }
+
+    r = amdgpu_vm_bo_update(adev, bo_va, false);
+    if (r) {
+        DRM_ERROR("failed to do vm_bo_update on sec sem object BO\n");
+        goto error;
+    }
+    amdgpu_sync_fence(&sync, bo_va->last_pt_update);
+
+    r = amdgpu_vm_update_pdes(adev, vm, false);
+    if (r) {
+        DRM_ERROR("failed to update pdes on sec sem object BO\n");
+        goto error;
+    }
+    amdgpu_sync_fence(&sync, vm->last_update);
+
+    amdgpu_sync_wait(&sync, false);
+    ttm_eu_backoff_reservation(&ticket, &list);
+
+    amdgpu_sync_free(&sync);
+    sem_bo_data->sem_data_va = bo_va;
+    return 0;
+
+error:
+    amdgpu_vm_bo_del(adev, bo_va);
+    ttm_eu_backoff_reservation(&ticket, &list);
+    amdgpu_sync_free(&sync);
+    return r;
+}
+
+int amdgpu_userqueue_sec_sem_get(struct amdgpu_device *adev,
+                            struct amdgpu_usermode_queue *q,
+                            u64 *gpu_addr)
+{
+    unsigned long offset = find_first_zero_bit(adev->userq.sem.used, adev->userq.sem.num_sem);
+    u32 sem_offset;
+    int r;
+
+    if (offset < adev->userq.sem.num_sem) {
+        __set_bit(offset, adev->userq.sem.used);
+        sem_offset = offset << 6; /* convert to qw offset */
+    } else {
+        return -EINVAL;
+    }
+
+    r = amdgpu_userqueue_sem_addr_map(adev, q);
+    if (r) {
+        DRM_ERROR("failed to map sec sem object BO");
+        amdgpu_userqueue_sem_addr_unmap(adev, q);
+        return r;
+    }
+
+    *gpu_addr = sem_offset + q->sem_data.sem_gpu_addr;
+
+    return 0;
+}
+
+void amdgpu_userqueue_sec_sem_free(struct amdgpu_device *adev,
+                                struct amdgpu_usermode_queue *q,
+                                u32 sem)
+{
+    int r;
+
+    r = amdgpu_userqueue_sem_addr_unmap(adev, q);
+    if (r)
+        DRM_ERROR("failed to unmap sec sem object BO");
+
+    sem >>= 6;
+    if (sem < adev->userq.sem.num_sem)
+        __clear_bit(sem, adev->userq.sem.used);
+}
+
+int
+amdgpu_userqueue_sec_sem_init(struct amdgpu_device *adev)
+{
+    int r;
+
+    if (adev->userq.sem.sem_obj == NULL) {
+        /*
+        * AMDGPU_MAX_USERQUEUE_SEC_SEM * sizeof(u64) = AMDGPU_MAX_USERQUEUE_SEC_SEM
+        * 64bit slots
+        */
+        r = amdgpu_bo_create_kernel(adev, AMDGPU_MAX_USERQUEUE_SEC_SEM * sizeof(u64),
+                                    PAGE_SIZE, AMDGPU_GEM_DOMAIN_GTT, &adev->userq.sem.sem_obj,
+                                    &adev->userq.sem.gpu_addr, NULL);
+        if (r) {
+            DRM_ERROR("Create userqueue SEM bo failed, err %d\n", r);
+            return r;
+        }
+
+        adev->userq.sem.num_sem = AMDGPU_MAX_USERQUEUE_SEC_SEM;
+        memset(&adev->userq.sem.used, 0, sizeof(adev->userq.sem.used));
+    }
+
+    return 0;
+}
+
+void
+amdgpu_userqueue_sec_sem_fini(struct amdgpu_device *adev)
+{
+    if (adev->userq.sem.sem_obj) {
+        amdgpu_bo_free_kernel(&adev->userq.sem.sem_obj,
+                &adev->userq.sem.gpu_addr,
+                NULL);
+        adev->userq.sem.sem_obj = NULL;
+    }
+}
\ No newline at end of file
diff --git a/drivers/gpu/drm/amd/include/amdgpu_usermode_queue.h b/drivers/gpu/drm/amd/include/amdgpu_usermode_queue.h
index 8bf3c0be6937..630d9b5d2423 100644
--- a/drivers/gpu/drm/amd/include/amdgpu_usermode_queue.h
+++ b/drivers/gpu/drm/amd/include/amdgpu_usermode_queue.h
@@ -25,6 +25,12 @@
 #define AMDGPU_USERMODE_QUEUE_H_
 
 #define AMDGPU_MAX_USERQ 512
+#define AMDGPU_MAX_USERQUEUE_SEC_SEM 64
+
+struct amdgpu_userq_sec_sem_data {
+	u64 sem_gpu_addr;
+	struct amdgpu_bo_va *sem_data_va;
+};
 
 struct amdgpu_userq_ctx {
 	struct amdgpu_bo *obj;
@@ -52,7 +58,11 @@ struct amdgpu_usermode_queue {
 	struct amdgpu_vm    	*vm;
 	struct amdgpu_userq_ctx proc_ctx;
 	struct amdgpu_userq_ctx gang_ctx;
+
+	struct amdgpu_userq_sec_sem_data sem_data;
 	struct list_head 	list;
 };
 
+int amdgpu_userqueue_sec_sem_init(struct amdgpu_device *adev);
+void amdgpu_userqueue_sec_sem_fini(struct amdgpu_device *adev);
 #endif
diff --git a/drivers/gpu/drm/amd/include/amdgpu_usermode_queue_mqd.h b/drivers/gpu/drm/amd/include/amdgpu_usermode_queue_mqd.h
index d0a285708ba5..e0bfb67d91f4 100644
--- a/drivers/gpu/drm/amd/include/amdgpu_usermode_queue_mqd.h
+++ b/drivers/gpu/drm/amd/include/amdgpu_usermode_queue_mqd.h
@@ -35,8 +35,8 @@ struct amdgpu_usermode_queue_mqd
 	uint32_t fw_work_area_base_hi; // offset: 5  (0x5)
 	uint32_t shadow_initialized; // offset: 6  (0x6)
 	uint32_t ib_vmid; // offset: 7  (0x7)
-	uint32_t reserved_8; // offset: 8  (0x8)
-	uint32_t reserved_9; // offset: 9  (0x9)
+	uint32_t fenceaddress_lo; // offset: 8  (0x8)
+	uint32_t fenceaddress_high; // offset: 9  (0x9)
 	uint32_t reserved_10; // offset: 10  (0xA)
 	uint32_t reserved_11; // offset: 11  (0xB)
 	uint32_t reserved_12; // offset: 12  (0xC)
-- 
2.34.1

