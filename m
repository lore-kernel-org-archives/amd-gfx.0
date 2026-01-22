Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2350C44536
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jan 2026 08:58:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7538310E958;
	Thu, 22 Jan 2026 08:58:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EG3T8P85";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012041.outbound.protection.outlook.com
 [40.107.200.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E457910E957
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Jan 2026 08:58:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eMInxkni2ED69cAaYyVSASEsjDaB4sj6Hiw2IusPb5RhawQIYkNAu82d49oZ1F+8w1FuKAZCCr1uA4WecCzGMVz/QaRXcgLr15Xl+NKZrcfpGUqFPHH9CJBLqUN3FgV3f6Xrw1DedXycxPkXWCaTgQ+xcz4OYOQQScgO8Dydn2ZvD8pXGor+9YDbGe4Y4CKYPkzEi0MBn1Uv3d8DjhhzD7Fph5lajKs9rVaVPYEA23qRjpmOl64FPQ3VLPrBtJD9l4/W9nvEFu2ivu6REbzCtCE7KFX1EKi31/q+V20Bu2P6enFrTr8hW41UouwXW69IEImcnp5CZqJNK9zw/OAdDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tGNU6r8mpnaU7L/IwPal7Ee60SYZy00PCTgE+wZCP8U=;
 b=VQ0dWrQDU+JHGAWcQijk+y2WBtCxLmCpVRBfwLvzGABeP+5tbtOoCdyW6m7za7NTOhYmXxyqnmwIpvFFoL2UTimzPNhuAY/EkgwmtuUlr0El/koq2tLHgD+fK9pAsr5+KG5QPhstckxhDvsuL2czRQM69NW6PtCbVzllIpCpeN0Npx1eLxnxtK20UBtRbs0w/unqLuiv+pMfteeSIvX89QoPU1/YFc0ORdHrROMD5TB7RNIGNUMALUWdON0iw+Bp1M8FywEb2Y6E9TYYz+dBsJo58e94ugTYjMcCsjmCoxBk/3/gUemqynW4TQyl4nITiQNHOOEhgS0fBHCkDbayyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tGNU6r8mpnaU7L/IwPal7Ee60SYZy00PCTgE+wZCP8U=;
 b=EG3T8P85j86xQR/l5wkvCtHDpqvoEk9HpupV1fHGOqqHaFRKaABzGT8u7PLNShEbkmvHWx1gDQNsdXagHcLrpMoyiiJ10bjP47uMunXas1TmWOj6If/XLY4Kjjg0koZz/jsWd+8i2bLwd36FU5KQhoTaDXoK/yPOhcHt6qikuzs=
Received: from BY5PR16CA0019.namprd16.prod.outlook.com (2603:10b6:a03:1a0::32)
 by CY1PR12MB9625.namprd12.prod.outlook.com (2603:10b6:930:106::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.9; Thu, 22 Jan
 2026 08:58:45 +0000
Received: from CO1PEPF000075F2.namprd03.prod.outlook.com
 (2603:10b6:a03:1a0:cafe::a2) by BY5PR16CA0019.outlook.office365.com
 (2603:10b6:a03:1a0::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.10 via Frontend Transport; Thu,
 22 Jan 2026 08:58:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF000075F2.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Thu, 22 Jan 2026 08:58:45 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 22 Jan
 2026 02:58:44 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Thu, 22 Jan 2026 02:58:38 -0600
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH 9/9] drm/amdgpu: Add queue update IOCTL support
Date: Thu, 22 Jan 2026 16:57:19 +0800
Message-ID: <20260122085738.1542800-9-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260122085738.1542800-1-Jesse.Zhang@amd.com>
References: <20260122085738.1542800-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F2:EE_|CY1PR12MB9625:EE_
X-MS-Office365-Filtering-Correlation-Id: 787a27bd-04ce-4f80-d96a-08de599472e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EyEVnzUp7cIxjGwhwgthHFCzCmjUrSXne1Nj/0D6Z87NhldXMAlAaxE+ZW4W?=
 =?us-ascii?Q?8zMdWD0tUKxNAlT5EZKDahaHRxC2fwqapSYWbcWYHWHc4hbZWSed447Prppk?=
 =?us-ascii?Q?o8ExmUJdSSzMqvrc8LCtaWiuq1ZBekmd8bh8KgG2tETuEj0tTPRnc/n4Zo35?=
 =?us-ascii?Q?kjYKRtzGoRF2MlcyYMNqyWtJ1XmP54DKywTkxTvUqzK4l8ATD3DPY2FDAXru?=
 =?us-ascii?Q?SN79thQiVSc8HjTYoMDCpE2iZovU70jlTSIMKb3kQGpZD0lTqaOJpPwxU1XZ?=
 =?us-ascii?Q?5/7xIQMrNdbfokUyQn7STKPhxp2af7c26q28+OSabKJ2gri9F2C3cRaVkXRt?=
 =?us-ascii?Q?edX19W5UftKvFb1qzUmN3FqwKAkHtKtz1YtLbC+wHu9O04YXIv1ceRCHUbJ8?=
 =?us-ascii?Q?dB84s6MrwRT3myWn1BiR+P9m8IaJV5awvxUS2LsK33AH5xFfrPP8DJRVtdwQ?=
 =?us-ascii?Q?Npf7RrSa5HhEVQdMTSoWNqrVO5SOMFS1JZZVSFSbEBo8YXivvT0ue4WA2lPS?=
 =?us-ascii?Q?B+lFxm/4sJczoYtnYdnnhImPJx7qGgiP2BqpSEZAbCXfkXuljcfecSsV9HWo?=
 =?us-ascii?Q?+zzzoFXwMsngHh+BkN1AEUFJKpWh6y4uk4aB1yY4sn9cMbCMI5hQKQRHH+ge?=
 =?us-ascii?Q?qZEwVPZuHO41TTh6MnZW8gNCwj1b/xqwbPQKK5r8g/0tHrL2RmVtfy/zlzOa?=
 =?us-ascii?Q?yqo72qWqV9iJi4i2lULdIUw8uOrxhSqEtGT+zzAVyqPChGsIjZbBt+6E0NIs?=
 =?us-ascii?Q?gwK3743Ax0kOB1Qo4Y72Ug86Aejf9IuF3qlpqsC1cAKx4DmXzPoB5v78T9/E?=
 =?us-ascii?Q?9GSqNPz+CK06fPeOg7F5AaWXvq8Lt/DnfihTQQS45icge9DE3fLZBZLvB+OY?=
 =?us-ascii?Q?+jA1JZ0lhNzYIk0prKqHCeM2lS218aXz2GhE9WXa9eqrZXOYnNxbuSqFBxRx?=
 =?us-ascii?Q?aCOJO6Iuc2q4xQy8grgFDyEzM8I4l8C+3+PTeEoynam0gLH7hh3d4nGOm/QB?=
 =?us-ascii?Q?71fjRSvUx4NmUnen/REez8EkBZ7ugk34yKmQapHmaB9IIDJsKR501CAMQm6V?=
 =?us-ascii?Q?r4Qcpv3w7OTEhc6TV0nRi58TlqspnVW/040htaAcoEapV1RDuBRL5K3tNKzK?=
 =?us-ascii?Q?lca2a7PaD/RMysqcp6tkUXeXMsl+gjGk2o/mPKfhoiVs0lzqssO0ZH+EZ1KD?=
 =?us-ascii?Q?a7s1kL545qgWaEJFlhNl/WUfNAAiVweJ6iAWijong+WoUoZ+du+vk3VI8CY+?=
 =?us-ascii?Q?cOM3fCs1stDOZEU5yDNCWGpcl0gaysYSQZMzI/TxvimpKNNAwNrMfBXlRcmH?=
 =?us-ascii?Q?beDonRAzNEgEeZyGzeQMU8St2dlfZJEbY6cx5VdbvVcCujNPcu88N4DUR8uK?=
 =?us-ascii?Q?fX3t24IF2LwbS9ygidpYEQW5zemWJqfZmrRZQbc58BHlPK5eH8/PTR2hHex4?=
 =?us-ascii?Q?vlnlqu4mLiCkcqc6J7JxrLV+wI9qWexn8lrd1ivJHT8JOf7FLemQq7j5rCVh?=
 =?us-ascii?Q?vMkpGUZAFLa39ZJfpZJ9texO3kqbIV/RaW3jy47lu08m0U1xwVwfVSyDcPhL?=
 =?us-ascii?Q?vvVBfMxsMsdosbjQf/cAsakxjkyn7UP7Tv2PrS7+iLky9mny2WbSmARmL7HJ?=
 =?us-ascii?Q?Tu9gWjcY6BEBCu/IMVXqJb4P7LipUlBzGQJ7B79k6pDfOvF+O0/iutPUMcQG?=
 =?us-ascii?Q?jYJTGg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 08:58:45.0120 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 787a27bd-04ce-4f80-d96a-08de599472e6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9625
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

Add AMDGPU_USERQ_UPDATE_QUEUE IOCTL to support updating user mode
queue properties after creation. This allows userspace to modify
queue attributes like ring buffer address, ring size, queue
priority, and queue percentage dynamically.

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 106 +++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  |   6 ++
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c |   1 +
 include/uapi/drm/amdgpu_drm.h              |  13 +++
 6 files changed, 122 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 246d74205b48..1679075f679b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -813,6 +813,9 @@ struct amdgpu_mqd_prop {
 	uint32_t cu_mask_count;
 	uint32_t cu_flags;
 	bool is_user_cu_masked;
+	uint32_t queue_percentage;
+	/* used in gfx9 and gfx12.1 */
+	uint32_t pm4_target_xcc;
 };
 
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 9c425169a4f9..bc6cc1517221 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -3075,6 +3075,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
 	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_OP, amdgpu_gem_op_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_USERPTR, amdgpu_gem_userptr_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ, amdgpu_userq_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
+	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_UPDATE_QUEUE, amdgpu_update_queue_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_SET_CU_MASK, amdgpu_userq_set_cu_mask_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_SIGNAL, amdgpu_userq_signal_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_WAIT, amdgpu_userq_wait_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 4cbf75723c08..922f73b92db3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -34,6 +34,26 @@
 #include "amdgpu_hmm.h"
 #include "amdgpu_userq_fence.h"
 
+/* Mapping queue priority to pipe priority, indexed by queue priority */
+int amdgpu_userq_pipe_priority_map[] = {
+	AMDGPU_RING_PRIO_0,
+	AMDGPU_RING_PRIO_0,
+	AMDGPU_RING_PRIO_0,
+	AMDGPU_RING_PRIO_0,
+	AMDGPU_RING_PRIO_0,
+	AMDGPU_RING_PRIO_0,
+	AMDGPU_RING_PRIO_0,
+	AMDGPU_RING_PRIO_1,
+	AMDGPU_RING_PRIO_1,
+	AMDGPU_RING_PRIO_1,
+	AMDGPU_RING_PRIO_1,
+	AMDGPU_RING_PRIO_2,
+	AMDGPU_RING_PRIO_2,
+	AMDGPU_RING_PRIO_2,
+	AMDGPU_RING_PRIO_2,
+	AMDGPU_RING_PRIO_2
+};
+
 u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev)
 {
 	int i;
@@ -907,7 +927,6 @@ static int amdgpu_userq_update_queue(struct amdgpu_usermode_queue *queue,
 	struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
 	struct amdgpu_device *adev = uq_mgr->adev;
 	const struct amdgpu_userq_funcs *uq_funcs;
-	bool unmap_queue = false;
 	int r;
 
 	uq_funcs = adev->userq_funcs[queue->queue_type];
@@ -923,23 +942,94 @@ static int amdgpu_userq_update_queue(struct amdgpu_usermode_queue *queue,
 		r = amdgpu_userq_unmap_helper(queue);
 		if (r)
 			return r;
-		unmap_queue = true;
 	}
 
 	r = uq_funcs->mqd_update(queue, minfo);
+	if (r)
+		return r;
 
-	if (unmap_queue) {
-		int map_r = amdgpu_userq_map_helper(queue);
-		if (map_r)
-			dev_err(adev->dev, "Failed to remap queue %llu after update\n",
+	/*
+	 * If the queue is considered active (has valid size, address, and percentage),
+	 * we attempt to map it. This effectively starts the queue or restarts it
+	 * if it was previously running.
+	 */
+	if (AMDGPU_USERQ_IS_ACTIVE(queue)) {
+		r = amdgpu_userq_map_helper(queue);
+		if (r)
+			drm_file_err(uq_mgr->file, "Failed to remap queue %llu after update\n",
 				queue->doorbell_index);
-		if (!r)
-			r = map_r;
 	}
 
 	return r;
 }
 
+int amdgpu_update_queue_ioctl(struct drm_device *dev, void *data,
+			      struct drm_file *filp)
+{
+	struct amdgpu_fpriv *fpriv = filp->driver_priv;
+	struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
+	struct amdgpu_userq_update_queue_args *args = data;
+	struct amdgpu_usermode_queue *queue;
+	struct amdgpu_mqd_prop *props;
+	int r;
+
+	/*
+	 * Repurpose queue percentage to accommodate new features:
+	 * bit 0-7: queue percentage
+	 * bit 8-15: pm4_target_xcc
+	 */
+	if ((args->queue_percentage & 0xFF) > AMDGPU_USERQ_MAX_QUEUE_PERCENTAGE) {
+		drm_file_err(uq_mgr->file, "Queue percentage must be between 0 to AMDGPU_USERQ_MAX_QUEUE_PERCENTAGE\n");
+		return -EINVAL;
+	}
+
+	/* Validate priority */
+	if (args->queue_priority > AMDGPU_GFX_QUEUE_PRIORITY_MAXIMUM) {
+		drm_file_err(uq_mgr->file, "Queue priority must be between 0 to KFD_MAX_QUEUE_PRIORITY\n");
+		return -EINVAL;
+	}
+
+	/* Validate ring size */
+	if (!is_power_of_2(args->ring_size) && (args->ring_size != 0)) {
+		drm_file_err(uq_mgr->file, "Ring size must be a power of 2 or 0\n");
+		return -EINVAL;
+	}
+
+	if (args->ring_size > 0 && args->ring_size < AMDGPU_GPU_PAGE_SIZE) {
+		args->ring_size = AMDGPU_GPU_PAGE_SIZE;
+		drm_file_err(uq_mgr->file, "Size clamped to AMDGPU_GPU_PAGE_SIZE\n");
+	}
+
+	if ((args->ring_base_address) &&
+		(!access_ok((const void __user *) args->ring_base_address,
+			sizeof(uint64_t)))) {
+		drm_file_err(uq_mgr->file, "Can't access ring base address\n");
+		return -EFAULT;
+	}
+
+	mutex_lock(&uq_mgr->userq_mutex);
+	queue = amdgpu_userq_find(uq_mgr, args->queue_id);
+	if (!queue) {
+		mutex_unlock(&uq_mgr->userq_mutex);
+		return -EINVAL;
+	}
+
+	props = queue->userq_prop;
+	props->queue_size = args->ring_size;
+	props->hqd_base_gpu_addr = args->ring_base_address;
+	props->queue_percentage = args->queue_percentage & 0xFF;
+	/* bit 8-15 are repurposed to be PM4 target XCC */
+	props->pm4_target_xcc = (args->queue_percentage >> 8) & 0xFF;
+	props->hqd_pipe_priority = amdgpu_userq_pipe_priority_map[args->queue_priority];
+	props->hqd_queue_priority = args->queue_priority;
+
+	r = amdgpu_userq_update_queue(queue, NULL);
+
+	mutex_unlock(&uq_mgr->userq_mutex);
+
+	return r;
+}
+
 int amdgpu_userq_set_cu_mask_ioctl(struct drm_device *dev, void *data,
                                     struct drm_file *filp)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 43bf104d2fb8..c8ea81c17c6e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -31,6 +31,9 @@
 #define to_ev_fence(f) container_of(f, struct amdgpu_eviction_fence, base)
 #define uq_mgr_to_fpriv(u) container_of(u, struct amdgpu_fpriv, userq_mgr)
 #define work_to_uq_mgr(w, name) container_of(w, struct amdgpu_userq_mgr, name)
+#define AMDGPU_USERQ_IS_ACTIVE(q) ((q)->userq_prop->queue_size > 0 &&	\
+			    (q)->userq_prop->hqd_base_gpu_addr != 0 &&	\
+			    (q)->userq_prop->queue_percentage > 0)
 
 enum amdgpu_userq_state {
 	AMDGPU_USERQ_STATE_UNMAPPED = 0,
@@ -118,6 +121,9 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data, struct drm_file *filp
 int amdgpu_userq_set_cu_mask_ioctl(struct drm_device *dev, void *data,
 					struct drm_file *filp);
 
+int amdgpu_update_queue_ioctl(struct drm_device *dev, void *data,
+			      struct drm_file *filp);
+
 int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct drm_file *file_priv,
 			  struct amdgpu_device *adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index ae221eaa5b82..cfa3cb46a983 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -304,6 +304,7 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 	userq_props->use_doorbell = true;
 	userq_props->doorbell_index = queue->doorbell_index;
 	userq_props->fence_address = queue->fence_drv->gpu_addr;
+	userq_props->queue_percentage = 100;
 
 	if (queue->queue_type == AMDGPU_HW_IP_COMPUTE) {
 		struct drm_amdgpu_userq_mqd_compute_gfx11 *compute_mqd;
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 41b6b3cea834..c42328453652 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -59,6 +59,7 @@ extern "C" {
 #define DRM_AMDGPU_USERQ_WAIT		0x18
 #define DRM_AMDGPU_GEM_LIST_HANDLES	0x19
 #define DRM_AMDGPU_USERQ_SET_CU_MASK	0x1a
+#define DRM_AMDGPU_USERQ_UPDATE_QUEUE	0x1b
 
 #define DRM_IOCTL_AMDGPU_GEM_CREATE	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
 #define DRM_IOCTL_AMDGPU_GEM_MMAP	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
@@ -81,6 +82,7 @@ extern "C" {
 #define DRM_IOCTL_AMDGPU_USERQ_WAIT	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_WAIT, struct drm_amdgpu_userq_wait)
 #define DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_LIST_HANDLES, struct drm_amdgpu_gem_list_handles)
 #define DRM_IOCTL_AMDGPU_USERQ_SET_CU_MASK DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_SET_CU_MASK, struct amdgpu_userq_set_cu_mask_args)
+#define DRM_IOCTL_AMDGPU_USERQ_UPDATE_QUEUE DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_UPDATE_QUEUE, struct amdgpu_userq_update_queue_args)
 
 /**
  * DOC: memory domains
@@ -343,6 +345,7 @@ union drm_amdgpu_ctx {
 #define AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_HIGH 3 /* admin only */
 /* for queues that need access to protected content */
 #define AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE  (1 << 2)
+#define AMDGPU_USERQ_MAX_QUEUE_PERCENTAGE	100
 
 /*
  * This structure is a container to pass input configuration
@@ -440,6 +443,16 @@ struct amdgpu_userq_set_cu_mask_args {
 	__u64 cu_mask_ptr;
 };
 
+
+/* IOCTL parameters used to set user queue updates */
+struct amdgpu_userq_update_queue_args {
+	__u64 ring_base_address;
+	__u32 queue_id;
+	__u32 ring_size;
+	__u32 queue_percentage;
+	__u32 queue_priority;
+};
+
 /* GFX V11 IP specific MQD parameters */
 struct drm_amdgpu_userq_mqd_gfx11 {
 	/**
-- 
2.49.0

