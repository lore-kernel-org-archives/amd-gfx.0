Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60298C43458
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2026 10:02:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC2E010E034;
	Fri, 10 Jul 2026 10:01:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tKAKF3Rs";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011010.outbound.protection.outlook.com [52.101.57.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5EED10E034
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2026 10:01:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=drLLguH/ZKFnpXmi09BrJj1fnuvXFW6diDLJaQzi/hHMNo62e1GRv3ko4AfE2Fkmw3C6djmgVCBflwXrZxqHZTq/zbKIO44P7tfFnCxwUOPjWK+20iRv81MKzQkZQC3ajX29Gu2Y7v/HL25kCEKX9FGxody0Sc0FwdjVGebc0+zYkcpPDkKgU1+OhK6fjEo/6Y+jXiAvO/9fL+a2wfR0ZmrjsBLDPx85rAxQhjK5r4qEkW2aGMdS3FxFxDsTEVWgdgs2q9+1k/v3MpjAlgCKA7c3UUDOgtP60wmoVwp+tLsFIhKY0xcoTf3PjPIWJ3LBlxJGceCtTohI3/3Qe5JXeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xNUQ80aqHekW33CLJ/sz+c2LFt4naxRAu9sINez1nug=;
 b=tUde9JoAnaAHTuic7Huh7MFCnKzvDAUvVkS+isKPIBKtNlSslUkh6NDdfW820xItf9LYucaoaXvnR9zg+O2G+i8z0oee/dOR7eyXAkIXrrXANpr38YhAxDus6TA5Yg+QVqVE9l3FcNss/DSmvNtI4G+CKPl/8re2k/sJSgaR/TZo88b/UDpYaTm+fEWZzTfizeKjS0LeTAh/l7XFqKZB28sHGdEwmQy9xMT1SU6Ck7PEIVwA4qRdMPxVifFjrF789EgiyqTtIJaYVRr+McQSlYDLlBfG4l+DPziTrpfIUm4gsnw+xA1zYDYEKp0Adtfupiq0r62VpbnR36oRqFfUAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xNUQ80aqHekW33CLJ/sz+c2LFt4naxRAu9sINez1nug=;
 b=tKAKF3Rsrk1Bga+pBxi+82c4Lsrr+4lL4PTLHfBuXTuc/Pi5DBpNcZ1ie61R7epltsMgHSA47fgp8Hy1clJoNzzKwm8bYdX+hwwVj81Xbhcdc6TGoylXp4np0JYmYlx4LDEgHTZoVhJzc5WpgAUC8yt4YdHLS7Jwd9FSQEenrL8=
Received: from BN0PR04CA0002.namprd04.prod.outlook.com (2603:10b6:408:ee::7)
 by SA1PR12MB9548.namprd12.prod.outlook.com (2603:10b6:806:458::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 10 Jul
 2026 10:01:54 +0000
Received: from BN1PEPF00004687.namprd05.prod.outlook.com
 (2603:10b6:408:ee:cafe::88) by BN0PR04CA0002.outlook.office365.com
 (2603:10b6:408:ee::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.13 via Frontend Transport; Fri,
 10 Jul 2026 10:01:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN1PEPF00004687.mail.protection.outlook.com (10.167.243.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 10 Jul 2026 10:01:53 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 10 Jul
 2026 05:01:53 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 10 Jul 2026 05:01:51 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Prike Liang <Prike.Liang@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu/userq: fix indefinite fence wait during GPU reset
Date: Fri, 10 Jul 2026 18:01:13 +0800
Message-ID: <20260710100151.2849385-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004687:EE_|SA1PR12MB9548:EE_
X-MS-Office365-Filtering-Correlation-Id: 221501d2-cd4c-4ada-9081-08dede6a44ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|23010399003|1800799024|36860700016|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: Gei82gut4LL5Jzu1lHyv91WpnRWRQ5QiE4k0TAQbPntM0jGikMutKZ2p3ZENwJ8o2mPwrrzH+ZUlRoEn1Zn+LrpVGytMTD73wAln1m2U/qhARa9+FfMDzrTlNBhCO37h39z2C9IOSjBXG3HPea4rKfGA/Ld/cmOTVP/+uVLoCYX5kof/OXSEd99FzF8oogTwkxU4FzsUkuxk/TZMQTerG1oVUrpUzZV8Z+dHEbcH6q0DyclucWLKLf0v8UZMYgZt3AK0XsTrIrzVFBbBcE7QMNA/TqELSUTPayZET1k+4pCHFe3LTI1ImtyGu85Vo2ZtJzKy2NHEgW1iU+fe3U7kJN8flLxePNmzeO1+c2tZwYpVfYhqLQpIUtOsrn9YOiZBzA+as7SJPuYZ3f6X9zQGHXvPFkawh+tgTnjjLYsV2URb+HVlXDfUkjVTRYXPX2e6ycOU22oR8L8MqNM3zXspASxK7sQI1/64npTBMXC29gJZSX8tar9AtxhqhczNuYPjfe0QbtggdQAh303r+Aa3pOLxkVQpxs1iJBDWze4ZEbsTapCP7pPdQBaeTPaZTr65RR1qtDJ5lc0OqRKPiqzdn+387Gqz7qfg0FmExY25QecBoqnKD7dL8jytYU4LlZGQN+kb46gaul1tLQP8xdO+92ALQgQ1yZbp1TRutm+NHVt/OlNGEXwmyuS/x87TwSv1a6YX7LEHASMazLrGQaR8fQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(23010399003)(1800799024)(36860700016)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hM/0ByByJ3QVZx362La5JfUTyuLL+SNJU/+Q3GAgqTQcW53tWpHeUnMG4ecPUhKMbtWlEW3cggUouF5wbKRNE/SOhCa3ZYHzn0HD5OC1zDteiJ6yEz8FKSDTGxbAr0UJ4h4YGOir1YV03lex1h/7XQTZ+iO9J6iACxpQNlN+1cpR2twu1RbDwo1YpwnAN858cPJiE8FNv7j0MyMbSayFULa6EsS7FFBg/K4H7Ma7RSGkl+NCXeFAH1Tsl9OB86YckE/c8sMtF6tAzv9qOxXKOOxbgiAfw48yehUx+0RQBPUVbN4V++ltxY7i6n+ftXQnyjPq8hrtdxcpsjJFAmUNIT/megZwjypzEMuq3AGAHjOQH0BLHzJGDoAnHIrZHsnb9D6GDndR8s9K/gZLBpbxRnpkPpe/FmzwpQui8kHkCmU7aPvFhY1462McsHR/tmKZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 10:01:53.5087 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 221501d2-cd4c-4ada-9081-08dede6a44ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004687.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9548
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

pre_reset only force-completes fences of MAPPED queues. A queue in any
other state (e.g. mid-eviction) keeps its last_fence pending; after a
GPU reset that fence never signals, so the eviction/suspend worker and
process teardown (amdgpu_evf_mgr_flush_suspend) wait on it forever and
wedge the machine:

  INFO: task kworker/6:28 blocked for more than 120 seconds.
  Workqueue: events amdgpu_eviction_fence_suspend_worker [amdgpu]
  Call Trace:
   dma_fence_wait_timeout+0x7e/0x130
   amdgpu_userq_evict+0x67/0x140 [amdgpu]
   amdgpu_eviction_fence_suspend_worker+0xd8/0x160 [amdgpu]
   process_scheduled_works+0xa6/0x420

Force-complete every queue's fence regardless of state. The unmap and
mark-hung step stays gated on MAPPED, since unmapping a queue that is
not mapped is invalid.

Fixes: 290f46cf5726 ("drm/amdgpu: Implement user queue reset functionality")
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 25 +++++++++++++----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index aa5cc5642e87..6aa75da27f91 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -1424,18 +1424,21 @@ void amdgpu_userq_pre_reset(struct amdgpu_device *adev)
 
 	/* TODO: We probably need a new lock for the queue state */
 	xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {
-		if (queue->state != AMDGPU_USERQ_STATE_MAPPED)
-			continue;
-
-		trace_amdgpu_userq_state_start(queue);
-		userq_funcs = adev->userq_funcs[queue->queue_type];
-		userq_funcs->unmap(queue);
-		/* just mark all queues as hung at this point.
-		 * if unmap succeeds, we could map again
-		 * in amdgpu_userq_post_reset() if vram is not lost
+		if (queue->state == AMDGPU_USERQ_STATE_MAPPED) {
+			trace_amdgpu_userq_state_start(queue);
+			userq_funcs = adev->userq_funcs[queue->queue_type];
+			userq_funcs->unmap(queue);
+			/* just mark all queues as hung at this point.
+			 * if unmap succeeds, we could map again
+			 * in amdgpu_userq_post_reset() if vram is not lost
+			 */
+			trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_HUNG);
+			queue->state = AMDGPU_USERQ_STATE_HUNG;
+		}
+		/* Force-complete any pending fence regardless of queue state so
+		 * that eviction/suspend and queue teardown waiters don't block
+		 * forever on a fence that will never signal after the reset.
 		 */
-		trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_HUNG);
-		queue->state = AMDGPU_USERQ_STATE_HUNG;
 		amdgpu_userq_fence_driver_force_completion(queue);
 	}
 }
-- 
2.49.0

