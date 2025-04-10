Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09876C369A2
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Apr 2025 18:12:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F3B410E381;
	Thu, 10 Apr 2025 18:12:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="T4Y+3A76";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCF2310E37E
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Apr 2025 18:12:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iT2wr42PFR62exAUjeLyZr7b9oD1ttFhCWDgQLKeBK4t/DoonyPnBltVa544vTk850uQRcYW1vd3PMSPEsrNmzrGAQ1tIbRrKbNsQUqR6MjaetsJsx/x/78DfDp4d4ajp8qCIcVtyhNAUc7Z+BD5bXCWtzKwD1Xtkw4sYbRR843nL2BfLT8BNecg1KJT67edLlEuyMJX6DzKKhbmtrpMF5IRjCHjR1GWD9APkF26XvkVIKgm4s9Q2qJFl8KgoD9nK2h2QJGXySCSAtIcoRuMnwaCo/I5FgFaL0sQRQ/eRukhq+0Ny9Is4SCTHiZ/u/gNINqahE+sv4E5wTkMX/AWKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fVsnaoYaMuYQ10Lt53xBum4BAZjqfScO9tnCAr7UMmc=;
 b=Zdx7wA4xpUgaSPklR5BhhH53wuVCDhHn5nvXyAwegSbfRtkhgZeOZg9DOwMZnKhnewRZDOWqmT540Fi7LhVs4VMG45N4l87yqtZF3GlE+YGCXmHCIRKjOgmbQuJiGuJanD4Owc6mCSWzhUB0VbI21//NztWrprUq1mv+izocAwNvZpkVG+XZjXBDDqPovDcxBTtcQ++kYpNhA59DPtYKwLXdSO9a0ILUay/WF+9KqCz4ptmAqKCqEMap0hQ8mRNllK96repuY1NhjP/rBf7HMmVLGwxqSXTiN2RI2Vqm4P7O6HwrEF7oKtgWrkwkHnkh3n5DJ1vVh+Zo6rVqOE3BLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fVsnaoYaMuYQ10Lt53xBum4BAZjqfScO9tnCAr7UMmc=;
 b=T4Y+3A76M6jSs3Xs/eQWQkJY4VPFRsDxifpZLnG0psMX277nPLO8Lj4DgVAzhC50Ga1vKGd5tIO0rO0XzmtfZkbr0IUnWZuRQf3gEQWmWfcYOd8GjsJDvTsw2aauqvDid5y1hbtx3NQCwTMgsTv0RevY2gSMyFrovhXoEui6VOE=
Received: from BL1PR13CA0015.namprd13.prod.outlook.com (2603:10b6:208:256::20)
 by PH8PR12MB6771.namprd12.prod.outlook.com (2603:10b6:510:1c6::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Thu, 10 Apr
 2025 18:11:58 +0000
Received: from BN3PEPF0000B074.namprd04.prod.outlook.com
 (2603:10b6:208:256:cafe::81) by BL1PR13CA0015.outlook.office365.com
 (2603:10b6:208:256::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.11 via Frontend Transport; Thu,
 10 Apr 2025 18:11:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B074.mail.protection.outlook.com (10.167.243.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8632.13 via Frontend Transport; Thu, 10 Apr 2025 18:11:57 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Apr
 2025 13:11:54 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 8/9] drm/amdgpu/userq: add helpers to start/stop scheduling
Date: Thu, 10 Apr 2025 14:11:37 -0400
Message-ID: <20250410181138.2287932-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250410181138.2287932-1-alexander.deucher@amd.com>
References: <20250410181138.2287932-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B074:EE_|PH8PR12MB6771:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e230657-f986-487c-cbe3-08dd785b2edd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?a7jAFgUfheE6N89vCMGyIGx9ALQvMIVnAETjFZ50sZVWRH73dEd5GnaJAMvH?=
 =?us-ascii?Q?5GQ8+HZUTKXoSVG8hiSE4a3eayfvgc2PrE2PdI9h28Mo6gMdJTJfFtp1Tjs4?=
 =?us-ascii?Q?lgTw8uDkXmK5GmoZxOIi/SIOaQi7k8VlyPXhh/0hI29zyAv/s17U8+d90SL/?=
 =?us-ascii?Q?aa6iqLzB2lNi39256Niim0kZCa+y6VbZaFGtkOJUGzR9Mh/emTOqpBnSQeea?=
 =?us-ascii?Q?xk5cMW3bi2fNrVoCCh0o+dN3U88TLKFrbQBvVAJyAAH686k2eT46g4FaeJBf?=
 =?us-ascii?Q?1BGrtb6/Dq8P8nf+8FtTMUW0HakN/qhQ4fhLJxU4quXv0mJMC+6Mw0MqIszW?=
 =?us-ascii?Q?S+EisneFPe5QUhi2jttOycIX7LbWLqP9TrhU3KGaMfj2llpe0EvnraBmtrLZ?=
 =?us-ascii?Q?hVF5pPckTs+x7t0ubGj8YzWtUQ+7uLesxsUsr117RuQ23hS9n25RATlJpTK1?=
 =?us-ascii?Q?XoPGaKy0DzV1FK3r5AE4IMl4QiZHfJbHGeq+3aFcLKRc+UkYlJGCsJK/ugyX?=
 =?us-ascii?Q?0AQdEHCIK2btG7dGdjXe5VhpM4PHoC0/COA2SjaonJfDuCXnmxOtWO1xAp6K?=
 =?us-ascii?Q?mXJI/+f3h05afHHnrFZCReTSMGzfieOcFAWw3Q2wrfN1925RrhaO5c2P4Xil?=
 =?us-ascii?Q?mlZq1r1aHYYeL0YeBrtxp2fNBga6uEXMs+OfrNyTx+Msx5ogLkb0YVsF2k6E?=
 =?us-ascii?Q?xTl4FHtoskYuFJ6ZbQTMzoOH0RVLnDhL7+1XsWiUFyV6bdfocHUo9YCcPFGQ?=
 =?us-ascii?Q?0xizrXlbqd3xrgR5mNygITsCIfVJdV5Vo4VOgW1Hr6DDEKiITquBZO+Sfe/R?=
 =?us-ascii?Q?ntY+tddb7v1VeoLlEk5CtOKWvWl2Nns2b6NbZ5qaIv+w7eMtlzUuBhT/eRQe?=
 =?us-ascii?Q?b7/q6+Le+If8KxhOokUmZEUTYsxRvEQlYjtwQH/3g/PRDLa0+B9sIyh3PBWW?=
 =?us-ascii?Q?VTONqnOC8AYdoU/18J6wjv7tZyw7jlq5o/LigMbng86qUSuxKVhekKaiJLlw?=
 =?us-ascii?Q?lelnoB+rGXUqWcKRes9O5jOwJ1TcpNRIKryYzPCpKH3Vb13bPsx9Pf9Zu9X1?=
 =?us-ascii?Q?8jOpTNjVh5sZSQ58CDjVN0KpHUGg1UjDUF5tl57BZO3VzrHBocobWuL/CLwh?=
 =?us-ascii?Q?EdHBUKyNnL/NhkAi6J1aFz87nle786AVJxOpuzR/fbt6Y+TAkkBuDa6xI3NG?=
 =?us-ascii?Q?amHWxUFzWuZ5+kdcoUBU7W2vHRUlEuiFC1e6lDNtiShuzBx6s7Oa4i/71sua?=
 =?us-ascii?Q?ARtRHqt8CLROP8YZdNBBpznoWPaO1PT43vYNotOPbx6OMvnhncipSmJLo8Gy?=
 =?us-ascii?Q?5kWIMxUg8RaJT8prg48wiTuVkvzFTREguYtVJtzSjdIn2dmiIIxIMAXcrtLt?=
 =?us-ascii?Q?D+zHrwiEfilkI2IjpGgwHSxX1BVEKAkc37GNWs94XSvfdG07uo+C0CI7nci5?=
 =?us-ascii?Q?JMXWRqvfMhqfURkC0B6D5g8DQtFA2IFVrAILUvdcJrHg5+MnhoETcM/sM7Y6?=
 =?us-ascii?Q?MxhB+XIw5XaOeEc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 18:11:57.9653 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e230657-f986-487c-cbe3-08dd785b2edd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6771
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

This will be used to stop/start user queue scheduling for
example when switching between kernel and user queues when
enforce isolation is enabled.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 66 +++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h |  3 +
 3 files changed, 63 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index bb5df7831308f..b818ad63dc84f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1242,6 +1242,7 @@ struct amdgpu_device {
 
 	struct list_head		userq_mgr_list;
 	struct mutex                    userq_mutex;
+	bool                            userq_halt;
 };
 
 static inline uint32_t amdgpu_ip_version(const struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index 09c2b01955c58..50317fbd40e0e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -335,6 +335,7 @@ amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 		goto unlock;
 	}
 
+
 	qid = idr_alloc(&uq_mgr->userq_idr, queue, 1, AMDGPU_MAX_USERQ_COUNT, GFP_KERNEL);
 	if (qid < 0) {
 		DRM_ERROR("Failed to allocate a queue id\n");
@@ -345,14 +346,20 @@ amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 		goto unlock;
 	}
 
-	r = uq_funcs->map(uq_mgr, queue);
-	if (r) {
-		DRM_ERROR("Failed to map Queue\n");
-		amdgpu_userq_fence_driver_free(queue);
-		uq_funcs->mqd_destroy(uq_mgr, queue);
-		kfree(queue);
-		goto unlock;
+	/* don't map the queue if scheduling is halted */
+	mutex_lock(&adev->userq_mutex);
+	if (!adev->userq_halt) {
+		r = uq_funcs->map(uq_mgr, queue);
+		if (r) {
+			DRM_ERROR("Failed to map Queue\n");
+			mutex_unlock(&adev->userq_mutex);
+			amdgpu_userq_fence_driver_free(queue);
+			uq_funcs->mqd_destroy(uq_mgr, queue);
+			kfree(queue);
+			goto unlock;
+		}
 	}
+	mutex_unlock(&adev->userq_mutex);
 
 	args->out.queue_id = qid;
 
@@ -719,3 +726,48 @@ int amdgpu_userq_resume(struct amdgpu_device *adev)
 	mutex_unlock(&adev->userq_mutex);
 	return ret;
 }
+
+int amdgpu_userq_stop_sched(struct amdgpu_device *adev, u32 idx)
+{
+	const struct amdgpu_userq_funcs *userq_funcs;
+	struct amdgpu_usermode_queue *queue;
+	struct amdgpu_userq_mgr *uqm, *tmp;
+	int queue_id;
+	int ret = 0;
+
+	mutex_lock(&adev->userq_mutex);
+	if (adev->userq_halt)
+		dev_warn(adev->dev, "userq scheduling already stopped!\n");
+	adev->userq_halt = true;
+	list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
+		cancel_delayed_work_sync(&uqm->resume_work);
+		idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
+			userq_funcs = adev->userq_funcs[queue->queue_type];
+			ret |= userq_funcs->unmap(uqm, queue);
+		}
+	}
+	mutex_unlock(&adev->userq_mutex);
+	return ret;
+}
+
+int amdgpu_userq_start_sched(struct amdgpu_device *adev, u32 idx)
+{
+	const struct amdgpu_userq_funcs *userq_funcs;
+	struct amdgpu_usermode_queue *queue;
+	struct amdgpu_userq_mgr *uqm, *tmp;
+	int queue_id;
+	int ret = 0;
+
+	mutex_lock(&adev->userq_mutex);
+	if (!adev->userq_halt)
+		dev_warn(adev->dev, "userq scheduling already started!\n");
+	adev->userq_halt = false;
+	list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
+		idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
+			userq_funcs = adev->userq_funcs[queue->queue_type];
+			ret |= userq_funcs->map(uqm, queue);
+		}
+	}
+	mutex_unlock(&adev->userq_mutex);
+	return ret;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h
index 381b9c6f0573d..fd0542f60433b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h
@@ -114,4 +114,7 @@ uint64_t amdgpu_userqueue_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr,
 int amdgpu_userq_suspend(struct amdgpu_device *adev);
 int amdgpu_userq_resume(struct amdgpu_device *adev);
 
+int amdgpu_userq_stop_sched(struct amdgpu_device *adev, u32 idx);
+int amdgpu_userq_start_sched(struct amdgpu_device *adev, u32 idx);
+
 #endif
-- 
2.49.0

