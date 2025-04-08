Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D021C3DA4A
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Apr 2025 02:11:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10F0E10E599;
	Tue,  8 Apr 2025 02:11:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="F8sdTqZv";
	dkim-atps=neutral
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com
 [209.85.222.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A0B510E599
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Apr 2025 02:11:31 +0000 (UTC)
Received: by mail-qk1-f177.google.com with SMTP id
 af79cd13be357-7c5568355ffso425708085a.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 07 Apr 2025 19:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744078290; x=1744683090; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WpiL9JIcKCZpiO60KViaazUBowYJJ7Did2fz4rW1Mxc=;
 b=F8sdTqZvrvGdfpc5X1enLjKjl4krV3yY54hRwMux4DqZywHLJd8zoJjhCcseJHS6kG
 TFuKpPNarbBjt76nZG1IoBzt2M9GKt6shYa5VyzyYYvc90Q6WGMBGF7YASWfQVehiepI
 Ijp72wjikq8APP8ab28taqXq/PdsZ2botndT3i4VLgMLbgjHUztLEY9E2ja4egsRpyAo
 6jfZ+sbuY/E2NP7lG87dmbFsZRLebp88h87Qv+ooDi9IGzeg/aU4K4UsMoJ16Di8M/zu
 08rJFp0ePZIHyX45j7cHj6NPEem+wpL2aA8jq/L6BuQrgdQB/T+LbVGfyCPWJjwVovcx
 1Q9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744078290; x=1744683090;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WpiL9JIcKCZpiO60KViaazUBowYJJ7Did2fz4rW1Mxc=;
 b=D2S/AsFYtRJcWFb+bZSh32oPL0D6ByTnZox47w/5PxsDTn0NuH3jxsS3ZIT6bP9LVo
 ejPYJYEb+RpSE/fpvk86BBJKtcoq+3NE5rDZBbI5HiMTZlm4dIZ6LNwCWTnNmNaMJeeW
 ss/658Lg7yk3yT0UJTa+hGQLZOwcVJEl7bna2Hmhw6uw7OkHf+EWFhadegjs7nluPoqW
 EvMn1w/WvREtPjVQFIISiMSYLUDfdQbDXQ4ORzR3vS9JuKS+b9NbLA1JmfFpDo2gpJ35
 70B9akchqwE3g2wsOVr2M9hEEWphnZIuWRCdftekgn0gH4ucUgoAhSAMleW23kAbsL8u
 JBzQ==
X-Gm-Message-State: AOJu0YyIL09ZUBym8DfMvdTQBsw7YU+wKx/6DdFxj+xCRBcSQq7B3LBt
 8dBiV4ASNd/pnlkYvIng4OTwr5RkT4V0TcU2CDWkBPbdiMx2dB1FHWyqRg==
X-Gm-Gg: ASbGnctS5m9qm6LvVqqlJInMn49loR8UMQ8Y0yfmECxjDAfE7BNM3y0K/WFyywoYJQA
 iUZAYyzDpbCpICmw/jxSWCZRx5OENkeT/ojXGPFO40gUaZWPJXEJQod0AY6gxF8gpceKhodju9J
 SdL196G1wuOJduz25FBu2QHK4O2GWd7snuUc6Z8Zg3QenmR2xpV1nk+bzQCqcmeAydZ4sQXFJIR
 NOaSASve5geZNUvQLC2hJysNRACEsawtxxZlA+0cjt9ljT97Cv2aRLloPW6UE4jXjFyM+cOTCSK
 PbfEYqr2wAC60X0ov6mm/rl9CyBEd7LIGjU7tac0tGybgeGKKVqx7dPu8tTc2abFFRrB
X-Google-Smtp-Source: AGHT+IGxdzaByfy+dCI9Ry2r+odMgzOtCZ8G/Ki3TbMQS6ZL4BdY4AtyB/6x4ekr81zqvHKJVa+LDg==
X-Received: by 2002:a05:620a:4515:b0:7c7:739d:5cea with SMTP id
 af79cd13be357-7c774e16427mr2123501885a.35.1744078289783; 
 Mon, 07 Apr 2025 19:11:29 -0700 (PDT)
Received: from localhost.localdomain ([38.121.253.36])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c76ea5992csm687693985a.84.2025.04.07.19.11.29
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 19:11:29 -0700 (PDT)
From: Alexandre Demers <alexandre.f.demers@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/6] drm/amdgpu: add missing parameter name in
 dce110_clk_src_construct() declaration
Date: Mon,  7 Apr 2025 22:10:56 -0400
Message-ID: <20250408021100.5439-3-alexandre.f.demers@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408021100.5439-1-alexandre.f.demers@gmail.com>
References: <20250408021100.5439-1-alexandre.f.demers@gmail.com>
MIME-Version: 1.0
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

While not needed per speaking, all the other parameters have names but
this one.

Signed-off-by: Alexandre Demers <alexandre.f.demers@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.h b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.h
index 0721ae895ae9..94128f7a18b1 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.h
@@ -257,7 +257,7 @@ bool dce110_clk_src_construct(
 	struct dce110_clk_src *clk_src,
 	struct dc_context *ctx,
 	struct dc_bios *bios,
-	enum clock_source_id,
+	enum clock_source_id id,
 	const struct dce110_clk_src_regs *regs,
 	const struct dce110_clk_src_shift *cs_shift,
 	const struct dce110_clk_src_mask *cs_mask);
-- 
2.49.0

