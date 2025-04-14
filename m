Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5C4FC369B2
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Apr 2025 19:21:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D552410E28A;
	Mon, 14 Apr 2025 19:20:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oKgWYYtw";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2075.outbound.protection.outlook.com [40.107.236.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A12310E28A
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Apr 2025 19:20:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UW565oTZXqWL0LqhhYSYqznknzPKaqDET8cF1RJxjoqDClHFNNFhZJX4Vry1srycdI12m+8S/XMQ0ab5r5IWghcLFGOONhRc4naQydhDZm0qCjJMazGuNpzH7t6+WWucn5rwvgqgDeBTJp9lCKhsyCW1CGN/2lhU4DmfzvtB8U0mamUi3o1zEIr32ECBcPykxe+ik8V+x7TDnfp86gCzYmf8dwcCwzPmazixRfig6Enqw9gqsNqGfPQbj7I6btdnw/RjZumQPbG7rIsAG4dHR9BBcxclemNycHJKzMVAcVIMLtTTQgZ9vpB26CuI6eNiYMLKjcq26aCx1J/Uf11kNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GDHEvdCjLBNYQ1fJgcjs8HeTn6026AC+GXsMwXd0HQ8=;
 b=nLZgr0GR+6Uf92ORqX6khHaC3N5V+7G1EixGQOMYQEzQI5Ss8FVIL90CxDQ89xntik8vRMECQmi3T7u0wJapn4XscJSdxVSfkWos3vVPLS2Iu0FWrdvfNLvo606s9LO2YrwldhqSMawzFnT2sU8WcocMuc8bzuiv50eg0ssm0ICCaZiqcALibOArH9YjqkZjDJPfL8wJOEc0kDn1G7b0e0G0c7O+xcqsHg0FKlsYKCrxQsvQLFgaR2SxqRVXYa0/vEZhyTveaAbbozyJU7NI3NXX1ftIp3VTiO4BXv40ON2s7Uke+0HVS64xeXIRe1HEz5wR/zCSUughpRiGDvmB9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GDHEvdCjLBNYQ1fJgcjs8HeTn6026AC+GXsMwXd0HQ8=;
 b=oKgWYYtw2ydESq9NjsK3NNUZ8tXumcTiwm+JvO7V8ZDDcsvJVkEgh0LZVlw+HrCM3Fe2mHKAd7ysaPS5CxopNAR50a0cF5cxQbGoi086YsOSN0ZZ8qkoT+QCsqp/+sOP376+O8/U/XjVhlpQ0Q8MNUa6woYQVm/YDdBhFAXawCg=
Received: from CH2PR15CA0019.namprd15.prod.outlook.com (2603:10b6:610:51::29)
 by PH7PR12MB8425.namprd12.prod.outlook.com (2603:10b6:510:240::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Mon, 14 Apr
 2025 19:20:45 +0000
Received: from DS3PEPF000099DC.namprd04.prod.outlook.com
 (2603:10b6:610:51:cafe::4e) by CH2PR15CA0019.outlook.office365.com
 (2603:10b6:610:51::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.32 via Frontend Transport; Mon,
 14 Apr 2025 19:20:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DC.mail.protection.outlook.com (10.167.17.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Mon, 14 Apr 2025 19:20:45 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 14 Apr
 2025 14:20:42 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Sunil Khatri
 <sunil.khatri@amd.com>
Subject: [PATCH 3/4] drm/amdgpu: rename enforce isolation variables
Date: Mon, 14 Apr 2025 15:20:27 -0400
Message-ID: <20250414192028.3113100-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250414192028.3113100-1-alexander.deucher@amd.com>
References: <20250414192028.3113100-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DC:EE_|PH7PR12MB8425:EE_
X-MS-Office365-Filtering-Correlation-Id: 14524bf6-9d06-4938-0966-08dd7b897479
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gMbqTa3wrBvTUnMxbBIC9sAVh9/NTtvoskfyWJz3gVy+EbKGX6R1Ss7O+r3p?=
 =?us-ascii?Q?qt/C9w/fQruuR4nNXsYtNVCQIW+kFkVu2e9yN8ND/0qcZrv4/mTEw8iuAEAV?=
 =?us-ascii?Q?DiHuX+XDyG+z4ced+eWskmdTFOR9doHjzzLz9svPXn2tot5SQyDlCu0vLcWj?=
 =?us-ascii?Q?OMjSitGivyYLYmiL9zLqvs4xMulwsSK7R7kQfZxHErecOToYZLcePuoWVvm+?=
 =?us-ascii?Q?x+Ey9jxUOBQeGcILculzCofPJjGw4k4wvFpNjf4FCFB3VpGkO+mIIRm+vgob?=
 =?us-ascii?Q?pS9LIxNE8tumQauYnMHWCZ4jBivDOrYgJBDPUrM+HGKHZryvQQUuTl6jON2q?=
 =?us-ascii?Q?2gxrhUDNfZqY9IxGe9v7Cjxn3p+O6Q3F2K7HOW942FBwewQbyV2FysVo2XZa?=
 =?us-ascii?Q?6wlpHifZaGK81SdZ2Y0UsjEIzNBChSkytf7sN0IgJNPL34twZLDjXdQGo08B?=
 =?us-ascii?Q?/K2GU596psbR1x00AGq2z50gZ84S4dMRkbR4zJS/9qLMoUNo9MZAIMZ59er4?=
 =?us-ascii?Q?syD7D2dLNMm/bKEUamonpmNCXpesWufQ2dIW2Jy1pu3CYksG2ps0pcSoJgdK?=
 =?us-ascii?Q?Z7mAO6Lnh2b66SpTt60NTaVBGjoid+AhOyiKjEqeZ3fEnnsYNz9eg1Hc73EV?=
 =?us-ascii?Q?z/d+SPsgwDDr+Owc0/wKc+ZZcakFwytygZ6EbWGIJfQkMWfr6o/JI3wY2chf?=
 =?us-ascii?Q?XVWhYILCgKWRcM6ujTSP1b28RPSBnj23Cwn11b/MzqP5tCp5szhzP9Db4nSX?=
 =?us-ascii?Q?fztYpu3qlJZZdwXnHVNjKldVT9r3fgcWP/aPhNrKtjOm4HbJEX8TRyZyZakQ?=
 =?us-ascii?Q?4WHwsUe+DEYxVw0kkkyzDR2Y56e9yozvzQlUk+S2D3vD+/D+69irZ4pjSin/?=
 =?us-ascii?Q?4pgh+TeY8XDWBSaZd/vYSo/LBBEVmHFNWAo2kJli15mhugn7Jtdzygit9zh9?=
 =?us-ascii?Q?OEjqZ2UyTm9D69F2/49HKYn7On/A7V4Mxs5iQwrtCsmcrbwpBz1OTmXW2Cvm?=
 =?us-ascii?Q?1xgY/tIuRewSg4pbNGbxa1r4deFIOdU8fNOJPxVwkqgFa/TRkzENUBkEH1EF?=
 =?us-ascii?Q?Fg3U82bebIO6o4ir8dSslRx0jtb30t/YOi9SLvIt4ZYiTW9Qd/13muD4PqAM?=
 =?us-ascii?Q?Zl8EZknMB1JKv3d9Ly7H0PV9eHOEl8UT9sl+Y8wlFkMUgTm5VEpRI+HhXRxd?=
 =?us-ascii?Q?BeuOs7ihkIbaCZHT7h4NvP7J9eEBx1bfJAuUmtBq5bqan8eMLG+JQKC515+N?=
 =?us-ascii?Q?KcH9pP6Q0lqG3mAbbWJDOAch7TP/QQlFE2VHlUlgSWgRlQQ4cx3XEJStGCdx?=
 =?us-ascii?Q?9UsNCdJHvdTASmh7uSjfpGgM6du601rklWQaOxDk36VylbANIJp1ZzMf4yOC?=
 =?us-ascii?Q?tHnUgONCrvX5aoN13UvidFBHMMZKyMb+VOZ9hDYr4jSDurnM9LhOiCCNsFti?=
 =?us-ascii?Q?89EY9vmcMncxLNpcjjC8gJnZLW21tnh28yUSc7gAHKBdWJtNhh2t1fXtVVSW?=
 =?us-ascii?Q?B0OrlUZFWuA9W5tbzt1eQVVKlnBsXnv1Kfmc?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 19:20:45.0366 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14524bf6-9d06-4938-0966-08dd7b897479
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8425
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

Since they will be used for both KFD and KGD user queues,
rename them from kfd to userq.  No intended functional
change.

Acked-by: Sunil Khatri <sunil.khatri@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    | 32 +++++++++++-----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h    |  6 ++--
 3 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index e966aefc2b0f3..b96e0613ea7e1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4368,7 +4368,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 		amdgpu_sync_create(&adev->isolation[i].active);
 		amdgpu_sync_create(&adev->isolation[i].prev);
 	}
-	mutex_init(&adev->gfx.kfd_sch_mutex);
+	mutex_init(&adev->gfx.userq_sch_mutex);
 	mutex_init(&adev->gfx.workload_profile_mutex);
 	mutex_init(&adev->vcn.workload_profile_mutex);
 	mutex_init(&adev->userq_mutex);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 2c933d436e564..c58d32983c45e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1947,39 +1947,40 @@ void amdgpu_gfx_cleaner_shader_init(struct amdgpu_device *adev,
 static void amdgpu_gfx_kfd_sch_ctrl(struct amdgpu_device *adev, u32 idx,
 				    bool enable)
 {
-	mutex_lock(&adev->gfx.kfd_sch_mutex);
+	mutex_lock(&adev->gfx.userq_sch_mutex);
 
 	if (enable) {
 		/* If the count is already 0, it means there's an imbalance bug somewhere.
 		 * Note that the bug may be in a different caller than the one which triggers the
 		 * WARN_ON_ONCE.
 		 */
-		if (WARN_ON_ONCE(adev->gfx.kfd_sch_req_count[idx] == 0)) {
+		if (WARN_ON_ONCE(adev->gfx.userq_sch_req_count[idx] == 0)) {
 			dev_err(adev->dev, "Attempted to enable KFD scheduler when reference count is already zero\n");
 			goto unlock;
 		}
 
-		adev->gfx.kfd_sch_req_count[idx]--;
+		adev->gfx.userq_sch_req_count[idx]--;
 
-		if (adev->gfx.kfd_sch_req_count[idx] == 0 &&
-		    adev->gfx.kfd_sch_inactive[idx]) {
+		if (adev->gfx.userq_sch_req_count[idx] == 0 &&
+		    adev->gfx.userq_sch_inactive[idx]) {
 			schedule_delayed_work(&adev->gfx.enforce_isolation[idx].work,
 					      msecs_to_jiffies(adev->gfx.enforce_isolation_time[idx]));
 		}
 	} else {
-		if (adev->gfx.kfd_sch_req_count[idx] == 0) {
+		if (adev->gfx.userq_sch_req_count[idx] == 0) {
 			cancel_delayed_work_sync(&adev->gfx.enforce_isolation[idx].work);
-			if (!adev->gfx.kfd_sch_inactive[idx]) {
-				amdgpu_amdkfd_stop_sched(adev, idx);
-				adev->gfx.kfd_sch_inactive[idx] = true;
+			if (!adev->gfx.userq_sch_inactive[idx]) {
+				if (adev->kfd.init_complete)
+					amdgpu_amdkfd_stop_sched(adev, idx);
+				adev->gfx.userq_sch_inactive[idx] = true;
 			}
 		}
 
-		adev->gfx.kfd_sch_req_count[idx]++;
+		adev->gfx.userq_sch_req_count[idx]++;
 	}
 
 unlock:
-	mutex_unlock(&adev->gfx.kfd_sch_mutex);
+	mutex_unlock(&adev->gfx.userq_sch_mutex);
 }
 
 /**
@@ -2024,12 +2025,11 @@ void amdgpu_gfx_enforce_isolation_handler(struct work_struct *work)
 				      msecs_to_jiffies(1));
 	} else {
 		/* Tell KFD to resume the runqueue */
-		if (adev->kfd.init_complete) {
-			WARN_ON_ONCE(!adev->gfx.kfd_sch_inactive[idx]);
-			WARN_ON_ONCE(adev->gfx.kfd_sch_req_count[idx]);
+		WARN_ON_ONCE(!adev->gfx.userq_sch_inactive[idx]);
+		WARN_ON_ONCE(adev->gfx.userq_sch_req_count[idx]);
+		if (adev->kfd.init_complete)
 			amdgpu_amdkfd_start_sched(adev, idx);
-			adev->gfx.kfd_sch_inactive[idx] = false;
-		}
+		adev->gfx.userq_sch_inactive[idx] = false;
 	}
 	mutex_unlock(&adev->enforce_isolation_mutex);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index caaddab31023f..70b64bb1847c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -475,9 +475,9 @@ struct amdgpu_gfx {
 	bool				enable_cleaner_shader;
 	struct amdgpu_isolation_work	enforce_isolation[MAX_XCP];
 	/* Mutex for synchronizing KFD scheduler operations */
-	struct mutex                    kfd_sch_mutex;
-	u64				kfd_sch_req_count[MAX_XCP];
-	bool				kfd_sch_inactive[MAX_XCP];
+	struct mutex                    userq_sch_mutex;
+	u64				userq_sch_req_count[MAX_XCP];
+	bool				userq_sch_inactive[MAX_XCP];
 	unsigned long			enforce_isolation_jiffies[MAX_XCP];
 	unsigned long			enforce_isolation_time[MAX_XCP];
 
-- 
2.49.0

