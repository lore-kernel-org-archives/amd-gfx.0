Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0666FC369AB
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Apr 2025 18:12:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F53510E382;
	Thu, 10 Apr 2025 18:12:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Om0/zskB";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D279910E387
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Apr 2025 18:12:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cdA3dnf9dcOim4dzHpuSpqUQlBE8GT02TQOE/ri3sqr1O0eIOLnY3rvV5Yw9NdALIq15nVTgIe4yEFmkTI7m2Ztyd9+9vy8G7wZwJeDUBvmBpkaA2bb8lolXEDzStOCQ4bSoM6Kg8f2FUokPOpagh01cRqTkupkBcuCVzAH7RxOF0I01R5UMySGGfe+67Y1QbecwvIRQXOQMrek7X9B37QACE4lggSeYl+vTvfpXXwsT+sqVdXdgLPkI0zFyMwFvh1pDAVJ/LViVHIpjFwxFR8IYFDQdBkip0T2E6jR2NNcoFIBUGR5XzW94/s1YnPz7COVW9+H2cn0waDwHm8bTqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K0uipINfSOD3u/exPp48tSELAp6KL6suPv4jIUH48G4=;
 b=rSvAajxDK/RSl05slYNRTG0FTKzorf5x47GKmsxd1sBychDmwFRSrkvZAToJDopF3hnjQ0lcZ3yw9TKK1wJSQY74RpJOFBL9VsWZqjxkM+SJiWVeMGYFndc8NUeIoeZvBXEtyqxAzYcPPeFTeqRVYD1Q3fi8mMnMW50GlujiudFJHTQkZ/ZHNIoIb8ZJLtUQEU+633zj5HIk92eEJYg2nNOOjiPuOE0U4LpzivMx3uMHB7RW6zCUVnFNQGA0Ux+8thxzDkktKgjXVq1N4VLQwF/8+DcQXjUWsK5GKLDkeZ5rAlkkhryZkjaCMQGZJ0DrWrQO5q7uc3MDnQFLvHw/0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K0uipINfSOD3u/exPp48tSELAp6KL6suPv4jIUH48G4=;
 b=Om0/zskB47Ut9V93SegcYAglDMMRxFa6yocV1ZxmCSaIH9/KXIGpixUQZlCZcG8Sa60OZX0Rb4+RzmpiJp3OMtD/81dLQnFFzPHHEVEBNkP7uO5Hz6BvunVYRDLd5b3OpJvq4Kf2tILs2NlBvUF2U4LktzLd2EaK4qR1kkSPrB0=
Received: from BL1PR13CA0009.namprd13.prod.outlook.com (2603:10b6:208:256::14)
 by MW3PR12MB4427.namprd12.prod.outlook.com (2603:10b6:303:52::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.22; Thu, 10 Apr
 2025 18:11:59 +0000
Received: from BN3PEPF0000B074.namprd04.prod.outlook.com
 (2603:10b6:208:256:cafe::45) by BL1PR13CA0009.outlook.office365.com
 (2603:10b6:208:256::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.11 via Frontend Transport; Thu,
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
 15.20.8632.13 via Frontend Transport; Thu, 10 Apr 2025 18:11:58 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Apr
 2025 13:11:55 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 9/9] drm/amdgpu/userq: integrate with enforce isolation
Date: Thu, 10 Apr 2025 14:11:38 -0400
Message-ID: <20250410181138.2287932-9-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B074:EE_|MW3PR12MB4427:EE_
X-MS-Office365-Filtering-Correlation-Id: 019e5ede-7389-489b-c4cf-08dd785b2f3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Dp/C5LxX9okYF2eG0fYOBv4Kdsy9ru04/FIEZyJGFvuSqHzR0YFUzhmPXItL?=
 =?us-ascii?Q?524HN6n0l6irzcT9LaQUPx+lWDerxWT/dmAZvz+xuLXXDlyX16jBfXOn/IUV?=
 =?us-ascii?Q?rJMGjM9OTo9wWqqlgTb3IciroMhjGX5WGvhQnXhZslg9AeVT5sYLiD/jt1IO?=
 =?us-ascii?Q?a086qTh7A5abgKCuS4JhGW7tQGALI6cKiO2f++HCYEPggPc7E4ROH00FYTwk?=
 =?us-ascii?Q?Y+OfNH97qkkWc2MMIOBcXvfQRifnHjDBhr2lawjSVdDfN7nrsWspE8mpMeBH?=
 =?us-ascii?Q?lD+RaN1fLnIvUk0GW4TKM+UXAeONN2KHMVABRSQKEpoTvhMRehc9QB6HgTGW?=
 =?us-ascii?Q?4jZZ+gqKBoH+i5dj3htY3+ApnREGFAtWUzKEBlKEs/YsoWtD1oYqmQy8zeDa?=
 =?us-ascii?Q?2WzGBvccZJhDh0lPAmrOYkwKCL6eFCPv7+oPH1NHfveepp5jROguPCNHYaj7?=
 =?us-ascii?Q?CopWqbh5f8K4xgaRraR2PY4z38oBnqMUjXKsmmBsTwG0wnEFihed2VNLrFK8?=
 =?us-ascii?Q?Jis1cYiZxR0JAkaJB29pSCe0htKsvH/jtrAZLVp2eHAQpOuRNFBaaV9DObhW?=
 =?us-ascii?Q?MICLBeOvuFLXLrrACb5wxwmYH68GaL9dLuOm/1OdiCmrhTSzACdoDN/mKiL6?=
 =?us-ascii?Q?c3XJx8r4gCfEw+Q4ld/mTeDqJyzl2ZPMd/OZCw6vlDo4TuawZ9eo5DZjoTmo?=
 =?us-ascii?Q?NsCfs29xifCIpKyVPPI+YVpYd1GFe/oofePj0+MMqEUFNXvGPAjB6B/nUOWb?=
 =?us-ascii?Q?GsAs66zjNVn78nPddpqGmFSRPaNoLio/jd3r3uXsbrDpNOe0zTKA6MCzpRch?=
 =?us-ascii?Q?VgTPQzyogluCam62Vh8NXVenTCZIkuM+NuOAFLuvsQq2WRYXaGg8atSxixBu?=
 =?us-ascii?Q?u0l6tWelzCUHtEAlsCcKssYgL14zuPfjhztLD9RqWV91Xi6JRG7bCai10UGG?=
 =?us-ascii?Q?GkiLSSWTMTIsPTBlqqj4pU+zopMvc15l2L+eEYvqb+bshquhcMsMTG9+ZOK1?=
 =?us-ascii?Q?93eQgX5u9lh0xOfmMDFoWce+5M1wX9tYQGN3GMkhzmuePepRXMOqNq+86CdC?=
 =?us-ascii?Q?7ILgchRTCp+wFKvyVrsFR04j+EOEQtX6wKsI9KnnZIpxnyDzuticr5qJoqQR?=
 =?us-ascii?Q?Qi6akHdNTWR7PLnk+ZSDo2fzW43IcZ0BmWhZfYGlX8RL9Wr3Dqw4/fEtIitb?=
 =?us-ascii?Q?4Rksx4c7GomkxYBfGv8x/QJEBfT04BP1l86XkuvD8FKcJ0kx7eaH1HcnwdlJ?=
 =?us-ascii?Q?vQJ/AOfsU3IYw3ojrS+RmnWv713ydUDfbKdA4oTy2jPqTKsWgfXGGAuIO1ck?=
 =?us-ascii?Q?WXxNBUsCm5lHFhoRUlTu/WKkUrh3G/3t+y+CeUYBxBtwq7Yq1+lgfF/XLJWa?=
 =?us-ascii?Q?mCS21deJlTl8hH+W/VnFDCgT3/D8F5nUpg7l7Jpo9obJqnYVLoSEmJ75lDDD?=
 =?us-ascii?Q?wnvgYKMY2DwjTABO9HnlQSoAbQ1VXjV3TPkMhLXc6GRneVQ5CdLlaqAnoSFP?=
 =?us-ascii?Q?QIyKkjtPBoH5sKKlowG9fq/UCwo8WzAGEN9p?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 18:11:58.5747 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 019e5ede-7389-489b-c4cf-08dd785b2f3a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4427
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

Enforce isolation serializes access to the GFX IP.  User
queues are isolated in the MES scheduler, but we still
need to serialize between kernel queues and user queues.
For enforce isolation, group KGD user queues with KFD user
queues.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    | 34 ++++++++++++----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h    |  6 ++--
 3 files changed, 22 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 4e1c97a919cec..3c6679fce7c20 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4344,7 +4344,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 		amdgpu_sync_create(&adev->isolation[i].active);
 		amdgpu_sync_create(&adev->isolation[i].prev);
 	}
-	mutex_init(&adev->gfx.kfd_sch_mutex);
+	mutex_init(&adev->gfx.userq_sch_mutex);
 	mutex_init(&adev->gfx.workload_profile_mutex);
 	mutex_init(&adev->vcn.workload_profile_mutex);
 	mutex_init(&adev->userq_mutex);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index a42ac1060fa92..e08323f601535 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1928,39 +1928,41 @@ void amdgpu_gfx_cleaner_shader_init(struct amdgpu_device *adev,
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
+				amdgpu_userq_stop_sched(adev, idx);
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
@@ -2005,12 +2007,12 @@ void amdgpu_gfx_enforce_isolation_handler(struct work_struct *work)
 				      msecs_to_jiffies(1));
 	} else {
 		/* Tell KFD to resume the runqueue */
-		if (adev->kfd.init_complete) {
-			WARN_ON_ONCE(!adev->gfx.kfd_sch_inactive[idx]);
-			WARN_ON_ONCE(adev->gfx.kfd_sch_req_count[idx]);
+		WARN_ON_ONCE(!adev->gfx.userq_sch_inactive[idx]);
+		WARN_ON_ONCE(adev->gfx.userq_sch_req_count[idx]);
+		amdgpu_userq_start_sched(adev, idx);
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

