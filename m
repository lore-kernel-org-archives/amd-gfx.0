Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EBF8C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Mar 2022 08:28:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2919810E467;
	Tue, 15 Mar 2022 08:28:47 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEC0E10E467
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Mar 2022 08:28:45 +0000 (UTC)
Received: from [192.168.0.3] (ip5f5ae8f9.dynamic.kabel-deutschland.de
 [95.90.232.249])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 0514F61EA1928;
 Tue, 15 Mar 2022 09:28:44 +0100 (CET)
Message-ID: <fddfa9db-344f-3fa6-9aa9-00b0172ac8c6@molgen.mpg.de>
Date: Tue, 15 Mar 2022 09:28:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 04/12] drm/amd/display: Update engine ddc
Content-Language: en-US
To: Agustin Gutierrez <agustin.gutierrez@amd.com>
References: <20220310222045.664867-1-agustin.gutierrez@amd.com>
 <20220310222045.664867-5-agustin.gutierrez@amd.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220310222045.664867-5-agustin.gutierrez@amd.com>
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
Cc: stylon.wang@amd.com, Aric Cyr <Aric.Cyr@amd.com>, Sunpeng.Li@amd.com,
 Jing Zhou <Jing.Zhou@amd.com>, qingqing.zhuo@amd.com, wayne.lin@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, amd-gfx@lists.freedesktop.org,
 Bhawanpreet.Lakha@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Wyatt Wood <Wyatt.Wood@amd.com>, Harry.Wentland@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Dear Agustin,


Am 10.03.22 um 23:20 schrieb Agustin Gutierrez:
> From: Jing Zhou <Jing.Zhou@amd.com>
> 
> [Why]
> Crash caused by a ddc update failure

Please give more details. What setup is it? Did Linux crash or just 
print a stack trace?

Also *Update engine ddc* should be more concrete.

> [How]
> Update engine ddc before release engine.

Please add a Fixes tag.

> Reviewed-by: Wyatt Wood <Wyatt.Wood@amd.com>
> Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
> Acked-by: Agustin Gutierrez <agustin.gutierrez@amd.com>
> Signed-off-by: Jing Zhou <Jing.Zhou@amd.com>
> ---
>   drivers/gpu/drm/amd/display/dc/dce/dce_aux.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
> index b8d6f4202413..8e814000db62 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
> @@ -413,6 +413,7 @@ static bool acquire(
>   		return false;
>   
>   	if (!acquire_engine(engine)) {
> +		engine->ddc = ddc;
>   		release_engine(engine);
>   		return false;
>   	}


Kind regards,

Paul
