Return-Path: <SRS0=1H3f=ND=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4377FC432BE
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Aug 2021 04:01:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08EA160E78
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Aug 2021 04:01:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 08EA160E78
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09F016E249;
	Thu, 12 Aug 2021 04:01:52 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7FCB6E241
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Aug 2021 04:01:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=luv0Oi5I6eu76ks9M4vQSlYXwO4KwxlI2Uk6FhrJAKkd3FHQwz0ayDzftTXvkRyhoF8RGCYCiJlfwxrkcNwS/nHoi1NjtU96JczOOpn2Lv0QayxyUhHacuiRmdbKrPILiIWEigxSOknsg7GXf4WpckpNbeUZPABM+z3+5G0SwFq3DPq4AaV7msYeVTnPhQPWYWdlGFIuyAPeTQurY95JUbsQrDHsrM9ha1+bLDJToBBKhNMu+zFem8v/Bu9YkDhXSd1daHvGfJVQRrKJDNpzllwZaP5vg44tz7SbV98TEjfbRNl7alRDRnpIN1lghmXztY9P8g4tQTgRV6iJYc0K7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=peHEh16uB4xfDHkBZtMKr4JMQ4Gfi5EvOvB5UEWnQnA=;
 b=clYe33lKBICt4vFdIbpzZuwLvivwTKNOPbiAkic/GKdRt9docX1h9Kn44oA71bRsvS9w9vkowiv7eykupJh2CAigSR4uS//SdNQwSmYqudCwYjDMDCoF2Vit4TopeNsopNhcKPgfPiGxHur5vGj4OLbpDUhtj+skaJSlzsi57evfK/AmumS9QcnE/wvI7JnihEq0QB1zCeyHwO65fjU5kR5uyVqDA7YOCT8YD7QWlc+4VCmMckXwlcxWLnzSHxG0hTu1DUFINh6TJGKrfyIWcPqy4TkdfGS/dRkab8sbLjtevMcMt9WDJREnCTy+Bjkd3zPnIcEWuLjoIiW3C/ZkFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=peHEh16uB4xfDHkBZtMKr4JMQ4Gfi5EvOvB5UEWnQnA=;
 b=0RW8ZGaQVpQO38W7nb57AMf9TG3clcCYGi/224EqQ7cpmVlpOtjnAfkQJVf2nKL0fOwMN3QUPd1Ze4ZNIJ/cFAgR7FAhlV8JSJPSIYOFIfz28FcB/gIGn7UozTM2cPVLFq3NM6TcW+tooXyX1/w/iBKRhgDt90RiaZOOUY6ibEw=
Received: from BN7PR02CA0035.namprd02.prod.outlook.com (2603:10b6:408:20::48)
 by MWHPR12MB1728.namprd12.prod.outlook.com (2603:10b6:300:112::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17; Thu, 12 Aug
 2021 04:01:47 +0000
Received: from BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:20:cafe::a7) by BN7PR02CA0035.outlook.office365.com
 (2603:10b6:408:20::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16 via Frontend
 Transport; Thu, 12 Aug 2021 04:01:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT034.mail.protection.outlook.com (10.13.176.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4415.14 via Frontend Transport; Thu, 12 Aug 2021 04:01:47 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Wed, 11 Aug
 2021 23:01:45 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <nils.wallmenius@gmail.com>, <Lijo.Lazar@amd.com>, <Guchun.Chen@amd.com>, 
 Evan Quan <evan.quan@amd.com>
Subject: [PATCH V2 7/7] drm/amd/pm: correct the address of Arcturus fan
 related registers
Date: Thu, 12 Aug 2021 12:01:10 +0800
Message-ID: <20210812040110.1293682-7-evan.quan@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 064b9b75-e5dd-498b-fdba-08d95d45e81b
X-MS-TrafficTypeDiagnostic: MWHPR12MB1728:
X-Microsoft-Antispam-PRVS: <MWHPR12MB17283683CAA2683FD5F987D4E4F99@MWHPR12MB1728.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NFo0Y+TJzkMk9rV0imx7Xq6kW8/7HGIeBH4Ys5Z8wqEyxuItk+Rp7oe0BndAWbCn69qFYpJqY9tx7LKVVIO6nlOQA2ybO6GBNyOX1r8yjABr+P7deeHYoJPZSvYwhmeH/yLMn2XId7pvIyJIgn5/g6/dFWMaUoT1gP3dEEJd8R5Y4BkhqYwZEKzH+xZaljQ5Yl0Pe3I19gcjoT9hoOFt2ukX0ndNay7hyfIqqBE6ghyDMx1RJ6/vQGkAvePRQuWMxbj+nD8M7vPN36XHveDZwXrtvnb+k/KguVdpLdpo2ir3hipzhGHaLc193GKqH0ef1qGrUjSJZTTiBRnU1adJ4oBwSPt2+VFb0bK6C8Tk1Kas29Ne2U9urEX651x4l2eCOY4IVRTkTztjC6JlxAj029ORe7XBp3C2A6RxEldzmDfBxepYXmrX8emZuM+O1zTPF+WpX9xy7vnOgk+y+pO0XApQwsHDxnDDhcbgjlFvM7mML6qzVtAM8bE7kf0vo4llHoia7wvkICsdrYkSA4HZ6VNKhdEFiUNv4chqJYIq0b6qoDoK+TmIR94jMK6DZfSJKBXCeB05BvvaA/hxbs8VxG+UsLzYiCF5HSwWRBvhQeST1z8hK5QnofF9hlQA7F4HwnRWjbZw+b1CMCcIj5hiYIMZL3juh/zBxYpKtD4EaEht1F4Cvz0dhYSmLYmpjxaLIpD+DmrX6l3Wab7Mm29ffS4bpKriMIqWxIy+ISX6WsPFLTIQ4MXQ9wDYNyexYej2gPVjFMfvekzl3f2aO3AxjA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(346002)(396003)(39860400002)(136003)(46966006)(36840700001)(2906002)(26005)(426003)(16526019)(70586007)(186003)(8936002)(2616005)(36860700001)(70206006)(7696005)(6916009)(478600001)(5660300002)(336012)(44832011)(6666004)(316002)(4326008)(82740400003)(86362001)(36756003)(54906003)(83380400001)(34020700004)(8676002)(356005)(82310400003)(47076005)(1076003)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2021 04:01:47.7471 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 064b9b75-e5dd-498b-fdba-08d95d45e81b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1728
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

These registers have different address from other SMU V11 ASICs.

Change-Id: Iaeb0438331eed9b0313933da25622f8e4c048fab
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
v1->v2:
  - cover the ASIC specific details in arcturus_ppt.c (Lijo)
---
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 138 +++++++++++++++++-
 1 file changed, 133 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index d090a999baf4..1aad6c23db4d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -81,6 +81,24 @@
 
 #define smnPCIE_ESM_CTRL			0x111003D0
 
+#define mmCG_FDO_CTRL0_ARCT			0x8B
+#define mmCG_FDO_CTRL0_ARCT_BASE_IDX		0
+
+#define mmCG_FDO_CTRL1_ARCT			0x8C
+#define mmCG_FDO_CTRL1_ARCT_BASE_IDX		0
+
+#define mmCG_FDO_CTRL2_ARCT			0x8D
+#define mmCG_FDO_CTRL2_ARCT_BASE_IDX		0
+
+#define mmCG_TACH_CTRL_ARCT			0x8E
+#define mmCG_TACH_CTRL_ARCT_BASE_IDX		0
+
+#define mmCG_TACH_STATUS_ARCT			0x8F
+#define mmCG_TACH_STATUS_ARCT_BASE_IDX		0
+
+#define mmCG_THERMAL_STATUS_ARCT		0x90
+#define mmCG_THERMAL_STATUS_ARCT_BASE_IDX	0
+
 static const struct cmn2asic_msg_mapping arcturus_message_map[SMU_MSG_MAX_COUNT] = {
 	MSG_MAP(TestMessage,			     PPSMC_MSG_TestMessage,			0),
 	MSG_MAP(GetSmuVersion,			     PPSMC_MSG_GetSmuVersion,			1),
@@ -1162,9 +1180,28 @@ static int arcturus_read_sensor(struct smu_context *smu,
 	return ret;
 }
 
+static int arcturus_set_fan_static_mode(struct smu_context *smu,
+					uint32_t mode)
+{
+	struct amdgpu_device *adev = smu->adev;
+
+	WREG32_SOC15(THM, 0, mmCG_FDO_CTRL2_ARCT,
+		     REG_SET_FIELD(RREG32_SOC15(THM, 0, mmCG_FDO_CTRL2_ARCT),
+				   CG_FDO_CTRL2, TMIN, 0));
+	WREG32_SOC15(THM, 0, mmCG_FDO_CTRL2_ARCT,
+		     REG_SET_FIELD(RREG32_SOC15(THM, 0, mmCG_FDO_CTRL2_ARCT),
+				   CG_FDO_CTRL2, FDO_PWM_MODE, mode));
+
+	return 0;
+}
+
 static int arcturus_get_fan_speed_rpm(struct smu_context *smu,
 				      uint32_t *speed)
 {
+	struct amdgpu_device *adev = smu->adev;
+	uint32_t crystal_clock_freq = 2500;
+	uint32_t tach_status;
+	uint64_t tmp64;
 	int ret = 0;
 
 	if (!speed)
@@ -1177,14 +1214,105 @@ static int arcturus_get_fan_speed_rpm(struct smu_context *smu,
 						    speed);
 		break;
 	default:
-		ret = smu_v11_0_get_fan_speed_rpm(smu,
-						  speed);
+		/*
+		 * For pre Sienna Cichlid ASICs, the 0 RPM may be not correctly
+		 * detected via register retrieving. To workaround this, we will
+		 * report the fan speed as 0 RPM if user just requested such.
+		 */
+		if ((smu->user_dpm_profile.flags & SMU_CUSTOM_FAN_SPEED_RPM)
+		     && !smu->user_dpm_profile.fan_speed_rpm) {
+			*speed = 0;
+			return 0;
+		}
+
+		tmp64 = (uint64_t)crystal_clock_freq * 60 * 10000;
+		tach_status = RREG32_SOC15(THM, 0, mmCG_TACH_STATUS_ARCT);
+		do_div(tmp64, tach_status);
+		*speed = (uint32_t)tmp64;
+
 		break;
 	}
 
 	return ret;
 }
 
+static int arcturus_set_fan_speed_pwm(struct smu_context *smu,
+				      uint32_t speed)
+{
+	struct amdgpu_device *adev = smu->adev;
+	uint32_t duty100, duty;
+	uint64_t tmp64;
+
+	speed = MIN(speed, 255);
+
+	duty100 = REG_GET_FIELD(RREG32_SOC15(THM, 0, mmCG_FDO_CTRL1_ARCT),
+				CG_FDO_CTRL1, FMAX_DUTY100);
+	if (!duty100)
+		return -EINVAL;
+
+	tmp64 = (uint64_t)speed * duty100;
+	do_div(tmp64, 255);
+	duty = (uint32_t)tmp64;
+
+	WREG32_SOC15(THM, 0, mmCG_FDO_CTRL0_ARCT,
+		     REG_SET_FIELD(RREG32_SOC15(THM, 0, mmCG_FDO_CTRL0_ARCT),
+				   CG_FDO_CTRL0, FDO_STATIC_DUTY, duty));
+
+	return arcturus_set_fan_static_mode(smu, FDO_PWM_MODE_STATIC);
+}
+
+static int arcturus_set_fan_speed_rpm(struct smu_context *smu,
+				      uint32_t speed)
+{
+	struct amdgpu_device *adev = smu->adev;
+	/*
+	 * crystal_clock_freq used for fan speed rpm calculation is
+	 * always 25Mhz. So, hardcode it as 2500(in 10K unit).
+	 */
+	uint32_t crystal_clock_freq = 2500;
+	uint32_t tach_period;
+
+	tach_period = 60 * crystal_clock_freq * 10000 / (8 * speed);
+	WREG32_SOC15(THM, 0, mmCG_TACH_CTRL_ARCT,
+		     REG_SET_FIELD(RREG32_SOC15(THM, 0, mmCG_TACH_CTRL_ARCT),
+				   CG_TACH_CTRL, TARGET_PERIOD,
+				   tach_period));
+
+	return arcturus_set_fan_static_mode(smu, FDO_PWM_MODE_STATIC_RPM);
+}
+
+static int arcturus_get_fan_speed_pwm(struct smu_context *smu,
+				      uint32_t *speed)
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
+	     && !smu->user_dpm_profile.fan_speed_pwm) {
+		*speed = 0;
+		return 0;
+	}
+
+	duty100 = REG_GET_FIELD(RREG32_SOC15(THM, 0, mmCG_FDO_CTRL1_ARCT),
+				CG_FDO_CTRL1, FMAX_DUTY100);
+	duty = REG_GET_FIELD(RREG32_SOC15(THM, 0, mmCG_THERMAL_STATUS_ARCT),
+				CG_THERMAL_STATUS, FDO_PWM_DUTY);
+	if (!duty100)
+		return -EINVAL;
+
+	tmp64 = (uint64_t)duty * 255;
+	do_div(tmp64, duty100);
+	*speed = MIN((uint32_t)tmp64, 255);
+
+	return 0;
+}
+
 static int arcturus_get_fan_parameters(struct smu_context *smu)
 {
 	PPTable_t *pptable = smu->smu_table.driver_pptable;
@@ -2270,7 +2398,7 @@ static const struct pptable_funcs arcturus_ppt_funcs = {
 	.print_clk_levels = arcturus_print_clk_levels,
 	.force_clk_levels = arcturus_force_clk_levels,
 	.read_sensor = arcturus_read_sensor,
-	.get_fan_speed_pwm = smu_v11_0_get_fan_speed_pwm,
+	.get_fan_speed_pwm = arcturus_get_fan_speed_pwm,
 	.get_fan_speed_rpm = arcturus_get_fan_speed_rpm,
 	.get_power_profile_mode = arcturus_get_power_profile_mode,
 	.set_power_profile_mode = arcturus_set_power_profile_mode,
@@ -2316,8 +2444,8 @@ static const struct pptable_funcs arcturus_ppt_funcs = {
 	.display_clock_voltage_request = smu_v11_0_display_clock_voltage_request,
 	.get_fan_control_mode = smu_v11_0_get_fan_control_mode,
 	.set_fan_control_mode = smu_v11_0_set_fan_control_mode,
-	.set_fan_speed_pwm = smu_v11_0_set_fan_speed_pwm,
-	.set_fan_speed_rpm = smu_v11_0_set_fan_speed_rpm,
+	.set_fan_speed_pwm = arcturus_set_fan_speed_pwm,
+	.set_fan_speed_rpm = arcturus_set_fan_speed_rpm,
 	.set_xgmi_pstate = smu_v11_0_set_xgmi_pstate,
 	.gfx_off_control = smu_v11_0_gfx_off_control,
 	.register_irq_handler = smu_v11_0_register_irq_handler,
-- 
2.29.0

