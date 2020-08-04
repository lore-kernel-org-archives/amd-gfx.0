Return-Path: <SRS0=+8vs=BO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F3E6C433E1
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Aug 2020 21:32:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 709A020842
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Aug 2020 21:32:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=basnieuwenhuizen-nl.20150623.gappssmtp.com header.i=@basnieuwenhuizen-nl.20150623.gappssmtp.com header.b="fMhaVVSU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 709A020842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=basnieuwenhuizen.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C8F56E0B7;
	Tue,  4 Aug 2020 21:32:13 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C20326E067
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Aug 2020 21:32:11 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id 184so4326512wmb.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 04 Aug 2020 14:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen-nl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=i7RjU3C/5Tb6jLW/v4DIQIukxcUqY46qUqpQsce2gQs=;
 b=fMhaVVSURSGWXG/bmV+V+DtMYP5sBT9lppI7KPJnWoHE4YZWDzQL/H8oORCRccpm4T
 1fgaLyQJCx+Af+v2ydGWiWvTG3VBk7nxEzPHultgVle/GhDYxLmTGTD6cWH6+My4wluz
 mrRRJLLVDABB4jC0FKGyMJlwiL2QawwAPnitPz1hHeQg5sQPyeMeotTp+rPM9qZkzqTh
 RLwQDhj5UasVaxTCq6yOvoNE0ivvv41HNBU36cSO8A8mpELFJj3WJ9U1pyeCalyepGyO
 hrCQQM53Le4yGQEgv7WF9sWsp7VMs4HvxJAl1c5+3pQ/TySoInAqnF8DzQYoe3tZVY3o
 Xv8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=i7RjU3C/5Tb6jLW/v4DIQIukxcUqY46qUqpQsce2gQs=;
 b=gjNI+cljDJB3JBSQexeIPpy+pRBNoh3Kol3toLXVMlyafXEiv/AX5/TEa/tGRMrdnE
 JiK0dgbgiuKT8yXfbSCHkzdWHbE2wcPBmu86h8tpN6OH59gHnLuGnMAUJvGm2fdEwFeH
 Ej8cwa81EZwt9g52GppugGauXbxYIRG7SH8IyXbXdLdXhslkUe27jJmqXTiEEywdwOks
 4/38WhLhVNuo+/40BF26f9c0VCG14rMOEQqeIeucETa8tm5EC5k7yApmBRDKyvvxluhP
 VqNJt4sqDNC8KpsfSte8kiaKs60Pm/6wquGaEmc5mAJ5MEyP7nuDiDOP2TAwihYd3mn9
 Crtg==
X-Gm-Message-State: AOAM532YLopeyT28g6QdLY7OGJnxdXlVTOz1LHHXJ/3WxewhLR3QgE4S
 ESQaUanFtnOYYBqY1i6nUFTkxRtB9o+NSA==
X-Google-Smtp-Source: ABdhPJzyUZOS+6tMx3qeSYu6/OugEV3exrgg4HeWaOAqb/J9wpthzl7ajkvtheUuG/IuIEcTE5fA6A==
X-Received: by 2002:a1c:bd04:: with SMTP id n4mr356338wmf.83.1596576730183;
 Tue, 04 Aug 2020 14:32:10 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:aa12:a77f:2000:ce92:471f:873f:fc56])
 by smtp.gmail.com with ESMTPSA id x11sm97612wmc.33.2020.08.04.14.32.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2020 14:32:09 -0700 (PDT)
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/8] drm/amd: Init modifier field of helper fb.
Date: Tue,  4 Aug 2020 23:31:13 +0200
Message-Id: <20200804213119.25091-3-bas@basnieuwenhuizen.nl>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200804213119.25091-1-bas@basnieuwenhuizen.nl>
References: <20200804213119.25091-1-bas@basnieuwenhuizen.nl>
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
Cc: maraeo@gmail.com, daniel@fooishbar.org, dri-devel@lists.freedesktop.org,
 daniel@ffwll.ch, Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
 harry.wentland@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Otherwise the field ends up being used uninitialized when
enabling modifiers, failing validation with high likelihood.

Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
index 25ddb482466a..c2d6952d0a7d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
@@ -201,7 +201,7 @@ static int amdgpufb_create(struct drm_fb_helper *helper,
 	struct amdgpu_device *adev = rfbdev->adev;
 	struct fb_info *info;
 	struct drm_framebuffer *fb = NULL;
-	struct drm_mode_fb_cmd2 mode_cmd;
+	struct drm_mode_fb_cmd2 mode_cmd = {0};
 	struct drm_gem_object *gobj = NULL;
 	struct amdgpu_bo *abo = NULL;
 	int ret;
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
