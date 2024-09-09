Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE8B0ECE588
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Sep 2024 20:07:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5358810E67F;
	Mon,  9 Sep 2024 20:07:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LyUT5uGq";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F5D910E67D
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Sep 2024 20:07:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GuFvVKr4XUENZzRJYWjSiPabFmY1bjwWUN/mldi6sWcP+0oxY1NqRGWXQMrDqWpcR1ld1xnzhT/dveWqnV22T9REdxFbnWgHN4IdXzNNWu3PeeELnTiEOdPDHHiKQ99yknKOwQJC0mB5gPy4nM+f0jHX2cm6ObRG96K0/oOUyFxjDafInUDDLhU2agLjha6dcNh5UHcICA8Wp6a4bjdNyU1a60I3lJcoGrANiF03kMQESQeK3Z3Yr3FFCLUp5Gb7rPMmoxiBU937xG52pZrpbckdmFwHS0kRXRB2mjpGP1z3IvtRTS1AxjWP4/MbxrYyoqh+zYyp5je0UU4Mmxxmng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Y91Kn1dVzfECWnptykQzCMf7MLGV2bO5n9y9r59hPE=;
 b=WRFywGcYhtED5kAxLXqU8WIu6dhkmHXds7PhGxc14Pk0HzrqJGEdxrk9UxcTLxRwdqX+E1mp4IvjoO308YmlofgQAYWJpSh80W9Pi/McGfoKpfTpIFGaqFSLvNDvGvfhtLXWheal/rK0UUPAYns2L1NJ9uHAudHiGeqasdzNbCqFFdYQQ/EbSfWCXGtc1hKtrGGJB51Baokf1nngakXQ3u8EknlitWeYXtZxdNc7E3+QSHQt9yIJwW7Q/ihDbgLg7SstlAK9mJYX72IjEPCBSPr+u9kSBWnPUH5GK7hQacIWkCK4Ad06DfKL7NDyqyBWEc8uYaC8uMSIXuYzmtfenQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Y91Kn1dVzfECWnptykQzCMf7MLGV2bO5n9y9r59hPE=;
 b=LyUT5uGqipL9b1zhSHo+hbEsEvpXHrCxx0WzmZ0K7+ktQz8HUHA7pFIMbXcXqFCug5i1M/uuoJI4Z2e5tzbQljKhCVNLOnG5SRT+S9kIL9CNRQjCVte0nGLCbhxgqU9tkcDNL6RT4viF2Ht+g7BBvtwescdeDJXGVwMZ5xW9dj0=
Received: from SA0PR11CA0148.namprd11.prod.outlook.com (2603:10b6:806:131::33)
 by DS7PR12MB6310.namprd12.prod.outlook.com (2603:10b6:8:95::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17; Mon, 9 Sep
 2024 20:06:59 +0000
Received: from SN1PEPF000397B1.namprd05.prod.outlook.com
 (2603:10b6:806:131:cafe::39) by SA0PR11CA0148.outlook.office365.com
 (2603:10b6:806:131::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23 via Frontend
 Transport; Mon, 9 Sep 2024 20:06:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF000397B1.mail.protection.outlook.com (10.167.248.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 9 Sep 2024 20:06:59 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Sep
 2024 15:06:57 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Shashank Sharma <shashank.sharma@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>
Subject: [PATCH v11 03/28] drm/amdgpu: add new IOCTL for usermode queue
Date: Mon, 9 Sep 2024 22:05:54 +0200
Message-ID: <20240909200614.481-4-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20240909200614.481-1-shashank.sharma@amd.com>
References: <20240909200614.481-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B1:EE_|DS7PR12MB6310:EE_
X-MS-Office365-Filtering-Correlation-Id: 92f5457c-9270-4db5-89be-08dcd10af65a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lACOEnsCFWtoS7h7xMx+duyH39bWqdYxXKleXejn2kZafeQ3vwO+sHSzF+2k?=
 =?us-ascii?Q?lGVdbFKkFefHodrQM/IW3zt/xds+vQGP0qliv07DfDgoPjwpOrshyaT9sGhf?=
 =?us-ascii?Q?KT8WND+RW8ZXHixWcivQCAP0m7lDZSZmFp64uTuLkRy2SMORLA2nPanvZHeF?=
 =?us-ascii?Q?tF96jgmJLzd4LhyFS0UqG80w1rS5NFageM4u3kXUVrNo9w6Jj34vy0nLtSJC?=
 =?us-ascii?Q?XKOtowTa1ketgp2mEvcvytq309B6wkFIrnyHTfp2lRFqVY6+xFo6806jtWSa?=
 =?us-ascii?Q?fDPTSXTcNPy8cw9Jy6UaVjHD1+h9N1z7fdivHF4HalvUp3l+2Z8Cd2NMDqyY?=
 =?us-ascii?Q?rK7zVytyD+FtCDvpt1wXlMcsjOWpaOODT1W5fdJjzWyB/XPFjzE0qRxOyytj?=
 =?us-ascii?Q?fWNya1vKgRQRS5q67FwbWClQrOSd0GpKbghWnzK3USSaafd/mGqvWzYjNoze?=
 =?us-ascii?Q?f+/Hv6/lV17JcA5RpIdAd2xQhTyftmcg1vRR8/96z2iF76Gc6V4fT0cr9+jJ?=
 =?us-ascii?Q?7YMEQzudEQal3ytR6pSXdxZ/bFpkKAvZ1i3ZtSMRxmBQT7F7MjZpDeXh/X62?=
 =?us-ascii?Q?k9dPC+bjYH62BNXiKSOD/7QSIqtWFWHx090BpcKayT5V51Me2lF8n8/Y1fl6?=
 =?us-ascii?Q?EpZIVGY+I+uB/hWgAp39iXPhNvgspHXwh4Cn7BUhkR+glnTm4ZW+1PW4WcT0?=
 =?us-ascii?Q?OdDCS+PSAnee9DvIPoli6e/FBHC0EdRLi/xVZp+maLz7PFQfoeIQBLIEb0LK?=
 =?us-ascii?Q?BGNsQ1WpW5INtTR0ory1t4w+2erVz4AHtK3vmcCdpp2+PoEN7udwdM6Dmxw5?=
 =?us-ascii?Q?Eq6Kok6EapnRXTINPFejRA3/0kIRnsVbfzXsMj1Lu8NqZyBup4JdkuMinand?=
 =?us-ascii?Q?3uG8w5fJvU25/cI9iXlxpxbxlapQxuk5EutsIrJNlP9/p3cpPxshF3bfsLUY?=
 =?us-ascii?Q?hBsDlV0H0X4q93PqbOCVcmEpAMtJRqFc0BVYT7cnILpNr48ZIJQdHsq2pRf1?=
 =?us-ascii?Q?OsqTFTubEkPCdA5CDB8XxNGD03ijZ/pEEhWhUtEeIT5FG+ANYj9dgTyDsiEX?=
 =?us-ascii?Q?GnSL29UUQU1cnYGMr8NteOTCYA2cJgW+0QjKRpB3GFbzby2WKhLX//I6Pzft?=
 =?us-ascii?Q?DsnzGoUV8X1MK78PjEHf0mEbDkLhTj/FZUozydVTt5/LbA2ho5asLkNhmtKG?=
 =?us-ascii?Q?pB5RtZQ+GaiPqnuyV1aC6CRA1b3SgVy5Y6wpTQSfDQh/mo6kFfQhsti0Ogea?=
 =?us-ascii?Q?a4GbeAy9LKLP8246kNpU28xXZjJAiyLLAZixPyWPQ7Eq94ms9g3QVXfObfm8?=
 =?us-ascii?Q?ykeppo3AxIj/Yi1Fi63gsaiubj9i1dsqL0sTXIc4QPjVt1mrgKzenhz+R+bD?=
 =?us-ascii?Q?w8o0B5vdfdngB5BG5Rs8EAQiZ05Lk2pkYnNyc/z+ITaqaPPtLMVuE4Kb8CQW?=
 =?us-ascii?Q?bSJGcpX7qmbaaOFWH/wZef3m8oRy0fqq?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 20:06:59.1993 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92f5457c-9270-4db5-89be-08dcd10af65a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6310
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

V11:
  - check the input flags to be zero (Alex)

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Reviewed-by: Christian Koenig <christian.koenig@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 120 ++++++++++++++++++
 .../gpu/drm/amd/include/amdgpu_userqueue.h    |   2 +
 3 files changed, 123 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index d92f01f3ea44..79db64d30c18 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2951,6 +2951,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
 	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_VA, amdgpu_gem_va_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_OP, amdgpu_gem_op_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_USERPTR, amdgpu_gem_userptr_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
+	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ, amdgpu_userq_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 };
 
 static const struct drm_driver amdgpu_kms_driver = {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index effc0c7c02cf..cf7fe68d9277 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -23,6 +23,126 @@
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
+	if (args->in.flags) {
+		DRM_ERROR("Usermode queue flags not supported yet\n");
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
2.45.1

