Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 508E510ED66E
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2026 12:40:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60B5410EE22;
	Fri, 27 Mar 2026 12:40:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lZw+P64i";
	dkim-atps=neutral
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com
 [209.85.160.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B071B10EBE6
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 18:55:43 +0000 (UTC)
Received: by mail-oa1-f44.google.com with SMTP id
 586e51a60fabf-404254ffe8aso774943fac.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 11:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774551343; x=1775156143; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=irTrrnawNz+DXC6VSfC9mZGBC+I85t9C/e5XGxZ5eAQ=;
 b=lZw+P64iBfRYIMX/W9pc5CyUElmM4XV3yAGWsoA9zbyXdLBb1E3Tx11ju5j8nA8rUx
 T1zZFzpcqDzLLZPeeIGjsZu2S5DX6M+vzPJdJzfLzY1cohVK4urBaP8XalH/3tzugn3R
 9UVtUzjWZv/+9WcKephlNOlMnfv3HXi6aNMlUCdMzpX9CmOFCfSXTSUnxV7biEobJFLb
 OBmiSs3rD3+04LjownyUEf1aPPm6St/71MD2MQVgGbWQ/DkWWhRjI5ovDO1YXqlk3clv
 FRfBakrBgw/bQuIbNZ9cFSV2GCiz1ZwdKHA5CktqDsmd5TbKfZU9cSYwtjleNzeFpm/k
 hwOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774551343; x=1775156143;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=irTrrnawNz+DXC6VSfC9mZGBC+I85t9C/e5XGxZ5eAQ=;
 b=jHp6Czn1Hft4meEKm+FJJK1UMA++qya0nzLlE+vhcVrSqKERR68J/Po0QopcaJ7gpl
 X04pWyCYslrqucwPEJK2GL2unNfXAu03cW47OlbyhJxNkmIkr33phTU7aoqvJi3oa9lM
 n3HkTnzdwIu42jq/pn8KyKxP4bPHJD69kwwP6EKgBDB4PbaFjWuTI9oskO1LD84a/ihw
 zZjU7kRQIPH9pBNrg5ruKFjyjge0gknyBTC10qkJEW+TAqlf5z9Aw9ArxZ65QgdOhRbZ
 kz91JlmRugeXXsRPiuygWNoG1XUG5GaKS4trdDqmocdbfP56+YImGNm020U68P0IxuGF
 AIdg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+D43/odlNLCHvZNKSZ5g6vRT8zzbfmJ1xK/Okrz4UAUEQOEf2Gk/TuzeYUOgZXJVy2ARFFC93@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yynt5S221hpF+zfpYT4gbBiim5M1xxRQMMJz309vCvBteIaP/MZ
 gMShheFlhLQwc4N4C7Dk12NiPNGTfluqw5BoHl4dXYggoGoNBTarBNRV
X-Gm-Gg: ATEYQzxJzT+Miiv85GlZeLlrGsce1chz5CF1hvCbIrcanEXPC8MXQ9cGObQquKBRsC3
 jxjxXNNzP77Iy6k8pZlR1VhlaDFieHt4SZ9ZXOjmpS8r76ulF8illS/i26302V/X747BMiocyHM
 rkYWfsTNJTD9MxqShdz40gJuWgvaM99tsw1CAqGYyIxUNNXeahdY1o0hj6iOEnTJGAHi8GOp6zk
 b+esojWY85ysPyoSWVRLB74k4z6VL8FxMp4pMGLBvgwchx/IXG+0mcknV5jxI3+zK0RibuXAGvB
 M2RrFV7ejKmy0A5AteCkxivI1mXfVJUIAd86Jg6jr4gEHgGWU9Ljfnvqt/SeoRN0i1OZH77gS/a
 ZMxz4aEbLU1L7LCI7kogf/BNY3hmbVHywGjKFURq8i7KdlOw3D2CuyUDOCb2qJQpUxP5IlZgQEY
 15oav7hpBjh3d6pjX78ZuapbSUNK6a13ngD0/hsxTCUszpOtA0
X-Received: by 2002:a05:6871:e488:b0:41c:6bae:2307 with SMTP id
 586e51a60fabf-41cd7b9c264mr1725197fac.12.1774551342859; 
 Thu, 26 Mar 2026 11:55:42 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 586e51a60fabf-41cc7760c08sm3075171fac.4.2026.03.26.11.55.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 11:55:42 -0700 (PDT)
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
Subject: [PATCH v12 46/69] drm-dyndbg: DRM_CLASSMAP_USE in i915 driver
Date: Thu, 26 Mar 2026 12:53:50 -0600
Message-ID: <20260326185413.1205870-47-jim.cromie@gmail.com>
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

