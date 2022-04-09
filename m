Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EC32C433EF
	for <amd-gfx@archiver.kernel.org>; Sat,  9 Apr 2022 19:26:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37D6710E7B6;
	Sat,  9 Apr 2022 19:26:52 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 522A410E443
 for <amd-gfx@lists.freedesktop.org>; Sat,  9 Apr 2022 19:26:37 +0000 (UTC)
Received: from [192.168.0.2] (ip5f5ae90c.dynamic.kabel-deutschland.de
 [95.90.233.12])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 304DD61EA1928;
 Sat,  9 Apr 2022 21:26:35 +0200 (CEST)
Message-ID: <838947f4-bbed-fd0e-7618-c7fff801e6ce@molgen.mpg.de>
Date: Sat, 9 Apr 2022 21:26:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 03/20] drm/amd/display: Disabling Z10 on DCN31
Content-Language: en-US
To: Pavle Kotarac <Pavle.Kotarac@amd.com>, syerizvi@amd.com
References: <20220408171911.601615-1-Pavle.Kotarac@amd.com>
 <20220408171911.601615-4-Pavle.Kotarac@amd.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220408171911.601615-4-Pavle.Kotarac@amd.com>
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
Cc: stylon.wang@amd.com, Eric Yang <Eric.Yang2@amd.com>, Sunpeng.Li@amd.com,
 Bhawanpreet.Lakha@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, amd-gfx@lists.freedesktop.org, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Harry.Wentland@amd.com,
 agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Dear Pavle, dear syerizvi,


Thank you for the patch.

Am 08.04.22 um 19:18 schrieb Pavle Kotarac:
> From: "AMD\\syerizvi" <syerizvi@amd.com>

Please correct the author name.

Imperative mood should be used in the commit message summary: Disable Z10 ….

> 
> [WHY]
> Z10 is should not be enabled by default on DCN31.

According to what source?

> 
> [HOW]
> Using DC debug flags to disable Z10 by default on DCN31.

s/Using/Use/

Why is that grouped under debug flags? Does not seem related.

> 
> Reviewed-by: Eric Yang <Eric.Yang2@amd.com>
> Acked-by: Pavle Kotarac <Pavle.Kotarac@amd.com>
> Signed-off-by: AMD\syerizvi <syerizvi@amd.com>

Please fix the name.

> ---
>   drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
> index f27262417abe..6cc580be7c79 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
> @@ -885,6 +885,7 @@ static const struct dc_debug_options debug_defaults_drv = {
>   			.afmt = true,
>   		}
>   	},
> +	.disable_z10 = true,
>   	.optimize_edp_link_rate = true,
>   	.enable_sw_cntl_psr = true,
>   	.apply_vendor_specific_lttpr_wa = true,


Kind regards,

Paul
