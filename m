Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45B77C25B79
	for <amd-gfx@archiver.kernel.org>; Wed, 22 May 2024 06:26:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54F0210F382;
	Wed, 22 May 2024 06:26:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dqIXdmr5";
	dkim-atps=neutral
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com
 [209.85.167.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D63B10E562
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 May 2024 06:26:00 +0000 (UTC)
Received: by mail-lf1-f46.google.com with SMTP id
 2adb3069b0e04-51f45104ef0so5935351e87.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 May 2024 23:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716359158; x=1716963958; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NAWjwCLmat0Pt42wss/KcevTPw7T7NPDEdWBIi4Ib0k=;
 b=dqIXdmr5Zz/3jon78qS+wfyU1lnoG1LrarT5dks1x/Tix3iDNNeIOS1uuvhpsA+yUq
 Ym1gQHXN4MjwKdDp2WewGPSf7hxwEuuEBk/Cw8H3THU5nHZXiKCx/DYzU7cjVNDNdGKe
 bZP/4rq0M43kr6v/bK35avumlTyFPCkuuf9ew2JHaZ2e/pmU0zHCEpOeWX4EGIv1sXpU
 UNZDVYfmLDinfgCF/7XGHO4c+2Vk+hEGHdGFDxbi2CVBU3wK+4yxQBTtXvOvdy9t5q2y
 c9pCjETG0OpQmSg5nqgweRYlCcY3XSWB3/Ge/bvuQAnrrc1aZnbR6hIH4dAbj0r7NWV1
 NZHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716359158; x=1716963958;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NAWjwCLmat0Pt42wss/KcevTPw7T7NPDEdWBIi4Ib0k=;
 b=wln6zmUSF+R6VaxRd+RaRFzikxTzGJk2d1M6mJYKYUcDNXjOxwb+apZyNhJiyJfQSU
 53fQ+VGj3xqraOETwd0e9c5YysB+DVVJDuuO6nYWjcBXEMY38llzirazmtfd6sG3ER81
 Two8S3fT6HhtMQBOHe8N7KXRCvjKJJPGPoGH2bhadHexleLI/C1eBiOAJbe7zrpwODNC
 S0JRbrq9EAmFDokzAHekf4TzrjlchMPki6z48LiL4SBu+ccodV66FGBUK2595JtDa3y0
 2gHeHGejcYViooBWfsNKvC1Rbx5bi9ElNApl4QnmjHuUdXIRWM1otFGUNphNXzoc/jbm
 LKxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJAY6d7BQzbknODT8UGRpoX/7fPbT0vgKbOzz7IhdkaQTyHu997zXEs8+0Bjcb4kd3UAb/+I8Gu/NTlsZdLOlPbiZ/0a7ArztZuQs2pA==
X-Gm-Message-State: AOJu0YyMaE+udelaj/v8uifid3Is/mm7+jyek/SAHjXhoepYFDTjX1/l
 2MMtiaSBOfzgSKD5AXzY0SNWm6iDKq8aw+BKD3g0JolWbBNGCRREn2ti/2YR/0U=
X-Google-Smtp-Source: AGHT+IEW+S3+sVgdb7Ioh3lWeKabvLfqA+b3mZ7ScIiWLt3n37PheAoJ6ahbaI04M7Q2NlUrqW9u/g==
X-Received: by 2002:ac2:43a4:0:b0:519:5e81:276d with SMTP id
 2adb3069b0e04-526bf35cademr539325e87.31.1716359158307; 
 Tue, 21 May 2024 23:25:58 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-521f35ad4d0sm4910023e87.49.2024.05.21.23.25.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 May 2024 23:25:57 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 22 May 2024 09:25:55 +0300
Subject: [PATCH v3 3/3] drm/panel/lg-sw43408: mark sw43408_backlight_ops as
 static
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240522-panel-sw43408-fix-v3-3-6902285adcc0@linaro.org>
References: <20240522-panel-sw43408-fix-v3-0-6902285adcc0@linaro.org>
In-Reply-To: <20240522-panel-sw43408-fix-v3-0-6902285adcc0@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Vinod Koul <vkoul@kernel.org>, Caleb Connolly <caleb@connolly.tech>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org, 
 kernel test robot <lkp@intel.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1104;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=0ZNKdxQ3JQtZLj0Gm+s5zrogyXn00ZSW+UEFR2j6wX0=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmTY/yjvD9VQu7L2gIRW8vekBVTwOXaxbDR2pMu
 FPr9Zp7kVKJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZk2P8gAKCRCLPIo+Aiko
 1Q+kB/45cboCZ7/CfpexfH4y1ofxb4sjLn89zKrylAAgkFqw4wtjybX5pUvHhR2h0TJVS3hPsqe
 O4qvHD/4C3vZTPQcnCZUOAx1QEtRPUMCg+vF4aw925FhwDUGrg2vqpJJpbaEYNzEvoncyan8fwv
 m2INUzUrPYiwj7C/kO6GFKMfXOOP62ANl50Aeno+vO0ZlYpzqZdu+dgP8t8zvDt7r8qPgU6+EIa
 2r4WjEeCRcH9ydw6/GabNsTVdbCWo2FlwNwrByNoZEZi5c+GGCPnyEHnvwxMYCBntEuV9eCEHwy
 oQ3vg6J5dglMkju2nNaXnoHtewp2IeYb7vLJVmRWTFjzkuD4
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
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

Fix sparse warning regarding symbol 'sw43408_backlight_ops' not being
declared.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202404200739.hbWZvOhR-lkp@intel.com/
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Fixes: 069a6c0e94f9 ("drm: panel: Add LG sw43408 panel driver")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/panel/panel-lg-sw43408.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-lg-sw43408.c b/drivers/gpu/drm/panel/panel-lg-sw43408.c
index 115f4702d59f..2b3a73696dce 100644
--- a/drivers/gpu/drm/panel/panel-lg-sw43408.c
+++ b/drivers/gpu/drm/panel/panel-lg-sw43408.c
@@ -182,7 +182,7 @@ static int sw43408_backlight_update_status(struct backlight_device *bl)
 	return mipi_dsi_dcs_set_display_brightness_large(dsi, brightness);
 }
 
-const struct backlight_ops sw43408_backlight_ops = {
+static const struct backlight_ops sw43408_backlight_ops = {
 	.update_status = sw43408_backlight_update_status,
 };
 

-- 
2.39.2

