Return-Path: <SRS0=hGuQ=PP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC46C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Oct 2021 04:38:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3BCE610A0
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Oct 2021 04:38:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F3BCE610A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE6066E56D;
	Wed, 27 Oct 2021 04:37:39 +0000 (UTC)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B9A78932D;
 Wed, 27 Oct 2021 04:37:26 +0000 (UTC)
Received: by mail-io1-xd2a.google.com with SMTP id r194so2089698iod.7;
 Tue, 26 Oct 2021 21:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7iYW4I4CStTbC9vQQqx1wbnaW7QfaWOV+gu+PhQHi68=;
 b=bwhmmQWaeTqGmfGhryL8vuXPioJB6//CiznbOIm2iZRVPl+AcEv1t65GnJrm3HtNuO
 ZBH7pXp8+qRNbXE0VVi/gb4lkEat831GjKilUCXymAF27Fy+r0vJhL6Dmp+SNaZw8ycM
 4c9X1c6sUb5qNz8/QUN6Ih55N5s51IrpLl9SeYAQ3QS5NEGA0PHUd4ksB3mv2MnovIZ3
 KjVo1J3ALQUK5ZmRSq89qyFRBA1ms9LJRBK7gsKxM7ZmJf4MXYNHgHQYJTL67sUKr2vo
 vjLKq6FIwKO4/v+3wGYJlbk+EbMI6EETArObjvi/15aDCG2Yo274Ng/+NSGiwvsKGvDC
 nIyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7iYW4I4CStTbC9vQQqx1wbnaW7QfaWOV+gu+PhQHi68=;
 b=rsKQv/9J0G2Q3yKv0b06cFumIhd2Xm2sUMNYpbLI1HZq8wDKaDNYqeiWfjXEhxVWB2
 FAzBo7UqyC7B1x9mtPdE+T3lnepYV3Jp6toxFKtjrrJk7bADvkH82dDHS4YdxO38+sS4
 rkUmWl/nF9gbFmmyIw84/wrU5o6sLmv5r1N8dmcZsOx0aBs+HzEtoc2YfmbR55HpTg8H
 NA1FdYKkoc43oWQHbs4zw2AlFIkcXtLjXH5d2JZG5PrirVirmuTRWKlNiFBfPtkKLmqa
 5ZG4YCsLy5t2H1+5YOqz6xMoSsnjIWQuEj5c2EIng5pr2tgHjSgxedJXSqylnx3avz4v
 sYMQ==
X-Gm-Message-State: AOAM531EFarbdn2E4xh+xGFp0IA2vnPywbQJz+52xFzLuGu/3zjYL99E
 7NPQtuAqC/s1WN8y/js6dc31ywDKag4=
X-Google-Smtp-Source: ABdhPJz4nVn5zyXeRfn7gHHvpvDCVU+3Y3rIZxzBfd8KgODE1Ou7nwBG8jJvpQ1lwq6FuX/hS41vVQ==
X-Received: by 2002:a05:6602:158a:: with SMTP id
 e10mr18367339iow.157.1635309444000; 
 Tue, 26 Oct 2021 21:37:24 -0700 (PDT)
Received: from samwise.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
 by smtp.googlemail.com with ESMTPSA id a15sm2030404ilj.81.2021.10.26.21.37.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Oct 2021 21:37:23 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: jbaron@akamai.com, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk,
 daniel.vetter@ffwll.ch, seanpaul@chromium.org,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 intel-gvt-dev@lists.freedesktop.org, intel-gfx@lists.freedesktop.org
Cc: Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v9 07/10] drm_print: instrument drm_debug_enabled
Date: Tue, 26 Oct 2021 22:36:42 -0600
Message-Id: <20211027043645.153133-8-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211027043645.153133-1-jim.cromie@gmail.com>
References: <20211027043645.153133-1-jim.cromie@gmail.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Duplicate drm_debug_enabled() code into both "basic" and "dyndbg"
ifdef branches.  Then add a pr_debug("todo: ...") into the "dyndbg"
branch.

Then convert the "dyndbg" branch's code to a macro, so that the
pr_debug() get its callsite info from the invoking function, instead
of from drm_debug_enabled() itself.

This gives us unique callsite info for the 8 remaining users of
drm_debug_enabled(), and lets us enable them individually to see how
much logging traffic they generate.  The oft-visited callsites can
then be reviewed for runtime cost and possible optimizations.

Heres what we get:

bash-5.1# modprobe drm
dyndbg: 384 debug prints in module drm
bash-5.1# grep todo: /proc/dynamic_debug/control
drivers/gpu/drm/drm_edid.c:1843 [drm]connector_bad_edid =_ "todo: maybe avoid via dyndbg\012"
drivers/gpu/drm/drm_print.c:309 [drm]___drm_dbg =p "todo: maybe avoid via dyndbg\012"
drivers/gpu/drm/drm_print.c:286 [drm]__drm_dev_dbg =p "todo: maybe avoid via dyndbg\012"
drivers/gpu/drm/drm_vblank.c:1491 [drm]drm_vblank_restore =_ "todo: maybe avoid via dyndbg\012"
drivers/gpu/drm/drm_vblank.c:787 [drm]drm_crtc_vblank_helper_get_vblank_timestamp_internal =_ "todo: maybe avoid via dyndbg\012"
drivers/gpu/drm/drm_vblank.c:410 [drm]drm_crtc_accurate_vblank_count =_ "todo: maybe avoid via dyndbg\012"
drivers/gpu/drm/drm_atomic_uapi.c:1457 [drm]drm_mode_atomic_ioctl =_ "todo: maybe avoid via dyndbg\012"
drivers/gpu/drm/drm_edid_load.c:178 [drm]edid_load =_ "todo: maybe avoid via dyndbg\012"

At quick glance, edid won't qualify, drm_print might, drm_vblank is
strongest chance, maybe atomic-ioctl too.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
---
 include/drm/drm_print.h | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
index cc853314f44a..36373a91c9e0 100644
--- a/include/drm/drm_print.h
+++ b/include/drm/drm_print.h
@@ -381,6 +381,11 @@ enum drm_debug_category {
 #define DRM_DBG_CAT_DP		DRM_UT_DP
 #define DRM_DBG_CAT_DRMRES	DRM_UT_DRMRES
 
+static inline bool drm_debug_enabled(enum drm_debug_category category)
+{
+	return unlikely(__drm_debug & category);
+}
+
 #else /* CONFIG_DRM_USE_DYNAMIC_DEBUG */
 
 /* join prefix + format in cpp so dyndbg can see it */
@@ -414,12 +419,13 @@ enum drm_debug_category {
 #define DRM_DBG_CAT_DP		"drm:dp: "
 #define DRM_DBG_CAT_DRMRES	"drm:res: "
 
-#endif /* CONFIG_DRM_USE_DYNAMIC_DEBUG */
+#define drm_debug_enabled(category)			\
+	({						\
+	pr_debug("todo: maybe avoid via dyndbg\n");	\
+	unlikely(__drm_debug & (category));		\
+	})
 
-static inline bool drm_debug_enabled(enum drm_debug_category category)
-{
-	return unlikely(__drm_debug & category);
-}
+#endif /* CONFIG_DRM_USE_DYNAMIC_DEBUG */
 
 /*
  * struct device based logging
@@ -569,7 +575,6 @@ void __drm_dev_dbg(const struct device *dev, enum drm_debug_category category,
 #define drm_dbg_drmres(drm, fmt, ...)					\
 	drm_dev_dbg((drm) ? (drm)->dev : NULL, DRM_DBG_CAT_DRMRES, fmt, ##__VA_ARGS__)
 
-
 /*
  * printk based logging
  *
-- 
2.31.1

