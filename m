Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0CC606A31B
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Nov 2026 10:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=TjVUHyQw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37F8D10FAEF;
	Wed,  4 Nov 2026 10:22:40 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013002.outbound.protection.outlook.com
 [40.107.201.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E597310FAEE
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Nov 2026 10:22:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZRROqnenUcgNERa2+RbjPI+S8uwLPMTSpb1rbjUyevOd3eBX543fGUplW7SfX/JFrwE2HyidhcpAgFE1/JDELEBuvGKOTxnmzKuC5lh60vnqCOG1CRUyT3G/RRF/ClxfTGYS41ZdG7UciMjp3jsjlK9Qy8EGuOMroKbwqYNe/TU9ZWdYI7ChROsP8c2p7HFQaEadaDHtcisFNMFUBqDb221hrLHIkv1vAQd2o+UXYseUsrErjYh9lyy0S+V9pRHJ6rU8qQfXdrngsilWqgym2si8bnfwu3HE14E8thZXFmHbM338xdwaEK62NRoWietcFtfYHc1BjgM+CexulE+1VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qBlZWBxVyoJEL/3bwV19buR8+fth6OUmkJND+lw5mCc=;
 b=Bt8H2ycnS9QfPG9UmQoov0gcAmWZ8hRuCx70n9eNqXdUyPD7OjpFqVWGGuUdGP+11HUQfjosewczSm7mrbR1E6XWHFypF+vydjpMRIrppCxzivscUdQiifm1yCGnZZFI2qo91ZXt6pukG/1WxEhnnIl1B/UNmZeFHeXeadCpiveSaBa4YPJ/QVPSum9mH5qtXSaTaYVgoamPUef158gj8mPkDO38fEYxUbMD8TJX3lBnPtYOX7drqxmtvcR8devL20946Vcy5LcnFUqFXWQTZKmesYnNuHEBxPRdCHDJ/X9pDgWEtM4FCj1zLWaiLtQjmZ9pfITAqYKOx/eS7olbwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qBlZWBxVyoJEL/3bwV19buR8+fth6OUmkJND+lw5mCc=;
 b=TjVUHyQwacAsjyl/ReKB7anxEF/wzXudueWJ5iG1pMOnpbuJw8jSSXi5+ynkXUuXOltxD0ofovIQz6TLD1xEIRiNxpckYhgARcEVLchbGbVLazzTXQXn63Fdb1d+Zp3Laxam9WXjc2+LMdXqshuE/Iqe/+nM8DUIx2vBcUa487Q=
Received: from DS1PR02CA0025.namprd02.prod.outlook.com (2603:10b6:8:44a::18)
 by DM6PR12MB4299.namprd12.prod.outlook.com (2603:10b6:5:223::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Wed, 4 Nov
 2026 10:22:29 +0000
Received: from CH7PEPF00000015.namprd21.prod.outlook.com
 (2603:10b6:8:44a:cafe::99) by DS1PR02CA0025.outlook.office365.com
 (2603:10b6:8:44a::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Wed, 4
 Nov 2026 10:22:29 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH7PEPF00000015.mail.protection.outlook.com (10.167.244.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.2 via Frontend Transport; Wed, 4 Nov 2026 10:22:29 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 04:22:28 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 04:22:28 -0600
Received: from stxhmapple1.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 4 Nov 2026 04:22:26 -0600
From: Priya Hosur <Priya.Hosur@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Kevin.Wang@amd.com>,
 <Lijo.Lazar@amd.com>, <Christian.Koenig@amd.com>, <Felix.Kuehling@amd.com>
CC: <Priya.Hosur@amd.com>, <Pratik.Vishwakarma@amd.com>,
 <Veerabadhran.Gopalakrishnan@amd.com>
Subject: [PATCH v4 1/1] drm/amd/pm: restore the forced performance level after
 a reset
Date: Wed, 4 Nov 2026 15:52:22 +0530
Message-ID: <abbf127cdaa05bc133605a961ef912dd773dab29.1793787406.git.Priya.Hosur@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1793787406.git.Priya.Hosur@amd.com>
References: <cover.1793787406.git.Priya.Hosur@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH7PEPF00000015:EE_|DM6PR12MB4299:EE_
X-MS-Office365-Filtering-Correlation-Id: ef57aa6b-0732-4ceb-e947-08df3a5d8795
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|10067099003|11063799006|261028144727099003|261009221227099003|261009223027099003|261022105027099003|261021121427099003|56012099006|261021123027099003|261026121527099003|261022075727099003|261026140227099003|22082099003|18002099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: xqOqVrdoj5k2L+icFV0DaJHbix0bwkJCfHRBNTy2P549YYBhE0wfYZQKkEbFybJOH+zQwMF947tG+NbP+erfEAvGcer+CiGsQ5kIwKO504KjkWX60/sJCChzbIJyi6frti+kUTrcNCgfbAdKaPHyeGN1wYTORPaREiXiONKpHMimBU4wDSoT12SAHbga4LHbfY3Pk1YwnMdq96TpSkKn6DImGFu8S4FqUrEWWDisnMZFhz+J/Tbv1DNYQV12a3iy/WBhXSQINkza5jEqp+evYFZRurK88z/t0OeDFWuKI8kcmk8EVd9jbzttSBqh+2bOXE4OHtKYcYjcU5zf298JtLaALDOw6ehv33syF04Yt99FilxAh0+HOf7Jc1BKZ6bVkz9tRLuAUegO8WwsuvIAo5NeMxEaJfpnRZ+/p3nhvmXbDuqWTss+han6tEkxC2oQ4LUNq1rD+F3vKDGDuiOIq5Hlx81pHFPstUkAU5O+RW4YrtrBwhs6POz5N0LDDSMyLlZuHfUfkgCCpOnKz2b8KTFXyxOKZTvSOvO9HSMLfyJLDEvhnVIcwFnTUNdtqOIKCvBYjmwRyRjxVMyc0wrk5272jl31vSVq0QYWwTBpF1rm3s68n4kqBKbPn6mLveKWlO6f2lNQKDtB2mxyMnbKNCbvZfrPAJAUgJ+vcIGC2fpaUnIFTMHWWe5LynKWgiD8xBYkmrJRGXI9pq2T9wwxvA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(10067099003)(11063799006)(261028144727099003)(261009221227099003)(261009223027099003)(261022105027099003)(261021121427099003)(56012099006)(261021123027099003)(261026121527099003)(261022075727099003)(261026140227099003)(22082099003)(18002099003)(261102123227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YcSOzc2FJTV0oPYFlkE+fSB4BjTXdy3ZZ1AvAzDNjlwaOR6Rr+N/BL+Jji4OGojKrN3LXBM4lxsflgAYx7HRI3q3SPmJvtOT7Ik5HHSkGJc7EFE2Z69uCpPDExvgCtfbdb2H9aJF/GqTG6tnDKDp6E9VxBhlKksU/9Q34rHiioSYL0im+U3qEoi4rcTjpWov8YZHymfvsFWVFpxQBPAKTzxsl7XGU8O4i+SIWLE98aEtKjIarUI/f1oTbc9AfI2riAomyKgojZo0WOqeGGiD13fTMBd1RarQefD+XzECA86fqNREqRawXNT6nD7O9zCPldH7hioAuhkWGuhlpQKOQCHnXgVVX2tXGlIDYm8co6luayilvy9es5hTLxV+/VBL99gzqjcnbBT1JtGlL0jCdbLBvCHq0kd4Z605ugZYVpNF6SCz8xZErmmUhWuMxi+8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 10:22:29.0455 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef57aa6b-0732-4ceb-e947-08df3a5d8795
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH7PEPF00000015.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4299
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

After a GPU reset PMFW is reinitialised and comes back on its default
curve, while smu_dpm.dpm_level still holds the level the user forced. On
an SMU 14.0.1 APU with the level set to high, gfxclk drops from 2.8GHz to
600MHz while sysfs still reports high. Writing the same level again does
not help, as amdgpu_dpm_force_performance_level() returns early when the
requested level matches the cached one.

smu_late_init() does not re-program the level either, as the
AMD_PP_TASK_COMPLETE_INIT path compares the cached level against itself.

amdgpu_dpm_reapply_umd_profile() replays the retained level after reset
and resume, but only for the PROFILE_* levels, and returns early for any
other level.

Restore every level through this common path and rename it to
amdgpu_dpm_reapply_performance_level(). The PROFILE_* levels keep their
UMD pstate handling, other levels only replay the level itself. auto is
skipped, as PMFW comes back in auto, as it does at probe. If replaying a
non-profile level fails, the failure is logged and the level the user
asked for is kept.

smu_reapply_power_state_dynamic() duplicates
smu_adjust_power_state_dynamic() with the display settings skipped and
the level forced, so call that instead.

v2: restore the forced level instead of reporting the default after the
    reset (Lijo).

v3: use the force_performance_level argument of
    smu_adjust_power_state_dynamic() instead of switching the cached level
    to auto first.

v4: restore the level through the common reapply path instead of
    smu_handle_task(), rename amdgpu_dpm_reapply_umd_profile() to
    amdgpu_dpm_reapply_performance_level(), replay non-profile levels
    directly and replace the body of smu_reapply_power_state_dynamic()
    (Lijo). Add the Fixes tag (Kevin).

Fixes: 580ad7cbd4b7 ("drm/amdgpu/swsmu: Only force workload setup on init")
Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Priya Hosur <Priya.Hosur@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  4 +--
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c        | 21 +++++++++---
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h    |  2 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c  | 39 ++++------------------
 4 files changed, 26 insertions(+), 40 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 5069042b5279..2f7ef4bb2a65 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2774,9 +2774,9 @@ static int amdgpu_device_ip_late_init(struct amdgpu_device *adev)
 	amdgpu_device_set_cg_state(adev, AMD_CG_STATE_GATE);
 	amdgpu_device_set_pg_state(adev, AMD_PG_STATE_GATE);
 
-	r = amdgpu_dpm_reapply_umd_profile(adev);
+	r = amdgpu_dpm_reapply_performance_level(adev);
 	if (r) {
-		dev_err(adev->dev, "Failed to restore UMD profile state: %d\n", r);
+		dev_err(adev->dev, "Failed to restore performance level: %d\n", r);
 		return r;
 	}
 
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 75d8bb4868e8..ea698fe48e07 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -1083,14 +1083,16 @@ static void amdgpu_dpm_exit_umd_state(struct amdgpu_device *adev)
 }
 
 /**
- * amdgpu_dpm_reapply_umd_profile - Restore the active UMD profile
+ * amdgpu_dpm_reapply_performance_level - Restore the retained DPM level
  * @adev: amdgpu device
  *
  * Resume and reset retain the selected DPM level in software, but the
- * underlying GFX and PMFW state is lost. Reapply a retained UMD profile
- * after the common resume path has restored its default CG and PG state.
+ * underlying GFX and PMFW state is lost. Reapply the retained level after
+ * the common resume path has restored its default CG and PG state. UMD
+ * profile levels also restore their GFX state, other levels only replay
+ * the level itself.
  */
-int amdgpu_dpm_reapply_umd_profile(struct amdgpu_device *adev)
+int amdgpu_dpm_reapply_performance_level(struct amdgpu_device *adev)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 	enum amd_dpm_forced_level level;
@@ -1120,7 +1122,18 @@ int amdgpu_dpm_reapply_umd_profile(struct amdgpu_device *adev)
 	case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK:
 	case AMD_DPM_FORCED_LEVEL_PROFILE_PEAK:
 		break;
+	case AMD_DPM_FORCED_LEVEL_AUTO:
+		/* PMFW comes back in auto, as it does at probe. */
+		ret = 0;
+		goto unlock;
 	default:
+		/* No UMD pstate state to restore, only the level itself. */
+		ret = pp_funcs->reapply_performance_level(adev->powerplay.pp_handle,
+							     level);
+		if (ret)
+			dev_warn(adev->dev,
+				 "Failed to restore performance level %d: %d\n",
+				 level, ret);
 		ret = 0;
 		goto unlock;
 	}
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index ba8624d28f28..8ae3fcc016f8 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -484,7 +484,7 @@ void amdgpu_dpm_set_power_state(struct amdgpu_device *adev,
 enum amd_dpm_forced_level amdgpu_dpm_get_performance_level(struct amdgpu_device *adev);
 int amdgpu_dpm_force_performance_level(struct amdgpu_device *adev,
 				       enum amd_dpm_forced_level level);
-int amdgpu_dpm_reapply_umd_profile(struct amdgpu_device *adev);
+int amdgpu_dpm_reapply_performance_level(struct amdgpu_device *adev);
 int amdgpu_dpm_get_pp_num_states(struct amdgpu_device *adev,
 				 struct pp_states_info *states);
 int amdgpu_dpm_dispatch_task(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index a901f8535598..e45aeb2c565b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2507,33 +2507,7 @@ static int
 smu_reapply_power_state_dynamic(struct smu_context *smu,
 				enum amd_dpm_forced_level level)
 {
-	struct smu_dpm_context *smu_dpm_ctx = &smu->smu_dpm;
-	int ret;
-
-	ret = smu_apply_clocks_adjust_rules(smu);
-	if (ret) {
-		dev_err(smu->adev->dev, "Failed to apply clocks adjust rules!");
-		return ret;
-	}
-
-	ret = smu_asic_set_performance_level(smu, level);
-	if (ret) {
-		if (ret == -EOPNOTSUPP)
-			dev_info(smu->adev->dev, "set performance level %d not supported",
-				 level);
-		else
-			dev_err(smu->adev->dev, "Failed to set performance level %d",
-				level);
-		return ret;
-	}
-
-	smu_dpm_ctx->dpm_level = level;
-
-	if (smu_dpm_ctx->dpm_level == AMD_DPM_FORCED_LEVEL_MANUAL ||
-	    smu_dpm_ctx->dpm_level == AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM)
-		return 0;
-
-	return smu_bump_power_profile_mode(smu, NULL, 0);
+	return smu_adjust_power_state_dynamic(smu, level, true, true);
 }
 
 static int smu_handle_task(struct smu_context *smu,
@@ -2698,21 +2672,20 @@ smu_reapply_performance_level(void *handle,
 	if (!smu->is_apu && !smu_dpm_ctx->dpm_context)
 		return -EINVAL;
 
+	if (smu_dpm_ctx->dpm_level != level)
+		return -EINVAL;
+
 	switch (level) {
 	case AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD:
 	case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK:
 	case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK:
 	case AMD_DPM_FORCED_LEVEL_PROFILE_PEAK:
+		smu_enter_umd_pstate(smu);
 		break;
 	default:
-		return -EINVAL;
+		break;
 	}
 
-	if (smu_dpm_ctx->dpm_level != level)
-		return -EINVAL;
-
-	smu_enter_umd_pstate(smu);
-
 	return smu_reapply_power_state_dynamic(smu, level);
 }
 
-- 
2.43.0

