Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76C5ECCD186
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Oct 2025 16:32:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C39010E424;
	Mon,  6 Oct 2025 16:32:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Wzf7Zq9E";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010031.outbound.protection.outlook.com [52.101.46.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9639410E413
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Oct 2025 16:32:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pt/t9F8xpIdlf2sGEj5BMstDWt6W+qrJZEqD7HwuVMUhg//9rkrbGm+D/Wn3de7KiYfQavwU792Cbtw7fWSlIxxM6WSEldtbLnEK2z385aLSQXOZGD+4qCHPGwgz2t7mECJKfQ1fLrftakdaT/HEUCWLbNpti7Re555iBmaR4pCxPYNez5NsHRqGUTk6pvBCGI3zQmc1Gg2yCOlXzWKjj5D7wavgAfQ5rvS2E0CPQKM6oLZMtSihKD62TtQpTg+h3VCIio0bqUAowMX37bSnFSTEL9PNbTZ4D6pYOdVtozWc4tTAKrQjuLrcHvaJeKZpN0qbQy+bkRb8mHV/lsGjeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ICJygWSb+BVZPc3eWdWEQ9OvYeTCJRBe5AJ/rUS8uw8=;
 b=uEjIJMi59woZL3dI9YHU3YUbxe0Ec56wtPpAuxvn31M/uNftVBx25f42DlyKDd3AG3ukOlgnrTzAyMlUFOtH3S5W6UayMSFM1mhzq3jtGabyoO7taORl6X9bQ2LH2KZk8XH1bWI30bLFZ6lYOtIEJUbuKXTmGx0B9wRoJ2ACtvw8cmoR+6QTVmCjpNIT2Ku/SvNuAGmLrF1WE8KaiEHnWttSy1SP6NxL6OrooX8/uXhmUIV7qQPvjy+lNPmPbcpEurtOdPiVmdIIi8ey9bXR4T689ZmOPEgyGDf1L+EMD4+BHl14fNFxNmVsgeW9tIJh4Ibhtj87Iti4UOEtURI28w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ICJygWSb+BVZPc3eWdWEQ9OvYeTCJRBe5AJ/rUS8uw8=;
 b=Wzf7Zq9ErCwsH/kjscuKjWt3ESDwtzNW26kekMFllXpoOE40xJgsP1PRrjXK3MIIVXmvUJbk9C+ePPlRT/PLRxh5uDi7PU9OjeYZctG81+DsvpouCtbrL//1nOGbCm11y8UxtXeXEU24jpObxNTNJiftwvbxeY1c5yWvpzKfkpk=
Received: from PH7PR17CA0006.namprd17.prod.outlook.com (2603:10b6:510:324::28)
 by PH7PR12MB9222.namprd12.prod.outlook.com (2603:10b6:510:2ef::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 6 Oct
 2025 16:31:55 +0000
Received: from CY4PEPF0000EE38.namprd03.prod.outlook.com
 (2603:10b6:510:324:cafe::74) by PH7PR17CA0006.outlook.office365.com
 (2603:10b6:510:324::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.20 via Frontend Transport; Mon,
 6 Oct 2025 16:31:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE38.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Mon, 6 Oct 2025 16:31:54 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 6 Oct 2025 09:31:54 -0700
From: Mario Limonciello <mario.limonciello@amd.com>
To: <mario.limonciello@amd.com>, <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 2/5] drm/amd: Stop overloading power limit with limit type
Date: Mon, 6 Oct 2025 11:31:35 -0500
Message-ID: <20251006163138.17489-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251006163138.17489-1-mario.limonciello@amd.com>
References: <20251006163138.17489-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE38:EE_|PH7PR12MB9222:EE_
X-MS-Office365-Filtering-Correlation-Id: 38e8b79b-6a05-4dd1-bdd4-08de04f5dc8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aDM5Rhf8h7YR/hADFn7MdCF/0gTJNLzhVtJAxdqXs49b5ENIzACoIAaTWWfT?=
 =?us-ascii?Q?HI54CRCT5LRKWGPW2DTrvNjBCpL5dhUnnrX0q/cQ/6FF5+PpC739r9NxNeJy?=
 =?us-ascii?Q?a1JsRv3NabNEKJgAuc8dx6yGFv/SxhZfvPbRcAMoU+QPqjKwolyqSd7odDxP?=
 =?us-ascii?Q?EquzMdm7xxNBbWrmRUakfNvQfnaAtsacdLMuXFmgVJZpGIybAoP5vufkqxDG?=
 =?us-ascii?Q?P6Dikngu6KoWOaAXQR03DjCehRDTdFcAJ4wUtY6xNgish89iCi5qPL24ehRR?=
 =?us-ascii?Q?VYrPW4Rvb6XXIwkpS17tNHhq87fslau6v3ttvPQr9qU39Tr4Y9bb5Yia7I0Q?=
 =?us-ascii?Q?+PAgqP/4bbtZOZfHXO/j3nJEOp8I+jCjDTg7Fdh15QiAC7ehzj+76GKf9rYo?=
 =?us-ascii?Q?JbjtpnoXva7kGFtFCi6zoUsE19Yc8JzvqbhYqEA43jnpkUhsgqYwoKNTNNYF?=
 =?us-ascii?Q?uFZCmnnOnfwwuB1K6HDDU66OGUmjchIIIwnMDe7qLngvKMVEy2ahoyR/v4Cu?=
 =?us-ascii?Q?91RKV3sj1MbkH9hFWR5esrfky/la4bIdBJsi6lh/fc7PblRC8/dYa/5NstJc?=
 =?us-ascii?Q?AM5CvHrR+x83N0ojmv65ZPBvGgHau/DCyA9b9CpFUUkoTfU8keBXHrO0/j4a?=
 =?us-ascii?Q?aog+NlxcwFWMPAkuQgXnTMXs5/8KZRV5SsRtIX+TPy6SC01JgLCfOrPlQeLx?=
 =?us-ascii?Q?3zHEJqH2D+AMMyAj1KAzX21lvGoZoMqOOPeRNnjZLKD4QlzQMav98TgfPzsD?=
 =?us-ascii?Q?tH66m4rMOi+XVcHSdPT7+4gL848A/My4dUg/O2rf61jxaJ9s5SNIAYDcMt/c?=
 =?us-ascii?Q?5lzrdjoAGuGBpYgKIBWowAcawQY/4HfzGIyLu/+glYwdiR/ElzM9hl6w8DBh?=
 =?us-ascii?Q?dUL/m6uStZVGm8GuPJVn5yx6HM8l7UXhS//Sdy74ml6cUZt/vaLcHbGxlZXl?=
 =?us-ascii?Q?Hx+3Kbm44/sMAnWEvyxFy8WsSQvMp74XF5rOoCeKFsc4oY2iurHmY9/znE1g?=
 =?us-ascii?Q?kVqBu/chgs8QZ44zembPKInQ2MFtVvuKAN04nFUW3Q7ZmoNUsiGV5L29bvfT?=
 =?us-ascii?Q?U9TvKWdtMjHPSqyDiQZ7jP2GWgzxvk7rqCyUIlaucJy3hqDzBpeAQBO3Dz+K?=
 =?us-ascii?Q?radP60OvDCS2XAFv43uJoHvvlDjaTE25zb+haWEF2QF9SpCMYJ733cFLYhMH?=
 =?us-ascii?Q?FTFPQS9qGaRcDyXVgunfFScg1030xsMn2ZpUcr1iqvNe/ySH+hmSxJnMC/C5?=
 =?us-ascii?Q?qVUrErVpw7Im+hv+NZyDMiYRRDaE2rptKcF1+xHe0vTZZjIeQn4AaO2ZQbjJ?=
 =?us-ascii?Q?AJVRedP/djF/l2YhGYLZeJDDRjjQa0/0jHRzSm1qSgwkDqE8SNjLtAOgrAnW?=
 =?us-ascii?Q?KbbDzosHbf8NQ2WKbIyNEvcp13QOy2S/RIRusZs2xgag9eFdD8AtQw246Rn7?=
 =?us-ascii?Q?8bU3s/a8zSBgCiEfUWNwxrd4Ufd7P4IyfycSRzJRqb6ThCPIeutwW9DAPiN7?=
 =?us-ascii?Q?CE/2XBQvXJN8HThdAx9+hijwXprnpeTiFX7c22Xf9EVU/Z1iHQVrK7BAPaH+?=
 =?us-ascii?Q?Wfe5pknfcwJ4ypAmIt4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 16:31:54.6086 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38e8b79b-6a05-4dd1-bdd4-08de04f5dc8d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE38.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9222
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

When passed around internally the upper 8 bits of power limit include the limit type.
This is non-obvious without digging into the nuances of each function.
Instead pass the limit type as an argument to all applicable layers.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2:
 * split into two patches
---
 drivers/gpu/drm/amd/include/kgd_pp_interface.h   | 2 +-
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c              | 3 ++-
 drivers/gpu/drm/amd/pm/amdgpu_pm.c               | 3 +--
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h          | 2 +-
 drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c        | 6 ++----
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c | 1 -
 7 files changed, 8 insertions(+), 11 deletions(-)

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
index fb8086859857..c4459dc553f0 100644
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

