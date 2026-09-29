Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39DE1CA5FA1
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2026 03:47:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EE7110EC91;
	Tue, 29 Sep 2026 03:47:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OzK4yp4E";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012023.outbound.protection.outlook.com [40.107.209.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7AF210EC90
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Sep 2026 03:47:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tHwpmGTyJ0HgUhhlppD32kvc+UVFMtorfyjJCTLqbf5apUblBoc/Z4rOuYnE14gTJO5InMArlcHGmmUFNdjOISi3ccgsqTnUB7HrdworU6t/s87tlK9PiVJVREk2WEfp+mfuvbtU2SGV56SCwHnYIdU4gCyUNbVXTqLU14jhe/vg+ZIzVeTHoZ94bmlUTu6oPq5Xmna6xz0yn2nB4p3kBzvaPDh3I7BLwDaNCg2ZYKwnDtQPXmZOH57w4WU+aT3zGqNvswSiNuAfsiwCqiiLIBoRJteS3uHiyJS3NBY/Y0FvsTZwp71PT03+d+OpN/CcRGykb79AveiK4XjurWnd4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XzH4xZsCPeq5ccU6v3Uex6Q8i4J5PV285gRiLCJsMQU=;
 b=trIhtToxmYILCJnns9/LCdaw2To2uHZjRsjvm4YEP7i/liDm5xO2bmI05fwK/w00CY71hbVrYhcm/PvRXjbtTzst2EqzAFcSh/fcHQK1/L4T9eZwIC6c7pVWtfxaTl/CJaxCZv5XtSYFkcSAUeWkvKwOE4X14wUJegIPDOdZ7lO/GFtXy2bIoLJyHXpOLtKlqc+BzVZWvt5du47d2qwCvLv6+rVCRHwGagv+Hun/fGnrnAzSGV36SIaj6y6fJauwdg8Ts+z6vx4kC4fFh1ub0O8+dT7HFM6CpbAzxSKX4/XBVmmCDGUkR2val3Ortw1GJiJhKRJGUMxD39PVf75YsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XzH4xZsCPeq5ccU6v3Uex6Q8i4J5PV285gRiLCJsMQU=;
 b=OzK4yp4ETxzRM0H+GLNsbc10CKUD4dQkWG5/++8fViya/UET3aY9/ajIetKOwoSxc7TVNi4RI4z9MZNFKLLDOAmIn+qrA+VcVcaxIXbngeGwl23JnW/kLIXruYLBHJcZNizBOUuUPB7Iej+Z4y7MNWTVVftGlQ2nHwC1uD9AmWI=
Received: from BN9PR03CA0566.namprd03.prod.outlook.com (2603:10b6:408:138::31)
 by IA3PR12MB951235.namprd12.prod.outlook.com (2603:10b6:208:709::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 03:47:24 +0000
Received: from BN2PEPF000044A4.namprd02.prod.outlook.com
 (2603:10b6:408:138:cafe::3b) by BN9PR03CA0566.outlook.office365.com
 (2603:10b6:408:138::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.9 via Frontend Transport; Tue, 29
 Sep 2026 03:47:24 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A4.mail.protection.outlook.com (10.167.243.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Tue, 29 Sep 2026 03:47:24 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 28 Sep
 2026 22:47:22 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Vitaly.Prosyak@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH v2 14/14] drm/amdgpu/userq: skip MES removal before device
 reset
Date: Tue, 29 Sep 2026 11:46:50 +0800
Message-ID: <20260929034650.2393125-14-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260929034650.2393125-1-Prike.Liang@amd.com>
References: <20260929034650.2393125-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A4:EE_|IA3PR12MB951235:EE_
X-MS-Office365-Filtering-Correlation-Id: 020e686b-c2cb-4a6e-c17d-08df1ddc5f7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|82310400026|1800799024|36860700016|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: yLFzTfHUPN7EpNZApAHWI8hBntU/4Nd5wayJz3tb6o6/larXOrg55p5q8W8vtMIAqToZFA/aAl8tjuRRSP/VN4W6UYiQxYtILWjk36xOuMOi2SN+kapT+uAzpCZwSL4GQmMnDA5QjyDN4zPFSHapf+BGeM7OQjpi35eOzVnFj48xKrwkremx8Y3N3bUkQm2YnN2XTXTsbbpDZYzx5NZjGLbP/1+4r090yiBWqf5DuIfRn8IjGd3yFZ2HhxaBlyrhp8JRFFKK1lExcrn2mR06XLbvvqRQhf+RaJVTpCarmyJNRa93IFfXtXKCSc9oQpXY+Wkb6dHyc2HDQVtQE8pw+hRsMfZBISqk0pVfWZOSEXnpDgzh0t5Q7+VQoAc8TacQlsN6wWliW6VXx9M9Mkr0NLzd2qDwxUTzlGPtpLPt/5jgEogUnCuEUCqlb8rl9m/4x6BGLn99t0EuDyiMPb6gUTqp4KKcVyVAssJT7ENvxFg2Pmcf6z829yFu+mTohtDBB2T1DP8ghpiUIPXb1xDlGyzbJY1Jzusq/L/CV0CYwvWR5xwc+oWcY/rz4BiXAxFGxA3x5rejiTY5NrL9b2Ym0zzDq7NyJH6ZKGQOLSZVuXvfZ8hFs9BMPDS299CEveH1h729NZIWKKnCOaAObDeiF3cbAORJDHUB85uQAMLX63UPkJptC5u/c5PfpcdcuvxkqAH63CeRdn+ITNkUffuBrg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(82310400026)(1800799024)(36860700016)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lQZ7ZhiLOjb6G4H8KPBk51SScLU6KZjC0fjsSVS8cp0B94LtBTYfbg1SDrN2Dn2EaesYbetOlYIWkTsamvSX4OwVx6K7UFran+hCC9cC9UXpl5EQ0ue2cMyu70n4Vt5jmB93ZZ+nhlALgH8FA2Otw5j/EndKxlzRmRcpHo1tS4xzReZRpGHrCZYF6KzNnSKIFHFdAW7uxhpCvpfFmfAehJKWQPeST017FR32IL7bZlzHGqhntEqpHJzRVF7YL5q6dDiX+7vPuT6Sp3nHoEkCUcB35iEtSTpeNFZ0zgKmguj21lXswzvW4Gp3+7zY1uWFb5XdNPngCUpDSTFzCioiYC/RT/C4XfJIkmvbOnD4krFH3Z5+QxJmtzPg1A8QgSkj7S9De1yWJ1JBJraYHgu4W2y/wprezyPIHonj5ISznTaKt8WlEKXIuraUOdmtxcw2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 03:47:24.1424 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 020e686b-c2cb-4a6e-c17d-08df1ddc5f7b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR12MB951235
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

Retire all old queues after successful hardware reset. Pre-reset suspension,
removal and resumption are therefore unnecessary for that lifecycle. Remove
these firmware operations and only mark the queues RESET_PENDING. Leave
their fences pending until hardware reset establishes quiescence, including
when reset fails or is skipped. Clear the count before draining to prevent a
running worker from rearming.

Fixes: a33a2db6af0a ("drm/amdgpu: bracket pre-reset userq removal with MES suspend and resume")
Fixes: 99f2f5b9ef67 ("drm/amdgpu/userq: complete eviction fences after hardware reset")
Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c    | 17 +++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h    |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 33 +++++++++-------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  |  3 ++
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 17 +++++++++--
 5 files changed, 48 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 4138080edbea..851405d9fea4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -1243,6 +1243,23 @@ void amdgpu_mes_userq_queue_unmapped(struct amdgpu_device *adev)
 		cancel_delayed_work(&adev->mes.userq_notify_unmap_work);
 }
 
+/* Hardware reset discarded all old user queues, including failed removals. */
+void amdgpu_mes_userq_reset_complete(struct amdgpu_device *adev)
+{
+	lockdep_assert_held_write(&adev->reset_domain->sem);
+
+	if (!adev->enable_mes || amdgpu_sriov_vf(adev))
+		return;
+
+	if (!(amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(11, 0, 0) &&
+	      amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(12, 0, 0)))
+		return;
+
+	/* Stop rearming before draining a worker that may have dropped its lock. */
+	atomic_set(&adev->mes.userq_hw_queue_count, 0);
+	cancel_delayed_work_sync(&adev->mes.userq_notify_unmap_work);
+}
+
 #if defined(CONFIG_DEBUG_FS)
 
 static int amdgpu_debugfs_mes_event_log_show(struct seq_file *m, void *unused)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index 5160b227943b..738226b3ac2a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -653,5 +653,6 @@ void amdgpu_mes_free_gang_ctx_index(struct amdgpu_mes *mes,
 int amdgpu_mes_notify_unmap_queue(struct amdgpu_device *adev);
 void amdgpu_mes_userq_queue_mapped(struct amdgpu_device *adev);
 void amdgpu_mes_userq_queue_unmapped(struct amdgpu_device *adev);
+void amdgpu_mes_userq_reset_complete(struct amdgpu_device *adev);
 
 #endif /* __AMDGPU_MES_H__ */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 0f509e67ca1a..5fe16185b887 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -1626,33 +1626,21 @@ void amdgpu_userq_gem_va_unmap_validate(struct amdgpu_device *adev,
 
 void amdgpu_userq_pre_reset(struct amdgpu_device *adev)
 {
-	const struct amdgpu_userq_funcs *userq_funcs;
 	struct amdgpu_usermode_queue *queue;
 	unsigned long queue_id;
 
 	lockdep_assert_held_write(&adev->reset_domain->sem);
-	if (xa_empty(&adev->userq_doorbell_xa))
-		return;
-
-	/* Best effort: only the subsequent hardware reset proves quiescence. */
-	if (amdgpu_mes_suspend(adev, 0))
-		dev_dbg(adev->dev, "Continuing GPU reset after MES suspend failure\n");
 
+	/*
+	 * Device reset will retire these queues. Asking a faulted MES to suspend
+	 * or remove them can time out once per queue and delays the reset. Do
+	 * not resume them either: keep their memory protected until hardware
+	 * reset proves that all queue access has stopped.
+	 */
 	xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {
-		if (queue->state == AMDGPU_USERQ_STATE_MAPPED ||
-		    queue->state == AMDGPU_USERQ_STATE_PREEMPTED) {
-			trace_amdgpu_userq_state_start(queue);
-			userq_funcs = adev->userq_funcs[queue->queue_type];
-			userq_funcs->unmap(queue);
-		}
-		/* A failed unmap is not proof that hardware access has stopped. */
 		trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_RESET_PENDING);
 		queue->state = AMDGPU_USERQ_STATE_RESET_PENDING;
 	}
-
-	/* Pair locally, including partial suspension and failed queue removal. */
-	if (amdgpu_mes_resume(adev, 0))
-		dev_dbg(adev->dev, "Continuing GPU reset after MES resume failure\n");
 }
 
 /* Called after successful hardware reset, before allocations during resume. */
@@ -1661,13 +1649,18 @@ void amdgpu_userq_reset_complete(struct amdgpu_device *adev)
 	struct amdgpu_usermode_queue *queue;
 	unsigned long queue_id;
 
+	lockdep_assert_held_write(&adev->reset_domain->sem);
+	amdgpu_mes_userq_reset_complete(adev);
+
 	if (xa_empty(&adev->userq_doorbell_xa))
 		return;
 
-	lockdep_assert_held_write(&adev->reset_domain->sem);
-
 	/* Release queue-fence waiters before acquiring their manager mutexes. */
 	xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {
+		const struct amdgpu_userq_funcs *funcs = adev->userq_funcs[queue->queue_type];
+
+		if (funcs->reset_complete)
+			funcs->reset_complete(queue);
 		trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_HUNG);
 		queue->state = AMDGPU_USERQ_STATE_HUNG;
 		amdgpu_userq_fence_driver_force_completion(queue);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index d17dbc284688..eb4e51613908 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -103,6 +103,7 @@ struct amdgpu_usermode_queue {
 	} userq_vas;
 
 	uint32_t	gang_ctx_array_index;
+	bool		gang_ctx_allocated;
 };
 
 struct amdgpu_userq_funcs {
@@ -116,6 +117,8 @@ struct amdgpu_userq_funcs {
 	int (*preempt)(struct amdgpu_usermode_queue *queue);
 	int (*restore)(struct amdgpu_usermode_queue *queue);
 	int (*reset)(struct amdgpu_usermode_queue *queue);
+	/* Release software resources only after successful device reset. */
+	void (*reset_complete)(struct amdgpu_usermode_queue *queue);
 };
 
 /* Usermode queues for gfx */
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 3b973ea0c24a..fa67899fcd32 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -161,6 +161,7 @@ static int mes_userq_map(struct amdgpu_usermode_queue *queue)
 			DRM_ERROR("Failed to allocate userq gang index err:%d\n", r);
 			return r;
 		}
+		queue->gang_ctx_allocated = true;
 		queue_input.process_context_array_index = uq_mgr->proc_ctx_array_index;
 		queue_input.gang_context_array_index = queue->gang_ctx_array_index;
 	}
@@ -178,13 +179,23 @@ static int mes_userq_map(struct amdgpu_usermode_queue *queue)
 	return 0;
 }
 
+/* The queue must have been removed successfully or stopped by device reset. */
+static void mes_userq_release_gang_ctx(struct amdgpu_usermode_queue *queue)
+{
+	struct amdgpu_mes *mes = &queue->userq_mgr->adev->mes;
+
+	if (queue->gang_ctx_allocated) {
+		amdgpu_mes_free_gang_ctx_index(mes, queue->gang_ctx_array_index);
+		queue->gang_ctx_allocated = false;
+	}
+}
+
 static int mes_userq_unmap(struct amdgpu_usermode_queue *queue)
 {
 	struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
 	struct amdgpu_device *adev = uq_mgr->adev;
 	struct mes_remove_queue_input queue_input;
 	struct amdgpu_userq_obj *ctx = &queue->fw_obj;
-	struct amdgpu_mes *mes = &adev->mes;
 	int r;
 
 	memset(&queue_input, 0x0, sizeof(struct mes_remove_queue_input));
@@ -196,13 +207,12 @@ static int mes_userq_unmap(struct amdgpu_usermode_queue *queue)
 	amdgpu_mes_lock(&adev->mes);
 	r = adev->mes.funcs->remove_hw_queue(&adev->mes, &queue_input);
 	amdgpu_mes_unlock(&adev->mes);
-	if (mes->use_rs64mem)
-		amdgpu_mes_free_gang_ctx_index(mes, queue->gang_ctx_array_index);
 	if (r) {
 		DRM_ERROR("Failed to unmap queue in HW, err (%d)\n", r);
 		return r;
 	}
 
+	mes_userq_release_gang_ctx(queue);
 	amdgpu_mes_userq_queue_unmapped(adev);
 	return 0;
 }
@@ -646,4 +656,5 @@ const struct amdgpu_userq_funcs userq_mes_funcs = {
 	.preempt = mes_userq_preempt,
 	.restore = mes_userq_restore,
 	.reset = mes_userq_reset,
+	.reset_complete = mes_userq_release_gang_ctx,
 };
-- 
2.34.1

