Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD756C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Jan 2022 14:04:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95A2210F3BC;
	Mon, 10 Jan 2022 14:04:42 +0000 (UTC)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 820A810F3F1
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Jan 2022 14:04:41 +0000 (UTC)
Received: by mail-ot1-x332.google.com with SMTP id
 h5-20020a9d6a45000000b005908066fa64so14228052otn.7
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Jan 2022 06:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=gR98uCcUz12d4QD94j+QBkM5RuHoZRMeMGmKx7U9sbw=;
 b=EsU1xvkbUvfREx765iDZLzP0yT9d7X3uNvBaBYoEwK4+ps67rGgn7LCTuxEJvc+AzD
 wr0pIaELWxXUNp4PTjNCSKfeuJ1lbP9dtZc8y8R+SRCa6UsPFvOaU+eQglMJ014O0BXS
 Oeg1kqGh7Jh3AbLUU1etW3z8mEkjts4L8B79R86+MTSdg9m2wcBy2abVZfKpZtRvAwiM
 VzGdL9rRuBe37N11XJ0hOpSqK1bT2N+PlxBuCUoOXhNn1FijNi+akIDEfnXRm58QkAgy
 OfZRRDygx4vup8mTSjepbKP8n0BZeZDWPfLcjf8lCazC0s8zgm7sDSRgdofNMPC1gP+P
 veuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=gR98uCcUz12d4QD94j+QBkM5RuHoZRMeMGmKx7U9sbw=;
 b=G6hYKgtty0B5NE7fegFtG9WtN1aveatjzlGrdGimaI0oeqOTqM4cseYEb9IdFJkkI2
 VJMjV/J8lIxET3wKFW6YgjIjxmHmFkRS37PbLH8PyXbtC8Xq8JGo5Laxe25+ukzyCSBv
 6pm9ROZMZXG9oWvQpN0i1qgd5C+LAKi6KzU/Nwh0oasvTI3BM7sT5ZBVFKOT1jGFIaaP
 TDmGUxxsqUGzoeUo1wGxa/M48Sh4WHM4IngHqJyHEUPQaNo83QSq8IIQ+PYo84Q4ZKgD
 OJ5NC3qitkD/3+3F50Un8PrYKxpkc3TTmq6zjuzFJqC15W++7Jbvy7ECvyaAvOiwWhBy
 tfMQ==
X-Gm-Message-State: AOAM5326uGQdE8dcPbRC9CM3AvcL8H/5XctSVj7zn0BPtfRAZIq3pCtn
 RbXFbbZom+OtGLmADUJ+OgReJV1vFIz7u4bs2b8=
X-Google-Smtp-Source: ABdhPJxR+NODh8B0utS9N334ZpLoYEwiNnAgeC5Y77ZmHXkCkN/98VfhasJbdOVpc8E3cfbylbrGdvtRfhA2XuE+9bY=
X-Received: by 2002:a9d:f09:: with SMTP id 9mr10157537ott.299.1641823480730;
 Mon, 10 Jan 2022 06:04:40 -0800 (PST)
MIME-Version: 1.0
References: <20220107120740.1041489-1-tom.stdenis@amd.com>
 <CADnq5_Puzsx67iFTxzitLCQ0EOBUm0Db-dn2Yj-N8XTNVWbGeg@mail.gmail.com>
 <BN9PR12MB5257EA84DCA357DCEAEA8E88FC4F9@BN9PR12MB5257.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB5257EA84DCA357DCEAEA8E88FC4F9@BN9PR12MB5257.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 10 Jan 2022 09:04:29 -0500
Message-ID: <CADnq5_NvmuvY6uHqeWaY72JJ2AbJqv5Tp0H0_rNOc6qu7FQhmg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/amdgpu: Add pcie indirect support to
 amdgpu_mm_wreg_mmio_rlc()
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>
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
Cc: "StDenis, Tom" <Tom.StDenis@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Sun, Jan 9, 2022 at 5:27 AM Zhang, Hawking <Hawking.Zhang@amd.com> wrote=
:
>
> [AMD Official Use Only]
>
> RE - Actually, for older asics, we shouldn't we be using mmINDEX/mmDATA r=
ather than the pcie indirect registers?  Or is that handled already somehow=
?
>
> I remember we checked this with hw team before (might two years ago when =
make the change in amdgpu_device_rreg/wreg helper). The answer was it is sa=
fe to retire mmINDEX/DATA approach for SI and onwards. PCIE_INDEX/DATA shou=
ld be good enough for indirect access in amdgpu driver. For radeon driver, =
mmINDEX/mmDATA shall still be kept.
>

Thanks for the confirmation.

Alex

> Regards,
> Hawking
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex D=
eucher
> Sent: Sunday, January 9, 2022 05:13
> To: StDenis, Tom <Tom.StDenis@amd.com>
> Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
> Subject: Re: [PATCH] drm/amd/amdgpu: Add pcie indirect support to amdgpu_=
mm_wreg_mmio_rlc()
>
> On Fri, Jan 7, 2022 at 7:07 AM Tom St Denis <tom.stdenis@amd.com> wrote:
> >
> > The function amdgpu_mm_wreg_mmio_rlc() is used by debugfs to write to
> > MMIO registers.  It didn't support registers beyond the BAR mapped
> > MMIO space.  This adds pcie indirect write support.
> >
> > Signed-off-by: Tom St Denis <tom.stdenis@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > index c38e0e87090b..53a04095a6db 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -552,7 +552,7 @@ void amdgpu_device_wreg(struct amdgpu_device
> > *adev,  }
> >
> >  /**
> > - * amdgpu_mm_wreg_mmio_rlc -  write register either with mmio or with
> > RLC path if in range
> > + * amdgpu_mm_wreg_mmio_rlc -  write register either with
> > + direct/indirect mmio or with RLC path if in range
> >   *
> >   * this function is invoked only the debugfs register access
> >   */
> > @@ -567,6 +567,8 @@ void amdgpu_mm_wreg_mmio_rlc(struct amdgpu_device *=
adev,
> >             adev->gfx.rlc.funcs->is_rlcg_access_range) {
> >                 if (adev->gfx.rlc.funcs->is_rlcg_access_range(adev, reg=
))
> >                         return adev->gfx.rlc.funcs->sriov_wreg(adev,
> > reg, v, 0, 0);
> > +       } else if ((reg * 4) >=3D adev->rmmio_size) {
> > +               adev->pcie_wreg(adev, reg * 4, v);
>
> Actually, for older asics, we shouldn't we be using mmINDEX/mmDATA rather=
 than the pcie indirect registers?  Or is that handled already somehow?
>
> Alex
>
> >         } else {
> >                 writel(v, ((void __iomem *)adev->rmmio) + (reg * 4));
> >         }
> > --
> > 2.32.0
> >
