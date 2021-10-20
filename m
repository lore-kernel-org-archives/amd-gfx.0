Return-Path: <SRS0=xYMq=PI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 338E5C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Oct 2021 11:50:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E450760EE9
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Oct 2021 11:50:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E450760EE9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88C1C6E24E;
	Wed, 20 Oct 2021 11:50:33 +0000 (UTC)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F9396E24E
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Oct 2021 11:50:32 +0000 (UTC)
Received: by mail-wm1-x32a.google.com with SMTP id
 g79-20020a1c2052000000b00323023159e1so1008703wmg.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Oct 2021 04:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=TfevqN0xZtn8VU5G53faDpDWDXZDK73PW8UIpKt5xOs=;
 b=F5tMAli/o6IJgCytIiQ+YpB3I7GLHeoCiTO+RpgKgR5T3TYb6Nev62ugOHXkjr263m
 iD7vuWXf1hLNKiPOZ6kuksTLIL+tNYLC83bqZRVC2iHNnxR3+cMAePaAisKN2Tqgmq4s
 dTR7NX8qcWYkKm1z2X9y/arjUq9+xlEAAX99UlocZ3cs924haoJQSEhnGAcpjiwtP1T4
 bP+z79AGEafHckMWLAYXU34xb2ifD3Av/r8ksCV9KO+HjCDSuVaLuen7R3vupkafkYGr
 kJmUzuVM5zfZAHNqzyu3+Kx7a9FiQ4va2txmrsgWAQ2DxD+WqNY5+orCxSDmixd9FdbU
 muQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=TfevqN0xZtn8VU5G53faDpDWDXZDK73PW8UIpKt5xOs=;
 b=KfbIV0eaEONQAn6me8BuFKhY4NJUs4pXVD+2Hup2qusOSGTx+jay+cyX9skDLQIoYB
 cB1M+bdLfnsK71mqtAAfVyu8tUwfDsSG4SwrN73B0PjEHOLsoLD4IsyMpdPSouD+UEsv
 tv5+Lgc1JsC2z1W2bY3dvjE9Tq8FYELRQ4KykyernMCyNJqT7lDOLRoqBl2QXgSGKS18
 ujfqm67JRyqg8oPNK6J3fw1tnK3cQcFpwy1olroKg3wXid4q1CTvdSPwZfwjQfpw0NyR
 LCThSe5q6WaUpNuqnD5gCcSOw0v3a6d6wjKHVE4mK5IsrNFzhL5hIfLEHIY30CsFs0JW
 udsw==
X-Gm-Message-State: AOAM532T07Vys68AS9HXpcTe0jqk6fIzq8i0yIDTnBHzWerhiL6N6J8b
 v0Ablv1xdj2VFxXo6dVSeIU=
X-Google-Smtp-Source: ABdhPJyAMvJnLkkMiZudWJzB0myHDuj00Pc7WZ7LbG5WZxGFgtLGmc+HfKLghmEIQeX82ui0dVMPbw==
X-Received: by 2002:a05:600c:19d0:: with SMTP id
 u16mr12949591wmq.154.1634730630500; 
 Wed, 20 Oct 2021 04:50:30 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:6048:8836:7968:5df6?
 ([2a02:908:1252:fb60:6048:8836:7968:5df6])
 by smtp.gmail.com with ESMTPSA id 10sm5591127wme.27.2021.10.20.04.50.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Oct 2021 04:50:29 -0700 (PDT)
Subject: Re: [PATCH 1/1] drm/amdgpu: fix BO leak after successful move test
To: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Christian.Koenig@amd.com, Alexander.Deucher@amd.com,
 zhang <botton_zhang@163.com>
References: <20211012121018.81693-1-nirmoy.das@amd.com>
 <20211013150902.6646-1-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <7f990838-a3e3-333e-3237-09f4595ee452@gmail.com>
Date: Wed, 20 Oct 2021 13:50:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211013150902.6646-1-nirmoy.das@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
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



Am 13.10.21 um 17:09 schrieb Nirmoy Das:
> GTT BO cleanup code is with in the test for loop and
> we would skip cleaning up GTT BO on success.
>
> Reported-by: zhang <botton_zhang@163.com>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_test.c | 25 ++++++++++++------------
>   1 file changed, 12 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_test.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_test.c
> index 909d830b513e..5fe7ff680c29 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_test.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_test.c
> @@ -35,6 +35,7 @@ static void amdgpu_do_test_moves(struct amdgpu_device *adev)
>   	struct amdgpu_bo *vram_obj = NULL;
>   	struct amdgpu_bo **gtt_obj = NULL;
>   	struct amdgpu_bo_param bp;
> +	struct dma_fence *fence = NULL;
>   	uint64_t gart_addr, vram_addr;
>   	unsigned n, size;
>   	int i, r;
> @@ -82,7 +83,6 @@ static void amdgpu_do_test_moves(struct amdgpu_device *adev)
>   		void *gtt_map, *vram_map;
>   		void **gart_start, **gart_end;
>   		void **vram_start, **vram_end;
> -		struct dma_fence *fence = NULL;
>   
>   		bp.domain = AMDGPU_GEM_DOMAIN_GTT;
>   		r = amdgpu_bo_create(adev, &bp, gtt_obj + i);
> @@ -212,24 +212,23 @@ static void amdgpu_do_test_moves(struct amdgpu_device *adev)
>   
>   		DRM_INFO("Tested GTT->VRAM and VRAM->GTT copy for GTT offset 0x%llx\n",
>   			 gart_addr - adev->gmc.gart_start);
> -		continue;
> +	}
>   
> +	--i;
>   out_lclean_unpin:
> -		amdgpu_bo_unpin(gtt_obj[i]);
> +	amdgpu_bo_unpin(gtt_obj[i]);
>   out_lclean_unres:
> -		amdgpu_bo_unreserve(gtt_obj[i]);
> +	amdgpu_bo_unreserve(gtt_obj[i]);
>   out_lclean_unref:
> -		amdgpu_bo_unref(&gtt_obj[i]);
> +	amdgpu_bo_unref(&gtt_obj[i]);
>   out_lclean:
> -		for (--i; i >= 0; --i) {
> -			amdgpu_bo_unpin(gtt_obj[i]);
> -			amdgpu_bo_unreserve(gtt_obj[i]);
> -			amdgpu_bo_unref(&gtt_obj[i]);
> -		}
> -		if (fence)
> -			dma_fence_put(fence);
> -		break;
> +	for (--i; i >= 0; --i) {

The usual idiom for cleanups like that is "while (i--)..." because that 
also works with an unsigned i.

Apart from that looks good to me.

Christian.

> +		amdgpu_bo_unpin(gtt_obj[i]);
> +		amdgpu_bo_unreserve(gtt_obj[i]);
> +		amdgpu_bo_unref(&gtt_obj[i]);
>   	}
> +	if (fence)
> +		dma_fence_put(fence);
>   
>   	amdgpu_bo_unpin(vram_obj);
>   out_unres:

