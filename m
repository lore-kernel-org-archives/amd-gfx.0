Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 906B5C3DA4A
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Mar 2025 10:53:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38A7810E3E1;
	Mon, 17 Mar 2025 10:53:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="W6qcpVkQ";
	dkim-atps=neutral
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com
 [209.85.208.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA71E10E291
 for <amd-gfx@lists.freedesktop.org>; Sat, 15 Mar 2025 20:16:04 +0000 (UTC)
Received: by mail-ed1-f48.google.com with SMTP id
 4fb4d7f45d1cf-5dbe706f94fso621213a12.2
 for <amd-gfx@lists.freedesktop.org>; Sat, 15 Mar 2025 13:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742069763; x=1742674563; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DQbs55148QdS4RAoyP0E2UQn6gpvgVBPMPfAuPEPEck=;
 b=W6qcpVkQeBGud1GazHPW6qFao0xwfT80aeY6CVIFQeRjwSmAzbGhaBgi2lpMaq1RMs
 Akwo1LeQe0jd0ovdiFj7c36TZ2AiltE4QKBvc7Al4OqCNrRgWf71xRd+KdZfInMlvgIW
 shVOU3+vmqzivMSyleCMwSD1TiVjTRAzRcIcFLoSKcSBRdxx/1t+OS8Cv5J974akougK
 prAWWFRTFRaY2Y597PZg3xXUJmIbJWbG/fW1iKnwj2K+9Rr7nGtCUZaSmv4Ixm1ItMOa
 P3FwLEEHbedp/vfOeO2UTUZ2xhIiQQwsRAW19iPjBidknwpbXRv7CmVyVtVAYqKcBAHh
 3LFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742069763; x=1742674563;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DQbs55148QdS4RAoyP0E2UQn6gpvgVBPMPfAuPEPEck=;
 b=JKehCFTE+2SnV6hVZJ+RXgZDDMkwpCywvPYzLY/R1EpQVw+HSmHXUUEc+DUBxESMp1
 YmgJY++Ojj24pAh+G3iQdOuvMSlrsLZdeiSAqS8TEJYnNSs5fnuZngkz64Z/sMLmVHTO
 tszk/ZW0mPLZtuiPHzIzsgIB2OuvatCFNMXZkYu4THhM5zjrgUvmhXpDLE5yozoX9r1o
 V1I71ee53uuA9CBPQm71QxZBG+ooyDgx48nC+pOAU30dnWxoOCNdFMpRwISp88dJPcD7
 VZGrqYzwAZvlDvOOVCjICcNY1BRKuGDmbwCoaddJjqZbyTTIaj8h/URbJu1afDSIgif+
 SRjQ==
X-Gm-Message-State: AOJu0YzgHkWxZAgk9VEW4zafLznjdaVyZvkbqVESbQZ/yCokUUbI6WDE
 i2eGAhRqGssi3qi4o3vlpbDKEDzlVbRoXHe4Lt/s6EnWJyElFq+P
X-Gm-Gg: ASbGncuzQyeLvUv2nhlUBVKbB9Zfb3f71zXh3MfoAVHvhRJucPokk0z1QFx+DDuB8ZQ
 D7m2UxvTA3heSS4kwZGU667NZtJ30Qk+epljEIQlxtzE5gPaptkv9b63U3aabHHYASSfkTxvcgb
 /dSIs1XtwucJQ0LUFPQYPsLby1+XRV29Y8TWLjO9MzXS+y0Ew4bwZ3eF1Z6gxYh0hTt7sAtbAaF
 5U9L6JNOkNFjE4jpG1Tbw6uX1xxpEti8EH+AW3MSL2IJ9BwytGpfAIuXspwefZI6vsg0OOE3oqt
 aO+1DTyqwC0h4PkFZV8RSeBdpfAusSFMLjd+rxySwlwi+gjHoi0VELGf/HKJh/YbAjOAjYPI012
 7MGUc029EkcaEKzE=
X-Google-Smtp-Source: AGHT+IHxRow/9QpNn+nOSgljIbiRhU7oNeWS0r8k/yGH5SFNENw6SOT3uzfI1FpRDWXTE/ZmmcNegw==
X-Received: by 2002:a17:907:9813:b0:abf:6c88:df53 with SMTP id
 a640c23a62f3a-ac330274090mr305284466b.4.1742069763029; 
 Sat, 15 Mar 2025 13:16:03 -0700 (PDT)
Received: from laptok.lan (89-64-31-121.dynamic.chello.pl. [89.64.31.121])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac314aa5a7csm416922766b.179.2025.03.15.13.16.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Mar 2025 13:16:02 -0700 (PDT)
From: =?UTF-8?q?Tomasz=20Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: alexander.deucher@amd.com,
	kenneth.feng@amd.com,
	KevinYang.Wang@amd.com
Cc: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amd/pm: add zero RPM OD setting support for SMU 14.0.2
Date: Sat, 15 Mar 2025 21:15:57 +0100
Message-ID: <20250315201558.339913-2-tomasz.pakula.oficjalny@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250315201558.339913-1-tomasz.pakula.oficjalny@gmail.com>
References: <20250315201558.339913-1-tomasz.pakula.oficjalny@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 17 Mar 2025 10:53:32 +0000
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

Signed-off-by: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>
---
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  | 55 ++++++++++++++++++-
 1 file changed, 54 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index 21d1b34ada05..fedf0c8c4741 100644
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
@@ -1337,6 +1342,24 @@ static int smu_v14_0_2_print_clk_levels(struct smu_context *smu,
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
@@ -2281,7 +2304,9 @@ static void smu_v14_0_2_set_supported_od_feature_mask(struct smu_context *smu)
 					    OD_OPS_SUPPORT_FAN_TARGET_TEMPERATURE_RETRIEVE |
 					    OD_OPS_SUPPORT_FAN_TARGET_TEMPERATURE_SET |
 					    OD_OPS_SUPPORT_FAN_MINIMUM_PWM_RETRIEVE |
-					    OD_OPS_SUPPORT_FAN_MINIMUM_PWM_SET;
+					    OD_OPS_SUPPORT_FAN_MINIMUM_PWM_SET |
+					    OD_OPS_SUPPORT_FAN_ZERO_RPM_ENABLE_RETRIEVE |
+					    OD_OPS_SUPPORT_FAN_ZERO_RPM_ENABLE_SET;
 }
 
 static int smu_v14_0_2_get_overdrive_table(struct smu_context *smu,
@@ -2360,6 +2385,8 @@ static int smu_v14_0_2_set_default_od_settings(struct smu_context *smu)
 			user_od_table_bak.OverDriveTable.FanTargetTemperature;
 		user_od_table->OverDriveTable.FanMinimumPwm =
 			user_od_table_bak.OverDriveTable.FanMinimumPwm;
+		user_od_table->OverDriveTable.FanZeroRpmEnable =
+			user_od_table_bak.OverDriveTable.FanZeroRpmEnable;
 	}
 
 	smu_v14_0_2_set_supported_od_feature_mask(smu);
@@ -2407,6 +2434,11 @@ static int smu_v14_0_2_od_restore_table_single(struct smu_context *smu, long inp
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
@@ -2701,6 +2733,27 @@ static int smu_v14_0_2_od_edit_dpm_table(struct smu_context *smu,
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
-- 
2.48.1

