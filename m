Return-Path: <SRS0=0crs=NW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E991C4320A
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Aug 2021 20:22:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D7F36056B
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Aug 2021 20:22:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6D7F36056B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 949956E0B8;
	Tue, 31 Aug 2021 20:21:45 +0000 (UTC)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40F236E0AA;
 Tue, 31 Aug 2021 20:21:44 +0000 (UTC)
Received: by mail-io1-xd31.google.com with SMTP id g9so524969ioq.11;
 Tue, 31 Aug 2021 13:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kuB3RkzY1zFR/gTAbpOQb93W/7QigOgH822eKzxQKfY=;
 b=ZsN6D0QXyvTW7mikr08SMEj8mIyLS3HzG1B7LfVjZ+AkDVPTjZUoAlhwOFZVCd/oK4
 w1bddGOp6FqXSajxAksdhWn3nmqoEUwguvW3LEynpAQ5ZVA4XxrFbcQFRy9MGmn59AQT
 d1i7Y6zg50ac+vZGYYgGa6CykJi0Motn96/0eldHZE8v/rlnBzrZ5xAkjXDHBPqephfX
 mHl4AsR6hO2SKi5OeZYx8XPjO+cyShKJpEyURD5wv0BkeuszLawRG+b5RXOezyi0S1qg
 biw66hxtMl1aRJO9q6ZecJGsXmHA7vr2/6eP4GFdLEPzfcCeVycKZDCV0MhViN5WgROy
 KNIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kuB3RkzY1zFR/gTAbpOQb93W/7QigOgH822eKzxQKfY=;
 b=HIDg32hB9E7WbWvUCBe+rvOlkigmfhMEWLIj+EDN277jTHx2Zhc+hPL5aZ55K+LJKF
 ZcKFyzWy6j9jGBsOc4TyyXgNg1hp+5Mt0vghWFo9E40Zy9dN162Q8r2+2dQ57ALpYZ09
 JeTpxSIdHWecCd71b++r0pLhQvN3q/Ckq86rNxB/NjZcH6xJJNW4jSZVuXNxnLoyc05z
 z0h8Y5FZ3CpkfVLTK+YJGMQz4ua+pxLOZf2slMYv71Km+WoV1USUJIo4T3Y/bRUoqnD2
 ls4mbD/5+0PrOfHopPUfr+oSLg9hvWo+3tf5pR8EK4R2w8R/Rf21yBAgm3jxtkbRq4Ud
 Q2eQ==
X-Gm-Message-State: AOAM531TAijZpix8MBPuVrTKMMe8Pfb3S/QRx2lib1EAZlDBkGL01Lqv
 7/Nf5jgDiR3rNJKOvSKx7gA=
X-Google-Smtp-Source: ABdhPJwuB0NH2EJ07sqD/+cY1NyNE2prRHxrGfowa1te+2JVORx3JmfzoFGFg2+rsji0Y44SaPwrGw==
X-Received: by 2002:a02:644:: with SMTP id 65mr4532552jav.84.1630441303603;
 Tue, 31 Aug 2021 13:21:43 -0700 (PDT)
Received: from frodo.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
 by smtp.googlemail.com with ESMTPSA id u15sm10597384ilk.53.2021.08.31.13.21.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Aug 2021 13:21:43 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: jbaron@akamai.com, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org
Cc: Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v7 4/8] amdgpu: use DEFINE_DYNAMIC_DEBUG_CATEGORIES
Date: Tue, 31 Aug 2021 14:21:29 -0600
Message-Id: <20210831202133.2165222-5-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210831202133.2165222-1-jim.cromie@gmail.com>
References: <20210831202133.2165222-1-jim.cromie@gmail.com>
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

logger_types.h defines many DC_LOG_*() categorized debug wrappers.
Most of these use DRM debug API, so are controllable using drm.debug,
but others use bare pr_debug("$prefix: .."), each with a different
class-prefix matching "^\[\w+\]:"

Use DEFINE_DYNAMIC_DEBUG_CATEGORIES to create a /sys debug_dc
parameter, modinfos, and to specify a map from bits -> categorized
pr_debugs to be controlled.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 .../gpu/drm/amd/display/dc/core/dc_debug.c    | 44 ++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_debug.c b/drivers/gpu/drm/amd/display/dc/core/dc_debug.c
index 21be2a684393..9fd43254db88 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_debug.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_debug.c
@@ -36,8 +36,50 @@
 
 #include "resource.h"
 
-#define DC_LOGGER_INIT(logger)
+#ifdef CONFIG_DRM_USE_DYNAMIC_DEBUG
+/* define a drm.debug style dyndbg pr-debug control point */
+#include <linux/dynamic_debug.h>
+
+unsigned long __debug_dc;
+EXPORT_SYMBOL(__debug_dc);
+
+#define _help_(key)	"\t   " key "\t- help for " key "\n"
+
+/* Id like to do these inside DEFINE_DYNAMIC_DEBUG_CATEGORIES, if possible */
+#define DC_DYNDBG_BITMAP_DESC(name)					\
+	"Control pr_debugs via /sys/module/amdgpu/parameters/" #name	\
+	", where each bit controls a debug category.\n"			\
+	_help_("[SURFACE]:")						\
+	_help_("[CURSOR]:")						\
+	_help_("[PFLIP]:")						\
+	_help_("[VBLANK]:")						\
+	_help_("[HW_LINK_TRAINING]:")					\
+	_help_("[HW_AUDIO]:")						\
+	_help_("[SCALER]:")						\
+	_help_("[BIOS]:")						\
+	_help_("[BANDWIDTH_CALCS]:")					\
+	_help_("[DML]:")						\
+	_help_("[IF_TRACE]:")						\
+	_help_("[GAMMA]:")						\
+	_help_("[SMU_MSG]:")
+
+DEFINE_DYNAMIC_DEBUG_CATEGORIES(debug_dc, __debug_dc,
+	DC_DYNDBG_BITMAP_DESC(debug_dc),
+	_DD_cat_("[CURSOR]:"),
+	_DD_cat_("[PFLIP]:"),
+	_DD_cat_("[VBLANK]:"),
+	_DD_cat_("[HW_LINK_TRAINING]:"),
+	_DD_cat_("[HW_AUDIO]:"),
+	_DD_cat_("[SCALER]:"),
+	_DD_cat_("[BIOS]:"),
+	_DD_cat_("[BANDWIDTH_CALCS]:"),
+	_DD_cat_("[DML]:"),
+	_DD_cat_("[IF_TRACE]:"),
+	_DD_cat_("[GAMMA]:"),
+	_DD_cat_("[SMU_MSG]:"));
+#endif
 
+#define DC_LOGGER_INIT(logger)
 
 #define SURFACE_TRACE(...) do {\
 		if (dc->debug.surface_trace) \
-- 
2.31.1

