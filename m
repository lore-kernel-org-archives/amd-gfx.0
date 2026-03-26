Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF71E10ED664
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2026 12:40:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46C0B10ED7D;
	Fri, 27 Mar 2026 12:40:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AceqeUAA";
	dkim-atps=neutral
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com
 [209.85.210.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C952F10EBF1
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 18:56:04 +0000 (UTC)
Received: by mail-ot1-f54.google.com with SMTP id
 46e09a7af769-7d7e565c877so677810a34.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 11:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774551364; x=1775156164; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jUW+eTRlaAbHOLDd6X1oNyvzhDfkwQ9M9VIyPQZn2Pc=;
 b=AceqeUAASmYrB+Yn6vZD4ll2gGiHJ5CYXL0iGLMhrGLcPDLVtxeXnf26V+x1DR90de
 VShXFkgux1UEott3lKTJgyt4S6J2kHP24YDHzDEKgnoEZ7pKNvb1EueBxIZJ7uE6GNbu
 WrNSxTORF8dNRsraijWZrTJjOsA5/zD1KDngeOdpb7mxDxZqDW6gMfxejYnNa0UawRVr
 fx8el25nqspEj9LccL6PWA3IW682vxLTQ9zgFX1sY+iPYTvFZXRiRUOHhltzWOgL5dBq
 fqjYSPDI8dAbBKLYe9kl+P3TKteEY1Px2vnq2VCLoppi8t3ZIbWnLRIkJvwM7oTna2he
 49VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774551364; x=1775156164;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jUW+eTRlaAbHOLDd6X1oNyvzhDfkwQ9M9VIyPQZn2Pc=;
 b=WZIiqjfS7qXbo5mV35wN/BwX45rSDhRE12e2+uwxtV1q/saVBo5J4Csdrpqx95ETWw
 BBVF7A8Fa7ZchWJ8hKs5dPHrcZXm65/dhG1MIo09Kg/SWMfAi6Jb+AfCcqJGqRs5bc3v
 I/M9QqqF/S6lkakJATZGyYJGt2zy2ks4rZ8Ur9qQSA0qpmfEbyQPMbEiKR9YkhcXgE+c
 QvdUcqSULQEdDnd0vmMvWJME7BS8JCVTPeZzkHL28WI+0MtsLYvH1qraQ8IYiEot435u
 mRrxG8yAo+H5kLT70wSkfQaZeN83jKmtHZFQQ9vIxoCFU5S/juPYk+D5JRFRpPNse20x
 nEqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEU+5MPfciOCjXlBYMy1CRNVXR49/U6+AWjiLGDKCTloxxGdzl+OOdb0iYwepH95hyEYcUgZ92@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz4LCzDHJfxIHCw7jCtgg+9adAb4tdae6CreqWkgYnk7TTRnxO/
 JiYE2IJLuNBh8ydpysEjHTQrJ+7RD9XIEHL4KVH9vqzpBvLi14c3q5fe
X-Gm-Gg: ATEYQzy+GaAWdEofHW0JJdeDLd2fGl2ZgnWX9YrFnaO3B0N9ORuT7egPSIyfvA7Sl1a
 8TFrSDJVJRyjgZp77VFvAbgfMcCvLq10veOhk6FB+avUysXsVkZgv2cunliBEg9bF/Dp3xha+ld
 JwZUVhKAmhHSHAW1MR2MT6jzpvzTa1VB3bLFDl5Y9SmnSeiwJEchCpT3TvBS3xgHIDkT5SsaQ3I
 0wt6e2mN03jwXjSx7RGkqiNzBBykmNmm23kA/KHFJ8UegpqYeJPXp4B6mny1r6nX2mAMHQrEtqh
 VuTBviZLuklZ7NZ6MUtKcjShZ5CQn7ZuGYXfuZiPQvVrCqzgjYidUDIAAeh19mGYoAI9IGtsZPQ
 /GzmsxGLIomKInfrReptPWE0+F3p7/CtXA9ggKmrjrPUfWdiEfDpUXTuo+DxKv1oKONGlEXC9xC
 PqHqWJyctK1wqUewzDFxK87iqtGjh23rg3IrP3DJWIJQecIrAH
X-Received: by 2002:a05:6820:1909:b0:67b:be3b:ec49 with SMTP id
 006d021491bc7-67dff4039b0mr4290155eaf.21.1774551364004; 
 Thu, 26 Mar 2026 11:56:04 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 586e51a60fabf-41cc7760c08sm3075171fac.4.2026.03.26.11.56.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 11:56:03 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: linux-kernel@vger.kernel.org, airlied@gmail.com, simona@ffwll.ch,
 jbaron@akamai.com, gregkh@linuxfoundation.org
Cc: jim.cromie@gmail.com, mripard@kernel.org, tzimmermann@suse.de,
 maarten.lankhorst@linux.intel.com, jani.nikula@intel.com,
 ville.syrjala@linux.intel.com, christian.koenig@amd.com,
 matthew.auld@intel.com, arunpravin.paneerselvam@amd.com,
 louis.chauvet@bootlin.com, skhan@linuxfoundation.org, pmladek@suse.com,
 ukaszb@chromium.org, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 Ruben Wauters <rubenru09@aol.com>
Subject: [PATCH v12 61/69] drm-dyndbg: add DRM_CLASSMAP_USE to the gud driver
Date: Thu, 26 Mar 2026 12:54:05 -0600
Message-ID: <20260326185413.1205870-62-jim.cromie@gmail.com>
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

The gud driver has a number of DRM_UT_* debugs, make them
controllable when CONFIG_DRM_USE_DYNAMIC_DEBUG=y by telling dyndbg
that the module uses them.

Acked-by: Ruben Wauters <rubenru09@aol.com>
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/gud/gud_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/gud/gud_drv.c b/drivers/gpu/drm/gud/gud_drv.c
index 17c2dead2c13..c49f9135dc7a 100644
--- a/drivers/gpu/drm/gud/gud_drv.c
+++ b/drivers/gpu/drm/gud/gud_drv.c
@@ -32,6 +32,8 @@
 
 #include "gud_internal.h"
 
+DRM_CLASSMAP_USE(drm_debug_classes);
+
 /* Only used internally */
 static const struct drm_format_info gud_drm_format_r1 = {
 	.format = GUD_DRM_FORMAT_R1,
-- 
2.53.0

