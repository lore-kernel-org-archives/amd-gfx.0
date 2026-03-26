Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C0DC10ED672
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2026 12:40:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A571310EE06;
	Fri, 27 Mar 2026 12:40:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dWXrGn4C";
	dkim-atps=neutral
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com
 [209.85.160.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7825710EBF2
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 18:56:08 +0000 (UTC)
Received: by mail-oa1-f53.google.com with SMTP id
 586e51a60fabf-40f1a1f77a6so940397fac.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 11:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774551368; x=1775156168; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NRlPoGa7+iUNjeM7pxa7WPegOcsigZPqzY0YzlOOctI=;
 b=dWXrGn4CdyHwZe36ORUcenyNT/PfYW0BtBDSBhycZvEz9R1BLsWFAW3zzu6I/HcIOF
 sZm4wZVk91lMabf8MlEO7eOTOu9SInbflgjyBRdgCIf4IDyC9GGe0wjixfgBJrpSKVRV
 70idqofDDxSbdPvHqJfo0jE+69L8mBUj7jetGFB3z7hagGgJnbeR9iJKvVMA19KzpE7W
 0CKIMhdfHgFEfsrsHkgN/OmoNxi/nkfN+hGP8yp9xR099LuNXgbqOlUZReKaYczashLf
 Zsc4lr1adWPXdEs28eRo/DxKiAeW/4hWs38wFJT4lFQGVTGWrmw84xFXDrBLLPH4VH4b
 9yCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774551368; x=1775156168;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NRlPoGa7+iUNjeM7pxa7WPegOcsigZPqzY0YzlOOctI=;
 b=al4nDSyz3dXIzvA+yIfOBu5l9Ql0SUXLKc7kCcuckF2EFUvd2q9WF5jknqyy4/QtYv
 pz9JzQfB/3MjxBfJ/mw5yyaO28uD2w2I7mxTDnT9aXRtxXqz8kV8XYO86JCkbwpRARcx
 1AZnNG2C0AbpcHD2Ojcs+0xg07Z8JKxnz3PdFjO04zhI/i6M12SZcKLwC2lmKWzXuJlL
 YYI2rLtRF0Y7vFNbN0bFHDdRsyQrKUh/MrvzJH5A4PqmQJeePEDwKcoozSiznYaUzK9D
 J06hU9qXACI4wN08CaqDCWkMGk2ZFkAoMWr4/hRZoCkylQ7enaDuhubzTFHfzvfHx0rG
 k5xw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2/iqLYmhXNZ2zalRnVJOyUIoeRR0lu4aIX/eb/rFLPqgWWVndcEE1CMlE5gVUMbVvTKn6+nDD@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzmEsf/HO48nLqSuUzRQqW6yh7adFFy8Ii2wLtq2aoTH4ynGih6
 byooDTmGYW1WPD4fLyZjm6myfzcoZrRyyvA3sF9czVeAkQnPzPqCP09X
X-Gm-Gg: ATEYQzym4No3RNuL3mnK37ZI0C2giwu+uWFU16wp0rrHtRiGJ6J1GmJ92sbbZNN5hjH
 gY32wenN7F84lpKr8tsqSSYoeFKY+mePnymtELPxrNAsQl9UyhtWflnHJcGz/d8OZzhWJ94bOV+
 eQReIQOQgEjz8hkJQ60yaS50idvt2wwCjczU9ZM8y3vW0qygTffi6yquvXeadZg7o8h10oLMZsb
 3jsF4zby2ANZ3LMC+ByJH+OIma2MLfiDcZPzvv4PsJPh00PusHhfY61//tm2SqvIe5DZBVTf0p1
 Hazl6A1k1ScNgUOiCz7knFkCFKZYV9qA2BIw1h3lKSlxzVnUUsAtaxqGA/49Dlik/U3H2ULto6H
 +IB9lcrtQ//wSsm68O3YCICkcnir9jA6Xo9BU3CzJqg0NlR3EKNtrt0L68AylL4J+XhIdAjHd0P
 TEAq8Ulzj+wp/T5XQF+EO7pvAh7cZYe4OBmppZBU4jFeWSsGhLznmIKSqGNXg=
X-Received: by 2002:a05:6870:b493:b0:409:6227:d313 with SMTP id
 586e51a60fabf-41ca70d655bmr4566906fac.35.1774551367549; 
 Thu, 26 Mar 2026 11:56:07 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 586e51a60fabf-41cc7760c08sm3075171fac.4.2026.03.26.11.56.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 11:56:07 -0700 (PDT)
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
Subject: [PATCH v12 63/69] drm-dyndbg: add DRM_CLASSMAP_USE to the
 drm_gem_shmem_helper driver
Date: Thu, 26 Mar 2026 12:54:07 -0600
Message-ID: <20260326185413.1205870-64-jim.cromie@gmail.com>
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

The drm_gem_shmem_helper driver has a number of DRM_UT_* debugs, make
them controllable when CONFIG_DRM_USE_DYNAMIC_DEBUG=y by telling
dyndbg that the module uses them.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/drm_gem_shmem_helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index 7b5a49935ae4..bcc2c870d304 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -26,6 +26,7 @@
 #include <drm/drm_print.h>
 
 MODULE_IMPORT_NS("DMA_BUF");
+DRM_CLASSMAP_USE(drm_debug_classes);
 
 /**
  * DOC: overview
-- 
2.53.0

