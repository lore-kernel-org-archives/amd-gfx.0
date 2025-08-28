Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A591CA0FF2
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Aug 2025 09:17:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE80910E954;
	Thu, 28 Aug 2025 09:17:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LosG6oSu";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2054.outbound.protection.outlook.com [40.107.236.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DA7510E94D
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Aug 2025 09:17:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o99SlKm0q82G2HVqKal57rK46Iph+cT8Tk3J9oFQXSb/LGQlscD4Ni4CjgBVYkDGEaRc7cGhpN9k2mONfQxndDAjdTLOn3QbCGp5ctyOphc6/IuiFiV2j7It60guHOjQ6wcxHSt1VY0BKWtaAT2DmLLA+ZKrU6nLSBjYdQGaZnH7RD+1bwbdDZ/C6vuKEqjgGNSWMHyiDv1J7QnaVHsCsEag2SDXxq1ZaZQSk9/dZgzuDe67yB3v2MGSUrOTvoVKYhGyu2dx94IVocXp6DMKwt0se9gqKlY0/Mv5lfQDu22jzMyEKo5wIG6wev4h44vbLJ+iwO1SB1roaIqcHVLpoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x0kPzbWAe1gVTxMOucFfR6KfWoapfkMxFvxyCNZWkM8=;
 b=Dc3rUPbLKPaRnPLv9nBPTtxUPs9yQRAph8zQT3B/vxuMzR2wh7mQ0LbtRUmmNqDkBWGH1hx5UifivEL5GqUor5nYDCSZbXOoaZtuCOhBuUVAg1G2NpGXC4h2OJOaPVNp3LZfu7I+nMyno/ctKZnaYjEHr3XecKbkLRcr+c9b69xWXY9IdS8+f7NbhEjgAMr7ZmAX7gnMe1rNy4bbbM+JB8h6430nV68bcxgA0ABT5JxllmD5BRCUmXwKHJR9mE8Uc6O9EAR7Tn0nHjC+/z9GsguwTTKxQFSekkionne3RyLEK/GQyxP7e33ScswV5gLOxiIbS0zwCxE4KUKhL/UZuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x0kPzbWAe1gVTxMOucFfR6KfWoapfkMxFvxyCNZWkM8=;
 b=LosG6oSu5El5lt5NaiT/gkOGYy765B2J5vDbB3vbSHiOd3m/2mgRZddqttwxhxUHE6sR7nydcToAd7ercFhAiwkCVIrlbpGluxEM3cX7EeNkKidseXL1wb5bJ+Bj1i06grZ9kLhFzoFxanvbPCvsFdno3/TRdV6mv/mVzNB322Q=
Received: from CH0P223CA0022.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:116::8)
 by DS7PR12MB6357.namprd12.prod.outlook.com (2603:10b6:8:96::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.13; Thu, 28 Aug
 2025 09:17:36 +0000
Received: from CH2PEPF0000009E.namprd02.prod.outlook.com
 (2603:10b6:610:116::4) by CH0P223CA0022.outlook.office365.com
 (2603:10b6:610:116::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.17 via Frontend Transport; Thu,
 28 Aug 2025 09:17:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000009E.mail.protection.outlook.com (10.167.244.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Thu, 28 Aug 2025 09:17:36 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 28 Aug
 2025 03:46:05 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Thu, 28 Aug
 2025 01:46:05 -0700
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 28 Aug 2025 03:45:58 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [v12 10/11] drm/amdgpu: Switch user queues to use preempt/restore for
 eviction
Date: Thu, 28 Aug 2025 16:42:16 +0800
Message-ID: <20250828084457.1999535-10-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250828084457.1999535-1-Jesse.Zhang@amd.com>
References: <20250828084457.1999535-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009E:EE_|DS7PR12MB6357:EE_
X-MS-Office365-Filtering-Correlation-Id: 94099ac1-6279-434e-2644-08dde613ba4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JmCsiJumv1aAq4xMqHxQh3I1yTFDUEKg5lFoV/kiCBb5HFfq1i+XTRWX9p4I?=
 =?us-ascii?Q?YQjtjGVRksxqOlER5XI3CdRjlJmGIHV4NuKk0hSP7jHSguR11GifBv/RM0cz?=
 =?us-ascii?Q?Jgdm0dGMkON9lFSdX/cOpJ7EIDKB8aM8ySKU1H4VJfeFZ+w+7YJ1pltrO6Y/?=
 =?us-ascii?Q?45bx48eXAICOaoER1aHl9nSr99LKxGWIh8dehRa/6CXrqqlqTJaf001UpDE1?=
 =?us-ascii?Q?4ukWFWIvnYe8V5tn0dGajB+asfU0hER4RX7+MoGrNc2swZpIIgWFsM+9tMLA?=
 =?us-ascii?Q?HZd4vi4MjVIcxAZ952wmPMCEHgXb/x+ZeM9yKbQN4/+TfJhwTtCAiillsQ+6?=
 =?us-ascii?Q?BIJrdffX+T9A+/+wGLlpaptmOu7P9eb8u2DJFPQSsmxeYXsT/U0HkDdINXwH?=
 =?us-ascii?Q?xzKW07CzhbrAvyqJQUCpgkADn4Mkej429hpvrGKW0LlvYOmou4Vmp5lY1UWQ?=
 =?us-ascii?Q?gr7XVNynLKh5LcXvU/xd82dx4X6wDLcUGFjzKZksVWAWZ/dxw4NC44IWIE50?=
 =?us-ascii?Q?SJCLU6BO+6PFS2F9ApWFAD6tKrpgSs7urQcxJoivSGUUD/UpQOYGoJ0ZTPPX?=
 =?us-ascii?Q?iuO9n70gYMvxTjEoA3g30LHaQlRGN0sFkHR7Z9iFSiuwjtV11nIg1vKm4TWw?=
 =?us-ascii?Q?nVUk+8YET2mkYqT9CjK0KFjsfLfSNrQN3uyzJ3Wk1FfRHp2cXwsTWRmBzT2g?=
 =?us-ascii?Q?QmozRyMxGcXnwSYpn71bV2MJEJ2B1zUyGQiHMbZ360r6w+Mk+mt7D+ysd1XC?=
 =?us-ascii?Q?2Q2ObrcRhs7GNuAv4ITM2vO4tyq+mn2W0im39I1IlnnZwcERazkpieGV5Qo0?=
 =?us-ascii?Q?UHRBg9oFUjj3HxEDmfeDVFH9p9TYMhe10lSwv78ck2Rat8Tk+AzLKPW4T2y7?=
 =?us-ascii?Q?0FSqVQkMo5PkZltDwkbqbBGBrRNu2RibnPZdJ31utYIG7FWEJgjJD/Jey/1K?=
 =?us-ascii?Q?ZXa6hap66aGcwJN8vfDqyZ9Leu3IEGMp59sA7QXQOC4k/xE/A8OC7j+PbC0J?=
 =?us-ascii?Q?8QcgeN8BeNqUPODU4S2FjnSNMrlIoKj3QjVgl+Xh1BLADuCgfCwaSCjEgweN?=
 =?us-ascii?Q?INEdyXU8BPRZHp7VztbeeAQpNbN4L/PeeoFpKyVTjvxdD7wRiWRousvtwZI9?=
 =?us-ascii?Q?oLMEUCvmH5Tt+zxMlv9Y1TEKz3X7mJw+ea/n5IPr0+lN9osKC3UGOLhYjrHd?=
 =?us-ascii?Q?Q5tmIYQQrJXUoU0WEi6THJQDnUVg6a86vNYqeRdy1i9MGxAAbwWMrjM+l5At?=
 =?us-ascii?Q?9yHfsBr+NaIFrRlx3kksdxndtzrD/8pi1IlNm1LRBNvjk751bJMwK8mznedx?=
 =?us-ascii?Q?WoaGSCbJpvsWOhET7idDjaA157LqJ9Z5sNf+O/Uq/2ESkvm6JRKLDNx/8Hmg?=
 =?us-ascii?Q?L2seAFBamLWNl8sA6GbTb/2PlgUgXtiOcP56L9fxXPTdDwzvnS1FFK/7cVZz?=
 =?us-ascii?Q?+P9gJ1Cu00acGQENMl/sLVfk4qUsslUnPyWl8WWbjWBoNfCph1DLxoakMfzU?=
 =?us-ascii?Q?8JGWt4wSfZqh0LGFrInyXv9gxlECiyFLSwDy?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 09:17:36.0381 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94099ac1-6279-434e-2644-08dde613ba4e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6357
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

This patch modifies the user queue management to use preempt/restore
operations instead of full map/unmap for queue eviction scenarios where
applicable. The changes include:

1. Introduces new helper functions:
   - amdgpu_userqueue_preempt_helper()
   - amdgpu_userqueue_restore_helper()

2. Updates queue state management to track PREEMPTED state

3. Modifies eviction handling to use preempt instead of unmap:
   - amdgpu_userq_evict_all() now uses preempt_helper
   - amdgpu_userq_restore_all() now uses restore_helper

The preempt/restore approach provides better performance during queue
eviction by avoiding the overhead of full queue teardown and setup.
Full map/unmap operations are still used for initial setup/teardown
and system suspend scenarios.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 49 +++++++++++++++++++++--
 1 file changed, 46 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index aac0de86f3e8..decedf8057ac 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -45,7 +45,7 @@ u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev)
 }
 
 static int
-amdgpu_userq_unmap_helper(struct amdgpu_userq_mgr *uq_mgr,
+amdgpu_userqueue_preempt_helper(struct amdgpu_userq_mgr *uq_mgr,
 			  struct amdgpu_usermode_queue *queue)
 {
 	struct amdgpu_device *adev = uq_mgr->adev;
@@ -54,6 +54,49 @@ amdgpu_userq_unmap_helper(struct amdgpu_userq_mgr *uq_mgr,
 	int r = 0;
 
 	if (queue->state == AMDGPU_USERQ_STATE_MAPPED) {
+		r = userq_funcs->preempt(uq_mgr, queue);
+		if (r) {
+			queue->state = AMDGPU_USERQ_STATE_HUNG;
+		} else {
+			queue->state = AMDGPU_USERQ_STATE_PREEMPTED;
+		}
+	}
+
+	return r;
+}
+
+static int
+amdgpu_userqueue_restore_helper(struct amdgpu_userq_mgr *uq_mgr,
+			struct amdgpu_usermode_queue *queue)
+{
+	struct amdgpu_device *adev = uq_mgr->adev;
+	const struct amdgpu_userq_funcs *userq_funcs =
+		adev->userq_funcs[queue->queue_type];
+	int r = 0;
+
+	if (queue->state == AMDGPU_USERQ_STATE_PREEMPTED) {
+		r = userq_funcs->restore(uq_mgr, queue);
+		if (r) {
+			queue->state = AMDGPU_USERQ_STATE_HUNG;
+		} else {
+			queue->state = AMDGPU_USERQ_STATE_MAPPED;
+		}
+	}
+
+	return r;
+}
+
+static int
+amdgpu_userq_unmap_helper(struct amdgpu_userq_mgr *uq_mgr,
+			  struct amdgpu_usermode_queue *queue)
+{
+	struct amdgpu_device *adev = uq_mgr->adev;
+	const struct amdgpu_userq_funcs *userq_funcs =
+		adev->userq_funcs[queue->queue_type];
+	int r = 0;
+
+	if ((queue->state == AMDGPU_USERQ_STATE_MAPPED) ||
+		(queue->state == AMDGPU_USERQ_STATE_PREEMPTED)) {
 		r = userq_funcs->unmap(uq_mgr, queue);
 		if (r)
 			queue->state = AMDGPU_USERQ_STATE_HUNG;
@@ -536,7 +579,7 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
 
 	/* Resume all the queues for this process */
 	idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
-		r = amdgpu_userq_map_helper(uq_mgr, queue);
+		r = amdgpu_userqueue_restore_helper(uq_mgr, queue);
 		if (r)
 			ret = r;
 	}
@@ -693,7 +736,7 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_mgr)
 
 	/* Try to unmap all the queues in this process ctx */
 	idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
-		r = amdgpu_userq_unmap_helper(uq_mgr, queue);
+		r = amdgpu_userqueue_preempt_helper(uq_mgr, queue);
 		if (r)
 			ret = r;
 	}
-- 
2.49.0

