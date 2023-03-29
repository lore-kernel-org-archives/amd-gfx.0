Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08127C761AF
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Mar 2023 16:05:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E2FA10EB7C;
	Wed, 29 Mar 2023 16:05:15 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BE9310EB6C
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 16:05:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gRYc9V4ml0lJGSc9PFm8zmQ7hqF8WuHHjqKIN811GSsMMB7OFKIgmVcxEkOIQV0HL3M5wvcXv2BVdlqAPjGyaFkozALd972JPStLhhFqUBJ09vf9BNqGln9ZusNuec6oD/GPzlTLvRHqTfVAaIh/tpfq2Di3FF6f/2RFTzPI6AG6QtFuuPEyBeMnilwZTFfVAY7Vb0ifOqNLzN67lOLkE/I+RaYIgtbiF6UDo3VutiBk8QZUyaEsqLukA9nRvQrJS1jBC9So8t2ty2uaSppN/kmcl9MerCXjelSzlqoManEhywZukP3Uke7DZSdlcqWzthtx25iyTGlvtH+petz3SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZAIH9kCzseAW2j8zJlTHZ4MgJVT7fNhgDJoy1ly4U2g=;
 b=DA1ea7ovrCHirKt4qogT/qZ3LRlepKDlTao2kXOeK+9qIwFAqTGCj64T4OD2ejJe3zcThVUA8UHDD7zdUHRVZ0lcR/f66PDg/3/qUpYPFnU9mSA7IO8pE4gIyAGhDHpPSpjFnzcZIVvncqWGG3qaGpIV5mxfpbAFy1hBBGJ3LHHQWi9W+BvgNY/n2xpWdtqs6p4JlPaW8bvmWJLJjToBIY83nkGgZot4gnJpMmhOvXTmcfS6YSecxpiVPcF1IYiL4f8tl05BNvVy9mYcG27Gkp4CvSoPTxEkUB+xY/dF/hDzCTNxL0TSe/R4n0RrV/oqO6iDYv3v7XmrgzhfwhF+Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZAIH9kCzseAW2j8zJlTHZ4MgJVT7fNhgDJoy1ly4U2g=;
 b=OaLlrvmmqCYAQ3ifXFHl7qditmV3k/3Jrc+hoVIUh0Jkp8eYYCH0o28eXx80f67GqYPpqDrK268jNnfYJ3BbhBdkYPC6dT4l54ddK0xNSh55JkHp1BisCqqRqS/Lme8BKonyfbBa9zSGxnFmrJQsiCSRxt6DLBtn6/rY5t6H1Yg=
Received: from MW4P222CA0007.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::12)
 by SJ0PR12MB5675.namprd12.prod.outlook.com (2603:10b6:a03:42d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Wed, 29 Mar
 2023 16:05:12 +0000
Received: from CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:114:cafe::53) by MW4P222CA0007.outlook.office365.com
 (2603:10b6:303:114::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.43 via Frontend
 Transport; Wed, 29 Mar 2023 16:05:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT042.mail.protection.outlook.com (10.13.174.250) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.22 via Frontend Transport; Wed, 29 Mar 2023 16:05:11 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 Mar
 2023 11:05:09 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 3/9] drm/amdgpu: add new IOCTL for usermode queue
Date: Wed, 29 Mar 2023 18:04:39 +0200
Message-ID: <20230329160445.1300-4-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20230329160445.1300-1-shashank.sharma@amd.com>
References: <20230329160445.1300-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT042:EE_|SJ0PR12MB5675:EE_
X-MS-Office365-Filtering-Correlation-Id: b45c2e0a-55df-4fff-65b2-08db306f601e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SRK0FAqUzXfLuAnUy9NkfiXmgftSjjz8Lbmgps861RTIerae/R/ppUssRNSxhT4Ql6YfUEnPz2LgVmhfWmec3uFRp5rc6Sx3qxHe9yY5A0AiZ11by/9RxSlxbomvuEy7MaVeP1O39CKo8jlgOLLfcixhE3Xv6fVHnByAdsHsxGsf7nqnRzLHJIRKGbzl5GQoxWWJhHdth488SkzHy5zhHg4j+B2sYu8LHrmUcmOndIVLBrERFh3LseTAH/lUKP4ovoglSFinKYuQsNYRbO5xkkg/gD6AiaQ4THjjdSVsBWElHblq4EPC49HNwVMJy7WLDFUh8UEWx8ub/YdVzbUMTo4PqmzOqMCkqekGOuA9/BHpdbKAIXxT4rY5ZBbjmkHoPk+2lHVlIrgQIovM9n2rp3nmBS9lQ/D/Qq2wFW/BYBVCG7d5rmoG+4CFWVZDwkgIuE7Jx6UpvgOh8/XFwIaorP0WrTwP7BH+LvhwPrRo4RtXQ5UjJum51tkgrsHnGBq/Ih+3DN2HiLvj+U2ZPM780IdJzhXOxOr0JOme309RSiq8X0l/5Ubul9qBTug9zvoOF8MiUXDu5X6WaDHucOnuiJQcv0LSE3V/JmyV3H+IyjLwtAwG6Z+DZ1hsRsYb6J8gpc3+inGDNwXfe9OXHZEZlcatHQ9i8Dg4PmrRxyxyJMoqZn8jrVRTjGs9Io4q0V0pYUFjcQgyY6djmpwN+IAepeU7563WEV9NeevbIOaF9Is=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(136003)(346002)(376002)(451199021)(36840700001)(40470700004)(46966006)(7696005)(70586007)(6666004)(26005)(1076003)(6916009)(316002)(54906003)(478600001)(16526019)(36860700001)(47076005)(336012)(8676002)(70206006)(426003)(186003)(83380400001)(2616005)(81166007)(41300700001)(356005)(8936002)(2906002)(4326008)(5660300002)(44832011)(40460700003)(82740400003)(40480700001)(86362001)(82310400005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 16:05:11.3446 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b45c2e0a-55df-4fff-65b2-08db306f601e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5675
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
 Felix Kuehling <felix.kuehling@amd.com>,
 Shashank Sharma <contactshashanksharma@gmail.com>,
 Christian Koenig <christian.koenig@amd.com>
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

V3:
 - Integration with doorbell manager

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Signed-off-by: Shashank Sharma <contactshashanksharma@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 113 ++++++++++++++++++
 .../gpu/drm/amd/include/amdgpu_userqueue.h    |   2 +
 3 files changed, 116 insertions(+)

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
index 13e1eebc1cb6..353f57c5a772 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -22,6 +22,119 @@
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
2.40.0

