Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58942C433F5
	for <amd-gfx@archiver.kernel.org>; Sun, 30 Jan 2022 08:21:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A74810E407;
	Sun, 30 Jan 2022 08:21:36 +0000 (UTC)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A47D10E407
 for <amd-gfx@lists.freedesktop.org>; Sun, 30 Jan 2022 08:21:35 +0000 (UTC)
Received: by mail-ed1-x52d.google.com with SMTP id p7so20270696edc.12
 for <amd-gfx@lists.freedesktop.org>; Sun, 30 Jan 2022 00:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :references:from:in-reply-to:content-transfer-encoding;
 bh=R8oSKR2fqOtppwpgpKYPRb6mDRJ0Vfl0zwFiN+BYYW8=;
 b=lz5Xcu/CzFvjg1Uphul/ad2w8377RhNGeaHQqa+5pQQ9nzONRmiUI/X/TctXfFH/2T
 0Pz7i6oa3L2jq+MsFJ2dvrz1CJQAr+S7NbYYf+W4MKE19NzedCj+CikQGuOK4mLMT/cV
 WmNGPoGgbV5Q7f0HwkD5eHCUHlO4iXFBhBbspEtzGMCgq0I796kQpoxXJph6gwx3Hm/9
 jOtoL4uzRCWU8jcZhpEZ5ZGp0Fbw2iz7BuWDQ6vi76CCeWObJdAEtvHLorc9g3qlE/pC
 NgQzaNpOFg4VYTGmbWOQ+qHAd9SxxAQIc8FfBbp5KLAbuNYCZtEkzlQSLfc7WnMz5WkY
 dJvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:references:from:in-reply-to
 :content-transfer-encoding;
 bh=R8oSKR2fqOtppwpgpKYPRb6mDRJ0Vfl0zwFiN+BYYW8=;
 b=l+mqp0G9GGFf01GwTEOSGmCcWR54/d+FEl8I5SvGHYHY55XUb9/vqKVZZydWCef5JP
 47jtOeeR1UFAlnFhK+BfzI2P8KRfAc2qzWYSPI1jt+b5K9bP+EaHl7H00yfeblp6GKe/
 238bub40RZKtbBHNN3M3GJ6hLHmvBulLJmC8Ym2nBdhD61P0nAARbQ1L4gehiFMyahgK
 3RmhTSfce907J7Glw8Gv3D4yedtViiWUoZsy+iposUvlxgWuxaTnGLKYh1cRH+YF69kc
 xwEtVE1qlsBZfjOhmUT4Utok9uYddgoKSx5cgT2LYEGTEeoUPly/aQy8GX8jLFrYwee+
 TChg==
X-Gm-Message-State: AOAM533b+h2h5SzsH3V0qBWextOQ0vRQiseuw8oRySMQFk6C1xwCojXu
 Flq80uOJE4kNnT/JZYH2HiE=
X-Google-Smtp-Source: ABdhPJwaYKlZb1oLJSgjE/G4onUSlC9gNj/5NPgVr1Q8WSZvP6GrkEtaXiKHNWZny4UhDSmJ5P7vgQ==
X-Received: by 2002:aa7:c6c8:: with SMTP id b8mr15827634eds.37.1643530893464; 
 Sun, 30 Jan 2022 00:21:33 -0800 (PST)
Received: from ?IPV6:2a02:908:1252:fb60:5c9d:2358:3324:cc2a?
 ([2a02:908:1252:fb60:5c9d:2358:3324:cc2a])
 by smtp.gmail.com with ESMTPSA id gc12sm12127263ejb.23.2022.01.30.00.21.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 30 Jan 2022 00:21:33 -0800 (PST)
Message-ID: <07a4c5d1-c7dd-dbf8-1c7b-e363315a97d9@gmail.com>
Date: Sun, 30 Jan 2022 09:21:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] drm/amdgpu: fix list add issue in vram reserve
Content-Language: en-US
To: Tao Zhou <tao.zhou1@amd.com>, amd-gfx@lists.freedesktop.org,
 hawking.zhang@amd.com, stanley.yang@amd.com, yipeng.chai@amd.com,
 john.clements@amd.com
References: <20220130073742.17173-1-tao.zhou1@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20220130073742.17173-1-tao.zhou1@amd.com>
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

Am 30.01.22 um 08:37 schrieb Tao Zhou:
> The parameter order in the list_add_tail is incorrect, it causes the
> reuse of ras reserved page.
>
> Signed-off-by: Tao Zhou <tao.zhou1@amd.com>

Good catch, Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> index 7a2b487db57c..6c99ef700cc8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> @@ -281,7 +281,7 @@ int amdgpu_vram_mgr_reserve_range(struct amdgpu_vram_mgr *mgr,
>   	rsv->mm_node.size = size >> PAGE_SHIFT;
>   
>   	spin_lock(&mgr->lock);
> -	list_add_tail(&mgr->reservations_pending, &rsv->node);
> +	list_add_tail(&rsv->node, &mgr->reservations_pending);
>   	amdgpu_vram_mgr_do_reserve(&mgr->manager);
>   	spin_unlock(&mgr->lock);
>   

