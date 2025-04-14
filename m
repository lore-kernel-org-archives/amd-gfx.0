Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF896C369B4
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Apr 2025 17:13:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B43110E632;
	Mon, 14 Apr 2025 17:13:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xWwUmTGJ";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0AC910E2E5
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Apr 2025 17:13:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PEr/odurE9YiFRaVy5V/5SeByaEWSFCf5qOYID4vQxLYhvxPI3MGLHlWcgm+t5ZGrXecRd4GLDUcpFns+t63yT652ta0YUX19ij5Jak2Bd4sA/hq4tH8UcdSMY5u9Oq9iYNZ2Sm9N7HDV0bLcU6r5ytMY5sI3LSE36Z6wUnlFHx52VBkOqUqK92tZCDKx++ah03wLZEC6nr7i37ajaOgTwovy11Edm8mGtjalgUA9gs1xdTqrcZcLtpqyLk9r1iI9XKqylV450vHAqno0eTKtsDd8XW7scLw2NatlR73cSX8NjUZaUPb89mxPYOzlMB0Phr16bv+KwUDhGqqyH8+9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IKD5ZPtftCLYAV45xtZOU6C/Wv4OyyLZ8lPt/pb5RKU=;
 b=wowQCfhS3kW/nPbCmAoWVTwJj8exETXYMX6ElZ14zqg83c+bFCn/dPhJVG7Zhv9jFr/Vnqd3ZC9FxAAhv0Btyh43yPZ9L58lUnpmvdY/ixZbdcHY+kfiOXVMyhH3h0bNo1M0qNw1byrVu5JG8QP7JecNRnuw3FyplfCxDf2OFdsHfDJxhQ6lhWRnAwoQweiW3LKBj13AIvjerPQ2PF0ljQ0QE+ULyYt140xEIZEWInOujo00/K37rROeVdtawcOncTwYJSTqht5l8/3A+b6Qof4OarlxHocj2jIJCHrh5+BGJb4njTUuakIQZOGLIgzDlwwseaJ04HDWjAv2nBAevg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IKD5ZPtftCLYAV45xtZOU6C/Wv4OyyLZ8lPt/pb5RKU=;
 b=xWwUmTGJgtZV150y0hQ3kczkR4sIdR4g+FUssQRTLl5c23dJenEjCMgT8euL/plea/kfyd2CqP+totrBkSLtDNzIbMoatstI7teIErWXLKidxWRTx+fqmJQXRbNhxBZOtZ0I8W3T29s/IM/8UtW+Zi9z//1RAclU3JS4k0l4k3w=
Received: from BL1PR13CA0301.namprd13.prod.outlook.com (2603:10b6:208:2c1::6)
 by DM6PR12MB4482.namprd12.prod.outlook.com (2603:10b6:5:2a8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Mon, 14 Apr
 2025 17:13:15 +0000
Received: from BL6PEPF00020E61.namprd04.prod.outlook.com
 (2603:10b6:208:2c1:cafe::c3) by BL1PR13CA0301.outlook.office365.com
 (2603:10b6:208:2c1::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.10 via Frontend Transport; Mon,
 14 Apr 2025 17:13:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E61.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Mon, 14 Apr 2025 17:13:14 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 14 Apr
 2025 12:13:13 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 3/4] drm/amdgpu: rename enforce isolation variables
Date: Mon, 14 Apr 2025 13:12:58 -0400
Message-ID: <20250414171259.2996574-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250414171259.2996574-1-alexander.deucher@amd.com>
References: <20250414171259.2996574-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E61:EE_|DM6PR12MB4482:EE_
X-MS-Office365-Filtering-Correlation-Id: fbc87de5-3200-46d9-068f-08dd7b77a4a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?X0AuQyI1KGJVPZnIdApg39MsIGkZOf/dQsDOStIZPpQAjTT9SJftaLhr0sYN?=
 =?us-ascii?Q?t0Ph26BP4U1StCcX89DVHcHsQjiTG3ZC1eJq17aoW1aGJ04SeMY872cgEYwg?=
 =?us-ascii?Q?etMMF/N34tK1uuI55NH5Vdht3PRgb1fOwI+Pec9aUBUA9P5BqWsl4OEc/fNL?=
 =?us-ascii?Q?90dK+ldlpplqIpPalrewdpHORCbp8DEFEP+6AHGBqItwjP5UvKojcqQP1urr?=
 =?us-ascii?Q?WN98j1n65kssbj+aUGja6flSn7YePRdrCf/PrWYFO5Hx+kJL8ycX4kn+ww0A?=
 =?us-ascii?Q?rFGF/p+Oi0yb3X+M/H8ddupTMIbKndGp8GWwt30/VbTQ6WZ7hqzaexp19hLv?=
 =?us-ascii?Q?l8D+m23gbFXUVrnM/OUVEKWQC7oEasmTIVujoL397HnSurmL/NzUfXmdnScM?=
 =?us-ascii?Q?njsAcQC9k/07RJh4cDDvYvssIN2Mtk8UFGz9e7F3zHy0fqk24YU6LRRp4Bnu?=
 =?us-ascii?Q?ukbLK1hhbJL0mzL8B7pKhmaeYnWf9rl+fS8X0sZ62RsegIOfAN5V6b4I83d9?=
 =?us-ascii?Q?0ZDUdi3Ob6Il+px9mj8djD9Upi9NEarEiJ30mWxP6KUK20SfA7V4Y98Nksn8?=
 =?us-ascii?Q?YD6J6V2gyCfhsMhTbL06JL0L3CmacfragAkJ4TlgIiDWuI7bGr5D6ITIw8MV?=
 =?us-ascii?Q?CaBS4bG5bzeCcjMzcgdJBjqTDnTqRXg6zcI5aoaeXOjNz9Gx8gyfeE0giFbn?=
 =?us-ascii?Q?TGT1N9dUHF2zDfunbLm0/u1Q7aFBV42SM+A3odPOp4EUKgPZ6rsObxa00/nS?=
 =?us-ascii?Q?J/+bASTCWACZeY121t2KY7+DWUe3FY/mL797CKnT2jkjLJreIh+LjuK+J6Jr?=
 =?us-ascii?Q?0s3Y/PCsgEReLxxzF64iNnBM4Rl4h9JPmH3ooWU0yNea8oa6vxmi8GZ8/EEJ?=
 =?us-ascii?Q?jsNZjukf5ozUqHzD+qFh7XMK8Z2cctFpEcuSbw47NK+BPUdOHiSEJxDcQLPp?=
 =?us-ascii?Q?v1uJbob8a0MREvcR96TLY7oehw6DM0t07UJkpVsjDyEHWlOG3yj+BuZHLlkj?=
 =?us-ascii?Q?ZfqN6/GFLpz1JUIJkBRiHw0JYPtKeM2BeyszDK1gDweYncDymhm3vtx5h9Gd?=
 =?us-ascii?Q?RWPuvYqQNBhcsI/oU0KMwLL0pbJPgjobucKAgMiGtwNgzg8EYIXH/k23AkvV?=
 =?us-ascii?Q?3X1B232eUgt2QmmPXr8c+fyiRvyp7c94eS11tdPInoYk/Nar9uTbR/h2HA1s?=
 =?us-ascii?Q?0jNzQJwM66Yv8X7CzBXHx1YcaaD0AsiJhwJlp6ke4RtKiGJ7Qt7uLCPcL2yt?=
 =?us-ascii?Q?uR8MBQlkNW9BPwSCtq/9SopYBbTinS89+eYmVFcjVl14+u4aUcfK9a+aA/8W?=
 =?us-ascii?Q?tInzKMVPy4DPo9YP2IexqurLYhtzrgzcimPu+jZr5i3ryoDBnzqnFdnIYS7h?=
 =?us-ascii?Q?iSzCdgBBxv838snPYANaks9fq+V7g768QhwtNJW1TeHpmvM/sBk68EnOq/PG?=
 =?us-ascii?Q?hRFJ6nAJjl3WdSOoSYeNM8FGjLbmjtqffqkm/pkMrCA61tgA5FacY7Bq9TCL?=
 =?us-ascii?Q?99++3Kslal43PWItCYiNoTar8KPedPczmYcS?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 17:13:14.9416 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbc87de5-3200-46d9-068f-08dd7b77a4a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4482
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

