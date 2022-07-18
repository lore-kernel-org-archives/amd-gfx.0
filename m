Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AE46C43334
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Jul 2022 19:40:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88FA110E623;
	Mon, 18 Jul 2022 19:40:25 +0000 (UTC)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33A0710E0A1
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Jul 2022 19:40:24 +0000 (UTC)
Received: by mail-ej1-x62a.google.com with SMTP id sz17so23192295ejc.9
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Jul 2022 12:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :references:from:in-reply-to:content-transfer-encoding;
 bh=C3vRVpSQ7AjoHtEgq79gqiBlH2RX9WfThea5RKHJgoU=;
 b=kwPrLs9gGdUmJ8PTec+vpxtHVByRE493EaYELF+LyehNE+af9+qqBssLrOXX57E3kr
 RrsuztA4KOO5vPI6qg9ptH3fSx2FQ5S8CSePgqXq0RX302H6NmwgFekafAy71NCjMkav
 UkiZ2M8TW5sKnCgpNEHtxi9gN+3ziJF787P2dqpcts6Q7N6LIydey0k2ix6i00oodCNh
 1es7eJtsJRBlPlEl0bP4CenOocElcJFPZmdh9NwS+WuxNG+ViSEDOAxtPbQmfw5vo7EL
 qEvn/YQwNE2WG8uYCu0TBRzxYLHdWXvUcrbBTozTFIuPnZ+J5c9AKz3i456qqprug3eS
 litA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:references:from:in-reply-to
 :content-transfer-encoding;
 bh=C3vRVpSQ7AjoHtEgq79gqiBlH2RX9WfThea5RKHJgoU=;
 b=h4Djg+Ya8g7CUP+lBQIMosChjzmfcHVgM5DKpXog8sZcMMAO0yvznYkRocFUXFE7JF
 lcFQgClNU9s4Y2oz+fAx/vX7nxmEXL0YFfGxUChjmv1CIgrWA2hNjmbyaz3SUzie1Jlo
 681JAh5/klb8gAJxUjnaNjPaH2CmhA9iCv7eduIgu0cdhUM8D6RhpXbRmfpBIKDH0te7
 8jOev3mcUU52ECZLS/dsPg2WQgr2wS8hUzSb1EXXzSo2rW34mav7oviQc3UKMb4Xow60
 nLtBqFFd4VXNE/W98Y3grbZZ6ATOiih4FvplUv4yQ9Ula/ZDBz0J0MDpY285Ma1TXWIW
 oY5w==
X-Gm-Message-State: AJIora+fZZ5pVCIYt8oT+4hRTKrvs6PYzEhPXL747I6WHyj8zUeOfT8C
 /PikpecG9PlUbPWnoxp13Dtvqi0ut2Q=
X-Google-Smtp-Source: AGRyM1umtpCVuC0bqx+QIPJnOFxGU8igHoMV2PqmrTYBS5Pl6F6zud4yXcjniR4pGsOmrn5UlSQzUw==
X-Received: by 2002:a17:907:28d6:b0:72b:7497:76b with SMTP id
 en22-20020a17090728d600b0072b7497076bmr26297383ejc.365.1658173222434; 
 Mon, 18 Jul 2022 12:40:22 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:224c:44a4:ecb8:82c2?
 ([2a02:908:1256:79a0:224c:44a4:ecb8:82c2])
 by smtp.gmail.com with ESMTPSA id
 dx24-20020a170906a85800b006fed93bf71fsm5931440ejb.18.2022.07.18.12.40.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Jul 2022 12:40:21 -0700 (PDT)
Message-ID: <d844be3e-68c5-2390-f706-2955780ea637@gmail.com>
Date: Mon, 18 Jul 2022 21:40:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm/amdgpu: fix scratch register access method in SRIOV
Content-Language: en-US
To: Gavin Wan <Gavin.Wan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220718193229.142120-1-Gavin.Wan@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20220718193229.142120-1-Gavin.Wan@amd.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 18.07.22 um 21:32 schrieb Gavin Wan:
> The scratch register should be accessed through MMIO instead of RLCG
> in SRIOV, since it being used in RLCG register access function.
>
> Fixes: 0e1314781b9c("drm/amdgpu: nuke dynamic gfx scratch reg allocation")
>
> Signed-off-by: Gavin Wan <Gavin.Wan@amd.com>
> Change-Id: I888cb3b96856583e764b35a098bcf8bff01ad90c

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 5349ca4d19e3..c6e0f9313a7f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -987,23 +987,23 @@ static void gfx_v9_0_wait_reg_mem(struct amdgpu_ring *ring, int eng_sel,
>   static int gfx_v9_0_ring_test_ring(struct amdgpu_ring *ring)
>   {
>   	struct amdgpu_device *adev = ring->adev;
> +	uint32_t scratch = SOC15_REG_OFFSET(GC, 0, mmSCRATCH_REG0);
>   	uint32_t tmp = 0;
>   	unsigned i;
>   	int r;
>   
> -	WREG32_SOC15(GC, 0, mmSCRATCH_REG0, 0xCAFEDEAD);
> +	WREG32(scratch, 0xCAFEDEAD);
>   	r = amdgpu_ring_alloc(ring, 3);
>   	if (r)
>   		return r;
>   
>   	amdgpu_ring_write(ring, PACKET3(PACKET3_SET_UCONFIG_REG, 1));
> -	amdgpu_ring_write(ring, SOC15_REG_OFFSET(GC, 0, mmSCRATCH_REG0) -
> -			  PACKET3_SET_UCONFIG_REG_START);
> +	amdgpu_ring_write(ring, scratch - PACKET3_SET_UCONFIG_REG_START);
>   	amdgpu_ring_write(ring, 0xDEADBEEF);
>   	amdgpu_ring_commit(ring);
>   
>   	for (i = 0; i < adev->usec_timeout; i++) {
> -		tmp = RREG32_SOC15(GC, 0, mmSCRATCH_REG0);
> +		tmp = RREG32(scratch);
>   		if (tmp == 0xDEADBEEF)
>   			break;
>   		udelay(1);

