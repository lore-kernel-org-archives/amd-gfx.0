Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7602FCD4F54
	for <amd-gfx@archiver.kernel.org>; Wed, 27 May 2026 07:46:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8FB610E20D;
	Wed, 27 May 2026 07:46:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LrX0k0e5";
	dkim-atps=neutral
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com
 [74.125.82.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15CC010E544
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2026 21:01:04 +0000 (UTC)
Received: by mail-dy1-f179.google.com with SMTP id
 5a478bee46e88-30246cfd41aso685638eec.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2026 14:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779829263; x=1780434063; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=C2x6fxQ+tdvDCPGI0zQ3v4zt0ktfN5BxYIE2BnW2JnA=;
 b=LrX0k0e5D/So0PFaLL0O1uepznZ3hMNcm0WVEDWwhtOEsqIHVXQfeRcIA25FVMmKYN
 cwiItmQt5oOquAIKacFNtojHiDTejnat/x+OIwuv8sTpXu9ALpEKLXaNjf8qawp7+DIp
 8VZjonNG2Bh1yXqVHlEcC7gUS+xfey0FH0hVmTK3iZF2eOs+x73INouLNPZRAZulE7w+
 lDa3vMb9vzsgPto1U2z9qM9IpiHU67N1xPAA4NCBvEmPkJOhsVvsxxiE0G44/t88NYcX
 vjISUvvhObixsMqUc4Jev16Vs0UoQJVTV801GfrR8903RdAmm35laTxhmgzyG/uXPRiU
 DNRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779829263; x=1780434063;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C2x6fxQ+tdvDCPGI0zQ3v4zt0ktfN5BxYIE2BnW2JnA=;
 b=hqZ1PnVqq5hcgNbVnbL3g2SA7MR70whFCnT264C4+X+ZCkTVlJ8oDhEx+m0zgZrHBG
 36Fg12YS15SIy/zudE7qWsPrgl4fEH7mmq9tVG44gWjn7pxsJjXwFrvOsm0ac5W4tNcM
 xuLUcI7GkOMUiuzvgFvwHe9s6/Us5xMg1i7v1+5Dzk1vxNabFCq4Y2FGpQMBfpk5MPnl
 +qHw5b7ysFbQcWHbX9uSAacJ7kLD58y8M54DDfkJ+TV1ObwE8M4lfVn9BN2G7gdapclU
 nKHPqJ1tXPsqxKL9EenELtxF+7g6RkOKyvdbU6vOZCpqvSLxzfu+2FLULKjtEr90sfEz
 g/Yw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8OANtX2Vbmh4vATWllRX+ayfDvyki7oDJG4Kmwf2mUryRIqgMO5Fgi1MxIJEozgqKBQ9Ra73Kt@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzgcFX/7uvZftO/Wei10mBedPdoYcbznogbwS2Mx2++8nfBT2d0
 WodcOoktWeiy3BttoN3nu5oMsAalIYGtm4k3daWzPjBnd0t8kDJw/0BH
X-Gm-Gg: Acq92OENAXAsPrmN+shnm7wsHncDTYEfokV4dxbMP5A2geBr3aWmUNXlA8JHCav5N2K
 54T2Kyh2QHpVgPUg/QstnjF2DjJXHfx0KKRbGTG0Yxd1641BU0axNqGRWwi5UC485iI6Xr7LwA8
 e4Cr3E+M0AACvCxacMVs8bYLCBWaFYMGHMN33N+SP8sM6ajABtAaCFktAcd/ijC5/Th84OFk7ko
 +/XYOp2a/zWa6g3S6Yxy6sOsThXB0RV6gb9qEcHLiBavSv2W4F8TaLtiOUGhMjoHRsMDeYpTA94
 Wl7yqmEr6ec1+7gDJz5wWdcE3CW0KoomAv1rkvB4gCXsZc1B/n2tuIvApT7E10LzVoWyT+CmoGc
 p0jkpl/W+zrDLL/0TwINyge/+QeyGj9iPeIUfK0EiJ1p34+bhkYtE1CFglyLur4M5PAasxUsdXi
 REs/1Aki2NoQOfMdFEAPS7X47OI2EcvRKaxnHUY+K4bY7F2qY5IYA=
X-Received: by 2002:a05:7300:cd85:b0:2d9:ad46:4a92 with SMTP id
 5a478bee46e88-3044905ce1emr8171506eec.13.1779829263188; 
 Tue, 26 May 2026 14:01:03 -0700 (PDT)
Received: from localhost.localdomain ([187.17.229.0])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30451ef3273sm15404389eec.2.2026.05.26.14.00.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 14:01:02 -0700 (PDT)
From: Edson Juliano Drosdeck <edson.drosdeck@gmail.com>
To: harry.wentland@amd.com
Cc: sunpeng.li@amd.com, siqueira@igalia.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch,
 mario.limonciello@amd.com, alex.hung@amd.com, Wayne.Lin@amd.com,
 timur.kristof@gmail.com, superm1@kernel.org, aurabindo.pillai@amd.com,
 ivan.lipski@amd.com, chen-yu.chen@amd.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 edson.drosdeck@gmail.com
Subject: [PATCH] drm/amd/display: Avoid using zero AC/DC brightness levels
Date: Tue, 26 May 2026 18:00:48 -0300
Message-ID: <20260526210048.1162477-1-edson.drosdeck@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 27 May 2026 07:46:23 +0000
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

Some systems report zero AC/DC brightness levels during
backlight initialization, causing the panel brightness to
start at the minimum level on boot.

Only use the firmware brightness levels when both AC and DC
values are non-zero

Signed-off-by: Edson Juliano Drosdeck <edson.drosdeck@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 5fc5d5608506..f947ce2a8625 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5380,7 +5380,9 @@ amdgpu_dm_register_backlight_device(struct amdgpu_dm_connector *aconnector)
 	}
 
 	caps = &dm->backlight_caps[aconnector->bl_idx];
-	if (get_brightness_range(caps, &min, &max)) {
+	if (get_brightness_range(caps, &min, &max) &&
+	    caps->ac_level > 0 &&
+	    caps->dc_level > 0) {
 		if (power_supply_is_system_supplied() > 0)
 			props.brightness = DIV_ROUND_CLOSEST((max - min) * caps->ac_level, 100);
 		else
-- 
2.47.3

