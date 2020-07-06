Return-Path: <SRS0=Hy8X=AR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88832C433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jul 2020 16:06:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B00920722
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jul 2020 16:06:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mlqIbKZz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B00920722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35C0489F43;
	Mon,  6 Jul 2020 16:06:50 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 668FB89F33;
 Mon,  6 Jul 2020 16:06:48 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id z2so19382505wrp.2;
 Mon, 06 Jul 2020 09:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=xCr/E2UfpfNx/3DS3JnlJgbuc+JNeFMMCFYGgSgWR/I=;
 b=mlqIbKZzvsR8H7X+H3bWpRjyAvsFIRS7m9r+3QwodLOn4YLUv8Iv41WHDpQB5yUkhe
 rvARNPXNxp2vv0Cui6XM1E9maK1sklAJEpEQYTy72veFM3wieR6hrtR1tUDo2xLwZvjX
 ApuE7mzTEliYkyWYR1gYrHsrGR552XeqmKHOQ2BT2RvjgrY7m0/LKar0xOLch/1pRJ80
 j6dqdSzcTHkQR0kQqPfa0K7VP08nUDsNHt18Vm7MnRMcP+GF1884ivyrWt8omJ0XxImN
 uZIDaAt25iNtHSywPtSpQMhz7fDCIJ+/Of/um4AV0s87aOoofiK5pXTZe/WRl/Sg/6Ck
 5sXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xCr/E2UfpfNx/3DS3JnlJgbuc+JNeFMMCFYGgSgWR/I=;
 b=cUMNRuDeq7tRjeUQjHbPS8ZoRi0O5/f/JX39Pc8hFc05ArMQ0T2ycF+gDyzjubVO5b
 URkEcbjFIUgu/Xt7KVucqfe0x+pdHT10M5J2B3Ik37aRLn5oQzORFNGvBBrQsdWnoWRu
 LVimwal7mnrROWXIYynEgEhNtKFF5z5swplSYDloB5bIP8AUUJVI2zstVExawpUHPNXR
 rE3EvKpL1ilajRRM02po5G3OP02ZUz0VkQUi5D43EfDtDkulk/a6Pe85yzI9Z/MvaCSE
 LNYXpex96u/gWkPD37lqLh8F7uXyebGoXwSeePWsUyF+VjD91FwQAtIBz/+izaD4PiZW
 S6Rg==
X-Gm-Message-State: AOAM5318kt8GuQhi1OfuwKQQAIVGhszQhF0nlGeng0H/YlmscX02OFv0
 qwi8+5lVcEPwB5hZoXGV6cY9QReDUOBPLQ9VxVs=
X-Google-Smtp-Source: ABdhPJxdm0SXjqdvnZSqVXcNs0zZL+fxT8CbYJGVE6ad2dBa9So/9NH/7pLse8Fajv9YZRRN3Dtr8tqXQjjPfoZIRfs=
X-Received: by 2002:adf:fa89:: with SMTP id h9mr48658791wrr.120.1594051607057; 
 Mon, 06 Jul 2020 09:06:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200702015552.42377-1-yuehaibing@huawei.com>
In-Reply-To: <20200702015552.42377-1-yuehaibing@huawei.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 6 Jul 2020 12:06:36 -0400
Message-ID: <CADnq5_M35jhfPDCGaYxYBxMcptVJjcXw5qSy-PLTh0Z8vjSFZA@mail.gmail.com>
Subject: Re: [PATCH -next] drm/amdgpu: remove set but not used variable 'adev'
To: YueHaibing <yuehaibing@huawei.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Dave Airlie <airlied@linux.ie>, "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 tiancyin <tianci.yin@amd.com>, kernel-janitors@vger.kernel.org,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Gerd Hoffmann <kraxel@redhat.com>,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Likun Gao <Likun.Gao@amd.com>, linux-media <linux-media@vger.kernel.org>,
 Christian Koenig <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Jul 2, 2020 at 3:25 AM YueHaibing <yuehaibing@huawei.com> wrote:
>
> Fixes gcc '-Wunused-but-set-variable' warning:
>
> drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c: In function 'amdgpu_init_mem_type':
> drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:81:24: warning:
>  variable 'adev' set but not used [-Wunused-but-set-variable]
>   struct amdgpu_device *adev;
>                         ^
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

With our current -next tree, this patch is no longer applicable.

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index bb95627ad2cc..8199702d3354 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -78,10 +78,6 @@
>  static int amdgpu_init_mem_type(struct ttm_bo_device *bdev, uint32_t type,
>                                 struct ttm_mem_type_manager *man)
>  {
> -       struct amdgpu_device *adev;
> -
> -       adev = amdgpu_ttm_adev(bdev);
> -
>         switch (type) {
>         case TTM_PL_SYSTEM:
>                 /* System memory */
>
>
>
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
