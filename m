Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 997C7C77B60
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Apr 2023 09:01:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3939710EC84;
	Fri, 28 Apr 2023 09:01:14 +0000 (UTC)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01AC110EC84
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Apr 2023 09:01:11 +0000 (UTC)
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-94a34a0b9e2so1443373566b.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Apr 2023 02:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1682672470; x=1685264470;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=InuKx0Hi/t1PfXRyGn1l+W28gO4cV3dUjASmDcsGYZg=;
 b=U6fpeNCPGDklfp0DzCuldh+tmoMVDyFv8ZlyWB/UGhrWVLHtMSzDPhH3LOfwAn0bP+
 eZ+2yKIsCtu3oS/AGTbumM5RB3JifeysmBw0oATfzwTeEPKThj+yqfkNyaqLTaHaio10
 HA48YD5u/k25qB820V/VEOXPZX6l2mR4G33eg0glYwBS/v+bzaD2Riw37fbqoevGUN4V
 sS9luFHXywP2r/gD0EWzq8zQStacbqCRNWK3WaK7/l6Dy1PsrCBV7NM1r7vz5dE/sjVz
 AopzcSA6oJraLgr7M21eg3xff1tkgKeqnFjkIfjYhsHPjV4SZ742r0cTXD+Bws4nNPVa
 yojw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682672470; x=1685264470;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=InuKx0Hi/t1PfXRyGn1l+W28gO4cV3dUjASmDcsGYZg=;
 b=DxaIWVKcUl9paOZhCny6FC8UB5+2tYe56d3VvxFuc28WLeJQHs9Kh2N9g7IYeALYoZ
 CzHtBAntOB5UuODSlRXHgSmKsJRV+zGqh0qTtcQ1CKhfQ45xRkCYrYPTHj305YP9h9i7
 P+RkyJiltHTtP67AJltTTELYEwo9zAsQuejSNjglftZkSpPjseXuhj/AaqVMZjQMMm4D
 /ipwhYONIU7qSnESC1inOW4bV30qWMVI3VpXfaZsDb6InnzW29AeAPEKA8fk4OwpzKgq
 pI3CTSqOUMwDnGdN8q2vTlDBLTdcRcGDnoTE7Sp6dJIZwq1JHg/jGkCyICVEEcK9H/Qd
 9arw==
X-Gm-Message-State: AC+VfDxh0TbyxmZio3w2b6C0Ln8IlvMH1rKgnLt/TsDV0yl/HbwS8e0J
 VdOV15wtGLIh4Ldphl+7Rv0I4BnpGQg=
X-Google-Smtp-Source: ACHHUZ4dB8DYe9sfQCv+yb1em4q3uvKMwr7ePaeOOqBKLUVpGqKSvQrt98zZf2e8bNDu+bP+z99ytg==
X-Received: by 2002:a17:907:d8a:b0:94e:effc:de4f with SMTP id
 go10-20020a1709070d8a00b0094eeffcde4fmr5347712ejc.54.1682672469977; 
 Fri, 28 Apr 2023 02:01:09 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:beb6:5db0:ea7:9b07?
 ([2a02:908:1256:79a0:beb6:5db0:ea7:9b07])
 by smtp.gmail.com with ESMTPSA id
 w11-20020a1709064a0b00b0094f614e43d0sm10915775eju.8.2023.04.28.02.01.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Apr 2023 02:01:09 -0700 (PDT)
Message-ID: <5771c831-3b8a-d75e-e839-773d7df1b596@gmail.com>
Date: Fri, 28 Apr 2023 11:01:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 08/12] drm/amdgpu/gfx8: always restore kcq MQDs
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230427152709.7612-1-alexander.deucher@amd.com>
 <20230427152709.7612-8-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230427152709.7612-8-alexander.deucher@amd.com>
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

Am 27.04.23 um 17:27 schrieb Alex Deucher:
> Always restore the MQD not just when we do a reset.
> This allows us to move the MQD to VRAM if we want.
>
> v2: always reset ring pointer as well (Christian)
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com> for this one and 
same for other hw generations.

> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> index 5de44d7e92de..2ae7f167985f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> @@ -4651,15 +4651,13 @@ static int gfx_v8_0_kcq_init_queue(struct amdgpu_ring *ring)
>   
>   		if (adev->gfx.mec.mqd_backup[mqd_idx])
>   			memcpy(adev->gfx.mec.mqd_backup[mqd_idx], mqd, sizeof(struct vi_mqd_allocation));
> -	} else if (amdgpu_in_reset(adev)) { /* for GPU_RESET case */
> -		/* reset MQD to a clean status */
> +	} else {
> +		/* restore MQD to a clean status */
>   		if (adev->gfx.mec.mqd_backup[mqd_idx])
>   			memcpy(mqd, adev->gfx.mec.mqd_backup[mqd_idx], sizeof(struct vi_mqd_allocation));
>   		/* reset ring buffer */
>   		ring->wptr = 0;
>   		amdgpu_ring_clear_ring(ring);
> -	} else {
> -		amdgpu_ring_clear_ring(ring);
>   	}
>   	return 0;
>   }

