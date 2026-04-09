Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4DEFEA3C4A
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Apr 2026 10:41:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C83610E796;
	Thu,  9 Apr 2026 10:41:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="un3uet+Z";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012071.outbound.protection.outlook.com [52.101.53.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F33A310E797
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Apr 2026 10:41:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jX3IszVF5M03ahZQAIurgVG+5XNatTl6HWs7TyUulCYgn1gZzZnmWe4IgZwMZBxVVkgbVacaL/8nTY/ZSFclFMwRcvM2/unmUzpw8jli5y2+Drpjdk6WHznZDrwbbusP/t5Z0NW36AbO0DfDe4GZxZsQUqBcTamnvOLrgm7uS8zJlamu7FlNkJOpEFY+UALYrI+U0M4h20HrajJKGpUkbDyQrgB6NtkS3oYGsqP1/xaPNdqHvhELQ4paOwk6dkGKXX9UNo29nBLUIYebA6n16Pnr5ii1gC86sOh2XKPzAopcCiyzfTHzNsWbD0pm/tiF49C+zjrjM1pLUY57ATr/Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4XMpgKMFq6ZlfdrdlDA1gEXQHRvLYRuTYJGJuZKJ5c4=;
 b=ftoYt5cTw5D9qoG1iChd4eMOoVkSzJBKRNHctfyW2af2+H4rlrEQ8auM2kCslRMuTYirBmPJ8VIlTQwEJvK6+9CYLRJBTFAajI4nYwfbvMYjGAm4vOxWfH0oxy35dwTvhXAj2ZiHZHC+OzeQEx6htOyOVIYMWTzeKpH0Mw2iKPozapSRv72jwsxNmQxua0RpBIyjduPo1Y/b0lEmjIg4waOlv3BHM5S+OX468PIcBhNZBo63HU5o3t/SNxgfhLVfKKOovhsSVO7Q+pN7TlVo6lFt44jmgXpHc7Hpzn8M8b9ntoOuUeRJ9MtKui+J5jwxpXeqxkfG9hj69JbxmQvLYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4XMpgKMFq6ZlfdrdlDA1gEXQHRvLYRuTYJGJuZKJ5c4=;
 b=un3uet+Zz+3XWrbB65fUPmo7uG72N27lyT0dE+5GFNE5ODf3KznQyardZVY+zyWkHgghhVOZAZXJk3/aE0E4WAXtP0a6sCJOM6fwq0Uk3/1/YV2GDEsjNapfAK0gObTk/2Ajsd//AYlwTTXR7daQw9I9T2xuo5b3lzAQ21xFMvk=
Received: from BYAPR02CA0065.namprd02.prod.outlook.com (2603:10b6:a03:54::42)
 by SA0PR12MB4384.namprd12.prod.outlook.com (2603:10b6:806:9f::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 9 Apr
 2026 10:41:29 +0000
Received: from SJ1PEPF00001CE9.namprd03.prod.outlook.com
 (2603:10b6:a03:54:cafe::c9) by BYAPR02CA0065.outlook.office365.com
 (2603:10b6:a03:54::42) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.41 via Frontend Transport; Thu,
 9 Apr 2026 10:41:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE9.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 9 Apr 2026 10:41:29 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 9 Apr 2026 05:41:27 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v6 6/7] drm/amdgpu: Make EVENTFD subscriptions queue-aware
Date: Thu, 9 Apr 2026 16:10:56 +0530
Message-ID: <20260409104057.2284155-7-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260409104057.2284155-1-srinivasan.shanmugam@amd.com>
References: <20260409104057.2284155-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE9:EE_|SA0PR12MB4384:EE_
X-MS-Office365-Filtering-Correlation-Id: ff431fef-8229-466f-52af-08de96248efc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: MBvXEwfSWJl8OOLZjZIPLitLrUJApeEjc8BLuYKjj0vHtr01Pn7m7pJjSG+ET6fWpAqQq8CaA8Cuqa1YWubIfBxrnmXICOh9zs11+u+jFDp3ra9Y70cLmdXqOepyaSGPq0k823vDbgK8gqRDaOsvyoYxKogfKRBdl0Y2CxrcP1t069sRFZ3aHB7dZWM4ZjxBwSU7o+WKhc4jW2SbLn5wUPX3yWPvDZbTgG1lxQ2wR19BuaxaNzWoAjP2ZDubWYGd56ii7IHK+oD5YE++fmq0TvqAh3hhZAwj8RhlJkVrpodnev7IYIMcmGd4EseNlJAZyQ/X+LkjDA5BCRmBRFFZMT35O3bO3atPtPwn6t62k14q4CnYwqzF2SUv1G64s/N34b83TDTrS88QnWPIjutOOkwxR+90L6Aux6c/ZqJqSpO5oDOk+2NspW4sZJEYOeg1I9Ox5ts4Srrg188cceLrbMbSz4zJX2N0pbxeyAQ6ZmzV5obwSPzXVD6Ao1wpWTEGB0DaKkWfpjpoHplY0WO+NVhLIOD061tyGVOetn/lcg58ROPKBac2Dz0GU35DOiJOMyXWfsnDP42jKrFTbITC0Z7IhlL6YSoDjEaXiLaQ0MeDr9y2Jfnt2kvWKic0Msw7LoceFlkK9OUBC6HkpxZ1lpyb5/dcb5SW+4Spb3fhT8Wk6MS0Q5x09ObQah+jigRsEZW7Y1t/oGk0Qul8F1ZlSj5PX8rvmqsyrlHXZEMCfSf+BLXT/sDyc60jonZUVyv5F8oh4WiIoMEVLkYBbsz+sg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 78lU8wS/yV8zbHttLf2ABWEJBvESwjyCLcpzJfcmP3mbujVx/dsAnevH3YF3k1T2at2/38R+3chd8ejDLaOaSdYLaQK/jAM9cNmR2yUS/Dpzv7dizOo4f1F0cqLBnfB6ZifiSOFvor97AHiPcsKIia9Owxa90xbWbYE0MrzFAnrH7sdoYUxV57gHGE2DdMokwqWnc+A+pwLmXypqe/C3dKC9oLti/Ew0YVy+GOAIIBBg1j/5pJo+Cm640bBY1dYNh4VwufCRqn4PlhqJnDvTE0d0oPhCbrs8h3OrEfdwj4eRiSMVwYobfKuxGGa8XJriwE23/aNtHO4yyHiA9tyetLZRUGJuSf1ij5cdIMwFvau70HQRtct3PrLcBFVbwBV7+IRwiEtHj7Ldr+l13BTMHh6IzzkpBpdx0SUjsFnWWnPfKLPcJaO3Ivdpvrh2SrdX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 10:41:29.3739 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff431fef-8229-466f-52af-08de96248efc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4384
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

This change keeps the existing manager design and binding model intact,
while making queue_id meaningful for queue-scoped wakeups.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.c | 90 ++++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.h | 16 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c     | 20 +++--
 3 files changed, 84 insertions(+), 42 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.c
index 4cd80d8d1361..e795affe95a6 100644
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
@@ -206,15 +221,17 @@ void amdgpu_eventfd_mgr_fini(struct amdgpu_eventfd_mgr *mgr)
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
 
 	/*
@@ -232,7 +249,7 @@ int amdgpu_eventfd_bind(struct amdgpu_eventfd_mgr *mgr, u32 event_id, int eventf
 		return PTR_ERR(ctx);
 	}
 
-	id = amdgpu_eventfd_id_get_or_create(mgr, event_id);
+	id = amdgpu_eventfd_id_get_or_create(mgr, key);
 	if (!id) {
 		eventfd_ctx_put(ctx);
 		atomic_dec(&mgr->bind_count);
@@ -294,9 +311,10 @@ int amdgpu_eventfd_bind(struct amdgpu_eventfd_mgr *mgr, u32 event_id, int eventf
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
@@ -304,25 +322,29 @@ int amdgpu_eventfd_bind(struct amdgpu_eventfd_mgr *mgr, u32 event_id, int eventf
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
 
@@ -338,7 +360,7 @@ int amdgpu_eventfd_unbind(struct amdgpu_eventfd_mgr *mgr, u32 event_id, int even
 			atomic_dec(&mgr->bind_count);
 
 			if (!id->n_entries) {
-				__xa_erase(&mgr->ids, event_id);
+				__xa_erase(&mgr->ids, key);
 				kfree(id);
 			}
 			break;
@@ -353,31 +375,37 @@ int amdgpu_eventfd_unbind(struct amdgpu_eventfd_mgr *mgr, u32 event_id, int even
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

