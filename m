Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DEDDC25B78
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Jun 2024 12:48:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3238510E47B;
	Tue,  4 Jun 2024 12:48:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="YNMCIMpC";
	dkim-atps=neutral
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com
 [209.85.167.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E27AC10E44A
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Jun 2024 10:39:34 +0000 (UTC)
Received: by mail-lf1-f50.google.com with SMTP id
 2adb3069b0e04-52b976b5d22so2434704e87.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 04 Jun 2024 03:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1717497573; x=1718102373;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=F3WCRRHJvbBRghgXSmEq8Fvp6W4aBxQB8LzjGg3Uzwg=;
 b=YNMCIMpC+zMhTLKr0xt7zazKpkfxPLWc+4iB+joU4u/1yd0+CeLS0pSSP4mvPnn01H
 g8r2szv8angGRUgRo8YtucUQktkRMyhoWDtVmN8ZrRdPYb6RfcXtV+ICWstgW1bGspAD
 VK7HSaB+DplN105ivDseoR7Re3kne+ug0HCkS4McYgvLznaJq5Aqb/6frzA8IJ2xsIFp
 FtWwNtCGAUa2C4z5v5Fw1zHO0AEhr0f9GUeloe7w/6Keyt/ThP3e3aOEG3ulTGBAOFHD
 lpAGnKR6uPJwFlAhBF7bLtf3vwOj5y/8U3RNRfa84gPdIqeZ2m/bMytRKwiKGnhUzjpG
 Qp9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717497573; x=1718102373;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=F3WCRRHJvbBRghgXSmEq8Fvp6W4aBxQB8LzjGg3Uzwg=;
 b=RlCsJabbRf9Rb01+kJUl604NBh+Ol6w51mcfQUIDbbGguKGo/w96ZnEq/+AtxyJwm0
 xmtTd/pkeIWJyo0wwPlkKyl2w4S27XeIai9m8kve+Yqd5XAE+X4mQz5sfVQNhyu6TKr2
 gX3WH3d7FmqgCmT4XV0KgBbwCQ3bbSwyEm609XJsZ5DziKTGB/moH6gxS/sMLae+Djak
 zMvDUs6lT9TfEGN9oR98RqVJF0erB+h2Y5SR+CVApPKAUvPLVzvj56qWTLyhF1zKsbMr
 a6AO9C/sVt7+Xpu0kiI2rB2JM2lSqQgm38BG/EwkLrtbaLmKwuPHREzENv3898nd86QR
 FVEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXyZOtTOlGX7hi23ZzY8Q10WRYxQEYGsQbECvVPv1zNHZ4dcesX1KT0e1ED7lXIOLvKdHH/s4eGcuJx+AyjykSiBn4oLSlTimMlj+z0WQ==
X-Gm-Message-State: AOJu0YzSpmsVEsDCN1GX7u701zPAnJU2iLn2vFWkbv6JCO5b2ZQe7tOB
 reuJYxZASY+H7lAQFvawh4Fl06eXQ6MdgvUYtdrRY074n/bDPonvStB+XoUipv4=
X-Google-Smtp-Source: AGHT+IETd4msXoxRl+ud5mCwMFNofqwpac+oO3fwbkx5DB7asjTWSlI02keQuaJBEBR7nsu+b/81Pg==
X-Received: by 2002:a05:651c:1991:b0:2d8:930c:bbfa with SMTP id
 38308e7fff4ca-2ea950c5fafmr91095041fa.5.1717497572574; 
 Tue, 04 Jun 2024 03:39:32 -0700 (PDT)
Received: from debian.fritz.box. (aftr-82-135-80-160.dynamic.mnet-online.de.
 [82.135.80.160]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4212b84be78sm149457245e9.17.2024.06.04.03.39.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jun 2024 03:39:32 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: harry.wentland@amd.com, sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 daniel@ffwll.ch
Cc: Qingqing.Zhuo@amd.com, roman.li@amd.com, hersenxs.wu@amd.com,
 chaitanya.dhere@amd.com, wenjing.liu@amd.com, alex.hung@amd.com,
 sungkim@amd.com, syed.hassan@amd.com, syedsaaem.rizvi@amd.com,
 dillon.varone@amd.com, charlene.liu@amd.com, hamza.mahfooz@amd.com,
 nicholas.kazlauskas@amd.com, jerry.zuo@amd.com,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] drm/amd/display: Simplify if conditions
Date: Tue,  4 Jun 2024 12:37:37 +0200
Message-Id: <20240604103736.3068-1-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 04 Jun 2024 12:47:58 +0000
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

The if conditions !A || A && B can be simplified to !A || B.

Fixes the following Coccinelle/coccicheck warnings reported by
excluded_middle.cocci:

	WARNING !A || A && B is equivalent to !A || B
	WARNING !A || A && B is equivalent to !A || B
	WARNING !A || A && B is equivalent to !A || B

Compile-tested only.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c | 6 +++---
 .../gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c   | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
index ad2a6b4769fe..940081df6dc0 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
@@ -68,7 +68,7 @@ static bool get_plane_id(struct dml2_context *dml2, const struct dc_state *state
 		if (state->streams[i]->stream_id == stream_id) {
 			for (j = 0; j < state->stream_status[i].plane_count; j++) {
 				if (state->stream_status[i].plane_states[j] == plane &&
-					(!is_plane_duplicate || (is_plane_duplicate && (j == plane_index)))) {
+					(!is_plane_duplicate || (j == plane_index))) {
 					*plane_id = (i << 16) | j;
 					return true;
 				}
@@ -707,8 +707,8 @@ static void free_unused_pipes_for_plane(struct dml2_context *ctx, struct dc_stat
 	for (i = 0; i < ctx->config.dcn_pipe_count; i++) {
 		if (state->res_ctx.pipe_ctx[i].plane_state == plane &&
 			state->res_ctx.pipe_ctx[i].stream->stream_id == stream_id &&
-			(!is_plane_duplicate || (is_plane_duplicate &&
-			ctx->v20.scratch.dml_to_dc_pipe_mapping.dml_pipe_idx_to_plane_index[state->res_ctx.pipe_ctx[i].pipe_idx] == plane_index)) &&
+			(!is_plane_duplicate ||
+			ctx->v20.scratch.dml_to_dc_pipe_mapping.dml_pipe_idx_to_plane_index[state->res_ctx.pipe_ctx[i].pipe_idx] == plane_index) &&
 			!is_pipe_used(pool, state->res_ctx.pipe_ctx[i].pipe_idx)) {
 			free_pipe(&state->res_ctx.pipe_ctx[i]);
 		}
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
index a41812598ce8..b2bbf7988f92 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
@@ -979,7 +979,7 @@ static bool get_plane_id(struct dml2_context *dml2, const struct dc_state *conte
 		if (context->streams[i]->stream_id == stream_id) {
 			for (j = 0; j < context->stream_status[i].plane_count; j++) {
 				if (context->stream_status[i].plane_states[j] == plane &&
-					(!is_plane_duplicate || (is_plane_duplicate && (j == plane_index)))) {
+					(!is_plane_duplicate || (j == plane_index))) {
 					*plane_id = (i << 16) | j;
 					return true;
 				}
-- 
2.39.2

