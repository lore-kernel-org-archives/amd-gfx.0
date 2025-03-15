Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D7FBC35FFB
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Mar 2025 10:53:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53F7C10E3EB;
	Mon, 17 Mar 2025 10:53:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ByEMsZLn";
	dkim-atps=neutral
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com
 [209.85.218.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DFD510E291
 for <amd-gfx@lists.freedesktop.org>; Sat, 15 Mar 2025 20:16:06 +0000 (UTC)
Received: by mail-ej1-f50.google.com with SMTP id
 a640c23a62f3a-ac3123c0ef9so40370566b.2
 for <amd-gfx@lists.freedesktop.org>; Sat, 15 Mar 2025 13:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742069765; x=1742674565; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CM8iKDl/0GDYbg2/8UjmQb+Vutt2B5xcuVwMZo2f/xc=;
 b=ByEMsZLnw57GE4pX5BVbFLvNZW8kYt2JBwXPN3h+zp4dRTuowJkUkL5T7zK4E375oj
 zHpgO5HPmpTAMUYFaX3CIeMwIiAu2G8wr3qAgirirb7qYOdDAXGwgGc+2ljx9pW09dyI
 Pp1lsQfM6jRH1vY0aqmk/3TD7LAMAmrZme6ea3u49FZsoBEn9sJGMcKERcMNMZn2+Htq
 tH60tVOTPhfoy82kpf4j9QYBdsaBW3s/JdR0zHixbWVgadYDRqAqi5xkq/djviDmBgSF
 a7nQRt0tFt1KbwJhInWwFdMNfhFnqNstz1pVbM7GQZagcY0iYKdUp5C+Kkn78rub4F4e
 hsTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742069765; x=1742674565;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CM8iKDl/0GDYbg2/8UjmQb+Vutt2B5xcuVwMZo2f/xc=;
 b=HyusQUdoh8dOz+NsA3BlbsonY2q07jr1RANc3kNPEkQmztabVlGFWk5jKQ833npXYO
 ToKl04cMT0QTsqiLEoaLAwzoNRkOWtXD7E5DCyVBF9wYr3s5cOBmLBlVPS9c1iigy8+X
 qauHZlTXJfbTk/5jp6lsKX4N9uLiszSwBSOPnInfKmNdwwWPVgpJe6ICzfiPjbLnRfCR
 7fC2vgZ4+lKqEgmmsPPbMxZlvje6jAe9SJZvZUalZhC0dkP9TELYOiS+Op1LXn0l4xyc
 SOD4ymgOm0vDVH/FwlmQPEkYGqUUNCmF6BDxyBDW/ShNERPtJC5SwXEwAQ95QeeXFGlg
 6RyA==
X-Gm-Message-State: AOJu0Yz9jT6N+akP6DPWPyAxRgwBd5+1HpCwSIxQcZqPqvlrdW43DlIz
 fohF+Ww3BQLoWnzybtKmEs1ZJkjjfWDXSt7oIh0hYBWmHOnc+PnY
X-Gm-Gg: ASbGncvXcdDCre88ojrMkltOMY5PHe/MsQwrYj1KhUff3JsPazATDG2XUMGuq1EKZT+
 bLh5CSAEFKtf2YaabX0TcabwPO19gklgVfUL4Ne2w+Z//u6CGKL0yvd2WCKsltRkpxEW/UU2eXg
 y2tP6csHQxJAhaOQexWheaLUdtrruabURwgg7hFQIMNi4BQzMv8C33GEQpWO3Y/IIwaD7OXIeaB
 c/7wBBU6inBpXBzkV7QPR+/jUgo9XlbuYWeMhuZdJwxo8mTNQYpaLM6DMphe7lcH9Ym7NSd7lyx
 WvYSn6dwXBy1sgjhXqnBZVGnpoJHchdtnHbQZzwH87yP7P23vWcTNBWopAWWdBEDdDifP6FeKlM
 rjrGlSGhfJcBoRh8=
X-Google-Smtp-Source: AGHT+IHPCGeO5GkCGw8ZKVf/5XyOELv5ihjS4Cm7AlLHIHFCvIJzRSq2xpzHNkOcJoucsmnxMhaa6A==
X-Received: by 2002:a17:907:1c89:b0:ac2:1d34:44ff with SMTP id
 a640c23a62f3a-ac3301a4ee8mr294587766b.4.1742069764604; 
 Sat, 15 Mar 2025 13:16:04 -0700 (PDT)
Received: from laptok.lan (89-64-31-121.dynamic.chello.pl. [89.64.31.121])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac314aa5a7csm416922766b.179.2025.03.15.13.16.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Mar 2025 13:16:03 -0700 (PDT)
From: =?UTF-8?q?Tomasz=20Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: alexander.deucher@amd.com,
	kenneth.feng@amd.com,
	KevinYang.Wang@amd.com
Cc: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amd/pm: add zero RPM stop temp OD setting support for
 SMU 14.0.2
Date: Sat, 15 Mar 2025 21:15:58 +0100
Message-ID: <20250315201558.339913-3-tomasz.pakula.oficjalny@gmail.com>
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

Hook up zero RPM stop temperature for 9070 and 9070 XT based on RDNA3
(smu 13.0.0 and 13.0.7) code.

Signed-off-by: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>
---
 .../swsmu/inc/pmfw_if/smu14_driver_if_v14_0.h |  3 +-
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  | 50 ++++++++++++++++++-
 2 files changed, 51 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu14_driver_if_v14_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu14_driver_if_v14_0.h
index c2fd0a4a13e5..a5eba7b91e2f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu14_driver_if_v14_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu14_driver_if_v14_0.h
@@ -846,9 +846,10 @@ typedef struct {
   uint16_t               FanTargetTemperature; // Degree Celcius
   //zero fan
   uint8_t                FanZeroRpmEnable;
+  uint8_t                FanZeroRpmStopTemp;
   //temperature
   uint8_t                MaxOpTemp;
-  uint8_t                Padding1[2];
+  uint8_t                Padding1;
 
   //Full Ctrl
   uint16_t               GfxVoltageFullCtrlMode;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index fedf0c8c4741..4e7eed0cc41c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -80,6 +80,7 @@
 #define PP_OD_FEATURE_FAN_TARGET_TEMPERATURE		9
 #define PP_OD_FEATURE_FAN_MINIMUM_PWM			10
 #define PP_OD_FEATURE_FAN_ZERO_RPM_ENABLE		11
+#define PP_OD_FEATURE_FAN_ZERO_RPM_STOP_TEMP		12
 
 static struct cmn2asic_msg_mapping smu_v14_0_2_message_map[SMU_MSG_MAX_COUNT] = {
 	MSG_MAP(TestMessage,			PPSMC_MSG_TestMessage,                 1),
@@ -1057,6 +1058,10 @@ static void smu_v14_0_2_get_od_setting_limits(struct smu_context *smu,
 		od_min_setting = overdrive_lowerlimits->FanZeroRpmEnable;
 		od_max_setting = overdrive_upperlimits->FanZeroRpmEnable;
 		break;
+	case PP_OD_FEATURE_FAN_ZERO_RPM_STOP_TEMP:
+		od_min_setting = overdrive_lowerlimits->FanZeroRpmStopTemp;
+		od_max_setting = overdrive_upperlimits->FanZeroRpmStopTemp;
+		break;
 	default:
 		od_min_setting = od_max_setting = INT_MAX;
 		break;
@@ -1360,6 +1365,24 @@ static int smu_v14_0_2_print_clk_levels(struct smu_context *smu,
 				      min_value, max_value);
 		break;
 
+	case SMU_OD_FAN_ZERO_RPM_STOP_TEMP:
+		if (!smu_v14_0_2_is_od_feature_supported(smu,
+							 PP_OD_FEATURE_ZERO_FAN_BIT))
+			break;
+
+		size += sysfs_emit_at(buf, size, "FAN_ZERO_RPM_STOP_TEMPERATURE:\n");
+		size += sysfs_emit_at(buf, size, "%d\n",
+					(int)od_table->OverDriveTable.FanZeroRpmStopTemp);
+
+		size += sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
+		smu_v14_0_2_get_od_setting_limits(smu,
+						  PP_OD_FEATURE_FAN_ZERO_RPM_STOP_TEMP,
+						  &min_value,
+						  &max_value);
+		size += sysfs_emit_at(buf, size, "ZERO_RPM_STOP_TEMPERATURE: %u %u\n",
+				      min_value, max_value);
+		break;
+
 	case SMU_OD_RANGE:
 		if (!smu_v14_0_2_is_od_feature_supported(smu, PP_OD_FEATURE_GFXCLK_BIT) &&
 		    !smu_v14_0_2_is_od_feature_supported(smu, PP_OD_FEATURE_UCLK_BIT) &&
@@ -2306,7 +2329,9 @@ static void smu_v14_0_2_set_supported_od_feature_mask(struct smu_context *smu)
 					    OD_OPS_SUPPORT_FAN_MINIMUM_PWM_RETRIEVE |
 					    OD_OPS_SUPPORT_FAN_MINIMUM_PWM_SET |
 					    OD_OPS_SUPPORT_FAN_ZERO_RPM_ENABLE_RETRIEVE |
-					    OD_OPS_SUPPORT_FAN_ZERO_RPM_ENABLE_SET;
+					    OD_OPS_SUPPORT_FAN_ZERO_RPM_ENABLE_SET |
+					    OD_OPS_SUPPORT_FAN_ZERO_RPM_STOP_TEMP_RETRIEVE |
+					    OD_OPS_SUPPORT_FAN_ZERO_RPM_STOP_TEMP_SET;
 }
 
 static int smu_v14_0_2_get_overdrive_table(struct smu_context *smu,
@@ -2387,6 +2412,8 @@ static int smu_v14_0_2_set_default_od_settings(struct smu_context *smu)
 			user_od_table_bak.OverDriveTable.FanMinimumPwm;
 		user_od_table->OverDriveTable.FanZeroRpmEnable =
 			user_od_table_bak.OverDriveTable.FanZeroRpmEnable;
+		user_od_table->OverDriveTable.FanZeroRpmStopTemp =
+			user_od_table_bak.OverDriveTable.FanZeroRpmStopTemp;
 	}
 
 	smu_v14_0_2_set_supported_od_feature_mask(smu);
@@ -2754,6 +2781,27 @@ static int smu_v14_0_2_od_edit_dpm_table(struct smu_context *smu,
 		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_ZERO_FAN_BIT);
 		break;
 
+	case PP_OD_EDIT_FAN_ZERO_RPM_STOP_TEMP:
+		if (!smu_v14_0_2_is_od_feature_supported(smu, PP_OD_FEATURE_ZERO_FAN_BIT)) {
+			dev_warn(adev->dev, "Zero RPM setting not supported!\n");
+			return -ENOTSUPP;
+		}
+
+		smu_v14_0_2_get_od_setting_limits(smu,
+						  PP_OD_FEATURE_FAN_ZERO_RPM_STOP_TEMP,
+						  &minimum,
+						  &maximum);
+		if (input[0] < minimum ||
+		    input[0] > maximum) {
+			dev_info(adev->dev, "zero RPM stop temperature setting(%ld) must be within [%d, %d]!\n",
+				 input[0], minimum, maximum);
+			return -EINVAL;
+		}
+
+		od_table->OverDriveTable.FanZeroRpmStopTemp = input[0];
+		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_ZERO_FAN_BIT);
+		break;
+
 	case PP_OD_RESTORE_DEFAULT_TABLE:
 		if (size == 1) {
 			ret = smu_v14_0_2_od_restore_table_single(smu, input[0]);
-- 
2.48.1

