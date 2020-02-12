Return-Path: <SRS0=l6GN=4A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B084AC3B18B
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Feb 2020 04:33:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 834A52086A
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Feb 2020 04:33:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M8zsO+ZH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 834A52086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2678C6E7EA;
	Wed, 12 Feb 2020 04:33:23 +0000 (UTC)
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com
 [IPv6:2607:f8b0:4864:20::b43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 864566E7EA
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Feb 2020 04:33:22 +0000 (UTC)
Received: by mail-yb1-xb43.google.com with SMTP id v12so476316ybi.5
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Feb 2020 20:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=TQQg681d5AW/gvzKM4jnie12ecUhUxmeAZW/kJLgeN0=;
 b=M8zsO+ZH6U38P4urbcQcxlRZpio4Pl+lY045PmpDREC7ZNwp4VdUHWC/MnQvGbW5Ij
 ApKoG+BxN3A+0qvKL0fDeF7367zezP14BYKgikqh7SfP4el9eHtfwkVKBxP7r7AMoQSF
 tKKpRQe4DjCNLt8ohAzCGfpsF4Ib6JGmAmkejXDSvtBtBZP5Kih/JSWTgq/VcHb5o6Nq
 JcSBNt22zw+IVZWiVJOsqyAy2IHbD1ZNEUIK5z4QL73Y+oZqDoU6sRXYilY7T6vyuxZ/
 lF9XvdlN6sI7z9mgMTRXsJPlRM55/g1HEwuT8/0x2Ava/YAcrED3fsJQnmoMfdq+2kpS
 FHHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=TQQg681d5AW/gvzKM4jnie12ecUhUxmeAZW/kJLgeN0=;
 b=Qcw5GBvSWNnd6vHKs25vHIoogpXbCvOGEpZobd+N977haO+W9VbzOFWhP8QHuK1b90
 ZNxu/hSkH0Ue/T9f5aJARpw1ZPx2mpkBC0O/UoHBsKoQoSRjCJZtUSovazil+AXOjZhg
 QzmYCu+mX8w8nnKvPqitUoOySjRvs4BxIFacMaWgZ96iaORdqhyZma3Kh2FXgIk1BJ9j
 wpZSReOA0Do2BdAQy4M2bO5pgmVF/d1UJ3PG+92HVgrSrCUH7wkY4aOJkdVmc/Q+CVXN
 yX0De3VdH7eMrenefBTRpqRW3m8zBvNofmCValSm0kye2eHpprcawZ6YuZ90lpnmQX6x
 OcXw==
X-Gm-Message-State: APjAAAX/rUfFuUV34b7E7vbayk7W3KAEZ7ixdcL5Sj7o2ZGAK/phKeoI
 m0HmSjl2Ig6wsNuTQvq4X6BLzdrW
X-Google-Smtp-Source: APXvYqxZNcaCMpBBKsaWE5XJPHVF+JXEx6sAnYK+KxTXz2gJsH6hIoXLqSRU8tWdeFf691j9qXl5CA==
X-Received: by 2002:a25:2a47:: with SMTP id q68mr8709213ybq.484.1581482001530; 
 Tue, 11 Feb 2020 20:33:21 -0800 (PST)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id h23sm2966676ywc.105.2020.02.11.20.33.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2020 20:33:21 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/3] drm/amdgpu/display move get_num_odm_splits() into
 dc_resource.c
Date: Tue, 11 Feb 2020 23:32:58 -0500
Message-Id: <20200212043258.1123758-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200212043258.1123758-1-alexander.deucher@amd.com>
References: <20200212043258.1123758-1-alexander.deucher@amd.com>
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

It's used by more than just DCN2.0.  Fixes missing symbol when
amdgpu is built without DCN support.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_resource.c    | 16 ++++++++++++++++
 .../drm/amd/display/dc/dcn20/dcn20_resource.c    | 16 ----------------
 .../drm/amd/display/dc/dcn20/dcn20_resource.h    |  1 -
 drivers/gpu/drm/amd/display/dc/inc/resource.h    |  3 +++
 4 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index c02e5994d32b..572ce3842535 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -532,6 +532,22 @@ static inline void get_vp_scan_direction(
 		*flip_horz_scan_dir = !*flip_horz_scan_dir;
 }
 
+int get_num_odm_splits(struct pipe_ctx *pipe)
+{
+	int odm_split_count = 0;
+	struct pipe_ctx *next_pipe = pipe->next_odm_pipe;
+	while (next_pipe) {
+		odm_split_count++;
+		next_pipe = next_pipe->next_odm_pipe;
+	}
+	pipe = pipe->prev_odm_pipe;
+	while (pipe) {
+		odm_split_count++;
+		pipe = pipe->prev_odm_pipe;
+	}
+	return odm_split_count;
+}
+
 static void calculate_split_count_and_index(struct pipe_ctx *pipe_ctx, int *split_count, int *split_idx)
 {
 	*split_count = get_num_odm_splits(pipe_ctx);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index 39026df56fa6..1061faccec9c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -1861,22 +1861,6 @@ void dcn20_populate_dml_writeback_from_context(
 
 }
 
-int get_num_odm_splits(struct pipe_ctx *pipe)
-{
-	int odm_split_count = 0;
-	struct pipe_ctx *next_pipe = pipe->next_odm_pipe;
-	while (next_pipe) {
-		odm_split_count++;
-		next_pipe = next_pipe->next_odm_pipe;
-	}
-	pipe = pipe->prev_odm_pipe;
-	while (pipe) {
-		odm_split_count++;
-		pipe = pipe->prev_odm_pipe;
-	}
-	return odm_split_count;
-}
-
 int dcn20_populate_dml_pipes_from_context(
 		struct dc *dc, struct dc_state *context, display_e2e_pipe_params_st *pipes)
 {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.h b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.h
index 5180088ab6bc..f5893840b79b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.h
@@ -49,7 +49,6 @@ unsigned int dcn20_calc_max_scaled_time(
 		unsigned int time_per_pixel,
 		enum mmhubbub_wbif_mode mode,
 		unsigned int urgent_watermark);
-int get_num_odm_splits(struct pipe_ctx *pipe);
 int dcn20_populate_dml_pipes_from_context(
 		struct dc *dc, struct dc_state *context, display_e2e_pipe_params_st *pipes);
 struct pipe_ctx *dcn20_acquire_idle_pipe_for_layer(
diff --git a/drivers/gpu/drm/amd/display/dc/inc/resource.h b/drivers/gpu/drm/amd/display/dc/inc/resource.h
index 5ae8ada154ef..ca4c36c0c9bc 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/resource.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/resource.h
@@ -179,4 +179,7 @@ unsigned int resource_pixel_format_to_bpp(enum surface_pixel_format format);
 
 void get_audio_check(struct audio_info *aud_modes,
 	struct audio_check *aud_chk);
+
+int get_num_odm_splits(struct pipe_ctx *pipe);
+
 #endif /* DRIVERS_GPU_DRM_AMD_DC_DEV_DC_INC_RESOURCE_H_ */
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
