Return-Path: <SRS0=iyzK=O7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B6AC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Oct 2021 23:16:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AB6E60EFE
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Oct 2021 23:16:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1AB6E60EFE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fireburn.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B2B46E97A;
	Mon, 11 Oct 2021 23:16:50 +0000 (UTC)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 314D86E97A
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Oct 2021 23:16:49 +0000 (UTC)
Received: by mail-qv1-xf31.google.com with SMTP id a16so11904005qvm.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Oct 2021 16:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=alQoqYS87XsmrPb6USyoK3tyWrIi9Vh7/OxBBaRU6IY=;
 b=op4usZwXpLQtb76sg9kV2EdZobFqEHX4v5UilYOuAy1AbrwcO5KdJQvZHzkURCjA/j
 JIjC/m3BkNN4J8yxu9BrSZ3IeYVlDqHd2/k0i/C+kp44cJoZNriARjoVb2cCnA0nSGS/
 HrBZ4EWf80BxAZ3w2BkudQ0LlcRuHPS3po+qk+PItwx7NzR5b07uwg7tnEAkeHyZPJnW
 OPDoIUDdXFJuN/aWWEyZbsGJHRm5To2R5uRg6v2Ud+hcVQO/lcne8om9/QNJl4qENfFJ
 15KgaVrLxkE+sy8EiMgoEZsIx9H8kdF2uqtg07pMEUr3iXnh2+l43KTc60MCfxxMkFbM
 bYbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=alQoqYS87XsmrPb6USyoK3tyWrIi9Vh7/OxBBaRU6IY=;
 b=v2rPRH29rJI0EtYxFAEOS7l+aP6HzggYi9LtytldnynSAKRRzI+5kDE/iCUbe1AxDc
 kG8Z57t8jbT/6rTYUBpUB54rJMyKPHNjig0EqsUrOF/fyX9Yji0CoQHWYl6ln9ZXKUvy
 58KstQIyb/EckfrzuOOPuVlDrp0RfpCEAW9rcmF2rfsBHqDWa7TT4Y/VF7hNrNcKMvG0
 DHiz/EXBs6ePWRc/7gG8+KOw89AfYZY5BVd9dilTW39hEjIqYzmCC0pBnL028CT1+Lm4
 707EpIg80xhrJoTvE1+dwXNVVpurMn7NI+tG4k9reaq3gqC3FaXb8p9KTtSR9Z8E8z1A
 Kxfg==
X-Gm-Message-State: AOAM530XDjAsSl4Pp6rHh9QDQB94BKuWRu5SwJ0xXuld8PUiRDQjHIl9
 Xy2GCyb4uxsgLPiyE1ej/KJ1WKm41aUfSS8KFrxPJw==
X-Google-Smtp-Source: ABdhPJxsOietXA16ZRrNzQcxotcaWsQQ8EpFGN1XAmTQW8l18H4mVrftg9vl2EhbOpgV7u/bVP0hp1aGjOsY9+N550E=
X-Received: by 2002:ad4:54ef:: with SMTP id k15mr26397007qvx.21.1633994207837; 
 Mon, 11 Oct 2021 16:16:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210928164237.833132-1-alexander.deucher@amd.com>
 <20210928164237.833132-29-alexander.deucher@amd.com>
 <CAHbf0-Egsi3MFD2BQyO1f7kFp8eQAH55bGkCvNauCH3KxR+LbQ@mail.gmail.com>
 <CADnq5_NkEAbxBVaEzaViDuyt+QD=y1aqOjNYvdWGDnebvGweKw@mail.gmail.com>
In-Reply-To: <CADnq5_NkEAbxBVaEzaViDuyt+QD=y1aqOjNYvdWGDnebvGweKw@mail.gmail.com>
From: Mike Lothian <mike@fireburn.co.uk>
Date: Tue, 12 Oct 2021 00:16:36 +0100
Message-ID: <CAHbf0-E33WVP24vMwcFQ39kzixS3LQThJEuno6MTfCt2gnJzPw@mail.gmail.com>
Subject: Re: [PATCH 28/64] drm/amdgpu: drive all navi asics from the IP
 discovery table
To: Alex Deucher <alexdeucher@gmail.com>
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

I've raised a bug with hopefully everything you need

https://gitlab.freedesktop.org/drm/amd/-/issues/1743

On Mon, 11 Oct 2021 at 18:35, Alex Deucher <alexdeucher@gmail.com> wrote:
>
> On Mon, Oct 11, 2021 at 1:20 PM Mike Lothian <mike@fireburn.co.uk> wrote:
> >
> > Hi
> >
> > This patch breaks things for me on my Green Sardine & Navy Flounder
> > system (Asus ROG G513QY)
> >
> > It doesn't get past post with amdgpu built in, will try as a module
>
> Can you provide the dmesg output in that case?
>
> Alex
>
>
> >
> > Cheers
> >
> > Mike
> >
> > On Tue, 28 Sept 2021 at 17:44, Alex Deucher <alexander.deucher@amd.com>=
 wrote:
> > >
> > > Rather than hardcoding based on asic_type, use the IP
> > > discovery table to configure the driver.
> > >
> > > v2: rebase
> > >
> > > Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> > > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > > ---
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 20 --------------------
> > >  1 file changed, 20 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_device.c
> > > index 5e0956b19d69..9c47cc636429 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > @@ -2142,26 +2142,6 @@ static int amdgpu_device_ip_early_init(struct =
amdgpu_device *adev)
> > >                 if (r)
> > >                         return r;
> > >                 break;
> > > -       case  CHIP_NAVI14:
> > > -       case  CHIP_NAVI12:
> > > -       case  CHIP_SIENNA_CICHLID:
> > > -       case  CHIP_NAVY_FLOUNDER:
> > > -       case  CHIP_DIMGREY_CAVEFISH:
> > > -       case  CHIP_BEIGE_GOBY:
> > > -       case CHIP_VANGOGH:
> > > -       case CHIP_YELLOW_CARP:
> > > -       case CHIP_CYAN_SKILLFISH:
> > > -               if (adev->asic_type =3D=3D CHIP_VANGOGH)
> > > -                       adev->family =3D AMDGPU_FAMILY_VGH;
> > > -               else if (adev->asic_type =3D=3D CHIP_YELLOW_CARP)
> > > -                       adev->family =3D AMDGPU_FAMILY_YC;
> > > -               else
> > > -                       adev->family =3D AMDGPU_FAMILY_NV;
> > > -
> > > -               r =3D nv_set_ip_blocks(adev);
> > > -               if (r)
> > > -                       return r;
> > > -               break;
> > >         default:
> > >                 r =3D amdgpu_discovery_set_ip_blocks(adev);
> > >                 if (r)
> > > --
> > > 2.31.1
> > >
