Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD3EFC6FA8F
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Aug 2023 05:57:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E05010E4BD;
	Wed, 30 Aug 2023 05:57:55 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF60010E4B9
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Aug 2023 05:57:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ebsp2nN/nkmmXTgl9IIYXn4rjNqbOKkpiS+te1rscN104SLxEcJclnQkO1l+oTRHLQ6v1sEHJ0SfTQxHFD4SifoVIVuu2uQDGPLJ14aPRN1d16MrRWd44g69SeFcPHrfRTRqqzqPjaKXMbBdYcs0V3Vefcrcf+w5q00H/REJmKn8wO02I1aTZzqtzr/BfXna2vWxOuL8oLQ/mYhCwBGdlsARISwv14D6QpxDq5dcfdePibilTVKl9MKlL+7LqHI1AolagUQ+OZOtCQgx4x8J109OdN/gyuoIVgupXR6X6ousjtbmZFI4CRSHOUmjzVJMLk5ELtpI9p1fUcR0im8Heg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HygbdswNghM7kfnIrGvuDdiLJ7uNjS2KsTiirVvWFIM=;
 b=gAaXaJnHKYTMpzbVZ3F2CTZC4EsVYEDwj2qGl3C0ALdQeGecOhuZjJkDA6BRBPke649JY6DlZ02Wxp51Mt8Q9A44gmOFuka2+daTzRJD1717r/cx9mEuw6ZUvYoXy9xIfQaK9o5+NbTGv7jIBqC+kxfst/YUqXhAD5fCoelFyM0mhsSieq1Tk7u2satbZGLfKYpoQ+jKykHUxtvbbUWu96dILYltCz4JavXgApXyVjbQynfgxIMjsJNhV0Ei0q+724WWHWP3HAHH4Nhgu/Z4zjoECis5W8x+0aws3fOTeQKrjNtaAE+kSO+xQoOV1i27h1HJB1tjjvo9/QoV+RxMXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HygbdswNghM7kfnIrGvuDdiLJ7uNjS2KsTiirVvWFIM=;
 b=uwxl/nmB3hMqde+ToEVrYWGT6zugh4RWLMFS7xLysxT+jV61ZHVeIK/yZvwqHoKsukTmrKOdjoyc33bbp1Mc+LE1XU4Pg5m4NMXZ/NZwQnB8w0+WxNeTxeVREipJAhyLX5hTelMTifHp9UBegrnGuro7srJHe4KvXPA3QkEypys=
Received: from MW4PR04CA0272.namprd04.prod.outlook.com (2603:10b6:303:89::7)
 by SA0PR12MB4525.namprd12.prod.outlook.com (2603:10b6:806:92::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.18; Wed, 30 Aug
 2023 05:57:44 +0000
Received: from CO1PEPF000042AA.namprd03.prod.outlook.com
 (2603:10b6:303:89:cafe::1f) by MW4PR04CA0272.outlook.office365.com
 (2603:10b6:303:89::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20 via Frontend
 Transport; Wed, 30 Aug 2023 05:57:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AA.mail.protection.outlook.com (10.167.243.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.16 via Frontend Transport; Wed, 30 Aug 2023 05:57:43 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 30 Aug
 2023 00:57:41 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [V3 7/7] drm/amd/pm: add fan minimum pwm OD setting support for SMU13
Date: Wed, 30 Aug 2023 13:56:48 +0800
Message-ID: <20230830055648.477908-8-evan.quan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230830055648.477908-1-evan.quan@amd.com>
References: <20230830055648.477908-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AA:EE_|SA0PR12MB4525:EE_
X-MS-Office365-Filtering-Correlation-Id: 92ab3b60-b7c2-435b-ccd0-08dba91e075e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IsVO2y/zlHS1pjN7NJWlVwYmB6HJOjnizKer1Eu08M+s+niEnVVeVzzqtmdwtJ44VHqIIdV+s85VnURi67VVnkkejc9V5zxUKFPDYALO92sq6gVclm5FC/ic0W5z2atgb+OEjyic9Es0kBP4QpP5/YnavijGHFbZ0MrP3ZMVZ1jfHjgvxR7F3LoZeLi9MtqQRNy+UE/5MH1X+ISq4/ZtsQpM9xNAoH9uoLS46fPduCEz/T0hmieUXBDKGI5/m0o9rf/DMqa3o6vihdpblN8QtY9DFWLX2mGIRpsuhOr3sumG6+RmLwqOTonxwE3jYzafkFuM0snS4bcust/Pi/OYyRkLYPjG/irZ9bRa4B4JheFblMi77zOeeGNq3tTMdyqtHB67rKIMtbnl5TtC13KOliicrOS0TSzAT4OnVBpvDD2sNF1pzBwkkCVCGuLO0yueMxxUUdxvNeUnMpfRDnKEHIhqU30SGOXddyRQ7KIFrJxsw//7Pm/Lia73lyxzyYyok5ALMtWItAe9uWExoYq4SRAcb4c9BBclGMKYTYRzCS2e8WlJdk3+4v4GgA591AubDcNdAYb6OwQtKBhoDo1YHRGmiUIzXHEeRLNANyxDpqyHC5FZ93NeVK11qv8Dv7CmeBEI7QKOONhrK33Ba9iv1dXrshyNYKkXUzc6fK2hs60FyHO8a4/tkrwyZwtQXNk4Yt81xPIfEdwYgfrKGPYvB1BfeKMEZRxI7s9PhLVBTyQJjH1Z8rKuXAxct+HbRnSaudi9Xr6jJqrxY4h09+u7Sw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(39860400002)(346002)(376002)(396003)(1800799009)(451199024)(186009)(82310400011)(40470700004)(36840700001)(46966006)(4326008)(8676002)(8936002)(2616005)(83380400001)(26005)(16526019)(1076003)(5660300002)(86362001)(336012)(426003)(44832011)(478600001)(41300700001)(36860700001)(40460700003)(47076005)(2906002)(70206006)(6916009)(7696005)(54906003)(70586007)(316002)(40480700001)(30864003)(82740400003)(81166007)(36756003)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 05:57:43.9104 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92ab3b60-b7c2-435b-ccd0-08dba91e075e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4525
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
v2->v3:
  - rich the document for the new interface(Alex)
---
 Documentation/gpu/amdgpu/thermal.rst          |  6 ++
 .../gpu/drm/amd/include/kgd_pp_interface.h    |  2 +
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            | 64 +++++++++++++++++++
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  2 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  2 +
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |  1 +
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 51 ++++++++++++++-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 51 ++++++++++++++-
 8 files changed, 177 insertions(+), 2 deletions(-)

diff --git a/Documentation/gpu/amdgpu/thermal.rst b/Documentation/gpu/amdgpu/thermal.rst
index aa2d15706cda..2f6166f81e6a 100644
--- a/Documentation/gpu/amdgpu/thermal.rst
+++ b/Documentation/gpu/amdgpu/thermal.rst
@@ -88,6 +88,12 @@ fan_target_temperature
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
index 0501d174dbd8..5a889f733462 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -117,6 +117,7 @@ enum pp_clock_type {
 	OD_ACOUSTIC_LIMIT,
 	OD_ACOUSTIC_TARGET,
 	OD_FAN_TARGET_TEMPERATURE,
+	OD_FAN_MINIMUM_PWM,
 };
 
 enum amd_pp_sensors {
@@ -195,6 +196,7 @@ enum PP_OD_DPM_TABLE_COMMAND {
 	PP_OD_EDIT_ACOUSTIC_LIMIT,
 	PP_OD_EDIT_ACOUSTIC_TARGET,
 	PP_OD_EDIT_FAN_TARGET_TEMPERATURE,
+	PP_OD_EDIT_FAN_MINIMUM_PWM,
 };
 
 struct pp_states_info {
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 060a38e30878..84e1af6a6ce7 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -3745,6 +3745,62 @@ static umode_t fan_target_temperature_visible(struct amdgpu_device *adev)
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
+ * your changes.
+ *
+ * This setting works under auto fan control mode only. It can co-exist with
+ * other settings which can work also under auto mode. It adjusts the PMFW's
+ * behavior about the minimum fan speed in PWM the fan should spin. Setting
+ * via this interface will switch the fan control to auto mode implicitly.
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
@@ -3782,6 +3838,14 @@ static struct od_feature_set amdgpu_od_set = {
 						.store = fan_target_temperature_store,
 					},
 				},
+				[4] = {
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
index 486036632ab7..5efdba6e358f 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -322,6 +322,8 @@ struct config_table_setting
 #define OD_OPS_SUPPORT_ACOUSTIC_TARGET_THRESHOLD_SET		BIT(5)
 #define OD_OPS_SUPPORT_FAN_TARGET_TEMPERATURE_RETRIEVE		BIT(6)
 #define OD_OPS_SUPPORT_FAN_TARGET_TEMPERATURE_SET		BIT(7)
+#define OD_OPS_SUPPORT_FAN_MINIMUM_PWM_RETRIEVE		BIT(8)
+#define OD_OPS_SUPPORT_FAN_MINIMUM_PWM_SET		BIT(9)
 
 struct amdgpu_pm {
 	struct mutex		mutex;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 60feffd8b221..206e233826b5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2489,6 +2489,8 @@ static enum smu_clk_type smu_convert_to_smuclk(enum pp_clock_type type)
 		clk_type = SMU_OD_ACOUSTIC_TARGET; break;
 	case OD_FAN_TARGET_TEMPERATURE:
 		clk_type = SMU_OD_FAN_TARGET_TEMPERATURE; break;
+	case OD_FAN_MINIMUM_PWM:
+		clk_type = SMU_OD_FAN_MINIMUM_PWM; break;
 	default:
 		clk_type = SMU_CLK_COUNT; break;
 	}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
index 5a129e7162a9..ebc789e7a289 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
@@ -284,6 +284,7 @@ enum smu_clk_type {
 	SMU_OD_ACOUSTIC_LIMIT,
 	SMU_OD_ACOUSTIC_TARGET,
 	SMU_OD_FAN_TARGET_TEMPERATURE,
+	SMU_OD_FAN_MINIMUM_PWM,
 	SMU_CLK_COUNT,
 };
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 328d377dde79..093962a37688 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -106,6 +106,7 @@
 #define PP_OD_FEATURE_FAN_ACOUSTIC_LIMIT		7
 #define PP_OD_FEATURE_FAN_ACOUSTIC_TARGET		8
 #define PP_OD_FEATURE_FAN_TARGET_TEMPERATURE		9
+#define PP_OD_FEATURE_FAN_MINIMUM_PWM			10
 
 #define LINK_SPEED_MAX					3
 
@@ -1135,6 +1136,10 @@ static void smu_v13_0_0_get_od_setting_limits(struct smu_context *smu,
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
@@ -1437,6 +1442,24 @@ static int smu_v13_0_0_print_clk_levels(struct smu_context *smu,
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
@@ -1751,6 +1774,28 @@ static int smu_v13_0_0_od_edit_dpm_table(struct smu_context *smu,
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
@@ -2014,7 +2059,9 @@ static void smu_v13_0_0_set_supported_od_feature_mask(struct smu_context *smu)
 					    OD_OPS_SUPPORT_ACOUSTIC_TARGET_THRESHOLD_RETRIEVE |
 					    OD_OPS_SUPPORT_ACOUSTIC_TARGET_THRESHOLD_SET |
 					    OD_OPS_SUPPORT_FAN_TARGET_TEMPERATURE_RETRIEVE |
-					    OD_OPS_SUPPORT_FAN_TARGET_TEMPERATURE_SET;
+					    OD_OPS_SUPPORT_FAN_TARGET_TEMPERATURE_SET |
+					    OD_OPS_SUPPORT_FAN_MINIMUM_PWM_RETRIEVE |
+					    OD_OPS_SUPPORT_FAN_MINIMUM_PWM_SET;
 }
 
 static int smu_v13_0_0_set_default_od_settings(struct smu_context *smu)
@@ -2078,6 +2125,8 @@ static int smu_v13_0_0_set_default_od_settings(struct smu_context *smu)
 			user_od_table_bak.OverDriveTable.AcousticTargetRpmThreshold;
 		user_od_table->OverDriveTable.FanTargetTemperature =
 			user_od_table_bak.OverDriveTable.FanTargetTemperature;
+		user_od_table->OverDriveTable.FanMinimumPwm =
+			user_od_table_bak.OverDriveTable.FanMinimumPwm;
 	}
 
 	smu_v13_0_0_set_supported_od_feature_mask(smu);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 0f945a86b475..430ad1b05ba3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -82,6 +82,7 @@
 #define PP_OD_FEATURE_FAN_ACOUSTIC_LIMIT		7
 #define PP_OD_FEATURE_FAN_ACOUSTIC_TARGET		8
 #define PP_OD_FEATURE_FAN_TARGET_TEMPERATURE		9
+#define PP_OD_FEATURE_FAN_MINIMUM_PWM			10
 
 #define LINK_SPEED_MAX					3
 
@@ -1121,6 +1122,10 @@ static void smu_v13_0_7_get_od_setting_limits(struct smu_context *smu,
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
@@ -1423,6 +1428,24 @@ static int smu_v13_0_7_print_clk_levels(struct smu_context *smu,
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
@@ -1737,6 +1760,28 @@ static int smu_v13_0_7_od_edit_dpm_table(struct smu_context *smu,
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
@@ -1995,7 +2040,9 @@ static void smu_v13_0_7_set_supported_od_feature_mask(struct smu_context *smu)
 					    OD_OPS_SUPPORT_ACOUSTIC_TARGET_THRESHOLD_RETRIEVE |
 					    OD_OPS_SUPPORT_ACOUSTIC_TARGET_THRESHOLD_SET |
 					    OD_OPS_SUPPORT_FAN_TARGET_TEMPERATURE_RETRIEVE |
-					    OD_OPS_SUPPORT_FAN_TARGET_TEMPERATURE_SET;
+					    OD_OPS_SUPPORT_FAN_TARGET_TEMPERATURE_SET |
+					    OD_OPS_SUPPORT_FAN_MINIMUM_PWM_RETRIEVE |
+					    OD_OPS_SUPPORT_FAN_MINIMUM_PWM_SET;
 }
 
 static int smu_v13_0_7_set_default_od_settings(struct smu_context *smu)
@@ -2059,6 +2106,8 @@ static int smu_v13_0_7_set_default_od_settings(struct smu_context *smu)
 			user_od_table_bak.OverDriveTable.AcousticTargetRpmThreshold;
 		user_od_table->OverDriveTable.FanTargetTemperature =
 			user_od_table_bak.OverDriveTable.FanTargetTemperature;
+		user_od_table->OverDriveTable.FanMinimumPwm =
+			user_od_table_bak.OverDriveTable.FanMinimumPwm;
 	}
 
 	smu_v13_0_7_set_supported_od_feature_mask(smu);
-- 
2.34.1

