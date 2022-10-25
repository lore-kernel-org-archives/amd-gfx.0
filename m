Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FF2BC433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Oct 2022 07:15:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FBC410E484;
	Wed, 26 Oct 2022 07:14:55 +0000 (UTC)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D26D610E042
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Oct 2022 21:20:59 +0000 (UTC)
Received: by mail-wr1-x42d.google.com with SMTP id o4so15016255wrq.6
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Oct 2022 14:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F7T3SAxv+RVQEEfVEAAes/sJ5EOopp0bVTDfxsMs/yk=;
 b=aLLvFaig18fX4FHQjccLjqq24HG5lwWKjT5hDpdCuUGqiIXkm/WSy5mUccA583HHmz
 g4apTxMv8tL7ykrW3/0EUoKaHPIlNyoPA7yUoKNUXpyR1VDU+x1IqSH8Aj9dJDRNw/cT
 7aYaax0nJSleExd+Qf40aBXmayVgy4fz2Ln/ur89a5T3kUnvDrEyOaylQCp/JYJqB6zH
 6x6bNntbqI9B0mKrmRa57Sl/nwray/QRtjD8uyWoYCK3QVOwyOWQSV25bSI3/1H5C2vc
 7tiZzGlKscPjp2VadJuVYkQZGMiOyWSvHIblbxlU+o5YOgCAe6/8XzAfR5I5e/XbTcE8
 ro+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F7T3SAxv+RVQEEfVEAAes/sJ5EOopp0bVTDfxsMs/yk=;
 b=2EzHgehh9jzXd5kQenhvoSrDZ1zPRYqRxL7wRZTDcX4/xWyBStuZOPfsreI1VVebQ5
 +2W3DK0RrQd1pJbqBmyFPQqoeeCx6FU6iP2fnOcY/s+KjLmvNFxj8vGhj0b4vQnZJBEn
 uf9UuEDAqdLYQW9qTHIX1Fe0Qzz4VOFeFD1TbiogkdguK+0/HNgcZ9+Hyj9Verzjybk2
 NzGqZC3JuzbT+/lLyyseMFH53cT64cSfdICOqsI6tiYX5ltbTaZJdxB/WHnqP0WmzXqK
 2t0VaU+KjzVD3ysMVb1eU4Z2+Lep4AX3ubc/u4oKRHJyaTk55IMd0afy9KQ8Evuz0Wlb
 ZHag==
X-Gm-Message-State: ACrzQf3gWt/LzhEvAZWTiDPKdnEId4Pd6HfcCgCl8IN3mfQVHQTtly+a
 65PqGpE72FRHEaFmIDqm90pD0pzfcRIp3mVE
X-Google-Smtp-Source: AMsMyM6emCmy/60rRRPju7Wy4RNqezF+bK55sfuYJYH7hOaoLx2n/L3YVrWCvHWS8G7Im29pY8wHeQ==
X-Received: by 2002:adf:f50b:0:b0:236:7d5d:d785 with SMTP id
 q11-20020adff50b000000b002367d5dd785mr4368226wro.427.1666732858251; 
 Tue, 25 Oct 2022 14:20:58 -0700 (PDT)
Received: from localhost.localdomain ([2a02:908:4f6:d280::9a6])
 by smtp.gmail.com with ESMTPSA id
 j8-20020a05600c190800b003b47e8a5d22sm88174wmq.23.2022.10.25.14.20.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Oct 2022 14:20:57 -0700 (PDT)
From: Ao Zhong <hacc1225@gmail.com>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Subject: [PATCH v2 2/2] drm/amd/display: move remaining FPU code to dml folder
Date: Tue, 25 Oct 2022 23:17:49 +0200
Message-Id: <20221025211746.16276-2-hacc1225@gmail.com>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <8055465a-4a0e-722b-c436-f39d6818ec73@amd.com>
References: <8055465a-4a0e-722b-c436-f39d6818ec73@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 26 Oct 2022 07:14:45 +0000
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
 Harry Wentland <harry.wentland@amd.com>, amd-gfx@lists.freedesktop.org
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

