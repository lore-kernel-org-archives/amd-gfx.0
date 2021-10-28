Return-Path: <SRS0=JMr/=PQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6EE6C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Oct 2021 15:31:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 940A760D43
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Oct 2021 15:31:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 940A760D43
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F03316E998;
	Thu, 28 Oct 2021 15:31:38 +0000 (UTC)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A83886E998
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Oct 2021 15:31:37 +0000 (UTC)
Received: by mail-oi1-x22e.google.com with SMTP id x8so4506176oix.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Oct 2021 08:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=XKYL5Uh1KcT1H75EH09QEpQOjLF1D3TfW79ZkqCWkMY=;
 b=i0jh2DkWUQbyIaPHbsjys/FDIY+Wm/QKVQzS3fPOhRSz/QNLXXd7/U4s4RwEcVhGiC
 +xmjAYNMjMZZvA48aTVgYPcfx6GD7RE+Wtxt3jF62LTjjQchttgq0DU/ZYb5K+DbhENh
 xWU+wygeDKVvi5HN8RdUlCrR8CKuH2lKjn5ILo6yMjKwLA3bZpIcCHUoXI49tCiLUleh
 dr+VGd8n4+PD0gaM9DRIzCJxliUS4jWVtUJGZ13h9QtAt/5igpXmjHQLxOJTFORN/g1w
 PTIfH8cp2R69misdwRS+B8NWIB6tXG/RqRHXW0dNezh7oFM3SRMGk2Ds/KHRfE3O6DlW
 +GGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=XKYL5Uh1KcT1H75EH09QEpQOjLF1D3TfW79ZkqCWkMY=;
 b=GdCQmVRtNqPsGPETRg1dhSElgYHVO9CzSgqBSOmdlr+xk72/34EY+brZUTUUDnTOOg
 HF3djPXnyRnLROJUT6jPpPJfPmPm8URHXokHkkDuzMMjZgvL2OZmWyzUSIYLUpEpk5IP
 VgRmr0x0MvMwAvLUJhNE6EdIFKI9Xx9adVpo5Q4+/SARaAa8CyolLwc9qAqmyFChIxCf
 1VSnFXREg7WV0KCQ/nVURS5AH95IuvLCmAMgnbDx4rymCPMIWbXFdMLMTmu+/coJ9vEt
 mD3ZYw7CtC0sVeb5nzONDs/NAqq/k7b/3hYl3Ze9N8aRmXtLG3jEp1KRXpBuqFWYr2GS
 daFQ==
X-Gm-Message-State: AOAM533mR2Yr4vBkxRT/1UXtm0F8MkSd0fL5ii7E8w2smUm6uwKoBmCn
 MJc+9l78fcxGXezjd44bvC5encJi0IV3Y9wuLJE=
X-Google-Smtp-Source: ABdhPJwd7WSPUi1LFVOY7eHTrM2FrrCEQQgyg/npdQdvtRA2PpjcpaHee0sgxialJhmV6ORiWjbYLdJtnL41kRWbvgo=
X-Received: by 2002:aca:3f87:: with SMTP id m129mr8972213oia.5.1635435096654; 
 Thu, 28 Oct 2021 08:31:36 -0700 (PDT)
MIME-Version: 1.0
References: <20211028142144.210568-1-alexander.deucher@amd.com>
 <9a249627-87e1-ab04-ce9c-f2e130ca19eb@molgen.mpg.de>
In-Reply-To: <9a249627-87e1-ab04-ce9c-f2e130ca19eb@molgen.mpg.de>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 28 Oct 2021 11:31:25 -0400
Message-ID: <CADnq5_O08ic05m3-B7s3Q6UfenmHADozzgMT1GxuvcepCOrnNA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu/gmc6: fix DMA mask from 44 to 40 bits
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 amd-gfx list <amd-gfx@lists.freedesktop.org>, it+linux-iommu@molgen.mpg.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, Oct 28, 2021 at 11:19 AM Paul Menzel <pmenzel@molgen.mpg.de> wrote:
>
> Dear Alex,
>
>
> On 28.10.21 16:21, Alex Deucher wrote:
> > The DMA mask on SI parts is 40 bits not 44.  Copy
> > paste typo.
> >
> > Fixes: 244511f386ccb9 ("drm/amdgpu: simplify and cleanup setting the dm=
a mask")
>
> This was present in Linux 5.4-rc1. Can it also be the cause of some of
> the crashes with the AMD Ryzen systems like Bug 206487 - Random
> freezes/crashes with enabled C-State C6 - AMD Ryzen [1]? I know, there
> were also some things with Linux 4.19.57, but, if my memory serves
> correctly, they were much more often with Linux 5.4. Some crashes had
> MCE and other did not, some froze the system, some rebooted it.

I doubt it would cause an MCE.  You should just see an IOMMU page fault.

Alex

>
> > Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1762
> > Acked-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> > Tested-by: Paul Menzel <pmenzel@molgen.mpg.de>
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/am=
d/amdgpu/gmc_v6_0.c
> > index 0e81e03e9b49..0fe714f54cca 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> > @@ -841,12 +841,12 @@ static int gmc_v6_0_sw_init(void *handle)
> >
> >       adev->gmc.mc_mask =3D 0xffffffffffULL;
> >
> > -     r =3D dma_set_mask_and_coherent(adev->dev, DMA_BIT_MASK(44));
> > +     r =3D dma_set_mask_and_coherent(adev->dev, DMA_BIT_MASK(40));
> >       if (r) {
> >               dev_warn(adev->dev, "No suitable DMA available.\n");
> >               return r;
> >       }
> > -     adev->need_swiotlb =3D drm_need_swiotlb(44);
> > +     adev->need_swiotlb =3D drm_need_swiotlb(40);
> >
> >       r =3D gmc_v6_0_init_microcode(adev);
> >       if (r) {
> >
>
>
> Kind regards,
>
> Paul
>
>
> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=3D206487
