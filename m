Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7170FC47077
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jan 2024 20:35:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 185AB10E5C1;
	Tue, 16 Jan 2024 20:35:33 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2049.outbound.protection.outlook.com [40.107.96.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D54F010E5B8
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jan 2024 20:35:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bMC/83LCjBjfRizY5NOEgB9SsEWUK34mOVmqCCWK2LFvdsqqQRvvr01tU8QfEds0TCB0XB2Nh6nE7VzZarUtiJy4Nmhse4xlwNMsDaj4/QYWUOduJP8aEiltr8PcReVxnDd2zQ3VOf4N/wQGGdZD1mSH7JcpqB5D0ZIUWMmLMGr7IXcy2yCFz6xkF1aypfTcHnSJ8cV2Heaw8KpZVxwRgJOMG+Z2HDIckVNOuexQ93EOtGPsvf5ALPaUfZPJYC4HjjA2H0mwo2sHtDPeS02U/nea5OLCxdS7NMK/QL5rSQF2v6PqShPkOY3mL3w0eOgOlze4uMV7GLZ0dABxznCQ4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FD0Q5hiOk2cdhXUUEeNLbStosW9UuziQbiTmHEUEulE=;
 b=BMnySsLclwO7EHjpfun6dPHV66NdJwGF1DbnSb9QVwoVdRcRCOjGczSU56cjhSQx2yH6DJGppJCdR3Qcs2GsE8hu/9KRtIMglOBexW2nDLzOgnGi0VCiZ0tpJtfHL3wfhhnworfHrwCLCAmO0S0+4HTNYfXie0FP1wrHub6BguDYMw4LEMd8dPqDh5PCZuq9moDl3qCeEGAMqFp5+63ioZfpjebn62ijzno0TuR8Iqb+iPrBMaop1qvMXNCF0bHzQ44kXXFIw/+S8F6U6lpeVIWHicWtdvtG97JF3pHzu4Nl0pNdHlD7Gjeqz2xXZhjk4c6VDiNyDwEosCannL1IAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FD0Q5hiOk2cdhXUUEeNLbStosW9UuziQbiTmHEUEulE=;
 b=AwG80E0s5zg6iSQcODHjS0V52ZWCyA1QtDk7dfx9ozSxmedF/XEAjmALOJGBof9yLJdKfJOs/LeS+auz+Ajov2oXYUnuqY3Pik0YfBhlO2uWPEbq2zSMaJAwe7hx6YStaENZjXSR6nHELmg6WhNjwxdmlhRaiDZnV6HyGOfZg3k=
Received: from DM6PR13CA0043.namprd13.prod.outlook.com (2603:10b6:5:134::20)
 by SJ0PR12MB8614.namprd12.prod.outlook.com (2603:10b6:a03:47d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.26; Tue, 16 Jan
 2024 20:35:12 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:5:134:cafe::63) by DM6PR13CA0043.outlook.office365.com
 (2603:10b6:5:134::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.22 via Frontend
 Transport; Tue, 16 Jan 2024 20:35:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Tue, 16 Jan 2024 20:35:12 +0000
Received: from amd-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 16 Jan 2024 14:35:09 -0600
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v8 1/9] drm/amdgpu: Implement a new userqueue fence driver
Date: Tue, 16 Jan 2024 12:34:35 -0800
Message-ID: <20240116203439.802772-1-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|SJ0PR12MB8614:EE_
X-MS-Office365-Filtering-Correlation-Id: d434cccd-67a9-4b0a-42b1-08dc16d2a378
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ts7xITqrQ2i255mk2+kJNGEH7wZ/V4Xu30/FdVvfg7wPm478zq+Qi9jcPhpZ+JioObdrTb+qqEdKDXB7xOzVH/4kTquWs0iTglYNl5VfQFkHwU5YSw+X27oUezBcqk+pqaplVd4bXpEpQHZmb9IVDn3h8uivIilX//wd+/c85tL6h5alr8zW47SJQ7HvLJu7DDKfeAiVaKnrE/22HkHR40MK4bucn68zvP+JoyubKj4vCtsaE5XgceSZympV0A7onhM1V8ePp87OLq+xHy7wUPbvH0HqbBU3kwTfRJ54f64EFKBi6DJRo7VJzj5SG8oaso2N43hVNP9WqpLvRXudJfhLPd/XPjkSlsAAsTaq/6F70TUSokO5jfb6O2RnrOWfa4ddv/7umotdVON8uw52SAMVsFaPinS50xsf8FfEk88ZPHuLFzvuoI4wQdkv9DZjmCQ6/aiz5khJqeebsJeGFsPLfvhBkkuf//9sSdRGvcHMQvAkbsWPf+r7LZmnCzmC5zNccQVEOSOfHB/+uioOpxe7C3U8paFIFgbfZMFbcSqROhe4ScIozxoPFldVUtsboZA5MlaDte3fdq20G64eY9OygrLtTROxoxP6L1V4y15mdbD80cF97YPfTzcy2mQB2mi2dYgzCcblyIFLhIWpBI/W3ngdEeYzHXhP4+Ikhkvh4b4SLj3sB9sG1osiaFcPXZjbi33qBOW6SH5XSMswOoiaJAcPPLs3EpcKnw5D6oH8WnmPiDZLJmIDJAmMXzcN4AjcMYegQDP6aYE2HcFwXw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(346002)(39860400002)(136003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(82310400011)(36840700001)(46966006)(40470700004)(70206006)(54906003)(40480700001)(40460700003)(6916009)(478600001)(316002)(70586007)(8936002)(4326008)(8676002)(36860700001)(47076005)(356005)(81166007)(26005)(7696005)(6666004)(36756003)(1076003)(426003)(2616005)(336012)(16526019)(2906002)(41300700001)(5660300002)(83380400001)(82740400003)(66899024)(86362001)(30864003)(66574015)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 20:35:12.0184 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d434cccd-67a9-4b0a-42b1-08dc16d2a378
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8614
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
    - Add dma_fence_put below the list_del as it might
      frees the userq fence.
    - Trim unnecessary code in interrupt handler.
    - Check dma fence signaled state in dma fence creation
      function for a potential problem of hardware completing
      the job processing beforehand.
    - Add necessary locks.
    - Create a list and process all the unsignaled fences.
    - clean up fences in destroy function.
    - implement .signaled callback function

v3: Worked on review comments from Christian
    - Modify naming convention for reference counted objects
    - Fix fence driver reference drop issue
    - Drop amdgpu_userq_fence_driver_process() function return value

v4: Worked on review comments from Christian
    - Moved fence driver allocation into amdgpu_userq_fence_driver_alloc()
    - Added detail doc mentioning the differences b/w
      two spinlocks declared.

v5: Worked on review comments from Christian
    - Check before upcast and remove local variable
    - Add error handling in fence_drv alloc function.
    - Move rptr read fn outside of the loop and remove WARN_ON in
      destroy function.

Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile           |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   6 +
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 255 ++++++++++++++++++
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.h   |  69 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c |   8 +
 .../gpu/drm/amd/include/amdgpu_userqueue.h    |   1 +
 6 files changed, 340 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index f469b7a6cae8..25a0e1041531 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -80,7 +80,7 @@ amdgpu-y += amdgpu_device.o amdgpu_doorbell_mgr.o amdgpu_kms.o \
 	amdgpu_umc.o smu_v11_0_i2c.o amdgpu_fru_eeprom.o amdgpu_rap.o \
 	amdgpu_fw_attestation.o amdgpu_securedisplay.o \
 	amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o \
-	amdgpu_ring_mux.o amdgpu_xcp.o
+	amdgpu_ring_mux.o amdgpu_xcp.o amdgpu_userq_fence.o
 
 amdgpu-$(CONFIG_PROC_FS) += amdgpu_fdinfo.o
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 81d8030be5ec..7976842d993e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -51,6 +51,7 @@
 #include "amdgpu_sched.h"
 #include "amdgpu_xgmi.h"
 #include "amdgpu_userqueue.h"
+#include "amdgpu_userq_fence.h"
 #include "../amdxcp/amdgpu_xcp_drv.h"
 
 /*
@@ -2932,6 +2933,10 @@ static int __init amdgpu_init(void)
 	if (r)
 		goto error_fence;
 
+	r = amdgpu_userq_fence_slab_init();
+	if (r)
+		goto error_fence;
+
 	DRM_INFO("amdgpu kernel modesetting enabled.\n");
 	amdgpu_register_atpx_handler();
 	amdgpu_acpi_detect();
@@ -2957,6 +2962,7 @@ static void __exit amdgpu_exit(void)
 	amdgpu_acpi_release();
 	amdgpu_sync_fini();
 	amdgpu_fence_slab_fini();
+	amdgpu_userq_fence_slab_fini();
 	mmu_notifier_synchronize();
 	amdgpu_xcp_drv_release();
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
new file mode 100644
index 000000000000..26ff670d1fc9
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -0,0 +1,255 @@
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
+static const struct dma_fence_ops amdgpu_userq_fence_ops;
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
+	if (!f || f->ops != &amdgpu_userq_fence_ops)
+		return NULL;
+
+	return container_of(f, struct amdgpu_userq_fence, base);
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
+	fence_drv = kzalloc(sizeof(*fence_drv), GFP_KERNEL);
+	if (!fence_drv) {
+		DRM_ERROR("Failed to allocate memory for fence driver\n");
+		return -ENOMEM;
+	}
+
+	/* Acquire seq64 memory */
+	r = amdgpu_seq64_alloc(adev, &fence_drv->gpu_addr,
+			       &fence_drv->cpu_addr);
+	if (r) {
+		kfree(fence_drv);
+		return -ENOMEM;
+	}
+
+	kref_init(&fence_drv->refcount);
+	INIT_LIST_HEAD(&fence_drv->fences);
+	spin_lock_init(&fence_drv->fence_list_lock);
+
+	fence_drv->adev = adev;
+	fence_drv->context = dma_fence_context_alloc(1);
+	get_task_comm(fence_drv->timeline_name, current);
+
+	userq->fence_drv = fence_drv;
+
+	return 0;
+}
+
+void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_drv)
+{
+	struct amdgpu_userq_fence *userq_fence, *tmp;
+	struct dma_fence *fence;
+	u64 rptr;
+
+	if (!fence_drv)
+		return;
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
+	if (!dma_fence_is_signaled(fence))
+		list_add_tail(&userq_fence->link, &fence_drv->fences);
+	else
+		dma_fence_put(fence);
+
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
index 000000000000..c3e04cdbb9e7
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
@@ -0,0 +1,69 @@
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
+	/*
+	 * This lock is necessary to synchronize the
+	 * userqueue dma fence operations.
+	 */
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
+	/*
+	 * This lock is necesaary to synchronize the access
+	 * to the fences list by the fence driver.
+	 */
+	spinlock_t fence_list_lock;
+	struct list_head fences;
+	struct amdgpu_device *adev;
+	char timeline_name[TASK_COMM_LEN];
+};
+
+int amdgpu_userq_fence_slab_init(void);
+void amdgpu_userq_fence_slab_fini(void);
+int amdgpu_userq_fence_create(struct amdgpu_usermode_queue *userq,
+			      u64 seq, struct dma_fence **f);
+void amdgpu_userq_fence_driver_get(struct amdgpu_userq_fence_driver *fence_drv);
+void amdgpu_userq_fence_driver_put(struct amdgpu_userq_fence_driver *fence_drv);
+int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
+				    struct amdgpu_usermode_queue *userq);
+void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_drv);
+void amdgpu_userq_fence_driver_destroy(struct kref *ref);
+
+#endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index 26cdd54acd74..c0bb3f5c45a6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -25,6 +25,7 @@
 #include "amdgpu.h"
 #include "amdgpu_vm.h"
 #include "amdgpu_userqueue.h"
+#include "amdgpu_userq_fence.h"
 
 static void
 amdgpu_userqueue_cleanup(struct amdgpu_userq_mgr *uq_mgr,
@@ -35,6 +36,7 @@ amdgpu_userqueue_cleanup(struct amdgpu_userq_mgr *uq_mgr,
 	const struct amdgpu_userq_funcs *uq_funcs = adev->userq_funcs[queue->queue_type];
 
 	uq_funcs->mqd_destroy(uq_mgr, queue);
+	amdgpu_userq_fence_driver_put(queue->fence_drv);
 	idr_remove(&uq_mgr->userq_idr, queue_id);
 	kfree(queue);
 }
@@ -302,6 +304,12 @@ amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	}
 	queue->doorbell_index = index;
 
+	r = amdgpu_userq_fence_driver_alloc(adev, queue);
+	if (r) {
+		DRM_ERROR("Failed to alloc fence driver\n");
+		goto unlock;
+	}
+
 	r = uq_funcs->mqd_create(uq_mgr, &args->in, queue);
 	if (r) {
 		DRM_ERROR("Failed to create Queue\n");
diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
index f1e3d311ae18..354aaa8cfa12 100644
--- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
+++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
@@ -48,6 +48,7 @@ struct amdgpu_usermode_queue {
 	struct amdgpu_userq_obj	db_obj;
 	struct amdgpu_userq_obj fw_obj;
 	struct amdgpu_userq_obj wptr_obj;
+	struct amdgpu_userq_fence_driver *fence_drv;
 };
 
 struct amdgpu_userq_funcs {
-- 
2.25.1

