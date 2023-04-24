Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E93D5C77B7F
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Apr 2023 17:39:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F05F10E119;
	Mon, 24 Apr 2023 17:39:18 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2642410E5B2
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Apr 2023 17:39:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AsZ1V+BO+uT83FVX4cuQOS3cLRPg4QrzI+dQmlYMe9CnPlDCSC2s65upKWnkkbDlJnFbYJxOv+yugjCUwX85oa9RnIlrxysF8FKuqmVe/mjMjhU7+DKvqYYSP8nC45AHzs7P2plFuvHjr+WK/Qh538QVgqCQJWFLs6PQD7N0RpwOwcylMlfnNbZxYPrpvQlJsYyT+P3z9dahiKs2oVMG6zhFFL738PJ6C+PExE4uCloAPhayOOrm6nUBKYUUNMV3Um+joI9ajVSyzOfG+pS2XnL00+9SZao39jylrQOyswsMX3DC2nk6I2CQRzqOrpKbSoSGTX9TzQYVBxaqVMvEeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tPUuMeWTn6VyGZrhqdhsutu5/Y3yZt3qMpk2QCjOb2I=;
 b=QiGi9LEFZ80GBIF579ifSWWevT80RK2sFamB6hRiI0EMlVcawNvtOhd54AgYuimsbTsGqY8LGKyqfoNPH+G3aU7Mc1kwB/fAAaNrsa3efjn+NSClDQbTrScx8nFBNUEIw8xVF2Z8a22JNsUBjbB44SpdNEWsayoFHgvH38N81T2Wcuhlasstys9vJC+4M7PfQFVKZ26o8E8bVe62nUJ05+vnpnuFohE6iN09jKzpyu6833ZMi19Yq7WwW4AuuhOCc9n4FSraZJkrKzIwrj8GnbFxUW5nVVYDls4NsAWfk7792aSIZCSt2JsvMziWL1bTOU/V3K04N/o65We9ESdaFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tPUuMeWTn6VyGZrhqdhsutu5/Y3yZt3qMpk2QCjOb2I=;
 b=dHWd/V9sJbTaBifejWS906QI1wJlpJczTHEiYEvEztXEY4tl48ffB9XYr9xgLt457qjpbEvuSKrPYQlHJNPhpQ843iAMydVlyVvlVxUYqaIlBE+LML/qIh4KwnQTyYJ0KB8HXvslNArqGXeLbejqsA/RgKwn7dhR2LYSQjJDg40=
Received: from MW4PR04CA0140.namprd04.prod.outlook.com (2603:10b6:303:84::25)
 by SJ2PR12MB8926.namprd12.prod.outlook.com (2603:10b6:a03:53b::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Mon, 24 Apr
 2023 17:39:11 +0000
Received: from CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:84:cafe::55) by MW4PR04CA0140.outlook.office365.com
 (2603:10b6:303:84::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33 via Frontend
 Transport; Mon, 24 Apr 2023 17:39:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT033.mail.protection.outlook.com (10.13.174.247) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.19 via Frontend Transport; Mon, 24 Apr 2023 17:39:10 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 24 Apr
 2023 12:39:07 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v4 03/10] drm/amdgpu: add new IOCTL for usermode queue
Date: Mon, 24 Apr 2023 19:38:28 +0200
Message-ID: <20230424173836.1441-4-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20230424173836.1441-1-shashank.sharma@amd.com>
References: <20230424173836.1441-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT033:EE_|SJ2PR12MB8926:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b14d032-3043-4ccc-4b88-08db44ead03c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yDlzIugEnFxJP8yGDZqIyyxKkb3rVYqWdk+xFnHrErFYXm1gHbw4v8+Mzb8/UvGCL6jdDqa4QQ55wJFFafipBwzCX08p9LpK9DwdfMXjyf5VU8YhWRf0WkWGZ6U6TpZp+Qp0+dIKEWuqii6QlHX9cRi7Bqc7BHUpMty4LksbOWxXAH2dvdz37wSZHTUI95Jibv6M6kBJsy/BTyMv6vgyFg3kdlffsC4U6hVQwC0+cr92L6z38WmjhzxNBL5eRoyQ3A8lLkBZzQ8lzHBGjsQr1cmHEw6Ef1y1SuQq0ybanLPlMj0ZWpOmiqwcpYtUMgwwUSZxHJ1LV7as9kvVatmm0MQc18xDv5Um4qGtJA/stI8/2+rf1iKzD+SLPk5LBXbSXZeQBaTCZYLxfTqAehnX2ttdxK/YCQfGlUTxvonXl9/G+v7oniTeIvlXxRcMCvYmSNJXq2om1qLD9XiSMKRmhsbPySbaUK8bVtHY/xqeBqtJ+CQJoN/ohzNwkwzyGSiFAs8d8a5rctPrNfq8pdo0BJ9WIgA3qPim5QzIVPCDlg+PmspfyG1GOecG/fL4F+oHVRk0ixpse5KT58s42KmEIae+pkBql+E0DpNfPjhWe21pcsl8WACBY9QumkEmfO6aLZccIlsIkj+H5ATW1STKS25UwTZkcToYXtF2ErsLj2AueS1QhW1Et7WjZPPkr4Ipv6/MrgJibqixRpMRTrE4l4JbP68s769Kaw4TbNhAvwU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(39860400002)(346002)(136003)(451199021)(40470700004)(46966006)(36840700001)(2906002)(40460700003)(41300700001)(356005)(5660300002)(81166007)(44832011)(8676002)(8936002)(36756003)(82310400005)(86362001)(40480700001)(7696005)(6666004)(1076003)(26005)(54906003)(478600001)(36860700001)(2616005)(83380400001)(47076005)(336012)(426003)(186003)(16526019)(6916009)(4326008)(82740400003)(316002)(70586007)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2023 17:39:10.8143 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b14d032-3043-4ccc-4b88-08db44ead03c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8926
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
Cc: pierre-eric.pelloux-prayer@amd.com,
 Shashank Sharma <shashank.sharma@amd.com>, arvind.yadav@amd.com,
 Alex Deucher <alexander.deucher@amd.com>, contactshashanksharma@gmail.com,
 Christian Koenig <christian.koenig@amd.com>
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

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 126 ++++++++++++++++++
 .../gpu/drm/amd/include/amdgpu_userqueue.h    |   2 +
 3 files changed, 129 insertions(+)

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
index effc0c7c02cf..333f31efbe7b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -23,6 +23,132 @@
  */
 
 #include "amdgpu.h"
+#include "amdgpu_vm.h"
+#include "amdgpu_userqueue.h"
+
+static inline int
+amdgpu_userqueue_index(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_queue *queue)
+{
+	return idr_alloc(&uq_mgr->userq_idr, queue, 1, AMDGPU_MAX_USERQ, GFP_KERNEL);
+}
+
+static inline void
+amdgpu_userqueue_free_index(struct amdgpu_userq_mgr *uq_mgr, int queue_id)
+{
+	idr_remove(&uq_mgr->userq_idr, queue_id);
+}
+
+static struct amdgpu_usermode_queue *
+amdgpu_userqueue_find(struct amdgpu_userq_mgr *uq_mgr, int qid)
+{
+	return idr_find(&uq_mgr->userq_idr, qid);
+}
+
+static int amdgpu_userqueue_create_gfx(struct drm_file *filp, union drm_amdgpu_userq *args)
+{
+	struct amdgpu_usermode_queue *queue;
+	struct amdgpu_fpriv *fpriv = filp->driver_priv;
+	struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
+	struct drm_amdgpu_userq_mqd_gfx *mqd_in = &args->in.mqd.gfx;
+	int r;
+
+	/* Do we support usermode queues on this GFX IP ? */
+	if (!uq_mgr->userq_funcs[AMDGPU_HW_IP_GFX]) {
+		DRM_ERROR("Usermode queue is not supported for this GFX IP\n");
+		return -EINVAL;
+	}
+
+	queue = kzalloc(sizeof(struct amdgpu_usermode_queue), GFP_KERNEL);
+	if (!queue) {
+		DRM_ERROR("Failed to allocate memory for queue\n");
+		return -ENOMEM;
+	}
+
+	mutex_lock(&uq_mgr->userq_mutex);
+	queue->userq_prop.wptr_gpu_addr = mqd_in->wptr_va;
+	queue->userq_prop.rptr_gpu_addr = mqd_in->rptr_va;
+	queue->userq_prop.queue_size = mqd_in->queue_size;
+	queue->userq_prop.hqd_base_gpu_addr = mqd_in->queue_va;
+
+	queue->doorbell_handle = mqd_in->doorbell_handle;
+	queue->queue_type = AMDGPU_HW_IP_GFX;
+	queue->flags = mqd_in->flags;
+	queue->vm = &fpriv->vm;
+	queue->queue_id = amdgpu_userqueue_index(uq_mgr, queue);
+	if (queue->queue_id < 0) {
+		DRM_ERROR("Failed to allocate a queue id\n");
+		r = queue->queue_id;
+		goto free_queue;
+	}
+
+	args->out.queue_id = queue->queue_id;
+	args->out.flags = 0;
+	mutex_unlock(&uq_mgr->userq_mutex);
+	return 0;
+
+free_queue:
+	mutex_unlock(&uq_mgr->userq_mutex);
+	kfree(queue);
+	return r;
+}
+
+static int amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
+{
+	u32 ip_type = args->in.ip_type;
+
+	switch (ip_type) {
+	case AMDGPU_HW_IP_GFX:
+		return amdgpu_userqueue_create_gfx(filp, args);
+	default:
+		DRM_ERROR("Usermode queue is not supported for this IP (%u)\n", ip_type);
+	}
+
+	return -EINVAL;
+}
+
+static void amdgpu_userqueue_destroy(struct drm_file *filp, int queue_id)
+{
+	struct amdgpu_fpriv *fpriv = filp->driver_priv;
+	struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
+	struct amdgpu_usermode_queue *queue;
+
+	queue = amdgpu_userqueue_find(uq_mgr, queue_id);
+	if (!queue) {
+		DRM_DEBUG_DRIVER("Invalid queue id to destroy\n");
+		return;
+	}
+
+	mutex_lock(&uq_mgr->userq_mutex);
+	amdgpu_userqueue_free_index(uq_mgr, queue->queue_id);
+	mutex_unlock(&uq_mgr->userq_mutex);
+	kfree(queue);
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
+		r = amdgpu_userqueue_create(filp, args);
+		if (r)
+			DRM_ERROR("Failed to create usermode queue\n");
+		break;
+
+	case AMDGPU_USERQ_OP_FREE:
+		amdgpu_userqueue_destroy(filp, args->in.queue_id);
+		break;
+
+	default:
+		DRM_ERROR("Invalid user queue op specified: %d\n", args->in.op);
+		return -EINVAL;
+	}
+
+	return r;
+}
+
 
 int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amdgpu_device *adev)
 {
diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
index 6fe5d8d73f37..8d8f6b3bcda5 100644
--- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
+++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
@@ -43,6 +43,8 @@ struct amdgpu_userq_funcs {
 	void (*mqd_destroy)(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_queue *uq);
 };
 
+int amdgpu_userq_ioctl(struct drm_device *dev, void *data, struct drm_file *filp);
+
 int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amdgpu_device *adev);
 
 void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr);
-- 
2.40.0

