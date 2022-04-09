Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7324BC433EF
	for <amd-gfx@archiver.kernel.org>; Sat,  9 Apr 2022 19:21:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6C1910E063;
	Sat,  9 Apr 2022 19:21:31 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E860B10E063
 for <amd-gfx@lists.freedesktop.org>; Sat,  9 Apr 2022 19:21:30 +0000 (UTC)
Received: from [192.168.0.2] (ip5f5ae90c.dynamic.kabel-deutschland.de
 [95.90.233.12])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 34B3361EA1928;
 Sat,  9 Apr 2022 21:21:29 +0200 (CEST)
Message-ID: <b94be5b4-6b81-66f9-ba6e-f040d0c55e64@molgen.mpg.de>
Date: Sat, 9 Apr 2022 21:21:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 02/20] drm/amd/display: do not wait for mpc idle if tg is
 disabled
Content-Language: en-US
To: Pavle Kotarac <Pavle.Kotarac@amd.com>
References: <20220408171911.601615-1-Pavle.Kotarac@amd.com>
 <20220408171911.601615-3-Pavle.Kotarac@amd.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220408171911.601615-3-Pavle.Kotarac@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 amd-gfx@lists.freedesktop.org, Bhawanpreet.Lakha@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Jun Lei <Jun.Lei@amd.com>,
 Josip Pavic <Josip.Pavic@amd.com>, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Dear Pavle,


Thank you for the patch.

Am 08.04.22 um 19:18 schrieb Pavle Kotarac:
> From: Josip Pavic <Josip.Pavic@amd.com>
> 
> [Why]
> When booting, the driver waits for the MPC idle bit to be set as part of
> pipe initialization. However, on some systems this occurs before OTG is
> enabled, and since the MPC idle bit won't be set until the vupdate
> signal occurs (which requires OTG to be enabled), this never happens and
> the wait times out. This can add hundreds of milliseconds to the boot
> time.

Please list one specific system, where OTG is enabled later.

> 
> [How]
> Do not wait for mpc idle if tg is disabled

Please add a dot/period at the end of sentences.

> Reviewed-by: Jun Lei <Jun.Lei@amd.com>
> Acked-by: Pavle Kotarac <Pavle.Kotarac@amd.com>
> Signed-off-by: Josip Pavic <Josip.Pavic@amd.com>
> ---
>   drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> index 50820e79d3c4..2d3d870f0bea 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> @@ -3185,7 +3185,8 @@ void dcn10_wait_for_mpcc_disconnect(
>   		if (pipe_ctx->stream_res.opp->mpcc_disconnect_pending[mpcc_inst]) {
>   			struct hubp *hubp = get_hubp_by_inst(res_pool, mpcc_inst);
>   
> -			res_pool->mpc->funcs->wait_for_idle(res_pool->mpc, mpcc_inst);
> +			if (pipe_ctx->stream_res.tg->funcs->is_tg_enabled(pipe_ctx->stream_res.tg))
> +				res_pool->mpc->funcs->wait_for_idle(res_pool->mpc, mpcc_inst);
>   			pipe_ctx->stream_res.opp->mpcc_disconnect_pending[mpcc_inst] = false;
>   			hubp->funcs->set_blank(hubp, true);
>   		}


Kind regards,

Paul
