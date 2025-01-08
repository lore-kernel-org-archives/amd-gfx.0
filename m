Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BD4AE77188
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2025 22:56:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4AAE10E975;
	Wed,  8 Jan 2025 22:56:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jDh8rEIr";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AB9510E975
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jan 2025 22:56:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xk+NDC0faE5LH62shAWsX0FeKnRtxVUYMec5e/mzRbIgtqG7ecLUVJjLaJWOVJLymWQLpqCcOmf1fPLNmFT6qV+kmvu92b8GAqnA2ss7NHqaHaADjLO69hCkRNx+mF2Ru/rnnlmF+Ay642mrdp8NhyvpiusEeJ9xBk3AnUfx+e/1kAE7a0TOUdaxBXE0w+H6Ex87fGukVERD3iAVpRh9V+37VoE3+UdD7tZtybTB/qb90NWFy7vH53HJTi+2C1ifEFhQQ+pO73NQ88JTGC9IFSjf73tkOHfQ9ZPlZlZEmCtfZyQli6N3VP3MrR2CADiiqvUeu7B9Q44M5i/RjCGCJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z8z0ZRLphLZB4edoW/wkCvf6Xzq9KFwxI+PUjOU4Z7I=;
 b=m3XydzR+krg/dG3vt9fnApb5UvChyrd7sZoY9MrOibAbN77yHHoLJndDvyKm5o23UVKp5pHkz/K3gxJpkIggJ+VRUi7VVLWlK2iwxNu6sF18HS6s+tk3nG9j9F4vli4UjvWBOg9uwvTlBPyPX1pprn+pl7MPIUquqbb1SWBH41K7unww4HVzh0NB8UElcUcAdeRRNx1s8HulhgJAt+GodInBgh5m1xFJEbKS7IrDU9I//cLQPm76HeJQEehQ7Iuf4FAhv6/yq0eX12isLn4qdmS/ca/nkgi1PgiLubGHEuj3/TH8+97y7eLo6wSYkGfS8x3JcZ4t/NqQBl4oy7jZ5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z8z0ZRLphLZB4edoW/wkCvf6Xzq9KFwxI+PUjOU4Z7I=;
 b=jDh8rEIrTc0cAyYgYpKgRyt5Yigylnq1TxhjwCfR4PVnAS1E5JF5Dm0g5w/843HY51jM5JPRhzD9cmXL5S1JiTlGK5nneeizN0kOUZoLb3Tsa44t6Y9NonvPChMxknjKnSnmeVehMNFMTMNqCFEqx0dK0ezVclaD30S8P1deduc=
Received: from PH3PEPF000040AF.namprd05.prod.outlook.com (2603:10b6:518:1::5a)
 by SJ1PR12MB6122.namprd12.prod.outlook.com (2603:10b6:a03:45b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.16; Wed, 8 Jan
 2025 22:56:45 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2a01:111:f403:f910::2) by PH3PEPF000040AF.outlook.office365.com
 (2603:1036:903:49::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.10 via Frontend Transport; Wed,
 8 Jan 2025 22:56:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Wed, 8 Jan 2025 22:56:44 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 8 Jan
 2025 16:56:43 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <aurabindo.pillai@amd.com>, <kenneth.feng@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 1/5] drm/amdgpu/gfx: add ring helpers for setting workload
 profile
Date: Wed, 8 Jan 2025 17:56:23 -0500
Message-ID: <20250108225627.14063-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|SJ1PR12MB6122:EE_
X-MS-Office365-Filtering-Correlation-Id: 11a0ada3-5c2c-439a-e0eb-08dd3037b98b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?F/0vAFK1Wff3MJzrX+VTBI4C4BJ5Ewf9EsHXY3BgKKIgSP2SizIUZfxglsz+?=
 =?us-ascii?Q?1w8rrKvdPqjZBd1fRHFUkfd+gxRdXj3AJRroL1/ZAg5btFzSc3VfJnGNo/Gq?=
 =?us-ascii?Q?ER96OjExDKbkzpQB6l/fY7VJHKOovFqK8prwAhELPGQxWJN3aeO1q11TPEcC?=
 =?us-ascii?Q?PA0lAFTXMlRwNcXtmTEdgnVuUNk5VPYHUtxtvIWm9L6Ga9eRK5mO7RbtGLo9?=
 =?us-ascii?Q?j5aeWpfxa+fa9m9KytZqcRSZyt7+Zcqodk9xM1dpuhQYHvcNkYbD35nL90PO?=
 =?us-ascii?Q?GptiUMSLGSxIBPDfDRvN7DtMdfT3vctwhiQiZNyDoVbFEoKH5IJFkDdcP6KF?=
 =?us-ascii?Q?fKD0+KjlG+gjuw1R7lUNAJSot97sSXxsSx7/wxnIk4FmS3XKq+cwL6G59ZKJ?=
 =?us-ascii?Q?tmqW0FXnjC7RjytEdw8vXrVXyklGAfsN3tySoEIMlTt1QoFyKyg1JzFPqxip?=
 =?us-ascii?Q?ImxT4aaANEP28ZW7b/veQlWKn6znWTbNotvWO33+NLq1o9H9IioamOPsdnUn?=
 =?us-ascii?Q?UZRZKpegdH2r8Gvryza7AhfAkaW8bN7lW1vdMBIAPGiaAu/Uv0YFX9PAvyT6?=
 =?us-ascii?Q?orV2StI2b2hQYQIbDgGX0XvFK7LLXrNBTjelbvIdXqK9wV4Rp3shykIOJBlQ?=
 =?us-ascii?Q?X8+lqBZQbg2ZYjTp0wlkwlMCgPJQg0zKvGvVIwvJh1IgEEcCUl5eZ5yRFeJd?=
 =?us-ascii?Q?yTngVVdv8N68P94OyqJhvaCynI7saJYkaXeZgS0KwwRibAIP/5DWFOY9a5hk?=
 =?us-ascii?Q?Bvc+kD+U3ar9YwR8YtkLT0mJ6t3zETeHynDlEIPaeJqpwuLOjrGin0NIk4GC?=
 =?us-ascii?Q?xoAtBVPpxxmK7Z4g9nECh+V000ulBZemktkmdeS0pk1sLA4yBwreRpvGUwgO?=
 =?us-ascii?Q?/j5v04KpxiqFF9rSouiaNzJX6IMasW8fTsqqJIEc5iq3sIhzXxJKQycDanlf?=
 =?us-ascii?Q?EwLlHAelfSmR7/X4ZoQL8LonZGGzFj5acKGm486OyAr+niqXk5Dv0KyJRtb8?=
 =?us-ascii?Q?MEWxkYxpuaTXWTedyBcdz318PsJzoXAE3KP1X1P/44Ryo2DPS0ZNePkEfZt8?=
 =?us-ascii?Q?KFq9hPHTLqJ3cbTbMXcTYZXpK7MQ37Ccr+sk2EtEXYDQrcBwOlKnKIAQcG+p?=
 =?us-ascii?Q?3iI5VXJB/T0tswmSBn6pmhzYAfIw3EKpbLzxrAC7OLi2ZgGnlwEgIOx0HvFs?=
 =?us-ascii?Q?KpGr28q4EsAwYGEALqkzGKMPEpzlrGW1Ne4IwrM0eGEcsDM468qoFDHuOtbG?=
 =?us-ascii?Q?IeJImjWwo2oj8HUvA8icwZnVtGeI/IXrSxCV42/zteLw/Is3C9BVepQhW5Bp?=
 =?us-ascii?Q?A3jRNgnT+U6Rc30MNIqe9TWW0a1L+9Px8VnvDDdDa5wW2s/ngn3Gr6BbM4m9?=
 =?us-ascii?Q?HJ2JYdWGXLujZAOcLfNsafQeJGLR5zeMzqs7UlyF/C36G6SHqttt/1tst2jo?=
 =?us-ascii?Q?nIm0alzgaJpeP1OHmEjRaZBOhNfULZfA2etpKPYdnpng+hOkYxGwh3uOIdCy?=
 =?us-ascii?Q?CExumtDtU82iykY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 22:56:44.9202 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11a0ada3-5c2c-439a-e0eb-08dd3037b98b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6122
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

Add helpers to switch the workload profile dynamically when
commands are submitted.  This allows us to switch to
the FULLSCREEN3D or COMPUTE profile when work is submitted.
Add a delayed work handler to delay switching out of the
selected profile if additional work comes in.  This works
the same as the VIDEO profile for VCN.  This lets dynamically
enable workload profiles on the fly and then move back
to the default when there is no work.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 57 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 11 +++++
 2 files changed, 68 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 6d5d81f0dc4e7..c542617121393 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -2110,6 +2110,63 @@ void amdgpu_gfx_enforce_isolation_ring_end_use(struct amdgpu_ring *ring)
 	mutex_unlock(&adev->enforce_isolation_mutex);
 }
 
+void amdgpu_gfx_profile_idle_work_handler(struct work_struct *work)
+{
+	struct amdgpu_device *adev =
+		container_of(work, struct amdgpu_device, gfx.idle_work.work);
+	enum PP_SMC_POWER_PROFILE profile;
+	u32 i, fences = 0;
+	int r;
+
+	if (adev->gfx.num_gfx_rings)
+		profile = PP_SMC_POWER_PROFILE_FULLSCREEN3D;
+	else
+		profile = PP_SMC_POWER_PROFILE_COMPUTE;
+
+	for (i = 0; i < AMDGPU_MAX_GFX_RINGS; ++i)
+		fences += amdgpu_fence_count_emitted(&adev->gfx.gfx_ring[i]);
+	for (i = 0; i < (AMDGPU_MAX_COMPUTE_RINGS * AMDGPU_MAX_GC_INSTANCES); ++i)
+		fences += amdgpu_fence_count_emitted(&adev->gfx.compute_ring[i]);
+	if (!fences && !atomic_read(&adev->gfx.total_submission_cnt)) {
+		r = amdgpu_dpm_switch_power_profile(adev, profile, false);
+		if (r)
+			dev_warn(adev->dev, "(%d) failed to disable %s power profile mode\n", r,
+				 profile == PP_SMC_POWER_PROFILE_FULLSCREEN3D ?
+				 "fullscreen 3D" : "compute");
+	} else {
+		schedule_delayed_work(&adev->gfx.idle_work, GFX_PROFILE_IDLE_TIMEOUT);
+	}
+}
+
+void amdgpu_gfx_profile_ring_begin_use(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+	enum PP_SMC_POWER_PROFILE profile;
+	int r;
+
+	if (adev->gfx.num_gfx_rings)
+		profile = PP_SMC_POWER_PROFILE_FULLSCREEN3D;
+	else
+		profile = PP_SMC_POWER_PROFILE_COMPUTE;
+
+	atomic_inc(&adev->gfx.total_submission_cnt);
+
+	if (!cancel_delayed_work_sync(&adev->gfx.idle_work)) {
+		r = amdgpu_dpm_switch_power_profile(adev, profile, true);
+		if (r)
+			dev_warn(adev->dev, "(%d) failed to disable %s power profile mode\n", r,
+				 profile == PP_SMC_POWER_PROFILE_FULLSCREEN3D ?
+				 "fullscreen 3D" : "compute");
+	}
+}
+
+void amdgpu_gfx_profile_ring_end_use(struct amdgpu_ring *ring)
+{
+	atomic_dec(&ring->adev->gfx.total_submission_cnt);
+
+	schedule_delayed_work(&ring->adev->gfx.idle_work, GFX_PROFILE_IDLE_TIMEOUT);
+}
+
 /*
  * debugfs for to enable/disable gfx job submission to specific core.
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 7f9e261f47f11..6c84598caec21 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -57,6 +57,9 @@ enum amdgpu_gfx_pipe_priority {
 #define AMDGPU_GFX_QUEUE_PRIORITY_MINIMUM  0
 #define AMDGPU_GFX_QUEUE_PRIORITY_MAXIMUM  15
 
+/* 1 second timeout */
+#define GFX_PROFILE_IDLE_TIMEOUT	msecs_to_jiffies(1000)
+
 enum amdgpu_gfx_partition {
 	AMDGPU_SPX_PARTITION_MODE = 0,
 	AMDGPU_DPX_PARTITION_MODE = 1,
@@ -477,6 +480,9 @@ struct amdgpu_gfx {
 	bool				kfd_sch_inactive[MAX_XCP];
 	unsigned long			enforce_isolation_jiffies[MAX_XCP];
 	unsigned long			enforce_isolation_time[MAX_XCP];
+
+	atomic_t			total_submission_cnt;
+	struct delayed_work		idle_work;
 };
 
 struct amdgpu_gfx_ras_reg_entry {
@@ -585,6 +591,11 @@ void amdgpu_gfx_cleaner_shader_init(struct amdgpu_device *adev,
 void amdgpu_gfx_enforce_isolation_handler(struct work_struct *work);
 void amdgpu_gfx_enforce_isolation_ring_begin_use(struct amdgpu_ring *ring);
 void amdgpu_gfx_enforce_isolation_ring_end_use(struct amdgpu_ring *ring);
+
+void amdgpu_gfx_profile_idle_work_handler(struct work_struct *work);
+void amdgpu_gfx_profile_ring_begin_use(struct amdgpu_ring *ring);
+void amdgpu_gfx_profile_ring_end_use(struct amdgpu_ring *ring);
+
 void amdgpu_debugfs_gfx_sched_mask_init(struct amdgpu_device *adev);
 void amdgpu_debugfs_compute_sched_mask_init(struct amdgpu_device *adev);
 
-- 
2.47.1

