Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCA5ED0BB79
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Oct 2024 08:59:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 816A710E8D7;
	Thu, 24 Oct 2024 08:59:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jsnQrqcy";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2077.outbound.protection.outlook.com [40.107.102.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C1FD10E8D7
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Oct 2024 08:59:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RU1nnXtAWnH21eSj5/860tdWHD+RFpNQ/kFfcD+Mj8ccp21AsF+0bHyUuBgiUgbgfdgDNzVEuD0bc1U/+Nds6gPkf7FQjMVD1GZW/2I/JJXl3VrUrK8vzf6gGC6ca6kmkEfC2P2zbrKB3QxJQvxX6tToGss6Aor/RJ8TXIxviMLs0cn5SQHpzkeZff2VxS+QJHKZGcpHAaNQO0kl1UPi7gKCmxPPWG7NinXrPyQFE9oOyEkLiKig5gADU32eezH96+SvrRHRTMspJHhJIla/K71/3ZZo68pJhhnqHMv8724QZzjksdXkzgy3L2Ek0qWgOi4Ly+7fqIL/S/RqTsUjqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wOi0wKW15zn6eknTwm1h9Xy0a1RtvBtIyJc0SfJov2s=;
 b=MeI9sFgIywf9/8tpCY/oU8sc+lMQA3bB7at9HVzSsWo4cq4QB4rfn+uTnU0yRrj8AZ5l+0QD0sO8/UMc1xQ7btO68AVrzeufrrx8eMKagNdvYJA6X69+4+OetVhGdpxesCdc5pLYX4/Y3aeujV6VKUs+NF1k8ZPk83KqY3K5hE6TL0/LIMum7R0IpILmDQnX5jzjLQEe/DXHmCZODP8ZtTUQyeRa6NjtK5utlWF9HH0a2+Be1XZaXDk5OFcxZlLDizjDBRHp0cQxZjdQhNwGxR0UoEyq7XjodDTxI3SLLy3AGzzyNcrO4Xgqx+35NB3o4E5psR24V7MNl4hLolRPLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wOi0wKW15zn6eknTwm1h9Xy0a1RtvBtIyJc0SfJov2s=;
 b=jsnQrqcyKd0l6A3pZf8FUMESwsCJzX5WPnXtu4mLWOMPny/QIYzBVhBNlxpUqa89Mwe6BgAg8AC3OwDbzbQAw51bQQJfbqjYPignhCAztQCKXBANmRbp2gKHHuUTtReKaJ6shtGXmnFGSefaOv9tfLRHDyzpJZ6El1hlyzn9mYU=
Received: from BY5PR13CA0036.namprd13.prod.outlook.com (2603:10b6:a03:180::49)
 by SA0PR12MB4461.namprd12.prod.outlook.com (2603:10b6:806:9c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Thu, 24 Oct
 2024 08:59:34 +0000
Received: from SJ1PEPF00001CE2.namprd05.prod.outlook.com
 (2603:10b6:a03:180:cafe::51) by BY5PR13CA0036.outlook.office365.com
 (2603:10b6:a03:180::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.5 via Frontend
 Transport; Thu, 24 Oct 2024 08:59:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE2.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Thu, 24 Oct 2024 08:59:34 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 24 Oct
 2024 03:59:33 -0500
Received: from kenneth-mlse-vm.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via
 Frontend Transport; Thu, 24 Oct 2024 03:59:31 -0500
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <Alexander.Deucher@amd.com>, Kenneth Feng
 <kenneth.feng@amd.com>
Subject: [PATCH v2] drm/amd/pm: correct the workload setting
Date: Thu, 24 Oct 2024 16:59:26 +0800
Message-ID: <20241024085926.25349-1-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: kenneth.feng@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE2:EE_|SA0PR12MB4461:EE_
X-MS-Office365-Filtering-Correlation-Id: bfc5e3b8-e7f4-4e50-34be-08dcf40a2e3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fZKKq9hGz08SN9fe8SWYt0VxirqS2A9h8gpkmSvUdLJsMGMekhpInb+pOeCT?=
 =?us-ascii?Q?Z+6GoF+56Co4fEwnoaiI26pwid/teYLQ3EwgrZvPGLfDzF8ebHi/RKEU9nQx?=
 =?us-ascii?Q?dKXdWI3UBXqbG5184vQXCcm9LvhB4o/YeK3irVJiHhLji/L9YP9JWaPdt0rt?=
 =?us-ascii?Q?y0pqwqrVvUX2jgbFJNiWQ/w+S0RwviaE3uruFMDSzfJqtw8b2z58AtMhCAEy?=
 =?us-ascii?Q?l/1Tl/oxq8cmNSOPfUyNU60bBICGsJVXFAO97BuoDR3J7VYhhUUCNUNdikxT?=
 =?us-ascii?Q?OlzScW2sYb3Nm+a6ke3/Ev1vLRCNkRi2fQ3bSzAma09wOroyR7N9Lm3/rNM5?=
 =?us-ascii?Q?KWMvNKAICSNvbijGqpZRZblfWBjQn6iiKbOi75XSKUWWSk07G632Oh5npRXp?=
 =?us-ascii?Q?5DSQaynwwjQf45OgUVRkSp14T8tX+CBqncHlKFwJvaUR2Z527JSq49WPta7p?=
 =?us-ascii?Q?UXxy0QtPDxYChGdadTgfUszzN/KAnajZ7hHzjqrC11E8vC31/UTYndICbvo4?=
 =?us-ascii?Q?J29jRhbOp8GGLyMVel8u7WGhq7t9a5hYgkFguDPfJWP2gB/Bwj6TNwtim9nj?=
 =?us-ascii?Q?IYDnEf1qqGrHKrG39zoTJGMC+Abl0Nqs+BlnQsHp46AjN3DBClGskRKAerQf?=
 =?us-ascii?Q?AENVrztnP7sDOr5NEaGBr04LcVEK6dTYn1FxvjE+R8/WfkjRCyIlpGk5oFfr?=
 =?us-ascii?Q?gfyY9fggOx73YR9FMIT7FqNEHGQf5o2J8A07fAG78fC0SMMumziSQFLjGDup?=
 =?us-ascii?Q?CZpjEog/GFF0YaKisMWloH6o8E4BNPDCZ2y+JOMsB9UT/7KGkoWTKypo1JD1?=
 =?us-ascii?Q?916Jk0yq2S09vwMG+zOvN3V3YO88FgHjA8z24xZGhMKWrCEnJ8HVsiIeGCci?=
 =?us-ascii?Q?saRFJGeamAvBasHl0U4SWz6StdQrcGwfaYWYQP4NBLV3fFyapMSOGiikjtKc?=
 =?us-ascii?Q?awkI3vMNgobEuv4sk+1sAY4lEOP5MEIb7bXRr8Db+eY9d7uTKod8qOrrRZQW?=
 =?us-ascii?Q?OdZ+H7Imwcfz1IDLsNZyZAEfbuMgOEySifTR+sLUwjFYkOgimGcWSQbfgmUr?=
 =?us-ascii?Q?0+bFBHCs6/kW1VZCjrcONp7R0Ud1tHxAH+u/jjI2m5YuGBvzD4743o33VtwK?=
 =?us-ascii?Q?9jhJU2L41pWXaaCmloUPK09oNaX7WePyV1IfNV6YGlZKSAWUxZcxBysANs1U?=
 =?us-ascii?Q?kAkwk7QMZe4bZDk7at3rhQ0dY9c/zrn5zfalLcIEVSuWHxJRZS2TcYiw3L72?=
 =?us-ascii?Q?gv2a4HHL8YLE8M/Pzmi2zQEB6ELyO+BUhr+eVRnkumhnbiPIzyzeHYt4Y2t/?=
 =?us-ascii?Q?4bnGKn9gAvtayccUnBoSc3fUOhIIWVUUv/Kd2mxvd9unK+Btwone9/Fi0lUi?=
 =?us-ascii?Q?+5DOJD00DkH4k3LgpyMqdnpOMKhB/w7Wxuhu0IBbh8gMwkJxHw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 08:59:34.0843 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bfc5e3b8-e7f4-4e50-34be-08dcf40a2e3b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4461
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

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 44 +++++++++++++------
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  5 ++-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 31 +++++++++++--
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 25 +++++++++--
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  | 28 +++++++++---
 5 files changed, 106 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 8d4aee4e2287..1de576461a70 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1261,25 +1261,31 @@ static int smu_sw_init(struct amdgpu_ip_block *ip_block)
 	smu->watermarks_bitmap = 0;
 	smu->power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
 	smu->default_power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
+	smu->user_dpm_profile.user_workload_mask = 0;
+	smu->user_dpm_profile.prev_user_workload_mask = 0;
 
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
+		smu->workload_mask = 1 << smu->workload_priority[PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT];
+	} else {
+		smu->workload_mask = 1 << smu->workload_priority[PP_SMC_POWER_PROFILE_FULLSCREEN3D];
+		smu->default_power_profile_mode = PP_SMC_POWER_PROFILE_FULLSCREEN3D;
+	}
+
+	smu->driver_workload_mask = smu->workload_mask;
 
 	smu->workload_setting[0] = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
 	smu->workload_setting[1] = PP_SMC_POWER_PROFILE_FULLSCREEN3D;
@@ -2354,12 +2360,14 @@ static int smu_switch_power_profile(void *handle,
 		return -EINVAL;
 
 	if (!en) {
-		smu->workload_mask &= ~(1 << smu->workload_prority[type]);
+		smu->workload_mask &= ~(1 << smu->workload_priority[type]);
+		smu->driver_workload_mask &= ~(1 << smu->workload_priority[type]);
 		index = fls(smu->workload_mask);
 		index = index > 0 && index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
 		workload[0] = smu->workload_setting[index];
 	} else {
-		smu->workload_mask |= (1 << smu->workload_prority[type]);
+		smu->workload_mask |= (1 << smu->workload_priority[type]);
+		smu->driver_workload_mask |= (1 << smu->workload_priority[type]);
 		index = fls(smu->workload_mask);
 		index = index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
 		workload[0] = smu->workload_setting[index];
@@ -3054,12 +3062,20 @@ static int smu_set_power_profile_mode(void *handle,
 				      uint32_t param_size)
 {
 	struct smu_context *smu = handle;
+	int ret;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled ||
 	    !smu->ppt_funcs->set_power_profile_mode)
 		return -EOPNOTSUPP;
 
-	return smu_bump_power_profile_mode(smu, param, param_size);
+	smu->user_dpm_profile.prev_user_workload_mask =
+			smu->user_dpm_profile.user_workload_mask;
+	smu->user_dpm_profile.user_workload_mask = (1 << smu->workload_priority[param[param_size]]);
+	ret = smu_bump_power_profile_mode(smu, param, param_size);
+	smu->user_dpm_profile.prev_user_workload_mask =
+			smu->user_dpm_profile.user_workload_mask;
+
+	return ret;
 }
 
 static int smu_get_fan_control_mode(void *handle, u32 *fan_mode)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 8bb32b3f0d9c..88294d986b36 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -240,6 +240,8 @@ struct smu_user_dpm_profile {
 	/* user clock state information */
 	uint32_t clk_mask[SMU_CLK_COUNT];
 	uint32_t clk_dependency;
+	uint32_t user_workload_mask;
+	uint32_t prev_user_workload_mask;
 };
 
 #define SMU_TABLE_INIT(tables, table_id, s, a, d)	\
@@ -557,7 +559,8 @@ struct smu_context {
 	bool disable_uclk_switch;
 
 	uint32_t workload_mask;
-	uint32_t workload_prority[WORKLOAD_POLICY_MAX];
+	uint32_t driver_workload_mask;
+	uint32_t workload_priority[WORKLOAD_POLICY_MAX];
 	uint32_t workload_setting[WORKLOAD_POLICY_MAX];
 	uint32_t power_profile_mode;
 	uint32_t default_power_profile_mode;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 3e2277abc754..0733fd3efd8b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -2474,9 +2474,22 @@ static int smu_v13_0_0_set_power_profile_mode(struct smu_context *smu,
 		&(activity_monitor_external.DpmActivityMonitorCoeffInt);
 	int workload_type, ret = 0;
 	u32 workload_mask;
+	uint32_t index;
 
 	smu->power_profile_mode = input[size];
 
+	if (smu->user_dpm_profile.prev_user_workload_mask !=
+		smu->user_dpm_profile.user_workload_mask) {
+		if (smu->workload_mask & smu->user_dpm_profile.prev_user_workload_mask &&
+			!(smu->driver_workload_mask & smu->user_dpm_profile.prev_user_workload_mask))
+			smu->workload_mask &= ~smu->user_dpm_profile.prev_user_workload_mask;
+
+		if (input[size] != smu->default_power_profile_mode) {
+			smu->workload_mask &= ~(1 << smu->workload_priority[smu->default_power_profile_mode]);
+			smu->driver_workload_mask &= ~(1 << smu->workload_priority[smu->default_power_profile_mode]);
+		}
+	}
+
 	if (smu->power_profile_mode >= PP_SMC_POWER_PROFILE_COUNT) {
 		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", smu->power_profile_mode);
 		return -EINVAL;
@@ -2555,12 +2568,24 @@ static int smu_v13_0_0_set_power_profile_mode(struct smu_context *smu,
 			workload_mask |= 1 << workload_type;
 	}
 
+	smu->workload_mask |= workload_mask;
 	ret = smu_cmn_send_smc_msg_with_param(smu,
 					       SMU_MSG_SetWorkloadMask,
-					       workload_mask,
+					       smu->workload_mask,
 					       NULL);
-	if (!ret)
-		smu->workload_mask = workload_mask;
+	if (!ret) {
+		index = fls(smu->workload_mask);
+		index = index > 0 && index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
+		smu->power_profile_mode = smu->workload_setting[index];
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
index 23f13388455f..2323c74ee50b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -2429,9 +2429,22 @@ static int smu_v13_0_7_set_power_profile_mode(struct smu_context *smu, long *inp
 	DpmActivityMonitorCoeffInt_t *activity_monitor =
 		&(activity_monitor_external.DpmActivityMonitorCoeffInt);
 	int workload_type, ret = 0;
+	uint32_t index;
 
 	smu->power_profile_mode = input[size];
 
+	if (smu->user_dpm_profile.prev_user_workload_mask !=
+		smu->user_dpm_profile.user_workload_mask) {
+		if (smu->workload_mask & smu->user_dpm_profile.prev_user_workload_mask &&
+			!(smu->driver_workload_mask & smu->user_dpm_profile.prev_user_workload_mask))
+			smu->workload_mask &= ~smu->user_dpm_profile.prev_user_workload_mask;
+
+		if (input[size] != smu->default_power_profile_mode) {
+			smu->workload_mask &= ~(1 << smu->workload_priority[smu->default_power_profile_mode]);
+			smu->driver_workload_mask &= ~(1 << smu->workload_priority[smu->default_power_profile_mode]);
+		}
+	}
+
 	if (smu->power_profile_mode > PP_SMC_POWER_PROFILE_WINDOW3D) {
 		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", smu->power_profile_mode);
 		return -EINVAL;
@@ -2487,13 +2500,19 @@ static int smu_v13_0_7_set_power_profile_mode(struct smu_context *smu, long *inp
 						       smu->power_profile_mode);
 	if (workload_type < 0)
 		return -EINVAL;
+
+	smu->workload_mask |= (1 << workload_type);
 	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
-				    1 << workload_type, NULL);
+				    smu->workload_mask, NULL);
 
 	if (ret)
 		dev_err(smu->adev->dev, "[%s] Failed to set work load mask!", __func__);
-	else
-		smu->workload_mask = (1 << workload_type);
+
+	if (!ret) {
+		index = fls(smu->workload_mask);
+		index = index > 0 && index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
+		smu->power_profile_mode = smu->workload_setting[index];
+	}
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index cefe10b95d8e..c2fd47f04e2d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -1787,9 +1787,22 @@ static int smu_v14_0_2_set_power_profile_mode(struct smu_context *smu,
 	DpmActivityMonitorCoeffInt_t *activity_monitor =
 		&(activity_monitor_external.DpmActivityMonitorCoeffInt);
 	int workload_type, ret = 0;
+	uint32_t index;
 	uint32_t current_profile_mode = smu->power_profile_mode;
 	smu->power_profile_mode = input[size];
 
+	if (smu->user_dpm_profile.prev_user_workload_mask !=
+		smu->user_dpm_profile.user_workload_mask) {
+		if (smu->workload_mask & smu->user_dpm_profile.prev_user_workload_mask &&
+			!(smu->driver_workload_mask & smu->user_dpm_profile.prev_user_workload_mask))
+			smu->workload_mask &= ~smu->user_dpm_profile.prev_user_workload_mask;
+
+		if (input[size] != smu->default_power_profile_mode) {
+			smu->workload_mask &= ~(1 << smu->workload_priority[smu->default_power_profile_mode]);
+			smu->driver_workload_mask &= ~(1 << smu->workload_priority[smu->default_power_profile_mode]);
+		}
+	}
+
 	if (smu->power_profile_mode >= PP_SMC_POWER_PROFILE_COUNT) {
 		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", smu->power_profile_mode);
 		return -EINVAL;
@@ -1857,12 +1870,15 @@ static int smu_v14_0_2_set_power_profile_mode(struct smu_context *smu,
 	if (workload_type < 0)
 		return -EINVAL;
 
-	ret = smu_cmn_send_smc_msg_with_param(smu,
-					       SMU_MSG_SetWorkloadMask,
-					       1 << workload_type,
-					       NULL);
-	if (!ret)
-		smu->workload_mask = 1 << workload_type;
+	smu->workload_mask |= (1 << workload_type);
+	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
+										  smu->workload_mask, NULL);
+
+	if (!ret) {
+		index = fls(smu->workload_mask);
+		index = index > 0 && index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
+		smu->power_profile_mode = smu->workload_setting[index];
+	}
 
 	return ret;
 }
-- 
2.34.1

