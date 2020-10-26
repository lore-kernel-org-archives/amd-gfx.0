Return-Path: <SRS0=jB5Z=EB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE49BC2D0A3
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2020 16:14:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69966223B0
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2020 16:14:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W5gyvGg7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69966223B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FB2F6E049;
	Mon, 26 Oct 2020 16:14:49 +0000 (UTC)
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com
 [IPv6:2607:f8b0:4864:20::f43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC4306E049
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2020 16:14:47 +0000 (UTC)
Received: by mail-qv1-xf43.google.com with SMTP id w9so4558184qvj.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2020 09:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Ha3uZDdtA3vDquM2UlE4gbbl0YKaoPV00ymMao/WjVk=;
 b=W5gyvGg7rMxrg+EFyojCZP0r2wsKtw68vWUuXOs6Cnb0UVTUC+OfLaDnqLxZNcgb50
 17Z1vuJX1XTYvYeagDjAmuT2/zF/nra7pnkQxBIHEqjVXW4wpYaG+l8nDmMARqDDAWRt
 iNAhezW9H/dG56SaGViKd7Nb7vYkT+UN8dReXUAguAazuIWtRfhj91nE2IDvw8Z0AgHU
 ltpy9GWxJknuCrErFJw1VzY9qbLinoRj6VtUXLLBhzIgPNXA0RDzJI3EHfXq4tiLtc7w
 0wtX0tEWfZP8Wztf0KnJvMD2yZKqdthLrvF+eWbPaZYbxxNR+bPEmEeGEVJehbaF6b6j
 vf0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Ha3uZDdtA3vDquM2UlE4gbbl0YKaoPV00ymMao/WjVk=;
 b=QXf9qVkZs/OErplLJk08Xv93UwLNz8MQEhOUjT1wXXku1c6IXKDw+RqUn8Rk422OuZ
 QyQc7lXpJcx+o5Es9ApBj3igFK11WksHgpKhYdaadpB9GnAoIhqTn4r8LF/N3v0Dhh/f
 GcYY1ZoA4LtuIcwKcuOnELr53mv6DcyAARCcaregD5V+Nz6JNYy6gKkrjGZOJxb03Vgp
 sOtybJ6+o0/sVbxgeiH84shzFRQEpgw0+scluPAgcS7FWXn6u0THGzjy+RFR1/WwNY05
 +3kpomuVB3db5OVUvRu+WAmucL3/+C8pCDFBpIpFJWVQrLvybKWQBLQXzE9Co/pS9X5/
 nF2g==
X-Gm-Message-State: AOAM531BrcWOduUgPF3pkjYCvvy1qRufZ7vvVvzAT5Uid6frktm3CJSB
 BUpyQ8+Q/YSVBYOn/HvVqTL53uUyZl0=
X-Google-Smtp-Source: ABdhPJwlzOOLEQhGf9rhoC1m+lwmlp30MJyvQSkDAYM6lfC7b8Wj/ffRZLeJU98FA7jnnxXrIbCBKw==
X-Received: by 2002:a0c:8285:: with SMTP id i5mr13795573qva.54.1603728886791; 
 Mon, 26 Oct 2020 09:14:46 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id 29sm6923811qks.28.2020.10.26.09.14.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2020 09:14:46 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/display: re-add surface size calculation in
 dcn30_hwseq.c
Date: Mon, 26 Oct 2020 12:14:36 -0400
Message-Id: <20201026161436.978310-1-alexander.deucher@amd.com>
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

This is required for MALL.  Was accidently removed in PRS update.

Fixes: 48e48e598478 ("drm/amd/display: Disable idle optimization when PSR is enabled")
Fixes: 52f2e83e2fe5 ("drm/amdgpu/display: add MALL support (v2)")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c    | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
index f3ae208850b0..cc2eca8c9a62 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
@@ -715,6 +715,21 @@ bool dcn30_apply_idle_power_optimizations(struct dc *dc, bool enable)
 					break;
 			}
 
+			if (dc->current_state->stream_count == 1 // single display only
+			    && dc->current_state->stream_status[0].plane_count == 1 // single surface only
+			    && dc->current_state->stream_status[0].plane_states[0]->address.page_table_base.quad_part == 0 // no VM
+			    // Only 8 and 16 bit formats
+			    && dc->current_state->stream_status[0].plane_states[0]->format <= SURFACE_PIXEL_FORMAT_GRPH_ABGR16161616F
+			    && dc->current_state->stream_status[0].plane_states[0]->format >= SURFACE_PIXEL_FORMAT_GRPH_ARGB8888) {
+				surface_size = dc->current_state->stream_status[0].plane_states[0]->plane_size.surface_pitch *
+					dc->current_state->stream_status[0].plane_states[0]->plane_size.surface_size.height *
+					(dc->current_state->stream_status[0].plane_states[0]->format >= SURFACE_PIXEL_FORMAT_GRPH_ARGB16161616 ?
+					 8 : 4);
+			} else {
+				// TODO: remove hard code size
+				surface_size = 128 * 1024 * 1024;
+			}
+
 			// TODO: remove hard code size
 			if (surface_size < 128 * 1024 * 1024) {
 				refresh_hz = div_u64((unsigned long long) dc->current_state->streams[0]->timing.pix_clk_100hz *
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
