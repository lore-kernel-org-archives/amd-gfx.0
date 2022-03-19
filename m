Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B280C433EF
	for <amd-gfx@archiver.kernel.org>; Sat, 19 Mar 2022 08:40:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D387910E1C0;
	Sat, 19 Mar 2022 08:40:32 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA10E10E1C0
 for <amd-gfx@lists.freedesktop.org>; Sat, 19 Mar 2022 08:40:31 +0000 (UTC)
Received: from [192.168.0.3] (ip5f5ae905.dynamic.kabel-deutschland.de
 [95.90.233.5])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id EFC1461EA1923;
 Sat, 19 Mar 2022 09:40:29 +0100 (CET)
Message-ID: <708c7014-04c2-ddeb-ea1d-0fb70b169ac8@molgen.mpg.de>
Date: Sat, 19 Mar 2022 09:40:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 10/13] drm/amd/display: remove destructive verify link for
 TMDS
Content-Language: en-US
To: Alex Hung <alex.hung@amd.com>, Charlene Liu <Charlene.Liu@amd.com>
References: <20220318214800.3565679-1-alex.hung@amd.com>
 <20220318214800.3565679-11-alex.hung@amd.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220318214800.3565679-11-alex.hung@amd.com>
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
Cc: stylon.wang@amd.com, Alan Liu <HaoPing.Liu@amd.com>,
 Aric Cyr <Aric.Cyr@amd.com>, Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 amd-gfx@lists.freedesktop.org, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Harry.Wentland@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Dear Alex, dear Charlene,


Thank you for the patch.

Am 18.03.22 um 22:47 schrieb Alex Hung:
> From: Charlene Liu <Charlene.Liu@amd.com>
> 
> [why and how]
> TMDS not need destructive verify link

According to whom? Please document the source for that claim.

Is that just to be spec compliant, or does it cause an actual problem? 
If so, how can it be reproduced?

> Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
> Acked-by: Alan Liu <HaoPing.Liu@amd.com>
> Acked-by: Alex Hung <alex.hung@amd.com>
> Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
> ---
>   drivers/gpu/drm/amd/display/dc/core/dc_link.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> index cb87dd643180..bbaa5abdf888 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> @@ -983,8 +983,7 @@ static bool should_verify_link_capability_destructively(struct dc_link *link,
>   				destrictive = false;
>   			}
>   		}
> -	} else if (dc_is_hdmi_signal(link->local_sink->sink_signal))
> -		destrictive = true;
> +	}
>   
>   	return destrictive;
>   }

It’d be great, if you also sent a patch to fix the typo in the variable 
name.


Kind regards,

Paul
