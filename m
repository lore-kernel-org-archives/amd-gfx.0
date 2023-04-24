Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0658DC77B61
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Apr 2023 09:07:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C98B10E435;
	Mon, 24 Apr 2023 09:07:29 +0000 (UTC)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5A0910E435
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Apr 2023 09:07:27 +0000 (UTC)
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5058181d58dso7357835a12.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Apr 2023 02:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1682327246; x=1684919246;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5TO/IJvGZEmMFlrF4dQCBNkAI94nQGIkYnzqjM4tzVY=;
 b=V7vFlCxMA9kwYN3JtiOecFP+dh52id7mNhRmfwhKXFWj4I6RzsLIpi39DCYqaPbKsv
 lC6/ltJ1lt2/EFWUditA7B6rY6VN0Q92wu2k5SBa6cne5z0l79Zuis2hwFZMlfTPK7mA
 ibzQuj4vvhUiu/W06/YVJ2qHeWZyr6laIBXacvNpLD/te/unzrnjUmzpQA3sYZupzlpU
 TkFj6ui4m4+/IpX6quB4AU+9aPa1DFkAh2ul0IsAj3d01YhlAzChPIwgQiOxJhaVSXA/
 SftuSDifAgPmn7QpEqd9dxw1k7DxsU2O1kvkUmoj1IMGpQFLojsXoXAeUtj0KDReAG5F
 Yejg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682327246; x=1684919246;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5TO/IJvGZEmMFlrF4dQCBNkAI94nQGIkYnzqjM4tzVY=;
 b=O8gq8uK9y2Bwg4M9oCK+V3KUXgckQo8fVICbN8hzw5DDBltr70KIxi9wY6zF5qNPaZ
 pgcvEL8EAII4EaeOszCSfYmjbTVMw9VRgYJbV+QCT44WTXZwXIMPK8SOXMD2CHM5wbgC
 N/ZZFsMZMhPScLVXjftLeeXBmWB4neJVlTVNQr9LsSCjfVSdXezHJYvm2JPz9GoTWAYD
 bWPauABn08GgGksvKab0qjkzNJPHI8VOIQ8WSTaaQE8rXTVary0rqRtw/BfsbdU3aqY+
 CB25in7tRxI562xeTRfxo2LRIB4WUUnaS1J0BTP+l+c7aIznH2K8Y2BSaPkaCntMrXaS
 EHyg==
X-Gm-Message-State: AAQBX9cq10SqFydq5nxrlbVQ73FpaRzjDGjV3KK0iQjVGp5+WO9CPhbE
 KiyLSbt/Frs7ZdtIXNYVog3OcNuBxxs=
X-Google-Smtp-Source: AKy350YlZGfResYwA4wtF720VDmdmqZBjbjrUoP34WbAFlu+CMo2Xurr5V6FkYyFF4bMZBpjJm2Rsw==
X-Received: by 2002:a05:6402:1218:b0:504:8c15:a132 with SMTP id
 c24-20020a056402121800b005048c15a132mr10355266edw.7.1682327245604; 
 Mon, 24 Apr 2023 02:07:25 -0700 (PDT)
Received: from [192.168.178.21] (p4fc2092b.dip0.t-ipconnect.de. [79.194.9.43])
 by smtp.gmail.com with ESMTPSA id
 r18-20020a056402035200b00506956c99d9sm4424063edw.15.2023.04.24.02.07.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Apr 2023 02:07:24 -0700 (PDT)
Message-ID: <9885713a-b424-dddc-f891-ed7d622c5b91@gmail.com>
Date: Mon, 24 Apr 2023 11:07:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] drm/amdgpu: Enable doorbell selfring if resize BAR
 successfully
Content-Language: en-US
To: Shane Xiao <shane.xiao@amd.com>, amd-gfx@lists.freedesktop.org,
 Alexander.Deucher@amd.com, hawking.zhang@amd.com, felix.kuehling@amd.com
References: <20230418065443.878721-1-shane.xiao@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230418065443.878721-1-shane.xiao@amd.com>
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
Cc: Xiaomeng Hou <Xiaomeng.Hou@amd.com>, Aaron Liu <aaron.liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 18.04.23 um 08:54 schrieb Shane Xiao:
> [Why]
> The selfring doorbell aperture will change when we resize
> FB BAR successfully during gmc sw init, we should reorder
> the sequence of enabling doorbell selfring aperture.

That's a good catch.

>
> [How]
> Move enable_doorbell_selfring_aperture from *_common_hw_init
> to *_common_late_init.

But that sounds like a bad idea. Instead the full call to 
nv_enable_doorbell_aperture() should be moved around.

Regards,
Christian.

>
> This fixes the potential issue that GPU ring its own
> doorbell when this device is in translated mode with
> iommu is on.
>
> Signed-off-by: Shane Xiao <shane.xiao@amd.com>
> Signed-off-by: Aaron Liu <aaron.liu@amd.com>
> Tested-by: Xiaomeng Hou <Xiaomeng.Hou@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/nv.c    | 4 +++-
>   drivers/gpu/drm/amd/amdgpu/soc15.c | 4 +++-
>   drivers/gpu/drm/amd/amdgpu/soc21.c | 4 +++-
>   3 files changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
> index 47420b403871..f4c85634a4c8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> @@ -535,7 +535,8 @@ static void nv_enable_doorbell_aperture(struct amdgpu_device *adev,
>   					bool enable)
>   {
>   	adev->nbio.funcs->enable_doorbell_aperture(adev, enable);
> -	adev->nbio.funcs->enable_doorbell_selfring_aperture(adev, enable);
> +	if (!enable)
> +		adev->nbio.funcs->enable_doorbell_selfring_aperture(adev, false);
>   }
>   
>   const struct amdgpu_ip_block_version nv_common_ip_block =
> @@ -999,6 +1000,7 @@ static int nv_common_late_init(void *handle)
>   		}
>   	}
>   
> +	adev->nbio.funcs->enable_doorbell_selfring_aperture(adev, true);
>   	return 0;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
> index bc5dd80f10c1..0202de79a389 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> @@ -623,7 +623,8 @@ static void soc15_enable_doorbell_aperture(struct amdgpu_device *adev,
>   					   bool enable)
>   {
>   	adev->nbio.funcs->enable_doorbell_aperture(adev, enable);
> -	adev->nbio.funcs->enable_doorbell_selfring_aperture(adev, enable);
> +	if (!enable)
> +		adev->nbio.funcs->enable_doorbell_selfring_aperture(adev, false);
>   }
>   
>   const struct amdgpu_ip_block_version vega10_common_ip_block =
> @@ -1125,6 +1126,7 @@ static int soc15_common_late_init(void *handle)
>   	if (amdgpu_sriov_vf(adev))
>   		xgpu_ai_mailbox_get_irq(adev);
>   
> +	adev->nbio.funcs->enable_doorbell_selfring_aperture(adev, true);
>   	return 0;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
> index 514bfc705d5a..cd4619085d67 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc21.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
> @@ -454,7 +454,8 @@ static void soc21_enable_doorbell_aperture(struct amdgpu_device *adev,
>   					bool enable)
>   {
>   	adev->nbio.funcs->enable_doorbell_aperture(adev, enable);
> -	adev->nbio.funcs->enable_doorbell_selfring_aperture(adev, enable);
> +	if (!enable)
> +		adev->nbio.funcs->enable_doorbell_selfring_aperture(adev, false);
>   }
>   
>   const struct amdgpu_ip_block_version soc21_common_ip_block =
> @@ -764,6 +765,7 @@ static int soc21_common_late_init(void *handle)
>   			amdgpu_irq_get(adev, &adev->nbio.ras_err_event_athub_irq, 0);
>   	}
>   
> +	adev->nbio.funcs->enable_doorbell_selfring_aperture(adev, true);
>   	return 0;
>   }
>   

