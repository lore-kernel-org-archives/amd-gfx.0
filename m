Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95396CD4F26
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2026 17:53:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C2F510E10C;
	Fri, 19 Jun 2026 17:53:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CnOKn0LX";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013040.outbound.protection.outlook.com
 [40.93.196.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E2FB10E10C
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jun 2026 17:53:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=donlE4M0P91pHGVcJU75uhlOrQHra9z5/C5m4F8lE5L8JqO//xja7k6Po1+SHoswRk/rO9MVQ39UOX278nF0Ci35qJmph9GiAdqIyb6cTmN69kszk1+c85waeP8n2N4NxykgMDEA4CJ7ndZAehadleFi1BKzcvqSAk3yK2kZF1g0N8XTgLD8uLI7Td2e8XSDSbLkXihdYFOnzX6C2TrNL8TnDUdArFcooL3XDt0ZLelhiLX8xVwczozAuxTfQhUA4e69zBDxG0KmNHLCmdt7g5aV+hOzj9duemWihCYjMSFhF089C4xyjouMlZB1p7rkgxOErzI9rzYh0E473hAcCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5H0HtNmV/Jf6vWahNC/Q0KnI/mE3cbVB6haVPPVFCIU=;
 b=Eh86S6ileda5H3jG7gnrYgs9aXKLyIPPA/CsRpOkfV8/CKmP7oGmSbBnHP5xwwIU6hCxLZ5ebOgwv59XRhWVAZrqGmgu5GrRKUMscG7no6OXklqrYJQnk4ems2mO/vvuaiJHglslapmXUpANI8rQgZenEV14+9etg8N8kO+O+8RZ9JdQg5/iZKOCPGJIJcgYlpR+wY6DNxbFjCuNvqLGW2BJorYHRTwVClmbo7p6jnFlBUkpui0vM9BTh47LkhF661NuduzVyxGSqUjkAB9AqMpgykKcDwDdTw2xrcAr7syzFGu1ADikPEj+Gx1/ywuaghanNmKtSmnzz0+6nZJ2/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5H0HtNmV/Jf6vWahNC/Q0KnI/mE3cbVB6haVPPVFCIU=;
 b=CnOKn0LXoqhUlm4r7aSaG2YygL1h4POTECWV+B6wybM5A3EDQkSb4SkRcuOdMkZKua9tf3AZeZokaiuV+rNa0L1ZToVOR0eKFKHfwPDsONct3hSJNPMeCfrNIQN7CMClTvGmeoirHGZvDMQ9RCC1Dhnm0zgs4AZ9VvGOCNi/L1Y=
Received: from DS1PR04CA0023.namprd04.prod.outlook.com (2603:10b6:8:243::17)
 by PH7PR12MB5686.namprd12.prod.outlook.com (2603:10b6:510:13d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Fri, 19 Jun
 2026 17:52:55 +0000
Received: from SN1PEPF0002BA4B.namprd03.prod.outlook.com
 (2603:10b6:8:243:cafe::3a) by DS1PR04CA0023.outlook.office365.com
 (2603:10b6:8:243::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.16 via Frontend Transport; Fri,
 19 Jun 2026 17:52:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA4B.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Fri, 19 Jun 2026 17:52:53 +0000
Received: from 0yonsun-linux-dev.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Fri, 19 Jun 2026 12:52:52 -0500
From: Yongqiang Sun <Yongqiang.Sun@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Yongqiang Sun <Yongqiang.Sun@amd.com>
Subject: [PATCH] drm/amdkfd: drop struct kfd_signal_page wrapper
Date: Fri, 19 Jun 2026 13:52:36 -0400
Message-ID: <20260619175236.2649795-1-Yongqiang.Sun@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4B:EE_|PH7PR12MB5686:EE_
X-MS-Office365-Filtering-Correlation-Id: bf2b2445-75f7-452a-0dea-08dece2b96ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|36860700016|82310400026|18002099003|3023799007|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: u70ewV1S1X3uS/FhYiItGV4w0Mh2WaeLHr08+UqmjfMTurYWjLT8607qAse3BnL14DG3KdLdozNqmwVVaqAr/KbUm0+sVzhRq408Ku1hBQlTvW245K0ktJ1X6VJC3uUNt4R36R4xwO+4z6VEE2hLedyKuthiMJIjoY2P7LdpKEl/CJfxwjp7czDGqiJmVxZEl4+lgsDaRz5dOivjVKjq+wCw58Tzfxx0aAGsm5cpxD0K79l3C2TrwTbdhNGyNzCVTiJc7NEk3xfH20GlQO5Z6GnyAygu6buiML72XixVKGZWFkwToAerY2x+TE816JWyydg3MjPEGf9/2FC8CGvXtfFgUMBEwb1T9QMYe2z1Uk2miP4HabRbFl6u1u66JnP7FBtYAuYgVJK3g8Gh9d5rLnFBaWfV7sDBvUnkMDhcLzutc+z95GYDj2wlXY8+fESqjOnSualiwLrUY3Y6n+aljciiVMukblO7o5CenLEiCHmMn6PBEEpI5VkhMrE15WHJVKhWMqoTT4kIentQ8tbtQX7fBWgSXepEF5xApcDqct4F1IymiDU9yEUll2uYqvrqz3hA/ndNpFnHroidabymyZtHgOTLVT7jqOtA5kFo/e6dqWqHT/uvxwSwsaF/6rr0RLkl4rWK7yfGBbmAr5NG7gQ8JIO4wAO5Dgf3UZMIcdkVw0TcKQFpOldq5kzTIWzVrCQv++kepVbgH9kDNeegwg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(18002099003)(3023799007)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: sl0Czm9LN0NR8WvftdO9NWc+DoeT2UfCYE6drlX3E20VFw2Z7Qwep3jyRxv+Y2b8TUqpMpAzBcVWAkWFjS5rsx9nBXPUoM8Izh7VIk031aXnyWKmfjKYw6YUAMgvEK+XhGqz1uz/uRX3GVqdFIkpN/qnMVOAcF3Mxv8xcnrLpotStH4fLmiXvpb+R+oZ374WaqFNp9fkQCFGU37iuIMemYrla+fwgkj4dKtjWwYheUA4aDOj6zVNNzgVMuwRnW0fTvluWu+TRbqzucafibcJYgUv+kmiq7dBTgOgAcMN9b9w/LnIcogqMWMU7omDVyXwJjvzyWj+SzMbUau1y9jtGvORbD/LjlXNOoSzt/FwT+hetrcgEXVF+T8MCnUWuS2QqnOBqmqwbHtwQj5GdcRlWZSh72svzT7fmrRykmJ4knOcdpOwsikQVd6sPJ4tsHfU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2026 17:52:53.9485 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf2b2445-75f7-452a-0dea-08dece2b96ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5686
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
index f00c522fba74..ad4897f094a2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -952,7 +952,14 @@ struct kfd_process {
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

