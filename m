Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ED37E77199
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jan 2025 17:20:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C210510E99A;
	Mon,  6 Jan 2025 17:20:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NcC+1+ub";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C87FE10E99A
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jan 2025 17:20:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KgAqxx2Oyj7x8ICTyOGDuMcNB13LOMCfkS1DM2a+pja4UXuAYVJcd0J1dJi5x+hjt9jbwbgIymEfONNqgkeAuOE79EdHkXkH4JquTlD9GJ7WVmU+mSNbrwsemTtubp5lOjiwsNISD1pKUJW5nydh2Ljleh7Qn/IPYe3h9PFs9RTqk7ZpcOnqiEvfoltK/J56NIWR7Al9z6m2vbZF9comt/IkJSqktlFemP/5H6BrAtGkFptbqPhtRr8tXmqiN+9N1Otxii4IBI3uj0kevb/pUH3/0DAXZb6/a1BSGp76AI5pOxg0clS0Q/lrT6TZNReYf1UEmIoDtWWIIUe0yOjcaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tr44k/x1wZPUx8bhE6JKYF5jF796y78ptrf52eEkTHo=;
 b=s65WxN00sjJZEVmDrSH3hFIsIZq5OGrO+HdEowbnLlgkis1cwWgk0ZgU4ghrqBjScq5K4NGkIvR5kdwihwFsaoNb3Fqf7AhrcC2OBJKfft31dERCollnzRSQAmilMKGXQMtKoQnaDyL0+MjbjHOzRNwx9GLoMSxIhXQOcqt0u3G/9sJ2gx507XMdTURjBBob22PGPBqlUuKgH+4xxzBieUUW6vPf2VW4bs66mvRoHZsbakfgsWjL0JV2+0CoQ8WA3VHitwoBrxu2klj5W8ylCl5GFxdnP30jl+uaHS3pU0KkAEDJUhDFUw0SwW/dS/xdMDsXqtLGeVqkUIbgR20J9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tr44k/x1wZPUx8bhE6JKYF5jF796y78ptrf52eEkTHo=;
 b=NcC+1+ub5912BtTPtmolnfUIrXlMnhKcaL6CXIL3AYVbJoJRV+8YkE1mDZ/FP31NhjAVsknR2yUny6fSHw1dcf7HQCU+4b9JM2S4peUk9cgXy9njqKQ23Vf8dXletqbq9Iqgu9eLJJAY9HLXeaFsV0qRI+2gLDmjVwJKsahGJe4=
Received: from CH2PR19CA0024.namprd19.prod.outlook.com (2603:10b6:610:4d::34)
 by SJ2PR12MB9005.namprd12.prod.outlook.com (2603:10b6:a03:53d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.16; Mon, 6 Jan
 2025 16:46:54 +0000
Received: from CH2PEPF0000009E.namprd02.prod.outlook.com
 (2603:10b6:610:4d:cafe::9d) by CH2PR19CA0024.outlook.office365.com
 (2603:10b6:610:4d::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.18 via Frontend Transport; Mon,
 6 Jan 2025 16:46:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000009E.mail.protection.outlook.com (10.167.244.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Mon, 6 Jan 2025 16:46:53 +0000
Received: from saleem-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 6 Jan
 2025 10:46:51 -0600
From: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <saleemkhan.jamadar@amd.com>,
 <shashank.sharma@amd.com>, <veerabadhran.gopalakrishnan@amd.com>
CC: <alexander.deucher@amd.com>, <leo.liu@amd.com>, <christian.koenig@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: map doorbell for the requested userq
Date: Mon, 6 Jan 2025 22:15:29 +0530
Message-ID: <20250106164530.763188-3-saleemkhan.jamadar@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250106164530.763188-1-saleemkhan.jamadar@amd.com>
References: <20250106164530.763188-1-saleemkhan.jamadar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009E:EE_|SJ2PR12MB9005:EE_
X-MS-Office365-Filtering-Correlation-Id: ab35437f-2398-4156-7309-08dd2e71b9d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Lxssd+gyrHrgeD88ZbgkBmjqCRwNRDaaiqeIzpS5ClBlDvFnxxqjVj5eKyg3?=
 =?us-ascii?Q?9OtQ9kW4xMBYM9RkVa49bogVeJtAbTwCsD9Fflom6Q4KxIqpZTnYWwXGYGGs?=
 =?us-ascii?Q?5Hdvt3XxpV/mSnY1K2Po1qYIL1aZ6Li1u0G8NCA0VojEhD3HkR42m3sHi7YJ?=
 =?us-ascii?Q?Hdn3+ZWmDaKPN1qm6eNu36LaJcjfCN8xlHzupS2jNkNaor03/kvxT8vydYGh?=
 =?us-ascii?Q?rS78bCsKwH2Fl80VukTRnJaFGD4/uoCmRpjKIYi9mfJt9AyIgQJ/Ps/+hnnS?=
 =?us-ascii?Q?0vYSA9mr99pknCUTqMUf2BFU4rtxWKlgP/uqz1gzZKv2LeRKqSZ2jJ4oh4X1?=
 =?us-ascii?Q?aq2iUv6x+FQBP0Te09WoaQ8u0sJODJ9StwtfF5IPdh+QTjCdjmZXaKkn8yY8?=
 =?us-ascii?Q?Wirq9orXalshr4ZosPw1JgRUzq8vLOjwEh2pxzozVfwepAwEJ1/GWIWwDpGP?=
 =?us-ascii?Q?4pCc521Hj8j2OulfSLKgbPXqpywEmF7MjK48EaDV5ay4LIjlkGyZXNOqrwY3?=
 =?us-ascii?Q?xblb9wVUTl9ARRAwi6HxsmjUr3WYcFsXc46ciR6YkawOQDvXPD1ichXM8fnt?=
 =?us-ascii?Q?nVATbYLLABT9rCPgaGzhmVj/Xie/W4+vqY3vFH2rmnldrtfogsHGpcIKL1kF?=
 =?us-ascii?Q?s+lmkZ0pD/l/gPz/gJ2yhdv3BnGzNFr7FIMuMtYq+ApN285DJfDwyo1sS3Mn?=
 =?us-ascii?Q?tnQGMobzGNBDNyKOH1W7XHGMtPRAqv95jfrVpsu8gg03B9oITnD4VkWWvmMw?=
 =?us-ascii?Q?R5myUw/RsRO1VdAHQs9CtK282BJKCatqD19weLtSScR4kG9ckRavVMUNETLg?=
 =?us-ascii?Q?Ovcl2zyxHfDwsmwlunfWoyrJ7nYjLJdR74Jgi3hra7/wt8+qeIR7/8etSo3X?=
 =?us-ascii?Q?rmfa6jTtv98dRan8IvXmxDag0ty5u80vYQLJBHd4PUJmlPwFY8+GQY+80jZo?=
 =?us-ascii?Q?T15V88EuGosSFhy0iKQCZGndkYLwSXaWn/Ql5Oc0LpH8gMOauo7L8ZRcICwa?=
 =?us-ascii?Q?/vuOY8PFRzkWfVMvMmwoLPEO+aIWpiavzY7BXg+cOGO0OhGimzC9XhVmE1Mw?=
 =?us-ascii?Q?mZBjFbyDchTnJwlq1BZ5h5qt+4AHwB63vLQ0nxhzhwapNdw/PK9IS5hQIge0?=
 =?us-ascii?Q?F2iowmvcomMJk3x2gwgSQTRZIEQQky2DBFsBvudD4ePH4qDFDtlFdEnZzan5?=
 =?us-ascii?Q?iJauN4JJN8E5v9Lq/URiJ3wjUFu0tg5+kfM0DCuObrJPlZu4IcZmZ8BcP5ia?=
 =?us-ascii?Q?xCxshIx8DAQotQYCP19vlcItGU0H7Hm/W98fuBW3uCvy4kaEaJEbMBRbaPSJ?=
 =?us-ascii?Q?NdZTa7xpOgy2nN461q/5I21NF55m4Iw1tGVbHCS3I7VpKnG5mmVskfAdla1E?=
 =?us-ascii?Q?uu8jEbmNfYMbqPEjiRWK9eKj2eWuF9DhRh5idPA9CTXhviN99TKN9QGnlgCv?=
 =?us-ascii?Q?HsN78jT82l9oioBG9wzNs419Ng44ogj5CTaKPGA9454I7iAIX8T9WcSLAWAJ?=
 =?us-ascii?Q?ik+MR5umqBC2OvM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2025 16:46:53.9849 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab35437f-2398-4156-7309-08dd2e71b9d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9005
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

Made changes to the doorbell mapping func more generic,
by taking parameters that vary based on IPs and/or usecase
into db_info structure.

Signed-off-by: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>

]
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 27 +++++++++++--------
 .../gpu/drm/amd/include/amdgpu_userqueue.h    |  5 ++++
 2 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index 85baba323ba5..769154223e2d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -189,18 +189,17 @@ void amdgpu_userqueue_destroy_object(struct amdgpu_userq_mgr *uq_mgr,
 	amdgpu_bo_unref(&userq_obj->obj);
 }
 
-static uint64_t
+uint64_t
 amdgpu_userqueue_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr,
-				     struct amdgpu_usermode_queue *queue,
-				     struct drm_file *filp,
-				     uint32_t doorbell_offset)
+				     struct amdgpu_db_info *db_info,
+				     struct drm_file *filp)
 {
 	uint64_t index;
 	struct drm_gem_object *gobj;
-	struct amdgpu_userq_obj *db_obj = &queue->db_obj;
-	int r;
+	struct amdgpu_userq_obj *db_obj = db_info->db_obj;
+	int r, db_size;
 
-	gobj = drm_gem_object_lookup(filp, queue->doorbell_handle);
+	gobj = drm_gem_object_lookup(filp, db_info->doorbell_handle);
 	if (gobj == NULL) {
 		DRM_ERROR("Can't find GEM object for doorbell\n");
 		return -EINVAL;
@@ -222,8 +221,9 @@ amdgpu_userqueue_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr,
 		goto unpin_bo;
 	}
 
+	db_size = sizeof(u64);
 	index = amdgpu_doorbell_index_on_bar(uq_mgr->adev, db_obj->obj,
-					     doorbell_offset, sizeof(u64));
+					     db_info->doorbell_offset, db_size);
 	DRM_DEBUG_DRIVER("[Usermode queues] doorbell index=%lld\n", index);
 	amdgpu_bo_unreserve(db_obj->obj);
 	return index;
@@ -268,6 +268,7 @@ amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	struct amdgpu_device *adev = uq_mgr->adev;
 	const struct amdgpu_userq_funcs *uq_funcs;
 	struct amdgpu_usermode_queue *queue;
+	struct amdgpu_db_info db_info;
 	uint64_t index;
 	int qid, r = 0;
 
@@ -302,19 +303,23 @@ amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 		goto unlock;
 	}
 	queue->doorbell_handle = args->in.doorbell_handle;
-	queue->doorbell_index = args->in.doorbell_offset;
 	queue->queue_type = args->in.ip_type;
 	queue->vm = &fpriv->vm;
 
+	db_info.queue_type = queue->queue_type;
+	db_info.doorbell_handle = queue->doorbell_handle;
+	db_info.db_obj = &queue->db_obj;
+	db_info.doorbell_offset = args->in.doorbell_offset;
+
 	/* Convert relative doorbell offset into absolute doorbell index */
-	index = amdgpu_userqueue_get_doorbell_index(uq_mgr, queue, filp, args->in.doorbell_offset);
+	index = amdgpu_userqueue_get_doorbell_index(uq_mgr, &db_info, filp);
 	if (index == (uint64_t)-EINVAL) {
 		DRM_ERROR("Failed to get doorbell for queue\n");
 		kfree(queue);
 		goto unlock;
 	}
-	queue->doorbell_index = index;
 
+	queue->doorbell_index = index;
 	xa_init_flags(&queue->fence_drv_xa, XA_FLAGS_ALLOC);
 	r = amdgpu_userq_fence_driver_alloc(adev, queue);
 	if (r) {
diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
index 1109144ed7e0..34b4a7eb79ac 100644
--- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
+++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
@@ -105,4 +105,9 @@ int amdgpu_userqueue_active(struct amdgpu_userq_mgr *uq_mgr);
 
 void amdgpu_userqueue_ensure_ev_fence(struct amdgpu_userq_mgr *userq_mgr,
 				      struct amdgpu_eviction_fence_mgr *evf_mgr);
+
+uint64_t amdgpu_userqueue_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr,
+				     struct amdgpu_db_info *db_info,
+				     struct drm_file *filp);
+
 #endif
-- 
2.34.1

