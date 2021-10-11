Return-Path: <SRS0=iyzK=O7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD93C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Oct 2021 17:36:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7F9860560
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Oct 2021 17:36:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B7F9860560
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F9A76E910;
	Mon, 11 Oct 2021 17:36:00 +0000 (UTC)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CB296E910
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Oct 2021 17:35:59 +0000 (UTC)
Received: by mail-oi1-x234.google.com with SMTP id a3so25620921oid.6
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Oct 2021 10:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=C0LsI7fKZ5eaWIwJmZJf1PUdvBWuj3V6DYvv1ac2PU0=;
 b=Cw5w6o3EnetFzUbZDNZWIz79TBMWKS5tEi4RFq35NtVI9woe7sw0imjLJiGdxLp0t6
 wg//41C2aAP8Gg+kYaGDyjvyFCFFNYWuHLzQhkLhnd3NQVpBG1p4dNca3YqwGHyXV/bf
 2NaOj6JxzuwmZfUA3AO1N5j0rxsU/7ieHsj/bHqudEWN0O4vP8r6IfPw3XW6YqDyBXwa
 Mb3zrxB+4ElN3uT29Td331Ur//psefQwxYhB3OWcW5/uwvfrPR90vLktRXFYrwMH62eu
 12pp6myvnalAjrmlg3PupnlJd4PfuoRCR4eO5P7gmlXVaz7bVQ4JW8te8zgHajl+kUpP
 vyPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=C0LsI7fKZ5eaWIwJmZJf1PUdvBWuj3V6DYvv1ac2PU0=;
 b=FX0cXBWFuFzaCaEW95wgN9eBvuYZBNzIIz8QFdogHamd3F+HaLEJSIVsIFlu07SRWV
 rTejfyZGovPaaEE1mWXqO83iewubJKCVMa/jec2Sk2N6AnQ+/nXd+HWWt5JhwTmTjxT7
 8GNgdkL/bWlFY+WaSvUN2whwuMIV/Vd8N//I94hMcZWQ/zQKFL1rnjH/NScklVAZL4pA
 CALCNIY/fdY9DAH5/DXLixJetYzMEFrEatNQjuS7zOpPIKO3EL0ByL0BwD0IY32F9887
 0OxydyW1GNCgixpdSO5kTvuMbfWL7FDMqfF28FnlL76gZVNVr4VSlyU94NzeZgxrNWLt
 uHtw==
X-Gm-Message-State: AOAM5330X6VsWlk+sn3TzFE+uRNrT2qQ7MQG+0Fl8EzgjtitWQT9hgZl
 BhQAMSKe6nmmo1QgtDq9HeIHxifcyvST/poqneLJ6XdIbKQ=
X-Google-Smtp-Source: ABdhPJxCBrrHbgj4s9F7f7C7Zr+RvabzL6WjL92g5sB237eLhwhM7bHNyGEbUbGzgNR/FJuJQH2t46X+Rfqr7BTeLkU=
X-Received: by 2002:a05:6808:1141:: with SMTP id
 u1mr190507oiu.123.1633973758695; 
 Mon, 11 Oct 2021 10:35:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210928164237.833132-1-alexander.deucher@amd.com>
 <20210928164237.833132-29-alexander.deucher@amd.com>
 <CAHbf0-Egsi3MFD2BQyO1f7kFp8eQAH55bGkCvNauCH3KxR+LbQ@mail.gmail.com>
In-Reply-To: <CAHbf0-Egsi3MFD2BQyO1f7kFp8eQAH55bGkCvNauCH3KxR+LbQ@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 11 Oct 2021 13:35:47 -0400
Message-ID: <CADnq5_NkEAbxBVaEzaViDuyt+QD=y1aqOjNYvdWGDnebvGweKw@mail.gmail.com>
Subject: Re: [PATCH 28/64] drm/amdgpu: drive all navi asics from the IP
 discovery table
To: Mike Lothian <mike@fireburn.co.uk>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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

On Mon, Oct 11, 2021 at 1:20 PM Mike Lothian <mike@fireburn.co.uk> wrote:
>
> Hi
>
> This patch breaks things for me on my Green Sardine & Navy Flounder
> system (Asus ROG G513QY)
>
> It doesn't get past post with amdgpu built in, will try as a module

Can you provide the dmesg output in that case?

Alex


>
> Cheers
>
> Mike
>
> On Tue, 28 Sept 2021 at 17:44, Alex Deucher <alexander.deucher@amd.com> w=
rote:
> >
> > Rather than hardcoding based on asic_type, use the IP
> > discovery table to configure the driver.
> >
> > v2: rebase
> >
> > Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 20 --------------------
> >  1 file changed, 20 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_device.c
> > index 5e0956b19d69..9c47cc636429 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -2142,26 +2142,6 @@ static int amdgpu_device_ip_early_init(struct am=
dgpu_device *adev)
> >                 if (r)
> >                         return r;
> >                 break;
> > -       case  CHIP_NAVI14:
> > -       case  CHIP_NAVI12:
> > -       case  CHIP_SIENNA_CICHLID:
> > -       case  CHIP_NAVY_FLOUNDER:
> > -       case  CHIP_DIMGREY_CAVEFISH:
> > -       case  CHIP_BEIGE_GOBY:
> > -       case CHIP_VANGOGH:
> > -       case CHIP_YELLOW_CARP:
> > -       case CHIP_CYAN_SKILLFISH:
> > -               if (adev->asic_type =3D=3D CHIP_VANGOGH)
> > -                       adev->family =3D AMDGPU_FAMILY_VGH;
> > -               else if (adev->asic_type =3D=3D CHIP_YELLOW_CARP)
> > -                       adev->family =3D AMDGPU_FAMILY_YC;
> > -               else
> > -                       adev->family =3D AMDGPU_FAMILY_NV;
> > -
> > -               r =3D nv_set_ip_blocks(adev);
> > -               if (r)
> > -                       return r;
> > -               break;
> >         default:
> >                 r =3D amdgpu_discovery_set_ip_blocks(adev);
> >                 if (r)
> > --
> > 2.31.1
> >
