Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12977C77B7E
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Jun 2023 14:40:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98E7710E55A;
	Thu,  1 Jun 2023 14:40:05 +0000 (UTC)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02CE610E55A
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Jun 2023 14:40:03 +0000 (UTC)
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-510f525e06cso1440328a12.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 01 Jun 2023 07:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685630402; x=1688222402;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QlU2bkmhLsj9aLYHqZuLoLdZpKsJ/x5xsbUzxDswI68=;
 b=i1oXHaZJHozHdObwKaz1Qqpk8wfF3PDqSZvkJEZ9j2c+3yByYk4/0XmN94F+Q44+oF
 71rAwH1+F/9Pi7nCVpvDAh+/sEq5R61WAkmiCh66weDRQTKsf0EcfgnaK7sg+ESZ2J6d
 BVGi/2ECBrEw3imzODJC7LvzbuhoWLstaycW9d1L4rJFAVA9DY2g+jzJPNT6/FM0EBbu
 EI62odgG1bRK/iR2rDHGMUt1gp6xTPPnl9YiTkOSCDz/+GZ1+TKcO7El8EGzZ/G3h06y
 Wz+YaVgHDYxuwIOiovDLjl4yFntysFBkGIIetj+Ey+q+gErADV/BanTocrHuT958mBo1
 2KvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685630402; x=1688222402;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QlU2bkmhLsj9aLYHqZuLoLdZpKsJ/x5xsbUzxDswI68=;
 b=h8ASd+dXceGbmUS1kl6i3OzMiFpkkV39wFaoCkE4oh+3f37ShT8QeLcWbIb4ZVG3Wv
 Ui1FRQ+gKM+FqhdMg5p2xzjdObfnOAiPxRnBXXOsHrY8UUEdkgnmN7AyZiHadX5GPwS7
 PEDtuXtFmobcOUUXEuNsuaXIMkLOkuPgRmlQ5+m6moj7GpjmOk745Y74ZzxIF96M0rEB
 Htz67sWzvOimuXI66v7qHpMpDBeHMCR5ZSqDCSiApbZZXXAbpEovulTjqa1co8RuXHUo
 +0HulJnxY6yl8AB94Bcinw5kzErQLwukKOUXZy8QEHY/AqGvP5uJ+pm4PVWnrXixqJGw
 ALMg==
X-Gm-Message-State: AC+VfDz5kUPHGRrC7XJBkP4iCXF6I50z0ArfNJ5Z50jQXSgxG9SgZ82z
 nP+jlS6rW4dpRWqsMp838mjkrAIYDEY=
X-Google-Smtp-Source: ACHHUZ5i9OptcWzqbOCmu0FjhYMeWUyb2VrN/R3lvwiJfvF+1Df7j2kYOMWN9ZAa6K+3T5AxmjnYWQ==
X-Received: by 2002:a17:906:ef02:b0:973:ff4d:d026 with SMTP id
 f2-20020a170906ef0200b00973ff4dd026mr8347942ejs.45.1685630401699; 
 Thu, 01 Jun 2023 07:40:01 -0700 (PDT)
Received: from ?IPV6:2a00:e180:1543:da00:92db:2067:4b66:9b88?
 ([2a00:e180:1543:da00:92db:2067:4b66:9b88])
 by smtp.gmail.com with ESMTPSA id
 lx6-20020a170906af0600b0096efa536229sm10832926ejb.149.2023.06.01.07.40.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Jun 2023 07:40:01 -0700 (PDT)
Message-ID: <bc744636-9eb0-0714-df77-cd058f8cfc28@gmail.com>
Date: Thu, 1 Jun 2023 16:40:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] Revert "drm/amdgpu: remove TOPDOWN flags when allocating
 VRAM in large bar system"
Content-Language: en-US
To: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230520092518.1993-1-Arunpravin.PaneerSelvam@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230520092518.1993-1-Arunpravin.PaneerSelvam@amd.com>
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
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, shane.xiao@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 20.05.23 um 11:25 schrieb Arunpravin Paneer Selvam:
> This reverts commit c105518679b6e87232874ffc989ec403bee59664.
>
> This patch disables the TOPDOWN flag for APU and few dGPU cards
> which has the VRAM size equal to the BAR size.
>
> When we enable the TOPDOWN flag, we get the free blocks at
> the highest available memory region and we don't split the
> lower order blocks. This change is required to keep off
> the fragmentation related issues particularly in ASIC
> which has VRAM space <= 500MiB
>
> Hence, we are reverting this patch.
>
> Gitlab issue link - https://gitlab.freedesktop.org/drm/amd/-/issues/2270
>
> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>

For now Reviewed-by: Christian König <christian.koenig@amd.com> for this 
change.

The extra overhead for the topdown handling is intentional here as far 
as I can see.

Christian.

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 2bd1a54ee866..ca5fc07faf6c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -139,7 +139,7 @@ void amdgpu_bo_placement_from_domain(struct amdgpu_bo *abo, u32 domain)
>   
>   		if (flags & AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED)
>   			places[c].lpfn = visible_pfn;
> -		else if (adev->gmc.real_vram_size != adev->gmc.visible_vram_size)
> +		else
>   			places[c].flags |= TTM_PL_FLAG_TOPDOWN;
>   
>   		if (flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS)

