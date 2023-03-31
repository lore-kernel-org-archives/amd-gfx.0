Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1106AC77B60
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Mar 2023 06:19:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A8E410F0F1;
	Fri, 31 Mar 2023 06:19:10 +0000 (UTC)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B89CE10E323
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Mar 2023 06:19:07 +0000 (UTC)
Received: by mail-ed1-x530.google.com with SMTP id x3so85499843edb.10
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 23:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1680243546;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fpgKrq1Mw1wvOtEFjYWcYecq/wdw/z6shx9NC48gC9E=;
 b=Jl8+M5yq4aeZ5Qu9GEsJ+7iek19Tieu1zpLiPTW2/8MsQ/Nj6a8lBSvxqyHmthawju
 pUr9q68tDYKhNifR3e7iCt2AsAz9IsShcvaQolyl88DEk/DqoxbplcIqD/V504y1qnKF
 GvpSvAqJ/Z3avnNvBAmmuIU16NJ8CEi5fdMUnc1ImtoFC+K5z/Q+Qiv28VwdB22KOXZ6
 DZjnsCyMjY8sWuDCfKmAHtCZvaNmi2EzuB/xR2PfUx+YmzfNnG2JtcpmSrjt1yZExAjn
 GRTjs1PIRbPvVx8qndbbzDGa95RInD9LqKC5wTGmPYeX9DP20+qlTjKMIYXrLFFNlmcc
 xmYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680243546;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fpgKrq1Mw1wvOtEFjYWcYecq/wdw/z6shx9NC48gC9E=;
 b=3lAGr/3rM8MchUXFzN1z5inh3uzNDHzmefhOgk+0otrtlSX2V8V+Fjbu3X4dOw0RPt
 TE2BqHoUVMX+EJibqZvxVl4WXXrEmp61d6yGG+mmFS6hH/LDP+UNYzeg4pfGGUglmpxh
 2B3Sd1g0FqmV0RDoJC6YWadSPSBNxjSD6Ku6PGEyLHigubIhUoqf5SfyhijrYihaboBZ
 EHgoKSvQrB2dgyY9iW2sA+jGWavzgRhh0uylY/QLsvuRilgsoG3Bmr8hMJ7gYHkJzlEq
 l2vK2mBzB2Bq6XKgIcabNoDkBVmtEPREIt1xsTVtUBCZ803xwt2AoYyak39TDyi/+Z9x
 mBpg==
X-Gm-Message-State: AAQBX9fNjDlBLM5NIfS9kV/h6uQWMk1sm9os40PEVavgQAzHdhRVzstW
 grAf3qnjK67j9HL9b9orI8bhLDei55eVPQ==
X-Google-Smtp-Source: AKy350a/tuKZr8XRNRrZmdqTPdlVw6aIwi2+2mwDL2EddiIrhJ9w3op7FXl4Ev1/kaNRV3utfb+FdA==
X-Received: by 2002:a17:906:641:b0:933:9f43:5c3b with SMTP id
 t1-20020a170906064100b009339f435c3bmr27234310ejb.59.1680243545946; 
 Thu, 30 Mar 2023 23:19:05 -0700 (PDT)
Received: from [192.168.178.21] (p4fc2092b.dip0.t-ipconnect.de. [79.194.9.43])
 by smtp.gmail.com with ESMTPSA id
 q20-20020a170906541400b009442efdaf20sm605675ejo.156.2023.03.30.23.19.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Mar 2023 23:19:05 -0700 (PDT)
Message-ID: <1383ca0d-6863-f40d-596e-db7d6ae6a572@gmail.com>
Date: Fri, 31 Mar 2023 08:19:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/8] drm/amdgpu: increase AMDGPU_MAX_HWIP_RINGS
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230330194843.1136162-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230330194843.1136162-1-alexander.deucher@amd.com>
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
Cc: James Zhu <James.Zhu@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



Am 30.03.23 um 21:48 schrieb Alex Deucher:
> From: James Zhu <James.Zhu@amd.com>
>
> [WA] Increase AMDGPU_MAX_HWIP_RINGS to 64 to support more compute
> ring resource. Later need redesign with queue/prirority/scheduler
> factors to reduce AMDGPU_MAX_HWIP_RINGS.

This is just a workaround for internal use and not meant for upstreaming.

The array is used for the load balancing between scheduler instances. 
Since we don't want to load balance between different partitions we 
should not need to increase this.

Christian.


>
> Signed-off-by: James Zhu <James.Zhu@amd.com>
> Acked-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index 1f40c0bfb33f..244562ce735c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -37,7 +37,7 @@ struct amdgpu_vm;
>   
>   /* max number of rings */
>   #define AMDGPU_MAX_RINGS		102
> -#define AMDGPU_MAX_HWIP_RINGS		32
> +#define AMDGPU_MAX_HWIP_RINGS		64
>   #define AMDGPU_MAX_GFX_RINGS		2
>   #define AMDGPU_MAX_SW_GFX_RINGS         2
>   #define AMDGPU_MAX_COMPUTE_RINGS	8

