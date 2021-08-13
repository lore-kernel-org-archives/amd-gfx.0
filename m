Return-Path: <SRS0=hpB+=NE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C63C4338F
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Aug 2021 13:55:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D27360F57
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Aug 2021 13:55:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3D27360F57
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F5EA6E7EA;
	Fri, 13 Aug 2021 13:55:48 +0000 (UTC)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 218036E7EA
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Aug 2021 13:55:47 +0000 (UTC)
Received: by mail-oi1-x231.google.com with SMTP id r5so16008348oiw.7
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Aug 2021 06:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=FR63+3O1oLz4VCTMeP5lba883Yq4+blFGM/hXGUh1+s=;
 b=iW9ahwmOL1KI8FxyVTvfpyNH21RBBOx5RxdiEKQ7mQFkgWnkRJOhT0qItZAMNa8qWe
 P6JqB3D34b5WW7+aZqQiktdsGF1R08eD4QFTo1BGgiP09Ue6Hok0qV9rkNM9nGzb8E2E
 mA2Eh3HZPv3wJAUmTg04YzTYEF6CtH9gVvgaQU1T2cvZ0zdBqBHEdtaEqD/7RDZJ9ZWF
 6eklEoGaH+2NjVtQ/lEW/8vYKsSrFQwHXHG2PKl6R3GlWFovZtgTczMhTMcU5jnuEuGC
 YPwejFPFM/RKlyAf2oMLM1k1kJGdYPYxmydqwTO/RGiax+/ODfvsqMTzzj3zEu8pD34i
 uB2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FR63+3O1oLz4VCTMeP5lba883Yq4+blFGM/hXGUh1+s=;
 b=po+nLDPGieLvCDP0WjoNNvbg82mwL5fRHcnzAqmbvw1vd8DkaY0K9RkukmfhPmkISw
 s3MjwXpxJM0fIPXlnNsicJ63VLudfAMUGi1ke2pbnqeWPJJcMr5jm0WAWYwwEQdlL1ih
 wSGIgcexQzoe35jE2o3rUyAMwlFdzjahynAd0H2EPlCy/IFI05CodHg4bdTa0fV0GCbN
 nzho19oqfUdqe92MoLSchAlV96LQ9SVL5U/7xKXkGpY2PzkfwCY0JMviTDiKIE6K3sMX
 KyLePiX6ZEQg6UxGrf4Xzfc7zxcn1AK8zN8A1MtFj59CHMY+REu4cKKLJh/ORrwNqqjz
 w3Hw==
X-Gm-Message-State: AOAM531OxI6bns6tEwEQhxckw1mQtLOCpcMSBVPZZpXtmd14RA9KHom4
 d/DXY4cJLzsFc5tMkTaErV9m+SwnySMeaJ3GjX0=
X-Google-Smtp-Source: ABdhPJzHXX3otOiQjjssCHjfV7XKAQwXoXsw3DhIoGSDKQtT9GYk2Dbwxl8lXBAHVzwDBs0dvYHkrXvK0kMuldHBO54=
X-Received: by 2002:a05:6808:6d2:: with SMTP id
 m18mr2146474oih.120.1628862946517; 
 Fri, 13 Aug 2021 06:55:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210813080933.1348241-1-evan.quan@amd.com>
 <CADnq5_MFk50m_PCys-pkHxbeSfW90rjxCpmhwNe1jEyouB+KRQ@mail.gmail.com>
In-Reply-To: <CADnq5_MFk50m_PCys-pkHxbeSfW90rjxCpmhwNe1jEyouB+KRQ@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 13 Aug 2021 09:55:35 -0400
Message-ID: <CADnq5_NF-RFPBNqBd_GU0R-XjQzw9_9unYNwnjd6ujNQoD0aPw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: disable BACO support for 699F:C7 polaris12
 SKU temporarily
To: Evan Quan <evan.quan@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Chen,
 Guchun" <Guchun.Chen@amd.com>
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

On Fri, Aug 13, 2021 at 9:54 AM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> Acked-by: Alex Deucher <alexander.deucher@amd.com>
>
> On Fri, Aug 13, 2021 at 4:09 AM Evan Quan <evan.quan@amd.com> wrote:
> >
> > We have a S3 issue on that SKU with BACO enabled. Will bring back this
> > when that root caused.
> >

Actually it might be worth checking the SSIDs as well assuming this is
platform specific.

Alex

> > Change-Id: I56d4830e6275e20a415808896eecbadfe944070b
> > Signed-off-by: Evan Quan <evan.quan@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/vi.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
> > index fe9a7cc8d9eb..7210f80815b8 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/vi.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/vi.c
> > @@ -904,7 +904,12 @@ static bool vi_asic_supports_baco(struct amdgpu_device *adev)
> >         case CHIP_POLARIS11:
> >         case CHIP_POLARIS12:
> >         case CHIP_TOPAZ:
> > -               return amdgpu_dpm_is_baco_supported(adev);
> > +               /* Disable BACO support for the specific polaris12 SKU temporarily */
> > +               if ((adev->pdev->device == 0x699F) &&
> > +                   (adev->pdev->revision == 0xC7))
> > +                       return false;
> > +               else
> > +                       return amdgpu_dpm_is_baco_supported(adev);
> >         default:
> >                 return false;
> >         }
> > --
> > 2.29.0
> >
