Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9D3ECD8C99
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Oct 2023 14:52:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 338AF10E38C;
	Tue, 10 Oct 2023 14:52:14 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20622.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::622])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AAEB10E38C
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Oct 2023 14:52:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TYqmsqYJOu2YOSW/SSqARfYl24MlP/mtP5mwuA/RL8G463ijxbESwI9N7aRiOqd4/2Ek2IhPfhIh2Gdx26uXd32trRtGgRCSTEOsd7jHMZy4l9HE8GWpKVwz+c3RDMpdPS0sTX/E8kAkWH4c8zUi1/VUOI31UK2QPi3gNiG5CxNwt3YWvR3VdBv8Y+iXEDDXgPBEMl5yjUCwe80nn2ffvoSMQoMeng7INSNWrgV1sYgo4v3MsK5xeGUWbZ8EnBCVSzZySM91X0SvVwHuVHjaq8EUK+l/eRjBOe9HNJ2wRv1Xoxk6i2IetanTpgnptW4iAJkp37SxEEbs8QgtrGLgLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3oR3esmxi3ggEbuaCOALVD8DiRpy3SokoedXMMjL5Kc=;
 b=fykAsAQcQ2mGjSofRKqfHniVqTcOBq8bcTvXvOubhwTR+h/6tj9Tk/qtNtDJ+TtOXcxNIlF/FY5uukxALUpKK95cxKqgebhWbemLvcI7BpHoyhcXxOdM0hBrVe0LjJy1ICB/NUChNpElMtDP4MGxzLpwBhuj1z4CiuDUgURqLAsXKAuqpM4i7aeS5NpyL9tLVKv0SHFnTbwM3MTZFpis0XqYGLQJ0RGKGlNSpvQ8effrIgH4FAzs9F6rg9EDVRHgv7d/W1t64i8zGfJNn5XhCve2bxPJ9sMK98i3rr9G4t72Ts4uEVE4hQmKFvx374nLUeZ36V+FL1xeiUlQjoIBFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3oR3esmxi3ggEbuaCOALVD8DiRpy3SokoedXMMjL5Kc=;
 b=gPX5AlR1AA/S+cmVjMZzPoL4OMseMGf52LGPzDYyqq5VQuaKasLYTujj+/849IWasPq4g7JNWPaLYc0rCYNFjebYkPx6SlLCGbz6RkcdIZjRJWGedJhfwDARVgYiE6TCaYPV/4e7rxMMjCP0VA0a69ENJPAvLIrrlzB5pOmvJDA=
Received: from CH0P221CA0047.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::28)
 by SN7PR12MB7911.namprd12.prod.outlook.com (2603:10b6:806:32a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Tue, 10 Oct
 2023 14:52:09 +0000
Received: from CY4PEPF0000E9D4.namprd03.prod.outlook.com
 (2603:10b6:610:11d:cafe::71) by CH0P221CA0047.outlook.office365.com
 (2603:10b6:610:11d::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38 via Frontend
 Transport; Tue, 10 Oct 2023 14:52:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D4.mail.protection.outlook.com (10.167.241.147) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Tue, 10 Oct 2023 14:52:08 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 10 Oct
 2023 09:52:06 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: drop most smu_cmn_get_smc_version in smu
Date: Tue, 10 Oct 2023 22:51:47 +0800
Message-ID: <20231010145147.573164-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D4:EE_|SN7PR12MB7911:EE_
X-MS-Office365-Filtering-Correlation-Id: edefe3f8-f3af-4311-fe1e-08dbc9a07a7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jBKi3amHoockSkQSkG6VbIK+18wn5FaSj7QCk3J1g+QcpI7zSwdBW6C8QzQSWrjUiNJafZXn7mqIbOhjlXfwzos5JcFwVKiUNOdyq8kV41n0ZBkxNReSkVDJMMIdUUuXCADPK7ajV8oAKLvJ6rliFHP40UzDZVadzevFAsYSzvofLI83hwyTMoWVA/3KnBgWpC0+6zYNMZu/8lFXVtuMWoVB7wlgarCWx+xjny2e0ZDzUlkbJ+bSSUNUh673gkWacxyDPEFpPLSUSixvlidN13SG6EKbmcV1/s5JAnTLzn0P1JpEn2R94VXt72ryWHWvqOUUKB0y1GYD/Ad+wdENIRju76UMbaPnsr/wTkyJr0yzLzOjTP+ds9pB3T2SYRNjqZ/Y0P0FzPlqF3qvW8LgkPG13Ez50VHCbXKAop/ksRnYm9wKSFYdgKkQROFRmV76Ryx4c58j/5H98YnEUY6qQit2vMAKWOQw6JlDcHwgrjGaNPsuRDbnXtnicQVnYyu9kDdBf7hdrQXImLNpDkFLukLBsOtNlEbSWNWV+VghvDb493zITP8+f3ume6LKKhk4TMOfwP5Thi2Z06y7xXoqFALLR0BzPtsXCi9sfH268otLGa65pv2/KFTFk81Tows1F4JuDMam/36B416U/ZRTbUHpx4rkyN6QzmP1Zs26FlM4NTzilvdSiCEj/MDe6NghlsIEec+hHOEQkeohTV85a5Z9QMe+XRRA5WPgZbDNX5O1Yp86cUDafk7eeUCyKEe6Si/v+T3gAbX2HUW0awRR9w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(346002)(376002)(396003)(230922051799003)(451199024)(82310400011)(186009)(1800799009)(64100799003)(36840700001)(40470700004)(46966006)(82740400003)(2616005)(7696005)(1076003)(478600001)(316002)(41300700001)(30864003)(336012)(83380400001)(426003)(66574015)(47076005)(2906002)(70586007)(5660300002)(54906003)(6916009)(70206006)(8676002)(4326008)(8936002)(16526019)(26005)(40460700003)(36860700001)(356005)(36756003)(40480700001)(81166007)(86362001)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 14:52:08.9278 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: edefe3f8-f3af-4311-fe1e-08dbc9a07a7f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7911
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
Cc: Alexander.Deucher@amd.com, Yifan Zhang <yifan1.zhang@amd.com>,
 Kenneth.Feng@amd.com, christian.koenig@amd.com, Li.Ma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

smu_check_fw_version is called in smu hw init, thus smu if version
and version are garenteed to be stored in smu context. No need to
call smu_cmn_get_smc_version again after system boot up.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 66 ++++---------------
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 37 +++--------
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 43 +++---------
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 45 +++----------
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 60 +++++------------
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 20 ++----
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 22 ++-----
 7 files changed, 61 insertions(+), 232 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 44e4289b95cd..e38620e9436c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -963,17 +963,10 @@ static int arcturus_force_clk_levels(struct smu_context *smu,
 	struct smu_11_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
 	struct smu_11_0_dpm_table *single_dpm_table = NULL;
 	uint32_t soft_min_level, soft_max_level;
-	uint32_t smu_version;
 	int ret = 0;
 
-	ret = smu_cmn_get_smc_version(smu, NULL, &smu_version);
-	if (ret) {
-		dev_err(smu->adev->dev, "Failed to get smu version!\n");
-		return ret;
-	}
-
-	if ((smu_version >= 0x361200) &&
-	    (smu_version <= 0x361a00)) {
+	if ((smu->smc_fw_version >= 0x361200) &&
+	    (smu->smc_fw_version <= 0x361a00)) {
 		dev_err(smu->adev->dev, "Forcing clock level is not supported with "
 		       "54.18 - 54.26(included) SMU firmwares\n");
 		return -EOPNOTSUPP;
@@ -1344,16 +1337,11 @@ static int arcturus_get_power_profile_mode(struct smu_context *smu,
 	uint32_t i, size = 0;
 	int16_t workload_type = 0;
 	int result = 0;
-	uint32_t smu_version;
 
 	if (!buf)
 		return -EINVAL;
 
-	result = smu_cmn_get_smc_version(smu, NULL, &smu_version);
-	if (result)
-		return result;
-
-	if (smu_version >= 0x360d00)
+	if (smu->smc_fw_version >= 0x360d00)
 		size += sysfs_emit_at(buf, size, "%16s %s %s %s %s %s %s %s %s %s %s\n",
 			title[0], title[1], title[2], title[3], title[4], title[5],
 			title[6], title[7], title[8], title[9], title[10]);
@@ -1372,7 +1360,7 @@ static int arcturus_get_power_profile_mode(struct smu_context *smu,
 		if (workload_type < 0)
 			continue;
 
-		if (smu_version >= 0x360d00) {
+		if (smu->smc_fw_version >= 0x360d00) {
 			result = smu_cmn_update_table(smu,
 						  SMU_TABLE_ACTIVITY_MONITOR_COEFF,
 						  workload_type,
@@ -1387,7 +1375,7 @@ static int arcturus_get_power_profile_mode(struct smu_context *smu,
 		size += sysfs_emit_at(buf, size, "%2d %14s%s\n",
 			i, amdgpu_pp_profile_name[i], (i == smu->power_profile_mode) ? "*" : " ");
 
-		if (smu_version >= 0x360d00) {
+		if (smu->smc_fw_version >= 0x360d00) {
 			size += sysfs_emit_at(buf, size, "%19s %d(%13s) %7d %7d %7d %7d %7d %7d %7d %7d %7d\n",
 				" ",
 				0,
@@ -1429,19 +1417,15 @@ static int arcturus_set_power_profile_mode(struct smu_context *smu,
 	int workload_type = 0;
 	uint32_t profile_mode = input[size];
 	int ret = 0;
-	uint32_t smu_version;
 
 	if (profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
 		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", profile_mode);
 		return -EINVAL;
 	}
 
-	ret = smu_cmn_get_smc_version(smu, NULL, &smu_version);
-	if (ret)
-		return ret;
 
 	if ((profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) &&
-	     (smu_version >= 0x360d00)) {
+	     (smu->smc_fw_version >= 0x360d00)) {
 		ret = smu_cmn_update_table(smu,
 				       SMU_TABLE_ACTIVITY_MONITOR_COEFF,
 				       WORKLOAD_PPLIB_CUSTOM_BIT,
@@ -1517,15 +1501,8 @@ static int arcturus_set_power_profile_mode(struct smu_context *smu,
 static int arcturus_set_performance_level(struct smu_context *smu,
 					  enum amd_dpm_forced_level level)
 {
-	uint32_t smu_version;
 	int ret;
 
-	ret = smu_cmn_get_smc_version(smu, NULL, &smu_version);
-	if (ret) {
-		dev_err(smu->adev->dev, "Failed to get smu version!\n");
-		return ret;
-	}
-
 	switch (level) {
 	case AMD_DPM_FORCED_LEVEL_HIGH:
 	case AMD_DPM_FORCED_LEVEL_LOW:
@@ -1533,8 +1510,8 @@ static int arcturus_set_performance_level(struct smu_context *smu,
 	case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK:
 	case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK:
 	case AMD_DPM_FORCED_LEVEL_PROFILE_PEAK:
-		if ((smu_version >= 0x361200) &&
-		    (smu_version <= 0x361a00)) {
+		if ((smu->smc_fw_version >= 0x361200) &&
+		    (smu->smc_fw_version <= 0x361a00)) {
 			dev_err(smu->adev->dev, "Forcing clock level is not supported with "
 			       "54.18 - 54.26(included) SMU firmwares\n");
 			return -EOPNOTSUPP;
@@ -2172,16 +2149,11 @@ static void arcturus_i2c_control_fini(struct smu_context *smu)
 static void arcturus_get_unique_id(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
-	uint32_t top32 = 0, bottom32 = 0, smu_version;
+	uint32_t top32 = 0, bottom32 = 0;
 	uint64_t id;
 
-	if (smu_cmn_get_smc_version(smu, NULL, &smu_version)) {
-		dev_warn(adev->dev, "Failed to get smu version, cannot get unique_id or serial_number\n");
-		return;
-	}
-
 	/* PPSMC_MSG_ReadSerial* is supported by 54.23.0 and onwards */
-	if (smu_version < 0x361700) {
+	if (smu->smc_fw_version < 0x361700) {
 		dev_warn(adev->dev, "ReadSerial is only supported by PMFW 54.23.0 and onwards\n");
 		return;
 	}
@@ -2198,7 +2170,6 @@ static int arcturus_set_df_cstate(struct smu_context *smu,
 				  enum pp_df_cstate state)
 {
 	struct amdgpu_device *adev = smu->adev;
-	uint32_t smu_version;
 	int ret;
 
 	/*
@@ -2208,14 +2179,8 @@ static int arcturus_set_df_cstate(struct smu_context *smu,
 	if (amdgpu_in_reset(adev) || adev->in_suspend)
 		return 0;
 
-	ret = smu_cmn_get_smc_version(smu, NULL, &smu_version);
-	if (ret) {
-		dev_err(smu->adev->dev, "Failed to get smu version!\n");
-		return ret;
-	}
-
 	/* PPSMC_MSG_DFCstateControl is supported by 54.15.0 and onwards */
-	if (smu_version < 0x360F00) {
+	if (smu->smc_fw_version < 0x360F00) {
 		dev_err(smu->adev->dev, "DFCstateControl is only supported by PMFW 54.15.0 and onwards\n");
 		return -EINVAL;
 	}
@@ -2226,17 +2191,10 @@ static int arcturus_set_df_cstate(struct smu_context *smu,
 static int arcturus_select_xgmi_plpd_policy(struct smu_context *smu,
 					    enum pp_xgmi_plpd_mode mode)
 {
-	uint32_t smu_version;
 	int ret;
 
-	ret = smu_cmn_get_smc_version(smu, NULL, &smu_version);
-	if (ret) {
-		dev_err(smu->adev->dev, "Failed to get smu version!\n");
-		return ret;
-	}
-
 	/* PPSMC_MSG_GmiPwrDnControl is supported by 54.23.0 and onwards */
-	if (smu_version < 0x00361700) {
+	if (smu->smc_fw_version < 0x00361700) {
 		dev_err(smu->adev->dev, "XGMI power down control is only supported by PMFW 54.23.0 and onwards\n");
 		return -EINVAL;
 	}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 5f3cbfff156a..bbe0cb68ca30 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -907,18 +907,11 @@ static int navi1x_get_smu_metrics_data(struct smu_context *smu,
 				       uint32_t *value)
 {
 	struct amdgpu_device *adev = smu->adev;
-	uint32_t smu_version;
 	int ret = 0;
 
-	ret = smu_cmn_get_smc_version(smu, NULL, &smu_version);
-	if (ret) {
-		dev_err(adev->dev, "Failed to get smu version!\n");
-		return ret;
-	}
-
 	switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
 	case IP_VERSION(11, 0, 9):
-		if (smu_version > 0x00341C00)
+		if (smu->smc_fw_version > 0x00341C00)
 			ret = navi12_get_smu_metrics_data(smu, member, value);
 		else
 			ret = navi12_get_legacy_smu_metrics_data(smu, member, value);
@@ -928,10 +921,10 @@ static int navi1x_get_smu_metrics_data(struct smu_context *smu,
 	default:
 		if (((amdgpu_ip_version(adev, MP1_HWIP, 0) ==
 		      IP_VERSION(11, 0, 5)) &&
-		     smu_version > 0x00351F00) ||
+		     smu->smc_fw_version > 0x00351F00) ||
 		    ((amdgpu_ip_version(adev, MP1_HWIP, 0) ==
 		      IP_VERSION(11, 0, 0)) &&
-		     smu_version > 0x002A3B00))
+		     smu->smc_fw_version > 0x002A3B00))
 			ret = navi10_get_smu_metrics_data(smu, member, value);
 		else
 			ret = navi10_get_legacy_smu_metrics_data(smu, member, value);
@@ -2847,19 +2840,12 @@ static int navi10_run_umc_cdr_workaround(struct smu_context *smu)
 	struct amdgpu_device *adev = smu->adev;
 	uint8_t umc_fw_greater_than_v136 = false;
 	uint8_t umc_fw_disable_cdr = false;
-	uint32_t pmfw_version;
 	uint32_t param;
 	int ret = 0;
 
 	if (!navi10_need_umc_cdr_workaround(smu))
 		return 0;
 
-	ret = smu_cmn_get_smc_version(smu, NULL, &pmfw_version);
-	if (ret) {
-		dev_err(adev->dev, "Failed to get smu version!\n");
-		return ret;
-	}
-
 	/*
 	 * The messages below are only supported by Navi10 42.53.0 and later
 	 * PMFWs and Navi14 53.29.0 and later PMFWs.
@@ -2868,9 +2854,9 @@ static int navi10_run_umc_cdr_workaround(struct smu_context *smu)
 	 * - PPSMC_MSG_GetUMCFWWA
 	 */
 	if (((amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(11, 0, 0)) &&
-	     (pmfw_version >= 0x2a3500)) ||
+	     (smu->smc_fw_version >= 0x2a3500)) ||
 	    ((amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(11, 0, 5)) &&
-	     (pmfw_version >= 0x351D00))) {
+	     (smu->smc_fw_version >= 0x351D00))) {
 		ret = smu_cmn_send_smc_msg_with_param(smu,
 						      SMU_MSG_GET_UMC_FW_WA,
 						      0,
@@ -3355,18 +3341,11 @@ static ssize_t navi1x_get_gpu_metrics(struct smu_context *smu,
 				      void **table)
 {
 	struct amdgpu_device *adev = smu->adev;
-	uint32_t smu_version;
 	int ret = 0;
 
-	ret = smu_cmn_get_smc_version(smu, NULL, &smu_version);
-	if (ret) {
-		dev_err(adev->dev, "Failed to get smu version!\n");
-		return ret;
-	}
-
 	switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
 	case IP_VERSION(11, 0, 9):
-		if (smu_version > 0x00341C00)
+		if (smu->smc_fw_version > 0x00341C00)
 			ret = navi12_get_gpu_metrics(smu, table);
 		else
 			ret = navi12_get_legacy_gpu_metrics(smu, table);
@@ -3376,10 +3355,10 @@ static ssize_t navi1x_get_gpu_metrics(struct smu_context *smu,
 	default:
 		if (((amdgpu_ip_version(adev, MP1_HWIP, 0) ==
 		      IP_VERSION(11, 0, 5)) &&
-		     smu_version > 0x00351F00) ||
+		     smu->smc_fw_version > 0x00351F00) ||
 		    ((amdgpu_ip_version(adev, MP1_HWIP, 0) ==
 		      IP_VERSION(11, 0, 0)) &&
-		     smu_version > 0x002A3B00))
+		     smu->smc_fw_version > 0x002A3B00))
 			ret = navi10_get_gpu_metrics(smu, table);
 		else
 			ret = navi10_get_legacy_gpu_metrics(smu, table);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 28868f64d134..1e710c0c9042 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -1279,7 +1279,6 @@ static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
 	uint32_t mark_index = 0;
 	uint32_t gen_speed, lane_width;
 	uint32_t min_value, max_value;
-	uint32_t smu_version;
 
 	smu_cmn_get_sysfs_buf(&buf, &size);
 
@@ -1388,10 +1387,9 @@ static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
 		 * OD GFX Voltage Offset functionality is supported only by 58.41.0
 		 * and onwards SMU firmwares.
 		 */
-		smu_cmn_get_smc_version(smu, NULL, &smu_version);
 		if ((amdgpu_ip_version(adev, MP1_HWIP, 0) ==
 		     IP_VERSION(11, 0, 7)) &&
-		    (smu_version < 0x003a2900))
+		    (smu->smc_fw_version < 0x003a2900))
 			break;
 
 		size += sysfs_emit_at(buf, size, "OD_VDDGFX_OFFSET:\n");
@@ -2148,16 +2146,14 @@ static void sienna_cichlid_dump_od_table(struct smu_context *smu,
 					 OverDriveTable_t *od_table)
 {
 	struct amdgpu_device *adev = smu->adev;
-	uint32_t smu_version;
 
 	dev_dbg(smu->adev->dev, "OD: Gfxclk: (%d, %d)\n", od_table->GfxclkFmin,
 							  od_table->GfxclkFmax);
 	dev_dbg(smu->adev->dev, "OD: Uclk: (%d, %d)\n", od_table->UclkFmin,
 							od_table->UclkFmax);
 
-	smu_cmn_get_smc_version(smu, NULL, &smu_version);
 	if (!((amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(11, 0, 7)) &&
-	      (smu_version < 0x003a2900)))
+	      (smu->smc_fw_version < 0x003a2900)))
 		dev_dbg(smu->adev->dev, "OD: VddGfxOffset: %d\n", od_table->VddGfxOffset);
 }
 
@@ -2235,7 +2231,6 @@ static int sienna_cichlid_od_edit_dpm_table(struct smu_context *smu,
 	enum SMU_11_0_7_ODSETTING_ID freq_setting;
 	uint16_t *freq_ptr;
 	int i, ret = 0;
-	uint32_t smu_version;
 
 	if (!smu->od_enabled) {
 		dev_warn(smu->adev->dev, "OverDrive is not enabled!\n");
@@ -2388,10 +2383,9 @@ static int sienna_cichlid_od_edit_dpm_table(struct smu_context *smu,
 		 * OD GFX Voltage Offset functionality is supported only by 58.41.0
 		 * and onwards SMU firmwares.
 		 */
-		smu_cmn_get_smc_version(smu, NULL, &smu_version);
 		if ((amdgpu_ip_version(adev, MP1_HWIP, 0) ==
 		     IP_VERSION(11, 0, 7)) &&
-		    (smu_version < 0x003a2900)) {
+		    (smu->smc_fw_version < 0x003a2900)) {
 			dev_err(smu->adev->dev, "OD GFX Voltage offset functionality is supported "
 						"only by 58.41.0 and onwards SMU firmwares!\n");
 			return -EOPNOTSUPP;
@@ -2461,14 +2455,12 @@ static bool sienna_cichlid_is_mode1_reset_supported(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
 	uint32_t val;
-	u32 smu_version;
 
 	/**
 	 * SRIOV env will not support SMU mode1 reset
 	 * PM FW support mode1 reset from 58.26
 	 */
-	smu_cmn_get_smc_version(smu, NULL, &smu_version);
-	if (amdgpu_sriov_vf(adev) || (smu_version < 0x003a1a00))
+	if (amdgpu_sriov_vf(adev) || (smu->smc_fw_version < 0x003a1a00))
 		return false;
 
 	/**
@@ -4060,14 +4052,9 @@ static ssize_t sienna_cichlid_get_gpu_metrics(struct smu_context *smu,
 
 static int sienna_cichlid_check_ecc_table_support(struct smu_context *smu)
 {
-	uint32_t if_version = 0xff, smu_version = 0xff;
 	int ret = 0;
 
-	ret = smu_cmn_get_smc_version(smu, &if_version, &smu_version);
-	if (ret)
-		return -EOPNOTSUPP;
-
-	if (smu_version < SUPPORT_ECCTABLE_SMU_VERSION)
+	if (smu->smc_fw_version < SUPPORT_ECCTABLE_SMU_VERSION)
 		ret = -EOPNOTSUPP;
 
 	return ret;
@@ -4133,17 +4120,13 @@ static int sienna_cichlid_enable_mgpu_fan_boost(struct smu_context *smu)
 static int sienna_cichlid_gpo_control(struct smu_context *smu,
 				      bool enablement)
 {
-	uint32_t smu_version;
 	int ret = 0;
 
 
 	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_GFX_GPO_BIT)) {
-		ret = smu_cmn_get_smc_version(smu, NULL, &smu_version);
-		if (ret)
-			return ret;
 
 		if (enablement) {
-			if (smu_version < 0x003a2500) {
+			if (smu->smc_fw_version < 0x003a2500) {
 				ret = smu_cmn_send_smc_msg_with_param(smu,
 								      SMU_MSG_SetGpoFeaturePMask,
 								      GFX_GPO_PACE_MASK | GFX_GPO_DEM_MASK,
@@ -4155,7 +4138,7 @@ static int sienna_cichlid_gpo_control(struct smu_context *smu,
 								      NULL);
 			}
 		} else {
-			if (smu_version < 0x003a2500) {
+			if (smu->smc_fw_version < 0x003a2500) {
 				ret = smu_cmn_send_smc_msg_with_param(smu,
 								      SMU_MSG_SetGpoFeaturePMask,
 								      0,
@@ -4174,18 +4157,11 @@ static int sienna_cichlid_gpo_control(struct smu_context *smu,
 
 static int sienna_cichlid_notify_2nd_usb20_port(struct smu_context *smu)
 {
-	uint32_t smu_version;
-	int ret = 0;
-
-	ret = smu_cmn_get_smc_version(smu, NULL, &smu_version);
-	if (ret)
-		return ret;
-
 	/*
 	 * Message SMU_MSG_Enable2ndUSB20Port is supported by 58.45
 	 * onwards PMFWs.
 	 */
-	if (smu_version < 0x003A2D00)
+	if (smu->smc_fw_version < 0x003A2D00)
 		return 0;
 
 	return smu_cmn_send_smc_msg_with_param(smu,
@@ -4332,13 +4308,10 @@ static bool sienna_cichlid_is_mode2_reset_supported(struct smu_context *smu)
 
 static int sienna_cichlid_mode2_reset(struct smu_context *smu)
 {
-	u32 smu_version;
 	int ret = 0, index;
 	struct amdgpu_device *adev = smu->adev;
 	int timeout = 100;
 
-	smu_cmn_get_smc_version(smu, NULL, &smu_version);
-
 	index = smu_cmn_to_asic_specific_index(smu, CMN2ASIC_MAPPING_MSG,
 						SMU_MSG_DriverMode2Reset);
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index a5481274052e..9d8afc83af67 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -225,15 +225,8 @@ static int vangogh_tables_init(struct smu_context *smu)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
 	struct smu_table *tables = smu_table->tables;
-	uint32_t if_version;
-	uint32_t smu_version;
 	uint32_t ret = 0;
 
-	ret = smu_cmn_get_smc_version(smu, &if_version, &smu_version);
-	if (ret) {
-		return ret;
-	}
-
 	SMU_TABLE_INIT(tables, SMU_TABLE_WATERMARKS, sizeof(Watermarks_t),
 		       PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
 	SMU_TABLE_INIT(tables, SMU_TABLE_DPMCLOCKS, sizeof(DpmClocks_t),
@@ -243,7 +236,7 @@ static int vangogh_tables_init(struct smu_context *smu)
 	SMU_TABLE_INIT(tables, SMU_TABLE_ACTIVITY_MONITOR_COEFF, sizeof(DpmActivityMonitorCoeffExt_t),
 		       PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
 
-	if (if_version < 0x3) {
+	if (smu->smc_fw_if_version < 0x3) {
 		SMU_TABLE_INIT(tables, SMU_TABLE_SMU_METRICS, sizeof(SmuMetrics_legacy_t),
 				PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
 		smu_table->metrics_table = kzalloc(sizeof(SmuMetrics_legacy_t), GFP_KERNEL);
@@ -256,7 +249,7 @@ static int vangogh_tables_init(struct smu_context *smu)
 		goto err0_out;
 	smu_table->metrics_time = 0;
 
-	if (smu_version >= 0x043F3E00)
+	if (smu->smc_fw_version >= 0x043F3E00)
 		smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v2_3);
 	else
 		smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v2_2);
@@ -431,16 +424,9 @@ static int vangogh_common_get_smu_metrics_data(struct smu_context *smu,
 				       uint32_t *value)
 {
 	struct amdgpu_device *adev = smu->adev;
-	uint32_t if_version;
 	int ret = 0;
 
-	ret = smu_cmn_get_smc_version(smu, &if_version, NULL);
-	if (ret) {
-		dev_err(adev->dev, "Failed to get smu if version!\n");
-		return ret;
-	}
-
-	if (if_version < 0x3)
+	if (smu->smc_fw_if_version < 0x3)
 		ret = vangogh_get_legacy_smu_metrics_data(smu, member, value);
 	else
 		ret = vangogh_get_smu_metrics_data(smu, member, value);
@@ -814,16 +800,9 @@ static int vangogh_common_print_clk_levels(struct smu_context *smu,
 			enum smu_clk_type clk_type, char *buf)
 {
 	struct amdgpu_device *adev = smu->adev;
-	uint32_t if_version;
 	int ret = 0;
 
-	ret = smu_cmn_get_smc_version(smu, &if_version, NULL);
-	if (ret) {
-		dev_err(adev->dev, "Failed to get smu if version!\n");
-		return ret;
-	}
-
-	if (if_version < 0x3)
+	if (smu->smc_fw_if_version < 0x3)
 		ret = vangogh_print_legacy_clk_levels(smu, clk_type, buf);
 	else
 		ret = vangogh_print_clk_levels(smu, clk_type, buf);
@@ -2011,18 +1990,12 @@ static ssize_t vangogh_get_gpu_metrics(struct smu_context *smu,
 static ssize_t vangogh_common_get_gpu_metrics(struct smu_context *smu,
 				      void **table)
 {
-	uint32_t if_version;
-	uint32_t smu_version;
 	uint32_t smu_program;
 	uint32_t fw_version;
 	int ret = 0;
 
-	ret = smu_cmn_get_smc_version(smu, &if_version, &smu_version);
-	if (ret)
-		return ret;
-
-	smu_program = (smu_version >> 24) & 0xff;
-	fw_version = smu_version & 0xffffff;
+	smu_program = (smu->smc_fw_version >> 24) & 0xff;
+	fw_version = smu->smc_fw_version & 0xffffff;
 	if (smu_program == 6) {
 		if (fw_version >= 0x3F0800)
 			ret = vangogh_get_gpu_metrics_v2_4(smu, table);
@@ -2030,13 +2003,13 @@ static ssize_t vangogh_common_get_gpu_metrics(struct smu_context *smu,
 			ret = vangogh_get_gpu_metrics_v2_3(smu, table);
 
 	} else {
-		if (smu_version >= 0x043F3E00) {
-			if (if_version < 0x3)
+		if (smu->smc_fw_version >= 0x043F3E00) {
+			if (smu->smc_fw_if_version < 0x3)
 				ret = vangogh_get_legacy_gpu_metrics_v2_3(smu, table);
 			else
 				ret = vangogh_get_gpu_metrics_v2_3(smu, table);
 		} else {
-			if (if_version < 0x3)
+			if (smu->smc_fw_if_version < 0x3)
 				ret = vangogh_get_legacy_gpu_metrics(smu, table);
 			else
 				ret = vangogh_get_gpu_metrics(smu, table);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 2373a66c7efd..bdb278f5c654 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -467,18 +467,12 @@ static bool aldebaran_is_primary(struct smu_context *smu)
 
 static int aldebaran_run_board_btc(struct smu_context *smu)
 {
-	u32 smu_version;
 	int ret;
 
 	if (!aldebaran_is_primary(smu))
 		return 0;
 
-	ret = smu_cmn_get_smc_version(smu, NULL, &smu_version);
-	if (ret) {
-		dev_err(smu->adev->dev, "Failed to get smu version!\n");
-		return ret;
-	}
-	if (smu_version <= 0x00441d00)
+	if (smu->smc_fw_version <= 0x00441d00)
 		return 0;
 
 	ret = smu_cmn_send_smc_msg(smu, SMU_MSG_BoardPowerCalibration, NULL);
@@ -1769,24 +1763,15 @@ static ssize_t aldebaran_get_gpu_metrics(struct smu_context *smu,
 static int aldebaran_check_ecc_table_support(struct smu_context *smu,
 		int *ecctable_version)
 {
-	uint32_t if_version = 0xff, smu_version = 0xff;
-	int ret = 0;
-
-	ret = smu_cmn_get_smc_version(smu, &if_version, &smu_version);
-	if (ret) {
-		/* return not support if failed get smu_version */
-		ret = -EOPNOTSUPP;
-	}
-
-	if (smu_version < SUPPORT_ECCTABLE_SMU_VERSION)
-		ret = -EOPNOTSUPP;
-	else if (smu_version >= SUPPORT_ECCTABLE_SMU_VERSION &&
-			smu_version < SUPPORT_ECCTABLE_V2_SMU_VERSION)
+	if (smu->smc_fw_version < SUPPORT_ECCTABLE_SMU_VERSION)
+		return -EOPNOTSUPP;
+	else if (smu->smc_fw_version >= SUPPORT_ECCTABLE_SMU_VERSION &&
+			smu->smc_fw_version < SUPPORT_ECCTABLE_V2_SMU_VERSION)
 		*ecctable_version = 1;
 	else
 		*ecctable_version = 2;
 
-	return ret;
+	return 0;
 }
 
 static ssize_t aldebaran_get_ecc_info(struct smu_context *smu,
@@ -1849,7 +1834,7 @@ static ssize_t aldebaran_get_ecc_info(struct smu_context *smu,
 
 static int aldebaran_mode1_reset(struct smu_context *smu)
 {
-	u32 smu_version, fatal_err, param;
+	u32 fatal_err, param;
 	int ret = 0;
 	struct amdgpu_device *adev = smu->adev;
 	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
@@ -1860,13 +1845,12 @@ static int aldebaran_mode1_reset(struct smu_context *smu)
 	/*
 	* PM FW support SMU_MSG_GfxDeviceDriverReset from 68.07
 	*/
-	smu_cmn_get_smc_version(smu, NULL, &smu_version);
-	if (smu_version < 0x00440700) {
+	if (smu->smc_fw_version < 0x00440700) {
 		ret = smu_cmn_send_smc_msg(smu, SMU_MSG_Mode1Reset, NULL);
 	} else {
 		/* fatal error triggered by ras, PMFW supports the flag
 		   from 68.44.0 */
-		if ((smu_version >= 0x00442c00) && ras &&
+		if ((smu->smc_fw_version >= 0x00442c00) && ras &&
 		    atomic_read(&ras->in_recovery))
 			fatal_err = 1;
 
@@ -1883,18 +1867,15 @@ static int aldebaran_mode1_reset(struct smu_context *smu)
 
 static int aldebaran_mode2_reset(struct smu_context *smu)
 {
-	u32 smu_version;
 	int ret = 0, index;
 	struct amdgpu_device *adev = smu->adev;
 	int timeout = 10;
 
-	smu_cmn_get_smc_version(smu, NULL, &smu_version);
-
 	index = smu_cmn_to_asic_specific_index(smu, CMN2ASIC_MAPPING_MSG,
 						SMU_MSG_GfxDeviceDriverReset);
 
 	mutex_lock(&smu->message_lock);
-	if (smu_version >= 0x00441400) {
+	if (smu->smc_fw_version >= 0x00441400) {
 		ret = smu_cmn_send_msg_without_waiting(smu, (uint16_t)index, SMU_RESET_MODE_2);
 		/* This is similar to FLR, wait till max FLR timeout */
 		msleep(100);
@@ -1921,7 +1902,7 @@ static int aldebaran_mode2_reset(struct smu_context *smu)
 
 	} else {
 		dev_err(adev->dev, "smu fw 0x%x does not support MSG_GfxDeviceDriverReset MSG\n",
-				smu_version);
+				smu->smc_fw_version);
 	}
 
 	if (ret == 1)
@@ -1944,13 +1925,11 @@ static bool aldebaran_is_mode1_reset_supported(struct smu_context *smu)
 {
 #if 0
 	struct amdgpu_device *adev = smu->adev;
-	u32 smu_version;
 	uint32_t val;
 	/**
 	 * PM FW version support mode1 reset from 68.07
 	 */
-	smu_cmn_get_smc_version(smu, NULL, &smu_version);
-	if ((smu_version < 0x00440700))
+	if ((smu->smc_fw_version < 0x00440700))
 		return false;
 	/**
 	 * mode1 reset relies on PSP, so we should check if
@@ -1995,19 +1974,10 @@ static int aldebaran_smu_send_hbm_bad_page_num(struct smu_context *smu,
 
 static int aldebaran_check_bad_channel_info_support(struct smu_context *smu)
 {
-	uint32_t if_version = 0xff, smu_version = 0xff;
-	int ret = 0;
+	if (smu->smc_fw_version < SUPPORT_BAD_CHANNEL_INFO_MSG_VERSION)
+		return -EOPNOTSUPP;
 
-	ret = smu_cmn_get_smc_version(smu, &if_version, &smu_version);
-	if (ret) {
-		/* return not support if failed get smu_version */
-		ret = -EOPNOTSUPP;
-	}
-
-	if (smu_version < SUPPORT_BAD_CHANNEL_INFO_MSG_VERSION)
-		ret = -EOPNOTSUPP;
-
-	return ret;
+	return 0;
 }
 
 static int aldebaran_send_hbm_bad_channel_flag(struct smu_context *smu,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 47d008cbc186..f22f35c97d24 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -296,7 +296,6 @@ smu_v13_0_0_get_allowed_feature_mask(struct smu_context *smu,
 				  uint32_t *feature_mask, uint32_t num)
 {
 	struct amdgpu_device *adev = smu->adev;
-	u32 smu_version;
 
 	if (num > 2)
 		return -EINVAL;
@@ -316,8 +315,7 @@ smu_v13_0_0_get_allowed_feature_mask(struct smu_context *smu,
 		*(uint64_t *)feature_mask &= ~FEATURE_MASK(FEATURE_DPM_SOCCLK_BIT);
 
 	/* PMFW 78.58 contains a critical fix for gfxoff feature */
-	smu_cmn_get_smc_version(smu, NULL, &smu_version);
-	if ((smu_version < 0x004e3a00) ||
+	if ((smu->smc_fw_version < 0x004e3a00) ||
 	     !(adev->pm.pp_feature & PP_GFXOFF_MASK))
 		*(uint64_t *)feature_mask &= ~FEATURE_MASK(FEATURE_GFXOFF_BIT);
 
@@ -2583,15 +2581,13 @@ static int smu_v13_0_0_baco_exit(struct smu_context *smu)
 static bool smu_v13_0_0_is_mode1_reset_supported(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
-	u32 smu_version;
 
 	/* SRIOV does not support SMU mode1 reset */
 	if (amdgpu_sriov_vf(adev))
 		return false;
 
 	/* PMFW support is available since 78.41 */
-	smu_cmn_get_smc_version(smu, NULL, &smu_version);
-	if (smu_version < 0x004e2900)
+	if (smu->smc_fw_version < 0x004e2900)
 		return false;
 
 	return true;
@@ -2781,13 +2777,10 @@ static void smu_v13_0_0_set_mode1_reset_param(struct smu_context *smu,
 						uint32_t supported_version,
 						uint32_t *param)
 {
-	uint32_t smu_version;
 	struct amdgpu_device *adev = smu->adev;
 	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
 
-	smu_cmn_get_smc_version(smu, NULL, &smu_version);
-
-	if ((smu_version >= supported_version) &&
+	if ((smu->smc_fw_version >= supported_version) &&
 			ras && atomic_read(&ras->in_recovery))
 		/* Set RAS fatal error reset flag */
 		*param = 1 << 16;
@@ -2903,15 +2896,10 @@ static int smu_v13_0_0_send_bad_mem_channel_flag(struct smu_context *smu,
 static int smu_v13_0_0_check_ecc_table_support(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
-	uint32_t if_version = 0xff, smu_version = 0xff;
 	int ret = 0;
 
-	ret = smu_cmn_get_smc_version(smu, &if_version, &smu_version);
-	if (ret)
-		return -EOPNOTSUPP;
-
 	if ((amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 10)) &&
-		(smu_version >= SUPPORT_ECCTABLE_SMU_13_0_10_VERSION))
+		(smu->smc_fw_version >= SUPPORT_ECCTABLE_SMU_13_0_10_VERSION))
 		return ret;
 	else
 		return -EOPNOTSUPP;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 8220bdcbd927..953a9a52ed8d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -719,7 +719,6 @@ static int smu_v13_0_6_get_smu_metrics_data(struct smu_context *smu,
 	struct smu_table_context *smu_table = &smu->smu_table;
 	MetricsTable_t *metrics = (MetricsTable_t *)smu_table->metrics_table;
 	struct amdgpu_device *adev = smu->adev;
-	uint32_t smu_version;
 	int ret = 0;
 	int xcc_id;
 
@@ -731,8 +730,7 @@ static int smu_v13_0_6_get_smu_metrics_data(struct smu_context *smu,
 	switch (member) {
 	case METRICS_CURR_GFXCLK:
 	case METRICS_AVERAGE_GFXCLK:
-		smu_cmn_get_smc_version(smu, NULL, &smu_version);
-		if (smu_version >= 0x552F00) {
+		if (smu->smc_fw_version >= 0x552F00) {
 			xcc_id = GET_INST(GC, 0);
 			*value = SMUQ10_ROUND(metrics->GfxclkFrequency[xcc_id]);
 		} else {
@@ -1392,10 +1390,7 @@ static int smu_v13_0_6_register_irq_handler(struct smu_context *smu)
 
 static int smu_v13_0_6_notify_unload(struct smu_context *smu)
 {
-	uint32_t smu_version;
-
-	smu_cmn_get_smc_version(smu, NULL, &smu_version);
-	if (smu_version <= 0x553500)
+	if (smu->smc_fw_version <= 0x553500)
 		return 0;
 
 	dev_dbg(smu->adev->dev, "Notify PMFW about driver unload");
@@ -1407,11 +1402,8 @@ static int smu_v13_0_6_notify_unload(struct smu_context *smu)
 
 static int smu_v13_0_6_mca_set_debug_mode(struct smu_context *smu, bool enable)
 {
-	uint32_t smu_version;
-
 	/* NOTE: this ClearMcaOnRead message is only supported for smu version 85.72.0 or higher */
-	smu_cmn_get_smc_version(smu, NULL, &smu_version);
-	if (smu_version < 0x554800)
+	if (smu->smc_fw_version < 0x554800)
 		return 0;
 
 	return smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_ClearMcaOnRead,
@@ -1670,13 +1662,11 @@ static int smu_v13_0_6_usr_edit_dpm_table(struct smu_context *smu,
 static int smu_v13_0_6_get_enabled_mask(struct smu_context *smu,
 					uint64_t *feature_mask)
 {
-	uint32_t smu_version;
 	int ret;
 
-	smu_cmn_get_smc_version(smu, NULL, &smu_version);
 	ret = smu_cmn_get_enabled_mask(smu, feature_mask);
 
-	if (ret == -EIO && smu_version < 0x552F00) {
+	if (ret == -EIO && smu->smc_fw_version < 0x552F00) {
 		*feature_mask = 0;
 		ret = 0;
 	}
@@ -2115,7 +2105,6 @@ static int smu_v13_0_6_get_thermal_temperature_range(struct smu_context *smu,
 {
 	struct amdgpu_device *adev = smu->adev;
 	u32 aid_temp, xcd_temp, max_temp;
-	uint32_t smu_version;
 	u32 ccd_temp = 0;
 	int ret;
 
@@ -2126,8 +2115,7 @@ static int smu_v13_0_6_get_thermal_temperature_range(struct smu_context *smu,
 		return -EINVAL;
 
 	/*Check smu version, GetCtfLimit message only supported for smu version 85.69 or higher */
-	smu_cmn_get_smc_version(smu, NULL, &smu_version);
-	if (smu_version < 0x554500)
+	if (smu->smc_fw_version < 0x554500)
 		return 0;
 
 	/* Get SOC Max operating temperature */
-- 
2.37.3

