Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 902A2107BCCD
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2026 16:51:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26FF910E44E;
	Fri, 13 Mar 2026 16:51:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OI0Ulaf9";
	dkim-atps=neutral
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com
 [209.85.167.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF09D10EC15
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2026 13:24:29 +0000 (UTC)
Received: by mail-oi1-f176.google.com with SMTP id
 5614622812f47-4671cbce2feso975924b6e.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2026 06:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773408269; x=1774013069; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=omqdlqhqg9w8rP5QQ/+0ZYQHRwMpTry/COrsHclV4zI=;
 b=OI0Ulaf9MBkuL8UHNfULduu+KrXKjJsEIpkkpzwthZOaB/jUt/HI5VxNXqC3g5stHo
 BVzKDTh3tHvsNdfLFLW3rJwKuE3u76XK+HN1Xx7ITnv7+8vxGxIDNkOu/ROULNSljE5Z
 2TvmxnBVrCjwbdlMJUGqBwB1dg8fq4Lkz7Usd22Mqaw8k1ufRrbbtouXRFkxCtyIM2E2
 y4Y8ItWCXeHlE2qDR5c0DUcLmlZHxV/cMcBNdS3KjSgZePxZ4IhpYDJOX/Xce/JJ1y8X
 4OgJsFhhP82cg+dwVudc26cunjG6PupJDZ8RJQWR8yZFWDA8Mr3P8aYbW8MOFWseB52e
 SYsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773408269; x=1774013069;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=omqdlqhqg9w8rP5QQ/+0ZYQHRwMpTry/COrsHclV4zI=;
 b=gUj+j3119yhoL2pA6i+gwnLyl8vVwKmNF/60joBOXYcw0tVhAiDK2AITHHkMmzbVqB
 L6UHkJMg/f6D0MV71mzorcTJJlV1B1NHLLiGp9VfNfcuIzbQaxFZh0XNJiib1UWojRQx
 A1K0Y9QC2I/5pOPTAZbUa5b2/cST3CAaHBQB/NZgYILn87RQp9C2oYF3BPAbEaO9mFLv
 kRWN7nVOOR4spheA9hXRsQdWTtHbpbCGwY/jFl462yX/SnLAO4mCxgD7nsyy6Hv/W3hJ
 YeijIH/sd9NpzWn1r95hfeobpQQex39aKCToPCFsd1TzuiEU0EdZtk5A7uOJSQCnqqe6
 lpiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXq9jC9TDKIqz9/63DZTE/ZVQwtGJ76UvMEQG+kkgdkQcHdz/AXaEDmt3nrpwAwsno4xbCbG4L3@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzRTVEKtL+GvKC/V0Po5jMQor7AbSbAXM0wbHzOC+NI2amv1a5h
 ek3XJmN65wAleWf77rSMka+MUnhkYQQEGf6uz8fo1zbFI6BJGOSPx4YO
X-Gm-Gg: ATEYQzy2HRkO9FYaKl4TRGRa9P0dUPEkKs19eLmHSSs+xLBuoXXdYNvPRlR6/UJCxsI
 N5kZMDG/DbWQa69KrXHLyr3gyhnzd72fNv1FhN9MX28bj6dgqm8WlxjX6jzAnG2VyGW5ak2fF9N
 OvL3QmOwa4McCp7kMZcnZiobM7xK0KMOZEbVFZEM3XKhCw8tYuvJ56LRqbBxnEgUN0HJ2fbpm0j
 lOu3Ecmuh2/f+Klj43pKPMAiOsArbPCak9dU7r0XLyZHhx1Ab9VgvCrO+i6QL2rnBdPLu/ldWKj
 /+y2kkLYJv0xac3qzCfZr4dhGm/a1KxNvC5XzvQ+flOhbzlyPdgPnVIIuaIRDW9dBrq7XRsZT2G
 o1fpE854RweKzbMR+S6/iOVR3HordqJScfI+OY3nxf0iuRlmXurQGWKv3MPv0Sz5nM/iY/WL7ET
 mLkhe9qZjmtGWXNPfHHlZ9e6A+Astui6/lRu0jFvgN4mSZ1Dc1
X-Received: by 2002:a05:6808:2218:b0:467:cda:f189 with SMTP id
 5614622812f47-467572ede3dmr1790509b6e.32.1773408268910; 
 Fri, 13 Mar 2026 06:24:28 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 5614622812f47-4673434a35csm4795987b6e.20.2026.03.13.06.24.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 06:24:28 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: airlied@gmail.com, simona@ffwll.ch, jbaron@akamai.com,
 gregkh@linuxfoundation.org, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Jim Cromie <jim.cromie@gmail.com>,
 dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: jani.nikula@intel.com, ville.syrjala@linux.intel.com,
 christian.koenig@amd.com, matthew.auld@intel.com,
 arunpravin.paneerselvam@amd.com, louis.chauvet@bootlin.com,
 skhan@linuxfoundation.org, pmladek@suse.com, ukaszb@chromium.org,
 intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Subject: [PATCH v11 43/65] drm-dyndbg: DRM_CLASSMAP_USE in nouveau
Date: Fri, 13 Mar 2026 07:20:08 -0600
Message-ID: <20260313132103.2529746-44-jim.cromie@gmail.com>
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
---
 drivers/gpu/drm/nouveau/nouveau_drm.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
index 5d8475e4895e..d205b58aff70 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
@@ -74,17 +74,7 @@
 #include "nouveau_uvmm.h"
 #include "nouveau_sched.h"
 
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
 
 MODULE_PARM_DESC(config, "option string to pass to driver core");
 static char *nouveau_config;
-- 
2.53.0

