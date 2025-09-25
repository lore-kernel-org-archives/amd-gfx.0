Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71F38CAC5B9
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Sep 2025 18:45:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 139FB10E2D1;
	Thu, 25 Sep 2025 18:45:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MkT1Io5y";
	dkim-atps=neutral
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com
 [209.85.210.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DE8910E2D1
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Sep 2025 18:45:50 +0000 (UTC)
Received: by mail-pf1-f171.google.com with SMTP id
 d2e1a72fcca58-780f6632e64so733041b3a.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Sep 2025 11:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758825950; x=1759430750; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ln6GmNWJNf/t9NU3XteHX7auEceHRj29achGjAmDW5I=;
 b=MkT1Io5yCWB5G4lm1usuTPYDQRgeLg9OWzRmehyr/sClS3XZeRfRZMYPK0QxnSqtGL
 0PJu7t17A6YXZqSwsSjPGWbSaR/tMpxresFAtQgAd7/07X8+qVs/eCgxuo7QW3B6G0gU
 ZJ3FzPHfybqM4cBwzNmb36wmX1uI2Zb4/0rl8e6YAVRNSzXuLenJnrqcPb7XQi8yfMaA
 AYsXhUteiOq7KV68Pa3Nn/M3IEv6TvpGkSNa17m85tjF8gWjZq8uVp/NVrm3jyHmoA7s
 anAl1I6cR16gT5ptwiKotPsiM2yUv2nIzIBhRlcMmqO4gkIPXYubLppo/0CeYUYE1p8G
 79bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758825950; x=1759430750;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ln6GmNWJNf/t9NU3XteHX7auEceHRj29achGjAmDW5I=;
 b=tcTQV68Oq3GHMu9kAYgyVhQrAjyvIfijw7/Q5urhf64smC2OVb/lmNyzvLVritt7Lc
 ujrznHQ/XayLJrd/4vOig93qO44X8e8vIlefkwehD9ZbkTivjgyaOgahB7a2WU4ZCABc
 am30DM0yQgKnJF9+X3EOzYUduGA7iXN1nbkIm1qaNJR7jLdCKfGWS+N1F6qPRSt5qkah
 3HAHucBCphNv0OSkjoVtdc+2V/BxH5r04+v8wmOX6/+0hA0YmXTkU59FaACsRDjE4u+j
 XhjBr1pay3nWND5ULr2KIAK4iQtwVkhje5wEMSuEN3CbFfMRSPV4/AtKnvho44ApwEpQ
 1GJQ==
X-Gm-Message-State: AOJu0YxwtCyg/IvwFAD6PZDiSCPCnkSUt0bpk2xxKkVukBzrtR6cOeYm
 JHItUoSoiWksYDI84P8YIkMZqMk+k8qV5sjzJhlgTU0pV+WZS+sLBDM60LOaxw==
X-Gm-Gg: ASbGncsU7x0N4UNtTfis6yyM8nQ/hu2yOXZ/d3SjHGAZjCUL4qVprTY7RumxZ91FlxY
 PVKuh8SV0cwWIqgZfDLx0WFf9qO+Fx9wmYj36QQNDoFuKmUQZqDxYJUmH9upfY+I3GTkOU48KgW
 JFiLpVBNT+1R+sKwlMjJS6ZOCgajSOJRRtkcFE53HnI5e5PU6kXu1JHDa7MLOY05t2jOgCBHhgL
 WCIeqSrs6F5YYeXpeA9jUfIx6xyamIohSgldfy0sXpThDyufZAGL31/9oc6DRAhKIFf9hgmiAp1
 GH3GzRaLeEwHOTMznmtoYP24n+pJ/N3McHR69eGkhxSIPZMGKYhBuTPR5b+m27AzjFmVtYaUmB1
 6kNF1aH1EtX1GpnjM86Fk4ucJ77HUMO0SO9VKxRQIm2ULuSTaaDBY0IiJuD/WtNSsqj+fX2Y43L
 OERRwOdhKLbZn24qn4BqDzOoYSxqcRSC/hxQ+R
X-Google-Smtp-Source: AGHT+IE5Y5+7I4EReAl8RNEwYwQPC+mh7w0KlSzSl2DRovMULw/BYMlntdCNgHXcz5R6U7YxMublSw==
X-Received: by 2002:a17:903:3d0d:b0:25f:9682:74ae with SMTP id
 d9443c01a7336-27ed4a91efbmr47743035ad.29.1758825949422; 
 Thu, 25 Sep 2025 11:45:49 -0700 (PDT)
Received: from Timur-Hyperion.home
 (20014C4E24D06700C9F588200B1ECEA8.dsl.pool.telekom.hu.
 [2001:4c4e:24d0:6700:c9f5:8820:b1e:cea8])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-27eeb9a8ebfsm4244125ad.67.2025.09.25.11.45.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Sep 2025 11:45:49 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, alex.hung@amd.com, harry.wentland@amd.com,
 siqueira@igalia.com,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 3/5] drm/amd/display: Properly clear SCL_*_FILTER_CONTROL on
 DCE6
Date: Thu, 25 Sep 2025 20:45:23 +0200
Message-ID: <20250925184525.43290-4-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250925184525.43290-1-timur.kristof@gmail.com>
References: <20250925184525.43290-1-timur.kristof@gmail.com>
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

Previously, the code would set a bit field which didn't exist
on DCE6 so it would be effectively a no-op.

Fixes: b70aaf5586f2 ("drm/amd/display: dce_transform: add DCE6 specific macros,functions")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_transform.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c b/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c
index 2b1673d69ea8..e5c2fb134d14 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c
@@ -527,8 +527,7 @@ static void dce60_transform_set_scaler(
 		if (coeffs_v != xfm_dce->filter_v || coeffs_h != xfm_dce->filter_h) {
 			/* 4. Program vertical filters */
 			if (xfm_dce->filter_v == NULL)
-				REG_SET(SCL_VERT_FILTER_CONTROL, 0,
-						SCL_V_2TAP_HARDCODE_COEF_EN, 0);
+				REG_WRITE(SCL_VERT_FILTER_CONTROL, 0);
 			program_multi_taps_filter(
 					xfm_dce,
 					data->taps.v_taps,
@@ -542,8 +541,7 @@ static void dce60_transform_set_scaler(
 
 			/* 5. Program horizontal filters */
 			if (xfm_dce->filter_h == NULL)
-				REG_SET(SCL_HORZ_FILTER_CONTROL, 0,
-						SCL_H_2TAP_HARDCODE_COEF_EN, 0);
+				REG_WRITE(SCL_HORZ_FILTER_CONTROL, 0);
 			program_multi_taps_filter(
 					xfm_dce,
 					data->taps.h_taps,
-- 
2.51.0

