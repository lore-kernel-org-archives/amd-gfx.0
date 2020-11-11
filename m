Return-Path: <SRS0=tzQw=ER=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD32C5517A
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2020 02:48:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 683732168B
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2020 02:48:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=basnieuwenhuizen.nl header.i=@basnieuwenhuizen.nl header.b="Ia7VUJyT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 683732168B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=basnieuwenhuizen.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA95889D7F;
	Wed, 11 Nov 2020 02:48:41 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96E8689D7F
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2020 02:48:39 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id s13so860057wmh.4
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2020 18:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen.nl; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ucHE0s+1GqoJzBFyor2rhj0xDvMhT39kyBkD1tfm0V0=;
 b=Ia7VUJyTe9goMrjNT1Rskr+9ZjxCHTawTijihzYf/XV7Eq420RZy610WGZOqgwjLWU
 5Jd/c8I7U8shGvJIVRpdWWr44HJzQOQK3M88CXv9nRc7AfGPSqLZprDH0kHiBW0cMv5M
 d0YTltPwOcobLMqt/zIfDhUaRgjOytvIiIO/gjR4T1Fssuuos6GM4eRJHd4W9mvpe6wH
 IitcJ72j6tng7UBUefREWGcid7JDi9GSHIT8I6G5HCGMCbCGwBskvKdjmymMm9DgArmS
 d/Jbk4jwoZc2cjfbdJxEI1YLBs5P7aNVD2QDyKbOolauguCPih0Jcdd8L2txojr3OiI+
 39mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ucHE0s+1GqoJzBFyor2rhj0xDvMhT39kyBkD1tfm0V0=;
 b=e+l/dyq9HkkpqECvSoL+Ty6IZ6WPjojZ8VGKGMeBzHwNAVWH7SCa5tmB/Mznpmn1Q7
 yorMKorw8XhZOojIYmXGT4EWcX3AT+Gxbe3b48LiD2knc/v194cdC58Cn6i73HTrx0j7
 2ubodzK18rih/Ae22+AuGP34qt8S2tGVqT7nzvvMVDw388KoAYuG7A3dHPU0I17xhXDn
 YqEsRh7E52DAvqO0OpNV3Fi2EQxFT51HmaeEf+EnKDboTnSN8ei31bc/Thxh0AWtukYF
 VQWk+b8gp7Hfsxnoc9qnkW472xfCZUn4nX38nS4FI2x008Hogmf8cieYw3vokZMRdFoY
 V1pw==
X-Gm-Message-State: AOAM533rjwcRg+TXlIovTIGKUKhFQX/tZN32o1wcYX/+PYr8YUqCxrkA
 n+gmLbU08gYlBK8CB3XPJyPlVjEXhrx6A+LO
X-Google-Smtp-Source: ABdhPJwOBkYVLnYN8ETZeC/kmI8MSArLaQ3tIh9uW2lBle4Smhvj8Vja4z5dKws9b5iM+lJsf7Lgkg==
X-Received: by 2002:a1c:2803:: with SMTP id o3mr1199214wmo.97.1605062918020;
 Tue, 10 Nov 2020 18:48:38 -0800 (PST)
Received: from localhost.localdomain
 ([2a02:aa12:a77f:2000:4cea:81e7:5fd4:93f7])
 by smtp.gmail.com with ESMTPSA id c185sm724498wma.44.2020.11.10.18.48.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2020 18:48:37 -0800 (PST)
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/3] drm/amd/display: Store gem objects for planes 1-3
Date: Wed, 11 Nov 2020 03:48:38 +0100
Message-Id: <20201111024840.496679-2-bas@basnieuwenhuizen.nl>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201111024840.496679-1-bas@basnieuwenhuizen.nl>
References: <20201111024840.496679-1-bas@basnieuwenhuizen.nl>
MIME-Version: 1.0
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
Cc: alexdeucher@gmail.com, harry.wentland@amd.com,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Also do the proper validation which was missed.

Besides the missing validation, not storing the objects in the
framebuffer led to wrong results in the getfb2 ioctl.

Note that this should really have been done for multi-plane
formats like NV12 already before modifiers landed.

Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index 89c3ead36501..e33acc3de286 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -695,13 +695,26 @@ int amdgpu_display_framebuffer_init(struct drm_device *dev,
 				    const struct drm_mode_fb_cmd2 *mode_cmd,
 				    struct drm_gem_object *obj)
 {
-	int ret;
+	int ret, i;
 	rfb->base.obj[0] = obj;
 	drm_helper_mode_fill_fb_struct(dev, &rfb->base, mode_cmd);
 	ret = drm_framebuffer_init(dev, &rfb->base, &amdgpu_fb_funcs);
 	if (ret)
 		goto fail;
 
+	/*
+	 * This needs to happen before modifier conversion as that might change
+	 * the number of planes.
+	 */
+	for (i = 1; i < rfb->base.format->num_planes; ++i) {
+		if (mode_cmd->handles[i] != mode_cmd->handles[0]) {
+			dev_err(&dev->pdev->dev, "Plane 0 and %d have different BOs: %u vs. %u\n",
+				i, mode_cmd->handles[0], mode_cmd->handles[i]);
+			ret = -EINVAL;
+			goto fail;
+		}
+	}
+
 	ret = amdgpu_display_get_fb_info(rfb, &rfb->tiling_flags, &rfb->tmz_surface);
 	if (ret)
 		goto fail;
@@ -713,6 +726,11 @@ int amdgpu_display_framebuffer_init(struct drm_device *dev,
 			goto fail;
 	}
 
+	for (i = 1; i < rfb->base.format->num_planes; ++i) {
+		rfb->base.obj[i] = rfb->base.obj[0];
+		drm_gem_object_get(rfb->base.obj[i]);
+	}
+
 	return 0;
 
 fail:
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
