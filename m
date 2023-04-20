Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A277C77B73
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Apr 2023 18:12:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF0EB10E19C;
	Thu, 20 Apr 2023 18:12:35 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6576810E040
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Apr 2023 18:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1682014033;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=DAlGbmvVdWeoiiH06KOhyy0LizTfr2FfHgvUIIzCTWQ=;
 b=W4YxmoGbHz89Z815T0zZ59lTCWQ/7glpXdRjudP+3b9wI64V5f0NIdV6OHiwmhO5NQKNJ3
 GDP3IP22nfE2S/pn5cqzTLD+Os/KlYt9wYHHzGk60U39PIsmJWdjPjuBmUWtajynw9CyYc
 sreO9icXCgYHoxNki+exPLC2M5wyBtA=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-OrP1SifIMV-8rWCPGRg_nA-1; Thu, 20 Apr 2023 14:07:10 -0400
X-MC-Unique: OrP1SifIMV-8rWCPGRg_nA-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-74ab517c14bso419611785a.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Apr 2023 11:07:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682014030; x=1684606030;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DAlGbmvVdWeoiiH06KOhyy0LizTfr2FfHgvUIIzCTWQ=;
 b=LHoVmFEkkBo5JDZ0ZhgIurpOAoXMhiwGxNvWJhwHFcr1ueCcal2Y+VL19rDgNUw6Yv
 FsXlwuGaDBCXFvb0Sf+Av8d9GnbdFGdKh3GQCr/r9bEC6c8J7b3wG4VjiPv+voN+u4hZ
 1ek7pK7HIqooj7iGxnVTmFYx0hVZLOWjExgdMu9e19+idz/Zlsaj4L2n9dh/0RDuchgC
 fOnB5iVL3A3+0cjvvLW3uJowtlLuLrJwJ237tJBRYthZnvzNzILPUQe8CDUTe5WUPT1i
 0hwA5LgY6+UsRJShq/Ehbe3me9RabdDWc9nNErj3w+6OtSbuHkqOPH71/WIPQhojR75v
 tgdA==
X-Gm-Message-State: AAQBX9fipkBVAjYu7/5BwBQH8XxzugJnpwv6Cfyln7HdhZqNZz6nu3yv
 LoCQfkwkfj7nn75Hf6a/hf0NQ+HnxQkhWDEnzdwb03ksrdqzF4/aWNamQKPdRbap8Fv56Kfxs4l
 A3WkWUAbQtPu5fbemnpkYSinpNQ==
X-Received: by 2002:ac8:5915:0:b0:3e4:e035:b5ae with SMTP id
 21-20020ac85915000000b003e4e035b5aemr5802123qty.25.1682014029741; 
 Thu, 20 Apr 2023 11:07:09 -0700 (PDT)
X-Google-Smtp-Source: AKy350bZtoGbXr5zTKxwxJWHDlD+kzZVK9Rkj0Gg5y9VvHKOIKTnh6wcqzjG9aPwh50t9BtIPzm+YQ==
X-Received: by 2002:ac8:5915:0:b0:3e4:e035:b5ae with SMTP id
 21-20020ac85915000000b003e4e035b5aemr5802089qty.25.1682014029490; 
 Thu, 20 Apr 2023 11:07:09 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com
 (nat-pool-bos-t.redhat.com. [66.187.233.206])
 by smtp.gmail.com with ESMTPSA id
 o17-20020a05620a111100b0074e00d6834esm602339qkk.81.2023.04.20.11.07.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Apr 2023 11:07:09 -0700 (PDT)
From: Tom Rix <trix@redhat.com>
To: harry.wentland@amd.com, sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, daniel@ffwll.ch, nathan@kernel.org,
 ndesaulniers@google.com, hamza.mahfooz@amd.com, drv@mailo.com,
 roman.li@amd.com, mairacanal@riseup.net, jiapeng.chong@linux.alibaba.com,
 caionovais@usp.br, gabe.teeger@amd.com
Subject: [PATCH] drm/amd/display: remove unused variables
 dispclk_delay_subtotal and dout
Date: Thu, 20 Apr 2023 14:07:05 -0400
Message-Id: <20230420180705.3893475-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-Mailman-Approved-At: Thu, 20 Apr 2023 18:12:34 +0000
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
Cc: Tom Rix <trix@redhat.com>, llvm@lists.linux.dev,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

clang with W=1 reports
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn314/display_rq_dlg_calc_314.c:1003:15:
  error: variable 'dispclk_delay_subtotal' set but not used [-Werror,-Wunused-but-set-variable]
        unsigned int dispclk_delay_subtotal;
                     ^
This variable is not used, so remove it.
Which made dout unused, so also remove.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 .../display/dc/dml/dcn314/display_rq_dlg_calc_314.c    | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_rq_dlg_calc_314.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_rq_dlg_calc_314.c
index ea4eb66066c4..239cb8160c77 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_rq_dlg_calc_314.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_rq_dlg_calc_314.c
@@ -951,7 +951,6 @@ static void dml_rq_dlg_get_dlg_params(
 {
 	const display_pipe_source_params_st *src = &e2e_pipe_param[pipe_idx].pipe.src;
 	const display_pipe_dest_params_st *dst = &e2e_pipe_param[pipe_idx].pipe.dest;
-	const display_output_params_st *dout = &e2e_pipe_param[pipe_idx].dout;
 	const display_clocks_and_cfg_st *clks = &e2e_pipe_param[pipe_idx].clks_cfg;
 	const scaler_ratio_depth_st *scl = &e2e_pipe_param[pipe_idx].pipe.scale_ratio_depth;
 	const scaler_taps_st *taps = &e2e_pipe_param[pipe_idx].pipe.scale_taps;
@@ -1000,8 +999,6 @@ static void dml_rq_dlg_get_dlg_params(
 	unsigned int vupdate_width;
 	unsigned int vready_offset;
 
-	unsigned int dispclk_delay_subtotal;
-
 	unsigned int vstartup_start;
 	unsigned int dst_x_after_scaler;
 	unsigned int dst_y_after_scaler;
@@ -1127,13 +1124,6 @@ static void dml_rq_dlg_get_dlg_params(
 	vupdate_offset = dst->vupdate_offset;
 	vupdate_width = dst->vupdate_width;
 	vready_offset = dst->vready_offset;
-	dispclk_delay_subtotal = mode_lib->ip.dispclk_delay_subtotal;
-
-	if (dout->dsc_enable) {
-		double dsc_delay = get_dsc_delay(mode_lib, e2e_pipe_param, num_pipes, pipe_idx); // FROM VBA
-
-		dispclk_delay_subtotal += dsc_delay;
-	}
 
 	vstartup_start = dst->vstartup_start;
 	if (interlaced) {
-- 
2.27.0

