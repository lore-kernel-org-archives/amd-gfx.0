Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CDAEC3DA7A
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Jan 2023 09:16:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03DE210E6CB;
	Thu,  5 Jan 2023 09:16:00 +0000 (UTC)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3FE910E6CB
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Jan 2023 09:15:57 +0000 (UTC)
Received: by mail-ej1-x62b.google.com with SMTP id tz12so88679392ejc.9
 for <amd-gfx@lists.freedesktop.org>; Thu, 05 Jan 2023 01:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qbB7/088ma6mMC2coEsYUQsXmJmtGet10yfGywYQz3c=;
 b=jrNKjbIQVb/I5FnziUTcw0h5QhrUOzgycqO/2Upx5jKynmn5zR3HO3JdCVuAeOE323
 7DklP5FwAWvvnrQ456O9mN7exrJQ9AutV/ZRQ/RDutfNib7h6IYoB2+lfcoeyVPy98aU
 UJsL+2xYWSPS46jYazLlYskB/vx0hW0jEL8KzGIltJaGdpEtNAzEc4lKuW0XvJM88BFC
 7PMbY774cd6PH3VmSwFh/Anye+eH9SQ3Vsf8sZ8wEtQgFu4iIpcAKqDx+F3UGBEH6TGd
 mR/+8LDIvlOl8mGFon5gqkyoy8GogCe98K2XpAG3j92EDyy5unYPBiCFUTgUGaCR+v9o
 tiow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qbB7/088ma6mMC2coEsYUQsXmJmtGet10yfGywYQz3c=;
 b=mR3SOiTTlMHOL1/NU4QZmqjHk0kKtX6h1jGrDNRpwNTj38rZG4EGb2f2fEVXGMxI3f
 yNnZyuQL1RwfFgI0AyCHEw9+cwZLcSh9/RccR5byOxWRXzaPQw9GDLSlgu7sVM8N3UX+
 p1cRS3TeTbmy2EIqUN8ZCWPKpm1qfoheXYYHMDAjUcCAbbN6bepUsG3aM9Rtda/wp77b
 Dfuma9GRFx5SmyrBOgx2Iu2OlRVjR5gXa0N3tQSYMj3HeSflMiZmEupdJP8GetGnbIQD
 3qDdCpa+oEVItGMFJTkdrcKTxmopj/yk3p+5EqzW3KG19M13BoV9Tewlkinf/xBoQie8
 aJcQ==
X-Gm-Message-State: AFqh2kpcCmFBEyhHf6r0lrRXByPkQvDxvyZBORan/1VX96N6+XTkPPA2
 rk9fpF6yTqCg+zg6SRabhy4=
X-Google-Smtp-Source: AMrXdXtWRZT6yEZ8/0Cn4KQVmQkxcV2SGRJjGZnIz/q0qjZiucceC4L28a4lMKEJPLoPplVfE0Klog==
X-Received: by 2002:a17:907:c68a:b0:84c:e9c4:5751 with SMTP id
 ue10-20020a170907c68a00b0084ce9c45751mr8248149ejc.74.1672910156077; 
 Thu, 05 Jan 2023 01:15:56 -0800 (PST)
Received: from [192.168.178.21] (p5b0ea2e7.dip0.t-ipconnect.de.
 [91.14.162.231]) by smtp.gmail.com with ESMTPSA id
 hb4-20020a170906b88400b008143bfe8429sm16325125ejb.73.2023.01.05.01.15.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Jan 2023 01:15:55 -0800 (PST)
Message-ID: <f5d462fd-ff8f-8634-2b24-18a6374da2fb@gmail.com>
Date: Thu, 5 Jan 2023 10:15:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] drm/amdgpu: Fix potential NULL dereference
Content-Language: en-US
To: Luben Tuikov <luben.tuikov@amd.com>,
 AMD Graphics <amd-gfx@lists.freedesktop.org>
References: <202212300020.CFmsapaG-lkp@intel.com>
 <20230104221935.113400-1-luben.tuikov@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230104221935.113400-1-luben.tuikov@amd.com>
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>, Dan Carpenter <error27@gmail.com>,
 kernel test robot <lkp@intel.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 04.01.23 um 23:19 schrieb Luben Tuikov:
> Fix potential NULL dereference, in the case when "man", the resource manager
> might be NULL, when/if we print debug information.
>
> Cc: Alex Deucher <Alexander.Deucher@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: AMD Graphics <amd-gfx@lists.freedesktop.org>
> Cc: Dan Carpenter <error27@gmail.com>
> Cc: kernel test robot <lkp@intel.com>
> Fixes: 7554886daa31ea ("drm/amdgpu: Fix size validation for non-exclusive domains (v4)")
> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index af716afad9a59a..d1c90015651ba5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -470,8 +470,9 @@ static bool amdgpu_bo_validate_size(struct amdgpu_device *adev,
>   	return true;
>   
>   fail:
> -	DRM_DEBUG("BO size %lu > total memory in domain: %llu\n", size,
> -		  man->size);
> +	if (man)
> +		DRM_DEBUG("BO size %lu > total memory in domain: %llu\n", size,
> +			  man->size);
>   	return false;
>   }
>   
>
> base-commit: b45d1c2754f5080acf2096ffcb17bcfeee7f5c2f

