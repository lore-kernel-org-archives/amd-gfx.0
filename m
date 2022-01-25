Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D711C433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Jan 2022 09:00:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF19E10E922;
	Tue, 25 Jan 2022 09:00:43 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2083F10E8CE
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Jan 2022 09:00:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NFPw5BGlo7Mvr2uVQ3tGTAT4jX7mq5cO9n+cmTe5CnM5KlnLGCxod3t8u9ebLJ7oqRDg9WbrBYv01slGaeCfCbxwjBPBcT1FIroPCYQBMEvEY/jB8zQtX0S1OfSEcg3g14AbouBTHb6zSuL7FJEI6qy0T/HNE8E/3f4XG1cxpSqv4+RtkXiWaM9/GBO8aa5DsHoHycri5L2oLJiOm1U4/mCBnAeiXppto1nIdyJlUmuZL6oWqzK+DOBXWKR70Wj6M3qjGLfuvNKcPklmL6h64n6bUITK5/5GziiQwZzBQjLYiOgyZFAOXQh/Yat1xzGL7JaFwoDJ1C3pIFr6HPTBDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uNdkF7h43QWHYrU3iwdXIZ/qRWUiv5Ly1M9DYR7KavE=;
 b=NhiKGyZIWpA/TF25tp4YdQ9zUphtLIRIjxPQ29aQHRb5Yzl4qgW8QiXi6H6xI25aSlFH8YA3IJ/c5qedM4ugx2vOfJViNoRiZZ7W83YvOP/utm3PIXw53TZ1aEiLe/nT/lqkJ0R1FqBlW4HLD3GuGpI4OFVGNRjA+erFeVXuVo/aDzyDAarnwpkvPVC4hoBlObCDaGjd3HVUV/qq4oG7ftZ61cFv2UQhEjncjSRtO8sf1/tGmEUx5Pw43KCfAeho+JWWfgaH8edMQMCw6bDlIVZFGnp8f4kqc0M5wKQiaBFuuKkwFKhQ/V2yHBbsXWJ3pi0sTUPXfDnXPmQ+f0BxKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uNdkF7h43QWHYrU3iwdXIZ/qRWUiv5Ly1M9DYR7KavE=;
 b=rSWIahoShr9+HRhEhFy0GkB6fELmzX9lRdv3YQSicTCbpJ3Aw9PNwzibXaLXBglz4FE496K0BXnM8e2BlOYxH8jQ4WoLXKomOJDp+M4RFYUJX2b4VKMcRInjR1ahKmnZiBv3F4qwySMGafeS60sCRrnfYXLz9fKeeHAs+RHTdR4=
Received: from MW4PR03CA0260.namprd03.prod.outlook.com (2603:10b6:303:b4::25)
 by MN2PR12MB3535.namprd12.prod.outlook.com (2603:10b6:208:105::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Tue, 25 Jan
 2022 09:00:38 +0000
Received: from CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b4:cafe::de) by MW4PR03CA0260.outlook.office365.com
 (2603:10b6:303:b4::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8 via Frontend
 Transport; Tue, 25 Jan 2022 09:00:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT003.mail.protection.outlook.com (10.13.175.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Tue, 25 Jan 2022 09:00:37 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 25 Jan
 2022 03:00:35 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 4/7] drm/amd/pm: correct the usage for 'supported' member
 of smu_feature structure
Date: Tue, 25 Jan 2022 17:00:10 +0800
Message-ID: <20220125090013.102080-4-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220125090013.102080-1-evan.quan@amd.com>
References: <20220125090013.102080-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c918c473-e230-4e6d-69a0-08d9dfe127dc
X-MS-TrafficTypeDiagnostic: MN2PR12MB3535:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3535E6C8C93343A560623C31E45F9@MN2PR12MB3535.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:318;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5RPg9kos2aGwB9DlW6YlJp96BcVpoPc9rrccpTVDaUFzauphkVVP/9wKy3vo5XzlXEgJ430lUCPBxs5dGH5MKg8XZprwPhN5wwXlTJYe7mxKfHjW0QnU4mVGU3cTi7DawuDPzAf8Pin3th5wZWAo+lwJIiE4TEczPYigZWnSB9/5d7OQ3w+GdMHpWS2KSYX1NwTnLLDQFaWmq4cjec0pdi03AegcPBUlPmZ3uTvQ8u1+2ByS7FzdaQk7bm0wkaQD8wZV7X0Huxu1DACSR72li5u8JY+QPtHucSH4I2dhevFIFIdMYQLNcWzCfhOJRqtMy1EK8nk9M0xbviakXB+nZ+RzvIFk9BYRwvY8n+2rkH8wqgIImjU5Si4BhyJgY7R3DuulCdf35P3gGjRHd3/e5nBCkQ69CtsvGIVENWTig13ojsoQHYkZCbNWZzU8hqG1qfzrtWEGb2KD5cZ1dMSIoPiLozvIcxVZ7KdV0dP5Hw1y6aVx1XyHA0nakkXXYMwQ1e34B0PEHMnoKAdoPA8/DmueUgpivaEbkZbx0HgBGZRD4GZzq113tnIi4ODpUPugPvXmvsAdgh4zDKKeDgMgSg5uubOMawd9CabNy7PUf6Xyc9cN61UuGT6jGpACEJoWhK9xWh8q5NSOrqe9cHjih8YyCn2YV030qUtlJsX3PE/HBc1iAtzGr9wt0DCEYoz2olpLHCyT71DDl9184nfnQPqE6U8UmRaeVCyJpu7HjL0eqQ31LsMC+e8dDSq1zFlTRtOEKhM5sJI5VYdVegPX14Pl1MNKaPiQxZao0kN6woo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(40470700004)(46966006)(16526019)(356005)(40460700003)(82310400004)(186003)(7696005)(26005)(426003)(36860700001)(5660300002)(6916009)(44832011)(4326008)(6666004)(8936002)(86362001)(70206006)(54906003)(2616005)(508600001)(36756003)(83380400001)(8676002)(70586007)(81166007)(1076003)(2906002)(47076005)(316002)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2022 09:00:37.7309 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c918c473-e230-4e6d-69a0-08d9dfe127dc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3535
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
Cc: Alexander.Deucher@amd.com, Lijo.Lazar@amd.com,
 Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The supported features should be retrieved just after EnableAllDpmFeatures message
complete. And the check(whether some dpm feature is supported) is only needed when we
decide to enable or disable it.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: I07c9a5ac5290cd0d88a40ce1768d393156419b5a
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c             | 11 +++++++++++
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c       |  8 ++++----
 .../gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 10 +++++-----
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c        |  3 ---
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c      |  5 +----
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c        |  3 ---
 drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  |  3 ---
 7 files changed, 21 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 95929cede585..1ef15f092b35 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1057,8 +1057,10 @@ static int smu_get_thermal_temperature_range(struct smu_context *smu)
 
 static int smu_smc_hw_setup(struct smu_context *smu)
 {
+	struct smu_feature *feature = &smu->smu_feature;
 	struct amdgpu_device *adev = smu->adev;
 	uint32_t pcie_gen = 0, pcie_width = 0;
+	uint64_t features_supported;
 	int ret = 0;
 
 	if (adev->in_suspend && smu_is_dpm_running(smu)) {
@@ -1138,6 +1140,15 @@ static int smu_smc_hw_setup(struct smu_context *smu)
 		return ret;
 	}
 
+	ret = smu_feature_get_enabled_mask(smu, &features_supported);
+	if (ret) {
+		dev_err(adev->dev, "Failed to retrieve supported dpm features!\n");
+		return ret;
+	}
+	bitmap_copy(feature->supported,
+		    (unsigned long *)&features_supported,
+		    feature->feature_num);
+
 	if (!smu_is_dpm_running(smu))
 		dev_info(adev->dev, "dpm has been disabled\n");
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index b68bce921453..4a41cd6c5ea4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -1625,8 +1625,8 @@ static int navi10_display_config_changed(struct smu_context *smu)
 	int ret = 0;
 
 	if ((smu->watermarks_bitmap & WATERMARKS_EXIST) &&
-	    smu_cmn_feature_is_supported(smu, SMU_FEATURE_DPM_DCEFCLK_BIT) &&
-	    smu_cmn_feature_is_supported(smu, SMU_FEATURE_DPM_SOCCLK_BIT)) {
+	    smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_DCEFCLK_BIT) &&
+	    smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_SOCCLK_BIT)) {
 		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_NumOfDisplays,
 						  smu->display_config->num_display,
 						  NULL);
@@ -1861,13 +1861,13 @@ static int navi10_notify_smc_display_config(struct smu_context *smu)
 	min_clocks.dcef_clock_in_sr = smu->display_config->min_dcef_deep_sleep_set_clk;
 	min_clocks.memory_clock = smu->display_config->min_mem_set_clock;
 
-	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_DPM_DCEFCLK_BIT)) {
+	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_DCEFCLK_BIT)) {
 		clock_req.clock_type = amd_pp_dcef_clock;
 		clock_req.clock_freq_in_khz = min_clocks.dcef_clock * 10;
 
 		ret = smu_v11_0_display_clock_voltage_request(smu, &clock_req);
 		if (!ret) {
-			if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_DS_DCEFCLK_BIT)) {
+			if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DS_DCEFCLK_BIT)) {
 				ret = smu_cmn_send_smc_msg_with_param(smu,
 								  SMU_MSG_SetMinDeepSleepDcefclk,
 								  min_clocks.dcef_clock_in_sr/100,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 98ea283f2a78..be522fd1088c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -1281,8 +1281,8 @@ static int sienna_cichlid_display_config_changed(struct smu_context *smu)
 	int ret = 0;
 
 	if ((smu->watermarks_bitmap & WATERMARKS_EXIST) &&
-	    smu_cmn_feature_is_supported(smu, SMU_FEATURE_DPM_DCEFCLK_BIT) &&
-	    smu_cmn_feature_is_supported(smu, SMU_FEATURE_DPM_SOCCLK_BIT)) {
+	    smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_DCEFCLK_BIT) &&
+	    smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_SOCCLK_BIT)) {
 #if 0
 		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_NumOfDisplays,
 						  smu->display_config->num_display,
@@ -1518,13 +1518,13 @@ static int sienna_cichlid_notify_smc_display_config(struct smu_context *smu)
 	min_clocks.dcef_clock_in_sr = smu->display_config->min_dcef_deep_sleep_set_clk;
 	min_clocks.memory_clock = smu->display_config->min_mem_set_clock;
 
-	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_DPM_DCEFCLK_BIT)) {
+	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_DCEFCLK_BIT)) {
 		clock_req.clock_type = amd_pp_dcef_clock;
 		clock_req.clock_freq_in_khz = min_clocks.dcef_clock * 10;
 
 		ret = smu_v11_0_display_clock_voltage_request(smu, &clock_req);
 		if (!ret) {
-			if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_DS_DCEFCLK_BIT)) {
+			if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DS_DCEFCLK_BIT)) {
 				ret = smu_cmn_send_smc_msg_with_param(smu,
 								  SMU_MSG_SetMinDeepSleepDcefclk,
 								  min_clocks.dcef_clock_in_sr/100,
@@ -3749,7 +3749,7 @@ static int sienna_cichlid_gpo_control(struct smu_context *smu,
 	int ret = 0;
 
 
-	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_DPM_GFX_GPO_BIT)) {
+	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_GFX_GPO_BIT)) {
 		ret = smu_cmn_get_smc_version(smu, NULL, &smu_version);
 		if (ret)
 			return ret;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index b34d3a416939..d36b64371492 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -808,7 +808,6 @@ int smu_v11_0_system_features_control(struct smu_context *smu,
 		return ret;
 
 	bitmap_zero(feature->enabled, feature->feature_num);
-	bitmap_zero(feature->supported, feature->feature_num);
 
 	if (en) {
 		ret = smu_cmn_get_enabled_mask(smu, &feature_mask);
@@ -817,8 +816,6 @@ int smu_v11_0_system_features_control(struct smu_context *smu,
 
 		bitmap_copy(feature->enabled, (unsigned long *)&feature_mask,
 			    feature->feature_num);
-		bitmap_copy(feature->supported, (unsigned long *)&feature_mask,
-			    feature->feature_num);
 	}
 
 	return ret;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 65f30cdafc8f..478151e72889 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -1956,7 +1956,6 @@ static int vangogh_system_features_control(struct smu_context *smu, bool en)
 						      RLC_STATUS_OFF, NULL);
 
 	bitmap_zero(feature->enabled, feature->feature_num);
-	bitmap_zero(feature->supported, feature->feature_num);
 
 	if (!en)
 		return ret;
@@ -1967,8 +1966,6 @@ static int vangogh_system_features_control(struct smu_context *smu, bool en)
 
 	bitmap_copy(feature->enabled, (unsigned long *)&feature_mask,
 		    feature->feature_num);
-	bitmap_copy(feature->supported, (unsigned long *)&feature_mask,
-		    feature->feature_num);
 
 	return 0;
 }
@@ -1985,7 +1982,7 @@ static int vangogh_post_smu_init(struct smu_context *smu)
 		adev->gfx.config.max_sh_per_se * adev->gfx.config.max_shader_engines;
 
 	/* allow message will be sent after enable message on Vangogh*/
-	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_DPM_GFXCLK_BIT) &&
+	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_GFXCLK_BIT) &&
 			(adev->pg_flags & AMD_PG_SUPPORT_GFX_PG)) {
 		ret = smu_cmn_send_smc_msg(smu, SMU_MSG_EnableGfxOff, NULL);
 		if (ret) {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 6b77fc4b4698..92b5c1108a2e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -774,7 +774,6 @@ int smu_v13_0_system_features_control(struct smu_context *smu,
 		return ret;
 
 	bitmap_zero(feature->enabled, feature->feature_num);
-	bitmap_zero(feature->supported, feature->feature_num);
 
 	if (en) {
 		ret = smu_cmn_get_enabled_mask(smu, &feature_mask);
@@ -783,8 +782,6 @@ int smu_v13_0_system_features_control(struct smu_context *smu,
 
 		bitmap_copy(feature->enabled, (unsigned long *)&feature_mask,
 			    feature->feature_num);
-		bitmap_copy(feature->supported, (unsigned long *)&feature_mask,
-			    feature->feature_num);
 	}
 
 	return ret;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
index a7aabb8079ed..d89e8a03651b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
@@ -204,7 +204,6 @@ static int yellow_carp_system_features_control(struct smu_context *smu, bool en)
 		ret = smu_cmn_send_smc_msg(smu, SMU_MSG_PrepareMp1ForUnload, NULL);
 
 	bitmap_zero(feature->enabled, feature->feature_num);
-	bitmap_zero(feature->supported, feature->feature_num);
 
 	if (!en)
 		return ret;
@@ -215,8 +214,6 @@ static int yellow_carp_system_features_control(struct smu_context *smu, bool en)
 
 	bitmap_copy(feature->enabled, (unsigned long *)&feature_mask,
 		    feature->feature_num);
-	bitmap_copy(feature->supported, (unsigned long *)&feature_mask,
-		    feature->feature_num);
 
 	return 0;
 }
-- 
2.29.0

