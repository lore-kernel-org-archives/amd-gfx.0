Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 390C1C28B2F
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Mar 2025 14:19:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C662410E740;
	Wed, 12 Mar 2025 14:19:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="du+lDk0l";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 274B510E740
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Mar 2025 14:19:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jUwHl51P4kmUhm4YGhv+S9rMUQvGJYLuhhrDTBMSqWFcy6TJal0N70sx+BE41L0tuChMmNjU8DGHwMaNQEBvYAWJdAtq0eR5rDjrj+QklzfIo7eP6bzi7h7+AhQLJPVDIUa3hqCk0WFtiwvBKtJcfiwq/aJmz9ljy/jsALUAJLUSz8PsS9eZR2SL8XEE1jCwjuTwgmQJueQ3r0GYmLhnSzRNqKV1+FytHAVVIgOFObd41PFdN8I5dV+ywNG6XGhe3PYtCrCcnedaUIT29QR8Pjq8+d7AJW3gTXqChYsFyfvuQ/fvb9ftMUnBSU015lhCa1IKp3vacOJELfvlF9NQbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z5eh5XM/q7LEMSpD5vB1bA9TfdovK6XnH/PooOhSIEg=;
 b=wAPFwIoWISxB4h6KZoTns4oIcl47X0CQUFSei25aqXW0Pf69gY8u3a0o0gidsmTUlwluXmpc0wIpi0q/aa0WOBbJmgNBvB+ItiVItXZDKCtd5+PwvdGABt83MFlhG9Uyei68CeOZOkpw0MkzfjWM86bmvzjQP6UtGGHbaQufOlg5JbTWzF4yvtY15MlXtj/eS19XwITVGsllz1MIzO2ecuZmpB2KOmTimbtR6FX+D9G+7CNalYLLsyDNh8kcDAHF6WvCxprm1RI7IObrgCv2IEM/N7+vaZ2k/v49Z+dkFAlYreVQTpztewwIzotLB6tGfkRtFXsTcdP0PGxQJpg6qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z5eh5XM/q7LEMSpD5vB1bA9TfdovK6XnH/PooOhSIEg=;
 b=du+lDk0l07a89wCzJ5fxngZKcpLb8k3+aNd6a7zRAc15f7Gb73xjGe3dBaHfmn/a1AnePNhOjevCLNZ60OdyZJD3TY8nkc4kMTgKPpWQ0zmOHkwJ6tMvkmNajc3uRcuKldcvEz/mFxhDXBhjAv24cZQRwaxDBps5QXy+iBh9Btw=
Received: from BY5PR16CA0029.namprd16.prod.outlook.com (2603:10b6:a03:1a0::42)
 by SA1PR12MB6727.namprd12.prod.outlook.com (2603:10b6:806:256::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 14:19:26 +0000
Received: from SJ5PEPF000001F2.namprd05.prod.outlook.com
 (2603:10b6:a03:1a0:cafe::cb) by BY5PR16CA0029.outlook.office365.com
 (2603:10b6:a03:1a0::42) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.24 via Frontend Transport; Wed,
 12 Mar 2025 14:19:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001F2.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 12 Mar 2025 14:19:26 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 12 Mar
 2025 09:19:25 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Yang Wang
 <kevinyang.wang@amd.com>, Kenneth Feng <kenneth.feng@amd.com>
Subject: [PATCH V2 1/2] drm/amdgpu/gfx: fix ref counting for ring based
 profile handling
Date: Wed, 12 Mar 2025 10:19:11 -0400
Message-ID: <20250312141912.10994-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F2:EE_|SA1PR12MB6727:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ea631fb-472a-4926-2504-08dd6170e510
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7jT0JugjV3wzfx3R/K/2w4HVU82Mam+bbwQwFAgd8BSIzdc7PCtoWZ0h040J?=
 =?us-ascii?Q?+LTVOkWyVMQTBP6deI5Fmor2RDUy7b7e0jU6b+SIaDfUNOD7gxlaNDL35pER?=
 =?us-ascii?Q?2KC07GaL7y470gGRj5lq7rXztIUmuMrJSLa3MF+lME6N+zunk7XxpRfEFYgM?=
 =?us-ascii?Q?UXWPdvPrAW+NBCkzVicSGi4PtKqggRyBi06wITq+iLtRgTKnUYO5+r0CjCEL?=
 =?us-ascii?Q?NegB3uiu8NYYfT737COXvNRqtMLjJs3HivXipEvHQYscPejYFJvXoe+6s0o4?=
 =?us-ascii?Q?wyOmhtXwmjsCjTbwHNcvI9pp19sBo6Yo/CfCdHespd2wqriknQjH2wq2ZI5T?=
 =?us-ascii?Q?LZbaKF/TyjKHHWrWKtmNKWhhM+HTDmxN7tfsP32Do8WNKbm6zO14PqSyS2fh?=
 =?us-ascii?Q?MHf43DPi2i7wNxTRYpmFlGGwS4Lz9TfHZ8saWtIsSzZ8MgVW9j7AoygVhMdQ?=
 =?us-ascii?Q?4EgNNz9jmC86njg4Sm1HeLzAfr43MNtr2O4cfQLrNZc/vJSFVtqoQeyrBegs?=
 =?us-ascii?Q?o3rSvk6Knqh+ladHJ9zUOjqAAfYwTPw/AbwqZoVOOek72qHYyLiZDkgPbmug?=
 =?us-ascii?Q?Pii6SCMmZGj4bXpf+9fvIS7I4m2273TK3bdArVUaiP6XWLRz1PqOcVenpzrc?=
 =?us-ascii?Q?eIwa0/MA/97iRMix+RAxeT+p2o8wqDnY8uMOG8vEv2PqvxYwwUO++p5ugoEh?=
 =?us-ascii?Q?2McapuftX+XTFPpAcJVR2wqULw7670R3dKaVpRx7Y9DAh/ZMvqEcU2rTRbeX?=
 =?us-ascii?Q?D3ia4N+hoFPPqAHInEi/q1lFlceFKCqvsjDqYSNHJO6jUpZCpSIxLEvKhXzO?=
 =?us-ascii?Q?VzGslagqeWnqMCxaQ7VoaeAGA2d9tGmCautna4feG7kmeqe5GuyL+axgbHQi?=
 =?us-ascii?Q?suZCe49t38Drn1QgV40HTljYgdaVY+yCSv1n+na/XJZKth95+Fd+12sJHHgL?=
 =?us-ascii?Q?RbBgVh5jO+xuOlN+WwUSDIYS8dT1CgA/OuATAi1aGSgvtIjRNuFR51NWyqgL?=
 =?us-ascii?Q?hzePcgM5Z+5DW/zTykIbSpXtVM0iWHnv5YFC1ByQxyohnx/f+sBCuy9ZXy50?=
 =?us-ascii?Q?turjmQiRxGh/pBhTMDHTgs/peUSa+SjhmPAFUZhLC6JaYiKTvVw7Rnz3N+GU?=
 =?us-ascii?Q?DWF7LP2M6jdvtvO6Rhq5nC5J4Swbbt5LpMwR5tJOp37q9+W5nvQVDevOlwB+?=
 =?us-ascii?Q?AHwcR1VIKNPRCIphRd6IiwpS6QI78LwjMqUyoH9dMx9qCcMpC/7VRy73ik62?=
 =?us-ascii?Q?G63REr3s0Q2ORUjAk5VMZeot1+HNL/RN0TopRt9IONjtC7K0UYQhIwBFFGFv?=
 =?us-ascii?Q?KUhR0gu0NsTTqBO2eHzOcsMp7MRW5mTLmjYexmCqJg6dL8WxGR1bZbvHdUcB?=
 =?us-ascii?Q?iZ00AkqEfRPT8FtToF0ArXdpoUjyW/Gl0k1DJf3YXnrakujeNXKi1wnlgQDo?=
 =?us-ascii?Q?bwEBCxuwO3JFUW8sOcT/olDTuNUYYhXHw/keHKs//IZKGUUHb7DEXWpICGvu?=
 =?us-ascii?Q?u6lbjnjVeSWn/84=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 14:19:26.2031 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ea631fb-472a-4926-2504-08dd6170e510
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6727
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

We need to make sure the workload profile ref counts are
balanced.  This isn't currently the case because we can
increment the count on submissions, but the decrement may
be delayed as work comes in.  Track when we enable the
workload profile so the references are balanced.

v2: switch to a mutex and active flag

Fixes: 8fdb3958e396 ("drm/amdgpu/gfx: add ring helpers for setting workload profile")
Cc: Yang Wang <kevinyang.wang@amd.com>
Cc: Kenneth Feng <kenneth.feng@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 30 ++++++++++++++++---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  2 ++
 2 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 984e6ff6e4632..099329d15b9ff 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -2160,11 +2160,16 @@ void amdgpu_gfx_profile_idle_work_handler(struct work_struct *work)
 	for (i = 0; i < (AMDGPU_MAX_COMPUTE_RINGS * AMDGPU_MAX_GC_INSTANCES); ++i)
 		fences += amdgpu_fence_count_emitted(&adev->gfx.compute_ring[i]);
 	if (!fences && !atomic_read(&adev->gfx.total_submission_cnt)) {
-		r = amdgpu_dpm_switch_power_profile(adev, profile, false);
-		if (r)
-			dev_warn(adev->dev, "(%d) failed to disable %s power profile mode\n", r,
-				 profile == PP_SMC_POWER_PROFILE_FULLSCREEN3D ?
-				 "fullscreen 3D" : "compute");
+		mutex_lock(&adev->gfx.workload_profile_mutex);
+		if (adev->gfx.workload_profile_active) {
+			r = amdgpu_dpm_switch_power_profile(adev, profile, false);
+			if (r)
+				dev_warn(adev->dev, "(%d) failed to disable %s power profile mode\n", r,
+					 profile == PP_SMC_POWER_PROFILE_FULLSCREEN3D ?
+					 "fullscreen 3D" : "compute");
+			adev->gfx.workload_profile_active = false;
+		}
+		mutex_unlock(&adev->gfx.workload_profile_mutex);
 	} else {
 		schedule_delayed_work(&adev->gfx.idle_work, GFX_PROFILE_IDLE_TIMEOUT);
 	}
@@ -2184,11 +2189,16 @@ void amdgpu_gfx_profile_ring_begin_use(struct amdgpu_ring *ring)
 	atomic_inc(&adev->gfx.total_submission_cnt);
 
 	if (!cancel_delayed_work_sync(&adev->gfx.idle_work)) {
-		r = amdgpu_dpm_switch_power_profile(adev, profile, true);
-		if (r)
-			dev_warn(adev->dev, "(%d) failed to disable %s power profile mode\n", r,
-				 profile == PP_SMC_POWER_PROFILE_FULLSCREEN3D ?
-				 "fullscreen 3D" : "compute");
+		mutex_lock(&adev->gfx.workload_profile_mutex);
+		if (!adev->gfx.workload_profile_active) {
+			r = amdgpu_dpm_switch_power_profile(adev, profile, true);
+			if (r)
+				dev_warn(adev->dev, "(%d) failed to disable %s power profile mode\n", r,
+					 profile == PP_SMC_POWER_PROFILE_FULLSCREEN3D ?
+					 "fullscreen 3D" : "compute");
+			adev->gfx.workload_profile_active = true;
+		}
+		mutex_unlock(&adev->gfx.workload_profile_mutex);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index ddf4533614bac..75af4f25a133b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -483,6 +483,8 @@ struct amdgpu_gfx {
 
 	atomic_t			total_submission_cnt;
 	struct delayed_work		idle_work;
+	bool				workload_profile_active;
+	struct mutex                    workload_profile_mutex;
 };
 
 struct amdgpu_gfx_ras_reg_entry {
-- 
2.48.1

