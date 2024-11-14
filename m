Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93DC0D6A22F
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Nov 2024 21:06:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 275C510E377;
	Thu, 14 Nov 2024 21:06:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="d2IS3Lei";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BDCF10E377
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Nov 2024 21:06:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YnHY6JUvot0BNUbXYzRo0vSan9OuUms/lnF1VjKILPgxFnIVdkXFuIkXJBBEL7A0yxkbe9PGDnX1E7SIMH8eA8iED2lsgg1KvBF2mCd/GvVDCx8FxqTS9VzLRv2UoFyZHV58/PBKWuB2q7SRVjp/aSh63kVgCq8kL7vrtEWnhQzp8tArgobymQpyXc1Q0Hf8qEuHyhMEirlzLSvnCJ04M1nfPRFg8Y4oev9/h6voHpYMearSLUqaawH6P36eadXmnPZFuby9h51STaz77Jir9WuhrGopleIjDG9Se0YKzTfsUUEC/QEbC7aSRZruVLX3d2t5VdNLl8P+mPP5fItTDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WRz8WoFEuRbhKTDMJNx7BDIjlMtKorRVzmj+QJ6th/k=;
 b=rY22U7EzrW1MeaYfE1m4YDE3K6lLzTvC1DVJehGXKzbX0GljRmyKZia0+gJN9IK5FZU9BVq6vUlzlvqEscwhwnwQSsYyGgMmEYjdT4gd2omG0dW9EngueI1Z8aGMJaWUKR5UWLtX21cDnZ5ItWQefm9NahOiO3PlzCRbyToaOnRilaD8jxG2LaQDP6bZZtpj2gVGQuDRMv8Nu7+anPFIHbVn3fRK7CPy3YnljyJbnLmPMZ3NTOpxRqb7WEoljo0xqCbX14nDdFzRXUyjlJ70g8uPCWjUumNaWCAf38kgAp6G8DWDnUuhN+D28O61s1tIjVxFuZ9qPjbyF8faeEBAdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WRz8WoFEuRbhKTDMJNx7BDIjlMtKorRVzmj+QJ6th/k=;
 b=d2IS3LeiwlvO8im9a/+pJ6eixdWWoe/PNdxdHlYy0MhL3HKYFOX+HQmwL+/ZpM5ay6y1DgV9aKnVllk+ZAt2nLbRD1T8wBRl/5nPz4hmqChqhLlGXNTGnkmNTtHIS67AbdZ7H5SQdGshdLTMiFWuFS/BvWCkggwVIZOtqnSbh7U=
Received: from CH2PR07CA0001.namprd07.prod.outlook.com (2603:10b6:610:20::14)
 by SJ2PR12MB8874.namprd12.prod.outlook.com (2603:10b6:a03:540::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Thu, 14 Nov
 2024 21:06:18 +0000
Received: from CH3PEPF00000010.namprd04.prod.outlook.com
 (2603:10b6:610:20:cafe::5b) by CH2PR07CA0001.outlook.office365.com
 (2603:10b6:610:20::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.16 via Frontend
 Transport; Thu, 14 Nov 2024 21:06:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000010.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Thu, 14 Nov 2024 21:06:17 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Nov
 2024 15:06:16 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Kenneth Feng
 <kenneth.feng@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
Subject: [PATCH] drm/amd/pm: fix and simplify workload handling
Date: Thu, 14 Nov 2024 16:06:03 -0500
Message-ID: <20241114210603.10448-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000010:EE_|SJ2PR12MB8874:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f213c5f-cebd-4564-2372-08dd04f02ec3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?x7oWalYK4SY08YWrTd6CufRNeKHnh7021IQnUR0W/6Z5uzz4jBjaIvn4nnrO?=
 =?us-ascii?Q?r1evs2jUYjmH+IGIWpVffTRSmXDiFG5YIjNCt0889COBb/iUNyT/VcWXISAS?=
 =?us-ascii?Q?ThHf+djG4AHJREvh8xmRzhYtjMIuQsGwY0PRt4WI+gJeNdVgfMDCo2J+YeZ+?=
 =?us-ascii?Q?SkyhBjjTzT85ajjpzLFLR1vYugKTcvSVjAZWpXDev0jkOrvLgmTm/1l2m9WA?=
 =?us-ascii?Q?yHYKMjPEF/wlYvQIBG9J48ZS9Oa8rmtjmiLlLsEPGsnujYmzAnYm/aYjWIyv?=
 =?us-ascii?Q?aDFdtsp47dpTTvHjyrZtAQ6QJNdLQrvGPpx3dzCLCKVs1plG25ZRCFC8L/zt?=
 =?us-ascii?Q?mmUukZUR+sD6Ii9FZchmdyWcqh3XnHF8iiEibYASEkpdnz2MvDqK+y+0rFMZ?=
 =?us-ascii?Q?us7Dg/3TjZlmPYHqh6do01sEEG0PvhsUrJ+SM+NL/ishQer/U8HdJQRHLP4a?=
 =?us-ascii?Q?4+OVqUbfhinjx+cyLy5a1qjgjmpz9wqyk/ugQ9FBoRtkt4dgc/cliZGVERa2?=
 =?us-ascii?Q?rzHZ2DdCg/t1KUlwCK7korIyeL8vGyAXdojbQEbH+76PZSTs+yd5FgfUIEHQ?=
 =?us-ascii?Q?s9nWJQwaRcoiw1iS8Mpt3pg2PGZozOzO+oy3JchupZEKUatXHrWB9NbkH2tX?=
 =?us-ascii?Q?NxMOZm2e1VrkL9nq0QM1PTdK6EBCIKhNDeyx1/5A3LiW2swOlGlj+pOjmzQI?=
 =?us-ascii?Q?bVVmoYG0TTKoWzRgS2IPpvUzHzxRUN5DGbIykJYdvNWp2zldAUXDcS48w0zQ?=
 =?us-ascii?Q?AC/zyex6+ZRE/uvLN4TiV4cQniD+5u9YqVpFKF+ew7fGodAUN9uSE+tq4DYj?=
 =?us-ascii?Q?rcF69PuL+kybk4vb4cID4MraH7Mg2d59KQGsPKxWyiBX27yApWng0XkuAYqT?=
 =?us-ascii?Q?cw73fMACCBUN5SscufIi6UgmZ1pBd0nKVOv1lag9mnEluPoJZ/Ld/7IuwZdg?=
 =?us-ascii?Q?DaORecB5qfP9s5YPxu/O91TbOpJbmcampw6cWS9JaaBLkvS3+h6gibo9vTlO?=
 =?us-ascii?Q?Y7OYhYsDkK9wacDHeYf/pd6qHdboWPigHuFaxnh6Y01s5b2AQ14li5ni8hYw?=
 =?us-ascii?Q?/iKVn//3j7VeY/ALBefQMeQwTGE2uYh7g7CAiUxWCQjZWp8m1lmWytpKe4ba?=
 =?us-ascii?Q?BZT6bEfQBTbHMVlXiTnozGBBST9jALpHfby1EEsm9Y+7EdzJMkLBVIRihj4B?=
 =?us-ascii?Q?AMeiM06dOuzyng01YuBg0QLQyAEdPr7QM/R1qdl0pwLvPnpZd0VWCF/pPsGv?=
 =?us-ascii?Q?kZ7RThLMqRaOJqyG+PKbzK33FDO+7rzFN6Gslya/VT0GwoxQMJULHwM5etoO?=
 =?us-ascii?Q?9DYVDDBkzczK/KuwdozHizH1M2SHejBLBDf4bxEcj0Bbf9rbgnfZMwDJswPN?=
 =?us-ascii?Q?hUkTkro46SZpDErmRLrgqrH2clfXcxD/nsS8acy7jevqne5J4Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 21:06:17.8743 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f213c5f-cebd-4564-2372-08dd04f02ec3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000010.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8874
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

Fixes: 8cc438be5d49 ("drm/amd/pm: correct the workload setting")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Kenneth Feng <kenneth.feng@amd.com>
Cc: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 165 +++++++++---------
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  21 ++-
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 147 ++++++++--------
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 151 ++++++++--------
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 150 ++++++++--------
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  |  41 ++---
 .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   |  43 ++---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 153 ++++++++--------
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 120 +++++++------
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  | 141 ++++++++-------
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        |  38 +++-
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |   7 +-
 12 files changed, 614 insertions(+), 563 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index c3a6b6f20455..ab6b30a9df1a 100644
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
@@ -1268,9 +1272,6 @@ static int smu_sw_init(struct amdgpu_ip_block *ip_block)
 	INIT_WORK(&smu->interrupt_work, smu_interrupt_work_fn);
 	atomic64_set(&smu->throttle_int_counter, 0);
 	smu->watermarks_bitmap = 0;
-	smu->power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
-	smu->default_power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
-	smu->user_dpm_profile.user_workload_mask = 0;
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; i++)
 		atomic_set(&smu->smu_power.power_gate.vcn_gated[i], 1);
@@ -1278,33 +1279,13 @@ static int smu_sw_init(struct amdgpu_ip_block *ip_block)
 	atomic_set(&smu->smu_power.power_gate.vpe_gated, 1);
 	atomic_set(&smu->smu_power.power_gate.umsch_mm_gated, 1);
 
-	smu->workload_priority[PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT] = 0;
-	smu->workload_priority[PP_SMC_POWER_PROFILE_FULLSCREEN3D] = 1;
-	smu->workload_priority[PP_SMC_POWER_PROFILE_POWERSAVING] = 2;
-	smu->workload_priority[PP_SMC_POWER_PROFILE_VIDEO] = 3;
-	smu->workload_priority[PP_SMC_POWER_PROFILE_VR] = 4;
-	smu->workload_priority[PP_SMC_POWER_PROFILE_COMPUTE] = 5;
-	smu->workload_priority[PP_SMC_POWER_PROFILE_CUSTOM] = 6;
-
 	if (smu->is_apu ||
-	    !smu_is_workload_profile_available(smu, PP_SMC_POWER_PROFILE_FULLSCREEN3D)) {
-		smu->driver_workload_mask =
-			1 << smu->workload_priority[PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT];
-	} else {
-		smu->driver_workload_mask =
-			1 << smu->workload_priority[PP_SMC_POWER_PROFILE_FULLSCREEN3D];
-		smu->default_power_profile_mode = PP_SMC_POWER_PROFILE_FULLSCREEN3D;
-	}
-
-	smu->workload_mask = smu->driver_workload_mask |
-							smu->user_dpm_profile.user_workload_mask;
-	smu->workload_setting[0] = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
-	smu->workload_setting[1] = PP_SMC_POWER_PROFILE_FULLSCREEN3D;
-	smu->workload_setting[2] = PP_SMC_POWER_PROFILE_POWERSAVING;
-	smu->workload_setting[3] = PP_SMC_POWER_PROFILE_VIDEO;
-	smu->workload_setting[4] = PP_SMC_POWER_PROFILE_VR;
-	smu->workload_setting[5] = PP_SMC_POWER_PROFILE_COMPUTE;
-	smu->workload_setting[6] = PP_SMC_POWER_PROFILE_CUSTOM;
+	    !smu_is_workload_profile_available(smu, PP_SMC_POWER_PROFILE_FULLSCREEN3D))
+		smu->power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
+	else
+		smu->power_profile_mode = PP_SMC_POWER_PROFILE_FULLSCREEN3D;
+	smu_power_profile_mode_get(smu, smu->power_profile_mode);
+
 	smu->display_config = &adev->pm.pm_display_cfg;
 
 	smu->smu_dpm.dpm_level = AMD_DPM_FORCED_LEVEL_AUTO;
@@ -2140,6 +2121,9 @@ static int smu_suspend(struct amdgpu_ip_block *ip_block)
 	if (!ret)
 		adev->gfx.gfx_off_entrycount = count;
 
+	/* clear this on suspend so it will get reprogrammed on resume */
+	smu->frontend_workload_mask = 0;
+
 	return 0;
 }
 
@@ -2251,26 +2235,46 @@ static int smu_enable_umd_pstate(void *handle,
 	return 0;
 }
 
-static int smu_bump_power_profile_mode(struct smu_context *smu,
-					   long *param,
-					   uint32_t param_size)
+static int smu_bump_power_profile_mode(struct smu_context *smu)
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
+	if (smu->frontend_workload_mask == workload_mask)
+		return 0;
 
 	if (smu->ppt_funcs->set_power_profile_mode)
-		ret = smu->ppt_funcs->set_power_profile_mode(smu, param, param_size);
+		ret = smu->ppt_funcs->set_power_profile_mode(smu, workload_mask);
+
+	if (!ret)
+		smu->frontend_workload_mask = workload_mask;
 
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
@@ -2307,14 +2311,8 @@ static int smu_adjust_power_state_dynamic(struct smu_context *smu,
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
+		smu_bump_power_profile_mode(smu);
 
 	return ret;
 }
@@ -2333,13 +2331,13 @@ static int smu_handle_task(struct smu_context *smu,
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
@@ -2361,12 +2359,10 @@ static int smu_handle_dpm_task(void *handle,
 
 static int smu_switch_power_profile(void *handle,
 				    enum PP_SMC_POWER_PROFILE type,
-				    bool en)
+				    bool enable)
 {
 	struct smu_context *smu = handle;
 	struct smu_dpm_context *smu_dpm_ctx = &(smu->smu_dpm);
-	long workload[1];
-	uint32_t index;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
@@ -2374,24 +2370,14 @@ static int smu_switch_power_profile(void *handle,
 	if (!(type < PP_SMC_POWER_PROFILE_CUSTOM))
 		return -EINVAL;
 
-	if (!en) {
-		smu->driver_workload_mask &= ~(1 << smu->workload_priority[type]);
-		index = fls(smu->workload_mask);
-		index = index > 0 && index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
-		workload[0] = smu->workload_setting[index];
-	} else {
-		smu->driver_workload_mask |= (1 << smu->workload_priority[type]);
-		index = fls(smu->workload_mask);
-		index = index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
-		workload[0] = smu->workload_setting[index];
-	}
-
-	smu->workload_mask = smu->driver_workload_mask |
-						 smu->user_dpm_profile.user_workload_mask;
-
 	if (smu_dpm_ctx->dpm_level != AMD_DPM_FORCED_LEVEL_MANUAL &&
-		smu_dpm_ctx->dpm_level != AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM)
-		smu_bump_power_profile_mode(smu, workload, 0);
+	    smu_dpm_ctx->dpm_level != AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM) {
+		if (enable)
+			smu_power_profile_mode_get(smu, type);
+		else
+			smu_power_profile_mode_put(smu, type);
+		smu_bump_power_profile_mode(smu);
+	}
 
 	return 0;
 }
@@ -3090,21 +3076,44 @@ static int smu_set_power_profile_mode(void *handle,
 				      uint32_t param_size)
 {
 	struct smu_context *smu = handle;
-	int ret;
+	bool custom_changed = false;
+	int ret = 0, i;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled ||
 	    !smu->ppt_funcs->set_power_profile_mode)
 		return -EOPNOTSUPP;
 
-	if (smu->user_dpm_profile.user_workload_mask &
-	   (1 << smu->workload_priority[param[param_size]]))
-	   return 0;
+	if (param[param_size] == PP_SMC_POWER_PROFILE_CUSTOM) {
+		if (param_size > SMU_BACKEND_MAX_CUSTOM_PARAMETERS)
+			return -EINVAL;
+		/* param_size is actually a max index, not an array size */
+		for (i = 0; i <= param_size; i++) {
+			if (smu->custom_profile_input[i] != param[i]) {
+				custom_changed = true;
+				break;
+			}
+		}
+	}
 
-	smu->user_dpm_profile.user_workload_mask =
-		(1 << smu->workload_priority[param[param_size]]);
-	smu->workload_mask = smu->user_dpm_profile.user_workload_mask |
-		smu->driver_workload_mask;
-	ret = smu_bump_power_profile_mode(smu, param, param_size);
+	if ((param[param_size] != smu->power_profile_mode) || custom_changed) {
+		/* save the parameters for custom */
+		if (custom_changed) {
+			/* param_size is actually a max index, not an array size */
+			for (i = 0; i <= param_size; i++)
+				smu->custom_profile_input[i] = param[i];
+			smu->custom_profile_size = param_size;
+			/* clear frontend mask so custom changes propogate */
+			smu->frontend_workload_mask = 0;
+		}
+		/* clear the old user preference */
+		smu_power_profile_mode_put(smu, smu->power_profile_mode);
+		/* set the new user preference */
+		smu_power_profile_mode_get(smu, param[param_size]);
+		ret = smu_bump_power_profile_mode(smu);
+		if (!ret)
+			/* store the user's preference */
+			smu->power_profile_mode = param[param_size];
+	}
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index fa93a8879113..a9b88072bd05 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -240,7 +240,6 @@ struct smu_user_dpm_profile {
 	/* user clock state information */
 	uint32_t clk_mask[SMU_CLK_COUNT];
 	uint32_t clk_dependency;
-	uint32_t user_workload_mask;
 };
 
 #define SMU_TABLE_INIT(tables, table_id, s, a, d)	\
@@ -510,6 +509,8 @@ enum smu_fw_status {
  */
 #define SMU_WBRF_EVENT_HANDLING_PACE	10
 
+#define SMU_BACKEND_MAX_CUSTOM_PARAMETERS	11
+
 struct smu_context {
 	struct amdgpu_device            *adev;
 	struct amdgpu_irq_src		irq_source;
@@ -557,12 +558,16 @@ struct smu_context {
 	uint32_t hard_min_uclk_req_from_dal;
 	bool disable_uclk_switch;
 
-	uint32_t workload_mask;
-	uint32_t driver_workload_mask;
-	uint32_t workload_priority[WORKLOAD_POLICY_MAX];
-	uint32_t workload_setting[WORKLOAD_POLICY_MAX];
+	/* asic agnostic workload mask */
+	uint32_t frontend_workload_mask;
+	/* asic specific workload mask */
+	uint32_t backend_workload_mask;
+	/* default/user workload preference */
 	uint32_t power_profile_mode;
-	uint32_t default_power_profile_mode;
+	uint32_t workload_refcount[PP_SMC_POWER_PROFILE_COUNT];
+	/* backend specific custom workload settings */
+	long custom_profile_input[SMU_BACKEND_MAX_CUSTOM_PARAMETERS];
+	bool custom_profile_size;
 	bool pm_enabled;
 	bool is_apu;
 
@@ -733,9 +738,9 @@ struct pptable_funcs {
 	 * @set_power_profile_mode: Set a power profile mode. Also used to
 	 *                          create/set custom power profile modes.
 	 * &input: Power profile mode parameters.
-	 * &size: Size of &input.
+	 * &workload_mask: mask of workloads to enable
 	 */
-	int (*set_power_profile_mode)(struct smu_context *smu, long *input, uint32_t size);
+	int (*set_power_profile_mode)(struct smu_context *smu, u32 workload_mask);
 
 	/**
 	 * @dpm_set_vcn_enable: Enable/disable VCN engine dynamic power
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 4b36c230e43a..64605cd932ab 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -1441,97 +1441,98 @@ static int arcturus_get_power_profile_mode(struct smu_context *smu,
 	return size;
 }
 
-static int arcturus_set_power_profile_mode(struct smu_context *smu,
-					   long *input,
-					   uint32_t size)
+static int arcturus_set_power_profile_mode_coeff(struct smu_context *smu,
+						 long *input,
+						 uint32_t size)
 {
 	DpmActivityMonitorCoeffInt_t activity_monitor;
-	int workload_type = 0;
-	uint32_t profile_mode = input[size];
-	int ret = 0;
+	int ret;
 
-	if (profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
-		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", profile_mode);
+	if (size != 10)
 		return -EINVAL;
+
+	ret = smu_cmn_update_table(smu,
+				   SMU_TABLE_ACTIVITY_MONITOR_COEFF,
+				   WORKLOAD_PPLIB_CUSTOM_BIT,
+				   (void *)(&activity_monitor),
+				   false);
+	if (ret) {
+		dev_err(smu->adev->dev, "[%s] Failed to get activity monitor!", __func__);
+		return ret;
 	}
 
-	if ((profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) &&
-	     (smu->smc_fw_version >= 0x360d00)) {
-		if (size != 10)
-			return -EINVAL;
+	switch (input[0]) {
+	case 0: /* Gfxclk */
+		activity_monitor.Gfx_FPS = input[1];
+		activity_monitor.Gfx_UseRlcBusy = input[2];
+		activity_monitor.Gfx_MinActiveFreqType = input[3];
+		activity_monitor.Gfx_MinActiveFreq = input[4];
+		activity_monitor.Gfx_BoosterFreqType = input[5];
+		activity_monitor.Gfx_BoosterFreq = input[6];
+		activity_monitor.Gfx_PD_Data_limit_c = input[7];
+		activity_monitor.Gfx_PD_Data_error_coeff = input[8];
+		activity_monitor.Gfx_PD_Data_error_rate_coeff = input[9];
+		break;
+	case 1: /* Uclk */
+		activity_monitor.Mem_FPS = input[1];
+		activity_monitor.Mem_UseRlcBusy = input[2];
+		activity_monitor.Mem_MinActiveFreqType = input[3];
+		activity_monitor.Mem_MinActiveFreq = input[4];
+		activity_monitor.Mem_BoosterFreqType = input[5];
+		activity_monitor.Mem_BoosterFreq = input[6];
+		activity_monitor.Mem_PD_Data_limit_c = input[7];
+		activity_monitor.Mem_PD_Data_error_coeff = input[8];
+		activity_monitor.Mem_PD_Data_error_rate_coeff = input[9];
+		break;
+	default:
+		return -EINVAL;
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
+	ret = smu_cmn_update_table(smu,
+				   SMU_TABLE_ACTIVITY_MONITOR_COEFF,
+				   WORKLOAD_PPLIB_CUSTOM_BIT,
+				   (void *)(&activity_monitor),
+				   true);
+	if (ret) {
+		dev_err(smu->adev->dev, "[%s] Failed to set activity monitor!", __func__);
+		return ret;
+	}
 
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
-			return -EINVAL;
-		}
+	return ret;
+}
 
-		ret = smu_cmn_update_table(smu,
-				       SMU_TABLE_ACTIVITY_MONITOR_COEFF,
-				       WORKLOAD_PPLIB_CUSTOM_BIT,
-				       (void *)(&activity_monitor),
-				       true);
-		if (ret) {
-			dev_err(smu->adev->dev, "[%s] Failed to set activity monitor!", __func__);
-			return ret;
-		}
-	}
+static int arcturus_set_power_profile_mode(struct smu_context *smu,
+					   u32 workload_mask)
+{
+	u32 backend_workload_mask = 0;
+	bool custom_enabled = false;
+	int ret;
 
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
+	smu_cmn_get_backend_workload_mask(smu, workload_mask,
+					  &backend_workload_mask,
+					  &custom_enabled);
+
+	if (custom_enabled) {
+		ret = arcturus_set_power_profile_mode_coeff(smu,
+							    smu->custom_profile_input,
+							    smu->custom_profile_size);
+		if (ret)
+			return ret;
 	}
 
 	ret = smu_cmn_send_smc_msg_with_param(smu,
-					  SMU_MSG_SetWorkloadMask,
-					  smu->workload_mask,
-					  NULL);
+					      SMU_MSG_SetWorkloadMask,
+					      backend_workload_mask,
+					      NULL);
 	if (ret) {
-		dev_err(smu->adev->dev, "Fail to set workload type %d\n", workload_type);
+		dev_err(smu->adev->dev, "Failed to set workload mask 0x%08x\n",
+			workload_mask);
 		return ret;
 	}
 
-	smu_cmn_assign_power_profile(smu);
+	smu->backend_workload_mask = backend_workload_mask;
 
-	return 0;
+	return ret;
 }
 
 static int arcturus_set_performance_level(struct smu_context *smu,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 211635dabed8..8ed446b3458c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2006,90 +2006,101 @@ static int navi10_get_power_profile_mode(struct smu_context *smu, char *buf)
 	return size;
 }
 
-static int navi10_set_power_profile_mode(struct smu_context *smu, long *input, uint32_t size)
+static int navi10_set_power_profile_mode_coeff(struct smu_context *smu,
+					       long *input,
+					       uint32_t size)
 {
 	DpmActivityMonitorCoeffInt_t activity_monitor;
-	int workload_type, ret = 0;
+	int ret;
+
+	if (size != 10)
+		return -EINVAL;
 
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
+	switch (input[0]) {
+	case 0: /* Gfxclk */
+		activity_monitor.Gfx_FPS = input[1];
+		activity_monitor.Gfx_MinFreqStep = input[2];
+		activity_monitor.Gfx_MinActiveFreqType = input[3];
+		activity_monitor.Gfx_MinActiveFreq = input[4];
+		activity_monitor.Gfx_BoosterFreqType = input[5];
+		activity_monitor.Gfx_BoosterFreq = input[6];
+		activity_monitor.Gfx_PD_Data_limit_c = input[7];
+		activity_monitor.Gfx_PD_Data_error_coeff = input[8];
+		activity_monitor.Gfx_PD_Data_error_rate_coeff = input[9];
+		break;
+	case 1: /* Socclk */
+		activity_monitor.Soc_FPS = input[1];
+		activity_monitor.Soc_MinFreqStep = input[2];
+		activity_monitor.Soc_MinActiveFreqType = input[3];
+		activity_monitor.Soc_MinActiveFreq = input[4];
+		activity_monitor.Soc_BoosterFreqType = input[5];
+		activity_monitor.Soc_BoosterFreq = input[6];
+		activity_monitor.Soc_PD_Data_limit_c = input[7];
+		activity_monitor.Soc_PD_Data_error_coeff = input[8];
+		activity_monitor.Soc_PD_Data_error_rate_coeff = input[9];
+		break;
+	case 2: /* Memclk */
+		activity_monitor.Mem_FPS = input[1];
+		activity_monitor.Mem_MinFreqStep = input[2];
+		activity_monitor.Mem_MinActiveFreqType = input[3];
+		activity_monitor.Mem_MinActiveFreq = input[4];
+		activity_monitor.Mem_BoosterFreqType = input[5];
+		activity_monitor.Mem_BoosterFreq = input[6];
+		activity_monitor.Mem_PD_Data_limit_c = input[7];
+		activity_monitor.Mem_PD_Data_error_coeff = input[8];
+		activity_monitor.Mem_PD_Data_error_rate_coeff = input[9];
+		break;
+	default:
 		return -EINVAL;
 	}
 
-	if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
-		if (size != 10)
-			return -EINVAL;
+	ret = smu_cmn_update_table(smu,
+				   SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORKLOAD_PPLIB_CUSTOM_BIT,
+				   (void *)(&activity_monitor), true);
+	if (ret) {
+		dev_err(smu->adev->dev, "[%s] Failed to set activity monitor!", __func__);
+		return ret;
+	}
 
-		ret = smu_cmn_update_table(smu,
-				       SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORKLOAD_PPLIB_CUSTOM_BIT,
-				       (void *)(&activity_monitor), false);
-		if (ret) {
-			dev_err(smu->adev->dev, "[%s] Failed to get activity monitor!", __func__);
-			return ret;
-		}
+	return ret;
+}
 
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
+static int navi10_set_power_profile_mode(struct smu_context *smu,
+					 u32 workload_mask)
+{
+	u32 backend_workload_mask = 0;
+	bool custom_enabled = false;
+	int ret;
 
-		ret = smu_cmn_update_table(smu,
-				       SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORKLOAD_PPLIB_CUSTOM_BIT,
-				       (void *)(&activity_monitor), true);
-		if (ret) {
-			dev_err(smu->adev->dev, "[%s] Failed to set activity monitor!", __func__);
+	smu_cmn_get_backend_workload_mask(smu, workload_mask,
+					  &backend_workload_mask,
+					  &custom_enabled);
+
+	if (custom_enabled) {
+		ret = navi10_set_power_profile_mode_coeff(smu,
+							  smu->custom_profile_input,
+							  smu->custom_profile_size);
+		if (ret)
 			return ret;
-		}
 	}
 
-	/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
-	workload_type = smu_cmn_to_asic_specific_index(smu,
-						       CMN2ASIC_MAPPING_WORKLOAD,
-						       smu->power_profile_mode);
-	if (workload_type < 0)
-		return -EINVAL;
-
 	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
-				    smu->workload_mask, NULL);
-	if (ret)
-		dev_err(smu->adev->dev, "[%s] Failed to set work load mask!", __func__);
-	else
-		smu_cmn_assign_power_profile(smu);
+					      backend_workload_mask, NULL);
+	if (ret) {
+		dev_err(smu->adev->dev, "Failed to set workload mask 0x%08x\n",
+			workload_mask);
+		return ret;
+	}
+
+	smu->backend_workload_mask = backend_workload_mask;
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 844532a9b641..bea11bbe859c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -1704,93 +1704,103 @@ static int sienna_cichlid_get_power_profile_mode(struct smu_context *smu, char *
 	return size;
 }
 
-static int sienna_cichlid_set_power_profile_mode(struct smu_context *smu, long *input, uint32_t size)
+static int sienna_cichlid_set_power_profile_mode_coeff(struct smu_context *smu,
+						       long *input, uint32_t size)
 {
 
 	DpmActivityMonitorCoeffIntExternal_t activity_monitor_external;
 	DpmActivityMonitorCoeffInt_t *activity_monitor =
 		&(activity_monitor_external.DpmActivityMonitorCoeffInt);
-	int workload_type, ret = 0;
+	int ret;
+
+	if (size != 10)
+		return -EINVAL;
 
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
+	switch (input[0]) {
+	case 0: /* Gfxclk */
+		activity_monitor->Gfx_FPS = input[1];
+		activity_monitor->Gfx_MinFreqStep = input[2];
+		activity_monitor->Gfx_MinActiveFreqType = input[3];
+		activity_monitor->Gfx_MinActiveFreq = input[4];
+		activity_monitor->Gfx_BoosterFreqType = input[5];
+		activity_monitor->Gfx_BoosterFreq = input[6];
+		activity_monitor->Gfx_PD_Data_limit_c = input[7];
+		activity_monitor->Gfx_PD_Data_error_coeff = input[8];
+		activity_monitor->Gfx_PD_Data_error_rate_coeff = input[9];
+		break;
+	case 1: /* Socclk */
+		activity_monitor->Fclk_FPS = input[1];
+		activity_monitor->Fclk_MinFreqStep = input[2];
+		activity_monitor->Fclk_MinActiveFreqType = input[3];
+		activity_monitor->Fclk_MinActiveFreq = input[4];
+		activity_monitor->Fclk_BoosterFreqType = input[5];
+		activity_monitor->Fclk_BoosterFreq = input[6];
+		activity_monitor->Fclk_PD_Data_limit_c = input[7];
+		activity_monitor->Fclk_PD_Data_error_coeff = input[8];
+		activity_monitor->Fclk_PD_Data_error_rate_coeff = input[9];
+		break;
+	case 2: /* Memclk */
+		activity_monitor->Mem_FPS = input[1];
+		activity_monitor->Mem_MinFreqStep = input[2];
+		activity_monitor->Mem_MinActiveFreqType = input[3];
+		activity_monitor->Mem_MinActiveFreq = input[4];
+		activity_monitor->Mem_BoosterFreqType = input[5];
+		activity_monitor->Mem_BoosterFreq = input[6];
+		activity_monitor->Mem_PD_Data_limit_c = input[7];
+		activity_monitor->Mem_PD_Data_error_coeff = input[8];
+		activity_monitor->Mem_PD_Data_error_rate_coeff = input[9];
+		break;
+	default:
 		return -EINVAL;
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
+						 u32 workload_mask)
+{
+	u32 backend_workload_mask = 0;
+	bool custom_enabled = false;
+	int ret;
 
-		ret = smu_cmn_update_table(smu,
-				       SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORKLOAD_PPLIB_CUSTOM_BIT,
-				       (void *)(&activity_monitor_external), true);
-		if (ret) {
-			dev_err(smu->adev->dev, "[%s] Failed to set activity monitor!", __func__);
+	smu_cmn_get_backend_workload_mask(smu, workload_mask,
+					  &backend_workload_mask,
+					  &custom_enabled);
+
+	if (custom_enabled) {
+		ret = sienna_cichlid_set_power_profile_mode_coeff(smu,
+								  smu->custom_profile_input,
+								  smu->custom_profile_size);
+		if (ret)
 			return ret;
-		}
 	}
 
-	/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
-	workload_type = smu_cmn_to_asic_specific_index(smu,
-						       CMN2ASIC_MAPPING_WORKLOAD,
-						       smu->power_profile_mode);
-	if (workload_type < 0)
-		return -EINVAL;
-
 	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
-				    smu->workload_mask, NULL);
-	if (ret)
-		dev_err(smu->adev->dev, "[%s] Failed to set work load mask!", __func__);
-	else
-		smu_cmn_assign_power_profile(smu);
+					      backend_workload_mask, NULL);
+	if (ret) {
+		dev_err(smu->adev->dev, "Failed to set workload mask 0x%08x\n",
+			workload_mask);
+		return ret;
+	}
+
+	smu->backend_workload_mask = backend_workload_mask;
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index f89c487dce72..279d01f58785 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -1056,42 +1056,29 @@ static int vangogh_get_power_profile_mode(struct smu_context *smu,
 	return size;
 }
 
-static int vangogh_set_power_profile_mode(struct smu_context *smu, long *input, uint32_t size)
+static int vangogh_set_power_profile_mode(struct smu_context *smu,
+					  u32 workload_mask)
 {
-	int workload_type, ret;
-	uint32_t profile_mode = input[size];
+	u32 backend_workload_mask = 0;
+	bool custom_enabled = false;
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
+					  &backend_workload_mask,
+					  &custom_enabled);
 
 	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_ActiveProcessNotify,
-				    smu->workload_mask,
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
 
-	smu_cmn_assign_power_profile(smu);
+	smu->backend_workload_mask = backend_workload_mask;
 
-	return 0;
+	return ret;
 }
 
 static int vangogh_set_soft_freq_limited_range(struct smu_context *smu,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
index 75a9ea87f419..f6d0973506d6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
@@ -864,44 +864,29 @@ static int renoir_force_clk_levels(struct smu_context *smu,
 	return ret;
 }
 
-static int renoir_set_power_profile_mode(struct smu_context *smu, long *input, uint32_t size)
+static int renoir_set_power_profile_mode(struct smu_context *smu,
+					 u32 workload_mask)
 {
-	int workload_type, ret;
-	uint32_t profile_mode = input[size];
+	int ret;
+	u32 backend_workload_mask = 0;
+	bool custom_enabled = false;
 
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
+					  &backend_workload_mask,
+					  &custom_enabled);
 
 	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_ActiveProcessNotify,
-				    smu->workload_mask,
-				    NULL);
+					      backend_workload_mask,
+					      NULL);
 	if (ret) {
-		dev_err_once(smu->adev->dev, "Fail to set workload type %d\n", workload_type);
+		dev_err_once(smu->adev->dev, "Failed to set workload mask 0x08%x\n",
+			     workload_mask);
 		return ret;
 	}
 
-	smu_cmn_assign_power_profile(smu);
+	smu->backend_workload_mask = backend_workload_mask;
 
-	return 0;
+	return ret;
 }
 
 static int renoir_set_peak_clock_by_device(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 80c6b1e523aa..4bc984cca6cd 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -2571,82 +2571,76 @@ static int smu_v13_0_0_get_power_profile_mode(struct smu_context *smu,
 	return size;
 }
 
-static int smu_v13_0_0_set_power_profile_mode(struct smu_context *smu,
-					      long *input,
-					      uint32_t size)
+static int smu_v13_0_0_set_power_profile_mode_coeff(struct smu_context *smu,
+						    long *input,
+						    uint32_t size)
 {
 	DpmActivityMonitorCoeffIntExternal_t activity_monitor_external;
 	DpmActivityMonitorCoeffInt_t *activity_monitor =
 		&(activity_monitor_external.DpmActivityMonitorCoeffInt);
-	int workload_type, ret = 0;
-	u32 workload_mask;
-
-	smu->power_profile_mode = input[size];
+	int ret;
 
-	if (smu->power_profile_mode >= PP_SMC_POWER_PROFILE_COUNT) {
-		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", smu->power_profile_mode);
+	if (size != 9)
 		return -EINVAL;
-	}
-
-	if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
-		if (size != 9)
-			return -EINVAL;
 
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
+				   false);
+	if (ret) {
+		dev_err(smu->adev->dev, "[%s] Failed to get activity monitor!", __func__);
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
+	switch (input[0]) {
+	case 0: /* Gfxclk */
+		activity_monitor->Gfx_FPS = input[1];
+		activity_monitor->Gfx_MinActiveFreqType = input[2];
+		activity_monitor->Gfx_MinActiveFreq = input[3];
+		activity_monitor->Gfx_BoosterFreqType = input[4];
+		activity_monitor->Gfx_BoosterFreq = input[5];
+		activity_monitor->Gfx_PD_Data_limit_c = input[6];
+		activity_monitor->Gfx_PD_Data_error_coeff = input[7];
+		activity_monitor->Gfx_PD_Data_error_rate_coeff = input[8];
+		break;
+	case 1: /* Fclk */
+		activity_monitor->Fclk_FPS = input[1];
+		activity_monitor->Fclk_MinActiveFreqType = input[2];
+		activity_monitor->Fclk_MinActiveFreq = input[3];
+		activity_monitor->Fclk_BoosterFreqType = input[4];
+		activity_monitor->Fclk_BoosterFreq = input[5];
+		activity_monitor->Fclk_PD_Data_limit_c = input[6];
+		activity_monitor->Fclk_PD_Data_error_coeff = input[7];
+		activity_monitor->Fclk_PD_Data_error_rate_coeff = input[8];
+		break;
+	default:
+		return -EINVAL;
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
+					      u32 workload_mask)
+{
+	u32 backend_workload_mask = 0;
+	bool custom_enabled = false;
+	int workload_type, ret;
 
-	workload_mask = 1 << workload_type;
+	smu_cmn_get_backend_workload_mask(smu, workload_mask,
+					  &backend_workload_mask,
+					  &custom_enabled);
 
 	/* Add optimizations for SMU13.0.0/10.  Reuse the power saving profile */
 	if ((amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 0) &&
@@ -2658,26 +2652,29 @@ static int smu_v13_0_0_set_power_profile_mode(struct smu_context *smu,
 							       CMN2ASIC_MAPPING_WORKLOAD,
 							       PP_SMC_POWER_PROFILE_POWERSAVING);
 		if (workload_type >= 0)
-			workload_mask |= 1 << workload_type;
+			backend_workload_mask |= 1 << workload_type;
+	}
+
+	if (custom_enabled) {
+		ret = smu_v13_0_0_set_power_profile_mode_coeff(smu,
+							       smu->custom_profile_input,
+							       smu->custom_profile_size);
+		if (ret)
+			return ret;
 	}
 
-	smu->workload_mask |= workload_mask;
 	ret = smu_cmn_send_smc_msg_with_param(smu,
-					       SMU_MSG_SetWorkloadMask,
-					       smu->workload_mask,
-					       NULL);
-	if (!ret) {
-		smu_cmn_assign_power_profile(smu);
-		if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_POWERSAVING) {
-			workload_type = smu_cmn_to_asic_specific_index(smu,
-							       CMN2ASIC_MAPPING_WORKLOAD,
-							       PP_SMC_POWER_PROFILE_FULLSCREEN3D);
-			smu->power_profile_mode = smu->workload_mask & (1 << workload_type)
-										? PP_SMC_POWER_PROFILE_FULLSCREEN3D
-										: PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
-		}
+					      SMU_MSG_SetWorkloadMask,
+					      backend_workload_mask,
+					      NULL);
+	if (ret) {
+		dev_err(smu->adev->dev, "Failed to set workload mask 0x%08x\n",
+			workload_mask);
+		return ret;
 	}
 
+	smu->backend_workload_mask = backend_workload_mask;
+
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index c5d3e25cc967..225629eb9422 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -2528,79 +2528,89 @@ do {													\
 	return result;
 }
 
-static int smu_v13_0_7_set_power_profile_mode(struct smu_context *smu, long *input, uint32_t size)
+static int smu_v13_0_7_set_power_profile_mode_coeff(struct smu_context *smu,
+						    long *input, uint32_t size)
 {
 
 	DpmActivityMonitorCoeffIntExternal_t activity_monitor_external;
 	DpmActivityMonitorCoeffInt_t *activity_monitor =
 		&(activity_monitor_external.DpmActivityMonitorCoeffInt);
-	int workload_type, ret = 0;
+	int ret;
+
+	if (size != 8)
+		return -EINVAL;
 
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
+	switch (input[0]) {
+	case 0: /* Gfxclk */
+		activity_monitor->Gfx_ActiveHystLimit = input[1];
+		activity_monitor->Gfx_IdleHystLimit = input[2];
+		activity_monitor->Gfx_FPS = input[3];
+		activity_monitor->Gfx_MinActiveFreqType = input[4];
+		activity_monitor->Gfx_BoosterFreqType = input[5];
+		activity_monitor->Gfx_MinActiveFreq = input[6];
+		activity_monitor->Gfx_BoosterFreq = input[7];
+		break;
+	case 1: /* Fclk */
+		activity_monitor->Fclk_ActiveHystLimit = input[1];
+		activity_monitor->Fclk_IdleHystLimit = input[2];
+		activity_monitor->Fclk_FPS = input[3];
+		activity_monitor->Fclk_MinActiveFreqType = input[4];
+		activity_monitor->Fclk_BoosterFreqType = input[5];
+		activity_monitor->Fclk_MinActiveFreq = input[6];
+		activity_monitor->Fclk_BoosterFreq = input[7];
+		break;
+	default:
 		return -EINVAL;
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
-		}
+static int smu_v13_0_7_set_power_profile_mode(struct smu_context *smu,
+					      u32 workload_mask)
+{
+	u32 backend_workload_mask = 0;
+	bool custom_enabled = false;
+	int ret;
 
-		ret = smu_cmn_update_table(smu,
-				       SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORKLOAD_PPLIB_CUSTOM_BIT,
-				       (void *)(&activity_monitor_external), true);
-		if (ret) {
-			dev_err(smu->adev->dev, "[%s] Failed to set activity monitor!", __func__);
+	smu_cmn_get_backend_workload_mask(smu, workload_mask,
+					  &backend_workload_mask,
+					  &custom_enabled);
+
+	if (custom_enabled) {
+		ret = smu_v13_0_7_set_power_profile_mode_coeff(smu,
+							       smu->custom_profile_input,
+							       smu->custom_profile_size);
+		if (ret)
 			return ret;
-		}
 	}
 
-	/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
-	workload_type = smu_cmn_to_asic_specific_index(smu,
-						       CMN2ASIC_MAPPING_WORKLOAD,
-						       smu->power_profile_mode);
-	if (workload_type < 0)
-		return -EINVAL;
-
 	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
-				    smu->workload_mask, NULL);
+					      backend_workload_mask, NULL);
 
-	if (ret)
-		dev_err(smu->adev->dev, "[%s] Failed to set work load mask!", __func__);
-	else
-		smu_cmn_assign_power_profile(smu);
+	if (ret) {
+		dev_err(smu->adev->dev, "Failed to set workload mask 0x%08x\n",
+			workload_mask);
+		return ret;
+	}
+
+	smu->backend_workload_mask = backend_workload_mask;
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index 59b369eff30f..272a44b6faf7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -1717,89 +1717,100 @@ static int smu_v14_0_2_get_power_profile_mode(struct smu_context *smu,
 	return size;
 }
 
-static int smu_v14_0_2_set_power_profile_mode(struct smu_context *smu,
-					      long *input,
-					      uint32_t size)
+static int smu_v14_0_2_set_power_profile_mode_coeff(struct smu_context *smu,
+						    long *input,
+						    uint32_t size)
 {
 	DpmActivityMonitorCoeffIntExternal_t activity_monitor_external;
 	DpmActivityMonitorCoeffInt_t *activity_monitor =
 		&(activity_monitor_external.DpmActivityMonitorCoeffInt);
-	int workload_type, ret = 0;
-	uint32_t current_profile_mode = smu->power_profile_mode;
-	smu->power_profile_mode = input[size];
+	int ret;
 
-	if (smu->power_profile_mode >= PP_SMC_POWER_PROFILE_COUNT) {
-		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", smu->power_profile_mode);
+	if (size != 9)
 		return -EINVAL;
+
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
+	switch (input[0]) {
+	case 0: /* Gfxclk */
+		activity_monitor->Gfx_FPS = input[1];
+		activity_monitor->Gfx_MinActiveFreqType = input[2];
+		activity_monitor->Gfx_MinActiveFreq = input[3];
+		activity_monitor->Gfx_BoosterFreqType = input[4];
+		activity_monitor->Gfx_BoosterFreq = input[5];
+		activity_monitor->Gfx_PD_Data_limit_c = input[6];
+		activity_monitor->Gfx_PD_Data_error_coeff = input[7];
+		activity_monitor->Gfx_PD_Data_error_rate_coeff = input[8];
+		break;
+	case 1: /* Fclk */
+		activity_monitor->Fclk_FPS = input[1];
+		activity_monitor->Fclk_MinActiveFreqType = input[2];
+		activity_monitor->Fclk_MinActiveFreq = input[3];
+		activity_monitor->Fclk_BoosterFreqType = input[4];
+		activity_monitor->Fclk_BoosterFreq = input[5];
+		activity_monitor->Fclk_PD_Data_limit_c = input[6];
+		activity_monitor->Fclk_PD_Data_error_coeff = input[7];
+		activity_monitor->Fclk_PD_Data_error_rate_coeff = input[8];
+		break;
+	default:
+		return -EINVAL;
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
+					      u32 workload_mask)
+{
+	u32 backend_workload_mask = 0;
+	bool custom_enabled = false;
+	int ret;
+
+	smu_cmn_get_backend_workload_mask(smu, workload_mask,
+					  &backend_workload_mask,
+					  &custom_enabled);
 
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
+	if (custom_enabled) {
+		ret = smu_v14_0_2_set_power_profile_mode_coeff(smu,
+							       smu->custom_profile_input,
+							       smu->custom_profile_size);
+		if (ret)
+			return ret;
+	}
 
 	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
-										  smu->workload_mask, NULL);
+					      backend_workload_mask, NULL);
+	if (ret) {
+		dev_err(smu->adev->dev, "Failed to set workload mask 0x%08x\n",
+			workload_mask);
+		return ret;
+	}
 
-	if (!ret)
-		smu_cmn_assign_power_profile(smu);
+	smu->backend_workload_mask = backend_workload_mask;
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index fd2aa949538e..91a3bf074f78 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -1141,14 +1141,6 @@ int smu_cmn_set_mp1_state(struct smu_context *smu,
 	return ret;
 }
 
-void smu_cmn_assign_power_profile(struct smu_context *smu)
-{
-	uint32_t index;
-	index = fls(smu->workload_mask);
-	index = index > 0 && index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
-	smu->power_profile_mode = smu->workload_setting[index];
-}
-
 bool smu_cmn_is_audio_func_enabled(struct amdgpu_device *adev)
 {
 	struct pci_dev *p = NULL;
@@ -1226,3 +1218,33 @@ void smu_cmn_generic_plpd_policy_desc(struct smu_dpm_policy *policy)
 {
 	policy->desc = &xgmi_plpd_policy_desc;
 }
+
+void smu_cmn_get_backend_workload_mask(struct smu_context *smu,
+				       u32 workload_mask,
+				       u32 *backend_workload_mask,
+				       bool *custom_enabled)
+{
+	int workload_type;
+	u32 profile_mode;
+
+	*custom_enabled = false;
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
+
+		if (profile_mode == PP_SMC_POWER_PROFILE_CUSTOM)
+			*custom_enabled = true;
+	}
+}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
index 8a801e389659..8d40c02efa00 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
@@ -130,8 +130,6 @@ void smu_cmn_init_soft_gpu_metrics(void *table, uint8_t frev, uint8_t crev);
 int smu_cmn_set_mp1_state(struct smu_context *smu,
 			  enum pp_mp1_state mp1_state);
 
-void smu_cmn_assign_power_profile(struct smu_context *smu);
-
 /*
  * Helper function to make sysfs_emit_at() happy. Align buf to
  * the current page boundary and record the offset.
@@ -149,5 +147,10 @@ bool smu_cmn_is_audio_func_enabled(struct amdgpu_device *adev);
 void smu_cmn_generic_soc_policy_desc(struct smu_dpm_policy *policy);
 void smu_cmn_generic_plpd_policy_desc(struct smu_dpm_policy *policy);
 
+void smu_cmn_get_backend_workload_mask(struct smu_context *smu,
+				       u32 workload_mask,
+				       u32 *backend_workload_mask,
+				       bool *custom_enabled);
+
 #endif
 #endif
-- 
2.47.0

