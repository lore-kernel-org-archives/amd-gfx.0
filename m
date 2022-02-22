Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3EA3C433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Feb 2022 14:06:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D6FC10E82D;
	Tue, 22 Feb 2022 14:06:43 +0000 (UTC)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C41F010E63C
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Feb 2022 13:18:30 +0000 (UTC)
Received: by mail-oi1-x22f.google.com with SMTP id a6so14386574oid.9
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Feb 2022 05:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=usp.br; s=usp-google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mAHBtmtMrIy2W3kHZTCvcn0QTbxMEFt0geIwL6YcBKU=;
 b=nwAqmSQ2vzkc3R4j/kHBj0KGZ82kOVGgV5IRWLnHakRqcnRlMTi9QWOODmUlZsR7Rn
 o5IZ/CoGQE9VyVOfT0qR0kyflmOFoLDdau0bR8Qx7YSRA9/5elfqnOn/Db86bYKBkTeG
 0FuUP7l9/VpIBYdcnESdf/CvwXHQQLYEOB0EVwZ28H8YarTK9fUla0EAV4crC8sBDwSK
 vK5gyqkTUzozj5/qxd5GkZ5NhYLamohIpzpxY8vU8KW8athgQctX6BWp5EFF6/l+oZxt
 TJKlTbCIQ94AB6watlHLY3iubMMGfwBc7yDlOMTMT2vEHeGzMGLD1S5iJBJVQ0MbIGtX
 2MiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mAHBtmtMrIy2W3kHZTCvcn0QTbxMEFt0geIwL6YcBKU=;
 b=l+39M1uuM80a0643/KRkW03dho37GIJ6StGPZurYnB1Z5cZ4yDyDfavQKmQJpkmtpw
 3ZOk6ZCA6aFAsq9p02m+cVFmW/+P0VBgcZpgqArtSv182QldvzqlrNxNFjzTo71yXifs
 iFV0d2f0Ub0A4Pu/I4OPzvdkLZyVsscLS9BQHHQ9vw4ZJ/3ITZfIE48FYRlhK2bJdeIc
 RXbg4DTdXz1OV9DHel5t67JqEx0gwpqp72WywnRNkaRceaqYr2nSmFQLms7OtuvlAr9g
 gNFji93zzHVGu3xBXOUn9AhbManAQSCxhmgLfRv5sBJP9pEnNu7M68s7WMN6XuVQXmXZ
 0Uwg==
X-Gm-Message-State: AOAM532VHW2N9PZcso7cXLUJdrPZdOaj3HPNMOgMWggX1v6V1545nmlM
 O+ZJILdu2hmEExQG2ywW1vXEqA==
X-Google-Smtp-Source: ABdhPJx8Rjrh7CF6sfeCwjuZInz6fzuEKQI/zgh6IVqdopcXaKbEaCWXyeks31/XR48U1/2OPddz9g==
X-Received: by 2002:a05:6808:1646:b0:2d4:428c:659e with SMTP id
 az6-20020a056808164600b002d4428c659emr1885513oib.20.1645535910109; 
 Tue, 22 Feb 2022 05:18:30 -0800 (PST)
Received: from fedora.. ([187.36.236.204])
 by smtp.gmail.com with ESMTPSA id c9sm6325050otd.26.2022.02.22.05.18.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Feb 2022 05:18:29 -0800 (PST)
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <maira.canal@usp.br>
To: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 Hawking.Zhang@amd.com, john.clements@amd.com, tao.zhou1@amd.com,
 YiPeng.Chai@amd.com, luben.tuikov@amd.com, Stanley.Yang@amd.com,
 Dennis.Li@amd.com, mukul.joshi@amd.com, harry.wentland@amd.com,
 sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com, Anthony.Koo@amd.com
Subject: [PATCH 08/10] drm/amd/display: Remove unused variable
Date: Tue, 22 Feb 2022 10:16:59 -0300
Message-Id: <20220222131701.356117-9-maira.canal@usp.br>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220222131701.356117-1-maira.canal@usp.br>
References: <20220222131701.356117-1-maira.canal@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 22 Feb 2022 14:06:42 +0000
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
Cc: magalilemes00@gmail.com,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <maira.canal@usp.br>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, mwen@igalia.com,
 amd-gfx@lists.freedesktop.org, isabbasso@riseup.net
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Remove the variable clamshell_closed from the function
dcn10_align_pixel_clocks.

This was pointed by clang with the following warning:

drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c:2063:7:
warning: variable 'clamshell_closed' set but not used
[-Wunused-but-set-variable]
    bool clamshell_closed = false;
         ^

Signed-off-by: Maíra Canal <maira.canal@usp.br>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 8dc1afc03961..559aa45f27e7 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -2060,14 +2060,11 @@ static int dcn10_align_pixel_clocks(struct dc *dc, int group_size,
 	uint32_t embedded_pix_clk_100hz;
 	uint16_t embedded_h_total;
 	uint16_t embedded_v_total;
-	bool clamshell_closed = false;
 	uint32_t dp_ref_clk_100hz =
 		dc->res_pool->dp_clock_source->ctx->dc->clk_mgr->dprefclk_khz*10;
 
 	if (dc->config.vblank_alignment_dto_params &&
 		dc->res_pool->dp_clock_source->funcs->override_dp_pix_clk) {
-		clamshell_closed =
-			(dc->config.vblank_alignment_dto_params >> 63);
 		embedded_h_total =
 			(dc->config.vblank_alignment_dto_params >> 32) & 0x7FFF;
 		embedded_v_total =
-- 
2.35.1

