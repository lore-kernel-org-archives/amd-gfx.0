Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1868CC43334
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Jul 2022 19:03:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86415113397;
	Thu,  7 Jul 2022 19:03:32 +0000 (UTC)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3590F113396
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Jul 2022 19:03:31 +0000 (UTC)
Received: by mail-ed1-x531.google.com with SMTP id g1so16682255edb.12
 for <amd-gfx@lists.freedesktop.org>; Thu, 07 Jul 2022 12:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=QbjYl0ohZcBwhk/xsey1vRHVIPMzuGgSluNR8lMOw48=;
 b=mh8se5TuRhZrPAvwLWxjAXagczrEzpIvSG1uik3WjgUWiyQwcd20fvbeXoYbd1q/Cn
 YQQJcrlR19wAwlEdByWbBP4LAp/cm04Q4WjimeCFvltXlgmpk7cFodsQhiFI33hXjZGp
 KFWnW4rJ9SZNy2tTMgxEqFYIoKJ1tOvWFZ9hAs3gDZ7aB8dFdAxVJXjGoqYJqWx+VkXq
 3L+YTYKPyt1mu1dP3C4ZpX0PwmLxbo/LkXalcmQVljTOIle+9fyv5C6KyBXbvYckGJAf
 /KGc0D82pYUZleeTOjkFvvr7OVO8MzIohudx6O7FHLjuzh5DTAfifEdGuX3+DWVzUaMa
 RQRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=QbjYl0ohZcBwhk/xsey1vRHVIPMzuGgSluNR8lMOw48=;
 b=rnQzbHzAU467BJNmp8FJIigchiJLa4flStRcPUMmDNeyTbGn2Mfe8r00ZuL+bCbi8z
 DPsyIhr+IOaGsAZqGLrv5c6ABJU8Mnf50z+woIlykjiaL8f36GffUmhwNDe+lyU8nH0t
 ElQEbNN/L4SQDIuHuzz+MXFb7J/t02SgaxCWUCdOQ94mVCOKJaw1ks5Bx5rjzkZv2/44
 GwlNOlOBuMfGdXEqJQbFNbgqOjUX1DpgbNANL98OzHihikQ/wGVCDH/RawtfpnwByLym
 qjdJx3hm6jUm7uQfiZJoBnN07SSuuLJX93PPjIw+hEB3WmQv/mod/qDaZ98IERDNVqmt
 A3tg==
X-Gm-Message-State: AJIora80ULQnDJ6jYMhbGn2ln8TzO01lQr3zvQqgwJf7mHOMNNdIkWXR
 wIq02MdbvFRgBiNEmvit2Lk=
X-Google-Smtp-Source: AGRyM1u2FWgYqINQdz9FKqGj7OEVmuxdwGTVSx5Mxt6QzXWzwQW9P6/Xn3cubSXuAbVEY//NQgaiuQ==
X-Received: by 2002:aa7:cd4d:0:b0:43a:2ce0:3a6f with SMTP id
 v13-20020aa7cd4d000000b0043a2ce03a6fmr35132909edw.181.1657220609625; 
 Thu, 07 Jul 2022 12:03:29 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:b539:b9f9:92bd:4f9d?
 ([2a02:908:1256:79a0:b539:b9f9:92bd:4f9d])
 by smtp.gmail.com with ESMTPSA id
 z8-20020aa7d408000000b0043a37e1d8easm11116810edq.32.2022.07.07.12.03.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Jul 2022 12:03:29 -0700 (PDT)
Message-ID: <fb61c0c1-b017-61c0-657f-39ff891db495@gmail.com>
Date: Thu, 7 Jul 2022 21:03:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/1] drm/amdgpu: Don't clear memory when PTB BO is released
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220707164549.4032-1-Philip.Yang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20220707164549.4032-1-Philip.Yang@amd.com>
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
Cc: felix.kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 07.07.22 um 18:45 schrieb Philip Yang:
> MMU notifier callback unmap the svm range update page table may free the
> PTB BO, then amdgpu_fill_buffer zero BO memory could cause deadlock as
> kmalloc may trigger MMU notifier.

Uff that means the whole free BO code path can't allocate anything.

I don't think we can do that.

>
> amdgpu_vm_pt_clear setup PTB BO memory with initial value, and no
> sensitive data in page table that must be wiped out before releasing the
> memory. So don't clear the memory when PTB BO is released.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com> for this change 
here, but in general we need to talk about that once more.

Regards,
Christian.

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 8a7b0f6162da..65b4ff6979ee 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -576,7 +576,7 @@ int amdgpu_bo_create(struct amdgpu_device *adev,
>   	if (!amdgpu_bo_support_uswc(bo->flags))
>   		bo->flags &= ~AMDGPU_GEM_CREATE_CPU_GTT_USWC;
>   
> -	if (adev->ras_enabled)
> +	if (adev->ras_enabled && bp->type != ttm_bo_type_kernel)
>   		bo->flags |= AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE;
>   
>   	bo->tbo.bdev = &adev->mman.bdev;

