Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EFE4CCD184
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Oct 2025 20:59:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 044DC10EB1A;
	Thu,  9 Oct 2025 20:59:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gwwM1Ulz";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012019.outbound.protection.outlook.com [52.101.53.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B24AA10EB18
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Oct 2025 20:59:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YVkwVZvp3byARjAlYj+//uJVg4c95k5uyjKfpXAov04L0Hc+rrrxywmRR6X/Zm/eDxrMyiu3aDTO2cnUOR9drIcXAQRezmtm+mb51SGhokVK5V28F4Z5ycdwtNwAfGtOnLiVT7ebrrx9xfAIVgpCNkg/HmkiXw8Q0rUbiF4VX30g7Q2HZHNKupuJBJ/pM4UOGFHKpjucYXaRklFSbinfYrcRiJzTj0ke2BeUVKyxfvaN7Q2+iSnB+vPsUZEnknn8trYoze2E2qwDP3v7Prtm2f+mH1MhTXQ8B2rnNfzVrwrClOWiVP7w8Gw2GsJ+b2fgGCEkcDaDLJ7teH/FTcLoZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hIf5EhZ5CcEmxnAYXfhpAXgN6JQmc6CY7X/4R9yyDBs=;
 b=safZ1Z4QdQEgI+VeRbwR8mKy17RxfvAx0Cfn+pkXavwCXEzsYeXaZMI5BVmsHTBQmYa6hLHIgwBgDciwJFn3kbCHZHHLy+7ksURcOlzBDZit6TzcepVzUAwdM2ZK3a+Kaq+U4y6lo+Rx7RG7nhsH5Swrt5lJvSHEd/VgkCok8KZBEWIYWwaaiokYHc/BJUFbYg3CdorA8ihOLRvbu9wDwXi2Ow3vwnBv6eR8hIgYMir4SlacN5y+pI5ljih215BVI2j/YfxkeGYBg25wWYDtzyxjNTMrLa/6fTKy0Ax32GrZFT+kVhv7caHBoK7YTOP7tepnFvEaAl6Jc0cVlTNKLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hIf5EhZ5CcEmxnAYXfhpAXgN6JQmc6CY7X/4R9yyDBs=;
 b=gwwM1Ulzkge8jh9d6cy5Zr29HWXnal8CA6Hj/45KSOwKhYliI+teJK3L7kx7rCePZ2HC3PJA0JFIXzstdmMQzYcDRPJF+zJ/XlECgZvezJA1ksAAuoNa2NB+11fDj9GC8zfhve7fB2eVh5tmjNjosVnnMCWAXfZOkZ2zDxU04yY=
Received: from SJ0PR13CA0030.namprd13.prod.outlook.com (2603:10b6:a03:2c0::35)
 by DS7PR12MB5960.namprd12.prod.outlook.com (2603:10b6:8:7f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Thu, 9 Oct
 2025 20:59:23 +0000
Received: from SJ1PEPF00001CE9.namprd03.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::d6) by SJ0PR13CA0030.outlook.office365.com
 (2603:10b6:a03:2c0::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.6 via Frontend Transport; Thu, 9
 Oct 2025 20:59:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE9.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Thu, 9 Oct 2025 20:59:23 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 9 Oct 2025 13:59:21 -0700
From: Mario Limonciello <mario.limonciello@amd.com>
To: <mario.limonciello@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: Robert Beckett <bob.beckett@collabora.com>, Lijo Lazar <lijo.lazar@amd.com>
Subject: [PATCH v5 1/4] drm/amd: Stop overloading power limit with limit type
Date: Thu, 9 Oct 2025 15:59:04 -0500
Message-ID: <20251009205907.177404-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009205907.177404-1-mario.limonciello@amd.com>
References: <20251009205907.177404-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE9:EE_|DS7PR12MB5960:EE_
X-MS-Office365-Filtering-Correlation-Id: 3712beea-b169-4405-844d-08de0776b973
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?n8tdRQgxo3EnKtW8cRtTK7b8cskk2BpjMTm+FArHc1KMLSFJyZN1H0HKVrwJ?=
 =?us-ascii?Q?pOtVnGCbDlH8gtnKBzhFnJLqafS3D36FTe3k+x7/KBQR09mBr8HJ1HiBI5wT?=
 =?us-ascii?Q?6808jBbQ8ijKseUoHon6tF0pBB3uEU0Jt4qZfM/Ww1Sfk167YoUG2G5mSRmq?=
 =?us-ascii?Q?T9AGSDKlVr0bCWvLiPcB3PNhfKGFvQjoh3BvB0sm6Pqc/R9fxSpD4khx/gMf?=
 =?us-ascii?Q?xwjusMzkhFYRQxZ0h+bT3mqLO+nD6lFn/9y4GjtnLzfwIELc5rOxke37ejRs?=
 =?us-ascii?Q?7nVPZr2cXVV7i5egOF7zTVCv7o3VfLlZkSrK0CfjeGfiB1J4cj30e7rlEXGQ?=
 =?us-ascii?Q?omVc2s+2yrvkX8gaEISzO+QKAvDYqoRNKx2KYL0xJT+0G1jVS7F4Pdmn8c2p?=
 =?us-ascii?Q?DgW5kJCej2rGPkmpVU3HFt+yxogF9Thwea5PImCdWYI8J7E2SY8Jpc4YYS01?=
 =?us-ascii?Q?QazXZO5tIZ3/ImJ0ZXbDmTytBTdyOJhf5GMXdQqHSGNsnIVFDakGjt2+as6r?=
 =?us-ascii?Q?RgeOGEat52W9/9EQhlq3d3dsVbaNeOEk0KEWQ2puBeeVwePnxUNXYU6d73ua?=
 =?us-ascii?Q?iQuiXCD7MlYSKojM++yYZv3scMY/2PKRNFvDj8jdYevfsBqKhOnFN1MkAzyk?=
 =?us-ascii?Q?NS8TIaGnY87zovaihyc12+pzl9BdIN0pSiUkwmTCFQt2r5cf5lgMf0/hw26T?=
 =?us-ascii?Q?u5v/DcozXubjOLsVvGhBiJ04fBBDTdu/dg4JdzdbYwsj75eY1ZP7h7J44cdO?=
 =?us-ascii?Q?/XSXibc73wn5x443CE5YgHrTYF61x1odEgwOqUgr/VAYz/9tzXLtEzM6pCjo?=
 =?us-ascii?Q?pd8ejNbogcizC/yeaF07ZgTl11LDloAMd7C8HWHcSMC+VWwerkdfLE2M6jpc?=
 =?us-ascii?Q?wX661bFkRrxHdo8A9LqJVu0bYTw+k1JhHHCml8lfUidCAzPRVCe+lm4N0HEI?=
 =?us-ascii?Q?0R9nMBRi+mog6HFIzdu/W+axIgd+If4n2eXqDYaW9Uqa19/BG+QspURcB1xx?=
 =?us-ascii?Q?irsE4yB9b09IWIhdmS+A6sSOpjtHfOZXbW1CcoqhT2H422nTdk/4XgXumKhf?=
 =?us-ascii?Q?6qL3yEDO1bAMEbs8FEiBGB+1JNzsEhgcK2OJdtcyEpGngWbXXq2KAlaZrZV1?=
 =?us-ascii?Q?h7y4/u0KUYNYE7T49vSgFNFifsqr2jtVHvs+Q3MYGO6PqYJ1QBQAsIzN1p9n?=
 =?us-ascii?Q?gaD2UlWXMZsK8JEV+pCYXXFOdWQAKf6SGqnS3Da1aYg4gaDGWolyInzVxuwm?=
 =?us-ascii?Q?XQOEDOvFFPBOtKR2fKdgqRdlmmFh7FhAaYjTO4XEBJnXJ168Iys56qModWy3?=
 =?us-ascii?Q?5krGre5yG8ClIxT51r+2qB95QwOTXFL0XTcOHlYb0YgCWK5Zwb6FXmOXhkHv?=
 =?us-ascii?Q?w1opjcSqzOs+Brcc05nlp98qpgQ3S12jfRTwchIXtj/iviG4U3VEUZMfe+EB?=
 =?us-ascii?Q?W18f+sxg9kKy+WgReINBWuwjwZRyTDiTZlhVRuqv7cRESg/DJcjx8RrQ/6nF?=
 =?us-ascii?Q?TUR2sQqTrlq19TQYQNUdeH8bMw1e1vIkVKN8O1wCeLteyGl+VIqpdUGwHYHI?=
 =?us-ascii?Q?YJkgkwhP9RWJDcl5Ubg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 20:59:23.0737 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3712beea-b169-4405-844d-08de0776b973
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5960
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
index 9fadfa820f5d..1dcbf250f486 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -2397,7 +2397,6 @@ static int vangogh_set_power_limit(struct smu_context *smu,
 		smu->current_power_limit = ppt_limit;
 		break;
 	case SMU_FAST_PPT_LIMIT:
-		ppt_limit &= ~(SMU_FAST_PPT_LIMIT << 24);
 		if (ppt_limit > power_context->max_fast_ppt_limit) {
 			dev_err(smu->adev->dev,
 				"New power limit (%d) is over the max allowed %d\n",
-- 
2.51.0

