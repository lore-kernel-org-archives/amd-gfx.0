Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C6F6CD98CC
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jun 2026 14:34:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95A4710EF77;
	Thu, 11 Jun 2026 14:34:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CHOp+LOC";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012008.outbound.protection.outlook.com
 [40.93.195.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D9C310EF77
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jun 2026 14:34:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QPwk0CBZFDWn2wR1pQzkgiuHEWJfrf7gVhmxYOfZGUyLFJ1PJwUJEGmta0S2uOwSXtRHGFXR1c0iaditWSxFnZMG0L4s4Prfpv0FSFzazO2Z2MdrL0F6FxWiMhM7B9mfgFEVJGRBrXADgvviJt0Nn6skFvw8Hd/y1hhwCa04kHWyjSt+dPxjc0fpeIF14d9huUMg+8T68X2OFAGvOMkJ7y/FDhUlqqoCQ3YOqHYumkWKFNv9npGuP9GNYm6/RyBucMjZ8M523MNzLFJOeINWOb5lvq/SFxoVkzfhgbuYh/raMbBMiSgpRbrxo9/MhbJtmgi7iMA1qlNH+VLoyIWAsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fD+X4v4qdUpN7N25uW0qTWQAcwex3zlrnOb2L9RBfoA=;
 b=BKn4YR+GTg074Zbu9XYteAzWI7xOiFp5UE19k4guPNOowvW5zU9NHTCCcSlhh6dHVs2Skm+ZBKhJVGUUY4QUGGxlt+9iRE+UazIfL+0Pc4elAUGdgF+aQf14YVKtr3hyPhcUYPJ11B8ffbgJ4Kgu3AieMQgNDv1Hb4KM7QBTmbGrRM36GDg+pl95vDii1maLCpUy+IvW9OMr73gR2aCyMx1Rg+XaEoquWHA20iEd9sgfR1CfOo1tmtflgE5ZnEdm89GnRbXEYxmSdWMxqjXCiRt9CjUZEp5ICZKeTGCiKJJ1z/90Zvue2KXnS7gYq2fEIgo1j4z/0K1ldasfiSUm3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fD+X4v4qdUpN7N25uW0qTWQAcwex3zlrnOb2L9RBfoA=;
 b=CHOp+LOCJEvF6U+ZEGasukFHlIzxCXbVn8UKxH/gZUDw/ppBIfOOjVEOg9WGUd62aQqbnJ0Yn2MYK4GPttRCSW+WxVHVeCbuuTZwtn/p+K5m+ISYLMaCq/hNqNFSk78NGSsgA0QuLj/sT7/LsbtEWnmkjUxHVZ/OhVn8K1AxTIY=
Received: from SJ0PR03CA0268.namprd03.prod.outlook.com (2603:10b6:a03:3a0::33)
 by IA1PR12MB6259.namprd12.prod.outlook.com (2603:10b6:208:3e5::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.17; Thu, 11 Jun
 2026 14:34:15 +0000
Received: from SJ5PEPF000001EB.namprd05.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::4e) by SJ0PR03CA0268.outlook.office365.com
 (2603:10b6:a03:3a0::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.14 via Frontend Transport; Thu,
 11 Jun 2026 14:34:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001EB.mail.protection.outlook.com (10.167.242.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Thu, 11 Jun 2026 14:34:14 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Thu, 11 Jun 2026 09:34:00 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v12 5/5] drm/amdgpu: Use queue references for queue-aware
 EVENTFD subscriptions
Date: Thu, 11 Jun 2026 20:03:26 +0530
Message-ID: <20260611143326.2870571-6-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611143326.2870571-1-srinivasan.shanmugam@amd.com>
References: <20260611143326.2870571-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EB:EE_|IA1PR12MB6259:EE_
X-MS-Office365-Filtering-Correlation-Id: 4abbb972-e2f0-4536-d8ee-08dec7c682ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|23010399003|22082099003|18002099003|3023799007|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: PGOKzx4HB4XV9wJIyE3xjjxn/HcEuAsWqWVEUnluX7P74ugD+ijaZlyUDDq9dJdtWOgr4mfRBDPljuhmRxho6rkxSvlVlLBSYvqgOSwJLjlVhzFX/HTIfGe+KliSXiFpv16v3KbIGkSPwxswYERdd002PQgxR+JN2S2wKl1HFqpVjmeEZCNe0ma1/iuo27WEkl0vwS9+xmp7i/vonc4dBeena+xwZey+jyFRenWiSG91HbjInnMFFW00JVWz89h9CkYQzYsbHI4AyiAYpfBsh8Uhudw4OxxOeP3Zh+gjA7jlePqTeeLJ63+WE2VRFZYGjImR2XGaU8WmLDyTDey9eUnI5ZVv7XacRmGP617RW2sTU8JV7aATHmdX9b+s2jvtBXBwTXfAcWWUUuvvUVbKG4i1V3A2dF5Z0hnoNDaboCc5ORDE38JYY3fEfiaohQiX8IzYcTCI/WLBxEchO1+JjrPBPNJssTfJfAVLdb7uhHlINjdR7hwuh625zB7QaApp91VWqfgz75Fabz5ELaDJ2yGRqY3db9egiCKoMyNNPDyBk4Cf0s3nurvL61+MnBOMQENtZDSY56pONt90UcLTPtX0BIlMb3gdnLhQZWDtgAbk28L5xK31GX+rojBqrqCBTx+5Ur6g8ig5LtmiqdtuSUhPFI/MfJd56DtQBwU1RRfl//ZDAuyuI/HZdw1ZKZGR3fZ0Alm8qoO3b8tRDYlCyIba1e7VfzCRwUN5mx6nsnE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(23010399003)(22082099003)(18002099003)(3023799007)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MkMYhpAwXmzhiN6ahxBzdjQLJsfCjSVlG9Z+lkPMGprBoNrpSdyk/rTwqn/kaAXBIXKpohAs5aQWARA2f6W75Acgp9kJQHJ7IPf7LeXSU+Qg8kjPYNADHtkkOR/K/vLXXWBW9b9dIS+V1yotvUHinRipu94zCgtJ9V6u8uvcLEAPyd/4rl6FydBZj0r+5PJ5sfBBeaUD6CIAOHMoyaZixpQIuYdGTdWrX/nJvDVC7sFMwiVaMFH6T73/VW224SbAD422+6n2e4i7l90x7cXwq1J7Kn8+C85k3LsF5tGHd8g/8PJA51mbgowz3hbvCPpXvfEBOlk+6ZSnK5761FjBTmTuI/7wRCYQnCEke4KP2RPqKCQ3FxrX4ONzJBPtlV4m7kzXGolYfJaftr3pri0LFDtEikUSIn8B7LdX8ovury/IdBgk0aK7hkfXI6DTm/4J
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 14:34:14.6302 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4abbb972-e2f0-4536-d8ee-08dec7c682ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6259
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
corresponding amdgpu_usermode_queue object in the ioctl path before
calling into the EVENTFD helpers. Resolve the eventfd file descriptor to
an eventfd context in the same place.

EVENTFD subscriptions now store the actual queue pointer and eventfd
context instead of the reusable queue identifier and raw eventfd file
descriptor.

Use the existing user queue refcounting infrastructure to keep queues
alive while EVENTFD subscriptions exist. Release those references during
unbind, manager teardown, and explicit queue cleanup.

Introduce amdgpu_eventfd_remove_queue() to remove all subscriptions
associated with a queue when that queue is removed from the USERQ
manager. This prevents EVENTFD from retaining stale queue references
after queue removal.

Queue-scoped subscriptions are matched using the queue pointer, while
GPU-scoped subscriptions continue to operate without an associated
queue.

Also validate supported event types, distinguish queue-scoped events
from GPU-scoped events, and allow eventfd file descriptor 0 by rejecting
only negative values.

EVENTFD remains notification-only and does not carry event payloads.

v11: (per Christian)
- Convert queue_id to a queue pointer in the ioctl path before calling
  EVENTFD helpers.
- Convert the eventfd file descriptor to an eventfd context in the ioctl
  path before calling EVENTFD helpers.
- Store queue pointers in EVENTFD entries instead of reusable queue_id
  values.
- Add queue cleanup to remove EVENTFD subscriptions when queues are
  removed from the USERQ manager.

v12:
- Remove explicit NULL checks before amdgpu_userq_put() and rely on the
  _put helper to handle NULL queue pointers. (Christian)

Cc: Alex Deucher <alexander.deucher@amd.com>
Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.c   | 146 ++++++++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.h   |  17 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |  79 ++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     |   6 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h     |   3 -
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   |   1 +
 .../drm/amd/amdgpu/amdgpu_userq_internal.h    |  37 +++++
 7 files changed, 225 insertions(+), 64 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_internal.h

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.c
index c777d563f1b5..7e90d9aad84e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.c
@@ -28,12 +28,15 @@
  * Event metadata/details are expected to be consumed separately through the
  * corresponding wait/event path.
  *
+ * Queue-scoped subscriptions store a refcounted queue pointer, not the
+ * reusable UAPI queue_id.
  */
 
 #include <linux/slab.h>
 #include <linux/err.h>
 
 #include "amdgpu_eventfd.h"
+#include "amdgpu_userq_internal.h"
 
 #define AMDGPU_EVENTFD_MAX_BINDS 4096
 
@@ -132,7 +135,7 @@ amdgpu_eventfd_id_get_or_create(struct amdgpu_eventfd_mgr *mgr,
  *
  * The manager stores mappings:
  *
- *   event_id -> list of eventfds
+ *   event_type -> list of eventfds
  *
  * The xarray provides efficient lookup of event type containers.
  */
@@ -168,6 +171,7 @@ void amdgpu_eventfd_mgr_fini(struct amdgpu_eventfd_mgr *mgr)
 
 		hlist_for_each_entry_safe(e, tmp, &id->entries, hnode) {
 			hlist_del(&e->hnode);
+			amdgpu_userq_put(e->queue);
 			eventfd_ctx_put(e->ctx);
 			kfree(e);
 		}
@@ -180,55 +184,49 @@ void amdgpu_eventfd_mgr_fini(struct amdgpu_eventfd_mgr *mgr)
 }
 
 /**
- * amdgpu_eventfd_bind - bind an eventfd to an event type
+ * amdgpu_eventfd_bind - bind eventfd to an EVENTFD subscription
  * @mgr: eventfd manager
  * @event_type: kernel-defined AMDGPU event type
- * @eventfd: eventfd file descriptor
+ * @queue: queue pointer for queue-scoped events, or NULL for GPU-scoped events
+ * @ctx: eventfd context
  *
- * Register an eventfd subscription for the specified event type.
- * Duplicate subscriptions are treated as success.
+ * The caller resolves queue_id to @queue and eventfd to @ctx before
+ * calling this helper. This helper assumes ownership of the references
+ * passed in. On success, the EVENTFD entry retains those references.
+ * On duplicate binds or errors, the references are dropped before
+ * returning.
  *
  * Return:
  * 0 on success or a negative error code.
  */
 int amdgpu_eventfd_bind(struct amdgpu_eventfd_mgr *mgr,
-			u32 event_type, int eventfd)
+			u32 event_type,
+			struct amdgpu_usermode_queue *queue,
+			struct eventfd_ctx *ctx)
 {
 	struct amdgpu_eventfd_id *id;
 	struct amdgpu_eventfd_entry *e = NULL, *it;
-	struct eventfd_ctx *ctx;
 	unsigned long flags;
 	bool dup = false;
 	int r = 0; /* duplicate binds are treated as success */
 
-	if (!mgr || !event_type || eventfd < 0)
+	if (!mgr || !event_type || !ctx)
 		return -EINVAL;
 
-	/*
-	 * Enforce total bind limit without a separate manager lock.
-	 * For duplicate binds, we decrement back before returning success.
-	 */
 	if (atomic_inc_return(&mgr->bind_count) > AMDGPU_EVENTFD_MAX_BINDS) {
-		atomic_dec(&mgr->bind_count);
-		return -ENOSPC;
-	}
-
-	ctx = eventfd_ctx_fdget(eventfd);
-	if (IS_ERR(ctx)) {
-		atomic_dec(&mgr->bind_count);
-		return PTR_ERR(ctx);
+		r = -ENOSPC;
+		goto out_put_refs;
 	}
 
 	id = amdgpu_eventfd_id_get_or_create(mgr, event_type);
 	if (!id) {
 		r = -ENOMEM;
-		goto out_put_ctx;
+		goto out_dec_bind_count;
 	}
 
-	/* check for duplicate binding */
 	xa_lock_irqsave(&mgr->ids, flags);
 	hlist_for_each_entry(it, &id->entries, hnode) {
-		if (it->ctx == ctx) {
+		if (it->ctx == ctx && it->queue == queue) {
 			dup = true;
 			break;
 		}
@@ -236,24 +234,24 @@ int amdgpu_eventfd_bind(struct amdgpu_eventfd_mgr *mgr,
 	xa_unlock_irqrestore(&mgr->ids, flags);
 
 	if (dup)
-		goto out_put_ctx; /* duplicate bind: success */
+		goto out_dec_bind_count;
 
-	/* Allocate entry only after ctx/id prerequisites are satisfied. */
 	e = kzalloc(sizeof(*e), GFP_KERNEL);
 	if (!e) {
 		r = -ENOMEM;
-		goto out_put_ctx;
+		goto out_dec_bind_count;
 	}
 
 	e->ctx = ctx;
+	e->queue = queue;
 
 	/*
 	 * Re-check duplicate under lock to close the race with another bind()
-	 * for the same event_type and eventfd context.
+	 * for the same (event_type, queue, ctx).
 	 */
 	xa_lock_irqsave(&mgr->ids, flags);
 	hlist_for_each_entry(it, &id->entries, hnode) {
-		if (it->ctx == ctx) {
+		if (it->ctx == ctx && it->queue == queue) {
 			dup = true;
 			break;
 		}
@@ -262,6 +260,8 @@ int amdgpu_eventfd_bind(struct amdgpu_eventfd_mgr *mgr,
 	if (!dup) {
 		hlist_add_head(&e->hnode, &id->entries);
 		id->n_entries++;
+		queue = NULL;
+		ctx = NULL;
 		e = NULL; /* consumed */
 	}
 	xa_unlock_irqrestore(&mgr->ids, flags);
@@ -273,41 +273,43 @@ int amdgpu_eventfd_bind(struct amdgpu_eventfd_mgr *mgr,
 
 out_free_entry:
 	kfree(e);
-out_put_ctx:
-	eventfd_ctx_put(ctx);
+out_dec_bind_count:
 	atomic_dec(&mgr->bind_count);
+out_put_refs:
+	amdgpu_userq_put(queue);
+	eventfd_ctx_put(ctx);
 
 	return r;
 }
 
 /**
- * amdgpu_eventfd_unbind - remove an eventfd subscription
+ * amdgpu_eventfd_unbind - remove an EVENTFD subscription
  * @mgr: eventfd manager
  * @event_type: kernel-defined AMDGPU event type
- * @eventfd: eventfd file descriptor
+ * @queue: queue pointer for queue-scoped events, or NULL for GPU-scoped events
+ * @ctx: eventfd context
  *
- * Remove an existing subscription for the specified event type.
+ * The caller resolves queue_id to @queue and eventfd to @ctx before
+ * calling this helper. This helper assumes ownership of the references
+ * passed in and drops them before returning.
  *
  * Return:
  * 0 on success or a negative error code.
  */
 int amdgpu_eventfd_unbind(struct amdgpu_eventfd_mgr *mgr,
-			  u32 event_type, int eventfd)
+			  u32 event_type,
+			  struct amdgpu_usermode_queue *queue,
+			  struct eventfd_ctx *ctx)
 {
 	struct amdgpu_eventfd_id *id;
 	struct amdgpu_eventfd_entry *e;
 	struct hlist_node *tmp;
-	struct eventfd_ctx *ctx;
 	unsigned long flags;
 	bool removed = false;
 
-	if (!mgr || !event_type || eventfd < 0)
+	if (!mgr || !event_type || !ctx)
 		return -EINVAL;
 
-	ctx = eventfd_ctx_fdget(eventfd);
-	if (IS_ERR(ctx))
-		return PTR_ERR(ctx);
-
 	xa_lock_irqsave(&mgr->ids, flags);
 
 	id = xa_load(&mgr->ids, event_type);
@@ -315,13 +317,14 @@ int amdgpu_eventfd_unbind(struct amdgpu_eventfd_mgr *mgr,
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
 
@@ -338,21 +341,68 @@ int amdgpu_eventfd_unbind(struct amdgpu_eventfd_mgr *mgr,
 out_unlock:
 	xa_unlock_irqrestore(&mgr->ids, flags);
 	eventfd_ctx_put(ctx);
+	amdgpu_userq_put(queue);
 
 	return removed ? 0 : -ENOENT;
 }
 
 /**
- * amdgpu_eventfd_signal - signal all eventfds bound to an event type
+ * amdgpu_eventfd_remove_queue - remove all EVENTFD bindings for a queue
  * @mgr: eventfd manager
- * @event_type: kernel-defined AMDGPU event type
+ * @queue: queue being destroyed/released
  *
- * Notify all subscribers associated with the specified event type.
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
+			amdgpu_userq_put(e->queue);
+			eventfd_ctx_put(e->ctx);
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
+ * amdgpu_eventfd_signal - signal matching eventfd subscriptions
+ * @mgr: eventfd manager
+ * @event_type: kernel-defined AMDGPU event type
+ * @queue: queue pointer for queue-scoped events, or NULL for GPU-scoped events
  *
  * Signaling is notification-only and does not carry additional payload.
  */
 void amdgpu_eventfd_signal(struct amdgpu_eventfd_mgr *mgr,
-			   u32 event_type)
+			   u32 event_type, struct amdgpu_usermode_queue *queue)
 {
 	struct amdgpu_eventfd_id *id;
 	struct amdgpu_eventfd_entry *e;
@@ -369,8 +419,10 @@ void amdgpu_eventfd_signal(struct amdgpu_eventfd_mgr *mgr,
 
 	id = xa_load(&mgr->ids, event_type);
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
index e13b86240afc..8dbae07b0d84 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.h
@@ -32,8 +32,11 @@
 #include <linux/eventfd.h>
 #include <linux/xarray.h>
 
+struct amdgpu_usermode_queue;
+
 struct amdgpu_eventfd_entry {
 	struct eventfd_ctx *ctx;
+	struct amdgpu_usermode_queue *queue;
 	struct hlist_node hnode;
 };
 
@@ -52,11 +55,19 @@ void amdgpu_eventfd_mgr_init(struct amdgpu_eventfd_mgr *mgr);
 void amdgpu_eventfd_mgr_fini(struct amdgpu_eventfd_mgr *mgr);
 
 int amdgpu_eventfd_bind(struct amdgpu_eventfd_mgr *mgr,
-			u32 event_type, int eventfd);
+			u32 event_type,
+			struct amdgpu_usermode_queue *queue,
+			struct eventfd_ctx *ctx);
 int amdgpu_eventfd_unbind(struct amdgpu_eventfd_mgr *mgr,
-			  u32 event_type, int eventfd);
+			  u32 event_type,
+			  struct amdgpu_usermode_queue *queue,
+			  struct eventfd_ctx *ctx);
+
+void amdgpu_eventfd_remove_queue(struct amdgpu_eventfd_mgr *mgr,
+				 struct amdgpu_usermode_queue *queue);
 
 void amdgpu_eventfd_signal(struct amdgpu_eventfd_mgr *mgr,
-			   u32 event_type);
+			   u32 event_type,
+			   struct amdgpu_usermode_queue *queue);
 
 #endif /* __AMDGPU_EVENTFD_H__ */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 7cc54b7e3b81..3cb675a33945 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -46,6 +46,7 @@
 #include "amdgpu_reset.h"
 #include "amd_pcie.h"
 #include "amdgpu_userq.h"
+#include "amdgpu_userq_internal.h"
 
 void amdgpu_unregister_gpu_instance(struct amdgpu_device *adev)
 {
@@ -634,11 +635,71 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
 	return 0;
 }
 
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
+static int amdgpu_eventfd_get_refs(struct amdgpu_fpriv *fpriv,
+				   struct drm_amdgpu_eventfd *args,
+				   struct amdgpu_usermode_queue **queue,
+				   struct eventfd_ctx **ctx)
+{
+	*queue = NULL;
+	*ctx = NULL;
+
+	if (!amdgpu_eventfd_valid_type(args->event_type))
+		return -EINVAL;
+
+	if (amdgpu_eventfd_queue_scoped(args->event_type)) {
+		if (!args->queue_id)
+			return -EINVAL;
+
+		*queue = amdgpu_userq_get(&fpriv->userq_mgr, args->queue_id);
+		if (!*queue)
+			return -ENOENT;
+	} else if (args->queue_id) {
+		return -EINVAL;
+	}
+
+	*ctx = eventfd_ctx_fdget(args->eventfd);
+	if (IS_ERR(*ctx)) {
+		amdgpu_userq_put(*queue);
+		return PTR_ERR(*ctx);
+	}
+
+	return 0;
+}
+
 int amdgpu_eventfd_ioctl(struct drm_device *dev, void *data,
 			 struct drm_file *file_priv)
 {
 	struct amdgpu_fpriv *fpriv = file_priv->driver_priv;
 	struct drm_amdgpu_eventfd *args = data;
+	struct amdgpu_usermode_queue *queue;
+	struct eventfd_ctx *ctx;
+	int r;
 
 	if (!fpriv)
 		return -EINVAL;
@@ -649,24 +710,20 @@ int amdgpu_eventfd_ioctl(struct drm_device *dev, void *data,
 	if (args->flags || !args->event_type || args->eventfd < 0)
 		return -EINVAL;
 
-	/*
-	 * Queue-scoped subscriptions are enabled by the later
-	 * queue-reference routing patch. Until then, keep
-	 * queue_id zero.
-	 */
-	if (args->queue_id)
-		return -EINVAL;
+	r = amdgpu_eventfd_get_refs(fpriv, args, &queue, &ctx);
+	if (r)
+		return r;
 
 	switch (args->op) {
 	case DRM_AMDGPU_EVENTFD_OP_BIND:
 		return amdgpu_eventfd_bind(&fpriv->eventfd_mgr,
-					   args->event_type,
-					   args->eventfd);
+					   args->event_type, queue, ctx);
 	case DRM_AMDGPU_EVENTFD_OP_UNBIND:
 		return amdgpu_eventfd_unbind(&fpriv->eventfd_mgr,
-					     args->event_type,
-					     args->eventfd);
+					     args->event_type, queue, ctx);
 	default:
+		amdgpu_userq_put(queue);
+		eventfd_ctx_put(ctx);
 		return -EINVAL;
 	}
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 427c09c83d6b..b77385e35e4e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -33,6 +33,7 @@
 #include "amdgpu_userq.h"
 #include "amdgpu_hmm.h"
 #include "amdgpu_userq_fence.h"
+#include "amdgpu_userq_internal.h"
 
 /*
  * Get the per-file eventfd manager associated with this userq manager.
@@ -872,6 +873,8 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
 		if (!queue)
 			return -ENOENT;
 
+		amdgpu_eventfd_remove_queue(&fpriv->eventfd_mgr, queue);
+
 		amdgpu_userq_put(queue);
 		break;
 	}
@@ -1232,6 +1235,9 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
 		if (!queue)
 			break;
 
+		amdgpu_eventfd_remove_queue(amdgpu_userq_eventfd_mgr(userq_mgr),
+					    queue);
+
 		amdgpu_userq_put(queue);
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 8c4b55517a0a..e1a7d0dbc436 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -144,9 +144,6 @@ struct amdgpu_db_info {
 	struct amdgpu_userq_obj	*db_obj;
 };
 
-struct amdgpu_usermode_queue *amdgpu_userq_get(struct amdgpu_userq_mgr *uq_mgr, u32 qid);
-void amdgpu_userq_put(struct amdgpu_usermode_queue *queue);
-
 int amdgpu_userq_ioctl(struct drm_device *dev, void *data, struct drm_file *filp);
 
 int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct drm_file *file_priv,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 008330a0d852..8795156270f2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -31,6 +31,7 @@
 
 #include "amdgpu.h"
 #include "amdgpu_userq_fence.h"
+#include "amdgpu_userq_internal.h"
 
 #define AMDGPU_USERQ_MAX_HANDLES	(1U << 16)
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_internal.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_internal.h
new file mode 100644
index 000000000000..f41ec9167581
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_internal.h
@@ -0,0 +1,37 @@
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+
+#ifndef __AMDGPU_USERQ_INTERNAL_H__
+#define __AMDGPU_USERQ_INTERNAL_H__
+
+#include <linux/types.h>
+
+struct amdgpu_userq_mgr;
+struct amdgpu_usermode_queue;
+
+struct amdgpu_usermode_queue *
+amdgpu_userq_get(struct amdgpu_userq_mgr *userq_mgr, u32 queue_id);
+
+void amdgpu_userq_put(struct amdgpu_usermode_queue *queue);
+
+#endif /* __AMDGPU_USERQ_INTERNAL_H__ */
-- 
2.34.1

