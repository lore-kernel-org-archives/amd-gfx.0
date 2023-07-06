Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B27FEB64DD
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jul 2023 12:36:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE23310E073;
	Thu,  6 Jul 2023 12:36:35 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C4E810E073
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jul 2023 12:36:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i2yXT05Lt6Wt5givmwE9CT+eKDM835O2ZZxZntyx6G81jApdZ+OgTCW0fZi4AIHYOztqEPMNwQVrOBKGnLxFh64LwBuhe2Ve/vZGqUwFF2YhSSj1wjNzFVNn2AefAh1ePdNnP8YtKgsfg4OeviaLq0TLkc7EbN143Dy5hJabnlxSQC78qGwZNn36J05auUgE+mNRl16pXW5pHhVjAmQuIfOiU+pY6UN6kFCTEFMbvKdsrB4Ttqh3Es/3ZuJCYCmedDkSNxgAANBz785ba24DJCDpaDW0rsUhGNonC70j5LiTeHEpVSHmd4Xbbi/3Lx/iICLK3TwmWNY282wdBT8fRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=37SCgIG9baqqngFBSoh2+aQ8j4/rlCWWSYhHjqOzfZ4=;
 b=Shts2OcCwsg98L5z1IsnH9u6DVUQTOwqY3koTEYdwwvpJgoxA+m7QY4MOAUjd+fAiItvuqEUNM3E2o489DSRvVRYyt1XEfJG6YyiqoPWoraj49p9TLVu2oESzXCTk7XXeIEDOhw18NNYjcm6OhUCbvSq5nEH9mneVLyueZ/afCEKiM+yyLu2+tLKEqmjsFdFaY7sJ7ElKnZEgAJ105LyZzJXcXMZh+IgxvXtgsb4FfL5PJSjOUjB39J6M9AstNpMF7ff7rzQbnG4U1iXMU+dSTFSQTTtCPTP6NVteKdyg1bdxKfhyu55db4bnsN0S6k9us9eJitbX/693YLjtYFYgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=37SCgIG9baqqngFBSoh2+aQ8j4/rlCWWSYhHjqOzfZ4=;
 b=1nneMlJnBrQd6/GVgeUXW4mdTOM9n5GarUU9MJtZOvlmX/lcyJFsTlnYWofOz6aMh089L7rb6J1bgcxtyVea9T5aFH1tpIKAwKHK8FCociUZQC/vd4+ihKZww0Y2KQBE2aGCE0u1kD1qbUq1SbLOmTWBEUIKcts3InKJbkB7/7Q=
Received: from DM6PR12CA0015.namprd12.prod.outlook.com (2603:10b6:5:1c0::28)
 by PH8PR12MB7253.namprd12.prod.outlook.com (2603:10b6:510:226::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 12:36:31 +0000
Received: from DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1c0:cafe::57) by DM6PR12CA0015.outlook.office365.com
 (2603:10b6:5:1c0::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.24 via Frontend
 Transport; Thu, 6 Jul 2023 12:36:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT012.mail.protection.outlook.com (10.13.173.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.45 via Frontend Transport; Thu, 6 Jul 2023 12:36:31 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 6 Jul
 2023 07:36:30 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v5 03/10] drm/amdgpu: add new IOCTL for usermode queue
Date: Thu, 6 Jul 2023 14:35:55 +0200
Message-ID: <20230706123602.2331-4-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20230706123602.2331-1-shashank.sharma@amd.com>
References: <20230706123602.2331-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT012:EE_|PH8PR12MB7253:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c6be561-13fa-4f63-18a9-08db7e1da09b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XJ5C8bKXtCidmK8G0/A9cBBYaSR+9Y2W/fyppNsxdVyamVB7C4OSm8UhffGv2WN0HgM//Gs7RD2BFnmOzsEy0MJPna+osXxZe1I1gAO6BBhcRVdaOQ94UBk6/OgD0W04Kpvm6vsnmODLUjcxrJ44pqGjifQkjQHdjLYE4snx5rXb0XIH1fRKffx/0sPFOBWLtmkEdwc6XfM7/SwPtMU0+v7WgRGL/sjU4EvTPWBrAt3rYTwSFwoGJEAmoEkuHZm4Tj98ENJpq7eOIzddbOCObBgsgc1ZybEMbhwiscNUtuNgR/MmuJqVjGPnoycYaveYoD8NMs7Hq3o+qDx82PplF5gW9otmwA2DYY5li3gtIlJvrlz7gXJzLt5YVB1NNZFjC5NgIY0yS2YdfRZ61SDO6MbbvzxXfU2NhM0+XGhUqtqWx/duKNfB+FJQKVb3OoryZSS8ColIMIIK9ftgVAQ70XtmNLMf8ga9uzc5BRLZ+1oIUtvKA1PssqvtMUGO32Ziozaa5m509Jz8UZB+ldhDSH6q4FqVjAKe5YTQaA/a/LAsy4ZxzcDmS5xWQMX0vm2j1yGcIlDjNPILeGb1imPQtAWnQgiwjYbegR/DUMfuT9EzEE30mjYaSYp6cg2a0kvIoqim+70siK5BbY+9fxUnum0xO6t100lYwo7II1GKlhACZOKMuHmzTzEyUaMrNfgl5wYww+AOMr5625LjOIw3oRrou+MV4VINML3nc7CHPFqxYi6rhnEYI1DEV8wL+wH1nS7+npl3vcQkRvUVQHGFkA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(136003)(346002)(376002)(451199021)(36840700001)(46966006)(40470700004)(7696005)(6666004)(478600001)(54906003)(70586007)(356005)(83380400001)(2616005)(81166007)(426003)(336012)(1076003)(36860700001)(47076005)(86362001)(36756003)(40480700001)(41300700001)(16526019)(2906002)(82310400005)(186003)(70206006)(26005)(8936002)(40460700003)(82740400003)(316002)(6916009)(5660300002)(8676002)(4326008)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 12:36:31.6102 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c6be561-13fa-4f63-18a9-08db7e1da09b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7253
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
 Christian Koenig <christian.koenig@amd.com>, arvind.yadav@amd.com,
 Shashank Sharma <shashank.sharma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

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

V4:
 - Accommodate MQD union related changes in UAPI (Alex)
 - Do not set the queue size twice (Bas)

V5:
- Remove wrapper functions for queue indexing (Christian)
- Do not save the queue id/idr in queue itself (Christian)
- Move the idr allocation in the IP independent generic space
  (Christian)

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 110 ++++++++++++++++++
 .../gpu/drm/amd/include/amdgpu_userqueue.h    |   2 +
 3 files changed, 113 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 4c5e44d41652..43cb37f097af 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2786,6 +2786,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
 	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_VA, amdgpu_gem_va_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_OP, amdgpu_gem_op_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_USERPTR, amdgpu_gem_userptr_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
+	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ, amdgpu_userq_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 };
 
 static const struct drm_driver amdgpu_kms_driver = {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index effc0c7c02cf..e37b5da5a0d0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -23,6 +23,116 @@
  */
 
 #include "amdgpu.h"
+#include "amdgpu_vm.h"
+#include "amdgpu_userqueue.h"
+
+static struct amdgpu_usermode_queue *
+amdgpu_userqueue_find(struct amdgpu_userq_mgr *uq_mgr, int qid)
+{
+	return idr_find(&uq_mgr->userq_idr, qid);
+}
+
+static int
+amdgpu_userqueue_destroy(struct drm_file *filp, int queue_id)
+{
+	struct amdgpu_fpriv *fpriv = filp->driver_priv;
+	struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
+	const struct amdgpu_userq_funcs *uq_funcs;
+	struct amdgpu_usermode_queue *queue;
+
+	mutex_lock(&uq_mgr->userq_mutex);
+
+	queue = amdgpu_userqueue_find(uq_mgr, queue_id);
+	if (!queue) {
+		DRM_DEBUG_DRIVER("Invalid queue id to destroy\n");
+		mutex_unlock(&uq_mgr->userq_mutex);
+		return -EINVAL;
+	}
+	uq_funcs = uq_mgr->userq_funcs[queue->queue_type];
+	uq_funcs->mqd_destroy(uq_mgr, queue);
+	idr_remove(&uq_mgr->userq_idr, queue_id);
+	kfree(queue);
+
+	mutex_unlock(&uq_mgr->userq_mutex);
+	return 0;
+}
+
+static int
+amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
+{
+	struct amdgpu_fpriv *fpriv = filp->driver_priv;
+	struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
+	const struct amdgpu_userq_funcs *uq_funcs;
+	struct amdgpu_usermode_queue *queue;
+	int qid, r = 0;
+
+	mutex_lock(&uq_mgr->userq_mutex);
+
+	uq_funcs = uq_mgr->userq_funcs[args->in.ip_type];
+	if (!uq_funcs) {
+		DRM_ERROR("Usermode queue is not supported for this IP (%u)\n", args->in.ip_type);
+		r = -EINVAL;
+		goto unlock;
+	}
+
+	queue = kzalloc(sizeof(struct amdgpu_usermode_queue), GFP_KERNEL);
+	if (!queue) {
+		DRM_ERROR("Failed to allocate memory for queue\n");
+		r = -ENOMEM;
+		goto unlock;
+	}
+	queue->doorbell_handle = args->in.doorbell_handle;
+	queue->doorbell_index = args->in.doorbell_offset;
+	queue->queue_type = args->in.ip_type;
+	queue->flags = args->in.flags;
+	queue->vm = &fpriv->vm;
+
+	r = uq_funcs->mqd_create(uq_mgr, &args->in, queue);
+	if (r) {
+		DRM_ERROR("Failed to create Queue\n");
+		goto unlock;
+	}
+
+	qid = idr_alloc(&uq_mgr->userq_idr, queue, 1, AMDGPU_MAX_USERQ_COUNT, GFP_KERNEL);
+	if (qid < 0) {
+		DRM_ERROR("Failed to allocate a queue id\n");
+		uq_funcs->mqd_destroy(uq_mgr, queue);
+		r = -ENOMEM;
+		goto unlock;
+	}
+	args->out.queue_id = qid;
+
+unlock:
+	mutex_unlock(&uq_mgr->userq_mutex);
+	return r;
+}
+
+int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
+		       struct drm_file *filp)
+{
+	union drm_amdgpu_userq *args = data;
+	int r = 0;
+
+	switch (args->in.op) {
+	case AMDGPU_USERQ_OP_CREATE:
+		r = amdgpu_userqueue_create(filp->driver_priv, args);
+		if (r)
+			DRM_ERROR("Failed to create usermode queue\n");
+		break;
+
+	case AMDGPU_USERQ_OP_FREE:
+		r = amdgpu_userqueue_destroy(filp, args->in.queue_id);
+		if (r)
+			DRM_ERROR("Failed to destroy usermode queue\n");
+		break;
+
+	default:
+		DRM_ERROR("Invalid user queue op specified: %d\n", args->in.op);
+		return -EINVAL;
+	}
+
+	return r;
+}
 
 int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amdgpu_device *adev)
 {
diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
index 79ffa131a514..55ed6512a565 100644
--- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
+++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
@@ -55,6 +55,8 @@ struct amdgpu_userq_mgr {
 	const struct amdgpu_userq_funcs *userq_funcs[AMDGPU_HW_IP_NUM];
 };
 
+int amdgpu_userq_ioctl(struct drm_device *dev, void *data, struct drm_file *filp);
+
 int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amdgpu_device *adev);
 
 void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr);
-- 
2.40.1

