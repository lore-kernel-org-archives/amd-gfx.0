Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD577E6748D
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Dec 2025 11:02:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63B3610E5F3;
	Mon, 22 Dec 2025 11:02:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="M9v0Cw8I";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012041.outbound.protection.outlook.com
 [40.107.200.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E0A810E5F3
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Dec 2025 11:02:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r2DZBZ1DNbU13IvEfGOcz94BmujrQs+qwbh6NQhsqU9tTWX9AC1Kts02Cm6yv0Tw+Os2YGQBcqnhbatKx32Nm6vEwh3EJQxucaidh018SIeskTbLthaCjWd8J4gSlmf7+meQh6hrkUfkmAk6A+oLvhKgQj0KnCez5xRxvA3jYoXT5t3kZbHxO6jZjjJ1josSu+e65bMAB1rhhW2PWtKjB2PtSREkMFWJabyxy/aiyo0cvTBNiAbjHir7pfD8DWEElqit9SEyq+ftTOxAWYpD1YTPCHQwxHclq04u8YZ8Qb3yNEZdp1IliPSFl7htOcAa30fKZ/FWEbWqcidP5boAnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GC4DsfNNbxRmlszBLHV4reRTdXaVAJA+zHHYuhD4nK4=;
 b=GC58w/o18ZYzHpKCKs6hxCd+gL+l68hy9bYQ4iDiZEbqG/MwlxHrm/jby9Qoq4+QxFN54ZS1CYkc6LC31GUg8nUvXg9EgE87JlJo9ZOpPrAGF4yGUCICcK4q9gu44JGhIyeilrNcYSgUAzUiM91nKHSTa3bZzYBNvlmqZVPEoFH9aoOPOsp9O+sJ/z+Xvn4HhEokdIUELPQymgNIX1voZoMs7zQNLPN7q6Kfgsr8JWEp5DnjSqfTapoQLGHV98dZmCXd/yIFrjiKHUaC8BaD4gOzs6nUJv943eFFWAL/mC96bnaJ775Yb7yh5/NmU92IKamvGdw4kjHMkMGSPQ1nIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GC4DsfNNbxRmlszBLHV4reRTdXaVAJA+zHHYuhD4nK4=;
 b=M9v0Cw8IJ/c1eqxis+Ag54fsqL5wXKHA7qdMjEKXtpYw8q3VZVgN4kt3S4ycp9TFd5w/v16jzIlJDb5x4vE2U4MqQqnHLHIw+O9WjtCGyeX54yy9EKSdDbKtqM8rnkXjiAyrlWr8DKz6NwtBgfkZalP6ANNK8UnRM6VJpdaTlCY=
Received: from BL1PR13CA0172.namprd13.prod.outlook.com (2603:10b6:208:2bd::27)
 by SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.11; Mon, 22 Dec
 2025 11:02:46 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:208:2bd:cafe::7c) by BL1PR13CA0172.outlook.office365.com
 (2603:10b6:208:2bd::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9456.10 via Frontend Transport; Mon,
 22 Dec 2025 11:02:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.9 via Frontend Transport; Mon, 22 Dec 2025 11:02:45 +0000
Received: from bingxguo-Super-Server.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 22 Dec 2025 05:02:43 -0600
From: Bingxi Guo <Bingxi.Guo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Deng Emily
 <Emily.Deng@amd.com>, Bingxi Guo <Bingxi.Guo@amd.com>
Subject: [PATCH] drm/amdgpu: Support fork process
Date: Mon, 22 Dec 2025 19:01:46 +0800
Message-ID: <20251222110146.464367-1-Bingxi.Guo@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|SA0PR12MB7091:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d3ebb9e-481e-47f7-cdac-08de4149a2e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PFAFiZV+nzMKOd9C8NOo+Axul95HOsDq4Rv9lve7j6Pv47eeRyo/mxr+q8ys?=
 =?us-ascii?Q?ytUtPSXnN/Yqgml4lIsDsZW5h4IToax3EXo4+Sn4f4KGLKDvqjyucQ+8MpMJ?=
 =?us-ascii?Q?7XgmGvglfyUd3NjP9NsEW0GKq6j+Vk7azaKKAiX1J6c3z+zeXivUrHjw6nXk?=
 =?us-ascii?Q?S+8hn9yJVG0rClHpJ+dvNj6D6MyG5RBFuARiKz2uKoyWszZkXl9Y+c8FelTX?=
 =?us-ascii?Q?r1zcOWEQ02dTuHe39P8CXoRESVF2eht6q9VCkstr5nYUMnPAXyX+Fino2FLl?=
 =?us-ascii?Q?ZRXvdG7kySPfDAYbiu0Br+eUuC2O5Ajj+4drdNUig2W3FJlqzUbWP/w+5wVY?=
 =?us-ascii?Q?xeMCfKv3YP+981tHM3Ff+ZGRSK9EisD9pOM4dX/fCVZWesO+WKTVdjiP0vra?=
 =?us-ascii?Q?Uop0zaO/rLIl4T12hhPd+ZmNIhvEsH1BCP4qh1mBoElaGTp5vYoeCoz8n/ym?=
 =?us-ascii?Q?R6nr1wuUbTT98r6VbA93kT4OjJ0Jlg2KwUtZC6PY4uWEQvk9SBvUjnQGfTdq?=
 =?us-ascii?Q?332JsB4Ue5Kr2ftaLW9boY1///zLd6YPf1iDOi6KmOUjejqCWYytyh87de7r?=
 =?us-ascii?Q?f8z2zk30Zj0L9RRvEgAiwQMX5QNFDDTlR8S0oIiMIfWiNSOd1idyudGmcfIi?=
 =?us-ascii?Q?7tajksxW/iNcJLDx7MFy98W8DKNAay1ywt1DLVwDe7tRN5jBqyYIdXbJbBYm?=
 =?us-ascii?Q?qCAVDCh1RHCC1hjLhnQQ9kgkLuWO91ain1Xh2T0Bo6j5ef4vQ4Y0RxLuSc+x?=
 =?us-ascii?Q?HCS8MmNVsbw4pZ+9EMbbnjN8dp3dCyyFuMcnCP4+FdqmC5mBOJ87j7ipXyww?=
 =?us-ascii?Q?VdqQKmClMZFxNZbtxP2Xf7oVoQ7XHP0M4gamkLa/RVgKicMv8AlSI3gQ+nB3?=
 =?us-ascii?Q?DSyAoQwEbXy4Y/FlaRDcSu/W8Aa/Y8fiQ1sqUUanDEibCSFLaPqLwbhjuv7R?=
 =?us-ascii?Q?afMN9ghwlyYyL4a24jx6LifJkWJlBkEYIuhUpR3bNLY/8vMZ+BI/5STWOMT8?=
 =?us-ascii?Q?OMIEsjSV38MNL5uIUpEFsirPjrhcEbIqklowzJb9PgrDIe1QzN0E7wi9D6dl?=
 =?us-ascii?Q?d7+W/shTYGI6/EgCu/cVpnXnlCUH3yyXMAyoLe1496WnBHH5LGHHfsJ7C3Vb?=
 =?us-ascii?Q?F4qrelrgpDwrTpQWKToeBPwZm3rVcgFl3uq1riHFNyAYCBMaHsnYU6xPX2aE?=
 =?us-ascii?Q?dDkI5tdua04wa7+aBmeIlFZ6QPzrKK++9jI8dbqsmYzgUIMe7KNsvUzqRYpv?=
 =?us-ascii?Q?EhhdCtuzWl4L4myzAXXXcaZGt/p+Gw88/dKzc6DtLUzbheNDMPbbo7DepA4D?=
 =?us-ascii?Q?L04/XxR6DFSq/fCbAMaujFqEwRKYWZ2B4W5T1mNNwFDtCO90E3pZqT8sCtT+?=
 =?us-ascii?Q?74yd0fT6fPfJgg18PteDuiKRhDdLkAZD8eskKWNuo6YjDlxLykPmf/AmJxBB?=
 =?us-ascii?Q?ZCYvtM5RlI9Jbmbbw0Q86BISyYEzBjxwAWt4W/w8oFp7LJV0jxDYAlLMtA/Y?=
 =?us-ascii?Q?VMbqnMnIV+ufsgUONbTMwBop3NzjMQNtWGlcUQQZlyzjx0bnduwQvO6ZO9gh?=
 =?us-ascii?Q?STIFF259rA4wNEkGMfk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2025 11:02:45.4062 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d3ebb9e-481e-47f7-cdac-08de4149a2e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7091
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

When a process forks, the child inherits the open DRM file descriptor.
If the parent is killed (e.g., by SIGKILL), only the parent's jobs
are canceled. The child process can continue submitting jobs to the
same entity through its own user entry in the entity's user list.

Signed-off-by: Emily Deng <Emily.Deng@amd.com>
Signed-off-by: Bingxi Guo <Bingxi.Guo@amd.com>
---
 drivers/gpu/drm/scheduler/sched_entity.c | 133 +++++++++++++++++++----
 include/drm/gpu_scheduler.h              |  22 ++++
 2 files changed, 135 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index 8867b95ab089..508a0629b839 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -110,6 +110,9 @@ int drm_sched_entity_init(struct drm_sched_entity *entity,
 	atomic_set(&entity->fence_seq, 0);
 	entity->fence_context = dma_fence_context_alloc(2);
 
+	INIT_LIST_HEAD(&entity->users);
+	spin_lock_init(&entity->users_lock);
+
 	return 0;
 }
 EXPORT_SYMBOL(drm_sched_entity_init);
@@ -228,10 +231,24 @@ static void drm_sched_entity_kill(struct drm_sched_entity *entity)
 {
 	struct drm_sched_job *job;
 	struct dma_fence *prev;
+	struct drm_sched_entity_user *user;
+	struct spsc_queue temp_queue;
+	pid_t my_tgid = task_tgid_nr(current);
 
 	if (!entity->rq)
 		return;
 
+	/* Mark current process as exited */
+	spin_lock(&entity->users_lock);
+	list_for_each_entry(user, &entity->users, list) {
+		if (user->tgid == my_tgid) {
+			atomic_set(&user->exited, 1);
+			break;
+		}
+	}
+	spin_unlock(&entity->users_lock);
+
+	/* Temporarily stop entity to prevent new jobs */
 	spin_lock(&entity->lock);
 	entity->stopped = true;
 	drm_sched_rq_remove_entity(entity->rq, entity);
@@ -240,27 +257,59 @@ static void drm_sched_entity_kill(struct drm_sched_entity *entity)
 	/* Make sure this entity is not used by the scheduler at the moment */
 	wait_for_completion(&entity->entity_idle);
 
-	/* The entity is guaranteed to not be used by the scheduler */
+	/*
+	 * The entity is stopped and idle. No new jobs can be pushed.
+	 * Scan the queue and separate jobs:
+	 * - Jobs from this process: kill immediately
+	 * - Jobs from other processes: keep in temp_queue
+	 */
+	spsc_queue_init(&temp_queue);
 	prev = rcu_dereference_check(entity->last_scheduled, true);
 	dma_fence_get(prev);
+
 	while ((job = drm_sched_entity_queue_pop(entity))) {
-		struct drm_sched_fence *s_fence = job->s_fence;
-
-		dma_fence_get(&s_fence->finished);
-		if (!prev ||
-		    dma_fence_add_callback(prev, &job->finish_cb,
-					   drm_sched_entity_kill_jobs_cb)) {
-			/*
-			 * Adding callback above failed.
-			 * dma_fence_put() checks for NULL.
-			 */
-			dma_fence_put(prev);
-			drm_sched_entity_kill_jobs_cb(NULL, &job->finish_cb);
+		if (job->owner_tgid == my_tgid) {
+			/* Kill this job */
+			struct drm_sched_fence *s_fence = job->s_fence;
+
+			dma_fence_get(&s_fence->finished);
+			if (!prev ||
+			    dma_fence_add_callback(prev, &job->finish_cb,
+						   drm_sched_entity_kill_jobs_cb)) {
+				dma_fence_put(prev);
+				drm_sched_entity_kill_jobs_cb(NULL, &job->finish_cb);
+			}
+			prev = &s_fence->finished;
+		} else {
+			/* Keep jobs from other processes */
+			spsc_queue_push(&temp_queue, &job->queue_node);
 		}
+	}
 
-		prev = &s_fence->finished;
+	/* Put back jobs from other processes */
+	while (true) {
+		struct spsc_node *node = spsc_queue_pop(&temp_queue);
+		if (!node)
+			break;
+		spsc_queue_push(&entity->job_queue, node);
 	}
+
 	dma_fence_put(prev);
+
+	/* Check if there are other active users and restore entity if needed */
+	spin_lock(&entity->users_lock);
+	list_for_each_entry(user, &entity->users, list) {
+		if (!atomic_read(&user->exited)) {
+			/* Found active user, restore entity */
+			spin_unlock(&entity->users_lock);
+			spin_lock(&entity->lock);
+			entity->stopped = false;
+			drm_sched_rq_add_entity(entity->rq, entity);
+			spin_unlock(&entity->lock);
+			return;
+		}
+	}
+	spin_unlock(&entity->users_lock);
 }
 
 /**
@@ -323,6 +372,8 @@ EXPORT_SYMBOL(drm_sched_entity_flush);
  */
 void drm_sched_entity_fini(struct drm_sched_entity *entity)
 {
+	struct drm_sched_entity_user *user, *tmp;
+
 	/*
 	 * If consumption of existing IBs wasn't completed. Forcefully remove
 	 * them here. Also makes sure that the scheduler won't touch this entity
@@ -338,6 +389,14 @@ void drm_sched_entity_fini(struct drm_sched_entity *entity)
 
 	dma_fence_put(rcu_dereference_check(entity->last_scheduled, true));
 	RCU_INIT_POINTER(entity->last_scheduled, NULL);
+
+	/* Clean up user list */
+	spin_lock(&entity->users_lock);
+	list_for_each_entry_safe(user, tmp, &entity->users, list) {
+		list_del_rcu(&user->list);
+		kfree_rcu(user, rcu);
+	}
+	spin_unlock(&entity->users_lock);
 }
 EXPORT_SYMBOL(drm_sched_entity_fini);
 
@@ -567,9 +626,40 @@ void drm_sched_entity_select_rq(struct drm_sched_entity *entity)
 void drm_sched_entity_push_job(struct drm_sched_job *sched_job)
 {
 	struct drm_sched_entity *entity = sched_job->entity;
+	struct drm_sched_entity_user *user, *found = NULL;
+	pid_t my_tgid = task_tgid_nr(current);
 	bool first;
 	ktime_t submit_ts;
 
+	/* Check if entity is stopped and reject directly */
+	if (entity->stopped)
+		goto error;
+
+	/* Entity is running, check user list */
+	spin_lock(&entity->users_lock);
+	list_for_each_entry(user, &entity->users, list) {
+		if (user->tgid == my_tgid) {
+			found = user;
+			/* Reject if this user has exited */
+			if (atomic_read(&user->exited)) {
+				spin_unlock(&entity->users_lock);
+				goto error;
+			}
+			break;
+		}
+	}
+
+	/* If not found, create new user (fork case) */
+	if (!found) {
+		found = kzalloc(sizeof(*found), GFP_ATOMIC);
+		if (found) {
+			found->tgid = my_tgid;
+			atomic_set(&found->exited, 0);
+			list_add_tail(&found->list, &entity->users);
+		}
+	}
+	spin_unlock(&entity->users_lock);
+
 	trace_drm_sched_job_queue(sched_job, entity);
 
 	if (trace_drm_sched_job_add_dep_enabled()) {
@@ -582,6 +672,9 @@ void drm_sched_entity_push_job(struct drm_sched_job *sched_job)
 	atomic_inc(entity->rq->sched->score);
 	WRITE_ONCE(entity->last_user, current->group_leader);
 
+	/* Record owner TGID */
+	sched_job->owner_tgid = my_tgid;
+
 	/*
 	 * After the sched_job is pushed into the entity queue, it may be
 	 * completed and freed up at any time. We can no longer access it.
@@ -597,12 +690,6 @@ void drm_sched_entity_push_job(struct drm_sched_job *sched_job)
 
 		/* Add the entity to the run queue */
 		spin_lock(&entity->lock);
-		if (entity->stopped) {
-			spin_unlock(&entity->lock);
-
-			DRM_ERROR("Trying to push to a killed entity\n");
-			return;
-		}
 
 		rq = entity->rq;
 		sched = rq->sched;
@@ -618,5 +705,11 @@ void drm_sched_entity_push_job(struct drm_sched_job *sched_job)
 
 		drm_sched_wakeup(sched);
 	}
+	return;
+
+error:
+	dma_fence_set_error(&sched_job->s_fence->finished, -EPERM);
+	drm_sched_fence_scheduled(sched_job->s_fence, NULL);
+	drm_sched_fence_finished(sched_job->s_fence, -EPERM);
 }
 EXPORT_SYMBOL(drm_sched_entity_push_job);
diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
index e62a7214e052..45e066596405 100644
--- a/include/drm/gpu_scheduler.h
+++ b/include/drm/gpu_scheduler.h
@@ -59,6 +59,16 @@ struct drm_sched_rq;
 
 struct drm_file;
 
+/**
+ * struct drm_sched_entity_user - Per-process entity user tracking
+ */
+struct drm_sched_entity_user {
+	struct list_head		list;
+	struct rcu_head			rcu;
+	pid_t				tgid;
+	atomic_t			exited;
+};
+
 /* These are often used as an (initial) index
  * to an array, and as such should start at 0.
  */
@@ -233,6 +243,13 @@ struct drm_sched_entity {
 	 */
 	struct rb_node			rb_tree_node;
 
+	/**
+	 * @users:
+	 *
+	 * List of processes using this entity (for fork support)
+	 */
+	struct list_head		users;
+	spinlock_t			users_lock;
 };
 
 /**
@@ -385,6 +402,11 @@ struct drm_sched_job {
 	 * drm_sched_job_add_implicit_dependencies().
 	 */
 	struct xarray			dependencies;
+
+	/**
+	 * @owner_tgid: TGID of the process that submitted this job
+	 */
+	pid_t				owner_tgid;
 };
 
 /**
-- 
2.43.0

