Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65AC3C44507
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2026 16:44:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0D6110EA72;
	Mon, 13 Jul 2026 16:44:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NnFsBnCC";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010010.outbound.protection.outlook.com [52.101.201.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE2AF10EA6F
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 16:44:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uBoTRfeZt9hcFL7V1uA9U4VGlKXjX1CSqCHtgM0CSfLu4SW5xsNb3iU5IYNd593ORdRN7ROoHuMmR/rFXKE4CpxDCyKqb3+N/l50nFUPu9efKOb/pC/UQWetGAhmFj8N541fquVdvSBZmHp0wZMfLOCMKKAQQnJIRuhCUQ/WkDzr2PkUfOD+jgXD2AAAsczGItnH1KWugiiMVM5qWH9RXZa/rfaSLfl6IgI+yODWX1OOzKNn1v+V5yPOdD9qdjE4GtA5RkOwFqHYucT4sCm+R4cfdeC2X7IafScsU/DYhU0uQVf+BEMlQnDE1nT7oKPcNUYsFQnEz4iRbGkl9UX9CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9HyU7uw4xYWPnadozCsRxmSOP9UHtrOTLK+N9U/JJWs=;
 b=PM5MKa4YzNZbeAOXLWT8b6N+CLDs3Ibmq/wUrtqA85Kl6Me++vMYVh6Nl4yL7uImGyRitSCuUOsTDYd+WOZ7YHfk5gjkrdKEJPFXi9/+0tC1VkFZ/rjhKto6w9Q4gg+kvo1Cf5TmADp5CJMbHFVVXj4HJ1NLh7/DOZC433g7OWNNMUnOK+RGAarcmuWEso3awUomGckLhoZGjLXlxjKtNLbUPKovTxUzE1OTM0Vy8lCfuA6Zzge2SN5eJBagAKSQOVBowWWs0pJoSeKKOYz2/6GxUMViimT84ZcCkaRsrGhekYdhB0KXlF344KtvekQ2MvFPf2zwIqGcNAvgYMfJgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9HyU7uw4xYWPnadozCsRxmSOP9UHtrOTLK+N9U/JJWs=;
 b=NnFsBnCC/usja99BeeKJTA7szyAAZd7Lo2RubqYpaiXiP44aqcyhtE97qYRci4bL3mPC471y8wRQYniBWRG4O8sN9nX+a0gfOdyafyt7jWG2nWoVKBEJ+xJqAw8e4nu0wOT8+L5A9PWjGi8cOBSZjLOp4Qv72u32hywjXcscbgg=
Received: from SA0PR11CA0159.namprd11.prod.outlook.com (2603:10b6:806:1bb::14)
 by SA1PR12MB6920.namprd12.prod.outlook.com (2603:10b6:806:258::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 16:43:54 +0000
Received: from SA2PEPF000015C7.namprd03.prod.outlook.com
 (2603:10b6:806:1bb:cafe::69) by SA0PR11CA0159.outlook.office365.com
 (2603:10b6:806:1bb::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.19 via Frontend Transport; Mon,
 13 Jul 2026 16:43:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF000015C7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Mon, 13 Jul 2026 16:43:54 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Mon, 13 Jul 2026 11:43:52 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v8 6/6] drm/amdgpu: Record QUEUE_RESET WAIT_EVENT notifications
Date: Mon, 13 Jul 2026 22:13:21 +0530
Message-ID: <20260713164321.3350036-7-srinivasan.shanmugam@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C7:EE_|SA1PR12MB6920:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a545039-832f-47c9-7ac8-08dee0fded47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|23010399003|376014|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: pptSDGhUUUoGqlAUKPcW08DgmSSmWOSY7zTW/AF0qnfwqN7GQd5xCZA62qF/uSqDRph60Tq9aslVAez0nIHB6GwMEbOqVVP7Mnc5kKUtox1gEhaSkrXrXwoz/i8g90AW7O4MTSP3TH5dGTzSI1HZa/P0F1iIofvhU9vcc9Ri4jcnctj4fwCDZ5s8AKUXDhUMpWjiYQH/eGeZvytDMvHzYEbeL053CbxuxO5BDklqln1LUym1TsEQDp3be0iW0FFmRrtotP1jb/nLDFoVMVL5x8yEOBuI1dCisMqnMd5aG7EVGCD2ygDhDExuD+3jDX61A1LNQl/d+FCgLY5RJlVdv0Dq2oap42zTgQYaggLIs/ohDpUcsIgLrti8kO4ISEWLg9/CaikEM1Am7i8x9FbPAU+mmAtnz6JWfo+TNlGmNUq1Uys7iqBPidRMLqIKp3Gd7DqIBeGN9OSNQkTnlA5ZsIY1zqxZer1fUKZNL6HAFEqQamEqsmsYjmcSrrHeTtYEtFYZsGzrc3Nds1Y5Us1f7tRN/Sw5qcpyjGqr40IUzZoAB6YsBRmUJBwyOxPRboJubzn7BdaaFxCTJtS86pfZye/Ez7z1rhebwAmOeTvUreJNY80pJqdbFowyfPPUyXxqC07p+T9xD896FaHlRp4MAJpaksQ9TzgnIqkp6Y1HQUnxHIklsE5Il03c94o6GJvVJ25cKOcB5MBPj85kDgMZ1A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(23010399003)(376014)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SY9QQZ4HRuzZ+llC3Kgmw5M9walxHfHfEvd5K3lsdazb9a1w0Zz0SrOqeJJivk4OpmRuOF7EcGQC+3H7PqKblXpUK4p8Rhq8OR8hLV6h9duLijIRdXqHog+cwmCOs0l2/dgFoqS9Uy+yswduZvm6TeSxP3HQQOpR+OVrzk3csXcDEnZ4ZrBl8g9Nzti7ysOBYEWurO9A25lxxz5np9VC/rAhIYRW4J339nHaqJPOYb3tQLonamHdW0dC8t15wLtM4JJw+uG3F3SUGjKVtCURU4jBJK3xGTBSMYc+ST7GKFaqdiwkISd1z51hIY32YO/I/9A2Lc+Ktjztxmm4eg+z9u0vnqdy3qd7aLWBmPVJ95eQ8d9uhyL7Ba6pmH+KT3GIc4ViUIkTtloIZAAZfnF+Yt86p/B+PP3pitR9Yy2QFSvy163OrcYOO8gkoJhNk8Xf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 16:43:54.4784 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a545039-832f-47c9-7ac8-08dee0fded47
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6920
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

The queue reset path already resolves the affected queue directly from
the doorbell and funnels successful reset handling through
amdgpu_userq_handle_hung_queue(). Reuse that common handling point to
create the corresponding WAIT_EVENT record.

Keeping the notification in the common helper ensures that queue state
is updated before userspace is notified and that both EVENTFD and
WAIT_EVENT observe the same reset. It also avoids duplicating the
doorbell lookup or adding a queue scan in the MES reset path.

No MES or GFX interrupt changes are needed.

Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 1abc05779192..8d081fda3e52 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -271,8 +271,8 @@ void amdgpu_userq_process_fence_irq(struct amdgpu_device *adev, u32 doorbell)
  * @adev: AMDGPU device
  * @queue: affected user queue
  *
- * Mark the queue as hung, notify matching QUEUE_RESET EVENTFD
- * subscribers, force-complete its fences, and send the DRM wedged event.
+ * Mark the queue as hung, notify userspace of the queue reset,
+ * force-complete its fences, and send the DRM wedged event.
  *
  * Return:
  * true when the queue was handled, false for an invalid queue.
@@ -282,6 +282,7 @@ amdgpu_userq_handle_hung_queue(struct amdgpu_device *adev,
 			       struct amdgpu_usermode_queue *queue)
 {
 	struct amdgpu_eventfd_mgr *eventfd_mgr;
+	struct amdgpu_wait_event_mgr *wait_event_mgr;
 
 	if (!queue)
 		return false;
@@ -293,6 +294,11 @@ amdgpu_userq_handle_hung_queue(struct amdgpu_device *adev,
 			      DRM_AMDGPU_EVENT_TYPE_QUEUE_RESET,
 			      queue);
 
+	wait_event_mgr = amdgpu_userq_wait_event_mgr(queue->userq_mgr);
+	amdgpu_wait_event_add(wait_event_mgr,
+			      DRM_AMDGPU_EVENT_TYPE_QUEUE_RESET,
+			      queue);
+
 	amdgpu_userq_fence_driver_force_completion(queue);
 
 	drm_dev_wedged_event(adev_to_drm(adev),
-- 
2.34.1

