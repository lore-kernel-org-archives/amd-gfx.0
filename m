Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FA9BC001B0
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Aug 2023 06:30:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2844410E3A5;
	Tue,  8 Aug 2023 06:30:50 +0000 (UTC)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D7DE10E3A5
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Aug 2023 06:30:48 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-3fe1e1142caso51511135e9.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 07 Aug 2023 23:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691476247; x=1692081047;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zqk8R3IonTci8hLSXfXeKm853p6DqLMRcAylSZJtUEM=;
 b=FmJgEKjoGxlH47ZTesaXYbYUaFPrcvpqlYsPV088rJE+oMPgnCDIiLxk6n7lYI7ruC
 cytUPwHOlLt2xaA0mC7UlneOO4hIFtVF5YTD5Pd3gJOqaWecfpV5DE+26Ws/P1FLIaAN
 InrSPIqt1Bl0liI7Fq30fDTSAm2caGRXM1pV89lsiU5UZgdpSoGA/N9MNnwOAlkaKpLB
 QL4Lm9mS3ALcxscI5NRk6JyojGTNvCQb17lMkdY2OKN7v/ypgjAGSnqSFDlAhAc9ifbe
 5hLm0Nh+Gv0P8o7FEsH4U4oWAsI6P+geHOhNmqRcCTfZJ0CnAaySw/PVxQ0m6nPKUw6R
 5Giw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691476247; x=1692081047;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zqk8R3IonTci8hLSXfXeKm853p6DqLMRcAylSZJtUEM=;
 b=L5wC12siU6u/ZGtey7yFhwD+kL20tHRHIDuzJD123a0Xbr+voSQ5MEJ7ow3KRnhq6/
 oL2Fxg7jk+7jcjtpV/DFLUWBJWurctLuolb1kjc/1yFN7H/zo12YvxzwIgfebNfcR0wQ
 nRjDx7+glTCwifdHt3w3kHeNrgSBa2mAqEIfsGwaKlf1ln/zjqMA9JY1DyAtiXOOU0Xs
 yMM/uZQmipYGptDSrWEtQNT5e6chiVw5whAVFs4Qjdb7wimZC8bQX22JZnCazTGP9LwD
 lxaW16y2yIrZFNWycJS5AxDiC5Y12jU73wN7rx4sU7IiXKcZdZlL3I/5n4pYw5GgU5YH
 631A==
X-Gm-Message-State: AOJu0YxSYMNrlDPobUx/I6oHyDfrZrGpdCFd2AsflvRIgZQDoo87zPAJ
 z0nGvgLVB3Xxr/cqPDV6+nvT8ihInLE=
X-Google-Smtp-Source: AGHT+IH3fgIot+xbJRQW4hSUf48X8BE6rkyU5OyjqqoHLIUQzNOP2vT5RVwLfvtvxwEAahg+Ot3p5A==
X-Received: by 2002:aa7:c31a:0:b0:522:1d30:efce with SMTP id
 l26-20020aa7c31a000000b005221d30efcemr7865634edq.22.1691476225839; 
 Mon, 07 Aug 2023 23:30:25 -0700 (PDT)
Received: from ?IPV6:2a00:e180:1471:fb00:e090:ae3d:1c51:b452?
 ([2a00:e180:1471:fb00:e090:ae3d:1c51:b452])
 by smtp.gmail.com with ESMTPSA id
 a22-20020aa7d756000000b005232cf13b02sm3910005eds.37.2023.08.07.23.30.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Aug 2023 23:30:25 -0700 (PDT)
Message-ID: <08e66fda-b382-27bc-e219-9d0a66df9b43@gmail.com>
Date: Tue, 8 Aug 2023 08:30:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 4/4] drm/amdgpu: use a macro to define no xcp partition
 case
Content-Language: en-US
To: Guchun Chen <guchun.chen@amd.com>, amd-gfx@lists.freedesktop.org,
 alexander.deucher@amd.com, hawking.zhang@amd.com, christian.koenig@amd.com,
 Philip.Yang@amd.com, Felix.Kuehling@amd.com
References: <20230718051342.217902-1-guchun.chen@amd.com>
 <20230718051342.217902-4-guchun.chen@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230718051342.217902-4-guchun.chen@amd.com>
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

Am 18.07.23 um 07:13 schrieb Guchun Chen:
> ~0 as no xcp partition is used in several places, so improve its
> definition by a macro for code consistency.
>
> Suggested-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>
> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>

I guess you already pushed this, so just for the record: Reviewed-by: 
Christian König <christian.koenig@amd.com>.

I need to get faster catching up on mails,
Christian.

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 3 ++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c          | 4 ++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h          | 2 ++
>   drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c       | 4 ++--
>   4 files changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index a7f314ddd173..d34c3ef8f3ed 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1709,7 +1709,8 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
>   			alloc_flags |= (flags & KFD_IOC_ALLOC_MEM_FLAGS_PUBLIC) ?
>   			AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED : 0;
>   		}
> -		xcp_id = fpriv->xcp_id == ~0 ? 0 : fpriv->xcp_id;
> +		xcp_id = fpriv->xcp_id == AMDGPU_XCP_NO_PARTITION ?
> +					0 : fpriv->xcp_id;
>   	} else if (flags & KFD_IOC_ALLOC_MEM_FLAGS_GTT) {
>   		domain = alloc_domain = AMDGPU_GEM_DOMAIN_GTT;
>   		alloc_flags = 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> index d175e862f222..9c9cca129498 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> @@ -363,7 +363,7 @@ int amdgpu_xcp_open_device(struct amdgpu_device *adev,
>   	if (!adev->xcp_mgr)
>   		return 0;
>   
> -	fpriv->xcp_id = ~0;
> +	fpriv->xcp_id = AMDGPU_XCP_NO_PARTITION;
>   	for (i = 0; i < MAX_XCP; ++i) {
>   		if (!adev->xcp_mgr->xcp[i].ddev)
>   			break;
> @@ -381,7 +381,7 @@ int amdgpu_xcp_open_device(struct amdgpu_device *adev,
>   		}
>   	}
>   
> -	fpriv->vm.mem_id = fpriv->xcp_id == ~0 ? -1 :
> +	fpriv->vm.mem_id = fpriv->xcp_id == AMDGPU_XCP_NO_PARTITION ? -1 :
>   				adev->xcp_mgr->xcp[fpriv->xcp_id].mem_id;
>   	return 0;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
> index 0f8026d64ea5..9a1036aeec2a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
> @@ -37,6 +37,8 @@
>   #define AMDGPU_XCP_FL_NONE 0
>   #define AMDGPU_XCP_FL_LOCKED (1 << 0)
>   
> +#define AMDGPU_XCP_NO_PARTITION (~0)
> +
>   struct amdgpu_fpriv;
>   
>   enum AMDGPU_XCP_IP_BLOCK {
> diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
> index 16471b81a1f5..72b629a78c62 100644
> --- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
> +++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
> @@ -68,7 +68,7 @@ static void aqua_vanjaram_set_xcp_id(struct amdgpu_device *adev,
>   	enum AMDGPU_XCP_IP_BLOCK ip_blk;
>   	uint32_t inst_mask;
>   
> -	ring->xcp_id = ~0;
> +	ring->xcp_id = AMDGPU_XCP_NO_PARTITION;
>   	if (adev->xcp_mgr->mode == AMDGPU_XCP_MODE_NONE)
>   		return;
>   
> @@ -177,7 +177,7 @@ static int aqua_vanjaram_select_scheds(
>   	u32 sel_xcp_id;
>   	int i;
>   
> -	if (fpriv->xcp_id == ~0) {
> +	if (fpriv->xcp_id == AMDGPU_XCP_NO_PARTITION) {
>   		u32 least_ref_cnt = ~0;
>   
>   		fpriv->xcp_id = 0;

