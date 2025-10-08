Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60227CAC5BB
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Oct 2025 19:12:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0015810E8CF;
	Wed,  8 Oct 2025 19:12:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2ndtCXb/";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013003.outbound.protection.outlook.com
 [40.107.201.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2989910E8CF
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Oct 2025 19:12:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=juAxywVIOdBcWegesAQpN4p3TVYDdfQIHRWB8bBEn3BncBnNC/X7M4bJal6pvMUyj8vWzULbGb04jFHazK04+SHPLyCwN0VVYnAcb+GQczFfir1fSxwkY95b5aOWmDPyn8PxW4YD31dgJu1VJjaU1JfneAusapSkuQiLFGxONmA637OydvPik3+1dPjdiH0J/FaUlFWBS5TQAWVpHmpSQf/+a2yl4EvaeRD/9TUxhrqfdjYx5IKRCURtEEvXSSDJ4wZ7b1chmmgcUZVeAOiuwrMml+DQwPtl6SpDgiT6chP/zni0Sw52N4OAHKLtcCJb56fFbmEEpUkLrOhpxwOnuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F4VvdSBwojSgjFt+5P3lTwtd4XjMTrTtR/TohTdGEIk=;
 b=wvEEpjeAcy4i1ZZs+GMJIdLpvjXFYdbPhlDebAlhoZPsfPzSagqOx2v+nRIdAaKLHSKms0qoUyjubRxFd2JCrRo1ItGR/iXc/fsO7g5LeZ3nomPDmREYL2njUuiiEt9L4B97G5dOvUnlklB+V6XB93MahqM++W8PBOdaM9uP3pf+L8bfZ3GBNHyKLDibBIuFi4AxVRrB+YSyK5uCkNBph7C6PB71qipZh5ioUNhjZHY7iSwHb4FeSFeyb30wWFC7GUlU5O2AfReg3ji+5yX4prRaeCnx3WFDB+KIzz7Kvm2L2h3A3UALxwF7wQDJIb7Z0SgflCGPev969e9cfBXfeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F4VvdSBwojSgjFt+5P3lTwtd4XjMTrTtR/TohTdGEIk=;
 b=2ndtCXb/5HPF++anYSoxIKkmyrG/eA9AgO+BWZvId+dOD39cfrWHFbJfium2m9Vj5b7jG60sKPypDbMpP2m7l2K/0ptodJYmd5e/5reymfJhJgKTLVUwDb4Vizd7mRMPW5R6Xjl5Tm3+nDnkZI9bRlFE/o7qw1hvJaouJ3KLsLs=
Received: from BN0PR08CA0014.namprd08.prod.outlook.com (2603:10b6:408:142::23)
 by DS0PR12MB9445.namprd12.prod.outlook.com (2603:10b6:8:1a1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Wed, 8 Oct
 2025 19:12:29 +0000
Received: from BN2PEPF000055E1.namprd21.prod.outlook.com
 (2603:10b6:408:142:cafe::56) by BN0PR08CA0014.outlook.office365.com
 (2603:10b6:408:142::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.19 via Frontend Transport; Wed,
 8 Oct 2025 19:12:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000055E1.mail.protection.outlook.com (10.167.245.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.3 via Frontend Transport; Wed, 8 Oct 2025 19:12:29 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 8 Oct 2025 12:12:13 -0700
From: Mario Limonciello <mario.limonciello@amd.com>
To: <mario.limonciello@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: Robert Beckett <bob.beckett@collabora.com>, Lijo Lazar <lijo.lazar@amd.com>
Subject: [PATCH v4 2/6] drm/amd: Stop overloading power limit with limit type
Date: Wed, 8 Oct 2025 14:11:49 -0500
Message-ID: <20251008191153.3145554-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251008191153.3145554-1-mario.limonciello@amd.com>
References: <20251008191153.3145554-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E1:EE_|DS0PR12MB9445:EE_
X-MS-Office365-Filtering-Correlation-Id: 612ab65a-3fe0-47f9-01cb-08de069e9ff4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zHQeKdDiOJOvqJU/ldQz4b2SXSc8rSXApAzvpmlpWbbwq3RBFENCZVWQrnqv?=
 =?us-ascii?Q?cArK3JeePtjmaJvq191dOe1/vQRKXgzdozQ/Igyik5JN8mx5yIH/T76yqopO?=
 =?us-ascii?Q?Omar8YSqEZPFleIZRVHWGRmGT4HD8eMJWXJp4cd7V94CVk5SaRymB5VQ/Rxx?=
 =?us-ascii?Q?wl/R/wbm9rZSjDDl+bVeU4+PQ3+g7U6G/jHAbKqPxvwapYLdQqHPfwYQK5sE?=
 =?us-ascii?Q?An6TLCaVlM40sFKavckV2Eqyv5upR798Mpc39UjEGf/myfSyl3ZH59ilzFWy?=
 =?us-ascii?Q?ZuNT1fZmjnm4C7tVfRcoUbfmEf/dEW04Q+UcydXH3b+07bVS2mJiO2jyQsh+?=
 =?us-ascii?Q?zET/u1dwWsMz2Roe67yyTkgHsOAjRpxETw03dCGgpUHcEz7KAI7/g4BkAC+B?=
 =?us-ascii?Q?TREDcnRetgiC0VPqwYHZDM9a6lNuyzk4HSyTEaoJtsYgE1MP2Tp1P9rPNTAp?=
 =?us-ascii?Q?wFz62PDLTRSMWW8CBJEh6DhWpSw55+mIsBMnTB1e4ApxJHCvn2Xp+zkxZlsi?=
 =?us-ascii?Q?Zlz0SGfnwnaOFlEDbzpuox3Hsj5uDMRR0hUFpDm3/XyrdoR0DjaR84oH1bZG?=
 =?us-ascii?Q?NXUXyWwULUScpgXIa809iQPyYFY7iq1fsxzvkcuIGbFGy/6KL2C7PKQ0AGfg?=
 =?us-ascii?Q?MWA6ChrbBPlNS7NOptm0iOxeQhJRQ30OSvnuZ/09PFoNmmPZxfHL5TCbWEh1?=
 =?us-ascii?Q?J69D87+jH0+swDatxEvnJlDkX2fEalIhSCkDVWjuq3B0XTkp0L4QYF2Hr3fg?=
 =?us-ascii?Q?NSbIGtvsiL714svqPdeSIRsifSyGi1UG8AqGGur0W5h5RZUkjNlY8DZmgv5i?=
 =?us-ascii?Q?EAkpwarnZ0097SmKtS5BkhKEFvWtxh2uezhUpLy3mRNAV7PZ9VoS6K4F0mzl?=
 =?us-ascii?Q?eL3mefxyS7y1TTqo2B8R7Izil3LJ23VHFjFGApdv8woo+GujPm0LTJDlWD7R?=
 =?us-ascii?Q?BeOM35fntbYtnAM2+GZcdqu9nPYWZ4uNedl0SmhKppBZ3P1b02ldim1kKcFo?=
 =?us-ascii?Q?SasFs8pikaJw/0GscICnjJ1IwdYPYro9tOA7GXJHTjyGhAenVyYYwcYP90Wc?=
 =?us-ascii?Q?lhCZRGHL6KxkWHe62EULC3+ZTJcoKzOc/PZQUqfL8m6hMm9s1LMPxMVbf82v?=
 =?us-ascii?Q?yB64IVfNaxPDWHCQ5DQs9FEgtUfWTSmnrQRAEkS9zix/n3AHxrAxNzPJD46r?=
 =?us-ascii?Q?s4QBlFBCjLqsJe2KP35M/pqxdV0x0Ph13DiolmGr7lxrNX1dDeXqAReVM8Pw?=
 =?us-ascii?Q?ztEI4aYDRpGswGMKo/gK1xlUNN2eHyBrxWC7KOXnZGqMVg0zvjyM0giDWo1/?=
 =?us-ascii?Q?uAC8l+QidHZlo5yfpYNLP3nchIYNbxYUFHEDqzVY95OXBoJoUBJ0nlMxRVhW?=
 =?us-ascii?Q?bFqmuL9CIXa+WqXFTZRGg0j/XuSkpUGwoIld9TkPrbmERnF3nDbi+8Rxq1Mk?=
 =?us-ascii?Q?7SA6b5FlqdiVdrgRkiZG1XDyPJ8CRkX6NmH8wNj8hrQDDzQszloKwvhoiXfv?=
 =?us-ascii?Q?pOX0X4poTeYvT50j9LoPm+hNXtWBBWuM4G/R7Toh3kLuIQWz6wpvZ/XCt5OY?=
 =?us-ascii?Q?FDuVAuQQzmPvhxupWus=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 19:12:29.0937 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 612ab65a-3fe0-47f9-01cb-08de069e9ff4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055E1.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9445
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
the limit type. This is non-obvious without digging into the nuances
of each function. Instead pass the limit type as an argument to all
applicable layers.

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/include/kgd_pp_interface.h   |  2 +-
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c              |  3 ++-
 drivers/gpu/drm/amd/pm/amdgpu_pm.c               |  3 +--
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h          |  2 +-
 drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c |  2 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c        | 10 ++++------
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c |  1 -
 7 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index 2b0cdb2a2775..87814c2b526e 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -454,7 +454,7 @@ struct amd_pm_funcs {
 				bool gate,
 				int inst);
 	int (*set_clockgating_by_smu)(void *handle, uint32_t msg_id);
-	int (*set_power_limit)(void *handle, uint32_t n);
+	int (*set_power_limit)(void *handle, uint32_t limit_type, uint32_t n);
 	int (*get_power_limit)(void *handle, uint32_t *limit,
 			enum pp_power_limit_level pp_limit_level,
 			enum pp_power_type power_type);
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 518d07afc7df..5d08dc3b7110 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -1616,6 +1616,7 @@ int amdgpu_dpm_get_power_limit(struct amdgpu_device *adev,
 }
 
 int amdgpu_dpm_set_power_limit(struct amdgpu_device *adev,
+			       uint32_t limit_type,
 			       uint32_t limit)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
@@ -1626,7 +1627,7 @@ int amdgpu_dpm_set_power_limit(struct amdgpu_device *adev,
 
 	mutex_lock(&adev->pm.mutex);
 	ret = pp_funcs->set_power_limit(adev->powerplay.pp_handle,
-					limit);
+					limit_type, limit);
 	mutex_unlock(&adev->pm.mutex);
 
 	return ret;
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index b5fbb0fd1dc0..6bdf185c6b60 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -3390,13 +3390,12 @@ static ssize_t amdgpu_hwmon_set_power_cap(struct device *dev,
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
index 65c1d98af26c..3bce74f8bb0a 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -553,7 +553,7 @@ int amdgpu_dpm_get_power_limit(struct amdgpu_device *adev,
 			       enum pp_power_limit_level pp_limit_level,
 			       enum pp_power_type power_type);
 int amdgpu_dpm_set_power_limit(struct amdgpu_device *adev,
-			       uint32_t limit);
+			       uint32_t limit_type, uint32_t limit);
 int amdgpu_dpm_is_cclk_dpm_supported(struct amdgpu_device *adev);
 int amdgpu_dpm_debugfs_print_current_performance_level(struct amdgpu_device *adev,
 						       struct seq_file *m);
diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
index fb595a70bbd1..76a5353d7f4a 100644
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
index fb8086859857..1c5f37cd5b75 100644
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
@@ -510,7 +510,7 @@ static void smu_restore_dpm_user_profile(struct smu_context *smu)
 
 	/* set the user dpm power limit */
 	if (smu->user_dpm_profile.power_limit) {
-		ret = smu_set_power_limit(smu, smu->user_dpm_profile.power_limit);
+		ret = smu_set_power_limit(smu, SMU_DEFAULT_PPT_LIMIT, smu->current_power_limit);
 		if (ret)
 			dev_err(smu->adev->dev, "Failed to set power limit value\n");
 	}
@@ -2258,7 +2258,7 @@ static int smu_resume(struct amdgpu_ip_block *ip_block)
 	adev->pm.dpm_enabled = true;
 
 	if (smu->current_power_limit) {
-		ret = smu_set_power_limit(smu, smu->current_power_limit);
+		ret = smu_set_power_limit(smu, SMU_DEFAULT_PPT_LIMIT, smu->current_power_limit);
 		if (ret && ret != -EOPNOTSUPP)
 			return ret;
 	}
@@ -2958,16 +2958,14 @@ int smu_get_power_limit(void *handle,
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
 	if (limit_type != SMU_DEFAULT_PPT_LIMIT)
 		if (smu->ppt_funcs->set_power_limit)
 			return smu->ppt_funcs->set_power_limit(smu, limit_type, limit);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 2c9869feba61..81077a3969e9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -2399,7 +2399,6 @@ static int vangogh_set_power_limit(struct smu_context *smu,
 		smu->current_power_limit = ppt_limit;
 		break;
 	case SMU_FAST_PPT_LIMIT:
-		ppt_limit &= ~(SMU_FAST_PPT_LIMIT << 24);
 		if (ppt_limit > power_context->max_fast_ppt_limit) {
 			dev_err(smu->adev->dev,
 				"New power limit (%d) is over the max allowed %d\n",
-- 
2.51.0

