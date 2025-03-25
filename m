Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D947C35FFC
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Mar 2025 12:42:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90FD710E566;
	Tue, 25 Mar 2025 12:42:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EOzB6/aD";
	dkim-atps=neutral
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com
 [209.85.167.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2536C10E064
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Mar 2025 10:26:58 +0000 (UTC)
Received: by mail-lf1-f54.google.com with SMTP id
 2adb3069b0e04-5499c3cc6b3so321004e87.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Mar 2025 03:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742898416; x=1743503216; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3Nqs1IC75lIOpzBjGnyb8c4V541LU3R6/5QAoqBnP8Q=;
 b=EOzB6/aD96zXGr3JKqwneogmKM/RbjS0KUuYlCmIrEiK1H2idfoaNHUfiP/6oAhknz
 HAuQXLGJNLvrFelZeRrp/VsTT5Vde0t3gDZ8rfkyxeQGZBUgiURQHAhC9tzYNyRL67wd
 6NDWLCqrKqzfaw8f3lysWny3a5PpUlfZjaaeJFAq2UfaTNnX/w+mnIBTxy+Q3i2dvNnB
 Na8Z8lzWEFeX0jxL8fW28gw2hsCI8F02SC7Vk2giFNEw/ctw+wqIz+9o1KVBDVbujImt
 zJauZ3Xhjo5IXGwlk06rn2XkQ8dv4DNPDqmHeIQqLZNRjwqnZobkUrsXfxi3xZlvD/Ai
 ugpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742898416; x=1743503216;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3Nqs1IC75lIOpzBjGnyb8c4V541LU3R6/5QAoqBnP8Q=;
 b=WGt6iYLXa71/FWPRJ1kUjqZBG2WYyGn8+CepfA6VvhDq9qPgdtEZUStnP1EFV+Texe
 V0/eF606vHsYk5bUI+r3GK9yAJrMqQR0LFUktSsR7vqNHHqc10t0uepSRFYaWRU1MqQN
 /nXq7HHKlh5v4eqdgvvFjyxJegWPN3fuSRdIbFlELvgX3YvkM/AldkLU6rpk1J2bu2rB
 A/cdarrMYefUzLXyzbkx5CveSbhe7HWlpGL1z23k7AVGh7OZaFEpbhFK3icd9AuNNFEX
 UwFmbQQ2+Gm3Opl9Me42dFNfQ3M45MGb+E+aJPycZ1uMzBo55cZ6L/AmEuttw5kYJ0aQ
 TGQw==
X-Gm-Message-State: AOJu0YxXVjDZGCkdmK7h9eiWCtNeRLOD+9stIxuWiyPVvSuODTtIRU8d
 +Q7cTA1T1ZF7QKhZ02M6s60V2BRZPWe3Z39dm9qAIUd+mLrbxYAXmu7J6g==
X-Gm-Gg: ASbGncuCe0PNEsNzTW2TA+efRNN51f4csmuBGTK6KCUHGhhS+4pYgGau0xSp2fQJe+h
 G+qzAyiqOT6TR/cc92DflhIE3yM2n+VEytw+1Vp6i8NrL1gxb4A49wOr1Kjhi2WWaxY4KWBC1/2
 3e7TvU2Y4YksDvFw7gsVxir/YfbwrOn/ZR8MIi4TutDJTcLv9/kVxRZX16m2fBw+PB6yUeekAx6
 cgA3r/bJHaEOWoSEuq1SDKsaBnmS2gJP+c9f0pLoRkV5c27x0vxmwunNL/bL1VrTAihHv0B/2cI
 YMGhSYM7VJuZ693mwam1GfPSX9F+1azTBzNX0pqYJVCnwVrROC1T8nebcwiNSIhoIpr76MNqGM1
 RU3+I337pTuCoSb5cp7m/MVUu2w==
X-Google-Smtp-Source: AGHT+IHatcWaqC9/4AxIUbkQw8PTM88q6dFexzrxpqyi2hOx6J0xBQLOr42rCoqlIOmxm0UyhcP1Ag==
X-Received: by 2002:a05:6512:3f24:b0:549:8e41:20b9 with SMTP id
 2adb3069b0e04-54af5410ac6mr215706e87.8.1742898415940; 
 Tue, 25 Mar 2025 03:26:55 -0700 (PDT)
Received: from laptok.lan (89-64-31-184.dynamic.chello.pl. [89.64.31.184])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-54ad64fbaf4sm1489679e87.137.2025.03.25.03.26.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Mar 2025 03:26:55 -0700 (PDT)
From: =?UTF-8?q?Tomasz=20Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: alexander.deucher@amd.com,
	kenneth.feng@amd.com,
	KevinYang.Wang@amd.com
Cc: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/pm: Add zero RPM enabled OD setting support for
 SMU14.0.2
Date: Tue, 25 Mar 2025 11:26:52 +0100
Message-ID: <20250325102652.229756-1-tomasz.pakula.oficjalny@gmail.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 25 Mar 2025 12:41:59 +0000
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

Hook up zero RPM enable for 9070 and 9070 XT based on RDNA3
(smu 13.0.0 and 13.0.7) code.

Tested on 9070 XT Hellhound

Signed-off-by: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>
---
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  | 55 ++++++++++++++++++-
 1 file changed, 54 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index f7cfe1f35cae..82c2db972491 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -79,6 +79,7 @@
 #define PP_OD_FEATURE_FAN_ACOUSTIC_TARGET		8
 #define PP_OD_FEATURE_FAN_TARGET_TEMPERATURE		9
 #define PP_OD_FEATURE_FAN_MINIMUM_PWM			10
+#define PP_OD_FEATURE_FAN_ZERO_RPM_ENABLE		11
 
 static struct cmn2asic_msg_mapping smu_v14_0_2_message_map[SMU_MSG_MAX_COUNT] = {
 	MSG_MAP(TestMessage,			PPSMC_MSG_TestMessage,                 1),
@@ -1052,6 +1053,10 @@ static void smu_v14_0_2_get_od_setting_limits(struct smu_context *smu,
 		od_min_setting = overdrive_lowerlimits->FanMinimumPwm;
 		od_max_setting = overdrive_upperlimits->FanMinimumPwm;
 		break;
+	case PP_OD_FEATURE_FAN_ZERO_RPM_ENABLE:
+		od_min_setting = overdrive_lowerlimits->FanZeroRpmEnable;
+		od_max_setting = overdrive_upperlimits->FanZeroRpmEnable;
+		break;
 	default:
 		od_min_setting = od_max_setting = INT_MAX;
 		break;
@@ -1330,6 +1335,24 @@ static int smu_v14_0_2_print_clk_levels(struct smu_context *smu,
 				      min_value, max_value);
 		break;
 
+	case SMU_OD_FAN_ZERO_RPM_ENABLE:
+		if (!smu_v14_0_2_is_od_feature_supported(smu,
+							 PP_OD_FEATURE_ZERO_FAN_BIT))
+			break;
+
+		size += sysfs_emit_at(buf, size, "FAN_ZERO_RPM_ENABLE:\n");
+		size += sysfs_emit_at(buf, size, "%d\n",
+				(int)od_table->OverDriveTable.FanZeroRpmEnable);
+
+		size += sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
+		smu_v14_0_2_get_od_setting_limits(smu,
+						  PP_OD_FEATURE_FAN_ZERO_RPM_ENABLE,
+						  &min_value,
+						  &max_value);
+		size += sysfs_emit_at(buf, size, "ZERO_RPM_ENABLE: %u %u\n",
+				      min_value, max_value);
+		break;
+
 	case SMU_OD_RANGE:
 		if (!smu_v14_0_2_is_od_feature_supported(smu, PP_OD_FEATURE_GFXCLK_BIT) &&
 		    !smu_v14_0_2_is_od_feature_supported(smu, PP_OD_FEATURE_UCLK_BIT) &&
@@ -2270,7 +2293,9 @@ static void smu_v14_0_2_set_supported_od_feature_mask(struct smu_context *smu)
 					    OD_OPS_SUPPORT_FAN_TARGET_TEMPERATURE_RETRIEVE |
 					    OD_OPS_SUPPORT_FAN_TARGET_TEMPERATURE_SET |
 					    OD_OPS_SUPPORT_FAN_MINIMUM_PWM_RETRIEVE |
-					    OD_OPS_SUPPORT_FAN_MINIMUM_PWM_SET;
+					    OD_OPS_SUPPORT_FAN_MINIMUM_PWM_SET |
+					    OD_OPS_SUPPORT_FAN_ZERO_RPM_ENABLE_RETRIEVE |
+					    OD_OPS_SUPPORT_FAN_ZERO_RPM_ENABLE_SET;
 }
 
 static int smu_v14_0_2_get_overdrive_table(struct smu_context *smu,
@@ -2349,6 +2374,8 @@ static int smu_v14_0_2_set_default_od_settings(struct smu_context *smu)
 			user_od_table_bak.OverDriveTable.FanTargetTemperature;
 		user_od_table->OverDriveTable.FanMinimumPwm =
 			user_od_table_bak.OverDriveTable.FanMinimumPwm;
+		user_od_table->OverDriveTable.FanZeroRpmEnable =
+			user_od_table_bak.OverDriveTable.FanZeroRpmEnable;
 	}
 
 	smu_v14_0_2_set_supported_od_feature_mask(smu);
@@ -2396,6 +2423,11 @@ static int smu_v14_0_2_od_restore_table_single(struct smu_context *smu, long inp
 		od_table->OverDriveTable.FanMode = FAN_MODE_AUTO;
 		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_FAN_CURVE_BIT);
 		break;
+	case PP_OD_EDIT_FAN_ZERO_RPM_ENABLE:
+		od_table->OverDriveTable.FanZeroRpmEnable =
+					boot_overdrive_table->OverDriveTable.FanZeroRpmEnable;
+		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_ZERO_FAN_BIT);
+		break;
 	case PP_OD_EDIT_ACOUSTIC_LIMIT:
 		od_table->OverDriveTable.AcousticLimitRpmThreshold =
 					boot_overdrive_table->OverDriveTable.AcousticLimitRpmThreshold;
@@ -2678,6 +2710,27 @@ static int smu_v14_0_2_od_edit_dpm_table(struct smu_context *smu,
 		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_FAN_CURVE_BIT);
 		break;
 
+	case PP_OD_EDIT_FAN_ZERO_RPM_ENABLE:
+		if (!smu_v14_0_2_is_od_feature_supported(smu, PP_OD_FEATURE_ZERO_FAN_BIT)) {
+			dev_warn(adev->dev, "Zero RPM setting not supported!\n");
+			return -ENOTSUPP;
+		}
+
+		smu_v14_0_2_get_od_setting_limits(smu,
+						  PP_OD_FEATURE_FAN_ZERO_RPM_ENABLE,
+						  &minimum,
+						  &maximum);
+		if (input[0] < minimum ||
+		    input[0] > maximum) {
+			dev_info(adev->dev, "zero RPM enable setting(%ld) must be within [%d, %d]!\n",
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
 			ret = smu_v14_0_2_od_restore_table_single(smu, input[0]);

base-commit: 7547510d4a915f4f6d9b1262182d8db6763508f4
-- 
2.49.0

