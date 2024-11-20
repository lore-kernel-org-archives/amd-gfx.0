Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 376A2D711D7
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2024 18:28:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CED2C10E187;
	Wed, 20 Nov 2024 18:28:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="htb2Qogm";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE15C10E187
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Nov 2024 18:28:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iW+Ay+sMVJrSojENR0G6XcNP4XyhS39Z6xDL+Twy7r0TVSluXB2Cf8JtVFq1SCnKWjlbLp2HHm3lS0qReYUozCvSYNgILQL+uVjJjlbqww7wxhvIvAGpnBUVqPJxecJvyD9AZh5QlMOiTaxynicSR+ejuQqBK2rvi/+n8mKJ9hXnhbbilzekIWKcn1HEFLoyR1ETC5k6qzy2jRU3WW+pTqyIZdduC6OTQy2Kin3LT8HY1/drzybNC3VQgG8ie/3Tx5E4EoBU59yrANQo1S70+UIzcFPh5PPdv9GVeain4sGxKEtbUX8TZ0eic/75NuLW8+bE/UwnsP7uM3j6u6YfeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DnQu1dVqgnvKZzuOE+q/WNBTmN1DHEYJiKgOrG1RLVI=;
 b=J2CZyzchPQukcIwhSDEgjfckXoTXJCcGHev2flgHusSvMGdAd0nnXQz7xVOoYY7WG8VaR/yuPJM4YWSzuF/iHEhJ+YVss4Oha7JX74XiV8+JjN4BGBgQnjKrKwYaBYrSQnoMkRqJpGw8wpTnvnQU25+LlGsBDZVVPvUpnkr+Ag5RxfbntaFBqI4kiD14G0YxLYK8VcCR2idwOi96yB4MxHMYpAPiZwyGa5dzm/4ob5MD+sg/pOp7AVTg22daxRbZ7ob4OTAPFtEiuKcPQYAZI2kjHghoncss3mRjisLHOev0H4slygo7+SPJhBvV4WXq4gbpU08zSVR7roMjDzy6VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DnQu1dVqgnvKZzuOE+q/WNBTmN1DHEYJiKgOrG1RLVI=;
 b=htb2Qogm+DwfbFgX/VDVsLV8vfcV0mBn9Gw03m6j/MxIUyzUrB8iy4KAYLrxt4HFyLGrJgL60d5BubYRjNhKS0KF4EBNSLJUP/hq0M2zKBIpZd9uA5BeRH58be04p31KY2ldB9MXFuBCxH6gl/d/xYY3xJcl/m91ElJf5/kLF9s=
Received: from BY5PR04CA0028.namprd04.prod.outlook.com (2603:10b6:a03:1d0::38)
 by PH7PR12MB6884.namprd12.prod.outlook.com (2603:10b6:510:1ba::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Wed, 20 Nov
 2024 18:28:47 +0000
Received: from CO1PEPF000044F2.namprd05.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::79) by BY5PR04CA0028.outlook.office365.com
 (2603:10b6:a03:1d0::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23 via Frontend
 Transport; Wed, 20 Nov 2024 18:28:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 CO1PEPF000044F2.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8182.16 via Frontend Transport; Wed, 20 Nov 2024 18:28:46 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Nov
 2024 12:28:44 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Kenneth Feng
 <kenneth.feng@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
Subject: [PATCH] drm/amd/pm: fix and simplify workload handling
Date: Wed, 20 Nov 2024 13:28:28 -0500
Message-ID: <20241120182828.2507700-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F2:EE_|PH7PR12MB6884:EE_
X-MS-Office365-Filtering-Correlation-Id: 2747eb41-d611-48d7-7f0d-08dd09912bda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8vplQQWa3ias4oSYKNMdmJri+QFCcpvPLIidnQVRsZ+AoqXeaUi61Eeo06Hx?=
 =?us-ascii?Q?mv04cdxQgS4nWqZ+KdJtys40A/G3WmJP+4w3nWU6dZRrWh1OGF3dgSJNf+IK?=
 =?us-ascii?Q?Sa3Vy3zAYG9z1gOb4BHM7qtfM7G4kwdocmLszPrhjFhlYs8380QDJ3zYJaRr?=
 =?us-ascii?Q?O+qEQV2yxpBP+4bdV8sp7VQsopI0GyU8YmAP63ks3ZyLmff+Lb+OUGYVg5eT?=
 =?us-ascii?Q?/JwFp7IFT21uq71omvqzNnVu5WMRPjxxnHU0TZCelbJHOHWDRnEdQwlMVbdy?=
 =?us-ascii?Q?uSXNa6IRv6ZlH2rfvkxjHjOiqNXVQ3Vo2TxLvQt1BLjBNYOctx8iXFtVHDoT?=
 =?us-ascii?Q?Vwyg7yFnVcLgtYUr9X5HXBZ+sieupP4k72cl4qpIheF0PNSwBD03bKg2BCka?=
 =?us-ascii?Q?+Wjv5s1oOB5oMK1JzdDsuqs204k4VV+RtOMjYM/QhZxrHg7rLmNog9vfsKb1?=
 =?us-ascii?Q?VTbLF2jFlaOwlNmPCw+Gpa6NyqSvJvXqQ3f7n8y9NEAT1fP8J0mtgJNqEaW3?=
 =?us-ascii?Q?Uk2aUOSa/OXX1FE/41oVAYFeDBUG6bHmo3jAfYmq5WL+AsRl8vHanWJbCUb2?=
 =?us-ascii?Q?zPyWXRw1C19KXsJvYefKhkVltI2oOsay3VChGpVv8vX6aKdSoUwPzuSWdluR?=
 =?us-ascii?Q?rBwuWMrWJ+0JfjzrOaO1OjQ8OIjLUm27SXrn0T47Y+GRaUOh9NoBHgX4UhfE?=
 =?us-ascii?Q?rc/y7zHRuInsBQDPZUqDXvGW2O3AuJ5IpZa28DHHt6LUJik9rB2/Apq4mxkJ?=
 =?us-ascii?Q?foXDaw18tvf7W4dv7Ry/5AmNAVWyiLUaQavKHCVPt8PuXO3plX6zZ1flVNHW?=
 =?us-ascii?Q?w4rUpUP8iggjR97tTrqBW9xitM4EzxTRV6YSMDoY2l83uTxFILGNxH12jrnf?=
 =?us-ascii?Q?lCeghlKkrVJcAsquYa6BBdc3uTI5O/2NuNbEYHMqpzdk4PY1fmY548Bv6xPI?=
 =?us-ascii?Q?fjWAeokXVZCLAayk06vv41CrqkKoEpyob/qNHA+ACxCrWUuuNLr1Qcqt7ZyX?=
 =?us-ascii?Q?nKHdKXeD8pxWxnZovIJYd8mkDSvzc9JmWGpCj7aMBEUZ2+RQCmkc0upyucCC?=
 =?us-ascii?Q?AUvSZUqgZKPLx1aOuM1qIOEzBxDK6P/h9fWYbDe2ug1lzCHzCflcE3UaTHO+?=
 =?us-ascii?Q?i/0jYzvPSez6+4dOjNr7L3l+IUU9e9+3HZJY7+0YfkDs5/n3vIeo8Ez+uj8n?=
 =?us-ascii?Q?6Ap/GnIBBu4QW05DmgGXVWsKsKy5tlEOblWVa9L1XEoYQRBstX7qnTwndT3+?=
 =?us-ascii?Q?IiCryfXMbDfOWtNs9tG86FQ5aQ3U9Dc9KG1RGaA9TBXBwoGX/PQspO+Cjg/9?=
 =?us-ascii?Q?wm/2kcJYKvBiygyVecOZna6Z+y8XfYKQ1wGjJqpHC4gf7PPyaKOegDfzFbXc?=
 =?us-ascii?Q?+FG7zx5PzfwK59DDSQcxBVh1MtrGGP1GqdTeRWi1MVgrtaoHHw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.12; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:atlvpn-bp.amd.com; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 18:28:46.5563 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2747eb41-d611-48d7-7f0d-08dd09912bda
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.12];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6884
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

smu->workload_mask is IP specific and should not be messed with in
the common code. The mask bits vary across SMU versions.

Move all handling of smu->workload_mask in to the backends and
simplify the code.  Store the user's preference in smu->power_profile_mode
which will be reflected in sysfs.  For internal driver profile
switches for KFD or VCN, just update the workload mask so that the
user's preference is retained.  Remove all of the extra now unused
workload related elements in the smu structure.

v2: use refcounts for workload profiles
v3: rework based on feedback from Lijo
v4: fix the refcount on failure, drop backend mask
v5: rework custom handling
v6: handle failure cleanup with custom profile

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Kenneth Feng <kenneth.feng@amd.com>
Cc: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 150 ++++++++++------
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  15 +-
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 166 +++++++++--------
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 167 ++++++++++-------
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 168 +++++++++++-------
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  |  41 ++---
 .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   |  43 ++---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 167 +++++++++--------
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 138 ++++++++------
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  | 168 +++++++++++-------
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        |  25 +++
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |   4 +
 12 files changed, 736 insertions(+), 516 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index f99fe2508852..acaa1530c25c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -72,6 +72,10 @@ static int smu_set_power_limit(void *handle, uint32_t limit);
 static int smu_set_fan_speed_rpm(void *handle, uint32_t speed);
 static int smu_set_gfx_cgpg(struct smu_context *smu, bool enabled);
 static int smu_set_mp1_state(void *handle, enum pp_mp1_state mp1_state);
+static void smu_power_profile_mode_get(struct smu_context *smu,
+				       enum PP_SMC_POWER_PROFILE profile_mode);
+static void smu_power_profile_mode_put(struct smu_context *smu,
+				       enum PP_SMC_POWER_PROFILE profile_mode);
 
 static int smu_sys_get_pp_feature_mask(void *handle,
 				       char *buf)
@@ -1268,8 +1272,6 @@ static int smu_sw_init(struct amdgpu_ip_block *ip_block)
 	INIT_WORK(&smu->interrupt_work, smu_interrupt_work_fn);
 	atomic64_set(&smu->throttle_int_counter, 0);
 	smu->watermarks_bitmap = 0;
-	smu->power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
-	smu->default_power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; i++)
 		atomic_set(&smu->smu_power.power_gate.vcn_gated[i], 1);
@@ -1277,27 +1279,13 @@ static int smu_sw_init(struct amdgpu_ip_block *ip_block)
 	atomic_set(&smu->smu_power.power_gate.vpe_gated, 1);
 	atomic_set(&smu->smu_power.power_gate.umsch_mm_gated, 1);
 
-	smu->workload_prority[PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT] = 0;
-	smu->workload_prority[PP_SMC_POWER_PROFILE_FULLSCREEN3D] = 1;
-	smu->workload_prority[PP_SMC_POWER_PROFILE_POWERSAVING] = 2;
-	smu->workload_prority[PP_SMC_POWER_PROFILE_VIDEO] = 3;
-	smu->workload_prority[PP_SMC_POWER_PROFILE_VR] = 4;
-	smu->workload_prority[PP_SMC_POWER_PROFILE_COMPUTE] = 5;
-	smu->workload_prority[PP_SMC_POWER_PROFILE_CUSTOM] = 6;
-
 	if (smu->is_apu ||
 	    !smu_is_workload_profile_available(smu, PP_SMC_POWER_PROFILE_FULLSCREEN3D))
-		smu->workload_mask = 1 << smu->workload_prority[PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT];
+		smu->power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
 	else
-		smu->workload_mask = 1 << smu->workload_prority[PP_SMC_POWER_PROFILE_FULLSCREEN3D];
-
-	smu->workload_setting[0] = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
-	smu->workload_setting[1] = PP_SMC_POWER_PROFILE_FULLSCREEN3D;
-	smu->workload_setting[2] = PP_SMC_POWER_PROFILE_POWERSAVING;
-	smu->workload_setting[3] = PP_SMC_POWER_PROFILE_VIDEO;
-	smu->workload_setting[4] = PP_SMC_POWER_PROFILE_VR;
-	smu->workload_setting[5] = PP_SMC_POWER_PROFILE_COMPUTE;
-	smu->workload_setting[6] = PP_SMC_POWER_PROFILE_CUSTOM;
+		smu->power_profile_mode = PP_SMC_POWER_PROFILE_FULLSCREEN3D;
+	smu_power_profile_mode_get(smu, smu->power_profile_mode);
+
 	smu->display_config = &adev->pm.pm_display_cfg;
 
 	smu->smu_dpm.dpm_level = AMD_DPM_FORCED_LEVEL_AUTO;
@@ -1350,6 +1338,11 @@ static int smu_sw_fini(struct amdgpu_ip_block *ip_block)
 		return ret;
 	}
 
+	if (smu->custom_profile_params) {
+		kfree(smu->custom_profile_params);
+		smu->custom_profile_params = NULL;
+	}
+
 	smu_fini_microcode(smu);
 
 	return 0;
@@ -2137,6 +2130,9 @@ static int smu_suspend(struct amdgpu_ip_block *ip_block)
 	if (!ret)
 		adev->gfx.gfx_off_entrycount = count;
 
+	/* clear this on suspend so it will get reprogrammed on resume */
+	smu->workload_mask = 0;
+
 	return 0;
 }
 
@@ -2249,25 +2245,49 @@ static int smu_enable_umd_pstate(void *handle,
 }
 
 static int smu_bump_power_profile_mode(struct smu_context *smu,
-					   long *param,
-					   uint32_t param_size)
+				       long *custom_params,
+				       u32 custom_params_max_idx)
 {
-	int ret = 0;
+	u32 workload_mask = 0;
+	int i, ret = 0;
+
+	for (i = 0; i < PP_SMC_POWER_PROFILE_COUNT; i++) {
+		if (smu->workload_refcount[i])
+			workload_mask |= 1 << i;
+	}
+
+	if (smu->workload_mask == workload_mask)
+		return 0;
 
 	if (smu->ppt_funcs->set_power_profile_mode)
-		ret = smu->ppt_funcs->set_power_profile_mode(smu, param, param_size);
+		ret = smu->ppt_funcs->set_power_profile_mode(smu, workload_mask,
+							     custom_params,
+							     custom_params_max_idx);
+
+	if (!ret)
+		smu->workload_mask = workload_mask;
 
 	return ret;
 }
 
+static void smu_power_profile_mode_get(struct smu_context *smu,
+				       enum PP_SMC_POWER_PROFILE profile_mode)
+{
+	smu->workload_refcount[profile_mode]++;
+}
+
+static void smu_power_profile_mode_put(struct smu_context *smu,
+				       enum PP_SMC_POWER_PROFILE profile_mode)
+{
+	if (smu->workload_refcount[profile_mode])
+		smu->workload_refcount[profile_mode]--;
+}
+
 static int smu_adjust_power_state_dynamic(struct smu_context *smu,
 					  enum amd_dpm_forced_level level,
-					  bool skip_display_settings,
-					  bool init)
+					  bool skip_display_settings)
 {
 	int ret = 0;
-	int index = 0;
-	long workload[1];
 	struct smu_dpm_context *smu_dpm_ctx = &(smu->smu_dpm);
 
 	if (!skip_display_settings) {
@@ -2304,14 +2324,8 @@ static int smu_adjust_power_state_dynamic(struct smu_context *smu,
 	}
 
 	if (smu_dpm_ctx->dpm_level != AMD_DPM_FORCED_LEVEL_MANUAL &&
-		smu_dpm_ctx->dpm_level != AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM) {
-		index = fls(smu->workload_mask);
-		index = index > 0 && index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
-		workload[0] = smu->workload_setting[index];
-
-		if (init || smu->power_profile_mode != workload[0])
-			smu_bump_power_profile_mode(smu, workload, 0);
-	}
+	    smu_dpm_ctx->dpm_level != AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM)
+		smu_bump_power_profile_mode(smu, NULL, 0);
 
 	return ret;
 }
@@ -2330,13 +2344,13 @@ static int smu_handle_task(struct smu_context *smu,
 		ret = smu_pre_display_config_changed(smu);
 		if (ret)
 			return ret;
-		ret = smu_adjust_power_state_dynamic(smu, level, false, false);
+		ret = smu_adjust_power_state_dynamic(smu, level, false);
 		break;
 	case AMD_PP_TASK_COMPLETE_INIT:
-		ret = smu_adjust_power_state_dynamic(smu, level, true, true);
+		ret = smu_adjust_power_state_dynamic(smu, level, true);
 		break;
 	case AMD_PP_TASK_READJUST_POWER_STATE:
-		ret = smu_adjust_power_state_dynamic(smu, level, true, false);
+		ret = smu_adjust_power_state_dynamic(smu, level, true);
 		break;
 	default:
 		break;
@@ -2358,12 +2372,11 @@ static int smu_handle_dpm_task(void *handle,
 
 static int smu_switch_power_profile(void *handle,
 				    enum PP_SMC_POWER_PROFILE type,
-				    bool en)
+				    bool enable)
 {
 	struct smu_context *smu = handle;
 	struct smu_dpm_context *smu_dpm_ctx = &(smu->smu_dpm);
-	long workload[1];
-	uint32_t index;
+	int ret;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
@@ -2371,21 +2384,21 @@ static int smu_switch_power_profile(void *handle,
 	if (!(type < PP_SMC_POWER_PROFILE_CUSTOM))
 		return -EINVAL;
 
-	if (!en) {
-		smu->workload_mask &= ~(1 << smu->workload_prority[type]);
-		index = fls(smu->workload_mask);
-		index = index > 0 && index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
-		workload[0] = smu->workload_setting[index];
-	} else {
-		smu->workload_mask |= (1 << smu->workload_prority[type]);
-		index = fls(smu->workload_mask);
-		index = index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
-		workload[0] = smu->workload_setting[index];
-	}
-
 	if (smu_dpm_ctx->dpm_level != AMD_DPM_FORCED_LEVEL_MANUAL &&
-		smu_dpm_ctx->dpm_level != AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM)
-		smu_bump_power_profile_mode(smu, workload, 0);
+	    smu_dpm_ctx->dpm_level != AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM) {
+		if (enable)
+			smu_power_profile_mode_get(smu, type);
+		else
+			smu_power_profile_mode_put(smu, type);
+		ret = smu_bump_power_profile_mode(smu, NULL, 0);
+		if (ret) {
+			if (enable)
+				smu_power_profile_mode_put(smu, type);
+			else
+				smu_power_profile_mode_get(smu, type);
+			return ret;
+		}
+	}
 
 	return 0;
 }
@@ -3084,12 +3097,35 @@ static int smu_set_power_profile_mode(void *handle,
 				      uint32_t param_size)
 {
 	struct smu_context *smu = handle;
+	bool custom = false;
+	int ret = 0;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled ||
 	    !smu->ppt_funcs->set_power_profile_mode)
 		return -EOPNOTSUPP;
 
-	return smu_bump_power_profile_mode(smu, param, param_size);
+	if (param[param_size] == PP_SMC_POWER_PROFILE_CUSTOM) {
+		custom = true;
+		/* clear frontend mask so custom changes propogate */
+		smu->workload_mask = 0;
+	}
+
+	if ((param[param_size] != smu->power_profile_mode) || custom) {
+		/* clear the old user preference */
+		smu_power_profile_mode_put(smu, smu->power_profile_mode);
+		/* set the new user preference */
+		smu_power_profile_mode_get(smu, param[param_size]);
+		ret = smu_bump_power_profile_mode(smu,
+						  custom ? param : NULL,
+						  custom ? param_size : 0);
+		if (ret)
+			smu_power_profile_mode_put(smu, param[param_size]);
+		else
+			/* store the user's preference */
+			smu->power_profile_mode = param[param_size];
+	}
+
+	return ret;
 }
 
 static int smu_get_fan_control_mode(void *handle, u32 *fan_mode)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index d407777d6711..3630593bce61 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -556,11 +556,13 @@ struct smu_context {
 	uint32_t hard_min_uclk_req_from_dal;
 	bool disable_uclk_switch;
 
+	/* asic agnostic workload mask */
 	uint32_t workload_mask;
-	uint32_t workload_prority[WORKLOAD_POLICY_MAX];
-	uint32_t workload_setting[WORKLOAD_POLICY_MAX];
+	/* default/user workload preference */
 	uint32_t power_profile_mode;
-	uint32_t default_power_profile_mode;
+	uint32_t workload_refcount[PP_SMC_POWER_PROFILE_COUNT];
+	/* backend specific custom workload settings */
+	long *custom_profile_params;
 	bool pm_enabled;
 	bool is_apu;
 
@@ -731,9 +733,12 @@ struct pptable_funcs {
 	 * @set_power_profile_mode: Set a power profile mode. Also used to
 	 *                          create/set custom power profile modes.
 	 * &input: Power profile mode parameters.
-	 * &size: Size of &input.
+	 * &workload_mask: mask of workloads to enable
+	 * &custom_params: custom profile parameters
+	 * &custom_params_max_idx: max valid idx into custom_params
 	 */
-	int (*set_power_profile_mode)(struct smu_context *smu, long *input, uint32_t size);
+	int (*set_power_profile_mode)(struct smu_context *smu, u32 workload_mask,
+				      long *custom_params, u32 custom_params_max_idx);
 
 	/**
 	 * @dpm_set_vcn_enable: Enable/disable VCN engine dynamic power
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index a15754b1989f..8aa61a9f7778 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -1445,98 +1445,120 @@ static int arcturus_get_power_profile_mode(struct smu_context *smu,
 	return size;
 }
 
-static int arcturus_set_power_profile_mode(struct smu_context *smu,
-					   long *input,
-					   uint32_t size)
+#define ARCTURUS_CUSTOM_PARAMS_COUNT 10
+#define ARCTURUS_CUSTOM_PARAMS_CLOCK_COUNT 2
+#define ARCTURUS_CUSTOM_PARAMS_SIZE (ARCTURUS_CUSTOM_PARAMS_CLOCK_COUNT * ARCTURUS_CUSTOM_PARAMS_COUNT * sizeof(long))
+
+static int arcturus_set_power_profile_mode_coeff(struct smu_context *smu,
+						 long *input)
 {
 	DpmActivityMonitorCoeffInt_t activity_monitor;
-	int workload_type = 0;
-	uint32_t profile_mode = input[size];
-	int ret = 0;
+	int ret, idx;
 
-	if (profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
-		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", profile_mode);
-		return -EINVAL;
+	ret = smu_cmn_update_table(smu,
+				   SMU_TABLE_ACTIVITY_MONITOR_COEFF,
+				   WORKLOAD_PPLIB_CUSTOM_BIT,
+				   (void *)(&activity_monitor),
+				   false);
+	if (ret) {
+		dev_err(smu->adev->dev, "[%s] Failed to get activity monitor!", __func__);
+		return ret;
 	}
 
+	idx = 0 * ARCTURUS_CUSTOM_PARAMS_COUNT;
+	if (input[idx]) {
+		/* Gfxclk */
+		activity_monitor.Gfx_FPS = input[idx + 1];
+		activity_monitor.Gfx_UseRlcBusy = input[idx + 2];
+		activity_monitor.Gfx_MinActiveFreqType = input[idx + 3];
+		activity_monitor.Gfx_MinActiveFreq = input[idx + 4];
+		activity_monitor.Gfx_BoosterFreqType = input[idx + 5];
+		activity_monitor.Gfx_BoosterFreq = input[idx + 6];
+		activity_monitor.Gfx_PD_Data_limit_c = input[idx + 7];
+		activity_monitor.Gfx_PD_Data_error_coeff = input[idx + 8];
+		activity_monitor.Gfx_PD_Data_error_rate_coeff = input[idx + 9];
+	}
+	idx = 1 * ARCTURUS_CUSTOM_PARAMS_COUNT;
+	if (input[idx]) {
+		/* Uclk */
+		activity_monitor.Mem_FPS = input[idx + 1];
+		activity_monitor.Mem_UseRlcBusy = input[idx + 2];
+		activity_monitor.Mem_MinActiveFreqType = input[idx + 3];
+		activity_monitor.Mem_MinActiveFreq = input[idx + 4];
+		activity_monitor.Mem_BoosterFreqType = input[idx + 5];
+		activity_monitor.Mem_BoosterFreq = input[idx + 6];
+		activity_monitor.Mem_PD_Data_limit_c = input[idx + 7];
+		activity_monitor.Mem_PD_Data_error_coeff = input[idx + 8];
+		activity_monitor.Mem_PD_Data_error_rate_coeff = input[idx + 9];
+	}
 
-	if ((profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) &&
-	     (smu->smc_fw_version >= 0x360d00)) {
-		if (size != 10)
-			return -EINVAL;
+	ret = smu_cmn_update_table(smu,
+				   SMU_TABLE_ACTIVITY_MONITOR_COEFF,
+				   WORKLOAD_PPLIB_CUSTOM_BIT,
+				   (void *)(&activity_monitor),
+				   true);
+	if (ret) {
+		dev_err(smu->adev->dev, "[%s] Failed to set activity monitor!", __func__);
+		return ret;
+	}
 
-		ret = smu_cmn_update_table(smu,
-				       SMU_TABLE_ACTIVITY_MONITOR_COEFF,
-				       WORKLOAD_PPLIB_CUSTOM_BIT,
-				       (void *)(&activity_monitor),
-				       false);
-		if (ret) {
-			dev_err(smu->adev->dev, "[%s] Failed to get activity monitor!", __func__);
-			return ret;
-		}
+	return ret;
+}
 
-		switch (input[0]) {
-		case 0: /* Gfxclk */
-			activity_monitor.Gfx_FPS = input[1];
-			activity_monitor.Gfx_UseRlcBusy = input[2];
-			activity_monitor.Gfx_MinActiveFreqType = input[3];
-			activity_monitor.Gfx_MinActiveFreq = input[4];
-			activity_monitor.Gfx_BoosterFreqType = input[5];
-			activity_monitor.Gfx_BoosterFreq = input[6];
-			activity_monitor.Gfx_PD_Data_limit_c = input[7];
-			activity_monitor.Gfx_PD_Data_error_coeff = input[8];
-			activity_monitor.Gfx_PD_Data_error_rate_coeff = input[9];
-			break;
-		case 1: /* Uclk */
-			activity_monitor.Mem_FPS = input[1];
-			activity_monitor.Mem_UseRlcBusy = input[2];
-			activity_monitor.Mem_MinActiveFreqType = input[3];
-			activity_monitor.Mem_MinActiveFreq = input[4];
-			activity_monitor.Mem_BoosterFreqType = input[5];
-			activity_monitor.Mem_BoosterFreq = input[6];
-			activity_monitor.Mem_PD_Data_limit_c = input[7];
-			activity_monitor.Mem_PD_Data_error_coeff = input[8];
-			activity_monitor.Mem_PD_Data_error_rate_coeff = input[9];
-			break;
-		default:
+static int arcturus_set_power_profile_mode(struct smu_context *smu,
+					   u32 workload_mask,
+					   long *custom_params,
+					   u32 custom_params_max_idx)
+{
+	u32 backend_workload_mask = 0;
+	int ret, idx = -1, i;
+
+	smu_cmn_get_backend_workload_mask(smu, workload_mask,
+					  &backend_workload_mask);
+
+	if (workload_mask & (1 << PP_SMC_POWER_PROFILE_CUSTOM)) {
+		if (smu->smc_fw_version < 0x360d00)
 			return -EINVAL;
+		if (!smu->custom_profile_params) {
+			smu->custom_profile_params =
+				kzalloc(ARCTURUS_CUSTOM_PARAMS_SIZE, GFP_KERNEL);
+			if (!smu->custom_profile_params)
+				return -ENOMEM;
 		}
-
-		ret = smu_cmn_update_table(smu,
-				       SMU_TABLE_ACTIVITY_MONITOR_COEFF,
-				       WORKLOAD_PPLIB_CUSTOM_BIT,
-				       (void *)(&activity_monitor),
-				       true);
+		if (custom_params && custom_params_max_idx) {
+			if (custom_params_max_idx != ARCTURUS_CUSTOM_PARAMS_COUNT)
+				return -EINVAL;
+			if (custom_params[0] >= ARCTURUS_CUSTOM_PARAMS_CLOCK_COUNT)
+				return -EINVAL;
+			idx = custom_params[0] * ARCTURUS_CUSTOM_PARAMS_COUNT;
+			smu->custom_profile_params[idx] = 1;
+			for (i = 1; i < custom_params_max_idx; i++)
+				smu->custom_profile_params[idx + i] = custom_params[i];
+		}
+		ret = arcturus_set_power_profile_mode_coeff(smu,
+							    smu->custom_profile_params);
 		if (ret) {
-			dev_err(smu->adev->dev, "[%s] Failed to set activity monitor!", __func__);
+			if (idx != -1)
+				smu->custom_profile_params[idx] = 0;
 			return ret;
 		}
-	}
-
-	/*
-	 * Conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT
-	 * Not all profile modes are supported on arcturus.
-	 */
-	workload_type = smu_cmn_to_asic_specific_index(smu,
-						       CMN2ASIC_MAPPING_WORKLOAD,
-						       profile_mode);
-	if (workload_type < 0) {
-		dev_dbg(smu->adev->dev, "Unsupported power profile mode %d on arcturus\n", profile_mode);
-		return -EINVAL;
+	} else if (smu->custom_profile_params) {
+		memset(smu->custom_profile_params, 0, ARCTURUS_CUSTOM_PARAMS_SIZE);
 	}
 
 	ret = smu_cmn_send_smc_msg_with_param(smu,
-					  SMU_MSG_SetWorkloadMask,
-					  1 << workload_type,
-					  NULL);
+					      SMU_MSG_SetWorkloadMask,
+					      backend_workload_mask,
+					      NULL);
 	if (ret) {
-		dev_err(smu->adev->dev, "Fail to set workload type %d\n", workload_type);
+		dev_err(smu->adev->dev, "Failed to set workload mask 0x%08x\n",
+			workload_mask);
+		if (idx != -1)
+			smu->custom_profile_params[idx] = 0;
 		return ret;
 	}
 
-	smu->power_profile_mode = profile_mode;
-
-	return 0;
+	return ret;
 }
 
 static int arcturus_set_performance_level(struct smu_context *smu,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index faa8e7d9c3c6..7fad5dfb39c4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2006,87 +2006,122 @@ static int navi10_get_power_profile_mode(struct smu_context *smu, char *buf)
 	return size;
 }
 
-static int navi10_set_power_profile_mode(struct smu_context *smu, long *input, uint32_t size)
+#define NAVI10_CUSTOM_PARAMS_COUNT 10
+#define NAVI10_CUSTOM_PARAMS_CLOCKS_COUNT 3
+#define NAVI10_CUSTOM_PARAMS_SIZE (NAVI10_CUSTOM_PARAMS_CLOCKS_COUNT * NAVI10_CUSTOM_PARAMS_COUNT * sizeof(long))
+
+static int navi10_set_power_profile_mode_coeff(struct smu_context *smu,
+					       long *input)
 {
 	DpmActivityMonitorCoeffInt_t activity_monitor;
-	int workload_type, ret = 0;
+	int ret, idx;
 
-	smu->power_profile_mode = input[size];
+	ret = smu_cmn_update_table(smu,
+				   SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORKLOAD_PPLIB_CUSTOM_BIT,
+				   (void *)(&activity_monitor), false);
+	if (ret) {
+		dev_err(smu->adev->dev, "[%s] Failed to get activity monitor!", __func__);
+		return ret;
+	}
 
-	if (smu->power_profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
-		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", smu->power_profile_mode);
-		return -EINVAL;
+	idx = 0 * NAVI10_CUSTOM_PARAMS_COUNT;
+	if (input[idx]) {
+		/* Gfxclk */
+		activity_monitor.Gfx_FPS = input[idx + 1];
+		activity_monitor.Gfx_MinFreqStep = input[idx + 2];
+		activity_monitor.Gfx_MinActiveFreqType = input[idx + 3];
+		activity_monitor.Gfx_MinActiveFreq = input[idx + 4];
+		activity_monitor.Gfx_BoosterFreqType = input[idx + 5];
+		activity_monitor.Gfx_BoosterFreq = input[idx + 6];
+		activity_monitor.Gfx_PD_Data_limit_c = input[idx + 7];
+		activity_monitor.Gfx_PD_Data_error_coeff = input[idx + 8];
+		activity_monitor.Gfx_PD_Data_error_rate_coeff = input[idx + 9];
+	}
+	idx = 1 * NAVI10_CUSTOM_PARAMS_COUNT;
+	if (input[idx]) {
+		/* Socclk */
+		activity_monitor.Soc_FPS = input[idx + 1];
+		activity_monitor.Soc_MinFreqStep = input[idx + 2];
+		activity_monitor.Soc_MinActiveFreqType = input[idx + 3];
+		activity_monitor.Soc_MinActiveFreq = input[idx + 4];
+		activity_monitor.Soc_BoosterFreqType = input[idx + 5];
+		activity_monitor.Soc_BoosterFreq = input[idx + 6];
+		activity_monitor.Soc_PD_Data_limit_c = input[idx + 7];
+		activity_monitor.Soc_PD_Data_error_coeff = input[idx + 8];
+		activity_monitor.Soc_PD_Data_error_rate_coeff = input[idx + 9];
+	}
+	idx = 2 * NAVI10_CUSTOM_PARAMS_COUNT;
+	if (input[idx]) {
+		/* Memclk */
+		activity_monitor.Mem_FPS = input[idx + 1];
+		activity_monitor.Mem_MinFreqStep = input[idx + 2];
+		activity_monitor.Mem_MinActiveFreqType = input[idx + 3];
+		activity_monitor.Mem_MinActiveFreq = input[idx + 4];
+		activity_monitor.Mem_BoosterFreqType = input[idx + 5];
+		activity_monitor.Mem_BoosterFreq = input[idx + 6];
+		activity_monitor.Mem_PD_Data_limit_c = input[idx + 7];
+		activity_monitor.Mem_PD_Data_error_coeff = input[idx + 8];
+		activity_monitor.Mem_PD_Data_error_rate_coeff = input[idx + 9];
+	}
+
+	ret = smu_cmn_update_table(smu,
+				   SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORKLOAD_PPLIB_CUSTOM_BIT,
+				   (void *)(&activity_monitor), true);
+	if (ret) {
+		dev_err(smu->adev->dev, "[%s] Failed to set activity monitor!", __func__);
+		return ret;
 	}
 
-	if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
-		if (size != 10)
-			return -EINVAL;
+	return ret;
+}
 
-		ret = smu_cmn_update_table(smu,
-				       SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORKLOAD_PPLIB_CUSTOM_BIT,
-				       (void *)(&activity_monitor), false);
-		if (ret) {
-			dev_err(smu->adev->dev, "[%s] Failed to get activity monitor!", __func__);
-			return ret;
-		}
+static int navi10_set_power_profile_mode(struct smu_context *smu,
+					 u32 workload_mask,
+					 long *custom_params,
+					 u32 custom_params_max_idx)
+{
+	u32 backend_workload_mask = 0;
+	int ret, idx = -1, i;
 
-		switch (input[0]) {
-		case 0: /* Gfxclk */
-			activity_monitor.Gfx_FPS = input[1];
-			activity_monitor.Gfx_MinFreqStep = input[2];
-			activity_monitor.Gfx_MinActiveFreqType = input[3];
-			activity_monitor.Gfx_MinActiveFreq = input[4];
-			activity_monitor.Gfx_BoosterFreqType = input[5];
-			activity_monitor.Gfx_BoosterFreq = input[6];
-			activity_monitor.Gfx_PD_Data_limit_c = input[7];
-			activity_monitor.Gfx_PD_Data_error_coeff = input[8];
-			activity_monitor.Gfx_PD_Data_error_rate_coeff = input[9];
-			break;
-		case 1: /* Socclk */
-			activity_monitor.Soc_FPS = input[1];
-			activity_monitor.Soc_MinFreqStep = input[2];
-			activity_monitor.Soc_MinActiveFreqType = input[3];
-			activity_monitor.Soc_MinActiveFreq = input[4];
-			activity_monitor.Soc_BoosterFreqType = input[5];
-			activity_monitor.Soc_BoosterFreq = input[6];
-			activity_monitor.Soc_PD_Data_limit_c = input[7];
-			activity_monitor.Soc_PD_Data_error_coeff = input[8];
-			activity_monitor.Soc_PD_Data_error_rate_coeff = input[9];
-			break;
-		case 2: /* Memclk */
-			activity_monitor.Mem_FPS = input[1];
-			activity_monitor.Mem_MinFreqStep = input[2];
-			activity_monitor.Mem_MinActiveFreqType = input[3];
-			activity_monitor.Mem_MinActiveFreq = input[4];
-			activity_monitor.Mem_BoosterFreqType = input[5];
-			activity_monitor.Mem_BoosterFreq = input[6];
-			activity_monitor.Mem_PD_Data_limit_c = input[7];
-			activity_monitor.Mem_PD_Data_error_coeff = input[8];
-			activity_monitor.Mem_PD_Data_error_rate_coeff = input[9];
-			break;
-		default:
-			return -EINVAL;
-		}
+	smu_cmn_get_backend_workload_mask(smu, workload_mask,
+					  &backend_workload_mask);
 
-		ret = smu_cmn_update_table(smu,
-				       SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORKLOAD_PPLIB_CUSTOM_BIT,
-				       (void *)(&activity_monitor), true);
+	if (workload_mask & (1 << PP_SMC_POWER_PROFILE_CUSTOM)) {
+		if (!smu->custom_profile_params) {
+			smu->custom_profile_params = kzalloc(NAVI10_CUSTOM_PARAMS_SIZE, GFP_KERNEL);
+			if (!smu->custom_profile_params)
+				return -ENOMEM;
+		}
+		if (custom_params && custom_params_max_idx) {
+			if (custom_params_max_idx != NAVI10_CUSTOM_PARAMS_COUNT)
+				return -EINVAL;
+			if (custom_params[0] >= NAVI10_CUSTOM_PARAMS_CLOCKS_COUNT)
+				return -EINVAL;
+			idx = custom_params[0] * NAVI10_CUSTOM_PARAMS_COUNT;
+			smu->custom_profile_params[idx] = 1;
+			for (i = 1; i < custom_params_max_idx; i++)
+				smu->custom_profile_params[idx + i] = custom_params[i];
+		}
+		ret = navi10_set_power_profile_mode_coeff(smu,
+							  smu->custom_profile_params);
 		if (ret) {
-			dev_err(smu->adev->dev, "[%s] Failed to set activity monitor!", __func__);
+			if (idx != -1)
+				smu->custom_profile_params[idx] = 0;
 			return ret;
 		}
+	} else if (smu->custom_profile_params) {
+		memset(smu->custom_profile_params, 0, NAVI10_CUSTOM_PARAMS_SIZE);
 	}
 
-	/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
-	workload_type = smu_cmn_to_asic_specific_index(smu,
-						       CMN2ASIC_MAPPING_WORKLOAD,
-						       smu->power_profile_mode);
-	if (workload_type < 0)
-		return -EINVAL;
 	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
-				    1 << workload_type, NULL);
-	if (ret)
-		dev_err(smu->adev->dev, "[%s] Failed to set work load mask!", __func__);
+					      backend_workload_mask, NULL);
+	if (ret) {
+		dev_err(smu->adev->dev, "Failed to set workload mask 0x%08x\n",
+			workload_mask);
+		if (idx != -1)
+			smu->custom_profile_params[idx] = 0;
+		return ret;
+	}
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 30d050a6e953..19a25fdc2f5b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -1704,90 +1704,126 @@ static int sienna_cichlid_get_power_profile_mode(struct smu_context *smu, char *
 	return size;
 }
 
-static int sienna_cichlid_set_power_profile_mode(struct smu_context *smu, long *input, uint32_t size)
+#define SIENNA_CICHLID_CUSTOM_PARAMS_COUNT 10
+#define SIENNA_CICHLID_CUSTOM_PARAMS_CLOCK_COUNT 3
+#define SIENNA_CICHLID_CUSTOM_PARAMS_SIZE (SIENNA_CICHLID_CUSTOM_PARAMS_CLOCK_COUNT * SIENNA_CICHLID_CUSTOM_PARAMS_COUNT * sizeof(long))
+
+static int sienna_cichlid_set_power_profile_mode_coeff(struct smu_context *smu,
+						       long *input)
 {
 
 	DpmActivityMonitorCoeffIntExternal_t activity_monitor_external;
 	DpmActivityMonitorCoeffInt_t *activity_monitor =
 		&(activity_monitor_external.DpmActivityMonitorCoeffInt);
-	int workload_type, ret = 0;
+	int ret, idx;
 
-	smu->power_profile_mode = input[size];
+	ret = smu_cmn_update_table(smu,
+				   SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORKLOAD_PPLIB_CUSTOM_BIT,
+				   (void *)(&activity_monitor_external), false);
+	if (ret) {
+		dev_err(smu->adev->dev, "[%s] Failed to get activity monitor!", __func__);
+		return ret;
+	}
 
-	if (smu->power_profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
-		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", smu->power_profile_mode);
-		return -EINVAL;
+	idx = 0 * SIENNA_CICHLID_CUSTOM_PARAMS_COUNT;
+	if (input[idx]) {
+		/* Gfxclk */
+		activity_monitor->Gfx_FPS = input[idx + 1];
+		activity_monitor->Gfx_MinFreqStep = input[idx + 2];
+		activity_monitor->Gfx_MinActiveFreqType = input[idx + 3];
+		activity_monitor->Gfx_MinActiveFreq = input[idx + 4];
+		activity_monitor->Gfx_BoosterFreqType = input[idx + 5];
+		activity_monitor->Gfx_BoosterFreq = input[idx + 6];
+		activity_monitor->Gfx_PD_Data_limit_c = input[idx + 7];
+		activity_monitor->Gfx_PD_Data_error_coeff = input[idx + 8];
+		activity_monitor->Gfx_PD_Data_error_rate_coeff = input[idx + 9];
+	}
+	idx = 1 * SIENNA_CICHLID_CUSTOM_PARAMS_COUNT;
+	if (input[idx]) {
+		/* Socclk */
+		activity_monitor->Fclk_FPS = input[idx + 1];
+		activity_monitor->Fclk_MinFreqStep = input[idx + 2];
+		activity_monitor->Fclk_MinActiveFreqType = input[idx + 3];
+		activity_monitor->Fclk_MinActiveFreq = input[idx + 4];
+		activity_monitor->Fclk_BoosterFreqType = input[idx + 5];
+		activity_monitor->Fclk_BoosterFreq = input[idx + 6];
+		activity_monitor->Fclk_PD_Data_limit_c = input[idx + 7];
+		activity_monitor->Fclk_PD_Data_error_coeff = input[idx + 8];
+		activity_monitor->Fclk_PD_Data_error_rate_coeff = input[idx + 9];
+	}
+	idx = 2 * SIENNA_CICHLID_CUSTOM_PARAMS_COUNT;
+	if (input[idx]) {
+		/* Memclk */
+		activity_monitor->Mem_FPS = input[idx + 1];
+		activity_monitor->Mem_MinFreqStep = input[idx + 2];
+		activity_monitor->Mem_MinActiveFreqType = input[idx + 3];
+		activity_monitor->Mem_MinActiveFreq = input[idx + 4];
+		activity_monitor->Mem_BoosterFreqType = input[idx + 5];
+		activity_monitor->Mem_BoosterFreq = input[idx + 6];
+		activity_monitor->Mem_PD_Data_limit_c = input[idx + 7];
+		activity_monitor->Mem_PD_Data_error_coeff = input[idx + 8];
+		activity_monitor->Mem_PD_Data_error_rate_coeff = input[idx + 9];
 	}
 
-	if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
-		if (size != 10)
-			return -EINVAL;
+	ret = smu_cmn_update_table(smu,
+				   SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORKLOAD_PPLIB_CUSTOM_BIT,
+				   (void *)(&activity_monitor_external), true);
+	if (ret) {
+		dev_err(smu->adev->dev, "[%s] Failed to set activity monitor!", __func__);
+		return ret;
+	}
 
-		ret = smu_cmn_update_table(smu,
-				       SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORKLOAD_PPLIB_CUSTOM_BIT,
-				       (void *)(&activity_monitor_external), false);
-		if (ret) {
-			dev_err(smu->adev->dev, "[%s] Failed to get activity monitor!", __func__);
-			return ret;
-		}
+	return ret;
+}
 
-		switch (input[0]) {
-		case 0: /* Gfxclk */
-			activity_monitor->Gfx_FPS = input[1];
-			activity_monitor->Gfx_MinFreqStep = input[2];
-			activity_monitor->Gfx_MinActiveFreqType = input[3];
-			activity_monitor->Gfx_MinActiveFreq = input[4];
-			activity_monitor->Gfx_BoosterFreqType = input[5];
-			activity_monitor->Gfx_BoosterFreq = input[6];
-			activity_monitor->Gfx_PD_Data_limit_c = input[7];
-			activity_monitor->Gfx_PD_Data_error_coeff = input[8];
-			activity_monitor->Gfx_PD_Data_error_rate_coeff = input[9];
-			break;
-		case 1: /* Socclk */
-			activity_monitor->Fclk_FPS = input[1];
-			activity_monitor->Fclk_MinFreqStep = input[2];
-			activity_monitor->Fclk_MinActiveFreqType = input[3];
-			activity_monitor->Fclk_MinActiveFreq = input[4];
-			activity_monitor->Fclk_BoosterFreqType = input[5];
-			activity_monitor->Fclk_BoosterFreq = input[6];
-			activity_monitor->Fclk_PD_Data_limit_c = input[7];
-			activity_monitor->Fclk_PD_Data_error_coeff = input[8];
-			activity_monitor->Fclk_PD_Data_error_rate_coeff = input[9];
-			break;
-		case 2: /* Memclk */
-			activity_monitor->Mem_FPS = input[1];
-			activity_monitor->Mem_MinFreqStep = input[2];
-			activity_monitor->Mem_MinActiveFreqType = input[3];
-			activity_monitor->Mem_MinActiveFreq = input[4];
-			activity_monitor->Mem_BoosterFreqType = input[5];
-			activity_monitor->Mem_BoosterFreq = input[6];
-			activity_monitor->Mem_PD_Data_limit_c = input[7];
-			activity_monitor->Mem_PD_Data_error_coeff = input[8];
-			activity_monitor->Mem_PD_Data_error_rate_coeff = input[9];
-			break;
-		default:
-			return -EINVAL;
-		}
+static int sienna_cichlid_set_power_profile_mode(struct smu_context *smu,
+						 u32 workload_mask,
+						 long *custom_params,
+						 u32 custom_params_max_idx)
+{
+	u32 backend_workload_mask = 0;
+	int ret, idx = -1, i;
 
-		ret = smu_cmn_update_table(smu,
-				       SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORKLOAD_PPLIB_CUSTOM_BIT,
-				       (void *)(&activity_monitor_external), true);
+	smu_cmn_get_backend_workload_mask(smu, workload_mask,
+					  &backend_workload_mask);
+
+	if (workload_mask & (1 << PP_SMC_POWER_PROFILE_CUSTOM)) {
+		if (!smu->custom_profile_params) {
+			smu->custom_profile_params =
+				kzalloc(SIENNA_CICHLID_CUSTOM_PARAMS_SIZE, GFP_KERNEL);
+			if (!smu->custom_profile_params)
+				return -ENOMEM;
+		}
+		if (custom_params && custom_params_max_idx) {
+			if (custom_params_max_idx != SIENNA_CICHLID_CUSTOM_PARAMS_COUNT)
+				return -EINVAL;
+			if (custom_params[0] >= SIENNA_CICHLID_CUSTOM_PARAMS_CLOCK_COUNT)
+				return -EINVAL;
+			idx = custom_params[0] * SIENNA_CICHLID_CUSTOM_PARAMS_COUNT;
+			smu->custom_profile_params[idx] = 1;
+			for (i = 1; i < custom_params_max_idx; i++)
+				smu->custom_profile_params[idx + i] = custom_params[i];
+		}
+		ret = sienna_cichlid_set_power_profile_mode_coeff(smu,
+								  smu->custom_profile_params);
 		if (ret) {
-			dev_err(smu->adev->dev, "[%s] Failed to set activity monitor!", __func__);
+			if (idx != -1)
+				smu->custom_profile_params[idx] = 0;
 			return ret;
 		}
+	} else if (smu->custom_profile_params) {
+		memset(smu->custom_profile_params, 0, SIENNA_CICHLID_CUSTOM_PARAMS_SIZE);
 	}
 
-	/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
-	workload_type = smu_cmn_to_asic_specific_index(smu,
-						       CMN2ASIC_MAPPING_WORKLOAD,
-						       smu->power_profile_mode);
-	if (workload_type < 0)
-		return -EINVAL;
 	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
-				    1 << workload_type, NULL);
-	if (ret)
-		dev_err(smu->adev->dev, "[%s] Failed to set work load mask!", __func__);
+					      backend_workload_mask, NULL);
+	if (ret) {
+		dev_err(smu->adev->dev, "Failed to set workload mask 0x%08x\n",
+			workload_mask);
+		if (idx != -1)
+			smu->custom_profile_params[idx] = 0;
+		return ret;
+	}
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index cd3e9ba3eff4..a55ea76d7399 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -1056,42 +1056,27 @@ static int vangogh_get_power_profile_mode(struct smu_context *smu,
 	return size;
 }
 
-static int vangogh_set_power_profile_mode(struct smu_context *smu, long *input, uint32_t size)
+static int vangogh_set_power_profile_mode(struct smu_context *smu,
+					  u32 workload_mask,
+					  long *custom_params,
+					  u32 custom_params_max_idx)
 {
-	int workload_type, ret;
-	uint32_t profile_mode = input[size];
+	u32 backend_workload_mask = 0;
+	int ret;
 
-	if (profile_mode >= PP_SMC_POWER_PROFILE_COUNT) {
-		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", profile_mode);
-		return -EINVAL;
-	}
-
-	if (profile_mode == PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT ||
-			profile_mode == PP_SMC_POWER_PROFILE_POWERSAVING)
-		return 0;
-
-	/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
-	workload_type = smu_cmn_to_asic_specific_index(smu,
-						       CMN2ASIC_MAPPING_WORKLOAD,
-						       profile_mode);
-	if (workload_type < 0) {
-		dev_dbg(smu->adev->dev, "Unsupported power profile mode %d on VANGOGH\n",
-					profile_mode);
-		return -EINVAL;
-	}
+	smu_cmn_get_backend_workload_mask(smu, workload_mask,
+					  &backend_workload_mask);
 
 	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_ActiveProcessNotify,
-				    1 << workload_type,
-				    NULL);
+					      backend_workload_mask,
+					      NULL);
 	if (ret) {
-		dev_err_once(smu->adev->dev, "Fail to set workload type %d\n",
-					workload_type);
+		dev_err_once(smu->adev->dev, "Fail to set workload mask 0x%08x\n",
+			     workload_mask);
 		return ret;
 	}
 
-	smu->power_profile_mode = profile_mode;
-
-	return 0;
+	return ret;
 }
 
 static int vangogh_set_soft_freq_limited_range(struct smu_context *smu,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
index a34797f3576b..37d82a71a2d7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
@@ -864,44 +864,27 @@ static int renoir_force_clk_levels(struct smu_context *smu,
 	return ret;
 }
 
-static int renoir_set_power_profile_mode(struct smu_context *smu, long *input, uint32_t size)
+static int renoir_set_power_profile_mode(struct smu_context *smu,
+					 u32 workload_mask,
+					 long *custom_params,
+					 u32 custom_params_max_idx)
 {
-	int workload_type, ret;
-	uint32_t profile_mode = input[size];
+	int ret;
+	u32 backend_workload_mask = 0;
 
-	if (profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
-		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", profile_mode);
-		return -EINVAL;
-	}
-
-	if (profile_mode == PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT ||
-			profile_mode == PP_SMC_POWER_PROFILE_POWERSAVING)
-		return 0;
-
-	/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
-	workload_type = smu_cmn_to_asic_specific_index(smu,
-						       CMN2ASIC_MAPPING_WORKLOAD,
-						       profile_mode);
-	if (workload_type < 0) {
-		/*
-		 * TODO: If some case need switch to powersave/default power mode
-		 * then can consider enter WORKLOAD_COMPUTE/WORKLOAD_CUSTOM for power saving.
-		 */
-		dev_dbg(smu->adev->dev, "Unsupported power profile mode %d on RENOIR\n", profile_mode);
-		return -EINVAL;
-	}
+	smu_cmn_get_backend_workload_mask(smu, workload_mask,
+					  &backend_workload_mask);
 
 	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_ActiveProcessNotify,
-				    1 << workload_type,
-				    NULL);
+					      backend_workload_mask,
+					      NULL);
 	if (ret) {
-		dev_err_once(smu->adev->dev, "Fail to set workload type %d\n", workload_type);
+		dev_err_once(smu->adev->dev, "Failed to set workload mask 0x08%x\n",
+			     workload_mask);
 		return ret;
 	}
 
-	smu->power_profile_mode = profile_mode;
-
-	return 0;
+	return ret;
 }
 
 static int renoir_set_peak_clock_by_device(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 199bdd9720d3..3aa705aae4c0 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -2571,82 +2571,76 @@ static int smu_v13_0_0_get_power_profile_mode(struct smu_context *smu,
 	return size;
 }
 
-static int smu_v13_0_0_set_power_profile_mode(struct smu_context *smu,
-					      long *input,
-					      uint32_t size)
+#define SMU_13_0_0_CUSTOM_PARAMS_COUNT 9
+#define SMU_13_0_0_CUSTOM_PARAMS_CLOCK_COUNT 2
+#define SMU_13_0_0_CUSTOM_PARAMS_SIZE (SMU_13_0_0_CUSTOM_PARAMS_CLOCK_COUNT * SMU_13_0_0_CUSTOM_PARAMS_COUNT * sizeof(long))
+
+static int smu_v13_0_0_set_power_profile_mode_coeff(struct smu_context *smu,
+						    long *input)
 {
 	DpmActivityMonitorCoeffIntExternal_t activity_monitor_external;
 	DpmActivityMonitorCoeffInt_t *activity_monitor =
 		&(activity_monitor_external.DpmActivityMonitorCoeffInt);
-	int workload_type, ret = 0;
-	u32 workload_mask, selected_workload_mask;
-
-	smu->power_profile_mode = input[size];
+	int ret, idx;
 
-	if (smu->power_profile_mode >= PP_SMC_POWER_PROFILE_COUNT) {
-		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", smu->power_profile_mode);
-		return -EINVAL;
+	ret = smu_cmn_update_table(smu,
+				   SMU_TABLE_ACTIVITY_MONITOR_COEFF,
+				   WORKLOAD_PPLIB_CUSTOM_BIT,
+				   (void *)(&activity_monitor_external),
+				   false);
+	if (ret) {
+		dev_err(smu->adev->dev, "[%s] Failed to get activity monitor!", __func__);
+		return ret;
 	}
 
-	if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
-		if (size != 9)
-			return -EINVAL;
-
-		ret = smu_cmn_update_table(smu,
-					   SMU_TABLE_ACTIVITY_MONITOR_COEFF,
-					   WORKLOAD_PPLIB_CUSTOM_BIT,
-					   (void *)(&activity_monitor_external),
-					   false);
-		if (ret) {
-			dev_err(smu->adev->dev, "[%s] Failed to get activity monitor!", __func__);
-			return ret;
-		}
-
-		switch (input[0]) {
-		case 0: /* Gfxclk */
-			activity_monitor->Gfx_FPS = input[1];
-			activity_monitor->Gfx_MinActiveFreqType = input[2];
-			activity_monitor->Gfx_MinActiveFreq = input[3];
-			activity_monitor->Gfx_BoosterFreqType = input[4];
-			activity_monitor->Gfx_BoosterFreq = input[5];
-			activity_monitor->Gfx_PD_Data_limit_c = input[6];
-			activity_monitor->Gfx_PD_Data_error_coeff = input[7];
-			activity_monitor->Gfx_PD_Data_error_rate_coeff = input[8];
-			break;
-		case 1: /* Fclk */
-			activity_monitor->Fclk_FPS = input[1];
-			activity_monitor->Fclk_MinActiveFreqType = input[2];
-			activity_monitor->Fclk_MinActiveFreq = input[3];
-			activity_monitor->Fclk_BoosterFreqType = input[4];
-			activity_monitor->Fclk_BoosterFreq = input[5];
-			activity_monitor->Fclk_PD_Data_limit_c = input[6];
-			activity_monitor->Fclk_PD_Data_error_coeff = input[7];
-			activity_monitor->Fclk_PD_Data_error_rate_coeff = input[8];
-			break;
-		default:
-			return -EINVAL;
-		}
+	idx = 0 * SMU_13_0_0_CUSTOM_PARAMS_COUNT;
+	if (input[idx]) {
+		/* Gfxclk */
+		activity_monitor->Gfx_FPS = input[idx + 1];
+		activity_monitor->Gfx_MinActiveFreqType = input[idx + 2];
+		activity_monitor->Gfx_MinActiveFreq = input[idx + 3];
+		activity_monitor->Gfx_BoosterFreqType = input[idx + 4];
+		activity_monitor->Gfx_BoosterFreq = input[idx + 5];
+		activity_monitor->Gfx_PD_Data_limit_c = input[idx + 6];
+		activity_monitor->Gfx_PD_Data_error_coeff = input[idx + 7];
+		activity_monitor->Gfx_PD_Data_error_rate_coeff = input[idx + 8];
+	}
+	idx = 1 * SMU_13_0_0_CUSTOM_PARAMS_COUNT;
+	if (input[idx]) {
+		/* Fclk */
+		activity_monitor->Fclk_FPS = input[idx + 1];
+		activity_monitor->Fclk_MinActiveFreqType = input[idx + 2];
+		activity_monitor->Fclk_MinActiveFreq = input[idx + 3];
+		activity_monitor->Fclk_BoosterFreqType = input[idx + 4];
+		activity_monitor->Fclk_BoosterFreq = input[idx + 5];
+		activity_monitor->Fclk_PD_Data_limit_c = input[idx + 6];
+		activity_monitor->Fclk_PD_Data_error_coeff = input[idx + 7];
+		activity_monitor->Fclk_PD_Data_error_rate_coeff = input[idx + 8];
+	}
 
-		ret = smu_cmn_update_table(smu,
-					   SMU_TABLE_ACTIVITY_MONITOR_COEFF,
-					   WORKLOAD_PPLIB_CUSTOM_BIT,
-					   (void *)(&activity_monitor_external),
-					   true);
-		if (ret) {
-			dev_err(smu->adev->dev, "[%s] Failed to set activity monitor!", __func__);
-			return ret;
-		}
+	ret = smu_cmn_update_table(smu,
+				   SMU_TABLE_ACTIVITY_MONITOR_COEFF,
+				   WORKLOAD_PPLIB_CUSTOM_BIT,
+				   (void *)(&activity_monitor_external),
+				   true);
+	if (ret) {
+		dev_err(smu->adev->dev, "[%s] Failed to set activity monitor!", __func__);
+		return ret;
 	}
 
-	/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
-	workload_type = smu_cmn_to_asic_specific_index(smu,
-						       CMN2ASIC_MAPPING_WORKLOAD,
-						       smu->power_profile_mode);
+	return ret;
+}
 
-	if (workload_type < 0)
-		return -EINVAL;
+static int smu_v13_0_0_set_power_profile_mode(struct smu_context *smu,
+					      u32 workload_mask,
+					      long *custom_params,
+					      u32 custom_params_max_idx)
+{
+	u32 backend_workload_mask = 0;
+	int workload_type, ret, idx = -1, i;
 
-	selected_workload_mask = workload_mask = 1 << workload_type;
+	smu_cmn_get_backend_workload_mask(smu, workload_mask,
+					  &backend_workload_mask);
 
 	/* Add optimizations for SMU13.0.0/10.  Reuse the power saving profile */
 	if ((amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 0) &&
@@ -2658,15 +2652,48 @@ static int smu_v13_0_0_set_power_profile_mode(struct smu_context *smu,
 							       CMN2ASIC_MAPPING_WORKLOAD,
 							       PP_SMC_POWER_PROFILE_POWERSAVING);
 		if (workload_type >= 0)
-			workload_mask |= 1 << workload_type;
+			backend_workload_mask |= 1 << workload_type;
+	}
+
+	if (workload_mask & (1 << PP_SMC_POWER_PROFILE_CUSTOM)) {
+		if (!smu->custom_profile_params) {
+			smu->custom_profile_params =
+				kzalloc(SMU_13_0_0_CUSTOM_PARAMS_SIZE, GFP_KERNEL);
+			if (!smu->custom_profile_params)
+				return -ENOMEM;
+		}
+		if (custom_params && custom_params_max_idx) {
+			if (custom_params_max_idx != SMU_13_0_0_CUSTOM_PARAMS_COUNT)
+				return -EINVAL;
+			if (custom_params[0] >= SMU_13_0_0_CUSTOM_PARAMS_CLOCK_COUNT)
+				return -EINVAL;
+			idx = custom_params[0] * SMU_13_0_0_CUSTOM_PARAMS_COUNT;
+			smu->custom_profile_params[idx] = 1;
+			for (i = 1; i < custom_params_max_idx; i++)
+				smu->custom_profile_params[idx + i] = custom_params[i];
+		}
+		ret = smu_v13_0_0_set_power_profile_mode_coeff(smu,
+							       smu->custom_profile_params);
+		if (ret) {
+			if (idx != -1)
+				smu->custom_profile_params[idx] = 0;
+			return ret;
+		}
+	} else if (smu->custom_profile_params) {
+		memset(smu->custom_profile_params, 0, SMU_13_0_0_CUSTOM_PARAMS_SIZE);
 	}
 
 	ret = smu_cmn_send_smc_msg_with_param(smu,
-					       SMU_MSG_SetWorkloadMask,
-					       workload_mask,
-					       NULL);
-	if (!ret)
-		smu->workload_mask = selected_workload_mask;
+					      SMU_MSG_SetWorkloadMask,
+					      backend_workload_mask,
+					      NULL);
+	if (ret) {
+		dev_err(smu->adev->dev, "Failed to set workload mask 0x%08x\n",
+			workload_mask);
+		if (idx != -1)
+			smu->custom_profile_params[idx] = 0;
+		return ret;
+	}
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 34c1e0c7e1e4..f4ac403b8b36 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -2530,78 +2530,110 @@ do {													\
 	return result;
 }
 
-static int smu_v13_0_7_set_power_profile_mode(struct smu_context *smu, long *input, uint32_t size)
+#define SMU_13_0_7_CUSTOM_PARAMS_COUNT 8
+#define SMU_13_0_7_CUSTOM_PARAMS_CLOCK_COUNT 2
+#define SMU_13_0_7_CUSTOM_PARAMS_SIZE (SMU_13_0_7_CUSTOM_PARAMS_CLOCK_COUNT * SMU_13_0_7_CUSTOM_PARAMS_COUNT * sizeof(long))
+
+static int smu_v13_0_7_set_power_profile_mode_coeff(struct smu_context *smu,
+						    long *input)
 {
 
 	DpmActivityMonitorCoeffIntExternal_t activity_monitor_external;
 	DpmActivityMonitorCoeffInt_t *activity_monitor =
 		&(activity_monitor_external.DpmActivityMonitorCoeffInt);
-	int workload_type, ret = 0;
+	int ret, idx;
 
-	smu->power_profile_mode = input[size];
+	ret = smu_cmn_update_table(smu,
+				   SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORKLOAD_PPLIB_CUSTOM_BIT,
+				   (void *)(&activity_monitor_external), false);
+	if (ret) {
+		dev_err(smu->adev->dev, "[%s] Failed to get activity monitor!", __func__);
+		return ret;
+	}
 
-	if (smu->power_profile_mode > PP_SMC_POWER_PROFILE_WINDOW3D) {
-		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", smu->power_profile_mode);
-		return -EINVAL;
+	idx = 0 * SMU_13_0_7_CUSTOM_PARAMS_COUNT;
+	if (input[idx]) {
+		/* Gfxclk */
+		activity_monitor->Gfx_ActiveHystLimit = input[idx + 1];
+		activity_monitor->Gfx_IdleHystLimit = input[idx + 2];
+		activity_monitor->Gfx_FPS = input[idx + 3];
+		activity_monitor->Gfx_MinActiveFreqType = input[idx + 4];
+		activity_monitor->Gfx_BoosterFreqType = input[idx + 5];
+		activity_monitor->Gfx_MinActiveFreq = input[idx + 6];
+		activity_monitor->Gfx_BoosterFreq = input[idx + 7];
+	}
+	idx = 1 * SMU_13_0_7_CUSTOM_PARAMS_COUNT;
+	if (input[idx]) {
+		/* Fclk */
+		activity_monitor->Fclk_ActiveHystLimit = input[idx + 1];
+		activity_monitor->Fclk_IdleHystLimit = input[idx + 2];
+		activity_monitor->Fclk_FPS = input[idx + 3];
+		activity_monitor->Fclk_MinActiveFreqType = input[idx + 4];
+		activity_monitor->Fclk_BoosterFreqType = input[idx + 5];
+		activity_monitor->Fclk_MinActiveFreq = input[idx + 6];
+		activity_monitor->Fclk_BoosterFreq = input[idx + 7];
 	}
 
-	if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
-		if (size != 8)
-			return -EINVAL;
+	ret = smu_cmn_update_table(smu,
+				   SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORKLOAD_PPLIB_CUSTOM_BIT,
+				   (void *)(&activity_monitor_external), true);
+	if (ret) {
+		dev_err(smu->adev->dev, "[%s] Failed to set activity monitor!", __func__);
+		return ret;
+	}
 
-		ret = smu_cmn_update_table(smu,
-				       SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORKLOAD_PPLIB_CUSTOM_BIT,
-				       (void *)(&activity_monitor_external), false);
-		if (ret) {
-			dev_err(smu->adev->dev, "[%s] Failed to get activity monitor!", __func__);
-			return ret;
-		}
+	return ret;
+}
 
-		switch (input[0]) {
-		case 0: /* Gfxclk */
-			activity_monitor->Gfx_ActiveHystLimit = input[1];
-			activity_monitor->Gfx_IdleHystLimit = input[2];
-			activity_monitor->Gfx_FPS = input[3];
-			activity_monitor->Gfx_MinActiveFreqType = input[4];
-			activity_monitor->Gfx_BoosterFreqType = input[5];
-			activity_monitor->Gfx_MinActiveFreq = input[6];
-			activity_monitor->Gfx_BoosterFreq = input[7];
-			break;
-		case 1: /* Fclk */
-			activity_monitor->Fclk_ActiveHystLimit = input[1];
-			activity_monitor->Fclk_IdleHystLimit = input[2];
-			activity_monitor->Fclk_FPS = input[3];
-			activity_monitor->Fclk_MinActiveFreqType = input[4];
-			activity_monitor->Fclk_BoosterFreqType = input[5];
-			activity_monitor->Fclk_MinActiveFreq = input[6];
-			activity_monitor->Fclk_BoosterFreq = input[7];
-			break;
-		default:
-			return -EINVAL;
+static int smu_v13_0_7_set_power_profile_mode(struct smu_context *smu,
+					      u32 workload_mask,
+					      long *custom_params,
+					      u32 custom_params_max_idx)
+{
+	u32 backend_workload_mask = 0;
+	int ret, idx = -1, i;
+
+	smu_cmn_get_backend_workload_mask(smu, workload_mask,
+					  &backend_workload_mask);
+
+	if (workload_mask & (1 << PP_SMC_POWER_PROFILE_CUSTOM)) {
+		if (!smu->custom_profile_params) {
+			smu->custom_profile_params =
+				kzalloc(SMU_13_0_7_CUSTOM_PARAMS_SIZE, GFP_KERNEL);
+			if (!smu->custom_profile_params)
+				return -ENOMEM;
 		}
-
-		ret = smu_cmn_update_table(smu,
-				       SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORKLOAD_PPLIB_CUSTOM_BIT,
-				       (void *)(&activity_monitor_external), true);
+		if (custom_params && custom_params_max_idx) {
+			if (custom_params_max_idx != SMU_13_0_7_CUSTOM_PARAMS_COUNT)
+				return -EINVAL;
+			if (custom_params[0] >= SMU_13_0_7_CUSTOM_PARAMS_CLOCK_COUNT)
+				return -EINVAL;
+			idx = custom_params[0] * SMU_13_0_7_CUSTOM_PARAMS_COUNT;
+			smu->custom_profile_params[idx] = 1;
+			for (i = 1; i < custom_params_max_idx; i++)
+				smu->custom_profile_params[idx + i] = custom_params[i];
+		}
+		ret = smu_v13_0_7_set_power_profile_mode_coeff(smu,
+							       smu->custom_profile_params);
 		if (ret) {
-			dev_err(smu->adev->dev, "[%s] Failed to set activity monitor!", __func__);
+			if (idx != -1)
+				smu->custom_profile_params[idx] = 0;
 			return ret;
 		}
+	} else if (smu->custom_profile_params) {
+		memset(smu->custom_profile_params, 0, SMU_13_0_7_CUSTOM_PARAMS_SIZE);
 	}
 
-	/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
-	workload_type = smu_cmn_to_asic_specific_index(smu,
-						       CMN2ASIC_MAPPING_WORKLOAD,
-						       smu->power_profile_mode);
-	if (workload_type < 0)
-		return -EINVAL;
 	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
-				    1 << workload_type, NULL);
+					      backend_workload_mask, NULL);
 
-	if (ret)
-		dev_err(smu->adev->dev, "[%s] Failed to set work load mask!", __func__);
-	else
-		smu->workload_mask = (1 << workload_type);
+	if (ret) {
+		dev_err(smu->adev->dev, "Failed to set workload mask 0x%08x\n",
+			workload_mask);
+		if (idx != -1)
+			smu->custom_profile_params[idx] = 0;
+		return ret;
+	}
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index 98e01a06add8..6a565ce74d5b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -1739,90 +1739,120 @@ static int smu_v14_0_2_get_power_profile_mode(struct smu_context *smu,
 	return size;
 }
 
-static int smu_v14_0_2_set_power_profile_mode(struct smu_context *smu,
-					      long *input,
-					      uint32_t size)
+#define SMU_14_0_2_CUSTOM_PARAMS_COUNT 9
+#define SMU_14_0_2_CUSTOM_PARAMS_CLOCK_COUNT 2
+#define SMU_14_0_2_CUSTOM_PARAMS_SIZE (SMU_14_0_2_CUSTOM_PARAMS_CLOCK_COUNT * SMU_14_0_2_CUSTOM_PARAMS_COUNT * sizeof(long))
+
+static int smu_v14_0_2_set_power_profile_mode_coeff(struct smu_context *smu,
+						    long *input)
 {
 	DpmActivityMonitorCoeffIntExternal_t activity_monitor_external;
 	DpmActivityMonitorCoeffInt_t *activity_monitor =
 		&(activity_monitor_external.DpmActivityMonitorCoeffInt);
-	int workload_type, ret = 0;
-	uint32_t current_profile_mode = smu->power_profile_mode;
-	smu->power_profile_mode = input[size];
+	int ret, idx;
 
-	if (smu->power_profile_mode >= PP_SMC_POWER_PROFILE_COUNT) {
-		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", smu->power_profile_mode);
-		return -EINVAL;
+	ret = smu_cmn_update_table(smu,
+				   SMU_TABLE_ACTIVITY_MONITOR_COEFF,
+				   WORKLOAD_PPLIB_CUSTOM_BIT,
+				   (void *)(&activity_monitor_external),
+				   false);
+	if (ret) {
+		dev_err(smu->adev->dev, "[%s] Failed to get activity monitor!", __func__);
+		return ret;
 	}
 
-	if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
-		if (size != 9)
-			return -EINVAL;
+	idx = 0 * SMU_14_0_2_CUSTOM_PARAMS_COUNT;
+	if (input[idx]) {
+		/* Gfxclk */
+		activity_monitor->Gfx_FPS = input[idx + 1];
+		activity_monitor->Gfx_MinActiveFreqType = input[idx + 2];
+		activity_monitor->Gfx_MinActiveFreq = input[idx + 3];
+		activity_monitor->Gfx_BoosterFreqType = input[idx + 4];
+		activity_monitor->Gfx_BoosterFreq = input[idx + 5];
+		activity_monitor->Gfx_PD_Data_limit_c = input[idx + 6];
+		activity_monitor->Gfx_PD_Data_error_coeff = input[idx + 7];
+		activity_monitor->Gfx_PD_Data_error_rate_coeff = input[idx + 8];
+	}
+	idx = 1 * SMU_14_0_2_CUSTOM_PARAMS_COUNT;
+	if (input[idx]) {
+		/* Fclk */
+		activity_monitor->Fclk_FPS = input[idx + 1];
+		activity_monitor->Fclk_MinActiveFreqType = input[idx + 2];
+		activity_monitor->Fclk_MinActiveFreq = input[idx + 3];
+		activity_monitor->Fclk_BoosterFreqType = input[idx + 4];
+		activity_monitor->Fclk_BoosterFreq = input[idx + 5];
+		activity_monitor->Fclk_PD_Data_limit_c = input[idx + 6];
+		activity_monitor->Fclk_PD_Data_error_coeff = input[idx + 7];
+		activity_monitor->Fclk_PD_Data_error_rate_coeff = input[idx + 8];
+	}
 
-		ret = smu_cmn_update_table(smu,
-					   SMU_TABLE_ACTIVITY_MONITOR_COEFF,
-					   WORKLOAD_PPLIB_CUSTOM_BIT,
-					   (void *)(&activity_monitor_external),
-					   false);
-		if (ret) {
-			dev_err(smu->adev->dev, "[%s] Failed to get activity monitor!", __func__);
-			return ret;
-		}
+	ret = smu_cmn_update_table(smu,
+				   SMU_TABLE_ACTIVITY_MONITOR_COEFF,
+				   WORKLOAD_PPLIB_CUSTOM_BIT,
+				   (void *)(&activity_monitor_external),
+				   true);
+	if (ret) {
+		dev_err(smu->adev->dev, "[%s] Failed to set activity monitor!", __func__);
+		return ret;
+	}
 
-		switch (input[0]) {
-		case 0: /* Gfxclk */
-			activity_monitor->Gfx_FPS = input[1];
-			activity_monitor->Gfx_MinActiveFreqType = input[2];
-			activity_monitor->Gfx_MinActiveFreq = input[3];
-			activity_monitor->Gfx_BoosterFreqType = input[4];
-			activity_monitor->Gfx_BoosterFreq = input[5];
-			activity_monitor->Gfx_PD_Data_limit_c = input[6];
-			activity_monitor->Gfx_PD_Data_error_coeff = input[7];
-			activity_monitor->Gfx_PD_Data_error_rate_coeff = input[8];
-			break;
-		case 1: /* Fclk */
-			activity_monitor->Fclk_FPS = input[1];
-			activity_monitor->Fclk_MinActiveFreqType = input[2];
-			activity_monitor->Fclk_MinActiveFreq = input[3];
-			activity_monitor->Fclk_BoosterFreqType = input[4];
-			activity_monitor->Fclk_BoosterFreq = input[5];
-			activity_monitor->Fclk_PD_Data_limit_c = input[6];
-			activity_monitor->Fclk_PD_Data_error_coeff = input[7];
-			activity_monitor->Fclk_PD_Data_error_rate_coeff = input[8];
-			break;
-		default:
-			return -EINVAL;
-		}
+	return ret;
+}
 
-		ret = smu_cmn_update_table(smu,
-					   SMU_TABLE_ACTIVITY_MONITOR_COEFF,
-					   WORKLOAD_PPLIB_CUSTOM_BIT,
-					   (void *)(&activity_monitor_external),
-					   true);
-		if (ret) {
-			dev_err(smu->adev->dev, "[%s] Failed to set activity monitor!", __func__);
-			return ret;
-		}
-	}
+static int smu_v14_0_2_set_power_profile_mode(struct smu_context *smu,
+					      u32 workload_mask,
+					      long *custom_params,
+					      u32 custom_params_max_idx)
+{
+	u32 backend_workload_mask = 0;
+	int ret, idx = -1, i;
+
+	smu_cmn_get_backend_workload_mask(smu, workload_mask,
+					  &backend_workload_mask);
 
-	if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_COMPUTE)
+	/* disable deep sleep if compute is enabled */
+	if (workload_mask & (1 << PP_SMC_POWER_PROFILE_COMPUTE))
 		smu_v14_0_deep_sleep_control(smu, false);
-	else if (current_profile_mode == PP_SMC_POWER_PROFILE_COMPUTE)
+	else
 		smu_v14_0_deep_sleep_control(smu, true);
 
-	/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
-	workload_type = smu_cmn_to_asic_specific_index(smu,
-						       CMN2ASIC_MAPPING_WORKLOAD,
-						       smu->power_profile_mode);
-	if (workload_type < 0)
-		return -EINVAL;
+	if (workload_mask & (1 << PP_SMC_POWER_PROFILE_CUSTOM)) {
+		if (!smu->custom_profile_params) {
+			smu->custom_profile_params =
+				kzalloc(SMU_14_0_2_CUSTOM_PARAMS_SIZE, GFP_KERNEL);
+			if (!smu->custom_profile_params)
+				return -ENOMEM;
+		}
+		if (custom_params && custom_params_max_idx) {
+			if (custom_params_max_idx != SMU_14_0_2_CUSTOM_PARAMS_COUNT)
+				return -EINVAL;
+			if (custom_params[0] >= SMU_14_0_2_CUSTOM_PARAMS_CLOCK_COUNT)
+				return -EINVAL;
+			idx = custom_params[0] * SMU_14_0_2_CUSTOM_PARAMS_COUNT;
+			smu->custom_profile_params[idx] = 1;
+			for (i = 1; i < custom_params_max_idx; i++)
+				smu->custom_profile_params[idx + i] = custom_params[i];
+		}
+		ret = smu_v14_0_2_set_power_profile_mode_coeff(smu,
+							       smu->custom_profile_params);
+		if (ret) {
+			if (idx != -1)
+				smu->custom_profile_params[idx] = 0;
+			return ret;
+		}
+	} else if (smu->custom_profile_params) {
+		memset(smu->custom_profile_params, 0, SMU_14_0_2_CUSTOM_PARAMS_SIZE);
+	}
 
-	ret = smu_cmn_send_smc_msg_with_param(smu,
-					       SMU_MSG_SetWorkloadMask,
-					       1 << workload_type,
-					       NULL);
-	if (!ret)
-		smu->workload_mask = 1 << workload_type;
+	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
+					      backend_workload_mask, NULL);
+	if (ret) {
+		dev_err(smu->adev->dev, "Failed to set workload mask 0x%08x\n",
+			workload_mask);
+		if (idx != -1)
+			smu->custom_profile_params[idx] = 0;
+		return ret;
+	}
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index 007a81e108ec..8f92b2777726 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -1221,3 +1221,28 @@ void smu_cmn_generic_plpd_policy_desc(struct smu_dpm_policy *policy)
 {
 	policy->desc = &xgmi_plpd_policy_desc;
 }
+
+void smu_cmn_get_backend_workload_mask(struct smu_context *smu,
+				       u32 workload_mask,
+				       u32 *backend_workload_mask)
+{
+	int workload_type;
+	u32 profile_mode;
+
+	*backend_workload_mask = 0;
+
+	for (profile_mode = 0; profile_mode < PP_SMC_POWER_PROFILE_COUNT; profile_mode++) {
+		if (!(workload_mask & (1 << profile_mode)))
+			continue;
+
+		/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
+		workload_type = smu_cmn_to_asic_specific_index(smu,
+							       CMN2ASIC_MAPPING_WORKLOAD,
+							       profile_mode);
+
+		if (workload_type < 0)
+			continue;
+
+		*backend_workload_mask |= 1 << workload_type;
+	}
+}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
index 1de685defe85..a020277dec3e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
@@ -147,5 +147,9 @@ bool smu_cmn_is_audio_func_enabled(struct amdgpu_device *adev);
 void smu_cmn_generic_soc_policy_desc(struct smu_dpm_policy *policy);
 void smu_cmn_generic_plpd_policy_desc(struct smu_dpm_policy *policy);
 
+void smu_cmn_get_backend_workload_mask(struct smu_context *smu,
+				       u32 workload_mask,
+				       u32 *backend_workload_mask);
+
 #endif
 #endif
-- 
2.47.0

