Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93A9AF30283
	for <amd-gfx@archiver.kernel.org>; Sun, 15 Mar 2026 22:35:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2217310E1B8;
	Sun, 15 Mar 2026 22:35:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ldKH9K/n";
	dkim-atps=neutral
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A04B710E21F
 for <amd-gfx@lists.freedesktop.org>; Sun, 15 Mar 2026 22:35:00 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-43b4121c40aso516918f8f.0
 for <amd-gfx@lists.freedesktop.org>; Sun, 15 Mar 2026 15:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773614099; x=1774218899; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OpWnHUk+3SPsGecPBlRkfmE78MiNGD1gTyiflQvv2gI=;
 b=ldKH9K/nmEEOARuJtjrejUtdEx5wkxmREmlXlKYJVwvaxA4YdC6I9PSv5HDfSOPeF0
 va8OSkZRdt7qThNwNB+HbMFHTiwTxtM7m7lTW7dH++DkAgdW6jiucjigXuWdYcvEkxis
 D0laU3KyK2XeTn6PkfogQ0S5B5bX4aIW08jmr1XBUyxrZLnnc6iPPlWRoMRNvR/Oy26K
 6h6R34pl1WPGHgzpZ3YcSckEv85E7Fn0I/xLScqH2xdQZXCZq4SSTvHr65RvjrFUjZLp
 wDV7eJQr9smNXuxQ3kDXpGOIedd74qGhgOfuMqpfI/G2xoZZlVMQYWZG0PpnIaFbxfv6
 mKqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773614099; x=1774218899;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OpWnHUk+3SPsGecPBlRkfmE78MiNGD1gTyiflQvv2gI=;
 b=SC+1Ti9xAmueq1FtTL2t6J4aYqLYv7VhUma+7Wpoy1iE/Ezw1+3ry5KEVg/KwZK7EH
 sll1Go9PuikRtJpuUrMFHsee07FJg7xApic+X1HYWSAG+Lc2mLc65pads1qffrjjI9BX
 1fbXprmJ/lVhx7I0RLtOQOzO70mCYjj1uIoXi4Ills41clnyiH+4cC/JquiHL6V+W+yf
 XVLt63mhtEvevAYCgEy21Ulr+13YPmh3lnF9THiz8DW3Y+b98lMEB1haB1a9QNEB0tPN
 YLGtUcTSY8Cj75XxJpe6pDNfKbkvpWce1SGBY0ajqGJ1FZ5l3Y9OXviyj9O2cbXkgqS4
 SnUA==
X-Gm-Message-State: AOJu0YxqenbUBT3D/g57yE/vIPpVOuuW+foJpM322Vmw//dpK+urkIhR
 CTtzSpL+WchW7x4R/nIFAU29Xv3KPvIDkbcwEy84RApDrfO7Xrje81w9gKx1lxelc+Xplg==
X-Gm-Gg: ATEYQzztmWLPmYsKDwtN6QwOqTkm+HeitxRMtkcV1tMsLLgZx7ttyjF+2TrCmI9dSNE
 8im6h47nj69WQvzIuOFFaz96r4cs/oL9CXb6OQtKF3WXPuE/XuptyFINWhT+C/ROkcnSQ3Xp2bv
 WAVDDr/gkfLDK/laIDJhwU7LxWFTlo+I1nz9BtOD0yg8U85/uN6xKhQaX9Np8G7R1fH1MT5NGPD
 hAo+/1NI+g6Ojs2l4gGz40iE0EjUQ18nge/asIVwHDxV5Ecaxp2oKjZInZx+TulZAc7Uuirn2ih
 Mvtmj9/L/FAG2+TmV+f1z8saqBJ0XCvqnAH/yk3N720etljEZx9bqxLQRrYK+mjEqhqytF9/FFY
 O9EW1hwahZB2KNbSZSxSswOqwGKfh9zlETH8F9Pn85sGyrFxJHtW3zKu3UIUFJSDevj+uAoUXK+
 EKK1S9oLZ9ZVrnF/fwdFV9DkLbkFwF0Oa8cueKNAsILJc8ngtR8lhO8fmwJjWyKkBreIL43VC4N
 GzG99hGXOEXCjb+7VIU
X-Received: by 2002:a5d:5c89:0:b0:43b:45d1:f44f with SMTP id
 ffacd0b85a97d-43b45d1f733mr476847f8f.41.1773614098847; 
 Sun, 15 Mar 2026 15:34:58 -0700 (PDT)
Received: from localhost
 (p200300eba70b6e00ca7f54fffe019321.dip0.t-ipconnect.de.
 [2003:eb:a70b:6e00:ca7f:54ff:fe01:9321])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439fe20c473sm38616488f8f.24.2026.03.15.15.34.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Mar 2026 15:34:58 -0700 (PDT)
From: =?UTF-8?q?Johannes=20W=C3=BCller?= <johanneswueller@gmail.com>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: =?UTF-8?q?Johannes=20W=C3=BCller?= <johanneswueller@gmail.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 3/4] drm/amd: treat max_tmds_clock==0 as unconstrained
Date: Sun, 15 Mar 2026 23:33:05 +0100
Message-ID: <20260315223307.45807-4-johanneswueller@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260315223307.45807-1-johanneswueller@gmail.com>
References: <20260315223307.45807-1-johanneswueller@gmail.com>
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

If max_tmds_clock is not specified by the EDID, it should be treated
as unconstrained rather than as a zero MHz limit, since it would cause
adjust_colour_depth_from_display_info() to reject all color depths
unconditionally.

Signed-off-by: Johannes Wüller <johanneswueller@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index bc853f7555a9..82c8dc8dd39f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6612,7 +6612,8 @@ static bool adjust_colour_depth_from_display_info(
 			/* The above depths are the only ones valid for HDMI. */
 			return false;
 		}
-		if (normalized_clk <= info->max_tmds_clock) {
+		if (info->max_tmds_clock == 0 ||
+		    normalized_clk <= info->max_tmds_clock) {
 			timing_out->display_color_depth = depth;
 			return true;
 		}
-- 
2.53.0

