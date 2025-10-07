Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA5BCCCA476
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Oct 2025 13:35:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16E4410E681;
	Tue,  7 Oct 2025 13:35:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mWe/0Rdf";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010069.outbound.protection.outlook.com [52.101.85.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D65110E682
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Oct 2025 13:35:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lZ8XjeS0uig6zjra9Ot+Nvism1f+GUKIImN2GFiBnxmLp1J2cVAB4PUUAV4tzZmTVE+c6G48w1aK2aQwIXsE1MNBKtMxhOSKeZX+V8os5T8076l9CJCOFmUz8N6THlWPb8m5e2FTrw5eyI6m3v3Q1GGh1pRfs4ihxQWC9ADkZeK22svHFkn+jqsNDk4cg32I+wh5HOV2uvu8OQJiDFntd2P2vyw2JzZYwScx1pOgiqW6DUk0D6cwkCapVT5TugYXAZRM7gLX++257kFqvWcVxJ/uN4cXrLUijwMpZEF4Ym5VZMplsga2tkNmaFjxA1+RGnFzZLLoE3BUxTGsAElnvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sIEL2pHbO4nsbHdKoLqCGDgP5aVj5sTSCEqdEqsHCYM=;
 b=A4QX5ee/K90tlNx245qDdk2jmKnEno8F2Au0yIBVEj8mczsGU1vx1TRtxdRbBTA24ibOy71FPIlNKPoKAxAGCXq/BYh2w/SFAL/BuaTMt9w4midiLjBbG69qiYa1XR4l2z5SlYSpAQ9CnZV6yRJN/UT/FiyDYF2AsNpo/ecyawvecT2gkfWx09cgLAVfIQgFVxvFrHy1ZeT9eGYWHp7EjqwRpYp6uwXZZffd5F1NNfcCMbn4bQ0vtKNqL7xTtFxzOeN1O1vBNy8w2KlB5Ju23oNgj3+7GAbzLHBwKDq/o/v1Jj7THTz8Ii09mKmmir8Vh+laKN9nkjzw4IrhHjw/lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sIEL2pHbO4nsbHdKoLqCGDgP5aVj5sTSCEqdEqsHCYM=;
 b=mWe/0RdfYSxPk8pG5Osqf/TR1lrTGvZyjzTV56j1EIRKjpFfC8ZFEYNBnH7re8fiJ4a4bK8Z9SweoQTGNyazZ+3AUbDJFTt+M5DtcxOxfcEsfuzXKgKA7L68K2qm1TsyHw7W6PxXnZuG+G4GBKEb6GE5TLziTy/Hjzf5qZZMLoY=
Received: from BLAPR03CA0011.namprd03.prod.outlook.com (2603:10b6:208:32b::16)
 by MW3PR12MB4425.namprd12.prod.outlook.com (2603:10b6:303:5e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 13:34:53 +0000
Received: from BN1PEPF0000467F.namprd03.prod.outlook.com
 (2603:10b6:208:32b:cafe::19) by BLAPR03CA0011.outlook.office365.com
 (2603:10b6:208:32b::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.9 via Frontend Transport; Tue, 7
 Oct 2025 13:34:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0000467F.mail.protection.outlook.com (10.167.243.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Tue, 7 Oct 2025 13:34:52 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 7 Oct 2025 06:34:51 -0700
From: Mario Limonciello <mario.limonciello@amd.com>
To: <mario.limonciello@amd.com>, <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 2/5] drm/amd: Stop overloading power limit with limit type
Date: Tue, 7 Oct 2025 08:34:35 -0500
Message-ID: <20251007133438.39411-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251007133438.39411-1-mario.limonciello@amd.com>
References: <20251007133438.39411-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000467F:EE_|MW3PR12MB4425:EE_
X-MS-Office365-Filtering-Correlation-Id: a114793b-1869-45b0-c704-08de05a64bc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FRqwrkCEluxR7NWaRrfzqBH8/1FIA9p1y8Alh/XLUcCBhfJfpc0/Lz4T/zyu?=
 =?us-ascii?Q?6iCbiV4+DvmimkIgvG8opWIeJjK3LodYd6rZ0uTAcuJ4NmUipOjzqsvbqKIz?=
 =?us-ascii?Q?xGI0+DueBvMYnPpseG5t98Ym98O/IgZvLdhrhAez/3NZvsQ8yTHVpTSNO961?=
 =?us-ascii?Q?aYT7xuZru1Ek4t/1DaCWRqdHfnkbwDHimNGxAe3+/WdMBdk3yVAj/pXjfk5N?=
 =?us-ascii?Q?IJsyAUgC7nKSRymOZWSxZjaivHrNm62VqCXUaCUSYCYXEZBcLyz9UigRMV8D?=
 =?us-ascii?Q?+NdN1O+DFZKRGDOsDir1gEfa1vsDI7TUvKC+3y8hMQ4O15fqagkzWGEQXPz/?=
 =?us-ascii?Q?am3V2Hqg+bQJhNzJ1CwHeToWaKSDqqBj1OgTaI82EjwOvPDrELHj0e+JFLXI?=
 =?us-ascii?Q?PuDek61fRqfaCNJcPUAF+NAS2ueX79seMzf9f6LBduI77MR7Pnthy35QwCEG?=
 =?us-ascii?Q?n8WXGHGNpjrsJrKa/CV4zPG+SYe+11w9L8sDegWca9dqeyoiJqMOaN6q8ITc?=
 =?us-ascii?Q?b3j5HliQ9n9vBWK+7HeweGNs2R4qSeLFGB4AeqbP7NbbixHoSmgqBRhFTneA?=
 =?us-ascii?Q?CiJRKzMffV51JEXDWOq5LOH/dAnchuE4j9EqZXa7MH9ruhppMvM0zc6Qfvg2?=
 =?us-ascii?Q?uMKXE7xPXR/t47kOfxrox8CShn+7O0mqvIVRoue4Y+5/RncNpxb69Y3xiMLO?=
 =?us-ascii?Q?X7YGLP5ZZ1u1D7zm/R2mGw6JzFeddirjGwB7YIHlIe+A2IY2pxkjWnSZIHr/?=
 =?us-ascii?Q?BeAaYn2m+VeUofYnpSxBuu7zBB44MdOUaZOPoPuUtC+7L9+2KgKIb/oOKOVz?=
 =?us-ascii?Q?cchxRpxns8B/6Dm1uI1+0e2P8KACE8O0iiyqngLPSH9E9FRZulBYr/FwixeK?=
 =?us-ascii?Q?746tVm2RzqBeZLxK21iXh9Raxjz2U8bYIiQdhMaV09O5ZrlY4vK1WP2p4lxs?=
 =?us-ascii?Q?xS5cc02wFpR5HamFtWlYRaWGpeuwXeqBNUfVFUgtKDE49Zr4TpBFMBiwzWvZ?=
 =?us-ascii?Q?BCRRygy9hYXAZMSTwrEBULOhKY5nwL54spQ5CIazNk0WLN19ObjvvqEj63Li?=
 =?us-ascii?Q?QdfcvJ29A0Ja1A+BGM7GTodMvjvF28shh3OgD0iUSaTcX9lEhiS86fIcmpqL?=
 =?us-ascii?Q?b4RIfUrbfaLn5TZB2PqZDOd5DC+fRAy+5vUW4QRV5fNBaC6oEqQFFt/ldZV4?=
 =?us-ascii?Q?X4tOa+RoqbkGRb/sDCT0YMeSb/L0Kdp21nHAu8W87JLqumQTkm72JESQprOA?=
 =?us-ascii?Q?hUJDR4jTq8gmGM6H9hbPIKwlwCnigK8BnD48NBeguNZ6B/o5jWYeet+KAag4?=
 =?us-ascii?Q?ltQFrJGjfyQnNUmxINpl51QoPpLVjaXui3v3LRf6bD6xm56353j8vMjzmoJw?=
 =?us-ascii?Q?oyFTWERAu5L5gHYQ7/7oAzDNbCjNSam4PyBYpsqr4gF5PneidqDBf0xUF2Kb?=
 =?us-ascii?Q?t0lD/vLlbXdaGEEe2ZeLu2tSPGNCx2CGdyanmTLPxdTiwRdxkAmM1aohs9/b?=
 =?us-ascii?Q?HLQ/oTmMg2JfVDD8ErrTijG7Oy8608GNuI1SAbB44jrB89n1fQTrAQZAO14r?=
 =?us-ascii?Q?FhykBl3B3wtf3c7Fo/U=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 13:34:52.6724 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a114793b-1869-45b0-c704-08de05a64bc5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000467F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4425
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
v3:
 * fix a missing hunk for smu_set_power_limit()
v2:
 * split into two patches
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

