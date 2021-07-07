Return-Path: <SRS0=5bFg=L7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65080C07E96
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jul 2021 01:59:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 330EE61A3E
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jul 2021 01:59:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 330EE61A3E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED4D66E7EF;
	Wed,  7 Jul 2021 01:59:27 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2083.outbound.protection.outlook.com [40.107.236.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4E8C6E7EF
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jul 2021 01:59:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LWP7pqcG5tE/8nmMK6aUp9hlMCDvk5VnIDtmxCoXG785IWTqQYFi/d8LF+9npuyxdWYmiZ3A4V0jcI28BsBP+WhuW/vE4s0WBk5I11nytSlHb4lscbjOBE6tHD6p7PHgA0XxFc6TS1xVN1vYwfph0cx5JNluajyoNBMNOI3LGieUAFiEs69dg4zAJFEKLVb4C9Vcbvn4Gv4CljA4E2/+/pbF4nqP35s8HU1AReInh7or2H9Yx8vTC4gDLA3+pUyAiVw7W1hNSRzxGOQeVY0UjBlY7lGseT5svbIFCKmRZ8cEs7JtJtFsp0aCDN+5A1HHmqbKmRik3eek4GJ0HCBAXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NOGN4lOKfg0/iHshkjDCG/Gag5m9g2ebPVPlZvp7nMA=;
 b=BKWttuifADdjtv3kqRAUVet1C7g4jSa32QOJM/hjJw86TZ+FpgxynsyaVf4Ggut9pPC+htPoG+M8zM552BbWyBNff7BAAdz/B0fhoWuOMbWRrtFZe+k5dQK5vMBAAg9Ea7ec0HEK4QyyxuKMulBZcHJOZOp0Rlioovu0WAnxkVxQP6YsUzhDwxXYW/EAgDWMbq4vifPbmlr9uLxO2FfsVjLREp6f4XHZ6F8CeeUEsaMuzgao2t68s30jbHAEMovQnJCkfIsCmHDMR6bTy2PG3o+WlvQM/E/E3xLnSZwOirXmtl6Sy0aKjW5MqQ5xpYfklg5TqLle6P1euVoSr+VIYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NOGN4lOKfg0/iHshkjDCG/Gag5m9g2ebPVPlZvp7nMA=;
 b=0uVp1jOul+MKVTbxv9UhTZqtpE3YKgWa/7+eYWRLCMSp0YR/260d7/WZkPls7qlCsnPYYBSSqJLMyR45HGrG+CHPvDJg+ki29xdD96iWDQZvB278daaj0NlDKnj5JYaz6PpPIjtMQafYmA+bOGe7IN4zEXMCg15RJg0c6yWkOtw=
Received: from DM5PR06CA0094.namprd06.prod.outlook.com (2603:10b6:3:4::32) by
 SN1PR12MB2448.namprd12.prod.outlook.com (2603:10b6:802:28::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4287.22; Wed, 7 Jul 2021 01:59:24 +0000
Received: from DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:4:cafe::b1) by DM5PR06CA0094.outlook.office365.com
 (2603:10b6:3:4::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend
 Transport; Wed, 7 Jul 2021 01:59:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT018.mail.protection.outlook.com (10.13.172.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4308.20 via Frontend Transport; Wed, 7 Jul 2021 01:59:24 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 6 Jul 2021
 20:59:22 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/7] drm/amd/pm: correct the fan speed PWM retrieving
Date: Wed, 7 Jul 2021 09:56:43 +0800
Message-ID: <20210707015647.139127-3-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210707015647.139127-1-evan.quan@amd.com>
References: <20210707015647.139127-1-evan.quan@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9ef9afe5-9c75-489f-75d6-08d940ead84e
X-MS-TrafficTypeDiagnostic: SN1PR12MB2448:
X-Microsoft-Antispam-PRVS: <SN1PR12MB24489EC6A19AF32F9D34FFC9E41A9@SN1PR12MB2448.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FWbNfif4VYDSY3OHsnqWDhBfHwlnXInAh3c3w84UcQOf7GiXbC2FjRPBrmyHklmvy7ERfEXYS+wQ5LzCkKxEN8ow8+l/JcHZb8V4tD0NArg884GCk76XlzFVcRAVauF1hwJADpUDnOaUL9DziCBow721kBchMwimi4PReY4IB8flldeP59b9aa/+r4/P9gymCLh02F34QwXtMRnkNQhaQyoT3fdMo4NKG87J2WcNoBzfs6oNsUZrbjqyygL1DbcomAoGjdANUUxJ/nwSfv4Y63xpOeWWgpiawk/RIKOnHx0uaFxM/TL3TcPd562cUjDZSQwCBII5y7jotjOgxBM2tTqCPjXDHZSJDuhCRv2OQ44Pq3J+h0zKbcisfoRHCXtinfN/W30BjpkJLQGqiss50jPI+KNO6t37aVbU9ryY2ZetSrnXXsbJl02jG4MPSNsnpUKMaBizB99rPNNkDZjjFksjJ5szVhrwxaPZaQCqRqrel3Z7pxCu9/PWbHZfTCxoHfX46y13NDKqXvhfzUtStREXSb/MRnU1ognM268FcrX5j8UolmUFjBUMzLz5r4t9iHEvQuWI6pno8592vgc29+yYVa52hMZwvMyJdo6R59met6YDTXnolhe4H2x63f0d8jrtp7hUNq8om8N6vGoDeH++OM8U9RP5n7f2K/nkJFlLkGZ67fXYbsamng9DlK5tY2TaM+tE+2O+aABy1jJBqZDUBYAou/9xMdUEH4T7GXg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(396003)(39860400002)(376002)(346002)(46966006)(36840700001)(426003)(54906003)(8676002)(36756003)(2616005)(44832011)(70586007)(336012)(6666004)(82310400003)(36860700001)(47076005)(7696005)(356005)(4326008)(478600001)(82740400003)(86362001)(70206006)(16526019)(6916009)(186003)(81166007)(26005)(83380400001)(8936002)(2906002)(5660300002)(316002)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 01:59:24.4111 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ef9afe5-9c75-489f-75d6-08d940ead84e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2448
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
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
index 134a33e3de91..8e0f8e9a1665 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
@@ -226,6 +226,9 @@ int smu_v11_0_set_fan_speed_percent(struct smu_context *smu,
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
index 047adf6dd444..4a6544b8e05e 100644
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
@@ -2268,7 +2245,7 @@ static const struct pptable_funcs arcturus_ppt_funcs = {
 	.print_clk_levels = arcturus_print_clk_levels,
 	.force_clk_levels = arcturus_force_clk_levels,
 	.read_sensor = arcturus_read_sensor,
-	.get_fan_speed_percent = arcturus_get_fan_speed_percent,
+	.get_fan_speed_percent = smu_v11_0_get_fan_speed_percent,
 	.get_power_profile_mode = arcturus_get_power_profile_mode,
 	.set_power_profile_mode = arcturus_set_power_profile_mode,
 	.set_performance_level = arcturus_set_performance_level,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index d8a011483dcf..2ddf35788672 100644
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
@@ -3204,7 +3181,7 @@ static const struct pptable_funcs navi10_ppt_funcs = {
 	.display_config_changed = navi10_display_config_changed,
 	.notify_smc_display_config = navi10_notify_smc_display_config,
 	.is_dpm_running = navi10_is_dpm_running,
-	.get_fan_speed_percent = navi10_get_fan_speed_percent,
+	.get_fan_speed_percent = smu_v11_0_get_fan_speed_percent,
 	.get_power_profile_mode = navi10_get_power_profile_mode,
 	.set_power_profile_mode = navi10_set_power_profile_mode,
 	.set_watermarks_table = navi10_set_watermarks_table,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index dad120294c19..e7686ce6744b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -1355,29 +1355,6 @@ static bool sienna_cichlid_is_dpm_running(struct smu_context *smu)
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
@@ -3842,7 +3819,7 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 	.display_config_changed = sienna_cichlid_display_config_changed,
 	.notify_smc_display_config = sienna_cichlid_notify_smc_display_config,
 	.is_dpm_running = sienna_cichlid_is_dpm_running,
-	.get_fan_speed_percent = sienna_cichlid_get_fan_speed_percent,
+	.get_fan_speed_percent = smu_v11_0_get_fan_speed_percent,
 	.get_power_profile_mode = sienna_cichlid_get_power_profile_mode,
 	.set_power_profile_mode = sienna_cichlid_set_power_profile_mode,
 	.set_watermarks_table = sienna_cichlid_set_watermarks_table,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index fefc8e93fdc6..c49683b07076 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -1249,6 +1249,41 @@ int smu_v11_0_set_fan_speed_rpm(struct smu_context *smu,
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
+	if ((smu->user_dpm_profile.custom_fan_speed & SMU_CUSTOM_FAN_SPEED_PWM)
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

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
