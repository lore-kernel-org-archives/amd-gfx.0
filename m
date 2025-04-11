Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85A8DC369AB
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Apr 2025 18:48:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24B5B10EC66;
	Fri, 11 Apr 2025 18:48:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HG8kexNT";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F5FA10EC64
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 18:48:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lRS7ipnuMruSduEU9i8NuofO56F1tSRid2cS77dRBeEScaB+PYVWJolM/yZF8RBoFOO8mYTJR2JMWl5Wm7zUvKJHh+pGwAm1pSstR0ra5eBx82zQxsu8j3TEBcc4zeXKbRNh3SobCTZOaN8m/9rOlWH/k83fZopta/q49Q309UZUSnyyjQ9TNoZW5ZQChdkQvqEe2/WBs95ev48QMrCtT0rgK8xa8HCjnE5AzvRuZriEfqqMlQGQSEquplyuTbO6RQfZmw/vfWEhFKV6YOfLCIhYvt+ttco8ITGo45ltPBl//zLK0sb8Z5d8qw0dVaMQadOErS2xs7LpMS6zKDyVAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nWg2ckUWw4VhNABQdOBhj6wcs91LFV0RlrOiHN6QUrk=;
 b=GgUYTvGaMRF8hutrk4ftKUVkbfSYgigkuCnj22HrPphoKLTGuTgDDPKe4cwCFrw7fUFc/U+bl7ycHu/9+0yq+wuOudz1xweT9719R7VPGWSzOvBfkYsRRxwa/0xMO9SZlBTR2V8BqLwpiChCC7DThZ0Xay9MjThYBFt0MipWe9suRSj8X54IQjb58Ns/KbqHpStBv4Ab77eG1KtStfpTkRuO/u+1WRAqiu04+zN0wjKiyI1lnqoubRGdunBtvSep5Qubrl1pMTz0HlDartcf6mFQGKz3PM71TcYPA/PhG/ywYBCs6BD966JQ4/wZYBAUY2ySjGXhqXSE9HDr/NezPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nWg2ckUWw4VhNABQdOBhj6wcs91LFV0RlrOiHN6QUrk=;
 b=HG8kexNT/wl99JCdTCVNDWkfing0MqGjNZdQ1fTfny9vB+rKYO3ZXM0sI4XIpEw6SrhZGSemVp2vmovlXD7W0B2L2VHniZVbcbCuHHvNGxN/tbt0QIxWsmyclbhK87QXMSHWFMwjwYuB7p+4Jchl1Jbc9p+0e9bXSym+WNZS+y4=
Received: from MN0P220CA0017.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::10)
 by CY5PR12MB6528.namprd12.prod.outlook.com (2603:10b6:930:43::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.25; Fri, 11 Apr
 2025 18:48:45 +0000
Received: from BN2PEPF000055E1.namprd21.prod.outlook.com
 (2603:10b6:208:52e:cafe::d7) by MN0P220CA0017.outlook.office365.com
 (2603:10b6:208:52e::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.29 via Frontend Transport; Fri,
 11 Apr 2025 18:48:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055E1.mail.protection.outlook.com (10.167.245.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.0 via Frontend Transport; Fri, 11 Apr 2025 18:48:45 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Apr
 2025 13:48:43 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 10/10] drm/amdgpu/userq: integrate with enforce isolation
Date: Fri, 11 Apr 2025 14:48:25 -0400
Message-ID: <20250411184825.2890189-10-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250411184825.2890189-1-alexander.deucher@amd.com>
References: <20250411184825.2890189-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E1:EE_|CY5PR12MB6528:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cf40d28-73b4-42cc-dbd6-08dd79297d25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qx8MlpgXirDesefRmM//uQahyp3Jt2B7ZVQjJPmzUOAMMi9D71HifCwLL514?=
 =?us-ascii?Q?DF+qOqnQdzAbIR8T6egd89ZFHWYuw7tYAHj8lqB2MWakNmGExtIQwPgHn+7q?=
 =?us-ascii?Q?4Cp+UBGmmIqjQvLUI18UnVS1DnEf7Bka6ouzvH2LLqC/rJ2Yy9GLXB7rGMFa?=
 =?us-ascii?Q?GG2M6SxlZpr7mEnS9ouwYdSTMLfnjL89gayU03SWfjYjhg1//W7WZldM8hR2?=
 =?us-ascii?Q?PiACJUPHm2//POxSj4/OQcQXTvo+TcRtjY7Jyoqolghu0D1AgANZaC82ZWvA?=
 =?us-ascii?Q?erzGLgG8rGQtb8hDBvdFYeN7iv7M65ofvnYmzeQhBhI6maxi4NZL0R8/w7sV?=
 =?us-ascii?Q?xXM4tJ3Myp8GP/g8jMGX6mD515el4Dgx2BYjHiPX+LNk0P3AduZ8ihpQAhyM?=
 =?us-ascii?Q?ieefyisko8SATt0qukxTOxAe3WOXyAXaLh4A/GtjaPaXx7fOl5LIPDA5lZgF?=
 =?us-ascii?Q?NjHTHktXwtCmxJGqDyqMTNmkmgcIp8S1cDTFcxrbUxLHPjn7hmyrsTAJgajN?=
 =?us-ascii?Q?RXYuy55LIg7vMPW9O/MU1h8XFgzjONqPCe46l7D6ky3mbRyKaga5E+oyJBhh?=
 =?us-ascii?Q?AwwxFDd7dSEBoQUJ1mDEVR9pPBwf23UYOvoPHbNjldBQMv6lMtDINLKc5UIN?=
 =?us-ascii?Q?9Rm/XQPVBfMF+3qPed2im8kgJI1YMt5mrPRjogIoq+zIz12KbeOjJVzt0259?=
 =?us-ascii?Q?+TnmF+cgnaLox6z3TRY/C6vUy81lDhGKQIspkiOte5mpJc+IM2sADvifgqJ/?=
 =?us-ascii?Q?JVkofCD4m1ycA++ILUT4Qd0b7EVvW1edi3aT/BTQCK6IAHIoxUitDt1MVt6H?=
 =?us-ascii?Q?ewxv0bCmjornPTTKryR+Stw2u6kvJ13gCwYgCw/cH0P36TeOLLRUjH0tGTYJ?=
 =?us-ascii?Q?LvFvoI4L/MJPfgz/TIwWk3pyUDCnqg/aCEhR7cn7Z7caxNsPkzocLu79uSh/?=
 =?us-ascii?Q?Hl7HnFMZ1pPSQImqBf1NXkjwGRKdrWFQyPVaoLZeAeUvn1x3BdWTaXXyHC1P?=
 =?us-ascii?Q?4xalGb8j2l6tp+3r/6RQogScDz+uYp88GJJ3JVFil2qBb0j4/2udkgy0M60G?=
 =?us-ascii?Q?pnlpkz99jBdKj/Tet97u7nEv6mxJPQNiQs5CMIJSZskjjiiWVK8yJLut9eXY?=
 =?us-ascii?Q?qPsMeB5jkhxZG7HWzCb2tnU7Up39wpZXZQKRg/kCp5V7/ra+6M5niE9NJ4mW?=
 =?us-ascii?Q?6brrNExwkng1bo08ViD6knxlqhGCZS/BoSxSX3j5NmGRBmipHnurpxXzwOLg?=
 =?us-ascii?Q?wbj9DtS9nxbsQ875i7isyg4hBTl/TwsJpeJ1L98MWN2EbQ1c6xl8YcP78jud?=
 =?us-ascii?Q?ym4fxBLSx2eLQEcYof2Y8HZGC0lN3r+QNR2jKRamQva5ItPpDyPSd04uwJgR?=
 =?us-ascii?Q?aOvZH7rcxPpjpB5lXOjIK09KHj3ydCUfuhK+x7TTAWX3fpZDieTFXDvC3KkU?=
 =?us-ascii?Q?ACy27EL2+hWYwS3nymnCRDsP5+8g26Mz8yn6m+Y1XuCwyjdIkX5v4H6MYl3J?=
 =?us-ascii?Q?JSGZkQxUb3dgrawDZvC8M4WBfW4YQUn3BXfV?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 18:48:45.6310 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cf40d28-73b4-42cc-dbd6-08dd79297d25
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055E1.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6528
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
index e7398e70d6795..fdb7a6d4c57d9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4362,7 +4362,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 		amdgpu_sync_create(&adev->isolation[i].active);
 		amdgpu_sync_create(&adev->isolation[i].prev);
 	}
-	mutex_init(&adev->gfx.kfd_sch_mutex);
+	mutex_init(&adev->gfx.userq_sch_mutex);
 	mutex_init(&adev->gfx.workload_profile_mutex);
 	mutex_init(&adev->vcn.workload_profile_mutex);
 	mutex_init(&adev->userq_mutex);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 7fc4e62536e10..7ccab1268e7ee 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1947,39 +1947,41 @@ void amdgpu_gfx_cleaner_shader_init(struct amdgpu_device *adev,
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
@@ -2024,12 +2026,12 @@ void amdgpu_gfx_enforce_isolation_handler(struct work_struct *work)
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

