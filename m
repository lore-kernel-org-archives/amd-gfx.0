Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2511C64EC4
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Mar 2023 09:33:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3552610E7C7;
	Thu,  9 Mar 2023 09:33:29 +0000 (UTC)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EF0610E7B2
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Mar 2023 08:49:03 +0000 (UTC)
Received: by mail-lj1-x22d.google.com with SMTP id f16so1038287ljq.10
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Mar 2023 00:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1678351741;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ndQH7nAbuFcVR/u/HQsjMbEiAKZj5mUlBWSv1hdxxug=;
 b=Fb9OmPAOd5KS4H8D3+pBZFeBepyfAqDGqkOEsG924nynzRB+ZBVaIz1bl2j8WLJEkp
 oi+4tFWoo/vjLODwyQPBN5pd6St6I8WvEr7ycr31AXzAsuwKVrOhO8UFY2FfBbaW8RL/
 wziauTtv6gr+1DCr+Gbb1RiQcnyUhNGaM5Ug155ZwSp/utUU0t9xNycdxsVOO+C4xMKL
 TqU7CUqL0+bQ4NAA4wydrczSYbATVJm1mgcByyHu3wqukezabLUMN9bZda1R4im74ttC
 46261RaP2oF/9CH9PuxFfyIqRuFlLrS/LDIcsf1NqG8pKbkAoP6277NvrxLlSxkbMuuo
 QMkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678351741;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ndQH7nAbuFcVR/u/HQsjMbEiAKZj5mUlBWSv1hdxxug=;
 b=uyFT0yiszrzcmGrfej2P24JOWB96B/L5dx9H+fq1ZnHkceed6dSa0Gonltqyx2fAIO
 vtBQaHkE8tyLV70zzA5ZRlClfjHjXGJplyNIFu5xbrrV8ogLcIget7UXHSMZlfx1Lkz/
 bWD2TRGguWhiAdBkshAnlCfl9fNQggEvjMHzhTQ1O/l1sFFo2VMenwSxBJKL7/W9WyKO
 AH1zFdplEci4mTkXlUaf6z3TOFgRv1Wf609cYkrSzJA4e7p0n+ON48SU7q5xiY239/FN
 RRhwiLGxbJWDSsCjpl3XsRFFw1TSyAhrlJnq6rXm9h8LO5Rg7u5m23ICCHSXjg59VSKY
 UmQQ==
X-Gm-Message-State: AO0yUKU5v08P3KsY1ivPRSm6FWfuECNTvfWKX/op2huQ1/sBdsVKX/Zl
 u6iKL6BlKdJpVqtRtia74qLuvA==
X-Google-Smtp-Source: AK7set8LMu/BEMahbfX8gOyx7vqpoCvyQcWjOT4Pg5tbVcOM9eItld6zLilvF6VjTTGz35wNktmXUA==
X-Received: by 2002:a2e:b613:0:b0:295:b0ee:666d with SMTP id
 r19-20020a2eb613000000b00295b0ee666dmr5604860ljn.53.1678351741139; 
 Thu, 09 Mar 2023 00:49:01 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5?
 (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
 by smtp.gmail.com with ESMTPSA id
 s15-20020a2e98cf000000b002986d306698sm584002ljj.95.2023.03.09.00.49.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Mar 2023 00:49:00 -0800 (PST)
Message-ID: <55b40f8f-b1d8-71ba-0af5-91e08e69160f@linaro.org>
Date: Thu, 9 Mar 2023 10:49:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/2] drm/probe_helper: warning on poll_enabled for issue
 catching
Content-Language: en-GB
To: Guchun Chen <guchun.chen@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, alexander.deucher@amd.com,
 hawking.zhang@amd.com, spasswolf@web.de, mike@fireburn.co.uk
References: <20230309054839.2709424-1-guchun.chen@amd.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230309054839.2709424-1-guchun.chen@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 09 Mar 2023 09:33:28 +0000
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

On 09/03/2023 07:48, Guchun Chen wrote:
> In order to catch issues in other drivers to ensure proper call
> sequence of polling function.
> 
> Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/2411
> Fixes: a4e771729a51("drm/probe_helper: sort out poll_running vs poll_enabled")

Previously it was suggested that this is not a fix, so the Fixes header 
is incorrect.

Also please use -vN when preparing/sending patchsets. This is v2.

> Reported-by: Bert Karwatzki <spasswolf@web.de>
> Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>
> ---
>   drivers/gpu/drm/drm_probe_helper.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_probe_helper.c b/drivers/gpu/drm/drm_probe_helper.c
> index 8127be134c39..85e0e80d4a52 100644
> --- a/drivers/gpu/drm/drm_probe_helper.c
> +++ b/drivers/gpu/drm/drm_probe_helper.c
> @@ -852,6 +852,8 @@ EXPORT_SYMBOL(drm_kms_helper_is_poll_worker);
>    */
>   void drm_kms_helper_poll_disable(struct drm_device *dev)
>   {
> +	WARN_ON(!dev->mode_config.poll_enabled);
> +
>   	if (dev->mode_config.poll_running)
>   		drm_kms_helper_disable_hpd(dev);
>   

-- 
With best wishes
Dmitry

