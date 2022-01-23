Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22BA8C433F5
	for <amd-gfx@archiver.kernel.org>; Sun, 23 Jan 2022 02:38:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D8FE10E17D;
	Sun, 23 Jan 2022 02:38:27 +0000 (UTC)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A810F10E17D
 for <amd-gfx@lists.freedesktop.org>; Sun, 23 Jan 2022 02:38:25 +0000 (UTC)
Received: by mail-wr1-x432.google.com with SMTP id h29so4434342wrb.5
 for <amd-gfx@lists.freedesktop.org>; Sat, 22 Jan 2022 18:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen.nl; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=GBRF7kMtmQT1So2HvAEx1sH4/oRrcbKlHGkYAbSPjjk=;
 b=EOa7+X4OL9GK3IJ0UTVZ4RI0CXj117yxdVc9DJwyH1hnAaxi8fNW1e4CMauzvJQ88k
 SngQ9h5Srz5MXXG8VWDtJLOi0+6LhAwB60/RFeTX3R8wyJhvtdsKmvsd3kYHAp6HKj7o
 ifz3JXvdw7O2EQMfNrEMjwCl/C0m716mQdYyg03dgW6NS3sDVQ47zdtxucyOTse69Qb9
 ldKDE1TzdBUj9qFitTj18manDgCyeUXKA2KHRWZkqCvb2Le9euH9RIwcXVa8q2EyTMim
 GIFzfNmqYLdZS5XMqdW0Qi0KIRtPRjVl09WmUbZN9/nMILTF2zsVfkRjdP9CwPpoiLIb
 HzAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=GBRF7kMtmQT1So2HvAEx1sH4/oRrcbKlHGkYAbSPjjk=;
 b=xovQyGPlSvlph5fvYxJ64du2GwFmCf1zXaaulEwGTkdwb8S0Bo7YOcfdXzPIAv0ZBX
 nQE3Pe73eeZJnCrkZ2v4Znc783nXh4z94gn7k2vXdYt42ftKk8raeVZcSdIoHo8S4oKY
 ZkCwDdPEgMOuwAUkSZLJL9Hjhcd6I/I7mNvhyFolXif2+tI9mauIOceVZDP7LRT1X5W4
 Y0T+Z0XJqsDo7QrzqktjiSVCM57Kax731RATcG7fUDVbrdgA/uiviqSCjXTyu7KjLP0w
 tjGYZuKeQNcoJs1aE/scBzJHdVciF8r9PXZw6gbESpDQdjttu6BaroxPxk3lF0vsAkwJ
 32Gw==
X-Gm-Message-State: AOAM533wKcEGpSYqoVD+SCLJylf3Uz55I+kh8ff/ZGMyKraTyPrwt689
 lPFqPrYbaYy2xJNwslFVeBrPobIxjRAa6aWJ
X-Google-Smtp-Source: ABdhPJwWm1R632+FnpWXhsmYdJIXOAkAV2cwI9KEvFtJWxb7uz/Ta7Taeo8QpWv8JklCKIkV2pks6g==
X-Received: by 2002:adf:d849:: with SMTP id k9mr9239198wrl.513.1642905503809; 
 Sat, 22 Jan 2022 18:38:23 -0800 (PST)
Received: from bas-workstation.. ([2a02:aa12:a77f:2000:7285:c2ff:fe67:a82f])
 by smtp.gmail.com with ESMTPSA id u14sm10209493wrm.58.2022.01.22.18.38.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Jan 2022 18:38:23 -0800 (PST)
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/display: Remove t_srx_delay_us.
Date: Sun, 23 Jan 2022 03:38:28 +0100
Message-Id: <20220123023828.1443906-1-bas@basnieuwenhuizen.nl>
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

Unused. Convert the divisions into asserts on the divisor, to
debug why it is zero. The divide by zero is suspected of causing
kernel panics.

While I have no idea where the zero is coming from I think this
patch is a positive either way.

Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
---
 drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c          | 1 -
 .../gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c | 2 --
 .../drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.c   | 2 --
 .../gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c | 2 --
 .../gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.c | 2 --
 drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h     | 1 -
 drivers/gpu/drm/amd/display/dc/dml/display_rq_dlg_helpers.c   | 3 ---
 drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.c | 4 ----
 8 files changed, 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c b/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c
index ec19678a0702..e447c74be713 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c
@@ -503,7 +503,6 @@ static void dcn_bw_calc_rq_dlg_ttu(
 	//input[in_idx].dout.output_standard;
 
 	/*todo: soc->sr_enter_plus_exit_time??*/
-	dlg_sys_param->t_srx_delay_us = dc->dcn_ip->dcfclk_cstate_latency / v->dcf_clk_deep_sleep;
 
 	dml1_rq_dlg_get_rq_params(dml, rq_param, &input->pipe.src);
 	dml1_extract_rq_regs(dml, rq_regs, rq_param);
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c
index 246071c72f6b..548cdef8a8ad 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c
@@ -1576,8 +1576,6 @@ void dml20_rq_dlg_get_dlg_reg(struct display_mode_lib *mode_lib,
 	dlg_sys_param.total_flip_bytes = get_total_immediate_flip_bytes(mode_lib,
 			e2e_pipe_param,
 			num_pipes);
-	dlg_sys_param.t_srx_delay_us = mode_lib->ip.dcfclk_cstate_latency
-			/ dlg_sys_param.deepsleep_dcfclk_mhz; // TODO: Deprecated
 
 	print__dlg_sys_params_st(mode_lib, &dlg_sys_param);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.c
index 015e7f2c0b16..0fc9f3e3ffae 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.c
@@ -1577,8 +1577,6 @@ void dml20v2_rq_dlg_get_dlg_reg(struct display_mode_lib *mode_lib,
 	dlg_sys_param.total_flip_bytes = get_total_immediate_flip_bytes(mode_lib,
 			e2e_pipe_param,
 			num_pipes);
-	dlg_sys_param.t_srx_delay_us = mode_lib->ip.dcfclk_cstate_latency
-			/ dlg_sys_param.deepsleep_dcfclk_mhz; // TODO: Deprecated
 
 	print__dlg_sys_params_st(mode_lib, &dlg_sys_param);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c
index 8bc27de4c104..618f4b682ab1 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c
@@ -1688,8 +1688,6 @@ void dml21_rq_dlg_get_dlg_reg(
 			mode_lib,
 			e2e_pipe_param,
 			num_pipes);
-	dlg_sys_param.t_srx_delay_us = mode_lib->ip.dcfclk_cstate_latency
-			/ dlg_sys_param.deepsleep_dcfclk_mhz; // TODO: Deprecated
 
 	print__dlg_sys_params_st(mode_lib, &dlg_sys_param);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.c
index aef854270054..747167083dea 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.c
@@ -1858,8 +1858,6 @@ void dml30_rq_dlg_get_dlg_reg(struct display_mode_lib *mode_lib,
 	dlg_sys_param.total_flip_bytes = get_total_immediate_flip_bytes(mode_lib,
 		e2e_pipe_param,
 		num_pipes);
-	dlg_sys_param.t_srx_delay_us = mode_lib->ip.dcfclk_cstate_latency
-		/ dlg_sys_param.deepsleep_dcfclk_mhz; // TODO: Deprecated
 
 	print__dlg_sys_params_st(mode_lib, &dlg_sys_param);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
index d46a2733024c..8f9f1d607f7c 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
@@ -546,7 +546,6 @@ struct _vcs_dpi_display_dlg_sys_params_st {
 	double t_sr_wm_us;
 	double t_extra_us;
 	double mem_trip_us;
-	double t_srx_delay_us;
 	double deepsleep_dcfclk_mhz;
 	double total_flip_bw;
 	unsigned int total_flip_bytes;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_rq_dlg_helpers.c b/drivers/gpu/drm/amd/display/dc/dml/display_rq_dlg_helpers.c
index 71ea503cb32f..412e75eb4704 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_rq_dlg_helpers.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_rq_dlg_helpers.c
@@ -141,9 +141,6 @@ void print__dlg_sys_params_st(struct display_mode_lib *mode_lib, const struct _v
 	dml_print("DML_RQ_DLG_CALC:    t_urg_wm_us          = %3.2f\n", dlg_sys_param->t_urg_wm_us);
 	dml_print("DML_RQ_DLG_CALC:    t_sr_wm_us           = %3.2f\n", dlg_sys_param->t_sr_wm_us);
 	dml_print("DML_RQ_DLG_CALC:    t_extra_us           = %3.2f\n", dlg_sys_param->t_extra_us);
-	dml_print(
-			"DML_RQ_DLG_CALC:    t_srx_delay_us       = %3.2f\n",
-			dlg_sys_param->t_srx_delay_us);
 	dml_print(
 			"DML_RQ_DLG_CALC:    deepsleep_dcfclk_mhz = %3.2f\n",
 			dlg_sys_param->deepsleep_dcfclk_mhz);
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.c b/drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.c
index 59dc2c5b58dd..3df559c591f8 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.c
@@ -1331,10 +1331,6 @@ void dml1_rq_dlg_get_dlg_params(
 	if (dual_plane)
 		DTRACE("DLG: %s: swath_height_c     = %d", __func__, swath_height_c);
 
-	DTRACE(
-			"DLG: %s: t_srx_delay_us     = %3.2f",
-			__func__,
-			(double) dlg_sys_param->t_srx_delay_us);
 	DTRACE("DLG: %s: line_time_in_us    = %3.2f", __func__, (double) line_time_in_us);
 	DTRACE("DLG: %s: vupdate_offset     = %d", __func__, vupdate_offset);
 	DTRACE("DLG: %s: vupdate_width      = %d", __func__, vupdate_width);
-- 
2.34.1

