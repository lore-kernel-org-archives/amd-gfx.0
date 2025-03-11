Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7291AC28B28
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Mar 2025 10:09:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F4E610E753;
	Wed, 12 Mar 2025 10:09:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nZmdyaxc";
	dkim-atps=neutral
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com
 [209.85.167.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE53D10E2B7
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Mar 2025 21:38:38 +0000 (UTC)
Received: by mail-lf1-f53.google.com with SMTP id
 2adb3069b0e04-5494fe13a6eso867251e87.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Mar 2025 14:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741729116; x=1742333916; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IMyV2yXTxsI+rGs2k9HMmgY1nvHk/Y/nZ9Y0zucHg7M=;
 b=nZmdyaxc24C99JdIwn888QF+8Xml35+q4bTOrN7rvRR7ckhve5ZW4Nt+VjpKZp+2kT
 7/CbLt4fL8OCCyF2v9+5NIjN7hkyNJOpu0a6TNVDs3Fbdulrtw4Kmk+TTUYdu1tMSC7M
 +wNf6vAKc52tlzWPt5MWN3xaXgYF4uF3LJMZe2sGtCQwgU4SGL5AxYGauDOlTjd1h0Km
 PL27X5gCRCSYgXe4DyX+q4R/K1bg6zzVUvswRPCbTAVFjOSrB7LgdZ6IMb8fmz784jh2
 IDLC7mpr2bKhNXbEoQGx2mzLFrt8aCpVEVTSqgd19DhgPYmmtyyVm15ZTNfPPIpxT8XJ
 kX0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741729116; x=1742333916;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IMyV2yXTxsI+rGs2k9HMmgY1nvHk/Y/nZ9Y0zucHg7M=;
 b=oYHYCmuG24bSnU8Q4ZBJ2+HlVTWyB8IiDWI2JKifFR72w6UcY8/qQ+Zdz8X50u9QFK
 AcD0/i5d3m0X+wYpSlWe62GZHJifhMdgZ7OhQZfs5o1tT5PpWybbE+K+aZE5Q1jLvK1I
 oEZjpslGpo/bq1zO3xszddXl4+GT8k56pCuwHSJOetddBS69Q/ytnDZtjwor1T9E4sjs
 YkPiGCnc8yNF01q8KOn+YXPoMXPmnV2oOg/fFobPYMKGikKIJv1C85hPbQCzwfVDqrPw
 YIzpIm2aUwuhGUlftvcYtcWnfRH+FkSkQk1xWvDBuRvgyIP3mh8+m/N3kV7CrqE92M5U
 iZ/Q==
X-Gm-Message-State: AOJu0YwO2TdTOfW/KnwJF1Z2o0g2xydgVRTK/FBy20YBwLYypn6jz6gG
 jPJoISdmrZUMFSHZ4W4zKbBVHMfFglFYuBHdyxqW4xZy+2sKSxG0eQ5Xi8eJ
X-Gm-Gg: ASbGncsE+GW8fpmHK6vjDET3UZ3FTTzI9XdPE1c3VJoQ0uvX3m6iTPKhweSTB7LUEXs
 b2l2GlA9LNQueEdA0naZWGtfoQd8pyIzopxk+qNXZSz4dHbylDnaCcwnpEkyU/3MC0yS7GKii7b
 ae7jg0S5xtJGj587biNeSR0YGauPH/4nQicxaAy3CbQ0rbyFxYzL2S+4E552UeM6S8Zk6QMtxSU
 0FRrsTTZV4fBTE3QVe0anZIIT2zJF7GFNLWAoIZ2mIecxmRdMqyajqRRmzUuw0o7Z7awSI1WeMt
 Yja9iNlRW78zFSZIZplZ30J76PVwte1/TecdZsnX+y5tM3KZ23NEfQwat1gMEJFqUiuBWjLB3HF
 mLl/9j5hjNQN8E+k=
X-Google-Smtp-Source: AGHT+IFZuC8bTyJAg5AQp4URZ4OlGll75AC5Lv88p8HcFZmgrgkgo5iBklVc1oeK+qBEYOU5bYkbcQ==
X-Received: by 2002:a05:651c:543:b0:308:e803:119b with SMTP id
 38308e7fff4ca-30c2067cbecmr8432421fa.1.1741729116025; 
 Tue, 11 Mar 2025 14:38:36 -0700 (PDT)
Received: from laptok.lan (89-64-31-140.dynamic.chello.pl. [89.64.31.140])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-30bef40f9cdsm20644711fa.48.2025.03.11.14.38.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 14:38:35 -0700 (PDT)
From: =?UTF-8?q?Tomasz=20Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
Subject: [PATCH] drm/amdgpu/pm: Handle SCLK offset correctly in overdrive for
 smu 14.0.2
Date: Tue, 11 Mar 2025 22:38:33 +0100
Message-ID: <20250311213833.870840-1-tomasz.pakula.oficjalny@gmail.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 12 Mar 2025 10:09:06 +0000
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

Currently, it seems like the code was carried over from RDNA3 because
it assumes two possible values to set. RDNA4, instead of having:
0: min SCLK
1: max SCLK
only has
0: SCLK offset

This change makes it so it only reports current offset value instead of
showing possible min/max values and their indices. Moreover, it now only
accepts the offset as a value, without the indice index.

Additionally, the lower bound was printed as %u by mistake.

Old:
OD_SCLK_OFFSET:
0: -500Mhz
1: 1000Mhz
OD_MCLK:
0: 97Mhz
1: 1259MHz
OD_VDDGFX_OFFSET:
0mV
OD_RANGE:
SCLK_OFFSET:    -500Mhz       1000Mhz
MCLK:      97Mhz       1500Mhz
VDDGFX_OFFSET:    -200mv          0mv

New:
OD_SCLK_OFFSET:
0Mhz
OD_MCLK:
0: 97Mhz
1: 1259MHz
OD_VDDGFX_OFFSET:
0mV
OD_RANGE:
SCLK_OFFSET:    -500Mhz       1000Mhz
MCLK:      97Mhz       1500Mhz
VDDGFX_OFFSET:    -200mv          0mv

Setting this offset:
Old: "s 1 <offset>"
New: "s <offset>"

Signed-off-by: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>
---
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  | 59 ++++++-------------
 1 file changed, 18 insertions(+), 41 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index 5cad09c5f2ff..62bd9647541a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -1193,16 +1193,9 @@ static int smu_v14_0_2_print_clk_levels(struct smu_context *smu,
 							 PP_OD_FEATURE_GFXCLK_BIT))
 			break;
 
-		PPTable_t *pptable = smu->smu_table.driver_pptable;
-		const OverDriveLimits_t * const overdrive_upperlimits =
-					&pptable->SkuTable.OverDriveLimitsBasicMax;
-		const OverDriveLimits_t * const overdrive_lowerlimits =
-					&pptable->SkuTable.OverDriveLimitsBasicMin;
-
 		size += sysfs_emit_at(buf, size, "OD_SCLK_OFFSET:\n");
-		size += sysfs_emit_at(buf, size, "0: %dMhz\n1: %uMhz\n",
-					overdrive_lowerlimits->GfxclkFoffset,
-					overdrive_upperlimits->GfxclkFoffset);
+		size += sysfs_emit_at(buf, size, "%dMhz\n",
+					od_table->OverDriveTable.GfxclkFoffset);
 		break;
 
 	case SMU_OD_MCLK:
@@ -1336,13 +1329,9 @@ static int smu_v14_0_2_print_clk_levels(struct smu_context *smu,
 		size += sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
 
 		if (smu_v14_0_2_is_od_feature_supported(smu, PP_OD_FEATURE_GFXCLK_BIT)) {
-			smu_v14_0_2_get_od_setting_limits(smu,
-							  PP_OD_FEATURE_GFXCLK_FMIN,
-							  &min_value,
-							  NULL);
 			smu_v14_0_2_get_od_setting_limits(smu,
 							  PP_OD_FEATURE_GFXCLK_FMAX,
-							  NULL,
+							  &min_value,
 							  &max_value);
 			size += sysfs_emit_at(buf, size, "SCLK_OFFSET: %7dMhz %10uMhz\n",
 					      min_value, max_value);
@@ -2417,36 +2406,24 @@ static int smu_v14_0_2_od_edit_dpm_table(struct smu_context *smu,
 			return -ENOTSUPP;
 		}
 
-		for (i = 0; i < size; i += 2) {
-			if (i + 2 > size) {
-				dev_info(adev->dev, "invalid number of input parameters %d\n", size);
-				return -EINVAL;
-			}
-
-			switch (input[i]) {
-			case 1:
-				smu_v14_0_2_get_od_setting_limits(smu,
-								  PP_OD_FEATURE_GFXCLK_FMAX,
-								  &minimum,
-								  &maximum);
-				if (input[i + 1] < minimum ||
-				    input[i + 1] > maximum) {
-					dev_info(adev->dev, "GfxclkFmax (%ld) must be within [%u, %u]!\n",
-						input[i + 1], minimum, maximum);
-					return -EINVAL;
-				}
-
-				od_table->OverDriveTable.GfxclkFoffset = input[i + 1];
-				od_table->OverDriveTable.FeatureCtrlMask |= 1U << PP_OD_FEATURE_GFXCLK_BIT;
-				break;
+		if (size != 1) {
+			dev_info(adev->dev, "invalid number of input parameters %d\n", size);
+			return -EINVAL;
+		}
 
-			default:
-				dev_info(adev->dev, "Invalid SCLK_VDDC_TABLE index: %ld\n", input[i]);
-				dev_info(adev->dev, "Supported indices: [0:min,1:max]\n");
-				return -EINVAL;
-			}
+		smu_v14_0_2_get_od_setting_limits(smu,
+						  PP_OD_FEATURE_GFXCLK_FMAX,
+						  &minimum,
+						  &maximum);
+		if (input[0] < minimum ||
+		    input[0] > maximum) {
+			dev_info(adev->dev, "GfxclkFoffset must be within [%d, %u]!\n",
+				 minimum, maximum);
+			return -EINVAL;
 		}
 
+		od_table->OverDriveTable.GfxclkFoffset = input[0];
+		od_table->OverDriveTable.FeatureCtrlMask |= 1U << PP_OD_FEATURE_GFXCLK_BIT;
 		break;
 
 	case PP_OD_EDIT_MCLK_VDDC_TABLE:
-- 
2.48.1

