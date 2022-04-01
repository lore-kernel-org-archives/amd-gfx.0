Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72E9FC433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Apr 2022 05:46:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B846110F646;
	Fri,  1 Apr 2022 05:46:11 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CA7010F646;
 Fri,  1 Apr 2022 05:46:09 +0000 (UTC)
Received: from [192.168.0.4] (ip5f5aef67.dynamic.kabel-deutschland.de
 [95.90.239.103])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 72AF461EA192A;
 Fri,  1 Apr 2022 07:46:07 +0200 (CEST)
Message-ID: <6b01c237-c58c-26be-0f6a-2bdef452faa2@molgen.mpg.de>
Date: Fri, 1 Apr 2022 07:46:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/1] drm: add PSR2 support and capability definition as
 per eDP 1.5
Content-Language: en-US
To: David Zhang <dingchen.zhang@amd.com>
References: <20220331172652.3445223-1-dingchen.zhang@amd.com>
 <20220331172652.3445223-2-dingchen.zhang@amd.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220331172652.3445223-2-dingchen.zhang@amd.com>
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
Cc: stylon.wang@amd.com, solomon.chiu@amd.com, airlied@linux.ie,
 Bhawanpreet.Lakha@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, dri-devel@lists.freedesktop.org, Sunpeng.Li@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, amd-gfx@lists.freedesktop.org,
 daniel@ffwll.ch, wayne.lin@amd.com, Harry.Wentland@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Dear David,


Thank you for your patch.

Am 31.03.22 um 19:26 schrieb David Zhang:
> [why & how]
> In eDP 1.5 spec, some new DPCD bit fileds are defined for PSR-SU
> support.

You could be specific by using the exact number two. Maybe:

As per eDP 1.5 specification, add the two DPCD bit fields below for 
PSR-SU support:

1.  DP_PSR2_WITH_Y_COORD_ET_SUPPORTED
2.  DP_PSR2_SU_AUX_FRAME_SYNC_NOT_NEEDED


Kind regards,

Paul

> Signed-off-by: David Zhang <dingchen.zhang@amd.com>
> ---
>   include/drm/drm_dp_helper.h | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/include/drm/drm_dp_helper.h b/include/drm/drm_dp_helper.h
> index 30359e434c3f..ac7b7571ae66 100644
> --- a/include/drm/drm_dp_helper.h
> +++ b/include/drm/drm_dp_helper.h
> @@ -361,6 +361,7 @@ struct drm_panel;
>   # define DP_PSR_IS_SUPPORTED                1
>   # define DP_PSR2_IS_SUPPORTED		    2	    /* eDP 1.4 */
>   # define DP_PSR2_WITH_Y_COORD_IS_SUPPORTED  3	    /* eDP 1.4a */
> +# define DP_PSR2_WITH_Y_COORD_ET_SUPPORTED  4	    /* eDP 1.5, adopted eDP 1.4b SCR */
>   
>   #define DP_PSR_CAPS                         0x071   /* XXX 1.2? */
>   # define DP_PSR_NO_TRAIN_ON_EXIT            1
> @@ -375,6 +376,7 @@ struct drm_panel;
>   # define DP_PSR_SETUP_TIME_SHIFT            1
>   # define DP_PSR2_SU_Y_COORDINATE_REQUIRED   (1 << 4)  /* eDP 1.4a */
>   # define DP_PSR2_SU_GRANULARITY_REQUIRED    (1 << 5)  /* eDP 1.4b */
> +# define DP_PSR2_SU_AUX_FRAME_SYNC_NOT_NEEDED (1 << 6)/* eDP 1.5, adopted eDP 1.4b SCR */
>   
>   #define DP_PSR2_SU_X_GRANULARITY	    0x072 /* eDP 1.4b */
>   #define DP_PSR2_SU_Y_GRANULARITY	    0x074 /* eDP 1.4b */
