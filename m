Return-Path: <SRS0=5bFg=L7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A41DEC07E9B
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jul 2021 01:59:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 640C061A3E
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jul 2021 01:59:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 640C061A3E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27BE96E7FA;
	Wed,  7 Jul 2021 01:59:30 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 888666E7FA
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jul 2021 01:59:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gAlhCICQ5AYJa3sJEknZ3ZCjRH2G/ACkiyejYKtndJLaWnQyji8Hi4EOp1qmNeosTWnLXfIDftomHGf+n5qAExP/R6FJMBIj/no367JLwHA3eyucp/GK08fe0o/mekeQp3I6vJfZTrtTVrg0wWxJvT+07EqCMxBV1z5TxbXSS0QWvihyIPwzSAJ6/1ZZqZMZAaxHDzaJUhVRynxu3preW+onPKorUs8ilLO3e2tkmmsaidspf4rJQ5Ohuye0x1LN6mffLAqejweUlfRd/rftzORddRv8umdCzV//O1AhkW594znaIVajyMnLoyHJOEJj/QzP17hZX50IiuaYTGgEKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9VsI/ZLP7FHP1Ulk830IQi51mr2OK7vlUns1SKpED3Q=;
 b=Xb8+qo+w0Zz4wY0Z/XMxbHtnKjKZ5v2SayPJqJT58leZnT2sxIFP4EVSqGr3XwO7ucOvOp8zDPyKvchw3YX2Su68VR0ud4qGem5TPNuAKoxWI9yP8kASN33lEHcD8FGV0u3XmEuQIc9zLWQib2KXrruEcMypiDTrwGM/x5OLimd1Jrc5MrUM2JuVXs8z6hD9s3Za/Be0BuLQzVcvN8tiRgjbCVi8vmNVzTXGASXMir4j4aaALdVksktWx9vFCoIxAKPJJu/bRCTkT0oX5znE1U2vTOhTPWuXKNha9dkvEP+h7rKtQrE0wyM1x2dfL+DIZu+ZVBG4oUwOkQvhxT0Skw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9VsI/ZLP7FHP1Ulk830IQi51mr2OK7vlUns1SKpED3Q=;
 b=Lwg9IMFy9rP4nLAhxuLXD0oUvNt9/GaBxYPYs3IIAd211nd5pX8KQuNBEReHsAomeEork12uAOLPnvKieFnoFglcmtMC3qlchvgzP9q856aq2Do/22Nrww1D2Z7u4c8KG2O/hQ4Zj9vwmFBeBKX0PnhT8eikdZyBpE83+qD/8X8=
Received: from DM6PR03CA0033.namprd03.prod.outlook.com (2603:10b6:5:40::46) by
 MN2PR12MB4030.namprd12.prod.outlook.com (2603:10b6:208:159::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22; Wed, 7 Jul
 2021 01:59:27 +0000
Received: from DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:40:cafe::27) by DM6PR03CA0033.outlook.office365.com
 (2603:10b6:5:40::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend
 Transport; Wed, 7 Jul 2021 01:59:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT022.mail.protection.outlook.com (10.13.172.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4287.22 via Frontend Transport; Wed, 7 Jul 2021 01:59:26 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 6 Jul 2021
 20:59:25 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/7] drm/amd/pm: correct the fan speed RPM retrieving
Date: Wed, 7 Jul 2021 09:56:44 +0800
Message-ID: <20210707015647.139127-4-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210707015647.139127-1-evan.quan@amd.com>
References: <20210707015647.139127-1-evan.quan@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ab3d8807-d522-4de7-eecf-08d940ead9d6
X-MS-TrafficTypeDiagnostic: MN2PR12MB4030:
X-Microsoft-Antispam-PRVS: <MN2PR12MB40303136487BF8755C0ACAFCE41A9@MN2PR12MB4030.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kuf0J9lomZ+CR1/VG3LkRP5dL5+G5OHdhhW0/9LOJCf5FdiDAoTt8eovkHvGUjAy5ZSoM8ikscA+MUrSgM3Ato2rVsXwBY9eS45dmG1P1WalQ+nMR65lH++i8KbTgP/VKdMuPG3Y9KTEbD8IiATVDal/E6MMbuHR2OEktI+tXzEPKd4LpTaQd8a+Jh0sfZEo26bSjPjZjZXy8yIbSCa9xg2Bi9HbrQT9VFMzH14eO//XQajIA5lkbYgGmuuB18nvpyHcLpkM/pbKlMBIwXp02pElPOT1fthOSOcKnyHRe9W/HIgG2MbKhoc0p5Kdv/DMbpKcthv+w8h9Ufj92wPjHfj6K+8+qDFBsgqbRQi06dwxO3pw9t0InED2tZLg/0EsJaEP9L4A3iOqKGqBCRpEfKQ7mi9vX3xzYbuz+Scr4ncoAQRK4e/Ar87rL9/gW9CMR5VNpG2HOLmMQrkbKAdz6aliwNcISnkRQAqtBi31RUY3fiA6egf3POFwqJUK1qnJ3NSrRcGuawdi6fu/DjPAaKbPGgJitk67g6dZUIsnZJCVx9xYHqZmJgo8d9/9NFOP0K70Zhi75yD7LZbiNuegCFY4evsfu0BYumhfhRYD20XwziKYFy2xrpTt91ogueayDhAJRpRSmDXuG7GUj1uZHF0Q2uhRT2qgfBuRY9NEXAopeRncmxssnxg3mEZiM9ZEf4f/xbBwR9lEpPePEtvH2BoEVntMNTDH4eS0uPpTtUo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(136003)(39860400002)(376002)(346002)(36840700001)(46966006)(54906003)(7696005)(186003)(16526019)(36860700001)(316002)(5660300002)(4326008)(26005)(478600001)(2906002)(82310400003)(83380400001)(47076005)(70206006)(36756003)(8676002)(8936002)(336012)(82740400003)(426003)(44832011)(6916009)(6666004)(2616005)(81166007)(1076003)(86362001)(70586007)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 01:59:26.9893 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab3d8807-d522-4de7-eecf-08d940ead9d6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4030
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
retrieving the fan speed RPM.

Change-Id: Ife4298c8b7ec93ef023a7da27d59654e0444e044
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 .../include/asic_reg/thm/thm_11_0_2_offset.h  |  3 ++
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h       |  5 ++++
 drivers/gpu/drm/amd/pm/inc/smu_v11_0.h        |  3 ++
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  7 ++---
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 24 ++++++++++++++++
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 24 ++++++++++++++++
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 21 ++++++++++++++
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    | 28 +++++++++++++++++++
 8 files changed, 110 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/asic_reg/thm/thm_11_0_2_offset.h b/drivers/gpu/drm/amd/include/asic_reg/thm/thm_11_0_2_offset.h
index eca96abef445..8474f419caa5 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/thm/thm_11_0_2_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/thm/thm_11_0_2_offset.h
@@ -38,6 +38,9 @@
 #define mmCG_TACH_CTRL                                                                                 0x006a
 #define mmCG_TACH_CTRL_BASE_IDX                                                                        0
 
+#define mmCG_TACH_STATUS                                                                               0x006b
+#define mmCG_TACH_STATUS_BASE_IDX                                                                      0
+
 #define mmTHM_THERMAL_INT_ENA                                                                          0x000a
 #define mmTHM_THERMAL_INT_ENA_BASE_IDX                                                                 0
 #define mmTHM_THERMAL_INT_CTRL                                                                         0x000b
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index fa585f0be530..db5123fc6042 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -726,6 +726,11 @@ struct pptable_funcs {
 	 */
 	int (*get_fan_speed_percent)(struct smu_context *smu, uint32_t *speed);
 
+	/**
+	 * @get_fan_speed_rpm: Get the current fan speed in rpm.
+	 */
+	int (*get_fan_speed_rpm)(struct smu_context *smu, uint32_t *speed);
+
 	/**
 	 * @set_watermarks_table: Configure and upload the watermarks tables to
 	 *                        the SMU.
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
index 8e0f8e9a1665..05c8fc8fc3f9 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
@@ -229,6 +229,9 @@ int smu_v11_0_set_fan_speed_rpm(struct smu_context *smu,
 int smu_v11_0_get_fan_speed_percent(struct smu_context *smu,
 				    uint32_t *speed);
 
+int smu_v11_0_get_fan_speed_rpm(struct smu_context *smu,
+				uint32_t *speed);
+
 int smu_v11_0_set_xgmi_pstate(struct smu_context *smu,
 				     uint32_t pstate);
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 9a25443988e3..54fb3d7d23ee 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2614,17 +2614,14 @@ static int smu_get_fan_speed_rpm(void *handle, uint32_t *speed)
 {
 	struct smu_context *smu = handle;
 	int ret = 0;
-	u32 percent;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
 	mutex_lock(&smu->mutex);
 
-	if (smu->ppt_funcs->get_fan_speed_percent) {
-		ret = smu->ppt_funcs->get_fan_speed_percent(smu, &percent);
-		*speed = percent * smu->fan_max_rpm / 100;
-	}
+	if (smu->ppt_funcs->get_fan_speed_rpm)
+		ret = smu->ppt_funcs->get_fan_speed_rpm(smu, speed);
 
 	mutex_unlock(&smu->mutex);
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 4a6544b8e05e..e3303c8dcaca 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -1162,6 +1162,29 @@ static int arcturus_read_sensor(struct smu_context *smu,
 	return ret;
 }
 
+static int arcturus_get_fan_speed_rpm(struct smu_context *smu,
+				      uint32_t *speed)
+{
+	int ret = 0;
+
+	if (!speed)
+		return -EINVAL;
+
+	switch (smu_v11_0_get_fan_control_mode(smu)) {
+	case AMD_FAN_CTRL_AUTO:
+		ret = arcturus_get_smu_metrics_data(smu,
+						    METRICS_CURR_FANSPEED,
+						    speed);
+		break;
+	default:
+		ret = smu_v11_0_get_fan_speed_rpm(smu,
+						  speed);
+		break;
+	}
+
+	return ret;
+}
+
 static int arcturus_get_fan_parameters(struct smu_context *smu)
 {
 	PPTable_t *pptable = smu->smu_table.driver_pptable;
@@ -2246,6 +2269,7 @@ static const struct pptable_funcs arcturus_ppt_funcs = {
 	.force_clk_levels = arcturus_force_clk_levels,
 	.read_sensor = arcturus_read_sensor,
 	.get_fan_speed_percent = smu_v11_0_get_fan_speed_percent,
+	.get_fan_speed_rpm = arcturus_get_fan_speed_rpm,
 	.get_power_profile_mode = arcturus_get_power_profile_mode,
 	.set_power_profile_mode = arcturus_set_power_profile_mode,
 	.set_performance_level = arcturus_set_performance_level,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 2ddf35788672..7dce5ea7c1a0 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -1668,6 +1668,29 @@ static bool navi10_is_dpm_running(struct smu_context *smu)
 	return !!(feature_enabled & SMC_DPM_FEATURE);
 }
 
+static int navi10_get_fan_speed_rpm(struct smu_context *smu,
+				    uint32_t *speed)
+{
+	int ret = 0;
+
+	if (!speed)
+		return -EINVAL;
+
+	switch (smu_v11_0_get_fan_control_mode(smu)) {
+	case AMD_FAN_CTRL_AUTO:
+		ret = navi10_get_smu_metrics_data(smu,
+						  METRICS_CURR_FANSPEED,
+						  speed);
+		break;
+	default:
+		ret = smu_v11_0_get_fan_speed_rpm(smu,
+						  speed);
+		break;
+	}
+
+	return ret;
+}
+
 static int navi10_get_fan_parameters(struct smu_context *smu)
 {
 	PPTable_t *pptable = smu->smu_table.driver_pptable;
@@ -3182,6 +3205,7 @@ static const struct pptable_funcs navi10_ppt_funcs = {
 	.notify_smc_display_config = navi10_notify_smc_display_config,
 	.is_dpm_running = navi10_is_dpm_running,
 	.get_fan_speed_percent = smu_v11_0_get_fan_speed_percent,
+	.get_fan_speed_rpm = navi10_get_fan_speed_rpm,
 	.get_power_profile_mode = navi10_get_power_profile_mode,
 	.set_power_profile_mode = navi10_set_power_profile_mode,
 	.set_watermarks_table = navi10_set_watermarks_table,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index e7686ce6744b..2f93dc4b5968 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -1355,6 +1355,26 @@ static bool sienna_cichlid_is_dpm_running(struct smu_context *smu)
 	return !!(feature_enabled & SMC_DPM_FEATURE);
 }
 
+static int sienna_cichlid_get_fan_speed_rpm(struct smu_context *smu,
+					    uint32_t *speed)
+{
+	int ret = 0;
+
+	if (!speed)
+		return -EINVAL;
+
+	/*
+	 * For Sienna_Cichlid and later, the fan speed(rpm) reported
+	 * by pmfw is always trustable(even when the fan control feature
+	 * disabled or 0 RPM kicked in).
+	 */
+	ret = sienna_cichlid_get_smu_metrics_data(smu,
+						  METRICS_CURR_FANSPEED,
+						  speed);
+
+	return ret;
+}
+
 static int sienna_cichlid_get_fan_parameters(struct smu_context *smu)
 {
 	uint16_t *table_member;
@@ -3820,6 +3840,7 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 	.notify_smc_display_config = sienna_cichlid_notify_smc_display_config,
 	.is_dpm_running = sienna_cichlid_is_dpm_running,
 	.get_fan_speed_percent = smu_v11_0_get_fan_speed_percent,
+	.get_fan_speed_rpm = sienna_cichlid_get_fan_speed_rpm,
 	.get_power_profile_mode = sienna_cichlid_get_power_profile_mode,
 	.set_power_profile_mode = sienna_cichlid_set_power_profile_mode,
 	.set_watermarks_table = sienna_cichlid_set_watermarks_table,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index c49683b07076..0cdf55a0dba2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -1284,6 +1284,34 @@ int smu_v11_0_get_fan_speed_percent(struct smu_context *smu,
 	return 0;
 }
 
+int smu_v11_0_get_fan_speed_rpm(struct smu_context *smu,
+				uint32_t *speed)
+{
+	struct amdgpu_device *adev = smu->adev;
+	uint32_t tach_status, crystal_clock_freq;
+	uint64_t tmp64;
+
+	/*
+	 * For pre Sienna Cichlid ASICs, the 0 RPM may be not correctly
+	 * detected via register retrieving. To workaround this, we will
+	 * report the fan speed as 0 RPM if user just requested such.
+	 */
+	if ((smu->user_dpm_profile.custom_fan_speed & SMU_CUSTOM_FAN_SPEED_RPM)
+	     && !smu->user_dpm_profile.fan_speed_rpm) {
+		*speed = 0;
+		return 0;
+	}
+
+	crystal_clock_freq = amdgpu_asic_get_xclk(adev) / 4;
+	tmp64 = (uint64_t)crystal_clock_freq * 60 * 10000;
+
+	tach_status = RREG32_SOC15(THM, 0, mmCG_TACH_STATUS);
+	do_div(tmp64, tach_status);
+	*speed = (uint32_t)tmp64;
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
