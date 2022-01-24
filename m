Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A066BC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jan 2022 00:23:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE58D10E149;
	Mon, 24 Jan 2022 00:23:35 +0000 (UTC)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6608810E149
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jan 2022 00:23:34 +0000 (UTC)
Received: by mail-wr1-x429.google.com with SMTP id s18so10527185wrv.7
 for <amd-gfx@lists.freedesktop.org>; Sun, 23 Jan 2022 16:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen.nl; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Zq4/GHvYGZool2h9WbQe1drYbJ4VfS1/2qLhFQ4qCw4=;
 b=IabeUoIfxbGhBD/Tz8CuxV5jU0/TaRXaTdHgjE/9UpVaqWD9T0mgFqFscRu9zxo4NG
 NQFOo+gpr1TfrciCSjtgWgHDg+GMr4+JVwD8Ibz1FkeAi+cFBqhTa0GA/a2738sRO176
 1/aqrlLnIrIFzoYwojBP9NHLNW6ebjA6dFw1lSp0LEsCSffZ4mU9Kp9CTWHnjPLveQU2
 00cLPAdVVR1k5CQ9MY8Zd4AbGfZIJ/6PW2ZEJaRBDMYUNApJYU9QG/2AVphpcKo1IA+H
 amPkEzDJuaXESYXG0fJecVYdqnTn0BoOZqlqyB1yH5aROm34VVlY+FqOhDDU4ggURvgl
 l8mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Zq4/GHvYGZool2h9WbQe1drYbJ4VfS1/2qLhFQ4qCw4=;
 b=4APFrHryjAn1MrJjLjcVZ0dZsZvFugrzzm5Csg017qsfsFOM/fZLxgjv0ZH+0Idos0
 KlSAzqxoA281Ix+GNJzLLYtCpH6Hu7q/bLTlJ2xdiq4G0tPAQ+fUI8VefKqkdazQ8CyT
 SD2A+mDQ4k7O5tP9iPJYReY3vOuMECPFUYsO9bIDzOJCxoc4xKeA9CNaELR1XAWSCpdm
 2BgYxClT2EyN9q172UBvowLqwQtPFpRuYK2JjOzoF+H4sT9cQlXM1Kv1XiAmiq/OnlOs
 YaNzedzrxmqOURtZ2AuVqpRZnmMVmcUARYjT9D8pykJEQaRjlRhlRS7cT+psMNye0l62
 Koww==
X-Gm-Message-State: AOAM532fvHXB+WjccaCSBMcW2z5hkKP/twjb24EqZdODHf0WQXp3YmyW
 l5+dfJLm2LNVeJ4Z8Vq5RujNnGOuGpBQ+mjs
X-Google-Smtp-Source: ABdhPJxPCd/2l15qedOnjNsCG4HceIACEkDH8+TXpHtPGZkfPZWqkrkz0cl1Ns9jf0ji207fXlv7rQ==
X-Received: by 2002:adf:ea41:: with SMTP id j1mr12097355wrn.649.1642983812751; 
 Sun, 23 Jan 2022 16:23:32 -0800 (PST)
Received: from bas-workstation.. ([2a02:aa12:a77f:2000:7285:c2ff:fe67:a82f])
 by smtp.gmail.com with ESMTPSA id j4sm14381909wrq.81.2022.01.23.16.23.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Jan 2022 16:23:32 -0800 (PST)
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amd/display: Wrap dcn301_calculate_wm_and_dlg for FPU.
Date: Mon, 24 Jan 2022 01:23:36 +0100
Message-Id: <20220124002336.3455326-2-bas@basnieuwenhuizen.nl>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220124002336.3455326-1-bas@basnieuwenhuizen.nl>
References: <20220124002336.3455326-1-bas@basnieuwenhuizen.nl>
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

Mirrors the logic for dcn30. Cue lots of WARNs and some
kernel panics without this fix.

Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
---
 .../gpu/drm/amd/display/dc/dcn301/dcn301_resource.c   | 11 +++++++++++
 .../gpu/drm/amd/display/dc/dml/dcn301/dcn301_fpu.c    |  2 +-
 .../gpu/drm/amd/display/dc/dml/dcn301/dcn301_fpu.h    |  2 +-
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
index b4001233867c..5d9637b07429 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
@@ -1380,6 +1380,17 @@ static void set_wm_ranges(
 	pp_smu->nv_funcs.set_wm_ranges(&pp_smu->nv_funcs.pp_smu, &ranges);
 }
 
+static void dcn301_calculate_wm_and_dlg(
+		struct dc *dc, struct dc_state *context,
+		display_e2e_pipe_params_st *pipes,
+		int pipe_cnt,
+		int vlevel)
+{
+	DC_FP_START();
+	dcn301_calculate_wm_and_dlg_fp(dc, context, pipes, pipe_cnt, vlevel);
+	DC_FP_END();
+}
+
 static struct resource_funcs dcn301_res_pool_funcs = {
 	.destroy = dcn301_destroy_resource_pool,
 	.link_enc_create = dcn301_link_encoder_create,
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn301/dcn301_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn301/dcn301_fpu.c
index 94c32832a0e7..0a7a33864973 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn301/dcn301_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn301/dcn301_fpu.c
@@ -327,7 +327,7 @@ void dcn301_fpu_init_soc_bounding_box(struct bp_soc_bb_info bb_info)
 		dcn3_01_soc.sr_exit_time_us = bb_info.dram_sr_exit_latency_100ns * 10;
 }
 
-void dcn301_calculate_wm_and_dlg(struct dc *dc,
+void dcn301_calculate_wm_and_dlg_fp(struct dc *dc,
 		struct dc_state *context,
 		display_e2e_pipe_params_st *pipes,
 		int pipe_cnt,
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn301/dcn301_fpu.h b/drivers/gpu/drm/amd/display/dc/dml/dcn301/dcn301_fpu.h
index fc7065d17842..774b0fdfc80b 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn301/dcn301_fpu.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn301/dcn301_fpu.h
@@ -34,7 +34,7 @@ void dcn301_fpu_set_wm_ranges(int i,
 
 void dcn301_fpu_init_soc_bounding_box(struct bp_soc_bb_info bb_info);
 
-void dcn301_calculate_wm_and_dlg(struct dc *dc,
+void dcn301_calculate_wm_and_dlg_fp(struct dc *dc,
 		struct dc_state *context,
 		display_e2e_pipe_params_st *pipes,
 		int pipe_cnt,
-- 
2.34.1

