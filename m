Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5F0610ED664
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2026 12:42:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D90B10EE30;
	Fri, 27 Mar 2026 12:42:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="izavzM6r";
	dkim-atps=neutral
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com
 [209.85.160.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E060510EBEE
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 18:55:29 +0000 (UTC)
Received: by mail-oa1-f53.google.com with SMTP id
 586e51a60fabf-41cd9267bbfso533786fac.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 11:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774551329; x=1775156129; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BSisvrIuxABye56v+k4UdRTAwS5HV0U80AJ6AJkDqLc=;
 b=izavzM6r3fKe0qk3c65nD4xsENxTsjUFoMxZtpFpXily1O4EngvisOya5qKP9bEbEI
 cjWSv0c12dUI+PnfrcJpwlbl31DV5mSyJcLBlDs9AxaV3B6p/oi7daq0IAanXxq7ciRf
 wu8ZjgrNwlxqDwd7nmPKa7tdbmBPmMWWN0INk89FLOvy8cmXflAtgBs2eLlY6kZfruQg
 8L61MFB/0vIFScrtv45CIH+2IS4r7vOyJF7POwGtdrLa84u647SJZy+RPm9M95TqZ2JS
 hDIPPGQMra5LvVv+pK905/GdVATufteh9iMvvSUAaw/ek61BNGQA0FVKYHQwmUAwffwH
 cmuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774551329; x=1775156129;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BSisvrIuxABye56v+k4UdRTAwS5HV0U80AJ6AJkDqLc=;
 b=GC6ae219qXOrTNorRcQP72489h5yJD0wFckTGVtkos+KNF2qdGxZBk3aItNWFZE/ed
 Sea0R9JwVha7MrxwXHnlT8MKFua/0hlLzl8ZJx3Vruw5luiXSkyUyVkH4Cn0xrgawhO2
 yKFBWNAI5NwjOi4tiSQJy8H2b/9bUOR3HpV/RQ/ydcytG+FP9FzGbrg/gvhha46QtR9Y
 7M5S6hbF9/w1cJwe3EgoBYCRptT3o6fdrben8oAUh0k7xpYIKLrnPlB7yieXpmDGc0da
 3O2QgMJaLtnbTeRUEEleblUpdRmvgOJOUx37fUxWj5vCWcZkODu7tyX54BFh+DvJgwJJ
 cNGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfbk1GpOppHA8LczlwXB9vqUSUMb56X9Z1SU9cgjZEzSLvfThQYJSO5mHzg5WW7kz5VfUME446@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxCkpv8T52rYM6cA7jK4lsaJhPR2irwkqnO4SekxGTpd/y47/L8
 GVwxAG4/ksEUTqeTY7stUMFgDXcGVQgGT8r7VxZwEOM2KlsXTDnR3+sA
X-Gm-Gg: ATEYQzwoz0nxxMd7MdGvsIVyukfl5snRb70rnaneMNInqqMd751JofOsQGIIAz9vUlV
 SfuNxwJta5xhxLOs76F1Sse3Cthho+w26aKRcmmpfrTSWsFxpl4LXRyJzA/R8iJXkBTorlby5Lw
 sJ5G0sgH1DhK3aV8eGqk/AlssGRk9jgj98DJmObU/b80TFjOBK1uzMX3FTXLr2Q+GSZvnvmnzeJ
 qycDo4+Ze3ifzH4n5QxGK9yHDLfHP5+rlrfTiabSLd/fHZo8U8gIahgkIPN6sQ35oEZlcpTe1W4
 7w/ZIJgkbcld01T3oJNDfI9a1NprWiLlxZQGG2xLO9IW1SSkuDR4ib8EuRSSCqfNupwgGSWi0w/
 OMI11c1X0KLuywWYYvdTkGII8a/QqUa5PyWUQSU9r022bo7zcYXwUayuF/yPqWkNHqbzd9/wpdp
 Q246ghxlDnW4IzxXNSNQgHHpHDAv1gumi2pAAX4kFAjue0mXX2+9cUogBgzfc=
X-Received: by 2002:a05:6870:b0e4:b0:40e:a9c5:5c32 with SMTP id
 586e51a60fabf-41cd7b187d0mr1250153fac.8.1774551329111; 
 Thu, 26 Mar 2026 11:55:29 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 586e51a60fabf-41cc7760c08sm3075171fac.4.2026.03.26.11.55.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 11:55:28 -0700 (PDT)
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
Subject: [PATCH v12 38/69] drm: use correct ccflags-y spelling
Date: Thu, 26 Mar 2026 12:53:42 -0600
Message-ID: <20260326185413.1205870-39-jim.cromie@gmail.com>
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

Incorrectly spelled CFLAGS- failed to add -DDYNAMIC_DEBUG_MODULE,
which disabled dynamic-debug in modules built with:

CONFIG_DYNAMIC_DEBUG=n		# 1
CONFIG_DYNAMIC_DEBUG_CORE=y	# 2
CONFIG_DRM_USE_DYNAMIC_DEBUG=y	# 3

NB: this adds the flag (when 3) more often than strictly needed;
modules built with CONFIG_DYNAMIC_DEBUG=y (!1) don't need the flag.

Fixes: 84ec67288c10 ("drm_print: wrap drm_*_dbg in dyndbg descriptor factory macro")
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index ec2c5ff82382..da36a9dbf170 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -3,7 +3,8 @@
 # Makefile for the drm device driver.  This driver provides support for the
 # Direct Rendering Infrastructure (DRI) in XFree86 4.1.0 and higher.
 
-CFLAGS-$(CONFIG_DRM_USE_DYNAMIC_DEBUG)	+= -DDYNAMIC_DEBUG_MODULE
+ccflags-$(CONFIG_DRM_USE_DYNAMIC_DEBUG)		+= -DDYNAMIC_DEBUG_MODULE
+subdir-ccflags-$(CONFIG_DRM_USE_DYNAMIC_DEBUG)	+= -DDYNAMIC_DEBUG_MODULE
 
 # Unconditionally enable W=1 warnings locally
 # --- begin copy-paste W=1 warnings from scripts/Makefile.warn
-- 
2.53.0

