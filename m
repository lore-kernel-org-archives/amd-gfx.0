Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91D1DC369AF
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Apr 2025 14:12:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB18710EBD7;
	Fri, 11 Apr 2025 14:12:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GyKrldAS";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2050.outbound.protection.outlook.com [40.107.236.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CABA10EBD7
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 14:12:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JEiqgD1hW2N62sUw9kjKJWBRkY5FljszN4pD41TLmoq5+1bK60Z/gPOhls0WMvjR3lhLzRWd9UQqX2ZiQAIswHmhMIpTDDDC+jqo0vYlD8Iymj6svtzmfuwgMznaz+aLS4/JB4c0TaBQjqF/8fzlwhHl/ZqpGvt+MhsKrKgjL2JSuhImtahmTWA9oNdxFY9EHWZYyF0OpMJ9nXx3bw9b4Vu0aU1J+r/dM2aWjjxY6Z/nvo0Rbke5IFGnrD7dw2V39Z5dPhk44IAD26jhyytXsP/9WT5GDFsxX+hPvtKP2bkUYoph+e3aH4R+Pj8vplj8Hgx2fI/yPkWiAmNiALTS7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+1pWg/N6uQs8mxs13zV56ifhyuMqXp9h/xC35k6MXhQ=;
 b=okz9bk3ckbI2cdHs6mzXAfVVakslPYpClEarYn46EasUGNdS0ur60xr4fZqctGA/h8cfxDaBUE+QqKli4E/tXcMoyOgtxpXfWgUDAyreQozug1+TbTd9tBAOYIsHyssJRp6QPzNy8ey83uLiSe1/H9WIbE8Ex3xM5SIs2c50uRc6AXb8MW71hLq8Q4zSCqbuaT4KpwNHEhspCqxu8lkfdhsbSWLPC6EvIfVmxPpW5dSgsFhu4P3tg3qAQcDqQOc1qag63OqoSwMhmGdK+g7ZU9sAR94qEa5pS2ZeIBOzsIsqQM089mV848MFsXEphNuCxBWaJXQDUrVNRSzc/Hbvfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+1pWg/N6uQs8mxs13zV56ifhyuMqXp9h/xC35k6MXhQ=;
 b=GyKrldASlDFplzBLPNVzXwPxcDUM5yak7JZVx7K4h6boaLc9IPjaEivlMtegD/psYogDevQRQRgjFP/SxRBUWFy9HvyNRrNdTxDrg4utJ6KyIQkB/yi8FKNM3o0HrsZi/k5E1lShDSp6gReDqOmRejoAPoY4WysR6BQVirNb/UI=
Received: from BN9PR03CA0642.namprd03.prod.outlook.com (2603:10b6:408:13b::17)
 by DS0PR12MB8344.namprd12.prod.outlook.com (2603:10b6:8:fe::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.28; Fri, 11 Apr 2025 14:12:48 +0000
Received: from MN1PEPF0000F0E2.namprd04.prod.outlook.com
 (2603:10b6:408:13b:cafe::7c) by BN9PR03CA0642.outlook.office365.com
 (2603:10b6:408:13b::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.26 via Frontend Transport; Fri,
 11 Apr 2025 14:12:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E2.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Fri, 11 Apr 2025 14:12:46 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Apr
 2025 09:12:44 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 9/9] drm/amdgpu/userq: integrate with enforce isolation
Date: Fri, 11 Apr 2025 10:12:28 -0400
Message-ID: <20250411141228.2722962-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250411141228.2722962-1-alexander.deucher@amd.com>
References: <20250411141228.2722962-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E2:EE_|DS0PR12MB8344:EE_
X-MS-Office365-Filtering-Correlation-Id: c6a9bdc4-6373-43e5-7cf0-08dd7902ef69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YgdF2oQG8D1PLWwG8UkNqin1Y6ZmW99mI3FU7XdTl3dI3MX4RCNn7kAQSNl7?=
 =?us-ascii?Q?v06TG9NcfXo4mLIuEaaIhHt7Hr9eTVsphrMzib/M2y7USJ1sP6PGMlw0AHqy?=
 =?us-ascii?Q?wuvWL7zVxa6wRnYeO07skk/iKBX+nvch9CCHHTWcVd0b6pveJzIezT/5xBLE?=
 =?us-ascii?Q?r0HkDCxMN6z0WriBycTmEUVl82ZWd/uBj7zNUB52cL53T+NFKZ6pkyi8v0/3?=
 =?us-ascii?Q?B4ptVhOsuto9Dn/2yclQ/Mfw4aqZUP+ENMYnsHeo52Fh+WreOvZsL1nVkAaZ?=
 =?us-ascii?Q?Zh1HOt0d39dSU7197sQ3W5CNG5SXXjFSptMXK65XyGnVPJ+yFjbllGIV6apX?=
 =?us-ascii?Q?2XM9KdhWJTxfGKk1Js5CCEMcw5gUygTbKyi3+uxJCWw3WVDVnK1coij/sdBT?=
 =?us-ascii?Q?0AlhOo4Gcr8hItMjb/YC9SZOZxhZfPZlNnaRgEX66v/1V/4L6wLdK789Ivln?=
 =?us-ascii?Q?6Tu9stljaBdzyCIrDMUvQGZwYEFSFw1QmmgTAjnAM1HsArErybRwq5RvESKe?=
 =?us-ascii?Q?p+b+09Nb36n4YrMzj9gpFy4bqVnY73cRnFNljUVKpvmQIrqVsz5N0HVbDjWW?=
 =?us-ascii?Q?6SjfkIsxAdYE8C07a+YY7FK9yGOyoatcFFWFmefXQ2o8FZD5NZLRBfoD9RW0?=
 =?us-ascii?Q?NioB/I4LnLZpLwxEVUvom+SezVLTiWN/xnJ/7g7I3RqUwnlQux+tbNErQ94o?=
 =?us-ascii?Q?y7pu5ikzPMeiZaGb17/AHnVeCDQ6i50U0wBYczWHFbHqGv5zXVXLgKddhR7m?=
 =?us-ascii?Q?5lnvyIqxU9kIEWY1VBlE7yx94J8aHFFzTJ0fujO/Xc05mbxmkVdEj9y1k+sF?=
 =?us-ascii?Q?ABsF6cKTBT60+O8tF3ZHON5jhoQ4adIIMzdoUtwIg5QdxDKpbFYFCXCvOovx?=
 =?us-ascii?Q?223gXmumyhsctd35x046RKSGPhj55QreQ9LByaAYeQegUDDPsP3IE93/kdSC?=
 =?us-ascii?Q?SHETjxTZ5K+yn6Ye6g7Wqhgn9j0TAOM7cwH8oQ+VXIV0lNkjJWcXm0LrAFfP?=
 =?us-ascii?Q?mng/heTKepP3r1zV7t8XRJkDZNOxE6cmo6j3S51FtRnn1NXpHbFFsZzqpKTA?=
 =?us-ascii?Q?ev5wJzhw0dWVtKuIDv3aIT/t0wprUmqq4KYcIi9YxkRqxKn4ZuNvHf0QoeZg?=
 =?us-ascii?Q?602j6RztjM8GN2B7yEAJkg+eoJszXzF92fEGy4vbwOg9Vf3Uq0gitK3U2IF+?=
 =?us-ascii?Q?HUxz8XEY6PwIzbM1Lba+FXXTFmj/mCUcNFboz+tsEcZvbUQupxPU9t7EO4R7?=
 =?us-ascii?Q?fP8uVtJA6kZAEKNey43ekpod2WFIxuk4fpXHbC8K3Lu21cCtpPQxMEGf8zc4?=
 =?us-ascii?Q?46YRpAyRuq844A7DtrW4WXB+h+DPFR2MuKZRjfK69aDmGMKDHeiF/o5T93f6?=
 =?us-ascii?Q?vwUpBBknvpoTjCYkVSXvnXwAGWBlYrgrs1Lp91eHQxHxwmAh4uosJiF8TDoh?=
 =?us-ascii?Q?Qh7pJ8bal/IQfiSJmP+O9smNbYDcI4B87l7nRbUJMWMLyDmoQmnChMTVfGCp?=
 =?us-ascii?Q?r4EwjAKLRsa/iRsNGGaB1MxAJZVqbLuQBa1h?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 14:12:46.9729 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6a9bdc4-6373-43e5-7cf0-08dd7902ef69
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8344
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
index 2a3cab6d56286..28e9d4480e7dd 100644
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

