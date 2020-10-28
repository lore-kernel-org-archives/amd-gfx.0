Return-Path: <SRS0=QeQy=ED=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2713CC388F7
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2020 23:52:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B1A12070E
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2020 23:52:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=basnieuwenhuizen.nl header.i=@basnieuwenhuizen.nl header.b="WuiWQChd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B1A12070E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=basnieuwenhuizen.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 553C26E81D;
	Wed, 28 Oct 2020 23:52:43 +0000 (UTC)
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com
 [IPv6:2a00:1450:4864:20::643])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A8336E81B
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2020 23:52:43 +0000 (UTC)
Received: by mail-ej1-x643.google.com with SMTP id h24so1341496ejg.9
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2020 16:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen.nl; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=yPo+60UVEmq7wnU64xnzp4zkOl9t3nvBhPeTg/67dHo=;
 b=WuiWQChdBZ1KSWxVDRQrV2BlvUBq5tAL084GeQyGGw+IVSFf6CZSu2I2dcqff+Bonk
 EZUpu4Sxg8ioY7Q6x2+Lrkrn6hd98tJoNvj36VbEUU4Gh57zB8gP454cU7gL9sDM9bMg
 TI9t9Rs/MhaGOYKtByYd4WuQ1om9y+8DCpKMI/1qWYHKBSgWscjYNo6PT0RdjQ7dv2vR
 ebXtoPnd5sxYNbgVSX356WFY1SJ0UEnjUZe7oSU9rrKf1tFQo9CdftflJpQgMzla6Mgj
 Dr8Zg29zJZtI9bt3i7P5N+344WSsFQ7uceKjZdB6fBaaFL8Ud2c8YaA4GUKBqM0/bPTd
 w7Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yPo+60UVEmq7wnU64xnzp4zkOl9t3nvBhPeTg/67dHo=;
 b=pWbQN+uFo+yr+BRv6bd6N8qjYvNrbZK8gpc7+yOI4uHWrLQQRRSDqcm3lZkdzurIFd
 y5HJJFOEOMP4RE6x5enXQjxyoso2gnBEgx0S5br9YngKRg7JzWKthUTWiAgsZguIpSHa
 jAC9Yu4omhkc5AsQiQGrG6ONhw4IuOF6c2Ji7QZfONQQpQ+N3TagnHAKmC+r4ztXusPa
 rF/iBhw+EdTfIiHJXi4c1sCGD6GT5fYWfHT978ZJnkaePXyW/zTX62aPtgGkTF1hrwBG
 7VXUsyplDpClmibhB5KOUp0pnNA5E6wgNOlDSkC7rJSVbp8dZYrelxpiZnvWMKZwPdsc
 2Fag==
X-Gm-Message-State: AOAM530lijhBQH3py9hA8MgcTZD5wg0qcNmmdj3EtuMy+rDPAGb2hL8R
 CJxRBNLARkXQ3Jtxa/Ta7fyEzNf3uIs8AQ==
X-Google-Smtp-Source: ABdhPJyJwX68lebJ/3ICM4x6xRQ+D2/lf0oFu/DQ0/BeIBd5zG/OwsXOojdsIW9I2OdlPwb2IxYE9Q==
X-Received: by 2002:a17:906:6a07:: with SMTP id
 o7mr1493021ejr.454.1603929161474; 
 Wed, 28 Oct 2020 16:52:41 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:aa12:a77f:2000:4cea:81e7:5fd4:93f7])
 by smtp.gmail.com with ESMTPSA id o13sm479174ejr.120.2020.10.28.16.52.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2020 16:52:40 -0700 (PDT)
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v4 02/11] drm/amd: Init modifier field of helper fb.
Date: Thu, 29 Oct 2020 00:52:32 +0100
Message-Id: <20201028235241.3299-3-bas@basnieuwenhuizen.nl>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201028235241.3299-1-bas@basnieuwenhuizen.nl>
References: <20201028235241.3299-1-bas@basnieuwenhuizen.nl>
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
Cc: alexdeucher@gmail.com, Alex Deucher <alexander.deucher@amd.com>,
 harry.wentland@amd.com, nicholas.kazlauskas@amd.com,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Otherwise the field ends up being used uninitialized when
enabling modifiers, failing validation with high likelyhood.

v4: Use memset

Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
(for v1)
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
index e2c2eb45a793..0bf7d36c6686 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
@@ -207,6 +207,7 @@ static int amdgpufb_create(struct drm_fb_helper *helper,
 	int ret;
 	unsigned long tmp;
 
+	memset(&mode_cmd, 0, sizeof(mode_cmd));
 	mode_cmd.width = sizes->surface_width;
 	mode_cmd.height = sizes->surface_height;
 
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
