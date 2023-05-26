Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E16D9C77B7A
	for <amd-gfx@archiver.kernel.org>; Tue, 30 May 2023 13:50:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D89C010E393;
	Tue, 30 May 2023 13:50:29 +0000 (UTC)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8884310E1C8
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 May 2023 12:02:25 +0000 (UTC)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3f6cbf02747so4710025e9.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 May 2023 05:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685102544; x=1687694544;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UtSP2dJ26RL4DTO5afV8jgi3I5uKUznxWJICL9NyxnA=;
 b=sCGPhNji26CuIR0qJVd/felDhmYZz+5n0wwiE5OK1bn78e6ktputOlGLBesEHzCVCm
 g/yAp1QxoKCpMhU0Q+kfPtJoT3m6AZvYVviRycg8NTpp85bn/uscGl6WH+ug47FYHUa6
 myt+f/5XH5VafaQrlUi+jnCYQGJ7nYc0Pb+8P9dTf6LOyDtTe19X3NhXnnUGqa7rT0QY
 +dA2izwioQ2nnyqae68eQHK0ljJ5a9zVek9GX6VDvlB/+a2cmiBaG85xNnLLiEyDZHJz
 CVs1R8NqGOHDuiLjaZuHzSNH4iW9ZFaK8KFwoxUPGx9izr8aaMcRHUZXKhdGy3h+jPmu
 FaRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685102544; x=1687694544;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UtSP2dJ26RL4DTO5afV8jgi3I5uKUznxWJICL9NyxnA=;
 b=bz5XMh/zKuBLwbM9F/cohHAE2g8LKSxrGMFt+WIhEv4Yveg9Am7Mb9BqOay2VmvNBs
 fsuIvItuDe3Xyo7ElqrVhpSepXGpdzrhnnXBeGnsg6KBb/X9xwdsRvyCPYKJn4rD8hIm
 TWIcoILlO+g/MYUYCpwNvn1RIcnF5nG9tBcpUdZB3juT1/YzjCYyVIXT9fqvaUbRCn/A
 /348sL0FaIDNr/Zn8B8P61On9BcqMPt+rQkJlplVqSFxHq+QNG/T79bXvaN9hU0+UUaO
 u+NpXJhdcVzRGZfWSVXmNtSDLcz9reywqdMDt0BqPBZJirgv1odhilYQimr1ayULFANf
 9FWA==
X-Gm-Message-State: AC+VfDyVf196+3rtEXm8QcUmskvtRMVGSyJT0XcSjI9Skk5RhHWfKFwl
 YV3DOBncK43CpecaZoSFerQHKw==
X-Google-Smtp-Source: ACHHUZ5NCE9QPI/Oqr6TdhuutWLz8tFhBc0XBJ1aHrRQg60/dSDOQzZOWCtEmhhZwE8H0+REAlMTTQ==
X-Received: by 2002:a05:600c:21cf:b0:3f6:8ef:a213 with SMTP id
 x15-20020a05600c21cf00b003f608efa213mr1303616wmj.28.1685102543642; 
 Fri, 26 May 2023 05:02:23 -0700 (PDT)
Received: from localhost ([102.36.222.112]) by smtp.gmail.com with ESMTPSA id
 u10-20020a5d514a000000b00307b5376b2csm4832644wrt.90.2023.05.26.05.02.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 May 2023 05:02:22 -0700 (PDT)
Date: Fri, 26 May 2023 15:02:19 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Rodrigo.Siqueira@amd.com, Qingqing Zhuo <qingqing.zhuo@amd.com>
Subject: [bug report] drm/amd/display: Check clock table return
Message-ID: <d9a8f0a0-b5e4-439f-b8b3-69a898ba4a0a@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Tue, 30 May 2023 13:50:27 +0000
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hello Rodrigo Siqueira,

This is a semi-automatic email about new static checker warnings.

The patch 4b4f21ff7f5d: "drm/amd/display: Check clock table return" 
from Aug 20, 2020, leads to the following Smatch complaint:

    drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn21/rn_clk_mgr.c:775 rn_clk_mgr_construct()
    warn: variable dereferenced before check 'ctx->dc_bios->integrated_info' (see line 743)

drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn21/rn_clk_mgr.c
   742	
   743		if (ctx->dc_bios->integrated_info->memory_type == LpDdr4MemType) {
                    ^^^^^^^^^^^^^^
Not sure why Smatch is complaining about this after three years.

   744			if (clk_mgr->periodic_retraining_disabled) {
   745				rn_bw_params.wm_table = lpddr4_wm_table_with_disabled_ppt;
   746			} else {
   747				if (is_green_sardine)
   748					rn_bw_params.wm_table = lpddr4_wm_table_gs;
   749				else
   750					rn_bw_params.wm_table = lpddr4_wm_table_rn;
   751			}
   752		} else {
   753			if (is_green_sardine)
   754				rn_bw_params.wm_table = ddr4_wm_table_gs;
   755			else {
   756				if (ctx->dc->config.is_single_rank_dimm)
   757					rn_bw_params.wm_table = ddr4_1R_wm_table_rn;
   758				else
   759					rn_bw_params.wm_table = ddr4_wm_table_rn;
   760			}
   761		}
   762		/* Saved clocks configured at boot for debug purposes */
   763		rn_dump_clk_registers(&clk_mgr->base.boot_snapshot, &clk_mgr->base, &log_info);
   764	
   765		clk_mgr->base.dprefclk_khz = 600000;
   766		dce_clock_read_ss_info(clk_mgr);
   767	
   768	
   769		clk_mgr->base.bw_params = &rn_bw_params;
   770	
   771		if (pp_smu && pp_smu->rn_funcs.get_dpm_clock_table) {
   772			status = pp_smu->rn_funcs.get_dpm_clock_table(&pp_smu->rn_funcs.pp_smu, &clock_table);
   773	
   774			if (status == PP_SMU_RESULT_OK &&
   775			    ctx->dc_bios && ctx->dc_bios->integrated_info) {
                            ^^^^^^^^^^^^
Check for NULL is too late.

   776				rn_clk_mgr_helper_populate_bw_params (clk_mgr->base.bw_params, &clock_table, ctx->dc_bios->integrated_info);
   777				/* treat memory config as single channel if memory is asymmetrics. */

regards,
dan carpenter
