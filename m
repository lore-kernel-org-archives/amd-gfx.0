Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 725FBD3C916
	for <amd-gfx@archiver.kernel.org>; Sat, 19 Oct 2024 14:43:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0103D10E266;
	Sat, 19 Oct 2024 14:43:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=oriole.systems header.i=@oriole.systems header.b="Vs7IQmdY";
	dkim-atps=neutral
X-Greylist: delayed 345 seconds by postgrey-1.36 at gabe;
 Sat, 19 Oct 2024 14:43:04 UTC
Received: from coleridge.oriole.systems (coleridge.oriole.systems
 [89.238.76.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9626910E266
 for <amd-gfx@lists.freedesktop.org>; Sat, 19 Oct 2024 14:43:04 +0000 (UTC)
From: =?UTF-8?q?Wolfgang=20M=C3=BCller?= <wolf@oriole.systems>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=oriole.systems;
 s=canary-202303; t=1729348638;
 bh=h9IbRw1+VproxOxRxxxmWJZ3FQkSGBWD1IgVRR4bf3M=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding:From:Sender:Reply-To:Subject:Date:
 Message-Id:To:Cc:Mime-Version:Content-Type:
 Content-Transfer-Encoding:In-Reply-To:References;
 b=Vs7IQmdY0JS7NJpwUWmDhaLlz2rDMabnxRdhpnQM+1qp6S8ib4Ko3pBEhXzyZFncr
 BIuYerSvMiHPXugZpoB6PYMpL742rP6t/cBp6UApZNF4JAhEl9afBXYmFCp8wSTrft
 vpwSvj4fVgUJMT+BZZFav10NaSE2kjldrSzLzpGZ76kbwlftYwfz9LBxs8HZ/icieb
 1GOFkiSr/WKNDtwkrtfsciOQro1RZJgit7ajv0T1/Ax590JXDWoWzcVbLHzAyCL36+
 5BjXmtvdmUiXfb5zzUox/2dJOInA3/mCx2e2vO6msn1Ug+1lKdGMl9yJ+mKSz8Xq8l
 BZBM4h6lkOmSQ==
To: amd-gfx@lists.freedesktop.org
Subject: [RFC PATCH] drm/amd/pm: add zero RPM OD setting support for SMU13
Date: Sat, 19 Oct 2024 16:37:06 +0200
Message-ID: <20241019143706.18779-1-wolf@oriole.systems>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Whilst we have support for setting fan curves there is no support for
disabling the zero RPM feature. Since the relevant bits are already
present in the OverDriveTable, hook them up to a sysctl setting so users
can influence this behaviour.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3489
Signed-off-by: Wolfgang Müller <wolf@oriole.systems>
---
I've been wanting this feature for a while so today I sat down and had a
look at how to best implement it. This is my first ever look at amdgpu
code, so I've marked it with RFC. I've based it on the implementation of
eedd5a343d22 (drm/amd/pm: add fan target temperature OD setting support
for SMU13, 2023-08-11) and also hooked resetting the knob with "r".

One thing I'm unsure about is using PP_OD_FEATURE_ZERO_FAN_BIT for
FeatureCtrlMask. I'm not sure this is the right thing to use there.

I successfully tested this on my own system with a 7900XTX; enabling and
disabling as well as resetting the knob to its default value work fine.

Thanks!

 Documentation/gpu/amdgpu/thermal.rst          |  6 ++
 .../gpu/drm/amd/include/kgd_pp_interface.h    |  2 +
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            | 62 +++++++++++++++++++
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  2 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  2 +
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |  1 +
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 55 +++++++++++++++-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 55 +++++++++++++++-
 8 files changed, 183 insertions(+), 2 deletions(-)

diff --git a/Documentation/gpu/amdgpu/thermal.rst b/Documentation/gpu/amdgpu/thermal.rst
index 6d942b5c5..442b242f9 100644
--- a/Documentation/gpu/amdgpu/thermal.rst
+++ b/Documentation/gpu/amdgpu/thermal.rst
@@ -100,6 +100,12 @@ fan_minimum_pwm
 .. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
    :doc: fan_minimum_pwm
 
+fan_zero_rpm
+----------------------
+
+.. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
+   :doc: fan_zero_rpm
+
 GFXOFF
 ======
 
diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index 2fa71f682..c6343e813 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -119,6 +119,7 @@ enum pp_clock_type {
 	OD_ACOUSTIC_TARGET,
 	OD_FAN_TARGET_TEMPERATURE,
 	OD_FAN_MINIMUM_PWM,
+	OD_FAN_ZERO_RPM,
 };
 
 enum amd_pp_sensors {
@@ -199,6 +200,7 @@ enum PP_OD_DPM_TABLE_COMMAND {
 	PP_OD_EDIT_ACOUSTIC_TARGET,
 	PP_OD_EDIT_FAN_TARGET_TEMPERATURE,
 	PP_OD_EDIT_FAN_MINIMUM_PWM,
+	PP_OD_EDIT_FAN_ZERO_RPM,
 };
 
 struct pp_states_info {
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index ea9407733..52efc5ac6 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -4109,6 +4109,60 @@ static umode_t fan_minimum_pwm_visible(struct amdgpu_device *adev)
 	return umode;
 }
 
+/**
+ * DOC: fan_zero_rpm
+ *
+ * The amdgpu driver provides a sysfs API for checking and adjusting the
+ * zero RPM feature.
+ *
+ * Reading back the file shows you the current setting and the permitted
+ * ranges if changable.
+ *
+ * Writing an integer to the file, change the setting accordingly.
+ *
+ * When you have finished the editing, write "c" (commit) to the file to commit
+ * your changes.
+ *
+ * If you want to reset to the default value, write "r" (reset) to the file to
+ * reset them.
+ */
+static ssize_t fan_zero_rpm_show(struct kobject *kobj,
+					   struct kobj_attribute *attr,
+					   char *buf)
+{
+	struct od_kobj *container = container_of(kobj, struct od_kobj, kobj);
+	struct amdgpu_device *adev = (struct amdgpu_device *)container->priv;
+
+	return (ssize_t)amdgpu_retrieve_od_settings(adev, OD_FAN_ZERO_RPM, buf);
+}
+
+static ssize_t fan_zero_rpm_store(struct kobject *kobj,
+					    struct kobj_attribute *attr,
+					    const char *buf,
+					    size_t count)
+{
+	struct od_kobj *container = container_of(kobj, struct od_kobj, kobj);
+	struct amdgpu_device *adev = (struct amdgpu_device *)container->priv;
+
+	return (ssize_t)amdgpu_distribute_custom_od_settings(adev,
+							     PP_OD_EDIT_FAN_ZERO_RPM,
+							     buf,
+							     count);
+}
+
+static umode_t fan_zero_rpm_visible(struct amdgpu_device *adev)
+{
+	umode_t umode = 0000;
+
+	if (adev->pm.od_feature_mask & OD_OPS_SUPPORT_FAN_ZERO_RPM_RETRIEVE)
+		umode |= S_IRUSR | S_IRGRP | S_IROTH;
+
+	if (adev->pm.od_feature_mask & OD_OPS_SUPPORT_FAN_ZERO_RPM_SET)
+		umode |= S_IWUSR;
+
+	return umode;
+}
+
 static struct od_feature_set amdgpu_od_set = {
 	.containers = {
 		[0] = {
@@ -4154,6 +4208,14 @@ static struct od_feature_set amdgpu_od_set = {
 						.store = fan_minimum_pwm_store,
 					},
 				},
+				[5] = {
+					.name = "fan_zero_rpm",
+					.ops = {
+						.is_visible = fan_zero_rpm_visible,
+						.show = fan_zero_rpm_show,
+						.store = fan_zero_rpm_store,
+					},
+				},
 			},
 		},
 	},
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index f5bf41f21..be8de30ae 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -328,6 +328,8 @@ struct config_table_setting
 #define OD_OPS_SUPPORT_FAN_TARGET_TEMPERATURE_SET		BIT(7)
 #define OD_OPS_SUPPORT_FAN_MINIMUM_PWM_RETRIEVE		BIT(8)
 #define OD_OPS_SUPPORT_FAN_MINIMUM_PWM_SET		BIT(9)
+#define OD_OPS_SUPPORT_FAN_ZERO_RPM_RETRIEVE		BIT(10)
+#define OD_OPS_SUPPORT_FAN_ZERO_RPM_SET		BIT(11)
 
 struct amdgpu_pm {
 	struct mutex		mutex;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index accc96a03..3c6b14f7b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2874,6 +2874,8 @@ static enum smu_clk_type smu_convert_to_smuclk(enum pp_clock_type type)
 		clk_type = SMU_OD_FAN_TARGET_TEMPERATURE; break;
 	case OD_FAN_MINIMUM_PWM:
 		clk_type = SMU_OD_FAN_MINIMUM_PWM; break;
+	case OD_FAN_ZERO_RPM:
+		clk_type = SMU_OD_FAN_ZERO_RPM; break;
 	default:
 		clk_type = SMU_CLK_COUNT; break;
 	}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
index e71a721c1..4d0558470 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
@@ -313,6 +313,7 @@ enum smu_clk_type {
 	SMU_OD_ACOUSTIC_TARGET,
 	SMU_OD_FAN_TARGET_TEMPERATURE,
 	SMU_OD_FAN_MINIMUM_PWM,
+	SMU_OD_FAN_ZERO_RPM,
 	SMU_CLK_COUNT,
 };
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 3e2277abc..092fd4806 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -107,6 +107,7 @@
 #define PP_OD_FEATURE_FAN_ACOUSTIC_TARGET		8
 #define PP_OD_FEATURE_FAN_TARGET_TEMPERATURE		9
 #define PP_OD_FEATURE_FAN_MINIMUM_PWM			10
+#define PP_OD_FEATURE_FAN_ZERO_RPM			11
 
 #define LINK_SPEED_MAX					3
 
@@ -1130,6 +1131,10 @@ static void smu_v13_0_0_get_od_setting_limits(struct smu_context *smu,
 		od_min_setting = overdrive_lowerlimits->FanMinimumPwm;
 		od_max_setting = overdrive_upperlimits->FanMinimumPwm;
 		break;
+	case PP_OD_FEATURE_FAN_ZERO_RPM:
+		od_min_setting = overdrive_lowerlimits->FanZeroRpmEnable;
+		od_max_setting = overdrive_upperlimits->FanZeroRpmEnable;
+		break;
 	default:
 		od_min_setting = od_max_setting = INT_MAX;
 		break;
@@ -1450,6 +1455,24 @@ static int smu_v13_0_0_print_clk_levels(struct smu_context *smu,
 				      min_value, max_value);
 		break;
 
+	case SMU_OD_FAN_ZERO_RPM:
+		if (!smu_v13_0_0_is_od_feature_supported(smu,
+							 PP_OD_FEATURE_ZERO_FAN_BIT))
+			break;
+
+		size += sysfs_emit_at(buf, size, "FAN_ZERO_RPM:\n");
+		size += sysfs_emit_at(buf, size, "%d\n",
+					(int)od_table->OverDriveTable.FanZeroRpmEnable);
+
+		size += sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
+		smu_v13_0_0_get_od_setting_limits(smu,
+						  PP_OD_FEATURE_FAN_ZERO_RPM,
+						  &min_value,
+						  &max_value);
+		size += sysfs_emit_at(buf, size, "ZERO_RPM: %u %u\n",
+				      min_value, max_value);
+		break;
+
 	case SMU_OD_RANGE:
 		if (!smu_v13_0_0_is_od_feature_supported(smu, PP_OD_FEATURE_GFXCLK_BIT) &&
 		    !smu_v13_0_0_is_od_feature_supported(smu, PP_OD_FEATURE_UCLK_BIT) &&
@@ -1547,6 +1570,11 @@ static int smu_v13_0_0_od_restore_table_single(struct smu_context *smu, long inp
 		od_table->OverDriveTable.FanMode = FAN_MODE_AUTO;
 		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_FAN_CURVE_BIT);
 		break;
+	case PP_OD_EDIT_FAN_ZERO_RPM:
+		od_table->OverDriveTable.FanZeroRpmEnable =
+					boot_overdrive_table->OverDriveTable.FanZeroRpmEnable;
+		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_ZERO_FAN_BIT);
+		break;
 	default:
 		dev_info(adev->dev, "Invalid table index: %ld\n", input);
 		return -EINVAL;
@@ -1840,6 +1868,27 @@ static int smu_v13_0_0_od_edit_dpm_table(struct smu_context *smu,
 		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_FAN_CURVE_BIT);
 		break;
 
+	case PP_OD_EDIT_FAN_ZERO_RPM:
+		if (!smu_v13_0_0_is_od_feature_supported(smu, PP_OD_FEATURE_ZERO_FAN_BIT)) {
+			dev_warn(adev->dev, "Zero RPM setting not supported!\n");
+			return -ENOTSUPP;
+		}
+
+		smu_v13_0_0_get_od_setting_limits(smu,
+						  PP_OD_FEATURE_FAN_ZERO_RPM,
+						  &minimum,
+						  &maximum);
+		if (input[0] < minimum ||
+		    input[0] > maximum) {
+			dev_info(adev->dev, "zero RPM setting(%ld) must be within [%d, %d]!\n",
+				 input[0], minimum, maximum);
+			return -EINVAL;
+		}
+
+		od_table->OverDriveTable.FanZeroRpmEnable = input[0];
+		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_ZERO_FAN_BIT);
+		break;
+
 	case PP_OD_RESTORE_DEFAULT_TABLE:
 		if (size == 1) {
 			ret = smu_v13_0_0_od_restore_table_single(smu, input[0]);
@@ -2110,7 +2159,9 @@ static void smu_v13_0_0_set_supported_od_feature_mask(struct smu_context *smu)
 					    OD_OPS_SUPPORT_FAN_TARGET_TEMPERATURE_RETRIEVE |
 					    OD_OPS_SUPPORT_FAN_TARGET_TEMPERATURE_SET |
 					    OD_OPS_SUPPORT_FAN_MINIMUM_PWM_RETRIEVE |
-					    OD_OPS_SUPPORT_FAN_MINIMUM_PWM_SET;
+					    OD_OPS_SUPPORT_FAN_MINIMUM_PWM_SET |
+					    OD_OPS_SUPPORT_FAN_ZERO_RPM_RETRIEVE|
+					    OD_OPS_SUPPORT_FAN_ZERO_RPM_SET;
 }
 
 static int smu_v13_0_0_set_default_od_settings(struct smu_context *smu)
@@ -2176,6 +2227,8 @@ static int smu_v13_0_0_set_default_od_settings(struct smu_context *smu)
 			user_od_table_bak.OverDriveTable.FanTargetTemperature;
 		user_od_table->OverDriveTable.FanMinimumPwm =
 			user_od_table_bak.OverDriveTable.FanMinimumPwm;
+		user_od_table->OverDriveTable.FanZeroRpmEnable =
+			user_od_table_bak.OverDriveTable.FanZeroRpmEnable;
 	}
 
 	smu_v13_0_0_set_supported_od_feature_mask(smu);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 23f133884..735ed3d4f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -83,6 +83,7 @@
 #define PP_OD_FEATURE_FAN_ACOUSTIC_TARGET		8
 #define PP_OD_FEATURE_FAN_TARGET_TEMPERATURE		9
 #define PP_OD_FEATURE_FAN_MINIMUM_PWM			10
+#define PP_OD_FEATURE_FAN_ZERO_RPM			11
 
 #define LINK_SPEED_MAX					3
 
@@ -1119,6 +1120,10 @@ static void smu_v13_0_7_get_od_setting_limits(struct smu_context *smu,
 		od_min_setting = overdrive_lowerlimits->FanMinimumPwm;
 		od_max_setting = overdrive_upperlimits->FanMinimumPwm;
 		break;
+	case PP_OD_FEATURE_FAN_ZERO_RPM:
+		od_min_setting = overdrive_lowerlimits->FanZeroRpmEnable;
+		od_max_setting = overdrive_upperlimits->FanZeroRpmEnable;
+		break;
 	default:
 		od_min_setting = od_max_setting = INT_MAX;
 		break;
@@ -1439,6 +1444,24 @@ static int smu_v13_0_7_print_clk_levels(struct smu_context *smu,
 				      min_value, max_value);
 		break;
 
+	case SMU_OD_FAN_ZERO_RPM:
+		if (!smu_v13_0_7_is_od_feature_supported(smu,
+							 PP_OD_FEATURE_ZERO_FAN_BIT))
+			break;
+
+		size += sysfs_emit_at(buf, size, "FAN_ZERO_RPM:\n");
+		size += sysfs_emit_at(buf, size, "%d\n",
+					(int)od_table->OverDriveTable.FanZeroRpmEnable);
+
+		size += sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
+		smu_v13_0_7_get_od_setting_limits(smu,
+						  PP_OD_FEATURE_FAN_ZERO_RPM,
+						  &min_value,
+						  &max_value);
+		size += sysfs_emit_at(buf, size, "ZERO_RPM: %u %u\n",
+				      min_value, max_value);
+		break;
+
 	case SMU_OD_RANGE:
 		if (!smu_v13_0_7_is_od_feature_supported(smu, PP_OD_FEATURE_GFXCLK_BIT) &&
 		    !smu_v13_0_7_is_od_feature_supported(smu, PP_OD_FEATURE_UCLK_BIT) &&
@@ -1535,6 +1558,11 @@ static int smu_v13_0_7_od_restore_table_single(struct smu_context *smu, long inp
 		od_table->OverDriveTable.FanMode = FAN_MODE_AUTO;
 		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_FAN_CURVE_BIT);
 		break;
+	case PP_OD_EDIT_FAN_ZERO_RPM:
+		od_table->OverDriveTable.FanZeroRpmEnable =
+					boot_overdrive_table->OverDriveTable.FanZeroRpmEnable;
+		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_ZERO_FAN_BIT);
+		break;
 	default:
 		dev_info(adev->dev, "Invalid table index: %ld\n", input);
 		return -EINVAL;
@@ -1828,6 +1856,27 @@ static int smu_v13_0_7_od_edit_dpm_table(struct smu_context *smu,
 		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_FAN_CURVE_BIT);
 		break;
 
+	case PP_OD_EDIT_FAN_ZERO_RPM:
+		if (!smu_v13_0_7_is_od_feature_supported(smu, PP_OD_FEATURE_ZERO_FAN_BIT)) {
+			dev_warn(adev->dev, "Zero RPM setting not supported!\n");
+			return -ENOTSUPP;
+		}
+
+		smu_v13_0_7_get_od_setting_limits(smu,
+						  PP_OD_FEATURE_FAN_ZERO_RPM,
+						  &minimum,
+						  &maximum);
+		if (input[0] < minimum ||
+		    input[0] > maximum) {
+			dev_info(adev->dev, "zero RPM setting(%ld) must be within [%d, %d]!\n",
+				 input[0], minimum, maximum);
+			return -EINVAL;
+		}
+
+		od_table->OverDriveTable.FanZeroRpmEnable = input[0];
+		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_ZERO_FAN_BIT);
+		break;
+
 	case PP_OD_RESTORE_DEFAULT_TABLE:
 		if (size == 1) {
 			ret = smu_v13_0_7_od_restore_table_single(smu, input[0]);
@@ -2094,7 +2143,9 @@ static void smu_v13_0_7_set_supported_od_feature_mask(struct smu_context *smu)
 					    OD_OPS_SUPPORT_FAN_TARGET_TEMPERATURE_RETRIEVE |
 					    OD_OPS_SUPPORT_FAN_TARGET_TEMPERATURE_SET |
 					    OD_OPS_SUPPORT_FAN_MINIMUM_PWM_RETRIEVE |
-					    OD_OPS_SUPPORT_FAN_MINIMUM_PWM_SET;
+					    OD_OPS_SUPPORT_FAN_MINIMUM_PWM_SET |
+					    OD_OPS_SUPPORT_FAN_ZERO_RPM_RETRIEVE|
+					    OD_OPS_SUPPORT_FAN_ZERO_RPM_SET;
 }
 
 static int smu_v13_0_7_set_default_od_settings(struct smu_context *smu)
@@ -2160,6 +2211,8 @@ static int smu_v13_0_7_set_default_od_settings(struct smu_context *smu)
 			user_od_table_bak.OverDriveTable.FanTargetTemperature;
 		user_od_table->OverDriveTable.FanMinimumPwm =
 			user_od_table_bak.OverDriveTable.FanMinimumPwm;
+		user_od_table->OverDriveTable.FanZeroRpmEnable =
+			user_od_table_bak.OverDriveTable.FanZeroRpmEnable;
 	}
 
 	smu_v13_0_7_set_supported_od_feature_mask(smu);

base-commit: 3631f572ee38bed4c3d0a9003570c63eaa9fd4e3
-- 
2.47.0

