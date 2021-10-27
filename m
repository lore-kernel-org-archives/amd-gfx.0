Return-Path: <SRS0=hGuQ=PP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3147C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Oct 2021 07:18:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C23860F9B
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Oct 2021 07:18:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9C23860F9B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BBBB892A4;
	Wed, 27 Oct 2021 07:18:07 +0000 (UTC)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25F29892A4
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Oct 2021 07:18:07 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id
 b194-20020a1c1bcb000000b0032cd7b47853so322887wmb.5
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Oct 2021 00:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=+CMc+ik38J3ooJ5KTSU6HAwN30me8enTNPWmlL1wcZo=;
 b=f9Sl2GiPPQQE69EFtAZumDuBcB2rthqlmyqnhDn85J7jPuMopgQ38BcFRYS01ArepZ
 QhNjlJc2rP1I6ANPDJLJhSysN2Eh3Ws4qWYhuXnh2XMCncdqXHubc1xLLBtZZo1R8rnN
 TJok1RZ4837VHKaeA/40hz7Sq+SjAmdwvGRudL39DqOTLtaftIo36SqLRpuEdfWhqzPK
 FgyKQYc2ZsEQOcwPyqFNMHdoYr+NSN9ZdFblFlEx/i7Y60Qdzsy7qK/z6sOzKTFpjUCw
 akAF8iVEv9SJmUw/olQxD4C5vZ/HujHOuVpw1+VL2ukMQ06Kyxq0G3NaMc8TZ1bPb5nW
 aj5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=+CMc+ik38J3ooJ5KTSU6HAwN30me8enTNPWmlL1wcZo=;
 b=JwPgHWYhQ8MEaysNCCfusuVtM2erBPrnvymkumTdMNk8AbCVRrgL9C2VXs9BCgkMXO
 PnSvpFOPALvJKn2qt4RwCuLlSBNohLKM1VGeFq52Dcmhdxo4YPlNtCuaax2lDlJmCdXD
 VT3RHnQ/93H7wwnofOuHnpYIZaEKyhja9aluJ836b+oucPpPLWpHb/idAoh6dKcGFUe/
 voTAXB6iwFWkXNoXBNrHFc3zs1klLf0WcmKvEHLfv3BCL+B/BZtEDaPEHc8MYg24pEhl
 Yz/oVbE50/eTmP9xsZ/gcUwyffiWZfBj0+JsocF/JMOWQjq21e/XiVZ7cFn0d5D73YjX
 YNXg==
X-Gm-Message-State: AOAM533YPnFkusccI5L5Dtfdiw90MP5yxMVKTfc2HXWtX6roxyQxCzK7
 Bc1ATwMT4pN6YgJFGRl/F/umhIgWy68=
X-Google-Smtp-Source: ABdhPJzOB0bZMzJSzrTaFcrj/T8HKKMTgEmunwTutpRkGwX4yiJi0yX8Sc0CNPkkxP4FGl2SFS/e8g==
X-Received: by 2002:a1c:f609:: with SMTP id w9mr3811513wmc.24.1635319085751;
 Wed, 27 Oct 2021 00:18:05 -0700 (PDT)
Received: from [192.168.178.21] (p5b0ea1b5.dip0.t-ipconnect.de.
 [91.14.161.181])
 by smtp.gmail.com with ESMTPSA id t11sm20599051wrz.65.2021.10.27.00.18.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Oct 2021 00:18:05 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: fix warning in pr_debug
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Philip Yang <Philip.Yang@amd.com>
References: <20211026153612.474820-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <26362744-6a99-78c3-ed07-e87eec31cc11@gmail.com>
Date: Wed, 27 Oct 2021 09:18:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211026153612.474820-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
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

Am 26.10.21 um 17:36 schrieb Alex Deucher:
> In file included from drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:52:
> drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c: In function ‘amdgpu_ttm_tt_get_user_pages’:
> drivers/gpu/drm/amd/amdgpu/amdgpu.h:35:21: warning: format ‘%llx’ expects argument of type ‘long long unsigned int’, but argument 4 has type ‘long unsigned int’ [-Wformat=]
>     35 | #define pr_fmt(fmt) "amdgpu: " fmt
>        |                     ^~~~~~~~~~
> ./include/linux/dynamic_debug.h:134:15: note: in expansion of macro ‘pr_fmt’
>    134 |   func(&id, ##__VA_ARGS__);  \
>        |               ^~~~~~~~~~~
> ./include/linux/dynamic_debug.h:152:2: note: in expansion of macro ‘__dynamic_func_call’
>    152 |  __dynamic_func_call(__UNIQUE_ID(ddebug), fmt, func, ##__VA_ARGS__)
>        |  ^~~~~~~~~~~~~~~~~~~
> ./include/linux/dynamic_debug.h:162:2: note: in expansion of macro ‘_dynamic_func_call’
>    162 |  _dynamic_func_call(fmt, __dynamic_pr_debug,  \
>        |  ^~~~~~~~~~~~~~~~~~
> ./include/linux/printk.h:424:2: note: in expansion of macro ‘dynamic_pr_debug’
>    424 |  dynamic_pr_debug(fmt, ##__VA_ARGS__)
>        |  ^~~~~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:697:3: note: in expansion of macro ‘pr_debug’
>    697 |   pr_debug("failed %d to get user pages 0x%llx\n", r, start);
>        |   ^~~~~~~~
>
> Fixes: 702dde19d4b0e7 ("drm/amdkfd: restore userptr ignore bad address error")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: Philip Yang <Philip.Yang@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index ae6694f2c73d..881a91a6ab13 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -694,7 +694,7 @@ int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo, struct page **pages)
>   				       ttm->num_pages, &gtt->range, readonly,
>   				       false, NULL);
>   	if (r)
> -		pr_debug("failed %d to get user pages 0x%llx\n", r, start);
> +		pr_debug("failed %d to get user pages 0x%lux\n", r, start);
>   
>   out_putmm:
>   	mmput(mm);

