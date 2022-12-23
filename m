Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECA54C3DA79
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Dec 2022 19:37:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12D5C10E220;
	Fri, 23 Dec 2022 19:37:35 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56B7910E220
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Dec 2022 19:37:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R4GfV2Ru/WduIvkwzmxjUeCtQsqIV43LsnU2lB00CZpYgoP5KcF7hcMzRVM/n/9XdqgwRejTt0RPziRDrky7yYfnepTrtnKQbBA3jOlVN2oWFP4lhDvPXHY4nAFdl6OiDCaXIIriePyGjZ6+AxHDc7SItjushEcc5NEC1MVWKcRCTsBZsrGnB+ve5hSd2V/pQfeQFbyV/j1CZVKSRWd+WEcgLJ06z98s24T+Yq6K4yteKYdHsoyKg3G0KB1W6UH1HpgIuKj9WqKhNo8JIpBVWi3tYHl4w5DRIZ3wTLtJVmrnYgiWx2FllA9A0CX0bNUM0NoDXtHNIgw858JKB0N6Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x++eoAjniSjRrAp8CpvOXYNLM0p0XNJOM4zsWfO8Wh8=;
 b=IjLn44BbRNIVFfVH4jrMzBmiqrJng6EYl8Y/3mTj/uu81+0gxOOgR358nzR25p5YXYchR6rMNg5HwhMqQNjfiejSkx88OIY022aBUZBz7+jUFjUaeuw98J4AcN2pDfOtX0PcJpuMNOdnbi0sW/AhT6YPjhiZDH4b+uaW18kk+f0guYO2IPvZZ6nY4nbMxsXmVrK/AoWtUACWflPQxJSVM0gOeAenOGiw3hcMMQrjvvaexDH7q1IuQ57qTXQimhKBddG8UcsI9H9wn+3mjbg8vv7vJ0NA7+fYveS3M2sNnb3p/+SHhqKCAyHmhJcx0nu7H1tpes3Et9F8h3BQqQ1JuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x++eoAjniSjRrAp8CpvOXYNLM0p0XNJOM4zsWfO8Wh8=;
 b=JJTIPUpeMCmjHR/P0i5I4HCqFTsjnLV1R0BPIgB8m+gpmY+Y1G+FRY/yqsitdAMgToVhPPzwBitHPN6dLF8eHLDDvKYla6HLj6KUfCZtCpQYYzuCdFpE+3MRYp9IFaMAIfuC5K4wLtkOXVHV9P62DySOwDhnkBG63uHqkONbGSI=
Received: from MW2PR2101CA0031.namprd21.prod.outlook.com (2603:10b6:302:1::44)
 by BL1PR12MB5922.namprd12.prod.outlook.com (2603:10b6:208:399::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.13; Fri, 23 Dec
 2022 19:37:29 +0000
Received: from CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:302:1:cafe::4e) by MW2PR2101CA0031.outlook.office365.com
 (2603:10b6:302:1::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5966.11 via Frontend
 Transport; Fri, 23 Dec 2022 19:37:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT055.mail.protection.outlook.com (10.13.175.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5944.14 via Frontend Transport; Fri, 23 Dec 2022 19:37:28 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 23 Dec
 2022 13:37:25 -0600
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [RFC 2/7] drm/amdgpu: Add usermode queue for gfx work
Date: Fri, 23 Dec 2022 20:36:50 +0100
Message-ID: <20221223193655.1972-3-shashank.sharma@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT055:EE_|BL1PR12MB5922:EE_
X-MS-Office365-Filtering-Correlation-Id: 26be1398-02d7-4dfc-8c5d-08dae51d2036
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eiJP4dyNgyYItEY7a0WQp4YamD9cBeDmgCEojzg8JzQriaCZf9YytvCqssnwmxxaleeiaxWV1A6BE7j1ZhYQ9fB7k28eOvCPe5CMrxSrDwMfnhhV9Q1wuFNFrc9EIXFyAs5ORoIA+snevzZRl3RLU2IplOHqryAJCXktMlX1Gy8jA+f0F14u0DTlhwlDski8ewr3vH+/umZdMp5+qR/HaiGMgB/8KM89rLaRqqg/4eJSsPtz2ZPV4H5KQXrSbvKG4m7DFlSnvOrXmURUzsLAF+0/S2AeVma0/TRkI6WvwBE9o13gUTL7APQWOWMDQn/CQId2fwdgajaCi6G9Htk9D23AYsc/3CUmTKvSN9nIXvN3/R0Q9oZOe6YWilhxdyvxY8myQdPn2nSpYZ5FD3KBbP0RuxGYSyOU8w/ct3H4kGSBNll2U3P8wrL+SJLqoVP1A/DewMsagv38IMiBEddA0dM4VjkyHzr8wZBK+AtyvlMnVedXow0sWY5T46wDMfySsu2BgzGFo1e0AuKJ11bxzBdUK7XocSfvn0ftziQcs8FYulvv0wXy5ey/IWyai4dS8HoRpn1xM2a5TAdbb4C0T3IXCU6eP+VFMaHxDDQ0pQDx/oNT/YxCUTx91bIWQMajWJs3Q8V1O0E+pNZFDf3oVg3huK401y61S7ShcaDNKpf2XL2+b+n2/Fyrs538Ln3tLptlLlRNg/L5KXd0ZhTZdViqYiqjo4uBt2CknBNOP9M=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(376002)(346002)(136003)(396003)(451199015)(40470700004)(36840700001)(46966006)(316002)(2906002)(36756003)(47076005)(54906003)(6916009)(426003)(44832011)(356005)(83380400001)(40460700003)(478600001)(7696005)(86362001)(6666004)(40480700001)(2616005)(1076003)(336012)(16526019)(186003)(26005)(82740400003)(36860700001)(8936002)(82310400005)(66899015)(41300700001)(5660300002)(70206006)(70586007)(81166007)(8676002)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2022 19:37:28.1885 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26be1398-02d7-4dfc-8c5d-08dae51d2036
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5922
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
 Shashank Sharma <shashank.sharma@amd.com>,
 Christian Koenig <christian.koenig@amd.com>, arvind.yadav@amd.com,
 arunpravin.paneerselvam@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch adds skeleton code for usermode queue creation. It
typically contains:
- A new structure to keep all the user queue data in one place.
- An IOCTL function to create/free a usermode queue.
- A function to generate unique index for the queue.
- A global ptr in amdgpu_dev

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile           |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   6 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h       |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 187 ++++++++++++++++++
 .../drm/amd/include/amdgpu_usermode_queue.h   |  50 +++++
 5 files changed, 246 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
 create mode 100644 drivers/gpu/drm/amd/include/amdgpu_usermode_queue.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 6ad39cf71bdd..e2a34ee57bfb 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -209,6 +209,8 @@ amdgpu-y += \
 # add amdkfd interfaces
 amdgpu-y += amdgpu_amdkfd.o
 
+# add usermode queue
+amdgpu-y += amdgpu_userqueue.o
 
 ifneq ($(CONFIG_HSA_AMD),)
 AMDKFD_PATH := ../amdkfd
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 8639a4f9c6e8..4b566fcfca18 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -749,6 +749,11 @@ struct amdgpu_mqd {
 			struct amdgpu_mqd_prop *p);
 };
 
+struct amdgpu_userq_globals {
+	struct ida ida;
+	struct mutex userq_mutex;
+};
+
 #define AMDGPU_RESET_MAGIC_NUM 64
 #define AMDGPU_MAX_DF_PERFMONS 4
 #define AMDGPU_PRODUCT_NAME_LEN 64
@@ -955,6 +960,7 @@ struct amdgpu_device {
 	bool                            enable_mes_kiq;
 	struct amdgpu_mes               mes;
 	struct amdgpu_mqd               mqds[AMDGPU_HW_IP_NUM];
+	struct amdgpu_userq_globals	userq;
 
 	/* df */
 	struct amdgpu_df                df;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
index 0fa0e56daf67..f7413859b14f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
@@ -57,6 +57,7 @@ struct amdgpu_ctx {
 	unsigned long			ras_counter_ce;
 	unsigned long			ras_counter_ue;
 	uint32_t			stable_pstate;
+	struct amdgpu_usermode_queue	*userq;
 };
 
 struct amdgpu_ctx_mgr {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
new file mode 100644
index 000000000000..3b6e8f75495c
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -0,0 +1,187 @@
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
+#include "amdgpu_mes.h"
+#include "amdgpu_usermode_queue.h"
+#include "soc15_common.h"
+
+#define CHECK_ACCESS(a) (access_ok((const void __user *)a, sizeof(__u64)))
+
+static int
+amdgpu_userqueue_index(struct amdgpu_device *adev)
+{
+    int index;
+    struct amdgpu_userq_globals *uqg = &adev->userq;
+
+    index = ida_simple_get(&uqg->ida, 2, AMDGPU_MAX_USERQ, GFP_KERNEL);
+    return index;
+}
+
+static void
+amdgpu_userqueue_remove_index(struct amdgpu_device *adev, struct amdgpu_usermode_queue *queue)
+{
+    struct amdgpu_userq_globals *uqg = &adev->userq;
+
+    ida_simple_remove(&uqg->ida, queue->queue_id);
+}
+
+static int
+amdgpu_userqueue_validate_input(struct amdgpu_device *adev, struct drm_amdgpu_userq_mqd *mqd_in)
+{
+    if (mqd_in->queue_va == 0 || mqd_in->doorbell_handle == 0 || mqd_in->doorbell_offset == 0) {
+        DRM_ERROR("Invalid queue object address\n");
+        return -EINVAL;
+    }
+
+    if (mqd_in->queue_size == 0 || mqd_in->rptr_va == 0 || mqd_in->wptr_va == 0) {
+        DRM_ERROR("Invalid queue object value\n");
+        return -EINVAL;
+    }
+
+    if (mqd_in->ip_type < AMDGPU_HW_IP_GFX || mqd_in->ip_type >= AMDGPU_HW_IP_NUM) {
+        DRM_ERROR("Invalid HW IP type 0x%x\n", mqd_in->ip_type);
+        return -EINVAL;
+    }
+
+    if (!CHECK_ACCESS(mqd_in->queue_va) || !CHECK_ACCESS(mqd_in->rptr_va) ||
+        !CHECK_ACCESS(mqd_in->wptr_va)) {
+            DRM_ERROR("Invalid mapping of queue ptrs, access error\n");
+            return -EINVAL;
+    }
+
+    DRM_DEBUG_DRIVER("Input parameters to create queue are valid\n");
+    return 0;
+}
+
+int amdgpu_userqueue_create(struct amdgpu_device *adev, struct drm_file *filp,
+                            union drm_amdgpu_userq *args)
+{
+    int r, pasid;
+    struct amdgpu_usermode_queue *queue;
+    struct amdgpu_fpriv *fpriv = filp->driver_priv;
+    struct amdgpu_vm *vm = &fpriv->vm;
+    struct amdgpu_ctx *ctx = amdgpu_ctx_get(fpriv, args->in.ctx_id);
+    struct drm_amdgpu_userq_mqd *mqd_in = &args->in.mqd;
+
+    if (!ctx) {
+        DRM_ERROR("Invalid GPU context\n");
+        return -EINVAL;
+    }
+
+    if (vm->pasid < 0) {
+        DRM_WARN("No PASID info found\n");
+        pasid = 0;
+    }
+
+    mutex_lock(&adev->userq.userq_mutex);
+
+    queue = kzalloc(sizeof(struct amdgpu_usermode_queue), GFP_KERNEL);
+    if (!queue) {
+        DRM_ERROR("Failed to allocate memory for queue\n");
+        mutex_unlock(&adev->userq.userq_mutex);
+        return -ENOMEM;
+    }
+
+    r = amdgpu_userqueue_validate_input(adev, mqd_in);
+    if (r < 0) {
+        DRM_ERROR("Invalid input to create queue\n");
+        goto free_queue;
+    }
+
+    queue->vm = vm;
+    queue->pasid = pasid;
+    queue->wptr_gpu_addr = mqd_in->wptr_va;
+    queue->rptr_gpu_addr = mqd_in->rptr_va;
+    queue->queue_size = mqd_in->queue_size;
+    queue->queue_type = mqd_in->ip_type;
+    queue->paging = false;
+    queue->flags = mqd_in->flags;
+    queue->queue_id = amdgpu_userqueue_index(adev);
+
+    ctx->userq = queue;
+    args->out.q_id = queue->queue_id;
+    args->out.flags = 0;
+    mutex_unlock(&adev->userq.userq_mutex);
+    return 0;
+
+free_queue:
+    amdgpu_userqueue_remove_index(adev, queue);
+    mutex_unlock(&adev->userq.userq_mutex);
+    kfree(queue);
+    return r;
+}
+
+void amdgpu_userqueue_destroy(struct amdgpu_device *adev, struct drm_file *filp,
+                              union drm_amdgpu_userq *args)
+{
+    struct amdgpu_fpriv *fpriv = filp->driver_priv;
+    struct amdgpu_ctx *ctx = amdgpu_ctx_get(fpriv, args->in.ctx_id);
+    struct amdgpu_usermode_queue *queue = ctx->userq;
+
+    mutex_lock(&adev->userq.userq_mutex);
+    amdgpu_userqueue_remove_index(adev, queue);
+    ctx->userq = NULL;
+    mutex_unlock(&adev->userq.userq_mutex);
+    kfree(queue);
+}
+
+int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
+		       struct drm_file *filp)
+{
+    union drm_amdgpu_userq *args = data;
+    struct amdgpu_device *adev = drm_to_adev(dev);
+    int r = 0;
+
+    switch (args->in.op) {
+    case AMDGPU_USERQ_OP_CREATE:
+        r = amdgpu_userqueue_create(adev, filp, args);
+        if (r)
+            DRM_ERROR("Failed to create usermode queue\n");
+        break;
+
+    case AMDGPU_USERQ_OP_FREE:
+        amdgpu_userqueue_destroy(adev, filp, args);
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
+int amdgpu_userqueue_init(struct amdgpu_device *adev)
+{
+    struct amdgpu_userq_globals *uqg = &adev->userq;
+
+    mutex_init(&uqg->userq_mutex);
+    return 0;
+}
+
+void amdgpu_userqueue_fini(struct amdgpu_device *adev)
+{
+
+}
diff --git a/drivers/gpu/drm/amd/include/amdgpu_usermode_queue.h b/drivers/gpu/drm/amd/include/amdgpu_usermode_queue.h
new file mode 100644
index 000000000000..c1fe39ffaf72
--- /dev/null
+++ b/drivers/gpu/drm/amd/include/amdgpu_usermode_queue.h
@@ -0,0 +1,50 @@
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
+#ifndef AMDGPU_USERMODE_QUEUE_H_
+#define AMDGPU_USERMODE_QUEUE_H_
+
+#define AMDGPU_MAX_USERQ 512
+
+struct amdgpu_usermode_queue {
+	int		queue_id;
+	int		queue_type;
+	int		queue_size;
+	int		paging;
+	int		pasid;
+	int		use_doorbell;
+	int		doorbell_index;
+
+	uint64_t	mqd_gpu_addr;
+	uint64_t	wptr_gpu_addr;
+	uint64_t	rptr_gpu_addr;
+	uint64_t	queue_gpu_addr;
+	uint64_t	flags;
+	void 		*mqd_cpu_ptr;
+
+	struct amdgpu_bo	*mqd_obj;
+	struct amdgpu_vm    	*vm;
+	struct list_head 	list;
+};
+
+#endif
-- 
2.34.1

