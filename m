Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B988EE49AE
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Aug 2023 06:36:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2472E10E34F;
	Wed, 23 Aug 2023 06:36:02 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2044.outbound.protection.outlook.com [40.107.95.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A06A10E34F
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Aug 2023 06:35:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UMQ7yjOcmV1KyFbmKTfdtPna9elirvODAaRMP0FYEp4gSCII/Zt7QUnhHx9NSdvCifScboJ56SM2TLtjoEve1bAgpiBAJ207PxaRky9QCxmzK3pbeXvlGBaBU0mMzfPK4g997h8pmJ/5nUPrgKsLA30TJw3HKrxh2LgwcYqNpjo9mnS6t5Q4QcOnYaWL789mEsgn6Z2R1RTBNyTIkA2SOWQHQSnb9z6mjZQLBfrOL2ADzKpMHamDslzUwO5XrHxFbwqNfPn1/QtOcDrTWqwhaAYFPFAj5JpFJNgVLM8BBhqQ2hbY5iwbCwLTylZdka5oQNpCZ6z23H2mUcTHfRO4vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gocmHEwHuIlRoX0FIKEBlh7YA3NM15GQ5IOpYrVMD6o=;
 b=fwW4HTaRW/tJeSj2HfQonLvvmwTPb4SH22siBZNacHPbGiOWCMLk5G8cDf17p+xpH9VO1AOQ6NrMAOhk6S4T06dI4At7IDiBj1EobG7ELEkgmkAyO7rAs8jmopTqRVaW5r+JNwxKTylGg/itgyIjikdGiMeZmaRbts0wN+nOl6H9bCS5LH25UeJIUAXjFmBLY48UcCVkslhS8XIkOOJLS/BXBDBlgY7bn0n7Ht0jostY6sQmER2F540ujDtkmXDvcqjeHFBiTRSxXypX2+O4Vz3JLmPQOoCV2hSOIF9zK05wHF19BXOZY7Rm5jyS5CRQTthvM6NjLOAw1lm/RqEv2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gocmHEwHuIlRoX0FIKEBlh7YA3NM15GQ5IOpYrVMD6o=;
 b=BrezyMT/8OYhPoZXfMQtv+u0FEKYfoiJAPmGkUmBARZkhSknW65LJcCo/hQ9kG6pyMiPQlJWVssUpM74cVPPna3aHqWkRWlB9AGvZLE12tLbLRDM7I/gqkVlKunsSn2XudvO53YC5lH3CNP8o6jppBh0fk1aL3JnX5p6lZtAg6U=
Received: from CYXPR02CA0027.namprd02.prod.outlook.com (2603:10b6:930:cc::17)
 by PH8PR12MB7112.namprd12.prod.outlook.com (2603:10b6:510:22c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Wed, 23 Aug
 2023 06:35:47 +0000
Received: from CY4PEPF0000E9D0.namprd03.prod.outlook.com
 (2603:10b6:930:cc:cafe::9f) by CYXPR02CA0027.outlook.office365.com
 (2603:10b6:930:cc::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26 via Frontend
 Transport; Wed, 23 Aug 2023 06:35:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D0.mail.protection.outlook.com (10.167.241.143) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Wed, 23 Aug 2023 06:35:47 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 23 Aug
 2023 01:35:39 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [V2 7/8] drm/amd/pm: add fan target temperature OD setting support
 for SMU13
Date: Wed, 23 Aug 2023 14:34:05 +0800
Message-ID: <20230823063406.1195151-7-evan.quan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D0:EE_|PH8PR12MB7112:EE_
X-MS-Office365-Filtering-Correlation-Id: d59df245-c081-433a-38bc-08dba3a32f69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kVS3hndtK+htWJdxAgKuCnPmj8QoxUVoVKmiI+zpsNaXv7bzzjxY6ExmtCliLvCUsafZU04HM2oLKJLzbKtRNVUW3dybHtwTiPj2jMiegygAFm+TnTi/MhdMhSq9LSH23d/YhqmCfWrHpB12uW7HnLQP896LSrhmTUYc3mkITcz/g7+WWDjvXrFI/mpJyVgamJ1MylE+FdqEuJ4QAxtlvGcXbmyOVxZF3JVdtwPMwIDyw1dqjrAzs+wyfbR+65NAdZJkT4UkJUh+m5h9mMa50Oded5GwceIWbAoKmWarWS313LilAS2Rk7XTOp65fOGhnK4oMMvo2LJ6ZKIudWnMGP+MKyn2GDjmzcCBVoMOpV/iJOn85UUDpjUXh6cVos8hrn252SW/DRHZfMunhcKchdbI9ToHLe67I7jYNlPAtS/UKtm98zHLb9JRRChNTxM+EI4yJg3jsNyE/VJQ2SGgZSiVQP8+MITJpan/j3NXWyIOTRyD3tdhB8r8l9IFSG+s0C6FVI2LeaRBB5Jyo8tAg0J3d52tV7/bEOaq5y02VYWl3GDg1S2XLacJrnEwNzwxTfylDdOCRXNckyOTsP/1Su23N5farsaaGu4NrkxOvOyUSr5NqcI1enCu1CZUtNsDU4JPPHzexObHqySBOvOoxPV+s5RIGHg00nqseLgThX7NQVhFXLgJSz4nHrgbTan1hWZAhFplMywmFcuQDwQQPmpwhPbUv8nwCPpTD5SGPK66n/7Sw5x7ZNuKA3IcDA1l9cF/e9GTeIli66czSh0pDw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(39860400002)(376002)(346002)(186009)(1800799009)(82310400011)(451199024)(36840700001)(40470700004)(46966006)(54906003)(70586007)(6916009)(70206006)(316002)(8936002)(8676002)(2616005)(4326008)(1076003)(40460700003)(41300700001)(82740400003)(81166007)(356005)(478600001)(36756003)(6666004)(7696005)(40480700001)(30864003)(2906002)(83380400001)(47076005)(86362001)(36860700001)(336012)(426003)(44832011)(5660300002)(16526019)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 06:35:47.2541 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d59df245-c081-433a-38bc-08dba3a32f69
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7112
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

Add SMU13 fan target temperature OD setting support.

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
index 25774032cc16..073ab9e418b1 100644
--- a/Documentation/gpu/amdgpu/thermal.rst
+++ b/Documentation/gpu/amdgpu/thermal.rst
@@ -88,6 +88,12 @@ acoustic_target_rpm_threshold
 .. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
    :doc: acoustic_target_rpm_threshold
 
+fan_target_temperature
+----------------------
+
+.. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
+   :doc: fan_target_temperature
+
 GFXOFF
 ======
 
diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index ca44e5bea2e5..c1065136f527 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -117,6 +117,7 @@ enum pp_clock_type {
 	OD_FAN_CURVE,
 	OD_ACOUSTIC_LIMIT,
 	OD_ACOUSTIC_TARGET,
+	OD_FAN_TARGET_TEMPERATURE,
 };
 
 enum amd_pp_sensors {
@@ -195,6 +196,7 @@ enum PP_OD_DPM_TABLE_COMMAND {
 	PP_OD_EDIT_FAN_CURVE,
 	PP_OD_EDIT_ACOUSTIC_LIMIT,
 	PP_OD_EDIT_ACOUSTIC_TARGET,
+	PP_OD_EDIT_FAN_TARGET_TEMPERATURE,
 };
 
 struct pp_states_info {
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 6f5fea6394af..682eef0c0eeb 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -3721,6 +3721,57 @@ static umode_t acoustic_target_threshold_visible(struct amdgpu_device *adev)
 	return umode;
 }
 
+/**
+ * DOC: fan_target_temperature
+ *
+ * The amdgpu driver provides a sysfs API for checking and adjusting the
+ * target tempeature in Celsius degree for fan control.
+ *
+ * Reading back the file shows you the current setting and the permitted
+ * ranges if changable.
+ *
+ * Writing an integer to the file, change the setting accordingly.
+ *
+ * When you have finished the editing, write "c" (commit) to the file to commit
+ * your changes. NOTE: this will switch the fan control to auto mode.
+ */
+static ssize_t fan_target_temperature_show(struct kobject *kobj,
+					   struct kobj_attribute *attr,
+					   char *buf)
+{
+	struct od_kobj *container = container_of(kobj, struct od_kobj, kobj);
+	struct amdgpu_device *adev = (struct amdgpu_device *)container->priv;
+
+	return (ssize_t)amdgpu_retrieve_od_settings(adev, OD_FAN_TARGET_TEMPERATURE, buf);
+}
+
+static ssize_t fan_target_temperature_store(struct kobject *kobj,
+					    struct kobj_attribute *attr,
+					    const char *buf,
+					    size_t count)
+{
+	struct od_kobj *container = container_of(kobj, struct od_kobj, kobj);
+	struct amdgpu_device *adev = (struct amdgpu_device *)container->priv;
+
+	return (ssize_t)amdgpu_distribute_custom_od_settings(adev,
+							     PP_OD_EDIT_FAN_TARGET_TEMPERATURE,
+							     buf,
+							     count);
+}
+
+static umode_t fan_target_temperature_visible(struct amdgpu_device *adev)
+{
+	umode_t umode = 0000;
+
+	if (adev->pm.od_feature_mask & OD_OPS_SUPPORT_FAN_TARGET_TEMPERATURE_RETRIEVE)
+		umode |= S_IRUSR | S_IRGRP | S_IROTH;
+
+	if (adev->pm.od_feature_mask & OD_OPS_SUPPORT_FAN_TARGET_TEMPERATURE_SET)
+		umode |= S_IWUSR;
+
+	return umode;
+}
+
 static struct od_feature_set amdgpu_od_set = {
 	.containers = {
 		[0] = {
@@ -3758,6 +3809,14 @@ static struct od_feature_set amdgpu_od_set = {
 						.store = acoustic_target_threshold_store,
 					},
 				},
+				[4] = {
+					.name = "fan_target_temperature",
+					.ops = {
+						.is_visible = fan_target_temperature_visible,
+						.show = fan_target_temperature_show,
+						.store = fan_target_temperature_store,
+					},
+				},
 			},
 		},
 	},
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index 6b2bbd13db09..80d2ac1ecb9f 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -322,6 +322,8 @@ struct config_table_setting
 #define OD_OPS_SUPPORT_ACOUSTIC_LIMIT_THRESHOLD_SET		BIT(5)
 #define OD_OPS_SUPPORT_ACOUSTIC_TARGET_THRESHOLD_RETRIEVE	BIT(6)
 #define OD_OPS_SUPPORT_ACOUSTIC_TARGET_THRESHOLD_SET		BIT(7)
+#define OD_OPS_SUPPORT_FAN_TARGET_TEMPERATURE_RETRIEVE	BIT(8)
+#define OD_OPS_SUPPORT_FAN_TARGET_TEMPERATURE_SET	BIT(9)
 
 struct amdgpu_pm {
 	struct mutex		mutex;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 3bfa9b9bb247..22a6527139a6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2489,6 +2489,8 @@ static enum smu_clk_type smu_convert_to_smuclk(enum pp_clock_type type)
 		clk_type = SMU_OD_ACOUSTIC_LIMIT; break;
 	case OD_ACOUSTIC_TARGET:
 		clk_type = SMU_OD_ACOUSTIC_TARGET; break;
+	case OD_FAN_TARGET_TEMPERATURE:
+		clk_type = SMU_OD_FAN_TARGET_TEMPERATURE; break;
 	default:
 		clk_type = SMU_CLK_COUNT; break;
 	}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
index 8049c20c1e66..1a00f807fb09 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
@@ -284,6 +284,7 @@ enum smu_clk_type {
 	SMU_OD_FAN_CURVE,
 	SMU_OD_ACOUSTIC_LIMIT,
 	SMU_OD_ACOUSTIC_TARGET,
+	SMU_OD_FAN_TARGET_TEMPERATURE,
 	SMU_CLK_COUNT,
 };
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index d483c06c2464..953620f95abc 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -106,6 +106,7 @@
 #define PP_OD_FEATURE_FAN_CURVE_PWM			7
 #define PP_OD_FEATURE_FAN_ACOUSTIC_LIMIT		8
 #define PP_OD_FEATURE_FAN_ACOUSTIC_TARGET		9
+#define PP_OD_FEATURE_FAN_TARGET_TEMPERATURE		10
 
 #define LINK_SPEED_MAX					3
 
@@ -1135,6 +1136,10 @@ static void smu_v13_0_0_get_od_setting_limits(struct smu_context *smu,
 		od_min_setting = overdrive_lowerlimits->AcousticTargetRpmThreshold;
 		od_max_setting = overdrive_upperlimits->AcousticTargetRpmThreshold;
 		break;
+	case PP_OD_FEATURE_FAN_TARGET_TEMPERATURE:
+		od_min_setting = overdrive_lowerlimits->FanTargetTemperature;
+		od_max_setting = overdrive_upperlimits->FanTargetTemperature;
+		break;
 	default:
 		od_min_setting = od_max_setting = INT_MAX;
 		break;
@@ -1429,6 +1434,24 @@ static int smu_v13_0_0_print_clk_levels(struct smu_context *smu,
 				      min_value, max_value);
 		break;
 
+	case SMU_OD_FAN_TARGET_TEMPERATURE:
+		if (!smu_v13_0_0_is_od_feature_supported(smu,
+							 PP_OD_FEATURE_FAN_CURVE_BIT))
+			break;
+
+		size += sysfs_emit_at(buf, size, "FAN_TARGET_TEMPERATURE:\n");
+		size += sysfs_emit_at(buf, size, "%d\n",
+					(int)od_table->OverDriveTable.FanTargetTemperature);
+
+		size += sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
+		smu_v13_0_0_get_od_setting_limits(smu,
+						  PP_OD_FEATURE_FAN_TARGET_TEMPERATURE,
+						  &min_value,
+						  &max_value);
+		size += sysfs_emit_at(buf, size, "TARGET_TEMPERATURE: %u %u\n",
+				      min_value, max_value);
+		break;
+
 	case SMU_OD_RANGE:
 		if (!smu_v13_0_0_is_od_feature_supported(smu, PP_OD_FEATURE_GFXCLK_BIT) &&
 		    !smu_v13_0_0_is_od_feature_supported(smu, PP_OD_FEATURE_UCLK_BIT) &&
@@ -1721,6 +1744,28 @@ static int smu_v13_0_0_od_edit_dpm_table(struct smu_context *smu,
 		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_FAN_CURVE_BIT);
 		break;
 
+	case PP_OD_EDIT_FAN_TARGET_TEMPERATURE:
+		if (!smu_v13_0_0_is_od_feature_supported(smu, PP_OD_FEATURE_FAN_CURVE_BIT)) {
+			dev_warn(adev->dev, "Fan curve setting not supported!\n");
+			return -ENOTSUPP;
+		}
+
+		smu_v13_0_0_get_od_setting_limits(smu,
+						  PP_OD_FEATURE_FAN_TARGET_TEMPERATURE,
+						  &minimum,
+						  &maximum);
+		if (input[0] < minimum ||
+		    input[0] > maximum) {
+			dev_info(adev->dev, "fan target temperature setting(%ld) must be within [%d, %d]!\n",
+				 input[0], minimum, maximum);
+			return -EINVAL;
+		}
+
+		od_table->OverDriveTable.FanTargetTemperature = input[0];
+		od_table->OverDriveTable.FanMode = FAN_MODE_AUTO;
+		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_FAN_CURVE_BIT);
+		break;
+
 	case PP_OD_RESTORE_DEFAULT_TABLE:
 		feature_ctrlmask = od_table->OverDriveTable.FeatureCtrlMask;
 		memcpy(od_table,
@@ -1983,7 +2028,9 @@ static void smu_v13_0_0_set_supported_od_feature_mask(struct smu_context *smu)
 					    OD_OPS_SUPPORT_ACOUSTIC_LIMIT_THRESHOLD_RETRIEVE |
 					    OD_OPS_SUPPORT_ACOUSTIC_LIMIT_THRESHOLD_SET |
 					    OD_OPS_SUPPORT_ACOUSTIC_TARGET_THRESHOLD_RETRIEVE |
-					    OD_OPS_SUPPORT_ACOUSTIC_TARGET_THRESHOLD_SET;
+					    OD_OPS_SUPPORT_ACOUSTIC_TARGET_THRESHOLD_SET |
+					    OD_OPS_SUPPORT_FAN_TARGET_TEMPERATURE_RETRIEVE |
+					    OD_OPS_SUPPORT_FAN_TARGET_TEMPERATURE_SET;
 }
 
 static int smu_v13_0_0_set_default_od_settings(struct smu_context *smu)
@@ -2047,6 +2094,8 @@ static int smu_v13_0_0_set_default_od_settings(struct smu_context *smu)
 			user_od_table_bak.OverDriveTable.AcousticLimitRpmThreshold;
 		user_od_table->OverDriveTable.AcousticTargetRpmThreshold =
 			user_od_table_bak.OverDriveTable.AcousticTargetRpmThreshold;
+		user_od_table->OverDriveTable.FanTargetTemperature =
+			user_od_table_bak.OverDriveTable.FanTargetTemperature;
 	}
 
 	smu_v13_0_0_set_supported_od_feature_mask(smu);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 61caa5d54e57..a4d48ef5aaa7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -82,6 +82,7 @@
 #define PP_OD_FEATURE_FAN_CURVE_PWM			7
 #define PP_OD_FEATURE_FAN_ACOUSTIC_LIMIT		8
 #define PP_OD_FEATURE_FAN_ACOUSTIC_TARGET		9
+#define PP_OD_FEATURE_FAN_TARGET_TEMPERATURE		10
 
 #define LINK_SPEED_MAX					3
 
@@ -1121,6 +1122,10 @@ static void smu_v13_0_7_get_od_setting_limits(struct smu_context *smu,
 		od_min_setting = overdrive_lowerlimits->AcousticTargetRpmThreshold;
 		od_max_setting = overdrive_upperlimits->AcousticTargetRpmThreshold;
 		break;
+	case PP_OD_FEATURE_FAN_TARGET_TEMPERATURE:
+		od_min_setting = overdrive_lowerlimits->FanTargetTemperature;
+		od_max_setting = overdrive_upperlimits->FanTargetTemperature;
+		break;
 	default:
 		od_min_setting = od_max_setting = INT_MAX;
 		break;
@@ -1415,6 +1420,24 @@ static int smu_v13_0_7_print_clk_levels(struct smu_context *smu,
 				      min_value, max_value);
 		break;
 
+	case SMU_OD_FAN_TARGET_TEMPERATURE:
+		if (!smu_v13_0_7_is_od_feature_supported(smu,
+							 PP_OD_FEATURE_FAN_CURVE_BIT))
+			break;
+
+		size += sysfs_emit_at(buf, size, "FAN_TARGET_TEMPERATURE:\n");
+		size += sysfs_emit_at(buf, size, "%d\n",
+					(int)od_table->OverDriveTable.FanTargetTemperature);
+
+		size += sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
+		smu_v13_0_7_get_od_setting_limits(smu,
+						  PP_OD_FEATURE_FAN_TARGET_TEMPERATURE,
+						  &min_value,
+						  &max_value);
+		size += sysfs_emit_at(buf, size, "TARGET_TEMPERATURE: %u %u\n",
+				      min_value, max_value);
+		break;
+
 	case SMU_OD_RANGE:
 		if (!smu_v13_0_7_is_od_feature_supported(smu, PP_OD_FEATURE_GFXCLK_BIT) &&
 		    !smu_v13_0_7_is_od_feature_supported(smu, PP_OD_FEATURE_UCLK_BIT) &&
@@ -1707,6 +1730,28 @@ static int smu_v13_0_7_od_edit_dpm_table(struct smu_context *smu,
 		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_FAN_CURVE_BIT);
 		break;
 
+	case PP_OD_EDIT_FAN_TARGET_TEMPERATURE:
+		if (!smu_v13_0_7_is_od_feature_supported(smu, PP_OD_FEATURE_FAN_CURVE_BIT)) {
+			dev_warn(adev->dev, "Fan curve setting not supported!\n");
+			return -ENOTSUPP;
+		}
+
+		smu_v13_0_7_get_od_setting_limits(smu,
+						  PP_OD_FEATURE_FAN_TARGET_TEMPERATURE,
+						  &minimum,
+						  &maximum);
+		if (input[0] < minimum ||
+		    input[0] > maximum) {
+			dev_info(adev->dev, "fan target temperature setting(%ld) must be within [%d, %d]!\n",
+				 input[0], minimum, maximum);
+			return -EINVAL;
+		}
+
+		od_table->OverDriveTable.FanTargetTemperature = input[0];
+		od_table->OverDriveTable.FanMode = FAN_MODE_AUTO;
+		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_FAN_CURVE_BIT);
+		break;
+
 	case PP_OD_RESTORE_DEFAULT_TABLE:
 		feature_ctrlmask = od_table->OverDriveTable.FeatureCtrlMask;
 		memcpy(od_table,
@@ -1964,7 +2009,9 @@ static void smu_v13_0_7_set_supported_od_feature_mask(struct smu_context *smu)
 					    OD_OPS_SUPPORT_ACOUSTIC_LIMIT_THRESHOLD_RETRIEVE |
 					    OD_OPS_SUPPORT_ACOUSTIC_LIMIT_THRESHOLD_SET |
 					    OD_OPS_SUPPORT_ACOUSTIC_TARGET_THRESHOLD_RETRIEVE |
-					    OD_OPS_SUPPORT_ACOUSTIC_TARGET_THRESHOLD_SET;
+					    OD_OPS_SUPPORT_ACOUSTIC_TARGET_THRESHOLD_SET |
+					    OD_OPS_SUPPORT_FAN_TARGET_TEMPERATURE_RETRIEVE |
+					    OD_OPS_SUPPORT_FAN_TARGET_TEMPERATURE_SET;
 }
 
 static int smu_v13_0_7_set_default_od_settings(struct smu_context *smu)
@@ -2028,6 +2075,8 @@ static int smu_v13_0_7_set_default_od_settings(struct smu_context *smu)
 			user_od_table_bak.OverDriveTable.AcousticLimitRpmThreshold;
 		user_od_table->OverDriveTable.AcousticTargetRpmThreshold =
 			user_od_table_bak.OverDriveTable.AcousticTargetRpmThreshold;
+		user_od_table->OverDriveTable.FanTargetTemperature =
+			user_od_table_bak.OverDriveTable.FanTargetTemperature;
 	}
 
 	smu_v13_0_7_set_supported_od_feature_mask(smu);
-- 
2.34.1

