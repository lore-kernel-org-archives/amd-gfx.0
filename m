Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76C78C761A6
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 11:23:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDE5810EDCB;
	Thu, 30 Mar 2023 11:22:59 +0000 (UTC)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FF6110EDCB
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 11:22:58 +0000 (UTC)
Received: by mail-ed1-x532.google.com with SMTP id eg48so74942869edb.13
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 04:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1680175376;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=H+9agMMJ/uRIpaZb5Lw46EgNOhB9l2q8VGvLzu9iJnw=;
 b=AXLJ1AGt8+Hp57aoGppiIJufXmo+GfYsp3vKO2ONBRowMoOgLx9fwEnEqP7WgIjhnE
 3zmyWgtFmpyOg92pIz9XzJHkW0jVjJn6CUiLItrOKQkxU0Quk43cpuINDC2nGDWzQqP4
 dpCG3cURvuXYaOmbcq0PVCY+krL3AGJ76JLkeUSNIyKdXUigwRK3/92i27nuWcdjROTM
 AiQNB5QHVGh7dTa4x4LmunDnpy6FQEVULJaMCCXa2orGppGLm/Cf9d1R4WCl3Gl2RKBW
 eiWkYjHnIydQCJWNQmWANG24umGYQRSmHyo7JMTA3/ZTpzS4YJxHZ/MK6dUhgRcy4cWt
 njuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680175376;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=H+9agMMJ/uRIpaZb5Lw46EgNOhB9l2q8VGvLzu9iJnw=;
 b=HP1T/1ZBNZ0MmMjNgOZbaUnyF6UG2uODvFx9QYNSb0qt7eP+nAnGM1ef0ayOF7W+X/
 e3MPLGBgPWHHuIBNhxnvk4GTKh1Oby96sm3UePeGtBh7S5GFhEXROKQKBFuf0Bi3+WBX
 Bx5YISSJFn4M5EIsuY4ZhLaLzUvPU4pGoSdFMJ6HFXmT55KCORqrcEjFTctckzcDB0c7
 lafGYiBW7qvSGgJS/YQ5tlJTSDzsPURvzVI+fNnlV0Ep5MKRqYskPEmRQmdqogrgBLOJ
 THgNWIOKjI3GOBQSO7BgkS8gIhVF66wsUce29XfihRSQCH+59FszjNB7njVl0diwkEhi
 oH1w==
X-Gm-Message-State: AAQBX9cLis6NeJrnMb1BBt6as07aA4SEFwqJ33d0yPbFNZXz8NhNepff
 18sLMn7ImKED8R64b5RWKELK4ud/d8WRWA==
X-Google-Smtp-Source: AKy350Ymr+5q0d5ZVuLxiHlyZh5DnuSkdszSvYA69DhavO9upXb4vdeOAyVm+6xZW9lqa8TUwH2NjA==
X-Received: by 2002:a17:907:6d8d:b0:946:a14e:23a5 with SMTP id
 sb13-20020a1709076d8d00b00946a14e23a5mr12953238ejc.45.1680175376392; 
 Thu, 30 Mar 2023 04:22:56 -0700 (PDT)
Received: from [192.168.178.21] (p4fc2092b.dip0.t-ipconnect.de. [79.194.9.43])
 by smtp.gmail.com with ESMTPSA id
 e9-20020a17090681c900b008cf377e8795sm17615759ejx.199.2023.03.30.04.22.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Mar 2023 04:22:55 -0700 (PDT)
Message-ID: <b3e94b1c-1bac-0158-2210-a35dd9de86da@gmail.com>
Date: Thu, 30 Mar 2023 13:22:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 08/16] drm/amdgpu: initialize ttm for doorbells
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230329154753.1261-1-shashank.sharma@amd.com>
 <20230329154753.1261-9-shashank.sharma@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230329154753.1261-9-shashank.sharma@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Mukul Joshi <mukul.joshi@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Shashank Sharma <contactshashanksharma@gmail.com>,
 Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 29.03.23 um 17:47 schrieb Shashank Sharma:
> From: Shashank Sharma <contactshashanksharma@gmail.com>
>
> This patch initialzes the ttm resource manager for doorbells.
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 6f61491ef3dd..203d77a20507 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1858,6 +1858,14 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>   	DRM_INFO("amdgpu: %uM of GTT memory ready.\n",
>   		 (unsigned)(gtt_size / (1024 * 1024)));
>   
> +	/* Initiailize doorbell pool on PCI BAR */
> +	r = amdgpu_ttm_init_on_chip(adev, AMDGPU_PL_DOORBELL,
> +				    DIV_ROUND_UP(adev->doorbell.size, PAGE_SIZE));
> +	if (r) {
> +		DRM_ERROR("Failed initializing doorbell heap. \n");
> +		return r;
> +	}
> +
>   	/* Initialize preemptible memory pool */
>   	r = amdgpu_preempt_mgr_init(adev);
>   	if (r) {

