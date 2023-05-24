Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6556C7EE32
	for <amd-gfx@archiver.kernel.org>; Wed, 24 May 2023 09:46:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0C1D10E662;
	Wed, 24 May 2023 09:46:52 +0000 (UTC)
Received: from out30-133.freemail.mail.aliyun.com
 (out30-133.freemail.mail.aliyun.com [115.124.30.133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67A8C10E578
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 May 2023 04:05:17 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R151e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045168;
 MF=yang.lee@linux.alibaba.com; NM=1; PH=DS; RN=12; SR=0;
 TI=SMTPD_---0VjMWCGq_1684900807; 
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com
 fp:SMTPD_---0VjMWCGq_1684900807) by smtp.aliyun-inc.com;
 Wed, 24 May 2023 12:00:08 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: alexander.deucher@amd.com
Subject: [PATCH -next 07/13] drm/amd/display: remove unused definition
Date: Wed, 24 May 2023 11:59:46 +0800
Message-Id: <20230524035952.123590-7-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
In-Reply-To: <20230524035952.123590-1-yang.lee@linux.alibaba.com>
References: <20230524035952.123590-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 24 May 2023 09:46:48 +0000
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
Cc: sunpeng.li@amd.com, harry.wentland@amd.com, Xinhui.Pan@amd.com,
 Rodrigo.Siqueira@amd.com, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, Abaci Robot <abaci@linux.alibaba.com>,
 Yang Li <yang.lee@linux.alibaba.com>, dri-devel@lists.freedesktop.org,
 daniel@ffwll.ch, airlied@gmail.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Eliminate the following warnings:
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn302/dcn302_resource.c:957:43: warning: unused variable 'res_create_maximus_funcs'
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn302/dcn302_resource.c:101:38: warning: unused variable 'debug_defaults_diags'

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=5296
Fixes: 00df97e1df57 ("drm/amd/display: Clean FPGA code in dc")
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 .../amd/display/dc/dcn302/dcn302_resource.c   | 25 -------------------
 1 file changed, 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
index efd98d64588d..93f42132c900 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
@@ -98,24 +98,6 @@ static const struct dc_debug_options debug_defaults_drv = {
 		.exit_idle_opt_for_cursor_updates = true
 };
 
-static const struct dc_debug_options debug_defaults_diags = {
-		.disable_dmcu = true,
-		.force_abm_enable = false,
-		.timing_trace = true,
-		.clock_trace = true,
-		.disable_dpp_power_gate = true,
-		.disable_hubp_power_gate = true,
-		.disable_clock_gate = true,
-		.disable_pplib_clock_request = true,
-		.disable_pplib_wm_range = true,
-		.disable_stutter = false,
-		.scl_reset_length10 = true,
-		.dwb_fi_phase = -1, // -1 = disable
-		.dmub_command_table = true,
-		.enable_tri_buf = true,
-		.use_max_lb = true
-};
-
 static const struct dc_panel_config panel_config_defaults = {
 		.psr = {
 			.disable_psr = false,
@@ -954,13 +936,6 @@ static const struct resource_create_funcs res_create_funcs = {
 		.create_hwseq = dcn302_hwseq_create,
 };
 
-static const struct resource_create_funcs res_create_maximus_funcs = {
-		.read_dce_straps = NULL,
-		.create_audio = NULL,
-		.create_stream_encoder = NULL,
-		.create_hwseq = dcn302_hwseq_create,
-};
-
 static bool is_soc_bounding_box_valid(struct dc *dc)
 {
 	uint32_t hw_internal_rev = dc->ctx->asic_id.hw_internal_rev;
-- 
2.20.1.7.g153144c

