Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56F77C05027
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Feb 2023 21:54:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C4DE10E919;
	Fri,  3 Feb 2023 21:54:46 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C23EA10E8E6
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Feb 2023 21:54:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IyR4KH2U0yfCnyxSEOjHhffTlWZ/0DCO2irbQIDbD2DT6YQ6yhOQFu8YlXIKsTfQBOsTMPO4KSeV/BoTF15cD4Pwkh/cil/ThRS59p4B7dSx18FVIPcRlfV8SA8RyaBm7nMaEXTlmom6QgSCLy9FsWhM/p2h5tU+aOmWFWQMxSm/SUyW08qSKAef1M8cK5kOIjRVZiGYOV9tdwlHTTsipdvQb8+LaaI4WLYXWh72ITvFf4ffJbVFNZpBTPEzdaZ1i5yF06NWLG/Ui7K+XPJKzfwkZ1XFbR/XSvzkVfWMhRO4AvrCQCOD8fDHlghdcJZpFz+NQtLdNbpfQJNQ432Jng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Q8BP+5H56suCeyAB9da/FWht1EgdznzCQbin4uWpAM=;
 b=BBG0jvgVzD8AcLYc/0lXO8nRLZ+KyMmDoAFtM2WgXpZCU4rcp7KFxPgXpKN75rKlYVoGSNbGsGN0i1sejvygaaIvT6X57aHe1BLSeZ1K0Eo0ZQqGwqFwiUcvQhLSCaR8O2eG1Ni8jwD/rFS6svAcCQOPruvS5Jk7K6ko8tA2mHdqkOB8uOLkxUYvp90r/HjEc7/mSBH8Ii5XNfV6KglUKiexqwP193UYVIXulh+/x/IAaax7T+tHmthsvhLHz9/d5iOi2DYwHggaFpT31zNNGF2QQWyZJGCzHLMEctHYu+HRKZxZO1Cy+o2rR6l3NvknadCBKnsIcfx2aZgP7XrSYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Q8BP+5H56suCeyAB9da/FWht1EgdznzCQbin4uWpAM=;
 b=HRBE2BQwvhp20DNab8VciNHvmiGGW2DM1kllxlAQRSOldJF4fByQB8ouqsMKyX+UuEyPqPnVdSQV1iGOMEh6UxpBFsacP8nUchDx31BtE5y2sWO+2xTgAMu9RrnNTRH9vZLMFlVhP4HCjGb0rnhUF56fV1iSx9B8Va/+E7yRJ0k=
Received: from CY5PR19CA0132.namprd19.prod.outlook.com (2603:10b6:930:64::29)
 by CH3PR12MB8534.namprd12.prod.outlook.com (2603:10b6:610:15a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.29; Fri, 3 Feb
 2023 21:54:41 +0000
Received: from CY4PEPF0000C977.namprd02.prod.outlook.com
 (2603:10b6:930:64:cafe::ed) by CY5PR19CA0132.outlook.office365.com
 (2603:10b6:930:64::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.31 via Frontend
 Transport; Fri, 3 Feb 2023 21:54:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C977.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6064.18 via Frontend Transport; Fri, 3 Feb 2023 21:54:40 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 3 Feb
 2023 15:54:35 -0600
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/8] drm/amdgpu: add usermode queues
Date: Fri, 3 Feb 2023 22:54:03 +0100
Message-ID: <20230203215409.2021-3-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20230203215409.2021-1-shashank.sharma@amd.com>
References: <20230203215409.2021-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C977:EE_|CH3PR12MB8534:EE_
X-MS-Office365-Filtering-Correlation-Id: e0bea64f-4eeb-42f8-9fda-08db06314043
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JSoMY6S66Y/j06NP4m9gcEKwasRNx3/+dB0UawXNbN9JcQR/ojjKGZ3EqrjWr1hmTD5FesDN684zupN6Dw1d0JRL/34Q7F8jlvtRunG+OxpHDpZqNZF9PYT9owmTIo1JC+CIbOHDCgs+q+LrYIqpL/pf/IUatp5nPLptuPK2UjNovYWSkwCb7pRjDfeL1wn0rcL6lvIzkBauQEvsOSfIP+j4RKZlFiZMH1j5nQ9o734gy+qYuguvRdPzK7tJ1j5nSOXACyj8ukio9Qe6VUIpMOD4d1VHshKXfSKmK1vqI74pb29InJVsmyhqa+0fjVdQBtVfQvhUk0YwDWlUy8vgKZbFRCog7aAidCirJCv8hIX3Pyh9/6SivTY8JJY4ocWGV2cwQVssaepa4vuRvB/+G/fhHEoHJtbdrdI0MdELEYcQjs43mDZ9g0JzBr64oVF7UhXfeq/sPKk2/YFWqNYIma9zVqna7eIttfetzd0gJtK15P8MKmUNg/BdtXWt0DMPe82gHOiQdI0m+frkpOY34gSW81690QUKGwDtmz5BOjJ/0xADJGDJuJ7Bw8uswfql/CkOADGeqPwaDzACTzueuCWkqBLCoUstcMPsTXpnanRPJ4HDUosw9oz+Rt5L3ercDleVdaD8asxbTzPeNTIBh6ZgSmbPS9lwuIEpLUnJiGjNpNp2Q4zJTUCghBNI1ucT
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(376002)(346002)(396003)(136003)(451199018)(40470700004)(46966006)(36840700001)(40480700001)(83380400001)(54906003)(2616005)(82740400003)(6916009)(81166007)(47076005)(82310400005)(8676002)(70206006)(70586007)(86362001)(41300700001)(316002)(426003)(356005)(1076003)(4326008)(5660300002)(336012)(478600001)(66899018)(30864003)(44832011)(6666004)(36756003)(7696005)(2906002)(36860700001)(186003)(26005)(16526019)(8936002)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2023 21:54:40.3301 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0bea64f-4eeb-42f8-9fda-08db06314043
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C977.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8534
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
Cc: alexander.deucher@amd.com,
 Shashank Sharma <contactshashanksharma@gmail.com>, christian.koenig@amd.com,
 shashank.sharma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Shashank Sharma <contactshashanksharma@gmail.com>

This patch adds skeleton code for usermode queue creation. It
typically contains:
- A new structure to keep all the user queue data in one place.
- An IOCTL function to create/free a usermode queue.
- A function to generate unique index for the queue.
- A queue context manager in driver private data.

V1: Worked on design review comments from RFC patch series:
(https://patchwork.freedesktop.org/series/112214/)

- Alex: Keep a list of queues, instead of single queue per process.
- Christian: Use the queue manager instead of global ptrs,
           Don't keep the queue structure in amdgpu_ctx

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Signed-off-by: Shashank Sharma <contactshashanksharma@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile           |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |   5 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 155 ++++++++++++++++++
 .../gpu/drm/amd/include/amdgpu_userqueue.h    |  64 ++++++++
 6 files changed, 230 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
 create mode 100644 drivers/gpu/drm/amd/include/amdgpu_userqueue.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 798d0e9a60b7..764801cc8203 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -210,6 +210,8 @@ amdgpu-y += \
 # add amdkfd interfaces
 amdgpu-y += amdgpu_amdkfd.o
 
+# add usermode queue
+amdgpu-y += amdgpu_userqueue.o
 
 ifneq ($(CONFIG_HSA_AMD),)
 AMDKFD_PATH := ../amdkfd
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 6b74df446694..0625d6bdadf4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -109,6 +109,7 @@
 #include "amdgpu_fdinfo.h"
 #include "amdgpu_mca.h"
 #include "amdgpu_ras.h"
+#include "amdgpu_userqueue.h"
 
 #define MAX_GPU_INSTANCE		16
 
@@ -482,6 +483,7 @@ struct amdgpu_fpriv {
 	struct mutex		bo_list_lock;
 	struct idr		bo_list_handles;
 	struct amdgpu_ctx_mgr	ctx_mgr;
+	struct amdgpu_userq_mgr	userq_mgr;
 };
 
 int amdgpu_file_to_fpriv(struct file *filp, struct amdgpu_fpriv **fpriv);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index b4f2d61ea0d5..229976a2d0e7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -52,6 +52,7 @@
 #include "amdgpu_ras.h"
 #include "amdgpu_xgmi.h"
 #include "amdgpu_reset.h"
+#include "amdgpu_userqueue.h"
 
 /*
  * KMS wrapper.
@@ -2748,6 +2749,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
 	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_VA, amdgpu_gem_va_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_OP, amdgpu_gem_op_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_USERPTR, amdgpu_gem_userptr_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
+	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ, amdgpu_userq_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 };
 
 static const struct drm_driver amdgpu_kms_driver = {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 7aa7e52ca784..52e61e339a88 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1187,6 +1187,10 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 
 	amdgpu_ctx_mgr_init(&fpriv->ctx_mgr, adev);
 
+	r = amdgpu_userq_mgr_init(&fpriv->userq_mgr, adev);
+	if (r)
+		DRM_WARN("Can't setup usermode queues, only legacy workload submission will work\n");
+
 	file_priv->driver_priv = fpriv;
 	goto out_suspend;
 
@@ -1254,6 +1258,7 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
 
 	amdgpu_ctx_mgr_fini(&fpriv->ctx_mgr);
 	amdgpu_vm_fini(adev, &fpriv->vm);
+	amdgpu_userq_mgr_fini(&fpriv->userq_mgr);
 
 	if (pasid)
 		amdgpu_pasid_free_delayed(pd->tbo.base.resv, pasid);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
new file mode 100644
index 000000000000..d5bc7fe81750
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -0,0 +1,155 @@
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
+
+#include "amdgpu.h"
+#include "amdgpu_vm.h"
+
+static inline int
+amdgpu_userqueue_index(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_queue *queue)
+{
+    return idr_alloc(&uq_mgr->userq_idr, queue, 1, AMDGPU_MAX_USERQ, GFP_KERNEL);
+}
+
+static inline void
+amdgpu_userqueue_free_index(struct amdgpu_userq_mgr *uq_mgr, int queue_id)
+{
+    idr_remove(&uq_mgr->userq_idr, queue_id);
+}
+
+static struct amdgpu_usermode_queue
+*amdgpu_userqueue_find(struct amdgpu_userq_mgr *uq_mgr, int qid)
+{
+    return idr_find(&uq_mgr->userq_idr, qid);
+}
+
+static int amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
+{
+    int r, pasid;
+    struct amdgpu_usermode_queue *queue;
+    struct amdgpu_fpriv *fpriv = filp->driver_priv;
+    struct amdgpu_vm *vm = &fpriv->vm;
+    struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
+    struct drm_amdgpu_userq_mqd *mqd_in = &args->in.mqd;
+
+    pasid = vm->pasid;
+    if (vm->pasid < 0) {
+        DRM_WARN("No PASID info found\n");
+        pasid = 0;
+    }
+
+    mutex_lock(&uq_mgr->userq_mutex);
+
+    queue = kzalloc(sizeof(struct amdgpu_usermode_queue), GFP_KERNEL);
+    if (!queue) {
+        DRM_ERROR("Failed to allocate memory for queue\n");
+        mutex_unlock(&uq_mgr->userq_mutex);
+        return -ENOMEM;
+    }
+
+    queue->vm = vm;
+    queue->pasid = pasid;
+    queue->wptr_gpu_addr = mqd_in->wptr_va;
+    queue->rptr_gpu_addr = mqd_in->rptr_va;
+    queue->queue_size = mqd_in->queue_size;
+    queue->queue_type = mqd_in->ip_type;
+    queue->queue_gpu_addr = mqd_in->queue_va;
+    queue->flags = mqd_in->flags;
+    queue->use_doorbell = true;
+    queue->queue_id = amdgpu_userqueue_index(uq_mgr, queue);
+    if (queue->queue_id < 0) {
+        DRM_ERROR("Failed to allocate a queue id\n");
+        r = queue->queue_id;
+        goto free_queue;
+    }
+
+    list_add_tail(&queue->userq_node, &uq_mgr->userq_list);
+    args->out.q_id = queue->queue_id;
+    args->out.flags = 0;
+    mutex_unlock(&uq_mgr->userq_mutex);
+    return 0;
+
+free_queue:
+    mutex_unlock(&uq_mgr->userq_mutex);
+    kfree(queue);
+    return r;
+}
+
+static void amdgpu_userqueue_destroy(struct drm_file *filp, int queue_id)
+{
+    struct amdgpu_fpriv *fpriv = filp->driver_priv;
+    struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
+    struct amdgpu_usermode_queue *queue;
+
+    queue = amdgpu_userqueue_find(uq_mgr, queue_id);
+    if (!queue) {
+        DRM_DEBUG_DRIVER("Invalid queue id to destroy\n");
+        return;
+    }
+
+    mutex_lock(&uq_mgr->userq_mutex);
+    amdgpu_userqueue_free_index(uq_mgr, queue->queue_id);
+    list_del(&queue->userq_node);
+    mutex_unlock(&uq_mgr->userq_mutex);
+    kfree(queue);
+}
+
+int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
+		       struct drm_file *filp)
+{
+    union drm_amdgpu_userq *args = data;
+    int r = 0;
+
+    switch (args->in.op) {
+    case AMDGPU_USERQ_OP_CREATE:
+        r = amdgpu_userqueue_create(filp, args);
+        if (r)
+            DRM_ERROR("Failed to create usermode queue\n");
+        break;
+
+    case AMDGPU_USERQ_OP_FREE:
+        amdgpu_userqueue_destroy(filp, args->in.queue_id);
+        break;
+
+    default:
+        DRM_ERROR("Invalid user queue op specified: %d\n", args->in.op);
+        return -EINVAL;
+    }
+
+    return r;
+}
+
+int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amdgpu_device *adev)
+{
+    mutex_init(&userq_mgr->userq_mutex);
+    idr_init_base(&userq_mgr->userq_idr, 1);
+    INIT_LIST_HEAD(&userq_mgr->userq_list);
+    userq_mgr->adev = adev;
+
+    return 0;
+}
+
+void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
+{
+    idr_destroy(&userq_mgr->userq_idr);
+    mutex_destroy(&userq_mgr->userq_mutex);
+}
diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
new file mode 100644
index 000000000000..9557588fe34f
--- /dev/null
+++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
@@ -0,0 +1,64 @@
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
+
+#ifndef AMDGPU_USERQUEUE_H_
+#define AMDGPU_USERQUEUE_H_
+
+#define AMDGPU_MAX_USERQ 512
+
+struct amdgpu_userq_mgr {
+	struct idr userq_idr;
+	struct mutex userq_mutex;
+	struct list_head userq_list;
+	struct amdgpu_device *adev;
+};
+
+struct amdgpu_usermode_queue {
+	int		queue_id;
+	int		queue_type;
+	int		queue_size;
+	int		pasid;
+	int		doorbell_index;
+	int 		use_doorbell;
+
+	uint64_t	wptr_gpu_addr;
+	uint64_t	rptr_gpu_addr;
+	uint64_t	queue_gpu_addr;
+	uint64_t	flags;
+
+	uint64_t	mqd_gpu_addr;
+	void 		*mqd_cpu_ptr;
+
+	struct amdgpu_bo	*mqd_obj;
+	struct amdgpu_vm    	*vm;
+	struct amdgpu_userq_mgr *userq_mgr;
+	struct list_head 	userq_node;
+};
+
+int amdgpu_userq_ioctl(struct drm_device *dev, void *data, struct drm_file *filp);
+
+int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amdgpu_device *adev);
+
+void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr);
+
+#endif
-- 
2.34.1

