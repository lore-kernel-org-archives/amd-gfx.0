Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD896C369B2
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Apr 2025 19:48:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C91D10E647;
	Mon, 14 Apr 2025 19:48:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QmIP8IlM";
	dkim-atps=neutral
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46BB510E647
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Apr 2025 19:48:52 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-2ff62f9b6e4so812443a91.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Apr 2025 12:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744660132; x=1745264932; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xlPZ6LFNVeXdMYCBRD4CC12ljur4rQFKYVbMmZkX2WQ=;
 b=QmIP8IlMjRNPIFLERlWh4iZVHL8zfvfiVWjzYj8ch+5OrEhTEE3vmrn4H4gDYtpkzQ
 BaOGFtV0QvH91rocPQcGfXbXGk5ahzlqSwwR8lIgylStd+GcIzEv3TUw/75Va8TRDI1W
 pbEJ8XKe/qaRVccBoAd/jkrFQWO43579Cqy47UQ+4flVrlwZP1qmSnqAA0tr3dRNHL9N
 kvxwIiSZdtt5UFCKfF78JP5n5b+X7SzYXYydzbmUFMi3EbP1NNb+iSCRGq/BXhWCl1C7
 XzgpSWCvdfALIBgzG04IBlFm9fhg0u2ivKie3eGUN2XPZk6nnXPfpvWKCBzCmcURHe9/
 dyfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744660132; x=1745264932;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xlPZ6LFNVeXdMYCBRD4CC12ljur4rQFKYVbMmZkX2WQ=;
 b=phU/aGJMDv+SIL9xotbbKijg4Lcs+PpMUy1ODTagPuxe1DQolE+0c7dAr2B/hyuFfE
 MSOjKiDLqXziI9+q/dXCzChLWpRqNq/RmlmPNwLsQc9XjLx0S3hw9Rz0UKztQ/YkF2BQ
 zYiPXXuHI99+cRDD5HHb3Nm+P1L+xORalXHld9y3WuzjqRI+/ctKDTh049eNdXzqjZUx
 2aaM3O3GAsiT3AHJKoKlxt9zZ8ZbTCo9iAzZyLNxW2HvCXOw5GKTAjG+584dS6bA6Tjf
 VTdj36ftNMZtCWMyrIjaBWvlbvaOhYqSXuqfeHpFvAdiJQAplF/lVQNSqAqXQ+yK+him
 olDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqN9kmi3aCSJ68jb6aNTsJRQQe9ErSjn3uF2DhJlpTXOE2duUDY7+vfQiyaehkJ4tnhkVtGE5k@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzT2Bha2GTb0GCeOFX5pkboAf/kbjM5CS/38DhpN0p5pdHownLU
 R6sQdoX83h9UqArv6WQq73uC7H3w+q1yQVFKqia5rqurAEGN4VLZEsP/4IvYVvPJlj61VT8hjtC
 zJFeMEW1oagCNqhcBseKG19m2EOg=
X-Gm-Gg: ASbGncuZJRAvMtJvYKsAnPWeZD8b+AGfGX2ttsdYdLbQCLp8LBzQ6ePQ+Ezl4tm/MmB
 CE31+BJPPli5FytUUQKLfVu9sAChOgsX1Ek7S2to0Busg6rJ8+21GgMaIkoV1+OTocB2MnwSqgW
 KEZdgE70rdnZs5fgvqURo+Gw==
X-Google-Smtp-Source: AGHT+IHXBbp7ZGb2YLKEgrgb02doczLUEJweRyLGKrugoqHPlbFU0fcW9GrjygSRWBpGaX1KAof19eDvJ6P5zekIXSE=
X-Received: by 2002:a17:90b:3912:b0:2ff:5759:549a with SMTP id
 98e67ed59e1d1-30823624fa5mr7012649a91.1.1744660131746; Mon, 14 Apr 2025
 12:48:51 -0700 (PDT)
MIME-Version: 1.0
References: <20250412202134.3025051-1-siqueira@igalia.com>
 <20250412202134.3025051-8-siqueira@igalia.com>
 <CADnq5_NCyuZdO4gHzpjfV_ASZ+ExkWAb41jeE+N+DBqfQuUaZA@mail.gmail.com>
 <kg62gvo454qwwogrkadsv5chufzn6heyqtxkqtonqspuzhodqy@jt3iyllwmogh>
In-Reply-To: <kg62gvo454qwwogrkadsv5chufzn6heyqtxkqtonqspuzhodqy@jt3iyllwmogh>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 14 Apr 2025 15:48:39 -0400
X-Gm-Features: ATxdqUG9WhflKlDIDO7GCYEcIA4LZW5CW0XaQMEjbFY2PdlQO7fcYEitn2yHDtg
Message-ID: <CADnq5_PV98Y-5SrDTTg5fFBkFKzrj8j1EcWtMFp7ZpspUHxQ7Q@mail.gmail.com>
Subject: Re: [PATCH v2 7/9] drm/amdgpu/gfx: Clean up gfx_v7_0_get_csb_buffer
To: Rodrigo Siqueira <siqueira@igalia.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, amd-gfx@lists.freedesktop.org, 
 kernel-dev@igalia.com
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

On Mon, Apr 14, 2025 at 3:38=E2=80=AFPM Rodrigo Siqueira <siqueira@igalia.c=
om> wrote:
>
> On 04/13, Alex Deucher wrote:
> > On Sat, Apr 12, 2025 at 4:22=E2=80=AFPM Rodrigo Siqueira <siqueira@igal=
ia.com> wrote:
> > >
> > > CHIP_KAVERI, CHIP_KABINI, and CHIP_MULLINS have the same buffer
> > > manipulation as the default option in the switch case. Remove those
> > > specific manipulations and rely on the default behavior for them.
> > >
> > > Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
> > > ---
> > >  drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c | 9 ---------
> > >  1 file changed, 9 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/=
amd/amdgpu/gfx_v7_0.c
> > > index 16b94ff5a959..4d8d68b737d1 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> > > @@ -3902,15 +3902,6 @@ static void gfx_v7_0_get_csb_buffer(struct amd=
gpu_device *adev,
> > >                 buffer[count++] =3D cpu_to_le32(0x16000012);
> > >                 buffer[count++] =3D cpu_to_le32(0x00000000);
> > >                 break;
> > > -       case CHIP_KAVERI:
> > > -               buffer[count++] =3D cpu_to_le32(0x00000000); /* XXX *=
/
> > > -               buffer[count++] =3D cpu_to_le32(0x00000000);
> > > -               break;
> > > -       case CHIP_KABINI:
> > > -       case CHIP_MULLINS:
> > > -               buffer[count++] =3D cpu_to_le32(0x00000000); /* XXX *=
/
> > > -               buffer[count++] =3D cpu_to_le32(0x00000000);
> > > -               break;
> >
> > These should be fixed rather than removed.  Actually, all of these
> > should be fixed up for all chips.  We should use the values calculated
> > by the driver similar to what we do in gfx_v8.  E.g.,
> >         buffer[count++] =3D
> > cpu_to_le32(adev->gfx.config.rb_config[0][0].raster_config);
> >         buffer[count++] =3D
> > cpu_to_le32(adev->gfx.config.rb_config[0][0].raster_config_1);
> >
>
> ok, I checked the code sequence, and fwiu gfx_v7_0_setup_rb() ->
> gfx_v7_0_raster_config() is called before gfx_v7_0_get_csb_buffer().
>  gfx_v7_0_raster_config() has the setup for all of the ASICs in this
> part. I also have a HAWAII and confirmed that using raster_config
> directly had the same value as the one hardcoded in this part. Anyway,
> I'll send a v3 with this fix.
>
> When I was looking into the code, it was not clear to me these things:
>
> 1. What is this config RB? Why is there a field for User RB? Also, what
>    RB stands for?

RB =3D Render Backends.  These are the render backends (color and depth
buffer handling) on the 3D engine (also called ROPs by a lot of
people).  Bad RBs are fused off and there is a harvest register the
driver reads to determine which RB(s) are fused off so that the driver
can configure the hardware state so that nothing gets sent to them.
There are also user harvest registers that the driver can program to
disable additional RBs, etc. for testing purposes.

> 2. Why there is raster_config and raster_config_1? Is raster_config_1
>    some sort of fallback?

The configuration just happens to require two registers to hold all of
the state.

Alex

>
> Thanks
>
> > Alex
> >
> > >         case CHIP_HAWAII:
> > >                 buffer[count++] =3D cpu_to_le32(0x3a00161a);
> > >                 buffer[count++] =3D cpu_to_le32(0x0000002e);
> > > --
> > > 2.49.0
> > >
>
> --
> Rodrigo Siqueira
