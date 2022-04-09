Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2109EC433EF
	for <amd-gfx@archiver.kernel.org>; Sat,  9 Apr 2022 19:17:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69C6310E3D7;
	Sat,  9 Apr 2022 19:17:39 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6A3C10E3D7
 for <amd-gfx@lists.freedesktop.org>; Sat,  9 Apr 2022 19:17:37 +0000 (UTC)
Received: from [192.168.0.2] (ip5f5ae90c.dynamic.kabel-deutschland.de
 [95.90.233.12])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 263F061EA1928;
 Sat,  9 Apr 2022 21:17:35 +0200 (CEST)
Message-ID: <75713171-6728-0bb7-216a-25473cffa355@molgen.mpg.de>
Date: Sat, 9 Apr 2022 21:17:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 01/20] drm/amd/display: undo clearing of z10 related
 function pointers
Content-Language: en-US
To: Pavle Kotarac <Pavle.Kotarac@amd.com>, Eric Yang <Eric.Yang2@amd.com>
References: <20220408171911.601615-1-Pavle.Kotarac@amd.com>
 <20220408171911.601615-2-Pavle.Kotarac@amd.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220408171911.601615-2-Pavle.Kotarac@amd.com>
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 amd-gfx@lists.freedesktop.org, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Harry.Wentland@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Dear Eric, dear Pavle,


Thank you for the patch.

Am 08.04.22 um 19:18 schrieb Pavle Kotarac:
> From: Eric Yang <Eric.Yang2@amd.com>
> 
> [Why]
> Z10 and S0i3 have some shared path. Previous code clean up ,

1.  cleanup
2.  Remove the space before the comma, or remove the unneeded comma.

> incorrectly removed these pointers, which breaks s0i3 restore

Please add a dot/period at the end of sentences.

How does tho breakage manifest exactly?

Maybe mention, that it only happened with `dc->debug.disable_z10`.

> 
> [How]
> Do not clear the function pointers based on Z10 disable.
> 

What commit introduced the regression? Please add a Fixes tag.

> Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
> Acked-by: Pavle Kotarac <Pavle.Kotarac@amd.com>
> Signed-off-by: Eric Yang <Eric.Yang2@amd.com>
> ---
>   drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c | 5 -----
>   1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c
> index d7559e5a99ce..e708f07fe75a 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c
> @@ -153,9 +153,4 @@ void dcn31_hw_sequencer_construct(struct dc *dc)
>   		dc->hwss.init_hw = dcn20_fpga_init_hw;
>   		dc->hwseq->funcs.init_pipes = NULL;
>   	}
> -	if (dc->debug.disable_z10) {
> -		/*hw not support z10 or sw disable it*/
> -		dc->hwss.z10_restore = NULL;
> -		dc->hwss.z10_save_init = NULL;
> -	}
>   }


Kind regards,

Paul
