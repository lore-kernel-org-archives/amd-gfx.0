Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6144D10ED66F
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2026 12:42:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D239810EE3C;
	Fri, 27 Mar 2026 12:42:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pcfIllgo";
	dkim-atps=neutral
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com
 [209.85.160.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C6D010EBF0
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 18:55:46 +0000 (UTC)
Received: by mail-oa1-f48.google.com with SMTP id
 586e51a60fabf-40423dbe98bso539853fac.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 11:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774551346; x=1775156146; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QuXW2pVB+6BOeyoEL7PCyteLSTsnkRNE1etSyCy+RQQ=;
 b=pcfIllgorXhiBb3aPESWJRL7y1GQUgFiOm5kjwHDtiJgv7b8WvqlPgaZxhSRFOjUuQ
 ZcdcjVMrnSMvcdVFTQVEDV5lSsab3RbI5A6t+ePjpv0BG18b/Hrtx7EjTUfry7wQl3UZ
 xKvFA0im0WiA405UPU7AYbFC2tztvpZO48Fbv4ENlWo5Cv54I3+DK99mVwLpiVl+usBj
 qtA4u6WZZTpnFJQSuPiEPL6yv/mEZ4iUTKhVo/44RWxaWLtn9/f4RS/DHXunGJEIJcKR
 CzBODzxfAYlS7QmLc9h6uj66oHPaNnagi3qO/Q7twukre6WrLBpP7YvRg68Jj324qUwL
 WJIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774551346; x=1775156146;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QuXW2pVB+6BOeyoEL7PCyteLSTsnkRNE1etSyCy+RQQ=;
 b=YD6rufz2m2bty56LYuReeu/Ekqp0TWJr7synv6KcsFwZsmRdgN0lrawbn4fDudLJVQ
 xJwUBvW32dXxXYjpfcwiqSJnqF+kSg9gMA4wZAbBrkETvaYyIALq9yXhEIwQDkmzX2iq
 CsDv6qZB651HGoHVkSBuwO4VvAZZ0sKfJPMRpPav7TJvZ60zbk7g+6Z6QUUby6aGZ+Q5
 qf3/sVte1YW0tq/Nm5RmuWsZMG0urWqLh8ubZ9V7G5UaWILu26ubD3XFtpEDUnLH5qeb
 GvVpOOAgAjVbcg1zjZGyH8jLxKDnYjIo5sHBh84jtWOFMD8/nHOfXmIXiWmRjv5dsHlw
 5Z0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6JnFpRYpr7n1fUkj+FqdCfbBsfPVx4aMPpjp5P7qm/pOc2ksYYZby8qk9eyje/+xBdcZvsaeX@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzbirKANKo/HdyC/Q42818b1iwy+Mt5lBNNrjWRDHgCS+t3wUU6
 AU8EHxbta1bzvUCxdrBm6NfC+8oKUjx+nGtyeoHmGiI6yejwUhs/MXhu
X-Gm-Gg: ATEYQzynfgK8U3o0B918DgjvqSzuB3NxBXSXJdwq5tn870H6b5lqZ6mHg08+YpEWWVi
 w9z0zxdV9tf09xc4w6EphrpX0sfNPNZ/Gs5aY7Ql2cbEUzwuoARxHGd3GXFdO0LlxSBFl1E3xow
 4kfghSU5Lmcm2YjNNibriaO2VtR9/Rv/VF9AV2eaUWKL8mXe49rfvjflBd0l9s2wseN8nmxQCdz
 JDKvDr1lCD2jSZGrnfeLxuaHCqQ3KtDPwztcSptZAJQSDV6BdxQl7YIuDhN4ZcZTVUJvIc3vD7S
 hty81CYuUWuiyHzfIGfbV8OXhye08rKPVWpOcG91BQOK0Y8lHAg/20yLEY2Ks199lEWc1vrqteF
 yPSAqP0uBOwkxuMNqx8oX4zU4oj7fJeHZLYok8fNdLE7PeMvSoYIdce3M0plbcrLneTIumagK69
 vOVgzwVEWfAvGfuJgmqT4w8QfCjPsuJp1nTuzpQCe8wMe4CpIe
X-Received: by 2002:a05:6870:2e93:b0:41c:b780:93c with SMTP id
 586e51a60fabf-41cb780158emr4153585fac.8.1774551345778; 
 Thu, 26 Mar 2026 11:55:45 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 586e51a60fabf-41cc7760c08sm3075171fac.4.2026.03.26.11.55.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 11:55:45 -0700 (PDT)
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
Subject: [PATCH v12 48/69] drm-dyndbg: DRM_CLASSMAP_USE in drm_dp_helper
Date: Thu, 26 Mar 2026 12:53:52 -0600
Message-ID: <20260326185413.1205870-49-jim.cromie@gmail.com>
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

