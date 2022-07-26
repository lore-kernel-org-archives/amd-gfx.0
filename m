Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 229EFC00140
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Jul 2022 20:48:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89FD4A5C3C;
	Tue, 26 Jul 2022 20:48:10 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89BA4A5BF9
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Jul 2022 20:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=l9ZR32nvB1+nParfaYWTtqXW9ZIvNJF2ndoRcfn4lJc=; b=fHZVd3uljUA6l2x6Qzp8GlO80N
 bxfLjdysxF8kqDu4bAkEA71viWKdN0uYxWKAtr/hAhyqqUxMv1apDH8gx1FeHk7IQ/X2fxJW0zmKi
 Vw3BDk4yAb39mEurFjSxlKV51DrEX7bKIPJ9lhc0HlKnHycY8GI712JsW66K6E0cAKnOAsXTZlWXu
 e7crCI6Z6Oc2YkEBv7PiRIb1M2SOvfcNSfCb5gvbweDJoFyX5iZGjhy9KBKIwv3+keBeKlX8mUZUN
 ijxRa6dGxPdZlvskBNx9n9YUFV9rcWs+hIt/LPxv3+beR1oVvUP0G4G8KNsRh35++D5d6h8jB/8Dh
 ruo7Y/mQ==;
Received: from 201-13-50-220.dsl.telesp.net.br ([201.13.50.220]
 helo=[192.168.15.109]) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1oGRTJ-007iDW-6V; Tue, 26 Jul 2022 22:48:05 +0200
Message-ID: <bf37f042-c316-17e4-581c-2783628f0c92@igalia.com>
Date: Tue, 26 Jul 2022 17:47:49 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: amdgpu: misc ugliness and inconsistency
Content-Language: en-US
To: Dan Carpenter <dan.carpenter@oracle.com>, amd-gfx@lists.freedesktop.org
References: <YuAN1aR9jGmnR/wk@kili>
From: =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <YuAN1aR9jGmnR/wk@kili>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Dan,

Às 12:52 de 26/07/22, Dan Carpenter escreveu:
> Hi AMD devs,
> 
> I guess there was a big merge in linux-next the other day?  Anyway, it
> generated a lot of Smatch warnings.  I reported some of them but there
> is just a lot so I'm mass reporting these.
> 
> Inconsistent NULL checking can be harmless.  Part of the function
> assumes that the pointer can be NULL and part assumes that it cannot.
> It does not make sense, but it is often harmless and the correct
> response is just to remove the NULL check.
> 
> The other class of reports is inconsistent indenting.  There were two
> bugs but I already fixed one and reported the other so these should be
> harmless.

For this class, I believe this series fixes most of them:

https://lore.kernel.org/amd-gfx/20220726072555.91323-1-jiapeng.chong@linux.alibaba.com/

> 
> regards,
> dan carpenter
> 
> Inconsistent NULL checks:
> 
> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_plane.c:1271 handle_cursor_update() error: we previously assumed 'afb' could be null (see line 1230)
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:1017 dcn201_acquire_idle_pipe_for_layer() error: we previously assumed 'head_pipe' could be null (see line 1011)
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_hwseq.c:222 dcn21_set_backlight_level() error: we previously assumed 'panel_cntl' could be null (see line 213)
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_hwseq.c:765 dcn30_apply_idle_power_optimizations() error: we previously assumed 'stream' could be null (see line 749)
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_hwseq.c:767 dcn30_apply_idle_power_optimizations() error: we previously assumed 'plane' could be null (see line 749)
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn31/dcn31_hwseq.c:284 dcn31_init_hw() error: we previously assumed 'dc->clk_mgr' could be null (see line 117)
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_hwseq.c:896 dcn32_init_hw() error: we previously assumed 'dc->clk_mgr' could be null (see line 738)
> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/dcn32_fpu.c:777 subvp_drr_schedulable() error: we previously assumed 'pipe->stream' could be null (see line 768)
> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/dcn32_fpu.c:868 subvp_vblank_schedulable() error: we previously assumed 'subvp_pipe' could be null (see line 860)
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_hwseq.c:250 dcn201_init_hw() warn: variable dereferenced before check 'res_pool->dccg' (see line 227)
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_hwseq.c:782 dcn20_enable_stream_timing() warn: variable dereferenced before check 'pipe_ctx->stream_res.tg' (see line 698)
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn31/dcn31_hwseq.c:157 dcn31_init_hw() warn: variable dereferenced before check 'res_pool->dccg' (see line 147)
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_hwseq.c:765 dcn32_init_hw() warn: variable dereferenced before check 'res_pool->dccg' (see line 742)
> 
> Bad indenting:
> 
> drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn201/dcn201_clk_mgr.c:107 dcn201_update_clocks() warn: inconsistent indenting
> drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c:716 dcn314_clk_mgr_construct() warn: inconsistent indenting
> drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c:655 dcn315_clk_mgr_construct() warn: inconsistent indenting
> drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c:683 dcn316_clk_mgr_construct() warn: inconsistent indenting
> drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c:726 dcn31_clk_mgr_construct() warn: inconsistent indenting
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c:2152 dcn10_align_pixel_clocks() warn: inconsistent indenting
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn301/dcn301_resource.c:854 dcn301_hubbub_create() warn: inconsistent indenting
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_hwseq.c:618 dcn32_set_output_transfer_func() warn: inconsistent indenting
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_hwseq.c:910 dcn32_init_hw() warn: inconsistent indenting
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_mpc.c:306 mpc32_get_shaper_current() warn: inconsistent indenting
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_resource.c:1979 dcn32_resource_construct() warn: inconsistent indenting
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_resource.c:2319 dcn32_resource_construct() warn: inconsistent indenting
> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn303/dcn303_fpu.c:205 dcn303_fpu_update_bw_bounding_box() warn: inconsistent indenting
> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn303/dcn303_fpu.c:355 dcn303_fpu_init_soc_bounding_box() warn: inconsistent indenting
> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/dcn30_fpu.c:185 optc3_fpu_set_vrr_m_const() warn: inconsistent indenting
> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/dcn30_fpu.c:355 dcn30_fpu_set_mcif_arb_params() warn: inconsistent indenting
> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/dcn30_fpu.c:384 dcn30_fpu_calculate_wm_and_dlg() warn: inconsistent indenting
> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/dcn30_fpu.c:390 dcn30_fpu_calculate_wm_and_dlg() warn: inconsistent indenting
> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn31/display_mode_vba_31.c:1110 CalculatePrefetchSchedule() warn: inconsistent indenting
> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn31/display_mode_vba_31.c:1113 CalculatePrefetchSchedule() warn: inconsistent indenting
> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn31/display_mode_vba_31.c:1341 CalculatePrefetchSchedule() warn: inconsistent indenting
> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn31/display_rq_dlg_calc_31.c:1099 dml_rq_dlg_get_dlg_params() warn: inconsistent indenting
> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn321/dcn321_fpu.c:516 dcn321_update_bw_bounding_box_fpu() warn: inconsistent indenting
> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/dcn32_fpu.c:2069 dcn32_update_bw_bounding_box_fpu() warn: inconsistent indenting
> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c:683 DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation() warn: inconsistent indenting
> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_rq_dlg_calc_32.c:220 dml32_rq_dlg_get_dlg_reg() warn: inconsistent indenting
> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_rq_dlg_calc_32.c:224 dml32_rq_dlg_get_dlg_reg() warn: inconsistent indenting
> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_rq_dlg_calc_32.c:235 dml32_rq_dlg_get_dlg_reg() warn: inconsistent indenting
> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_rq_dlg_calc_32.c:240 dml32_rq_dlg_get_dlg_reg() warn: inconsistent indenting
> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_rq_dlg_calc_32.c:51 dml32_rq_dlg_get_rq_reg() warn: inconsistent indenting
> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_rq_dlg_calc_32.c:68 dml32_rq_dlg_get_rq_reg() warn: inconsistent indenting
> 
