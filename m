Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E17E0E7718B
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Dec 2024 19:31:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75B3B10E335;
	Mon, 23 Dec 2024 19:31:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iHBICEaR";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9B6610E5A3
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Dec 2024 19:31:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pgEQKyzkIPTKJOEHU4q2ATDkH6Co1e+xa1DDzDgwvgKPHUg457X4MXjVb7qI82rvVSlhGwe6qAibu4xtGb7N7F54s2L8gRpLUZxaA5kJ/SAdm/DSHXeozJS9nr7rX9Cg+c/YsvXTYhmb4h7b+nJRf628flwL/wtyRY4KSFUOhaQAVcuDf5GhgXrakYLib4bvHHA1KK+/kYOhhzEugVF6faI6PmQpmXbGIRBWPNEOH48pc1kYV0JgK8AzBBm/W7q7VfLRAxr4bBPaqaXgtnChGxa5PFMXUDygq3O1nQ5f9Ox6B0EbK4D4Amk1lwLFAvSmWUyIfcMACmEmCNu6tI3AJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kgifW06W3r+MVSd5DT5mFQcUpr2D7NBtCPaS/Xg44Z4=;
 b=oWGWJeRc836IV9LmcnHgRcvEWiPWjoRwKvank1YORr5u4g/sMfleP715iIZNkQsc77KlLZOdG93XJf/Q1cZdXt2O403oe/Em+kN2TQRdKOv/wDHIE3MpH8IWU+qXzfuzi3ACRAKQke9mi+kt81cCcrWzwADJrbkg8XT6D7124uf5OjVIqOFXJvYOL7+h0NxY4ikoA7W1nJqbRu6vTG9+63I5ndhp81yZRp1PwPgFziLZcFqQFW8tYh9/9AY52ISjcKrg/tfe+4ETupFWXk2JtL+KaBvys10kS/ruR3gotVUBp7nmNXvNUVm4MUnJv7aflSwLCy5+B1y4IyEtmNCjXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kgifW06W3r+MVSd5DT5mFQcUpr2D7NBtCPaS/Xg44Z4=;
 b=iHBICEaRS0JhcskBQUGatS0mHY9SI7DsXxKS+Qcj6lT4BL1+AREsTHBowu/b1I2XDN1UwrhtlGTy6nKD5fBHbHECMJucdm49bIKHH3eBxy1uKDgfMr9Zic4lSFYA7vNWPUyUi2YNV+b2g+qF7mtB7TjZmb+T6DxRqbLRc5+3Wa4=
Received: from CH2PR16CA0025.namprd16.prod.outlook.com (2603:10b6:610:50::35)
 by DM4PR12MB6157.namprd12.prod.outlook.com (2603:10b6:8:ac::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.20; Mon, 23 Dec
 2024 19:30:42 +0000
Received: from CH2PEPF0000014A.namprd02.prod.outlook.com
 (2603:10b6:610:50:cafe::dc) by CH2PR16CA0025.outlook.office365.com
 (2603:10b6:610:50::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8272.20 via Frontend Transport; Mon,
 23 Dec 2024 19:30:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000014A.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8293.12 via Frontend Transport; Mon, 23 Dec 2024 19:30:42 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 23 Dec
 2024 13:30:41 -0600
Received: from debian.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 23 Dec 2024 13:30:41 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <aurabindo.pillai@amd.com>, Kenneth Feng
 <kenneth.feng@amd.com>
Subject: [PATCH] drm/amd: set the workload type based on MALL status
Date: Mon, 23 Dec 2024 19:30:40 +0000
Message-ID: <20241223193040.32500-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000014A:EE_|DM4PR12MB6157:EE_
X-MS-Office365-Filtering-Correlation-Id: a6aaac3f-0edf-4eb1-9d46-08dd23884a41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Yjc8DrRopG/7dSrk3jykidRohtMUD22SvjdLvVOGhj/ciX82LEFHL34soeJd?=
 =?us-ascii?Q?xiF+Bqi3EcMiFDSFBvql0VO5weno8Q8IxhnFapyn5CYA2/lwazS7GHnSucGf?=
 =?us-ascii?Q?S2d/hd41948vrksGxmjLDBX8/8NDk8MJroA45PByfq+EhsyxbiEiARY60Gi2?=
 =?us-ascii?Q?nKanVcAQIJj15s5gWIRPAbBduZuuODDWYiXEQi1uw7Gnv5bhL2ziPdDYG5TP?=
 =?us-ascii?Q?OPBr0LRBvuueF9+yJjURPqWvMLjXqZkjLCJlC6at6OP8Q5gY6s2+atB83qsj?=
 =?us-ascii?Q?xOZzYHgifnU7pHi2NlpXbYtBMYTVMVG4wf4gL02fPQyo4hq15iamltFAEXvu?=
 =?us-ascii?Q?k7d0bjGmLwuuX9P9/sdVLjFDTmZux2kaRSc6DZzcwSSXcJH/2LafEHGwZgdw?=
 =?us-ascii?Q?pFBp3ULW603ONuJ5h/+4yHgkpH2GIZPnE3h/vsUGCroKo8KzhT+/CWPGgsTF?=
 =?us-ascii?Q?EkKMOkQeLB0tHFK32CvN5pTpDJqbCxm2FUZNiKvbmAcrl3jkhnlPlDjezXNL?=
 =?us-ascii?Q?4Y5tsAs/SD1viQfVOxtyJByZggysk5OKGi9nScOAEmsnlVvFT5EtGkNveX5d?=
 =?us-ascii?Q?xNbYKDdBeREOTQ1+RkdWLLwmyrVbho+6JOf7EKbKEf0cwla2/br8l5IJqsTe?=
 =?us-ascii?Q?4qWLkLGgKR51cEJ9LfIWQNQBuIMb/1guv9060YQxh2iV+z1e3cO7htwS08bA?=
 =?us-ascii?Q?Azm3z2PwkPSYuzuoJuwKy855lBPf82oELi6Vqtuiano3itzAruWX0f3KvsqD?=
 =?us-ascii?Q?nR7cin60AYIxYwVxWF+tJLBgXBwMXzTqwG/7al6GEsD30dVwV0/oyWTllPWf?=
 =?us-ascii?Q?KkAVp2srOEo+orMGFPjTMHcFf3iHDWzvqk5aNNrpI3Swa1Pdu9IqZ7CWOr99?=
 =?us-ascii?Q?DYBfiJ5ZAJbdJVSeb7DzfILbZ6FP0Fx2KReppf6NyTTvkqRYX64CtSfk1dVl?=
 =?us-ascii?Q?6o4upJ17DxOIErGsfIDMtoDzL4K5NfOTJbW2n5kVzBRqtfRbq9Vi0hAol3Z9?=
 =?us-ascii?Q?YEJR3de4hpit0rHdL6DgUt4YldyJn5kHz3xvWuYj5vfIMQtSpkV6276cc0TY?=
 =?us-ascii?Q?MYXCTOEJ0pY5tB4/KW1UAi7URXXwnUZ2i2SPt0mSip1kOBuBnUNX/1PmrTEP?=
 =?us-ascii?Q?qYxrMw8VVBOJulBC6/yoNRhIwmcUQ9WN8pIV0994oVZ2Bx+wDgm1I32Tj5Df?=
 =?us-ascii?Q?+kamnKWzmV9byQX9FVjNX45toxF9pVitYtWAjspAi3IW5T0WyOhVYo5S4kYQ?=
 =?us-ascii?Q?Hf8IndUdzpdU2x8N6JaLxK/jbSWB3x07nkLZElbs6eOhna4mHMJwrpXWUUds?=
 =?us-ascii?Q?XnK4jPICyIhHugyUH/TtHzG9XPnQq2tHA4zRCwqUv91jQiTAe8mSaZrNEDS1?=
 =?us-ascii?Q?6br6UO4DV46EiAsL1/9yGjhdOkhzt2GV6ytenNyImhILepf+J5jckb9a9OrT?=
 =?us-ascii?Q?5O/36sX14FnzXUD0CQ6x0MwLQEmTT6ajwbQcoV7ySQegGbqHn0NBAhtOX6Sm?=
 =?us-ascii?Q?jWW+v2g9it3QtwI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2024 19:30:42.4035 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6aaac3f-0edf-4eb1-9d46-08dd23884a41
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000014A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6157
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

From: Kenneth Feng <kenneth.feng@amd.com>

set the workload type based on MALL status

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c         |  4 ++--
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c  | 12 ++++++++++--
 drivers/gpu/drm/amd/include/kgd_pp_interface.h  |  2 +-
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c             |  4 ++--
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h         |  2 +-
 .../gpu/drm/amd/pm/powerplay/amd_powerplay.c    |  2 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c       | 17 ++++++++++-------
 8 files changed, 28 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 2e5732dfd425..9b2bdf0273f5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -730,7 +730,7 @@ void amdgpu_amdkfd_set_compute_idle(struct amdgpu_device *adev, bool idle)
 	}
 	amdgpu_dpm_switch_power_profile(adev,
 					PP_SMC_POWER_PROFILE_COMPUTE,
-					!idle);
+					!idle, false);
 }
 
 bool amdgpu_amdkfd_is_kfd_vmid(struct amdgpu_device *adev, u32 vmid)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 83faf6e6788a..393eea91ad0e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -423,7 +423,7 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
 		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
 		       AMD_PG_STATE_GATE);
 		r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
-				false);
+				false, false);
 		if (r)
 			dev_warn(adev->dev, "(%d) failed to disable video power profile mode\n", r);
 	} else {
@@ -440,7 +440,7 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
 
 	if (!cancel_delayed_work_sync(&adev->vcn.idle_work)) {
 		r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
-				true);
+				true, false);
 		if (r)
 			dev_warn(adev->dev, "(%d) failed to switch to video power profile mode\n", r);
 	}
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index 8bc73922e3a6..fc6d8bb7cc11 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -34,6 +34,7 @@
 #include "amdgpu_dm_plane.h"
 #include "amdgpu_dm_trace.h"
 #include "amdgpu_dm_debugfs.h"
+#include "amdgpu_smu.h"
 
 #define HPD_DETECTION_PERIOD_uS 2000000
 #define HPD_DETECTION_TIME_uS 100000
@@ -244,6 +245,9 @@ static void amdgpu_dm_crtc_vblank_control_worker(struct work_struct *work)
 	struct vblank_control_work *vblank_work =
 		container_of(work, struct vblank_control_work, work);
 	struct amdgpu_display_manager *dm = vblank_work->dm;
+	struct amdgpu_device *adev = dm->adev;
+	struct smu_context *smu = (struct smu_context*)(adev->powerplay.pp_handle);
+	int profile_mode = smu->power_profile_mode;
 
 	mutex_lock(&dm->dc_lock);
 
@@ -252,8 +256,10 @@ static void amdgpu_dm_crtc_vblank_control_worker(struct work_struct *work)
 	else if (dm->active_vblank_irq_count)
 		dm->active_vblank_irq_count--;
 
-	if (dm->active_vblank_irq_count > 0)
+	if (dm->active_vblank_irq_count > 0) {
+		amdgpu_dpm_switch_power_profile(adev, profile_mode, true, false);
 		dc_allow_idle_optimizations(dm->dc, false);
+	}
 
 	/*
 	 * Control PSR based on vblank requirements from OS
@@ -271,8 +277,10 @@ static void amdgpu_dm_crtc_vblank_control_worker(struct work_struct *work)
 			vblank_work->acrtc->dm_irq_params.allow_sr_entry);
 	}
 
-	if (dm->active_vblank_irq_count == 0)
+	if (dm->active_vblank_irq_count == 0) {
+		amdgpu_dpm_switch_power_profile(adev, profile_mode, false, true);
 		dc_allow_idle_optimizations(dm->dc, true);
+	}
 
 	mutex_unlock(&dm->dc_lock);
 
diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index 9189dcb65188..cd56fa375f19 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -413,7 +413,7 @@ struct amd_pm_funcs {
 	int (*get_pp_table)(void *handle, char **table);
 	int (*set_pp_table)(void *handle, const char *buf, size_t size);
 	void (*debugfs_print_current_performance_level)(void *handle, struct seq_file *m);
-	int (*switch_power_profile)(void *handle, enum PP_SMC_POWER_PROFILE type, bool en);
+	int (*switch_power_profile)(void *handle, enum PP_SMC_POWER_PROFILE type, bool en, bool force);
 /* export to amdgpu */
 	struct amd_vce_state *(*get_vce_clock_state)(void *handle, u32 idx);
 	int (*dispatch_tasks)(void *handle, enum amd_pp_task task_id,
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 6a9e26905edf..0fd5b520d281 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -331,7 +331,7 @@ int amdgpu_dpm_mode1_reset(struct amdgpu_device *adev)
 
 int amdgpu_dpm_switch_power_profile(struct amdgpu_device *adev,
 				    enum PP_SMC_POWER_PROFILE type,
-				    bool en)
+				    bool en, bool force)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 	int ret = 0;
@@ -342,7 +342,7 @@ int amdgpu_dpm_switch_power_profile(struct amdgpu_device *adev,
 	if (pp_funcs && pp_funcs->switch_power_profile) {
 		mutex_lock(&adev->pm.mutex);
 		ret = pp_funcs->switch_power_profile(
-			adev->powerplay.pp_handle, type, en);
+			adev->powerplay.pp_handle, type, en, force);
 		mutex_unlock(&adev->pm.mutex);
 	}
 
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index 1f5ac7e0230d..b473c06d0b09 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -408,7 +408,7 @@ int amdgpu_dpm_set_xgmi_pstate(struct amdgpu_device *adev,
 
 int amdgpu_dpm_switch_power_profile(struct amdgpu_device *adev,
 				    enum PP_SMC_POWER_PROFILE type,
-				    bool en);
+				    bool en, bool force);
 
 int amdgpu_dpm_baco_reset(struct amdgpu_device *adev);
 
diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
index 686345f75f26..6095776ee0cb 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
@@ -909,7 +909,7 @@ static int pp_dpm_set_mp1_state(void *handle, enum pp_mp1_state mp1_state)
 }
 
 static int pp_dpm_switch_power_profile(void *handle,
-		enum PP_SMC_POWER_PROFILE type, bool en)
+		enum PP_SMC_POWER_PROFILE type, bool en, bool force)
 {
 	struct pp_hwmgr *hwmgr = handle;
 	long workload[1];
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 8ca793c222ff..c48d3588fbc8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -75,7 +75,7 @@ static int smu_set_mp1_state(void *handle, enum pp_mp1_state mp1_state);
 static void smu_power_profile_mode_get(struct smu_context *smu,
 				       enum PP_SMC_POWER_PROFILE profile_mode);
 static void smu_power_profile_mode_put(struct smu_context *smu,
-				       enum PP_SMC_POWER_PROFILE profile_mode);
+				       enum PP_SMC_POWER_PROFILE profile_mode, bool force);
 
 static int smu_sys_get_pp_feature_mask(void *handle,
 				       char *buf)
@@ -2287,8 +2287,11 @@ static void smu_power_profile_mode_get(struct smu_context *smu,
 }
 
 static void smu_power_profile_mode_put(struct smu_context *smu,
-				       enum PP_SMC_POWER_PROFILE profile_mode)
+				       enum PP_SMC_POWER_PROFILE profile_mode, bool force)
 {
+	if (force)
+		smu->workload_refcount[profile_mode] = 0;
+
 	if (smu->workload_refcount[profile_mode])
 		smu->workload_refcount[profile_mode]--;
 }
@@ -2382,7 +2385,7 @@ static int smu_handle_dpm_task(void *handle,
 
 static int smu_switch_power_profile(void *handle,
 				    enum PP_SMC_POWER_PROFILE type,
-				    bool enable)
+				    bool enable, bool force)
 {
 	struct smu_context *smu = handle;
 	struct smu_dpm_context *smu_dpm_ctx = &(smu->smu_dpm);
@@ -2399,11 +2402,11 @@ static int smu_switch_power_profile(void *handle,
 		if (enable)
 			smu_power_profile_mode_get(smu, type);
 		else
-			smu_power_profile_mode_put(smu, type);
+			smu_power_profile_mode_put(smu, type, force);
 		ret = smu_bump_power_profile_mode(smu, NULL, 0);
 		if (ret) {
 			if (enable)
-				smu_power_profile_mode_put(smu, type);
+				smu_power_profile_mode_put(smu, type, force);
 			else
 				smu_power_profile_mode_get(smu, type);
 			return ret;
@@ -3122,14 +3125,14 @@ static int smu_set_power_profile_mode(void *handle,
 
 	if ((param[param_size] != smu->power_profile_mode) || custom) {
 		/* clear the old user preference */
-		smu_power_profile_mode_put(smu, smu->power_profile_mode);
+		smu_power_profile_mode_put(smu, smu->power_profile_mode, false);
 		/* set the new user preference */
 		smu_power_profile_mode_get(smu, param[param_size]);
 		ret = smu_bump_power_profile_mode(smu,
 						  custom ? param : NULL,
 						  custom ? param_size : 0);
 		if (ret)
-			smu_power_profile_mode_put(smu, param[param_size]);
+			smu_power_profile_mode_put(smu, param[param_size], false);
 		else
 			/* store the user's preference */
 			smu->power_profile_mode = param[param_size];
-- 
2.39.5

