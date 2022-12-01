Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 430C3C43217
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Dec 2022 20:28:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47DF110E157;
	Thu,  1 Dec 2022 20:28:25 +0000 (UTC)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 345DA10E157
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Dec 2022 20:28:21 +0000 (UTC)
Received: by mail-oi1-x231.google.com with SMTP id e205so3245500oif.11
 for <amd-gfx@lists.freedesktop.org>; Thu, 01 Dec 2022 12:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lJc4HIJxpTsJbXXJtzYwpDjAQEMTKZohr+b8gbcdv5g=;
 b=QTFyE7fs5uernv7ZxOzPAzzdauq8HBaYeqlT0M6C1OtsyD5icArSoRjPvtZ6iFWzqg
 aQf34CGbBMJOE8qSu6dJDIiT0i7IDyEthDOOIx5mIfpklLAnyRofHp08WDa7X1BJaBUj
 HwIPhASWDbuOkGP3BN5ohHhafgS/UWJcbIjERTR1CVY1cZbpaelobkqTcQTMhh7mAVa+
 wgqgNzIWnnjVQm+ZaHXawhny/+zqhhsuB6AR4kaCwh8Z/dYjgcFGcDN+PDMRHpSrCfWs
 23DAymwK/7MajllCJubvblsni/RwSeobDwPfSJ2jhZxYC6e5EsuDbrYCJRx7v3ZnrzbL
 +mXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lJc4HIJxpTsJbXXJtzYwpDjAQEMTKZohr+b8gbcdv5g=;
 b=JsZfjj4ffx36iTsx8Sx9Q3ZKAwi79FJ6MEhC2L9vcuPWqGOb08W9RCH5greO521+Dj
 TkLZkA/WqyLzaLgg3KPdvwBckgyAvqCuU84QrTD88AdEZy2n01pQKBO/PYC7fXvjm81u
 umt/lT9QrOELUoq21G2TasVbgrqrboupTkl4dilh2xvimCSJXkHGdr2XKmSCGF3LjxTy
 qdjd/5CjZgXPgW+P+z9basIjUvbTuucOxjeNd995YEdCH4nY4tkMJG7MWak13Ej4hXlT
 yEJzKEdSxYunZcX7EL9xm6KiTlaIB/es+SXTsp3Y9J08gnY0O6LiAjEIwjxEGHVoMrlE
 UbHA==
X-Gm-Message-State: ANoB5plaLgqX6ge6RkYdJxxGHDjXHqNgaY26Z8lrlDpKgKN3TdNbqsrG
 ju9In7aVnsmxrruQ3C8ja4+G/m8PjmQu8nJcMR8=
X-Google-Smtp-Source: AA0mqf79enL1xpLhwzpJ0nsjnpRG4cDODCraXG4/qxRuiwZzCnPZWZgjjlQl0bnRm5XMyolr6tJyAf0U+G20xqSmw7s=
X-Received: by 2002:aca:d17:0:b0:35b:c9e7:b124 with SMTP id
 23-20020aca0d17000000b0035bc9e7b124mr6531770oin.46.1669926500407; Thu, 01 Dec
 2022 12:28:20 -0800 (PST)
MIME-Version: 1.0
References: <20221201162309.3112713-1-alexander.deucher@amd.com>
 <774af616-0781-a4fb-116b-9d5da9a78fa7@amd.com>
In-Reply-To: <774af616-0781-a4fb-116b-9d5da9a78fa7@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 1 Dec 2022 15:28:08 -0500
Message-ID: <CADnq5_On-e_=SELkL7fJmKCRajP4AetN10=Gst2u_r+VNW6PVA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: add GART, GPUVM, and GTT to glossary
To: Luben Tuikov <luben.tuikov@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, bellosilicio@gmail.com,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Dec 1, 2022 at 12:20 PM Luben Tuikov <luben.tuikov@amd.com> wrote:
>
> On 2022-12-01 11:23, Alex Deucher wrote:
> > Add definitions to clarify GPU virtual memory.
> >
> > Suggested-by: Peter Maucher <bellosilicio@gmail.com>
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  Documentation/gpu/amdgpu/amdgpu-glossary.rst | 21 ++++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> >
> > diff --git a/Documentation/gpu/amdgpu/amdgpu-glossary.rst b/Documentation/gpu/amdgpu/amdgpu-glossary.rst
> > index 326896e9800d..944ebcef1d28 100644
> > --- a/Documentation/gpu/amdgpu/amdgpu-glossary.rst
> > +++ b/Documentation/gpu/amdgpu/amdgpu-glossary.rst
> > @@ -30,12 +30,33 @@ we have a dedicated glossary for Display Core at
> >      EOP
> >        End Of Pipe/Pipeline
> >
> > +    GART
> > +      Graphics Address Remapping Table.  This is a GPUVM page table that maps
> > +      system resources (memory or MMIO space) into the GPU's address space so
> > +      the GPU can access them.  In the GPU kernel driver's virtual address
> > +      space is referred to as the GART for legacy reasons going back to AGP
> > +      and the early GPU remapping hardware.
> > +
>
> I'd probably mention that this is an actual IOMMU IP.

Ack.

>
> >      GC
> >        Graphics and Compute
> >
> >      GMC
> >        Graphic Memory Controller
> >
> > +    GPUVM
> > +      GPU Virtual Memory.  The GPU supports multiple virtual address spaces
> > +      that can be in flight at any given time.  These allow the GPU to remap
> > +      VRAM and system resources into GPU virtual address spaces for use by
> > +      the GPU kernel driver and applications using the GPU.  These provide
> > +      memory protection for different applications using the GPU.
> > +
>
> I'd probably add something like:
>
> "... These allow the GPU to remap VRAM, using GMC, and system resources,
>      using AGP or GART, into GPU virtual address spaces ..."

Well, that's not entirely true.  The GPUVM address space is unified so
you can map a vram page next to a system ram page.  The only
difference is how you set up the PTEs.  We just happen to set up VMID
0 (the kernel driver's GPUVM) slightly differently due to some
extended capabilities in that context.  But you could map vram via the
GART (vmid 0) page table if you wanted to.  AGP isn't really a thing
anymore, but we still have the aperture on the GPU, but we use it for
other things now.

>
> > +    GTT
> > +      Graphics Translation Tables.  This is a memory pool managed through TTM
> > +      which provides access to system resources (memory or MMIO space) for
> > +      use by the GPU. These addresses can be mapped into the GART GPUVM page
> > +      table for use by the kernel driver or into per process GPUVM page tables
> > +      for application usage.
> > +
>
> I'd probably clarify this simply by adding something like:
>
> "This is system memory, mapped by GART or AGP, into the GPUVM, for access by the GPU."
>
> I'm ambivalent if you want to add these, but it might make things clearer, as I'd
> struggled with what something is, as opposed to what it does.

I'll see if I can clarify things a bit more.

>
> Having said this, this patch is generally,
>
> Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>
>
> Thanks for doing this.

Thanks!

Alex

>
> Regards,
> Luben
>
> >      IH
> >        Interrupt Handler
> >
>
