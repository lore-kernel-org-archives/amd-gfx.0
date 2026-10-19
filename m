Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 124EACCF2DB
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Oct 2026 08:34:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96F0E10E87A;
	Mon, 19 Oct 2026 08:34:32 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010039.outbound.protection.outlook.com [52.101.56.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4F3810E87A
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Oct 2026 08:34:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HbgnrdL/K9qldF9r/unmHiBSAu5AgW3kpWEbWheUuxbMkOT0oBDCx5EGEU/j4ulZ6uOvBHWbcV1h8x2oZm/ITKymrG7LFidFrj8Y06nb45vwwV0TBzg9YO5nx0Hxx0hiiTUnH76bhyMBn1blOnvWW1FpeVmpCHePjSQeZiaUOLyyMjNwWezFBMGhHU1H1d0s0LvfVbaXvjncy1IkNgS1BB2hs47Oj4SkoY4S88kpZl5+AY+LpjDzfpRLANyYrH/tzl4jnWWqciraXB5qyq4gK+yS3xxmHgadGBuRudjGlEbPjkTmuiYVWuYGOlPZkCPOERKnYVx2Qh4fzMjssJV2SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ue+JM9iPpz/wtYxjcxsjoXS00khI3xIP62syw5SrYUE=;
 b=bj6MTV3ERcrlFSHPQDPkHYWn2syZFwXOSBIP+BYPZ1zLYcvkUHZ3pa05D8YVUfc+hQZRTQ2frkvCfjZfI/2hZpvv2FMQuXTgIvPSMxlXik6088MgLwAO9zy/xHaV7fGBzM3FAeJLyrU5RFJoRK0jXTh9ucH6prAnDUeXa+fTbdD9Tx7ZQD55CcvfawWm1gxskHgt6ATGLoV17SzAxuxGDfbnx64eb6AImwkZ/SHmTR8SB+ZoeheHXX+5QxyVco8Ser4HZAHv9BJzmqN8WEDOxqhLBcsaCaggHRs914KwJkdDIve5HQNZbHYl/YPnla/hQi0w+wPaMovVD+k35XcTgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ue+JM9iPpz/wtYxjcxsjoXS00khI3xIP62syw5SrYUE=;
 b=BYwS9b+AAzjdgbltZ4WAAt9k3AVOgbSo5GXJrToOMQUMTku7jMocbCBD67vxGaPJCOWnSxsTIvIKuAULWGxPuJbHkKAV0PA1MXIwvVnUzV8j2sQpUgi4fwxOK9ifWqd8867fnh8zqKm5pZlfelUsGni5kFPdWPlNFe7Jjk7tiOs=
Received: from SJ0PR13CA0027.namprd13.prod.outlook.com (2603:10b6:a03:2c0::32)
 by DS4PR12MB9683.namprd12.prod.outlook.com (2603:10b6:8:280::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 08:34:22 +0000
Received: from MW2PEPF00014679.namprd04.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::7b) by SJ0PR13CA0027.outlook.office365.com
 (2603:10b6:a03:2c0::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.14 via Frontend Transport; Mon,
 19 Oct 2026 08:34:21 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW2PEPF00014679.mail.protection.outlook.com (10.167.249.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 08:34:21 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 03:34:06 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 03:34:05 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Mon, 19 Oct 2026 03:34:04 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <lijo.lazar@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 06/13] drm/amdgpu/userq: add helpers to reset the user queues
 of one engine
Date: Mon, 19 Oct 2026 16:33:06 +0800
Message-ID: <20261019083402.2033724-6-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261019083402.2033724-1-Jesse.Zhang@amd.com>
References: <20261019083402.2033724-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PEPF00014679:EE_|DS4PR12MB9683:EE_
X-MS-Office365-Filtering-Correlation-Id: 663dc5cc-fc4b-434f-67db-08df2dbbc638
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|1800799024|376014|36860700016|11063799006|56012099006|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: v9hKt77q2iEZ8bTNJaexR3gS//f9+lKBPty213CfVNCdzfoQr+V3GVYi3y/+XjSP9K3yRWCs9CR7duIwg5UXVKGLjWLWN46UxoltyrkBjutq57XkErujA93vKZCAJCl+PAzDBD6WJ6IolI78XfZtRDO+EJ3e1AJPhTY0ksw1uVLqbEm3fTLK/UMQ1F5VszXaogcp0KQ/uPx3MWe7I0Vkse1Uzk2Fasia3DGHrnXVVpSF1x1Cz5+0072IO9E/StJlxa870S+GoXE9MSrjguSxrhNoOH1qO6yc5lkqdQoP92QyaOOLCSW6cLHP5HuK25lpaT5ybgAkkZsa66xZX7nLV2yEQvJzVs8NHbyyo4HShbPqCL6+71+cSAr6mgzKnsJs7vDGp2FMwsUwltl0CM90yQJMRk7TvtbF4B9zwBW5Yyprmf4PUJWJ7cD9hTFcGd2qrTA58WhX3KEGzGcqMWEcJ9VpXMs/mXkRpR9e8cuirovS9gKb9yIpa75Msbj3lJGPw3GgaSCDN07h/sNvGxEYtXPuVCe5dSaLO+aRDETkEFxbH7lgSI29TCiq3r0LBFn2hc12Fhkyie7lEoZbvW4o7zMrcC068cIsmfimKnS51DIklL2r2I0JTj+JsRR5lQHKGHGZezLMiUSzzyBZKd+uES9FanLICgA8NxTpWijW/BWl+4e6zBA06AOnuSZL757hsKuoLiUto3iawt1opmceGA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(1800799024)(376014)(36860700016)(11063799006)(56012099006)(261009223027099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TpSBm5OevW2ik20IytcOfwNcSFtIBqY2QP8pbX7uCNT9pLWJ4KfL6e62x2pjEMConyjbBaR5cfmaeLUWpFl/dGkwEnSzUKZY05sGaUrAKAPAJmIpnigVt/u99fOkhxYZFaJq5Z+sRhcTwR+KB18eNQj+AA0/Tf4YwysZImYpBYkMwqSII1DeR9kOZfkKo0wZw2HjpUrZvif9i1iyDNwJ79V4r1SVm6a30LvXFDU9xVN8of3vafjookhqZLGJAPOs8yNyQnM+FMqbPbPDpFrPCYYzrzuICzS84zPkp+ARW/9g5L9gP2aGlna/Qh4NJXnGJ8kBejTwXqprL0O/dG1BUMwEIKqqypnWp7DI5wblE9FldFJZPTP+Ixqm6/C8kP1hgnloed6jqTUXdwUiSDdFtPrw+N31cCm3SIZD5BjJn6J3ysPoQ6E11qFONlxexLRo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 08:34:21.6272 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 663dc5cc-fc4b-434f-67db-08df2dbbc638
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2PEPF00014679.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9683
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

An engine reset, eg. of the gfx engine, only resets the queues of one
engine of the GFX IP, while the queues of the other engines keep
running. amdgpu_userq_pre_reset() and amdgpu_userq_post_reset() handle
all the user queues for a full reset. Add separate helpers for the
queues of one engine, which walk them with for_each_userq_of_type():

- amdgpu_userq_pre_engine_reset(), called before the reset, cancels
  their pending hang detection and marks them hung. It doesn't unmap the
  mapped and the preempted queues: the scheduler firmware can't preempt
  the queues of a hung engine, and the reset clears their state anyway.
  A queue that was unmapped before, eg. evicted, is marked hung too:
  mapping it again later would resume its work across the reset.
- amdgpu_userq_post_engine_reset(), called after the reset but before
  the scheduler firmware resumes the queues of the engine, unmaps the
  queues the reset left mapped and signals the fences of the dropped
  queues. It returns an error if a queue couldn't be unmapped, so that a
  full reset can follow.
- amdgpu_userq_cancel_engine_reset() drops the records of a failed
  engine reset. amdgpu_userq_pre_reset() drops them too.

The records are kept in a struct of their own in the queue.

The scheduler firmware drops a user queue even when unmapping it fails.
Track that, and don't unmap such a queue again.

The caller of an engine reset holds the userq_engine_reset_sem of the
engine for write.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 110 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  |  18 ++++
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c |   2 +
 3 files changed, 130 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 2097d7c0bfd6..f10dc1a7a3ea 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -1613,6 +1613,13 @@ amdgpu_userq_next_of_type(struct amdgpu_device *adev, unsigned long *index,
 	return queue;
 }
 
+/**
+ * amdgpu_userq_pre_reset - unmap the user queues for a full reset
+ * @adev: amdgpu device
+ *
+ * The queues stay hung until amdgpu_userq_post_reset(), which maps them again
+ * if VRAM survived.
+ */
 void amdgpu_userq_pre_reset(struct amdgpu_device *adev)
 {
 	const struct amdgpu_userq_funcs *userq_funcs;
@@ -1621,6 +1628,8 @@ void amdgpu_userq_pre_reset(struct amdgpu_device *adev)
 
 	/* TODO: We probably need a new lock for the queue state */
 	xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {
+		/* Drop what a failed engine reset left behind. */
+		memset(&queue->engine_reset, 0, sizeof(queue->engine_reset));
 		if (queue->state == AMDGPU_USERQ_STATE_MAPPED) {
 			trace_amdgpu_userq_state_start(queue);
 			userq_funcs = adev->userq_funcs[queue->queue_type];
@@ -1670,3 +1679,104 @@ int amdgpu_userq_post_reset(struct amdgpu_device *adev, bool vram_lost)
 
 	return ret;
 }
+
+/**
+ * amdgpu_userq_pre_engine_reset - prepare the user queues for an engine reset
+ * @adev: amdgpu device
+ * @queue_type: AMDGPU_HW_IP_* type of the queues on the reset engine
+ *
+ * Call it before the reset, for amdgpu_userq_post_engine_reset() after it.
+ * The queues stay hung until then.
+ *
+ * The firmware can't unmap the queues of a hung engine, and the reset clears
+ * the state of the mapped and the preempted ones: they are dropped, and
+ * unmapped after the reset. A queue that was already unmapped, eg. evicted,
+ * is dropped too: mapping it again later would resume its work across the
+ * reset. The caller holds the userq_engine_reset_sem of the engine for write.
+ */
+void amdgpu_userq_pre_engine_reset(struct amdgpu_device *adev, u32 queue_type)
+{
+	struct amdgpu_usermode_queue *queue;
+	unsigned long queue_id;
+
+	for_each_userq_of_type(adev, queue_id, queue, queue_type) {
+		struct amdgpu_userq_engine_reset *er = &queue->engine_reset;
+
+		/* The queue is reset with the engine, don't reset it again. */
+		cancel_delayed_work(&queue->hang_detect_work);
+
+		if (queue->state == AMDGPU_USERQ_STATE_MAPPED ||
+		    queue->state == AMDGPU_USERQ_STATE_PREEMPTED) {
+			trace_amdgpu_userq_state_start(queue);
+			er->unmap = true;
+			trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_HUNG);
+			queue->state = AMDGPU_USERQ_STATE_HUNG;
+		} else if (queue->state == AMDGPU_USERQ_STATE_UNMAPPED) {
+			/*
+			 * Unmapped before the reset, eg. evicted: mapping it
+			 * again later would resume its work across the reset.
+			 */
+			trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_HUNG);
+			queue->state = AMDGPU_USERQ_STATE_HUNG;
+		}
+	}
+}
+
+/**
+ * amdgpu_userq_post_engine_reset - recover the user queues after an engine reset
+ * @adev: amdgpu device
+ * @queue_type: AMDGPU_HW_IP_* type of the queues on the reset engine
+ *
+ * Call it after the reset, before the scheduler firmware resumes the queues
+ * of the engine: it would resume them from a state that didn't survive the
+ * reset. Unmap the queues the reset left mapped, and signal the fences of
+ * the dropped queues.
+ *
+ * Returns an error if a step failed for a queue: the caller then falls back
+ * to a full reset.
+ */
+int amdgpu_userq_post_engine_reset(struct amdgpu_device *adev, u32 queue_type)
+{
+	const struct amdgpu_userq_funcs *userq_funcs;
+	struct amdgpu_usermode_queue *queue;
+	unsigned long queue_id;
+	int ret = 0, r;
+
+	for_each_userq_of_type(adev, queue_id, queue, queue_type) {
+		struct amdgpu_userq_engine_reset er = queue->engine_reset;
+
+		memset(&queue->engine_reset, 0, sizeof(queue->engine_reset));
+		if (queue->state != AMDGPU_USERQ_STATE_HUNG)
+			continue;
+
+		userq_funcs = adev->userq_funcs[queue->queue_type];
+		/* Not mapped in the firmware since a failed unmap. */
+		if (er.unmap && !queue->unmap_failed) {
+			r = userq_funcs->unmap(queue);
+			if (r)
+				ret = r;
+		}
+
+		amdgpu_userq_fence_driver_force_completion(queue);
+	}
+
+	return ret;
+}
+
+/**
+ * amdgpu_userq_cancel_engine_reset - drop the records of a failed engine reset
+ * @adev: amdgpu device
+ * @queue_type: AMDGPU_HW_IP_* type of the queues on the reset engine
+ *
+ * The queues amdgpu_userq_pre_engine_reset() prepared stay hung, for the
+ * full reset that follows to handle them.
+ */
+void amdgpu_userq_cancel_engine_reset(struct amdgpu_device *adev,
+				      u32 queue_type)
+{
+	struct amdgpu_usermode_queue *queue;
+	unsigned long queue_id;
+
+	for_each_userq_of_type(adev, queue_id, queue, queue_type)
+		memset(&queue->engine_reset, 0, sizeof(queue->engine_reset));
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index a56cb9fa8684..55a5bfdc980a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -89,6 +89,20 @@ struct amdgpu_usermode_queue {
 	struct delayed_work	hang_detect_work;
 	struct kref		refcount;
 
+	/**
+	 * @unmap_failed:
+	 *
+	 * The scheduler firmware drops a user queue even when unmapping it
+	 * fails: it isn't mapped there until it is mapped again.
+	 */
+	bool			unmap_failed;
+
+	/** @engine_reset: what an engine reset recorded to recover the queue */
+	struct amdgpu_userq_engine_reset {
+		/* left mapped by the reset: unmap it after */
+		bool				unmap;
+	} engine_reset;
+
 	union {
 		struct {
 			u64 queue_rb;
@@ -189,6 +203,10 @@ amdgpu_userq_next_of_type(struct amdgpu_device *adev, unsigned long *index,
 	     index++)
 void amdgpu_userq_pre_reset(struct amdgpu_device *adev);
 int amdgpu_userq_post_reset(struct amdgpu_device *adev, bool vram_lost);
+void amdgpu_userq_pre_engine_reset(struct amdgpu_device *adev, u32 queue_type);
+int amdgpu_userq_post_engine_reset(struct amdgpu_device *adev, u32 queue_type);
+void amdgpu_userq_cancel_engine_reset(struct amdgpu_device *adev,
+				      u32 queue_type);
 void amdgpu_userq_start_hang_detect_work(struct amdgpu_usermode_queue *queue);
 void amdgpu_userq_process_fence_irq(struct amdgpu_device *adev, u32 doorbell);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 7abb9d95ef59..adc9bdaaa981 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -176,6 +176,7 @@ static int mes_userq_map(struct amdgpu_usermode_queue *queue)
 		DRM_ERROR("Failed to map queue in HW, err (%d)\n", r);
 		return r;
 	}
+	queue->unmap_failed = false;
 
 	amdgpu_mes_userq_queue_mapped(adev);
 
@@ -203,6 +204,7 @@ static int mes_userq_unmap(struct amdgpu_usermode_queue *queue)
 	amdgpu_mes_unlock(&adev->mes);
 	if (mes->use_rs64mem)
 		amdgpu_mes_free_gang_ctx_index(mes, queue->gang_ctx_array_index);
+	queue->unmap_failed = !!r;
 	if (r) {
 		DRM_ERROR("Failed to unmap queue in HW, err (%d)\n", r);
 		return r;
-- 
2.50.1

