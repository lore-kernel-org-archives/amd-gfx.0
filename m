Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEBAAC61DA4
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Feb 2023 13:18:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D04A10E793;
	Fri,  3 Feb 2023 13:18:06 +0000 (UTC)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FB4810E793
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Feb 2023 13:18:03 +0000 (UTC)
Received: by mail-ej1-x632.google.com with SMTP id mf7so15250444ejc.6
 for <amd-gfx@lists.freedesktop.org>; Fri, 03 Feb 2023 05:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=c/VvD9hB9Epdbh3wMnBinhxophhuXywj9GjVcfoTRsk=;
 b=FvvplfwO1Lvk2iXP8gPFBxM625H0wFI8mSbbLWofqUI464Kdi6lfxy4thkK0b/9x6U
 viYVA+1XlSRFz2LXicj94F8CYMZIH0jlABpbiVUXiaf54evfkB1gGmJga3qv3qQRSO2Z
 K2t000vB94T3M3q1YKodH6XAfG0/jp5Rzy0OqnJPSa2lRkzQzQLSrssRNeZEx3urQvnX
 ZZBQ1EXn/2ZakRWwOHl6/9VuhX69OPZNSOpkIarMz8QW6au46Vbb9d2qRVAFKaAnP4tE
 j1DKhNjJNRybOO35GWqJA6BtZqIQU6G8tLXgxyW1WDZ0m3Dog2UP0gMeKYxhKpijKptV
 cS7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=c/VvD9hB9Epdbh3wMnBinhxophhuXywj9GjVcfoTRsk=;
 b=d+nUHFa5sFtKerUbWND1jbo3107G1KgtT0FnEcBZuI4vfk+MGRVXWPfZkEr3642lp6
 WGkiG03VUb5G9gkazlf9gRAlo92xSHC4u2N3EEoAo+fC0AhFgIgB48JtMxJ9SBbH2HGU
 Ph9GAehMjG2mlAUsB1DfDitw5XOpyQMI0XK5K3fRD9z6yqD73ocp5Xf45szrerzxs8r4
 x0j+JSZ5H0TWUpbOzF4MCX28ZKOhX5RTE+PQE5sXOIxGkwCa2Jiu36Z+342voOntB1pZ
 Hkr3ZTyuFSVny/2zaYWJFrIlPuwh2gQ/Ho3xEEtTx60MiEM2Me2lUObxUpnQ2+UCBfCo
 ctRw==
X-Gm-Message-State: AO0yUKWhGJ4mbIibuw6ND/9shYQuBPbIM/h8oePLtjTfPaM6KJ3EzFof
 q74DpE77M4m3n5Ir1Pcevx0=
X-Google-Smtp-Source: AK7set9Aht0AW/c/Im5mM7j2TDO8ZTdfn93Kq0aJi4A3hbQK9cHmTpuEzW8rsg3ALJUA1hc2NU7D7w==
X-Received: by 2002:a17:906:1711:b0:87b:cdab:988e with SMTP id
 c17-20020a170906171100b0087bcdab988emr8523698eje.21.1675430281868; 
 Fri, 03 Feb 2023 05:18:01 -0800 (PST)
Received: from ?IPV6:2a02:908:1256:79a0:e69f:4344:5e2b:198b?
 ([2a02:908:1256:79a0:e69f:4344:5e2b:198b])
 by smtp.gmail.com with ESMTPSA id
 cd11-20020a170906b34b00b008720c458bd4sm1382581ejb.3.2023.02.03.05.18.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Feb 2023 05:18:01 -0800 (PST)
Message-ID: <7a1b9b2c-3f5c-ebee-530a-55075f61ee82@gmail.com>
Date: Fri, 3 Feb 2023 14:18:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] drm/amd: fix memory leak in amdgpu_cs_sync_rings
Content-Language: en-US
To: Bert Karwatzki <spasswolf@web.de>, Alex Deucher <alexdeucher@gmail.com>
References: <905de6ced5f1798deb21a523910a05cf9ff691bc.camel@web.de>
 <CADnq5_N97JdMT_yk-X+RgMuO_=P3FNaYFN7URvNc38icGkjxWQ@mail.gmail.com>
 <3b590ba0f11d24b8c6c39c3d38250129c1116af4.camel@web.de>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <3b590ba0f11d24b8c6c39c3d38250129c1116af4.camel@web.de>
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 02.02.23 um 20:02 schrieb Bert Karwatzki:
> I hope I got it right this time:
> Here is the fix for
> Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/2360
>
>  From 6e064c9565ef0da890f3fcb2a4f6a8cd44a12fdb Mon Sep 17 00:00:00 2001
> From: Bert Karwatzki <spasswolf@web.de>
> Date: Thu, 2 Feb 2023 19:50:27 +0100
> Subject: [PATCH] Fix memory leak in amdgpu_cs_sync_rings.
>
> Signed-off-by: Bert Karwatzki <spasswolf@web.de>

Well this patch header is not properly formated, but I think Alex can 
fix this when he picks it up. If not I will take care of this next week.

Reviewed-by: Christian König <christian.koenig@amd.com> on the code change.

Thanks,
Christian.

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index 0f4cb41078c1..08eced097bd8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -1222,10 +1222,13 @@ static int amdgpu_cs_sync_rings(struct
> amdgpu_cs_parser *p)
>   		 * next job actually sees the results from the
> previous one
>   		 * before we start executing on the same scheduler
> ring.
>   		 */
> -		if (!s_fence || s_fence->sched != sched)
> +		if (!s_fence || s_fence->sched != sched) {
> +			dma_fence_put(fence);
>   			continue;
> +		}
>   
>   		r = amdgpu_sync_fence(&p->gang_leader->explicit_sync,
> fence);
> +		dma_fence_put(fence);
>   		if (r)
>   			return r;
>   	}

