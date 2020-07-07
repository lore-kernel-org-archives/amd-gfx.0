Return-Path: <SRS0=Rnur=AS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70675C433E0
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jul 2020 18:36:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A05D206E2
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jul 2020 18:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RSmZqa1Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A05D206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09AB589EAE;
	Tue,  7 Jul 2020 18:36:14 +0000 (UTC)
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com
 [IPv6:2a00:1450:4864:20::141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E60B76E348
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jul 2020 18:27:07 +0000 (UTC)
Received: by mail-lf1-x141.google.com with SMTP id d21so25333654lfb.6
 for <amd-gfx@lists.freedesktop.org>; Tue, 07 Jul 2020 11:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=wBPt5x54bBYdogV1hFFEtw1gjhLQFxpBVjPvTtrmvTg=;
 b=RSmZqa1YghAS6vaMBAw2JHubEKJzTgtLE+VhxkT7eSKzT0Xq+mM6Ir3DEAs4TbQRc4
 GpioK+rA69yVHmKoo7wdpb4N+rpE4gUK/U2PyIdQpcIODuCs/L8on144AtexqXciADeM
 YalX9J21My6ubI2EVk6QYgJA5ttQf/9vgDZNimKE4H5FBveXKWu8GTXx9TIzB4Ut3tSh
 mz+RFGS9tpEK1yGpncLqZAS1UPYtyRfn2jnbjHJkFEaWrMjGgfh2ARVGEBGU+PUrIxiF
 Ym6KTTOdH/f2MJd9ojsz84/SrgohabBJ4TIwXqdhcaiILq/IhKG+sIxpoj0bRIcZAaEp
 l4Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wBPt5x54bBYdogV1hFFEtw1gjhLQFxpBVjPvTtrmvTg=;
 b=qB+nYX6ud5CnKBG3zoBVakXH/wbLPWBOnuxP94y4LxETyg+K7JbBj9RLRjYYMmEc1d
 vG3xu4zoX7s/ofj82JEhL2pkiutSIrOpImqIYB6XVeS1uwmiK6ysEMC4AVMN1gY0quKL
 OJt+q6D8iFzg+au0D8KLvcRrF05sU8vULH/rBA6X5btSOFgU5hY4FPID1truJDdPuyno
 nQ7ZlloA81n3i+aOmsHJZY2LcsW8BXU+d4/MHbeQbZYyTPndWlv59ukqasIiKMKBFZTh
 DBHe8C9CKFJvDGPe2JUqnPCx0RUmkO8hwMChEYhKuntyoCcQfiz9YE49obHiA2i5HeDH
 Bh+Q==
X-Gm-Message-State: AOAM530uVHPWKEg5TtRX9cKaSudFJlY2fB6CSGi11fpUU/cB83bSzEzB
 EVNovNWHUN5B+h9onRwKxVfw0zH4ndbVZzs13TGGlpE34dw=
X-Google-Smtp-Source: ABdhPJxeA6e1+F+DyxNnPoA9HoVxg/PWrc7eA68SARMMJZKkrxrEzKtybmAZC6bmVWXZRXp0wmRTIPrte3wGFgzMblM=
X-Received: by 2002:ac2:5093:: with SMTP id f19mr34340266lfm.10.1594146426142; 
 Tue, 07 Jul 2020 11:27:06 -0700 (PDT)
MIME-Version: 1.0
References: <119ce850-c07f-8a4d-ac3c-78e021b7dd32@amd.com>
 <20200707180430.2760835-1-ytht.net@gmail.com>
 <CADnq5_N4cXHePP3q-4S-mJpkaMKMZRp_e_uB1P5hG-_f06rDyA@mail.gmail.com>
In-Reply-To: <CADnq5_N4cXHePP3q-4S-mJpkaMKMZRp_e_uB1P5hG-_f06rDyA@mail.gmail.com>
From: lepton <ytht.net@gmail.com>
Date: Tue, 7 Jul 2020 11:26:55 -0700
Message-ID: <CALqoU4x-W1EfK8LQhggyhgGCakELsS0opz54RbPA0Cejwke_Eg@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: fix null pointer reference to adev.
To: Alex Deucher <alexdeucher@gmail.com>
X-Mailman-Approved-At: Tue, 07 Jul 2020 18:36:13 +0000
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jul 7, 2020 at 11:22 AM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> On Tue, Jul 7, 2020 at 2:15 PM Lepton Wu <ytht.net@gmail.com> wrote:
> >
> > I hit this when compiling amdgpu in kernel. amdgpu_driver_load_kms fail
> > to load firmwares since GPU was initialized before rootfs is ready.
> > Just gracefully fail in such cases.
> >
> > v2: Check return code of amdgpu_driver_load_kms
> >
> > Signed-off-by: Lepton Wu <ytht.net@gmail.com>
>
> Already fixed:
> https://cgit.freedesktop.org/drm/drm/commit/?id=7504d3bbec7da70516a13e34415b92bf5203399a
Nice, next time I will check drm tree instead of Linus tree for drm
related stuff.
>
> Alex
>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > index 126e74758a34..75bcd1789185 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > @@ -1111,7 +1111,9 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
> >
> >         pci_set_drvdata(pdev, dev);
> >
> > -       amdgpu_driver_load_kms(dev, ent->driver_data);
> > +       ret = amdgpu_driver_load_kms(dev, ent->driver_data);
> > +       if (ret)
> > +               goto err_pci;
> >
> >  retry_init:
> >         ret = drm_dev_register(dev, ent->driver_data);
> > --
> > 2.27.0.212.ge8ba1cc988-goog
> >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
