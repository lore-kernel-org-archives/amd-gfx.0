Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F0AECA101F
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Sep 2025 09:32:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08D7C10EBE6;
	Fri, 12 Sep 2025 09:32:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YrEDlIaa";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2067.outbound.protection.outlook.com [40.107.236.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9346110EBE6
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Sep 2025 09:32:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uB6VDTOdNS1LeU4/RfEmeKyGrY1bgmg1qtuCAWhN2haufCvQLfFdn2lQ7/vKlY/DZSgmjcdzZbJ/cRwwa1FymAs0WzHMFFq6qcN0siRIpct6UHK5u4w17O1j005MftnS0HZOroqHx1LIf8xwAMW1d787ylUXio6YrrpQdNnrPlxVzouIjD5SeoZckWTcere8pr7V3jwS5e3DFme7fTr+C/RL0SGEHx2ikF9eIg4kzH33wT8VZ0o/lb+XqPT661hGhLfD85URZLZLSnVQbl0xiRyVWODYJV2WAKD730GjHpYdKygmAT+uvo8/1P+/c/yxOfkipvPaIm6MyqbgCT1P5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l89Y/zz/WQzXKeEcF2b1N8gJyUTyTj2TrVDcXq6kQOM=;
 b=JpsHcmTULGZ42ycuB6jF5gKLZQ37BfBrvctPF45gSD7TbV+tovhh3lS71H+T1f4YAt41yLGK1ii7co+pOzwQIHp49MM9Ks5W/UNs6b+J+9RLBWvrmz+TrNwH5MXHKfQqhNBsi8ZwKWnIJb7Vy+lgEIPCPEKlDi2feD7X30AAVPiG3KgBKJmPfFNzWDFLm/KOtX8LuuAY44HsdwR6XczQHRCVgcDMteKYeqzU0eNUKMh5Cj//U7mWaSD5o/U3Vkb/GmKOqwagMbx7CqIvUOmKHF0owkrmxp5rFQYCJe7OJC680NRtSq3AitV/np5L9iCH2+1o8abdBSD27Dk1FLpojA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l89Y/zz/WQzXKeEcF2b1N8gJyUTyTj2TrVDcXq6kQOM=;
 b=YrEDlIaaq+KxId5dFlXkXWtS5+IkAC0Ol8bioreQhmJindMHZMIsHobaIU8HNgDqihEInhIIl8csMSfXGQ88mqq9qhY0eDJ7YWhenS5p9b/5ltnm7PjFlYjEzAJPV0MMdub3xplJ+V17E8rOZUuwCAoELl2LH8gHXbeE36Yp5fg=
Received: from MW4PR03CA0097.namprd03.prod.outlook.com (2603:10b6:303:b7::12)
 by MN0PR12MB5740.namprd12.prod.outlook.com (2603:10b6:208:373::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 09:32:30 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:303:b7:cafe::79) by MW4PR03CA0097.outlook.office365.com
 (2603:10b6:303:b7::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.15 via Frontend Transport; Fri,
 12 Sep 2025 09:32:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Fri, 12 Sep 2025 09:32:29 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 12 Sep
 2025 02:32:26 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 12 Sep
 2025 04:32:14 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Fri, 12 Sep 2025 02:32:08 -0700
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [v2 1/2] drm/amdgpu: Simplify user queue locking with global device
 mutex
Date: Fri, 12 Sep 2025 17:31:44 +0800
Message-ID: <20250912093202.4905-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|MN0PR12MB5740:EE_
X-MS-Office365-Filtering-Correlation-Id: dc818e57-b642-4508-7a9b-08ddf1df4adf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?h69QFfOHSWaZEYe1CvRIOe77RBqssxSVjy3mqRhxWf5vZ2HyDPnKem5z4kNP?=
 =?us-ascii?Q?BWv6kYdcPSs1zogO2msaCVbVoGaAdoApsztz3VgWdnjG8SednI22Rh6ANgsr?=
 =?us-ascii?Q?sSqX45/w+FgLQxTMTCZmJC1G/xV8Q901LtM7ZnIC8ZJpfbFXnxb3FS0LwuS2?=
 =?us-ascii?Q?ewSYCCB5frulLLC+cYKT54NrT1AXPfngGEu+YZHv5e/ArLwwn0TqAW3ybdUM?=
 =?us-ascii?Q?g3jnAUhSOGOJ9q7qEmqpNOGI0ECZq3OkUcJ/xi5oEa99SVWqIRp1aZWx6Nz8?=
 =?us-ascii?Q?y3qCb4YoirbNq36FJsB/vBkxCW56TPNKkggZSJOFKz+allukxnUxnxklvNgA?=
 =?us-ascii?Q?X/fd3xPMi+XjQwWrk8DrMRdLzrE4UmdViiOuCY3LFCjDSZFZxzoHRlC5JQk5?=
 =?us-ascii?Q?xItmXGjQVWCBT9cQaBYWB5rZOTOu3vs+3qi9NnoO9psTJ8NA1R698oGRzq1Y?=
 =?us-ascii?Q?AmEaKmrqkdNzlYgL5RZyhSlnu8ZyHErTFLPBgqEv4O2N644EkdhlZPQ1B2e9?=
 =?us-ascii?Q?t7+3SER3ISfJPaC/JFiT91NhqoPJs0njpLiXXUqlOGQ17iGznvUW2nAmcT8q?=
 =?us-ascii?Q?r0oB3RKa7YBsbX3lrYF76tbzf2hxqvW7MUnZ+w4wlDFiYSc0vyWi2rTZWkUZ?=
 =?us-ascii?Q?l3OjLTFmJOOH+qWWflfhVuip7D8WYQvx28SE1tq3lvKvHuH1l3hHQrO2q6nB?=
 =?us-ascii?Q?9H/75RThB2ypzRLPHjbWXgof8iRtDcvIJIO9FHX7eMPj84X+PH2wHImbNjeM?=
 =?us-ascii?Q?+mYf7fF0RAmwMLssMlbnnhP4yGBcsaqraVGJw88HMRqmvNmMIkfrskY8TJrH?=
 =?us-ascii?Q?y7bs1BnBGuFye9Qc+wa0DXmM/k3CnenswRyOi38tImVpc5UauWc9f0aAnrcr?=
 =?us-ascii?Q?lTkNfLCac/RKj8mK92NWE3ccFMl6au6u/U9aSYYxX+wgryQNsDtUjFkSwSm+?=
 =?us-ascii?Q?JsAvx1ONzlGLrfZvA0WcU6y9cS3eJd0IQhy7Ne0+qd7CFPaAQxXLvU6y+s5U?=
 =?us-ascii?Q?hAwni9WL2xnzziLUxGe9UnFYqlOFwvdP7vtdaUBPgtlM7+S6ZDcW29T3ivmY?=
 =?us-ascii?Q?5z8qf5VoGc++R2j8w+vgH+yFiWxYLbezqX9OVNbCsjCb/0wWlTMoJjIt13ZT?=
 =?us-ascii?Q?74xIU3yKGsg5/N/XF0sQ3lwmz7JGYFEZmtAdUThmZkfbad538iHmGMZ7Vb7D?=
 =?us-ascii?Q?nO1FtHLIrx/QCbm/MItTjO1/8mQwGJ506UVh/GHyi3QcswnXlsJRnpFGXAc6?=
 =?us-ascii?Q?k//Pe4WR24D5VGOZ8HzGnUBZ7J2cCrk9VP0zvBvaUOAqKmE/6ulx98XwOmRD?=
 =?us-ascii?Q?LKkTKIlstfTKRKs01BGU6QgsSZOMPI9HIcewEcJ3UC0FG04Uzvl0UsOTvgNF?=
 =?us-ascii?Q?m5oPUladHsYAwXYsGoMXkRlhQSYfb4NxL51q42ZiWLuXmc1xKCcjhgTLU8H+?=
 =?us-ascii?Q?eZxI7mZgJB17eUarIW9S8C89dQHfKBCjbVu8WFyIdf9fSYhIlUgVOR+nftyN?=
 =?us-ascii?Q?HuP92WTL8YdYgVxtySiHOd7sNKkuH5NFqdJ0?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 09:32:29.1618 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc818e57-b642-4508-7a9b-08ddf1df4adf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5740
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

The current user queue implementation uses a dual-mutex scheme with
both per-device (adev->userq_mutex) and per-process (uq_mgr->userq_mutex)
locking. This overcomplicated design creates potential deadlock scenarios
and makes the code harder to maintain.

Simplify the locking by switching entirely to the global adev->userq_mutex
for all user queue operations. This approach:
- Eliminates potential deadlocks between the two mutexes
- Serializes all user queue handling at the kernel level
- Provides adequate protection since user queue operations aren't
  performance-critical paths
- Makes the code more maintainable with a single locking scheme

Key changes:
1. Remove uq_mgr->userq_mutex entirely from amdgpu_userq_mgr
2. Consistently use adev->userq_mutex across all user queue operations
3. Add proper work flushing in amdgpu_userq_ensure_ev_fence() to
   prevent races when ensuring eviction fence availability
4. Maintain proper locking order throughout all user queue functions

The serialization of all user queue operations is acceptable since
these are management operations that don't need high parallelism.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 .../drm/amd/amdgpu/amdgpu_eviction_fence.c    |  7 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     | 32 ++++++-------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h     |  1 -
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   |  5 +--
 4 files changed, 16 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
index 23d7d0b0d625..d6a07fac7df2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
@@ -105,9 +105,10 @@ amdgpu_eviction_fence_suspend_worker(struct work_struct *work)
 	struct amdgpu_eviction_fence_mgr *evf_mgr = work_to_evf_mgr(work, suspend_work.work);
 	struct amdgpu_fpriv *fpriv = evf_mgr_to_fpriv(evf_mgr);
 	struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
+	struct amdgpu_device *adev = uq_mgr->adev;
 	struct amdgpu_eviction_fence *ev_fence;
 
-	mutex_lock(&uq_mgr->userq_mutex);
+	mutex_lock(&adev->userq_mutex);
 	spin_lock(&evf_mgr->ev_fence_lock);
 	ev_fence = evf_mgr->ev_fence;
 	if (ev_fence)
@@ -118,13 +119,13 @@ amdgpu_eviction_fence_suspend_worker(struct work_struct *work)
 
 	amdgpu_userq_evict(uq_mgr, ev_fence);
 
-	mutex_unlock(&uq_mgr->userq_mutex);
+	mutex_unlock(&adev->userq_mutex);
 	dma_fence_put(&ev_fence->base);
 	return;
 
 unlock:
 	spin_unlock(&evf_mgr->ev_fence_lock);
-	mutex_unlock(&uq_mgr->userq_mutex);
+	mutex_unlock(&adev->userq_mutex);
 }
 
 static bool amdgpu_eviction_fence_enable_signaling(struct dma_fence *f)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index b649ac0cedff..af92450ea6eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -198,17 +198,18 @@ amdgpu_userq_ensure_ev_fence(struct amdgpu_userq_mgr *uq_mgr,
 			     struct amdgpu_eviction_fence_mgr *evf_mgr)
 {
 	struct amdgpu_eviction_fence *ev_fence;
+	struct amdgpu_device *adev = uq_mgr->adev;
 
 retry:
 	/* Flush any pending resume work to create ev_fence */
 	flush_delayed_work(&uq_mgr->resume_work);
 
-	mutex_lock(&uq_mgr->userq_mutex);
+	mutex_lock(&adev->userq_mutex);
 	spin_lock(&evf_mgr->ev_fence_lock);
 	ev_fence = evf_mgr->ev_fence;
 	spin_unlock(&evf_mgr->ev_fence_lock);
 	if (!ev_fence || dma_fence_is_signaled(&ev_fence->base)) {
-		mutex_unlock(&uq_mgr->userq_mutex);
+		mutex_unlock(&adev->userq_mutex);
 		/*
 		 * Looks like there was no pending resume work,
 		 * add one now to create a valid eviction fence
@@ -362,12 +363,12 @@ amdgpu_userq_destroy(struct drm_file *filp, int queue_id)
 	int r = 0;
 
 	cancel_delayed_work_sync(&uq_mgr->resume_work);
-	mutex_lock(&uq_mgr->userq_mutex);
+	mutex_lock(&adev->userq_mutex);
 
 	queue = amdgpu_userq_find(uq_mgr, queue_id);
 	if (!queue) {
 		drm_dbg_driver(adev_to_drm(uq_mgr->adev), "Invalid queue id to destroy\n");
-		mutex_unlock(&uq_mgr->userq_mutex);
+		mutex_unlock(&adev->userq_mutex);
 		return -EINVAL;
 	}
 	amdgpu_userq_wait_for_last_fence(uq_mgr, queue);
@@ -388,7 +389,7 @@ amdgpu_userq_destroy(struct drm_file *filp, int queue_id)
 		queue->state = AMDGPU_USERQ_STATE_HUNG;
 	}
 	amdgpu_userq_cleanup(uq_mgr, queue, queue_id);
-	mutex_unlock(&uq_mgr->userq_mutex);
+	mutex_unlock(&adev->userq_mutex);
 
 	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
 	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
@@ -478,7 +479,6 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
 		return r;
 	}
-
 	/*
 	 * There could be a situation that we are creating a new queue while
 	 * the other queues under this UQ_mgr are suspended. So if there is any
@@ -486,7 +486,6 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	 *
 	 * This will also make sure we have a valid eviction fence ready to be used.
 	 */
-	mutex_lock(&adev->userq_mutex);
 	amdgpu_userq_ensure_ev_fence(&fpriv->userq_mgr, &fpriv->evf_mgr);
 
 	uq_funcs = adev->userq_funcs[args->in.ip_type];
@@ -588,9 +587,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	kfree(queue_name);
 
 	args->out.queue_id = qid;
-
 unlock:
-	mutex_unlock(&uq_mgr->userq_mutex);
 	mutex_unlock(&adev->userq_mutex);
 
 	return r;
@@ -820,11 +817,12 @@ static void amdgpu_userq_restore_worker(struct work_struct *work)
 {
 	struct amdgpu_userq_mgr *uq_mgr = work_to_uq_mgr(work, resume_work.work);
 	struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(uq_mgr);
+	struct amdgpu_device *adev = uq_mgr->adev;
 	int ret;
 
 	flush_delayed_work(&fpriv->evf_mgr.suspend_work);
 
-	mutex_lock(&uq_mgr->userq_mutex);
+	mutex_lock(&adev->userq_mutex);
 
 	ret = amdgpu_userq_validate_bos(uq_mgr);
 	if (ret) {
@@ -839,7 +837,7 @@ static void amdgpu_userq_restore_worker(struct work_struct *work)
 	}
 
 unlock:
-	mutex_unlock(&uq_mgr->userq_mutex);
+	mutex_unlock(&adev->userq_mutex);
 }
 
 static int
@@ -919,7 +917,6 @@ amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr,
 int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct drm_file *file_priv,
 			  struct amdgpu_device *adev)
 {
-	mutex_init(&userq_mgr->userq_mutex);
 	idr_init_base(&userq_mgr->userq_idr, 1);
 	userq_mgr->adev = adev;
 	userq_mgr->file = file_priv;
@@ -942,7 +939,6 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
 	cancel_delayed_work_sync(&userq_mgr->resume_work);
 
 	mutex_lock(&adev->userq_mutex);
-	mutex_lock(&userq_mgr->userq_mutex);
 	idr_for_each_entry(&userq_mgr->userq_idr, queue, queue_id) {
 		amdgpu_userq_wait_for_last_fence(userq_mgr, queue);
 		amdgpu_userq_unmap_helper(userq_mgr, queue);
@@ -956,9 +952,7 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
 		}
 	}
 	idr_destroy(&userq_mgr->userq_idr);
-	mutex_unlock(&userq_mgr->userq_mutex);
 	mutex_unlock(&adev->userq_mutex);
-	mutex_destroy(&userq_mgr->userq_mutex);
 }
 
 int amdgpu_userq_suspend(struct amdgpu_device *adev)
@@ -975,13 +969,11 @@ int amdgpu_userq_suspend(struct amdgpu_device *adev)
 	mutex_lock(&adev->userq_mutex);
 	list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
 		cancel_delayed_work_sync(&uqm->resume_work);
-		mutex_lock(&uqm->userq_mutex);
 		idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
 			r = amdgpu_userq_unmap_helper(uqm, queue);
 			if (r)
 				ret = r;
 		}
-		mutex_unlock(&uqm->userq_mutex);
 	}
 	mutex_unlock(&adev->userq_mutex);
 	return ret;
@@ -1000,13 +992,11 @@ int amdgpu_userq_resume(struct amdgpu_device *adev)
 
 	mutex_lock(&adev->userq_mutex);
 	list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
-		mutex_lock(&uqm->userq_mutex);
 		idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
 			r = amdgpu_userq_map_helper(uqm, queue);
 			if (r)
 				ret = r;
 		}
-		mutex_unlock(&uqm->userq_mutex);
 	}
 	mutex_unlock(&adev->userq_mutex);
 	return ret;
@@ -1031,7 +1021,6 @@ int amdgpu_userq_stop_sched_for_enforce_isolation(struct amdgpu_device *adev,
 	adev->userq_halt_for_enforce_isolation = true;
 	list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
 		cancel_delayed_work_sync(&uqm->resume_work);
-		mutex_lock(&uqm->userq_mutex);
 		idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
 			if (((queue->queue_type == AMDGPU_HW_IP_GFX) ||
 			     (queue->queue_type == AMDGPU_HW_IP_COMPUTE)) &&
@@ -1041,7 +1030,6 @@ int amdgpu_userq_stop_sched_for_enforce_isolation(struct amdgpu_device *adev,
 					ret = r;
 			}
 		}
-		mutex_unlock(&uqm->userq_mutex);
 	}
 	mutex_unlock(&adev->userq_mutex);
 	return ret;
@@ -1065,7 +1053,6 @@ int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
 		dev_warn(adev->dev, "userq scheduling already started!\n");
 	adev->userq_halt_for_enforce_isolation = false;
 	list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
-		mutex_lock(&uqm->userq_mutex);
 		idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
 			if (((queue->queue_type == AMDGPU_HW_IP_GFX) ||
 			     (queue->queue_type == AMDGPU_HW_IP_COMPUTE)) &&
@@ -1075,7 +1062,6 @@ int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
 					ret = r;
 			}
 		}
-		mutex_unlock(&uqm->userq_mutex);
 	}
 	mutex_unlock(&adev->userq_mutex);
 	return ret;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index c027dd916672..2d63308d55c3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -89,7 +89,6 @@ struct amdgpu_userq_funcs {
 /* Usermode queues for gfx */
 struct amdgpu_userq_mgr {
 	struct idr			userq_idr;
-	struct mutex			userq_mutex;
 	struct amdgpu_device		*adev;
 	struct delayed_work		resume_work;
 	struct list_head		list;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 95e91d1dc58a..daf3be92a39c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -464,6 +464,7 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 	u32 *bo_handles_write, num_write_bo_handles;
 	u32 *syncobj_handles, num_syncobj_handles;
 	u32 *bo_handles_read, num_read_bo_handles;
+	struct amdgpu_device *adev = userq_mgr->adev;
 	int r, i, entry, rentry, wentry;
 	struct dma_fence *fence;
 	struct drm_exec exec;
@@ -557,14 +558,14 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 	/* Create a new fence */
 	r = amdgpu_userq_fence_create(queue, userq_fence, wptr, &fence);
 	if (r) {
-		mutex_unlock(&userq_mgr->userq_mutex);
+		mutex_unlock(&adev->userq_mutex);
 		kmem_cache_free(amdgpu_userq_fence_slab, userq_fence);
 		goto put_gobj_write;
 	}
 
 	dma_fence_put(queue->last_fence);
 	queue->last_fence = dma_fence_get(fence);
-	mutex_unlock(&userq_mgr->userq_mutex);
+	mutex_unlock(&adev->userq_mutex);
 
 	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT,
 		      (num_read_bo_handles + num_write_bo_handles));
-- 
2.49.0

