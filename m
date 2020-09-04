Return-Path: <SRS0=eFkV=CN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 225CEC2D0E0
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Sep 2020 16:07:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5C1720772
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Sep 2020 16:07:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=basnieuwenhuizen-nl.20150623.gappssmtp.com header.i=@basnieuwenhuizen-nl.20150623.gappssmtp.com header.b="EF6OmSJH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5C1720772
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=basnieuwenhuizen.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27DF16EC7E;
	Fri,  4 Sep 2020 16:07:15 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FBA66EC7B
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Sep 2020 16:07:12 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id z1so7309107wrt.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 04 Sep 2020 09:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen-nl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dE2rJAPqiyT9tOUmyIj2SaDYVLXFYZg6Wl2vSBnlHxE=;
 b=EF6OmSJH+7dt89vuPxvV/hpSg3tH7SK0Uj32m20Prq4OQQ0k6DT2mO3blxHJNxP5u5
 FLKOTXOF8pzc4cUvspLiU1WLpEZ8faQCBAOlri333mOtn8L1KCesl/Nr/9pgz2/bS819
 krYvp9rdx72TkawdnK6MGnN3fxOLOI8BM4QdYLvSDxorSB7QaYejH3Nv9LB7q4tqqfIR
 imfKXMl/jvnvf4OB4NM1Lu6bH7FA1J5XiwRInSVwvsqJfszH3GZGAkWQty4yp8hxBYvK
 FQZyWPCmOGIuoDQh0mwdECkfP0h69cBm3+76/PbG7b1uAKbq83Eaid+m/e3Cv/r+9b8N
 isFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dE2rJAPqiyT9tOUmyIj2SaDYVLXFYZg6Wl2vSBnlHxE=;
 b=DvrZloFLsNSUCRjQFvBJl4cCf497rd5/DU2KGiJ5Q3YaNw2rhCdzLTSUxHpY0YxOzw
 dcFYwVTCdZyXdBKKCcCTyhtao1IDfRYtzGJThO3pZ8RgEfAOy+YEsA2VQB0NVN7LCwqu
 hr/IzlbZjEtu2TIzGiaDpnfnJ5NCIpnrG5FATNAmI2FP/eh4l98qoimCdL65UIMR5ylO
 USqYWTwymL/+5P8cvrWhFPvaZFAjqdVDnzWmJKy5OW4ViDm+pZBiP2nQv1cG2QGRCmRf
 0RbnNY8o0gg/WEt6oGM7PAVEQ8sWS8/HsSHb3yzUoG8qoLtEIpq7zFh35Mfdn5FjjjsZ
 o8Vw==
X-Gm-Message-State: AOAM533pmnz6PTX6uDYvco13zv8pFrHHJV+PTedmM2ehVr2WVdxSqRRD
 ijjWC8Ttt9El5tNL0NJq7SbaRDHn03TXvuXR
X-Google-Smtp-Source: ABdhPJzkIZgbva8zzDUZFSetEEloCYGaSf+WX6M3YWKP6pD/abJC24cUC3PPf1+KMjbn/CmJ4Lumtg==
X-Received: by 2002:a5d:680e:: with SMTP id w14mr7897158wru.50.1599235630746; 
 Fri, 04 Sep 2020 09:07:10 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:aa12:a77f:2000:4cea:81e7:5fd4:93f7])
 by smtp.gmail.com with ESMTPSA id h185sm12467609wme.25.2020.09.04.09.07.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2020 09:07:10 -0700 (PDT)
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2 02/11] drm/amd: Init modifier field of helper fb.
Date: Fri,  4 Sep 2020 18:07:00 +0200
Message-Id: <20200904160709.123970-3-bas@basnieuwenhuizen.nl>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200904160709.123970-1-bas@basnieuwenhuizen.nl>
References: <20200904160709.123970-1-bas@basnieuwenhuizen.nl>
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
 alexdeucher@gmail.com, harry.wentland@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Otherwise the field ends up being used uninitialized when
enabling modifiers, failing validation with high likelyhood.

Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
index 88ebdb3b3c7d..efc31bd6121d 100644
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
