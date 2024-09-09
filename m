Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6966BECE57A
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Sep 2024 15:23:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C85E510E5B1;
	Mon,  9 Sep 2024 15:23:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HM2KYFB6";
	dkim-atps=neutral
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAF0A10E5B1
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Sep 2024 15:23:36 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-20530659f78so1917975ad.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 09 Sep 2024 08:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725895416; x=1726500216; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dzrMzoEu+Pc7HAkVJImJG0by2cEigP7KbLkJL8NXuWU=;
 b=HM2KYFB6acwnND5kGf0+4Qb7UcEurOaSgFnFMoIqkQs5sjdumQks9HeRBgeYI2nvFf
 M4uRAvvO1Rashuox8bWsQH4VEkmV2yGsod1hlY7YOM4yfsCeGklqM98P/XIQTcWpqcsY
 pXSdN7K2+uA1TP2cgtmeH05XWZN9z+Pdf75VQ818SiVqVKc6WJu7EihhlsbhDLnd7URd
 nCsEnZVQFh/HrwSYoVnJxBg1m8bvemtfNI8AYdGcjF1l/MgipvMpxnW6i00wP5c75daU
 yGDdv0oVumyAFl+3qqx60lAIBI4yC0Vj64EP0mxvyvm8KFusWYF1yiEX2G5Pv0pKyRTF
 Znmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725895416; x=1726500216;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dzrMzoEu+Pc7HAkVJImJG0by2cEigP7KbLkJL8NXuWU=;
 b=MlB+eDNHeP2TkbSnw/vHfqCJuQG2EtRtExG9OrkX7qZfrn/ULdjrs9CFXEsWSWugOJ
 xz1LR+NlcWmpsP17/ITfx3srSP3OjB7HaEJIx6/3U4rdPFISHB12TsnY5oROzjv+v9Km
 sfOICZXX/HLY+jv6feRfZqto5s9FXuY1/apQfwadQCOhSRDUmPwlTIqu+nvz+XFSbG9Q
 FMfldM5x6mtoRd5ki1eu9g5sq/tha8oJxzQ/HmvO5UMD+PCSyE1GiBC5iUAaWz296WwQ
 THc5h9qSyhyylAc7HG1RtH819/ObMRhRTJQQGg+BCmkQu9RmoUp+CPtWaOu67gZ/A1Xg
 VgCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZ3YFMcs3M+jDII4qAQV61L+Ac+rejIuQymTTaAeyq3TCddm+0Qyf7ijWr2BTDdCtky5U6ZZIs@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxtLKPetOxK9bDElHKtJfFkj81LgDST21pk6MAlMHACTg2J/c2r
 3S7QRZ37h0TJEDLqwtZczgp/ZAQhYBcTbVBII8uGl79ZWr6NGtpI9KtF7V3HHoWaN+jF4MqvxKI
 5R8ktmZ8KZPrzFD7gJF2+WcRWPcU=
X-Google-Smtp-Source: AGHT+IGE8sZ7Wi+V1eL0Q4K2C04OVwMjjZxitHnjr5O6+rXDj9X2Uh2r8+vhwWCBgO0wvCLyGjxO8uvCy2dhbog65cs=
X-Received: by 2002:a17:902:d2c2:b0:205:76c9:795d with SMTP id
 d9443c01a7336-206f0605ebbmr56974885ad.6.1725895415839; Mon, 09 Sep 2024
 08:23:35 -0700 (PDT)
MIME-Version: 1.0
References: <20240902081311.2918278-1-Prike.Liang@amd.com>
 <DS7PR12MB600580C6E52BE6734FD7F0F7FB9D2@DS7PR12MB6005.namprd12.prod.outlook.com>
 <BN9PR12MB5146FB172036F9601B38C3E6F79E2@BN9PR12MB5146.namprd12.prod.outlook.com>
 <DS7PR12MB60057926E8C172D3EB5A332EFB992@DS7PR12MB6005.namprd12.prod.outlook.com>
In-Reply-To: <DS7PR12MB60057926E8C172D3EB5A332EFB992@DS7PR12MB6005.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 9 Sep 2024 11:23:24 -0400
Message-ID: <CADnq5_M4R5-fFQPeMe6XxoovQdL-7z1zecnRDyr7pNXwe5=UOQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: update suspend status for aborting from
 deeper suspend
To: "Liang, Prike" <Prike.Liang@amd.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
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

On Mon, Sep 9, 2024 at 8:58=E2=80=AFAM Liang, Prike <Prike.Liang@amd.com> w=
rote:
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
>
> Previously, the S3 process aborted before calling the noirq suspend, and =
this issue was successfully sorted by checking the suspend_complete flag. H=
owever, there are now some S3 suspend cases, such as pm_test platform/core =
mode, which abort the S3 process after the noirq suspend. In these cases of=
 abort, the issue cannot be sorted out by setting the suspend_complete flag=
 in the noirq suspend callback, and it=E2=80=99s fine to use the MP0 SOL re=
gister directly to determine whether to reset the GPU on resume. However, o=
n the GFX9 series, the driver still needs to rely on the suspend_complete f=
lag to determine whether it needs to skip reprogramming the clear state reg=
ister values during resume from suspend abort cases, so now it sounds that =
the suspend_complete flag cannot be completely removed.

Can we just set the suspend_complete flag based on the SOL register
rather than based on what functions have been called?  Maybe as a
future cleanup?  This logic seems fragile and I'm worried it will get
accidently broken.  For now the patch is:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

Alex

>
>
>
> Thanks,
>
> Prikec
>
>
>
> From: Deucher, Alexander <Alexander.Deucher@amd.com>
> Sent: Saturday, September 7, 2024 1:34 AM
> To: Liang, Prike <Prike.Liang@amd.com>; amd-gfx@lists.freedesktop.org
> Subject: Re: [PATCH] drm/amdgpu: update suspend status for aborting from =
deeper suspend
>
>
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
>
>
> Can you elaborate on how this fails?  Seems like maybe we should just get=
 rid of adev->suspend_complete and just check the MP0 SOL register to deter=
mine whether or not we need to reset the GPU on resume.
>
>
>
> Alex
>
>
>
> ________________________________
>
> From: Liang, Prike <Prike.Liang@amd.com>
> Sent: Thursday, September 5, 2024 3:36 AM
> To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: RE: [PATCH] drm/amdgpu: update suspend status for aborting from =
deeper suspend
>
>
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> According to the ChromeOS team test, this patch can resolve the S3 suspen=
d abort from deeper sleep, which occurs when suspension aborts after callin=
g the noirq suspend and before executing the _S3 and turning off the power =
rail.
>
> Could this patch get a review or acknowledgment?
>
> Thanks,
> Prike
>
> > -----Original Message-----
> > From: Liang, Prike <Prike.Liang@amd.com>
> > Sent: Monday, September 2, 2024 4:13 PM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Liang, Prike
> > <Prike.Liang@amd.com>
> > Subject: [PATCH] drm/amdgpu: update suspend status for aborting from
> > deeper suspend
> >
> > There're some other suspend abort cases which can call the noirq suspen=
d
> > except for executing _S3 method. In those cases need to process as
> > incomplete suspendsion.
> >
> > Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/soc15.c | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c
> > b/drivers/gpu/drm/amd/amdgpu/soc15.c
> > index 8d16dacdc172..cf701bb8fc79 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> > @@ -587,11 +587,13 @@ static bool soc15_need_reset_on_resume(struct
> > amdgpu_device *adev)
> >        * 2) S3 suspend abort and TOS already launched.
> >        */
> >       if (adev->flags & AMD_IS_APU && adev->in_s3 &&
> > -                     !adev->suspend_complete &&
> > -                     sol_reg)
> > +                     sol_reg) {
> > +             adev->suspend_complete =3D false;
> >               return true;
> > -
> > -     return false;
> > +     } else {
> > +             adev->suspend_complete =3D true;
> > +             return false;
> > +     }
> >  }
> >
> >  static int soc15_asic_reset(struct amdgpu_device *adev)
> > --
> > 2.34.1
