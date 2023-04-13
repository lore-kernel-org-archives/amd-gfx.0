Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50413C77B6E
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Apr 2023 10:59:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B712410EAB9;
	Thu, 13 Apr 2023 10:59:19 +0000 (UTC)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE6F710E083
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Apr 2023 10:59:16 +0000 (UTC)
Received: by mail-ej1-x636.google.com with SMTP id dm2so36482112ejc.8
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Apr 2023 03:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1681383555; x=1683975555;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EvKk2RBVb5AI+B19eRV4OEivsOx9Uok7pLSN6QQxi44=;
 b=iLCn5ZpaOsbs/fv6PRJ0KJlYp8DHomgxt3wJ/4YXZfn7nYSeM/vWUQMYQF258COBZ2
 hjCRMHur7KMitk3zgPPqKAOmYBKfwII/O6zQyh870n9kAajRXstulNWrDg6mOUgYRkIJ
 co8Y1/mdfT9NM3g/llT/baEZ5ZzMHzqoGq6o6kyzSGTX/wQJgTYNNy2ZzT3rmvgkzmhk
 1zvwdmGFUaVwJse9jw6T0XJLw3CTqVyQomaqY+uNEyhmLvi4SEEaN9jsd0P3Prvb5hiH
 dmkrSDFg1LAp56W26+ohr2QsXdI/LDpfqWA4B3mpnO7YdpNFnJbHZUqCeVGSnJjN5/HK
 RZew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1681383555; x=1683975555;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EvKk2RBVb5AI+B19eRV4OEivsOx9Uok7pLSN6QQxi44=;
 b=MWF7QsQpS2NA2nQ33FUKPNk8r8KDA8Zch90sZiINr35/OrsKEBovUW6c076EDlvU0j
 2SmZNnA63g7YYcp+uhE9WQRb08f9loXUW2x41D4N0k3efNUW5mReKhjk+iqZAu1QrE4S
 79q06pDqOy2RT4DhvgqBTl6g4IzRzfzbr/HywJxIZh7fBklTnKE5pYWSjkg60OgLHocQ
 sUU1gaUMtU4hg2GM/AhSnt25k1QDRsudStQKHtG63AKUie15p+PvAtMnxivL7KwpiHjx
 Cyd/dbQxd+ywcE8tuy+EZnEsifQtxZ04W63bqUayhLjagfqw6WjMw+uitYNAn8b7UGLV
 bp7A==
X-Gm-Message-State: AAQBX9fTIGAU0LOLMLB3CLSZYVFMHSaKVmf0o5ySew8wgkS2BEV1FCZP
 JrtA91+LpJpBvCepvsCvo34=
X-Google-Smtp-Source: AKy350aM8qZGPGp0FrWlxsO4bNAHg9uzYjTUOp/4FReXnopaWquwigpka7tHTb6pBKvHE34uii5osw==
X-Received: by 2002:a17:907:7896:b0:94a:84fe:acff with SMTP id
 ku22-20020a170907789600b0094a84feacffmr2425006ejc.21.1681383554717; 
 Thu, 13 Apr 2023 03:59:14 -0700 (PDT)
Received: from [192.168.178.21] (p4fc2092b.dip0.t-ipconnect.de. [79.194.9.43])
 by smtp.gmail.com with ESMTPSA id
 s5-20020a170906168500b0094d69608f5fsm811986ejd.97.2023.04.13.03.59.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Apr 2023 03:59:14 -0700 (PDT)
Message-ID: <8d3b24e5-cef5-608a-3110-456bc2967360@gmail.com>
Date: Thu, 13 Apr 2023 12:59:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 07/12] get absolute offset from doorbell index
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230412162537.1357-1-shashank.sharma@amd.com>
 <20230412162537.1357-8-shashank.sharma@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230412162537.1357-8-shashank.sharma@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, mukul.joshi@amd.com,
 contactshashanksharma@gmail.com, Christian Koenig <christian.koenig@amd.com>,
 arvind.yadav@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 12.04.23 um 18:25 schrieb Shashank Sharma:
> This patch adds a helper function which converts a doorbell's
> relative index in a BO to an absolute doorbell offset in the
> doorbell BAR.
>
> V2: No space between the variable name doc (Luben)
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h  |  3 +++
>   .../gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c  | 21 +++++++++++++++++++
>   2 files changed, 24 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
> index fbbff12a14cd..b110e002bad2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
> @@ -317,6 +317,9 @@ void amdgpu_mm_wdoorbell64(struct amdgpu_device *adev, u32 index, u64 v);
>   int amdgpu_doorbell_init(struct amdgpu_device *adev);
>   void amdgpu_doorbell_fini(struct amdgpu_device *adev);
>   int amdgpu_doorbell_create_kernel_doorbells(struct amdgpu_device *adev);
> +uint32_t amdgpu_doorbell_index_on_bar(struct amdgpu_device *adev,
> +				       struct amdgpu_bo *db_bo,
> +				       uint32_t doorbell_index);
>   
>   #define RDOORBELL32(index) amdgpu_mm_rdoorbell(adev, (index))
>   #define WDOORBELL32(index, v) amdgpu_mm_wdoorbell(adev, (index), (v))
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
> index 8be2dfa8fa74..a99cd56e8bf4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
> @@ -108,6 +108,27 @@ void amdgpu_mm_wdoorbell64(struct amdgpu_device *adev, u32 index, u64 v)
>   		DRM_ERROR("writing beyond doorbell aperture: 0x%08x!\n", index);
>   }
>   
> +/**
> + * amdgpu_doorbell_index_on_bar - Find doorbell's absolute offset in BAR
> + *
> + * @adev: amdgpu_device pointer
> + * @db_bo: doorbell object's bo
> + * @db_index: doorbell relative index in this doorbell object
> + *
> + * returns doorbell's absolute index in BAR
> + */
> +uint32_t amdgpu_doorbell_index_on_bar(struct amdgpu_device *adev,
> +				       struct amdgpu_bo *db_bo,
> +				       uint32_t doorbell_index)
> +{
> +	int db_bo_offset;
> +
> +	db_bo_offset = amdgpu_bo_gpu_offset_no_check(db_bo);
> +
> +	/* doorbell index is 32 bit but doorbell's size is 64-bit, so *2 */
> +	return db_bo_offset / sizeof(u32) + doorbell_index * 2;
> +}
> +
>   /**
>    * amdgpu_doorbell_create_kernel_doorbells - Create kernel doorbells for graphics
>    *

