Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88A68C43458
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jul 2026 22:21:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2303410E36C;
	Wed,  8 Jul 2026 22:21:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AJzTImP8";
	dkim-atps=neutral
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com
 [209.85.128.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C582110E36C
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jul 2026 22:21:11 +0000 (UTC)
Received: by mail-yw1-f173.google.com with SMTP id
 00721157ae682-80cebd41372so19657567b3.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 08 Jul 2026 15:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783549270; x=1784154070; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=6ryEBOu0tdMaJYn0ZWk82G78CEwzIufJFF6xesijT5I=;
 b=AJzTImP8z5+C4a/AqLFGI6+CP72moPwCjMvpTtdV/+h90bZOV8onysxCNm5hHJFXNm
 Z+FxTzr0paLCu87JzIsgDyycwXTM7AGVWo0PEwLw+qauztUNtrYgBwRZQJDF/klANGvm
 ZypKVkTpjYs+I5tGqtPaASodUISamBIs6YaLnz+f9y/3TbAJD3gC012l1SmhkoIN5oDK
 VwW4y+tZzaLcr1JDYARkgYt2U6ljXZOpwWByJLR2CKYIIqKjJVEvjL6+K89S1qdLHnt9
 jXezdKZR0pItPyULoZ0JC7m8wYxGZOVImTPZMArDQaIE1KblsTAQIH8PGToZPHIStEms
 YUHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783549270; x=1784154070;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6ryEBOu0tdMaJYn0ZWk82G78CEwzIufJFF6xesijT5I=;
 b=X69F56Sn3zkq4vjF1a03844tGe12ziXB4g920bClFQQH/WoG/+zGyZroY7TUProuWd
 JFsD2EPmtDxvg68QnJK0DRmJKcYvzjnRETysHcPrzoLlgyN9zgXjNUL5ZldV748DLen5
 Y4XGS7DJNwWPBqftejcLOLKpegpsqnMaG91+jjxyo9A0C7IvwFwcUDJvV3N/WrB0Xbzx
 lZwIHpjoFkYXmRJZPz32h4JeOSkYkQ9IzmpY4gi8+Ep3WQLphsKqu9cbyiSJqX68yuSt
 IkxxnBOVEZBmNuYW/HyYStN7Qucu2IVGzHFl+Eab48NWsFqCxDO4oc/K7byj86/YyjxY
 8ang==
X-Forwarded-Encrypted: i=1;
 AHgh+RqqDe6vhsTqviJk5No0BRZIXazbL7DvUsmnOKQEMssocaeL5YufVLFgrdha4Q7E3yDWdG04MXP7@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzYocZKTeDqltD2wc0jXM6YWoz7lA+2dI/rDKE+kwLchBfspu+9
 T70DN0jWmRzFRIrAAJi+3kZvtH4DXsDIGt7soZnUgEQpVlTFTU7/UQQ=
X-Gm-Gg: AfdE7cn51mUKa8CQ5Ki8gGOJMsEJ6kAKDyq0SfYoSY8VSBuXh6SaU5/dzmZB6DSH/QM
 RAxxOz/VcvhJb+NlBeroxzO4GTXEBtzdmuxpdcAfNuX+ubagzOJoTs8HBPTgnzqKMGpsiXE6BQT
 A/+3Wou876ZJ4gDUvisiPYKOJi14IhEe3KUSaLNjnhdBTuDhaebehNARN/fAYzMMrWZoLUjsiE4
 wvZN/r3CcFoLzvadtedkm7xIF1WlKH2OfesDvh9zzSe6ysdwFi8dS49BqfRH5HeqQ8N+A2nUejf
 v7lg6hOJlEGqaC2qd6dSdDgtx6EDq75uwf2PZPJZ7xcIl2l+ZqxQXbYq80O7qgAI+GNY7yxjGvk
 M7nErxlGGfddxINDugbCNot9fuzBdSyn3ycsrJdAs2wOMchD8YQapRE4xeIQ8KmFAmk5mq+M5ko
 wRiok5zprZLr7EdImuR+0XRTbFw+zrHenE9+dQTyahs9UdJBqU/a7xrmRorMQzHO+9PA==
X-Received: by 2002:a05:690c:4b90:b0:80d:a249:486c with SMTP id
 00721157ae682-81dbbe3b5b4mr36173027b3.3.1783549270397; 
 Wed, 08 Jul 2026 15:21:10 -0700 (PDT)
Received: from localhost.localdomain ([186.158.238.108])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-81e6bf653desm3151417b3.17.2026.07.08.15.21.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 15:21:09 -0700 (PDT)
From: =?UTF-8?q?Nicol=C3=A1s=20Antinori?= <nico.antinori.7@gmail.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Thomas Zimmermann <tzimmermann@suse.de>
Cc: =?UTF-8?q?Nicol=C3=A1s=20Antinori?= <nico.antinori.7@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Brigham Campbell <me@brighamcampbell.com>,
 David Airlie <airlied@gmail.com>, Shuah Khan <skhan@linuxfoundation.org>,
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Inline drm_simple_encoder_init()
Date: Wed,  8 Jul 2026 19:20:21 -0300
Message-ID: <20260708222035.7324-1-nico.antinori.7@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Simple KMS helpers are deprecated because they introduce an unnecessary
intermediate layer between atomic modesetting and the DRM driver.

Inline the functionality of drm_simple_encoder_init() to remove
dependencies on these deprecated helpers.

Signed-off-by: Nicolás Antinori <nico.antinori.7@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
index 170adaf7e76a..d5b0692fe860 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
@@ -2,7 +2,7 @@

 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_edid.h>
-#include <drm/drm_simple_kms_helper.h>
+#include <drm/drm_encoder.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_vblank.h>
 #include <drm/drm_vblank_helper.h>
@@ -316,6 +316,10 @@ static struct drm_plane *amdgpu_vkms_plane_init(struct drm_device *dev,
 	return plane;
 }

+static const struct drm_encoder_funcs drm_encoder_funcs_cleanup = {
+	.destroy = drm_encoder_cleanup,
+};
+
 static int amdgpu_vkms_output_init(struct drm_device *dev, struct
 				   amdgpu_vkms_output *output, int index)
 {
@@ -342,7 +346,9 @@ static int amdgpu_vkms_output_init(struct drm_device *dev, struct

 	drm_connector_helper_add(connector, &amdgpu_vkms_conn_helper_funcs);

-	ret = drm_simple_encoder_init(dev, encoder, DRM_MODE_ENCODER_VIRTUAL);
+	ret = drm_encoder_init(dev, encoder,
+			       &drm_encoder_funcs_cleanup,
+			       DRM_MODE_ENCODER_VIRTUAL, NULL);
 	if (ret) {
 		DRM_ERROR("Failed to init encoder\n");
 		goto err_encoder;
--
2.47.3

