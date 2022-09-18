Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77EE4C32771
	for <amd-gfx@archiver.kernel.org>; Sun, 18 Sep 2022 07:26:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5930210E4FC;
	Sun, 18 Sep 2022 07:26:41 +0000 (UTC)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D23C10E4FB
 for <amd-gfx@lists.freedesktop.org>; Sun, 18 Sep 2022 07:26:37 +0000 (UTC)
Received: by mail-pf1-x42d.google.com with SMTP id b75so19970771pfb.7
 for <amd-gfx@lists.freedesktop.org>; Sun, 18 Sep 2022 00:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date;
 bh=C8vsUa5TU95rsgUcJUkozqAPbFUmOUW9tjNdpADjyrs=;
 b=cEQ1vuj6zPBknfy4Xr5cPJ+H9e7UH8A1lpIxdpcpUlh0+6x5BGpwQQjXywdV0sjzcN
 ec4a0YeUgpIb7eb0aO7SuiPzGXzGk1o7iKU6DLx86nYaFL+F+KYSVvwEKyVspSzlVhjP
 9r4Q5Q8JvIBzOTcIEu6hp+ynLwM8WizN9HvWkuTVF4hx2il5cDqeKAmfwM6yR2YyIw4u
 Lz/jJ3hX9kJM4n+mrUDfaqUDfVRm2gw1W8Hrl3xq3aZfSmMzWWGDB0iNwv0zNVgIDL3u
 MnlHGfjBoN/Y5235nBQ1Ame0r8RdoHsxliQtGpf5ECLYH6NhxgYNzk7Eec/42frbNBZF
 MeFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date;
 bh=C8vsUa5TU95rsgUcJUkozqAPbFUmOUW9tjNdpADjyrs=;
 b=x8rIhDl7BfaEJ0tzH7iyYVItiJH2Ad1VW3IFEKPAzfaxMath2Sl52kgOlEZcf+2IGY
 fcjqqnKdDO3tIRxWAwGbygQykV4PU9NA7+yWtlVK5aWyRg/N1eHSh45nxuzKmbmlmmfY
 qb13acwPMPMuPKqNvEE4ZFR7JOquMxRNigEpSIYHgOgKJe7fJ9NXzGVrObjh9Hm7kNug
 5cPx5BAU5wgF+yQFUrybrXwEeLK7+VG5XUvnphvZl3BFwsmMyhtaaQ8sGif54QbX29QR
 UONFr/994WUxGlbDRiTPEbWuFaFHvit/nOLDKQjE3dTtMSSQYisFUsqo+ub6Pozmv01F
 QweA==
X-Gm-Message-State: ACrzQf1ASBZiqGKOeAa27TNDrLPXknjoz4CrhjE16vp8gfcYNs09aGuE
 mesooA2XwXtuVhjofSjJGry/i6TXDS0=
X-Google-Smtp-Source: AMsMyM6Upq4W3M0XP/mOUv42MbJbFokt2lgz6Mi9obhgmluWJFongK+lROcRlkt3qDjJGXTv9CW6lg==
X-Received: by 2002:a63:e52:0:b0:438:ebec:363e with SMTP id
 18-20020a630e52000000b00438ebec363emr11137039pgo.437.1663485996416; 
 Sun, 18 Sep 2022 00:26:36 -0700 (PDT)
Received: from rainbow.com ([240d:1a:5a8:5a00:34b9:499e:1035:3657])
 by smtp.gmail.com with ESMTPSA id
 q6-20020aa79606000000b0052d432b4cc0sm17662163pfg.33.2022.09.18.00.26.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Sep 2022 00:26:34 -0700 (PDT)
From: stalkerg <stalkerg@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: getting fan speed pwm for vega10 properly
Date: Sun, 18 Sep 2022 16:23:15 +0900
Message-Id: <20220918072314.28870-1-stalkerg@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
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
Cc: alexander.deucher@amd.com, stalkerg <stalkerg@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Instead of using RPM speed, we will use a function from vega20 based on PWM registers.

Signed-off-by: Yury Zhuravlev <stalkerg@gmail.com>
---
 .../amd/pm/powerplay/hwmgr/vega10_thermal.c   | 25 +++++++++----------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c
index dad3e3741a4e..190af79f3236 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c
@@ -67,22 +67,21 @@ int vega10_fan_ctrl_get_fan_speed_info(struct pp_hwmgr *hwmgr,
 int vega10_fan_ctrl_get_fan_speed_pwm(struct pp_hwmgr *hwmgr,
 		uint32_t *speed)
 {
-	uint32_t current_rpm;
-	uint32_t percent = 0;
-
-	if (hwmgr->thermal_controller.fanInfo.bNoFan)
-		return 0;
+	struct amdgpu_device *adev = hwmgr->adev;
+	uint32_t duty100, duty;
+	uint64_t tmp64;
 
-	if (vega10_get_current_rpm(hwmgr, &current_rpm))
-		return -1;
+	duty100 = REG_GET_FIELD(RREG32_SOC15(THM, 0, mmCG_FDO_CTRL1),
+				CG_FDO_CTRL1, FMAX_DUTY100);
+	duty = REG_GET_FIELD(RREG32_SOC15(THM, 0, mmCG_THERMAL_STATUS),
+				CG_THERMAL_STATUS, FDO_PWM_DUTY);
 
-	if (hwmgr->thermal_controller.
-			advanceFanControlParameters.usMaxFanRPM != 0)
-		percent = current_rpm * 255 /
-			hwmgr->thermal_controller.
-			advanceFanControlParameters.usMaxFanRPM;
+	if (!duty100)
+		return -EINVAL;
 
-	*speed = MIN(percent, 255);
+	tmp64 = (uint64_t)duty * 255;
+	do_div(tmp64, duty100);
+	*speed = MIN((uint32_t)tmp64, 255);
 
 	return 0;
 }
-- 
2.35.1

