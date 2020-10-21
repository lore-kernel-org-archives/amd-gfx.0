Return-Path: <SRS0=buuZ=D4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92721C4363A
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 23:31:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 247462225F
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 23:31:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=basnieuwenhuizen.nl header.i=@basnieuwenhuizen.nl header.b="EIw+jB1V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 247462225F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=basnieuwenhuizen.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1FA66EEB6;
	Wed, 21 Oct 2020 23:31:41 +0000 (UTC)
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com
 [IPv6:2a00:1450:4864:20::644])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B3CD6EEB1
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2020 23:31:38 +0000 (UTC)
Received: by mail-ej1-x644.google.com with SMTP id p5so5684909ejj.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2020 16:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen.nl; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XhQdRpTZQlvWNDL2xph4d9tIaqYvR6Uizqzqj0oGHbQ=;
 b=EIw+jB1VQyUyH079p9RZI1SqWtu9EhZ2jvjalpJYjGSnjhwSReub1KJXrJIdNOlCss
 PmK2J0Ls1UhXoaegUH1s+l5yai+iSc4gzq/ZyCgat2mH3w4kKj4kqnF5/9/SXFCHQ1Vf
 daHIsg7lVkFPlvXfbtET4xCmBhqqmATdZpWJf0eJ3ahhf0gW+9muZ34WCArvUIA3+Q8E
 wN3HWtYI8K0Cz7+q5/xwsz1Q+llhvnqVyQL8zFil/H6vwT5BRkh0T6yqTszrLAYUpTkK
 KsMJ6Y1zA+XdCs0h3KXERd3rJB/c8DV1bOFu3ejB1OjnAgBG9nhNIzt0Z7g8vFDcw8iN
 3w1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XhQdRpTZQlvWNDL2xph4d9tIaqYvR6Uizqzqj0oGHbQ=;
 b=ESy5I2VZuERD6bWJ0hjPOBXe2108qjHUpJ6WBg27I9ewJVJlvQCeSUFquFhTkTvIKE
 EHnLDsxtOZiJBJ8wyfPbRw4HOpf+qMFFw75UWnKdTE8mEh2BfWML8S+25PsuKGp1stmr
 H3a0xB9ml0oU9GMHKMdB+0k39NM1LDZreDCqxEE7c7AbYRVz+GShB/bdJYZbvMJQfYvG
 hNNRiqqwjGG6JgAuQgDLYBH2yyZNAWKIlXVw0PHreIMl2MrPMYRF+I1P6WXAgTf+X71N
 fr5fXl/FxBiSu+KGYR0yC0XapVFTpb58YPp+ctWGia9S98Of7ygOMW4Xr5e43NOvQAIH
 UHiQ==
X-Gm-Message-State: AOAM533I635q2cPSmvFa93u3pob7R/D1CEZJeBRJhMQSMc6M+Di/ovDh
 xCCo6itc3CFPAxNBUPURQZLxbzKqBEi9HmJP
X-Google-Smtp-Source: ABdhPJzrPHTM7FJuVc/oxVOiK6TQz/XcSOUrJx53Wh/necnYa1JajggP1ldXYT2F4N+eBeEqyUfCuw==
X-Received: by 2002:a17:906:4b18:: with SMTP id
 y24mr6134190eju.416.1603323096606; 
 Wed, 21 Oct 2020 16:31:36 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:aa12:a77f:2000:4cea:81e7:5fd4:93f7])
 by smtp.gmail.com with ESMTPSA id k23sm2845236ejs.100.2020.10.21.16.31.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2020 16:31:35 -0700 (PDT)
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v3 02/11] drm/amd: Init modifier field of helper fb.
Date: Thu, 22 Oct 2020 01:31:21 +0200
Message-Id: <20201021233130.874615-3-bas@basnieuwenhuizen.nl>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201021233130.874615-1-bas@basnieuwenhuizen.nl>
References: <20201021233130.874615-1-bas@basnieuwenhuizen.nl>
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
Cc: maraeo@gmail.com, sunpeng.li@amd.com, daniel@ffwll.ch,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>, alexdeucher@gmail.com,
 harry.wentland@amd.com, nicholas.kazlauskas@amd.com
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
index e2c2eb45a793..77dd2a189746 100644
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
