Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAD49C761A6
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Mar 2023 19:30:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A518310F2EF;
	Fri, 31 Mar 2023 19:30:44 +0000 (UTC)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B494710F2EF
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Mar 2023 19:30:21 +0000 (UTC)
Received: by mail-oi1-x22a.google.com with SMTP id f14so3923058oiw.10
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Mar 2023 12:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1680291021;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FbtgTLuK3hmi6zMQPLTCG8zEhIwgvE0SlW8CMKib6bM=;
 b=N+qN/ErO1Z9XjGG6eHTyAN7/V6DJ3rqZcrJTsZMWRUQDQHsKwpNGul4dU0gOEphyFN
 VrgOC3Sh2pI1fe2i3EsGbV4t2UGyvk7NMLldoHIOg+mi6k4kREElfFF83TtwJkwVEN1+
 JvtycwHlnMu9+tUjwhCgWa9TlCuB6qGdx5v3AcULQlQMyugape1RHnJePod3Vtk8aOYY
 OZhrhNQaZgsokEl/LqZWNILmS+JdCuxAaxUR+GLj5jLXUuvaz78ID3xg14DijfmmjeoF
 1G7kquEqSr0tKDe4HOm34Fg6OQJveZIlIsFnPqLCzFZmEQ/9HnSCce1sk+BpgBrHQu5v
 rPHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680291021;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FbtgTLuK3hmi6zMQPLTCG8zEhIwgvE0SlW8CMKib6bM=;
 b=EADfytls/iQ3bEJvZXXC2n1wexAGEE75KM6f5cO89m7nKWfHNiJN+iEv+b17DG/evl
 jNQ33Dr8QwmhJDt0Svug0Mrh2rfGKlSEaHWhSwTxwNiojDHpempdSlecaFhATSN1L/49
 ziWqiu1AJgUJYud8Kp14eX7k9GSbJnk2DRn1+I3ikwfQP+BNZP26H0Bt9+7PL7gQkMn2
 vfkUYd9KC78S9z0GusVxgovoc6vNuNOO/0ALylo8Wv3wuplyTMAKZ4SpXFs4mTVmW8Ju
 gffYTHuLsB4hP/Mlm23xQ/CJQXlp4i1JbLU1Wuyt1ycHV2qdH5HYycsHxK1sUtsXX6x+
 Riug==
X-Gm-Message-State: AAQBX9c8A0UrHXw0JkxvIfdel9wwua0UHhxR+F2EiE5WkPc/N6MgZb+M
 JnqodJ4dXamKRtPq79x+ffC//zQWIfSwzwGrUxA=
X-Google-Smtp-Source: AKy350ZA77SnIoAzTWUi9VJIFz76juVzVs9+3J52xKSp+rzQ299bIeNmd2y7WLonuorLtUnK3lOZveb4QvN5gJmjiao=
X-Received: by 2002:a54:448c:0:b0:389:4e54:79f0 with SMTP id
 v12-20020a54448c000000b003894e5479f0mr2240153oiv.3.1680291020818; Fri, 31 Mar
 2023 12:30:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230328001119.1363691-1-alexander.deucher@amd.com>
 <cf5a5181-4c3c-10ff-1dff-36a34658cea7@amd.com>
In-Reply-To: <cf5a5181-4c3c-10ff-1dff-36a34658cea7@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 31 Mar 2023 15:30:09 -0400
Message-ID: <CADnq5_P0VdXL=SC_2MWGHHOL+KZfrbkrvS=ko9sDnHbgocAhmg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: simplify amdgpu_ras_eeprom.c
To: Luben Tuikov <luben.tuikov@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Mar 28, 2023 at 12:30=E2=80=AFPM Luben Tuikov <luben.tuikov@amd.com=
> wrote:
>
> On 2023-03-27 20:11, Alex Deucher wrote:
> > All chips that support RAS also support IP discovery, so
> > use the IP versions rather than a mix of IP versions and
> > asic types.
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > Cc: Luben Tuikov <luben.tuikov@amd.com>
> > ---
> >  .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 72 ++++++-------------
> >  1 file changed, 20 insertions(+), 52 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> > index 3106fa8a15ef..c2ef2b1456bc 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> > @@ -106,48 +106,13 @@
> >  #define to_amdgpu_device(x) (container_of(x, struct amdgpu_ras, eeprom=
_control))->adev
> >
> >  static bool __is_ras_eeprom_supported(struct amdgpu_device *adev)
> > -{
> > -     if (adev->asic_type =3D=3D CHIP_IP_DISCOVERY) {
> > -             switch (adev->ip_versions[MP1_HWIP][0]) {
> > -             case IP_VERSION(13, 0, 0):
> > -             case IP_VERSION(13, 0, 10):
> > -                     return true;
> > -             default:
> > -                     return false;
> > -             }
> > -     }
> > -
> > -     return  adev->asic_type =3D=3D CHIP_VEGA20 ||
> > -             adev->asic_type =3D=3D CHIP_ARCTURUS ||
> > -             adev->asic_type =3D=3D CHIP_SIENNA_CICHLID ||
> > -             adev->asic_type =3D=3D CHIP_ALDEBARAN;
> > -}
> > -
> > -static bool __get_eeprom_i2c_addr_arct(struct amdgpu_device *adev,
> > -                                    struct amdgpu_ras_eeprom_control *=
control)
> > -{
> > -     struct atom_context *atom_ctx =3D adev->mode_info.atom_context;
> > -
> > -     if (!control || !atom_ctx)
> > -             return false;
> > -
> > -     if (strnstr(atom_ctx->vbios_version,
> > -                 "D342",
> > -                 sizeof(atom_ctx->vbios_version)))
> > -             control->i2c_address =3D EEPROM_I2C_MADDR_0;
> > -     else
> > -             control->i2c_address =3D EEPROM_I2C_MADDR_4;
> > -
> > -     return true;
> > -}
> > -
> > -static bool __get_eeprom_i2c_addr_ip_discovery(struct amdgpu_device *a=
dev,
> > -                                    struct amdgpu_ras_eeprom_control *=
control)
> >  {
> >       switch (adev->ip_versions[MP1_HWIP][0]) {
> > +     case IP_VERSION(11, 0, 2): /* VEGA20 and ARCTURUS */
> > +     case IP_VERSION(11, 0, 7):
> >       case IP_VERSION(13, 0, 0):
> > +     case IP_VERSION(13, 0, 2):
> >       case IP_VERSION(13, 0, 10):
>
> I'd add the rest of the proper names here which are being deleted by this=
 change,
> so as to not lose this information by this commit: Sienna Cichlid and Ald=
ebaran,
> the rest can be left blank as per the current state of the code.

Fixed.

>
> > -             control->i2c_address =3D EEPROM_I2C_MADDR_4;
> >               return true;
> >       default:
> >               return false;
> > @@ -178,29 +143,32 @@ static bool __get_eeprom_i2c_addr(struct amdgpu_d=
evice *adev,
> >               return true;
> >       }
> >
> > -     switch (adev->asic_type) {
> > -     case CHIP_VEGA20:
> > -             control->i2c_address =3D EEPROM_I2C_MADDR_0;
> > +     switch (adev->ip_versions[MP1_HWIP][0]) {
> > +     case IP_VERSION(11, 0, 2):
> > +             /* VEGA20 and ARCTURUS */
> > +             if (adev->asic_type =3D=3D CHIP_VEGA20)
> > +                     control->i2c_address =3D EEPROM_I2C_MADDR_0;
> > +             else if (strnstr(atom_ctx->vbios_version,
>
> In the code this is qualified with atom_ctx !=3D NULL; and if it is,
> then we return false. So, this is fine, iff we can guarantee that
> "atom_ctx" will never be NULL. If, OTOH, we cannot guarantee that,
> then we need to add,
>                 else if (!atom_ctx)
>                         return false;
>                 else if (strnstr(...
>
> Although, I do recognize that for Aldebaran below, we do not qualify
> atom_ctx, so we should probably qualify there too.

This function is called after the vbios is initialized so I think we
can drop the check.  vbios is fetched in amdgpu_device_ip_early_init()
and ras is initialized in amdgpu_device_ip_init() which is called much
later.

Alex

>
> > +                              "D342",
> > +                              sizeof(atom_ctx->vbios_version)))
> > +                     control->i2c_address =3D EEPROM_I2C_MADDR_0;
> > +             else
> > +                     control->i2c_address =3D EEPROM_I2C_MADDR_4;
> >               return true;
> > -
> > -     case CHIP_ARCTURUS:
> > -             return __get_eeprom_i2c_addr_arct(adev, control);
> > -
> > -     case CHIP_SIENNA_CICHLID:
> > +     case IP_VERSION(11, 0, 7):
> >               control->i2c_address =3D EEPROM_I2C_MADDR_0;
> >               return true;
> > -
> > -     case CHIP_ALDEBARAN:
> > +     case IP_VERSION(13, 0, 2):
> >               if (strnstr(atom_ctx->vbios_version, "D673",
> >                           sizeof(atom_ctx->vbios_version)))
> >                       control->i2c_address =3D EEPROM_I2C_MADDR_4;
> >               else
> >                       control->i2c_address =3D EEPROM_I2C_MADDR_0;
> >               return true;
> > -
> > -     case CHIP_IP_DISCOVERY:
> > -             return __get_eeprom_i2c_addr_ip_discovery(adev, control);
> > -
> > +     case IP_VERSION(13, 0, 0):
> > +     case IP_VERSION(13, 0, 10):
> > +             control->i2c_address =3D EEPROM_I2C_MADDR_4;
> > +             return true;
> >       default:
> >               return false;
> >       }
>
> --
> Regards,
> Luben
>
