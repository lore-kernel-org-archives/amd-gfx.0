Return-Path: <SRS0=NxiI=D5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B0FC388F9
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2020 20:34:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C0D924640
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2020 20:34:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GvF472/4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C0D924640
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A231E6E0E7;
	Thu, 22 Oct 2020 20:34:37 +0000 (UTC)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA50D6E0E7
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2020 20:34:36 +0000 (UTC)
Received: by mail-qk1-x742.google.com with SMTP id r7so3222297qkf.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2020 13:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=5qX9yNjwc/u4AgMh1861g2rILqkHDEql3Vbn4ZaExvc=;
 b=GvF472/4Z7vUOvEIZGxREseiqWv1ZQscwxySDTS80fHOb8SRb8xMelfeg7zVdghe9p
 M+THE88E3z3EoVgdyIblWvEFHbLsPRwhYSWD38r7/zk0JVSJ/OB7DBbad4f7MhuRi7c9
 AYJ7nQuuUBCRLAQdeVR2X1jmEf7Y2+RXpnJU8mqZGO2r8ZmCWEFs5zyynqT7ASOZf9/a
 8CdgttHsM28Vcesob3c5q+0kQ1SOON89J9TSE5xjA4zgHiMARD1nBDbaEscPFgBChytc
 MrMDkX8j/CkU46VMDKyqpyRV/y2NS5WbxnEXWLcEihnH+6QZfHL25F+Ig2ChmVg1obvp
 aD3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=5qX9yNjwc/u4AgMh1861g2rILqkHDEql3Vbn4ZaExvc=;
 b=tQrg248WdsIIZ9XMrOwMELB7T5K9KKeigI77DvfEbCVfuIX3wDscaIcPosphM+IBCO
 NppJExJiB6W+uEnqs9416qjSOny2ljon0yB9aP8BmhTXD0OpgimWY9ifMpP5kaCoHAOk
 Mo9aUNgun9bQ8GGLXvSyxTkABggd6LgiJjQfOs/aA45Sy4domffhrrl18GVkQJxYgEeg
 ZSv16sNqtGqCvAqOvh+2c9vhManMxAYE8ia/QzIhq+z7bVzSa+uijiXKrYGxCkzFeaeH
 w5h8SQaZDjJOFOTgRht6gKK+G6iumJksHJ4WRtb08TZtAnUL9QtKbScOQ1YfbT6cUYVC
 /+PA==
X-Gm-Message-State: AOAM532loGQUxkT0/1dtWqojuyeXVOAX+5VZpDz3fhLrkd2YdDmytKYY
 oimBdNzIXivu0wCxbK3IlYDFzwzFo6Y=
X-Google-Smtp-Source: ABdhPJwYKBZ7rw9cgvE+s28XNG85WDaHDV2rf+eQZ0NjP1JVxlxNLY/jutLa7ecDdpssoL+0+7dCgw==
X-Received: by 2002:a05:620a:621:: with SMTP id
 1mr2965494qkv.471.1603398874675; 
 Thu, 22 Oct 2020 13:34:34 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id g5sm1823703qto.39.2020.10.22.13.34.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2020 13:34:34 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/display: fix 64 bit division in dcn30_hwseq.c
Date: Thu, 22 Oct 2020 16:34:24 -0400
Message-Id: <20201022203424.278010-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Slava Abramov <slava.abramov@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use div_u64 helpers.

Reviewed-by: Slava Abramov <slava.abramov@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
index a06f6d19e38e..f3ae208850b0 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
@@ -717,8 +717,10 @@ bool dcn30_apply_idle_power_optimizations(struct dc *dc, bool enable)
 
 			// TODO: remove hard code size
 			if (surface_size < 128 * 1024 * 1024) {
-				refresh_hz = (unsigned long long) dc->current_state->streams[0]->timing.pix_clk_100hz * 100LL /
-						(dc->current_state->streams[0]->timing.v_total * dc->current_state->streams[0]->timing.h_total);
+				refresh_hz = div_u64((unsigned long long) dc->current_state->streams[0]->timing.pix_clk_100hz *
+						     100LL,
+						     (dc->current_state->streams[0]->timing.v_total *
+						      dc->current_state->streams[0]->timing.h_total));
 
 				/*
 				 * Delay_Us = 65.28 * (64 + MallFrameCacheTmrDly) * 2^MallFrameCacheTmrScale
@@ -732,7 +734,7 @@ bool dcn30_apply_idle_power_optimizations(struct dc *dc, bool enable)
 				 * need to round up the result of the division before the subtraction
 				 */
 				denom = refresh_hz * 6528;
-				tmr_delay = (100000000LL + denom - 1) / denom - 64LL;
+				tmr_delay = div_u64((100000000LL + denom - 1), denom) - 64LL;
 
 				/* scale should be increased until it fits into 6 bits */
 				while (tmr_delay & ~0x3F) {
@@ -745,7 +747,7 @@ bool dcn30_apply_idle_power_optimizations(struct dc *dc, bool enable)
 					}
 
 					denom *= 2;
-					tmr_delay = (100000000LL + denom - 1) / denom - 64LL;
+					tmr_delay = div_u64((100000000LL + denom - 1), denom) - 64LL;
 				}
 
 				/* Enable MALL */
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
