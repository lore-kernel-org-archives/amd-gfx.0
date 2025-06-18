Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F6F7C7115B
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Jun 2025 22:19:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 563A110E96E;
	Wed, 18 Jun 2025 22:19:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qS+xzxkN";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 835AE10E968
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Jun 2025 22:19:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CxjkJ0SdUlsQOAbLWsR8UhewdcQnBbP7Iqx32y8woLObpQPZnUeMZPh1xvpaD1OZFtCM4PitUYrIfpjRlIwTK2OsV7pamaoVoysd9PX190eT6y7vQ+DuTsgMdim8D/7WzFUbVor/t2RjkCyHZb1OoOU5r/ulIMOxoTA0Ivfc5eF/a5rtA6xVLlLeWtlMsmy4C4fqzbT2JFboe4YkVnrYWnLwsHwgt3mZ6rNVBXaNaV+uPhQ0/jBP7zp43h8m/crquNd3baEQ/R1QQGFfli6x5dbjmrO7NCJ3hwbcekQgIDRpqPWQulBvVTNqw0tSbff2Vpvrk4RCtn5eW6nUVU7nrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AlI0uj8pyP8oIecdofa8kurAWGayPqAnELuF40bZyeQ=;
 b=upAbcDjpk5T3DSuEq/wVa/V/5q2kkrSSTzHTUZgApuigv14QCzXYNJTNvZgEL/z3yICnSYRq5S3x3g1VsUx8sf3X6mjvHWfEwIlhNND10uufeRn0hov/hk+2PzsRFRzyW6qvNXwbUTNY1sHTHicoxqt46FyJO2Q0XQ5Ip1Ia6uDo/opsH0nnCXJfFvEaTkgtgpLjugtgEZoo/bjU0eV/dOwSJZSmG2VprQUz8MkY/zTicjvFaUKJcG0WoW89pHnJo74R73QuB2kEAG0UJ1fDcN1QYIQ7wOkJES32NB4ENgvCB1rGVIv61lQhunKvX2blwtDraIqn+BF6cE0WTRT2DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AlI0uj8pyP8oIecdofa8kurAWGayPqAnELuF40bZyeQ=;
 b=qS+xzxkNKy3Y1TmSp2ECsbRERUjqD5vOaONhD1/r02BRgHta222NQwTtd4hT9XzlpOF+xpfaE3HnnmT0TP/ukKKztbrntHoRB2daZTsAPTO4ioBfNcT5ufQ267egkqMlDMI9ouVpJBdbPNcqJ8Jr1VRDbQe60OAZK6u4nN5dOBI=
Received: from SN7PR04CA0084.namprd04.prod.outlook.com (2603:10b6:806:121::29)
 by CH2PR12MB4037.namprd12.prod.outlook.com (2603:10b6:610:7a::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.20; Wed, 18 Jun
 2025 22:19:50 +0000
Received: from SA2PEPF00003AE7.namprd02.prod.outlook.com
 (2603:10b6:806:121:cafe::e5) by SN7PR04CA0084.outlook.office365.com
 (2603:10b6:806:121::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.28 via Frontend Transport; Wed,
 18 Jun 2025 22:19:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AE7.mail.protection.outlook.com (10.167.248.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8857.21 via Frontend Transport; Wed, 18 Jun 2025 22:19:49 +0000
Received: from maple-stxh-linux-10.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 18 Jun 2025 17:19:47 -0500
From: Pratap Nirujogi <pratap.nirujogi@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <mlimonci@amd.com>, <lijo.lazar@amd.com>, 
 <xiaojian.du@amd.com>, <alexander.deucher@amd.com>,
 <christian.koenig@amd.com>
CC: <benjamin.chan@amd.com>, <bin.du@amd.com>, <gjorgji.rosikopulos@amd.com>, 
 <king.li@amd.com>, <dantony@amd.com>, <Phil.Jawich@amd.com>,
 Pratap Nirujogi <pratap.nirujogi@amd.com>
Subject: [PATCH 2/4] drm/amd/pm: Add support to set min ISP clocks
Date: Wed, 18 Jun 2025 18:17:23 -0400
Message-ID: <20250618221923.3944751-3-pratap.nirujogi@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250618221923.3944751-1-pratap.nirujogi@amd.com>
References: <20250618221923.3944751-1-pratap.nirujogi@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE7:EE_|CH2PR12MB4037:EE_
X-MS-Office365-Filtering-Correlation-Id: 053ba1f4-bd48-4598-aa6a-08ddaeb63d54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tyK03GxYdXHqRlc1OLlNvNDJZQR3WOHuOJcVbeoTLkqHKwKF0DybwaSKuMID?=
 =?us-ascii?Q?wQ8zaGW8YKb2mIK7ppPwpqDcP4GCbMGzNzsfZm0fo1ITclMbw2a/bWhaxa3A?=
 =?us-ascii?Q?dTqkgcidx9xEkBhjJejeCfVfBaVDjpcCrQNoglFUmH0zSaC50yta/ElBmk4U?=
 =?us-ascii?Q?OCnBvDQ9eb+jNFTHDhyWsLU3IA6s4hiTyi1GY0JvWxuMUOkjTI0MSrW5uemm?=
 =?us-ascii?Q?REQoVlD87fZpqdjX5ZeAkG4UHmUnnwhkaKMSLflWFZ78Nt4gHNJqlKXEwWiO?=
 =?us-ascii?Q?AGS3oo4yQeQU1wsYFMKySjj6xEJhGb7IpTa62/wHH1WDCayVc4O/TT8XmOtU?=
 =?us-ascii?Q?l9P9VQttHypYWG2GKdgKess+h5E68LHOOah0N24w8xPimkQ/ydYZF/d2uJjK?=
 =?us-ascii?Q?NuoMBfFdwnBKVuZwRs/pHO5MT8gdtWvSPVt9lvVBudOMjuaoZt83C5q649ZP?=
 =?us-ascii?Q?5c7GO+YLGBQWLXITLDUleRhbPtEXiTH9HIx/ckpC8af3zhZK2J7CiyCB+HHz?=
 =?us-ascii?Q?81sKio+6Kxz4Knja6uY3tKDOj5i2n+j2hr1Qw4pmlH3C1NEEDafWXBHtO1Wh?=
 =?us-ascii?Q?BvY3G/YZvCn210e4PyBItmhLhayjgyfP7W3Zf/3iuxwDM9k0WrbzOZvzIqkh?=
 =?us-ascii?Q?YMeFhSUyqhyUXIjewpnKewtssh8yxRycFZlB2ujeSzMB+fnoLlBqetRIka91?=
 =?us-ascii?Q?99oY69XSzMz0QQUomg11NzF0TojjmmTBR4XFhKoOQSz1qJeTkfWd5z9fgjwY?=
 =?us-ascii?Q?TS4lwupYGZ2tZ8qUVKboDDoMkDCjDhVEN6Hr2IGiwtVrHiPro5lnzE+QZ1P8?=
 =?us-ascii?Q?ZEv2EhatusyuWfhGhtgQfAo5Syr2sRIxY3JBDDL5naodiMD1wte1vdqTE2Rj?=
 =?us-ascii?Q?FI/S3sPfKScCxHetxi29usivawp+TNxSJjksSMmPjf5O3gcmlaPU9C0Iod4z?=
 =?us-ascii?Q?cAcJycIIIPT5mByriY6tc5GgCsgm9F6dgA9UxfB4gRyFhCdUkqclTHdNLjbV?=
 =?us-ascii?Q?RnXcRB6MDL0WmzMT+NzTkOnVQ/gVVuDQPLJ69God9ACH3j7G31WahKtsmf1Y?=
 =?us-ascii?Q?6TywcwDTrIZgn4ZnPfXRkJrsHrC1mOsdMQNyNJQeZH1CD3KlsG1cC6ltR4C8?=
 =?us-ascii?Q?9WUa//dxEi2R/U4J+H5F06hVKKb3P3OmP/90S1WQ/nwC0b7KPBNfhxukD5la?=
 =?us-ascii?Q?x37FJC5aAa0Nd5jMi4uD+gWd3Wnj0sjc/2HWl7XOTYjAziHqBHrcaIWLeRyA?=
 =?us-ascii?Q?eXP+bzY6HNqP9L6CKmhuGag9bfmd3KUux75TjesxONXIvlukXM47MmYgcS4i?=
 =?us-ascii?Q?qNaKT7N3Y06A9x53d12EtBKQTFn6F+sZQtEI2JOW6SBmAVh1Nqv5R/rQuQx9?=
 =?us-ascii?Q?+52o0HQEgOqmqr/OXwcrb6WBbNYNrNxiyMfZ6gOQFJnZW3DLSW2aJPXx6jnF?=
 =?us-ascii?Q?ugcogmTFdGhVZN8GVaaodVsy90nwG+nAC1orNoyrAWDqDAn3lckIlIHcTJYf?=
 =?us-ascii?Q?JDmBiQdZ0wWSm3rKYleH0CfzFjVxRP3naFrn?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 22:19:49.1993 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 053ba1f4-bd48-4598-aa6a-08ddaeb63d54
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4037
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

Add support to set ISP clocks for SMU v14.0.0. ISP driver
uses amdgpu_dpm_set_soft_freq_range() API to set clocks via
SMU interface than communicating with PMFW directly.

amdgpu_dpm_set_soft_freq_range() is updated to take in any
pp_clock_type than limiting to support only PP_SCLK to allow
ISP and other driver modules to set the min/max clocks. Any
clock specific restrictions are expected to be taken care in
SOC specific SMU implementations instead of generic amdgpu_dpm
and amdgpu_smu interfaces.

Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
---
 .../gpu/drm/amd/include/kgd_pp_interface.h    |  2 +
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           | 14 ++---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 14 ++++-
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  2 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |  2 +
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c  | 51 ++++++++++++-------
 6 files changed, 56 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index f4d914dc731f..e2b1ea7467b0 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -108,6 +108,8 @@ enum pp_clock_type {
 	PP_VCLK1,
 	PP_DCLK,
 	PP_DCLK1,
+	PP_ISPICLK,
+	PP_ISPXCLK,
 	OD_SCLK,
 	OD_MCLK,
 	OD_VDDC_CURVE,
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 95f1fff442cb..71d986dd7a6e 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -853,22 +853,16 @@ int amdgpu_dpm_set_soft_freq_range(struct amdgpu_device *adev,
 				   uint32_t max)
 {
 	struct smu_context *smu = adev->powerplay.pp_handle;
-	int ret = 0;
-
-	if (type != PP_SCLK)
-		return -EINVAL;
 
 	if (!is_support_sw_smu(adev))
 		return -EOPNOTSUPP;
 
-	mutex_lock(&adev->pm.mutex);
-	ret = smu_set_soft_freq_range(smu,
-				      SMU_SCLK,
+	guard(mutex)(&adev->pm.mutex);
+
+	return smu_set_soft_freq_range(smu,
+				      type,
 				      min,
 				      max);
-	mutex_unlock(&adev->pm.mutex);
-
-	return ret;
 }
 
 int amdgpu_dpm_write_watermarks_table(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 97572fe26ddf..756afe78a6e5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -76,6 +76,7 @@ static void smu_power_profile_mode_get(struct smu_context *smu,
 				       enum PP_SMC_POWER_PROFILE profile_mode);
 static void smu_power_profile_mode_put(struct smu_context *smu,
 				       enum PP_SMC_POWER_PROFILE profile_mode);
+static enum smu_clk_type smu_convert_to_smuclk(enum pp_clock_type type);
 
 static int smu_sys_get_pp_feature_mask(void *handle,
 				       char *buf)
@@ -134,12 +135,17 @@ int smu_get_status_gfxoff(struct smu_context *smu, uint32_t *value)
 }
 
 int smu_set_soft_freq_range(struct smu_context *smu,
-			    enum smu_clk_type clk_type,
+			    enum pp_clock_type type,
 			    uint32_t min,
 			    uint32_t max)
 {
+	enum smu_clk_type clk_type;
 	int ret = 0;
 
+	clk_type = smu_convert_to_smuclk(type);
+	if (clk_type == SMU_CLK_COUNT)
+		return -EINVAL;
+
 	if (smu->ppt_funcs->set_soft_freq_limited_range)
 		ret = smu->ppt_funcs->set_soft_freq_limited_range(smu,
 								  clk_type,
@@ -2980,6 +2986,12 @@ static enum smu_clk_type smu_convert_to_smuclk(enum pp_clock_type type)
 		clk_type = SMU_DCLK; break;
 	case PP_DCLK1:
 		clk_type = SMU_DCLK1; break;
+	case PP_ISPICLK:
+		clk_type = SMU_ISPICLK;
+		break;
+	case PP_ISPXCLK:
+		clk_type = SMU_ISPXCLK;
+		break;
 	case OD_SCLK:
 		clk_type = SMU_OD_SCLK; break;
 	case OD_MCLK:
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 41d4a7f93660..b52e194397e2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -1642,7 +1642,7 @@ int smu_write_watermarks_table(struct smu_context *smu);
 int smu_get_dpm_freq_range(struct smu_context *smu, enum smu_clk_type clk_type,
 			   uint32_t *min, uint32_t *max);
 
-int smu_set_soft_freq_range(struct smu_context *smu, enum smu_clk_type clk_type,
+int smu_set_soft_freq_range(struct smu_context *smu, enum pp_clock_type clk_type,
 			    uint32_t min, uint32_t max);
 
 int smu_set_gfx_power_up_by_imu(struct smu_context *smu);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
index eefdaa0b5df6..d7a9e41820fa 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
@@ -305,6 +305,8 @@ enum smu_clk_type {
 	SMU_MCLK,
 	SMU_PCIE,
 	SMU_LCLK,
+	SMU_ISPICLK,
+	SMU_ISPXCLK,
 	SMU_OD_CCLK,
 	SMU_OD_SCLK,
 	SMU_OD_MCLK,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
index fe4735d5ebd4..fe00c84b1cc6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
@@ -1207,11 +1207,13 @@ static int smu_v14_0_0_print_clk_levels(struct smu_context *smu,
 
 static int smu_v14_0_0_set_soft_freq_limited_range(struct smu_context *smu,
 						   enum smu_clk_type clk_type,
-						   uint32_t min,
-						   uint32_t max)
+						   u32 min,
+						   u32 max,
+						   bool __always_unused automatic)
 {
-	enum smu_message_type msg_set_min, msg_set_max;
-	int ret = 0;
+	enum smu_message_type msg_set_min = SMU_MSG_MAX_COUNT;
+	enum smu_message_type msg_set_max = SMU_MSG_MAX_COUNT;
+	int ret = -EINVAL;
 
 	if (!smu_v14_0_0_clk_dpm_is_enabled(smu, clk_type))
 		return -EINVAL;
@@ -1240,16 +1242,23 @@ static int smu_v14_0_0_set_soft_freq_limited_range(struct smu_context *smu,
 		msg_set_min = SMU_MSG_SetHardMinVcn1;
 		msg_set_max = SMU_MSG_SetSoftMaxVcn1;
 		break;
+	case SMU_ISPICLK:
+		msg_set_min = SMU_MSG_SetHardMinIspiclkByFreq;
+		break;
+	case SMU_ISPXCLK:
+		msg_set_min = SMU_MSG_SetHardMinIspxclkByFreq;
+		break;
 	default:
 		return -EINVAL;
 	}
 
-	ret = smu_cmn_send_smc_msg_with_param(smu, msg_set_min, min, NULL);
-	if (ret)
-		return ret;
+	if (min && msg_set_min != SMU_MSG_MAX_COUNT)
+		ret = smu_cmn_send_smc_msg_with_param(smu, msg_set_min, min, NULL);
+
+	if (max && msg_set_max != SMU_MSG_MAX_COUNT)
+		ret = smu_cmn_send_smc_msg_with_param(smu, msg_set_max, max, NULL);
 
-	return smu_cmn_send_smc_msg_with_param(smu, msg_set_max,
-					       max, NULL);
+	return ret;
 }
 
 static int smu_v14_0_0_force_clk_levels(struct smu_context *smu,
@@ -1278,7 +1287,7 @@ static int smu_v14_0_0_force_clk_levels(struct smu_context *smu,
 		if (ret)
 			break;
 
-		ret = smu_v14_0_0_set_soft_freq_limited_range(smu, clk_type, min_freq, max_freq);
+		ret = smu_v14_0_0_set_soft_freq_limited_range(smu, clk_type, min_freq, max_freq, false);
 		break;
 	default:
 		ret = -EINVAL;
@@ -1426,7 +1435,8 @@ static int smu_v14_0_common_set_performance_level(struct smu_context *smu,
 		ret = smu_v14_0_0_set_soft_freq_limited_range(smu,
 							      SMU_SCLK,
 							      sclk_min,
-							      sclk_max);
+							      sclk_max,
+							      false);
 		if (ret)
 			return ret;
 
@@ -1438,7 +1448,8 @@ static int smu_v14_0_common_set_performance_level(struct smu_context *smu,
 		ret = smu_v14_0_0_set_soft_freq_limited_range(smu,
 							      SMU_FCLK,
 							      fclk_min,
-							      fclk_max);
+							      fclk_max,
+							      false);
 		if (ret)
 			return ret;
 	}
@@ -1447,7 +1458,8 @@ static int smu_v14_0_common_set_performance_level(struct smu_context *smu,
 		ret = smu_v14_0_0_set_soft_freq_limited_range(smu,
 							      SMU_SOCCLK,
 							      socclk_min,
-							      socclk_max);
+							      socclk_max,
+							      false);
 		if (ret)
 			return ret;
 	}
@@ -1456,7 +1468,8 @@ static int smu_v14_0_common_set_performance_level(struct smu_context *smu,
 		ret = smu_v14_0_0_set_soft_freq_limited_range(smu,
 							      SMU_VCLK,
 							      vclk_min,
-							      vclk_max);
+							      vclk_max,
+							      false);
 		if (ret)
 			return ret;
 	}
@@ -1465,7 +1478,8 @@ static int smu_v14_0_common_set_performance_level(struct smu_context *smu,
 		ret = smu_v14_0_0_set_soft_freq_limited_range(smu,
 							      SMU_VCLK1,
 							      vclk1_min,
-							      vclk1_max);
+							      vclk1_max,
+							      false);
 		if (ret)
 			return ret;
 	}
@@ -1474,7 +1488,8 @@ static int smu_v14_0_common_set_performance_level(struct smu_context *smu,
 		ret = smu_v14_0_0_set_soft_freq_limited_range(smu,
 							      SMU_DCLK,
 							      dclk_min,
-							      dclk_max);
+							      dclk_max,
+							      false);
 		if (ret)
 			return ret;
 	}
@@ -1483,7 +1498,8 @@ static int smu_v14_0_common_set_performance_level(struct smu_context *smu,
 		ret = smu_v14_0_0_set_soft_freq_limited_range(smu,
 							      SMU_DCLK1,
 							      dclk1_min,
-							      dclk1_max);
+							      dclk1_max,
+							      false);
 		if (ret)
 			return ret;
 	}
@@ -1670,6 +1686,7 @@ static const struct pptable_funcs smu_v14_0_0_ppt_funcs = {
 	.gfx_off_control = smu_v14_0_gfx_off_control,
 	.mode2_reset = smu_v14_0_0_mode2_reset,
 	.get_dpm_ultimate_freq = smu_v14_0_common_get_dpm_ultimate_freq,
+	.set_soft_freq_limited_range = smu_v14_0_0_set_soft_freq_limited_range,
 	.od_edit_dpm_table = smu_v14_0_od_edit_dpm_table,
 	.print_clk_levels = smu_v14_0_0_print_clk_levels,
 	.force_clk_levels = smu_v14_0_0_force_clk_levels,
-- 
2.43.0

