Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2EEEC44507
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2026 08:10:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39CF510EC55;
	Tue, 14 Jul 2026 08:10:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="giw/EGvy";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010049.outbound.protection.outlook.com [52.101.61.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29F2D10EC51
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2026 08:10:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z+NmaKtJk6Fz/XMcHXSQXqm8hVJo2uHye5f5ydU7qOaN1sA0Wfh1zU/ZUvOsuZawNps1I40TpiV5hIuopiyH4DpkhJRU+u4jmj/h7FJOwrSgWhHXfQaDhJbXV0bIaE2s9qR01w/h+x4BVxPLpjHIJN2gYzctDftrF9IN+kpeohKtUuf8gulpUmNdWZo6yWvnMqyfbK/WB14M8LI0+l7NgCBrHs2F7TzElrK2Gvn5RI47lG8kQkI4oD/TU5+6UXA9mKGwFmH9tYGYqNVPSP0oR2YbJMn95not190iEXz+LSk3YUy9ITH0XiWxRNm1Aa1HMoyejsYlHz/mdqRJQnaAWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x/7sLznPC4WQwzpjyEU9iO9QSWRDxdv2fjaAcSX4fO0=;
 b=kxvo7X3az/cLN2P7NPBaRj2ZSPJSfLhPQQixCo83mkHfA23tBu8todEw8U25AA+5Gft68XaEswmPHZis21F7t9eZ6E4UPneoE4Jj6kyUteV/D6AnFqJUTYGkgtIIN7KCj631K5XqhdFYAAMecm+V2sDfw9rQDixkPoPRLjOsoFKeBEhXtfDj9FRsOnIWjpwT+4oNxOXR3Du3LQxWuSWQjG6kGu2ogXam4M7BJe14YV7XIbmA0r6nBbrbyw1lni4foHz7M9T9WJBc+cfnNVIIQNtTU97R+UOB4O3JS3pUirwWzULClxAMFhzwWuDbQbMo7oCe9PmrsKI1Yq8ptShutA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x/7sLznPC4WQwzpjyEU9iO9QSWRDxdv2fjaAcSX4fO0=;
 b=giw/EGvymYW2sYhgXa5IHBEpGoMYTEFVSYqWi6myzaqqfZATWzIX7rzKia1HqLnGAkz0vSj8pz3geT1n4ek7O8hchD3htIhj1JCIKIkS4mUnCiBrARUFLm8uTrejOmmcUlSHP2KGVGuaNhaA2Q169G+geztfQWGblLZAf3+vJnc=
Received: from SJ2PR07CA0016.namprd07.prod.outlook.com (2603:10b6:a03:505::16)
 by DM4PR12MB7648.namprd12.prod.outlook.com (2603:10b6:8:104::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Tue, 14 Jul
 2026 08:10:42 +0000
Received: from SJ1PEPF0000231D.namprd03.prod.outlook.com
 (2603:10b6:a03:505:cafe::46) by SJ2PR07CA0016.outlook.office365.com
 (2603:10b6:a03:505::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.10 via Frontend Transport; Tue,
 14 Jul 2026 08:10:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231D.mail.protection.outlook.com (10.167.242.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Tue, 14 Jul 2026 08:10:41 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Tue, 14 Jul 2026 03:10:39 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v9 4/5] drm/amdgpu: Record USERQ_EOP WAIT_EVENT notifications
Date: Tue, 14 Jul 2026 13:40:22 +0530
Message-ID: <20260714081023.3395485-5-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260714081023.3395485-1-srinivasan.shanmugam@amd.com>
References: <20260714081023.3395485-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231D:EE_|DM4PR12MB7648:EE_
X-MS-Office365-Filtering-Correlation-Id: acabbcf7-77bb-452c-a47d-08dee17f65db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|23010399003|36860700016|376014|11063799006|56012099006|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: 5nltNacJOKM2n+1s74Du66mP2czszWPPINBvDhIH+WZBD+vjmlFAxxsrBuibEslmuSMQ2LYpG7ejJbG9kNjMedCCOgIkwssiTaSWhhmoiP0LXul0Q9T3IaZ0a6V6JHWuzbh3aQOAIDCHuoym84kIg2YbQVZ2KeEWmDc7+9nlz9pupm9MPeTS9A2rDqpeywIBnmv6THQB7Swgb+07J1ciq6PqKUs84Mlh08NKobFnRzn+f4ENEKWrMuKQJSKY5sTg7iAII62YespqyH8mqDirbGRI/jQ5gNQNcNyOaAIACvE04BAAtnn8BedDeJKd6GNJkg8RIMMLOTomZYgHu/iOmMFgglejPAObdxvqtYvPZnWasSkXX4f9r7gNJca2NMfmQJ3cbZkjWpa5jD8z5AOA977zPUjUfr9ND2IYmZqH/LCyjkKGaqGtuNim7X2UtV7pUBR3h4nYwNt4xiYKkNt50w9dF2tcCr2aEkQDNiBXDbDKDlVJ8/V7n3GroJTzbcbWBbj7mvb+4trPxqReFRKIccqQwHPpuWDFf+VkVpHKmIyS4dQXKQl1BJ/5F+5bgkO9fPCzyrYgk0rJAgRHhOveyPpzIM16FQSYmLm6Er74AqKPf0EYe8//p/xkGHPpFqwEdUbc1FWp9FfqCLdqV53DeVV0dn7r9nu3iGfO3TeY95KW0gkyRuCuICJYIja24WOnk4isxIL3fQeI1HDNIvISSw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(23010399003)(36860700016)(376014)(11063799006)(56012099006)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YrcxUJXGLA/uR5KK5Bg1pLhnkFx5+Du5PuU8ogmJ9rMLGifJa4TUxcYz6BT4fHSyGa3PAxb8NVyF7gq63qZEORDtk8Pe/pwJfYzx63rzXnYYqEhf7uYl0PyeqBTKqp8vIuIr/1uKMYPh6Y1s2nBuAXwPsJMf5JH9LYXkC2S3m3O1aOIDYtdEW6xaZvT0BftTisJVMu8oByke1GrGTkowQPRPVvzhWRdqt93U9eGbAxcEa+jbgpMigxeih06BffK7NrwAV1BX8pTkyEdNbZCu88LZ3JsQQIPXyxHLvd3qCEz8Th7Wgq6gqB9OYSLJFNNIlQcx7DP6sF1Y77Prs4zkPGeL8QTJkI8ROrZS6Uj+j0sIxQILEAQDVnWOeWMYce9YncZFXgWd5D+5P2uWJfEz4mjqMqfm7Bqc/W7PDqNq45L+xu1y5z4FHHZsGIDHK+ra
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 08:10:41.8144 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: acabbcf7-77bb-452c-a47d-08dee17f65db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7648
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
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     |  6 +++
 .../gpu/drm/amd/amdgpu/amdgpu_wait_event.c    | 53 +++++++++++++++++++
 .../gpu/drm/amd/amdgpu/amdgpu_wait_event.h    |  4 ++
 3 files changed, 63 insertions(+)

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

