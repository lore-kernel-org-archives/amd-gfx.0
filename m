Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBF03C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Dec 2021 16:33:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FC5E10E50D;
	Fri, 17 Dec 2021 16:33:17 +0000 (UTC)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04E3B10E4B7
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Dec 2021 16:33:17 +0000 (UTC)
Received: by mail-oo1-xc34.google.com with SMTP id
 w15-20020a4a354f000000b002d85ef0533dso869266oog.7
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Dec 2021 08:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=JoLqhiAZUdk9zxMymKLeAB8TGnNtDlLUwV5DVovBCDE=;
 b=gYyviewrZiW5M/Y8hE+scUDePUZLVW8SE4fFiJKCteITKiGAx09qYxX4BlNMcE8tdU
 MmsdnINtJy0WkBD6PixYT8TTIBmPkF5DudtLtxwRMqxL2geMB5HiIlOlXVdG2YynyRVQ
 iBlSfWMbd/TrclkiA26b/fzWYATMEZUCd+77NlTLyiSL9dyJ6TRK+xho24GlgdO4jq6+
 HuUNqOZFfcveJm9W+TudDUHfOnBXXPrSi9HYAGBnHfP70dgSHjvlFTAghjb9UakVwwHR
 q6UIChPNtHKr6edAKoxB7E335dalR5et+42bfNvlK0RGP03P9kecavbt20xSLXRRvN3r
 CC+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JoLqhiAZUdk9zxMymKLeAB8TGnNtDlLUwV5DVovBCDE=;
 b=XVbFS4ZzB9wxoxeKdIcrUC/qPeG45rAE6mCTI6m1k80ZxQUGofJCKYjs/6ceV7KtmI
 /Tom6393ILd77l9H4KJ+Fo4wk7JvNkJqVDlFnwvSBBwk8ilpz8Q5S6S4vI7Rj26SQGZu
 9B8yXRiiSeddsYkVgxRVgDZ37SB5qs34KriYftV7Wec/dlbNUdiZD+VNp1d5Svch68sd
 ba9Qc37ad95pL+s2MX55bIvlybiTahokpH9rRMZf70RqvmAYvEP91ESH6NsrBWUBJMQu
 WXIkrlnmqA1DCtBlo6TUMqVBTJh5dSFiwQdhyFkH+xlOuCrEhaM1tuLrITcKd2cG0oAN
 Irxg==
X-Gm-Message-State: AOAM5316zPfUOKUStRX9o0VmtIS3psz5wqiYCXh4oQZv41M7W91ahftw
 nAIDGFxmBxHB6whOSgnF1uebjqWtj/603/Tgf9s=
X-Google-Smtp-Source: ABdhPJyX3/KrHCzOM4bP+NNOXaTq75FGsYdY99NSAH/qtDc6whZ/+sUf8lFIBdwYLIe8uh9kaXjBUFhDo7t2rLKNqSA=
X-Received: by 2002:a4a:9568:: with SMTP id n37mr2437047ooi.73.1639758796277; 
 Fri, 17 Dec 2021 08:33:16 -0800 (PST)
MIME-Version: 1.0
References: <20211216152533.2131-1-surbhi.kakarya@amd.com>
In-Reply-To: <20211216152533.2131-1-surbhi.kakarya@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 17 Dec 2021 11:33:05 -0500
Message-ID: <CADnq5_O9b1_tfZUaQutBEKPOEe36DBF-Z2iNEr4sp48D=f8AZw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Check the memory can be accesssed by
 ttm_device_clear_dma_mappings.
To: Surbhi Kakarya <surbhi.kakarya@amd.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Bokun Zhang <Bokun.Zhang@amd.com>, "monk.liu" <Monk.Liu@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "Chang,
 HaiJun" <HaiJun.Chang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Dec 16, 2021 at 10:25 AM Surbhi Kakarya <surbhi.kakarya@amd.com> wrote:
>
> If the event guard is enabled and VF doesn't receive an ack from PF for full access,
> the guest driver load crashes.
> This is caused due to the call to ttm_device_clear_dma_mappings with non-initialized
> mman during driver tear down.
>
> This patch adds the necessary condition to check if the mman initialization passed or not
> and takes the path based on the condition output.
>
> Signed-off-by: skakarya <Surbhi.Kakarya@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> Change-Id: I1c18c7eb3500687c8b6e7fc414503dcf2a20b94c
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 598250a380f5..226110be7a2f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3984,7 +3984,8 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
>
>         amdgpu_irq_fini_hw(adev);
>
> -       ttm_device_clear_dma_mappings(&adev->mman.bdev);
> +       if (adev->mman.initialized)
> +               ttm_device_clear_dma_mappings(&adev->mman.bdev);
>
>         amdgpu_gart_dummy_page_fini(adev);
>
> --
> 2.25.1
>
