Return-Path: <SRS0=1H3f=ND=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92AFEC4338F
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Aug 2021 04:01:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 352BB60E78
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Aug 2021 04:01:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 352BB60E78
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A921D6E23B;
	Thu, 12 Aug 2021 04:01:44 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E65E6E23D
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Aug 2021 04:01:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CfjlsWhF2rFs/fbfeOhQgLyAoE6ZvBO7zSEn1zqLmdpZPlX7vVZMCtU2UpelLOO5edwwc0Ag/bdmqNVVIJFAFcqhqs3Wiu8snpt/jHEdD7ItnifbC/IOWZ2FJKYzlAgRrpo4fmLA8XD+cTdK3tiRSK2xnwT7POOGoC0zK3RyWgRSEzDYNMtMImVZbzjZjOLXIPbyYV/OOt4vJhRZQRakTrDAL6Y2q+4QZTtKTaKZlVE3Q/NRUA8Q4/yDwHkJX+o80bxtZhQzpxGkIBvmaS7/v8ZEDDQZ330R0YnZhi3sWFvzswYyh37XQ2gu/ZQRAD4gDCZ7zE+ljX2tONutzKwjOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8BJTwFQqWise7r0n3Fxg3dzts72YFJgXwedx+oYnUM8=;
 b=CvMXT1OFdQVF4cJKIHkJabRwQejqv7VpVw4pFidXYjlTaZ/eVB/nM2ZH1aQkZ5LrkYFF7w/16Lwj8g5FfRaomAcfhNNy4J76gAIB6BtBR59m0bykhqiv4dXmeArrIBIkwkPOnVKdJhjBY9IogiUPJ3FNdnUCR1KJgvrnvWVAyLySZeh42/PuHwCDUCans6sWGU4RZI1wK/owBNC+rivgrK3lqtI4hSkwIQOR7VvRg9xdhkvfI6E9KZJnZx5yDZ0qOIpdFgDoGFeDKVvl3FMDnvN52XIJiv1iAIeGlxhbfuvyYuHpKWc7LljCXi2i1bRYAHq1r0hnv45SJlOsstiqrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8BJTwFQqWise7r0n3Fxg3dzts72YFJgXwedx+oYnUM8=;
 b=o9EjIkQKKx4o9YuesIBIx/RxIadtsl6l6DQfpAPq1FRZqoIWPvMFoeQGOno0M2Hbugq6Nf7CEApHXp8q0EpPsi5mfnib4Hc8quOe3sHt0qDMCLQUOqkfgr8EDXhbdU/tDSJWg2rTQCsvxkX/0YIPdQqmXUoz3+Rp9hwb05aSJRU=
Received: from BN6PR19CA0101.namprd19.prod.outlook.com (2603:10b6:404:a0::15)
 by DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17; Thu, 12 Aug
 2021 04:01:39 +0000
Received: from BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:a0:cafe::81) by BN6PR19CA0101.outlook.office365.com
 (2603:10b6:404:a0::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16 via Frontend
 Transport; Thu, 12 Aug 2021 04:01:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT036.mail.protection.outlook.com (10.13.177.168) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4415.14 via Frontend Transport; Thu, 12 Aug 2021 04:01:39 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Wed, 11 Aug
 2021 23:01:37 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <nils.wallmenius@gmail.com>, <Lijo.Lazar@amd.com>, <Guchun.Chen@amd.com>, 
 Evan Quan <evan.quan@amd.com>
Subject: [PATCH V2 3/7] drm/amd/pm: correct the fan speed PWM retrieving
Date: Thu, 12 Aug 2021 12:01:06 +0800
Message-ID: <20210812040110.1293682-3-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210812040110.1293682-1-evan.quan@amd.com>
References: <20210812040110.1293682-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7cbc2baa-93b0-4329-7993-08d95d45e360
X-MS-TrafficTypeDiagnostic: DM5PR12MB2504:
X-Microsoft-Antispam-PRVS: <DM5PR12MB25048B9F4EC23A6771D435F2E4F99@DM5PR12MB2504.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DyW+BmmGAecEe+rvM/e8+rFUcLbVoxwJpjX1cF1rnLrwBLhttLJO6ReokkLPWvC3oB/1i/gR8N2XsCFDAHPdMUTXZnoRtN5qAvCCFRtyK64q98+JMNDB2afoiiuQEVUE5MdTF0aqiH8sFpjzs/8GHWQYEiN30/VzAiuNGyeD5YpUcwzBZdej/jKNE8FDkHQj6JxjuPjyOhTkxxq7RnoKS1O6TAwg6o+PfBJArn5QUeRbV5fvIPFVaj1mjDwx17se5eLlhnZm0OuEQ0eKEBq1ZbhxKPGIBX3kU5b3r4Z1olZPBGo1RaT4EVT1XgRKwciA5TO3n4sRAiycd+vXpZDX6ELIe74HY4WyuudBblVN7MR/aj/6BZmNG79kTXquTtcwaGnit2Mrw1lLA6GGu5Kw/YUhJDF5d6LCmi/LBHePeiUs6lLEr6ydzO4IGXxG3e+6K2WT2pFzyUJohWGYjVcPoTXoHT57nL/fDsn68NjRB9x7Zz6+mLHMHpkFPdpHaXxNHt+qN5JKyz2DTu1mDQsS04de6W2NNXClf4GpZzfgoXbH3C9DSqiOt/epn6NWMCj0Punp0tw0VXxMexspEv0RDjRvyNPkwr8hWaeVJX8x4R+BXzdu8SdMRRgnEThr6e+nMo9dGdiYRpuCV8MO5V6gNhODX2q1V0t0DVzBreOXw6JRcenOKWWAdb6AM7As4w7vl+hbEf+gqjg2QeT3V0i4sUctewibOVu/d+MlJINwdP8jxIU2IfTMxMoqebMxUbiJLmWb+vKb1jd0unH2olEClQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(136003)(39860400002)(46966006)(36840700001)(86362001)(47076005)(8676002)(6916009)(36756003)(2616005)(36860700001)(336012)(426003)(44832011)(4326008)(83380400001)(478600001)(7696005)(2906002)(1076003)(356005)(70586007)(26005)(70206006)(186003)(16526019)(82740400003)(8936002)(34020700004)(316002)(82310400003)(5660300002)(54906003)(6666004)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2021 04:01:39.8073 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cbc2baa-93b0-4329-7993-08d95d45e360
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2504
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

The relationship "PWM = RPM / smu->fan_max_rpm" between fan speed
PWM and RPM is not true for SMU11 ASICs. So, we need a new way to
retrieving the fan speed PWM.

Change-Id: Idfe0276d7113b9c921b88fa08085a33fd971d621
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 .../include/asic_reg/thm/thm_11_0_2_offset.h  |  3 ++
 .../include/asic_reg/thm/thm_11_0_2_sh_mask.h |  3 ++
 drivers/gpu/drm/amd/pm/inc/smu_v11_0.h        |  3 ++
 .../amd/pm/powerplay/hwmgr/vega20_thermal.c   | 24 ++++++++-----
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 25 +------------
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 25 +------------
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 25 +------------
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    | 35 +++++++++++++++++++
 8 files changed, 62 insertions(+), 81 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/asic_reg/thm/thm_11_0_2_offset.h b/drivers/gpu/drm/amd/include/asic_reg/thm/thm_11_0_2_offset.h
index a485526f3a51..eca96abef445 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/thm/thm_11_0_2_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/thm/thm_11_0_2_offset.h
@@ -49,4 +49,7 @@
 #define mmTHM_BACO_CNTL                                                                                0x0081
 #define mmTHM_BACO_CNTL_BASE_IDX                                                                       0
 
+#define mmCG_THERMAL_STATUS                                                                            0x006C
+#define mmCG_THERMAL_STATUS_BASE_IDX                                                                   0
+
 #endif
diff --git a/drivers/gpu/drm/amd/include/asic_reg/thm/thm_11_0_2_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/thm/thm_11_0_2_sh_mask.h
index d130d92aee19..f2f9eae9a68f 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/thm/thm_11_0_2_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/thm/thm_11_0_2_sh_mask.h
@@ -92,5 +92,8 @@
 #define THM_TCON_THERM_TRIP__RSVD3_MASK                                                                       0x7FFFC000L
 #define THM_TCON_THERM_TRIP__SW_THERM_TP_MASK                                                                 0x80000000L
 
+#define CG_THERMAL_STATUS__FDO_PWM_DUTY__SHIFT                                                                0x9
+#define CG_THERMAL_STATUS__FDO_PWM_DUTY_MASK                                                                  0x0001FE00L
+
 #endif
 
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
index b9c8a924dca6..ff31be2eaff9 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
@@ -227,6 +227,9 @@ int smu_v11_0_set_fan_speed_percent(struct smu_context *smu,
 int smu_v11_0_set_fan_speed_rpm(struct smu_context *smu,
 				uint32_t speed);
 
+int smu_v11_0_get_fan_speed_percent(struct smu_context *smu,
+				    uint32_t *speed);
+
 int smu_v11_0_set_xgmi_pstate(struct smu_context *smu,
 				     uint32_t pstate);
 
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_thermal.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_thermal.c
index 269dd7e95a44..43d754952bd9 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_thermal.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_thermal.c
@@ -117,18 +117,24 @@ static int vega20_get_current_rpm(struct pp_hwmgr *hwmgr, uint32_t *current_rpm)
 int vega20_fan_ctrl_get_fan_speed_percent(struct pp_hwmgr *hwmgr,
 		uint32_t *speed)
 {
-	struct vega20_hwmgr *data = (struct vega20_hwmgr *)(hwmgr->backend);
-	PPTable_t *pp_table = &(data->smc_state_table.pp_table);
-	uint32_t current_rpm, percent = 0;
-	int ret = 0;
+	struct amdgpu_device *adev = hwmgr->adev;
+	uint32_t duty100, duty;
+	uint64_t tmp64;
 
-	ret = vega20_get_current_rpm(hwmgr, &current_rpm);
-	if (ret)
-		return ret;
+	duty100 = REG_GET_FIELD(RREG32_SOC15(THM, 0, mmCG_FDO_CTRL1),
+				CG_FDO_CTRL1, FMAX_DUTY100);
+	duty = REG_GET_FIELD(RREG32_SOC15(THM, 0, mmCG_THERMAL_STATUS),
+				CG_THERMAL_STATUS, FDO_PWM_DUTY);
+
+	if (!duty100)
+		return -EINVAL;
 
-	percent = current_rpm * 100 / pp_table->FanMaximumRpm;
+	tmp64 = (uint64_t)duty * 100;
+	do_div(tmp64, duty100);
+	*speed = (uint32_t)tmp64;
 
-	*speed = percent > 100 ? 100 : percent;
+	if (*speed > 100)
+		*speed = 100;
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index f909cda86299..74cd957f37da 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -1162,29 +1162,6 @@ static int arcturus_read_sensor(struct smu_context *smu,
 	return ret;
 }
 
-static int arcturus_get_fan_speed_percent(struct smu_context *smu,
-					  uint32_t *speed)
-{
-	int ret;
-	u32 rpm;
-
-	if (!speed)
-		return -EINVAL;
-
-	switch (smu_v11_0_get_fan_control_mode(smu)) {
-	case AMD_FAN_CTRL_AUTO:
-		ret = arcturus_get_smu_metrics_data(smu,
-						    METRICS_CURR_FANSPEED,
-						    &rpm);
-		if (!ret && smu->fan_max_rpm)
-			*speed = rpm * 100 / smu->fan_max_rpm;
-		return ret;
-	default:
-		*speed = smu->user_dpm_profile.fan_speed_percent;
-		return 0;
-	}
-}
-
 static int arcturus_get_fan_parameters(struct smu_context *smu)
 {
 	PPTable_t *pptable = smu->smu_table.driver_pptable;
@@ -2270,7 +2247,7 @@ static const struct pptable_funcs arcturus_ppt_funcs = {
 	.print_clk_levels = arcturus_print_clk_levels,
 	.force_clk_levels = arcturus_force_clk_levels,
 	.read_sensor = arcturus_read_sensor,
-	.get_fan_speed_percent = arcturus_get_fan_speed_percent,
+	.get_fan_speed_percent = smu_v11_0_get_fan_speed_percent,
 	.get_power_profile_mode = arcturus_get_power_profile_mode,
 	.set_power_profile_mode = arcturus_set_power_profile_mode,
 	.set_performance_level = arcturus_set_performance_level,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 08b0edcbc8f9..c0bd52c307cf 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -1668,29 +1668,6 @@ static bool navi10_is_dpm_running(struct smu_context *smu)
 	return !!(feature_enabled & SMC_DPM_FEATURE);
 }
 
-static int navi10_get_fan_speed_percent(struct smu_context *smu,
-					uint32_t *speed)
-{
-	int ret;
-	u32 rpm;
-
-	if (!speed)
-		return -EINVAL;
-
-	switch (smu_v11_0_get_fan_control_mode(smu)) {
-	case AMD_FAN_CTRL_AUTO:
-		ret = navi1x_get_smu_metrics_data(smu,
-						  METRICS_CURR_FANSPEED,
-						  &rpm);
-		if (!ret && smu->fan_max_rpm)
-			*speed = rpm * 100 / smu->fan_max_rpm;
-		return ret;
-	default:
-		*speed = smu->user_dpm_profile.fan_speed_percent;
-		return 0;
-	}
-}
-
 static int navi10_get_fan_parameters(struct smu_context *smu)
 {
 	PPTable_t *pptable = smu->smu_table.driver_pptable;
@@ -3224,7 +3201,7 @@ static const struct pptable_funcs navi10_ppt_funcs = {
 	.display_config_changed = navi10_display_config_changed,
 	.notify_smc_display_config = navi10_notify_smc_display_config,
 	.is_dpm_running = navi10_is_dpm_running,
-	.get_fan_speed_percent = navi10_get_fan_speed_percent,
+	.get_fan_speed_percent = smu_v11_0_get_fan_speed_percent,
 	.get_power_profile_mode = navi10_get_power_profile_mode,
 	.set_power_profile_mode = navi10_set_power_profile_mode,
 	.set_watermarks_table = navi10_set_watermarks_table,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 4e28a4ff1817..0b9be89276ab 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -1354,29 +1354,6 @@ static bool sienna_cichlid_is_dpm_running(struct smu_context *smu)
 	return !!(feature_enabled & SMC_DPM_FEATURE);
 }
 
-static int sienna_cichlid_get_fan_speed_percent(struct smu_context *smu,
-						uint32_t *speed)
-{
-	int ret;
-	u32 rpm;
-
-	if (!speed)
-		return -EINVAL;
-
-	switch (smu_v11_0_get_fan_control_mode(smu)) {
-	case AMD_FAN_CTRL_AUTO:
-		ret = sienna_cichlid_get_smu_metrics_data(smu,
-							  METRICS_CURR_FANSPEED,
-							  &rpm);
-		if (!ret && smu->fan_max_rpm)
-			*speed = rpm * 100 / smu->fan_max_rpm;
-		return ret;
-	default:
-		*speed = smu->user_dpm_profile.fan_speed_percent;
-		return 0;
-	}
-}
-
 static int sienna_cichlid_get_fan_parameters(struct smu_context *smu)
 {
 	uint16_t *table_member;
@@ -3859,7 +3836,7 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 	.display_config_changed = sienna_cichlid_display_config_changed,
 	.notify_smc_display_config = sienna_cichlid_notify_smc_display_config,
 	.is_dpm_running = sienna_cichlid_is_dpm_running,
-	.get_fan_speed_percent = sienna_cichlid_get_fan_speed_percent,
+	.get_fan_speed_percent = smu_v11_0_get_fan_speed_percent,
 	.get_power_profile_mode = sienna_cichlid_get_power_profile_mode,
 	.set_power_profile_mode = sienna_cichlid_set_power_profile_mode,
 	.set_watermarks_table = sienna_cichlid_set_watermarks_table,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 007f84bdda6f..1f3230f232b7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -1263,6 +1263,41 @@ int smu_v11_0_set_fan_speed_rpm(struct smu_context *smu,
 	return ret;
 }
 
+int smu_v11_0_get_fan_speed_percent(struct smu_context *smu,
+				    uint32_t *speed)
+{
+	struct amdgpu_device *adev = smu->adev;
+	uint32_t duty100, duty;
+	uint64_t tmp64;
+
+	/*
+	 * For pre Sienna Cichlid ASICs, the 0 RPM may be not correctly
+	 * detected via register retrieving. To workaround this, we will
+	 * report the fan speed as 0 PWM if user just requested such.
+	 */
+	if ((smu->user_dpm_profile.flags & SMU_CUSTOM_FAN_SPEED_PWM)
+	     && !smu->user_dpm_profile.fan_speed_percent) {
+		*speed = 0;
+		return 0;
+	}
+
+	duty100 = REG_GET_FIELD(RREG32_SOC15(THM, 0, mmCG_FDO_CTRL1),
+				CG_FDO_CTRL1, FMAX_DUTY100);
+	duty = REG_GET_FIELD(RREG32_SOC15(THM, 0, mmCG_THERMAL_STATUS),
+				CG_THERMAL_STATUS, FDO_PWM_DUTY);
+	if (!duty100)
+		return -EINVAL;
+
+	tmp64 = (uint64_t)duty * 100;
+	do_div(tmp64, duty100);
+	*speed = (uint32_t)tmp64;
+
+	if (*speed > 100)
+		*speed = 100;
+
+	return 0;
+}
+
 int
 smu_v11_0_set_fan_control_mode(struct smu_context *smu,
 			       uint32_t mode)
-- 
2.29.0

