Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D598CD98CF
	for <amd-gfx@archiver.kernel.org>; Sat, 13 Jun 2026 01:15:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08CC010E915;
	Sat, 13 Jun 2026 01:15:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XpUawxyN";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011065.outbound.protection.outlook.com [52.101.52.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCCD710E915
 for <amd-gfx@lists.freedesktop.org>; Sat, 13 Jun 2026 01:15:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iSpmw+3YDCqDTweckrIlaHWFEG7+D3fIhXddGKw+BCoOKdEKIe0dzqa1NSh/pjFLJLz/fI7wlYYvo2F+IbDQgag+TAaCPX7ASalHt+ohnx5XA42brvEddMKqewuhIxoyXe/e517incPjaLuJbn+M9ej+v3qwkTEWUlG3drDvm9qFhRON2ANlj4GFEm6UU9289LD9gvSVD9Q8MPXJw9rqDORISjwpUZCeVE2wYSpqNvHlrKkPxVckr9UEK0VHX8MeHg7ST2dpeC7nf1dMH4mmi5TqWLtk+cjmsoIOFmZrdMfw4mvcMeKK0do1hKtDSCYEoOZkr7BehbdD3j7mPyJiFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m3cexWUlnbQ0TiuyxZKEYOkY6BEoAJkCOxvI2JkV6rM=;
 b=EMlUuoPIgprQpUPfQizQp3onNBj0cudbyKBvzE2PnFXH5Y6epGsVLUf2b8RXI4aaMtojysWy9p7/KkizW99pEtHDq+PnwyRaLQW8zfbNEa0UfV77Iq0LSEvwmZOEbSmfcjwmbx8UOid3NUFUNwRpN7co0IRzeJiFFVucFRXfvIei9xlc6SqF8wl96mOhhbpm2zEUfcqE+g6RXBuiVgMs83hYKOORWkJFSjlOqEEP499dvi1qF+ePJl1TyJzuhLyithsLXZFGEOLQ7kVJy1X3lRjnLHcdM5H8pi+uTNHSwbeoL9OEPASB1iJfaO19ADsMj1q5dXR/1LHrFdezjnXpjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m3cexWUlnbQ0TiuyxZKEYOkY6BEoAJkCOxvI2JkV6rM=;
 b=XpUawxyNspn5c9m+0UebPoUuJ4Pq5DTxTJUGWXkTYI8NbJ579J10ZUZxOoIVg+AUlmVv1OJgXfU6CDDpBR8OVE34jKe8ni+6dJi8by8Nian23UAYiQzH2ZOCqIVO4gsXMSsLTbWItjAyrkGdzwZd0IPtBRWUfwkPskUaKX9eGJk=
Received: from PH7PR02CA0009.namprd02.prod.outlook.com (2603:10b6:510:33d::11)
 by CH3PR12MB8510.namprd12.prod.outlook.com (2603:10b6:610:15b::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.15; Sat, 13 Jun
 2026 01:15:32 +0000
Received: from SN1PEPF0002BA4C.namprd03.prod.outlook.com
 (2603:10b6:510:33d:cafe::24) by PH7PR02CA0009.outlook.office365.com
 (2603:10b6:510:33d::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.14 via Frontend Transport; Sat,
 13 Jun 2026 01:15:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA4C.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Sat, 13 Jun 2026 01:15:31 +0000
Received: from 0yonsun-linux-dev.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Fri, 12 Jun 2026 20:15:31 -0500
From: Yongqiang Sun <Yongqiang.Sun@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Yongqiang Sun <Yongqiang.Sun@amd.com>
Subject: [PATCH] drm/amdkfd: drop struct kfd_signal_page wrapper
Date: Fri, 12 Jun 2026 21:15:19 -0400
Message-ID: <20260613011519.659866-1-Yongqiang.Sun@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4C:EE_|CH3PR12MB8510:EE_
X-MS-Office365-Filtering-Correlation-Id: 23c9bc2b-067c-40a9-1908-08dec8e9439b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|36860700016|82310400026|3023799007|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 1TJRGYQ50G/9PoXW2KP1pz/bkhQMVjeX1SgG96wtYtI0FW6NwIsOCHO9jjuOq1b6SfzCn+otU3XlUPlCTlB3XX9DBe7NWBxBwc1LyJRhcJQ4nEoySNYmkywFDMjiPPgSvgZHTVq78i8sy2XTZw8XiTn7w1tbGSFDsIP92jKqYlPEslx7kF+CPL2eyuDEfBmITb5QJG6c/LEuQyWDqJ/fvaLXwY6ApEEIoavLspSEIDw8AXXtSC9fSDNN7+oKmV2+1C+digQENoyEL507zXCSG650yIqIMf0r+vtNZzZTl9Yeyz7pytMAhVEurZiWP8lgE/WRINr6FBb8q1Xd2wE8P9i+GhguU/yA4i8v4+IuzVNgQLrUSllRyM++XxYQymJsKPdNXwvFKFIRjpP6kAmWcDqQmTdPRFhkWt/QqNKxSMX3iCTF4xok26sXsXZwJwK6YJWydDYQR8OeZArtLmpIH1WiGvMV208Csf+wHJ6lxT4gN5zGMH/IiJhUGtgSC8T9Iox/V0dYEHW7TQq1kdJwwf4rE6MPgf6/e5uISxsuJ6T9oak7fNNyhE41pk8rMAzRR6PzukulyqBACXjNRcmf4rlQBfm7r4DLkm+UR+ZAJeolsRal8yHvB5hCOxdevaalZV7nB9MLHnYFFFxkcQd9PcYDbFIbOhSU7DtJFnG2F8My9GyEZp/WeB6m0/OO10BZNHomN3vM5ltpbw4adKB2+bP2ssgj0StrzIDwpt9hzEU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(36860700016)(82310400026)(3023799007)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wHY1V3qRFvSKjlY3kCcfEnLM40Wf6k+7MYpE9Pqqp+slOs1HM/aTNEhEkITxNY3x+IbXjJIDmUg5zlp2x30XeKDfxfiGjAjU2xkVBfDaQpuzeFBnwxhY7xaTPO74uPxvuh2aW8fWH8il/0v3UIB+jLtvzfjv+XiuO6OcYOSdpWxuXJ7KSyQjLlSe2lbz1qplYCAdBzN840Pnqi3GISdf7X7ZbcYUC1uqJv8cl4YkFlphKvmGDvyXn/2gOn8e07S9FqUmhgq8jkUVrMZlynog5rAt5TXSExWJtelFiWAMETTMXyWwb52gfpCxU+c3/nZtLWGVu5S98SnJ3Jxn/RDWr0p5swT4Os4EVJv+ivhgo8o/3IlKLlUbcnNIMmFPGfq/4so9lluVyEzVU/W8bME6/KMvhyjCbcEt7lxhGdDCphpfp1C6s1T9/xZjSya/BeaH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2026 01:15:31.9716 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23c9bc2b-067c-40a9-1908-08dec8e9439b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8510
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

struct kfd_signal_page now only wraps a single uint64_t *kernel_address
pointer. Drop the wrapper struct (and the page_slots() helper) and store
the signal page pointer directly in kfd_process::signal_page.

Since the signal page is the GTT BO mapping provided by user mode and is
not owned by the events code, no separate allocation/free is needed for
it, so shutdown_signal_page() goes away as well.

No functional change intended.

Signed-off-by: Yongqiang Sun <Yongqiang.Sun@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_events.c | 48 ++++---------------------
 drivers/gpu/drm/amd/amdkfd/kfd_events.h |  1 -
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h   |  9 ++++-
 3 files changed, 14 insertions(+), 44 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
index 85e4ad10d619..3ffe9a52f3e1 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
@@ -46,22 +46,6 @@ struct kfd_event_waiter {
 	bool event_age_enabled;  /* set to true when last_event_age is non-zero */
 };
 
-/*
- * Each signal event needs a 64-bit signal slot where the signaler will write
- * a 1 before sending an interrupt. (This is needed because some interrupts
- * do not contain enough spare data bits to identify an event.)
- * We get whole pages and map them to the process VA.
- * Individual signal events use their event_id as slot index.
- */
-struct kfd_signal_page {
-	uint64_t *kernel_address;
-};
-
-static uint64_t *page_slots(struct kfd_signal_page *page)
-{
-	return page->kernel_address;
-}
-
 static int allocate_event_notification_slot(struct kfd_process *p,
 					    struct kfd_event *ev,
 					    const int *restore_id)
@@ -93,7 +77,7 @@ static int allocate_event_notification_slot(struct kfd_process *p,
 		return id;
 
 	ev->event_id = id;
-	page_slots(p->signal_page)[id] = UNSIGNALED_EVENT_SLOT;
+	p->signal_page[id] = UNSIGNALED_EVENT_SLOT;
 
 	return 0;
 }
@@ -139,7 +123,7 @@ static struct kfd_event *lookup_signaled_event_by_partial_id(
 	 */
 	if (bits > 31 || (1U << bits) >= KFD_SIGNAL_EVENT_LIMIT) {
 		if (signal_mailbox_updated &&
-		    page_slots(p->signal_page)[id] == UNSIGNALED_EVENT_SLOT)
+		    p->signal_page[id] == UNSIGNALED_EVENT_SLOT)
 			return NULL;
 
 		return idr_find(&p->event_idr, id);
@@ -149,7 +133,7 @@ static struct kfd_event *lookup_signaled_event_by_partial_id(
 	 * and find the first one that has signaled.
 	 */
 	for (ev = NULL; id < KFD_SIGNAL_EVENT_LIMIT && !ev; id += 1U << bits) {
-		if (page_slots(p->signal_page)[id] == UNSIGNALED_EVENT_SLOT)
+		if (p->signal_page[id] == UNSIGNALED_EVENT_SLOT)
 			continue;
 
 		ev = idr_find(&p->event_idr, id);
@@ -261,21 +245,9 @@ static void destroy_events(struct kfd_process *p)
 	mutex_destroy(&p->event_mutex);
 }
 
-/*
- * We assume that the process is being destroyed and there is no need to
- * unmap the pages or keep bookkeeping data in order.
- */
-static void shutdown_signal_page(struct kfd_process *p)
-{
-	struct kfd_signal_page *page = p->signal_page;
-
-	kfree(page);
-}
-
 void kfd_event_free_process(struct kfd_process *p)
 {
 	destroy_events(p);
-	shutdown_signal_page(p);
 }
 
 static bool event_can_be_gpu_signaled(const struct kfd_event *ev)
@@ -292,8 +264,6 @@ static bool event_can_be_cpu_signaled(const struct kfd_event *ev)
 static int kfd_event_page_set(struct kfd_process *p, void *kernel_address,
 		       uint64_t size, uint64_t user_handle)
 {
-	struct kfd_signal_page *page;
-
 	if (p->signal_page)
 		return -EBUSY;
 
@@ -303,17 +273,11 @@ static int kfd_event_page_set(struct kfd_process *p, void *kernel_address,
 		return -EINVAL;
 	}
 
-	page = kzalloc(sizeof(*page), GFP_KERNEL);
-	if (!page)
-		return -ENOMEM;
-
 	/* Initialize all events to unsignaled */
 	memset(kernel_address, (uint8_t) UNSIGNALED_EVENT_SLOT,
 	       KFD_SIGNAL_EVENT_LIMIT * 8);
 
-	page->kernel_address = kernel_address;
-
-	p->signal_page = page;
+	p->signal_page = kernel_address;
 	p->signal_mapped_size = size;
 	p->signal_handle = user_handle;
 	return 0;
@@ -680,7 +644,7 @@ int kfd_reset_event(struct kfd_process *p, uint32_t event_id)
 
 static void acknowledge_signal(struct kfd_process *p, struct kfd_event *ev)
 {
-	WRITE_ONCE(page_slots(p->signal_page)[ev->event_id], UNSIGNALED_EVENT_SLOT);
+	WRITE_ONCE(p->signal_page[ev->event_id], UNSIGNALED_EVENT_SLOT);
 }
 
 static void set_event_from_interrupt(struct kfd_process *p,
@@ -723,7 +687,7 @@ void kfd_signal_event_interrupt(u32 pasid, uint32_t partial_id,
 		 * in the interrupt payload was invalid and do an
 		 * exhaustive search of signaled events.
 		 */
-		uint64_t *slots = page_slots(p->signal_page);
+		uint64_t *slots = p->signal_page;
 		uint32_t id;
 
 		if (valid_id_bits)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.h b/drivers/gpu/drm/amd/amdkfd/kfd_events.h
index 88e3797bfc42..827a2c7d7721 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.h
@@ -49,7 +49,6 @@
 #define UNSIGNALED_EVENT_SLOT ((uint64_t)-1)
 
 struct kfd_event_waiter;
-struct signal_page;
 
 struct kfd_event {
 	u32 event_id;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 13a021b0e6e5..28a0b014d703 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -953,7 +953,14 @@ struct kfd_process {
 	struct idr event_idr;
 	/* Event page */
 	u64 signal_handle;
-	struct kfd_signal_page *signal_page;
+	/*
+	 * Each signal event needs a 64-bit signal slot where the signaler will
+	 * write a 1 before sending an interrupt. (This is needed because some
+	 * interrupts do not contain enough spare data bits to identify an
+	 * event.) The signal page is allocated in user mode and mapped to the
+	 * kernel; individual signal events use their event_id as slot index.
+	 */
+	uint64_t *signal_page;
 	size_t signal_mapped_size;
 	size_t signal_event_count;
 	bool signal_event_limit_reached;
-- 
2.43.0

