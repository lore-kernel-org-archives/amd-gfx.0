Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B88ECF94CA5
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Apr 2026 17:59:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4888910E91C;
	Tue, 21 Apr 2026 17:59:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SV4aebYM";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011027.outbound.protection.outlook.com [52.101.57.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB1E310E914
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Apr 2026 17:59:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vC+eY8Jcrzmm4oqt+jpXEEBsVeyvkc09KXkFJudvQ2G20RtnQrfMZYI2/vxNayyc+E/S14C1kfQp5tdrvJUOYEBxgcg5oboTHUCvommVBwRANIlAITxC2GyinyKrda31XtCva/BGm8I3reXnHT9IWdNS/dd90otiCY8TeqFoNWYGx2YWFgFCTH+FE3Bd8lkTHtTfBxT9RZAXENQrTyEpLEM/xhVh/8Xgw/vOQJLr8y8vq2FJvYoBywhDoVcGWgV1ui+Me8eo0wIeHG26G3zA6KcRErGa/7Hq3cvCsnA1vmsYFqg3+7fiDP7ugX5VVebi80rvDnH0sosy9iuw/+FTGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K/B5E3lOzoE66tOAmTJik1nby1Ns17+tjuSc74+MmQ4=;
 b=EjFxGrK5nndRxb6vKgaGtRdFOfi4pWcdwbUMshHKxgqA0eVhwDLLi7ipYW45f3/4+lx7gcJfs9objdrGwwVLN5M+GGbZvIBWRHRcVYmCV+GSquIzu05rHw+p+ZOqj+61uz8t3iiuP7gJsfgv6gKD2+Sly9wNJZ1mavCN84SPTDtLoiAo2JEvmebYT0Jyhe/OLh6OfwheGqkBB2U0quAUlII9ptF51BuhkbN0nbWEYXy6lhk1s4FJlD6uNiGY/2dJAiNCqoeigNACr3TGK5/SyAvARLd8r+byQazRD92hHl2QHDkilkx00WEqRCtgKVNUGpuwbvt8mCTJ8G5n+nf3xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K/B5E3lOzoE66tOAmTJik1nby1Ns17+tjuSc74+MmQ4=;
 b=SV4aebYMeMtRZn4QuIqXw18igsNwXG//pTucC7JaNrsF54v/gmNoRhBe3JBf+TPcmPNoeEV77EhcYecyLyuMVA7kGBWHUDq0aLCLpaU1jeAvEENCHr+R8nAHCx1aRWZYo5qKkGZ7uofgotRiAcLG4Xl+K5iuhwK7P7rf3svRO24=
Received: from CH2PR18CA0003.namprd18.prod.outlook.com (2603:10b6:610:4f::13)
 by SN7PR12MB8172.namprd12.prod.outlook.com (2603:10b6:806:352::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 17:59:37 +0000
Received: from DS3PEPF0000C37F.namprd04.prod.outlook.com
 (2603:10b6:610:4f:cafe::93) by CH2PR18CA0003.outlook.office365.com
 (2603:10b6:610:4f::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Tue,
 21 Apr 2026 17:59:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C37F.mail.protection.outlook.com (10.167.23.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Tue, 21 Apr 2026 17:59:37 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 21 Apr 2026 12:59:34 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v8 06/11] drm/amdgpu: Make EVENTFD subscriptions queue-aware
Date: Tue, 21 Apr 2026 23:29:03 +0530
Message-ID: <20260421175908.2402019-7-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260421175908.2402019-1-srinivasan.shanmugam@amd.com>
References: <20260421175908.2402019-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37F:EE_|SN7PR12MB8172:EE_
X-MS-Office365-Filtering-Correlation-Id: 43a6992e-903b-4bf7-e456-08de9fcfc0b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: wmt+FMfxkeal3dXv5lf5WaHZI4NmtOLcjYA8MnBIDS9TTtN9yrFkwvT3k4/+vcuC5ycThfbTg0fScdFLrEk/WBvOqOpIZ/45GobmXwwPfFMSSe9KGqz66P8iUjA1PeQvGKDviGe+Kpir+fqXlDn5Lnvsx5jI0wqlJSOk0l1/fsK8EZlH4iU68JeILl6r/8zQi8Qbm2Mstu8g778HBajGnI1gxThZw51iAHIoOqDDZQZEYaOlvAtcTF9Ziq2sxUr9O4xIhgeFPixtW7++3oc5kH0l3yPOlFhNtoAhAiEqqgBQQbz3VUzsnjXrravlfrgcWLHkHKY+ZsQe6QJ0k4sHLFwW5O/q7hV3Bfu4wniaVTQJ96F3xPdR6Qn8LoRekh6sodPrCOkcogRFzKZoXIOAhE7W6c73AMmO5RE/lKKq4W/WgWknkSN1w114fd7KmjUeF/lYa7lRr2vXD9muFsGoCClG5DVvpJ3FiZ/Vu4i3xGlLAySMVCOTIblQvGaUggyKjiod08AucZCntHq9qI4YVmUAGZycsgN8gAwsH1+28IAboHoCh4IuU91SSebqaAZV8ojNtbPbGcXp7vSAL8c6goOvh4axB8FvMlYj9s8v3myBLalC0AVWp5Pst2kbhObLqB6pfgQmOqOhjALDsMFcaQDK5tMcw1+x1uvggUYDh+S1TsHoRcwWgicWNhfmyfKNUbplrVkAxKthVWr5qZDRUW4nX3RNa+/KbHvtn7OLGjQuwX9ASRQVWcN1JdksdvzdJfPj0VgdYy+nYbJMZ1oNww==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: UmKW/hjUD1L3VanrWMZNJz1LjDFKjiSvRT5z8C1eL8p7+gmc3X0FAVbwi0b2lBTIsxwrxbL5R1BtPPLpFrpgk7kMBxC8FtB2qyqg0hqXWWWEnEFLD8GDkxT3VDWVgs0mlRpRBCDIjO+cA0gxlXbLWROnQ2U7dATLn9zh4YT+Y0GkcRDnb9/hsrC7VmFvx+Cjqao7mxLVrQYed9jUVqv5AcU3pDBhyEF55F9ao8iOU2SjCLTDpsuyHJ1Z5141BagJFNKiobniWRdO+MUkAGITI4nlu2RotmuFLD87EeWBXcvHy97fx8WPX1irf0eK1mfBakeFrSBcNO0joOapoW2v/CrTmrom21W1YzDpTYuN9sHV97WmjFZlAjhl/senJl3hoK9d6ZcXVBvGWfEz3o2OQ4xhTzZtaQtesWlH7ZmRSM8pqOuFxTzAub2ZSQLTovtQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 17:59:37.2577 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43a6992e-903b-4bf7-e456-08de9fcfc0b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8172
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

The current EVENTFD manager matches subscriptions only by event
identifier.  That is enough for coarse notification, but it does not
support the queue-scoped routing needed by queue completion style
events.

Extend the subscription key from a single event identifier to the pair
(event_type, queue_id).

For device/GPU-scoped events, queue_id is 0.  For queue-scoped events,
queue_id selects the queue-specific subscription.

EVENTFD remains notification-only.

Also fix the queue-aware bind path to compute the packed subscription
key before lookup/insert, and allow fd 0 by rejecting only negative file
descriptors.

This change keeps the existing manager design and binding model intact,
while making queue_id meaningful for queue-scoped wakeups.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.c | 92 ++++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.h | 16 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c     | 20 +++--
 3 files changed, 86 insertions(+), 42 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.c
index 4cd80d8d1361..8c21b6c49fd7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.c
@@ -36,25 +36,39 @@
 
 #include <linux/slab.h>
 #include <linux/err.h>
+#include <drm/amdgpu_drm.h>
 
 #include "amdgpu_eventfd.h"
 
 #define AMDGPU_EVENTFD_MAX_BINDS 4096
 
+static bool amdgpu_eventfd_valid_type(u32 event_type)
+{
+	switch (event_type) {
+	case DRM_AMDGPU_EVENT_TYPE_USERQ_EOP:
+	case DRM_AMDGPU_EVENT_TYPE_QUEUE_RESET:
+	case DRM_AMDGPU_EVENT_TYPE_MEMORY_EXCEPTION:
+	case DRM_AMDGPU_EVENT_TYPE_SCRATCH:
+		return true;
+	default:
+		return false;
+	}
+}
+
 /**
  * amdgpu_eventfd_id_alloc - allocate an event id container
- * @event_id: userspace-defined event identifier
+ * @key: packed (event_type, queue_id) subscription key
  *
- * Each event_id represents a notification category. Multiple eventfds can
- * be bound to the same event_id.
+ * Each key represents one subscription category. Multiple eventfds can
+ * be bound to the same key.
  *
  * This function allocates the container which stores the list of eventfds
- * associated with that event_id.
+ * associated with that subscription key.
  *
  * Return:
  * Pointer to the newly allocated structure or NULL on failure.
  */
-static struct amdgpu_eventfd_id *amdgpu_eventfd_id_alloc(u32 event_id)
+static struct amdgpu_eventfd_id *amdgpu_eventfd_id_alloc(u64 key)
 {
 	struct amdgpu_eventfd_id *id;
 
@@ -62,7 +76,7 @@ static struct amdgpu_eventfd_id *amdgpu_eventfd_id_alloc(u32 event_id)
 	if (!id)
 		return NULL;
 
-	id->event_id = event_id;
+	id->key = key;
 	INIT_HLIST_HEAD(&id->entries);
 	id->n_entries = 0;
 	return id;
@@ -71,9 +85,9 @@ static struct amdgpu_eventfd_id *amdgpu_eventfd_id_alloc(u32 event_id)
 /**
  * amdgpu_eventfd_id_get_or_create - find or create an event_id entry
  * @mgr: eventfd manager
- * @event_id: event identifier
+ * @key: packed (event_type, queue_id) subscription key
  *
- * This helper returns the container associated with the given event_id.
+ * This helper returns the container associated with the given key.
  * If it does not exist, it will create one.
  *
  * The function is designed to be callable without holding any locks.
@@ -84,7 +98,7 @@ static struct amdgpu_eventfd_id *amdgpu_eventfd_id_alloc(u32 event_id)
  * Pointer to the event_id structure or NULL on failure.
  */
 static struct amdgpu_eventfd_id *
-amdgpu_eventfd_id_get_or_create(struct amdgpu_eventfd_mgr *mgr, u32 event_id)
+amdgpu_eventfd_id_get_or_create(struct amdgpu_eventfd_mgr *mgr, u64 key)
 {
 	struct amdgpu_eventfd_id *id;
 	struct amdgpu_eventfd_id *new_id;
@@ -92,19 +106,19 @@ amdgpu_eventfd_id_get_or_create(struct amdgpu_eventfd_mgr *mgr, u32 event_id)
 	int r;
 
 	xa_lock_irqsave(&mgr->ids, flags);
-	id = xa_load(&mgr->ids, event_id);
+	id = xa_load(&mgr->ids, key);
 	xa_unlock_irqrestore(&mgr->ids, flags);
 	if (id)
 		return id;
 
-	new_id = amdgpu_eventfd_id_alloc(event_id);
+	new_id = amdgpu_eventfd_id_alloc(key);
 	if (!new_id)
 		return NULL;
 
 	xa_lock_irqsave(&mgr->ids, flags);
 
 	/* Re-check after taking the lock in case another thread inserted it. */
-	id = xa_load(&mgr->ids, event_id);
+	id = xa_load(&mgr->ids, key);
 	if (id) {
 		xa_unlock_irqrestore(&mgr->ids, flags);
 		kfree(new_id);
@@ -115,9 +129,9 @@ amdgpu_eventfd_id_get_or_create(struct amdgpu_eventfd_mgr *mgr, u32 event_id)
 	 * xa_insert() returns -EBUSY if an entry already exists.
 	 * Since we are in irqsave context here, use GFP_ATOMIC.
 	 */
-	r = xa_insert(&mgr->ids, event_id, new_id, GFP_ATOMIC);
+	r = xa_insert(&mgr->ids, key, new_id, GFP_ATOMIC);
 	if (r == -EBUSY)
-		id = xa_load(&mgr->ids, event_id);
+		id = xa_load(&mgr->ids, key);
 
 	xa_unlock_irqrestore(&mgr->ids, flags);
 
@@ -190,13 +204,14 @@ void amdgpu_eventfd_mgr_fini(struct amdgpu_eventfd_mgr *mgr)
 }
 
 /**
- * amdgpu_eventfd_bind - bind eventfd to an event_id
+ * amdgpu_eventfd_bind - bind eventfd to an EVENTFD subscription
  * @mgr: eventfd manager
- * @event_id: userspace event identifier
+ * @event_type: kernel-defined event type
+ * @queue_id: queue identifier, or 0 for device/GPU-scoped events
  * @eventfd: eventfd file descriptor
  *
  * This function allows userspace to subscribe to notifications for a
- * specific event_id.
+ * specific (event_type, queue_id) pair.
  *
  * Multiple eventfds can be bound to the same event_id.
  *
@@ -206,17 +221,21 @@ void amdgpu_eventfd_mgr_fini(struct amdgpu_eventfd_mgr *mgr)
  * Return:
  * 0 on success, negative error code on failure.
  */
-int amdgpu_eventfd_bind(struct amdgpu_eventfd_mgr *mgr, u32 event_id, int eventfd)
+int amdgpu_eventfd_bind(struct amdgpu_eventfd_mgr *mgr, u32 event_type,
+			u32 queue_id, int eventfd)
 {
 	struct amdgpu_eventfd_id *id;
 	struct amdgpu_eventfd_entry *e, *it;
 	struct eventfd_ctx *ctx;
+	u64 key;
 	unsigned long flags;
 	bool dup = false;
 
-	if (!mgr || !event_id || eventfd < 0)
+	if (!mgr || !eventfd || eventfd < 0 || !amdgpu_eventfd_valid_type(event_type))
 		return -EINVAL;
 
+	key = amdgpu_eventfd_key(event_type, queue_id);
+
 	/*
 	 * Enforce total bind limit without a separate manager lock.
 	 * For duplicate binds, we decrement back before returning success.
@@ -232,7 +251,7 @@ int amdgpu_eventfd_bind(struct amdgpu_eventfd_mgr *mgr, u32 event_id, int eventf
 		return PTR_ERR(ctx);
 	}
 
-	id = amdgpu_eventfd_id_get_or_create(mgr, event_id);
+	id = amdgpu_eventfd_id_get_or_create(mgr, key);
 	if (!id) {
 		eventfd_ctx_put(ctx);
 		atomic_dec(&mgr->bind_count);
@@ -294,9 +313,10 @@ int amdgpu_eventfd_bind(struct amdgpu_eventfd_mgr *mgr, u32 event_id, int eventf
 }
 
 /**
- * amdgpu_eventfd_unbind - remove eventfd binding
+ * amdgpu_eventfd_unbind - remove EVENTFD binding
  * @mgr: eventfd manager
- * @event_id: event identifier
+ * @event_type: kernel-defined event type
+ * @queue_id: queue identifier, or 0 for device/GPU-scoped events
  * @eventfd: eventfd file descriptor
  *
  * Removes an existing binding between an event_id and an eventfd.
@@ -304,25 +324,29 @@ int amdgpu_eventfd_bind(struct amdgpu_eventfd_mgr *mgr, u32 event_id, int eventf
  * Return:
  * 0 if removed, -ENOENT if binding does not exist.
  */
-int amdgpu_eventfd_unbind(struct amdgpu_eventfd_mgr *mgr, u32 event_id, int eventfd)
+int amdgpu_eventfd_unbind(struct amdgpu_eventfd_mgr *mgr, u32 event_type,
+			  u32 queue_id, int eventfd)
 {
 	struct amdgpu_eventfd_id *id;
+	u64 key;
 	struct amdgpu_eventfd_entry *e;
 	struct hlist_node *tmp;
 	struct eventfd_ctx *ctx;
 	unsigned long flags;
 	bool removed = false;
 
-	if (!mgr || !event_id || eventfd < 0)
+	if (!mgr || eventfd < 0 || !amdgpu_eventfd_valid_type(event_type))
 		return -EINVAL;
 
+	key = amdgpu_eventfd_key(event_type, queue_id);
+
 	ctx = eventfd_ctx_fdget(eventfd);
 	if (IS_ERR(ctx))
 		return PTR_ERR(ctx);
 
 	xa_lock_irqsave(&mgr->ids, flags);
 
-	id = xa_load(&mgr->ids, event_id);
+	id = xa_load(&mgr->ids, key);
 	if (!id)
 		goto out_unlock;
 
@@ -338,7 +362,7 @@ int amdgpu_eventfd_unbind(struct amdgpu_eventfd_mgr *mgr, u32 event_id, int even
 			atomic_dec(&mgr->bind_count);
 
 			if (!id->n_entries) {
-				__xa_erase(&mgr->ids, event_id);
+				__xa_erase(&mgr->ids, key);
 				kfree(id);
 			}
 			break;
@@ -353,31 +377,37 @@ int amdgpu_eventfd_unbind(struct amdgpu_eventfd_mgr *mgr, u32 event_id, int even
 }
 
 /**
- * amdgpu_eventfd_signal - notify all eventfds bound to event_id
+ * amdgpu_eventfd_signal - notify all eventfds bound to subscription key
  * @mgr: eventfd manager
  * @event_id: event identifier
+ * @event_type: kernel-defined event type
+ * @queue_id: queue identifier, or 0 for device/GPU-scoped events
  *
  * This function is typically called from interrupt context.
  *
- * All eventfds registered for the given event_id will be signaled.
+ * All eventfds registered for the given subscription will be signaled.
  * Userspace processes waiting on those eventfds will wake up.
  */
-void amdgpu_eventfd_signal(struct amdgpu_eventfd_mgr *mgr, u32 event_id)
+void amdgpu_eventfd_signal(struct amdgpu_eventfd_mgr *mgr, u32 event_type,
+			   u32 queue_id)
 {
 	struct amdgpu_eventfd_id *id;
 	struct amdgpu_eventfd_entry *e;
+	u64 key;
 	unsigned long flags;
 
-	if (!mgr || !event_id)
+	if (!mgr || !amdgpu_eventfd_valid_type(event_type))
 		return;
 
+	key = amdgpu_eventfd_key(event_type, queue_id);
+
 	/*
 	 * IRQ-safe signaling path: keep xarray lock held while iterating and
 	 * signaling. eventfd_signal() is IRQ-safe.
 	 */
 	xa_lock_irqsave(&mgr->ids, flags);
 
-	id = xa_load(&mgr->ids, event_id);
+	id = xa_load(&mgr->ids, key);
 	if (id) {
 		hlist_for_each_entry(e, &id->entries, hnode)
 			eventfd_signal(e->ctx);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.h
index 248afb1f2f14..6e7eb513fbc5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.h
@@ -38,7 +38,7 @@ struct amdgpu_eventfd_entry {
 };
 
 struct amdgpu_eventfd_id {
-	u32 event_id;
+	u64 key;
 	struct hlist_head entries;
 	u32 n_entries;
 };
@@ -48,12 +48,20 @@ struct amdgpu_eventfd_mgr {
 	atomic_t bind_count;        /* total binds across all event_ids */
 };
 
+static inline u64 amdgpu_eventfd_key(u32 event_type, u32 queue_id)
+{
+	return ((u64)event_type << 32) | queue_id;
+}
+
 void amdgpu_eventfd_mgr_init(struct amdgpu_eventfd_mgr *mgr);
 void amdgpu_eventfd_mgr_fini(struct amdgpu_eventfd_mgr *mgr);
 
-int amdgpu_eventfd_bind(struct amdgpu_eventfd_mgr *mgr, u32 event_id, int eventfd);
-int amdgpu_eventfd_unbind(struct amdgpu_eventfd_mgr *mgr, u32 event_id, int eventfd);
+int amdgpu_eventfd_bind(struct amdgpu_eventfd_mgr *mgr, u32 event_type,
+			u32 queue_id, int eventfd);
+int amdgpu_eventfd_unbind(struct amdgpu_eventfd_mgr *mgr, u32 event_type,
+			  u32 queue_id, int eventfd);
 
-void amdgpu_eventfd_signal(struct amdgpu_eventfd_mgr *mgr, u32 event_id);
+void amdgpu_eventfd_signal(struct amdgpu_eventfd_mgr *mgr, u32 event_type,
+			   u32 queue_id);
 
 #endif /* __AMDGPU_EVENTFD_H__ */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index bf17619a32c1..5e2abf32420f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -646,21 +646,27 @@ int amdgpu_eventfd_ioctl(struct drm_device *dev, void *data,
 	if (args->flags || !args->event_type || args->eventfd < 0)
 		return -EINVAL;
 
-	/*
-	 * queue_id is reserved for future queue-specific subscriptions.
-	 * Keep it zero for now.
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
-					   args->event_type,
+					   args->event_type, args->queue_id,
 					   args->eventfd);
 	case DRM_AMDGPU_EVENTFD_OP_UNBIND:
 		return amdgpu_eventfd_unbind(&fpriv->eventfd_mgr,
-					     args->event_type,
+					     args->event_type, args->queue_id,
 					     args->eventfd);
 	default:
 		return -EINVAL;
-- 
2.34.1

