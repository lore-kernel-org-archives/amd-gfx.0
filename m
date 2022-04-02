Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99742C433F5
	for <amd-gfx@archiver.kernel.org>; Sat,  2 Apr 2022 00:23:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 727B510E1B5;
	Sat,  2 Apr 2022 00:23:19 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2055.outbound.protection.outlook.com [40.107.101.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F75B10E15B
 for <amd-gfx@lists.freedesktop.org>; Sat,  2 Apr 2022 00:23:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h7VdPPq1Bjbgy1Ea8A6WNJmxgIvucznk4FklJptyo/qv8wt6VXaxonCAY7vY4N0dY5rOhCrJWKadYCD8OrbLx9hpgwGu3jumaLeLKStVkKuym5fcaev+8rNS3b2rewTiVn82H5kW/CQzZfUZ9PxxZvrSBwcBm96X8NKW3CEfA8lZgySBJnkuSpRNgNbn/NfPpf5OVrpWdVq9WsBh9CWf3jnYcjKN3WAivTMVd8X/KvekPboyFhe+J/s60vOMNon0RUrfuO8nriHw6OCLkYyUnR9/fUmxMRaaBU9SktuexHUxwlNq5N5mzh7QVYLgvyyXNO/ouilx0Y9WJmx4guYQNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0YGrFypBdSdVP1D8k2s/kotRV0ms2qaAYgYUk66cJAo=;
 b=QHyyU6Jtk4rAFboI01Q7QGcWgDwbzQ0FUTgrGrsiyLHbqzb3JHAF1N83Pq2Pt8fT84TMhZ1R/PCL5r7QpkktTDNc4WhUAeTSK/IDBKkrO+RmdEQtrc5NXmM0Xa0toML2UuQ50EJxpulyUxciy2YbCvkDAGmSJYfNPIf1tk8VwbXxrz84xs5vT33AA0tr0EAPQgBCmSm0aM6eDLclfLUgPfXQuemFH+JN+t4+4oYCNkrGQKwJOWPb47CUTu4izenxoEfAF32t744+SRq9jKSNpc8zpTwdg1xN4apCF73wZbCf1oDF061hzqq+TSMGv6oPa79yB7Aw6FKJP/7oOSQSpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0YGrFypBdSdVP1D8k2s/kotRV0ms2qaAYgYUk66cJAo=;
 b=IuXWp4OJyfpONipihZZzpvVmWzkDn0G4PMV6GmHD8ZAX5m0xf4Z5d+YhefmyfaUBdcvvgEpnHl3leDZS4G6Nd9OdpFTKG47B10ij7jbk68pduXWj+Gpn3oeoCIrRGnCR+VnXWCZR4e5BdEgzgBuGMccTeCgPS5gYQh6wTEN2z7Y=
Received: from MW4PR04CA0219.namprd04.prod.outlook.com (2603:10b6:303:87::14)
 by DM4PR12MB5962.namprd12.prod.outlook.com (2603:10b6:8:69::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5123.21; Sat, 2 Apr 2022 00:23:14 +0000
Received: from CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::8e) by MW4PR04CA0219.outlook.office365.com
 (2603:10b6:303:87::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.27 via Frontend
 Transport; Sat, 2 Apr 2022 00:23:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT038.mail.protection.outlook.com (10.13.174.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5123.19 via Frontend Transport; Sat, 2 Apr 2022 00:23:13 +0000
Received: from Harpoon.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 1 Apr
 2022 19:23:12 -0500
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 1/1] drm/amdkfd: Improve concurrency of event handling
Date: Fri, 1 Apr 2022 20:22:43 -0400
Message-ID: <20220402002243.991584-1-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 69f05bb0-7f9e-49bf-e3f0-08da143ef994
X-MS-TrafficTypeDiagnostic: DM4PR12MB5962:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB596238E005F675D4EE23999592E39@DM4PR12MB5962.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: urSF/PUfelSBmtUceLCeCWsMEMU3o+XD6JBhfqw9shKNB9VI2ZkyBhKYva3alT7tM003gNWYIvBL83oxEfQ8LP9pjfPpJPjcoNX8ZgV6K4BAmtthkim3Upv5i4C2/faEHGQKjuMg9mpQ9Cv7XuahfDCq494bB7a/Z55P20YCEKt9289q0HM342cLhTiws5t8c0CAKRH02cwtkCZ8brE9A8Bt0tKpEqeiZ7WGmXL0UO33PvYSDwra3P+X1LtPB1PQTDeeCEbB+3IHp2dF/Q+t5YgjxSp3oT2eKsURpID15Lh39jtAgZ8ImD6mIfHUk6MEPrsbtB8wybj/aZDYDDmbkilAVwY+FPgVU1Px57YQptAX+PRRaRdRMdpgcuhke87liyAtsxUQpRp7sFiYWz531aiMe9yJJdGwqXZvoLmZU4pJDOuuEdEt6imrkABkgcht9zBl3YZkGfV85dOdj5vI17Qs8LLTknz/J7k65pvirKp60EQ01uNYiFg7CNkymKRGrrHuuedNelRPvsrgQa1JnHZWzozrSKlnO8CC84xD0+qCpfZM0rw4xvcKNlpdShH0PHEr9YMJMzhXRcfHDPbAFV6cM6yC+NRB2ZIrUZdSJo7u0+/cffp34q9hNZhPXC8f7qjJsTNKL26fsSEmPHI88F6BsuMcfvBsQ1ePEDk98LyUO4TdK1IOlA6E4iaL2Yykh8N9hmRGY1i8eX9TLDoneg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(7696005)(81166007)(36756003)(5660300002)(54906003)(6666004)(40460700003)(82310400004)(356005)(316002)(6916009)(30864003)(2906002)(4326008)(336012)(508600001)(2616005)(426003)(8676002)(86362001)(83380400001)(8936002)(186003)(26005)(47076005)(1076003)(70206006)(16526019)(70586007)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2022 00:23:13.2127 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69f05bb0-7f9e-49bf-e3f0-08da143ef994
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5962
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
Cc: Sean Keely <Sean.Keely@amd.com>, Sanjay Tripathi <sanjay.tripathi@amd.com>
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

v2: Reschedule the worker periodically to avoid soft lockup warnings

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
Reviewed-by: Sean Keely <Sean.Keely@amd.com> # v1
Tested-by: Sanjay Tripathi <sanjay.tripathi@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_events.c    | 119 +++++++++++++--------
 drivers/gpu/drm/amd/amdkfd/kfd_events.h    |   1 +
 drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c |  11 +-
 3 files changed, 88 insertions(+), 43 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
index 64f4a51cc880..0fef24b0b915 100644
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
 
@@ -769,9 +780,11 @@ static int init_event_waiter_get_status(struct kfd_process *p,
 	if (!ev)
 		return -EINVAL;
 
+	spin_lock(&ev->lock);
 	waiter->event = ev;
 	waiter->activated = ev->signaled;
 	ev->signaled = ev->signaled && !ev->auto_reset;
+	spin_unlock(&ev->lock);
 
 	return 0;
 }
@@ -783,8 +796,11 @@ static void init_event_waiter_add_to_waitlist(struct kfd_event_waiter *waiter)
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
@@ -804,10 +820,10 @@ static uint32_t test_event_condition(bool all, uint32_t num_events,
 	uint32_t activated_count = 0;
 
 	for (i = 0; i < num_events; i++) {
-		if (!event_waiters[i].event)
+		if (!READ_ONCE(event_waiters[i].event))
 			return KFD_IOC_WAIT_RESULT_FAIL;
 
-		if (event_waiters[i].activated) {
+		if (READ_ONCE(event_waiters[i].activated)) {
 			if (!all)
 				return KFD_IOC_WAIT_RESULT_COMPLETE;
 
@@ -836,6 +852,8 @@ static int copy_signaled_event_data(uint32_t num_events,
 	for (i = 0; i < num_events; i++) {
 		waiter = &event_waiters[i];
 		event = waiter->event;
+		if (!event)
+			return -EINVAL; /* event was destroyed */
 		if (waiter->activated && event->type == KFD_EVENT_TYPE_MEMORY) {
 			dst = &data[i].memory_exception_data;
 			src = &event->memory_exception_data;
@@ -846,11 +864,8 @@ static int copy_signaled_event_data(uint32_t num_events,
 	}
 
 	return 0;
-
 }
 
-
-
 static long user_timeout_to_jiffies(uint32_t user_timeout_ms)
 {
 	if (user_timeout_ms == KFD_EVENT_TIMEOUT_IMMEDIATE)
@@ -874,9 +889,12 @@ static void free_waiters(uint32_t num_events, struct kfd_event_waiter *waiters)
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
@@ -900,6 +918,9 @@ int kfd_wait_on_events(struct kfd_process *p,
 		goto out;
 	}
 
+	/* Use p->event_mutex here to protect against concurrent creation and
+	 * destruction of events while we initialize event_waiters.
+	 */
 	mutex_lock(&p->event_mutex);
 
 	for (i = 0; i < num_events; i++) {
@@ -978,14 +999,19 @@ int kfd_wait_on_events(struct kfd_process *p,
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
@@ -1044,8 +1070,7 @@ int kfd_event_mmap(struct kfd_process *p, struct vm_area_struct *vma)
 }
 
 /*
- * Assumes that p->event_mutex is held and of course
- * that p is not going away (current or locked).
+ * Assumes that p is not going away.
  */
 static void lookup_events_by_type_and_signal(struct kfd_process *p,
 		int type, void *event_data)
@@ -1057,6 +1082,8 @@ static void lookup_events_by_type_and_signal(struct kfd_process *p,
 
 	ev_data = (struct kfd_hsa_memory_exception_data *) event_data;
 
+	rcu_read_lock();
+
 	id = KFD_FIRST_NONSIGNAL_EVENT_ID;
 	idr_for_each_entry_continue(&p->event_idr, ev, id)
 		if (ev->type == type) {
@@ -1064,9 +1091,11 @@ static void lookup_events_by_type_and_signal(struct kfd_process *p,
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
@@ -1089,6 +1118,8 @@ static void lookup_events_by_type_and_signal(struct kfd_process *p,
 				p->lead_thread->pid, p->pasid);
 		}
 	}
+
+	rcu_read_unlock();
 }
 
 #ifdef KFD_SUPPORT_IOMMU_V2
@@ -1164,16 +1195,10 @@ void kfd_signal_iommu_event(struct kfd_dev *dev, u32 pasid,
 
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
@@ -1190,12 +1215,7 @@ void kfd_signal_hw_exception_event(u32 pasid)
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
 
@@ -1231,16 +1251,19 @@ void kfd_signal_vm_fault_event(struct kfd_dev *dev, u32 pasid,
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
 
@@ -1274,22 +1297,28 @@ void kfd_signal_reset_event(struct kfd_dev *dev)
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
@@ -1322,19 +1351,25 @@ void kfd_signal_poison_consumed_event(struct kfd_dev *dev, u32 pasid)
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
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c b/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c
index 9178cfe34f20..a9466d154395 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c
@@ -146,15 +146,24 @@ static void interrupt_wq(struct work_struct *work)
 	struct kfd_dev *dev = container_of(work, struct kfd_dev,
 						interrupt_work);
 	uint32_t ih_ring_entry[KFD_MAX_RING_ENTRY_SIZE];
+	long start_jiffies = jiffies;
 
 	if (dev->device_info.ih_ring_entry_size > sizeof(ih_ring_entry)) {
 		dev_err_once(dev->adev->dev, "Ring entry too small\n");
 		return;
 	}
 
-	while (dequeue_ih_ring_entry(dev, ih_ring_entry))
+	while (dequeue_ih_ring_entry(dev, ih_ring_entry)) {
 		dev->device_info.event_interrupt_class->interrupt_wq(dev,
 								ih_ring_entry);
+		if (jiffies - start_jiffies > HZ) {
+			/* If we spent more than a second processing signals,
+			 * reschedule the worker to avoid soft-lockup warnings
+			 */
+			queue_work(dev->ih_wq, &dev->interrupt_work);
+			break;
+		}
+	}
 }
 
 bool interrupt_is_wanted(struct kfd_dev *dev,
-- 
2.32.0

