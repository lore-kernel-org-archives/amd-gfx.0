Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A03F107BCE3
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2026 16:51:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDE9110ECAC;
	Fri, 13 Mar 2026 16:51:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RHqeQIaI";
	dkim-atps=neutral
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com
 [209.85.167.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7C9710EC12
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2026 13:24:23 +0000 (UTC)
Received: by mail-oi1-f177.google.com with SMTP id
 5614622812f47-4673790ab85so1445795b6e.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2026 06:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773408263; x=1774013063; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=irTrrnawNz+DXC6VSfC9mZGBC+I85t9C/e5XGxZ5eAQ=;
 b=RHqeQIaIWe1JqhhrXvX8ug6w/Q2CufFrX51kU/fBLeqBBLuoNvzOxaSgHBvxew6cB/
 K5IyIEGOvQ5TYToxsDutQ9L4kbWKfFFf2AklK2dC5vnk2JW9tY1DOda0rpYQ1+Fq6pvX
 6uerzeDB3YQhrLt/8481YkSWN55ufMzep9BnAm2bK0AcSFVm5kgthW+grT6jSAaMux0J
 fxSY93WxXVuJEi8HbiFXrFmqO6W/ZZXewt2BcCkdzATnRRmioD2uvWfNipyY3ZaaSvvd
 KFCzY6+VO9MM2DE2AQVvINmcKRUTCgHOa1sauKKZ6MZG64kNiOfpbGdJiPyKOb4OoLLq
 ypSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773408263; x=1774013063;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=irTrrnawNz+DXC6VSfC9mZGBC+I85t9C/e5XGxZ5eAQ=;
 b=pvbrji8+MR6O+7RUqlB0uEnDOpxfGADIbfO+EMf+VDSIA7GcgRuq24vIagSVfBs2hs
 lDKlaPrNbMyBpV8IiQ7q7btuW6KQ+/TIsdGi91Ly7tOjewYbJWZ/mbvhxNn7JVqhD0jm
 1eR7Yf1If3J0W5f8yBSE5TKOXDKRCbV7MXpSDHnYSMUHb45XAGaLw2qY4XEMOT9cG+Jq
 6RWRjlGLDaGgMV3ZvhdvABAxFw9GZruCfKEGlBrWO25AHskDxjtP0PUzAKR7Q9iJJwmU
 yHV8t+paMd0p+JE6k1PywGln2m9BJkJtJfpoxAcGS5rLNEVOXmgxvEGpNns/ydUvA4ad
 EwcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVW/Oi/cz9rfEiI3emXKqF/Voi/7t7vV0t9FT3pPcsi+KzSwpL8ylb9VcdNLrlz+R8oBPIup3Np@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwNjYc2PlnRldgUc+j4LbL0HpJnMuB3l6ar34Lo5mkkGLMc7bCr
 Nf+sCUJJ5h6txaBGTDS1GozUytXWmytsIRC52baIBlXAMdicMvJ5hFSI
X-Gm-Gg: ATEYQzynUCYJNEOQl5uivF1j+jD39onaTc+7Q2nCg3GcHoXLXNGLqiBHmzURazdQIJl
 G7Gywj+8gavs/6fZqB77Zhm4qDjoDFuK5qOAYJVMXcDoj8lOwW0xtPN66Cbb/qbHGsqgagUY/hX
 jfL14UesfMDb0+nmrZV75g3GUgIjJni89cW+KmvD8CRy0uHQteM5+MLsB1dNqE0hc852no7cgBn
 17O44MQ+UDAQB5yVN6tbZhVdZVOEEhy1PZJG5xvwNO+pptyqgS7EFp1PujTqqUBdSPlSM1PK9Me
 DhF5HPBWARH53iIcm9BHg+u/FI43Ze++Xr5VJ8bbTzCsXF7S92NJAvkTVIaBhHZJ2hS0SKhf2an
 EMFCmc4bynR6cBHNbEHSSOVG3L50xlZSJXiDesD7cK2fMJtUrLZSR+NIrIDLEJ22HDwbNAfH4Gv
 lgIUETTHSwplwmC7+aQVthd5Se4WKQHeyJMZeNoi8hCvsxaQQo
X-Received: by 2002:a05:6808:302c:b0:467:4a7:e3f6 with SMTP id
 5614622812f47-467570efaf8mr1550885b6e.2.1773408262974; 
 Fri, 13 Mar 2026 06:24:22 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 5614622812f47-4673434a35csm4795987b6e.20.2026.03.13.06.24.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 06:24:22 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: airlied@gmail.com, simona@ffwll.ch, jbaron@akamai.com,
 gregkh@linuxfoundation.org, Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, Jim Cromie <jim.cromie@gmail.com>,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: mripard@kernel.org, tzimmermann@suse.de, maarten.lankhorst@linux.intel.com,
 jani.nikula@intel.com, ville.syrjala@linux.intel.com,
 christian.koenig@amd.com, matthew.auld@intel.com,
 arunpravin.paneerselvam@amd.com, louis.chauvet@bootlin.com,
 skhan@linuxfoundation.org, pmladek@suse.com, ukaszb@chromium.org,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH v11 40/65] drm-dyndbg: DRM_CLASSMAP_USE in i915 driver
Date: Fri, 13 Mar 2026 07:20:05 -0600
Message-ID: <20260313132103.2529746-41-jim.cromie@gmail.com>
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
 drivers/gpu/drm/i915/i915_params.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_params.c b/drivers/gpu/drm/i915/i915_params.c
index 34ed82bb1b1a..40c5e0014686 100644
--- a/drivers/gpu/drm/i915/i915_params.c
+++ b/drivers/gpu/drm/i915/i915_params.c
@@ -29,17 +29,7 @@
 #include "i915_params.h"
 #include "i915_drv.h"
 
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
 
 #define i915_param_named(name, T, perm, desc) \
 	module_param_named(name, i915_modparams.name, T, perm); \
-- 
2.53.0

