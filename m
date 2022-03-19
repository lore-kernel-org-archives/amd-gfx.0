Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F4000C433F5
	for <amd-gfx@archiver.kernel.org>; Sat, 19 Mar 2022 06:52:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4111910EAEA;
	Sat, 19 Mar 2022 06:52:26 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C485510EAEA
 for <amd-gfx@lists.freedesktop.org>; Sat, 19 Mar 2022 06:52:24 +0000 (UTC)
Received: from [192.168.0.3] (ip5f5ae905.dynamic.kabel-deutschland.de
 [95.90.233.5])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id CC42B61EA1923;
 Sat, 19 Mar 2022 07:52:21 +0100 (CET)
Message-ID: <25d377b0-bbe0-325a-dc4b-0c8ce7c7e6e2@molgen.mpg.de>
Date: Sat, 19 Mar 2022 07:52:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 03/13] drm/amd/display: Reduce stack size
Content-Language: en-US
To: Alex Hung <alex.hung@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
References: <20220318214800.3565679-1-alex.hung@amd.com>
 <20220318214800.3565679-4-alex.hung@amd.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220318214800.3565679-4-alex.hung@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: stylon.wang@amd.com, Aric Cyr <Aric.Cyr@amd.com>, Sunpeng.Li@amd.com,
 Bhawanpreet.Lakha@amd.com, qingqing.zhuo@amd.com, roman.li@amd.com,
 amd-gfx@lists.freedesktop.org, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Harry.Wentland@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Dear Alex, dear Rodrigo,


Thank you for the patch.

Am 18.03.22 um 22:47 schrieb Alex Hung:
> From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> 
> Linux kernel enabled more compilation restrictions related to the stack
> size,

Could you please reference the commit, where that was introduced.

> which caused compilation failures in our code.

Please give one example failure message.

> This commit reduces the allocation size by allocating the required
> memory dynamically.
Did you do measurements how much the stack size was reduced in the end? 
If so, it’d be great if you documented that in the commit message.

> Reviewed-by: Harry Wentland <Harry.Wentland@amd.com>
> Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
> Acked-by: Alex Hung <alex.hung@amd.com>
> Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> ---
>   drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> index c3e141c19a77..ad757b59e00e 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> @@ -2056,7 +2056,7 @@ static int dcn10_align_pixel_clocks(struct dc *dc, int group_size,
>   {
>   	struct dc_context *dc_ctx = dc->ctx;
>   	int i, master = -1, embedded = -1;
> -	struct dc_crtc_timing hw_crtc_timing[MAX_PIPES] = {0};
> +	struct dc_crtc_timing *hw_crtc_timing;
>   	uint64_t phase[MAX_PIPES];
>   	uint64_t modulo[MAX_PIPES];
>   	unsigned int pclk;
> @@ -2067,6 +2067,10 @@ static int dcn10_align_pixel_clocks(struct dc *dc, int group_size,
>   	uint32_t dp_ref_clk_100hz =
>   		dc->res_pool->dp_clock_source->ctx->dc->clk_mgr->dprefclk_khz*10;
>   
> +	hw_crtc_timing = kcalloc(MAX_PIPES, sizeof(*hw_crtc_timing), GFP_KERNEL);
> +	if (!hw_crtc_timing)
> +		return master;
> +
>   	if (dc->config.vblank_alignment_dto_params &&
>   		dc->res_pool->dp_clock_source->funcs->override_dp_pix_clk) {
>   		embedded_h_total =
> @@ -2130,6 +2134,8 @@ static int dcn10_align_pixel_clocks(struct dc *dc, int group_size,
>   		}
>   
>   	}
> +
> +	kfree(hw_crtc_timing);
>   	return master;
>   }
>   


Kind regards,

Paul
