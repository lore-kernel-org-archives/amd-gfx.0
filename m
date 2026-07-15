Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89A6CC4450E
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 14:26:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F10B10F0DF;
	Wed, 15 Jul 2026 14:26:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="I4La/VHJ";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012034.outbound.protection.outlook.com [52.101.53.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A7AC10F0DF
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 14:26:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vhs5BxWsBuSk4YFAzmwjyAo34hE2wn1IMsdwp27+JGQAFfNYeRqQ/s2KagbO6eFOsDrWbelayfdouy2remFvfn2lry3eJQp/lIV0Sg2B7nxsw2gfdJBnILrjBtWhY8aK2skv9eGvVmr10hRTU7is/YeFYeVteeIUJo+I7bAN5lpIacn3xH9rlxlzMTpX+mc5p1f/Ve7VRghc34FiyxlvXN5ufuwKsIMGr34GTazgf/9H79AEVjibnLymwLMKCrORoOS8zDqE7UlUwYWzxHUAjU8j8mUwU2neb2b9/hwFKhsqLWAaJd7TA/GYPVFqThJdHFvBAgqlePidtdke2nXwbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RP9w81q1ru3zdAMeTO7KgYMKpx3bFG3evkmzLsVVbUk=;
 b=A8cxsjVWjOz3Uc/87dMHYqVL+CyKOK7E3amm1NsPxhYaPk6IBpDD00Bl2vmEpqJDPRpKsV8xkWy6EhVr8FtqUQ+MHIMBSqgiMrUDNs5gDqnhPUI69TYtN2m+eF84IRvvtlUHMSwAe0Bp4cxWiLGK9gzNw3DkhDVeboHWFTrBM6mwAPFGw44p1VzLn46SitYfJr3PlJXkg+2EVvgpJsLYVGDLfuHEYwO8lxS/95gFZnZsGx8Z9fbiJ9PDW4tJF3F7YcVJsiwHvOCgQkQY3JC32NeOYEUr5Gl0CWqgmVoV3ZVNMrTe5aKk617T24UflCVBfZrk6jm68AO9s96oLyjBXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RP9w81q1ru3zdAMeTO7KgYMKpx3bFG3evkmzLsVVbUk=;
 b=I4La/VHJronOm1zL/L2oWj96pf+Ct25Aegsi7GpGMMiAPmvRS7nL/+mO65J+hqfe33hJMsaf8cGR3gpcYQtfLKZdWxj/12ZmMgDeavraO8UON8fECYkhybiPxteRvrTEGBtlU1Y7TUSVAm6s89z66peLyBmsueZRQwdwNZmd6bU=
Received: from SJ0PR13CA0035.namprd13.prod.outlook.com (2603:10b6:a03:2c2::10)
 by DM6PR12MB4044.namprd12.prod.outlook.com (2603:10b6:5:21d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Wed, 15 Jul
 2026 14:26:07 +0000
Received: from SJ5PEPF000001CB.namprd05.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::ac) by SJ0PR13CA0035.outlook.office365.com
 (2603:10b6:a03:2c2::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.10 via Frontend Transport; Wed,
 15 Jul 2026 14:26:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CB.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 14:26:06 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Wed, 15 Jul 2026 09:26:01 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v11 4/5] drm/amdgpu: Record USERQ_EOP WAIT_EVENT notifications
Date: Wed, 15 Jul 2026 19:55:41 +0530
Message-ID: <20260715142542.3475265-5-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260715142542.3475265-1-srinivasan.shanmugam@amd.com>
References: <20260715142542.3475265-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CB:EE_|DM6PR12MB4044:EE_
X-MS-Office365-Filtering-Correlation-Id: f6fe9368-aacb-45a4-2214-08dee27d0200
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|23010399003|36860700016|1800799024|11063799006|56012099006|6133799003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: r3KtGblSm3hdEKoAqRLNk3ZvYb52Ryqkz58AE300T5h1rrgC/NOnZiId2yZD+DIFr1a3zV8OsRLHcJBAraWcEe9WPJ6fX1CdjSex/qGw6hvTw4pcSm8KYelBFHOacclCufnIM66L0eWkb6MUrUsb94w2MQqsNF2/mNAKOf5zTY/qi3SS1LW3SL6zbjdi/gqELEXMcK6jHrF/TU3GFE0T2D9O9MtIdV7C8ZWNHvyDEHNo9Ytuymnllw6nMPnsU+cMQPKLNVKdmZqWDzMEu8YeL4RZtI21G+E23LW+h+e2T5hMjdFjtDVG491E/XyVoqUcZ5LpfSwA6sqXKuFINpNtcMwa5qseOeH6A7+U6aH3MVD93svcfHW75sVBf9feRhSk03n8CS9i4Rnzo6NgSobTb9JT0ZemGs0m30J6QFgYnoJnrljGcNMI1v9luyzYSKWQVO4lvCz5sP4TeZn9ZfXrzuX5MCo401oN949H175JvIdErJYiS6kuCchVOR7Lu4PY4uuM7eXy9LLTgTDj8Iunn8k54fH2iDERqpwmTSMdSr61EltiD7cEK8U85HNFDCBuU2PrnCCixMcSvkLw2K4tW0NgvfM3q70eV1D9gnSudioRNdDBHhULqMQ5+ZHB27pA6+OyUqpvHjnXUoKoeCOKDXBvyIb7RPIXGbhwTsJ8mJvX4yrnsFM1G+2tpNPPn3hiMWAhuYd4qgg7UuodH/d9QA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(23010399003)(36860700016)(1800799024)(11063799006)(56012099006)(6133799003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: eS/GedEgk7T7KQqhoA7uxZIhOa/bHVPCPGGjGVoJUNzCxUZozaFNT2h9hR4zwbCd/w5HnkqyJ4VB5ruJzip6aJCKC3k21bTWqTUJy0oLZ1sLOKAo2cNpoFM1Q3q+nDxSACVGCyRLqRwPwfcz/RJeuIe4tN5ChoE6OPQRUKdFFPaWmln5Z5TTKfUrtJSNH5hUppr+Xy7R2CBmSx1dsR7vmE1MBs/YX4VgV9v5R5B9LOVktgy2WsNNuxA4NzTEsL59fbrp79QlHIzkjQiWt8QO9QY78y2VLynLwLVbkUVoIZrHHNngEOJOP6zY56APt6Rc8BiveN9iwBQzhb5+RZ0hFt/rZ7VVCiDsewhpNE9/NNR/oiFhryaGruBZnyUGyRA77gghgfo75fIQhf1amfFpHlgmd6jhEK21UjMieXcqLKjD+eM/RKw7Ct0vAvV6BU8V
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 14:26:06.4275 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6fe9368-aacb-45a4-2214-08dee27d0200
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4044
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

WAIT_EVENT currently provides the per-file queue, matching, and lifetime
infrastructure, but no producer creates records when a user queue fence
completes.

Add an IRQ-safe helper which appends a WAIT_EVENT record using the queue
pointer as the internal routing key. The record takes a queue reference
before it is published and releases it through the existing record
cleanup paths.

The producer does not translate the queue pointer back to a queue ID.
Instead, the WAIT_EVENT ioctl adds the queue ID supplied by the waiter
to the matched record immediately before returning it to userspace. This
keeps queue IDs at the UAPI boundary while retaining queue-pointer-based
matching internally.

Call the helper from amdgpu_userq_process_fence_irq(), next to the
existing EVENTFD notification. This reuses the established
doorbell-to-queue lookup and does not add another queue lookup or change
the GFX interrupt handling.

Changes since v9:
- Keep queue pointers for internal event matching.
- Populate queue_id in returned metadata at the WAIT_EVENT ioctl
  boundary.
- Clarify the producer and ioctl matching flow in the kerneldoc.

Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     |  6 ++
 .../gpu/drm/amd/amdgpu/amdgpu_wait_event.c    | 85 ++++++++++++++++++-
 2 files changed, 89 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index db97cd42e81a..edf6c3e91900 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -279,6 +279,7 @@ void amdgpu_userq_process_fence_irq(struct amdgpu_device *adev, u32 doorbell)
 	struct xarray *xa = &adev->userq_doorbell_xa;
 	struct amdgpu_usermode_queue *queue;
 	struct amdgpu_eventfd_mgr *eventfd_mgr;
+	struct amdgpu_wait_event_mgr *wait_event_mgr;
 	unsigned long flags;
 	int r;
 
@@ -301,6 +302,11 @@ void amdgpu_userq_process_fence_irq(struct amdgpu_device *adev, u32 doorbell)
 		amdgpu_eventfd_signal(eventfd_mgr,
 				      DRM_AMDGPU_EVENT_TYPE_USERQ_EOP,
 				      queue);
+
+		wait_event_mgr = amdgpu_userq_wait_event_mgr(queue->userq_mgr);
+		amdgpu_wait_event_add(wait_event_mgr,
+				      DRM_AMDGPU_EVENT_TYPE_USERQ_EOP,
+				      queue);
 	}
 	xa_unlock_irqrestore(xa, flags);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.c
index db612106fb12..7f22f950bfd6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.c
@@ -40,7 +40,8 @@
  * of jiffies. A negative deadline requests an indefinite wait.
  *
  * The caller recalculates the remaining time after every wakeup so that
- * spurious wakeups do not extend the userspace deadline.
+ * interrupted or spurious wakeups continue to honor the original
+ * userspace deadline.
  *
  * Return:
  * Remaining wait time in jiffies, zero if the deadline has expired, or
@@ -98,6 +99,35 @@ static bool amdgpu_wait_event_valid_type(u32 event_type)
 	}
 }
 
+/**
+ * amdgpu_wait_event_set_queue_id - populate queue-scoped event metadata
+ * @rec: matched WAIT_EVENT record being returned
+ * @queue_id: userspace USERQ queue handle
+ *
+ * Store the queue handle in the common record header and in the
+ * event-specific metadata for queue-scoped events.
+ */
+static void
+amdgpu_wait_event_set_queue_id(struct amdgpu_wait_event_record *rec,
+			       u32 queue_id)
+{
+	rec->data.queue_id = queue_id;
+
+	switch (rec->data.event_type) {
+	case DRM_AMDGPU_EVENT_TYPE_USERQ_EOP:
+		rec->data.u.queue.queue_id = queue_id;
+		break;
+	case DRM_AMDGPU_EVENT_TYPE_QUEUE_RESET:
+		rec->data.u.reset.queue_id = queue_id;
+		break;
+	case DRM_AMDGPU_EVENT_TYPE_SCRATCH:
+		rec->data.u.scratch.queue_id = queue_id;
+		break;
+	default:
+		break;
+	}
+}
+
 /**
  * amdgpu_wait_event_record_free - release a pending event record
  * @rec: record to release
@@ -269,6 +299,48 @@ void amdgpu_wait_event_mgr_init(struct amdgpu_wait_event_mgr *mgr)
 	mgr->dead = false;
 }
 
+/**
+ * amdgpu_wait_event_add - append a queue-scoped WAIT_EVENT record
+ * @mgr: per-file WAIT_EVENT manager
+ * @event_type: kernel-defined AMDGPU event type
+ * @queue: queue which generated the event
+ *
+ * This helper can be called from interrupt context. Allocate the record
+ * with GFP_ATOMIC and take a queue reference before publishing it on the
+ * manager's pending list.
+ *
+ * The queue pointer is retained as the internal routing key. queue_id is
+ * copied from the producing queue only as metadata returned to userspace.
+ */
+void amdgpu_wait_event_add(struct amdgpu_wait_event_mgr *mgr,
+			   u32 event_type,
+			   struct amdgpu_usermode_queue *queue)
+{
+	struct amdgpu_wait_event_record *rec;
+	unsigned long flags;
+
+	rec = kzalloc(sizeof(*rec), GFP_ATOMIC);
+	if (!rec)
+		return;
+
+	kref_get(&queue->refcount);
+	rec->queue = queue;
+	rec->data.event_type = event_type;
+	rec->data.seqno = atomic64_inc_return(&mgr->seqno);
+
+	spin_lock_irqsave(&mgr->lock, flags);
+	if (mgr->dead) {
+		spin_unlock_irqrestore(&mgr->lock, flags);
+		amdgpu_wait_event_record_free(rec);
+		return;
+	}
+
+	list_add_tail(&rec->node, &mgr->pending);
+	spin_unlock_irqrestore(&mgr->lock, flags);
+
+	wake_up_interruptible(&mgr->wq);
+}
+
 /**
  * amdgpu_wait_event_mgr_fini - finalize a per-file WAIT_EVENT manager
  * @mgr: manager to finalize
@@ -350,7 +422,13 @@ void amdgpu_wait_event_remove_queue(struct amdgpu_wait_event_mgr *mgr,
  *
  * deadline_ns is an absolute CLOCK_MONOTONIC deadline. The remaining wait
  * interval is recomputed from the original deadline after every wakeup so
- * that spurious wakeups cannot extend the requested deadline.
+ * that interrupted or spurious wakeups cannot extend the requested
+ * deadline.
+ *
+ * For queue-scoped events, queue_id is resolved to a queue pointer before
+ * waiting. Pending records are matched using queue pointer equality. After
+ * a record is matched, the request queue_id is written to the returned
+ * metadata.
  *
  * Return:
  * Zero on success or a negative error code.
@@ -412,6 +490,9 @@ int amdgpu_wait_event_drm_ioctl(struct drm_device *dev, void *data,
 		}
 	}
 
+	if (queue)
+		amdgpu_wait_event_set_queue_id(rec, args->queue_id);
+
 	if (copy_to_user(u64_to_user_ptr(args->out_ptr), &rec->data,
 			 sizeof(rec->data)))
 		ret = -EFAULT;
-- 
2.34.1

