Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 034D9C77B75
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Apr 2023 09:44:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5762C10EDD9;
	Fri, 21 Apr 2023 09:44:26 +0000 (UTC)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B323D10EDD9
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Apr 2023 09:44:23 +0000 (UTC)
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-94ef8b88a5bso190946066b.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Apr 2023 02:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1682070262; x=1684662262;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=U3VhjEsI5nvLfnnswuRG/fw21EH+6MHHARQt0ZC1zHw=;
 b=C5FRBy+8EeuO37V+Mx3vc90qXOVG5Y8Ty7KwD0bdkDOZJKVehGgF0fV9QGUDxaj2Qp
 PPcBNbOI8klNA721fOZHGH5cxuElNBXYdsp37i+1aNbYe8tqv1IXJhsBdsq2Iif3MgnO
 PsjCMoeBIe0Sxu2LKJFXR/n1D7rOPl3YdwXoya23E5YSG1V7Pi4wk+2kJjLVA5ELOqxr
 p0wQpGss3gbJFdDdQ35XVgeyyTh/WNIro6IsHHLhdzdXdkGQbBSSdmhQXkDqKStQ1v8S
 UXq5YrRyyY+lnkgbAAeLjgpgrey94YwkA6fpK1c7krW/KC/6EnM8CusmPjk4WKcwOW+B
 NUEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682070262; x=1684662262;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=U3VhjEsI5nvLfnnswuRG/fw21EH+6MHHARQt0ZC1zHw=;
 b=dolfTV/rwcDxgFBy4S8bfxYb4KmP8JKvUOlDNS2hqyzF2icSjpKHDNADAq5xjCU4Qd
 YosL7ZFSOkf3KatJkYK9ZCh9bnZVekKHLccZn+KyJyrJN68jjwLfxFtnW/Fm6koezIsi
 EVs2Ibl20M9MUAVAN3HQOjCpH45RdeKZwSFkdM7+g7yO3ZlGB+I96IWTjjytHh6Sxg0r
 uHRxvI+HfDnVJGAqPfzZvvmTQBRg2mC6NQnYnUCkh+LLi88l6F/o+68a3AyFkFbslJW9
 sLZ536GUBsEPIKm61NItYAFC8wVR3C2Qqe+OVOGgYhtZNhPtQ4RBaCKmKDIBiyYi/sir
 7CRg==
X-Gm-Message-State: AAQBX9fitR2RHm7KJSqbtgwdkLMDjOXHcSJEWdTruMQRG2Zp7A/VXbxb
 RULGNFFcTM2XC69bu/1fYbs=
X-Google-Smtp-Source: AKy350aQ5cRF/n9lp/Qx1agBfNMZCXUabm/EcYBLfZV27FaTQFm9qap66RgSZbLCVPEfZNas0ruZwg==
X-Received: by 2002:a17:907:3ac3:b0:94e:70bb:5f8a with SMTP id
 fi3-20020a1709073ac300b0094e70bb5f8amr1404047ejc.66.1682070261719; 
 Fri, 21 Apr 2023 02:44:21 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:b9f1:4015:2594:f62d?
 ([2a02:908:1256:79a0:b9f1:4015:2594:f62d])
 by smtp.gmail.com with ESMTPSA id
 fp31-20020a1709069e1f00b0095251a3d66fsm1814060ejc.119.2023.04.21.02.44.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Apr 2023 02:44:21 -0700 (PDT)
Message-ID: <8b500681-f108-5413-50e3-37c0f0eaee9b@gmail.com>
Date: Fri, 21 Apr 2023 11:44:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] drm/amdgpu: fix memory leak in mes self test
Content-Language: en-US
To: Jack Xiao <Jack.Xiao@amd.com>, amd-gfx@lists.freedesktop.org,
 Hawking.Zhang@amd.com
References: <20230421070613.3820348-1-Jack.Xiao@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230421070613.3820348-1-Jack.Xiao@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Am 21.04.23 um 09:06 schrieb Jack Xiao:
> The fences associated with mes queue have to be freed
> up during amdgpu_ring_fini.
>
> Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>

Well big NAK to this! The fences are supposed to be freed by the fence 
handling code.

Christian.

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> index dc474b809604..4a35cee4cb83 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -361,6 +361,8 @@ void amdgpu_ring_fini(struct amdgpu_ring *ring)
>   		amdgpu_bo_free_kernel(&ring->ring_obj,
>   				      &ring->gpu_addr,
>   				      (void **)&ring->ring);
> +	} else {
> +		kfree(ring->fence_drv.fences);
>   	}
>   
>   	dma_fence_put(ring->vmid_wait);

