Return-Path: <SRS0=1H3f=ND=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD8E5C432BE
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Aug 2021 09:33:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DE9C6056B
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Aug 2021 09:33:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6DE9C6056B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9F206E3CE;
	Thu, 12 Aug 2021 09:33:45 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 514C06E3CE
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Aug 2021 09:33:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lgW81snmnXByTIPo5Ew+mvaY8JTMsH+02Q6R45/lJRupihgRY7jlCDTMshvXwGZ5P7TJS5CdUpHNU75G2Ftuhlrie5MLnGE3auRZiqPuWVTMXIRE3KzXbTZulYPlBvJYR8XsbynGUqu4kVIn1RTUreVWuVY277XYQ94GjlXESaMhF/ffrk0xS27WayZKXaNJUH099S4DHYEQEO7XfoAvg138GRuI9TtJjd5Y+YHK8wNud0kTa9XtNokMhNbOOxjWfHQ1SeNxD9SM4Imwx69nc/Kg+9YzR6s+m8uE0sagbAfuI4hTemiSuuRBWCclV+hlUCTMJqFsbZIPTLZ/lonEfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=peHEh16uB4xfDHkBZtMKr4JMQ4Gfi5EvOvB5UEWnQnA=;
 b=Nzkoo8yYfuA4q8q/GY1i7ycwZAQb1td/FgtjynqOWQZqQMigs/oT7VCCY5aWzbetbLxPY0o6HxP88OJP1Ljm+pMBhZke5nnm7nVrAlMHuLGDe/o7w1vDUNkw1zcxawJdDeZpGMaHEHBr6EJ/B5e3r70TS2YQTpbZtlg//twYhMy9Sbrw+fcZ+f3IUV61JjV+pSfhcnGUSXFtjTEbOVns+2S3tuE1UZ4B7VRsMibgJ83pD9wIDngT9yxmDDbhkzLi1c8W7v+evZBdfAz2Stt1s+z2YDOiANjKuCnjCeBg+JuiE6y1ISLl5ihy8/tEGT7DE6A/Ol6NAi2tnHj1fzxRDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=peHEh16uB4xfDHkBZtMKr4JMQ4Gfi5EvOvB5UEWnQnA=;
 b=zb0+Ho98CHMbFm0iqKGx1Q9MeGV7W5s2BoYscIjdjboy60PT6t1dx0VTinz9BvWTMgeFnZcBCZJZiU2FxI3QpwTGZ9RllZtsCmtafRUdtdOgMT5WJLrAUe5Oy2m2lQFsTaA47gqxYXk8PiQ2FVBxioWclX9OYImepdwu//QTgXQ=
Received: from MWHPR02CA0020.namprd02.prod.outlook.com (2603:10b6:300:4b::30)
 by DM6PR12MB3049.namprd12.prod.outlook.com (2603:10b6:5:11d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17; Thu, 12 Aug
 2021 09:33:42 +0000
Received: from CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:4b:cafe::a7) by MWHPR02CA0020.outlook.office365.com
 (2603:10b6:300:4b::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16 via Frontend
 Transport; Thu, 12 Aug 2021 09:33:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT010.mail.protection.outlook.com (10.13.175.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4415.14 via Frontend Transport; Thu, 12 Aug 2021 09:33:41 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 12 Aug
 2021 04:33:38 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <nils.wallmenius@gmail.com>, <Lijo.Lazar@amd.com>, <Guchun.Chen@amd.com>, 
 Evan Quan <evan.quan@amd.com>
Subject: [PATCH V3 7/7] drm/amd/pm: correct the address of Arcturus fan
 related registers
Date: Thu, 12 Aug 2021 17:33:08 +0800
Message-ID: <20210812093308.1322342-7-evan.quan@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 40a90d70-fae1-428a-f2c3-08d95d7445db
X-MS-TrafficTypeDiagnostic: DM6PR12MB3049:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3049AB103CBBEF07E9215818E4F99@DM6PR12MB3049.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iFO4CsUox0W8wy/VVwhYyojVrOK4J5rfBq5YwcgH25bSN9zdD11CnB03nOU78ICE6QNjQKQXOjoIeKlfyeJzgkZI1837IxuXEkFk0Az2TPSP2GJaK7Py9YeTbT+bKLwkn9f7I8rFxBM8JviVHTW1iSR1yKlcv52WcwrMIVOTfB8zx40xVmU4Gk3pesrDb5fPJnAa83GSymBMn3gzHBAavAX2VPKvXFACKOXMBUKok3lAnd0cM1RTfo+Up4qBNBHYiUnZuTLcTY0YYC0vBCc9D2yobJL7o3UN1gAngufs012VV2vWnkKjlExeCIvtECSlBUPN5Z0v13dqSjse90QuJyxPrqYXZy7E/KLxaqarDkb21CkEWtKaAOPQqFslztXc0fZhjFMiAhgZjdjZZzivNvWS3fNjLGEFOjjZjYJ4ZXpaAhCGcWrMSJG2a/RgumGT9H7Q00jYm+G66O/jdvvabGs5fUzT+kFt7msMb7oPE/p3G/ShjaODZFoyf9XQi4k6I6SW7exuqG6hKkmVrQ9s+W+3hhBhX/ZHJNHTWisZHobwpHmnJ8AWEXBeEHqxHYKWsjfcAIsxUVvlJOUIjaCdaT7fqsY2VH8BGY626n+6CIbPEuPVIKqBebmMQjGn6xD0ke1QLAa1Mvy24BhUMydfaJ94DJVRTdH7q+xioZGkqZBRamI8dop8AQUdbJWS/VdvG1BcQEwP7lfCbyYBS4vTGk24L6BcUSMyuTtx0yF0BpFyEQdD5I8wEDLFxgAF5SqOa9LebvUL+MW4vTj16zaaRQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(136003)(396003)(346002)(36840700001)(46966006)(7696005)(70586007)(44832011)(6666004)(47076005)(70206006)(316002)(6916009)(54906003)(2906002)(36756003)(8676002)(86362001)(336012)(8936002)(83380400001)(26005)(81166007)(82740400003)(356005)(186003)(16526019)(478600001)(5660300002)(1076003)(4326008)(82310400003)(2616005)(34020700004)(426003)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2021 09:33:41.7718 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40a90d70-fae1-428a-f2c3-08d95d7445db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3049
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

