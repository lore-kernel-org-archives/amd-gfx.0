Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1DCED3E77A
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Dec 2025 20:24:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6816F10E754;
	Wed, 10 Dec 2025 20:24:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CYAQHRHe";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011037.outbound.protection.outlook.com [52.101.62.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D721B10E754
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Dec 2025 20:24:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ctug/r14UhI2WGs+g6kfQCKkjb3jgt11VVlqS2e5JJ7Ka5n0kfhyy/XT4MK6eYX+EPFObHb8vf0lZEwpKrE1pH+mJoV45EKZRBauTqRhkv9q4tYGVzYIdPetn4rVQoAORcjDXhSWU/vtw19Y1sWzGwDBb2x4yj/5mExsyah9hEuvNjZmNAFzg/XWHeF9AbwKTJ9yJJPLhmwvDVnqoiFfiIJmDFR9CEiKaaK37atV1dQXvytHmbq4Yx9iGimMWoAQyCvaoCFdqEWNvbs+Q8ndMuaBvbDQdBSPfRgCXDrc0Taeyj8VQYFAbosTYCyon7tj0xSBW2jFc2Fg+8DTADs36A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4K+RWUXkqtJ31x/GGe4zVuz49m3R106viyyfNvxvgOY=;
 b=SOT0jKqiW+uErR3bPFSh2BYkmVqEvnWb5FWl/0dR7NHORipBsHhgLJTUNCgFmy1rYKmw2ZRF7xMMDIeT1Q9ZGy4xFUjoTyUsw11KO/TTk3k0eIDkEYPMe2MSNb2SMCn3CMF2ZFlTsk4sKMZc+AUTGS2iPbed3w94XEhFm88NTL1bH6HBEe1BuPYwlAdI2c9rFLLrpc3f3bx1+w8ZsFXwyNEk9rJyJuObXHY+BUEWXyWPUw/aP6/h+FUpi9dqeFcGy0qaqc6Pj3MtObkizsxW3jjbiL5aBF8VJonuUChr+AM1TTS+n8riICkaiWGoG5sudhYIKbsM9A/qAdVRYiy7QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4K+RWUXkqtJ31x/GGe4zVuz49m3R106viyyfNvxvgOY=;
 b=CYAQHRHecvJ5Duvet1Al0a6M3YRLu1XCI/aiijK363hEhWubiH5vWrIe4+mEHfWMKkRV6LQALa3W4iaOAz4On2fHp8bGRB4oG1I3I7ALj54fkJRQ2NTtm7z8+1MNxhXy1y9LwNQT5S2URPN/2UjGHiiOm1t3bRZUVyWPwH/XbLk=
Received: from PH7P220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:326::25)
 by BY5PR12MB4098.namprd12.prod.outlook.com (2603:10b6:a03:205::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.7; Wed, 10 Dec
 2025 20:24:07 +0000
Received: from CO1PEPF000044FC.namprd21.prod.outlook.com
 (2603:10b6:510:326:cafe::21) by PH7P220CA0003.outlook.office365.com
 (2603:10b6:510:326::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.7 via Frontend Transport; Wed,
 10 Dec 2025 20:24:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000044FC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.0 via Frontend Transport; Wed, 10 Dec 2025 20:24:06 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 10 Dec
 2025 14:24:05 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, <SRINIVASAN.SHANMUGAM@amd.com>, 
 <vitaly.prosyak@amd.com>, <christian.koenig@amd.com>, Matthew Brost
 <matthew.brost@intel.com>
Subject: [PATCH V2] drm/amdgpu: fix a job->pasid access race in gpu recovery
Date: Wed, 10 Dec 2025 15:23:47 -0500
Message-ID: <20251210202347.63243-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FC:EE_|BY5PR12MB4098:EE_
X-MS-Office365-Filtering-Correlation-Id: 20395c7d-d81d-44c1-4a34-08de382a1162
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gLBN+KE2f7lUZclZa1814pEwX/I4iSl5SwM/LJ6mtPJewKVKzFf3r00r+S1H?=
 =?us-ascii?Q?oP7pWsTnMOmAjIBqIqlLonXjEMKe1hH7T6Eqy/zBsFSo8HZ/icxLfDjgmRTx?=
 =?us-ascii?Q?3i5YHi52WZ208UfD7g84CXJ2kGmmWPYcn2oFt++IBMTafAd6VQNLmJ52MEhU?=
 =?us-ascii?Q?XjyCyAEoVj6eL6Xt5CyrFLiS0/Gz8sH8XxqHw5uoS6wANfhwMuIjsKJHBvUH?=
 =?us-ascii?Q?18sDgczM1B0dn3vogYzZB7MThRnqArAxJrmM4sw/XQENkDZP3hQa2+C4VfHB?=
 =?us-ascii?Q?EJ+WewkDmbjeeiduTL1nZq5qeAhWHI80Blm9xernDbtz9qSur5WepFIPDw3R?=
 =?us-ascii?Q?+YNkbfhJvdz0LyYKplLdjqTwcnW1HF7MWxjF97mqO05dsjq8U1MVbvpkoaHl?=
 =?us-ascii?Q?Bpl0dbjiv1UzrD41b91PjcIo9uTqxk0bpGSqoT6NFszC3ve5ELfFLQMs/amJ?=
 =?us-ascii?Q?W7nKSZZz5LYjR+xes/qwQvrv+JZOCfa9LKW1gD5ADWfqsdvnsQytoy4F/on2?=
 =?us-ascii?Q?tnOltPJqiKmPMzQoZJhXEQok78IxruvHeJoxGEg9fjYu+/4rp2mdU3UnhK6o?=
 =?us-ascii?Q?jakLTVcNA2BmU04M2I8QCsOopyWSqXkf+4qU43SDGky12s9M4myauroxra3O?=
 =?us-ascii?Q?eKg6jXdReXxkzGheZcxBA4rkI3y6unfS55dN6cDrrSkaP8KwGZBXsHnDtH9s?=
 =?us-ascii?Q?cceISW5AqV3sn8dsH8KcpDGhm13jkoWj3r8Z3hhS1HgvGo8oGi49+wQxr9N6?=
 =?us-ascii?Q?QM1WeOXv7tPyt313G8YGpvCroGFh0KAZl0wfuAzrx815soiHw/CZ8djx5OBn?=
 =?us-ascii?Q?EYGNXgqJT/kIJVj89As7AXQjngTtSosfvE0fayWCu2EEskQx6IUipO5B+Bsd?=
 =?us-ascii?Q?EctwIKRs67X/dV2a3/CmMdd7lYCdDNxRFtHKTyJ04WU8sL1IOTJfHzvHGMjt?=
 =?us-ascii?Q?pVFHux8+OCc8kINrtcgkkne4pnQD2kHH2Ty9lXn9/UekiZj5X4pK+St02dWf?=
 =?us-ascii?Q?bfvwwg07350Hm5fSk/2iSMG0YvP6B+oUGmK+F9rXGfIZjfJHBr2gF8RvE+PT?=
 =?us-ascii?Q?3vpteUj044TCoRS1LiI12HiAtYzytLWy2uY099j4KvKVuThI4Eru59AvntxD?=
 =?us-ascii?Q?06M0lI2U+fDX8nlqPtM1qw19TjI0TlS+0j46dA0aPL1VjEUkZt9KNPbaApda?=
 =?us-ascii?Q?3W44s+YoB7HXUiQE22RkD8DPK4+4lVuRvmFCsbU52oz06AHE3jfVHgD87Wt/?=
 =?us-ascii?Q?oxChPuATns0TAXVPqB7Z+m6/gWYMefiFbkDBtLtoy4ngwy06VSuXJ/usRuFc?=
 =?us-ascii?Q?iptFFnuNcGsEfkFwODvrH7g2cZDP77S2k5G1Z63Kxv65mmBK+FHh1V264Sww?=
 =?us-ascii?Q?1pNcdESlV/BB91IM+6pv57sBgY3zc7BUN1ZF6OHUUjS0gcb/1C/SatNufAPp?=
 =?us-ascii?Q?EKLOggYV/A+UPUUdGEkI83nVSY9paXLQmRElKdZhCmbXg/55qPiFkKxVFAMg?=
 =?us-ascii?Q?poUt+boJfjLrZAkZuSNRtXueZ4U6TGQ7hqDlk9S9X5tR5Vd/0tTRrooQZovA?=
 =?us-ascii?Q?ilgYXlYiTLuQaJeEBdg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 20:24:06.3864 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20395c7d-d81d-44c1-4a34-08de382a1162
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4098
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

Avoid a possible UAF in GPU recovery due to a race between
the sched timeout callback and the tdr work queue.

The gpu recovery function calls drm_sched_stop() and
later drm_sched_start().  drm_sched_start() restarts
the tdr queue which will eventually free the job.  If
the tdr queue frees the job before time out callback
completes, the job will be freed and we'll get a UAF
when accessing the pasid.  Cache it early to avoid the
UAF.

Fixes: a72002cb181f ("drm/amdgpu: Make use of drm_wedge_task_info")
Cc: SRINIVASAN.SHANMUGAM@amd.com
Cc: vitaly.prosyak@amd.com
Cc: christian.koenig@amd.com
Suggested-by: Matthew Brost <matthew.brost@intel.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---

v2: Check the pasid rather than job (Lijo)
    Add fixes tag (Christian)

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 8a851d7548c00..c6b1dd95c401d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -6634,6 +6634,8 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	struct amdgpu_hive_info *hive = NULL;
 	int r = 0;
 	bool need_emergency_restart = false;
+	/* save the pasid here as the job may be freed before the end of the reset */
+	int pasid = job ? job->pasid : -EINVAL;
 
 	/*
 	 * If it reaches here because of hang/timeout and a RAS error is
@@ -6734,8 +6736,12 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	if (!r) {
 		struct amdgpu_task_info *ti = NULL;
 
-		if (job)
-			ti = amdgpu_vm_get_task_info_pasid(adev, job->pasid);
+		/*
+		 * The job may already be freed at this point via the sched tdr workqueue so
+		 * use the cached pasid.
+		 */
+		if (pasid >= 0)
+			ti = amdgpu_vm_get_task_info_pasid(adev, pasid);
 
 		drm_dev_wedged_event(adev_to_drm(adev), DRM_WEDGE_RECOVERY_NONE,
 				     ti ? &ti->task : NULL);
-- 
2.52.0

