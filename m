Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36884C636D7
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Feb 2023 18:44:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A910310EB7B;
	Wed, 15 Feb 2023 18:44:38 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2061c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::61c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 719B110EB7B
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Feb 2023 18:44:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hhYB8IbDJfiFBkTOYvCtGAZFf3fq8i8goIHnro2nJqMDGwSW9AE1lQ6RzFoy3mpqGjpsjCwehsFw60ab9FRF8KJbbzyh3elhtHP89FUpWinwm2aOb9RXNgERmjA/E4zIs/F9X0GdhCSwxX4UZJwiZN4KapKJOCNH6RhUMYLRQM4KheVP82yMC1cSKBuwPuVmnaoKcU2fRpKEqGxqdKCiX6TwRTAoUL9pWBvNIevYcVk+h8rSByX9iGx69zX24hD66Uu9mnrDjvnbaoEIDUoRl/HVVLeQt1Lz/zXMkCg5DlOB9h1Hlcfi1lhdl+CO9UhaA47zC7ZLAZA9rUjtCef3/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VQvbLD6+ucbYNOqfXwoeJxsWHtdYKQ38y43oHXxkBQc=;
 b=HDrWidMlkrS8m/JTJmJAQ5V7urKhRDwgpY/75OHl5m3jnT77bPV7qDTz8/ubnaeohg0VJ1sjrFofKXPe+Rl0nEDpx15quaIMOgJInHdgGkHOAav72xdDvYHt+2hS6M52t8m81m5RAXQoivH26YvT9T8NBRu14eipTsDuwmLOAux6Foww8icruP+aOu1QG1qv539vX6iLR6dn1YQv1YQlN7SgNsTiLU7coIfHfdSgszikWKIBLiD8mKb8pXOvy6xyTadbP+temcm0RyCQ8gE7hD4c6GgiJ06aDgebl0Qvpl34P6mCq/OhPvOWdblTIgdUlR+TznXVoOw0fE2MINUrsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VQvbLD6+ucbYNOqfXwoeJxsWHtdYKQ38y43oHXxkBQc=;
 b=Uz59c8oHFsO4EarxqWhkZXnkknRM8vq5snmkuhSPfnX5/df68ImOAwKWsSo0/n23SbJEpxRhM6T42gTZUR859gSq+O4r0ykKXkmUemwehbPxbtcMwdNY9VhTiUihzh2mup2Q4JSB86JmMLrUTvmIjo8+Jbwp4cXn86S4xOVjEQw=
Received: from DM6PR13CA0059.namprd13.prod.outlook.com (2603:10b6:5:134::36)
 by DM4PR12MB5247.namprd12.prod.outlook.com (2603:10b6:5:39b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Wed, 15 Feb
 2023 18:44:33 +0000
Received: from DM6NAM11FT108.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:134:cafe::4) by DM6PR13CA0059.outlook.office365.com
 (2603:10b6:5:134::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.12 via Frontend
 Transport; Wed, 15 Feb 2023 18:44:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT108.mail.protection.outlook.com (10.13.172.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6111.12 via Frontend Transport; Wed, 15 Feb 2023 18:44:33 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 15 Feb
 2023 12:44:31 -0600
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 3/9] drm/amdgpu: add new IOCTL for usermode queue
Date: Wed, 15 Feb 2023 19:43:51 +0100
Message-ID: <20230215184356.2205-4-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20230215184356.2205-1-shashank.sharma@amd.com>
References: <20230215184356.2205-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT108:EE_|DM4PR12MB5247:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b74f8e2-c2b7-4014-3532-08db0f84ae1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pc9AZ294gbuHzc2kjKFCCQm0ClIRmdMNfRZj85t6wheqJyswY5yttaTMrhZncXWkMM9hsAEaYridTTFMbKSjd/MIYfYyf2YtfODI2CcMs2eXCkolhUu8/+eguqMWcwvrPXdAeKesIfE5UKxLxtaIsqrNwsdX0LVV9w1Jy1jdeXUJQQru3AhBxM/KE7zM6hsO93g961jxfKVQC8/HQqhWjQqN5C0lVLOq5c6xq+y77r6oF+5BnX4hLwQ7+5T0kJdspK3RTH/nB3GlN7ksVxPOef3DKVhmqXKavE3Kbd+vaJBYBp8s165PXEOTvZcAcQ+fo3/kCy4nN9VCcw4C4tCu//pN61ahTR0H0YdPaRw1o1Hcx+hkAtFqHhJ6ukAmF0Cse8kvOz6nNIrpm9Ldi/cZ6FXlwIF2AAijzhjvGyoEkXvENeSSAYNyOj8vbSUqd5NXBGBJxoxaVTaszPwaftSh8yAOI5Hnycjgx6tZMLhSHNxVLdLLsnCHsUPHXR0iwn2kk2VITVayVCuh3NjvWgv6cfhfmGKPLR0+1hGEKaBHVt8GdRFdRPeJU/4b2b/syJ0CV9iQwNVlmXOpbBTDGY7R5B40EEgkj8r0Is/2ZXB2ZMHfcTsz/lZfbejWxoJFLHDvZW9sSgDVJS4DSebGv29Y3vq3IxmMEX/SW6tp6eJ0JzcE6UVrR6SyPP3aAQgaJmjV3qOX0uRmAqb+w02IBA4dR9oWqdeYApRhRQ+HrunPtHc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(136003)(396003)(39860400002)(376002)(451199018)(46966006)(36840700001)(40470700004)(2616005)(336012)(426003)(47076005)(83380400001)(7696005)(186003)(26005)(478600001)(16526019)(6666004)(1076003)(36756003)(86362001)(356005)(81166007)(36860700001)(82740400003)(82310400005)(40480700001)(40460700003)(8936002)(44832011)(5660300002)(316002)(54906003)(6916009)(4326008)(70586007)(8676002)(41300700001)(70206006)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2023 18:44:33.3459 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b74f8e2-c2b7-4014-3532-08db0f84ae1c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT108.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5247
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
 Shashank Sharma <contactshashanksharma@gmail.com>,
 Christian Koenig <christian.koenig@amd.com>, Arvind.Yadav@amd.com,
 shashank.sharma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Shashank Sharma <contactshashanksharma@gmail.com>

This patch adds:
- A new IOCTL function to create and destroy
- A new structure to keep all the user queue data in one place.
- A function to generate unique index for the queue.

V1: Worked on review comments from RFC patch series:
  - Alex: Keep a list of queues, instead of single queue per process.
  - Christian: Use the queue manager instead of global ptrs,
           Don't keep the queue structure in amdgpu_ctx

V2: Worked on review comments:
 - Christian:
   - Formatting of text
   - There is no need for queuing of userqueues, with idr in place
 - Alex:
   - Remove use_doorbell, its unnecessary
   - Reuse amdgpu_mqd_props for saving mqd fields

 - Code formatting and re-arrangement

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Signed-off-by: Shashank Sharma <contactshashanksharma@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 114 ++++++++++++++++++
 .../gpu/drm/amd/include/amdgpu_userqueue.h    |   2 +
 3 files changed, 117 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 2d6bcfd727c8..229976a2d0e7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2749,6 +2749,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
 	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_VA, amdgpu_gem_va_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_OP, amdgpu_gem_op_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_USERPTR, amdgpu_gem_userptr_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
+	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ, amdgpu_userq_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 };
 
 static const struct drm_driver amdgpu_kms_driver = {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index 13e1eebc1cb6..ecf31d86f3de 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -22,6 +22,120 @@
  */
 
 #include "amdgpu.h"
+#include "amdgpu_vm.h"
+#include "amdgpu_userqueue.h"
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
+static struct amdgpu_usermode_queue *
+amdgpu_userqueue_find(struct amdgpu_userq_mgr *uq_mgr, int qid)
+{
+    return idr_find(&uq_mgr->userq_idr, qid);
+}
+
+static int amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
+{
+    struct amdgpu_usermode_queue *queue;
+    struct amdgpu_fpriv *fpriv = filp->driver_priv;
+    struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
+    struct drm_amdgpu_userq_mqd *mqd_in = &args->in.mqd;
+    int r;
+
+    /* Do we have support userqueues for this IP ? */
+    if (!uq_mgr->userq_funcs[mqd_in->ip_type]) {
+        DRM_ERROR("GFX User queues not supported for this IP: %d\n", mqd_in->ip_type);
+        return -EINVAL;
+    }
+
+    queue = kzalloc(sizeof(struct amdgpu_usermode_queue), GFP_KERNEL);
+    if (!queue) {
+        DRM_ERROR("Failed to allocate memory for queue\n");
+        return -ENOMEM;
+    }
+
+    mutex_lock(&uq_mgr->userq_mutex);
+    queue->userq_prop.wptr_gpu_addr = mqd_in->wptr_va;
+    queue->userq_prop.rptr_gpu_addr = mqd_in->rptr_va;
+    queue->userq_prop.queue_size = mqd_in->queue_size;
+    queue->userq_prop.hqd_base_gpu_addr = mqd_in->queue_va;
+    queue->userq_prop.queue_size = mqd_in->queue_size;
+
+    queue->doorbell_handle = mqd_in->doorbell_handle;
+    queue->queue_type = mqd_in->ip_type;
+    queue->flags = mqd_in->flags;
+    queue->vm = &fpriv->vm;
+    queue->shadow_ctx_gpu_addr = mqd_in->shadow_va;
+    queue->queue_id = amdgpu_userqueue_index(uq_mgr, queue);
+    if (queue->queue_id < 0) {
+        DRM_ERROR("Failed to allocate a queue id\n");
+        r = queue->queue_id;
+        goto free_queue;
+    }
+
+    args->out.queue_id = queue->queue_id;
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
 
 int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amdgpu_device *adev)
 {
diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
index 7eeb8c9e6575..7625a862b1fc 100644
--- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
+++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
@@ -42,6 +42,8 @@ struct amdgpu_userq_funcs {
 	void (*mqd_destroy)(struct amdgpu_userq_mgr *, struct amdgpu_usermode_queue *);
 };
 
+int amdgpu_userq_ioctl(struct drm_device *dev, void *data, struct drm_file *filp);
+
 int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amdgpu_device *adev);
 
 void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr);
-- 
2.34.1

