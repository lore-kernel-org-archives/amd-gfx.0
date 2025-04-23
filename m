Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CCC4C369DC
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Apr 2025 07:40:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8947110E758;
	Thu, 24 Apr 2025 07:40:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QUDOt+ei";
	dkim-atps=neutral
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC66B10E113
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Apr 2025 08:18:14 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-3912fdddf8fso440127f8f.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Apr 2025 01:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745396293; x=1746001093; darn=lists.freedesktop.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=h+f18L9/GopeAqHiHGz5HvxuOZ5tazfX0IUqKJjBBrU=;
 b=QUDOt+eia9Xom4FcOcexUS6kHLwZmF6QRpJbef1nZtxVsbI+FGmi7SmpfchQ8D69OX
 HuFjTz5hAMJseZ7uSyenTzJPT024n33eJyXAJwgf/hdsSzS/CR1UNNYPdorNKFOAtfVP
 1QItKkhQ+DAAxhLuJYj9wuZLrlcoBYGQ7phHsnvZWfc50ctPm0TLgm86gRf3SHeV7pW5
 urd7GB4dLtAQxANzjxGGV10ByIkvbf6CHaV1isxTKPE/S2APly8u7on78I3BIq6gYKM+
 0bxyrPvt/rBVC1Wi+OUbNnFqh1RRCSE2GlNewfYpD4z2wLsiiIJnePmWNWiApuBunc1w
 fD6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745396293; x=1746001093;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=h+f18L9/GopeAqHiHGz5HvxuOZ5tazfX0IUqKJjBBrU=;
 b=hSyox740P9DSIhUS8MRgcVnhfCukZDahuy2e4t9kyMLqwXlkYW01ShhEolu4zHZ7nK
 ay1FqgLNHf0sdjzOzneW7UJQqRrSjZLT8FoPE4Oh2ux+pUWzy/qTJEVeEsUtJf9gu/Yu
 i3jaufmn3mLJ8tKOheZph/3qyIxRIroE//eSsGNhwHrASYWRH3S6nZvyKpf3jwS2AhoD
 NUUgQcVUIU1FGjzoOjHte8gPfdBQ02ZALVyC83QZFIAebRjgMFDJbU5lR2QjviuZHk99
 poA0M2Zr/GNxpWXLh2cXtND756+/pBYjG4ybmTB3rLllNrg07HtbjTQsRrIJWav5cgxS
 Rq3A==
X-Gm-Message-State: AOJu0Yyow8h3bIA7lgZ71XJFQNGzTc3/YsSLLjVE8RjcPGi+bWUSsF0p
 dE8ezzWI0iVu+ZQdkIWALfF5QwmiAbPMtNd2vy7iYpIeZY6hcyWrkKfKkbjmObQ=
X-Gm-Gg: ASbGnctnZI+lJt9shg9AV6rHMyEpckNb9z5dus/d4OUP3s3u406gcGZw+EsahM6yTTF
 K7+PoYZQzsJTqiToGfMQh3/UiHP3nerooq2UNAoZeKHiGomcKq4FzMDDuZ7CGAOa067UhaKw9uw
 +XV0RdS6JeoyZROB4UfYck6ZkagcBEYFvm+YDp5ahDx0euFx08O9UAT5eoiQEXquwuRDV26mxGY
 BU5J03befdxmk3pETO0JsCjdoBcL4uBCJupOiUd7LeQxNmIn0rh7ywXwNipuNrRtHXfuFXQ0FQP
 4YT5G+WqdNr7izsjpFGk9EwH5QXeBAYpAb4p+X1x+fLT0Q==
X-Google-Smtp-Source: AGHT+IFJDVJitW0aDUzqwf8DKepc50MDuMo+yIo6x+p3mOaVsuzV0JBvqQzLxwmjw7l8xqVSxvX/KA==
X-Received: by 2002:a5d:59a8:0:b0:39c:1f02:44d8 with SMTP id
 ffacd0b85a97d-3a067222893mr1410557f8f.4.1745396292870; 
 Wed, 23 Apr 2025 01:18:12 -0700 (PDT)
Received: from localhost ([196.207.164.177])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-39efa433303sm17709077f8f.24.2025.04.23.01.18.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 01:18:12 -0700 (PDT)
Date: Wed, 23 Apr 2025 11:18:09 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Yihan Zhu <Yihan.Zhu@amd.com>
Cc: amd-gfx@lists.freedesktop.org,
 "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
Subject: [bug report] drm/amd/display: DCN42 RMCM and MCM 3DLUT support
Message-ID: <aAiiQYRc8HduYrSo@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Thu, 24 Apr 2025 07:40:49 +0000
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

Hello Yihan Zhu,

Commit 652968d996d7 ("drm/amd/display: DCN42 RMCM and MCM 3DLUT
support") from Apr 1, 2025 (linux-next), leads to the following
Smatch static checker warning:

	drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dcn401/dcn401_hwseq.c:720 dcn401_populate_mcm_luts()
	error: we previously assumed 'mpc->funcs->program_lut_mode' could be null (see line 701)

drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dcn401/dcn401_hwseq.c
    642 void dcn401_populate_mcm_luts(struct dc *dc,
    643                 struct pipe_ctx *pipe_ctx,
    644                 struct dc_cm2_func_luts mcm_luts,
    645                 bool lut_bank_a)
    646 {
    647         struct dpp *dpp_base = pipe_ctx->plane_res.dpp;
    648         struct hubp *hubp = pipe_ctx->plane_res.hubp;
    649         int mpcc_id = hubp->inst;
    650         struct mpc *mpc = dc->res_pool->mpc;
    651         union mcm_lut_params m_lut_params;
    652         enum dc_cm2_transfer_func_source lut3d_src = mcm_luts.lut3d_data.lut3d_src;
    653         enum hubp_3dlut_fl_format format = 0;
    654         enum hubp_3dlut_fl_mode mode;
    655         enum hubp_3dlut_fl_width width = 0;
    656         enum hubp_3dlut_fl_addressing_mode addr_mode;
    657         enum hubp_3dlut_fl_crossbar_bit_slice crossbar_bit_slice_y_g;
    658         enum hubp_3dlut_fl_crossbar_bit_slice crossbar_bit_slice_cb_b;
    659         enum hubp_3dlut_fl_crossbar_bit_slice crossbar_bit_slice_cr_r;
    660         enum MCM_LUT_XABLE shaper_xable = MCM_LUT_DISABLE;
    661         enum MCM_LUT_XABLE lut3d_xable = MCM_LUT_DISABLE;
    662         enum MCM_LUT_XABLE lut1d_xable = MCM_LUT_DISABLE;
    663         bool rval;
    664 
    665         dcn401_get_mcm_lut_xable_from_pipe_ctx(dc, pipe_ctx, &shaper_xable, &lut3d_xable, &lut1d_xable);
    666 
    667         //MCM - setting its location (Before/After) blender
    668         //set to post blend (true)
    669         dcn401_set_mcm_location_post_blend(
    670                 dc,
    671                 pipe_ctx,
    672                 mcm_luts.lut3d_data.mpc_mcm_post_blend);
    673 
    674         //RMCM - 3dLUT+Shaper
    675         if (mcm_luts.lut3d_data.rmcm_3dlut_enable) {
    676                 dcn401_program_rmcm_luts(
    677                         hubp,
    678                         pipe_ctx,
    679                         lut3d_src,
    680                         &mcm_luts,
    681                         mpc,
    682                         lut_bank_a,
    683                         mpcc_id);
    684         }
    685 
    686         /* 1D LUT */
    687         if (mcm_luts.lut1d_func) {
    688                 memset(&m_lut_params, 0, sizeof(m_lut_params));
    689                 if (mcm_luts.lut1d_func->type == TF_TYPE_HWPWL)
    690                         m_lut_params.pwl = &mcm_luts.lut1d_func->pwl;
    691                 else if (mcm_luts.lut1d_func->type == TF_TYPE_DISTRIBUTED_POINTS) {
    692                         rval = cm3_helper_translate_curve_to_hw_format(
    693                                         mcm_luts.lut1d_func,
    694                                         &dpp_base->regamma_params, false);
    695                         m_lut_params.pwl = rval ? &dpp_base->regamma_params : NULL;
    696                 }
    697                 if (m_lut_params.pwl) {
    698                         if (mpc->funcs->populate_lut)
    699                                 mpc->funcs->populate_lut(mpc, MCM_LUT_1DLUT, m_lut_params, lut_bank_a, mpcc_id);
    700                 }
    701                 if (mpc->funcs->program_lut_mode)
    702                         mpc->funcs->program_lut_mode(mpc, MCM_LUT_1DLUT, lut1d_xable && m_lut_params.pwl, lut_bank_a, mpcc_id);
    703         }
    704 
    705         /* Shaper */
    706         if (mcm_luts.shaper && mcm_luts.lut3d_data.mpc_3dlut_enable) {
    707                 memset(&m_lut_params, 0, sizeof(m_lut_params));
    708                 if (mcm_luts.shaper->type == TF_TYPE_HWPWL)
    709                         m_lut_params.pwl = &mcm_luts.shaper->pwl;
    710                 else if (mcm_luts.shaper->type == TF_TYPE_DISTRIBUTED_POINTS) {
    711                         ASSERT(false);
    712                         rval = cm3_helper_translate_curve_to_hw_format(
    713                                         mcm_luts.shaper,
    714                                         &dpp_base->regamma_params, true);
    715                         m_lut_params.pwl = rval ? &dpp_base->regamma_params : NULL;
    716                 }
    717                 if (m_lut_params.pwl) {
    718                         if (mpc->funcs->mcm.populate_lut)
    719                                 mpc->funcs->mcm.populate_lut(mpc, m_lut_params, lut_bank_a, mpcc_id);
--> 720                         mpc->funcs->program_lut_mode(mpc, MCM_LUT_SHAPER, MCM_LUT_ENABLE, lut_bank_a, mpcc_id);

All the other places that call ->program_lut_mode() check if it's NULL
and originally this caller had a check too but the commit removed it.
Potentially checking m_lut_params.pwl is sufficient?

    721                 }
    722         }
    723 
    724         /* 3DLUT */
    725         switch (lut3d_src) {
    726         case DC_CM2_TRANSFER_FUNC_SOURCE_SYSMEM:
    727                 memset(&m_lut_params, 0, sizeof(m_lut_params));
    728                 if (hubp->funcs->hubp_enable_3dlut_fl)
    729                         hubp->funcs->hubp_enable_3dlut_fl(hubp, false);
    730 
    731                 if (mcm_luts.lut3d_data.lut3d_func && mcm_luts.lut3d_data.lut3d_func->state.bits.initialized) {
    732                         m_lut_params.lut3d = &mcm_luts.lut3d_data.lut3d_func->lut_3d;
    733                         if (mpc->funcs->populate_lut)
    734                                 mpc->funcs->populate_lut(mpc, MCM_LUT_3DLUT, m_lut_params, lut_bank_a, mpcc_id);
    735                         if (mpc->funcs->program_lut_mode)
    736                                 mpc->funcs->program_lut_mode(mpc, MCM_LUT_3DLUT, lut3d_xable, lut_bank_a,
    737                                                 mpcc_id);
    738                 }
    739                 break;
    740                 case DC_CM2_TRANSFER_FUNC_SOURCE_VIDMEM:
    741                 switch (mcm_luts.lut3d_data.gpu_mem_params.size) {
    742                 case DC_CM2_GPU_MEM_SIZE_333333:
    743                         width = hubp_3dlut_fl_width_33;
    744                         break;
    745                 case DC_CM2_GPU_MEM_SIZE_171717:
    746                         width = hubp_3dlut_fl_width_17;
    747                         break;
    748                 case DC_CM2_GPU_MEM_SIZE_TRANSFORMED:
    749                         width = hubp_3dlut_fl_width_transformed;
    750                         break;
    751                 }
    752 
    753                 //check for support
    754                 if (mpc->funcs->mcm.is_config_supported &&
    755                         !mpc->funcs->mcm.is_config_supported(width))
    756                         break;
    757 
    758                 if (mpc->funcs->program_lut_read_write_control)
    759                         mpc->funcs->program_lut_read_write_control(mpc, MCM_LUT_3DLUT, lut_bank_a, mpcc_id);
    760                 if (mpc->funcs->program_lut_mode)
    761                         mpc->funcs->program_lut_mode(mpc, MCM_LUT_3DLUT, lut3d_xable, lut_bank_a, mpcc_id);
    762 
    763                 if (hubp->funcs->hubp_program_3dlut_fl_addr)
    764                         hubp->funcs->hubp_program_3dlut_fl_addr(hubp, mcm_luts.lut3d_data.gpu_mem_params.addr);
    765 
    766                 if (mpc->funcs->mcm.program_bit_depth)
    767                         mpc->funcs->mcm.program_bit_depth(mpc, mcm_luts.lut3d_data.gpu_mem_params.bit_depth, mpcc_id);
    768 
    769                 switch (mcm_luts.lut3d_data.gpu_mem_params.layout) {
    770                 case DC_CM2_GPU_MEM_LAYOUT_3D_SWIZZLE_LINEAR_RGB:
    771                         mode = hubp_3dlut_fl_mode_native_1;
    772                         addr_mode = hubp_3dlut_fl_addressing_mode_sw_linear;
    773                         break;
    774                 case DC_CM2_GPU_MEM_LAYOUT_3D_SWIZZLE_LINEAR_BGR:
    775                         mode = hubp_3dlut_fl_mode_native_2;
    776                         addr_mode = hubp_3dlut_fl_addressing_mode_sw_linear;
    777                         break;
    778                 case DC_CM2_GPU_MEM_LAYOUT_1D_PACKED_LINEAR:
    779                         mode = hubp_3dlut_fl_mode_transform;
    780                         addr_mode = hubp_3dlut_fl_addressing_mode_simple_linear;
    781                         break;
    782                 default:
    783                         mode = hubp_3dlut_fl_mode_disable;
    784                         addr_mode = hubp_3dlut_fl_addressing_mode_sw_linear;
    785                         break;
    786                 }
    787                 if (hubp->funcs->hubp_program_3dlut_fl_mode)
    788                         hubp->funcs->hubp_program_3dlut_fl_mode(hubp, mode);
    789 
    790                 if (hubp->funcs->hubp_program_3dlut_fl_addressing_mode)
    791                         hubp->funcs->hubp_program_3dlut_fl_addressing_mode(hubp, addr_mode);
    792 
    793                 switch (mcm_luts.lut3d_data.gpu_mem_params.format_params.format) {
    794                 case DC_CM2_GPU_MEM_FORMAT_16161616_UNORM_12MSB:
    795                         format = hubp_3dlut_fl_format_unorm_12msb_bitslice;
    796                         break;
    797                 case DC_CM2_GPU_MEM_FORMAT_16161616_UNORM_12LSB:
    798                         format = hubp_3dlut_fl_format_unorm_12lsb_bitslice;
    799                         break;
    800                 case DC_CM2_GPU_MEM_FORMAT_16161616_FLOAT_FP1_5_10:
    801                         format = hubp_3dlut_fl_format_float_fp1_5_10;
    802                         break;
    803                 }
    804                 if (hubp->funcs->hubp_program_3dlut_fl_format)
    805                         hubp->funcs->hubp_program_3dlut_fl_format(hubp, format);
    806                 if (hubp->funcs->hubp_update_3dlut_fl_bias_scale &&
    807                                 mpc->funcs->mcm.program_bias_scale) {
    808                         mpc->funcs->mcm.program_bias_scale(mpc,
    809                                 mcm_luts.lut3d_data.gpu_mem_params.format_params.float_params.bias,
    810                                 mcm_luts.lut3d_data.gpu_mem_params.format_params.float_params.scale,
    811                                 mpcc_id);
    812                         hubp->funcs->hubp_update_3dlut_fl_bias_scale(hubp,
    813                                                 mcm_luts.lut3d_data.gpu_mem_params.format_params.float_params.bias,
    814                                                 mcm_luts.lut3d_data.gpu_mem_params.format_params.float_params.scale);
    815                 }
    816 
    817                 //navi 4x has a bug and r and blue are swapped and need to be worked around here in
    818                 //TODO: need to make a method for get_xbar per asic OR do the workaround in program_crossbar for 4x
    819                 dc_get_lut_xbar(
    820                         mcm_luts.lut3d_data.gpu_mem_params.component_order,
    821                         &crossbar_bit_slice_cr_r,
    822                         &crossbar_bit_slice_y_g,
    823                         &crossbar_bit_slice_cb_b);
    824 
    825                 if (hubp->funcs->hubp_program_3dlut_fl_crossbar)
    826                         hubp->funcs->hubp_program_3dlut_fl_crossbar(hubp,
    827                                         crossbar_bit_slice_cr_r,
    828                                         crossbar_bit_slice_y_g,
    829                                         crossbar_bit_slice_cb_b);
    830 
    831                 if (mpc->funcs->mcm.program_lut_read_write_control)
    832                         mpc->funcs->mcm.program_lut_read_write_control(mpc, MCM_LUT_3DLUT, lut_bank_a, true, mpcc_id);
    833 
    834                 if (mpc->funcs->mcm.program_3dlut_size)
    835                         mpc->funcs->mcm.program_3dlut_size(mpc, width, mpcc_id);
    836 
    837                 if (mpc->funcs->update_3dlut_fast_load_select)
    838                         mpc->funcs->update_3dlut_fast_load_select(mpc, mpcc_id, hubp->inst);
    839 
    840                 if (hubp->funcs->hubp_enable_3dlut_fl)
    841                         hubp->funcs->hubp_enable_3dlut_fl(hubp, true);
    842                 else {
    843                         if (mpc->funcs->program_lut_mode) {
    844                                 mpc->funcs->program_lut_mode(mpc, MCM_LUT_SHAPER, MCM_LUT_DISABLE, lut_bank_a, mpcc_id);
    845                                 mpc->funcs->program_lut_mode(mpc, MCM_LUT_3DLUT, MCM_LUT_DISABLE, lut_bank_a, mpcc_id);
    846                                 mpc->funcs->program_lut_mode(mpc, MCM_LUT_1DLUT, MCM_LUT_DISABLE, lut_bank_a, mpcc_id);
    847                         }
    848                 }
    849                 break;
    850 
    851         }
    852 }

regards,
dan carpenter
