Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B348DC77B73
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Apr 2023 14:48:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30E4110EC79;
	Thu, 20 Apr 2023 14:48:01 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2062a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::62a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7415B10EC78
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Apr 2023 14:47:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BDJGiHHr7aF4O7bgJZ2OUDIvW1V+O+mteG6bIxHOkxGiP9x5JQqkBUEb8HgvbSMQX/tKXUoKIMU6DbvQF8j+gV2/kDRNW/x2WWGF/UCNG1Bqb7wOfmUsxpXDAzX42SgW2pv4BMaeQmTB5d8o5xcuS3N64XQJUcxhKKVzeP3dAp93a1QAzKUaxwlk1iWHNWwlzfxqaSH6JU4ZNh7EmjSjJTzgNMhGkzXhE7IOCwY+9Lpg+jwSvSUyOauoMggFBYQRGhSlE4Ht5/JkF2t/SIFreAEsF/1uh4hKB4a17pazOQxkPI6+wePJB93OVIav7kkK2n4oXZsBR3sMVb+t407JlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xIEWUZ/RpGwN63ey19rdu54s3JxAzx2BQFs6g161MzU=;
 b=LS8bxxCOrU7yb+AdCr/NY0VRhVlC4L9C8KLocx9soc7zQbrcExfKiksTT2NRopRybJozJv2hOf5hG2EY3/JFVK2h6qHfkE6sJEri0dxyGJAonIAlTtzdrXEHEkBih2CshDAhMeXAh/R14B9PlqwPc37vsJtqYzE+cwp/V73E8dSjAoWS50PhuQp6SYKfDON71usi1eQ+7bzKeNHVyEBoSamDUqUXjYtnVbqDYHyOzUZUHULQo38N0vqPxpz95LUhKLb+4NWQ7EwjvoPa+AAKrOJpikk9rWYQUrif4p1H5T1mj3ypAWs2h/MHn4BOItVu1hXp7HWMcq0YPY36ZS5oXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xIEWUZ/RpGwN63ey19rdu54s3JxAzx2BQFs6g161MzU=;
 b=RUi7dqZgM+mtZtcf/pRECQnQXo+1wglX/1gnrjvqV5yZAI1vZhgLkAQbcBf77QOtQj/9hKT95inr2gqlKAvQtuDVIIRmWnnkwryKhZEsRRsj+sdzuRZSuh5gWvCv1dAvQ1EET7TYXMX1xnK2DTi6Prn7LkRw1ldzaEk3pWBs6DM=
Received: from DM5PR08CA0057.namprd08.prod.outlook.com (2603:10b6:4:60::46) by
 DM4PR12MB6375.namprd12.prod.outlook.com (2603:10b6:8:a2::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6319.22; Thu, 20 Apr 2023 14:47:55 +0000
Received: from DM6NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:60:cafe::66) by DM5PR08CA0057.outlook.office365.com
 (2603:10b6:4:60::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.25 via Frontend
 Transport; Thu, 20 Apr 2023 14:47:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT061.mail.protection.outlook.com (10.13.173.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6319.26 via Frontend Transport; Thu, 20 Apr 2023 14:47:55 +0000
Received: from amd-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 20 Apr 2023 09:47:52 -0500
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 2/6] drm/amdgpu: Implement a new userqueue fence driver
Date: Thu, 20 Apr 2023 07:47:10 -0700
Message-ID: <20230420144714.124377-3-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230420144714.124377-1-Arunpravin.PaneerSelvam@amd.com>
References: <20230420144714.124377-1-Arunpravin.PaneerSelvam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT061:EE_|DM4PR12MB6375:EE_
X-MS-Office365-Filtering-Correlation-Id: fc058a82-f760-4d09-598a-08db41ae39b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P1FcfZDyfoqYXalC6ZPGO15dEui6npREvSnT8bi102e7dDQ+X3mjvYXV2CX3tUdtTnmwQMI2oaJ2hBisVbt5Upcv/NJGi+tsu4ud8J1heahUKba+JtetwJ1AC5puqTpYNpVuEMtASdGYEGwY4kF6Y1uDlvTTsLngqh+upJ3L9KJfPu1uPwfPsWxgCYeHMA/cXlD+c7mOZRPhO4CITlMhZvRDB3IrknTjHmnXYrKaYzqDp6R+nLLNfUWJ7qfFQVAUdu1IWXk2EzYFd+37yiAUyX8g8HC1h4fOEBDbCZhcqFkWMkbmqorIiJEu6L7GmbofKXskrxUJrN1RuGuJ8UOl+jOjJJC6l0QC1xWVfLPBOSgjH2QVHJZ6kzpOcQFmvaITI5ABdk1hvCeM7RBAKQSyrvxQPzvELGQKuHuXFgJzRpOdaWRhrNO1EWD/6t0Mx/BaJsvM+wGs+1Qmut7OxsAJtP/dSUsWTMYp83dHAQpEQiya0NKflbHs0llrqgie3OyZvD9AkRSmmNP7/htOBw63GbT8KYnOnuOyrMUat3I6+lIVMBlBhHRk8Xv1pVp5f1QXofoVRafmIsRgd5LFJ26OI1gOUDlJUtvAyAP1l8DzXGGzrnajqHCadGA1Ov30fuGsC1A3mhyL63wn3pSzQBcAX0gWYo+owEWYKtbgBjxcHQ5lLGtyCA9hyOtHYFMT27qYO1ppoqmzr3z4q0QsNCPbHv7ZSJ2TDdfEVQU/PG5g9vc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(346002)(136003)(376002)(451199021)(40470700004)(36840700001)(46966006)(40460700003)(54906003)(36756003)(66899021)(86362001)(82310400005)(478600001)(81166007)(356005)(41300700001)(8936002)(8676002)(5660300002)(30864003)(2906002)(82740400003)(40480700001)(4326008)(6916009)(316002)(70586007)(83380400001)(1076003)(26005)(16526019)(186003)(70206006)(426003)(336012)(6666004)(7696005)(47076005)(2616005)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 14:47:55.0577 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc058a82-f760-4d09-598a-08db41ae39b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6375
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
    - implement .signaled callback function

v3: Worked on review comments from Christian
    - Modify naming convention for reference counted objects
    - Fix fence driver reference drop issue
    - Drop amdgpu_userq_fence_driver_process() function return value

Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
---
 build.sh                                      |  11 +
 drivers/gpu/drm/amd/amdgpu/Makefile           |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   6 +
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 253 ++++++++++++++++++
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.h   |  64 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c |  19 ++
 .../gpu/drm/amd/include/amdgpu_userqueue.h    |   1 +
 7 files changed, 355 insertions(+), 1 deletion(-)
 create mode 100755 build.sh
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h

diff --git a/build.sh b/build.sh
new file mode 100755
index 000000000000..fddaff75dd2a
--- /dev/null
+++ b/build.sh
@@ -0,0 +1,11 @@
+#make -j16 modules M=drivers/gpu/drm/
+#make -j16 modules M=drivers/gpu/drm/selftests/
+make -j16 modules M=drivers/gpu/drm/amd/amdgpu/
+#make -j16 modules M=drivers/gpu/drm/ttm/
+#cp drivers/gpu/drm/drm.ko /lib/modules/$(uname -r)/kernel/drivers/gpu/drm/
+#cp drivers/gpu/drm/selftests/test-drm_buddy.ko /lib/modules/$(uname -r)/kernel/drivers/gpu/drm/selftests/
+#cp drivers/gpu/drm/amd/amdgpu/amdgpu.ko /lib/modules/$(uname -r)/kernel/drivers/gpu/drm/amd/amdgpu/
+#cp drivers/gpu/drm/ttm/ttm.ko /lib/modules/$(uname -r)/kernel/drivers/gpu/drm/ttm/
+#update-initramfs -c -k $(uname -r)
+#reboot
+
diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index d39504e65db1..8ed9be0d4818 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -59,7 +59,7 @@ amdgpu-y += amdgpu_device.o amdgpu_doorbell_mgr.o amdgpu_kms.o \
 	amdgpu_umc.o smu_v11_0_i2c.o amdgpu_fru_eeprom.o amdgpu_rap.o \
 	amdgpu_fw_attestation.o amdgpu_securedisplay.o \
 	amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o \
-	amdgpu_ring_mux.o amdgpu_seq64.o
+	amdgpu_ring_mux.o amdgpu_seq64.o amdgpu_userq_fence.o
 
 amdgpu-$(CONFIG_PROC_FS) += amdgpu_fdinfo.o
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 229976a2d0e7..e9c5047087d0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -53,6 +53,7 @@
 #include "amdgpu_xgmi.h"
 #include "amdgpu_reset.h"
 #include "amdgpu_userqueue.h"
+#include "amdgpu_userq_fence.h"
 
 /*
  * KMS wrapper.
@@ -2826,6 +2827,10 @@ static int __init amdgpu_init(void)
 	if (r)
 		goto error_fence;
 
+	r = amdgpu_userq_fence_slab_init();
+	if (r)
+		goto error_fence;
+
 	DRM_INFO("amdgpu kernel modesetting enabled.\n");
 	amdgpu_register_atpx_handler();
 	amdgpu_acpi_detect();
@@ -2850,6 +2855,7 @@ static void __exit amdgpu_exit(void)
 	amdgpu_unregister_atpx_handler();
 	amdgpu_sync_fini();
 	amdgpu_fence_slab_fini();
+	amdgpu_userq_fence_slab_fini();
 	mmu_notifier_synchronize();
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
new file mode 100644
index 000000000000..a03d12f83147
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -0,0 +1,253 @@
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
+int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
+				    struct amdgpu_usermode_queue *userq)
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
+void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_drv)
+{
+	struct amdgpu_userq_fence *userq_fence, *tmp;
+	struct dma_fence *fence;
+
+	if (!fence_drv)
+		return;
+
+	spin_lock(&fence_drv->fence_list_lock);
+	list_for_each_entry_safe(userq_fence, tmp, &fence_drv->fences, link) {
+		fence = &userq_fence->base;
+
+		if (amdgpu_userq_fence_read(fence_drv) >= fence->seqno) {
+			dma_fence_signal(fence);
+			list_del(&userq_fence->link);
+
+			dma_fence_put(fence);
+		} else {
+			break;
+		}
+	}
+	spin_unlock(&fence_drv->fence_list_lock);
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
+void amdgpu_userq_fence_driver_get(struct amdgpu_userq_fence_driver *fence_drv)
+{
+	kref_get(&fence_drv->refcount);
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
+	amdgpu_userq_fence_driver_get(fence_drv);
+	dma_fence_get(fence);
+
+	spin_lock(&fence_drv->fence_list_lock);
+	/* Check if hardware has already processed the job */
+	if (!dma_fence_is_signaled(fence)) {
+		list_add_tail(&userq_fence->link, &fence_drv->fences);
+	} else {
+		dma_fence_put(fence);
+	}
+	spin_unlock(&fence_drv->fence_list_lock);
+
+	*f = fence;
+
+	return 0;
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
+	struct dma_fence *fence = container_of(rcu, struct dma_fence, rcu);
+	struct amdgpu_userq_fence *userq_fence = to_amdgpu_userq_fence(fence);
+	struct amdgpu_userq_fence_driver *fence_drv = userq_fence->fence_drv;
+
+	/* Release the fence driver reference */
+	amdgpu_userq_fence_driver_put(fence_drv);
+	kmem_cache_free(amdgpu_userq_fence_slab, userq_fence);
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
index 000000000000..7329b4e5dd30
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
@@ -0,0 +1,64 @@
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
+#include "amdgpu_userqueue.h"
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
+int amdgpu_userq_fence_create(struct amdgpu_usermode_queue *userq,
+			      u64 seq, struct dma_fence **f);
+void amdgpu_userq_fence_driver_get(struct amdgpu_userq_fence_driver *fence_drv);
+void amdgpu_userq_fence_driver_put(struct amdgpu_userq_fence_driver *fence_drv);
+int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev, struct amdgpu_usermode_queue *userq);
+void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_drv);
+void amdgpu_userq_fence_driver_destroy(struct kref *ref);
+
+#endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index fd4a2ca3302d..8918b176fdcb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -24,6 +24,7 @@
 #include "amdgpu.h"
 #include "amdgpu_vm.h"
 #include "amdgpu_userqueue.h"
+#include "amdgpu_userq_fence.h"
 
 static inline int
 amdgpu_userqueue_index(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_queue *queue)
@@ -158,6 +159,8 @@ static int amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq
     struct amdgpu_fpriv *fpriv = filp->driver_priv;
     struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
     struct drm_amdgpu_userq_mqd *mqd_in = &args->in.mqd;
+    struct amdgpu_userq_fence_driver *fence_drv;
+    struct amdgpu_device *adev = uq_mgr->adev;
     uint64_t index;
     int r;
 
@@ -173,6 +176,12 @@ static int amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq
         return -ENOMEM;
     }
 
+    fence_drv = kzalloc(sizeof(struct amdgpu_userq_fence_driver), GFP_KERNEL);
+    if (!fence_drv) {
+	    DRM_ERROR("Failed to allocate memory for fence driver\n");
+	    return -ENOMEM;
+    }
+
     mutex_lock(&uq_mgr->userq_mutex);
     queue->userq_prop.wptr_gpu_addr = mqd_in->wptr_va;
     queue->userq_prop.rptr_gpu_addr = mqd_in->rptr_va;
@@ -188,6 +197,13 @@ static int amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq
         goto free_queue;
     }
 
+    queue->fence_drv = fence_drv;
+    r = amdgpu_userq_fence_driver_alloc(adev, queue);
+    if (r) {
+	    DRM_ERROR("Failed to alloc fence driver\n");
+	    goto free_fence_drv;
+    }
+
     queue->userq_prop.doorbell_index = index;
     queue->shadow_ctx_gpu_addr = mqd_in->shadow_va;
     queue->queue_type = mqd_in->ip_type;
@@ -217,6 +233,8 @@ static int amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq
     mutex_unlock(&uq_mgr->userq_mutex);
     return 0;
 
+free_fence_drv:
+    amdgpu_userq_fence_driver_put(queue->fence_drv);
 free_queue:
     mutex_unlock(&uq_mgr->userq_mutex);
     kfree(queue);
@@ -238,6 +256,7 @@ static void amdgpu_userqueue_destroy(struct drm_file *filp, int queue_id)
     mutex_lock(&uq_mgr->userq_mutex);
     uq_mgr->userq_funcs[queue->queue_type]->mqd_destroy(uq_mgr, queue);
     amdgpu_userqueue_free_index(uq_mgr, queue->queue_id);
+    amdgpu_userq_fence_driver_put(queue->fence_drv);
     mutex_unlock(&uq_mgr->userq_mutex);
     kfree(queue);
 }
diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
index eaab7cf5fff6..eaea88539007 100644
--- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
+++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
@@ -50,6 +50,7 @@ struct amdgpu_usermode_queue {
 	struct amdgpu_mqd_prop userq_prop;
 	struct amdgpu_userq_ctx_space mqd;
 	struct amdgpu_userq_ctx_space fw_space;
+	struct amdgpu_userq_fence_driver *fence_drv;
 };
 
 struct amdgpu_userq_funcs {
-- 
2.25.1

