Return-Path: <SRS0=8ysN=7Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE280C433E0
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jun 2020 18:00:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B90A920657
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jun 2020 18:00:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bWyxl4AF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B90A920657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 609CB89B67;
	Wed,  3 Jun 2020 18:00:15 +0000 (UTC)
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com
 [IPv6:2607:f8b0:4864:20::842])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB82F89B67
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jun 2020 18:00:13 +0000 (UTC)
Received: by mail-qt1-x842.google.com with SMTP id d27so2845290qtg.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 03 Jun 2020 11:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=uDFWu4cdW7jWRWURaBnlbSDXTx2d3sOrjOccOGIhz3I=;
 b=bWyxl4AFmMdutAmqhtwRWF8e805T0l2tXBdPaWDOXARH/j/iWYN0hNGHKD4+yyy8Ym
 XwDd/xjY5FVTOkjfdzTnOchL748gAuicyLfWoxx8eylp3Z4NvzPvE4SzKylzwGkdsmxm
 +8Kkv4vZN5NhRN5L2/lkdZsq/5SvuNLY4UTmhOUS06OsPMjw7gVjAeK95XWgnSGo4Otu
 nVaxqwzu2C3Vb3E7rPt4ut0AIRWGTAEuy632S6iJlRCwvsXv+Z1+11Lu/m7BL2YlzV/v
 o2n8KhGgFDRPL1eZrUVaZX4PGLZ1EE9QoIM2O03+QDquTzhYEG+8On2r/pgmAKiyD6AG
 g37g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=uDFWu4cdW7jWRWURaBnlbSDXTx2d3sOrjOccOGIhz3I=;
 b=Y+rzqOjyshqoroyoc6hRFOnKP11DRoL8guD0S0WkZAAyDyE6ohq3ud/TJITaxPZQ03
 QrDCWg/XJOGOpitVVgKPdCgxMIwcFwzROwSIK2a70iDaF8FMUC8/J22cvcGg9zhxbKTr
 +Dh7i/NXQr3vr8UFFOg6KvmvkpRobs7f+fYQZqSIVzohOS+cyi714qdQ5XwOGdXrri5r
 9gX6K92Aa7DBk1Ke+jY693gIXVURK6L+p95kZGjc2lc1W2l57gpiPE1AOBIVoOb4OwEV
 8gNakiZpxoSI3KfC9NkTQ8mG0SIwcVXYyQRZOxxpivRI4tTc1YcqDPcud1C9pdaAXMHA
 ftPg==
X-Gm-Message-State: AOAM532yfrf8l1GQ7HhkkkOJbcGCcg565V2pKjCrXdKaIDAN5mBLoCbB
 kABYjVjR6ymJQyBXE4ZDwL01N6Pt
X-Google-Smtp-Source: ABdhPJwshNWeO0eD8uiLiTad9IfF38OD702AAuR8ZQa0kkAEW8tSJan2aHEWgL6aSW8vmkna7qTQzw==
X-Received: by 2002:ac8:7c8f:: with SMTP id y15mr564899qtv.248.1591207212600; 
 Wed, 03 Jun 2020 11:00:12 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id a191sm2229669qkc.66.2020.06.03.11.00.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2020 11:00:11 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/display: fix build without CONFIG_DRM_AMD_DC_DCN3_0
Date: Wed,  3 Jun 2020 14:00:04 -0400
Message-Id: <20200603180004.266897-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Need to guard some new DCN3.0 stuff.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
index 43d0b4e53b5d..2972392f9788 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
@@ -288,13 +288,16 @@ void optc1_program_timing(
 	if (optc1_is_two_pixels_per_containter(&patched_crtc_timing) || optc1->opp_count == 2)
 		h_div = H_TIMING_DIV_BY2;
 
+#if defined(CONFIG_DRM_AMD_DC_DCN3_0)
 	if (optc1->tg_mask->OTG_H_TIMING_DIV_MODE != 0) {
 		if (optc1->opp_count == 4)
 			h_div = H_TIMING_DIV_BY4;
 
 		REG_UPDATE(OTG_H_TIMING_CNTL,
 		OTG_H_TIMING_DIV_MODE, h_div);
-	} else {
+	} else
+#endif
+	{
 		REG_UPDATE(OTG_H_TIMING_CNTL,
 		OTG_H_TIMING_DIV_BY2, h_div);
 	}
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
