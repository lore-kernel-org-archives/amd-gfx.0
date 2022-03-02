Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D438BC433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Mar 2022 20:06:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D57D10E15A;
	Wed,  2 Mar 2022 20:06:43 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2077.outbound.protection.outlook.com [40.107.101.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F009610E15A
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Mar 2022 20:06:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NxP3BlhKGO7k1TFyIhZMOb2Zet5jaDrCGR0QurE7sbi7XWu1RNL74Eur6hC0EQBgfYrGNKRph5yLj8pNcbjU/gsEOP2D5Fk5792uvFWc/Ana1mjVtSnGhKAlxSQU4fQu4mTmTVF3DG/nMVFxBj+1ytB8okxGLDbitzpUOXbqBPXNscXKHQ+Ux4uvVEoGVH1BiwxKEa9o1ncRjRSMmjCdoct7NeSkCYhca1pkYpaQsx6kqMV2+Qd9M2B+w/SXdsyaws973IDTJkSgozglHtcsQubfC/FW4lDftE2zxpIkjJAAIrd5lPkWu70vbQj9kE1kEgt5xcIAP2+LjtQ1URBoTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T2O/Z+hRN2FT+U3bPh6oWQ4hnQ/oDqNgXYsO+AcHTKw=;
 b=agYjf0mJe9EyaWMpj3IrztWxSa0xyczIYkCKurIiF/U5Usx3zEzBUpukQrBrP4faD/gmcW1vV2kVf2Lwf1xGmdZf3r2o/EzazJwHi383uZ5EHRYHDC3VKY+BPy5ci/CJ8aucfQ12JGWIp7lDce0lcyRWY9FDmYT6928+GVWoTeu3eVTrJusjCrkWDayITTlgRzbAPzLIB8OIeA4Pr+Lzo44nV0DPnvJXE2YDtkqvAQMTBZDkEi0cw5rzvzmjuF8y9sLU5hwKcTQJEfsvIXe3VkNeAKTZgY2vgcdGbvMsB3s+mzMtnYJ2FXdTay9INUWGhYBNn/t3XBJ21BXMKMgo6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T2O/Z+hRN2FT+U3bPh6oWQ4hnQ/oDqNgXYsO+AcHTKw=;
 b=yqn8Z0L3/ErEavRehnsvxZqBFoLN7Zd4u6e5aB8hePLpp+i44KiC7OGmjrQI5xkg8fl6zFwKezYeqMbFfi1E1fxLoXrc9btf1nf0/NgoIEp0T5Fihhz1AtjnHX53Z8nFfHeFRRgBzULN0RgfnWbSVrVR8Xoo3G5ln90kibRWLdY=
Received: from BN0PR10CA0015.namprd10.prod.outlook.com (2603:10b6:408:143::33)
 by BL1PR12MB5319.namprd12.prod.outlook.com (2603:10b6:208:317::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Wed, 2 Mar
 2022 20:06:38 +0000
Received: from BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:143:cafe::9f) by BN0PR10CA0015.outlook.office365.com
 (2603:10b6:408:143::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Wed, 2 Mar 2022 20:06:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT010.mail.protection.outlook.com (10.13.177.53) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Wed, 2 Mar 2022 20:06:38 +0000
Received: from Harpoon.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 2 Mar
 2022 14:06:37 -0600
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/1] drm/amdkfd: Improve concurrency of event handling
Date: Wed, 2 Mar 2022 15:06:14 -0500
Message-ID: <20220302200614.2439019-1-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f45f25f-c37a-4818-77a4-08d9fc8828f4
X-MS-TrafficTypeDiagnostic: BL1PR12MB5319:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB53191550FE7F9F838E21AE7E92039@BL1PR12MB5319.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sKMJRpmK8AkE+GQ3jMcBa6q0RjUJoDhYLIoCj/WHmVasseXXGjxp/hnob97wfg3pkbQ5tNvI7f5Ww1sgKFQCroQ7aeBNw8uKRz+nVvIjJnphDuSqfu2izLpJ8bntbhpb5L4bADF9Y78SgitL5GHIV4ogwgBTr2N9o/S0q6U5KEZ+inuKxnJMieBZT+HgFhTsBS8zVvQqgrhmT4e0sbC1+27Y7Q/ZZF2OYV39FDWqPJKya4jlSj1imdXn2+mLRoIZhRUWrgufqVslWQ6VFX/zfkfb/+MaE37MdFrUErgmcMvZG1ZTB4qgIUwDsxV0d2g7BiKEFU+vGley5hr0PB5jfBydwLgW2BArgdUU+3o18xvpBXUXEI09vQPu0/qNzkvqo+79TqGYfDR3pq0Y0kNbPtlI1A8O3FxjPrzgE/oTW7+88LwW/dbO2imLEQa2yUN8D62HN99RtW7YsL8yhqkD/GY+5hCXGvIXdr8nN/ueC+24omqZ9/nNHFfGKmbU6xj+mi96BCJ50S1vc3Txhc7dmFD+NCs3h5OaA1X5XBFEiTUZF/jAsodoa5Nel064Fm23SdabPTym0yzReNOJcp615eGthD4lvKWbdbGmm1mktJU42ktx5+5I/fUAe2Muz0ZYiLyzHJDBwhS6Gtm0aC8xgq2dFkw3fr/wBiGl4UPoY4jdszFYoj50jmgHTTVj1TSDDWkOY35YD0E05uctMSArAA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(4326008)(70206006)(70586007)(2906002)(8676002)(36756003)(508600001)(7696005)(6666004)(336012)(1076003)(186003)(82310400004)(426003)(26005)(16526019)(36860700001)(2616005)(86362001)(316002)(356005)(83380400001)(30864003)(47076005)(81166007)(5660300002)(40460700003)(8936002)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2022 20:06:38.1716 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f45f25f-c37a-4818-77a4-08d9fc8828f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5319
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
Cc: sean.keely@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use rcu_read_lock to read p->event_idr concurrently with other readers
and writers. Use p->event_mutex only for creating and destroying events
and in kfd_wait_on_events.

Protect the contents of the kfd_event structure with a per-event
spinlock that can be taken inside the rcu_read_lock critical section.

This eliminates contention of p->event_mutex in set_event, which tends
to be on the critical path for dispatch latency even when busy waiting
is used. It also eliminates lock contention in event interrupt handlers.
Since the p->event_mutex is now used much less, the impact of requiring
it in kfd_wait_on_events should also be much smaller.

This should improve event handling latency for processes using multiple
GPUs concurrently.

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_events.c | 119 +++++++++++++++---------
 drivers/gpu/drm/amd/amdkfd/kfd_events.h |   1 +
 2 files changed, 78 insertions(+), 42 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
index deecccebe5b6..1726306715b2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
@@ -128,8 +128,8 @@ static int allocate_event_notification_slot(struct kfd_process *p,
 }
 
 /*
- * Assumes that p->event_mutex is held and of course that p is not going
- * away (current or locked).
+ * Assumes that p->event_mutex or rcu_readlock is held and of course that p is
+ * not going away.
  */
 static struct kfd_event *lookup_event_by_id(struct kfd_process *p, uint32_t id)
 {
@@ -251,15 +251,18 @@ static void destroy_event(struct kfd_process *p, struct kfd_event *ev)
 	struct kfd_event_waiter *waiter;
 
 	/* Wake up pending waiters. They will return failure */
+	spin_lock(&ev->lock);
 	list_for_each_entry(waiter, &ev->wq.head, wait.entry)
-		waiter->event = NULL;
+		WRITE_ONCE(waiter->event, NULL);
 	wake_up_all(&ev->wq);
+	spin_unlock(&ev->lock);
 
 	if (ev->type == KFD_EVENT_TYPE_SIGNAL ||
 	    ev->type == KFD_EVENT_TYPE_DEBUG)
 		p->signal_event_count--;
 
 	idr_remove(&p->event_idr, ev->event_id);
+	synchronize_rcu();
 	kfree(ev);
 }
 
@@ -392,6 +395,7 @@ int kfd_event_create(struct file *devkfd, struct kfd_process *p,
 	ev->auto_reset = auto_reset;
 	ev->signaled = false;
 
+	spin_lock_init(&ev->lock);
 	init_waitqueue_head(&ev->wq);
 
 	*event_page_offset = 0;
@@ -466,6 +470,7 @@ int kfd_criu_restore_event(struct file *devkfd,
 	ev->auto_reset = ev_priv->auto_reset;
 	ev->signaled = ev_priv->signaled;
 
+	spin_lock_init(&ev->lock);
 	init_waitqueue_head(&ev->wq);
 
 	mutex_lock(&p->event_mutex);
@@ -609,13 +614,13 @@ static void set_event(struct kfd_event *ev)
 
 	/* Auto reset if the list is non-empty and we're waking
 	 * someone. waitqueue_active is safe here because we're
-	 * protected by the p->event_mutex, which is also held when
+	 * protected by the ev->lock, which is also held when
 	 * updating the wait queues in kfd_wait_on_events.
 	 */
 	ev->signaled = !ev->auto_reset || !waitqueue_active(&ev->wq);
 
 	list_for_each_entry(waiter, &ev->wq.head, wait.entry)
-		waiter->activated = true;
+		WRITE_ONCE(waiter->activated, true);
 
 	wake_up_all(&ev->wq);
 }
@@ -626,16 +631,18 @@ int kfd_set_event(struct kfd_process *p, uint32_t event_id)
 	int ret = 0;
 	struct kfd_event *ev;
 
-	mutex_lock(&p->event_mutex);
+	rcu_read_lock();
 
 	ev = lookup_event_by_id(p, event_id);
+	spin_lock(&ev->lock);
 
 	if (ev && event_can_be_cpu_signaled(ev))
 		set_event(ev);
 	else
 		ret = -EINVAL;
 
-	mutex_unlock(&p->event_mutex);
+	spin_unlock(&ev->lock);
+	rcu_read_unlock();
 	return ret;
 }
 
@@ -650,23 +657,25 @@ int kfd_reset_event(struct kfd_process *p, uint32_t event_id)
 	int ret = 0;
 	struct kfd_event *ev;
 
-	mutex_lock(&p->event_mutex);
+	rcu_read_lock();
 
 	ev = lookup_event_by_id(p, event_id);
+	spin_lock(&ev->lock);
 
 	if (ev && event_can_be_cpu_signaled(ev))
 		reset_event(ev);
 	else
 		ret = -EINVAL;
 
-	mutex_unlock(&p->event_mutex);
+	spin_unlock(&ev->lock);
+	rcu_read_unlock();
 	return ret;
 
 }
 
 static void acknowledge_signal(struct kfd_process *p, struct kfd_event *ev)
 {
-	page_slots(p->signal_page)[ev->event_id] = UNSIGNALED_EVENT_SLOT;
+	WRITE_ONCE(page_slots(p->signal_page)[ev->event_id], UNSIGNALED_EVENT_SLOT);
 }
 
 static void set_event_from_interrupt(struct kfd_process *p,
@@ -674,7 +683,9 @@ static void set_event_from_interrupt(struct kfd_process *p,
 {
 	if (ev && event_can_be_gpu_signaled(ev)) {
 		acknowledge_signal(p, ev);
+		spin_lock(&ev->lock);
 		set_event(ev);
+		spin_unlock(&ev->lock);
 	}
 }
 
@@ -693,7 +704,7 @@ void kfd_signal_event_interrupt(u32 pasid, uint32_t partial_id,
 	if (!p)
 		return; /* Presumably process exited. */
 
-	mutex_lock(&p->event_mutex);
+	rcu_read_lock();
 
 	if (valid_id_bits)
 		ev = lookup_signaled_event_by_partial_id(p, partial_id,
@@ -721,7 +732,7 @@ void kfd_signal_event_interrupt(u32 pasid, uint32_t partial_id,
 				if (id >= KFD_SIGNAL_EVENT_LIMIT)
 					break;
 
-				if (slots[id] != UNSIGNALED_EVENT_SLOT)
+				if (READ_ONCE(slots[id]) != UNSIGNALED_EVENT_SLOT)
 					set_event_from_interrupt(p, ev);
 			}
 		} else {
@@ -730,14 +741,14 @@ void kfd_signal_event_interrupt(u32 pasid, uint32_t partial_id,
 			 * only signaled events from the IDR.
 			 */
 			for (id = 0; id < KFD_SIGNAL_EVENT_LIMIT; id++)
-				if (slots[id] != UNSIGNALED_EVENT_SLOT) {
+				if (READ_ONCE(slots[id]) != UNSIGNALED_EVENT_SLOT) {
 					ev = lookup_event_by_id(p, id);
 					set_event_from_interrupt(p, ev);
 				}
 		}
 	}
 
-	mutex_unlock(&p->event_mutex);
+	rcu_read_unlock();
 	kfd_unref_process(p);
 }
 
@@ -767,9 +778,11 @@ static int init_event_waiter_get_status(struct kfd_process *p,
 	if (!ev)
 		return -EINVAL;
 
+	spin_lock(&ev->lock);
 	waiter->event = ev;
 	waiter->activated = ev->signaled;
 	ev->signaled = ev->signaled && !ev->auto_reset;
+	spin_unlock(&ev->lock);
 
 	return 0;
 }
@@ -781,8 +794,11 @@ static void init_event_waiter_add_to_waitlist(struct kfd_event_waiter *waiter)
 	/* Only add to the wait list if we actually need to
 	 * wait on this event.
 	 */
-	if (!waiter->activated)
+	if (!waiter->activated) {
+		spin_lock(&ev->lock);
 		add_wait_queue(&ev->wq, &waiter->wait);
+		spin_unlock(&ev->lock);
+	}
 }
 
 /* test_event_condition - Test condition of events being waited for
@@ -802,10 +818,10 @@ static uint32_t test_event_condition(bool all, uint32_t num_events,
 	uint32_t activated_count = 0;
 
 	for (i = 0; i < num_events; i++) {
-		if (!event_waiters[i].event)
+		if (!READ_ONCE(event_waiters[i].event))
 			return KFD_IOC_WAIT_RESULT_FAIL;
 
-		if (event_waiters[i].activated) {
+		if (READ_ONCE(event_waiters[i].activated)) {
 			if (!all)
 				return KFD_IOC_WAIT_RESULT_COMPLETE;
 
@@ -834,6 +850,8 @@ static int copy_signaled_event_data(uint32_t num_events,
 	for (i = 0; i < num_events; i++) {
 		waiter = &event_waiters[i];
 		event = waiter->event;
+		if (!event)
+			return -EINVAL; /* event was destroyed */
 		if (waiter->activated && event->type == KFD_EVENT_TYPE_MEMORY) {
 			dst = &data[i].memory_exception_data;
 			src = &event->memory_exception_data;
@@ -844,11 +862,8 @@ static int copy_signaled_event_data(uint32_t num_events,
 	}
 
 	return 0;
-
 }
 
-
-
 static long user_timeout_to_jiffies(uint32_t user_timeout_ms)
 {
 	if (user_timeout_ms == KFD_EVENT_TIMEOUT_IMMEDIATE)
@@ -872,9 +887,12 @@ static void free_waiters(uint32_t num_events, struct kfd_event_waiter *waiters)
 	uint32_t i;
 
 	for (i = 0; i < num_events; i++)
-		if (waiters[i].event)
+		if (waiters[i].event) {
+			spin_lock(&waiters[i].event->lock);
 			remove_wait_queue(&waiters[i].event->wq,
 					  &waiters[i].wait);
+			spin_unlock(&waiters[i].event->lock);
+		}
 
 	kfree(waiters);
 }
@@ -898,6 +916,9 @@ int kfd_wait_on_events(struct kfd_process *p,
 		goto out;
 	}
 
+	/* Use p->event_mutex here to protect against concurrent creation and
+	 * destruction of events while we initialize event_waiters.
+	 */
 	mutex_lock(&p->event_mutex);
 
 	for (i = 0; i < num_events; i++) {
@@ -976,14 +997,19 @@ int kfd_wait_on_events(struct kfd_process *p,
 	}
 	__set_current_state(TASK_RUNNING);
 
+	mutex_lock(&p->event_mutex);
 	/* copy_signaled_event_data may sleep. So this has to happen
 	 * after the task state is set back to RUNNING.
+	 *
+	 * The event may also have been destroyed after signaling. So
+	 * copy_signaled_event_data also must confirm that the event
+	 * still exists. Therefore this must be under the p->event_mutex
+	 * which is also held when events are destroyed.
 	 */
 	if (!ret && *wait_result == KFD_IOC_WAIT_RESULT_COMPLETE)
 		ret = copy_signaled_event_data(num_events,
 					       event_waiters, events);
 
-	mutex_lock(&p->event_mutex);
 out_unlock:
 	free_waiters(num_events, event_waiters);
 	mutex_unlock(&p->event_mutex);
@@ -1042,8 +1068,7 @@ int kfd_event_mmap(struct kfd_process *p, struct vm_area_struct *vma)
 }
 
 /*
- * Assumes that p->event_mutex is held and of course
- * that p is not going away (current or locked).
+ * Assumes that p is not going away.
  */
 static void lookup_events_by_type_and_signal(struct kfd_process *p,
 		int type, void *event_data)
@@ -1055,6 +1080,8 @@ static void lookup_events_by_type_and_signal(struct kfd_process *p,
 
 	ev_data = (struct kfd_hsa_memory_exception_data *) event_data;
 
+	rcu_read_lock();
+
 	id = KFD_FIRST_NONSIGNAL_EVENT_ID;
 	idr_for_each_entry_continue(&p->event_idr, ev, id)
 		if (ev->type == type) {
@@ -1062,9 +1089,11 @@ static void lookup_events_by_type_and_signal(struct kfd_process *p,
 			dev_dbg(kfd_device,
 					"Event found: id %X type %d",
 					ev->event_id, ev->type);
+			spin_lock(&ev->lock);
 			set_event(ev);
 			if (ev->type == KFD_EVENT_TYPE_MEMORY && ev_data)
 				ev->memory_exception_data = *ev_data;
+			spin_unlock(&ev->lock);
 		}
 
 	if (type == KFD_EVENT_TYPE_MEMORY) {
@@ -1087,6 +1116,8 @@ static void lookup_events_by_type_and_signal(struct kfd_process *p,
 				p->lead_thread->pid, p->pasid);
 		}
 	}
+
+	rcu_read_unlock();
 }
 
 #ifdef KFD_SUPPORT_IOMMU_V2
@@ -1162,16 +1193,10 @@ void kfd_signal_iommu_event(struct kfd_dev *dev, u32 pasid,
 
 	if (KFD_GC_VERSION(dev) != IP_VERSION(9, 1, 0) &&
 	    KFD_GC_VERSION(dev) != IP_VERSION(9, 2, 2) &&
-	    KFD_GC_VERSION(dev) != IP_VERSION(9, 3, 0)) {
-		mutex_lock(&p->event_mutex);
-
-		/* Lookup events by type and signal them */
+	    KFD_GC_VERSION(dev) != IP_VERSION(9, 3, 0))
 		lookup_events_by_type_and_signal(p, KFD_EVENT_TYPE_MEMORY,
 				&memory_exception_data);
 
-		mutex_unlock(&p->event_mutex);
-	}
-
 	kfd_unref_process(p);
 }
 #endif /* KFD_SUPPORT_IOMMU_V2 */
@@ -1188,12 +1213,7 @@ void kfd_signal_hw_exception_event(u32 pasid)
 	if (!p)
 		return; /* Presumably process exited. */
 
-	mutex_lock(&p->event_mutex);
-
-	/* Lookup events by type and signal them */
 	lookup_events_by_type_and_signal(p, KFD_EVENT_TYPE_HW_EXCEPTION, NULL);
-
-	mutex_unlock(&p->event_mutex);
 	kfd_unref_process(p);
 }
 
@@ -1229,16 +1249,19 @@ void kfd_signal_vm_fault_event(struct kfd_dev *dev, u32 pasid,
 			info->prot_write ? 1 : 0;
 		memory_exception_data.failure.imprecise = 0;
 	}
-	mutex_lock(&p->event_mutex);
+
+	rcu_read_lock();
 
 	id = KFD_FIRST_NONSIGNAL_EVENT_ID;
 	idr_for_each_entry_continue(&p->event_idr, ev, id)
 		if (ev->type == KFD_EVENT_TYPE_MEMORY) {
+			spin_lock(&ev->lock);
 			ev->memory_exception_data = memory_exception_data;
 			set_event(ev);
+			spin_unlock(&ev->lock);
 		}
 
-	mutex_unlock(&p->event_mutex);
+	rcu_read_unlock();
 	kfd_unref_process(p);
 }
 
@@ -1272,22 +1295,28 @@ void kfd_signal_reset_event(struct kfd_dev *dev)
 			continue;
 		}
 
-		mutex_lock(&p->event_mutex);
+		rcu_read_lock();
+
 		id = KFD_FIRST_NONSIGNAL_EVENT_ID;
 		idr_for_each_entry_continue(&p->event_idr, ev, id) {
 			if (ev->type == KFD_EVENT_TYPE_HW_EXCEPTION) {
+				spin_lock(&ev->lock);
 				ev->hw_exception_data = hw_exception_data;
 				ev->hw_exception_data.gpu_id = user_gpu_id;
 				set_event(ev);
+				spin_unlock(&ev->lock);
 			}
 			if (ev->type == KFD_EVENT_TYPE_MEMORY &&
 			    reset_cause == KFD_HW_EXCEPTION_ECC) {
+				spin_lock(&ev->lock);
 				ev->memory_exception_data = memory_exception_data;
 				ev->memory_exception_data.gpu_id = user_gpu_id;
 				set_event(ev);
+				spin_unlock(&ev->lock);
 			}
 		}
-		mutex_unlock(&p->event_mutex);
+
+		rcu_read_unlock();
 	}
 	srcu_read_unlock(&kfd_processes_srcu, idx);
 }
@@ -1320,19 +1349,25 @@ void kfd_signal_poison_consumed_event(struct kfd_dev *dev, u32 pasid)
 	memory_exception_data.gpu_id = user_gpu_id;
 	memory_exception_data.failure.imprecise = true;
 
-	mutex_lock(&p->event_mutex);
+	rcu_read_lock();
+
 	idr_for_each_entry_continue(&p->event_idr, ev, id) {
 		if (ev->type == KFD_EVENT_TYPE_HW_EXCEPTION) {
+			spin_lock(&ev->lock);
 			ev->hw_exception_data = hw_exception_data;
 			set_event(ev);
+			spin_unlock(&ev->lock);
 		}
 
 		if (ev->type == KFD_EVENT_TYPE_MEMORY) {
+			spin_lock(&ev->lock);
 			ev->memory_exception_data = memory_exception_data;
 			set_event(ev);
+			spin_unlock(&ev->lock);
 		}
 	}
-	mutex_unlock(&p->event_mutex);
+
+	rcu_read_unlock();
 
 	/* user application will handle SIGBUS signal */
 	send_sig(SIGBUS, p->lead_thread, 0);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.h b/drivers/gpu/drm/amd/amdkfd/kfd_events.h
index 1238af11916e..55d376f56021 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.h
@@ -59,6 +59,7 @@ struct kfd_event {
 
 	int type;
 
+	spinlock_t lock;
 	wait_queue_head_t wq; /* List of event waiters. */
 
 	/* Only for signal events. */
-- 
2.32.0

