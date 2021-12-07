Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF0D3C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Dec 2021 22:16:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 689D96E81A;
	Tue,  7 Dec 2021 22:16:55 +0000 (UTC)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF00C6E81A
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Dec 2021 22:16:53 +0000 (UTC)
Received: by mail-oi1-x235.google.com with SMTP id bj13so1273463oib.4
 for <amd-gfx@lists.freedesktop.org>; Tue, 07 Dec 2021 14:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=IJHplGqshKPuJNLXL8/0JWzrveBjlnnE07Qd8olV950=;
 b=Fvn/oBWDwQz3r5Sr/x5yme+v71rGP7t8+jVB2CpJlwLgoQAIUTDxTFMQmbrZ+qH/H8
 Chn3gYedlyUSpebIrXJ251htwVUYxrvISy+QwmfRpksU/yMuZikt6deWmQ+jUuxV5XAb
 pSzr5cZOS/v/MLO13BiOuNjxbtFnuNAnE95aj0yIvS8ZB55jEl8vHvZ3hEjyahwL3Wc+
 jZTF34PM85WmmXHlFWiu21zYnVHxwn43q3H3wtSkMpHeBU62+3Zbcw3VVmG3+sXK82ap
 NTHh9PPD82QEe6UuDtmrrXfcIT/Lisx1peJQH67oGHleiwoEJBqLioy5teSgjHhaRboR
 p2Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=IJHplGqshKPuJNLXL8/0JWzrveBjlnnE07Qd8olV950=;
 b=yZ6KYYBbgFiH3z4m0pA8pCW5rQ4WxCYK36uvfCLXNg5jjp3WqaGUlNzM0rk1A5gOiv
 ZlTaiK3oE/pqUro0BJzaZjCG/NrqkdtP3CByszGUX6RwwMv7b5UYTkLFWNcm/oz7JBOY
 2U/+rX/Bir9CLFGjDL1w9lTqMrlxFSC7p/k0a6t7/4mxKi+D+AsJ0YTZQuPdOIICKEZt
 r/S4wk0nS1jZJkhs7ixKdFUhyUpTHaEs83d/pSgYj7zh3CDOT+EsdpxlRyQ/gW5WR6hH
 8mAmzyRCidUmvQQr4toAU40drjACdly4MXuW6p5V9mMys/ldA0OjTwjzijxj2HYUP3oW
 gz/w==
X-Gm-Message-State: AOAM532b/PJDmE+6tgwpJGA6huj8fai5kDJz+H/KKsz8wh2lQKwJ+Fon
 kY4eTG8k6495npBzqYljxkj3gM7iE2x4hJuMlHU=
X-Google-Smtp-Source: ABdhPJzHtM6nHaaTiemveXK8yyJ1kEh5SN9I/sFskmbBEHpFnjSTTvj+LM03aptgxWNKKTXwYTLK1/f8DOzOEkqt91Q=
X-Received: by 2002:a05:6808:44:: with SMTP id
 v4mr7856966oic.123.1638915413005; 
 Tue, 07 Dec 2021 14:16:53 -0800 (PST)
MIME-Version: 1.0
References: <20211207145911.2690-1-Philip.Yang@amd.com>
 <4e277e05-4bf0-3f24-a28f-6ac7b33b45b4@amd.com>
In-Reply-To: <4e277e05-4bf0-3f24-a28f-6ac7b33b45b4@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 7 Dec 2021 17:16:42 -0500
Message-ID: <CADnq5_NkeJsOC_bW2xW7V-aNKd3hhOZ-JmGz0-4gf6QZM2c-ew@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: Detect if amdgpu in IOMMU isolation mode
To: Felix Kuehling <felix.kuehling@amd.com>
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
Cc: Philip Yang <Philip.Yang@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Dec 7, 2021 at 4:59 PM Felix Kuehling <felix.kuehling@amd.com> wrote:
>
> On 2021-12-07 9:59 a.m., Philip Yang wrote:
> > If host and amdgpu IOMMU is not enabled or IOMMU is pass through mode,
> > dma_map_page return address is equal to page physical address, use this
> > to set adev->iommu_isolation flag which will be used to optimize memory
> > usage for multi GPU mappings.
> >
> > Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  2 ++
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 27 ++++++++++++++++++++++
> >   2 files changed, 29 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > index c5cfe2926ca1..fbbe8c7b5d0c 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > @@ -1097,6 +1097,8 @@ struct amdgpu_device {
> >
> >       struct amdgpu_reset_control     *reset_cntl;
> >       uint32_t                        ip_versions[MAX_HWIP][HWIP_MAX_INSTANCE];
> > +
> > +     bool                            iommu_isolation;
> >   };
> >
> >   static inline struct amdgpu_device *drm_to_adev(struct drm_device *ddev)
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > index 3c5afa45173c..6d0f3c477670 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -3364,6 +3364,31 @@ static int amdgpu_device_get_job_timeout_settings(struct amdgpu_device *adev)
> >       return ret;
> >   }
> >
> > +/**
> > + * amdgpu_device_check_iommu_isolation - check if IOMMU isolation is enabled
> > + *
> > + * @adev: amdgpu_device pointer
> > + *
> > + * device is in IOMMU isolation mode if dma_map_page return address is not equal
> > + * to page physical address.
> > + */
> > +static void amdgpu_device_check_iommu_isolation(struct amdgpu_device *adev)
> > +{
> > +     struct page *page;
> > +     dma_addr_t addr;
> > +
> > +     page = alloc_page(GFP_KERNEL);
> > +     if (!page)
> > +             return;
> > +     addr = dma_map_page(adev->dev, page, 0, PAGE_SIZE, DMA_BIDIRECTIONAL);
> > +     if (dma_mapping_error(adev->dev, addr))
> > +             goto out_free_page;
> > +     adev->iommu_isolation = (addr != page_to_phys(page));
> > +     dma_unmap_page(adev->dev, addr, PAGE_SIZE, DMA_BIDIRECTIONAL);
>
> This is a bit of a hack. Unfortunately it seems there isn't a much
> better way to do this. I guess you could copy the implementation of
> dma_map_direct in kernel/dma/mapping.c, but that's more brittle.
>
> I think this hack only tells you whether system memory is direct-mapped.
> The answer may be different for peer VRAM (which isn't supported
> upstream yet, but it's coming). I think this can happen when the IOMMU
> is in pass-through mode by default but still used to DMA map physical
> addresses that are outside the dma mask of the GPU. So a more future
> proof way would be to store a direct-mapped flag for each GPU-GPU and
> GPU-System pair somehow. For the GPU->GPU direct mapping flag you'd need
> to try to DMA-map a page from one GPU's VRAM to the other device.
> Anyway, that can be done in a later change.
>
> For now I'd just change the name of the flag from iommu_isolation to
> direct_map_ram or ram_is_direct_mapped or similar to be more specific
> about what it means.

This thread might be useful:
https://lists.freedesktop.org/archives/dri-devel/2021-November/330557.html
https://lists.freedesktop.org/archives/dri-devel/2021-November/330583.html

Alex

>
> Regards,
>    Felix
>
>
> > +out_free_page:
> > +     __free_page(page);
> > +}
> > +
> >   static const struct attribute *amdgpu_dev_attributes[] = {
> >       &dev_attr_product_name.attr,
> >       &dev_attr_product_number.attr,
> > @@ -3767,6 +3792,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
> >               queue_delayed_work(system_wq, &mgpu_info.delayed_reset_work,
> >                                  msecs_to_jiffies(AMDGPU_RESUME_MS));
> >
> > +     amdgpu_device_check_iommu_isolation(adev);
> > +
> >       return 0;
> >
> >   release_ras_con:
