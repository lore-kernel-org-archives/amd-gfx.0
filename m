Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D84F1075274
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Mar 2026 08:22:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F29D10E8E6;
	Thu, 19 Mar 2026 08:22:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vA7uDyXx";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010026.outbound.protection.outlook.com [52.101.85.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0943010E8E6
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Mar 2026 08:22:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=baJxWsUkCSHi2aiKd8O/KzLWM86E8Sc7xnFzJNCoaFSBysLlBgbbybiuVPZG6T6APBcyAqTyURltj8Z5qbvJpwsxmJy8M7ARgRLnSWlnngyPnJPioQgVEukIQPUMRL0VoZWadHOtASCMaijCQmYvI/TbHt5H2BAG9W1S/fhBoE5Ou3vCaQBlkswSgsBMjOghsoQcIt7mI9/y9AMtLLqAx/yKYgod2xQbv2AjCujEj+L+unV76btLSyziykVir6TRmSA8bUvf4/5CK68g54PTKYa7qUpr518jWc2NdPUP/zWZ8EPWMjXtByeDuc8cnkQfLhQA8QoChy/iQ4aLmTAYxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XAfySSH3w7jJ+x9qJLAVpxU8IcRu5fML9NTv/CfReQI=;
 b=jxtC89d3XaXlHF/8W0aRv4D02sUXmpVUCG0yicPTWsd9XVB3VpsBZq9gXehQrso1ZsvT0kNQDoSd/B7NMhtGhMhtqKDKvZ++CSeSmne50M9wpyKX8m5CmaEC1Q/Lti3/PYvpkJYiZT9XMxbEBKks5AUl0H+gc8JBTIzen97AAbP4MrSs/Htzl3xZGyjcdZzOWVmQQnpa0ySirlzOLWfz24xj6aT+1ngZcBcGL/iS1tdS/K404mVVsqF69jhLpjjbajKZs9Nzt4mWhav74QcKO7Q+KtpZIlaNKIrBt4oJGva7JvI0z8P80PPNkG/tICewKhiXyGJHJumcnUHGj+cC+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XAfySSH3w7jJ+x9qJLAVpxU8IcRu5fML9NTv/CfReQI=;
 b=vA7uDyXxiFKtqp0f1Uw/ijOkKYu53rwIM/WGh+ozlNlJmnEqxnrHYQCtzDnNAmEs+4Xezc7wH8peReqnyAq8PzbWGWYUq9t5y95NB3M6LjZ2ONecH/l5cfZ9lnlkeml2ZfJkDKwYeroqQrt2JDjqfeFgezxTOZNtvpec59snCPw=
Received: from BY5PR17CA0007.namprd17.prod.outlook.com (2603:10b6:a03:1b8::20)
 by SA1PR12MB8722.namprd12.prod.outlook.com (2603:10b6:806:373::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 08:22:11 +0000
Received: from SJ5PEPF000001E8.namprd05.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::5b) by BY5PR17CA0007.outlook.office365.com
 (2603:10b6:a03:1b8::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.19 via Frontend Transport; Thu,
 19 Mar 2026 08:22:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001E8.mail.protection.outlook.com (10.167.242.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Thu, 19 Mar 2026 08:22:10 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 19 Mar
 2026 03:22:03 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: fix the userq destroy dead lock
Date: Thu, 19 Mar 2026 16:21:50 +0800
Message-ID: <20260319082150.3324177-3-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260319082150.3324177-1-Prike.Liang@amd.com>
References: <20260319082150.3324177-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E8:EE_|SA1PR12MB8722:EE_
X-MS-Office365-Filtering-Correlation-Id: 6eeeb796-5e9e-4805-e63f-08de85909dfa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: lz6N+iXvmbzmOU/52k24mlVQB9ZoTt+E2EobvVVxTYDfmat5LTmtVXzNDzZ44LbnZ24wZaR1n4B28OegQpUks3IMA2ye3Tx+BfgKOjYj9aS5SPWnUNuvUy6jN2V80rbM0jc1bw+lrRoL4BFOnXcr34e6PYmkn4qRBTsXJJKwD+S/X+SNYUCZtVdY439WjegKoRapkJGqZVzZFfxAGsfVHVMrldN5gSjPeHKr7pYnPEnc6AhHpuI4QdGhz9pnwIbhSiK7ner1U9nujSgbEj41FHckyjdRKNBygjPrZStqWsVrNFO0hYlkUwXioQasYaL2glOiRCUvADB5VkUnVMgQEp6n3BupRECykpkax77bGhPxt/m8mEQF/N79sO9obrl1cV33m0vVkIdbaKLSayOy7j65GLSa+GjMhpTBSu/ml7VDOr7LR3/07Vyrnfc+AU19bFlvKfmlzbKcxNxa+VlktmgOy+acRrN4cjEB926Xw6SfelNSgIts8wBFCCe2ExQYSgo6/KcbstR8jNkCaFTiP9z56ofPExx7TnTtFPPRIqc/+Haq97jJUm82jQI9jLmYo8bgdfha+lj6u1ER1sExrolZSdSy94ZVhj01tKbyje6mtrODYiUnA1Jshs1KuPui71GyME/yR4JM0xH9C7aAAtQvzN+rfP37lBMjoOmalH0Op4NHbUMCC0Bf6RqgvXK/1PcFfCCJo00W8nxpYO8Krbd83y0H6Mzjml7sK7FzWyl/V5+w9DHUXZX5c4KatM8lOTw+GM9HFg+3RcJEypxW/w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CpfuBgIgsywsX6meDAGCCYnGmFu0FGClc216wWH8rBlU/xEdySlXVX2Ru0BNaMA7Gq3DEdajdpXSo7WaFSZrmj3r8+7TboJJ+olUh3Je3s0gTE2LbtmGtru3W0vOgPliGZxqZuQXqyg9/3i3Ckk3xHrFhoTov/7rHS1QbvNFMcZptRnuj8JvfRFhXCM2Oev5kZB0TFM0cEfn1hCLkAmXi/8s8quj0R32vIiUQtUr63ptXAHU48lEBaDb2JQOPDxaZ7zeekdr8YuVg7u4ShlhHfA37mL1X10hTlwIYXb/kI/Bkq1P6GwePQX4AxWfb2zDR1vom6Z5FvHRjzCZaUvhdI/A4YDa+QpkBF9zArEhGzbaTJubD5dS/2T55LDLSam3Koe05EKIovel/jmYBANzdjYHL6v77FyRgbl5yzDK0kN9qD8eKe3pLld85Q4zVcTL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 08:22:10.4123 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eeeb796-5e9e-4805-e63f-08de85909dfa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8722
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

In the userq destroy routine, the queue refcount
should be 0 and the queue already removed from the
manager list, so it must not be touched. Attempting
to lock the userq mutex here would deadlock, as it
is already held by the eviction suspend work like as
following.

[  107.881652] ============================================
[  107.881866] WARNING: possible recursive locking detected
[  107.882081] 6.19.0-custom #16 Tainted: G     U     OE
[  107.882305] --------------------------------------------
[  107.882518] kworker/15:1/158 is trying to acquire lock:
[  107.882728] ffff8f2854b3d110 (&userq_mgr->userq_mutex){+.+.}-{4:4}, at: amdgpu_userq_kref_destroy+0x57/0x540 [amdgpu]
[  107.883462]
               but task is already holding lock:
[  107.883701] ffff8f2854b3d110 (&userq_mgr->userq_mutex){+.+.}-{4:4}, at: amdgpu_eviction_fence_suspend_worker+0x31/0xc0 [amdgpu]
[  107.884485]
               other info that might help us debug this:
[  107.884751]  Possible unsafe locking scenario:

[  107.884993]        CPU0
[  107.885100]        ----
[  107.885207]   lock(&userq_mgr->userq_mutex);
[  107.885385]   lock(&userq_mgr->userq_mutex);
[  107.885561]
                *** DEADLOCK ***

[  107.885798]  May be due to missing lock nesting notation

[  107.886069] 4 locks held by kworker/15:1/158:
[  107.886247]  #0: ffff8f2840057558 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x455/0x650
[  107.886630]  #1: ffffd32f01a4fe18 ((work_completion)(&evf_mgr->suspend_work)){+.+.}-{0:0}, at: process_one_work+0x1f3/0x650
[  107.887075]  #2: ffff8f2854b3d110 (&userq_mgr->userq_mutex){+.+.}-{4:4}, at: amdgpu_eviction_fence_suspend_worker+0x31/0xc0 [amdgpu]
[  107.887799]  #3: ffffffffb8d3f700 (dma_fence_map){++++}-{0:0}, at: amdgpu_eviction_fence_suspend_worker+0x36/0xc0 [amdgpu]
[  107.888457]

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 50 +++++++++++++++++++++--
 1 file changed, 47 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index bb5d572f5a3c..c7a9306a1c01 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -148,6 +148,52 @@ amdgpu_userq_detect_and_reset_queues(struct amdgpu_userq_mgr *uq_mgr)
 	return r;
 }
 
+static int
+amdgpu_userq_perq_detect_and_reset_queues(struct amdgpu_userq_mgr *uq_mgr,
+			struct amdgpu_usermode_queue *queue)
+{
+	struct amdgpu_device *adev = uq_mgr->adev;
+	bool gpu_reset = false;
+	int r = 0;
+
+	/* Warning if current process mutex is not held */
+	if (refcount_read(&queue->refcount.refcount))
+		WARN_ON(!mutex_is_locked(&uq_mgr->userq_mutex));
+
+	if (unlikely(adev->debug_disable_gpu_ring_reset)) {
+		dev_err(adev->dev, "userq reset disabled by debug mask\n");
+		return 0;
+	}
+
+	/*
+	 * If GPU recovery feature is disabled system-wide,
+	 * skip all reset detection logic
+	 */
+	if (!amdgpu_gpu_recovery)
+		return 0;
+
+	/*
+	 * Iterate through all queue types to detect and reset problematic queues
+	 * Process each queue type in the defined order
+	 */
+	int ring_type = queue->queue_type;
+	const struct amdgpu_userq_funcs *funcs = adev->userq_funcs[ring_type];
+
+	if (!amdgpu_userq_is_reset_type_supported(adev, ring_type, AMDGPU_RESET_TYPE_PER_QUEUE))
+			return r;
+
+	if (atomic_read(&uq_mgr->userq_count[ring_type]) > 0 &&
+	    funcs && funcs->detect_and_reset) {
+		r = funcs->detect_and_reset(adev, ring_type);
+		if (r)
+			gpu_reset = true;
+	}
+
+	if (gpu_reset)
+		amdgpu_userq_gpu_reset(adev);
+
+	return r;
+}
 static void amdgpu_userq_hang_detect_work(struct work_struct *work)
 {
 	struct amdgpu_usermode_queue *queue = container_of(work,
@@ -627,7 +673,6 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
 	/* Cancel any pending hang detection work and cleanup */
 	cancel_delayed_work_sync(&queue->hang_detect_work);
 
-	mutex_lock(&uq_mgr->userq_mutex);
 	queue->hang_detect_fence = NULL;
 	amdgpu_userq_wait_for_last_fence(queue);
 
@@ -649,7 +694,7 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
 #if defined(CONFIG_DEBUG_FS)
 	debugfs_remove_recursive(queue->debugfs_queue);
 #endif
-	amdgpu_userq_detect_and_reset_queues(uq_mgr);
+	amdgpu_userq_perq_detect_and_reset_queues(uq_mgr, queue);
 	r = amdgpu_userq_unmap_helper(queue);
 	/*TODO: It requires a reset for userq hw unmap error*/
 	if (unlikely(r != AMDGPU_USERQ_STATE_UNMAPPED)) {
@@ -657,7 +702,6 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
 		queue->state = AMDGPU_USERQ_STATE_HUNG;
 	}
 	amdgpu_userq_cleanup(queue);
-	mutex_unlock(&uq_mgr->userq_mutex);
 
 	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
 
-- 
2.34.1

