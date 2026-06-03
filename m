Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6808FCD6E6E
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jun 2026 16:34:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59F6B1120C8;
	Wed,  3 Jun 2026 16:34:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UuydhD+u";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010047.outbound.protection.outlook.com [52.101.46.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D6B61120C7
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jun 2026 16:34:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fiy1MOf9LZzxVbisQuOyROOLIeEyAgqoeLYXSFZbxE0dpjE6hwambBGV5isbIoXpeyfGdlZnGSAKNm0JmNii0cGFNyCe2ypcs4XSgsI2e/4tSCtUHl31A6SEEktEfylCY3kRDp6uubKHYhcKb3DYJi0zzuDP8ITpCKxy5N/FFelmS+8mRAp9wxYGwEYBqVnwxwr0cq9rW4n1BjSvdmQ+gtTO2oPs9rLwfJmd+VVmPbqhv1wBMOxbe4YArClOrisV5PaoP+Wr2r7Rd0bdObTUTSr9LPNKmb4dAlJ+ZToBSTNwWNa4zZUh42bXe6qpTk8ubg5J518QKB9Tbc0Lg7VaLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kP6U67UoVIFbSN7K7qMScQjfbFQ7gI2H0ktAs+n43Qs=;
 b=uyODtsUuzEJ7c4Whx24PgNVYJET3XMHbJkAFnktMn3wALQa61nltHcv1fXRqvD/tY3FPlEjEOE8kou6RzUDhKHabEOBp7jrWHa6wwbOrim+PeCGnN41Wb8jc9oxcvriaqbcsexFhkNVEex6nh19T1b6fKZmKln5707bLu63KM8sX7uJGy3rgWz22uy7CKN5EjgvmHYspiiDsXpvgfIemSaJVDBFJNsx1LigZ3fndbgPNIl24ibf5wn7GTmAspXk7V5W4NbVOLSFyz8sDvo61k3wy1EyMY/D0fADSugBYK5CDW2kEWLjkbZ+6rhf1nONx94rswDmcut+j7kqITraXzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kP6U67UoVIFbSN7K7qMScQjfbFQ7gI2H0ktAs+n43Qs=;
 b=UuydhD+ucV8M/rgLcNSVuSBNJaxK/AwML5JLNKjG6NrTpt2ytAyYCpXFqrk8jg0x6y2NNxuiLkzEX54MB9UScRhdLjOrC/1fgohUcCuhPQn6YI58Sy+wCs0H1ag8gBSObYnGkjbWVPzKIFpi0xTyfFDzyjPDBO1lBPYD75si7tc=
Received: from BN9PR03CA0319.namprd03.prod.outlook.com (2603:10b6:408:112::24)
 by MW4PR12MB6923.namprd12.prod.outlook.com (2603:10b6:303:208::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 16:34:18 +0000
Received: from BL02EPF0001A102.namprd05.prod.outlook.com
 (2603:10b6:408:112:cafe::a4) by BN9PR03CA0319.outlook.office365.com
 (2603:10b6:408:112::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Wed, 3
 Jun 2026 16:34:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A102.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Wed, 3 Jun 2026 16:34:18 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Wed, 3 Jun 2026 11:34:17 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v9 06/11] drm/amdgpu: Make EVENTFD subscriptions queue-aware
Date: Wed, 3 Jun 2026 22:03:45 +0530
Message-ID: <20260603163350.2678309-7-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260603163350.2678309-1-srinivasan.shanmugam@amd.com>
References: <20260603163350.2678309-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A102:EE_|MW4PR12MB6923:EE_
X-MS-Office365-Filtering-Correlation-Id: caa8e13c-f71a-4e84-f77e-08dec18df583
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|56012099006|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: b3auMBV/N+jw9fk87xqkJJbb2GvaNiS0ORVs2Agat8ezy2O1+guSOch4EUjPNiooIakFmj7nLz806CBxquQb+emTFkgxiPjYWpEoEi5eOOzHkdquN3+T3dnlurkM5I7vXyUKrhDhlxX840SXZXDEhqgSUsWJRUzcvHI/Wzg5n4NA6nrOCx5PJeROtaMk9E0g19/m48Jf71vwVZEKdCmHKoeRN08m6zCK+dxiHmecMbhk/JWcQaEVw8S/CE8rYGMcOsgRCXLpTh34dEaPb7Feci8GAiJV47XNHfpUyZ133NnvjK8drsdX5hpLyN3xc5ov+hYM4SIx+USmsY6HRB9y0ZeN4IKVQHO7gDAhkwPDa2SW2cmzpKtfPRhkKd5Fg8ukF/U/H52+ugP21N5KHsLc4X2lm51A4YKF8+9ZwuWmqqVJxUg3biNDmKXjwpmdonUJcG70eRiZT00vpb5W4LgT22Hq9nqtxzLFo6uvB+ech/wv+TFgl7Ar/AO9fYbROyLNGBt98NCmtTE7YqHX51VkCPGK4CrD1dBK6f0UlRWUw1jNhzgwhtgOb4Yy/sR6qUCwf6v33FpxYtXHCfUbhhBBLfF3oFyOnIZ9YxfWM1oV2MP1iUKH1gp9PJMgj4XkXkhPsKydHwM29wRPw8mk9ogaOwZpxn9YNsoMRCRiJr8FmrHy2BO8IXVu2Icz822G42daqigASZo8C97FVUkKr/Gr4i8CElEEwAMK2/PDGqlVqYA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(56012099006)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: QTEYDV8byLHWUgUPnfUL/h1tfOsDMJXf2Ln0pzThxAD2KY7fhPztYATNe7b3i/tUyI17caCvpxNou0gtwrSFP1LLORwWn/9UgF8WWOKn71dVhpZbAYfiFhk9EADa9r796DjufDVueaJJ6DCU5MKoP/W/kQi8Eo9535RFkzTUlhwrhyGQGDMs8K/WuFsBexfGg6MAW2Uwv8/67zL6KocITlRoY1ek8vdSi3sFdXvhEV5XtHvDSN+ujSHx+LBuyZUHYbTS8wRnaeQEsqKnj0MEMj3lXG3GSEEK9XD06LQbfIz1bXMS44tjIr9yZbXkvkayvD2jTNdA1CuJekQm/0ly38PmjpDi9loVPPzA5ajypiMlqK4ZZY2yuTJcADXIWuh66pox2yVWAGuX4P7b9mQ9vy5ZdBJ7EbuZRdqkarmVhAm9Kcu3/kGCCS+RTnK7erEb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 16:34:18.6440 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: caa8e13c-f71a-4e84-f77e-08dec18df583
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A102.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6923
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
index 0b0c9268aedc..fefc85ca916e 100644
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
index 75fc3a74db28..22dfd22210c4 100644
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

