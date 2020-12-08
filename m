Return-Path: <SRS0=uNpP=FM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A319FC4361B
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 17:39:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5770B23B32
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 17:39:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5770B23B32
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 095F189AB7;
	Tue,  8 Dec 2020 17:39:34 +0000 (UTC)
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com
 [IPv6:2a00:1450:4864:20::642])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EFCA88584
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Dec 2020 17:39:33 +0000 (UTC)
Received: by mail-ej1-x642.google.com with SMTP id qw4so25728811ejb.12
 for <amd-gfx@lists.freedesktop.org>; Tue, 08 Dec 2020 09:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=pWuGQFvXBwMVIGk2mv19MmKLPhKKL4e9PmkK+C3BpSo=;
 b=g/kFsEhD/0wZ35yDEQHV8UHmUMyD0Bn3eoKhg3YHPii8Eb3ErYf1TTb0x0ouBXKsyY
 p3OFF2+QmNiLFSxVdPn4XfhwO7QjnBLFn0pK3EIQPSp0sPqBiPkpuJLVG+W4fGuIXOOo
 ICa+M+Efy1WOc7eBLiVnVRoRe3YIXxBpXpFk8qf/7dtNw0Vky1x47zh8SPNdclPG3ZlB
 LKkK4uGbyjXAq8Qk/rjY8Sf2SNvo3GGRZ1g7CDho1UpmQi6jNT8ChzH7HdKhszXk15f6
 Yd9XjvqtUDtVusWQgmm7S8t8mUCne4/2tPuumEKbniXg1NgerGVuL7gX+i071VTaIdln
 8XPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=pWuGQFvXBwMVIGk2mv19MmKLPhKKL4e9PmkK+C3BpSo=;
 b=Z7MopQPqCnkFb3q1aiudKbxYEHSWKtfaa7sOMsMVthKZ/uMGIV/1FI8FaMcnFPjXzE
 FIELDYj5iCyPMYkqOk4eHdJTjQC7oKdC/hlrPSkig3tYbqQORz4TJO01QaWqPARSd8Qs
 jJPQ3j2gdWp5YLSLbJu4C4wcTMQgDXx2DneY1mnl52lMGpUCyQr0T0/6fdKkXbBcmH2P
 hGe3Ff1qNkjjxYP6CxvoLQCo3ZNgwIUkZIFFCubNWWe9a4IS8F1CCKozoGbNwtBUxoYz
 eDK4Kx+k3KVywBPyCqqXR8dV0y/12557t2+dUyJR9iVnZHpLN9zPBqYaT4bXS2pdbAD2
 Blbg==
X-Gm-Message-State: AOAM5303S5c4DGHpE8KYgtmqnvvMXIce2Kwo/PUIfzY8jv17YfmVgt48
 nKiBP+WOyyxlol1B3XRqCnk=
X-Google-Smtp-Source: ABdhPJwN4/Nwd2xUHmE9s88W2FLRJZlLXjSTzGv2vmz9y4UIFo8m4oWfHIsCyIb2m2aqz/eEpLkCdA==
X-Received: by 2002:a17:907:c15:: with SMTP id
 ga21mr18749024ejc.472.1607449171826; 
 Tue, 08 Dec 2020 09:39:31 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id n1sm15995529ejb.2.2020.12.08.09.39.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Dec 2020 09:39:31 -0800 (PST)
Subject: Re: [PATCH 1/1] drm/amdgpu: clean up bo in vce and vcn test
To: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
References: <20201208155508.6036-1-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <772be2aa-56f0-14d5-3de4-343c556e1dc2@gmail.com>
Date: Tue, 8 Dec 2020 18:39:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201208155508.6036-1-nirmoy.das@amd.com>
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
Reply-To: christian.koenig@amd.com
Cc: alexander.deucher@amd.com, Christian.Koenig@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 08.12.20 um 16:55 schrieb Nirmoy Das:
> BO created with amdgpu_bo_create_reserved wasn't clean
> properly before which causes:

I would rather like to keep the code as it is and just replace the 
amdgpu_bo_unref() with amdgpu_bo_free_kernel().

But apart from that I think we can stick with this.

Christian.

>
> [   21.056218] WARNING: CPU: 0 PID: 7 at drivers/gpu/drm/ttm/ttm_bo.c:518 ttm_bo_release+0x2bf/0x310 [ttm]
> <snip>
> [   21.056430] Call Trace:
> [   21.056525]  amdgpu_bo_unref+0x1a/0x30 [amdgpu]
> [   21.056635]  amdgpu_vcn_dec_send_msg+0x1b2/0x270 [amdgpu]
> [   21.056740]  amdgpu_vcn_dec_get_create_msg.constprop.0+0xd8/0x100 [amdgpu]
> [   21.056843]  amdgpu_vcn_dec_ring_test_ib+0x27/0x180 [amdgpu]
> [   21.056936]  amdgpu_ib_ring_tests+0xf1/0x150 [amdgpu]
> [   21.057024]  amdgpu_device_delayed_init_work_handler+0x11/0x30 [amdgpu]
> [   21.057030]  process_one_work+0x1df/0x370
> [   21.057033]  worker_thread+0x46/0x340
> [   21.057034]  ? process_one_work+0x370/0x370
> [   21.057037]  kthread+0x11b/0x140
> [   21.057039]  ? __kthread_bind_mask+0x60/0x60
> [   21.057043]  ret_from_fork+0x22/0x30
>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 16 ++++++++++------
>   2 files changed, 11 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> index ecaa2d7483b2..78a4dd9bf11f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> @@ -1151,6 +1151,6 @@ int amdgpu_vce_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>   error:
>   	dma_fence_put(fence);
>   	amdgpu_bo_unreserve(bo);
> -	amdgpu_bo_unref(&bo);
> +	amdgpu_bo_free_kernel(&bo, NULL, NULL);
>   	return r;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index 7e19a6656715..dfcdd38ff9c2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -491,8 +491,6 @@ static int amdgpu_vcn_dec_send_msg(struct amdgpu_ring *ring,
>   		goto err_free;
>   
>   	amdgpu_bo_fence(bo, f, false);
> -	amdgpu_bo_unreserve(bo);
> -	amdgpu_bo_unref(&bo);
>   
>   	if (fence)
>   		*fence = dma_fence_get(f);
> @@ -504,8 +502,6 @@ static int amdgpu_vcn_dec_send_msg(struct amdgpu_ring *ring,
>   	amdgpu_job_free(job);
>   
>   err:
> -	amdgpu_bo_unreserve(bo);
> -	amdgpu_bo_unref(&bo);
>   	return r;
>   }
>   
> @@ -540,7 +536,11 @@ static int amdgpu_vcn_dec_get_create_msg(struct amdgpu_ring *ring, uint32_t hand
>   	for (i = 14; i < 1024; ++i)
>   		msg[i] = cpu_to_le32(0x0);
>   
> -	return amdgpu_vcn_dec_send_msg(ring, bo, fence);
> +	r = amdgpu_vcn_dec_send_msg(ring, bo, fence);
> +	amdgpu_bo_unreserve(bo);
> +	amdgpu_bo_free_kernel(&bo, NULL, (void **)&msg);
> +
> +	return r;
>   }
>   
>   static int amdgpu_vcn_dec_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handle,
> @@ -566,7 +566,11 @@ static int amdgpu_vcn_dec_get_destroy_msg(struct amdgpu_ring *ring, uint32_t han
>   	for (i = 6; i < 1024; ++i)
>   		msg[i] = cpu_to_le32(0x0);
>   
> -	return amdgpu_vcn_dec_send_msg(ring, bo, fence);
> +	r = amdgpu_vcn_dec_send_msg(ring, bo, fence);
> +	amdgpu_bo_unreserve(bo);
> +	amdgpu_bo_free_kernel(&bo, NULL, (void **)&msg);
> +
> +	return r;
>   }
>   
>   int amdgpu_vcn_dec_ring_test_ib(struct amdgpu_ring *ring, long timeout)

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
