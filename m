Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D96F6E68941
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Oct 2024 01:17:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6173D10E069;
	Thu, 31 Oct 2024 01:17:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nIP7k52F";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 644E310E069
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Oct 2024 01:17:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fdCM/3dxpHZDuzHn5YzMH+6x0p74IHZ661KtMq9deu0qdMQX3UiS5UfRNRpY1AFCmkySaVwhPlUiHk+YzMfl4wboLg+rxj6rSk8OWWOFry1g6cbINoB+llhXaiH6T8/s1Vv4tqGea1WHDZUeiMHJOIf8oANjn0xhfG0QqWEiTuRSIPj61AO6HqZe3AY1k6Y88WphWIBQEtb4hzLTV2b6M1JLKhjLBtZ611hlSGLouRCRWNxdYelUAlcj0CcRs2/MLh2vFjy/izBxidDHCTLR32kZW/CBfTAGB2Lf5lojY8DlsmeOOKVandMsP4/miDtTFMGxg1Sg581fRfwIMdbs5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DoZ4UOHkYZFHHKMAC7yEZrWUj+ySpqgh6TYzIej1l7M=;
 b=VwNVBLbcntgIBiDAeqBwepfNdi/G0XzOwuhi2lOHx0w24LplRL4neEnIRTk84mnzeOLlyYb6+D8SdK0NSg+1CavLcUmFjMeKdVfCwKoDd4+XuSSaHkE2R0fS7DvKWJ0/rjPSFa/Xp0/GPdJXbpHJjT3ZDHqA/U4bqaWScj3Snfe/kzvZOsY6eiNa1dOke/ma/ljBrQxFSClfFCpF/TgZYCaloNcrzLQm5tKSmz8vS6ZewTRX+VFqXhhN0Uw+f15Ft4UmHRPLRJ1wdZ2vEVQ/zdypBFiHAQQxPgdSRrbtbsq2wKcna2+2/9RigTpakMokcPnaCM6phL33fscUTyCsNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DoZ4UOHkYZFHHKMAC7yEZrWUj+ySpqgh6TYzIej1l7M=;
 b=nIP7k52FlhSAm/U/FMELrD6A4rR0br3tDrgwY/8Eh77+hXnZU2wBkegA4igoqvW7KgjMsW/+9Jh/ygCdLuZ5zaEYGbgovh1gyn8Rcj1AyEwnuHEjyQ3Z6uMS1y2IiEtAatZcOWaE6rHEmHjoECwBYyp5endlPLLNomw8NhlWd0Y=
Received: from PH8PR22CA0012.namprd22.prod.outlook.com (2603:10b6:510:2d1::8)
 by PH8PR12MB7136.namprd12.prod.outlook.com (2603:10b6:510:22b::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Thu, 31 Oct
 2024 01:17:44 +0000
Received: from MWH0EPF000A6735.namprd04.prod.outlook.com
 (2603:10b6:510:2d1:cafe::a5) by PH8PR22CA0012.outlook.office365.com
 (2603:10b6:510:2d1::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.23 via Frontend
 Transport; Thu, 31 Oct 2024 01:17:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000A6735.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Thu, 31 Oct 2024 01:17:43 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Oct
 2024 20:17:42 -0500
Received: from kenneth-mlse-vm.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via
 Frontend Transport; Wed, 30 Oct 2024 20:17:40 -0500
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <Alexander.Deucher@amd.com>, Kenneth Feng
 <kenneth.feng@amd.com>
Subject: [PATCH v5] drm/amd/pm: correct the workload setting
Date: Thu, 31 Oct 2024 09:17:39 +0800
Message-ID: <20241031011739.80881-1-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: kenneth.feng@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6735:EE_|PH8PR12MB7136:EE_
X-MS-Office365-Filtering-Correlation-Id: 04a13e13-9148-4c35-5793-08dcf949d26b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5PnrnNYsLwptC3tdCxtXk2EoCkbaH13wXDojT79Ly2Za0Flh4fpJfyyvEEAK?=
 =?us-ascii?Q?4Qa5HSKWT9F/Mtf3f4eVUTTCjjDwZC+5TKywraugAv2/hH0eUOzy/dlz5yNO?=
 =?us-ascii?Q?dPOm8HvX92+kwP2AC4dqBLigYCxZbjSGVEydwTYAkJet2i5wZ6BLoBnt+CXK?=
 =?us-ascii?Q?NIUx4+zvPYBzXNgiW+uAijBv2FEIkH1F6RBsoMsYUn3gvsOXJ72HPAOgf0jo?=
 =?us-ascii?Q?ioHC+dtk7hVxEbBWWxlIR4hBLvKcTyHIT7uIUiCMgVIbVHJJeeC2wOIuoe5V?=
 =?us-ascii?Q?lazWg20ToZj4O1fz1vUyoi4hDouBfKpOAyHAfxhdpL0ObuIwmmpPojfe/W4a?=
 =?us-ascii?Q?QrsW1pqZ1r2TlwLiLc7o++8P9PsxpZzCK51/6SkC6XtZ3E8VKzjeq9pUe9Zb?=
 =?us-ascii?Q?hp0FIOMcMStl7a70hxrZjwjC2VBoZNbIHVnoZxFGu98kf7Qmy/Z1lStNdt7V?=
 =?us-ascii?Q?Wcnaal7//Wd9XnkPknLkat9FaQxnv5eObNB5hqLhoFlVm8/MgBOdO+Kw+Ppf?=
 =?us-ascii?Q?THFbVyvluck8HPu9ekeutsPOH10KlNPbv91eIqw3G0uGIprxGM0jcFNxMPHn?=
 =?us-ascii?Q?KviPy+Hf1fVO7tIzlCIP1zSxf5frbIqsDKE0LIzKm5jIUTHZGA3G1wlk688E?=
 =?us-ascii?Q?9oZOvjSN/HOn9nCYdFZhTbHbibFzj0kjSyjMsrohGPNNiKwtnVBiTyrSGhXv?=
 =?us-ascii?Q?eCb6UQYdipWWM9Kx53NA7dwUQQZ6AFfdbUMnkWGTFaMZ0Oc7pMbLjHa4/IWW?=
 =?us-ascii?Q?5tEvWExsiGKdvO/18zrRMR0QVV8L6G0U9ccSidd9Prvc7KP1lO4JNcCLPKa8?=
 =?us-ascii?Q?KsVZd/xmmcOa2oSecaA6ahMDeJRHebPSVc92jDC90/FTBXNk4SMtCwzUrCvi?=
 =?us-ascii?Q?reajqAbW4zLXCKQWBS1PMjLW0QYKhLdNQ3b5YYOrD3VoSm7SimtsDZPhgY6v?=
 =?us-ascii?Q?fvxdiqGrtr+TQMNLwlMjLT8ED4/lD/XcDJMxIVp4xISfqODF1A9l5fbZ3cCI?=
 =?us-ascii?Q?2r75Fhszq2bomN6bgOMIYp3xEMYTkXn3ZdVdtLUWhQ1HeUcFsb7efjfXUHda?=
 =?us-ascii?Q?PtQlJOQqd1krAA9kg/JIRojPq2g6IiAjVNOyufBbGxIetcosiPgbe2GyeFJE?=
 =?us-ascii?Q?/pkdrkD4PuB6nl85T27F2AotEaB28V8W9If1neBJ6GTeUI+pizI+ieo2vva2?=
 =?us-ascii?Q?I1KOMWERXUp1Ib0DleUKwuhROX6eHCUOst0rMkv8MJ3OMd7HhXJdQVz03O2M?=
 =?us-ascii?Q?4C47/mSWL0yma4AvDMjt85z/3zxp/+IFJ+EvqV+b7vttp7mqNSUu4sQcw/OD?=
 =?us-ascii?Q?Dlxq/TPeGkeCtWsODBDbiNb0dcoGrPV3sMp0M4u2JFMa8N65IG7lCqeCFFJ7?=
 =?us-ascii?Q?mtkNAGMT9xzEW/85zsKZs7jPSANh0LeBG1/2ZTFRQkS5Gil1vQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 01:17:43.6384 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04a13e13-9148-4c35-5793-08dcf949d26b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6735.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7136
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

Correct the workload setting in order not to mix the setting
with the end user. Update the workload mask accordingly.

v2: changes as below:
1. the end user can not erase the workload from driver except default workload.
2. always shows the real highest priority workoad to the end user.
3. the real workload mask is combined with driver workload mask and end user workload mask.

v3: apply this to the other ASICs as well.
v4: simplify the code
v5: refine the code based on the review comments.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 49 +++++++++++++------
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  4 +-
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |  5 +-
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   |  5 +-
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |  5 +-
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  |  4 +-
 .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   |  4 +-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 20 ++++++--
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  |  5 +-
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  |  9 ++--
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        |  8 +++
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |  2 +
 12 files changed, 84 insertions(+), 36 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 8d4aee4e2287..2e6c2f8dd065 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1261,26 +1261,33 @@ static int smu_sw_init(struct amdgpu_ip_block *ip_block)
 	smu->watermarks_bitmap = 0;
 	smu->power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
 	smu->default_power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
+	smu->user_dpm_profile.user_workload_mask = 0;
 
 	atomic_set(&smu->smu_power.power_gate.vcn_gated, 1);
 	atomic_set(&smu->smu_power.power_gate.jpeg_gated, 1);
 	atomic_set(&smu->smu_power.power_gate.vpe_gated, 1);
 	atomic_set(&smu->smu_power.power_gate.umsch_mm_gated, 1);
 
-	smu->workload_prority[PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT] = 0;
-	smu->workload_prority[PP_SMC_POWER_PROFILE_FULLSCREEN3D] = 1;
-	smu->workload_prority[PP_SMC_POWER_PROFILE_POWERSAVING] = 2;
-	smu->workload_prority[PP_SMC_POWER_PROFILE_VIDEO] = 3;
-	smu->workload_prority[PP_SMC_POWER_PROFILE_VR] = 4;
-	smu->workload_prority[PP_SMC_POWER_PROFILE_COMPUTE] = 5;
-	smu->workload_prority[PP_SMC_POWER_PROFILE_CUSTOM] = 6;
+	smu->workload_priority[PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT] = 0;
+	smu->workload_priority[PP_SMC_POWER_PROFILE_FULLSCREEN3D] = 1;
+	smu->workload_priority[PP_SMC_POWER_PROFILE_POWERSAVING] = 2;
+	smu->workload_priority[PP_SMC_POWER_PROFILE_VIDEO] = 3;
+	smu->workload_priority[PP_SMC_POWER_PROFILE_VR] = 4;
+	smu->workload_priority[PP_SMC_POWER_PROFILE_COMPUTE] = 5;
+	smu->workload_priority[PP_SMC_POWER_PROFILE_CUSTOM] = 6;
 
 	if (smu->is_apu ||
-	    !smu_is_workload_profile_available(smu, PP_SMC_POWER_PROFILE_FULLSCREEN3D))
-		smu->workload_mask = 1 << smu->workload_prority[PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT];
-	else
-		smu->workload_mask = 1 << smu->workload_prority[PP_SMC_POWER_PROFILE_FULLSCREEN3D];
+	    !smu_is_workload_profile_available(smu, PP_SMC_POWER_PROFILE_FULLSCREEN3D)) {
+		smu->driver_workload_mask =
+			1 << smu->workload_priority[PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT];
+	} else {
+		smu->driver_workload_mask =
+			1 << smu->workload_priority[PP_SMC_POWER_PROFILE_FULLSCREEN3D];
+		smu->default_power_profile_mode = PP_SMC_POWER_PROFILE_FULLSCREEN3D;
+	}
 
+	smu->workload_mask = smu->driver_workload_mask |
+							smu->user_dpm_profile.user_workload_mask;
 	smu->workload_setting[0] = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
 	smu->workload_setting[1] = PP_SMC_POWER_PROFILE_FULLSCREEN3D;
 	smu->workload_setting[2] = PP_SMC_POWER_PROFILE_POWERSAVING;
@@ -2354,17 +2361,20 @@ static int smu_switch_power_profile(void *handle,
 		return -EINVAL;
 
 	if (!en) {
-		smu->workload_mask &= ~(1 << smu->workload_prority[type]);
+		smu->driver_workload_mask &= ~(1 << smu->workload_priority[type]);
 		index = fls(smu->workload_mask);
 		index = index > 0 && index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
 		workload[0] = smu->workload_setting[index];
 	} else {
-		smu->workload_mask |= (1 << smu->workload_prority[type]);
+		smu->driver_workload_mask |= (1 << smu->workload_priority[type]);
 		index = fls(smu->workload_mask);
 		index = index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
 		workload[0] = smu->workload_setting[index];
 	}
 
+	smu->workload_mask = smu->driver_workload_mask |
+						 smu->user_dpm_profile.user_workload_mask;
+
 	if (smu_dpm_ctx->dpm_level != AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM)
 		smu_bump_power_profile_mode(smu, workload, 0);
 
@@ -3054,12 +3064,23 @@ static int smu_set_power_profile_mode(void *handle,
 				      uint32_t param_size)
 {
 	struct smu_context *smu = handle;
+	int ret;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled ||
 	    !smu->ppt_funcs->set_power_profile_mode)
 		return -EOPNOTSUPP;
 
-	return smu_bump_power_profile_mode(smu, param, param_size);
+	if (smu->user_dpm_profile.user_workload_mask &
+	   (1 << smu->workload_priority[param[param_size]]))
+	   return 0;
+
+	smu->user_dpm_profile.user_workload_mask =
+		(1 << smu->workload_priority[param[param_size]]);
+	smu->workload_mask = smu->user_dpm_profile.user_workload_mask |
+		smu->driver_workload_mask;
+	ret = smu_bump_power_profile_mode(smu, param, param_size);
+
+	return ret;
 }
 
 static int smu_get_fan_control_mode(void *handle, u32 *fan_mode)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 8bb32b3f0d9c..4ffed49ebb4b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -240,6 +240,7 @@ struct smu_user_dpm_profile {
 	/* user clock state information */
 	uint32_t clk_mask[SMU_CLK_COUNT];
 	uint32_t clk_dependency;
+	uint32_t user_workload_mask;
 };
 
 #define SMU_TABLE_INIT(tables, table_id, s, a, d)	\
@@ -557,7 +558,8 @@ struct smu_context {
 	bool disable_uclk_switch;
 
 	uint32_t workload_mask;
-	uint32_t workload_prority[WORKLOAD_POLICY_MAX];
+	uint32_t driver_workload_mask;
+	uint32_t workload_priority[WORKLOAD_POLICY_MAX];
 	uint32_t workload_setting[WORKLOAD_POLICY_MAX];
 	uint32_t power_profile_mode;
 	uint32_t default_power_profile_mode;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 5ad09323a29d..a20d08821a50 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -1455,7 +1455,6 @@ static int arcturus_set_power_profile_mode(struct smu_context *smu,
 		return -EINVAL;
 	}
 
-
 	if ((profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) &&
 	     (smu->smc_fw_version >= 0x360d00)) {
 		if (size != 10)
@@ -1523,14 +1522,14 @@ static int arcturus_set_power_profile_mode(struct smu_context *smu,
 
 	ret = smu_cmn_send_smc_msg_with_param(smu,
 					  SMU_MSG_SetWorkloadMask,
-					  1 << workload_type,
+					  smu->workload_mask,
 					  NULL);
 	if (ret) {
 		dev_err(smu->adev->dev, "Fail to set workload type %d\n", workload_type);
 		return ret;
 	}
 
-	smu->power_profile_mode = profile_mode;
+	smu_cmn_assign_power_profile(smu);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 9fa305ba6422..190ea240deae 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2081,10 +2081,13 @@ static int navi10_set_power_profile_mode(struct smu_context *smu, long *input, u
 						       smu->power_profile_mode);
 	if (workload_type < 0)
 		return -EINVAL;
+
 	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
-				    1 << workload_type, NULL);
+				    smu->workload_mask, NULL);
 	if (ret)
 		dev_err(smu->adev->dev, "[%s] Failed to set work load mask!", __func__);
+	else
+		smu_cmn_assign_power_profile(smu);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 77e58eb46328..0c7deb62b141 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -1786,10 +1786,13 @@ static int sienna_cichlid_set_power_profile_mode(struct smu_context *smu, long *
 						       smu->power_profile_mode);
 	if (workload_type < 0)
 		return -EINVAL;
+
 	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
-				    1 << workload_type, NULL);
+				    smu->workload_mask, NULL);
 	if (ret)
 		dev_err(smu->adev->dev, "[%s] Failed to set work load mask!", __func__);
+	else
+		smu_cmn_assign_power_profile(smu);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 6c43724c01dd..26e0b4ee1fa5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -1079,7 +1079,7 @@ static int vangogh_set_power_profile_mode(struct smu_context *smu, long *input,
 	}
 
 	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_ActiveProcessNotify,
-				    1 << workload_type,
+				    smu->workload_mask,
 				    NULL);
 	if (ret) {
 		dev_err_once(smu->adev->dev, "Fail to set workload type %d\n",
@@ -1087,7 +1087,7 @@ static int vangogh_set_power_profile_mode(struct smu_context *smu, long *input,
 		return ret;
 	}
 
-	smu->power_profile_mode = profile_mode;
+	smu_cmn_assign_power_profile(smu);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
index 0b210b1f2628..12d40c43ad40 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
@@ -890,14 +890,14 @@ static int renoir_set_power_profile_mode(struct smu_context *smu, long *input, u
 	}
 
 	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_ActiveProcessNotify,
-				    1 << workload_type,
+				    smu->workload_mask,
 				    NULL);
 	if (ret) {
 		dev_err_once(smu->adev->dev, "Fail to set workload type %d\n", workload_type);
 		return ret;
 	}
 
-	smu->power_profile_mode = profile_mode;
+	smu_cmn_assign_power_profile(smu);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 8d25cc1f218f..1d29e99d7955 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -2473,7 +2473,7 @@ static int smu_v13_0_0_set_power_profile_mode(struct smu_context *smu,
 	DpmActivityMonitorCoeffInt_t *activity_monitor =
 		&(activity_monitor_external.DpmActivityMonitorCoeffInt);
 	int workload_type, ret = 0;
-	u32 workload_mask, selected_workload_mask;
+	u32 workload_mask;
 
 	smu->power_profile_mode = input[size];
 
@@ -2540,7 +2540,7 @@ static int smu_v13_0_0_set_power_profile_mode(struct smu_context *smu,
 	if (workload_type < 0)
 		return -EINVAL;
 
-	selected_workload_mask = workload_mask = 1 << workload_type;
+	workload_mask = 1 << workload_type;
 
 	/* Add optimizations for SMU13.0.0/10.  Reuse the power saving profile */
 	if ((amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 0) &&
@@ -2555,12 +2555,22 @@ static int smu_v13_0_0_set_power_profile_mode(struct smu_context *smu,
 			workload_mask |= 1 << workload_type;
 	}
 
+	smu->workload_mask |= workload_mask;
 	ret = smu_cmn_send_smc_msg_with_param(smu,
 					       SMU_MSG_SetWorkloadMask,
-					       workload_mask,
+					       smu->workload_mask,
 					       NULL);
-	if (!ret)
-		smu->workload_mask = selected_workload_mask;
+	if (!ret) {
+		smu_cmn_assign_power_profile(smu);
+		if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_POWERSAVING) {
+			workload_type = smu_cmn_to_asic_specific_index(smu,
+							       CMN2ASIC_MAPPING_WORKLOAD,
+							       PP_SMC_POWER_PROFILE_FULLSCREEN3D);
+			smu->power_profile_mode = smu->workload_mask & (1 << workload_type)
+										? PP_SMC_POWER_PROFILE_FULLSCREEN3D
+										: PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
+		}
+	}
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 23f13388455f..12d622d4aceb 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -2487,13 +2487,14 @@ static int smu_v13_0_7_set_power_profile_mode(struct smu_context *smu, long *inp
 						       smu->power_profile_mode);
 	if (workload_type < 0)
 		return -EINVAL;
+
 	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
-				    1 << workload_type, NULL);
+				    smu->workload_mask, NULL);
 
 	if (ret)
 		dev_err(smu->adev->dev, "[%s] Failed to set work load mask!", __func__);
 	else
-		smu->workload_mask = (1 << workload_type);
+		smu_cmn_assign_power_profile(smu);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index cefe10b95d8e..e8ef6aa1d664 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -1857,12 +1857,11 @@ static int smu_v14_0_2_set_power_profile_mode(struct smu_context *smu,
 	if (workload_type < 0)
 		return -EINVAL;
 
-	ret = smu_cmn_send_smc_msg_with_param(smu,
-					       SMU_MSG_SetWorkloadMask,
-					       1 << workload_type,
-					       NULL);
+	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
+										  smu->workload_mask, NULL);
+
 	if (!ret)
-		smu->workload_mask = 1 << workload_type;
+		smu_cmn_assign_power_profile(smu);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index 63c4f75fa118..fd2aa949538e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -1141,6 +1141,14 @@ int smu_cmn_set_mp1_state(struct smu_context *smu,
 	return ret;
 }
 
+void smu_cmn_assign_power_profile(struct smu_context *smu)
+{
+	uint32_t index;
+	index = fls(smu->workload_mask);
+	index = index > 0 && index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
+	smu->power_profile_mode = smu->workload_setting[index];
+}
+
 bool smu_cmn_is_audio_func_enabled(struct amdgpu_device *adev)
 {
 	struct pci_dev *p = NULL;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
index 1de685defe85..8a801e389659 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
@@ -130,6 +130,8 @@ void smu_cmn_init_soft_gpu_metrics(void *table, uint8_t frev, uint8_t crev);
 int smu_cmn_set_mp1_state(struct smu_context *smu,
 			  enum pp_mp1_state mp1_state);
 
+void smu_cmn_assign_power_profile(struct smu_context *smu);
+
 /*
  * Helper function to make sysfs_emit_at() happy. Align buf to
  * the current page boundary and record the offset.
-- 
2.34.1

