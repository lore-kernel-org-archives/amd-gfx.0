Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9661CC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Dec 2021 14:44:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 468E4112409;
	Thu, 16 Dec 2021 14:44:16 +0000 (UTC)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2078112409
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Dec 2021 14:44:14 +0000 (UTC)
Received: by mail-ot1-x336.google.com with SMTP id
 i5-20020a05683033e500b0057a369ac614so29213168otu.10
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Dec 2021 06:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+G3HJh3MZWlUqjRSIu5srCjOEfLJjDJKKVI3N5SAZ+c=;
 b=DQoUM/JfHYJobxrTbmoXqf4grHcG6tzoLfSCWqybCufUtbztJk8pNBcr1OT5J3OFsi
 aQilR44ofQeI/VtbBSfOm74egKACBULSdr2bXS7OLcP/vRZWsYsAZ6BaRdRjefYCXc9n
 V0P/JzIGBZlpl8mEAXnL+NcI2i/Ax7/Hp8M0nS4SK5YfboPld/zy0PSUwQUk/OMcHPlW
 8Wgjc2clUnqyBld1DRnIXHkvN8V9Sfi6vDlAxC2kek3GWZ9cZ2OyrgX8zGqe7I+GBzli
 I4JqwDINaB4ky5IoSD3bWcOfbaZaKBGN/52PrhKxS3XcZDgtcdw5izuufNINw8bZvoNF
 gXGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+G3HJh3MZWlUqjRSIu5srCjOEfLJjDJKKVI3N5SAZ+c=;
 b=hlCpw8PfkcKD4Ub7pANredKuQEQpPvmSnPtR4SlW9J5Zs2PQnoCbAHes5NbJRUl5SL
 lU76Hs4galaL99nPrxEibgs26r6aKKuMmAUjy6uhlTiVbRfF2qHKDjsCgVyD/wVCmMnu
 x0Cu2NqzmlwZhnP5ieuGmv0mLEXKUFcd6rU38uVCNGngPy0yicFDjm1C1HoSp/I1bBxf
 S5dNdumai4ZWKKEv4cWNMxIZbBEavOAGVWU6ePIMAv8Fy5p8dYkXHuW0EfvKqg5b5yjD
 pxAwLcK5aK4vCw33zx/EKu82oind1B8/vITiOukW4yhxMf3xUamIFqqxBPO6pIeC9Vxb
 JiVQ==
X-Gm-Message-State: AOAM530QwzzC/uwh9IKYTBiS8EpODcMx6Cj4iy+yJHlwaGsCJrc6C5EG
 9G51X9xGRvkL8R5JsRiWqCyMKfySH9mz43TsKv0=
X-Google-Smtp-Source: ABdhPJxp8To3jd+Htdx5QN1fppHtTldEYOr+vfRMnD2EZI8Xsv02N1efg0J33XI7euxBpdnJFM1JFp9tNlQmrXz8Sqw=
X-Received: by 2002:a9d:67c1:: with SMTP id c1mr13049016otn.299.1639665854124; 
 Thu, 16 Dec 2021 06:44:14 -0800 (PST)
MIME-Version: 1.0
References: <20211214174437.15121-1-surbhi.kakarya@amd.com>
In-Reply-To: <20211214174437.15121-1-surbhi.kakarya@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 16 Dec 2021 09:44:03 -0500
Message-ID: <CADnq5_OJbaB2=xY695BkmfEaKyuFbP+R7pzrwvDXCfiS9aUdJQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/sriov : Check the memory can be accesssed by
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

On Tue, Dec 14, 2021 at 12:44 PM Surbhi Kakarya <surbhi.kakarya@amd.com> wrote:
>
> On SRIOV environment, if event guard is enabled and VF doesn't
> receive an ack from PF for full access, the guest driver load crashes.
> This is caused due to the call to ttm_device_clear_dma_mappings with non-initialized
> mman during driver tear down.
>
> This patch adds the necessary condition to check if the mman initialization passed or not
> and takes the path based on the condition output.

Is this actually sr-iov specific?  I think any failure that happens
before ttm is set up would hit this.  So I think the wording could be
updated to drop the SR-IOV.

Alex

>
> Signed-off-by: skakarya <Surbhi.Kakarya@amd.com>
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
