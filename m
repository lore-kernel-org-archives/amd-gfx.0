Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13381C43458
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2026 16:44:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FA8410EA60;
	Mon, 13 Jul 2026 16:44:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eOOgu51F";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010041.outbound.protection.outlook.com [52.101.56.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32D2510EA6F
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 16:44:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PPNiepb8JjiuW/ehhkJc+jpFKvIPjEv3QdAIehZUUNfjUzIeqHuWaUo5SSwVllTJRnFnK8ooqY+fv+XteqVzW5xrQG0LJhJRDbT2kCBeWBFUJUL8FfFeO8R2EHte6Dw1fvYUH4233gcTZ42Vu7Ae5tT0fEIjRX5j45bbzMBmYE8LIRbvHMGYk4BTTw7AMzhj7u58Cnt/xG9azgBy+7A/sfkMvLYjQjCTUpfXMXO/G/WXA5rLH0huQ6KP0WRDxAwpHR7/cLwbWtPkyc2GJ8EPT/yMIDVty/dNcyopt1VqknkNx+eQjzJ+ZlM4Jnth1S3QcZ7g3g9/dn0WTi/sSROPLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5fvgoFxCSn9+3pJugAE+0TZxC7HdA1gzG86kLdklGv8=;
 b=r9y5hzB8kIT0ZL8xzoJ7vYIZPdV0B/APY0OmBDfOH4WTdsvvHvt8YQCMy6yWOOCF2tcBVomxD4mW1F0DAfpy7UhWcBUgpBhUWECOqT2bILlUV1GlAZ1OINuVfcCF9vCsi4LgGRnSjoMNq4sZLn55MveEBJRxajELg37fnLi+LIaADi8dutNQRgYiqYtqwslydAJetpnwU41Ft87zDtSEXjwSxJWF7j/GsaY+dtnnLTyZjCIILtRDBdMUl6H71Vl6XohuXijefL83Op5t/ob+vQI4fNfovBB/m60VihVI6mLJJc8OGJEpovzhA4ajCzudyCdT+ZDyGan4+P/guIRL4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5fvgoFxCSn9+3pJugAE+0TZxC7HdA1gzG86kLdklGv8=;
 b=eOOgu51FU9JvUnfffeT2UB8A3XHBpaCg4tfbJgp8dLcGP7vSPgqAehqjuI2NrOlM8gswMQaVoo1m4uPuymBlYwNmMMpjsYo7EH6uDWCN82R3f7PQBfmACgoCn8IjGmtNvkfnUFYWYe5vmtciPYCs0yRVD39AZVDib25fbhwmE1k=
Received: from SA0PR11CA0173.namprd11.prod.outlook.com (2603:10b6:806:1bb::28)
 by DM4PR12MB5987.namprd12.prod.outlook.com (2603:10b6:8:6a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Mon, 13 Jul
 2026 16:43:54 +0000
Received: from SA2PEPF000015C7.namprd03.prod.outlook.com
 (2603:10b6:806:1bb:cafe::23) by SA0PR11CA0173.outlook.office365.com
 (2603:10b6:806:1bb::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.19 via Frontend Transport; Mon,
 13 Jul 2026 16:43:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF000015C7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Mon, 13 Jul 2026 16:43:53 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Mon, 13 Jul 2026 11:43:50 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v8 5/6] drm/amdgpu: Record USERQ_EOP WAIT_EVENT notifications
Date: Mon, 13 Jul 2026 22:13:20 +0530
Message-ID: <20260713164321.3350036-6-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260713164321.3350036-1-srinivasan.shanmugam@amd.com>
References: <20260713164321.3350036-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C7:EE_|DM4PR12MB5987:EE_
X-MS-Office365-Filtering-Correlation-Id: a8e7086a-0658-488b-d9ff-08dee0fdece0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|82310400026|1800799024|36860700016|22082099003|18002099003|56012099006|6133799003|11063799006;
X-Microsoft-Antispam-Message-Info: 7B5CS/4iMJaVF+8P+a00OWp9porQyhNPE7Qs63i6Ln192Cu1VjB9X3g1hKWioFROfEgOVciFMLtnmeNw+C592j4B8nsiNOvkMM5QLc29tetUI4sYiWzQo2xSqEmPK7qhU06aoAy7YzEDJZM9zQdfKEgCZMxQQi+crGVqr+2+0Nz8kKpuiZ6Ja5BpI3XZPsuIFaev3rdgmAQyRdu2SSlEwcyINfntEhXKiqq/YdwsFMjgMZ5Qpkzy4jMc1OlwOZj0+oU+s9yvwxbGHNDE4NBq0i7+tSKksAYfsdhyfdo4xRSfSTaw2oSFRcnthHr/4wljhnxddvdWWh2Kg1pV2yh731Ikl1QvyquNU5GYeNA4mwRSH2QkjXi/y6XTlycSO4ri/yG3s2B0Hrj8q0pKj6G2aObklV7lJAQ9VzUDEg3BaA4aoI8hEcGS4Rtfw5kFETGnhi2gRo1AYzGubNDQ/2W3qUHgu1ba+KlKJbUdj49XBHkJY962nnMMPMWRScRmi42ZP9sUx2RuvmgOcWMqAvc6cCC9V54m/T0a32Q0OnKOnTlG8Xz/cX7YS/eO4IrKQoAhacVvN590fnIWQACJGk7/9inunITZbU9JWpKIhp32ECD3dMGG5GB7TAUeZQ4Wl7iCP60ge9yZDQJDt1f2bgzVBmq77Lob2fPoLDCOAYUNjKhqrTo4NEGn7sDrYGNxo/UlSDt9MOVYwq14PxLTR+5leQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(82310400026)(1800799024)(36860700016)(22082099003)(18002099003)(56012099006)(6133799003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: iVgF8RfOZIjTZkg8WpkG576eECykGwqki4JEt5IYWjuFYaanytq7mnum0zmHXSCnoZy7Vc4LuTC/5POFhMLUuAaJRavgYnIl1KTJyg7wi+iFaY80xjgCNP/XkZdniy6xjabMprYoy1LYxctVnn3WGwySiZTWs7xo8um9ZYC+/AMNHo38iErrpQSaOILwKneYXye4p3/1bG/2mlKsyyPJx1u1GJtvZ8IpSUjrzuYLz8nwZLlE8fw4d//QOM0vSW5POTkOuw3Ry0WBNoIo10/FlUUlqKknGYlQt+/lGN1/uE7lGIlmpCFNS1aXJstpT75qkAQSwUvY+N+71zEWrftfDIAEtcOUVKsVPA6tIKw6uasFyAnno8f7sLTjyzuAFdaiaRHJQHwKT7tP5N18danXMV7DfoDkl6gvQYTtFzhq2lRahA8a524aRll5YncbPw7D
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 16:43:53.8041 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8e7086a-0658-488b-d9ff-08dee0fdece0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5987
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

Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     |  6 +++
 .../gpu/drm/amd/amdgpu/amdgpu_wait_event.c    | 53 +++++++++++++++++++
 .../gpu/drm/amd/amdgpu/amdgpu_wait_event.h    |  4 ++
 3 files changed, 63 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index b3ac1e81c9ca..1abc05779192 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -234,6 +234,7 @@ void amdgpu_userq_process_fence_irq(struct amdgpu_device *adev, u32 doorbell)
 	struct xarray *xa = &adev->userq_doorbell_xa;
 	struct amdgpu_usermode_queue *queue;
 	struct amdgpu_eventfd_mgr *eventfd_mgr;
+	struct amdgpu_wait_event_mgr *wait_event_mgr;
 	unsigned long flags;
 	int r;
 
@@ -256,6 +257,11 @@ void amdgpu_userq_process_fence_irq(struct amdgpu_device *adev, u32 doorbell)
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
index f98de1d94b56..ddbd03059916 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.c
@@ -63,6 +63,27 @@ static bool amdgpu_wait_event_valid_type(u32 event_type)
 	}
 }
 
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
 static void
 amdgpu_wait_event_record_free(struct amdgpu_wait_event_record *rec)
 {
@@ -167,6 +188,35 @@ void amdgpu_wait_event_mgr_init(struct amdgpu_wait_event_mgr *mgr)
 	mgr->dead = false;
 }
 
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
 void amdgpu_wait_event_mgr_fini(struct amdgpu_wait_event_mgr *mgr)
 {
 	struct amdgpu_wait_event_record *rec, *tmp;
@@ -270,6 +320,9 @@ int amdgpu_wait_event_drm_ioctl(struct drm_device *dev, void *data,
 		}
 	}
 
+	if (queue)
+		amdgpu_wait_event_set_queue_id(rec, args->queue_id);
+
 	if (copy_to_user(u64_to_user_ptr(args->out_ptr), &rec->data,
 			 sizeof(rec->data)))
 		ret = -EFAULT;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.h
index e887fffdc4ac..07e043dcc2e7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.h
@@ -56,6 +56,10 @@ void amdgpu_wait_event_mgr_fini(struct amdgpu_wait_event_mgr *mgr);
 void amdgpu_wait_event_remove_queue(struct amdgpu_wait_event_mgr *mgr,
 				    struct amdgpu_usermode_queue *queue);
 
+void amdgpu_wait_event_add(struct amdgpu_wait_event_mgr *mgr,
+			   u32 event_type,
+			   struct amdgpu_usermode_queue *queue);
+
 int amdgpu_wait_event_drm_ioctl(struct drm_device *dev, void *data,
 				struct drm_file *file_priv);
 
-- 
2.34.1

