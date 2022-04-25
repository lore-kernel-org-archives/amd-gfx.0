Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B9F3C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Apr 2022 10:52:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05C8210E2D2;
	Mon, 25 Apr 2022 10:52:07 +0000 (UTC)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2213C10E2D2
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Apr 2022 10:52:06 +0000 (UTC)
Received: by mail-ed1-x536.google.com with SMTP id a21so5685066edb.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Apr 2022 03:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=BrTZNzimTF2Kf1k6VeZZsx4uwPmHOhP5TccATDHeGmQ=;
 b=K5Jn5HA9KxTtLboYv6l+VU2p3Urnbh1svV403yVNmUjZVt2cofvrkLcsBKwrHSnDEB
 mMJ0dR8EgtMPMl7siQ88H4E4LRHDXT2WWT21mdSkCv5WI+q6TbSUtBpjO9+k4QMUlFsc
 K9UX250IKzDGiYIAXe7vJGKWIdqj/N4fvqTTgI6feTx/pBVJyBpbrnS3fi3x6htII/+q
 qXDfcdyRQndouL8HwsBu66fv7TkswnOiJSKOL//fE1yPBcFdXDEY3B4nJVYi8rZE/IOb
 auSE21Y1zc4vxxQicBTo/ZZlk+ouaJGtCrTAFO7O6Wh1AyHLKoy0Qtx2iNeqNM6owikg
 /kMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=BrTZNzimTF2Kf1k6VeZZsx4uwPmHOhP5TccATDHeGmQ=;
 b=2NiIm+F0Q4mVM55wQ0e/Yp40ns9R4DeYcSJTDG1mtRowsH7Hq2FX+3Aeun3nui07vR
 wASSa/sUVbwedVodcJXhruQannfbXE+4fePJSsk6riY+Z/juNySdeWMUXARgIdvQ/byS
 N/iEN12lGlQ1QU43qcyrcFueLox7TWEkzeYeGAfysfCXR3uO897E5Li1ARui5MyfMvSo
 Y1GnjDCUQONpBLVjhmWjYAa394LjCNv9K2MLOyxnu1PaLZSgqHcN7eNjb06K0Rg4a5RK
 I4n2z3SV/K2O5yLFY32/iVHHJgj2mbEm2dPTLMcqyivCG01DK9cY5exfzSKn0hFqvmRe
 0DdA==
X-Gm-Message-State: AOAM531Phyw5LE496gzLURo+zw2YGovNDBGRDxR174jGyrGP3NpPO+a5
 Vpk4/2cO1J/W6GuvucffxB4=
X-Google-Smtp-Source: ABdhPJw3unUznTQU+wHf8zqZ9gx6goYwsncqQA9jCwwM+zEzCGiSL5qq9S6wegOvKmOxXI2LnC3dLQ==
X-Received: by 2002:a05:6402:22e1:b0:425:d5e5:c63 with SMTP id
 dn1-20020a05640222e100b00425d5e50c63mr9569511edb.185.1650883924604; 
 Mon, 25 Apr 2022 03:52:04 -0700 (PDT)
Received: from ?IPV6:2a02:908:1252:fb60:7284:dbdc:d72b:7ea1?
 ([2a02:908:1252:fb60:7284:dbdc:d72b:7ea1])
 by smtp.gmail.com with ESMTPSA id
 jw12-20020a17090776ac00b006e87137194esm3506483ejc.150.2022.04.25.03.52.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Apr 2022 03:52:03 -0700 (PDT)
Message-ID: <f4b9dc03-2d2c-28f6-fe72-7bf0e6bcf203@gmail.com>
Date: Mon, 25 Apr 2022 12:52:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] Fix out-of-bound access for gfx_v10_0_ring_test_ib()
Content-Language: en-US
To: Haohui Mai <ricetons@gmail.com>, amd-gfx@lists.freedesktop.org
References: <CAHpOOhHucS2QJSW3-jyGg8v8AMoCp2nV0h7T2rL_TQf6EHRvaA@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CAHpOOhHucS2QJSW3-jyGg8v8AMoCp2nV0h7T2rL_TQf6EHRvaA@mail.gmail.com>
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
Cc: emily.deng@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 25.04.22 um 10:56 schrieb Haohui Mai:
> The gfx_v10_0_ring_test_ib() function uses 20 bytes instead of 16
> bytes during the test. The patch sets the size of the allocation to be
> 4-byte larger to match the actual usage.
>
> Signed-off-by: Haohui Mai <ricetons@gmail.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 9426e252d8aa..b131235826b1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -3830,7 +3830,7 @@ static int gfx_v10_0_ring_test_ib(struct
> amdgpu_ring *ring, long timeout)
>          gpu_addr = adev->wb.gpu_addr + (index * 4);
>          adev->wb.wb[index] = cpu_to_le32(0xCAFEDEAD);
>          memset(&ib, 0, sizeof(ib));
> -       r = amdgpu_ib_get(adev, NULL, 16,
> +       r = amdgpu_ib_get(adev, NULL, 20,
>                                          AMDGPU_IB_POOL_DIRECT, &ib);

Good catch, but while at it please fix the coding style and move the 
"AMDGPU_IB_POOL_DIRECT, &ib);" on the same line as well.

With that done, the patch is Reviewed-by: Christian König 
<christian.koenig@amd.com>

>          if (r)
>                  goto err1;
> --
> 2.25.1

