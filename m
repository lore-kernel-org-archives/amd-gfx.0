Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F3A8C3ABA2
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Apr 2025 02:11:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 312D710E5A1;
	Tue,  8 Apr 2025 02:11:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OwlPflh4";
	dkim-atps=neutral
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com
 [209.85.222.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 220E110E1FF
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Apr 2025 02:11:32 +0000 (UTC)
Received: by mail-qk1-f180.google.com with SMTP id
 af79cd13be357-7c58974ed57so530342585a.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 07 Apr 2025 19:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744078289; x=1744683089; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3lNznaki9Ko/QBtJDh3MPNnUILUrPBTJASDt/2TEAyM=;
 b=OwlPflh4q44BsXMQdFaxBPBAufALF0hin3qBXzU2k3NGwn++f3t/dUamnfeCJ+kdnA
 FXd9GRjEplSvYQ4Xe0cHnYLkusZbg9bUMeZLxnkeeNeiH6xzrBoGdCpYPKB+2ZyVk3ti
 FAlt2XUkNQXS3z9Krf8MMvynhIlCsgYx3I/cSgGbMNmGdUJbDI/ozVhK9LXbFQ/Mu2E5
 EogAylYRoG9WkQgGYDOYrWql4mNXmBQka5QvreiIwhiOoTfKKdT0xf3gGim3w6dNac/F
 UdvXk4PYKzR8kGLfRh0MgJhcGfMFdng6+y/E1ljq29sNj7rOAeLtbUyNYSRXRsWF/CXa
 1vxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744078289; x=1744683089;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3lNznaki9Ko/QBtJDh3MPNnUILUrPBTJASDt/2TEAyM=;
 b=Ej40El9ttxHuouYmmRw/nIkAaNaGs0C5PTp7GTj8KphJO117bu0CL96Zv6sApQ2b2C
 HMO0YXyhaB0vFhcsy8NDV2sUVoTHyTPF/K+FV2obQEH7t61cqMxTXzeQBtcfIT+ZohKi
 xhPfTFvDKdL3J1JFXTeNxPMa/CTo5Im4qX1p9u8YGr6LkuGGIl23p71sEhOUpdcBTYyz
 YUzHUggE67wKCbiu/7R1hSRwCYvA60DgxARgyxk88Ui3W/AE7WNHCSulAleLMF+i3g/r
 a9BznZRxCqMAQtdHqKDfboH1ov3t/+hIJrN/KDEU6t9zC3WLd2HS343+hnQjh65TpAZq
 cddA==
X-Gm-Message-State: AOJu0YwUitybGrcrVKLmewvMc/g0ShudcaNkO/iE575GbZFrXPML0XGE
 zYz5aXN7v++eyWoIftdyVKpFSlhpZkpyEJXTFULhqT8CQUnD+dlQng7BGA==
X-Gm-Gg: ASbGncuo64zq6alWXIy/huqXV1W0wBFvVLE1rM66NsRpR6sy2gTtoBMA25tuN4OxAn4
 xIrQmpB3BrbyX1XWJVbpNf9lEZC1rCojHSuQT4PdAC7aJPyjwDaVVuwWPbkxMOMZlayT9dVO+PE
 3BBU0ISJ7cR5hLaJ5+Oz44hOmoGbCsdqgU1RBFYrCAmMCT4Pqq/CPT8R8DZROcmUbmo6aEpdfMF
 kDfXifS/WYC09D+NFwSyoUV/squ7jcLl/xxM95cqOIxAEgXGeYceOVnX/qZchXQZz/df0cfLuSO
 CRW5R+Q3PU3F2l1I327MAh680KW4+BAK26Tnh6dUDyoW/PQXjx8gvlcINslbaDTn5G/s
X-Google-Smtp-Source: AGHT+IFSVnlIC4OHj3oLUfCl1y+LAtbjL4EOel9ObhREEMwCMcDsVWq+0opbX053Vaquv92jOO8NBg==
X-Received: by 2002:a05:620a:25cb:b0:7c5:3c0a:ab7e with SMTP id
 af79cd13be357-7c774d25540mr1962079585a.5.1744078288959; 
 Mon, 07 Apr 2025 19:11:28 -0700 (PDT)
Received: from localhost.localdomain ([38.121.253.36])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c76ea5992csm687693985a.84.2025.04.07.19.11.28
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 19:11:28 -0700 (PDT)
From: Alexandre Demers <alexandre.f.demers@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/6] drm/amdgpu: rename function to follow naming convention
 in dce110
Date: Mon,  7 Apr 2025 22:10:55 -0400
Message-ID: <20250408021100.5439-2-alexandre.f.demers@gmail.com>
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

The prefix dce110 is used on all functions, but init_pipes() and
init_hw(). Under DCN, these sames functions are prefixed.

Let's keep thing coherent.

Signed-off-by: Alexandre Demers <alexandre.f.demers@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index 81f4c386c287..9cc6301796f5 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -2761,12 +2761,12 @@ static void dce110_enable_per_frame_crtc_position_reset(
 
 }
 
-static void init_pipes(struct dc *dc, struct dc_state *context)
+static void dce110_init_pipes(struct dc *dc, struct dc_state *context)
 {
 	// Do nothing
 }
 
-static void init_hw(struct dc *dc)
+static void dce110_init_hw(struct dc *dc)
 {
 	int i;
 	struct dc_bios *bp;
@@ -3325,7 +3325,7 @@ void dce110_disable_link_output(struct dc_link *link,
 static const struct hw_sequencer_funcs dce110_funcs = {
 	.program_gamut_remap = program_gamut_remap,
 	.program_output_csc = program_output_csc,
-	.init_hw = init_hw,
+	.init_hw = dce110_init_hw,
 	.apply_ctx_to_hw = dce110_apply_ctx_to_hw,
 	.apply_ctx_for_surface = dce110_apply_ctx_for_surface,
 	.post_unlock_program_front_end = dce110_post_unlock_program_front_end,
@@ -3368,7 +3368,7 @@ static const struct hw_sequencer_funcs dce110_funcs = {
 };
 
 static const struct hwseq_private_funcs dce110_private_funcs = {
-	.init_pipes = init_pipes,
+	.init_pipes = dce110_init_pipes,
 	.set_input_transfer_func = dce110_set_input_transfer_func,
 	.set_output_transfer_func = dce110_set_output_transfer_func,
 	.power_down = dce110_power_down,
-- 
2.49.0

