Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2508C44501
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jul 2026 13:21:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E06610F307;
	Thu, 16 Jul 2026 13:21:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4N8dyFhx";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011018.outbound.protection.outlook.com [52.101.62.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BCA010F307
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jul 2026 13:21:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WBZwCcJc0w1QGTCSMahw/zfmykAJ4wnd8w9gvnIyhY0ELneogdguMF1Lz57UoNV12uqDn/PRjId5NRiAWNnvmrHTofeRRJpLkV9x1+sCN7p51CcGWpU7ihjPwm81ew/PDebOFUegUUYB+nKd2lObbHKzAa7/Ack2TVQJ/5ixoJ9iIm1Q9DR1eeNTtmwn3n4DJoUecOWvfFH8DWBzV7NpSRLY6HevzPKXYE1DiSbYGk2gAgUvFUOAKSqe4a5zLRrP6l14+uRgGvOC4fQlhuIMrEln6/hNZcvYKAQV1QLGRdKA300ibY2Bhr+jnJllWBgS3D7tjYNOcbY58v4cmAsvtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PztLk1n7htRUiW85htYq7zipC0Vv9oorf3ZzX9Dhx4s=;
 b=Kq6bCc4Y3kppLRkDeQAknDeFJPKSlTXdcIYRG2iRKXDYPymepWHsJUcnxuYVCII+N71XRgbnj69z1v0Zx9z8LJqp3UMQce9E1wO4dAhhefIv6dvDa1SIgQ1mLJhYGyFXZGiB9f9HxYtDKt+9Fu9wrTXTx/d/5gFjYQvrbCmCt1CsxJkbiuHC1CIgBqw+JrLXeBXYcJAlG5Hl2dFUZjcXyWAl0wPXNgi6vG6U9mKSR1k43SPWAs9/r5XKOlTMNsUhSqmrHa8DBV6POt0CVsAnyhp/1BAfc9+GtdXiKoCzjw6Ya4YQegxST3/cy8syF9uv8ZnrQAC7nYvfgEwvK6ZAAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PztLk1n7htRUiW85htYq7zipC0Vv9oorf3ZzX9Dhx4s=;
 b=4N8dyFhxq8PUU+XbEjgkvaIsYACvS0ocij4Bds1Zz3vtMhvl3qvVoQFdpu3mzWf1ksuEdxplG7u84RL8sZdruyMvbeUQvBv0Et+pIksmHMODEr7jwTCvpogNutict7+bydDEF3gXGtL6lyIeornzgOot0xLUX+x420hdVdPt7VU=
Received: from DS7PR03CA0023.namprd03.prod.outlook.com (2603:10b6:5:3b8::28)
 by DM4PR12MB5962.namprd12.prod.outlook.com (2603:10b6:8:69::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9; Thu, 16 Jul 2026 13:21:38 +0000
Received: from DS1PEPF00017094.namprd03.prod.outlook.com
 (2603:10b6:5:3b8:cafe::a8) by DS7PR03CA0023.outlook.office365.com
 (2603:10b6:5:3b8::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.12 via Frontend Transport; Thu,
 16 Jul 2026 13:21:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017094.mail.protection.outlook.com (10.167.17.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Thu, 16 Jul 2026 13:21:35 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Thu, 16 Jul 2026 08:21:33 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v12 4/5] drm/amdgpu: Record USERQ_EOP WAIT_EVENT notifications
Date: Thu, 16 Jul 2026 18:50:59 +0530
Message-ID: <20260716132100.3496327-5-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260716132100.3496327-1-srinivasan.shanmugam@amd.com>
References: <20260716132100.3496327-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017094:EE_|DM4PR12MB5962:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bd46931-f966-4b5a-907c-08dee33d290f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|23010399003|376014|82310400026|18002099003|22082099003|6133799003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: jArFlUtG7VJ9c1YbG35dUQ1R7R8ECH6GqRtDNQWcUP0Xfx88kBFdRSytMpUflub25lLHEgffY4H5Zj6l8LLDFdM1oT2NoGDzFkHdkNiFDACc5Ohxpik4VgXd9ikgbR0Smse+JOzVUs8Wzj0dMP80SQ38/ccyn8joR3ST7fumnWPE58TpXpRX7UQ62TN/47Z8vqxbehfrF2rbcy3NH5gH9T1E05ZwmH9eKn1ATpAJcDMcXXI30EZVDfNw6S/QtLjqSHVQ6VtgIMOhPui8AUpIwotoWI7Qh7tuz0mHHo75qooO/gi0vCMJAm3bhYrjX5HcPDc+6n+zqTGsp9478AlX2c4pT6d8VsNgJFuM9ToXxj729HkIJGq3kDoO4Ffl1dOlqkmjYu76DR5OO6EzAQ6K88W5QpHtjTuvlckjFGygItyACKwksSgtvyF06CSfPeXmdcpVyZaaXa57ZkoV2Nh2q2kFawHuO2oy3I9WT1/PL6Lvu/+VqVHOhkK2BzYIbDrhO00skF5d2r+C9J96WJ4G9HJZO+JJfsxDPv32eIVgy7yiFtDW4CfHrQEY/B2MDHA0vSGyez+CM/VU3e1TDG5nppgD4+wLg/yXEh8Epc0Ll8MHfA5BdNgvejnsYLZ7uvsy4oD0p4zi7o863bM14SujekcQTji5rBSY/80yl87r5N/XFnghf39e6HGfGu/x+BdD/8t2wVbGW5LBpKypkR5+IQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(23010399003)(376014)(82310400026)(18002099003)(22082099003)(6133799003)(56012099006)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jaB9RourIJ1Wg+mURtkUvAUDlKUoLzw4OAB5ysOcyV4Iyq8yJGGtp0ji8SF4SchokvV4OBy0RTDcwl1bjSxS/HYOebd/RBxR7rmmPcPjHn8qIWR8vLCDkZQslw/YmfLFD2Y24v2VIdif0HyfJUdcOmQ3PEHC+5snLcdUdd7wyWMlb1eeOJpEOY3t7GdifNX79z7HhR8TyyFs3gsmR0BqKBhFiUX5ntZ+dc+SitzKxmYVeAqgTA7WaDj7lxlDY3aZaER/JiL+Z1lNinW2NhidsnDTF4V5/n2P1s00mLAuJjJlSIPsYN9m2+REgJ8yi0f7PMI3f5QrIX2JCFfQOUvkgxUKDxf339BpD/eEDwZcqL/Vt2BI6E6S4y5QqyZUNVV6k7dudr39cRty2mXR0QolAGXT3LXntdDYttuFJiIp54RvZ/VkRq5dhkfUFG5LgelF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 13:21:35.3702 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bd46931-f966-4b5a-907c-08dee33d290f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017094.namprd03.prod.outlook.com
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
 .../gpu/drm/amd/amdgpu/amdgpu_wait_event.c    | 82 ++++++++++++++++++-
 2 files changed, 87 insertions(+), 1 deletion(-)

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
index 7060828be08d..794a57526076 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.c
@@ -80,6 +80,35 @@ static bool amdgpu_wait_event_valid_type(u32 event_type)
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
@@ -251,6 +280,48 @@ void amdgpu_wait_event_mgr_init(struct amdgpu_wait_event_mgr *mgr)
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
@@ -333,7 +404,13 @@ void amdgpu_wait_event_remove_queue(struct amdgpu_wait_event_mgr *mgr,
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
@@ -395,6 +472,9 @@ int amdgpu_wait_event_drm_ioctl(struct drm_device *dev, void *data,
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

