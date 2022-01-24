Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 829AAC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jan 2022 00:23:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A87210E20F;
	Mon, 24 Jan 2022 00:23:38 +0000 (UTC)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA2EE10E149
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jan 2022 00:23:33 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id
 bg19-20020a05600c3c9300b0034565e837b6so10801145wmb.1
 for <amd-gfx@lists.freedesktop.org>; Sun, 23 Jan 2022 16:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen.nl; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=LXmJmAU/GNGyG08ROn2eTDlok4sQu4atlGx1IPz2biY=;
 b=Jlu0OaSn/Vmm8kYLbLWbNH1HNCfebPQhBGN4rXUR3rSf1ucILhQ349hFi2wSWcJ7Jy
 hCGb+PBUThlCT4sHyuov+quWtsab72kgOKiCcSugZ2kmsaPAqWVg+ExW2Z9DcTnNLcj7
 oggvxl1hTQVv894MW8kgeI0xwo1yKk2UkkLoEq0VI2ENzvLqfWNhmFjJvrj49MqqEFMc
 7BRc+pMo9i7609MMR5ijHLWvhQ4LSmXEh+O25O6RS0yj3dpFQGvh5S5g8OTqJJCIKE5J
 7DOmDd9c/o9nOoj9vUp8u0WI3nYgZHLI4aKaXJxyP7CVCEJXYeNQ29WHUZqly50VK0s8
 dn0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=LXmJmAU/GNGyG08ROn2eTDlok4sQu4atlGx1IPz2biY=;
 b=wr6gEs4w+h3ZBEb9he9+tTNbGTDoUlyE8y5gjoNUUAhIBvzNzRBRxHM/1RuNJVpukW
 3RoQTc33zKCTwely2ssm3D2Z6GQvwio7kCQhG0o8LgG7e8r5q9CPE36eMyK3ynl/9UgD
 NTjA3Z1Ve93DgVahHleNmAmr/VfUcCUdobZaLsCCtCOFzZqoRgPzwlwJ68P76l49Uxro
 WXnao6Y8J3uYwRDPeL4ngZ/9I1Z0K8oQiH75w8vgr52c0pohHTYed0ckgcykx1h5Xhsl
 TNqytyTAvIcamjENoUhSghO+FUvoaFWNl6VHBDe45biilDWrkvUTIqAtuNjHBom2E3Ff
 zMoA==
X-Gm-Message-State: AOAM530G9sIHGcjvDiswEblOc/EapHnrZtCU8f//00Ben5t0GlbyRF6q
 gINU8WtCH/ls+NQPmBoXEjywJGEp7o+oG0Ni
X-Google-Smtp-Source: ABdhPJyLYkIUHGtUvQ5TFjIYKInQ7FdI2vJxE3HXqBiQHFvKIju6rLlh6qWVjPlLnsrdlpgJi7lslg==
X-Received: by 2002:a05:600c:d7:: with SMTP id
 u23mr9537299wmm.44.1642983811956; 
 Sun, 23 Jan 2022 16:23:31 -0800 (PST)
Received: from bas-workstation.. ([2a02:aa12:a77f:2000:7285:c2ff:fe67:a82f])
 by smtp.gmail.com with ESMTPSA id j4sm14381909wrq.81.2022.01.23.16.23.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Jan 2022 16:23:31 -0800 (PST)
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amd/display: Fix FP start/end for
 dcn30_internal_validate_bw.
Date: Mon, 24 Jan 2022 01:23:35 +0100
Message-Id: <20220124002336.3455326-1-bas@basnieuwenhuizen.nl>
X-Mailer: git-send-email 2.34.1
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
Cc: sunpeng.li@amd.com, Zhan.Liu@amd.com, Rodrigo.Siqueira@amd.com,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>, harry.wentland@amd.com,
 pgriffais@valvesoftware.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It calls populate_dml_pipes which uses doubles to initialize the
scale_ratio_depth params. Mirrors the dcn20 logic.

Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index 602ec9a08549..8ca26383b568 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -1878,7 +1878,6 @@ noinline bool dcn30_internal_validate_bw(
 	dc->res_pool->funcs->update_soc_for_wm_a(dc, context);
 	pipe_cnt = dc->res_pool->funcs->populate_dml_pipes(dc, context, pipes, fast_validate);
 
-	DC_FP_START();
 	if (!pipe_cnt) {
 		out = true;
 		goto validate_out;
@@ -2104,7 +2103,6 @@ noinline bool dcn30_internal_validate_bw(
 	out = false;
 
 validate_out:
-	DC_FP_END();
 	return out;
 }
 
@@ -2306,7 +2304,9 @@ bool dcn30_validate_bandwidth(struct dc *dc,
 
 	BW_VAL_TRACE_COUNT();
 
+	DC_FP_START();
 	out = dcn30_internal_validate_bw(dc, context, pipes, &pipe_cnt, &vlevel, fast_validate);
+	DC_FP_END();
 
 	if (pipe_cnt == 0)
 		goto validate_out;
-- 
2.34.1

