Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF90FD2ECFD
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jan 2026 01:34:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AF9710E54A;
	Tue, 20 Jan 2026 01:34:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Md0sRdDi";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010033.outbound.protection.outlook.com [52.101.61.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A80510E29D
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jan 2026 01:34:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UdP00HSgNIUGA06TZV4gmTINFq7+f/uGQkG9CYQymal9hd7axQ38HVubqpxXFX6zywFeh36xJE8R0Nf8iUB7CIX7sNN1VmRLgz09wNQT20qQZT8YjN/32gM3JdHWa+7xb0zbXTixY53I4hjQyhyGFMkea8bH5jAnO5UK4vDY/0094ydCIaGjJT8M3Yh8XwKuemCINT+4WOe16sF0NUVSMXPFhqnGVKC35bEblxfGmPvMRrvWv1ILUiFR54ZMt+UxnDvR+Yi4i6Rs72XNSIHNG7Bb9fMso6D8Kt3qq5l1KIWj7G625iOQHmBlFcdrGhXmr5BbFDLfd1xr7wGeEtF9fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BDJOX9/uhmclwmMgT20EDYmTUUsmmvFABSnBPTAcQfU=;
 b=JeoxQaZNySmJUn+V3w9SQvsxFifp9HKzDZmQC6dsromINJnqxi6zsS7AmWQdEFIbKAUYfMxjr4xhDvB+jE0XJbYrBuWcgW7OCS7oRvLGgX/qr1tSFsAQYtBhC6RPo2wEa2yP2rT1i9TeZkfEZZtdNpa7+9hmIdTpswMo9h/lCSnbA6euJVopVroqt3khZxTY6aN4jWEcK48lFQuGSoXpbIhrKhJROWIPTHcxK0Nb8FwWYTZJ4LGVJVu2tra2nnOLi0NYsi8O6IaLbPjBzgkSjcweACy5NL5HWzrKScIxcy4AUvqyKeS7vaIPYPEp62fpW0KG4Yi+kRDaktNw486wkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BDJOX9/uhmclwmMgT20EDYmTUUsmmvFABSnBPTAcQfU=;
 b=Md0sRdDiWsPQAsuYrnN8lxWGUhqKcVrvB+rRKCAMtIVa/iF4j8CVSrtb2BoxhQL2wiZPlPXZe5gOmertA9kgbXYOZ6NtoOxtXWIymFoxYnpE0X6fzOrKmWoC/IrA98INoz1e2+nh/SOOGarmwBZ2PSyfNWjAyVzq50+sJx9yrF0=
Received: from BY3PR05CA0004.namprd05.prod.outlook.com (2603:10b6:a03:254::9)
 by DS0PR12MB8317.namprd12.prod.outlook.com (2603:10b6:8:f4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.9; Tue, 20 Jan
 2026 01:34:21 +0000
Received: from MWH0EPF000989E6.namprd02.prod.outlook.com
 (2603:10b6:a03:254:cafe::16) by BY3PR05CA0004.outlook.office365.com
 (2603:10b6:a03:254::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.7 via Frontend Transport; Tue,
 20 Jan 2026 01:34:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000989E6.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Tue, 20 Jan 2026 01:34:21 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 19 Jan
 2026 19:34:19 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 19 Jan 2026 17:34:18 -0800
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 01/10] drm/amdgpu: re-add the bad job to the pending list for
 ring resets
Date: Mon, 19 Jan 2026 20:34:02 -0500
Message-ID: <20260120013411.15659-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120013411.15659-1-alexander.deucher@amd.com>
References: <20260120013411.15659-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E6:EE_|DS0PR12MB8317:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d399ec7-9878-4e98-635e-08de57c40937
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fvyX4nBJ64tkuV/9a2m9eHIGKKvth3VYAQ4yzfmSDEZfeAIlzR1JnBKODIP6?=
 =?us-ascii?Q?vgpC/xWs26vCQ3D82IF8DqkNcoCvXrDoY/+rWMHYCz8riB7UbEw4ENIyoDrZ?=
 =?us-ascii?Q?V8hTdFk1YPuYyo6/3oxhFDSz2/6cwqouuypuyxqFrIJ0ZsvEzKtyg2GPkXeO?=
 =?us-ascii?Q?w7nq3DEZC9Er7YCtK6rtw+jFiXrGyn1xQqKQF3Ta6UEFpWp3G1lwWiq2IwDS?=
 =?us-ascii?Q?G9EWzqAD8HTFXxwWAymPAI6FJYEP7Y0WVknnIVDu8qXg7zDC1aTM6QyWPkCr?=
 =?us-ascii?Q?q0W5RvG+U9Zb1hoefJOz5PjKVV5SOfoChXMCG8X330M94kjM3T6W6t0K9+9w?=
 =?us-ascii?Q?kA9I4Tyw9DGmWJ4crq25yVz1CBt+umcxOKwCEBsGYMJfDnxT1A0W15o6NTVU?=
 =?us-ascii?Q?INj/SfmSIYD4/c89TtW2pUnl+de71T7+nmNIMVDAG7MG+Xlt+gsWvegVUCqK?=
 =?us-ascii?Q?GwtoweGoddIZytT3DHPDevX9V+lFE6fcZDFyYjwAkPWggkq2pGsbR3//A4Ra?=
 =?us-ascii?Q?a5I87hEoGa4dz+MW6M6xccbhS660Mb6pp8ngsTB+PpHJ1CVXjp5Xx5ONclSC?=
 =?us-ascii?Q?eh0uO5JaTKx2zX0Cj34yxjh9vgI+SMjcROzG8Vv3/rCAUbhfZXfOiefj/GV2?=
 =?us-ascii?Q?Im6BNWLJjZqxuIgCggMPMLLiwRXfS4AMVRueqc+x24tzZV+fD4w4TESq6zZv?=
 =?us-ascii?Q?H/pbNPR6Xg5cVjBcVQF/IYwOuwOf1lBLXQ0XVw3dlJbZV4DIkKQC8+cUPN5E?=
 =?us-ascii?Q?R87djMi8I4v0gr5WDz/YnjVxWcwOtZ1MSpWGYtRmzC/ocAEVpPkV14W8ysEj?=
 =?us-ascii?Q?b0qq4VjOiDQxj4cZiIzSrWWG9GaB+bG9CYFZt6A9lVEy0dF9WT0dJsmoQQbt?=
 =?us-ascii?Q?SUjOP9rdMRroY4AGt6d8HR5+2WX4/hSYa/0zOM1xO/7w2LvFT9r96K+EKdtr?=
 =?us-ascii?Q?2CbZxBeLP4ExC2dlrh9IfxTgFzYu7n2UV5odk97tsaDFd/j1S4twTH0nzRof?=
 =?us-ascii?Q?x8CsxjWOLCdjMUC8RxtzzKdjt6NkRx0IwDyv2eLbzfQHg4wIQj6htstFDvsJ?=
 =?us-ascii?Q?I2MvMTvMCwGNq4n6+LjBzVEhc8hqJI1lvBHQxIHp6tJfTHSgcERQwQvPso1W?=
 =?us-ascii?Q?00PPFLb2/SxHluzNfKhPGrzeeVTaJ/wBLhgXnTCyxU2Pq7L9EHJ6GHg9hQKI?=
 =?us-ascii?Q?NyAeuxCpbwDj9o5/pns77sdPPT3RjaTKpJmChXAtNh4KRnBVnsnUrSiGpWGs?=
 =?us-ascii?Q?sl6vxxeuYBgC7LMk3Qn/VPTsAT1Oe5wFmePL2Eisrmuf+GzKWUBxDJYYevZt?=
 =?us-ascii?Q?EOKKsl/38vyJRJKFhKq1qM0kqJDlxw4gkq0TKtoXxmS8kcwr1dk+0Mo4+rD0?=
 =?us-ascii?Q?YTjwAsZGdvodpWXIPcIg/ohGy7OXAWhONY/5nWyuirDxlA7AiS5dKM1cx5JB?=
 =?us-ascii?Q?BQfKxWCx3r/kf58sOTSes7M+ANds3xFIJBBceSydTVr+cFL4rGMtx2JxhGPF?=
 =?us-ascii?Q?MgPPBSgizy7b323DDMuVvDK51WUNLLgIWuKVMpraSglvscVPmhrJK35I/4Hg?=
 =?us-ascii?Q?1yQ5nA8gBdzKHzCE6Ily0E8w4+VnkN8kiZjnB0b4TZtJl7PX9J/FT2DdaoO8?=
 =?us-ascii?Q?r4VYJ1d5Jk0pxUSnXArzyb8kuxIm5UnX043ZjXMric16D5V+1T+PXp49QhnP?=
 =?us-ascii?Q?D6zlkA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 01:34:21.1721 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d399ec7-9878-4e98-635e-08de57c40937
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8317
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

Need to re-add the bad job to the pending list before we
restart the scheduler.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c  | 6 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 4 ----
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 1daa9145b217e..ec8d74db62758 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -135,8 +135,14 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 	    ring->funcs->reset) {
 		dev_err(adev->dev, "Starting %s ring reset\n",
 			s_job->sched->name);
+		/* Stop the scheduler to prevent anybody else from touching the ring buffer. */
+		drm_sched_wqueue_stop(&ring->sched);
 		r = amdgpu_ring_reset(ring, job->vmid, job->hw_fence);
 		if (!r) {
+			/* add the job back to the pending list */
+			list_add(&s_job->list, &s_job->sched->pending_list);
+			/* Start the scheduler again */
+			drm_sched_wqueue_start(&ring->sched);
 			atomic_inc(&ring->adev->gpu_reset_counter);
 			dev_err(adev->dev, "Ring %s reset succeeded\n",
 				ring->sched.name);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index b82357c657237..129ad51386535 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -868,8 +868,6 @@ bool amdgpu_ring_sched_ready(struct amdgpu_ring *ring)
 void amdgpu_ring_reset_helper_begin(struct amdgpu_ring *ring,
 				    struct amdgpu_fence *guilty_fence)
 {
-	/* Stop the scheduler to prevent anybody else from touching the ring buffer. */
-	drm_sched_wqueue_stop(&ring->sched);
 	/* back up the non-guilty commands */
 	amdgpu_ring_backup_unprocessed_commands(ring, guilty_fence);
 }
@@ -895,8 +893,6 @@ int amdgpu_ring_reset_helper_end(struct amdgpu_ring *ring,
 			amdgpu_ring_write(ring, ring->ring_backup[i]);
 		amdgpu_ring_commit(ring);
 	}
-	/* Start the scheduler again */
-	drm_sched_wqueue_start(&ring->sched);
 	return 0;
 }
 
-- 
2.52.0

