Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E392C433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Oct 2022 14:21:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FDBA10E501;
	Wed, 26 Oct 2022 14:20:50 +0000 (UTC)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 661A710E4A7
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Oct 2022 11:14:35 +0000 (UTC)
Received: by mail-wr1-x42b.google.com with SMTP id bk15so25721188wrb.13
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Oct 2022 04:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z2dAxyBdcsGYNCn7JV332sMdo/wGykOw3BmjYudGgAI=;
 b=LqC5CmPnOOwqJE6avCuKn7TR+XuD5PByXL9JHS9lDINKqyTUeUW/3GkLPfQbrHGVGZ
 PJn3G+DXsx9LlqN80yfhs1zGtTx//Mm/n60MjxGLcpjKlEn1vVrmNpb7/pJLhNuK7T2Z
 8mfQbIKrSNBapFHn3aGdYX9moQgv3B7Ty+vZ3fHjH3b41ImP6pXQo+E21G3OoJDnpvdm
 omW5NsAV95DM+Rc5WmtsLX/EcxOiJmO8jC+5VigtrCcxq1enPD4mrIUEvjuOTsMC0s0l
 PKMokB7f6zTZeGgHmadXzIAhR0cGDVKlgaMKXEDgWhfSFBnCkFBahZ0B/WHXAJGBXNLc
 cz4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z2dAxyBdcsGYNCn7JV332sMdo/wGykOw3BmjYudGgAI=;
 b=kB2Eka4Wghl+39Md/3ySe3OAPvlF8s+41rR2R20i/Yc8w67NbvwLM6kehLv3/s0zCK
 i+ZQiAkUNUPgGS7PSqbjZGjV6Ghf2folw+l9OPqHi3ZrKXqT0yFIOr3cjpsN/7PLKkcY
 nq0fygyAE5wd93PAo+FKEq0tP1Htvwmz4zoPprY8PiFuHG4rZogo+zqwUJNTUDYdG54/
 yCDzSNUm3cfRJCNfsJqXI+m73gOE/g2McYUfziJRDS5kEo2rhsluh/cC6R29MedDT5EG
 A5G3rotNqbaYnZ/UbmP0GtvJ+4zrKZPZRg3kiZ/SxwMf1POptdCb9Vh+3s5Vwyl/BeSc
 zVVw==
X-Gm-Message-State: ACrzQf3/s3lPZQ4LMv7T8P/74c6w9hHgw2sHuRVEIm75FPAM5CTRXnsZ
 Z8Z4NJyHzIvfJYEP5pSNRM6VNvMcCeiznNvz
X-Google-Smtp-Source: AMsMyM7K17+3EeB9GcPGFZfV+Jx0j5EbJIknUqiRn4o074JIUKolXFfJYPyFkkJlHHlhENuSampiOw==
X-Received: by 2002:adf:fb43:0:b0:22b:64:8414 with SMTP id
 c3-20020adffb43000000b0022b00648414mr29190606wrs.70.1666782873651; 
 Wed, 26 Oct 2022 04:14:33 -0700 (PDT)
Received: from localhost.localdomain ([2a02:908:4f6:d280::9a6])
 by smtp.gmail.com with ESMTPSA id
 bg33-20020a05600c3ca100b003b49bd61b19sm1665827wmb.15.2022.10.26.04.14.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Oct 2022 04:14:33 -0700 (PDT)
From: Ao Zhong <hacc1225@gmail.com>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Subject: [PATCH v3 2/2] drm/amd/display: move remaining FPU code to dml folder
Date: Wed, 26 Oct 2022 13:13:03 +0200
Message-Id: <20221026111258.25000-2-hacc1225@gmail.com>
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

