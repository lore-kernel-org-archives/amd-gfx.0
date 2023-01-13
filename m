Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7434DC678D6
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Jan 2023 19:31:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B4E410EAE1;
	Fri, 13 Jan 2023 19:31:02 +0000 (UTC)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0370710EADA;
 Fri, 13 Jan 2023 19:30:58 +0000 (UTC)
Received: by mail-il1-x135.google.com with SMTP id u8so11214122ilq.13;
 Fri, 13 Jan 2023 11:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aRyUl1j2CeLT2msyDi6y9qIAncSGOoQz3PjuRO1TezA=;
 b=iziQWeBJgoiaMWnT+DGKeHRFoxOg8Y//x6gVDHTO/o/B4A2YM/jQhz7hOa75kni4T0
 mENNP100auhPgXQopX+LQvdAUY+0nOJ/rj9kM64uDIVIOpiPwFwEYZyZagsSNUKXoJoT
 8fUlesHV9DvTWZ6X031dT4qAHFMG1Rr80Q/mR9+vzpDC0++MWi6MKKM4zBwpTSNvAuVI
 9VUcAIV2UMhcADTgaUB2SqjfobS982vS5b/639ZvSEiS7/aAsWMM38zXDLuV7Yjmndjm
 q0WFuObgL8VxnpyJ+sHbRJRJXhPMARzB2VyhnINlSLyAwmXDUahnRjHIgV5sebJwH44a
 euBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aRyUl1j2CeLT2msyDi6y9qIAncSGOoQz3PjuRO1TezA=;
 b=Hhs4EJYBlltStYHoKTsSHVDDa75YyVeVmW6pjiaGN0K/gFdIpPRoIc/aG1KiHzHuDv
 3Lz3NIjImTpuCmzMZrV8/299P4KgzCGIf6DnD7ev+JEoGDAQq9BAyubxfRzpUXcXJcN/
 TkYUnt8XkhS91DC52CiD0ZLcH1QB8NELUid6hnB8/XwE/5SWmiprWmpq/24UEXheWw5W
 hxlrRICcBDHupUaie8rabdXcaZt9w5khFI7fQRKpwkpNTCkPwzIIxpPG9bUboMUWypyY
 7XcyiiZGCEk8/Ei9WZ5AIGJ1n+ZbYJaIUF+cqPOP3yMGqbzjJVsFVXwX2zWx6zUbIw/z
 IBLg==
X-Gm-Message-State: AFqh2kpXosjiPCFytT7UuxvmdAU2FheiYgCxag20h4ZiKTnl3G7U7xly
 NQd1OAMZKSW8AKxCLkBX/7s=
X-Google-Smtp-Source: AMrXdXtwfdAQ6WeQoeGyy+hEpdL1j6Nxnj9lnlS5pzsW0VhG/1M2+Rzc92ciwmwipotWIf+SkViSfA==
X-Received: by 2002:a92:7f03:0:b0:30c:54a1:e5d8 with SMTP id
 a3-20020a927f03000000b0030c54a1e5d8mr30477229ild.30.1673638257652; 
 Fri, 13 Jan 2023 11:30:57 -0800 (PST)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
 by smtp.googlemail.com with ESMTPSA id
 e32-20020a026d60000000b0039e583abceasm6497289jaf.68.2023.01.13.11.30.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Jan 2023 11:30:57 -0800 (PST)
From: Jim Cromie <jim.cromie@gmail.com>
To: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org
Subject: [PATCH v2 14/20] drm_print: fix stale macro-name in comment
Date: Fri, 13 Jan 2023 12:30:10 -0700
Message-Id: <20230113193016.749791-15-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230113193016.749791-1-jim.cromie@gmail.com>
References: <20230113193016.749791-1-jim.cromie@gmail.com>
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
Cc: jani.nikula@intel.com, daniel.vetter@ffwll.ch, jbaron@akamai.com,
 Jim Cromie <jim.cromie@gmail.com>, robdclark@gmail.com, seanpaul@chromium.org,
 gregkh@linuxfoundation.org, ville.syrjala@linux.intel.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Cited commit uses stale macro name, fix this, and explain better.

When DRM_USE_DYNAMIC_DEBUG=y, DYNDBG_CLASSMAP_DEFINE() maps DRM_UT_*
onto BITs in drm.debug.  This still uses enum drm_debug_category, but
it is somewhat indirect, with the ordered set of DRM_UT_* enum-vals.
This requires that the macro args: DRM_UT_* list must be kept in sync
and in order.

Fixes: f158936b60a7 ("drm: POC drm on dyndbg - use in core, 2 helpers, 3 drivers.")
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
. emphasize ABI non-change despite enum val change - Jani Nikula
. reorder to back of patchset to follow API name changes.
---
 include/drm/drm_print.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
index 6a27e8f26770..7695ba31b3a4 100644
--- a/include/drm/drm_print.h
+++ b/include/drm/drm_print.h
@@ -276,7 +276,10 @@ static inline struct drm_printer drm_err_printer(const char *prefix)
  *
  */
 enum drm_debug_category {
-	/* These names must match those in DYNAMIC_DEBUG_CLASSBITS */
+	/*
+	 * Keep DYNDBG_CLASSMAP_DEFINE args in sync with changes here,
+	 * the enum-values define BIT()s in drm.debug, so are ABI.
+	 */
 	/**
 	 * @DRM_UT_CORE: Used in the generic drm code: drm_ioctl.c, drm_mm.c,
 	 * drm_memory.c, ...
-- 
2.39.0

