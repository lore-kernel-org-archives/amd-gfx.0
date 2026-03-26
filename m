Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44C6910ED66D
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2026 12:40:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 395A810EDCD;
	Fri, 27 Mar 2026 12:40:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IRkNoAg8";
	dkim-atps=neutral
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com
 [209.85.160.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D16510EBE9
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 18:55:39 +0000 (UTC)
Received: by mail-oa1-f54.google.com with SMTP id
 586e51a60fabf-40f387a688dso1105092fac.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 11:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774551338; x=1775156138; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b4VPaN2JxzLfP79BRo4ZYIGptPdGN0vKlLM6mj5G4BY=;
 b=IRkNoAg8SByesDEF+uk8nhT05MlMq48mRLLLsGblUY5GKiiWnp4Ol6/A2wsG2m9hQj
 5XzqXhjE4yCXmQwIFQAsKqZdne46cjgZth38hj8DST2t0YXaWmFE4DkkOAc9bj+leXBf
 DVei8oAFE7P05Douo3mdX+ffyiLmduHq2+B8PQylqQssryBQRCzF3E5wFY3PO7K/+Q6H
 RDjpvbzZ3YOgMzdgar5ohcx5RGO5RI9HJGSPAbaJ+BkNi1yOkce1bbfZG/V40gySLxBf
 EyR4FuGy9LSnv5jP8fYhg+1GLeMKqZAS4BS6ekWX0i3kT6fBEKm10SMboq29yXe+aMJI
 oAvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774551338; x=1775156138;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=b4VPaN2JxzLfP79BRo4ZYIGptPdGN0vKlLM6mj5G4BY=;
 b=UVuHhDr9CVTO9EhTMCk+j5wZuxpTcsSqHrZuYet0MuyRmvkJia5vNJdiy/rozVqqt7
 /ajCBy2BmYBh+BqLRTcYoLRNep/0K5o0zagQ5c/kGO962L5fvomr1dc/D6VZPDabqzEW
 VMlWGJeS26q66OjNxWrvustsNc1pNxr97+pbyCNfra+RVlU9YoIckO3k+AM5/1d0hDmD
 Z6ruVW+8dUd0uzqv2EOWEg47aVW/e4kgKS3KKjkW1L7GkO7GeL+MIJC6Invk2U/d1g2X
 p3ieQPP6TRHMFOg0s37EbNasa+2kJZp5kt5iZNQgMt1EU//ogzBkvoPDgqpLBKg85nvS
 HeQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVP8p6lZWW885VIzTOLuKyjZ/R/788y+dLuMeKOADvWix9Mq2FHJBOt75uvjFe9OKfmKkFfU6bF@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwRUGPJPKIUzsDXIjsrI4Fy/XRPzcHLDl1mEHT5Lhp7sazbdVf0
 MvePr38p/9wAxN7ytfxniEp07qdZvPbDjEMEHpCCVtOwuKZGaeN8kcfm
X-Gm-Gg: ATEYQzwBChyUeDtv0MfsDL9gYBQFcpfL9Mk22KbjDYZXC6/cZWUSEOf7EmmzMkrWFiS
 5GTCr578YlhINhIDXR6WSCbR5VlztzUeXI+pJJzHxPAJNg64IJ1sVMW1Rl41D9VsfzywOhQcF1R
 jbBqPVoZ+6gPoBiySGykea0oCdp0a7s724ybD/EsDk2uh7JEvcgujee70UJRCoPJEyAvahwcxl7
 Rcx4YjPj1RLlMcujQ+QPlZgcJOhgx5nY6aFhsvTuVwU0Z/hWuSKToriD04HkjbPyjqSKJFAN3+M
 mAth9FdbL3XidRsS++nF6jNLhKR8/cbPkbX8CIo9w+t4I8eaVmnlMgBzIAGALbaormCDN1mADas
 Ychv2hGTxZW0Mym4TR/3q3tNxzQamWO88/IHPFQLHjJTShaEvR3qbtGb/U7qTmpnXo4LjCH8Nod
 s+naAXWhWLgkaOrKvHPUWMEPpsdpeCD3LIgw9CKGuICEt7tthA
X-Received: by 2002:a05:6871:4604:b0:409:95c6:f2dd with SMTP id
 586e51a60fabf-41ca6e9ff1emr4767565fac.22.1774551338399; 
 Thu, 26 Mar 2026 11:55:38 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 586e51a60fabf-41cc7760c08sm3075171fac.4.2026.03.26.11.55.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 11:55:38 -0700 (PDT)
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
Subject: [PATCH v12 43/69] drm-dyndbg: adapt DRM to invoke
 DYNAMIC_DEBUG_CLASSMAP_PARAM
Date: Thu, 26 Mar 2026 12:53:47 -0600
Message-ID: <20260326185413.1205870-44-jim.cromie@gmail.com>
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

Invoke DYNAMIC_DEBUG_CLASSMAP_PARAM to hook drm.debug (__drm_debug) to the
DRM_UT_* classmap, replacing the ad-hoc wiring previously doing it.

Add DRM_CLASSMAP_* adapter macros to selectively use
DYNAMIC_DEBUG_CLASSMAP_* when DRM_USE_DYNAMIC_DEBUG=y is configured.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/drm_print.c | 8 ++------
 include/drm/drm_print.h     | 4 ++++
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/drm_print.c b/drivers/gpu/drm/drm_print.c
index c0ec866f31dd..9cdc547e3f85 100644
--- a/drivers/gpu/drm/drm_print.c
+++ b/drivers/gpu/drm/drm_print.c
@@ -70,12 +70,8 @@ DRM_CLASSMAP_DEFINE(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS,
 		    "DRM_UT_DP",
 		    "DRM_UT_DRMRES");
 
-static struct ddebug_class_param drm_debug_bitmap = {
-	.bits = &__drm_debug,
-	.flags = "p",
-	.map = &drm_debug_classes,
-};
-module_param_cb(debug, &param_ops_dyndbg_classes, &drm_debug_bitmap, 0600);
+DRM_CLASSMAP_PARAM_REF(debug, __drm_debug, drm_debug_classes, p);
+
 #endif
 
 void __drm_puts_coredump(struct drm_printer *p, const char *str)
diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
index b743ee3f8f5e..94064ec6c229 100644
--- a/include/drm/drm_print.h
+++ b/include/drm/drm_print.h
@@ -147,9 +147,13 @@ enum drm_debug_category {
 #ifdef CONFIG_DRM_USE_DYNAMIC_DEBUG
 #define DRM_CLASSMAP_DEFINE(...)    DYNAMIC_DEBUG_CLASSMAP_DEFINE(__VA_ARGS__)
 #define DRM_CLASSMAP_USE(name)      DYNAMIC_DEBUG_CLASSMAP_USE(name)
+#define DRM_CLASSMAP_PARAM_REF(...) DYNAMIC_DEBUG_CLASSMAP_PARAM_REF(__VA_ARGS__)
+#define DRM_CLASSMAP_PARAM(...)     DYNAMIC_DEBUG_CLASSMAP_PARAM(__VA_ARGS__)
 #else
 #define DRM_CLASSMAP_DEFINE(...)
 #define DRM_CLASSMAP_USE(name)
+#define DRM_CLASSMAP_PARAM_REF(...)
+#define DRM_CLASSMAP_PARAM(...)
 #endif
 
 static inline bool drm_debug_enabled_raw(enum drm_debug_category category)
-- 
2.53.0

