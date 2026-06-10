Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 250E4CD8CB9
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jun 2026 06:04:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7CD810E716;
	Wed, 10 Jun 2026 06:04:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="F+36uPom";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013019.outbound.protection.outlook.com
 [40.107.201.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8A9810E71A
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jun 2026 06:04:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z/YE3cNK59wZKrLctwPADIhkr38b/bdidsC7/gxDBUsP+qKMY9NXipaIQoTzdmBjSoO2fARH5PclD3lgsDqiFpdk/1Sfd4kBgMrpSXUp7YbED3WnxTSXGl/wzjZOGygem8g7z31fAwyvj9NV6Zb2wfRrLArnWEqwd6FjupssjiijwY9HOlMHHvLva093ed/4cu2yavZAyIl9mQgIdw5xBm/mPH1KL4yiXd7HxUpCvFcp8Ew1dQj/kV0RR0p36gk/wqOEUg7zD8pIZ6LcOD9h+BiW40z7w+7CH5iS+OwbhtcPxHMV6M0Hx7vvF1hYuAcJQ+N6GjkoSjELSbwRB2c1kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XORm/ifYS0043mNPHCWcjJxNR+g4dnMs8NpPW2ee8XY=;
 b=FKkukkgj0uYvguUU0CS28vHfZ5NB44+1r5DpqmMELRndQjApzPco26ORF1HIS1qOVwOWdWHR/uidMwhPyQ86p7s39cJdGVH5PjKDJyznWfu4dyHWebLtPka94lYuAHNP8i6gy9h24257DUcUv5Joy8IDtrhexLPpblwW2u1tJb7ncbqQVTL/5hCqlM2bQBn54fPk6r1UEo/84pPtlTsbinA8DmnmxQkJDsSzviqLVz05r41P03EkTZbZCC5xd2JM+AgwtUA4igchP5lHPXDgdNZnJka0Pxq8pyR6ucYAnSBjfcSCz5gRkBny4yYH6HAPyCKB4aYp5wi5RwK1wXhEJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XORm/ifYS0043mNPHCWcjJxNR+g4dnMs8NpPW2ee8XY=;
 b=F+36uPomTj7Yi7Np9LCS8m4m5kDjIaygmaU4XOoGR3qyMhBFS7qzM9yWXcyhlNryjQ5yhCDErDf2aXcGNMnAmBxVcHNrA2xXRZL8e0o4TyF+eT13ADABPK1o8ZeGIlZGrbHSd6tX9+GrHnvqFqtBbtlBo8RTH9cKxG4L7UvbtMs=
Received: from BL1P223CA0027.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::32)
 by PH7PR12MB7967.namprd12.prod.outlook.com (2603:10b6:510:273::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Wed, 10 Jun
 2026 06:04:40 +0000
Received: from BL02EPF0001A100.namprd03.prod.outlook.com
 (2603:10b6:208:2c4:cafe::70) by BL1P223CA0027.outlook.office365.com
 (2603:10b6:208:2c4::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.11 via Frontend Transport; Wed,
 10 Jun 2026 06:04:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A100.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Wed, 10 Jun 2026 06:04:40 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Wed, 10 Jun 2026 01:04:38 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v10 5/9] drm/amdgpu: Use queue references for queue-aware
 EVENTFD subscriptions
Date: Wed, 10 Jun 2026 11:33:58 +0530
Message-ID: <20260610060402.2769642-6-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260610060402.2769642-1-srinivasan.shanmugam@amd.com>
References: <20260610060402.2769642-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A100:EE_|PH7PR12MB7967:EE_
X-MS-Office365-Filtering-Correlation-Id: ee75a59d-d96c-40d5-6800-08dec6b6289f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|1800799024|376014|36860700016|56012099006|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: 14c2140ZXShKgx8tZ/2sNuRIUzH7ZyJ9Ts96pauXoWZokpLLpFDgJLby3LtNKfHUk8MqWSiz/L7EStqEn8y+q8xnUuAllTpS2EYuPm+fCcUh4l4qw0+f+XTYu96n/G8FT4W0cqWzLzgT13oL89PRsDbfSnV/XDZeeGX7mQBeqSklEfT7YBLdZRGL+YUYzDa7SVLoWZlEwD32979GwMFKzRDxf51X16XYKzjLqLBXvyCxfnUItXrrk6P5Rx3IjXIUWEhbFpSfERXpZ1VnB64Lg/qOLVUvBmbtDgoh8IyUR2j3LDtdhD9opPFhgjrP0Nmyvk9WKrC0giJWiPRl+Jmkr7iTr7ZrprOy7eK3FluBTjvDJ23aHc+M57+UmijfLEs/IgTIcbe/JS/fujoyn4kpeBGm5HasU2P0a9GKyPWkFDmVHM53igGrtkVD4wrvjYlyULc15MbEIl/C0Dl1M+2XIX4toC3WmNDIANdL/TbR/7/lgOPTF0NqxOxpqsx6hfL902yAuHjRv6K3XRuvfOr7bzW2a+BiDyZSsGunMT5Qe4udg9oxts7ZFBtQQYhoeNFzJdRiNxmZtQZLuyYl3X+e+fgvemRcqEto1ZeOZcLG4YKYWImhwDb3ijRqMGUJXggFnM9jfM04g6I3LNAQqF/xwalkzklZSM2tlM6FyxZrwAU1P4bX7uej3yMxaBz7FN6amZkVcMV2AvUD7LxN3CTCwSq491DMYgTGRbAJzB3NmHc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(1800799024)(376014)(36860700016)(56012099006)(18002099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: gJscLBAHbLYmNIGgsbyvWkNOJFfK+LF3pEsB39vKC+eh/9SSUgyvLZ4aL8TRNXnw/g6zw78drLXnuxlrBrcad6sAwcjWURzUeaZrZDaYeWEoDMWJCRL8flYG/kg5KV/YGRj5q7Jlr3KwaVA76O3f2ni0Ti6kRjLOHfXxDhP0jP5hhjofEz5+bpxfQ/c3mZvp0H+vU7lcpRMKZcdjN7fKzzeFDuPe7ENfuIZVpJFO95opFB0w+DpNjHj3BZySFVQ10A9gqOUljkyrzJVwMqB5ca7GTy6zbPserbg+uLDAAwCYSUKU6328+xB8tlW6aiwfTxnkONqEm7vb112IAgt+ZoHdeXJrK+DImXwCzeCYKAfofi/Lswa4As+XMX2avzqemM9qcbO7tPd/x+InSlHJGJeUHtd7MSwBXtt+ljEPqiR+fhWPkEtMxS03juM49+0N
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 06:04:40.0701 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee75a59d-d96c-40d5-6800-08dec6b6289f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A100.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7967
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

Queue-scoped EVENTFD subscriptions originally used queue_id as part of
the routing key. However, queue_id is only a UAPI-visible handle and can
be reused after a queue is destroyed, making it unsuitable as a stable
identifier for internal EVENTFD tracking.

Rework queue-scoped EVENTFD handling to resolve queue_id to the
corresponding amdgpu_usermode_queue object during bind and unbind.
EVENTFD subscriptions now hold references to the actual queue objects
instead of the reusable queue identifiers.

Use the existing user queue refcounting infrastructure to keep queues
alive while subscriptions exist, and release those references during
unbind, manager teardown, and explicit queue cleanup.

Introduce amdgpu_eventfd_remove_queue() to remove all subscriptions
associated with a queue when that queue is being released. This ensures
that EVENTFD does not retain stale queue references after queues are
removed from the USERQ manager.

Queue-scoped subscriptions are now matched using the queue pointer,
while GPU-scoped subscriptions continue to operate without an associated
queue.

Also update the EVENTFD infrastructure to:

distinguish queue-scoped and GPU-scoped event types, allow eventfd file
descriptor 0 by rejecting only negative values, validate supported event
types, and avoid relying on reusable queue identifiers for signaling.

EVENTFD remains notification-only and does not carry event payloads.

Cc: Alex Deucher <alexander.deucher@amd.com>
Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.c | 240 ++++++++++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.h |  19 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c     |  24 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c   |   4 +
 4 files changed, 209 insertions(+), 78 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.c
index 3a6e08a3d0c1..db743435605f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.c
@@ -24,37 +24,63 @@
 /*
  * Render-node eventfd subscription infrastructure.
  *
- * This module provides a simple event notification mechanism for render-node
- * clients using Linux eventfd objects.
+ * EVENTFD is notification-only. It wakes userspace when a GPU event happens.
+ * Event metadata/details are expected to be consumed separately through the
+ * corresponding wait/event path.
  *
- * Userspace can bind an eventfd to a userspace-defined event_id. When the
- * driver signals that event_id, all eventfds bound to it are notified.
- *
- * This mechanism is intended to support lightweight GPU event notifications
- * without polling from userspace.
+ * Queue-scoped subscriptions use queue_id only for lookup at bind/unbind time.
+ * The EVENTFD entry stores a refcounted queue pointer, not the reusable UAPI
+ * queue_id.
  */
 
 #include <linux/slab.h>
 #include <linux/err.h>
+#include <drm/amdgpu_drm.h>
 
+#include "amdgpu.h"
 #include "amdgpu_eventfd.h"
+#include "amdgpu_userq.h"
 
 #define AMDGPU_EVENTFD_MAX_BINDS 4096
 
+static bool amdgpu_eventfd_valid_type(u32 event_type)
+{
+	switch (event_type) {
+	case DRM_AMDGPU_EVENT_TYPE_USERQ_EOP:
+	case DRM_AMDGPU_EVENT_TYPE_QUEUE_RESET:
+	case DRM_AMDGPU_EVENT_TYPE_MEMORY_EXCEPTION:
+	case DRM_AMDGPU_EVENT_TYPE_SCRATCH:
+	case DRM_AMDGPU_EVENT_TYPE_GPU_RESET:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool amdgpu_eventfd_queue_scoped(u32 event_type)
+{
+	switch (event_type) {
+	case DRM_AMDGPU_EVENT_TYPE_USERQ_EOP:
+	case DRM_AMDGPU_EVENT_TYPE_QUEUE_RESET:
+	case DRM_AMDGPU_EVENT_TYPE_SCRATCH:
+		return true;
+	default:
+		return false;
+	}
+}
+
 /**
- * amdgpu_eventfd_id_alloc - allocate an event id container
- * @event_id: userspace-defined event identifier
- *
- * Each event_id represents a notification category. Multiple eventfds can
- * be bound to the same event_id.
+ * amdgpu_eventfd_id_alloc - allocate an event type container
+ * @event_type: kernel-defined AMDGPU event type
  *
- * This function allocates the container which stores the list of eventfds
- * associated with that event_id.
+ * Each event_type has one container. For queue-scoped events, individual
+ * subscriptions inside the container are distinguished by the refcounted
+ * queue pointer stored in each entry.
  *
  * Return:
  * Pointer to the newly allocated structure or NULL on failure.
  */
-static struct amdgpu_eventfd_id *amdgpu_eventfd_id_alloc(u32 event_id)
+static struct amdgpu_eventfd_id *amdgpu_eventfd_id_alloc(u32 event_type)
 {
 	struct amdgpu_eventfd_id *id;
 
@@ -62,43 +88,40 @@ static struct amdgpu_eventfd_id *amdgpu_eventfd_id_alloc(u32 event_id)
 	if (!id)
 		return NULL;
 
-	id->event_id = event_id;
+	id->event_type = event_type;
 	INIT_HLIST_HEAD(&id->entries);
 	id->n_entries = 0;
+
 	return id;
 }
 
 /**
- * amdgpu_eventfd_id_get_or_create - find or create an event_id entry
+ * amdgpu_eventfd_id_get_or_create - find or create an event_type entry
  * @mgr: eventfd manager
- * @event_id: event identifier
- *
- * This helper returns the container associated with the given event_id.
- * If it does not exist, it will create one.
+ * @event_type: kernel-defined AMDGPU event type
  *
- * The function is designed to be callable without holding any locks.
- * Memory allocation is done outside the xarray lock to avoid blocking
- * inside critical sections.
+ * This helper returns the container associated with the given event_type.
+ * If it does not exist, it creates one.
  *
  * Return:
- * Pointer to the event_id structure or NULL on failure.
+ * Pointer to the event_type structure or NULL on failure.
  */
 static struct amdgpu_eventfd_id *
-amdgpu_eventfd_id_get_or_create(struct amdgpu_eventfd_mgr *mgr, u32 event_id)
+amdgpu_eventfd_id_get_or_create(struct amdgpu_eventfd_mgr *mgr, u32 event_type)
 {
 	struct amdgpu_eventfd_id *id;
 	struct amdgpu_eventfd_id *new_id;
-	XA_STATE(xas, &mgr->ids, event_id);
+	XA_STATE(xas, &mgr->ids, event_type);
 	unsigned long flags;
 	int r;
 
 	xa_lock_irqsave(&mgr->ids, flags);
-	id = xa_load(&mgr->ids, event_id);
+	id = xa_load(&mgr->ids, event_type);
 	xa_unlock_irqrestore(&mgr->ids, flags);
 	if (id)
 		return id;
 
-	new_id = amdgpu_eventfd_id_alloc(event_id);
+	new_id = amdgpu_eventfd_id_alloc(event_type);
 	if (!new_id)
 		return NULL;
 
@@ -174,6 +197,7 @@ void amdgpu_eventfd_mgr_fini(struct amdgpu_eventfd_mgr *mgr)
 
 		hlist_for_each_entry_safe(e, tmp, &id->entries, hnode) {
 			hlist_del(&e->hnode);
+			amdgpu_userq_put(e->queue);
 			eventfd_ctx_put(e->ctx);
 			kfree(e);
 		}
@@ -186,51 +210,61 @@ void amdgpu_eventfd_mgr_fini(struct amdgpu_eventfd_mgr *mgr)
 }
 
 /**
- * amdgpu_eventfd_bind - bind eventfd to an event_id
+ * amdgpu_eventfd_bind - bind eventfd to an EVENTFD subscription
  * @mgr: eventfd manager
- * @event_id: userspace event identifier
+ * @userq_mgr: user queue manager used to resolve queue_id
+ * @event_type: kernel-defined AMDGPU event type
+ * @queue_id: UAPI queue id for queue-scoped events, or 0 for GPU-scoped events
  * @eventfd: eventfd file descriptor
  *
- * This function allows userspace to subscribe to notifications for a
- * specific event_id.
- *
- * Multiple eventfds can be bound to the same event_id.
- *
- * Duplicate bindings of the same eventfd are treated as success and do
- * not create additional entries.
+ * For queue-scoped events, queue_id is used only to look up the queue.
+ * The entry stores the refcounted queue pointer, not queue_id.
  *
  * Return:
  * 0 on success, negative error code on failure.
  */
-int amdgpu_eventfd_bind(struct amdgpu_eventfd_mgr *mgr, u32 event_id, int eventfd)
+int amdgpu_eventfd_bind(struct amdgpu_eventfd_mgr *mgr,
+			struct amdgpu_userq_mgr *userq_mgr,
+			u32 event_type, u32 queue_id, int eventfd)
 {
 	struct amdgpu_eventfd_id *id;
 	struct amdgpu_eventfd_entry *e, *it;
 	struct eventfd_ctx *ctx;
+	struct amdgpu_usermode_queue *queue = NULL;
 	unsigned long flags;
 	bool dup = false;
 
-	if (!mgr || !event_id || eventfd < 0)
+	if (!mgr || eventfd < 0 || !amdgpu_eventfd_valid_type(event_type))
 		return -EINVAL;
 
-	/*
-	 * Enforce total bind limit without a separate manager lock.
-	 * For duplicate binds, we decrement back before returning success.
-	 */
+	if (amdgpu_eventfd_queue_scoped(event_type)) {
+		if (!userq_mgr || !queue_id)
+			return -EINVAL;
+
+		queue = amdgpu_userq_get(userq_mgr, queue_id);
+		if (!queue)
+			return -ENOENT;
+	} else if (queue_id) {
+		return -EINVAL;
+	}
+
 	if (atomic_inc_return(&mgr->bind_count) > AMDGPU_EVENTFD_MAX_BINDS) {
 		atomic_dec(&mgr->bind_count);
+		amdgpu_userq_put(queue);
 		return -ENOSPC;
 	}
 
 	ctx = eventfd_ctx_fdget(eventfd);
 	if (IS_ERR(ctx)) {
 		atomic_dec(&mgr->bind_count);
+		amdgpu_userq_put(queue);
 		return PTR_ERR(ctx);
 	}
 
-	id = amdgpu_eventfd_id_get_or_create(mgr, event_id);
+	id = amdgpu_eventfd_id_get_or_create(mgr, event_type);
 	if (!id) {
 		eventfd_ctx_put(ctx);
+		amdgpu_userq_put(queue);
 		atomic_dec(&mgr->bind_count);
 		return -ENOMEM;
 	}
@@ -238,7 +272,7 @@ int amdgpu_eventfd_bind(struct amdgpu_eventfd_mgr *mgr, u32 event_id, int eventf
 	/* check for duplicate binding */
 	xa_lock_irqsave(&mgr->ids, flags);
 	hlist_for_each_entry(it, &id->entries, hnode) {
-		if (it->ctx == ctx) {
+		if (it->ctx == ctx && it->queue == queue) {
 			dup = true;
 			break;
 		}
@@ -247,6 +281,7 @@ int amdgpu_eventfd_bind(struct amdgpu_eventfd_mgr *mgr, u32 event_id, int eventf
 
 	if (dup) {
 		eventfd_ctx_put(ctx);
+		amdgpu_userq_put(queue);
 		atomic_dec(&mgr->bind_count);
 		return 0;
 	}
@@ -255,10 +290,13 @@ int amdgpu_eventfd_bind(struct amdgpu_eventfd_mgr *mgr, u32 event_id, int eventf
 	e = kzalloc(sizeof(*e), GFP_KERNEL);
 	if (!e) {
 		eventfd_ctx_put(ctx);
+		amdgpu_userq_put(queue);
 		atomic_dec(&mgr->bind_count);
 		return -ENOMEM;
 	}
+
 	e->ctx = ctx;
+	e->queue = queue;
 
 	/*
 	 * Re-check duplicate under lock to close the race with another bind()
@@ -266,7 +304,7 @@ int amdgpu_eventfd_bind(struct amdgpu_eventfd_mgr *mgr, u32 event_id, int eventf
 	 */
 	xa_lock_irqsave(&mgr->ids, flags);
 	hlist_for_each_entry(it, &id->entries, hnode) {
-		if (it->ctx == ctx) {
+		if (it->ctx == ctx && it->queue == queue) {
 			dup = true;
 			break;
 		}
@@ -281,6 +319,7 @@ int amdgpu_eventfd_bind(struct amdgpu_eventfd_mgr *mgr, u32 event_id, int eventf
 
 	if (dup) {
 		eventfd_ctx_put(ctx);
+		amdgpu_userq_put(queue);
 		kfree(e);
 		atomic_dec(&mgr->bind_count);
 		return 0;
@@ -290,53 +329,70 @@ int amdgpu_eventfd_bind(struct amdgpu_eventfd_mgr *mgr, u32 event_id, int eventf
 }
 
 /**
- * amdgpu_eventfd_unbind - remove eventfd binding
+ * amdgpu_eventfd_unbind - remove EVENTFD binding
  * @mgr: eventfd manager
- * @event_id: event identifier
+ * @userq_mgr: user queue manager used to resolve queue_id
+ * @event_type: kernel-defined AMDGPU event type
+ * @queue_id: UAPI queue id for queue-scoped events, or 0 for GPU-scoped events
  * @eventfd: eventfd file descriptor
  *
- * Removes an existing binding between an event_id and an eventfd.
- *
  * Return:
  * 0 if removed, -ENOENT if binding does not exist.
  */
-int amdgpu_eventfd_unbind(struct amdgpu_eventfd_mgr *mgr, u32 event_id, int eventfd)
+int amdgpu_eventfd_unbind(struct amdgpu_eventfd_mgr *mgr,
+			  struct amdgpu_userq_mgr *userq_mgr,
+			  u32 event_type, u32 queue_id, int eventfd)
 {
 	struct amdgpu_eventfd_id *id;
 	struct amdgpu_eventfd_entry *e;
 	struct hlist_node *tmp;
 	struct eventfd_ctx *ctx;
+	struct amdgpu_usermode_queue *queue = NULL;
 	unsigned long flags;
 	bool removed = false;
 
-	if (!mgr || !event_id || eventfd < 0)
+	if (!mgr || eventfd < 0 || !amdgpu_eventfd_valid_type(event_type))
 		return -EINVAL;
 
+	if (amdgpu_eventfd_queue_scoped(event_type)) {
+		if (!userq_mgr || !queue_id)
+			return -EINVAL;
+
+		queue = amdgpu_userq_get(userq_mgr, queue_id);
+		if (!queue)
+			return -ENOENT;
+	} else if (queue_id) {
+		return -EINVAL;
+	}
+
 	ctx = eventfd_ctx_fdget(eventfd);
-	if (IS_ERR(ctx))
+	if (IS_ERR(ctx)) {
+		amdgpu_userq_put(queue);
 		return PTR_ERR(ctx);
+	}
 
 	xa_lock_irqsave(&mgr->ids, flags);
 
-	id = xa_load(&mgr->ids, event_id);
+	id = xa_load(&mgr->ids, event_type);
 	if (!id)
 		goto out_unlock;
 
 	hlist_for_each_entry_safe(e, tmp, &id->entries, hnode) {
-		if (e->ctx != ctx)
+		if (e->ctx != ctx || e->queue != queue)
 			continue;
 
 		hlist_del(&e->hnode);
 		id->n_entries--;
 		removed = true;
 
+		amdgpu_userq_put(e->queue);
 		eventfd_ctx_put(e->ctx);
 		kfree(e);
 
 		atomic_dec(&mgr->bind_count);
 
 		if (!id->n_entries) {
-			__xa_erase(&mgr->ids, event_id);
+			__xa_erase(&mgr->ids, event_type);
 			kfree(id);
 		}
 
@@ -346,27 +402,75 @@ int amdgpu_eventfd_unbind(struct amdgpu_eventfd_mgr *mgr, u32 event_id, int even
 out_unlock:
 	xa_unlock_irqrestore(&mgr->ids, flags);
 	eventfd_ctx_put(ctx);
+	amdgpu_userq_put(queue);
 
 	return removed ? 0 : -ENOENT;
 }
 
 /**
- * amdgpu_eventfd_signal - notify all eventfds bound to event_id
+ * amdgpu_eventfd_remove_queue - remove all EVENTFD bindings for a queue
  * @mgr: eventfd manager
- * @event_id: event identifier
+ * @queue: queue being destroyed/released
  *
- * This function is typically called from interrupt context.
+ * Remove all subscriptions that hold a reference to @queue.
+ * This is called when the queue id is released so EVENTFD can drop
+ * its queue references before the queue is finally destroyed.
+ */
+void amdgpu_eventfd_remove_queue(struct amdgpu_eventfd_mgr *mgr,
+				 struct amdgpu_usermode_queue *queue)
+{
+	struct amdgpu_eventfd_id *id;
+	struct amdgpu_eventfd_entry *e;
+	struct hlist_node *tmp;
+	unsigned long index;
+	unsigned long flags;
+
+	if (!mgr || !queue)
+		return;
+
+	xa_lock_irqsave(&mgr->ids, flags);
+
+	xa_for_each(&mgr->ids, index, id) {
+		hlist_for_each_entry_safe(e, tmp, &id->entries, hnode) {
+			if (e->queue != queue)
+				continue;
+
+			hlist_del(&e->hnode);
+			id->n_entries--;
+
+			eventfd_ctx_put(e->ctx);
+			amdgpu_userq_put(e->queue);
+			kfree(e);
+
+			atomic_dec(&mgr->bind_count);
+		}
+
+		if (!id->n_entries) {
+			__xa_erase(&mgr->ids, index);
+			kfree(id);
+		}
+	}
+
+	xa_unlock_irqrestore(&mgr->ids, flags);
+}
+
+/**
+ * amdgpu_eventfd_signal - notify all matching eventfd subscriptions
+ * @mgr: eventfd manager
+ * @event_type: kernel-defined AMDGPU event type
+ * @queue: queue pointer for queue-scoped events, or NULL for GPU-scoped events
  *
- * All eventfds registered for the given event_id will be signaled.
- * Userspace processes waiting on those eventfds will wake up.
+ * This can run from IRQ context. The queue pointer must refer to the actual
+ * queue object, not the reusable UAPI queue_id.
  */
-void amdgpu_eventfd_signal(struct amdgpu_eventfd_mgr *mgr, u32 event_id)
+void amdgpu_eventfd_signal(struct amdgpu_eventfd_mgr *mgr, u32 event_type,
+			   struct amdgpu_usermode_queue *queue)
 {
 	struct amdgpu_eventfd_id *id;
 	struct amdgpu_eventfd_entry *e;
 	unsigned long flags;
 
-	if (!mgr || !event_id)
+	if (!mgr || !amdgpu_eventfd_valid_type(event_type))
 		return;
 
 	/*
@@ -375,10 +479,12 @@ void amdgpu_eventfd_signal(struct amdgpu_eventfd_mgr *mgr, u32 event_id)
 	 */
 	xa_lock_irqsave(&mgr->ids, flags);
 
-	id = xa_load(&mgr->ids, event_id);
+	id = xa_load(&mgr->ids, event_type);
 	if (id) {
-		hlist_for_each_entry(e, &id->entries, hnode)
-			eventfd_signal(e->ctx);
+		hlist_for_each_entry(e, &id->entries, hnode) {
+			if (e->queue == queue)
+				eventfd_signal(e->ctx);
+		}
 	}
 
 	xa_unlock_irqrestore(&mgr->ids, flags);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.h
index 248afb1f2f14..9ea3283e92bd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.h
@@ -32,13 +32,17 @@
 #include <linux/xarray.h>
 #include <linux/atomic.h>
 
+struct amdgpu_userq_mgr;
+struct amdgpu_usermode_queue;
+
 struct amdgpu_eventfd_entry {
 	struct eventfd_ctx *ctx;
+	struct amdgpu_usermode_queue *queue;
 	struct hlist_node hnode;
 };
 
 struct amdgpu_eventfd_id {
-	u32 event_id;
+	u32 event_type;
 	struct hlist_head entries;
 	u32 n_entries;
 };
@@ -51,9 +55,16 @@ struct amdgpu_eventfd_mgr {
 void amdgpu_eventfd_mgr_init(struct amdgpu_eventfd_mgr *mgr);
 void amdgpu_eventfd_mgr_fini(struct amdgpu_eventfd_mgr *mgr);
 
-int amdgpu_eventfd_bind(struct amdgpu_eventfd_mgr *mgr, u32 event_id, int eventfd);
-int amdgpu_eventfd_unbind(struct amdgpu_eventfd_mgr *mgr, u32 event_id, int eventfd);
+int amdgpu_eventfd_bind(struct amdgpu_eventfd_mgr *mgr,
+			struct amdgpu_userq_mgr *userq_mgr,
+			u32 event_type, u32 queue_id, int eventfd);
+int amdgpu_eventfd_unbind(struct amdgpu_eventfd_mgr *mgr,
+			  struct amdgpu_userq_mgr *userq_mgr,
+			  u32 event_type, u32 queue_id, int eventfd);
+void amdgpu_eventfd_remove_queue(struct amdgpu_eventfd_mgr *mgr,
+				 struct amdgpu_usermode_queue *queue);
 
-void amdgpu_eventfd_signal(struct amdgpu_eventfd_mgr *mgr, u32 event_id);
+void amdgpu_eventfd_signal(struct amdgpu_eventfd_mgr *mgr, u32 event_type,
+			   struct amdgpu_usermode_queue *queue);
 
 #endif /* __AMDGPU_EVENTFD_H__ */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index f7c750094393..0db128def289 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -649,22 +649,32 @@ int amdgpu_eventfd_ioctl(struct drm_device *dev, void *data,
 	if (args->flags || !args->event_type || args->eventfd < 0)
 		return -EINVAL;
 
-	/*
-	 * Queue-scoped subscriptions are enabled by the later queue-reference
-	 * routing patch. Until then, keep queue_id zero.
-	 */
-	if (args->queue_id)
+	switch (args->event_type) {
+	case DRM_AMDGPU_EVENT_TYPE_USERQ_EOP:
+	case DRM_AMDGPU_EVENT_TYPE_QUEUE_RESET:
+	case DRM_AMDGPU_EVENT_TYPE_SCRATCH:
+		break;
+	case DRM_AMDGPU_EVENT_TYPE_MEMORY_EXCEPTION:
+		if (args->queue_id)
+			return -EINVAL;
+		break;
+	default:
 		return -EINVAL;
+	}
 
 	switch (args->op) {
 	case DRM_AMDGPU_EVENTFD_OP_BIND:
 		return amdgpu_eventfd_bind(&fpriv->eventfd_mgr,
+					   &fpriv->userq_mgr,
 					   args->event_type,
+					   args->queue_id,
 					   args->eventfd);
 	case DRM_AMDGPU_EVENTFD_OP_UNBIND:
 		return amdgpu_eventfd_unbind(&fpriv->eventfd_mgr,
-					     args->event_type,
-					     args->eventfd);
+						 &fpriv->userq_mgr,
+						 args->event_type,
+						 args->queue_id,
+						 args->eventfd);
 	default:
 		return -EINVAL;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 376813e9623f..45981adbd7d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -869,6 +869,8 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
 		if (!queue)
 			return -ENOENT;
 
+		amdgpu_eventfd_remove_queue(&fpriv->eventfd_mgr, queue);
+
 		amdgpu_userq_put(queue);
 		break;
 	}
@@ -1229,6 +1231,8 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
 		if (!queue)
 			break;
 
+		amdgpu_eventfd_remove_queue(amdgpu_userq_eventfd_mgr(userq_mgr), queue);
+
 		amdgpu_userq_put(queue);
 	}
 
-- 
2.34.1

