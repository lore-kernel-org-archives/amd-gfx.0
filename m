Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3D39C982FA
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2026 07:59:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6585310E97E;
	Tue, 22 Sep 2026 07:59:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="drIEs9Pl";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010027.outbound.protection.outlook.com [52.101.201.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D109910E42D
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2026 07:59:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WKSGrM+dbvfvkpzuzU0p5FR+ggnDOTXdQa+9f/r8PBPQvV/51e41k59xc7gVlESS/Kah79KLJEJrv6DWKZzxiwbZuIUW6MCsQwqwCg1c3mqjGQ8N0rWZahJVPj1czc37/M3AEfWKl11CS9qcSP4FC1yU/xL4rCQnN7olejeW0s9aQqh47WQdHC9nIzFEW50tDvCPZ3klTDe/YXuGBTD6r61WmYDY26LY+AtM8mszb6CzuzSIUb16JKnlAYjUfwb1kjH0+picCtarJAREuqVJzFGRKCZU8hqJs9LCUDXfY4kQSUq8HqsMOE8LgEz9NKEQjvVcRrGvyrnr9Fi/AiMKFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j1B2dwIurhMo8r0ePZBcPFsBUTaeuVTQHqPdml5sQEQ=;
 b=T423XTio7XiFDKNvT92XCTQxUBZvvCn9WrKQE/EB2cQVpBJCBhnr1NPWCIPm0neD84sNJhLn9LjL1WBnJorS3hWMBDJKodI9ofdEhcValMoEKcy0re4i5SCYmAeqyy4tNvJqibmPaDFsHCVIMzizfiZNMh7O0HxYFsTYzFv9ui/KszRK0mTKx6q0IMyHVhhEXJj8X3NRvNIirjyYbI1RONKKHgFa6D75CYIIFxs29f+mc9FWa3W8XqHRpnrg1xS0Ytx1VWn5f7hFwEXQUYq3V0X4PjU0FZJeFuvWCiaq6+h0RTn2N1Fq+9kwDVOwEiQdXVWZfWVRuFeZcJHZXNHtdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j1B2dwIurhMo8r0ePZBcPFsBUTaeuVTQHqPdml5sQEQ=;
 b=drIEs9Pl1i23IA3QPI91I8DRxpV/xQRbtEfD2O9A9gdG6JiN6g4AvOLBN4rIIaBJ9HLXhIg3b3LV6wylG0aO8w8GA/IT4gceqyVK6nlnyOmHhekvc2O0sUsaY/wVBY9uKAhX3kc0eHkcOqhUZz5uvhPH+/bblIC+HsE9KKvXXg0=
Received: from MW4PR04CA0340.namprd04.prod.outlook.com (2603:10b6:303:8a::15)
 by MW4PR12MB6684.namprd12.prod.outlook.com (2603:10b6:303:1ee::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 07:59:12 +0000
Received: from SJ1PEPF000037BB.namprd05.prod.outlook.com
 (2603:10b6:303:8a:cafe::6f) by MW4PR04CA0340.outlook.office365.com
 (2603:10b6:303:8a::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Tue,
 22 Sep 2026 07:59:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000037BB.mail.protection.outlook.com (10.167.244.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Tue, 22 Sep 2026 07:59:11 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 22 Sep
 2026 02:59:09 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Pierre-eric.Pelloux-prayer@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH v3 5/5] drm/amdgpu: track user queue guilt and report reset
 status
Date: Tue, 22 Sep 2026 15:58:52 +0800
Message-ID: <20260922075852.2335748-5-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260922075852.2335748-1-Prike.Liang@amd.com>
References: <20260922075852.2335748-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037BB:EE_|MW4PR12MB6684:EE_
X-MS-Office365-Filtering-Correlation-Id: a33480e0-cf9a-47ac-925c-08df187f639a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014|23010399003|6133799003|10067099003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 8mAp6joFOJmpvj4wZ28iovWQZtafZg8d3ssWv5QOLFI/DG7jTtB0NfW5jtCp/49NOpFpbLNTXDYpqN6ti/w2AD7bZxJqoaVm+J3nNAVl+fm61RxEe+WPEZ6aI/iaUwnXhuntsszvACoAngsaCYnn5ZBIhwrGsChlQ+JSqBlmoQWlwdm7iPH0XT5dDuI0V/paqBCpmAymeYfmyd/YHPVY2z4qUPjUOX0dm2qerwAHLynAVUNCFPF3YdEhx4ct1L6zCCs7wJs9SoibrqM7YZMJWv8bhAAErq5hMMBp+dLdM8M+vsBq+/Z8tF17H3cdR02xOwoW2k2orBmYwVkjUO3disfsj8J4vjhrQrC9D9XUjdF1vbH/FX9WvnTgpK5aN3N0aEJ3aO9AhCrGzAKjQ5LwjsEIT1EoXHEBnh4SYyJn5G8tb4Eqae00wqKOmEs+Z5QAVLQwsqLFMTHPsYsgnv3tmWiQ3zUZSVjdOvjG6yN1cLSyM8okWc5Ak7CRAJSbgXnV5VHXNTuDJzT5ucI+82GBkZu7LB+Rk6qIYzjTcmIfozH5OwuYM1FGFg/zRJTxRL6tgV4nj0mE9BSQa6ixe2rEGeaNO7wT6+nqT2t0aDDLDgtDOx1qOADB9QouXsEdK+e2hJdMEsx005pWF1kUo97OtsuaeaIhKScT4aboXzEFuO4kHkrQ5Oy6Z2TAzb4VCIks7IMck8SjsK+GqUF4d2sf+w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(23010399003)(6133799003)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: pSHs2c+HXiwgjtyD8V6EmfoU0vaiV9IyfYa0e2EdBqIq7ArKH4sFbcRxzpKsbK1EYF0cHcvS/Roje3d9M6I0f+WoBbWsxeqCSDduAEr8vyLbuSJrzrPW36Hmt5LGSm32TDDWx64KdAaZvuO29Zi92ONCmEnivaHqxib9FYeJKC0gty8dQTJAUyZhU79S//T54Tb2lor6JPAygxJ1G2NwtKm6LHfQddRIi/3ifuRwlU/AwxYurZ01iR0lVRwGshnj/sa0IYZ12bqL2qlR2Kk9AYcjP2XDJc+zTJ2A3X6rNpM2jXwF79sQHBSWQVKvgsUukWtoE2ZbLFMOA/mOk3EPn+Qe3fbJGj0RnrpBxcbBxX7K5WvyUOTGY+dgogEPOwjB4C18gNckwzOLqt3+bMaPCC1Wb71JdfKCAIeqmB93tQcZ5XvKXAF80ZzXTusfog0A
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 07:59:11.9607 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a33480e0-cf9a-47ac-925c-08df187f639a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037BB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6684
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

A hung user queue must not be replayed after reset because its context
may be corrupted. Keep the guilty state on the queue and report it
through the sticky HUNG status. Skip guilty queues and queues whose VM
generation has changed when mapping or restoring them.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 30 ++++++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  3 +++
 include/uapi/drm/amdgpu_drm.h             | 11 ++++++---
 3 files changed, 37 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 4ddd22af63c5..8ac63beca995 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -148,6 +148,8 @@ static void amdgpu_userq_hang_detect_work(struct work_struct *work)
 		}
 	}
 
+	WRITE_ONCE(queue->guilty, true);
+
 	if (amdgpu_userq_is_reset_type_supported(adev, queue->queue_type,
 						 AMDGPU_RESET_TYPE_PER_QUEUE)) {
 		int r;
@@ -174,7 +176,7 @@ static void amdgpu_userq_hang_detect_work(struct work_struct *work)
 	 * handler to another is illegal if you don't take extra precautions!
 	 */
 	if (gpu_reset)
-		amdgpu_userq_mgr_reset_work(&queue->userq_mgr->reset_work);
+		amdgpu_userq_mgr_reset_work(&uq_mgr->reset_work);
 }
 
 /*
@@ -338,6 +340,10 @@ static int amdgpu_userq_restore_helper(struct amdgpu_usermode_queue *queue)
 		adev->userq_funcs[queue->queue_type];
 	int r = 0;
 
+	if (READ_ONCE(queue->guilty) ||
+	    queue->generation != amdgpu_vm_generation(adev, queue->vm))
+		return 0;
+
 	if (queue->state == AMDGPU_USERQ_STATE_PREEMPTED) {
 		trace_amdgpu_userq_state_start(queue);
 
@@ -388,6 +394,10 @@ static int amdgpu_userq_map_helper(struct amdgpu_usermode_queue *queue)
 		adev->userq_funcs[queue->queue_type];
 	int r;
 
+	if (READ_ONCE(queue->guilty) ||
+	    queue->generation != amdgpu_vm_generation(adev, queue->vm))
+		return 0;
+
 	if (queue->state == AMDGPU_USERQ_STATE_UNMAPPED) {
 		trace_amdgpu_userq_state_start(queue);
 
@@ -692,6 +702,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	queue->queue_type = args->in.ip_type;
 	queue->vm = &fpriv->vm;
 	queue->priority = priority;
+	queue->reset_counter = atomic_read(&adev->gpu_reset_counter);
 	queue->generation = amdgpu_vm_generation(adev, &fpriv->vm);
 	queue->xcp_id = (fpriv->xcp_id != AMDGPU_XCP_NO_PARTITION) ?
 				fpriv->xcp_id : 0;
@@ -831,14 +842,20 @@ amdgpu_userq_query_status(struct drm_file *filp, union drm_amdgpu_userq *args)
 	}
 
 	args->out_qs.flags = 0;
-	if (queue->state == AMDGPU_USERQ_STATE_HUNG)
+	if (queue->reset_counter != atomic_read(&adev->gpu_reset_counter))
+		args->out_qs.flags |= AMDGPU_USERQ_QUERY_STATUS_FLAGS_RESET;
+	if (queue->state == AMDGPU_USERQ_STATE_HUNG ||
+	    READ_ONCE(queue->guilty))
 		args->out_qs.flags |= AMDGPU_USERQ_QUERY_STATUS_FLAGS_HUNG;
 	if (queue->generation != amdgpu_vm_generation(adev, &fpriv->vm))
 		args->out_qs.flags |= AMDGPU_USERQ_QUERY_STATUS_FLAGS_VRAMLOST;
 	if (queue->state == AMDGPU_USERQ_STATE_INVALID_VA)
 		args->out_qs.flags |= AMDGPU_USERQ_QUERY_STATUS_FLAGS_INVALID_VA;
-	amdgpu_userq_put(queue);
+	if (amdgpu_in_reset(adev))
+		args->out_qs.flags |= AMDGPU_USERQ_QUERY_STATUS_FLAGS_RESET_IN_PROGRESS;
 	mutex_unlock(&uq_mgr->userq_mutex);
+	/* The final put may destroy the queue and take userq_mutex. */
+	amdgpu_userq_put(queue);
 
 	return 0;
 }
@@ -900,6 +917,7 @@ static int amdgpu_userq_input_args_validate(struct drm_device *dev,
 		}
 		break;
 	case AMDGPU_USERQ_OP_FREE:
+	case AMDGPU_USERQ_OP_QUERY_STATUS:
 		if (args->in.ip_type ||
 		    args->in.doorbell_handle ||
 		    args->in.doorbell_offset ||
@@ -1596,7 +1614,11 @@ int amdgpu_userq_post_reset(struct amdgpu_device *adev, bool vram_lost)
 	int ret = 0, r;
 
 	xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {
-		if (queue->state == AMDGPU_USERQ_STATE_HUNG && !vram_lost) {
+		if (vram_lost || READ_ONCE(queue->guilty) ||
+		    queue->generation != amdgpu_vm_generation(adev, queue->vm))
+			continue;
+
+		if (queue->state == AMDGPU_USERQ_STATE_HUNG) {
 			trace_amdgpu_userq_state_start(queue);
 
 			userq_funcs = adev->userq_funcs[queue->queue_type];
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index d1a2e2a45861..c2349115f404 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -51,6 +51,8 @@ struct amdgpu_userq_obj {
 struct amdgpu_usermode_queue {
 	int			queue_type;
 	enum amdgpu_userq_state state;
+	/* Reset due to a hang; must not be re-mapped, userspace recreates. */
+	bool			guilty;
 	uint64_t		doorbell_handle;
 	uint64_t		doorbell_index;
 	u32			doorbell_offset;
@@ -79,6 +81,7 @@ struct amdgpu_usermode_queue {
 	struct dma_fence	*last_fence;
 	u32			xcp_id;
 	int			priority;
+	unsigned int		reset_counter;
 	uint64_t		generation;
 	struct dentry		*debugfs_queue;
 
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 2f81ec3265cd..7e928c4e8868 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -360,18 +360,23 @@ union drm_amdgpu_ctx {
 #define AMDGPU_USERQ_QUERY_STATUS_FLAGS_VRAMLOST (1 << 1)
 /* the invalid userq VA unmapped */
 #define AMDGPU_USERQ_QUERY_STATUS_FLAGS_INVALID_VA (1 << 2)
+/* indicate a GPU reset occurred since the queue was created */
+#define AMDGPU_USERQ_QUERY_STATUS_FLAGS_RESET (1 << 3)
+/* indicate that a GPU reset has not completed yet */
+#define AMDGPU_USERQ_QUERY_STATUS_FLAGS_RESET_IN_PROGRESS (1 << 4)
+
 /*
  * This structure is a container to pass input configuration
  * info for all supported userqueue related operations.
  * For operation AMDGPU_USERQ_OP_CREATE: user is expected
  *  to set all fields, excep the parameter 'queue_id'.
- * For operation AMDGPU_USERQ_OP_FREE: the only input parameter expected
- *  to be set is 'queue_id', eveything else is ignored.
+ * For operations AMDGPU_USERQ_OP_FREE and AMDGPU_USERQ_OP_QUERY_STATUS:
+ *  only 'op' and 'queue_id' should be set; all other fields must be zero.
  */
 struct drm_amdgpu_userq_in {
 	/** AMDGPU_USERQ_OP_* */
 	__u32	op;
-	/** Queue id passed for operation USERQ_OP_FREE */
+	/** Queue id passed for operations USERQ_OP_FREE and USERQ_OP_QUERY_STATUS */
 	__u32	queue_id;
 	/** the target GPU engine to execute workload (AMDGPU_HW_IP_*) */
 	__u32   ip_type;
-- 
2.34.1

