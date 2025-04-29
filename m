Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8220CC369DC
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Apr 2025 19:19:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07C7689518;
	Tue, 29 Apr 2025 19:19:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PBSH89fD";
	dkim-atps=neutral
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com
 [209.85.215.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04E4889518
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Apr 2025 19:19:17 +0000 (UTC)
Received: by mail-pg1-f181.google.com with SMTP id
 41be03b00d2f7-af51b57ea41so734360a12.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Apr 2025 12:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745954357; x=1746559157; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qUILtpdGnUS6bouiEoecog3s3QegW47Fb4E7DVq2Nlc=;
 b=PBSH89fDUWCjI+y031x6FumsV3bAiEPuH2FWw+F8mckZc/599yAVpn7N2uEyQniKbG
 nf0aVUfy3QLxY+0jhXdNQ2mR61l3Dyl4cVc0GBHkj5pLYl/rGdXEH4uNGULF1ls4PDjM
 P+l01OvWzaD2W9iz1+khaiq1oCpB8nFMnDhF4PDcggNe/Wz/EL4QkAlcURvi1ziSBt+Y
 2jWss5bIBEqHZR9Z2ALSFJfBM58JgkiYmJux24l/xW9gJzeoz2b25D0jcr5Bc6CnYqYc
 JI6HquBi24HwOahL5Ycj1y4zYn4sQrsD6nmw/rnlSi6wndlgqv2yfIzxmLNuVFYrBhYd
 q3YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745954357; x=1746559157;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qUILtpdGnUS6bouiEoecog3s3QegW47Fb4E7DVq2Nlc=;
 b=nWHHbFyp9eaW3qlqoYhzrVYUckw8QeiwEDUzA7HqPHVwO59J5VrslsD7ork5GNuFmK
 Q+iq+F/U7IF2QitxpI1Jze9wXIGRz+ErrxGZp9BMbRvgN8JZ9lbUGIqjgBRo76UTF1k6
 xLS9R5m73McXVfArMs4BHdGfP7DHXOZ0iOLNtbHKH2FhDJpJcRvylRjCsr2Qezwg23tI
 /Ego605m9mfvCCC2nc14YdgK269mQPh0BxNyF8gl8zxeI/R0u7rU3r9tUJL9XUUBrOj2
 qIjU1AqaBZyGSVOOzDmSBk9tX3tcKY/+v7VMf7ww91slbUzsLw5uCcJUQCYt55MOqKCZ
 b1fQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNJFQ+nva+8XODiOmimLG0iuK1Sdd9Fuw3ox5CYjGKqQpxR7brj25QfdkCvk5olomV5PQzbbKe@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy+M2i+656xT4LBsN4ojwwCrIs1+IByxqGnaIdP/LwjDOpWf1KG
 FkX++AAzyOUpZ66zc6t1r48OCy0J7GDk1i7JrtrqozWGlMkcoAftkhNx9MHNHcECs21j140YLVj
 ZROE6rcEHOjG+C5WRoVUW7LLwkVs=
X-Gm-Gg: ASbGncvX1CZFY/KzbSJrYh+6vprOBaXwb6FLL1sFm+WkmUArQAxOMg6i5Tm5FJzT2oY
 wPXey7Hsm4pNThfVbkPQUu8raPmJvTS6QCh8qA0JmUoJ91KACw84oOMT6967jIU1zx5G3F7pp65
 g4U4l7Y8eS5YQTooVjQJZakQ==
X-Google-Smtp-Source: AGHT+IHKbS3gpxoAWbJifnBdPI5+K3067bGUmIQdmLoBziwIEz3CzGEFkYKBtezW1e7IrtntgXc1sbu4HvOQAgJInPA=
X-Received: by 2002:a17:90b:4b01:b0:30a:2173:9f16 with SMTP id
 98e67ed59e1d1-30a332d60c1mr169114a91.1.1745954356766; Tue, 29 Apr 2025
 12:19:16 -0700 (PDT)
MIME-Version: 1.0
References: <20250428212050.1098434-1-alexander.deucher@amd.com>
 <20250428212050.1098434-5-alexander.deucher@amd.com>
 <SJ1PR12MB626846D071EF8DD342E4900294802@SJ1PR12MB6268.namprd12.prod.outlook.com>
 <CADnq5_P+kCk0vDm4W5K4QUF8_AR9iBRL2+-EgDJJTQVduMiLSw@mail.gmail.com>
 <CH0PR12MB53724E7D012C8D79AB497A5AF4802@CH0PR12MB5372.namprd12.prod.outlook.com>
 <CADnq5_P+Nv+SUZO+f14-Yp+D=kybtGyuKT2tA1teijDdiqbOOw@mail.gmail.com>
 <CH0PR12MB5372FD59F67537B0496A9A19F4802@CH0PR12MB5372.namprd12.prod.outlook.com>
In-Reply-To: <CH0PR12MB5372FD59F67537B0496A9A19F4802@CH0PR12MB5372.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 29 Apr 2025 15:19:05 -0400
X-Gm-Features: ATxdqUGx8Xzd-qTh3W8E1eY9VWlQmOITbVU_URZ5DfxI9TfqWmIw3DBIErnJVwk
Message-ID: <CADnq5_OFSrNWg7iKcqZdo994MuuHKVB5QBx2k3Rqe_TeAkHzgg@mail.gmail.com>
Subject: Re: [PATCH 5/8] drm/amdgpu/mes12: add support for setting gang submit
To: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
Cc: "Chen, Michael" <Michael.Chen@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Khatri,
 Sunil" <Sunil.Khatri@amd.com>, "Liang, Prike" <Prike.Liang@amd.com>
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

On Tue, Apr 29, 2025 at 3:16=E2=80=AFPM Liu, Shaoyun <Shaoyun.Liu@amd.com> =
wrote:
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
>  kiq still be  used for kernel queues map/unmap including the  scheduler =
queue itself . I think we can keep this design.   The  gang related will go=
 through  SCHED.

What about queue resets?

Alex

>
> Regards
> Shaoyun.liu
>
> -----Original Message-----
> From: Alex Deucher <alexdeucher@gmail.com>
> Sent: Tuesday, April 29, 2025 3:05 PM
> To: Liu, Shaoyun <Shaoyun.Liu@amd.com>
> Cc: Chen, Michael <Michael.Chen@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; amd-gfx@lists.freedesktop.org; Khatri, Sunil <Sunil.Khatri=
@amd.com>; Liang, Prike <Prike.Liang@amd.com>
> Subject: Re: [PATCH 5/8] drm/amdgpu/mes12: add support for setting gang s=
ubmit
>
> On Tue, Apr 29, 2025 at 2:56=E2=80=AFPM Liu, Shaoyun <Shaoyun.Liu@amd.com=
> wrote:
> >
> > [AMD Official Use Only - AMD Internal Distribution Only]
> >
> > Correctly , the gang submission related stuff only used for scheduler p=
ipe , kiq is for used for kernel driver only and  should not expose to the =
 user queue.
>
> What about kernel queues mapped through MES?  Do those need to go through=
 KIQ or is SCHED ok?  They seem to go through KIQ today.  Is going through =
SCHED ok?
>
> Alex
>
>
> >
> > Regards
> > Shaoyun.liu
> >
> > -----Original Message-----
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> > Alex Deucher
> > Sent: Tuesday, April 29, 2025 2:39 PM
> > To: Chen, Michael <Michael.Chen@amd.com>
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>;
> > amd-gfx@lists.freedesktop.org; Khatri, Sunil <Sunil.Khatri@amd.com>;
> > Liang, Prike <Prike.Liang@amd.com>
> > Subject: Re: [PATCH 5/8] drm/amdgpu/mes12: add support for setting
> > gang submit
> >
> > On Tue, Apr 29, 2025 at 2:23=E2=80=AFPM Chen, Michael <Michael.Chen@amd=
.com> wrote:
> > >
> > > [Public]
> > >
> > >
> > >
> > >
> > > ________________________________
> > > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of
> > > Alex Deucher <alexander.deucher@amd.com>
> > > Sent: Monday, April 28, 2025 5:20 PM
> > > To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> > > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Khatri, Sunil
> > > <Sunil.Khatri@amd.com>; Liang, Prike <Prike.Liang@amd.com>
> > > Subject: [PATCH 5/8] drm/amdgpu/mes12: add support for setting gang
> > > submit
> > >
> > > Enable a primary and secondary queue that schedule together.
> > >
> > > v2: fix offset of api_status (Prike)
> > >
> > > Acked-by: Sunil Khatri <sunil.khatri@amd.com>
> > > Reviewed-by: Prike Liang <Prike.Liang@amd.com>
> > > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > > ---
> > >  drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 28
> > > ++++++++++++++++++++++++++
> > >  1 file changed, 28 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> > > b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> > > index f9f2fbc0a7166..57d8b78210f9f 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> > > @@ -879,6 +879,33 @@ static int mes_v12_0_reset_hw_queue(struct amdgp=
u_mes *mes,
> > >                          offsetof(union MESAPI__RESET, api_status));
> > > }
> > >
> > > +static int mes_v12_0_set_gang_submit(struct amdgpu_mes *mes,
> > > +                                    struct
> > > +mes_set_gang_submit_input
> > > +*input) {
> > > +       union MESAPI__SET_GANG_SUBMIT mes_gang_submit_pkt;
> > > +       int pipe;
> > > +
> > > +       memset(&mes_gang_submit_pkt, 0,
> > > + sizeof(mes_gang_submit_pkt));
> > > +
> > > +       mes_gang_submit_pkt.header.type =3D MES_API_TYPE_SCHEDULER;
> > > +       mes_gang_submit_pkt.header.opcode =3D MES_SCH_API_SET_GANG_SU=
BMIT;
> > > +       mes_gang_submit_pkt.header.dwsize =3D
> > > + API_FRAME_SIZE_IN_DWORDS;
> > > +
> > > +       mes_gang_submit_pkt.set_gang_submit.gang_context_addr =3D
> > > +               input->primary_gang_context_addr;
> > > +       mes_gang_submit_pkt.set_gang_submit.slave_gang_context_addr =
=3D
> > > +               input->secondary_gang_context_addr;
> > > +
> > > +       if (mes->adev->enable_uni_mes)
> > > +               pipe =3D AMDGPU_MES_KIQ_PIPE;
> > > +       else
> > > +               pipe =3D AMDGPU_MES_SCHED_PIPE;
> > >
> > > I think this packet should be always submitted to
> > > AMDGPU_MES_SCHED_PIPE, same pipe as in mes_v12_0_add_hw_queue where t=
he queue is created.
> > > This is because HWS on AMDGPU_MES_KIQ_PIPE does not have the queue in=
formation.
> >
> > Sounds like the reset queue function and the map and unmap legacy queue=
s should also be changed?
> >
> > Alex
> >
> > >
> > > +
> > > +       return mes_v12_0_submit_pkt_and_poll_completion(mes, pipe,
> > > +                       &mes_gang_submit_pkt, sizeof(mes_gang_submit_=
pkt),
> > > +                       offsetof(union MESAPI__SET_GANG_SUBMIT,
> > > +api_status)); }
> > > +
> > >  static const struct amdgpu_mes_funcs mes_v12_0_funcs =3D {
> > >          .add_hw_queue =3D mes_v12_0_add_hw_queue,
> > >          .remove_hw_queue =3D mes_v12_0_remove_hw_queue, @@ -888,6
> > > +915,7 @@ static const struct amdgpu_mes_funcs mes_v12_0_funcs =3D {
> > >          .resume_gang =3D mes_v12_0_resume_gang,
> > >          .misc_op =3D mes_v12_0_misc_op,
> > >          .reset_hw_queue =3D mes_v12_0_reset_hw_queue,
> > > +       .set_gang_submit =3D mes_v12_0_set_gang_submit,
> > >  };
> > >
> > >  static int mes_v12_0_allocate_ucode_buffer(struct amdgpu_device
> > > *adev,
> > > --
> > > 2.49.0
> > >
