Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0453C4345F
	for <amd-gfx@archiver.kernel.org>; Thu,  2 May 2024 16:32:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4474710EB6B;
	Thu,  2 May 2024 16:32:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bj0Qh+jr";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2073.outbound.protection.outlook.com [40.107.236.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBF3A10E577
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 May 2024 16:32:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gfG2p/ERQYcFCsasI2xo1nKaGe1npDkshcpBDSXyJDs529zY2mz4LKE52shAcpqqhZpgg6SfL0rPtJXAhZtq7Uh57ZMYI//uzEyVSaUY6TAs9pRl3rMk8C9JQH1n7PkFcigj16uDc0Tivl1amVYGkz2fA7m/gukM6Em1d8aLPqsiLpmN/GIUw0HGWpgVRmynEeul2hcYj9g9PGuqBKI/HmBD3tu+SoPLdW/ar/lJ7TRD6wxLTYNyzoupg8JN4wIs2QWHWGdgthrrOj8Spw3L44UjF9/YDubP+gi2Q23UVY089GxBt+WBYur6grIrIUVx6BB7mwgFkrVNjzEAK62xfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GBEJUmZy2c4IJh55ewMGkI+yNO3Y/oW+T29QwaO7dUE=;
 b=InTA6UOptHVFKLX/DSFPWMKnH3CvpPrXhWWCHnsZcM9pMmm/PCs0J7913EVOvIIGzNbJL+boNfCnGT8qXsYg/bPOcGVco6fwmbweU711u7PC6fEHUi7s0fJeTuJmBw32Lcx/nYCa2CmGXncacv8jYPk0Hg2S9Tag9j+Hhln6FASJCbOh94YRZgR2XY54QXM7Zmp/fpWBd1mSqfkkMQoKPdWkXBLYgVYbQxkbc5Xs3LhJ3naFTSZKjlNMMQ4Jl5lAwreTd8/YfwMLr5pXBByDokqrmkor3b/t4Y1CJrTiXAruclCQIoo3Sei1p63o05HFPJyL5pw/dOmQSSKSnUhpIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GBEJUmZy2c4IJh55ewMGkI+yNO3Y/oW+T29QwaO7dUE=;
 b=bj0Qh+jrhYi2HPVjYLoLBLxxmYRxMpR+ERWpH3CwAEunaCqYQ2Ln6KrHUyyl0z10mIirO00U7TKwhUcjV/B3NGMZ03Vc5WNbgHKyJ9o7N3vuev+6dKneEmUl3ohDddVUENLd21iK0Q8cfweVvbG+ouy8w0fBGvrQT36kPtIaQFw=
Received: from BN8PR15CA0002.namprd15.prod.outlook.com (2603:10b6:408:c0::15)
 by CY8PR12MB8300.namprd12.prod.outlook.com (2603:10b6:930:7d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.30; Thu, 2 May
 2024 16:32:30 +0000
Received: from BN3PEPF0000B06E.namprd21.prod.outlook.com
 (2603:10b6:408:c0:cafe::28) by BN8PR15CA0002.outlook.office365.com
 (2603:10b6:408:c0::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.30 via Frontend
 Transport; Thu, 2 May 2024 16:32:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06E.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.0 via Frontend Transport; Thu, 2 May 2024 16:32:30 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 2 May
 2024 11:32:24 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Arvind Yadav <arvind.yadav@amd.com>, Shashank Sharma
 <shashank.sharma@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Subject: [PATCH v10 03/14] drm/amdgpu: add new IOCTL for usermode queue
Date: Thu, 2 May 2024 18:31:40 +0200
Message-ID: <20240502163152.1382-4-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20240502163152.1382-1-shashank.sharma@amd.com>
References: <20240502163152.1382-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06E:EE_|CY8PR12MB8300:EE_
X-MS-Office365-Filtering-Correlation-Id: e69426bc-0efd-4031-9c8a-08dc6ac57615
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|36860700004|376005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?V+wWzKX+Eauo81K6aVzj24asVG2RB+sJT+rjUvaofnysFfpRxus0bRVzJKuR?=
 =?us-ascii?Q?WvAkGwTXuyfHsu4RMgsBKHw99TTq7UZN8y0R6VUH1qlMZxq6DZW7cbvwU702?=
 =?us-ascii?Q?fnNQVMFVGj1eWm2Bdr1X2vyncsohqBp2acsQO6MNQYcwYiyvpAsP6kU1ubHq?=
 =?us-ascii?Q?8PLf+g/qsi+Ig1KtpnOc2C1x6H/g6EAvst8khqf+tvKMIEc+8cLVQIIjLkZb?=
 =?us-ascii?Q?fE1fYBAWgp8tY5kwoKoMf17NHM/da3v2x9YRS6slkk/TkYhzgS3Cu02cR1vP?=
 =?us-ascii?Q?PsP82FQOvmj76P/mJvyFiGrz0H0Kk1jpBMkxH1RqDRVMBkrfaqQst3ljEHFm?=
 =?us-ascii?Q?QWdvByiLwfYEOypP1oDFSnC5DIleb9t1L2BpG5O/Bp2CX55d5smRgAtV0Xim?=
 =?us-ascii?Q?ki25tzqOgeJTNPApJsSW5tJO8brqjMg8Z50PFTNfdg2R+OyFBQbq1+bkmN3G?=
 =?us-ascii?Q?jUbIQZtqISCCPJ8l8fOs69DdjznGT5dOXVJ/CwFSbINXgrLiaYzjWVw1L+Ku?=
 =?us-ascii?Q?wULBpRDlfcOlW6176V8DdC4Ele/ahvZ8E2ZwOJab9c10lNk0H0ua8tErdVjr?=
 =?us-ascii?Q?m2kMUUeX/jr4SF+kZvyIuo/X2/05rEpXGEpAeIAlLhU8XjXwoppqQQjTUD0o?=
 =?us-ascii?Q?J7ZHNp7ZHXDmsgv09b7TIx5yE4wqp7dGlXh9ZZQhB6yZYrVNooumnIUd1zCM?=
 =?us-ascii?Q?csECZ/m+kGFUoidTaXB7Bh52Fk5yBQdriTYebOa6RAfWuurvkVJNOhXoezrW?=
 =?us-ascii?Q?3ktrE8ZWS+ngAqgfxVy74zyrxHXu7MPTdCD6ndcP7qNvpD8lkQpK9viNEks3?=
 =?us-ascii?Q?38cZ6cGHJ5GJQpjZN4x0pVnGW3IsAOlxvQUBsnuy0TzmmqwOcSQgEwmb6E6o?=
 =?us-ascii?Q?dF+lxGeqM10VYu7X1MTe+9F47GkpzNu5W/cGZg8UG1vd1VTlKR2YD3bLHbPT?=
 =?us-ascii?Q?tg689BhgWTEfaNc6D48+Fp7nkI7w4e0KulNIn4dUrI9tzqy8IfUKcMW+X1RK?=
 =?us-ascii?Q?Lt7BhdmgKtf32x0MtyNPcF1amRs0sLM0KDROMtjvzxD3vzdKPRyWDUz8g2ej?=
 =?us-ascii?Q?ETkr425d72Y5VG6k/hdgU+cKD5ug/Fg/kgGGGCemx6SUHQQ00qy8otkf8/jd?=
 =?us-ascii?Q?K+rY+/6l+EVUdkz3zDI8mTaMRHD0eN8JXOPaiZNtqehXjjAT6w430tMGTXh+?=
 =?us-ascii?Q?UGmVKJZZgvJxAPAr+jeBC+RPDppEi2b/Tg/pkvc2pqLp9y1+IcNJnLpBk1gW?=
 =?us-ascii?Q?CKZIsbDDbHruoAF3JomHSsSChcMnOd4DWJ940f9OJRchpmyzGOpJMHvcWoJt?=
 =?us-ascii?Q?yJNifaWXKnYo/P8NlTVbcM7uk8MJE6aMw2ca3wtWedIEEs21zuOExy3bNBld?=
 =?us-ascii?Q?U5iYrjjJ88oI2X9HLt02sL3oTcUQ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(36860700004)(376005); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 16:32:30.1528 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e69426bc-0efd-4031-9c8a-08dc6ac57615
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8300
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

V10: Addressed review comments from Christian, and added R-B:
 - Do not initialize the local variable
 - Convert DRM_ERROR to DEBUG.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Reviewed-by: Christian Koenig <christian.koenig@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 121 ++++++++++++++++++
 .../gpu/drm/amd/include/amdgpu_userqueue.h    |   2 +
 3 files changed, 124 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index b52442e2d04a..551e13693100 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2929,6 +2929,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
 	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_VA, amdgpu_gem_va_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_OP, amdgpu_gem_op_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_USERPTR, amdgpu_gem_userptr_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
+	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ, amdgpu_userq_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 };
 
 static const struct drm_driver amdgpu_kms_driver = {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index effc0c7c02cf..ce9b25b82e94 100644
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
+	int r;
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
+		DRM_DEBUG_DRIVER("Invalid user queue op specified: %d\n", args->in.op);
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

