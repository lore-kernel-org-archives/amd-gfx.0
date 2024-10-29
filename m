Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9988D2AB20
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Oct 2024 11:18:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB27210E62A;
	Tue, 29 Oct 2024 11:18:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=oriole.systems header.i=@oriole.systems header.b="gJx01oAO";
	dkim-atps=neutral
Received: from coleridge.oriole.systems (coleridge.oriole.systems
 [89.238.76.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD4E310E627
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Oct 2024 11:18:23 +0000 (UTC)
From: =?UTF-8?q?Wolfgang=20M=C3=BCller?= <wolf@oriole.systems>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=oriole.systems;
 s=canary-202303; t=1730200702;
 bh=QdXkHqdL6Eqxi0tl+NA1HmjafY+Knu3//3oA03cxZyA=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type:Content-Transfer-Encoding:From:Sender:
 Reply-To:Subject:Date:Message-Id:To:Cc:Mime-Version:Content-Type:
 Content-Transfer-Encoding:In-Reply-To:References;
 b=gJx01oAO7/nHdGr+jvSUDBrL9ZKayuPLgPM8isOHlpEbCysU7pBNO8ti1mWA5kNLw
 evCjKiqmYdNlSJCPryIxH8d5wdGhsGN0tPQIArGCAxeEb//gHSw8TBFejDsGAf9pfq
 bBAV21TxmXfJToOJr0+hCwW1jyc/evLRHCF830l+bH+8Snsr4qG2exu4g/zquZmXcQ
 /y2C9CUas+6wpvZQw9wfnDWWYDfTqIb9EE/JbXsZyTCRKTmRjkOeGDV3EqnnX+TIFg
 /q83ZHkacEdE4N8+SipgDrBXtAicksJ3bsHNs9s+dAwmax7+deVKIuRkSpxvHjIZKb
 DmZTVjLTHkM5A==
To: amd-gfx@lists.freedesktop.org
Cc: Kenneth.Feng@amd.com
Subject: [PATCH v2 0/2] Two zero RPM features
Date: Tue, 29 Oct 2024 12:17:51 +0100
Message-ID: <20241029111753.5132-1-wolf@oriole.systems>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241019143706.18779-1-wolf@oriole.systems>
References: <20241019143706.18779-1-wolf@oriole.systems>
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

Here's v2 of this series, now also with support for setting the zero RPM
stop temperature. Additionally, the fan_zero_rpm knob has been renamed
fan_zero_rpm_enable.

As before I successfully tested both changes on my own system.

Wolfgang Müller (2):
  drm/amd/pm: add zero RPM OD setting support for SMU13
  drm/amd/pm: add zero RPM stop temperature OD setting support for SMU13

 Documentation/gpu/amdgpu/thermal.rst          |  12 ++
 .../gpu/drm/amd/include/kgd_pp_interface.h    |   4 +
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            | 127 ++++++++++++++++++
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |   4 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |   4 +
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |   2 +
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 108 ++++++++++++++-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 108 ++++++++++++++-
 8 files changed, 367 insertions(+), 2 deletions(-)

Range-diff against v1:
1:  633acda07 ! 1:  b6233aed7 drm/amd/pm: add zero RPM OD setting support for SMU13
    @@ Documentation/gpu/amdgpu/thermal.rst: fan_minimum_pwm
      .. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
         :doc: fan_minimum_pwm
      
    -+fan_zero_rpm
    ++fan_zero_rpm_enable
     +----------------------
     +
     +.. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
    -+   :doc: fan_zero_rpm
    ++   :doc: fan_zero_rpm_enable
     +
      GFXOFF
      ======
    @@ drivers/gpu/drm/amd/include/kgd_pp_interface.h: enum pp_clock_type {
      	OD_ACOUSTIC_TARGET,
      	OD_FAN_TARGET_TEMPERATURE,
      	OD_FAN_MINIMUM_PWM,
    -+	OD_FAN_ZERO_RPM,
    ++	OD_FAN_ZERO_RPM_ENABLE,
      };
      
      enum amd_pp_sensors {
    @@ drivers/gpu/drm/amd/include/kgd_pp_interface.h: enum PP_OD_DPM_TABLE_COMMAND {
      	PP_OD_EDIT_ACOUSTIC_TARGET,
      	PP_OD_EDIT_FAN_TARGET_TEMPERATURE,
      	PP_OD_EDIT_FAN_MINIMUM_PWM,
    -+	PP_OD_EDIT_FAN_ZERO_RPM,
    ++	PP_OD_EDIT_FAN_ZERO_RPM_ENABLE,
      };
      
      struct pp_states_info {
    @@ drivers/gpu/drm/amd/pm/amdgpu_pm.c: static umode_t fan_minimum_pwm_visible(struc
      }
      
     +/**
    -+ * DOC: fan_zero_rpm
    ++ * DOC: fan_zero_rpm_enable
     + *
     + * The amdgpu driver provides a sysfs API for checking and adjusting the
     + * zero RPM feature.
    @@ drivers/gpu/drm/amd/pm/amdgpu_pm.c: static umode_t fan_minimum_pwm_visible(struc
     + * If you want to reset to the default value, write "r" (reset) to the file to
     + * reset them.
     + */
    -+static ssize_t fan_zero_rpm_show(struct kobject *kobj,
    ++static ssize_t fan_zero_rpm_enable_show(struct kobject *kobj,
     +					   struct kobj_attribute *attr,
     +					   char *buf)
     +{
     +	struct od_kobj *container = container_of(kobj, struct od_kobj, kobj);
     +	struct amdgpu_device *adev = (struct amdgpu_device *)container->priv;
     +
    -+	return (ssize_t)amdgpu_retrieve_od_settings(adev, OD_FAN_ZERO_RPM, buf);
    ++	return (ssize_t)amdgpu_retrieve_od_settings(adev, OD_FAN_ZERO_RPM_ENABLE, buf);
     +}
     +
    -+static ssize_t fan_zero_rpm_store(struct kobject *kobj,
    ++static ssize_t fan_zero_rpm_enable_store(struct kobject *kobj,
     +					    struct kobj_attribute *attr,
     +					    const char *buf,
     +					    size_t count)
    @@ drivers/gpu/drm/amd/pm/amdgpu_pm.c: static umode_t fan_minimum_pwm_visible(struc
     +	struct amdgpu_device *adev = (struct amdgpu_device *)container->priv;
     +
     +	return (ssize_t)amdgpu_distribute_custom_od_settings(adev,
    -+							     PP_OD_EDIT_FAN_ZERO_RPM,
    ++							     PP_OD_EDIT_FAN_ZERO_RPM_ENABLE,
     +							     buf,
     +							     count);
     +}
     +
    -+static umode_t fan_zero_rpm_visible(struct amdgpu_device *adev)
    ++static umode_t fan_zero_rpm_enable_visible(struct amdgpu_device *adev)
     +{
     +	umode_t umode = 0000;
     +
    -+	if (adev->pm.od_feature_mask & OD_OPS_SUPPORT_FAN_ZERO_RPM_RETRIEVE)
    ++	if (adev->pm.od_feature_mask & OD_OPS_SUPPORT_FAN_ZERO_RPM_ENABLE_RETRIEVE)
     +		umode |= S_IRUSR | S_IRGRP | S_IROTH;
     +
    -+	if (adev->pm.od_feature_mask & OD_OPS_SUPPORT_FAN_ZERO_RPM_SET)
    ++	if (adev->pm.od_feature_mask & OD_OPS_SUPPORT_FAN_ZERO_RPM_ENABLE_SET)
     +		umode |= S_IWUSR;
     +
     +	return umode;
    @@ drivers/gpu/drm/amd/pm/amdgpu_pm.c: static struct od_feature_set amdgpu_od_set =
      					},
      				},
     +				[5] = {
    -+					.name = "fan_zero_rpm",
    ++					.name = "fan_zero_rpm_enable",
     +					.ops = {
    -+						.is_visible = fan_zero_rpm_visible,
    -+						.show = fan_zero_rpm_show,
    -+						.store = fan_zero_rpm_store,
    ++						.is_visible = fan_zero_rpm_enable_visible,
    ++						.show = fan_zero_rpm_enable_show,
    ++						.store = fan_zero_rpm_enable_store,
     +					},
     +				},
      			},
    @@ drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h: struct config_table_setting
      #define OD_OPS_SUPPORT_FAN_TARGET_TEMPERATURE_SET		BIT(7)
      #define OD_OPS_SUPPORT_FAN_MINIMUM_PWM_RETRIEVE		BIT(8)
      #define OD_OPS_SUPPORT_FAN_MINIMUM_PWM_SET		BIT(9)
    -+#define OD_OPS_SUPPORT_FAN_ZERO_RPM_RETRIEVE		BIT(10)
    -+#define OD_OPS_SUPPORT_FAN_ZERO_RPM_SET		BIT(11)
    ++#define OD_OPS_SUPPORT_FAN_ZERO_RPM_ENABLE_RETRIEVE	BIT(10)
    ++#define OD_OPS_SUPPORT_FAN_ZERO_RPM_ENABLE_SET		BIT(11)
      
      struct amdgpu_pm {
      	struct mutex		mutex;
    @@ drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c: static enum smu_clk_type smu_convert_
      		clk_type = SMU_OD_FAN_TARGET_TEMPERATURE; break;
      	case OD_FAN_MINIMUM_PWM:
      		clk_type = SMU_OD_FAN_MINIMUM_PWM; break;
    -+	case OD_FAN_ZERO_RPM:
    -+		clk_type = SMU_OD_FAN_ZERO_RPM; break;
    ++	case OD_FAN_ZERO_RPM_ENABLE:
    ++		clk_type = SMU_OD_FAN_ZERO_RPM_ENABLE; break;
      	default:
      		clk_type = SMU_CLK_COUNT; break;
      	}
    @@ drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h: enum smu_clk_type {
      	SMU_OD_ACOUSTIC_TARGET,
      	SMU_OD_FAN_TARGET_TEMPERATURE,
      	SMU_OD_FAN_MINIMUM_PWM,
    -+	SMU_OD_FAN_ZERO_RPM,
    ++	SMU_OD_FAN_ZERO_RPM_ENABLE,
      	SMU_CLK_COUNT,
      };
      
    @@ drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
      #define PP_OD_FEATURE_FAN_ACOUSTIC_TARGET		8
      #define PP_OD_FEATURE_FAN_TARGET_TEMPERATURE		9
      #define PP_OD_FEATURE_FAN_MINIMUM_PWM			10
    -+#define PP_OD_FEATURE_FAN_ZERO_RPM			11
    ++#define PP_OD_FEATURE_FAN_ZERO_RPM_ENABLE		11
      
      #define LINK_SPEED_MAX					3
      
    @@ drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c: static void smu_v13_0_0_ge
      		od_min_setting = overdrive_lowerlimits->FanMinimumPwm;
      		od_max_setting = overdrive_upperlimits->FanMinimumPwm;
      		break;
    -+	case PP_OD_FEATURE_FAN_ZERO_RPM:
    ++	case PP_OD_FEATURE_FAN_ZERO_RPM_ENABLE:
     +		od_min_setting = overdrive_lowerlimits->FanZeroRpmEnable;
     +		od_max_setting = overdrive_upperlimits->FanZeroRpmEnable;
     +		break;
    @@ drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c: static int smu_v13_0_0_pri
      				      min_value, max_value);
      		break;
      
    -+	case SMU_OD_FAN_ZERO_RPM:
    ++	case SMU_OD_FAN_ZERO_RPM_ENABLE:
     +		if (!smu_v13_0_0_is_od_feature_supported(smu,
     +							 PP_OD_FEATURE_ZERO_FAN_BIT))
     +			break;
     +
    -+		size += sysfs_emit_at(buf, size, "FAN_ZERO_RPM:\n");
    ++		size += sysfs_emit_at(buf, size, "FAN_ZERO_RPM_ENABLE:\n");
     +		size += sysfs_emit_at(buf, size, "%d\n",
     +					(int)od_table->OverDriveTable.FanZeroRpmEnable);
     +
     +		size += sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
     +		smu_v13_0_0_get_od_setting_limits(smu,
    -+						  PP_OD_FEATURE_FAN_ZERO_RPM,
    ++						  PP_OD_FEATURE_FAN_ZERO_RPM_ENABLE,
     +						  &min_value,
     +						  &max_value);
    -+		size += sysfs_emit_at(buf, size, "ZERO_RPM: %u %u\n",
    ++		size += sysfs_emit_at(buf, size, "ZERO_RPM_ENABLE: %u %u\n",
     +				      min_value, max_value);
     +		break;
     +
    @@ drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c: static int smu_v13_0_0_od_
      		od_table->OverDriveTable.FanMode = FAN_MODE_AUTO;
      		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_FAN_CURVE_BIT);
      		break;
    -+	case PP_OD_EDIT_FAN_ZERO_RPM:
    ++	case PP_OD_EDIT_FAN_ZERO_RPM_ENABLE:
     +		od_table->OverDriveTable.FanZeroRpmEnable =
     +					boot_overdrive_table->OverDriveTable.FanZeroRpmEnable;
     +		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_ZERO_FAN_BIT);
    @@ drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c: static int smu_v13_0_0_od_
      		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_FAN_CURVE_BIT);
      		break;
      
    -+	case PP_OD_EDIT_FAN_ZERO_RPM:
    ++	case PP_OD_EDIT_FAN_ZERO_RPM_ENABLE:
     +		if (!smu_v13_0_0_is_od_feature_supported(smu, PP_OD_FEATURE_ZERO_FAN_BIT)) {
     +			dev_warn(adev->dev, "Zero RPM setting not supported!\n");
     +			return -ENOTSUPP;
     +		}
     +
     +		smu_v13_0_0_get_od_setting_limits(smu,
    -+						  PP_OD_FEATURE_FAN_ZERO_RPM,
    ++						  PP_OD_FEATURE_FAN_ZERO_RPM_ENABLE,
     +						  &minimum,
     +						  &maximum);
     +		if (input[0] < minimum ||
     +		    input[0] > maximum) {
    -+			dev_info(adev->dev, "zero RPM setting(%ld) must be within [%d, %d]!\n",
    ++			dev_info(adev->dev, "zero RPM enable setting(%ld) must be within [%d, %d]!\n",
     +				 input[0], minimum, maximum);
     +			return -EINVAL;
     +		}
    @@ drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c: static void smu_v13_0_0_se
      					    OD_OPS_SUPPORT_FAN_MINIMUM_PWM_RETRIEVE |
     -					    OD_OPS_SUPPORT_FAN_MINIMUM_PWM_SET;
     +					    OD_OPS_SUPPORT_FAN_MINIMUM_PWM_SET |
    -+					    OD_OPS_SUPPORT_FAN_ZERO_RPM_RETRIEVE|
    -+					    OD_OPS_SUPPORT_FAN_ZERO_RPM_SET;
    ++					    OD_OPS_SUPPORT_FAN_ZERO_RPM_ENABLE_RETRIEVE |
    ++					    OD_OPS_SUPPORT_FAN_ZERO_RPM_ENABLE_SET;
      }
      
      static int smu_v13_0_0_set_default_od_settings(struct smu_context *smu)
    @@ drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
      #define PP_OD_FEATURE_FAN_ACOUSTIC_TARGET		8
      #define PP_OD_FEATURE_FAN_TARGET_TEMPERATURE		9
      #define PP_OD_FEATURE_FAN_MINIMUM_PWM			10
    -+#define PP_OD_FEATURE_FAN_ZERO_RPM			11
    ++#define PP_OD_FEATURE_FAN_ZERO_RPM_ENABLE		11
      
      #define LINK_SPEED_MAX					3
      
    @@ drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c: static void smu_v13_0_7_ge
      		od_min_setting = overdrive_lowerlimits->FanMinimumPwm;
      		od_max_setting = overdrive_upperlimits->FanMinimumPwm;
      		break;
    -+	case PP_OD_FEATURE_FAN_ZERO_RPM:
    ++	case PP_OD_FEATURE_FAN_ZERO_RPM_ENABLE:
     +		od_min_setting = overdrive_lowerlimits->FanZeroRpmEnable;
     +		od_max_setting = overdrive_upperlimits->FanZeroRpmEnable;
     +		break;
    @@ drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c: static int smu_v13_0_7_pri
      				      min_value, max_value);
      		break;
      
    -+	case SMU_OD_FAN_ZERO_RPM:
    ++	case SMU_OD_FAN_ZERO_RPM_ENABLE:
     +		if (!smu_v13_0_7_is_od_feature_supported(smu,
     +							 PP_OD_FEATURE_ZERO_FAN_BIT))
     +			break;
     +
    -+		size += sysfs_emit_at(buf, size, "FAN_ZERO_RPM:\n");
    ++		size += sysfs_emit_at(buf, size, "FAN_ZERO_RPM_ENABLE:\n");
     +		size += sysfs_emit_at(buf, size, "%d\n",
     +					(int)od_table->OverDriveTable.FanZeroRpmEnable);
     +
     +		size += sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
     +		smu_v13_0_7_get_od_setting_limits(smu,
    -+						  PP_OD_FEATURE_FAN_ZERO_RPM,
    ++						  PP_OD_FEATURE_FAN_ZERO_RPM_ENABLE,
     +						  &min_value,
     +						  &max_value);
    -+		size += sysfs_emit_at(buf, size, "ZERO_RPM: %u %u\n",
    ++		size += sysfs_emit_at(buf, size, "ZERO_RPM_ENABLE: %u %u\n",
     +				      min_value, max_value);
     +		break;
     +
    @@ drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c: static int smu_v13_0_7_od_
      		od_table->OverDriveTable.FanMode = FAN_MODE_AUTO;
      		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_FAN_CURVE_BIT);
      		break;
    -+	case PP_OD_EDIT_FAN_ZERO_RPM:
    ++	case PP_OD_EDIT_FAN_ZERO_RPM_ENABLE:
     +		od_table->OverDriveTable.FanZeroRpmEnable =
     +					boot_overdrive_table->OverDriveTable.FanZeroRpmEnable;
     +		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_ZERO_FAN_BIT);
    @@ drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c: static int smu_v13_0_7_od_
      		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_FAN_CURVE_BIT);
      		break;
      
    -+	case PP_OD_EDIT_FAN_ZERO_RPM:
    ++	case PP_OD_EDIT_FAN_ZERO_RPM_ENABLE:
     +		if (!smu_v13_0_7_is_od_feature_supported(smu, PP_OD_FEATURE_ZERO_FAN_BIT)) {
     +			dev_warn(adev->dev, "Zero RPM setting not supported!\n");
     +			return -ENOTSUPP;
     +		}
     +
     +		smu_v13_0_7_get_od_setting_limits(smu,
    -+						  PP_OD_FEATURE_FAN_ZERO_RPM,
    ++						  PP_OD_FEATURE_FAN_ZERO_RPM_ENABLE,
     +						  &minimum,
     +						  &maximum);
     +		if (input[0] < minimum ||
     +		    input[0] > maximum) {
    -+			dev_info(adev->dev, "zero RPM setting(%ld) must be within [%d, %d]!\n",
    ++			dev_info(adev->dev, "zero RPM enable setting(%ld) must be within [%d, %d]!\n",
     +				 input[0], minimum, maximum);
     +			return -EINVAL;
     +		}
    @@ drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c: static void smu_v13_0_7_se
      					    OD_OPS_SUPPORT_FAN_MINIMUM_PWM_RETRIEVE |
     -					    OD_OPS_SUPPORT_FAN_MINIMUM_PWM_SET;
     +					    OD_OPS_SUPPORT_FAN_MINIMUM_PWM_SET |
    -+					    OD_OPS_SUPPORT_FAN_ZERO_RPM_RETRIEVE|
    -+					    OD_OPS_SUPPORT_FAN_ZERO_RPM_SET;
    ++					    OD_OPS_SUPPORT_FAN_ZERO_RPM_ENABLE_RETRIEVE |
    ++					    OD_OPS_SUPPORT_FAN_ZERO_RPM_ENABLE_SET;
      }
      
      static int smu_v13_0_7_set_default_od_settings(struct smu_context *smu)
-:  --------- > 2:  6c2af6efb drm/amd/pm: add zero RPM stop temperature OD setting support for SMU13
-- 
2.47.0

