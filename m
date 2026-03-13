Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25440107BCD0
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2026 16:51:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72BA110ECC1;
	Fri, 13 Mar 2026 16:51:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="X9EG3PLv";
	dkim-atps=neutral
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com
 [209.85.167.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3DEA10EC1A
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2026 13:24:27 +0000 (UTC)
Received: by mail-oi1-f176.google.com with SMTP id
 5614622812f47-466f00535cfso1535175b6e.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2026 06:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773408267; x=1774013067; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QuXW2pVB+6BOeyoEL7PCyteLSTsnkRNE1etSyCy+RQQ=;
 b=X9EG3PLvOe4GO64DveDUusZaefG20nQmIx3gGO4NHIwYcvWr26WpSomapCWxT6EVqq
 YeWRXjaywzLzXnRPCzk/3ZSiWyApWO37gJapytOWvSy66FVPToDM9ZJSmEHyX65D7LOK
 s57ihHYk4BgXdVA1CMG6XtTO8qsBsG21QsQYCgbeo7Der2ttxLhSJ/GTGFjhOkxuFJU4
 4Gm9uS4Gx/oymRJvb1fuExvzkDbB3R3OgI/KmNw6KoKeePoPHuNT4/a5f3k5pw0+gbzf
 /+yAsgRaLXH0gld50QK+S9otnKExufEP8NnQYHQW7qLVZV7hVWTn0rb/Smz7KU1dJJTM
 9qVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773408267; x=1774013067;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QuXW2pVB+6BOeyoEL7PCyteLSTsnkRNE1etSyCy+RQQ=;
 b=I3tmY2e9wjr3+A2+d9p21OKV9ikWJf6DmMCXI1/Ja3MfgksgpsmKl7bCFzi/rMkGQp
 CW/AXwhXqS/5FE1yd7gbTD51BZeps5ukIom4xD7jl3VYlJlT5EpAgw3esb12bnNzkLx1
 1CfeumNNh5g8RfvjCVlWYrTC0uFLoaCjcIYuhoBE63h9ye24BbVXIDTSS2fYauofO9I4
 +EPepVsCGFPX7qwqW8Kk+4lH8XS2Og1jXH6AG4mAzzi/Ks7esyG196gMXmChsrVPrIVc
 6Ja0H4dgyHAQgSjjRV7HFqMdeciS96sB9Ql5SWRAaD+71utfJHv50+FK7lFAQNn3vLgr
 Y8ig==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCBHYZd5szgSOcJM+87RMyP0ujd00RRhH6pdRQjsKDHwVwGhRa5e6Amt52yEaXV5tLKjjr+2ZH@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw21TkHQi4QuuIJwTH8VyCXIfrJXpT++qwywbNqhPqdbQL73lzJ
 16//9MA1P6B96gxlg+1XtuZZFNN1G9obdoKN04TR1Np8LRqxqhSEnuNq
X-Gm-Gg: ATEYQzyr+rMof+wdWmwz6+Za098qSQmm/xJI/UEk8t1ScYTF9AJqfRItHdakq/vwSnA
 j+2XjM+UfbUIEVcvhpUAv3iiex/gD6u8lLUDyncM/a5O8LYoU8jA0U0uOxLckHq0h9y8mYxlVbE
 JR3fhVEIFBYWKFTUJ9OCy+nx6RefFgn+Xgk6f0u5MNpC+GcXEa5C8XQI0Rvxc2Vyd9Q6K/fmCi1
 tHYbAhjuxm62ou7MAYnOf81PuJmtgDaV+reAJS4fBFmLJFTzdui5VhiH4c/D1TwwnHfdc0xOtiJ
 GkblH1+8BoYBcBwpOJBoVX2Jf8Wk3qZojO1qvbM1E8vt/e3c/tALrspx8OI8kNseqHlkCmbiAe8
 +N0KwCxbJy5fir8T+XcLuNdnaPviW6BuCpnEqiQQQOROpH20PzZlx+V/ib644wuwYCMtwXZmZ9B
 ihmhbYGfj4d63aWbOu4d5whhL8AASa6Z7xu+oJBsVTNFeoQXl9
X-Received: by 2002:a05:6808:2392:b0:467:d75:702e with SMTP id
 5614622812f47-467570a0d7fmr1650516b6e.6.1773408267013; 
 Fri, 13 Mar 2026 06:24:27 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 5614622812f47-4673434a35csm4795987b6e.20.2026.03.13.06.24.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 06:24:26 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: airlied@gmail.com, simona@ffwll.ch, jbaron@akamai.com,
 gregkh@linuxfoundation.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Jim Cromie <jim.cromie@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: jani.nikula@intel.com, ville.syrjala@linux.intel.com,
 christian.koenig@amd.com, matthew.auld@intel.com,
 arunpravin.paneerselvam@amd.com, louis.chauvet@bootlin.com,
 skhan@linuxfoundation.org, pmladek@suse.com, ukaszb@chromium.org,
 intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Subject: [PATCH v11 42/65] drm-dyndbg: DRM_CLASSMAP_USE in drm_dp_helper
Date: Fri, 13 Mar 2026 07:20:07 -0600
Message-ID: <20260313132103.2529746-43-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313132103.2529746-1-jim.cromie@gmail.com>
References: <20260313132103.2529746-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 13 Mar 2026 16:51:10 +0000
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

Following the dyndbg-api-fix, replace DECLARE_DYNDBG_CLASSMAP with
DRM_CLASSMAP_USE.  This refs the defined & exported classmap, rather
than re-declaring it redundantly, and error-prone-ly.

This resolves the appearance of "class:_UNKNOWN_" in the control file
for the driver's drm_dbg()s.

Fixes: f158936b60a7 ("drm: POC drm on dyndbg - use in core, 2 helpers, 3 drivers.")

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/display/drm_dp_helper.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/display/drm_dp_helper.c
index a697cc227e28..308083e244d4 100644
--- a/drivers/gpu/drm/display/drm_dp_helper.c
+++ b/drivers/gpu/drm/display/drm_dp_helper.c
@@ -45,17 +45,7 @@
 
 #include "drm_dp_helper_internal.h"
 
-DECLARE_DYNDBG_CLASSMAP(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS, 0,
-			"DRM_UT_CORE",
-			"DRM_UT_DRIVER",
-			"DRM_UT_KMS",
-			"DRM_UT_PRIME",
-			"DRM_UT_ATOMIC",
-			"DRM_UT_VBL",
-			"DRM_UT_STATE",
-			"DRM_UT_LEASE",
-			"DRM_UT_DP",
-			"DRM_UT_DRMRES");
+DRM_CLASSMAP_USE(drm_debug_classes);
 
 struct dp_aux_backlight {
 	struct backlight_device *base;
-- 
2.53.0

