Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37BBEC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Jul 2022 16:46:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2D4B11A090;
	Thu, 14 Jul 2022 16:46:08 +0000 (UTC)
Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18F9B11A090
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Jul 2022 16:46:07 +0000 (UTC)
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
 client-signature RSA-PSS (2048 bits) client-digest SHA256)
 (Client CN "mail.riseup.net", Issuer "R3" (not verified))
 by mx0.riseup.net (Postfix) with ESMTPS id 4LkL3L33Z7z9sP3;
 Thu, 14 Jul 2022 16:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
 t=1657817166; bh=7ZIyFiuFgYNUa17wM136mhJTJfJP2BZyJxk+lgVG18A=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Y+uzNfg6XiOpBuZSLVzEP2p3SN9sRea2J7hilAEY4nZMrhmUY1n+PfxmoatQGvpOz
 I63z0VMk1uhdQ1j9QkgoRTa7PNW3NPINy4qOU4tb7+tB2EJAueeNnwfFMenlcZ+iPz
 fqNm7CpRF6JVE785RYsGsPSpKHxKEZWwEaeGfrV8=
X-Riseup-User-ID: 4D0773E2CA694B3310900D5C7D2DFB5E6AB547B05B4D989EE8DE07658CBFC1D2
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by fews1.riseup.net (Postfix) with ESMTPSA id 4LkL3D20jbz5vW1;
 Thu, 14 Jul 2022 16:45:59 +0000 (UTC)
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, christian.koenig@amd.com,
 Xinhui.Pan@amd.com, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
Subject: [PATCH 06/12] drm/amd/display: Remove unused variables from
 dml_rq_dlg_get_dlg_params
Date: Thu, 14 Jul 2022 13:45:01 -0300
Message-Id: <20220714164507.561751-6-mairacanal@riseup.net>
In-Reply-To: <20220714164507.561751-1-mairacanal@riseup.net>
References: <20220714164507.561751-1-mairacanal@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: magalilemes00@gmail.com, tales.aparecida@gmail.com,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, mwen@igalia.com,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>,
 Isabella Basso <isabbasso@riseup.net>, andrealmeid@riseup.net
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Remove the variables dispclk_delay_subtotal and dppclk_delay_subtotal from
the function dml_rq_dlg_get_dlg_params.

This was pointed by clang with the following warning:

drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn31/display_rq_dlg_calc_31.c:920:15:
warning: variable 'dispclk_delay_subtotal' set but not used [-Wunused-but-set-variable]
        unsigned int dispclk_delay_subtotal;
                     ^
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn31/display_rq_dlg_calc_31.c:919:15:
warning: variable 'dppclk_delay_subtotal' set but not used [-Wunused-but-set-variable]
        unsigned int dppclk_delay_subtotal;
                     ^
2 warnings generated.

Signed-off-by: Maíra Canal <mairacanal@riseup.net>
---
 .../dc/dml/dcn31/display_rq_dlg_calc_31.c     | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c
index c94cf6e01e25..66b82e4f05c6 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c
@@ -866,7 +866,6 @@ static void dml_rq_dlg_get_dlg_params(
 {
 	const display_pipe_source_params_st *src = &e2e_pipe_param[pipe_idx].pipe.src;
 	const display_pipe_dest_params_st *dst = &e2e_pipe_param[pipe_idx].pipe.dest;
-	const display_output_params_st *dout = &e2e_pipe_param[pipe_idx].dout;
 	const display_clocks_and_cfg_st *clks = &e2e_pipe_param[pipe_idx].clks_cfg;
 	const scaler_ratio_depth_st *scl = &e2e_pipe_param[pipe_idx].pipe.scale_ratio_depth;
 	const scaler_taps_st *taps = &e2e_pipe_param[pipe_idx].pipe.scale_taps;
@@ -916,9 +915,6 @@ static void dml_rq_dlg_get_dlg_params(
 	unsigned int vupdate_width;
 	unsigned int vready_offset;
 
-	unsigned int dppclk_delay_subtotal;
-	unsigned int dispclk_delay_subtotal;
-
 	unsigned int vstartup_start;
 	unsigned int dst_x_after_scaler;
 	unsigned int dst_y_after_scaler;
@@ -1037,21 +1033,6 @@ static void dml_rq_dlg_get_dlg_params(
 	vupdate_width = dst->vupdate_width;
 	vready_offset = dst->vready_offset;
 
-	dppclk_delay_subtotal = mode_lib->ip.dppclk_delay_subtotal;
-	dispclk_delay_subtotal = mode_lib->ip.dispclk_delay_subtotal;
-
-	if (scl_enable)
-		dppclk_delay_subtotal += mode_lib->ip.dppclk_delay_scl;
-	else
-		dppclk_delay_subtotal += mode_lib->ip.dppclk_delay_scl_lb_only;
-
-	dppclk_delay_subtotal += mode_lib->ip.dppclk_delay_cnvc_formatter + src->num_cursors * mode_lib->ip.dppclk_delay_cnvc_cursor;
-
-	if (dout->dsc_enable) {
-		double dsc_delay = get_dsc_delay(mode_lib, e2e_pipe_param, num_pipes, pipe_idx); // FROM VBA
-		dispclk_delay_subtotal += dsc_delay;
-	}
-
 	vstartup_start = dst->vstartup_start;
 	if (interlaced) {
 		if (vstartup_start / 2.0 - (double) (vready_offset + vupdate_width + vupdate_offset) / htotal <= vblank_end / 2.0)
-- 
2.36.1

