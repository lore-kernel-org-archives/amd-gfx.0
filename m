Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7655AC44501
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 13:17:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1528B10F05A;
	Wed, 15 Jul 2026 13:17:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="si2QVp2H";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012061.outbound.protection.outlook.com [52.101.48.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C2DB10F05E
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 13:17:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kAv6HEoWRnFNGmd3dUwj0qFHkbDaWaDcQnxt3QIXQb+lgJ/Lxs42nxM3mMeWnwgNKXta8SLc4sCmXaPAktAKfDsnhAcTKSNW7/2D7RojEW0BPQfbk3i9TK/J/k1YJFXmWQSb96lstY5XFXfSd8NuvimbcCVmkyY4B2hx4Y7PKQedbU1BiPgd/VQtvhQuJpaDydhAp3CfwaIyPDK7nlvrILrULqNlpzc9KMigGGPKY5vyEScsYFnchrMksTSD4FtysqI7PYHspdykWALiaiuXI4wKf7Nu891S/1EDh9qL0YPCW7zqGJP1V0yHYY/slA7RGNERzivTBx/FKT215waywA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Om+slnwM8qfLYT9s1YjVWvcc4oNuSz/Tk4+HouSYJXo=;
 b=GXQaXeDgG3YVbI1BkcDHk7VFIimLQu997vBCc6ry00IMqtuwjdJkS8KSxETH00MZ0OOsLwsjZ/bOtY4prW219SUVChPN8tDPn2zNG3/t+067jA+y2KiV7asSksCt50aXZcdqLtb/OyGdu53puPfrUBIJlL8TMlgYIroPFWNwRwtQ8HvfhXDvTUqsnCwc2yd9fug0dP5P6m8r2nnhSv2AdGgNWJG6E8NjiJHcgzSxoKWsR0P/A0oxBW2P8vVPT3ejt0o4W29+s88roQtQ4DYzR+2JjUSCXOjWlozVpfeo0WPI8lrApsz09uwK54PUoDagyecr/71QBIUb/Ddb7ayjLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Om+slnwM8qfLYT9s1YjVWvcc4oNuSz/Tk4+HouSYJXo=;
 b=si2QVp2HW1lIVg9DCXxom7ZLpRviFQy+WvBdKcLgH8By4+zsb5vPzG/HQpFOSu9cvpLPi77vh8FL1/zpL6o73GU4oR0rVYQDKH4XXvFkn6B1ex0m70tVA6JZzwlgLT1TQw/aIzRTbfcdeC+n9jN3G7FhkMyY1G7oH+A0O0BhGtw=
Received: from BN9PR03CA0135.namprd03.prod.outlook.com (2603:10b6:408:fe::20)
 by DS4PR12MB9659.namprd12.prod.outlook.com (2603:10b6:8:27f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Wed, 15 Jul
 2026 13:17:33 +0000
Received: from BN2PEPF000055E1.namprd21.prod.outlook.com
 (2603:10b6:408:fe:cafe::3e) by BN9PR03CA0135.outlook.office365.com
 (2603:10b6:408:fe::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.11 via Frontend Transport; Wed,
 15 Jul 2026 13:17:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000055E1.mail.protection.outlook.com (10.167.245.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.3 via Frontend Transport; Wed, 15 Jul 2026 13:17:32 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Wed, 15 Jul 2026 08:17:25 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v10 4/5] drm/amdgpu: Record USERQ_EOP WAIT_EVENT notifications
Date: Wed, 15 Jul 2026 18:47:03 +0530
Message-ID: <20260715131704.3452312-5-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260715131704.3452312-1-srinivasan.shanmugam@amd.com>
References: <20260715131704.3452312-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E1:EE_|DS4PR12MB9659:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a50d6a4-014f-4dfd-c501-08dee2736df4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|82310400026|1800799024|6133799003|56012099006|11063799006|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info: wMej3dG4XuVt/xC3iLK+j8Vhvx+BLfKSGf74UAG07RIB63YxVgsEYd9dRpm6ELKhVCx2uRwhS0B8kIqms0xdDmoRzik9pxWA03IdRB768GAVzF48yp4xOUAGXDEmpnHTWcC+cP0SdVxevCAXQklIvxhbgOxrDP61jDj/0ZsEPmA6B3fF2AAdcDSHEFGF6O5B9yoLcWbwEu28167U8DXbhZWMe6cGhnpcQtLfx5kLe8p3GL1nCzyNYvmVZJcQNJ/dFO8wJSdXKJfn+lDhPv71wYfRBMEz67l/Nb23nVzil5GSpn6uY9H8O2lNNX8pa6Sbo0XVrDyQgUzC05BQRQ8rmNBPtLgh8AKwv8GI1b6jcivLhhR8EtVVzZlKtE7ZGM7utY1NM9eGBXAlMjm8oEf6iOFvvXRh71X1emoHYf72+TQKfsdmnodr8xN0Q3AtSMFk3NuiEVg2mTn/2B2j0GNdJpc2NPJWoChaUcmT6AhV6d+edEbbgGtXw6zSFBT4mkzA74jGEsdPpWgG6t3czgu5vDJ4xcmkXisEe5VwyAd3WN1H07h5eAUtnC60l8Bn92JrrUHcm2qWii7eWMi+xZl6gi1fbRNZXTBtXER66x0cyBaXpU8DXnTJtcDVDm4GYM6T4rzYcwbABWhzZOHyAZILInGo0GxY/gegkDWTfG1o0iD25sGygwYkUCbSiy6DZZeBMOnk2uigRf69xAGOA03Wzw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(6133799003)(56012099006)(11063799006)(18002099003)(22082099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lQrAIXJcoGj2dI7zTmhklpbbchOWQAl5O+L2uEKlx0Pfq0EzenbGdWpXiqOcAJEJ5e38A/3CHo3Te7eQuON8d9HxjlkNLo+KJv1/6Nrb38XKQJ6uAJuBMY5H1LGRckjVXBXkK9Hq9ZMU9mhnQAGP8nR2YqsecD/yP42tyBqrwwA+fQk8Fc/oaZcF2/0IvPurR4AD/eT+4QceAkhM9ZFUH4GmpodSVnkGVE2XpC/RaNpyd/4jdGvgaEk9ON8eyGur5c1K8CEovWyF7GblI5rh2ZLNUtRYzMfWD5+rnZU2ZDSRKb8QIxjaA8yDqfx7+zqphO3iHYimOS62e8alo0ja09xv3/EMGwltLJJSrlK0FyaQyAdRmfH7IXasSqB6c4f5cbo+Ojc8AsRofH6cs3ogwjzow79C3sV0iHiz3RJZpXSoc0deVDPoBJyjagusBEa7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 13:17:32.6634 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a50d6a4-014f-4dfd-c501-08dee2736df4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055E1.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9659
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
index aa17e55d52e8..28f9d3fe0e80 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -264,6 +264,7 @@ void amdgpu_userq_process_fence_irq(struct amdgpu_device *adev, u32 doorbell)
 	struct xarray *xa = &adev->userq_doorbell_xa;
 	struct amdgpu_usermode_queue *queue;
 	struct amdgpu_eventfd_mgr *eventfd_mgr;
+	struct amdgpu_wait_event_mgr *wait_event_mgr;
 	unsigned long flags;
 	int r;
 
@@ -286,6 +287,11 @@ void amdgpu_userq_process_fence_irq(struct amdgpu_device *adev, u32 doorbell)
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

