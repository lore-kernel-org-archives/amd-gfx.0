Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F6FAC43458
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jul 2026 14:48:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE99510F16B;
	Wed,  8 Jul 2026 14:48:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="r2pRzYV2";
	dkim-atps=neutral
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com
 [209.85.160.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2CCA10F167
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jul 2026 14:48:09 +0000 (UTC)
Received: by mail-qt1-f182.google.com with SMTP id
 d75a77b69052e-51c0a81d286so10860231cf.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 08 Jul 2026 07:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783522089; x=1784126889; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=leQfIJHrdLYfs/b1smMAK/3gm3XKStN/0sSrRwEZGAE=;
 b=r2pRzYV2w50NFuLMbrk2AvLEifa7tpg6XIEAt+7kq//ouJQs21q94W5yVh2RysqYej
 QLBbAXqqElBxCKZ5+cj+a7LyMBtD+/ZQ/3JM4wDGgGEQQew8S7zfk8Mjq9/LyyCKwQJt
 e1hqxFOq7eDtyso/0xx8Y81WdKk4uAjtw+YdPhUUZ1BL0M5LTtpNVg0xSQwzfYjaASQG
 ZuvxmlnLPILeFaqiRAs44BFp6sR4WHeXo4sisMsD/tprMsneMUBBOAuXXwIhjiwyNuZm
 jJlpqQ+fvXbYeT+dfl2XQkNR1xwfN+TkoFl/m3OXoaMU/6LdlBCQzvlKbCyeL64ua6il
 C2hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783522089; x=1784126889;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=leQfIJHrdLYfs/b1smMAK/3gm3XKStN/0sSrRwEZGAE=;
 b=ZrtPuStJSihc0I8WfiZNL+Zr6qr5AjDbRD17P3zUsYzBKAmRds36eqtOaNyfouqJCo
 l4DoVAnOn4GWIkB05YWOkEqEnJ/XA48rTKD+iJcNw0JacOVsZMqSObvhDbSAvi1cX2fl
 v9tPiKm6V6nyMZvfpCV82bg04F8Ixi3pFvUMMEarCHaUwB759QvLoClF5en5+Wj7TYre
 RsE3EfX2wzjgwWfbV6Acc14QXksrk+zibpWhhj/wQTBgiiAKQUZulyQl0IggzEEiXFBu
 5KPKJyrIexkmkx80fd4cKHva/KYCMGgz10IygXXd8bsQa5FvdVceX7/O9X+Giovt5XyA
 PA+g==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr3S/2dfe95PNbKuyvDhpSxcpNDqcxMEtOtG3Vf6L+OHdeUkVdD2t3kNPB6i0mHE54lpTun1KQo@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwecJRBAAbzwqJCctzMTs+YBAvbbw3la0IlNzQDucgjEvfHfn6t
 QOwufEEWV+PZ0sVqmA+WGwwdTXsZdn+8MQSuxEIpTwZQT+lGQpmGVbDa
X-Gm-Gg: AfdE7cl2c+s+1aovXAWTILSjk/DoN7rKWu884gUExfVD4DFf6VMW10wmH4+8Seb4Edg
 cm/w7JlYWhW9fKWyMBKtktuBUtL5hFokrKPFVLwp3VIfn6hvZUxKl70QLmev0CJzMsdD3yYfgJc
 G7xlZwkMeY7Wxh0ybfCjE0Njap8WZ61WPhJvkEx+WU1M/IkKRqjBQRUYw5EKAx9/D4vzw8qzyII
 5Nwkt81jdWtC5TyCjm3yJh2GJ17flGEmrYDCNpw281KgmDQehB1X/+9hyy60Q2zjkjiP2a8JkZj
 kTjgYcrweNa24MQAhrZOeVAnrmluCzdjh96ye4c0QgACjj/YIy+n50zOQkni1aIZMPdTLxxOGda
 91uasIqWE9+e9LSMcz4Lqa5aqQLo3v8Uqx3L5gdypcotjr5670aE95ZfKKYxcyYnynkZC0v7Miv
 WIPQHKYC4FJR7Mr+Z9RTBV3LX3GjUgL8g=
X-Received: by 2002:a05:622a:4005:b0:516:e0e7:6e42 with SMTP id
 d75a77b69052e-51c7a4a9984mr79094551cf.13.1783522088757; 
 Wed, 08 Jul 2026 07:48:08 -0700 (PDT)
Received: from [192.168.1.100] ([32.219.225.223])
 by smtp.googlemail.com with ESMTPSA id
 6a1803df08f44-8f471de9a33sm200435266d6.36.2026.07.08.07.48.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jul 2026 07:48:08 -0700 (PDT)
Message-ID: <58c2249d-2bc1-4745-bce4-8e25ff769dfd@gmail.com>
Date: Wed, 8 Jul 2026 10:48:07 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/30] drm/amdgpu/mes11: drop all BUG()s
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20260707154203.2603209-1-alexander.deucher@amd.com>
 <20260707154203.2603209-15-alexander.deucher@amd.com>
Content-Language: en-US
From: John Olender <john.olender@gmail.com>
In-Reply-To: <20260707154203.2603209-15-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
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

On 7/7/26 11:41 AM, Alex Deucher wrote:
> There's no need to crash the kernel for these cases.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> index 72ca7302bbfbc..ee5229ae3d75e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -86,7 +86,7 @@ static void mes_v11_0_ring_set_wptr(struct amdgpu_ring *ring)
>  			     ring->wptr);
>  		WDOORBELL64(ring->doorbell_index, ring->wptr);
>  	} else {
> -		BUG();
> +		dev_warn(adev->dev, "mes_v11_0_ring_set_wptr() requires doorbell!\n");

Per scripts/checkpatch.pl:

WARNING: Prefer using '"%s...", __func__' to using 'mes_v11_0_ring_set_wptr', this function's name, in a string

>  	}
>  }
>  
> @@ -97,12 +97,15 @@ static u64 mes_v11_0_ring_get_rptr(struct amdgpu_ring *ring)
>  
>  static u64 mes_v11_0_ring_get_wptr(struct amdgpu_ring *ring)
>  {
> +	struct amdgpu_device *adev = ring->adev;
>  	u64 wptr;
>  
> -	if (ring->use_doorbell)
> +	if (ring->use_doorbell) {
>  		wptr = atomic64_read((atomic64_t *)ring->wptr_cpu_addr);
> -	else
> -		BUG();
> +	} else {
> +		dev_warn(adev->dev, "mes_v11_0_ring_get_wptr() requires doorbell!\n");

See above.  Interestingly, scripts/checkpatch.pl doesn't catch this one.

There are additional prints like this in the series.

Thanks,
John

> +		wptr = 0;
> +	}
>  	return wptr;
>  }
>  
> @@ -294,7 +297,7 @@ static int convert_to_mes_queue_type(int queue_type)
>  	else if (queue_type == AMDGPU_RING_TYPE_SDMA)
>  		return MES_QUEUE_TYPE_SDMA;
>  	else
> -		BUG();
> +		WARN(1, "Invalid queue type %d\n", queue_type);
>  	return -1;
>  }
>  
> @@ -1544,7 +1547,7 @@ static int mes_v11_0_queue_init(struct amdgpu_device *adev,
>  	else if (pipe == AMDGPU_MES_SCHED_PIPE)
>  		ring = &adev->mes.ring[0];
>  	else
> -		BUG();
> +		WARN(1, "Invalid MES pipe %d\n", pipe);
>  
>  	if ((pipe == AMDGPU_MES_SCHED_PIPE) &&
>  	    (amdgpu_in_reset(adev) || adev->in_suspend)) {
> @@ -1627,7 +1630,7 @@ static int mes_v11_0_mqd_sw_init(struct amdgpu_device *adev,
>  	else if (pipe == AMDGPU_MES_SCHED_PIPE)
>  		ring = &adev->mes.ring[0];
>  	else
> -		BUG();
> +		return -EINVAL;
>  
>  	if (ring->mqd_obj)
>  		return 0;

