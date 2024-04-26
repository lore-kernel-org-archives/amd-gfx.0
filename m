Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F4EFC19F4F
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Apr 2024 13:48:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06CF411240C;
	Fri, 26 Apr 2024 13:48:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="al6vaIgo";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F04BC112406
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Apr 2024 13:48:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jcfTKIsGtDxVxAgIDyuSDDZJq0EmrqsjiZBF+oH39IV2AJsF2CXMP9F8oPpmo449akTtBEJcjvePzkdlpJL+YsH3WsRGV/L2wmsWv+Az4nYiKrxvZvl9rkmglPh68iz+WNAJXxyiXjdzPsnmIkMMtaLgW457ZmsXTMrlpFDExZSFHrJRNsLXNfZ2sNU4FwnwsUlCUZW3KDVbOnPOMij2jx8lnUcINT0owzeMtNh5fG6eEtkVCHi/UrW50W9y1+F1jsMwWnaYTn2VEx3fw6A0eoMKYXgVlqH0+Jt4jhGHpsFYXucsXerwWI7eMISCzHhz5HVNZ/GKVm236DAqGLdKCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GpY6H325UNse0wmZjokQYxHPH4hx197UwFdYyurkle4=;
 b=Y5+mMz84p0NM0aWKxlURbwshiV2JafmDTzQivXbEuSwPJ0oAmsIT5hpXsTdXqmGqUnDVw/2vyeZvufvVdBpVWNF0jgBEEu5HPLDbXsaa9HR9TiLeCwmK4hl2ISKYhB7eqlRQy4I8Hu1iX/xMB65qdmOdAPlpTwb36/cKiBVIaq9ekyy3tXxLIhXgsNaMgrO58KFtdAe6ltlbUUDhBir/YTr6IcaDG9wdpIfJl0toxJrBPpleIWQgXSLgOE/0RaMKDnHiXFCCy6CjHprO7qi9elivdU7JqTz+BoTJSJSHxoKtP3FteDJoR9PwEuizyY9hGKV1pf2jHb23U0wuxK0/PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GpY6H325UNse0wmZjokQYxHPH4hx197UwFdYyurkle4=;
 b=al6vaIgovqTLMIdVmhaGh8+2P+oPU1Tn92uO0AasxyM6XMWS0zD9zqN1aV6IoMeFtvyFfmDzWqockdBZalYmJXwpB+NehzrmOz73BGg5MqsGG6LOI117y7+naL0dXRFxkLRpTwDmbOfyo03DSOFx5E6LL5XYJyV9W6sArzro8Bw=
Received: from CH2PR20CA0021.namprd20.prod.outlook.com (2603:10b6:610:58::31)
 by SJ2PR12MB8717.namprd12.prod.outlook.com (2603:10b6:a03:53d::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Fri, 26 Apr
 2024 13:48:42 +0000
Received: from CH1PEPF0000AD75.namprd04.prod.outlook.com
 (2603:10b6:610:58:cafe::8) by CH2PR20CA0021.outlook.office365.com
 (2603:10b6:610:58::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.26 via Frontend
 Transport; Fri, 26 Apr 2024 13:48:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD75.mail.protection.outlook.com (10.167.244.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Fri, 26 Apr 2024 13:48:41 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 26 Apr
 2024 08:48:40 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Arvind Yadav <arvind.yadav@amd.com>, Shashank Sharma
 <shashank.sharma@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Subject: [PATCH v9 03/14] drm/amdgpu: add new IOCTL for usermode queue
Date: Fri, 26 Apr 2024 15:47:59 +0200
Message-ID: <20240426134810.1250-4-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20240426134810.1250-1-shashank.sharma@amd.com>
References: <20240426134810.1250-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD75:EE_|SJ2PR12MB8717:EE_
X-MS-Office365-Filtering-Correlation-Id: bc967023-dc06-4e25-806b-08dc65f7956d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?97O0iQVlDEamwBdFnaoYwWX2HkS8FDPNx75Gd2VYZlUketVzc9IEmD+vpVcn?=
 =?us-ascii?Q?niiA+4P2UvzbgYlRzW0W1nsZD4YyPZvzkSzBOboklW+UCTknO6Yj0EVhhdLC?=
 =?us-ascii?Q?TJO62gbHs5UT/QC6mmc7og+SYlSUD++URRqPILYMdzr5K+GVcYg5s2hekch5?=
 =?us-ascii?Q?zcKv4MQGyeGk4pupoWi6ztGMQNlyyPUJo8Dn7g1Fcuh2nAfEVKA05pdTxce+?=
 =?us-ascii?Q?jvwxvg2kQ2jE0VyXNuKPF43rh6pZOfL4SoCCrv32PpUsQ9HTcVY2yeD6PEls?=
 =?us-ascii?Q?T/7u7+ajm0NVlXUgN4G1BtMd+avgh4eKIUSYfFvYtZ87/GOjawWc/PNjPllD?=
 =?us-ascii?Q?W9+xkn9MxjgkTolHbS+I++1R0mInXlapFFWhM/Kile7+F6wuBmwQ/qSSa93d?=
 =?us-ascii?Q?JpZZMefslMGKAm0R/eHgLvsdmeMRCBUKqKcJK6nXNxz47u9KJ4ty2BzQ2wa3?=
 =?us-ascii?Q?n5UWGvSlycHven5s/hUzMz2vW1CwuYSb38DdelLTGbaOkwkm0mddw61jQY+4?=
 =?us-ascii?Q?MddLhocMvKRjCxppdTpY4NzTuhBdg3IY65326bylOMngLLcKBQsk6nbonbAy?=
 =?us-ascii?Q?YN2eN5lFrqWBEre5vYN9UGFs21aairA1FSizrpajScZ2SOdLWI6Wm+MP6A6A?=
 =?us-ascii?Q?dZD7ShviS132dlUvH/hhzxTjC1YgdLQI9dqTPt6/yecbjmAt1djpRb4J96jR?=
 =?us-ascii?Q?8X0lorJ+XX8ilU7SJkTQ6jduzm9cX+jvAqt17DEhMXiVlGxLqv1IPjPCGF2i?=
 =?us-ascii?Q?TmHEBgwf4lwCmbVmIFFXiSXbqpgIbsjDZ1Yxs8JvWOWszAesMR+Y7rAzelcy?=
 =?us-ascii?Q?Xq12VX1z5Nw2ICkKLPn6PGFMF/pZW6XCYN5R5qPuJFeEBK4frc+ElJNDR9Ft?=
 =?us-ascii?Q?I/A5R8OAH4sbfNWb8UNgRMRvoVMhiIfGKxr9l7xF5mXiJkpjEdVGEeDlVdXA?=
 =?us-ascii?Q?eOIjLsiHru3tGsvtOyYz42W+fzgFn5r4hw7rF0u90k2VwhZPMY1MzbUoeMEx?=
 =?us-ascii?Q?sfhQX1LsB6sh29il74XeyR0BZ3N9Os6SNPW4Kkh0Rn6E8Lsoqy/u5LB7TQBm?=
 =?us-ascii?Q?TQJi3gvVYdxRPQ0aJLBTmbbSCVnGvxkbBmNcfsrBjNoMiMZwSgRw+K6BfQ24?=
 =?us-ascii?Q?IxMUZEhnVPOsfRBcGefRHX9oJ+efdN+MmijnYF1CUQLcTnFJTo4zl00epyoU?=
 =?us-ascii?Q?S5J9T2K+gPWy8nieFIJDQD0iPiA0FMNTYmP4iI378GoRDqmHXjsYNM8eHBCd?=
 =?us-ascii?Q?B74prCadJR2YBc5z3lgHT2+u6p4gjkv0lA8UHkczEg6XxHs0EaYK32LsdOXu?=
 =?us-ascii?Q?mX5WqmHd6A/W+dEeNma86GR1k1CKH8CMUwEbcHXoCCpOO8jWihRMLT2XV3Y+?=
 =?us-ascii?Q?v4beFv1EAjIj9w8bkhlw7kNDN6jd?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(1800799015)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 13:48:41.6358 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc967023-dc06-4e25-806b-08dc65f7956d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD75.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8717
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

V6:
 - Check the validity of input IP type (Christian)

V7:
 - Move uq_func from uq_mgr to adev (Alex)
 - Add missing free(queue) for error cases (Yifan)

V9:
 - Rebase

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 121 ++++++++++++++++++
 .../gpu/drm/amd/include/amdgpu_userqueue.h    |   2 +
 3 files changed, 124 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 374970984a61..acee1c279abb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2916,6 +2916,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
 	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_VA, amdgpu_gem_va_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_OP, amdgpu_gem_op_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_USERPTR, amdgpu_gem_userptr_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
+	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ, amdgpu_userq_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 };
 
 static const struct drm_driver amdgpu_kms_driver = {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index effc0c7c02cf..df97b856f891 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -23,6 +23,127 @@
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
+	struct amdgpu_device *adev = uq_mgr->adev;
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
+
+	uq_funcs = adev->userq_funcs[queue->queue_type];
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
+	struct amdgpu_device *adev = uq_mgr->adev;
+	const struct amdgpu_userq_funcs *uq_funcs;
+	struct amdgpu_usermode_queue *queue;
+	int qid, r = 0;
+
+	/* Usermode queues are only supported for GFX/SDMA engines as of now */
+	if (args->in.ip_type != AMDGPU_HW_IP_GFX) {
+		DRM_ERROR("Usermode queue doesn't support IP type %u\n", args->in.ip_type);
+		return -EINVAL;
+	}
+
+	mutex_lock(&uq_mgr->userq_mutex);
+
+	uq_funcs = adev->userq_funcs[args->in.ip_type];
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
+		kfree(queue);
+		goto unlock;
+	}
+
+	qid = idr_alloc(&uq_mgr->userq_idr, queue, 1, AMDGPU_MAX_USERQ_COUNT, GFP_KERNEL);
+	if (qid < 0) {
+		DRM_ERROR("Failed to allocate a queue id\n");
+		uq_funcs->mqd_destroy(uq_mgr, queue);
+		kfree(queue);
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
+		r = amdgpu_userqueue_create(filp, args);
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
index 93ebe4b61682..b739274c72e1 100644
--- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
+++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
@@ -54,6 +54,8 @@ struct amdgpu_userq_mgr {
 	struct amdgpu_device		*adev;
 };
 
+int amdgpu_userq_ioctl(struct drm_device *dev, void *data, struct drm_file *filp);
+
 int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amdgpu_device *adev);
 
 void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr);
-- 
2.43.2

