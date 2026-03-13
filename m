Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BB76107BCD2
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2026 16:52:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2446910ECDB;
	Fri, 13 Mar 2026 16:52:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WdlIUNs8";
	dkim-atps=neutral
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com
 [209.85.167.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B1B510EC1F
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2026 13:25:04 +0000 (UTC)
Received: by mail-oi1-f177.google.com with SMTP id
 5614622812f47-46701f2077cso2600383b6e.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2026 06:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773408303; x=1774013103; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZmHuo2gpKk+a4rM0v+S94FJooBnanLI4bt90pYFjtcE=;
 b=WdlIUNs8jVU09TTFtkAQFzt/PZG5qNnFsuuiRJ/khBU3BGmXcnCbsIcu8vfLV3fcgT
 apUX3jzndETlbFP1+3sIKYcSjCAEmZYSh6l1qlZ6tluzI5vmqMRavC0h/Eb9Gv29rpQ+
 fLnJCVCH6tuQWZkUc9HwIWzbwDScdvApQGdljvcugN5aWzqOPXNVoF1UNe9SbAfqjvHI
 CJVBZRUXPXny05aMX/zJu8wptnX0vM2v8L046QZfXYUY+OU3s4AESnIcN79Qkn49byZ7
 6oXusQ86GB2d/ktYEzZpQU0mHHWjvym6L64cm339HFCLL8wlh4KqeL1YkebgbO9TMmCr
 Z/cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773408303; x=1774013103;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZmHuo2gpKk+a4rM0v+S94FJooBnanLI4bt90pYFjtcE=;
 b=IpyrhbJTOyHBC7qm2wnnSXftlgBT7XrponAfOX4k09lqhzC+GGGIKFeSVaNi/2Sg2v
 4oYvkbhk6KQMiqEbMiN+gSWfnEUDQhkU/0ZuHeoOMTLz+iwbV2/QiWDje9LhlZdswupM
 3YK2RgzfiugBSQN5QpIUEXV50DZTQ8xINFuUCP0/CVhq58NEVb5brKWf2KtDjp/L901E
 P8KZItWy9+nKFC8Y21yNUqN6jzrMSUXQ8TjBPxXu9I/FcBsDk78zN8KYjbSmo13xSjX9
 6UEva9oPZcpVXuLoYspSXJ9MCpgaDOSXqgqg9wZjPYMLB1BIHCSZrnBHnEe8H5PoXjE0
 +cOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjajDJorrZg8lAGP8mD0ZxcT9S3IOo5LYXx5jljF8fxLW8dEI77UtGKgzukE7p82szYnsGDmK9@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwSHjjlDtgHkjuA30uGpQbx3hQJFqOnXMAUwgAOhC+5P4GqXxFK
 Ngt7jtpc5gNC0p5JNs0D/p8HdTjIn3TJAHmDJyehL2JH8GTHoOZT9CxLxi3I7xXk
X-Gm-Gg: ATEYQzwpoSCLTyuMlPzdz7BFzRpteHU78c69ulu2j/nDCj7RWgyiT7A5fbSHm2uabtH
 QWUvRUDC2l+jx1Gx6+2SQlqonddPbMbuqwT6+RyangF5rLSmPLPHuUkttXuam6+6gRob5XVlLrn
 50iR/w2oixungXexzLJnH1vc8xCZFFV6ecqsjH4jcTmR+I3YVQ86su/88DZslY+vm9MDV80CM2t
 7FTYfuOGht0XF8/dA2Yoiq1jLIn/7Ved0h40PQ9fJn7iq39ZbdyAlOTlbROTpm25e98j+qBhozC
 qwiZQMu6PpaL6LtQmP10CBetCusvhrgKABPwVajnFGAkoHtfg2hdXdRYY1cTbq/Ibnx2AQmKd37
 c5w6NWcEEV2co7GF08vUS4WxyLHN/1NWLj0FHKpO+CtUo17ski7YsMurYj9U7orCUsIsV2oZWS7
 /jdcm6AlZEXlblQIPHOp9PdRUiiz3m6PgQa+Vw7u+DRn1Njgiq
X-Received: by 2002:a05:6808:190e:b0:467:2be4:9e33 with SMTP id
 5614622812f47-4675552dd65mr1929280b6e.6.1773408303348; 
 Fri, 13 Mar 2026 06:25:03 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 5614622812f47-4673434a35csm4795987b6e.20.2026.03.13.06.25.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 06:25:03 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: airlied@gmail.com, simona@ffwll.ch, jbaron@akamai.com,
 gregkh@linuxfoundation.org, "Rob Herring (Arm)" <robh@kernel.org>,
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Jim Cromie <jim.cromie@gmail.com>, mripard@kernel.org, tzimmermann@suse.de,
 maarten.lankhorst@linux.intel.com, jani.nikula@intel.com,
 ville.syrjala@linux.intel.com, christian.koenig@amd.com,
 matthew.auld@intel.com, arunpravin.paneerselvam@amd.com,
 louis.chauvet@bootlin.com, skhan@linuxfoundation.org, pmladek@suse.com,
 ukaszb@chromium.org, intel-gfx@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH v11 61/65] accel/ethosu: enable drm.debug control
Date: Fri, 13 Mar 2026 07:20:26 -0600
Message-ID: <20260313132103.2529746-62-jim.cromie@gmail.com>
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

ethosu.ko has several drm*dbg() calls, it must call DRM_CLASSMAP_USE
to tell dynamic-debug what classmap enables them.
Also include drm/drm_print.h explicitly.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/accel/ethosu/ethosu_drv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/accel/ethosu/ethosu_drv.c b/drivers/accel/ethosu/ethosu_drv.c
index 9992193d7338..a0b8cb81a359 100644
--- a/drivers/accel/ethosu/ethosu_drv.c
+++ b/drivers/accel/ethosu/ethosu_drv.c
@@ -17,12 +17,15 @@
 #include <drm/drm_gem.h>
 #include <drm/drm_accel.h>
 #include <drm/ethosu_accel.h>
+#include <drm/drm_print.h>
 
 #include "ethosu_drv.h"
 #include "ethosu_device.h"
 #include "ethosu_gem.h"
 #include "ethosu_job.h"
 
+DRM_CLASSMAP_USE(drm_debug_classes);
+
 static int ethosu_ioctl_dev_query(struct drm_device *ddev, void *data,
 				  struct drm_file *file)
 {
-- 
2.53.0

