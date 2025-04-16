Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 063AFC369C2
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Apr 2025 22:21:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 884A210E12C;
	Wed, 16 Apr 2025 22:21:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Xq6/p1XQ";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2059.outbound.protection.outlook.com [40.107.101.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BE4310E9CE
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Apr 2025 22:21:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y7vfCU9sw7woiJpeZX04jFwf5FdBlD5wrK0oJCO6REExZw5L+xyu74aIj6dv4XI0q79yQEYE5iVUAhKXB/XEknGmpKYkwVzlhpoqW1n5m5xsb5So7EmfdPRc9V1HvZJuvHMex3kSFApZvRdtjKRW029lMtRk22ylKPlr8nXyFj5xloB4aCsl6lNqN1581kB2vDNt/IRxUECh5CnodDzMiCkidxjtErfoxZpybDPAx/q3My8OQaNHZ/g6sorWMjGE60izP5DMNC8TtqbH4KMmRFteNNRY5EiPMkkKPwWMzCvqL7XsKMLa/b0QMBPxRIaxawAl/r6PGt01V186+rW1rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CSRkRAbqWqT38koadf/cLJgtX2GsHccTPZZNTV0dWJs=;
 b=Jz+Z+ZWeek847gbmo0YLGIrp13SlKDs3KEp9dDe6rlvkNxtV4qpU/JMOCe3BctOzCpUNjJWVG65gLejdzPVEzEypKiEMgVRVeyfZKfBrk1REhuMYfXfAe7eaoFLEWv6wdS5B34MQAV8Res22bWzyoX/jD6sKGH2aFB4KA4h0wXaUndgVWsCFKiC0lfZF7WcyTXROKPZ390GEM5nM7qxuBG151LfEJblf9zJNQ04/VgmnLfUakYFf+fGNZimp/bEbmd/670lMA53fHeXCrpusBrX5WpfDPwINbtbUt0gkA19XTrRor+sRIPpIRuehBX5zQyws3xBsP7pQXLsH4QUcLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CSRkRAbqWqT38koadf/cLJgtX2GsHccTPZZNTV0dWJs=;
 b=Xq6/p1XQFD4zTNC215v0wbjRXbtIwr3CDIwXWOU7d1IqFJWGZsAitWYVEBnnj1LYREc+F9EnXBlEzPc6rFUgA13pa5CUGTkDbCit5PNkYgbUNM9u85vKMgk2kNhxn/8c87cCQuyiu9la1lZSG0Oz6to+YmT22qrb+if9g/K9ejE=
Received: from BN9PR03CA0282.namprd03.prod.outlook.com (2603:10b6:408:f5::17)
 by SJ0PR12MB6877.namprd12.prod.outlook.com (2603:10b6:a03:47f::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Wed, 16 Apr
 2025 22:21:04 +0000
Received: from BL6PEPF0001AB4B.namprd04.prod.outlook.com
 (2603:10b6:408:f5:cafe::89) by BN9PR03CA0282.outlook.office365.com
 (2603:10b6:408:f5::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.22 via Frontend Transport; Wed,
 16 Apr 2025 22:21:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4B.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Wed, 16 Apr 2025 22:21:03 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Apr
 2025 17:21:02 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6/7] drm/amdgpu/userq: rename eviction helpers
Date: Wed, 16 Apr 2025 18:20:45 -0400
Message-ID: <20250416222046.1142257-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250416222046.1142257-1-alexander.deucher@amd.com>
References: <20250416222046.1142257-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4B:EE_|SJ0PR12MB6877:EE_
X-MS-Office365-Filtering-Correlation-Id: 528fcc82-fcf3-47c0-0294-08dd7d34f9ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yQeTyWkB+XFEAXTj2WROq4vkX040EPQdmaLafM50OHuZ2CpHsK9AO6eb5WHv?=
 =?us-ascii?Q?ly/vmOhz9twEa9VGjg/jMiZG5kmZkTQiUB2QUhCmo21K6WOj0WTVZlAZL59V?=
 =?us-ascii?Q?hb0NwliQC4PuWn9It9ypglGmE6orf0s8KsXVoXt06xGPdZMfEPrpw+YwCLYx?=
 =?us-ascii?Q?RI8efb3tTowUAO/8LC16tCb8xChdTIUR4LrXTJvAvyEbsWglFkkRPc7XfjBt?=
 =?us-ascii?Q?3O1lYcxpM3B7smj52UioRFUQJESMG9EL8C9nfc5lYNumLxktRfEifXtkHphl?=
 =?us-ascii?Q?m8V07t6dP5+M9NRsTvpz1sxoZtIk2BVlkEgHPSHIzPdC2gYlKNnA59Uu5GeT?=
 =?us-ascii?Q?at/Vs9shywACvI6HQbTHYg8a1B6KxXpMswqvQ1ln5wcg8jXdxq6FK2m1Pvs/?=
 =?us-ascii?Q?MVdIJPcMj+0xzU0/r/Fq76XUcI5fmADXC9qesrDfyRKGuoTF6XLnX+VmXNnu?=
 =?us-ascii?Q?G1CjeNP23G7iOzv1qz5mnyuXPx6jLc364LTroZxRfEBgCPGbTyMzfPQbxoE1?=
 =?us-ascii?Q?s0OYLaRosoJX7BuF1tii+K4mhwNHdaY4oV5NjVbwUltnc5S+X85cQgXsjL7y?=
 =?us-ascii?Q?cOvEQBsI0kL48FHXzcY0OAre2t8fy4sBu1kyvJJLpWoIkH/aBPREtugZb1XD?=
 =?us-ascii?Q?c1qhrSaCIfoflwcz2DU9f4W8vaP8uSUHaP6kdHDivUr1XVAoTpIvopIybbHJ?=
 =?us-ascii?Q?FBfGt/gEju8K19qK3wfJWy1BZLJ7YD/ToAuL9MTIeQsHsyDDwoLu7zUXNReJ?=
 =?us-ascii?Q?ktwUv1Yte3ZGkwDCVzJoKOe8h7epNSnBQAcorcZlvGqjC5AnFUgTPSJ3NJWj?=
 =?us-ascii?Q?EqwuyteoxW/2MhRdjmtfVYAnuSuHKN0plFARc1xzidTpsc0rS2NCxZnqF+uJ?=
 =?us-ascii?Q?pPo40QVf0BVOJ/A2PdLjswu8681ytLx8/TNfHxJyIrTqhnURkHABValxxAUb?=
 =?us-ascii?Q?CXXDr5RSJY9F4vprSDrhHFEZ/QO8AzUkjp+6Ifbn7SR4lyZ3ThkoG+cyHVfG?=
 =?us-ascii?Q?5ybMD54dPE9T3MT2ygVy/YBOm3YdDxsV+GNiuvOgOi7mrHOzdJRCcLlMjQMI?=
 =?us-ascii?Q?GpX3sMPtT1aiUg0iLY48Gly2JgYy51hubM8nJI04Mll11D7h5+0JfBR1G/fp?=
 =?us-ascii?Q?MMOboUfJUL/XGL0QGTGbrlOwgGnIm53CBxSgwCZ12eOVZxGhubXJwv+akGBr?=
 =?us-ascii?Q?TLzQCsf36cMZvT4SeumKe2Oj9e7m9E4AkU1C2KVjHi2J19Hx4/RbrVITOPO7?=
 =?us-ascii?Q?X/JXrTZC+o9XpFBcf2m/2IXKbnBmk35M3J4FUlpOGwlH8y8pXUKI3UIfHFLU?=
 =?us-ascii?Q?21gIpdshuCF/5oSRDJWjTDDnotLui6dfjkBTuZv9etZi4TqVSSbs/JJtSRAr?=
 =?us-ascii?Q?A5B/RN0le92iwA9k1hczBeHNpAd0ZlXs5+8YIZ+xtac0IXfyQnQyTYfJFpu/?=
 =?us-ascii?Q?2ApdMTJ2K0S4VMj/xz4YlGDr/7x0QhX82vnAn0t+JTrq2vUoqMsNsUcnZvXv?=
 =?us-ascii?Q?GPvE0QpF81RWJ7PCIeV7rYVnXspO1Ii+EkqR?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 22:21:03.8965 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 528fcc82-fcf3-47c0-0294-08dd7d34f9ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6877
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

suspend/resume -> evict/restore

Rename to avoid confusion with the system suspend
and resume helpers.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c    | 16 ++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h    |  4 ++--
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
index 0075469550b06..02164bca51a7d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
@@ -112,7 +112,7 @@ amdgpu_eviction_fence_suspend_worker(struct work_struct *work)
 	if (!ev_fence)
 		goto unlock;
 
-	amdgpu_userqueue_suspend(uq_mgr, ev_fence);
+	amdgpu_userqueue_evict(uq_mgr, ev_fence);
 
 unlock:
 	mutex_unlock(&uq_mgr->userq_mutex);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index a2b92b549c0f9..c7b215337d55a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -529,7 +529,7 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
 #endif
 
 static int
-amdgpu_userqueue_resume_all(struct amdgpu_userq_mgr *uq_mgr)
+amdgpu_userqueue_restore_all(struct amdgpu_userq_mgr *uq_mgr)
 {
 	struct amdgpu_device *adev = uq_mgr->adev;
 	struct amdgpu_usermode_queue *queue;
@@ -660,7 +660,7 @@ amdgpu_userqueue_validate_bos(struct amdgpu_userq_mgr *uq_mgr)
 	return ret;
 }
 
-static void amdgpu_userqueue_resume_worker(struct work_struct *work)
+static void amdgpu_userqueue_restore_worker(struct work_struct *work)
 {
 	struct amdgpu_userq_mgr *uq_mgr = work_to_uq_mgr(work, resume_work.work);
 	struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(uq_mgr);
@@ -676,7 +676,7 @@ static void amdgpu_userqueue_resume_worker(struct work_struct *work)
 		goto unlock;
 	}
 
-	ret = amdgpu_userqueue_resume_all(uq_mgr);
+	ret = amdgpu_userqueue_restore_all(uq_mgr);
 	if (ret) {
 		DRM_ERROR("Failed to resume all queues\n");
 		goto unlock;
@@ -687,7 +687,7 @@ static void amdgpu_userqueue_resume_worker(struct work_struct *work)
 }
 
 static int
-amdgpu_userqueue_suspend_all(struct amdgpu_userq_mgr *uq_mgr)
+amdgpu_userqueue_evict_all(struct amdgpu_userq_mgr *uq_mgr)
 {
 	struct amdgpu_device *adev = uq_mgr->adev;
 	struct amdgpu_usermode_queue *queue;
@@ -728,8 +728,8 @@ amdgpu_userqueue_wait_for_signal(struct amdgpu_userq_mgr *uq_mgr)
 }
 
 void
-amdgpu_userqueue_suspend(struct amdgpu_userq_mgr *uq_mgr,
-			 struct amdgpu_eviction_fence *ev_fence)
+amdgpu_userqueue_evict(struct amdgpu_userq_mgr *uq_mgr,
+		       struct amdgpu_eviction_fence *ev_fence)
 {
 	int ret;
 	struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(uq_mgr);
@@ -742,7 +742,7 @@ amdgpu_userqueue_suspend(struct amdgpu_userq_mgr *uq_mgr,
 		return;
 	}
 
-	ret = amdgpu_userqueue_suspend_all(uq_mgr);
+	ret = amdgpu_userqueue_evict_all(uq_mgr);
 	if (ret) {
 		DRM_ERROR("Failed to evict userqueue\n");
 		return;
@@ -770,7 +770,7 @@ int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amdgpu_devi
 	list_add(&userq_mgr->list, &adev->userq_mgr_list);
 	mutex_unlock(&adev->userq_mutex);
 
-	INIT_DELAYED_WORK(&userq_mgr->resume_work, amdgpu_userqueue_resume_worker);
+	INIT_DELAYED_WORK(&userq_mgr->resume_work, amdgpu_userqueue_restore_worker);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h
index 8f392a0947a29..a9f0e46bcec05 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h
@@ -108,8 +108,8 @@ int amdgpu_userqueue_create_object(struct amdgpu_userq_mgr *uq_mgr,
 void amdgpu_userqueue_destroy_object(struct amdgpu_userq_mgr *uq_mgr,
 				     struct amdgpu_userq_obj *userq_obj);
 
-void amdgpu_userqueue_suspend(struct amdgpu_userq_mgr *uq_mgr,
-			      struct amdgpu_eviction_fence *ev_fence);
+void amdgpu_userqueue_evict(struct amdgpu_userq_mgr *uq_mgr,
+			    struct amdgpu_eviction_fence *ev_fence);
 
 int amdgpu_userqueue_active(struct amdgpu_userq_mgr *uq_mgr);
 
-- 
2.49.0

