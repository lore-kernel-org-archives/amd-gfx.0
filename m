Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24D11C52D70
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Aug 2024 20:05:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8CB910E3F2;
	Tue,  6 Aug 2024 20:05:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GmWrHUY7";
	dkim-atps=neutral
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20AE310E3F2
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Aug 2024 20:05:12 +0000 (UTC)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-1fd66cddd4dso11496545ad.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 06 Aug 2024 13:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722974711; x=1723579511; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Za+/C+muK7LCTJLkZOY/koJ4oMfePwlEq1RfIxBIgqc=;
 b=GmWrHUY7jIipZbmcnZT8oAjNDT2Jz3ejfTpqL5ZMUvslio2UtnOzJQUxGlTFJvBz8Z
 qGT4lkI1r1bxItMYPXZDrapPmhmfwqprhGx75eh1pn3I9r7Kg0jN09XVvE0abaZAfDfF
 s29HXjcOgHIgtL5rhAkeFTxIkuczIA5dDqwBiVXmwQektop8POme51Ob4kwjqB7zdfjE
 BgnBFFUS9zq04X0BvLW3c+OeFkR5JMrQe3aLnrDPi1RPQKFekOlXUFINVlVgw2Z1VntS
 a7bVihF26A7n0s2YaUKaho33qVijCgc9ZveSoYdSXDI/fvXg3d4nxt7KK+8KeEWb3UZ/
 8XFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722974711; x=1723579511;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Za+/C+muK7LCTJLkZOY/koJ4oMfePwlEq1RfIxBIgqc=;
 b=LUMu3jM4JhcEdhNJMxTH7InnIp7p1TyJnvqynShkg0annlLW0AwaYHSiwl8y4qtnH/
 mQrB2ntYSkawQ2h/sFD9CvdeLUEondau1zwNI4uydVcaQicAmKetjQSc4kJfEXNzm/8Q
 RnZ+FyQIgDXDqfeBH6FWqk+EXuuvabhCDkUe4eILS8tP7OtErFcgircC7B31OhzNnlGq
 8dBOSJE60kEsN92cXK2rc7dnRea5F/lGmrXD8j/aOKjwGbwbLaGgzUWJTRrROfPYAmG/
 zboc04yKmHABnUj1jDNrxh0UqFu4EpRvwfdom1qF5LznTWOZX/3B3+UCxF5yum1cfVMk
 uh7g==
X-Gm-Message-State: AOJu0YxwvROzVIEfXMoS5/2AsQaHsC91oi0AGpaJddMPskxLA9ujejVz
 TGtg7LhwB2fcrCGZzaBQ/XioXGUOdSg66gYyxGdV6wNEGOgFYDzqPXcYRTueWF9383dJbmnD+1o
 39k+pn1NQ722jgjTCsXBbR4uZi38=
X-Google-Smtp-Source: AGHT+IEGj32LjqXvk5K8oOaP0wHnIA6HtkfkArBOgNt0fl7Qqjo8t4yqMWTU/pirXHN1yILJiz34nBOj1U5D+rqZAPU=
X-Received: by 2002:a17:902:e80f:b0:1fc:327a:1f42 with SMTP id
 d9443c01a7336-1ff5722d7e7mr208573905ad.6.1722974711315; Tue, 06 Aug 2024
 13:05:11 -0700 (PDT)
MIME-Version: 1.0
References: <20240806160012.234633-1-David.Wu3@amd.com>
 <CADnq5_Ov6hnKmKXRe00JEgdWLyphEbMHDghHuN+UNRoq70CFQA@mail.gmail.com>
In-Reply-To: <CADnq5_Ov6hnKmKXRe00JEgdWLyphEbMHDghHuN+UNRoq70CFQA@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 6 Aug 2024 16:04:59 -0400
Message-ID: <CADnq5_MyHgVZKN21kCnn9OYCiO88-8Xg0mO8Wqw=QYAptdcJig@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amd/amdgpu: command submission parser for JPEG
To: "David (Ming Qiang) Wu" <David.Wu3@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Christian.Koenig@amd.com, 
 alexander.deucher@amd.com, leo.liu@amd.com
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

On Tue, Aug 6, 2024 at 1:08=E2=80=AFPM Alex Deucher <alexdeucher@gmail.com>=
 wrote:
>
> On Tue, Aug 6, 2024 at 12:00=E2=80=AFPM David (Ming Qiang) Wu <David.Wu3@=
amd.com> wrote:
> >
> > Add JPEG IB command parser to ensure registers
> > in the command are within the JPEG IP block.
> >
> > Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c   |  3 ++
> >  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 58 +++++++++++++++++++++++-
> >  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.h |  7 ++-
> >  drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c |  1 +
> >  drivers/gpu/drm/amd/amdgpu/soc15d.h      |  6 +++
> >  5 files changed, 73 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_cs.c
> > index 1e167d925b64..78b3c067fea7 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> > @@ -1061,6 +1061,9 @@ static int amdgpu_cs_patch_ibs(struct amdgpu_cs_p=
arser *p,
> >                         r =3D amdgpu_ring_parse_cs(ring, p, job, ib);
> >                         if (r)
> >                                 return r;
> > +
> > +                       if (ib->sa_bo)
> > +                               ib->gpu_addr =3D  amdgpu_sa_bo_gpu_addr=
(ib->sa_bo);
> >                 } else {
> >                         ib->ptr =3D (uint32_t *)kptr;
> >                         r =3D amdgpu_ring_patch_cs_in_place(ring, p, jo=
b, ib);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm=
/amd/amdgpu/jpeg_v4_0_3.c
> > index ad524ddc9760..6ccf61d7c13d 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> > @@ -782,7 +782,11 @@ void jpeg_v4_0_3_dec_ring_emit_ib(struct amdgpu_ri=
ng *ring,
> >
> >         amdgpu_ring_write(ring, PACKETJ(regUVD_LMI_JRBC_IB_VMID_INTERNA=
L_OFFSET,
> >                 0, 0, PACKETJ_TYPE0));
> > -       amdgpu_ring_write(ring, (vmid | (vmid << 4)));
> > +
> > +       if (ring->funcs->parse_cs)
> > +               amdgpu_ring_write(ring, 0);
> > +       else
> > +               amdgpu_ring_write(ring, (vmid | (vmid << 4)));
>
> This part doesn't make sense to me.  If we use vmid 0, we'll need to
> also patch any addresses in the IB itself to use vmid 0 as well unless
> there is a way to use a vmid 0 address for the IB base, but a
> different vmid for the addresses in the IB.  If it's the latter, then
> we need to make sure that is set up and specify the vmid to use.

David and I discussed this and this is handled in UVD_LMI_JPEG_VMID.

With the below nits fixed, this patch is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

>
> >
> >         amdgpu_ring_write(ring, PACKETJ(regUVD_LMI_JPEG_VMID_INTERNAL_O=
FFSET,
> >                 0, 0, PACKETJ_TYPE0));
> > @@ -1084,6 +1088,7 @@ static const struct amdgpu_ring_funcs jpeg_v4_0_3=
_dec_ring_vm_funcs =3D {
> >         .get_rptr =3D jpeg_v4_0_3_dec_ring_get_rptr,
> >         .get_wptr =3D jpeg_v4_0_3_dec_ring_get_wptr,
> >         .set_wptr =3D jpeg_v4_0_3_dec_ring_set_wptr,
> > +       .parse_cs =3D jpeg_v4_0_3_dec_ring_parse_cs,
> >         .emit_frame_size =3D
> >                 SOC15_FLUSH_GPU_TLB_NUM_WREG * 6 +
> >                 SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 8 +
> > @@ -1248,3 +1253,54 @@ static void jpeg_v4_0_3_set_ras_funcs(struct amd=
gpu_device *adev)
> >  {
> >         adev->jpeg.ras =3D &jpeg_v4_0_3_ras;
> >  }
> > +
> > +/**
> > + * jpeg_v4_0_3_dec_ring_parse_cs - command submission parser
> > + *
> > + * @parser: Command submission parser context
> > + * @job: the job to parse
> > + * @ib: the IB to parse
> > + *
> > + * Parse the command stream, return -EINVAL for invalid packet
> > + * 0 otherwise
> > + */
> > +int jpeg_v4_0_3_dec_ring_parse_cs(struct amdgpu_cs_parser *parser,
> > +                            struct amdgpu_job *job,
> > +                            struct amdgpu_ib *ib)
> > +{
> > +       uint32_t i, reg, res, cond, type;
> > +
> > +       for (i =3D 0; i < ib->length_dw ; i +=3D 2) {
> > +               reg  =3D CP_PACKETJ_GET_REG(ib->ptr[i]);
> > +               res  =3D CP_PACKETJ_GET_RES(ib->ptr[i]);
> > +               cond =3D CP_PACKETJ_GET_COND(ib->ptr[i]);
> > +               type =3D CP_PACKETJ_GET_TYPE(ib->ptr[i]);
> > +
> > +               if(res) /* only support 0 at the moment */
>
> space between if and (.
>
> > +                       return -EINVAL;
> > +
> > +               switch (type) {
> > +               case PACKETJ_TYPE0:
> > +                       if (cond !=3D PACKETJ_CONDITION_CHECK0 || reg <=
 JPEG_REG_RANGE_START || reg > JPEG_REG_RANGE_END) {
> > +                               DRM_ERROR("Invalid packet [0x%08x]!\n",=
 ib->ptr[i]);
>
> use dev_err() so we can differentiate between multiple GPUs.
>
> > +                               return -EINVAL;
> > +                       }
> > +                       break;
> > +               case PACKETJ_TYPE3:
> > +                       if (cond !=3D PACKETJ_CONDITION_CHECK3 || reg <=
 JPEG_REG_RANGE_START || reg > JPEG_REG_RANGE_END) {
> > +                               DRM_ERROR("Invalid packet [0x%08x]!\n",=
 ib->ptr[i]);
>
> Same here.
>
> > +                               return -EINVAL;
> > +                       }
> > +                       break;
> > +               case PACKETJ_TYPE6:
> > +                       if (ib->ptr[i] =3D=3D CP_PACKETJ_NOP)
> > +                               continue;
> > +                       return -EINVAL;
> > +               default:
> > +                       DRM_ERROR("Unknown packet type %d !\n", type);
>
> And here.
>
> > +                       return -EINVAL;
> > +               }
> > +       }
> > +
> > +       return 0;
> > +}
> > diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.h b/drivers/gpu/drm=
/amd/amdgpu/jpeg_v4_0_3.h
> > index 747a3e5f6856..71c54b294e15 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.h
> > @@ -46,6 +46,9 @@
> >
> >  #define JRBC_DEC_EXTERNAL_REG_WRITE_ADDR                              =
 0x18000
> >
> > +#define JPEG_REG_RANGE_START                                          =
 0x4000
> > +#define JPEG_REG_RANGE_END                                            =
 0x41c2
> > +
> >  extern const struct amdgpu_ip_block_version jpeg_v4_0_3_ip_block;
> >
> >  void jpeg_v4_0_3_dec_ring_emit_ib(struct amdgpu_ring *ring,
> > @@ -62,5 +65,7 @@ void jpeg_v4_0_3_dec_ring_insert_end(struct amdgpu_ri=
ng *ring);
> >  void jpeg_v4_0_3_dec_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t=
 reg, uint32_t val);
> >  void jpeg_v4_0_3_dec_ring_emit_reg_wait(struct amdgpu_ring *ring, uint=
32_t reg,
> >                                         uint32_t val, uint32_t mask);
> > -
> > +int jpeg_v4_0_3_dec_ring_parse_cs(struct amdgpu_cs_parser *parser,
> > +                                 struct amdgpu_job *job,
> > +                                 struct amdgpu_ib *ib);
> >  #endif /* __JPEG_V4_0_3_H__ */
> > diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c b/drivers/gpu/drm=
/amd/amdgpu/jpeg_v5_0_0.c
> > index d694a276498a..f4daff90c770 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> > @@ -646,6 +646,7 @@ static const struct amdgpu_ring_funcs jpeg_v5_0_0_d=
ec_ring_vm_funcs =3D {
> >         .get_rptr =3D jpeg_v5_0_0_dec_ring_get_rptr,
> >         .get_wptr =3D jpeg_v5_0_0_dec_ring_get_wptr,
> >         .set_wptr =3D jpeg_v5_0_0_dec_ring_set_wptr,
> > +       .parse_cs =3D jpeg_v4_0_3_dec_ring_parse_cs,
> >         .emit_frame_size =3D
> >                 SOC15_FLUSH_GPU_TLB_NUM_WREG * 6 +
> >                 SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 8 +
> > diff --git a/drivers/gpu/drm/amd/amdgpu/soc15d.h b/drivers/gpu/drm/amd/=
amdgpu/soc15d.h
> > index 2357ff39323f..e74e1983da53 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/soc15d.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/soc15d.h
> > @@ -76,6 +76,12 @@
> >                          ((cond & 0xF) << 24) |                        =
 \
> >                          ((type & 0xF) << 28))
> >
> > +#define CP_PACKETJ_NOP         0x60000000
> > +#define CP_PACKETJ_GET_REG(x)  ((x) & 0x3FFFF)
> > +#define CP_PACKETJ_GET_RES(x)  (((x) >> 18) & 0x3F)
> > +#define CP_PACKETJ_GET_COND(x) (((x) >> 24) & 0xF)
> > +#define CP_PACKETJ_GET_TYPE(x) (((x) >> 28) & 0xF)
> > +
> >  /* Packet 3 types */
> >  #define        PACKET3_NOP                                     0x10
> >  #define        PACKET3_SET_BASE                                0x11
> > --
> > 2.34.1
> >
