Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6512C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Mar 2022 08:59:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 772B610E927;
	Tue, 15 Mar 2022 08:59:09 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9DF810E927
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Mar 2022 08:59:07 +0000 (UTC)
Received: from [192.168.0.3] (ip5f5ae8f9.dynamic.kabel-deutschland.de
 [95.90.232.249])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 068AC61EA1929;
 Tue, 15 Mar 2022 09:59:06 +0100 (CET)
Message-ID: <a6f11b2b-5044-0875-f97d-4dd39aa60aef@molgen.mpg.de>
Date: Tue, 15 Mar 2022 09:59:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 12/12] drm/amd/display: 3.2.177
Content-Language: en-US
To: Agustin Gutierrez <agustin.gutierrez@amd.com>, Aric Cyr <aric.cyr@amd.com>
References: <20220310222045.664867-1-agustin.gutierrez@amd.com>
 <20220310222045.664867-13-agustin.gutierrez@amd.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220310222045.664867-13-agustin.gutierrez@amd.com>
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 amd-gfx@lists.freedesktop.org, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Harry.Wentland@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Dear Agustin, dear Aric,


Am 10.03.22 um 23:20 schrieb Agustin Gutierrez:
> From: Aric Cyr <aric.cyr@amd.com>

It’d be great if you could make the git commit message summary a 
statement. Maybe:

 > drm/amd/display: Increment DC version from 3.2.176 to 3.2.177

>      This version brings along following fixes:
>      - Added I2C escape to support query exist

Use imperative mood: Add I2C escape to support query device exist

(Though reading that summary, I do not understand it.)

>      - Functionality to get pipe from stream context

Maybe:

 > Add functionality …

>      - debugfs entry fixes
>      - Block zstate when more than one plane enabled
>      - Update to engine ddc
>      - Reading lante status during LT fixes

lane?

>      - Null point filters

Maybe update all items to use the commit message summaries.

>      - [FW Promotion] Release 0.0.108.0

Please remove the indentation from the whole block. (It looks like 
copied from `git show` output, which should not be used.)


Kind regards,

Paul


> Acked-by: Agustin Gutierrez <agustin.gutierrez@amd.com>
> Signed-off-by: Aric Cyr <aric.cyr@amd.com>
> ---
>   drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
> index bd5f718a9eb2..4ffab7bb1098 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc.h
> +++ b/drivers/gpu/drm/amd/display/dc/dc.h
> @@ -47,7 +47,7 @@ struct aux_payload;
>   struct set_config_cmd_payload;
>   struct dmub_notification;
>   
> -#define DC_VER "3.2.176"
> +#define DC_VER "3.2.177"
>   
>   #define MAX_SURFACES 3
>   #define MAX_PLANES 6
