Return-Path: <SRS0=1H3f=ND=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCFFBC432BE
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Aug 2021 09:33:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53D586056B
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Aug 2021 09:33:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 53D586056B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0E506E3B2;
	Thu, 12 Aug 2021 09:33:37 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 582BA6E3CE
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Aug 2021 09:33:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VzApjWtAGWmFO6tQlAUHDYj4OCfQUVPUmyDHjSuiVic/qjT+zMNph/eot6dcX/dWvV6GaS4Fx3hLLn99uZc9d90ndFOV82l2N5XEv1c/wvOFUERWJ+gYVZzvwTPlOAdDEvAcl8BMN7Um4h/6ePckE9KBevHfWzRJbjmXVOuvrUKfm34UvLPubWee0CCsRC7XSmqOz2mFqMy9HuEFh7FZj1pr/Y4SnxQK6zJ4iM5GTBjI2KhadIGMsRFnj5WTLcJLzsecaTvyjsAaAH0ffsejtDdbPh4ge1qXgw40OBHAAzJN0Tzx67iDwnrEDdDbYlNIEhZuRRm1IeA1GVDQprFcVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8BJTwFQqWise7r0n3Fxg3dzts72YFJgXwedx+oYnUM8=;
 b=EjpF8ogpIhT0ZjBYS3lh6heSW9I6MVjet29dRGdm26cTQiMeRDSoqjCxKPIVrSnTYlJvB3QdbZZrm2nPsdZZ8rzJ13Uyro22uPmuG15O0QRPKKP1zZgGKsaCGOav/+EMBTpTd+Oa6Ae5qR9Fyp5XtdGM9Zg2S6qm5PW0a91t4mJ+CskpmSf8tfZ/ckwyIC8vTjmSFJ1gr5T9M32zOL/xbJ3kA+LJIF3T+QgCj2FZX+h1KQX7u0vURNsgKcKnva7JzTyH+nm97i7uYWxpSWUtHy87vjYEj78b4JX/jtYcb7pEc9Y6OMUUlro6CGG6iERXsfDBQs5sOFFUMTI3/QTftA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8BJTwFQqWise7r0n3Fxg3dzts72YFJgXwedx+oYnUM8=;
 b=bVsF1PJC03hSuEYq2tcfkLHdS1ibDjy0vnPgRTK3Yco4VZmBgfSWWKjd4aOF4p7YayF8C6/byDR6lsWOJGdqUQ8vAlyQhUlC31/9O0YDf+wqndkPXlDznDV0xMmhZLxsbhSPCjUjS9tz2Q53b7HqkyRmvMHxS0u5Ai1swGHePlo=
Received: from MWHPR19CA0071.namprd19.prod.outlook.com (2603:10b6:300:94::33)
 by BL1PR12MB5190.namprd12.prod.outlook.com (2603:10b6:208:31c::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14; Thu, 12 Aug
 2021 09:33:33 +0000
Received: from CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:94:cafe::60) by MWHPR19CA0071.outlook.office365.com
 (2603:10b6:300:94::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14 via Frontend
 Transport; Thu, 12 Aug 2021 09:33:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT024.mail.protection.outlook.com (10.13.174.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4415.14 via Frontend Transport; Thu, 12 Aug 2021 09:33:32 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 12 Aug
 2021 04:33:30 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <nils.wallmenius@gmail.com>, <Lijo.Lazar@amd.com>, <Guchun.Chen@amd.com>, 
 Evan Quan <evan.quan@amd.com>
Subject: [PATCH V3 3/7] drm/amd/pm: correct the fan speed PWM retrieving
Date: Thu, 12 Aug 2021 17:33:04 +0800
Message-ID: <20210812093308.1322342-3-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210812093308.1322342-1-evan.quan@amd.com>
References: <20210812093308.1322342-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 54497896-1196-4042-3479-08d95d7440a0
X-MS-TrafficTypeDiagnostic: BL1PR12MB5190:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5190E2DAD58BC5BE1B260B4CE4F99@BL1PR12MB5190.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c68x0FtSr2mX7wNDTxArQDJVF31NKrebobeHScrMe2CkSPmTfjZjmvn67uplhhq1x2tIUdGhGEVmjpOw4zDllOFIhs2kD7W7HwGVjJ4c62aXvu9v/mONxUF2A/jEOU9S0hqOP0xqhCVF9Yf9dnQTD1+V6TcrsQPWdLJ/vjSEiiGKnYaN+3xfVDLDRkqHtGJOgGG7UbA3niW2Ck/RE2WlQr+xh0sQvh3cVwZRE/Bf9l6gptfLi8fhWuEXGIX7FP8Zw07Rb4b5U+ewRj6yDLcv13+tHdNQcgKY1Mekt4w4HO6t/Rdj+xtLrJBnpL78g5DOiqK7S3c2EUZg5CIlN6i3TF/85my6Y+xbSH0OcTU9Glld/yZGwed9Rai1V9AcHi4PTFvvdZj6+ea53e94j5IPutoLyMmte0P2Lix9ACaQ0A9LqewzxN5fQMyt93yYDFqwJ8NuHVFshJ2OC62TXedESLexU8yV3uUcpQNbwt4smuwNeTdOatkluI+omVoTPU6D6xLIMk/Sh3cLBuK9JmG7nBDT7s5Dxxv5TzmRtQeZD6jkFghe+Q4VqwAV+mw4KK3pMd8xja0HTzGkW7YMS0lhDnqHGTj7IKTI2dW01QznBHI+AT6AHwT9sUVkRnoIwc3c1ele96tyYmO4LUk557ocmm2LRHCkGYjETQ5DLL0xC5uQilzyuqacMfPZVFdmowVPqjdppIcqBsvDKsDBQZwQr/iTinXdCi1c0sEaBGEoIe8FVn39tBmPa9fscW+ZQncex35xdbB71lnMREegk0tuRQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(396003)(39860400002)(136003)(346002)(46966006)(36840700001)(316002)(36756003)(47076005)(70206006)(2906002)(70586007)(82740400003)(81166007)(7696005)(83380400001)(36860700001)(5660300002)(86362001)(16526019)(426003)(6666004)(44832011)(8936002)(26005)(2616005)(1076003)(478600001)(54906003)(6916009)(4326008)(186003)(34020700004)(356005)(8676002)(336012)(82310400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2021 09:33:32.9817 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54497896-1196-4042-3479-08d95d7440a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5190
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

