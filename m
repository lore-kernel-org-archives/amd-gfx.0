Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E42EFC433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Oct 2022 14:20:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0821F10E1D9;
	Wed, 26 Oct 2022 14:20:42 +0000 (UTC)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E9BD10E4B4
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Oct 2022 11:06:28 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id
 v130-20020a1cac88000000b003bcde03bd44so1193729wme.5
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Oct 2022 04:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z2dAxyBdcsGYNCn7JV332sMdo/wGykOw3BmjYudGgAI=;
 b=pM2G00Yk8X5K/YGfOsxyMqfE5/uhjQ5fabLl/gD/3tYMy0ITW8JVSPaMYICt34sTzO
 XTHpo0KtnelRmYZe/j09Z6UX89YRNTkJPm1TV/sKor8xmnn6cUBZrniCE0pLhrgmrS7T
 TObsh/Wg5+AjkCBN8ki/H3uEKnjJGoFH44zt76sQIRLIW3/AqKpfuk7FJEaDaZMFrGSz
 uLqffihvkCloa1d5UvYKhv67jl1hQB4n3jsHm+p522eqezl538D3Uvqzeh5k0HCOq0LG
 9TIjudMarIXtRNAZNgqMbkL1nq+42+myBurCUR78yTTmW2tzPU9qa1/a3oUcYRYtsp0y
 9PfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z2dAxyBdcsGYNCn7JV332sMdo/wGykOw3BmjYudGgAI=;
 b=zLLsubdFagyl1UF2FXTLYop3WOpqxdVjsF67ohD9htlzvBdtFjTOQmpOIHfMLdf0sx
 5WIv17B0keN9VTm8Z/k1hJt71bXu0Any95991RMfTVSdmcWObQILsRPz9BenKc3npjKX
 d5GcWd5fpM3T84YQuiz9Emn7jMujwhmXwSxFDAJGa+ojNV0O85Mm8bdSmh4hyp9p5RMd
 Ba0VvF4m8EYFS/8LvfVKLLa6bXLtNbO4+kGotxMP/0nFt2QnuWr1YRgUI4PTJYFy31L5
 ijQz/Ltv8vLlIzEiZ87usg3X0ifoXedCWl5ggO8d0x1qAiMbM5F3FijCuAEzY86GDFUL
 5LJA==
X-Gm-Message-State: ACrzQf3dGaYv2d5oKlU4yRoGufVxnLZ0Wdnkc8NeLU6lYYfnVRNXnbSs
 Y4zFRZtqLM2g37FR9iGD8aY=
X-Google-Smtp-Source: AMsMyM7hgCVW0hSCZTmzoBhRMmPGyxqwQs9nTn9AjEzWacY3B+t+ML0npDWp2STawUl/aB6XyR1BLQ==
X-Received: by 2002:a1c:440b:0:b0:3cf:4db1:d741 with SMTP id
 r11-20020a1c440b000000b003cf4db1d741mr890758wma.197.1666782387002; 
 Wed, 26 Oct 2022 04:06:27 -0700 (PDT)
Received: from localhost.localdomain ([2a02:908:4f6:d280::9a6])
 by smtp.gmail.com with ESMTPSA id
 bs14-20020a056000070e00b002366553eca7sm4646921wrb.83.2022.10.26.04.06.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Oct 2022 04:06:26 -0700 (PDT)
From: Ao Zhong <hacc1225@gmail.com>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Subject: [PATCH v2 2/2] drm/amd/display: move remaining FPU code to dml folder
Date: Wed, 26 Oct 2022 13:02:21 +0200
Message-Id: <20221026110218.24599-2-hacc1225@gmail.com>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <e4440d8d-61d3-5d71-ba48-79fec268f4af@amd.com>
References: <e4440d8d-61d3-5d71-ba48-79fec268f4af@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 26 Oct 2022 14:20:40 +0000
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
Cc: Leo Li <sunpeng.li@amd.com>, Ao Zhong <hacc1225@gmail.com>,
 Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

pipes[pipe_cnt].pipe.src.dcc_fraction_of_zs_req_luma = 0;
pipes[pipe_cnt].pipe.src.dcc_fraction_of_zs_req_chroma = 0;
these two operations in dcn32/dcn32_resource.c still need to use FPU,
This will cause compilation to fail on ARM64 platforms because
-mgeneral-regs-only is enabled by default to disable the hardware FPU.
Therefore, imitate the dcn31_zero_pipe_dcc_fraction function in
dml/dcn31/dcn31_fpu.c, declare the dcn32_zero_pipe_dcc_fraction function
in dcn32_fpu.c, and move above two operations into this function.

Acked-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Ao Zhong <hacc1225@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c | 5 +++--
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  | 8 ++++++++
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h  | 3 +++
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index a88dd7b3d1c1..287b7fa9bf41 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -1918,8 +1918,9 @@ int dcn32_populate_dml_pipes_from_context(
 		timing = &pipe->stream->timing;
 
 		pipes[pipe_cnt].pipe.src.gpuvm = true;
-		pipes[pipe_cnt].pipe.src.dcc_fraction_of_zs_req_luma = 0;
-		pipes[pipe_cnt].pipe.src.dcc_fraction_of_zs_req_chroma = 0;
+		DC_FP_START();
+		dcn32_zero_pipe_dcc_fraction(pipes, pipe_cnt);
+		DC_FP_END();
 		pipes[pipe_cnt].pipe.dest.vfront_porch = timing->v_front_porch;
 		pipes[pipe_cnt].pipe.src.gpuvm_min_page_size_kbytes = 256; // according to spreadsheet
 		pipes[pipe_cnt].pipe.src.unbounded_req_mode = false;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 819de0f11012..58772fce6437 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -2521,3 +2521,11 @@ void dcn32_update_bw_bounding_box_fpu(struct dc *dc, struct clk_bw_params *bw_pa
 	}
 }
 
+void dcn32_zero_pipe_dcc_fraction(display_e2e_pipe_params_st *pipes,
+				  int pipe_cnt)
+{
+	dc_assert_fp_enabled();
+
+	pipes[pipe_cnt].pipe.src.dcc_fraction_of_zs_req_luma = 0;
+	pipes[pipe_cnt].pipe.src.dcc_fraction_of_zs_req_chroma = 0;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h
index 3a3dc2ce4c73..ab010e7e840b 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h
@@ -73,4 +73,7 @@ int dcn32_find_dummy_latency_index_for_fw_based_mclk_switch(struct dc *dc,
 
 void dcn32_patch_dpm_table(struct clk_bw_params *bw_params);
 
+void dcn32_zero_pipe_dcc_fraction(display_e2e_pipe_params_st *pipes,
+				  int pipe_cnt);
+
 #endif
-- 
2.37.4

