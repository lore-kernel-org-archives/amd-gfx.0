Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31432C28B30
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Mar 2025 04:57:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80E9B10E010;
	Wed, 26 Mar 2025 04:57:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MoW3sO4w";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2043.outbound.protection.outlook.com [40.107.236.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD80710E010
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Mar 2025 04:57:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BsdH7ag4cl1G6Xsu4HDQ50Q/jKrBtdzN1CRIr7+OxQBgZ9sN3v2QaVtfoG9tP25sCF8VXVAxTSct7L9hcDz6LsA1EtUcyNSZDpGccCwkLKXmqWheiL1yURPFoBBiU8r9/tS0s8Rda6dAaqTa2QfTVTRctYUZlChrcpIx/+LXgZCKL69HGKEy9NnrNQhd4fsaJfoQmuIRKmc01hSc9ZB+HIiApOKBM8UeTTFJlCwr50T8A1gdp9SMeZryCideAGC9IJlyX0HJcB7ty00CL2FfMFEyCWswr3GOp9tmr9TAA7I549CkijNBVLy5tVYq5XLSqV8Njh5X2BlzmETceAs6DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O/beSD/H2+e6beG6iUhLnYCuL3uay1ngr3vlxeI3jgw=;
 b=kidzMBGfsUi8Lwthsqsdn/g9muhwpmO0B/LPnrNCE6dzIQFznSNs3qTlb3PxALLzwIzQ82AONHKq+EhTDg++G+uvwQf4LuTSLO+IXSnIk1hmwvhkMnJfJXJ8I70SiyoaQgsFZo3wuE2BuvIIyduCNsymqPCRBVfiJVUN39DBUujpzAj1bDo7c0Pine+EaqbvlGlWrU/B0BfIG8ztkOJA/Tk79ARlBdCx9B+A0TcOA8+AevHbZBLoASHkRmP1W14acsSVHA4ACm6kI0BvCZSXb2oe7Llm7vVvL6nnOzIEgZ08JuEIzzSI2485eWsaPOEWvYq9bhyaeuR7M+yDhjEnrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O/beSD/H2+e6beG6iUhLnYCuL3uay1ngr3vlxeI3jgw=;
 b=MoW3sO4w4H2eQ5YUvzXjEs/rmgpHjJA02Y+2uLwefS9kv01YUSjUYqdjeh8HsIGMuFd/o2ex9R/abOmGLP8Ei+9sf+4CIXW/X0fUEGrmnL7WfCPLGOkJsk6cUGGBcqDakLLEYN6KAt2HzOqy4cTEW7olR+9ZMCDAlMXm2U0ExjM=
Received: from MW4PR04CA0267.namprd04.prod.outlook.com (2603:10b6:303:88::32)
 by SJ0PR12MB6760.namprd12.prod.outlook.com (2603:10b6:a03:44c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Wed, 26 Mar
 2025 04:56:56 +0000
Received: from SJ1PEPF00001CDE.namprd05.prod.outlook.com
 (2603:10b6:303:88:cafe::2e) by MW4PR04CA0267.outlook.office365.com
 (2603:10b6:303:88::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Wed,
 26 Mar 2025 04:56:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDE.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 26 Mar 2025 04:56:56 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Mar
 2025 23:56:55 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Mar
 2025 23:56:55 -0500
Received: from kenneth-mlse-vm.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via
 Frontend Transport; Tue, 25 Mar 2025 23:56:53 -0500
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <kevinyang.wang@amd.com>, <alexander.deucher@amd.com>,
 <harry.wentland@amd.com>, Kenneth Feng <kenneth.feng@amd.com>
Subject: [PATCH] drm/amd/display: port the workload profile setting logic into
 dm
Date: Wed, 26 Mar 2025 12:56:50 +0800
Message-ID: <20250326045650.770578-1-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDE:EE_|SJ0PR12MB6760:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fba0fb3-5972-4e4f-d924-08dd6c22a243
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gTinzXxh9h92EVxLh4NO0J0td73imWPEmwIqG85WAEF6HmGW2rEdSnTDIjbW?=
 =?us-ascii?Q?1dT2bZzdp7tnyUz0pZEKEnkXwBGRYu//ACmOZCAQaMi9SJXDR2+vav6L2BIO?=
 =?us-ascii?Q?VEPnku1TJw4Go/Oe0xw+oe54tkM0+aRti0i+d/uF8hPw0A8Ig2C72/SsUOKe?=
 =?us-ascii?Q?0EcV5KcvKgem//Nq5LwY8/byoLhsCi7UIK2YFcbaxzhEZrjNwDxY3dNAuxYa?=
 =?us-ascii?Q?iLbtIGS+RDxAZPrbU1dK2+SUtm4z/mpdcNyif0OvuyjA/otTdv9CwyPLoEgv?=
 =?us-ascii?Q?6VS7gaBbcW4rN89tgOkC87DJaOwcBcLWyTqGOxoxHTPl4nqFsmm5yciGVA6k?=
 =?us-ascii?Q?5YKD9k410d3KZEBex+zSTlErWg1uaSvbYoQAZnSFGxbpFzc9r6pBR+WqTZMR?=
 =?us-ascii?Q?gLG8d52v8xPVrv+fDeNnwty+WHzcIzZpkKhCYKwiuloXFF1EahBjUxOfE/qy?=
 =?us-ascii?Q?1tRuGX8Z9iofqlruRHg9f5BEdk9KBm/EuoZJl5pkS038VTP5GTDDvgr9Mep3?=
 =?us-ascii?Q?f0ZpTgdQD6mEVkbDLce1ZoGg3efyqVVb8Ya4o2jsF9cRAZNJXTPQxLObhnZa?=
 =?us-ascii?Q?khuejt0kNVL4PUy+VTnHk0GuMgE9AIwpd/e8qM0u70NwLewDjEXD4xR7nHfO?=
 =?us-ascii?Q?qNkH9rcI5o6HmLeHXG3EYY7SMReR6b/pXgzC/rjj1SrK3YoNdZJfj54b0yrO?=
 =?us-ascii?Q?/8+qOMdoYXvUpidUaqvLEBhUH/vmDCTDIp9uJaGO3cm0kx/VnpNEgr4FwPrF?=
 =?us-ascii?Q?xV94jQEPnckV5AvsQPdET1y0zbltS/ZQ5f2a8ZkPDocjzZ7va/utFJ4XkYOF?=
 =?us-ascii?Q?m1IEtWzTBFpnvAHQ3g9QEXp5zsFNvR82qxnqeWxGNI/ms19gz2FAq28jlH2i?=
 =?us-ascii?Q?QvnjsZZa+3rGPpvGJXAgr0wOtGuUwQmxyXfvpi7SkVxt9kFGMM8y3bcK0Uuc?=
 =?us-ascii?Q?vrjilIEz6jp29TEmrPKfJGtCt6VOsR2CrE2RssmKhXbQAXgFPzt/NrNZ4ip+?=
 =?us-ascii?Q?q0rdS8kJD/VpPC78SzkBTm5HfISp3rb+8XBI5o5i+4ABamN9psXjReUdP2FH?=
 =?us-ascii?Q?Mlxyngp0KNuxjP/4RnnB89rrQ1pikx6rbphFjxo67T+PVATJxdVEP+M9ILo6?=
 =?us-ascii?Q?sbFttOPjawJCqXWYaPz1LYLfciB7smjYdYGsWT7/2pEqdCbZsEoXrK+vDLby?=
 =?us-ascii?Q?doLMJsHcyaP2hxJkYBVKLVz0s6fs0ixNw9rkZ841J50dnu0jNgn+9IpzhiNs?=
 =?us-ascii?Q?lXYMa7jKae6uTrvwh83vL0pROkcBqLvpy8j9V0oaM/hjSPcdWbHRNLOaPEZm?=
 =?us-ascii?Q?/dnKRmVKLpBp9JkYHWllUnzl7pPC1D+AZ5BO5HmHeHFDJtzlcy0fOWFNAOHV?=
 =?us-ascii?Q?dEAQAXMskbpMhnEkqA/2h8SAxWxlHpVfko4URLVYcbE34vPSrUU66jFrC4re?=
 =?us-ascii?Q?NWYKhkedBNV2TcHyjydPUbNCuKm4laf2udTcpIHe3ooPVWRyD/a/pZz082zl?=
 =?us-ascii?Q?jajXXeR4A3grdiE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 04:56:56.2115 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fba0fb3-5972-4e4f-d924-08dd6c22a243
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6760
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

Port the workload profile setting logic into dm before MALL optimization.

Background:
MALL optimization strategy has changed in the firmware.Previously, firmware does not
care what workload type it is, once there is a request from DAL for MALL, firmware immediately
trigger the MALL setting sequence on the SoC, so called D0i3.x idle power sequence.
Now, before the D0i3.x sequence starts, firmware always check if the workload type is default,
if it is not, then abort the D0i3.x sequence.

Issue:
Due to this strategy change, the task is moved to driver to make sure if gfx is really idle and
if it is, reset the workload to default. Without this task, when DAL's work task for MALL optimization
tries to do the optimization request to DMCUB->pmfw, the workload type is always 3D fullscreen or compute,
then MALL will never be applied.

Why:
The idle task for setting workload type back to default interval is 1 second currently. The DAL's work task
to optimize MALL always starts before the idle task for setting workload type back to default. There is no way
to ask the idle task in the base driver to reset the workload type ahead of the DAL's MALL setting work task
kicks off. There could be a workaround which sets the idle task interval to 10 millisecond. However, this causes
some call trace issues in which the workqueues is flushed.

Side effect:
This solution is to port the logic in idle thread to DAL: check the fence and make sure gfx is idle, then reset the workload
type. It is fine that when DAL's work task exits the MALL optimization, it does not set back the workload type to 3d fullscreen
or compute since the work task in base driver can make sure the workload type can be set back once there are jobs in the ring.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    | 29 ++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index 36a830a7440f..2adb3b72ed05 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -244,6 +244,20 @@ static void amdgpu_dm_crtc_vblank_control_worker(struct work_struct *work)
 	struct vblank_control_work *vblank_work =
 		container_of(work, struct vblank_control_work, work);
 	struct amdgpu_display_manager *dm = vblank_work->dm;
+	u32 i, fences = 0;
+	int r;
+	enum PP_SMC_POWER_PROFILE profile;
+	struct amdgpu_device *adev = drm_to_adev(dm->ddev);
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
 
 	mutex_lock(&dm->dc_lock);
 
@@ -271,8 +285,21 @@ static void amdgpu_dm_crtc_vblank_control_worker(struct work_struct *work)
 			vblank_work->acrtc->dm_irq_params.allow_sr_entry);
 	}
 
-	if (dm->active_vblank_irq_count == 0)
+	if (dm->active_vblank_irq_count == 0) {
+		if (adev->gfx.num_gfx_rings && !fences && !atomic_read(&adev->gfx.total_submission_cnt)) {
+			mutex_lock(&adev->gfx.workload_profile_mutex);
+			if (adev->gfx.workload_profile_active) {
+				r = amdgpu_dpm_switch_power_profile(adev, profile, false);
+				if (r)
+				dev_warn(adev->dev, "(%d) failed to disable %s power profile mode\n", r,
+									profile == PP_SMC_POWER_PROFILE_FULLSCREEN3D ?
+									"fullscreen 3D" : "compute");
+				adev->gfx.workload_profile_active = false;
+			}
+			mutex_unlock(&adev->gfx.workload_profile_mutex);
+		}
 		dc_allow_idle_optimizations(dm->dc, true);
+	}
 
 	mutex_unlock(&dm->dc_lock);
 
-- 
2.34.1

