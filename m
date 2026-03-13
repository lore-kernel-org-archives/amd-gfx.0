Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47CD6107BCCF
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2026 16:51:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93EF610ECB3;
	Fri, 13 Mar 2026 16:51:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YUN6izY4";
	dkim-atps=neutral
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com
 [209.85.167.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CCC410EC24
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2026 13:24:33 +0000 (UTC)
Received: by mail-oi1-f175.google.com with SMTP id
 5614622812f47-467161c4ba7so1424121b6e.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2026 06:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773408273; x=1774013073; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RCYC336WoUNdVp8/EmNZcTjPfopk7zVSApVc86osLdY=;
 b=YUN6izY4WAfT6zojS4VDTfnJAAAxMPUgONRwPSK6RQ5ZiMGMnK0AwAAileFH6moqDR
 e+Rfc6lMPhuQV/poWa/TmY0PPOaC0wt7ZjjJ3baEaYS81uH338mPoxzoGEnRX60CemXR
 iIvScED10NE4VPp9R1iSuR4EfqmSbvgJOIR2qlrhoHadrGM9WArmh7h8eLfzX3kpJH9J
 0kU8eYidDAt7/GB//jBUeuX+N70XkkXer+upxN6z7rpxE6htjMNT67QybxQ0tW2fr0Bm
 lYWiDruNK3kv06R12OhExrrvMEUCxYhL5bZz2KIsJ7FLeIjTgT0Cy9JxwjsNNM6HxzWQ
 MotQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773408273; x=1774013073;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RCYC336WoUNdVp8/EmNZcTjPfopk7zVSApVc86osLdY=;
 b=d5wKFJSO/QDKuwr4VD6ruazp2vCWgAfRVo4turSxCjFRh+8WaCDCtmKO7E2lOlu1Qr
 /u2Hrdh7ApvqwAfbyQ1qjwky1jn3/CijAYaNAqPuajDJuDX1JfiV09peLlbacfChqoF0
 YmWNOOEzj4rsUOyZoPj9m4l4ylF67t7LwrMo0Fb+vLBc1fm4XtQOaunBmE8xdP73ctd3
 KcVM/9K+N8lEq1/YuNMzVfIvFkRveFFYjdjKBRU3ZJAnR2BNOWyyPYUY7LFdQJFFri9C
 Ozb3UNI9ByXReMwDcNhxbUKYQJTP5Exh2U6V1FXjqb4gH8Z5LWEZ+Djkba65tTUtrX1V
 j+Ww==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDoZCc5/opHmcDSBRtVqme89xD0pofhU3Is5yXurWCkffuhx00sq8P81iaPswBTWD7fqs10zxd@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx9iHVhRzr8cxrAqkHTPqNCZy1iUfrHqwtg6lIlGhe3XUbPh1FG
 NZKx1/aZx6oUhdwIY2s79lUz6tYmNm6iQEyvzwce/Y7WnKnQF61eIZQh
X-Gm-Gg: ATEYQzyI5WnRMDnrspXg1JeiO8zeMeL4xR+7cvdFw8O4Ohlcp3Th7AYtEmmcC9hlN9w
 TXSR/u4IBat7NvUgAf1iPVwQJCQqWaFLuJ2oL11Mk+pcq2bX8bBYQHsCLMUPOG7NKQaFgxy71nj
 mgfTcaFCohQPPxVLsdLAM2c3+XUSPLQ8CQOEHCSPuwVEcnMIE13sxFzB6FJYw52tWadTAWdAY24
 a890PIpxZ13nmTryoam0GuVyHhEiYwhTA5orlVC0/wFEB39J9oAR1lFz6FTc8X1tRr5jU7VBhPA
 vXGn+HoXZxYsGmd9OyvHHT7F3cjTDQpKdi01taGefX+lZtyJnmkdTFHAdgNgQoiR7vJyJ2uGBjb
 sm7nRqzHqwy6DsLspzKISSUEyisf4Xx4HWMM0/kQhOXl3kUGP86R1cIKQc9H0Q6hyEhgxVYp5dN
 ye6o9c/u6z6DaP+R+gdo/aU5WBTKzuxSDizv40Si215+3HPhLL
X-Received: by 2002:a05:6808:1383:b0:466:f4cc:2b3c with SMTP id
 5614622812f47-467555834cdmr2362487b6e.8.1773408272824; 
 Fri, 13 Mar 2026 06:24:32 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 5614622812f47-4673434a35csm4795987b6e.20.2026.03.13.06.24.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 06:24:32 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: airlied@gmail.com, simona@ffwll.ch, jbaron@akamai.com,
 gregkh@linuxfoundation.org, David Airlie <airlied@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Chia-I Wu <olvaffe@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: Jim Cromie <jim.cromie@gmail.com>, jani.nikula@intel.com,
 ville.syrjala@linux.intel.com, christian.koenig@amd.com,
 matthew.auld@intel.com, arunpravin.paneerselvam@amd.com,
 louis.chauvet@bootlin.com, skhan@linuxfoundation.org, pmladek@suse.com,
 ukaszb@chromium.org, intel-gfx@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH v11 45/65] drm-dyndbg: add DRM_CLASSMAP_USE to virtio_gpu
Date: Fri, 13 Mar 2026 07:20:10 -0600
Message-ID: <20260313132103.2529746-46-jim.cromie@gmail.com>
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

virtio_gpu has 10 DRM_UT_CORE debugs, make them controllable when
CONFIG_DRM_USE_DYNAMIC_DEBUG=y by telling dyndbg that the module has
class'd debugs.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/virtio/virtgpu_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/virtgpu_drv.c
index a5ce96fb8a1d..aea4c117b006 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.c
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
@@ -49,6 +49,8 @@ static const struct drm_driver driver;
 
 static int virtio_gpu_modeset = -1;
 
+DRM_CLASSMAP_USE(drm_debug_classes);
+
 MODULE_PARM_DESC(modeset, "Disable/Enable modesetting");
 module_param_named(modeset, virtio_gpu_modeset, int, 0400);
 
-- 
2.53.0

