Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C47EE77197
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jan 2025 10:35:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2920F10ED4E;
	Thu,  9 Jan 2025 10:35:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hd47TaDA";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 604C410ED4B
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jan 2025 10:35:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T53tXrpWJyQI2ixInuLdq9lnSKh0h+XERH47p1ASQdcrgNzLc//PBln62Kq15ahCfElvtQi+EypXRQCKiv0tfytgS2HTF6cSmU0P5+PNwdQVkOj7kK5H3Ovno+moe6XzTEk5wHzsgKdGWm+327kDYSt0aZLCLvvKngv31FUyQiGPwBh+7Y4c+IFdMY2tOlGKPhWX538XsIKNgcnoJ1fNji9FU7UXfdH++ETJWXln/UTaGN0goG9GZfUTzgBcknmXRfOluCbEhholYiE8qU2nwUT5cdqFKyQqZLzjMn7w+Vkbkhbsap9vQczaghkfwOk09UdylGKPe3+YkDZ99nzLSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jRLCJcghXFLIK5r2P92Kz4LXjvXSUgD5SPmQH0Fv1oc=;
 b=pPVKDQVUbMRcFGMoNRNf01lyBc5a1BMTA09pkGfVRAwqSZRfhsZ6uZO3zib1o23AS23XouFBjZCZvHCxrBziR8M6winGCBxllUm16+mvLGVTtEvsE8yvBe0tIv6tg9qy8ml2eXoTVQg3EHlkYb4NQxUGftZB6SljcGyxTukGVfF+i6+P64PNwdcPgRZkiE04ovypXCD546QjUrtfrZ6hhQFcLMiyK+O//Q7G2v5uovmkTiUM2nL6UIJ4Jcpu4BUro/7uUQ9YinhrTLR0reDWaiH6+Ao+tX/XsGAF4/sfF9JESv6VE9xXut0KoU5cEf+9xr8lolImGPO7X1vwEW76cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jRLCJcghXFLIK5r2P92Kz4LXjvXSUgD5SPmQH0Fv1oc=;
 b=hd47TaDATycyAywUDMGc22qeesAnDZLjOZLfFfZU7t9wy7tMPTfM9F/j08V7mvMwjyhfiFPCTIRBfWrRG9VKJqvYzAsFF665qxHwv3JvfdxMRmJcfBqMqklY7R5DR6TzHx+7zexWFaAWdVtbyNOQPVQxRW8MIV4thIUi1EMsNoQ=
Received: from BY5PR16CA0021.namprd16.prod.outlook.com (2603:10b6:a03:1a0::34)
 by PH7PR12MB5784.namprd12.prod.outlook.com (2603:10b6:510:1d3::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.18; Thu, 9 Jan
 2025 10:35:36 +0000
Received: from CO1PEPF000066E9.namprd05.prod.outlook.com
 (2603:10b6:a03:1a0:cafe::ff) by BY5PR16CA0021.outlook.office365.com
 (2603:10b6:a03:1a0::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.15 via Frontend Transport; Thu,
 9 Jan 2025 10:35:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066E9.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Thu, 9 Jan 2025 10:35:35 +0000
Received: from saleem-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 9 Jan
 2025 04:35:32 -0600
From: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <saleemkhan.jamadar@amd.com>,
 <shashank.sharma@amd.com>, <veerabadhran.gopalakrishnan@amd.com>
CC: <alexander.deucher@amd.com>, <leo.liu@amd.com>, <christian.koenig@amd.com>
Subject: [PATCH v2 1/2] drm/amdgpu: map doorbell for the requested userq
Date: Thu, 9 Jan 2025 16:04:49 +0530
Message-ID: <20250109103450.870169-2-saleemkhan.jamadar@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250109103450.870169-1-saleemkhan.jamadar@amd.com>
References: <20250109103450.870169-1-saleemkhan.jamadar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E9:EE_|PH7PR12MB5784:EE_
X-MS-Office365-Filtering-Correlation-Id: 831759d6-d72b-4127-8e39-08dd30995a38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MqF03ctX9hB5Pm5VaDMHom0mY9G1K128kO4MWmKVNEctSUYwNjMu2Xd2eKDx?=
 =?us-ascii?Q?XCQUHM5htv5erxa0mcHy0381JrWl1g3m21njg8srzIun1AySX/yyDXJ+bVNs?=
 =?us-ascii?Q?5myr86IVFtfWz4NylOhpGxFbjT36O9vLhWl0FSx7SKUzJmUB4z2OGkzhdkdh?=
 =?us-ascii?Q?+mbctzibExSszRfAmnMQo4BoLvq4Rl9vDYHmBZS09IoftzI7wyqg6JD2EAt6?=
 =?us-ascii?Q?+7HhmXkW4t9xmp/6yNcFHyRjxUh31s93NYYm6JB0WQidpNbs2+gr5vjUsl4/?=
 =?us-ascii?Q?jCE7dGh3lP0MC/e9JAKokc0CuaO9CzcvEBaGVkvZ/0guSwiND7HfSCKpy7S6?=
 =?us-ascii?Q?ABI+9rVtXMrMZpLH05kTqu4LGWS9WtHyzqMafQnB8+YDhBPEXJ3qhJnAKFZ6?=
 =?us-ascii?Q?B4tTJssALaHEbjyeaDkpaMHJUcV0kJLht/VDmrKI4bZAlc5lRzNsaP3VER+h?=
 =?us-ascii?Q?9evSKVnLAmjQ+DwWYtwiQXxMzH5wZC9C7wdwkHrc0WELkbVXktKz38hGQwUD?=
 =?us-ascii?Q?swxCcZvL0lKY1DBGQTXBStlIM7KC1LzEkEJeGTidV6fLFVj5OppPHw4G+mAq?=
 =?us-ascii?Q?PPLENhqf9m7X48qttOg7TGHCIl7uPgzUWFDfaPK6cai5MHtjFk0cQ9b1yTWk?=
 =?us-ascii?Q?k2AaHrorOG1TCLRIGNcDtBzKCReYid9aPn8rarkJz6WKYWLLtuNl8iG/zOE7?=
 =?us-ascii?Q?2My0N3dEXUlHl0xMa88PpowlOQUNM7FEmYyrN17dQgBWTUePolXllgpDB07l?=
 =?us-ascii?Q?JovAQp5Y7ns7n8cNcjEjsC5MWMYvKOG1oNHqD6ZjLu6n883cYJ2FcaA2FCkL?=
 =?us-ascii?Q?Qs3bwyuKpFlGQ0uEAdKHPgTst47cCFLZeeBNQLVEFskmiGzBou6qzCNOX41Q?=
 =?us-ascii?Q?OEYHX1mUdw+n+qpg9nfaoUyk7aoVmXcnY6wlb2VS+pkEbat0A07iIAgPx9M8?=
 =?us-ascii?Q?RHFUHKvtR3UdNMQVgHeXxYOv/NT8YcgdQldxLmUSoPA9rq3d6uRyXIi7dbB1?=
 =?us-ascii?Q?Y6n2/TP/1c4E2I6zgEczAKRInP15dX3dO3qLWbvhkNrCJgl0IkMfhRHALPm+?=
 =?us-ascii?Q?3109f/1dLTqaNE+kxuGMkdh9DHVksl1P8sTVpwgfx3FxU44LrqvJukQUJiSh?=
 =?us-ascii?Q?TJT0QkVFifIRM4NpUtBWJrsgROTlHvA//VkYBvaXwTt1o8VCl5I7w8HOYe83?=
 =?us-ascii?Q?FDKR3jdJOder0wFcUuOZy890aaNYbgnistisjxzVrzEVDndhAwBm7bANh2bO?=
 =?us-ascii?Q?ZsaS9T6Jw+TGAmgk3UNKmt+k4cfVyuJRGWpuJ40q9s5AYNuwyWXdWCJxipD9?=
 =?us-ascii?Q?7ddDu/JS9bbDPZetRRCQQYJwqeadBPsoFexIoYqbOGrCcF89s7wMzRGgwcMm?=
 =?us-ascii?Q?cEp9myj8KK7otnzfePQNNgQiQfUhzizp2ze4aDZqlWazlIfH1v2tciipSSiw?=
 =?us-ascii?Q?MuDAUkJV8SovDOK7OgoROcP6Z2oks/sPDJr510lOx4i2zRavdA4s2Gg/qSHy?=
 =?us-ascii?Q?9ykcrocRvOJk+Zg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 10:35:35.6701 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 831759d6-d72b-4127-8e39-08dd30995a38
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5784
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

Introduce db_info structure to the populate the doorbell
information that is required to be mapped.

Made changes to the doorbell mapping func more generic,
by taking parameters that vary based on IPs and/or usecase
into db_info structure.

v2 - Fix space alignment and checkpatch warnings(Shashank) 

Signed-off-by: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 27 +++++++++++--------
 .../gpu/drm/amd/include/amdgpu_userqueue.h    | 12 +++++++++
 2 files changed, 28 insertions(+), 11 deletions(-)

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
index e7e8d79b689d..0f358f77f2d9 100644
--- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
+++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
@@ -78,6 +78,13 @@ struct amdgpu_userq_mgr {
 	struct delayed_work		resume_work;
 };
 
+struct amdgpu_db_info {
+	uint64_t doorbell_handle;
+	uint32_t queue_type;
+	uint32_t doorbell_offset;
+	struct amdgpu_userq_obj	*db_obj;
+};
+
 int amdgpu_userq_ioctl(struct drm_device *dev, void *data, struct drm_file *filp);
 
 int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amdgpu_device *adev);
@@ -98,4 +105,9 @@ int amdgpu_userqueue_active(struct amdgpu_userq_mgr *uq_mgr);
 
 void amdgpu_userqueue_ensure_ev_fence(struct amdgpu_userq_mgr *userq_mgr,
 				      struct amdgpu_eviction_fence_mgr *evf_mgr);
+
+uint64_t amdgpu_userqueue_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr,
+					     struct amdgpu_db_info *db_info,
+					     struct drm_file *filp);
+
 #endif
-- 
2.34.1

