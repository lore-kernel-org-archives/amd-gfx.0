Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4802C5DF7D
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2026 17:39:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F30210EC35;
	Tue, 18 Aug 2026 17:39:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KZu7ETWi";
	dkim-atps=neutral
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com
 [209.85.222.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 749A710E514
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2026 17:39:40 +0000 (UTC)
Received: by mail-ua1-f51.google.com with SMTP id
 a1e0cc1a2514c-977c81214bcso2376241.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2026 10:39:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787074779; cv=none;
 d=google.com; s=arc-20260327;
 b=FdNWBXj9y8XYMD9bbJo2UGHBB2unBXclqIOVvBXqItkfU7RPhcO84b7V6xMhAZxJig
 /mz0Qh5Bh0AqhbUDfcXebI1nZAlBzfaVC8c/hXHxUw5lL+HPa0Oxhq9sXeILvuYiDKNn
 hx6vG7h6nVMh82Lr/Y9MPXC+XeWM1MKKfDp+12lx9XlFDK0yzcTqhvl4ZPbXUTN7VPA5
 TEtw/LLp5yCxQNsJlvEC8z1tJ41mzEVCoUXOj9tOVJ1nneanFattslWTTvm7oi0HkJNl
 +rwUHx5tR7Z1meRnnK2+XnYgI6mr+baE1YR+E6brPAzNrEI8qYBFyB5EgrZfhgp2Ojn2
 ipbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=eEckY2/FWef46lUE2RU5Sdg+eCXq1PHhVlFbUmRSmPA=;
 fh=5kggbhq7OQRwr+TOyzXLvO9l520vEq5uxeH+A+EPiSQ=;
 b=Z9/4Dag4YF7o4sYanO0PcA7DYnMJH849Rwj7zv38dcU2NI/OEZzKObt+fGMeU8Ho1k
 Vm6xelvlIRWh8SD8nwwEiuytu+zWxbKsruGinjV8PHFpC1bafhyZ+xiOpwCE1l9S+HUO
 OnCR2AYDu32Dcn7kcrSjz3xltnwYXCdvKdjKBmpvgxsLK5BWI58/MULoNrKixjvvbu2N
 dfOCrO5RK1GTmlPTozUXuPF3FCKfJu2Dq7Rdg4BfqUBfuoSnEWOGKDYd56CGk9LpPuEP
 jWUFI/5WEqyuuRIg+wBBXuSLRVl+3DzwnRMmTEeMuVn0TiEGKyHRIUFx1Mna7040YVxQ
 yhAQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787074779; x=1787679579; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=eEckY2/FWef46lUE2RU5Sdg+eCXq1PHhVlFbUmRSmPA=;
 b=KZu7ETWi/JPtcmIdqIsk1ycfh1Q0h81/6ip/C31gWWjTUGsAssy4C//8y2JHCHAm0F
 X3tgIlVapYLfpjmhYpyeVMs0ch79puMbLjfHl8Mwv4plK7cJ5gJvd2iyvY3KFDu9vaZ9
 HLXsQJUjLnk5eERkuydQeP8RYC27dPi9mHq/EhPgbp3/PJWNfSesRvh7rD9q8f2H2aNK
 yhJ/nxAK5gw1Gf3BRwHlALG5VSIN3Cv/d8l/WQf8wRDLqUp2JmVsKTTGw9eDtlf+x8CO
 ycqV9TnvBN2Isfyh05ryA2ioisc5+aAguaT6Vsol7kseFCr+Hdcx84rEBvwKZoC3RLxX
 jPAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787074779; x=1787679579;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eEckY2/FWef46lUE2RU5Sdg+eCXq1PHhVlFbUmRSmPA=;
 b=foK/inh3+WfxhLNfT+oWPihziA8b8/QCSsgofwhXE4lFFNQagoTZwAZ+BEV7t2O4Dl
 LiMWdXnZcb1y05WdDT8ceWvay4rtwB1jCrAPFOYeNOcA9CvPiwdyYdqn21t8BK/crM4n
 CcF5ELUCcTvyYlCpnEC2DOP82KZaUGrDVlS7ukkotNX0FaWh7+f5yPkB46FSDIcn6X55
 IBxFVv82oFTFrihFMnhllF90nuXeSDPpLEi+3VFShSes0WwJYMzP4twqzFqGv6H2FNCB
 w3HVtPDKZ+Zg1Yhj/JhQBzDfoWilPC1OLU6cmuMn+BWrJ8W1I9uPD7WG7cVzKWQWcKaw
 jW0g==
X-Forwarded-Encrypted: i=1;
 AHgh+RqFZwwSoZWSEt5wXDGfUA+1uJCyjOnGW22lHyCDTavb68X5eB8QQV3skXsjusGNLJSYZx1TmiSV@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyQ4mUfv29goNMUxLryD5wyxDEHkWfPWTZoZjm41I+dgOSfxIGm
 B4rdauE2V7aiUj/hxXlZR32A09d28o6q9mPRoNJqlEE5JrrQfWnr1uCR0xywShplhEybAHAklW/
 IVwopg3mZL0AZd/Gip7rmOsXa3YDMK4k=
X-Gm-Gg: AR+sD11saouWWSNx9RQoWC4gQ4IA8LOYvnwMaFm9jQfijOxNv8tXhUn9z9iZVMt8Tdm
 xRX/cU7nJYuiC/4K7jkrha650sqJG1jg6uArmCOH2Stzusq5y59NMMrAJan5lljtOhlaGM7Ab0t
 ajufVU15pxTjNPTYslJi9g/wnJriniDI9zInBhUO3SnZ2LtpsLGgmqWluctlbqmE6TiADtaJsWp
 5D2UenjJifpu3ZPCWaSoLKPDaAHJm013EXnNfG7YCnVFoXIxSsDQk+sbboRSBKTtb1bFlWaJKct
 EyJ6JRg5Gb+Mn0OzizaXVDFZSKlRUUR/I2oOjxKMb8h2pReFZZCEQB3D058cHqHswMCJ1UMudsh
 NUnzdub0Q6f18J0L+LSVz9KZHIIYv4uw=
X-Received: by 2002:a05:6122:6d03:b0:5bd:ae1c:afcf with SMTP id
 71dfb90a1353d-5c591f935b9mr3387342e0c.3.1787074779223; Tue, 18 Aug 2026
 10:39:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260818-amdgpu-strcpy-v1-1-3ee9b111fafe@gmail.com>
 <CADnq5_NZQrSAqV4cTz8HaJYsatb9VWgc4J3--gTWvF8NTz6-xg@mail.gmail.com>
 <20260818152113.31b72e30@pumpkin>
In-Reply-To: <20260818152113.31b72e30@pumpkin>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 18 Aug 2026 13:39:26 -0400
X-Gm-Features: AcwNN1UdAawiuNlezTn1mx5MGXf0fGYUPgu4-splMDm1iIm25D8BbUfMfTsnfsM
Message-ID: <CADnq5_MOSxt4=15C941PyuKH0V6bubx7Wi55x5zoWjAsBS2ffg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Replace deprecated strcpy with strscpy
To: David Laight <david.laight.linux@gmail.com>
Cc: Amin Gattout <amin.gattout@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

On Tue, Aug 18, 2026 at 10:21=E2=80=AFAM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Tue, 18 Aug 2026 09:01:43 -0400
> Alex Deucher <alexdeucher@gmail.com> wrote:
>
> > Applied.  Thanks!
> >
> > On Tue, Aug 18, 2026 at 7:10=E2=80=AFAM Amin Gattout <amin.gattout@gmai=
l.com> wrote:
> > >
> > > strcpy() has been deprecated because it performs no bounds checking
> > > on the destination buffer, which can lead to buffer overflows. Replac=
e
> > > it with the safer strscpy().  No functional changes.
> > >
> > > Signed-off-by: Amin Gattout <amin.gattout@gmail.com>
> > > ---
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c | 6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_mca.c
> > > index cc6d1a4e4c3a..1caa393c44d5 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
> > > @@ -97,7 +97,7 @@ int amdgpu_mca_mp0_ras_sw_init(struct amdgpu_device=
 *adev)
> > >                 return err;
> > >         }
> > >
> > > -       strcpy(ras->ras_block.ras_comm.name, "mca.mp0");
> > > +       strscpy(ras->ras_block.ras_comm.name, "mca.mp0");
>
> I missed this being proposed.
> Both strcpy() and strscpy() get converted to the same memcpy()
> (which might itself get converted to writing a 64bit constant).
>
> But if the string were too long strcpy() would generate a compile error
> whereas strscpy() just trunctates the string.
>
> Which one is better?

I don't know.  I can go either way on this.

Alex


>
>         David
>
> > >         ras->ras_block.ras_comm.block =3D AMDGPU_RAS_BLOCK__MCA;
> > >         ras->ras_block.ras_comm.sub_block_index =3D AMDGPU_RAS_MCA_BL=
OCK__MP0;
> > >         ras->ras_block.ras_comm.type =3D AMDGPU_RAS_ERROR__MULTI_UNCO=
RRECTABLE;
> > > @@ -122,7 +122,7 @@ int amdgpu_mca_mp1_ras_sw_init(struct amdgpu_devi=
ce *adev)
> > >                 return err;
> > >         }
> > >
> > > -       strcpy(ras->ras_block.ras_comm.name, "mca.mp1");
> > > +       strscpy(ras->ras_block.ras_comm.name, "mca.mp1");
> > >         ras->ras_block.ras_comm.block =3D AMDGPU_RAS_BLOCK__MCA;
> > >         ras->ras_block.ras_comm.sub_block_index =3D AMDGPU_RAS_MCA_BL=
OCK__MP1;
> > >         ras->ras_block.ras_comm.type =3D AMDGPU_RAS_ERROR__MULTI_UNCO=
RRECTABLE;
> > > @@ -147,7 +147,7 @@ int amdgpu_mca_mpio_ras_sw_init(struct amdgpu_dev=
ice *adev)
> > >                 return err;
> > >         }
> > >
> > > -       strcpy(ras->ras_block.ras_comm.name, "mca.mpio");
> > > +       strscpy(ras->ras_block.ras_comm.name, "mca.mpio");
> > >         ras->ras_block.ras_comm.block =3D AMDGPU_RAS_BLOCK__MCA;
> > >         ras->ras_block.ras_comm.sub_block_index =3D AMDGPU_RAS_MCA_BL=
OCK__MPIO;
> > >         ras->ras_block.ras_comm.type =3D AMDGPU_RAS_ERROR__MULTI_UNCO=
RRECTABLE;
> > >
> > > ---
> > > base-commit: 0f23d56f17fdfc7db69d51f64c8b91bbab947aa9
> > > change-id: 20260818-amdgpu-strcpy-0e92d18299c6
> > >
> > > Best regards,
> > > --
> > > Amin Gattout <amin.gattout@gmail.com>
> > >
> >
>
