Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9A8210ED66E
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2026 12:42:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53E4710EE32;
	Fri, 27 Mar 2026 12:42:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Whj8soNe";
	dkim-atps=neutral
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com
 [209.85.167.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8105210EBEC
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 18:55:36 +0000 (UTC)
Received: by mail-oi1-f179.google.com with SMTP id
 5614622812f47-463f00cda04so720786b6e.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 11:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774551336; x=1775156136; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=odzxhFrE/OaIR8r3wWCi5vPBwW9g54UQJlDBz7itpic=;
 b=Whj8soNecmKGgQWvasvwBJ29mkqJii6kC7a7rxjOYRkJYrXzfpL1c3N07i3fB/9AGJ
 LM4tVWKJUAoybNderynx7yoML9KQ16lr41+/kmtDHdW7ptwpxl+dfNdlPgnXljfhxEEe
 GOKcVJbeI9A2rATpJpC0Ez5K3n3Gsocu3oU+sVfq3A3RNzlCevWWrYgIwRFkpl15ojg0
 ZG6IqGtxrLFNAQhMCukitFBdEX622/Z+6w+suLHMqbbmvqu2XZQWAE4ox/bqqWpvUwJx
 Amg9PodlpY5oNfXriWyzbX1pP8CTEwlLAnerXJN+IM5LelGW4BemopcfWQT6fugm2NX2
 VtUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774551336; x=1775156136;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=odzxhFrE/OaIR8r3wWCi5vPBwW9g54UQJlDBz7itpic=;
 b=bitF2vpmKNx08awd4UOxjhdbO+8IUiWQsAMMcWFskcWu1QTbxABdqW+cLWpzXTlJce
 8Kt0hP/4AJ1yvOAaE83PkhiV9zBl6KFCs80D4C+Q55PXmbXN9XULLRwKVzqUYKMAOWZU
 btLu6X7wqNcQmuuB4zbjR9Zv72+g2RrjuWnknt2/+vXid3Wlk4OqqEvXQZFpItB1eMcq
 F+jMXnit46RkOLMabmgd1IyaO4Nkf4n9COh+Tsi3C5RsrdN3bVDFD0lJRqlGP/a5kZpo
 /K+RA7qVRyChZtVGG3UzFGFkQduxVx1uSQTOT50ufwotiK48E7kGXTrQBL5zvP/jpBBr
 JvtQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUaMcIs3Vhpl70Us/qtZw6PdvDj4BQ+u7Lsrd7mQEAuOpsXZg3rPoiLeZZooCKtJjgMHhAmOhTC@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz7HCD40rEJDhZFJJh0Gr7B00VENaSUGI39EZ/SFA/Jcz5lVO+q
 Av6sKedp16fylG1rcWzihlQIetbgek1Z5UCKgwZCLeOCs0tqpxhc9Cyx
X-Gm-Gg: ATEYQzzDLd0i41PY0JpUVOmt/s/2LUuK3fLCFELjdlF7uCqm8OnOWmEYlJjlg4Y1AiM
 /jjxibglAjRRJ0yGaOQFp4zTAksqDmZPuW9Egylj5GVEZn5RPbfwsXPxB3am1VFMkQo6M4GLVU3
 SVcDEVq6fW1LK8Gah7dDWWohl2hiqzjKRHVmTU1gzVngDbsQ2TaZItNMJHpAZu8xqctqVu5zY/4
 tBRbX4BitzR6AkBaVs3sj8D6FuiBO3KwYoTyP5i9nzFDBafgoRu0vry1xdg6MbYtShT5FT2DwTZ
 etJk1EbPG5WuMHZthxUyJYHOMULRdS3kCOSEMX2i1K2+QxDEJPVWSRoYPkrBW1jeFa/7gl+JhIF
 QBg7ENsj/ghXfRlEZ/0AAOc2mnCiuTn+ndul2/qT3+J7Kxv2QYcXHAx/wlpofxKOceMQ+k94IlX
 3nX/mSh08KsX3iDwJJvwKGJBQjjrofQcnCEH/s39+GNgBa65fB
X-Received: by 2002:a05:6808:5246:b0:467:1f90:412d with SMTP id
 5614622812f47-46a5c5a5802mr3709128b6e.11.1774551335668; 
 Thu, 26 Mar 2026 11:55:35 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 586e51a60fabf-41cc7760c08sm3075171fac.4.2026.03.26.11.55.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 11:55:35 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: linux-kernel@vger.kernel.org, airlied@gmail.com, simona@ffwll.ch,
 jbaron@akamai.com, gregkh@linuxfoundation.org
Cc: jim.cromie@gmail.com, mripard@kernel.org, tzimmermann@suse.de,
 maarten.lankhorst@linux.intel.com, jani.nikula@intel.com,
 ville.syrjala@linux.intel.com, christian.koenig@amd.com,
 matthew.auld@intel.com, arunpravin.paneerselvam@amd.com,
 louis.chauvet@bootlin.com, skhan@linuxfoundation.org, pmladek@suse.com,
 ukaszb@chromium.org, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Subject: [PATCH v12 41/69] drm_vblank: avoid bit-test when
 DRM_USE_DYNAMIC_DEBUG=y
Date: Thu, 26 Mar 2026 12:53:45 -0600
Message-ID: <20260326185413.1205870-42-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326185413.1205870-1-jim.cromie@gmail.com>
References: <20260326185413.1205870-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 27 Mar 2026 12:40:00 +0000
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

drm_crtc_vblank_helper_get_vblank_timestamp_internal() is called about
~100 times per sec, on a single display. It currently calls
drm_debug_enabled(DRM_UT_VBL) to avoid doing ktime_to_timespec64()
conversions when drm_dbg_vbl() is disabled.

When CONFIG_DRM_USE_DYNAMIC_DEBUG=Y, that bit-test is redundant,
because its also done by the static-key inside drm_dbg_vbl().

In this case, we can move the ktime conversions into the drm_dbg_vbl()
argument list (using a comma operator to evaluate the assignment, then
pass the address of its LHS).  Then the __dynamic_func_call() wrapping
the func guards the arg-list too, avoiding its evaluation when its not
being printed.

When CONFIG_DRM_USE_DYNAMIC_DEBUG=N, the bit-test is needed, because
the conversion in the arg-list is not guarded, and we'd do the
conversions even when the callsite is disabled.

We can optimize for both Y/N cases by changing
drm_debug_enabled(DRM_UT_VBL) to __drm_debug_enabled(DRM_UT_VBL).
This gives us the short-circuit when the static-key guard is there,
and the bit-test by drm_debug_enabled_raw() otherwise.

TLDR: we could change __drm_debug_enabled() to call _instrumented()
instead of _raw() for the =N case, but that should be accompanied by
some experiments and results.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
-v12-
restore (previously dropped) drm_debug_enabled, with __ alterations.
---
 drivers/gpu/drm/drm_vblank.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
index f78bf37f1e0a..8ec025e12c67 100644
--- a/drivers/gpu/drm/drm_vblank.c
+++ b/drivers/gpu/drm/drm_vblank.c
@@ -803,15 +803,14 @@ drm_crtc_vblank_helper_get_vblank_timestamp_internal(
 	 */
 	*vblank_time = ktime_sub_ns(etime, delta_ns);
 
-	if (!drm_debug_enabled(DRM_UT_VBL))
+	if (!__drm_debug_enabled(DRM_UT_VBL))
 		return true;
 
-	ts_etime = ktime_to_timespec64(etime);
-	ts_vblank_time = ktime_to_timespec64(*vblank_time);
-
 	drm_dbg_vbl(dev,
 		    "crtc %u : v p(%d,%d)@ %ptSp -> %ptSp [e %d us, %d rep]\n",
-		    pipe, hpos, vpos, &ts_etime, &ts_vblank_time,
+		    pipe, hpos, vpos,
+		    (ts_etime = ktime_to_timespec64(etime), &ts_etime),
+		    (ts_vblank_time = ktime_to_timespec64(*vblank_time), &ts_vblank_time),
 		    duration_ns / 1000, i);
 
 	return true;
-- 
2.53.0

