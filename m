Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5A26C27C76
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Jan 2023 08:48:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1697F10E0D7;
	Wed, 25 Jan 2023 08:48:38 +0000 (UTC)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BFC010E0D7
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Jan 2023 08:48:35 +0000 (UTC)
Received: by mail-ed1-x52e.google.com with SMTP id s3so21007287edd.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Jan 2023 00:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SS+oLJtNTKPRroDHJ9WuiRmrcSRktrL4Ke3wtSiCubQ=;
 b=KAoj9IDza6h66kOsdcbNtsuiTWoC5NW1dvxbYk18yAiOTLMCstNrWlXx9vG8si3OL7
 PX78bk52phjs6R1KyGj44df/SL1TusRXY+5aNKrVy/ToVcyTZrNRCJLqVTDGBHPB1N+v
 f90CSITQLQdUAIJz+ecKmajlt/128P0E4pn7dq9eWeg6mRdrRwubN/I4P/RKbTquFVAT
 wB6/m0quEI6KZQ62pfomh00JXX+NDJ3YIaOBKYP/Q9RBpKxcEdZgdkdzU6nl+06t8i5h
 eSGSxJcOxVK7X5aSHaltnsDzt6FYGqzctyVoaEM9GK4aIUkywi/WPht7YQ3gWoVgN+F0
 ERJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SS+oLJtNTKPRroDHJ9WuiRmrcSRktrL4Ke3wtSiCubQ=;
 b=3QdQeJAa/a5gtuBD5JgS2NcGLymfuhkU35Om3kzTie+GazMI9kmIaakn4zNuh8Yv7S
 moRcELhpF393Vbwi7YFbqoGXbIiHTTojgHkJrBmWncWWpMshlEsk3xN+2hW083P/TLhW
 ITf9I77kuTDcALwGjNC+bynMpfW8iQsqTpZbup6BlMmJqH8XqJ+FrnS+IgR/nzYYyB69
 /IK04nr0PjcgyGz/XEFiY0+OCNfHVuTqtta0NGc45g5tzwnj/yMwuGedpFuSIGaKJBUF
 Tv6xMBO84fX3oo0eVST2iDcwf4cjpsSllgu4aQ09XvBPt1BYFbUepe9aGD3sMnS1QuvP
 sBBQ==
X-Gm-Message-State: AFqh2kpzPv2vMQP33sexDOHHwv5ac4NXuireoDav1TUM1E840ffYTq6e
 fXiLj31icSShqEdGEO/5qkw=
X-Google-Smtp-Source: AMrXdXt/1j9m/YXFG3JV/noK/HQ4lAq/4yGfkXFBlifC2dskXetykfVN9Bw33ItxEnom4nYAJ47bqA==
X-Received: by 2002:a05:6402:5d3:b0:482:9afc:c542 with SMTP id
 n19-20020a05640205d300b004829afcc542mr37481544edx.14.1674636513835; 
 Wed, 25 Jan 2023 00:48:33 -0800 (PST)
Received: from ?IPV6:2a02:908:1256:79a0:180c:8737:8e57:6be7?
 ([2a02:908:1256:79a0:180c:8737:8e57:6be7])
 by smtp.gmail.com with ESMTPSA id
 da14-20020a056402176e00b0046dd0c2a08esm2079212edb.36.2023.01.25.00.48.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Jan 2023 00:48:33 -0800 (PST)
Message-ID: <24f31bdb-17b7-01ea-7bd3-ddd7614ada3b@gmail.com>
Date: Wed, 25 Jan 2023 09:48:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] drm/amdgpu: add force_sg_display module parameter
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230124151318.605240-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230124151318.605240-1-alexander.deucher@amd.com>
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

Am 24.01.23 um 16:13 schrieb Alex Deucher:
> Add a module parameter to force sg (scatter/gather) display
> on APUs.  Normally we allow displays in both VRAM and GTT,
> but this option forces displays into GTT so we can explicitly
> test more scenarios with GTT.

We tried to avoid that very hard the last time the idea came up. 
Generally I don't think that this is something end users should mess with.

It's certainly useful for internal testing, but I think educating 
everybody how to change a define before compiling the driver should be 
the better approach.

Regards,
Christian.

>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  2 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 12 ++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c |  4 ++++
>   3 files changed, 18 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 872450a3a164..73d0a0807138 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -244,6 +244,8 @@ extern int amdgpu_num_kcq;
>   #define AMDGPU_VCNFW_LOG_SIZE (32 * 1024)
>   extern int amdgpu_vcnfw_log;
>   
> +extern int amdgpu_force_sg_display;
> +
>   #define AMDGPU_VM_MAX_NUM_CTX			4096
>   #define AMDGPU_SG_THRESHOLD			(256*1024*1024)
>   #define AMDGPU_DEFAULT_GTT_SIZE_MB		3072ULL /* 3GB by default */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index a75dba2caeca..bc0eaf2330f2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -942,6 +942,18 @@ MODULE_PARM_DESC(smu_pptable_id,
>   	"specify pptable id to be used (-1 = auto(default) value, 0 = use pptable from vbios, > 0 = soft pptable id)");
>   module_param_named(smu_pptable_id, amdgpu_smu_pptable_id, int, 0444);
>   
> +/**
> + * DOC: force_sg_display (int)
> + * Force display buffers into GTT (scatter/gather) memory for APUs.
> + * This is used to force GTT only for displays rather than displaying from
> + * either VRAM (carve out) or GTT.
> + *
> + * Defaults to 0, or disabled.
> + */
> +int amdgpu_force_sg_display;
> +MODULE_PARM_DESC(force_sg_display, "Force S/G display (0 = off (default), 1 = force display to use GTT) ");
> +module_param_named(force_sg_display, amdgpu_force_sg_display, int, 0444);
> +
>   /* These devices are not supported by amdgpu.
>    * They are supported by the mach64, r128, radeon drivers
>    */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 2d237f3d3a2e..78dc5d63a6dd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -1515,6 +1515,10 @@ uint32_t amdgpu_bo_get_preferred_domain(struct amdgpu_device *adev,
>   		if (adev->gmc.real_vram_size <= AMDGPU_SG_THRESHOLD)
>   			domain = AMDGPU_GEM_DOMAIN_GTT;
>   	}
> +	if (amdgpu_force_sg_display &&
> +	    (adev->asic_type >= CHIP_CARRIZO) &&
> +	    (adev->flags & AMD_IS_APU))
> +		domain = AMDGPU_GEM_DOMAIN_GTT;
>   	return domain;
>   }
>   

