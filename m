Return-Path: <SRS0=vXfK=NL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA80C4338F
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Aug 2021 14:24:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8249610FF
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Aug 2021 14:24:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C8249610FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F22D6EAA2;
	Fri, 20 Aug 2021 14:24:23 +0000 (UTC)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA6996EAA2
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Aug 2021 14:24:22 +0000 (UTC)
Received: by mail-wr1-x436.google.com with SMTP id r7so14658646wrs.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Aug 2021 07:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=cBESVMT5GnF8T0rI4my15flddZDPjX9XRYPEvn64kso=;
 b=sXNNEeQ1I8JVgIfffwPHcy87Tr1jLfreRFcx7ynCOMrI/6Qwwh3YFjWUcPyKUniAtI
 250m2geGJdaZg8zuPcaXwwOd5rK8lU64tPAZ1w/shOr9W3UVK/iw1n7DLRcKOQSQut3B
 EK62oe0qUDUt9alYmDxjJzNjYzTdMbZy5WBsBtC40Z8Xs4Olb4xn3zXte+cvDf+aZGFQ
 OtEZcesGdTIQM5UhNGDGdBdhKsvU4I0xnOTCD8XZn/PLGtGsePV/YjXz5J6irlwZPTK5
 Wxgmpt2DO5kKwGBxC60zDkS1fWT8XR38QA8zT05QsdvMo+8YMIW2p2XMPbdyerg2SiXp
 kFoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=cBESVMT5GnF8T0rI4my15flddZDPjX9XRYPEvn64kso=;
 b=CNtRAa+Ym0LR1bZtkhCBvn9+p8JmgZ6om17UZ/5Ckb8u6uJR10UmQb5FwWHSoc9OvQ
 xN6m1KpmRsNvq7Dy+Q40f9OaA1ycxA+ZsOIppRAPSFGRfMg1SiRS1U5OaomwW1FWy7rR
 qjpSev1WNFWfIZ4rGm5zWjmcer3jkdSoeceb1godA73PmoSWV13tm5SmFcQEqwAqXStI
 SWtmPE17UO5CkrYrVbOLGnZ/OAPJumxomS9HEmPA62rDbcHemTq7Mj3yOBuPjqrLKyQf
 igXzOGRP7ovkPW9Dy5Tpj1wVgC80qom4FUn0pTGC6aiUeTheI0fRGp8lQ1rv4nt41XPd
 KYMA==
X-Gm-Message-State: AOAM531YPSFNWSMdbIEZMoRmn+SwQT6qEoyN0TG4ng7SOAEmrxuhPMkH
 bJZumRHhhZIzoH1ejWhVYw4JczgJ89k=
X-Google-Smtp-Source: ABdhPJxthrflNCcDEbIUQpJ0cF84cZf6xVNpCdZPwFAE+xxHKjiKhyyCaDH87DvSl7wsZSkeVpT8dQ==
X-Received: by 2002:a5d:6908:: with SMTP id t8mr10526218wru.182.1629469461407; 
 Fri, 20 Aug 2021 07:24:21 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:afc8:926b:c96f:5234?
 ([2a02:908:1252:fb60:afc8:926b:c96f:5234])
 by smtp.gmail.com with ESMTPSA id y13sm5071931wmj.27.2021.08.20.07.24.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Aug 2021 07:24:20 -0700 (PDT)
Subject: Re: [PATCH v3] drm/amdgpu/OLAND: clip the ref divider max value
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Eddy Qin <Eddy.Qin@amd.com>
References: <20210820135414.982355-1-shashank.sharma@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <66a44f45-338d-233e-debd-d47caf407fda@gmail.com>
Date: Fri, 20 Aug 2021 16:24:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210820135414.982355-1-shashank.sharma@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
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

Am 20.08.21 um 15:54 schrieb Shashank Sharma:
> This patch limits the ref_div_max value to 100, during the
> calculation of PLL feedback reference divider. With current
> value (128), the produced fb_ref_div value generates unstable
> output at particular frequencies. Radeon driver limits this
> value at 100.
>
> On Oland, when we try to setup mode 2048x1280@60 (a bit weird,
> I know), it demands a clock of 221270 Khz. It's been observed
> that the PLL calculations using values 128 and 100 are vastly
> different, and look like this:
>
> +------------------------------------------+
> |Parameter    |AMDGPU        |Radeon       |
> |             |              |             |
> +-------------+----------------------------+
> |Clock feedback              |             |
> |divider max  |  128         |   100       |
> |cap value    |              |             |
> |             |              |             |
> |             |              |             |
> +------------------------------------------+
> |ref_div_max  |              |             |
> |             |  42          |  20         |
> |             |              |             |
> |             |              |             |
> +------------------------------------------+
> |ref_div      |  42          |  20         |
> |             |              |             |
> +------------------------------------------+
> |fb_div       |  10326       |  8195       |
> +------------------------------------------+
> |fb_div       |  1024        |  163        |
> +------------------------------------------+
> |fb_dev_p     |  4           |  9          |
> |frac fb_de^_p|              |             |
> +----------------------------+-------------+
>
> With ref_div_max value clipped at 100, AMDGPU driver can also
> drive videmode 2048x1280@60 (221Mhz) and produce proper output
> without any blanking and distortion on the screen.
>
> PS: This value was changed from 128 to 100 in Radeon driver also, here:
> https://github.com/freedesktop/drm-tip/commit/4b21ce1b4b5d262e7d4656b8ececc891fc3cb806
>
> V1:
> Got acks from:
> Acked-by: Alex Deucher <alexander.deucher@amd.com>
> Acked-by: Christian König <christian.koenig@amd.com>
>
> V2:
> - Restricting the changes only for OLAND, just to avoid any regression
>    for other cards.
> - Changed unsigned -> unsigned int to make checkpatch quiet.
>
> V3: Apply the change on SI family (not only oland) (Christian)
>
> Cc: Alex Deucher <Alexander.Deucher@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Eddy Qin <Eddy.Qin@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_pll.c    | 20 +++++++++++++-------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_pll.h    |  3 ++-
>   drivers/gpu/drm/amd/amdgpu/atombios_crtc.c |  2 +-
>   3 files changed, 16 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pll.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pll.c
> index f2e20666c9c1..4eaec446b49d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pll.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pll.c
> @@ -80,12 +80,17 @@ static void amdgpu_pll_reduce_ratio(unsigned *nom, unsigned *den,
>    * Calculate feedback and reference divider for a given post divider. Makes
>    * sure we stay within the limits.
>    */
> -static void amdgpu_pll_get_fb_ref_div(unsigned nom, unsigned den, unsigned post_div,
> -				      unsigned fb_div_max, unsigned ref_div_max,
> -				      unsigned *fb_div, unsigned *ref_div)
> +static void amdgpu_pll_get_fb_ref_div(struct amdgpu_device *adev, unsigned int nom,
> +				      unsigned int den, unsigned int post_div,
> +				      unsigned int fb_div_max, unsigned int ref_div_max,
> +				      unsigned int *fb_div, unsigned int *ref_div)
>   {
> +
>   	/* limit reference * post divider to a maximum */
> -	ref_div_max = min(128 / post_div, ref_div_max);
> +	if (adev->family == AMDGPU_FAMILY_SI)
> +		ref_div_max = min(100 / post_div, ref_div_max);
> +	else
> +		ref_div_max = min(128 / post_div, ref_div_max);
>   
>   	/* get matching reference and feedback divider */
>   	*ref_div = min(max(DIV_ROUND_CLOSEST(den, post_div), 1u), ref_div_max);
> @@ -112,7 +117,8 @@ static void amdgpu_pll_get_fb_ref_div(unsigned nom, unsigned den, unsigned post_
>    * Try to calculate the PLL parameters to generate the given frequency:
>    * dot_clock = (ref_freq * feedback_div) / (ref_div * post_div)
>    */
> -void amdgpu_pll_compute(struct amdgpu_pll *pll,
> +void amdgpu_pll_compute(struct amdgpu_device *adev,
> +			struct amdgpu_pll *pll,
>   			u32 freq,
>   			u32 *dot_clock_p,
>   			u32 *fb_div_p,
> @@ -199,7 +205,7 @@ void amdgpu_pll_compute(struct amdgpu_pll *pll,
>   
>   	for (post_div = post_div_min; post_div <= post_div_max; ++post_div) {
>   		unsigned diff;
> -		amdgpu_pll_get_fb_ref_div(nom, den, post_div, fb_div_max,
> +		amdgpu_pll_get_fb_ref_div(adev, nom, den, post_div, fb_div_max,
>   					  ref_div_max, &fb_div, &ref_div);
>   		diff = abs(target_clock - (pll->reference_freq * fb_div) /
>   			(ref_div * post_div));
> @@ -214,7 +220,7 @@ void amdgpu_pll_compute(struct amdgpu_pll *pll,
>   	post_div = post_div_best;
>   
>   	/* get the feedback and reference divider for the optimal value */
> -	amdgpu_pll_get_fb_ref_div(nom, den, post_div, fb_div_max, ref_div_max,
> +	amdgpu_pll_get_fb_ref_div(adev, nom, den, post_div, fb_div_max, ref_div_max,
>   				  &fb_div, &ref_div);
>   
>   	/* reduce the numbers to a simpler ratio once more */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pll.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_pll.h
> index db6136f68b82..44a583d6c9b4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pll.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pll.h
> @@ -24,7 +24,8 @@
>   #ifndef __AMDGPU_PLL_H__
>   #define __AMDGPU_PLL_H__
>   
> -void amdgpu_pll_compute(struct amdgpu_pll *pll,
> +void amdgpu_pll_compute(struct amdgpu_device *adev,
> +			 struct amdgpu_pll *pll,
>   			 u32 freq,
>   			 u32 *dot_clock_p,
>   			 u32 *fb_div_p,
> diff --git a/drivers/gpu/drm/amd/amdgpu/atombios_crtc.c b/drivers/gpu/drm/amd/amdgpu/atombios_crtc.c
> index 159a2a4385a1..afad094f84c2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/atombios_crtc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/atombios_crtc.c
> @@ -851,7 +851,7 @@ void amdgpu_atombios_crtc_set_pll(struct drm_crtc *crtc, struct drm_display_mode
>   	pll->reference_div = amdgpu_crtc->pll_reference_div;
>   	pll->post_div = amdgpu_crtc->pll_post_div;
>   
> -	amdgpu_pll_compute(pll, amdgpu_crtc->adjusted_clock, &pll_clock,
> +	amdgpu_pll_compute(adev, pll, amdgpu_crtc->adjusted_clock, &pll_clock,
>   			    &fb_div, &frac_fb_div, &ref_div, &post_div);
>   
>   	amdgpu_atombios_crtc_program_ss(adev, ATOM_DISABLE, amdgpu_crtc->pll_id,

