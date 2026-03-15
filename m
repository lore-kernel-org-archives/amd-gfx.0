Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5429EF506D3
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2026 13:28:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E19D710E537;
	Mon, 16 Mar 2026 13:28:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WPvJkJ1w";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C523910E295
 for <amd-gfx@lists.freedesktop.org>; Sun, 15 Mar 2026 16:51:51 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-485409ab264so26095615e9.1
 for <amd-gfx@lists.freedesktop.org>; Sun, 15 Mar 2026 09:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773593510; x=1774198310; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TesBLh40+3VL9iLCLxWBzIXiufdV95pvYiFmZMKCnb8=;
 b=WPvJkJ1wSxO3PmjU40i21rLhQFii/knNAj5eapJtRH+AKYkiGbFYcf/skPWOetJGbf
 sIVILAd0GGSfomnk8+LDQMPSgSucfzVUt3pWWmebT6xH5smx4CxEeD1bRIPazFH+6LZ9
 PyhvhXhMhKl3lYzSLzrAqyObNIkKE4dm2Dhmi0zW2VPkw86W1380MuPvTFweuvOUHzYl
 3fP/nRz7Vauas9vLo+GBMfRiJXhiG+3zim7DeTbPq5KZC5ISAth2eh+sYXnegcxcthoI
 XHn/gPEgWMcUQ6/8Sr8b4Rfsb5/dYDzS2TRp6WzLn62DOHU0+YNCrWxZPcSVHgOYyHGl
 OZvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773593510; x=1774198310;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TesBLh40+3VL9iLCLxWBzIXiufdV95pvYiFmZMKCnb8=;
 b=tHNrTjof/J8ETacdDKORSwixd8jc0bNOdDhIz2D5bA13jCMicqb4GpB6SCH06EWFr+
 GQXQGsxzbR+b2Nk+d2A8EzpR0h3TkW8nAwbsdOjBTpxS/8uC0Ohpx4Ag3uwwKetML+TX
 QlEfxrIFX5oWDsuVFjiog+feSYFEwLpz7MvV13pCQ88mAd+0dvWH/s+AW4fMyXf4Os3v
 O2xqox++lq8SLLUyfzA83oznEWK0Ccl5eCSzHoDV1neUwZImgRTcUSoWwuXbdUVSduuD
 EzYaWYullrni5RfXabxqBEEWz8nvM3J7vY4wHKuZQLhjI/pp7EHUHz64O8VF7mkDiUpg
 FTRg==
X-Gm-Message-State: AOJu0YygGgizuBB3zuhfKlB10JTNrL14Bvlqqmvd5Zh7Dl0eLpQmQoB3
 FV+05sZB7sjgX4IeGWCSeaRveK8Xe8cN/CTtW5qCUbT85aXLIR54ZfxG3/QFY475dis=
X-Gm-Gg: ATEYQzwEVJgolXapQ76bXHLCwNWg0xq67zIZcaDztt+SbnFMFQc17X2UywgPLOmgSp5
 s8jPMUsajqY5gOZzZH/Zi6TbJYy0V+4B6JmHKdxsvtZeQhZuZfuCAevKWJyGJwZFnDaprz1Zs6c
 e7HMpLj5CSIE9why/a3br9HmrCXjEwIv5On7SkxbdufYsKjC54AQZle6K9gpjCCuMww+R/Uskjj
 IIXGPak0VwZ/qLhskm9bS3mSmOAs4bIEmrKJKlALHf71mIr2uNo1tZtoCr5aq/5Dijc/WCEgXbD
 mmuhlzF9orNsLEB9+u+stFIrVp1XNvu/93uBV0YPNGLgqoFkQqa6H2l07fegFpMTZ/QZUEQS9fu
 aD5tiAyWhqpA1PrMLeJhbInZvpzpfgLimJaXJbu7Bu9aF4HfJ3ssWVH2/Gz0qhCpmgWUt0lu5mE
 H7LeFph4ig6EEt9jEqzuNv4zMZkPkKIwgz3i5smfpp1Vr+aQ72Ag==
X-Received: by 2002:a05:600c:a016:b0:47e:e981:78b4 with SMTP id
 5b1f17b1804b1-48555b2c949mr150575805e9.12.1773593509999; 
 Sun, 15 Mar 2026 09:51:49 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:86:f06b:2a9:c6c1:cd00:d0e9])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4855725572csm139542595e9.2.2026.03.15.09.51.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Mar 2026 09:51:49 -0700 (PDT)
From: Andy Nguyen <theofficialflow1996@gmail.com>
To: alexander.deucher@amd.com
Cc: amd-gfx@lists.freedesktop.org, Andy Nguyen <theofficialflow1996@gmail.com>
Subject: [PATCH] drm/amd: fix dcn 2.01 check
Date: Sun, 15 Mar 2026 17:51:47 +0100
Message-ID: <20260315165147.61189-1-theofficialflow1996@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 16 Mar 2026 13:28:00 +0000
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

The ASICREV_IS_BEIGE_GOBY_P check always took precedence, because it includes all chip revisions upto NV_UNKNOWN.

Fixes: 54b822b3eac3 ("drm/amd/display: Use dce_version instead of chip_id")
Signed-off-by: Andy Nguyen <theofficialflow1996@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
index 08d0e05a313e..d237d7b41dfd 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
@@ -255,6 +255,10 @@ struct clk_mgr *dc_clk_mgr_create(struct dc_context *ctx, struct pp_smu_funcs *p
 			BREAK_TO_DEBUGGER();
 			return NULL;
 		}
+		if (ctx->dce_version == DCN_VERSION_2_01) {
+			dcn201_clk_mgr_construct(ctx, clk_mgr, pp_smu, dccg);
+			return &clk_mgr->base;
+		}
 		if (ASICREV_IS_SIENNA_CICHLID_P(asic_id.hw_internal_rev)) {
 			dcn3_clk_mgr_construct(ctx, clk_mgr, pp_smu, dccg);
 			return &clk_mgr->base;
@@ -267,10 +271,6 @@ struct clk_mgr *dc_clk_mgr_create(struct dc_context *ctx, struct pp_smu_funcs *p
 			dcn3_clk_mgr_construct(ctx, clk_mgr, pp_smu, dccg);
 			return &clk_mgr->base;
 		}
-		if (ctx->dce_version == DCN_VERSION_2_01) {
-			dcn201_clk_mgr_construct(ctx, clk_mgr, pp_smu, dccg);
-			return &clk_mgr->base;
-		}
 		dcn20_clk_mgr_construct(ctx, clk_mgr, pp_smu, dccg);
 		return &clk_mgr->base;
 	}
-- 
2.43.0

