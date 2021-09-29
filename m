Return-Path: <SRS0=/upn=OT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47C66C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Sep 2021 13:43:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0710B61353
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Sep 2021 13:43:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0710B61353
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FDF56EA81;
	Wed, 29 Sep 2021 13:43:26 +0000 (UTC)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8AE96EA77
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Sep 2021 13:43:24 +0000 (UTC)
Received: by mail-ot1-x336.google.com with SMTP id
 c26-20020a056830349a00b0054d96d25c1eso2871889otu.9
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Sep 2021 06:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8Bfl5hVMJzq2LSZs/qEUqM/2uMkvJ1egKpLTRhsszec=;
 b=ljzDCOXlYIa12kYDuQ4eSYmVhwd2bgO03bkiN2zokj0V4sQVJfFPEpwsDd9+MTSW9l
 S0eXE8k881gM4rWWCWyHsLeof9XjhEmhw1fLkleobfK1YxsyE21Fkmu+QMEZQBvGXwpt
 xknBRwo3wOldemkRPXZAK+AyDElRXPHdQxGTiSHICLYfJ15Bit7oMPHueesMlEofPnQ8
 31faOl0n5RmQeY+ZvDtu6LK712S5Cg1CCE/rDFQh1qnuOHHy6ttJVYbE9McFWfjqWnQV
 dTuUzD2q8zmNjoJ0hhvhvkxf7mt8tt6oVTcYLABqXAWGCRn2C4aVk4L8lQghxE9xgqB3
 SAIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8Bfl5hVMJzq2LSZs/qEUqM/2uMkvJ1egKpLTRhsszec=;
 b=LFQpnbEnrxpLM52/c7ZXot9fhjBzzgugBFFrGUox07ei6o5Z+WBpztwb4/oyIo98+O
 tH71d0z+WE9VDpz67SkeserI7eigJo3uYFBzVbKyM8kLsSGFkwzIRGr6/wnYOMR45bVq
 yF26zWZQGR1iHLl9cgrvy4kmH1eNM7aPVMUZHVCfGo17+JEnVtwtSHh7xQNthEZpFOxj
 jUflaeiDc8n2Tynhtr1VEZgF5ERDIjinlY+xGpNPnGgqGgso764xv/wQzTvU/WxTzLmE
 XYg1NSeIrM2ZwSABKaqMZBu1hB13xm2kT34mdlhnhCj9lcV/YWToUPVufBqrHRGub5Y1
 oCqg==
X-Gm-Message-State: AOAM532yxsgOkJvwptoovbIm9QhbX41qRpHmNlvZo+q7ORuNbriXm0YB
 TPk0m6UOrwvhiYcr9cz4FkalgPNcsQp7dmkYQTPq9XhgKYs=
X-Google-Smtp-Source: ABdhPJy3BgKiZEF48fkU9pdGnuiKTriXBypjzU+NXu9J69Be6MiQKskRbVlFeTDUb15qfpNK1Uv8pnbn4WhGDcGMSWg=
X-Received: by 2002:a9d:6d14:: with SMTP id o20mr30414otp.357.1632923004236;
 Wed, 29 Sep 2021 06:43:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210929092200.783889-1-YuBiao.Wang@amd.com>
In-Reply-To: <20210929092200.783889-1-YuBiao.Wang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 29 Sep 2021 09:43:13 -0400
Message-ID: <CADnq5_O2TSvCV9cEugHGPW787sfMPQzDE9pXCUX-8VoDsJJZOA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/amdgpu: Do irq_fini_hw after ip_fini_early
To: YuBiao Wang <YuBiao.Wang@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>, 
 Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>, Evan Quan <Evan.Quan@amd.com>, 
 Horace Chen <horace.chen@amd.com>, Tuikov Luben <Luben.Tuikov@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Deucher Alexander <Alexander.Deucher@amd.com>, Jack Xiao <Jack.Xiao@amd.com>, 
 Hawking Zhang <Hawking.Zhang@amd.com>, Monk Liu <Monk.Liu@amd.com>,
 Feifei Xu <Feifei.Xu@amd.com>, 
 Kevin Wang <Kevin1.Wang@amd.com>, Jingwen Chen <Jingwen.Chen2@amd.com>
Content-Type: text/plain; charset="UTF-8"
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

On Wed, Sep 29, 2021 at 5:22 AM YuBiao Wang <YuBiao.Wang@amd.com> wrote:
>
> Some IP such as SMU need irq_put to perform hw_fini.
> So move irq_fini_hw after ip_fini.
>
> Signed-off-by: YuBiao Wang <YuBiao.Wang@amd.com>

This looks correct in general, but will this code:
        if (!amdgpu_device_has_dc_support(adev))
                        flush_work(&adev->hotplug_work);
in amdgpu_irq_fini_hw() cause any problems if it gets executed after
the DCE hw has been stopped?  I guess it should be ok.

Alex


> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 4c8f2f4647c0..18e26a78ef82 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3864,10 +3864,10 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
>                 amdgpu_ucode_sysfs_fini(adev);
>         sysfs_remove_files(&adev->dev->kobj, amdgpu_dev_attributes);
>
> -       amdgpu_irq_fini_hw(adev);
> -
>         amdgpu_device_ip_fini_early(adev);
>
> +       amdgpu_irq_fini_hw(adev);
> +
>         ttm_device_clear_dma_mappings(&adev->mman.bdev);
>
>         amdgpu_gart_dummy_page_fini(adev);
> --
> 2.25.1
>
