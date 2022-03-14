Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 582EBC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Mar 2022 07:53:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D66AD10E763;
	Mon, 14 Mar 2022 07:53:29 +0000 (UTC)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CD3810E763
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Mar 2022 07:53:29 +0000 (UTC)
Received: by mail-ej1-x62d.google.com with SMTP id qa43so31732118ejc.12
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Mar 2022 00:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=mo2HDtRrgGQ9YwCyOEcwgqn7j8VGNkkTCB9I+hOfhyE=;
 b=Tba6JIul+sktI5mjbk2yQRm+dyKs/ZLa3yCsV5PC9K04LjYpj0GLYZSa79eCDpI0V2
 +K2sIDIlEralZnnukx5CxZyEA1DvXUSQ8jvGZdFs0K0GNfi+J7Y86nqypL9TMgPtNpNe
 WWZ7/bNoZqScHIkxRAUlZ1FaAqEtcYWMLi9lMzhm7nKk1DgFXx370EMFGbaz82gn2RDi
 3FxsIykQ5LODXQvDm2HOkIZTF3WaHH1y32UfvoRaNDRVWSbI5mwOrFbeLyYHijXCb9Zx
 bMhxvpL+PAUVQN4iDkd40SGQFjiAUAVamJlbz+riugOZbFp0mPBey5XYT5WkNpNc/uVe
 gDzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=mo2HDtRrgGQ9YwCyOEcwgqn7j8VGNkkTCB9I+hOfhyE=;
 b=v9lRgsHe2oTrIe06s8ut2PdT/Go8c+lYhpz7Ba3LbEbyX5vFcjSVfp/RhpAZ3pVT0u
 NpSxaHbjXDKYWdNtKhBYiL9nIOGDQnj6ObQG/NkVe6BlT6ap50mqTQoOPpBrUwjkx72r
 NAVhk89a5pyBpK91T489ZFAz9iFI6sS5VZW9fDaf4uVBlfeukC+SZMdVadoj3+vc+ZuF
 O7cwkmQ61ZYWNUDaqADSambYyIc2wozPxsXQeMjjXn6PQzv+uWzSE8RvB+B+dr1sOsGI
 QLi4diSfdtdybisiclRV+NbNcrIifpv2Cd/uzN3p9wcs75prdufACZT7ws6uxPDfm1KU
 GUYQ==
X-Gm-Message-State: AOAM530RV0xQ7kSy8fOrpxqClKrQIjVP0qU2J65ZO5seIHDOy4hxClGW
 j15Bwr8Wn4bzjTGN1Nw/RRA=
X-Google-Smtp-Source: ABdhPJyLylCE5/m/EUAKbKn7YtV+JSsUQPslxf6yKQJyELR5l75s7RFI7NSb5eo9eEp4kkOKLGaRLw==
X-Received: by 2002:a17:906:3a18:b0:6cd:ba45:995f with SMTP id
 z24-20020a1709063a1800b006cdba45995fmr18262180eje.328.1647244407831; 
 Mon, 14 Mar 2022 00:53:27 -0700 (PDT)
Received: from [192.168.178.21] (p5b0eab60.dip0.t-ipconnect.de. [91.14.171.96])
 by smtp.gmail.com with ESMTPSA id
 bk1-20020a170906b0c100b006d47308d84dsm6454781ejb.33.2022.03.14.00.53.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Mar 2022 00:53:27 -0700 (PDT)
Message-ID: <6b9a2eed-b6b8-f0ea-0254-dc07f39d62f6@gmail.com>
Date: Mon, 14 Mar 2022 08:53:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] drm/amdgpu: reject secure submission on rings which don't
 support it
Content-Language: en-US
To: Lang Yu <Lang.Yu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220314024648.2201565-1-Lang.Yu@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20220314024648.2201565-1-Lang.Yu@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 14.03.22 um 03:46 schrieb Lang Yu:
> Only ring GFX, SDMA and VCN_DEC support secure submission at the moment.
>
> Signed-off-by: Lang Yu <Lang.Yu@amd.com>

it would be nicer if we have that as flag in ring->funcs, but that way 
works for now as well.

Reviewed-by: Christian König <christian.koenig@amd.com>

Thanks,
Christian.

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c   | 4 ++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 8 ++++++++
>   2 files changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> index bc1297dcdf97..840304691b92 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> @@ -166,8 +166,8 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
>   	}
>   
>   	if ((ib->flags & AMDGPU_IB_FLAGS_SECURE) &&
> -	    (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE)) {
> -		dev_err(adev->dev, "secure submissions not supported on compute rings\n");
> +	    !amdgpu_ring_secure_submission_supported(ring)) {
> +		dev_err(adev->dev, "secure submissions not supported on ring <%s>\n", ring->name);
>   		return -EINVAL;
>   	}
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index a8bed1b47899..3afe3d60e194 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -363,6 +363,14 @@ static inline void amdgpu_ring_write_multiple(struct amdgpu_ring *ring,
>   	ring->count_dw -= count_dw;
>   }
>   
> +static inline
> +bool amdgpu_ring_secure_submission_supported(struct amdgpu_ring *ring)
> +{
> +	return (ring->funcs->type == AMDGPU_RING_TYPE_GFX ||
> +		ring->funcs->type == AMDGPU_RING_TYPE_SDMA ||
> +		ring->funcs->type == AMDGPU_RING_TYPE_VCN_DEC);
> +}
> +
>   int amdgpu_ring_test_helper(struct amdgpu_ring *ring);
>   
>   void amdgpu_debugfs_ring_init(struct amdgpu_device *adev,

