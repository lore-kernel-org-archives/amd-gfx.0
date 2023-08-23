Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FD69EE49AB
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Aug 2023 06:35:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFF4D10E350;
	Wed, 23 Aug 2023 06:35:55 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2047.outbound.protection.outlook.com [40.107.101.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 849EF10E34F
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Aug 2023 06:35:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lsyFw+0gM/CMraxyQHO6idKrNzDwM/1RuehDRY/K9hyAOZgSKMLyGc/pOr+wo8nl8UMjJirG7gsV4yB3lw/uYR6Irr9Uqot0Wuu1oDnlpAMk86glDbuu8Q6k8eFP6gRYWhe8yyYd/PYKbmcxfSXwVJA1kht68lzoJNXxjbvsDXShruaDvCOH6dCJtftl4Q6KEVG/Kpw76DTnvKGAfeAOlNeQB8IZp+ZFTbBN1VI2dyCasJEhWIQcGpDhBxqNEL3i15Va+QEcYTEIcuNjTTw9zpfjrP1N7YylWseJEqOsEdNmKbNCIfJg0NaLURV4tyAAmi+NGoxLd0mlXF3/AJq1Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sCrbNhf85en8e3uP8Wo9oeNGEE+fvAaVmbMYxzOnS1g=;
 b=hODSDKHixTutdLInSBadhgrOFR6Ik7C7+SFrxlIMWYC62G7JWIPNWAVFoFqoLt2rMnFRCE4Wj26MYi4vlrYpF74TapYkysnuNT7tmCNShoBC2cVWDjk6PVYHoAog8n4AAKOe8M2OWZtXsImV+0kHop/wffF7YLOY+6FOFYYecG3ziOtl1R3y74iwhBWgW7e/vI0RGo0cDHT/CcdXnOJFXS1DK5Le1XVsHp8JbTkkPEHJaeE0JHP5VCBQ1i34GwSMX+c1elvafMdS2ImCD2WiKF+lvrw2LZBQC9m602GJofxMCEY8tR1X42NHUd3rRSFgqrhVTEShL+RJ9vdIpTOgxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sCrbNhf85en8e3uP8Wo9oeNGEE+fvAaVmbMYxzOnS1g=;
 b=1Cq+Kqv+yF0V2+9fTP5ZwQM4R2NHAuY8RJRhXcRYGy4a21c178TJ9nnAakir1UJUFS7B6jFmrD2v2BaX3yeBQzrJStdCD/56NTp0bQFJ2BAqMSM+pwkouYohEvRhl7lqWNkgpafWAwD6+H5Gjx1cT+fIygJDL2F4daeptyLtgBU=
Received: from CYXPR02CA0033.namprd02.prod.outlook.com (2603:10b6:930:cc::8)
 by LV2PR12MB5845.namprd12.prod.outlook.com (2603:10b6:408:176::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 23 Aug
 2023 06:35:49 +0000
Received: from CY4PEPF0000E9D0.namprd03.prod.outlook.com
 (2603:10b6:930:cc:cafe::2a) by CYXPR02CA0033.outlook.office365.com
 (2603:10b6:930:cc::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26 via Frontend
 Transport; Wed, 23 Aug 2023 06:35:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D0.mail.protection.outlook.com (10.167.241.143) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Wed, 23 Aug 2023 06:35:49 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 23 Aug
 2023 01:35:46 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [V2 8/8] drm/amd/pm: add fan minimum pwm OD setting support for SMU13
Date: Wed, 23 Aug 2023 14:34:06 +0800
Message-ID: <20230823063406.1195151-8-evan.quan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823063406.1195151-1-evan.quan@amd.com>
References: <20230823063406.1195151-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D0:EE_|LV2PR12MB5845:EE_
X-MS-Office365-Filtering-Correlation-Id: 61e4f33b-3921-451c-c87d-08dba3a3309c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5g36C3Zp2iOeeEjhSozb9Z+q6Hh4bqK7mI8roLi/s8B+swfTI+7W1Zexe12xNo85Ef2AhmmnhTigOK90yTnsae4x5FsGMHo2P/pJyUBmLRixVA7C9n+6abNqXS6xh49Fw/Eag47Lt60JgYjTxy/JIflTtQgTcO+B3HSOnzIMZTdVt86j6FXAW39NrKvtlPon6ySnKMJhLyudZCh+CckH+tYaLrGYIYDP9+o2HnIO3mkDILLW6PIiOuP6Svu7nAzHiXAoaUbLwrM019CqmFZBs4JdxEBNJEB6iSzDFuhYuuzh2gkXpqo4E9IIHDsN41KhxAFbrM2Dj9ML382k4JKfXO0E0+IwB6KWw0DYzh6SzQ8I2WfOB2Xyovr4o0Lf4smjNj8iDAKX7IcGVuo9w+sv5ll34WxZ7kVQa9N/tuumHQBND2ejeP7X7n2sElLrR9g6KfqKQZT52bkhMo21q+bU1/TTCPvVxRVE2zv0YMlxoHxvcBMrA8S8VIOJXDJeDLyY7BI6w5LnYPegD0DxGZMRAeUS9PtVVnox0VzvjZJ0JHql9TmVq0J5aEbBlaTdMGnHyWL4JFqUiqXwWZBqXztgbYgEYJQY0bXJgfONPYYixOcoFnUgx708I3t/9W8+bvvxinROGPvjnCSQ1BQ4TSrXAiHvG4nrfak5O7v41l6LUPF9Y0SPmkOSbswN+UEUBlAqIEFz3hwXOWZMk8Lxmuob3VhGDHugnbeoIOcgbShj6CxYO2f5/aFBImRQaaBZQ6WZnYc6nkwhwC+7scHZGdy5wg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(346002)(39860400002)(376002)(186009)(82310400011)(451199024)(1800799009)(46966006)(36840700001)(40470700004)(40460700003)(2906002)(83380400001)(30864003)(26005)(86362001)(478600001)(40480700001)(426003)(36756003)(6666004)(7696005)(2616005)(1076003)(16526019)(336012)(5660300002)(44832011)(41300700001)(36860700001)(82740400003)(70586007)(356005)(54906003)(70206006)(316002)(6916009)(81166007)(8936002)(4326008)(8676002)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 06:35:49.2541 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61e4f33b-3921-451c-c87d-08dba3a3309c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5845
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add SMU13 fan minimum pwm OD setting support.

Signed-off-by: Evan Quan <evan.quan@amd.com>
--
v1->v2:
  - add missing kerneldoc for the new interface(Alex)
---
 Documentation/gpu/amdgpu/thermal.rst          |  6 ++
 .../gpu/drm/amd/include/kgd_pp_interface.h    |  2 +
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            | 59 +++++++++++++++++++
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  2 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  2 +
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |  1 +
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 51 +++++++++++++++-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 51 +++++++++++++++-
 8 files changed, 172 insertions(+), 2 deletions(-)

diff --git a/Documentation/gpu/amdgpu/thermal.rst b/Documentation/gpu/amdgpu/thermal.rst
index 073ab9e418b1..940f723472b8 100644
--- a/Documentation/gpu/amdgpu/thermal.rst
+++ b/Documentation/gpu/amdgpu/thermal.rst
@@ -94,6 +94,12 @@ fan_target_temperature
 .. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
    :doc: fan_target_temperature
 
+fan_minimum_pwm
+---------------
+
+.. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
+   :doc: fan_minimum_pwm
+
 GFXOFF
 ======
 
diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index c1065136f527..528c892f7c4b 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -118,6 +118,7 @@ enum pp_clock_type {
 	OD_ACOUSTIC_LIMIT,
 	OD_ACOUSTIC_TARGET,
 	OD_FAN_TARGET_TEMPERATURE,
+	OD_FAN_MINIMUM_PWM,
 };
 
 enum amd_pp_sensors {
@@ -197,6 +198,7 @@ enum PP_OD_DPM_TABLE_COMMAND {
 	PP_OD_EDIT_ACOUSTIC_LIMIT,
 	PP_OD_EDIT_ACOUSTIC_TARGET,
 	PP_OD_EDIT_FAN_TARGET_TEMPERATURE,
+	PP_OD_EDIT_FAN_MINIMUM_PWM,
 };
 
 struct pp_states_info {
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 682eef0c0eeb..fa6c4ab16ccf 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -3772,6 +3772,57 @@ static umode_t fan_target_temperature_visible(struct amdgpu_device *adev)
 	return umode;
 }
 
+/**
+ * DOC: fan_minimum_pwm
+ *
+ * The amdgpu driver provides a sysfs API for checking and adjusting the
+ * minimum fan speed in PWM.
+ *
+ * Reading back the file shows you the current setting and the permitted
+ * ranges if changable.
+ *
+ * Writing an integer to the file, change the setting accordingly.
+ *
+ * When you have finished the editing, write "c" (commit) to the file to commit
+ * your changes. NOTE: this will switch the fan control to auto mode.
+ */
+static ssize_t fan_minimum_pwm_show(struct kobject *kobj,
+				    struct kobj_attribute *attr,
+				    char *buf)
+{
+	struct od_kobj *container = container_of(kobj, struct od_kobj, kobj);
+	struct amdgpu_device *adev = (struct amdgpu_device *)container->priv;
+
+	return (ssize_t)amdgpu_retrieve_od_settings(adev, OD_FAN_MINIMUM_PWM, buf);
+}
+
+static ssize_t fan_minimum_pwm_store(struct kobject *kobj,
+				     struct kobj_attribute *attr,
+				     const char *buf,
+				     size_t count)
+{
+	struct od_kobj *container = container_of(kobj, struct od_kobj, kobj);
+	struct amdgpu_device *adev = (struct amdgpu_device *)container->priv;
+
+	return (ssize_t)amdgpu_distribute_custom_od_settings(adev,
+							     PP_OD_EDIT_FAN_MINIMUM_PWM,
+							     buf,
+							     count);
+}
+
+static umode_t fan_minimum_pwm_visible(struct amdgpu_device *adev)
+{
+	umode_t umode = 0000;
+
+	if (adev->pm.od_feature_mask & OD_OPS_SUPPORT_FAN_MINIMUM_PWM_RETRIEVE)
+		umode |= S_IRUSR | S_IRGRP | S_IROTH;
+
+	if (adev->pm.od_feature_mask & OD_OPS_SUPPORT_FAN_MINIMUM_PWM_SET)
+		umode |= S_IWUSR;
+
+	return umode;
+}
+
 static struct od_feature_set amdgpu_od_set = {
 	.containers = {
 		[0] = {
@@ -3817,6 +3868,14 @@ static struct od_feature_set amdgpu_od_set = {
 						.store = fan_target_temperature_store,
 					},
 				},
+				[5] = {
+					.name = "fan_minimum_pwm",
+					.ops = {
+						.is_visible = fan_minimum_pwm_visible,
+						.show = fan_minimum_pwm_show,
+						.store = fan_minimum_pwm_store,
+					},
+				},
 			},
 		},
 	},
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index 80d2ac1ecb9f..342c4d8318dc 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -324,6 +324,8 @@ struct config_table_setting
 #define OD_OPS_SUPPORT_ACOUSTIC_TARGET_THRESHOLD_SET		BIT(7)
 #define OD_OPS_SUPPORT_FAN_TARGET_TEMPERATURE_RETRIEVE	BIT(8)
 #define OD_OPS_SUPPORT_FAN_TARGET_TEMPERATURE_SET	BIT(9)
+#define OD_OPS_SUPPORT_FAN_MINIMUM_PWM_RETRIEVE		BIT(10)
+#define OD_OPS_SUPPORT_FAN_MINIMUM_PWM_SET		BIT(11)
 
 struct amdgpu_pm {
 	struct mutex		mutex;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 22a6527139a6..d22ed5a272ce 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2491,6 +2491,8 @@ static enum smu_clk_type smu_convert_to_smuclk(enum pp_clock_type type)
 		clk_type = SMU_OD_ACOUSTIC_TARGET; break;
 	case OD_FAN_TARGET_TEMPERATURE:
 		clk_type = SMU_OD_FAN_TARGET_TEMPERATURE; break;
+	case OD_FAN_MINIMUM_PWM:
+		clk_type = SMU_OD_FAN_MINIMUM_PWM; break;
 	default:
 		clk_type = SMU_CLK_COUNT; break;
 	}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
index 1a00f807fb09..5c8f30f600f8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
@@ -285,6 +285,7 @@ enum smu_clk_type {
 	SMU_OD_ACOUSTIC_LIMIT,
 	SMU_OD_ACOUSTIC_TARGET,
 	SMU_OD_FAN_TARGET_TEMPERATURE,
+	SMU_OD_FAN_MINIMUM_PWM,
 	SMU_CLK_COUNT,
 };
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 953620f95abc..bedd9ca3605c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -107,6 +107,7 @@
 #define PP_OD_FEATURE_FAN_ACOUSTIC_LIMIT		8
 #define PP_OD_FEATURE_FAN_ACOUSTIC_TARGET		9
 #define PP_OD_FEATURE_FAN_TARGET_TEMPERATURE		10
+#define PP_OD_FEATURE_FAN_MINIMUM_PWM			11
 
 #define LINK_SPEED_MAX					3
 
@@ -1140,6 +1141,10 @@ static void smu_v13_0_0_get_od_setting_limits(struct smu_context *smu,
 		od_min_setting = overdrive_lowerlimits->FanTargetTemperature;
 		od_max_setting = overdrive_upperlimits->FanTargetTemperature;
 		break;
+	case PP_OD_FEATURE_FAN_MINIMUM_PWM:
+		od_min_setting = overdrive_lowerlimits->FanMinimumPwm;
+		od_max_setting = overdrive_upperlimits->FanMinimumPwm;
+		break;
 	default:
 		od_min_setting = od_max_setting = INT_MAX;
 		break;
@@ -1452,6 +1457,24 @@ static int smu_v13_0_0_print_clk_levels(struct smu_context *smu,
 				      min_value, max_value);
 		break;
 
+	case SMU_OD_FAN_MINIMUM_PWM:
+		if (!smu_v13_0_0_is_od_feature_supported(smu,
+							 PP_OD_FEATURE_FAN_CURVE_BIT))
+			break;
+
+		size += sysfs_emit_at(buf, size, "FAN_MINIMUM_PWM:\n");
+		size += sysfs_emit_at(buf, size, "%d\n",
+					(int)od_table->OverDriveTable.FanMinimumPwm);
+
+		size += sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
+		smu_v13_0_0_get_od_setting_limits(smu,
+						  PP_OD_FEATURE_FAN_MINIMUM_PWM,
+						  &min_value,
+						  &max_value);
+		size += sysfs_emit_at(buf, size, "MINIMUM_PWM: %u %u\n",
+				      min_value, max_value);
+		break;
+
 	case SMU_OD_RANGE:
 		if (!smu_v13_0_0_is_od_feature_supported(smu, PP_OD_FEATURE_GFXCLK_BIT) &&
 		    !smu_v13_0_0_is_od_feature_supported(smu, PP_OD_FEATURE_UCLK_BIT) &&
@@ -1766,6 +1789,28 @@ static int smu_v13_0_0_od_edit_dpm_table(struct smu_context *smu,
 		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_FAN_CURVE_BIT);
 		break;
 
+	case PP_OD_EDIT_FAN_MINIMUM_PWM:
+		if (!smu_v13_0_0_is_od_feature_supported(smu, PP_OD_FEATURE_FAN_CURVE_BIT)) {
+			dev_warn(adev->dev, "Fan curve setting not supported!\n");
+			return -ENOTSUPP;
+		}
+
+		smu_v13_0_0_get_od_setting_limits(smu,
+						  PP_OD_FEATURE_FAN_MINIMUM_PWM,
+						  &minimum,
+						  &maximum);
+		if (input[0] < minimum ||
+		    input[0] > maximum) {
+			dev_info(adev->dev, "fan minimum pwm setting(%ld) must be within [%d, %d]!\n",
+				 input[0], minimum, maximum);
+			return -EINVAL;
+		}
+
+		od_table->OverDriveTable.FanMinimumPwm = input[0];
+		od_table->OverDriveTable.FanMode = FAN_MODE_AUTO;
+		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_FAN_CURVE_BIT);
+		break;
+
 	case PP_OD_RESTORE_DEFAULT_TABLE:
 		feature_ctrlmask = od_table->OverDriveTable.FeatureCtrlMask;
 		memcpy(od_table,
@@ -2030,7 +2075,9 @@ static void smu_v13_0_0_set_supported_od_feature_mask(struct smu_context *smu)
 					    OD_OPS_SUPPORT_ACOUSTIC_TARGET_THRESHOLD_RETRIEVE |
 					    OD_OPS_SUPPORT_ACOUSTIC_TARGET_THRESHOLD_SET |
 					    OD_OPS_SUPPORT_FAN_TARGET_TEMPERATURE_RETRIEVE |
-					    OD_OPS_SUPPORT_FAN_TARGET_TEMPERATURE_SET;
+					    OD_OPS_SUPPORT_FAN_TARGET_TEMPERATURE_SET |
+					    OD_OPS_SUPPORT_FAN_MINIMUM_PWM_RETRIEVE |
+					    OD_OPS_SUPPORT_FAN_MINIMUM_PWM_SET;
 }
 
 static int smu_v13_0_0_set_default_od_settings(struct smu_context *smu)
@@ -2096,6 +2143,8 @@ static int smu_v13_0_0_set_default_od_settings(struct smu_context *smu)
 			user_od_table_bak.OverDriveTable.AcousticTargetRpmThreshold;
 		user_od_table->OverDriveTable.FanTargetTemperature =
 			user_od_table_bak.OverDriveTable.FanTargetTemperature;
+		user_od_table->OverDriveTable.FanMinimumPwm =
+			user_od_table_bak.OverDriveTable.FanMinimumPwm;
 	}
 
 	smu_v13_0_0_set_supported_od_feature_mask(smu);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index a4d48ef5aaa7..c2ca5f228dd5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -83,6 +83,7 @@
 #define PP_OD_FEATURE_FAN_ACOUSTIC_LIMIT		8
 #define PP_OD_FEATURE_FAN_ACOUSTIC_TARGET		9
 #define PP_OD_FEATURE_FAN_TARGET_TEMPERATURE		10
+#define PP_OD_FEATURE_FAN_MINIMUM_PWM			11
 
 #define LINK_SPEED_MAX					3
 
@@ -1126,6 +1127,10 @@ static void smu_v13_0_7_get_od_setting_limits(struct smu_context *smu,
 		od_min_setting = overdrive_lowerlimits->FanTargetTemperature;
 		od_max_setting = overdrive_upperlimits->FanTargetTemperature;
 		break;
+	case PP_OD_FEATURE_FAN_MINIMUM_PWM:
+		od_min_setting = overdrive_lowerlimits->FanMinimumPwm;
+		od_max_setting = overdrive_upperlimits->FanMinimumPwm;
+		break;
 	default:
 		od_min_setting = od_max_setting = INT_MAX;
 		break;
@@ -1438,6 +1443,24 @@ static int smu_v13_0_7_print_clk_levels(struct smu_context *smu,
 				      min_value, max_value);
 		break;
 
+	case SMU_OD_FAN_MINIMUM_PWM:
+		if (!smu_v13_0_7_is_od_feature_supported(smu,
+							 PP_OD_FEATURE_FAN_CURVE_BIT))
+			break;
+
+		size += sysfs_emit_at(buf, size, "FAN_MINIMUM_PWM:\n");
+		size += sysfs_emit_at(buf, size, "%d\n",
+					(int)od_table->OverDriveTable.FanMinimumPwm);
+
+		size += sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
+		smu_v13_0_7_get_od_setting_limits(smu,
+						  PP_OD_FEATURE_FAN_MINIMUM_PWM,
+						  &min_value,
+						  &max_value);
+		size += sysfs_emit_at(buf, size, "MINIMUM_PWM: %u %u\n",
+				      min_value, max_value);
+		break;
+
 	case SMU_OD_RANGE:
 		if (!smu_v13_0_7_is_od_feature_supported(smu, PP_OD_FEATURE_GFXCLK_BIT) &&
 		    !smu_v13_0_7_is_od_feature_supported(smu, PP_OD_FEATURE_UCLK_BIT) &&
@@ -1752,6 +1775,28 @@ static int smu_v13_0_7_od_edit_dpm_table(struct smu_context *smu,
 		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_FAN_CURVE_BIT);
 		break;
 
+	case PP_OD_EDIT_FAN_MINIMUM_PWM:
+		if (!smu_v13_0_7_is_od_feature_supported(smu, PP_OD_FEATURE_FAN_CURVE_BIT)) {
+			dev_warn(adev->dev, "Fan curve setting not supported!\n");
+			return -ENOTSUPP;
+		}
+
+		smu_v13_0_7_get_od_setting_limits(smu,
+						  PP_OD_FEATURE_FAN_MINIMUM_PWM,
+						  &minimum,
+						  &maximum);
+		if (input[0] < minimum ||
+		    input[0] > maximum) {
+			dev_info(adev->dev, "fan minimum pwm setting(%ld) must be within [%d, %d]!\n",
+				 input[0], minimum, maximum);
+			return -EINVAL;
+		}
+
+		od_table->OverDriveTable.FanMinimumPwm = input[0];
+		od_table->OverDriveTable.FanMode = FAN_MODE_AUTO;
+		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_FAN_CURVE_BIT);
+		break;
+
 	case PP_OD_RESTORE_DEFAULT_TABLE:
 		feature_ctrlmask = od_table->OverDriveTable.FeatureCtrlMask;
 		memcpy(od_table,
@@ -2011,7 +2056,9 @@ static void smu_v13_0_7_set_supported_od_feature_mask(struct smu_context *smu)
 					    OD_OPS_SUPPORT_ACOUSTIC_TARGET_THRESHOLD_RETRIEVE |
 					    OD_OPS_SUPPORT_ACOUSTIC_TARGET_THRESHOLD_SET |
 					    OD_OPS_SUPPORT_FAN_TARGET_TEMPERATURE_RETRIEVE |
-					    OD_OPS_SUPPORT_FAN_TARGET_TEMPERATURE_SET;
+					    OD_OPS_SUPPORT_FAN_TARGET_TEMPERATURE_SET |
+					    OD_OPS_SUPPORT_FAN_MINIMUM_PWM_RETRIEVE |
+					    OD_OPS_SUPPORT_FAN_MINIMUM_PWM_SET;
 }
 
 static int smu_v13_0_7_set_default_od_settings(struct smu_context *smu)
@@ -2077,6 +2124,8 @@ static int smu_v13_0_7_set_default_od_settings(struct smu_context *smu)
 			user_od_table_bak.OverDriveTable.AcousticTargetRpmThreshold;
 		user_od_table->OverDriveTable.FanTargetTemperature =
 			user_od_table_bak.OverDriveTable.FanTargetTemperature;
+		user_od_table->OverDriveTable.FanMinimumPwm =
+			user_od_table_bak.OverDriveTable.FanMinimumPwm;
 	}
 
 	smu_v13_0_7_set_supported_od_feature_mask(smu);
-- 
2.34.1

