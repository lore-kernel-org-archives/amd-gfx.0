Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 404A9CA1009
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Sep 2025 08:40:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C691A10E511;
	Wed,  3 Sep 2025 08:40:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LFIBGUxs";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B454510E511
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Sep 2025 08:40:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GCJpDRRkd7eYUfOphTDZ3BOa4hIk4lS5+oKonlWDK89mi9v1h4jXVeMOGbQFdGs98KXW5fVfTTmSOLdjG5R8xlR6npijnMf4V1DtVyzBi1ogcW7dtutnc4fm5OWkotPIqEzVXHKNMpv/nKNZsLk/6V1vnfLuoN1rQ8KH4SOiV/XajaQBlOINU8S+uW1MG7rw7lLPRF6+OfsLB/YZl9WaMAVT2kZlCxwepf2d8NB2r2shDit51C2Wr56aYnBDe2IcIKg9HbnOvdO0/jAQg1TFWmyngGTleL/Z4QnrEc+XRhMwlJpoq8Y9YtDmI4uHnrSXY3lsx+jIAemJo8XvOqrcBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tDCsgO88w8vhCDdOChsh+IL/sqWlCjLhr7htZdAdU+Q=;
 b=sCas9gO0VVPN6of+uK7gL4EqCG/TWLO8awAu0u2/Rp/C5LH3Eq5TSDq6IdL5zfA+8x+QpkP+uXx1uPzY1R3SmgBZw24i2l2LQPOIuy5lgZhdDMBbuth0l4F/L1imC2s5SsCYzFhzNeriEeP/xhWtt8hAivKmrm9nvEYn3qzdgYdYcCD5XWQXIkt/KdeC4SjgLvf2KQ0r9v83TsdR59KPnxPUtcKfTuqrr9UNEHB6phd9LHagXqQ46rNhBjnv+mWTCR+EsyfyarlfnH/9rX2QNz/bFLsLfTO3VHCEtjIM9Af983FMSDde/+VfLY5KypibiXlcBjiXkNk/0Q2azcqJ2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tDCsgO88w8vhCDdOChsh+IL/sqWlCjLhr7htZdAdU+Q=;
 b=LFIBGUxsQcV6TiQMVfH1mHwAMxqc11j9W6BmX1ucJOjoS+xFfmXHXGgXKDZXbrWTsPu9kC56kV4l4srNBRdAq+aCbWGdcnQXWUuhDNcmEq5KvjnBheBb5Da9Z7PT2J1Yu0jhcQGi2g8P+np3lgA5gjBDEeAufQik1Na1YBl//HE=
Received: from MN2PR02CA0019.namprd02.prod.outlook.com (2603:10b6:208:fc::32)
 by PH0PR12MB7471.namprd12.prod.outlook.com (2603:10b6:510:1e9::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 08:40:27 +0000
Received: from BL6PEPF00020E63.namprd04.prod.outlook.com
 (2603:10b6:208:fc:cafe::d7) by MN2PR02CA0019.outlook.office365.com
 (2603:10b6:208:fc::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.28 via Frontend Transport; Wed,
 3 Sep 2025 08:40:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E63.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Wed, 3 Sep 2025 08:40:27 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Sep
 2025 03:40:22 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Wed, 3 Sep
 2025 01:40:22 -0700
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 3 Sep 2025 03:40:15 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [v14 10/11] drm/amdgpu: Switch user queues to use preempt/restore for
 eviction
Date: Wed, 3 Sep 2025 16:34:28 +0800
Message-ID: <20250903083914.2604482-10-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250903083914.2604482-1-Jesse.Zhang@amd.com>
References: <20250903083914.2604482-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E63:EE_|PH0PR12MB7471:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bcc099d-66bd-4791-04b9-08ddeac58830
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gW1FSuzJTB/4SuXbK93HHssKZW6Wfb1LPWEtp6HJF9xv0PKJ5pQjV9KZVnPM?=
 =?us-ascii?Q?1CeafVbHEgvPKR8Py55Ik+glhux3FeDHgSNQ3bENOwhWCfwUGIYcBg9fx3fQ?=
 =?us-ascii?Q?EW9v3p6b11pLWm9S41qHmgjuRvYpKyy2jdS5NO9aOH9Mzmrql6b1yGy1WkYZ?=
 =?us-ascii?Q?pSvlZk79AuCDoL2/pWRFYPyLDGpGK/PRN72CD681QmrBoawofJxaPkcT1r4o?=
 =?us-ascii?Q?Ruy3NONkXu56XBjpDKkTjO2qyi0kQF73mRUj5u5bHLdFmeTl7A1a9o9A1VWe?=
 =?us-ascii?Q?AXDgCZ6xTQieeA2lr1n7IR+LefRAcdr5aSs4u5MoY/H8k8SM+ddQFAQM86E0?=
 =?us-ascii?Q?Ije93MwF5DV8ANGxgBcQY9nchb3YOJRO5XINS831VqmG4/uHKagXLgzDJ1Of?=
 =?us-ascii?Q?qffpe8/XmwnIZE8h7MyDdwXpNZqdzzsq12XuC4yqba87kTjXX1H+/JncO5m8?=
 =?us-ascii?Q?ILwuNY/4jH1JFM1Vy6zT7jy7HrBL7XtQEEn3bVBWolgIL/GcIiGUxVzmhA4V?=
 =?us-ascii?Q?jICdV+ckIpOJo4OekRVRx9/oXjEkmXciOgKzNE/nFluBiJZLvx7rFTJbMA/k?=
 =?us-ascii?Q?Oc7N56A9o10Yx1b4DeNVk/4EIi1w3OT2gKqjUHH4NJOi8dNzIr6k6/Tc25R4?=
 =?us-ascii?Q?1KDRHIAXXssq+iGL3C2UCXSM1HLh1RL9NImbmKT702vuNUDjHHxfO+CZAIpo?=
 =?us-ascii?Q?yQkYQ4MVdB9rkflQVJOFW4vTa19QNHtNEdIwZ81BMurugVisEhH3RS8mndMw?=
 =?us-ascii?Q?CG45tAppDJ9vDDK9diBf3u0N6vOn+52l30xyG2z1E/mUwiZXlch3Cvwk+7yI?=
 =?us-ascii?Q?3yUlfX0SXqblWCC0ir4MfpfwqwyEX/IxR/jjb1/G1DCXIYYvY20WgxYck2k3?=
 =?us-ascii?Q?P5iRDWTE4jnKaQAo2JZjMBDbpcOW3HE4tNOMPBmaCrH2kgZmau9IvveU+HU/?=
 =?us-ascii?Q?lI6i6Bx5ilU28129qyifyakWkQtaFxcWB5y8ztZvS3xDH9qEXV0rCy8be7g7?=
 =?us-ascii?Q?7U4dxbhCvz/vnkYeWAm/1OU16Ez/+jqhEHo2ENw1ZvcatQ9SBM1IYIgip+l2?=
 =?us-ascii?Q?kuzUTW1EwJcc4smphDXFviDwRtwOoy70Vd2BACRew59wrv4CuWqE9zhfNkVr?=
 =?us-ascii?Q?7vKFneVEn8Bzl1hAujFlMzKIXedxoslnTO2gu38aPkOZTU6fdWMii9QDPSoI?=
 =?us-ascii?Q?gfr0Q+5veWoK9aMTVbmIa0AqD+vKlSEpOkeojqiMytBz9Lc4pXKzev5oQ5KL?=
 =?us-ascii?Q?H01lg14dNu72oO0RZUV3X5AuE0BMNBsbdipQ2JO7XAc7InWvkpMow5Da45oJ?=
 =?us-ascii?Q?/FThe/DmA80b2nE8jcWyvOR0RcERGNbBDq/e2XUg5eHpin6kiLwAh+Xn9Ngm?=
 =?us-ascii?Q?gdbZ+2L/axd0xtyq4zh5Rje9uHJX80OeQGriWlUgJSPntUHJCcnAij+VEeLx?=
 =?us-ascii?Q?K51wncWm3QsgzgWgDor64VZCdfezpuuLIJJKRjL74tWQUahZGDvUCToZBBwx?=
 =?us-ascii?Q?CEB80Pc6FU8PTAIbdLYRZUVRV22NVFTzZxF/?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 08:40:27.0350 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bcc099d-66bd-4791-04b9-08ddeac58830
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7471
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

v2: rename amdgpu_userqueue_restore_helper/amdgpu_userqueue_preempt_helper to
amdgpu_userq_restore_helper/amdgpu_userq_preempt_helper for consistency. (Alex)

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 49 +++++++++++++++++++++--
 1 file changed, 46 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index aac0de86f3e8..54851ba8756a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -45,7 +45,7 @@ u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev)
 }
 
 static int
-amdgpu_userq_unmap_helper(struct amdgpu_userq_mgr *uq_mgr,
+amdgpu_userq_preempt_helper(struct amdgpu_userq_mgr *uq_mgr,
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
+amdgpu_userq_restore_helper(struct amdgpu_userq_mgr *uq_mgr,
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
+		r = amdgpu_userq_restore_helper(uq_mgr, queue);
 		if (r)
 			ret = r;
 	}
@@ -693,7 +736,7 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_mgr)
 
 	/* Try to unmap all the queues in this process ctx */
 	idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
-		r = amdgpu_userq_unmap_helper(uq_mgr, queue);
+		r = amdgpu_userq_preempt_helper(uq_mgr, queue);
 		if (r)
 			ret = r;
 	}
-- 
2.49.0

