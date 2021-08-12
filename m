Return-Path: <SRS0=1H3f=ND=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 384B4C432BE
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Aug 2021 04:01:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEFB36101E
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Aug 2021 04:01:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EEFB36101E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AE776E243;
	Thu, 12 Aug 2021 04:01:50 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C43716E23D
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Aug 2021 04:01:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NyfrpmBItMQo4Ce1ddvZxbIJa4xuqIiz5jf8btgNgHBap5IQCeeAtsIQm7vlIuF5qutmE7Th30pZlA1qFY3r2nUK/r23YKN3HqrubbhK6hsEFrB1f/Vfw4b1YH6SkU5L62Ki0MmtaniRLccfBA3zZqjYqevCKa6Tt21btbG1JSSQO/nix4JGVrJLn0Ny242pkARTZ4yDT5OkcmJZ2ztcbiM0a7Xq3FrpWchIExyDmZ5jVqVmLuDBd71NPhJgn1ld3gg9jx3wQKPFCovgs48NJS115HU1Mv2hXJezJdux7bGumuwPQC/xhzhKJJKoRQwuoTP/U89W06NqU3jG86b4Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xh/ty70TEIwhkvkzFSA0axpTYkfAGkBjNmPoKmXA3Qo=;
 b=IAbDbQLgxbI40Vz0PoF1Ngad+XGoAo941xdX9dCUJKsiA8A9P44QHiYqACv2xQyc5GbhxNrchuxA612lmldMsu2CTSQQsP+566E/VBXlbLNPWQcEVNe2ukYuEKmViw26GRxSNukC2gXzTPCxBbbT5AekpP6BPcuoRiILsMvBqbjJJ3FBTlFo4UFTRU5JJEZZYQkUzwYSOPsduvtml5B5HlZ9okykBbeRnbMa6Tf0Kc8iVZi/PVndIVHp72G5Dgo029SBB5TlZb7n9lgQAN0nO0+a88183VQ/cTGzbZoQ3Ti9IurHRzcVcgtQh4E2BvNhgzXZulNHOXBkEC85WrO+Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xh/ty70TEIwhkvkzFSA0axpTYkfAGkBjNmPoKmXA3Qo=;
 b=wJudQq+odoOYrS7wBWQDS+Y1V7xMH3DTz65EcQfV+XQzZj1uI3w3qSwOnBGcI6VAjm89rYqKczlhPAT4fprM1jn/qKwgZljE7khI8bj68CegCSELt2NvuGs2ocZL0DjA/FaKF+K4Lct5suBrppR7WcPND9zos5BeITKINFzof+g=
Received: from BN7PR02CA0013.namprd02.prod.outlook.com (2603:10b6:408:20::26)
 by DM6PR12MB4811.namprd12.prod.outlook.com (2603:10b6:5:1fb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17; Thu, 12 Aug
 2021 04:01:44 +0000
Received: from BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:20:cafe::ec) by BN7PR02CA0013.outlook.office365.com
 (2603:10b6:408:20::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15 via Frontend
 Transport; Thu, 12 Aug 2021 04:01:44 +0000
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
 15.20.4415.14 via Frontend Transport; Thu, 12 Aug 2021 04:01:43 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Wed, 11 Aug
 2021 23:01:39 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <nils.wallmenius@gmail.com>, <Lijo.Lazar@amd.com>, <Guchun.Chen@amd.com>, 
 Evan Quan <evan.quan@amd.com>
Subject: [PATCH V2 4/7] drm/amd/pm: correct the fan speed RPM retrieving
Date: Thu, 12 Aug 2021 12:01:07 +0800
Message-ID: <20210812040110.1293682-4-evan.quan@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8b9ac6e1-8d5c-4b55-f49e-08d95d45e5bf
X-MS-TrafficTypeDiagnostic: DM6PR12MB4811:
X-Microsoft-Antispam-PRVS: <DM6PR12MB48114A87745A6E801D455EFBE4F99@DM6PR12MB4811.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T84q9L0EHHNxzOBC0+2waYHGdUdI0xX2DnvIK/I6U1RuG21201qhqzwPLMu4gb4qhnmzRoNlqkXql/M55wszEe+B7JGaT9gtqU/kDKuD0hzT4nus1HAoyytWVSlEkqnAWNQcdk5KklMbXwKLf3HzCTmbDoLcVV7rQWl9LaP9GuQVJ1ExuOZhAPGNbTfd8brstfKHuiM0BLBsJjIgT5TO9y3ffM9YO4oOBZaJtan0vUoht6m+KUB+nYpiPZbDIiL5+UI9hG3VA4T9KRzMbDBec2zVMVCvoaTzzMIwynDbynkkeA57ZHeK06COCp5UR2gjCyR4Q25jx45zBhZQ7c1xcK7693LgLTdqCoX4/yOPAczqWipHDo+ggNmrNUu300ctYgDeLzKJkkfoe6y7wfggO81VOOmXC65fOn08x/aidYb2cldaO325Zx9SLNQC5uZRVEGkLyIdgxuOxJpksV2yyXEd2NxKLGupnUajFVKlqw/joTgljcqRkPZIHqOE0RuOC4N3787J2SHppTR6hLVbaPcuYPe4ROkGTbx5yXTfhpr7S392Gi/Yhoch8Gr7/dEIU2GNu97qPRI7WqI0OmXnYSjDpR77rjOpAFQH/yLMuk0lSZ4Uh58Pb55PMs/gpxeT+td5kzeh2cRxn4mSqC4anDYlPnYEFzXphtH5Wp2aQiq+j72a+MY0JO0EPGR72veXvQ4AcPm2ZPxdk/1AB3rLzqb3qqDWaJ5DAj3y6UrAU9WNdaKVQTnT/dZuUIKGPbQ/ZnQyKc51qU0XSa9Hj9+Mfg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(376002)(136003)(396003)(46966006)(36840700001)(86362001)(47076005)(8676002)(44832011)(36756003)(36860700001)(6916009)(336012)(426003)(2616005)(70206006)(6666004)(4326008)(7696005)(1076003)(478600001)(316002)(70586007)(186003)(26005)(356005)(82740400003)(8936002)(81166007)(16526019)(2906002)(82310400003)(34020700004)(5660300002)(54906003)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2021 04:01:43.7885 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b9ac6e1-8d5c-4b55-f49e-08d95d45e5bf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4811
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
retrieving the fan speed RPM.

Change-Id: Ife4298c8b7ec93ef023a7da27d59654e0444e044
Signed-off-by: Evan Quan <evan.quan@amd.com>
--
v1->v2
  - drop unneeded intermediate varaible (Guchun)
  - hardcode crystal_clock_freq as 25Mhz (Lijo)
---
 .../include/asic_reg/thm/thm_11_0_2_offset.h  |  3 ++
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h       |  5 ++++
 drivers/gpu/drm/amd/pm/inc/smu_v11_0.h        |  3 ++
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  7 ++---
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 24 ++++++++++++++++
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 24 ++++++++++++++++
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 17 +++++++++++
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    | 28 +++++++++++++++++++
 8 files changed, 106 insertions(+), 5 deletions(-)

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
index 29934a5af44e..c0ac6754f448 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -729,6 +729,11 @@ struct pptable_funcs {
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
index ff31be2eaff9..bc8d875b526d 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
@@ -230,6 +230,9 @@ int smu_v11_0_set_fan_speed_rpm(struct smu_context *smu,
 int smu_v11_0_get_fan_speed_percent(struct smu_context *smu,
 				    uint32_t *speed);
 
+int smu_v11_0_get_fan_speed_rpm(struct smu_context *smu,
+				uint32_t *speed);
+
 int smu_v11_0_set_xgmi_pstate(struct smu_context *smu,
 				     uint32_t pstate);
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 131ad0dfefbe..979ba6487577 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2627,17 +2627,14 @@ static int smu_get_fan_speed_rpm(void *handle, uint32_t *speed)
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
index 74cd957f37da..60ce8a813f19 100644
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
@@ -2248,6 +2271,7 @@ static const struct pptable_funcs arcturus_ppt_funcs = {
 	.force_clk_levels = arcturus_force_clk_levels,
 	.read_sensor = arcturus_read_sensor,
 	.get_fan_speed_percent = smu_v11_0_get_fan_speed_percent,
+	.get_fan_speed_rpm = arcturus_get_fan_speed_rpm,
 	.get_power_profile_mode = arcturus_get_power_profile_mode,
 	.set_power_profile_mode = arcturus_set_power_profile_mode,
 	.set_performance_level = arcturus_set_performance_level,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index c0bd52c307cf..3cb90fe107c5 100644
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
@@ -3202,6 +3225,7 @@ static const struct pptable_funcs navi10_ppt_funcs = {
 	.notify_smc_display_config = navi10_notify_smc_display_config,
 	.is_dpm_running = navi10_is_dpm_running,
 	.get_fan_speed_percent = smu_v11_0_get_fan_speed_percent,
+	.get_fan_speed_rpm = navi10_get_fan_speed_rpm,
 	.get_power_profile_mode = navi10_get_power_profile_mode,
 	.set_power_profile_mode = navi10_set_power_profile_mode,
 	.set_watermarks_table = navi10_set_watermarks_table,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 0b9be89276ab..513373dcaaca 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -1354,6 +1354,22 @@ static bool sienna_cichlid_is_dpm_running(struct smu_context *smu)
 	return !!(feature_enabled & SMC_DPM_FEATURE);
 }
 
+static int sienna_cichlid_get_fan_speed_rpm(struct smu_context *smu,
+					    uint32_t *speed)
+{
+	if (!speed)
+		return -EINVAL;
+
+	/*
+	 * For Sienna_Cichlid and later, the fan speed(rpm) reported
+	 * by pmfw is always trustable(even when the fan control feature
+	 * disabled or 0 RPM kicked in).
+	 */
+	return sienna_cichlid_get_smu_metrics_data(smu,
+						   METRICS_CURR_FANSPEED,
+						   speed);
+}
+
 static int sienna_cichlid_get_fan_parameters(struct smu_context *smu)
 {
 	uint16_t *table_member;
@@ -3837,6 +3853,7 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 	.notify_smc_display_config = sienna_cichlid_notify_smc_display_config,
 	.is_dpm_running = sienna_cichlid_is_dpm_running,
 	.get_fan_speed_percent = smu_v11_0_get_fan_speed_percent,
+	.get_fan_speed_rpm = sienna_cichlid_get_fan_speed_rpm,
 	.get_power_profile_mode = sienna_cichlid_get_power_profile_mode,
 	.set_power_profile_mode = sienna_cichlid_set_power_profile_mode,
 	.set_watermarks_table = sienna_cichlid_set_watermarks_table,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 1f3230f232b7..19334bb6a8b0 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -1298,6 +1298,34 @@ int smu_v11_0_get_fan_speed_percent(struct smu_context *smu,
 	return 0;
 }
 
+int smu_v11_0_get_fan_speed_rpm(struct smu_context *smu,
+				uint32_t *speed)
+{
+	struct amdgpu_device *adev = smu->adev;
+	uint32_t crystal_clock_freq = 2500;
+	uint32_t tach_status;
+	uint64_t tmp64;
+
+	/*
+	 * For pre Sienna Cichlid ASICs, the 0 RPM may be not correctly
+	 * detected via register retrieving. To workaround this, we will
+	 * report the fan speed as 0 RPM if user just requested such.
+	 */
+	if ((smu->user_dpm_profile.flags & SMU_CUSTOM_FAN_SPEED_RPM)
+	     && !smu->user_dpm_profile.fan_speed_rpm) {
+		*speed = 0;
+		return 0;
+	}
+
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

