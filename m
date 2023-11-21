Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12244C61D92
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Nov 2023 14:38:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93C0D10E17F;
	Tue, 21 Nov 2023 14:38:28 +0000 (UTC)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEB8510E17F
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Nov 2023 14:38:25 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4083f61322fso25957015e9.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Nov 2023 06:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700577504; x=1701182304; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wu7le8MWEYGHdpcPG9fxejUt4GWGGitEsI+NWKoEUn0=;
 b=lFiArmfU71Qw0BiWlQ+MAsVvJ+uPf4S7WYZHGYtHlyTzqDvIOT3uKyynhkl7Y5sGfp
 MsbBG9Ie50/zFANzfK3AMtFQY+V+VMCgL4jk4qs+Q5AxAxP7mkGt6mIFRzgeImlP2D+f
 n61sKFy6GtBpmwb85XSLUOlTCOj+n3alXmRjTlsB2bU0NIW9zNcxEiD5g6F50vGdU9jV
 FI3dk1RigyVDjdHXE4Z87YHGAyFlaRQxqXW2P9QL2yUqCxCN3ROHGkxODJ9gehhAL/qN
 Xve9QdKT5cBHVgKZU1/gBW/04I4lRMzKZ1nJ7n8yFMlOI0gvT/Bux++aY45i9WHOTtFC
 DnNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700577504; x=1701182304;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wu7le8MWEYGHdpcPG9fxejUt4GWGGitEsI+NWKoEUn0=;
 b=K5HCiX7OcdrIcK8auWKxELT/lXziqFsOb8oWd5ZumHXf6gwXSNBiMVrDDMU35aGnGr
 QrEW9OqrLUgjUudn5k7Wpx9LSu80WOn0jBg2Y+jf0kbc5etQzuBFPu24UZUEFCLbu3g+
 Q7SZsrRG7sWO68Q14B8CjJ5L9nE1DVR1Qhe6Qq6WSBYpGUPQCeFXaN9Xenad5w6G1qvv
 kqtv41pC+nDtDhjFANSnY1hjmBMPrjjxXNFnzEU3GIxrsjrjHTFWWU0FWk6W2457cKQ4
 wHl0mYgk3Gt9btDoMpt8ZYh6I2rCScN4SW/fKaCtb3n6SguPH6rBMKh9rrJxdEy2Lt21
 ub1w==
X-Gm-Message-State: AOJu0Yz9UQ4BRfSm01Qfr617Jb2sMoDIuFrImE7RWoworqvJtm3t9cUs
 Ulfrgfe9fJEXnw2MU2mM6QU=
X-Google-Smtp-Source: AGHT+IFAMQcqrNPWhCBaEi/j1kV6tml1kgjOCYpERRM9ICx4VtlP8qKBEhvkwtDNTVXj/2BCRbf4Yw==
X-Received: by 2002:a05:6000:111:b0:332:c441:70aa with SMTP id
 o17-20020a056000011100b00332c44170aamr5116087wrx.26.1700577503843; 
 Tue, 21 Nov 2023 06:38:23 -0800 (PST)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 c7-20020adffb47000000b00332c0aace23sm9762899wrs.105.2023.11.21.06.38.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Nov 2023 06:38:23 -0800 (PST)
Message-ID: <b7e49776-787a-40da-9f96-8de2b5debdfa@gmail.com>
Date: Tue, 21 Nov 2023 15:38:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix memory overflow in the IB test
Content-Language: en-US
To: Tim Huang <Tim.Huang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231121062533.664725-1-Tim.Huang@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20231121062533.664725-1-Tim.Huang@amd.com>
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
Cc: Alexander.Deucher@amd.com, Yifan1.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 21.11.23 um 07:25 schrieb Tim Huang:
> Fix a memory overflow issue in the gfx IB test
> for some ASICs. At least 20 bytes are needed for
> the IB test packet.
>
> Signed-off-by: Tim Huang <Tim.Huang@amd.com>

Good catch.

> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 2 +-
>   drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c   | 2 +-
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 2 +-
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 2 +-
>   4 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 0c6133cc5e57..f281eecaeeec 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -419,7 +419,7 @@ static int gfx_v11_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>   		adev->wb.wb[index] = cpu_to_le32(0xCAFEDEAD);
>   		cpu_ptr = &adev->wb.wb[index];
>   
> -		r = amdgpu_ib_get(adev, NULL, 16, AMDGPU_IB_POOL_DIRECT, &ib);
> +		r = amdgpu_ib_get(adev, NULL, 20, AMDGPU_IB_POOL_DIRECT, &ib);
>   		if (r) {
>   			DRM_ERROR("amdgpu: failed to get ib (%ld).\n", r);
>   			goto err1;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> index 885ebd703260..4b0eda46405f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> @@ -883,7 +883,7 @@ static int gfx_v8_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>   	gpu_addr = adev->wb.gpu_addr + (index * 4);
>   	adev->wb.wb[index] = cpu_to_le32(0xCAFEDEAD);
>   	memset(&ib, 0, sizeof(ib));
> -	r = amdgpu_ib_get(adev, NULL, 16,
> +	r = amdgpu_ib_get(adev, NULL, 20,
>   					AMDGPU_IB_POOL_DIRECT, &ib);

Not the fault of your patch, but the indentation here and below seems to 
be wrong, please check your patch with checkpatch.pl.

When you don't get a warning feel free to add Reviewed-by: Christian 
König <christian.koenig@amd.com>.

Regards,
Christian.

>   	if (r)
>   		goto err1;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index e3ff6e46f3f7..a55710bf6e01 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -1039,7 +1039,7 @@ static int gfx_v9_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>   	gpu_addr = adev->wb.gpu_addr + (index * 4);
>   	adev->wb.wb[index] = cpu_to_le32(0xCAFEDEAD);
>   	memset(&ib, 0, sizeof(ib));
> -	r = amdgpu_ib_get(adev, NULL, 16,
> +	r = amdgpu_ib_get(adev, NULL, 20,
>   					AMDGPU_IB_POOL_DIRECT, &ib);
>   	if (r)
>   		goto err1;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> index 40d06d32bb74..603988e49cd5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -297,7 +297,7 @@ static int gfx_v9_4_3_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>   	gpu_addr = adev->wb.gpu_addr + (index * 4);
>   	adev->wb.wb[index] = cpu_to_le32(0xCAFEDEAD);
>   	memset(&ib, 0, sizeof(ib));
> -	r = amdgpu_ib_get(adev, NULL, 16,
> +	r = amdgpu_ib_get(adev, NULL, 20,
>   			  AMDGPU_IB_POOL_DIRECT, &ib);
>   	if (r)
>   		goto err1;

