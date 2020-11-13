Return-Path: <SRS0=j5hG=ET=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA2AC55ABD
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 17:55:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D968720791
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 17:55:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=basnieuwenhuizen.nl header.i=@basnieuwenhuizen.nl header.b="LOL3trtQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D968720791
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=basnieuwenhuizen.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B8916E5D4;
	Fri, 13 Nov 2020 17:55:31 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 727E66E5D4
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2020 17:55:30 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id 10so9074773wml.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2020 09:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen.nl; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=W+H8gSv47GmnZ8PNmJXKOXGjnxoVWQS3wMbT7DJ1igU=;
 b=LOL3trtQ8wnpHXkIeRJV1OroFkfXkfPlxqLjRU/IJ22J63vMMxpRL0qiXTRmuA5+QB
 Ww6Km4uOTw2kzbVocgwOvwJMLV7gHyVZZzjOfwW3x3T4u3bqfjL10tvvHAsusCeoH6EC
 QRkOyMsR54K3NYvlo5RgNxy6Se4yh+4CGVjKf+yNFWUSS9mjsq/vyxyNBEItU+7eYdqe
 Ie4Oo30V0MSvgqg/ugaxW46hDqRWA4edqkIM5Tn/jFM9aYuarz0g4dmTugFDQUYwmWc6
 nJsodpeZj+eb+XdKLf23JuOmpUMJqZDBE/qi034ZibVCMDjGaKRGG2cvT0ozsnNTHq2H
 5Acw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=W+H8gSv47GmnZ8PNmJXKOXGjnxoVWQS3wMbT7DJ1igU=;
 b=I9C2CeePQwTPNcXjEwp0A6Ngl3bJW1INJIvKZJ9Lm+H/TZK5062DtLrDDw9Yxg5I4c
 BlJypwRUiYNsqceI4Nj8tV1e/wegZFj9Lfmi286FMzcf2iG0dvnZ8yg7tYCsXJ19ZOx/
 JCjMCHO5tbMF+OAfo/5qQSE4AEJ2O50KsWkPc/n/a7XS/xUEuCgzb7FWGX6CXjIMmA2N
 /p2VQxS996PBiOpqVMKaPFmXIU7YLrtJiF/O+hyCoLXtPKCs5hzh/KkMy0AmiwZ/N/I/
 i9Gh4eIJ5qp44xjbhtqVVOCizIXJyI8eX+Lk8Q+fVsmORV4ZaIyR6WjIr9F/3qBTUyUf
 KuVg==
X-Gm-Message-State: AOAM533iSb0ghSRq+KrqPfXkSjrqCcgRphsSM4zC4b+VkgyYkMQJPI42
 E2qmzpsgai+gZgrWlF0fTudKQuoz7Eim0OqQ
X-Google-Smtp-Source: ABdhPJwlVCwldF1pWbknahDpJulYrWqRowyQgY/B/XjJFZZqYib540NbOrKH/X6O7ysN7rDBlNW2FA==
X-Received: by 2002:a1c:5f45:: with SMTP id t66mr3451490wmb.132.1605290128046; 
 Fri, 13 Nov 2020 09:55:28 -0800 (PST)
Received: from localhost.localdomain
 ([2a02:aa12:a77f:2000:4cea:81e7:5fd4:93f7])
 by smtp.gmail.com with ESMTPSA id d2sm6834952wra.73.2020.11.13.09.55.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2020 09:55:27 -0800 (PST)
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2] drm/fourcc: Fix modifier field mask for AMD modifiers.
Date: Fri, 13 Nov 2020 18:55:33 +0100
Message-Id: <20201113175533.731834-1-bas@basnieuwenhuizen.nl>
X-Mailer: git-send-email 2.29.2
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
Cc: alexdeucher@gmail.com, contact@emersion.fr,
 Alex Deucher <alexander.deucher@amd.com>, dri-devel@lists.freedesktop.org,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The DCC_MAX_COMPRESSED_BLOCK has to contain one of
AMD_FMT_MOD_DCC_BLOCK_* and with 3 values this doesn't
fit in 1 bit.

Fix this cleanly while it is only in drm-next.

Fixes: 8ba16d599374 ("drm/fourcc: Add AMD DRM modifiers.")
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
---
 include/uapi/drm/drm_fourcc.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
index df56e71a7380..a878664ba41c 100644
--- a/include/uapi/drm/drm_fourcc.h
+++ b/include/uapi/drm/drm_fourcc.h
@@ -1129,7 +1129,7 @@ drm_fourcc_canonicalize_nvidia_format_mod(__u64 modifier)
 #define AMD_FMT_MOD_DCC_INDEPENDENT_128B_SHIFT 17
 #define AMD_FMT_MOD_DCC_INDEPENDENT_128B_MASK 0x1
 #define AMD_FMT_MOD_DCC_MAX_COMPRESSED_BLOCK_SHIFT 18
-#define AMD_FMT_MOD_DCC_MAX_COMPRESSED_BLOCK_MASK 0x1
+#define AMD_FMT_MOD_DCC_MAX_COMPRESSED_BLOCK_MASK 0x3
 
 /*
  * DCC supports embedding some clear colors directly in the DCC surface.
@@ -1140,7 +1140,7 @@ drm_fourcc_canonicalize_nvidia_format_mod(__u64 modifier)
  * If this bit is set that means the fastclear eliminate is not needed for these
  * embeddable colors.
  */
-#define AMD_FMT_MOD_DCC_CONSTANT_ENCODE_SHIFT 19
+#define AMD_FMT_MOD_DCC_CONSTANT_ENCODE_SHIFT 20
 #define AMD_FMT_MOD_DCC_CONSTANT_ENCODE_MASK 0x1
 
 /*
@@ -1153,15 +1153,15 @@ drm_fourcc_canonicalize_nvidia_format_mod(__u64 modifier)
  * RB = only for TILE_VER_GFX9 & DCC
  * PIPE = only for TILE_VER_GFX9 & DCC & (DCC_RETILE | DCC_PIPE_ALIGN)
  */
-#define AMD_FMT_MOD_PIPE_XOR_BITS_SHIFT 20
+#define AMD_FMT_MOD_PIPE_XOR_BITS_SHIFT 21
 #define AMD_FMT_MOD_PIPE_XOR_BITS_MASK 0x7
-#define AMD_FMT_MOD_BANK_XOR_BITS_SHIFT 23
+#define AMD_FMT_MOD_BANK_XOR_BITS_SHIFT 24
 #define AMD_FMT_MOD_BANK_XOR_BITS_MASK 0x7
-#define AMD_FMT_MOD_PACKERS_SHIFT 26 /* aliases with BANK_XOR_BITS */
+#define AMD_FMT_MOD_PACKERS_SHIFT 27 /* aliases with BANK_XOR_BITS */
 #define AMD_FMT_MOD_PACKERS_MASK 0x7
-#define AMD_FMT_MOD_RB_SHIFT 29
+#define AMD_FMT_MOD_RB_SHIFT 30
 #define AMD_FMT_MOD_RB_MASK 0x7
-#define AMD_FMT_MOD_PIPE_SHIFT 32
+#define AMD_FMT_MOD_PIPE_SHIFT 33
 #define AMD_FMT_MOD_PIPE_MASK 0x7
 
 #define AMD_FMT_MOD_SET(field, value) \
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
