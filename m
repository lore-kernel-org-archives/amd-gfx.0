Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED7C9CCA470
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Oct 2025 18:03:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 723F110E321;
	Wed,  1 Oct 2025 18:03:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iacvRses";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013025.outbound.protection.outlook.com
 [40.93.196.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 287B610E73C
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Oct 2025 18:03:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YVt1bbG89re9CsxSz/GShF+vJMaFSd1W41IbhCe5AlWtSsQpQ9YPA953d1cJZdXU99sbResg3fojcg2kMSn1bOXFXhyw/67QVnKfKbfjJCNlw27uO8Ca3q+KspdMEzl3vqwiFd0xScwl5g/y1BDposBiSMTBJY4YmzvTFtZJbFNtSPf6tOEzVnfSD1n1Uh6NDtEmUtI5+aP3BImNwFKjvdvSZpvjya2aGL4g1na0JDu4t3SPj0Is9bMsNJ1mtWo3OIt6T1BzQJwydqCAdCbM0vAgLoM0ky9mmpxBQws7zstaQmU8LUsw+t78ym192F+olXO0QmtbHSGeqhYilw2XxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NeGuLObhCqmaF9OoeU6MzbgJmFJppnNjufZACY7iIzM=;
 b=rQT076oXjZn2vLc7smsyfJ7VuM+Id1OnSrFe087O18ty+zlxTLGqHaZZ53MmOTSo68TxcvM7aqHofOZEZR3i5tW1M0L3zr1y7haPCg8BJ4bobiVdbiavprGxk4e6s8vYunkJjdUjmq3irVIh5W2HykdcnLG11gwXWEJBL22r95k+pieJvKybq1VjUYMwDsPmnR760xQ7uXMZVjx1wEAo+NZqPzCPKG0Z4bBWurgwRoGiEAaE4uGbjqI4WhfUlI1/wujwDUqO6P+CA/PBLOcbbUOaF5FZTraoC55S4C87i4y2bZ7H71nWKBnkpo4O286Wy6n+QXbXNeBEFlJXK1rVUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NeGuLObhCqmaF9OoeU6MzbgJmFJppnNjufZACY7iIzM=;
 b=iacvRsesdW9DCvr0A4gRDLZILEs5z+q1aJ0f2Fzf77hZBts+7BfFbwlu42DMqC/BoSSz1INtu2QRLbvV3artimc8hFkqqBwi4PpH2ukG1UWG8Iws6izmD9dCqVaHuHZ3jnDZ9tse4ZQMhNDxq3TsUdfcK7a/34GltSHpVJp2p0s=
Received: from DS7PR03CA0226.namprd03.prod.outlook.com (2603:10b6:5:3ba::21)
 by BL4PR12MB9724.namprd12.prod.outlook.com (2603:10b6:208:4ed::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Wed, 1 Oct
 2025 18:03:54 +0000
Received: from CY4PEPF0000FCBE.namprd03.prod.outlook.com
 (2603:10b6:5:3ba:cafe::21) by DS7PR03CA0226.outlook.office365.com
 (2603:10b6:5:3ba::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.14 via Frontend Transport; Wed,
 1 Oct 2025 18:03:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000FCBE.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.15 via Frontend Transport; Wed, 1 Oct 2025 18:03:53 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 1 Oct 2025 11:03:53 -0700
From: Mario Limonciello <mario.limonciello@amd.com>
To: <mario.limonciello@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: Lijo Lazar <Lijo.Lazar@amd.com>
Subject: [PATCH 2/3] drm/amd: Stop overloading power limit with limit type
Date: Wed, 1 Oct 2025 13:03:34 -0500
Message-ID: <20251001180335.625453-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251001180335.625453-1-mario.limonciello@amd.com>
References: <20251001180335.625453-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBE:EE_|BL4PR12MB9724:EE_
X-MS-Office365-Filtering-Correlation-Id: 3347f9cd-d14d-412d-19fa-08de0114e233
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vBLj0gX0SxeZrH1phiZmbiUHg4v+UioRqWS/NvTK6DhF8sEEgX2dxw+TL796?=
 =?us-ascii?Q?jQKDK3pc7MC+sLwFa5dM+hMPb2v0lsFclcnLy6Jt7BQpVk2RkyIb3qU6m4iH?=
 =?us-ascii?Q?Yv2m7A8doWg29DkawfU/VdpNEAqt8BT2AoTZVy6n6H7KlM0nu8+990n4zfdQ?=
 =?us-ascii?Q?2Kpcc8doVWrsH9ApR4KGSTz3ICqpQge2Gytnee89o7Wt2rBYdbSk6Kd/vw2A?=
 =?us-ascii?Q?vJ4D+1URmlzSLbv414ZJyhI5tjo8Ffm2l1UeXzb2OUrdTbtC2t9NUU2/+3wO?=
 =?us-ascii?Q?xkXAZfD0x+3QEXvqkaueF+jNWHlYkHg7xtWoD5qIDQTsLkPI8uh9COyeu33A?=
 =?us-ascii?Q?MX0DvculUtFXPHxMgNe9+hTQybq3Xw9PbPBINQ3zy0J6N8f4jcsaeHXaU9lI?=
 =?us-ascii?Q?E5Dl5oYDWasRChYdzOBGojbe/t5X3y/O+p8DO72/TTvBPZ1VEhtqMGkamBAW?=
 =?us-ascii?Q?LeMzWI1crCFdh8McCjbHdTEKxigwkfBviiL4ycktpjqAM8OmOMvPXB1y+EaD?=
 =?us-ascii?Q?A58nN2uljhkpljPEhSlRsL4EpXX7PJC+LJ+OQe69JmElMSzRBYOyjVn7GnHx?=
 =?us-ascii?Q?j7FW8ORSxEWcEc0A4qbIX+1N5QBxk1EZLpPvZqJqeyyGSMOYWCgCblU9JId1?=
 =?us-ascii?Q?lEiydtdPywTcixy38uF52LOn5+sR31Ejp/f3wcIT5j88zgjnu3Qvq1XpnAEp?=
 =?us-ascii?Q?Gs21qHLKAcmtqLOJAft41mkh8esLxTqXC6LIT4Q7z6LN4zkv3JfHT/lipdIk?=
 =?us-ascii?Q?/j2WCd7tDB0xF/qOQsMooAX2FpEriGwZ81Y4b3ixP30Ta+izq8pB3slREyFN?=
 =?us-ascii?Q?s5Bc1qUXuSRDW5t5SlLTB6NZRqF0+PlNHUxSMO7XedaL4hYw2Z18TIikXgpw?=
 =?us-ascii?Q?QAoW9l7Z8xO9nlSgTV/bOpUDE6bbTz+ON8SDr/OEr1bXnccuKc0SNKZHO2Dm?=
 =?us-ascii?Q?csCPDKgFSMESQZ6CF270JVqGEBpnEtLuZu7oKDRdSyJiLRP19QMnqtFnJr+O?=
 =?us-ascii?Q?DBzn4xAwJM21UuwzOGBDJ8+H7/pJTestxewR7/anqYuVUcjywmUxqsozvQqP?=
 =?us-ascii?Q?9SGvvZROXXpSvLDf5yRegJQgfRZZNswB0m77O9Q11A/b3wTv2MqoHeALf+SS?=
 =?us-ascii?Q?4E8uTP3hpX/yQP5XS6YlTvcBMYHNukXg5dZ+1d9Keg/s2aaKdXaFEfOC9v8i?=
 =?us-ascii?Q?jtUnWbrHWsjapixTS6HOBUkDi07o9HgWgqi/5+1tTJDHlndmiQ1rJG3qktbT?=
 =?us-ascii?Q?XKAAz9ayqvS4UGzAn6votcdaWaorxFs9wsIYQXcG5pePWjb2McZHMjucFLJD?=
 =?us-ascii?Q?2jyj/QlbHSpSCbI9ICmvzt1zqE2lnGNw5Yf2jBhgYPng/xysW8HzZdMYKVcK?=
 =?us-ascii?Q?k81ao5lhpOJgjR0sBjIuuU9vLvdaOf1fn8m+OoagnvzWKMu/KTuvKniGxEo1?=
 =?us-ascii?Q?hWCftSscjczqmRusLAUCg8vH3EyWyR5RdGl18KRJBEZ2D5tReWjt6eN91rnJ?=
 =?us-ascii?Q?zNKPnjsSMxHnkkEXK5jIRlwbvX3/PQRFcEjM4b1psxENms6TLeg/KrD91Ybb?=
 =?us-ascii?Q?lbysvpIiESU5uNZh+Cw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 18:03:53.8253 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3347f9cd-d14d-412d-19fa-08de0114e233
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCBE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9724
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

When passed around internally the upper 8 bits of power limit include
the limit type.  This is non-obvious without digging into the nuances
of each function.  Instead pass the limit type as an argument to all
applicable layers.

When the limit type is passed around it is apparent that the user
settings for power limits are only being restored for default limit
not fast limit.  Save and restore both.

Cc: Lijo Lazar <Lijo.Lazar@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 .../gpu/drm/amd/include/kgd_pp_interface.h    |  2 +-
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           |  3 +-
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            |  3 +-
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  2 +-
 .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  |  2 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 39 +++++++++++++------
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  3 +-
 7 files changed, 35 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index 20e11997437f..21a83ee87d84 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -445,7 +445,7 @@ struct amd_pm_funcs {
 				bool gate,
 				int inst);
 	int (*set_clockgating_by_smu)(void *handle, uint32_t msg_id);
-	int (*set_power_limit)(void *handle, uint32_t n);
+	int (*set_power_limit)(void *handle, uint32_t limit_type, uint32_t n);
 	int (*get_power_limit)(void *handle, uint32_t *limit,
 			enum pp_power_limit_level pp_limit_level,
 			enum pp_power_type power_type);
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 71d986dd7a6e..3458a7d4892f 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -1605,6 +1605,7 @@ int amdgpu_dpm_get_power_limit(struct amdgpu_device *adev,
 }
 
 int amdgpu_dpm_set_power_limit(struct amdgpu_device *adev,
+			       uint32_t limit_type,
 			       uint32_t limit)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
@@ -1615,7 +1616,7 @@ int amdgpu_dpm_set_power_limit(struct amdgpu_device *adev,
 
 	mutex_lock(&adev->pm.mutex);
 	ret = pp_funcs->set_power_limit(adev->powerplay.pp_handle,
-					limit);
+					limit_type, limit);
 	mutex_unlock(&adev->pm.mutex);
 
 	return ret;
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 08cd324515ad..37428eadfd09 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -3172,13 +3172,12 @@ static ssize_t amdgpu_hwmon_set_power_cap(struct device *dev,
 		return err;
 
 	value = value / 1000000; /* convert to Watt */
-	value |= limit_type << 24;
 
 	err = amdgpu_pm_get_access(adev);
 	if (err < 0)
 		return err;
 
-	err = amdgpu_dpm_set_power_limit(adev, value);
+	err = amdgpu_dpm_set_power_limit(adev, limit_type, value);
 
 	amdgpu_pm_put_access(adev);
 
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index 768317ee1486..4291471187f6 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -555,7 +555,7 @@ int amdgpu_dpm_get_power_limit(struct amdgpu_device *adev,
 			       enum pp_power_limit_level pp_limit_level,
 			       enum pp_power_type power_type);
 int amdgpu_dpm_set_power_limit(struct amdgpu_device *adev,
-			       uint32_t limit);
+			       uint32_t limit_type, uint32_t limit);
 int amdgpu_dpm_is_cclk_dpm_supported(struct amdgpu_device *adev);
 int amdgpu_dpm_debugfs_print_current_performance_level(struct amdgpu_device *adev,
 						       struct seq_file *m);
diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
index 9041002dea6a..ba72b08a0edc 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
@@ -952,7 +952,7 @@ static int pp_dpm_switch_power_profile(void *handle,
 	return 0;
 }
 
-static int pp_set_power_limit(void *handle, uint32_t limit)
+static int pp_set_power_limit(void *handle, uint32_t limit_type, uint32_t limit)
 {
 	struct pp_hwmgr *hwmgr = handle;
 	uint32_t max_power_limit;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 431333060b72..a5f40503b0b6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -68,7 +68,7 @@ static int smu_handle_task(struct smu_context *smu,
 static int smu_reset(struct smu_context *smu);
 static int smu_set_fan_speed_pwm(void *handle, u32 speed);
 static int smu_set_fan_control_mode(void *handle, u32 value);
-static int smu_set_power_limit(void *handle, uint32_t limit);
+static int smu_set_power_limit(void *handle, uint32_t limit_type, uint32_t limit);
 static int smu_set_fan_speed_rpm(void *handle, uint32_t speed);
 static int smu_set_gfx_cgpg(struct smu_context *smu, bool enabled);
 static int smu_set_mp1_state(void *handle, enum pp_mp1_state mp1_state);
@@ -508,11 +508,18 @@ static void smu_restore_dpm_user_profile(struct smu_context *smu)
 	/* Enable restore flag */
 	smu->user_dpm_profile.flags |= SMU_DPM_USER_PROFILE_RESTORE;
 
-	/* set the user dpm power limit */
-	if (smu->user_dpm_profile.power_limit) {
-		ret = smu_set_power_limit(smu, smu->user_dpm_profile.power_limit);
+	/* set the user dpm power limits */
+	if (smu->user_dpm_profile.power_limit_default) {
+		ret = smu_set_power_limit(smu, SMU_DEFAULT_PPT_LIMIT,
+					  smu->user_dpm_profile.power_limit_default);
 		if (ret)
-			dev_err(smu->adev->dev, "Failed to set power limit value\n");
+			dev_err(smu->adev->dev, "Failed to set default power limit value\n");
+	}
+	if (smu->user_dpm_profile.power_limit_fast) {
+		ret = smu_set_power_limit(smu, SMU_FAST_PPT_LIMIT,
+					  smu->user_dpm_profile.power_limit_fast);
+		if (ret)
+			dev_err(smu->adev->dev, "Failed to set fast power limit value\n");
 	}
 
 	/* set the user dpm clock configurations */
@@ -2229,7 +2236,7 @@ static int smu_resume(struct amdgpu_ip_block *ip_block)
 	adev->pm.dpm_enabled = true;
 
 	if (smu->current_power_limit) {
-		ret = smu_set_power_limit(smu, smu->current_power_limit);
+		ret = smu_set_power_limit(smu, SMU_DEFAULT_PPT_LIMIT, smu->current_power_limit);
 		if (ret && ret != -EOPNOTSUPP)
 			return ret;
 	}
@@ -2929,16 +2936,14 @@ int smu_get_power_limit(void *handle,
 	return ret;
 }
 
-static int smu_set_power_limit(void *handle, uint32_t limit)
+static int smu_set_power_limit(void *handle, uint32_t limit_type, uint32_t limit)
 {
 	struct smu_context *smu = handle;
-	uint32_t limit_type = limit >> 24;
 	int ret = 0;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
-	limit &= (1<<24)-1;
 	if ((limit > smu->max_power_limit) || (limit < smu->min_power_limit)) {
 		dev_err(smu->adev->dev,
 			"New power limit (%d) is out of range [%d,%d]\n",
@@ -2951,11 +2956,21 @@ static int smu_set_power_limit(void *handle, uint32_t limit)
 
 	if (smu->ppt_funcs->set_power_limit) {
 		ret = smu->ppt_funcs->set_power_limit(smu, limit_type, limit);
-		if (!ret && !(smu->user_dpm_profile.flags & SMU_DPM_USER_PROFILE_RESTORE))
-			smu->user_dpm_profile.power_limit = limit;
+		if (ret)
+			return ret;
+		if (!(smu->user_dpm_profile.flags & SMU_DPM_USER_PROFILE_RESTORE)) {
+			switch (limit_type) {
+			case SMU_DEFAULT_PPT_LIMIT:
+				smu->user_dpm_profile.power_limit_default = limit;
+				break;
+			case SMU_FAST_PPT_LIMIT:
+				smu->user_dpm_profile.power_limit_fast = limit;
+				break;
+			};
+		}
 	}
 
-	return ret;
+	return 0;
 }
 
 static int smu_print_smuclk_levels(struct smu_context *smu, enum smu_clk_type clk_type, char *buf)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index b52e194397e2..19689ef1db99 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -231,7 +231,8 @@ enum smu_memory_pool_size {
 
 struct smu_user_dpm_profile {
 	uint32_t fan_mode;
-	uint32_t power_limit;
+	uint32_t power_limit_default;
+	uint32_t power_limit_fast;
 	uint32_t fan_speed_pwm;
 	uint32_t fan_speed_rpm;
 	uint32_t flags;
-- 
2.51.0

