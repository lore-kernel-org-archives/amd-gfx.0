Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D44A2C369DC
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Apr 2025 19:05:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7687610E0D5;
	Tue, 29 Apr 2025 19:05:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZFbz04me";
	dkim-atps=neutral
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 804F410E0A9
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Apr 2025 19:05:18 +0000 (UTC)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-2241c95619eso12248665ad.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Apr 2025 12:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745953518; x=1746558318; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QsDuFCUU/vrbqSuvnS+ZGloa5FT3s69YFv4HBPe/UQw=;
 b=ZFbz04meQT0xsEMBh2hxUetb8nTlla6XI+1ACDJB0jAEhdAY+ZuqHWVEHIqmOo1qCa
 L8+NvD6cBrScIv//CN8DN/wVD6pG861h0iw2VnKn4fnc1rg00UqfD8GZ8ZnW06NEpBAZ
 Xmd+DKta7h1wbKG2gVxcADExZ+kGC5Q1JLiK/TJvN1CMyLt/uD37IraMM6S9voSKA4lb
 t8la3xqlgH4zidmSjLwNh14QPoq8gaEVMesxquSXsBwvHTS4AO6DIQXlOpCMZiZ1fIos
 VDIBPMu9wmkC7TJNR2Ip2Jj73Xma46JS/toWtJqjnSne/UYEp2HOf9XDpRW2Yg24UD9w
 MGrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745953518; x=1746558318;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QsDuFCUU/vrbqSuvnS+ZGloa5FT3s69YFv4HBPe/UQw=;
 b=TtGK3YYcnr0VhTXa31Dl+l7q9I6bguuQcZ8s5R10e/1wdOSBiz6VC9gCb3VJEx00bM
 bsmGHbgGgyrQQGJTxMWhlDJ9rS2e1omQp+Am17z+r4o0MXfDk/n7pImRWgJELxRj3hFp
 ufFZspTN5jJL2j187ACIqXrcOGgl2BWOL6O/14RsNYlAgOb4JgTsQ/fQ3c+G9zXF9nu0
 mfMOd5OKKtvs0XJAHN+qIm7FCvkn79ZO6EnQIJ8QFHwxDTcNcLUFP7NGGmjesi5rpxF5
 jZgTBBgQKOaKqD3n+qItHwzcyN5ChxXIOUALfan4jtNiOqcZcNrwXr+zvf9QNpmAOca7
 X8qw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQssI6jjPhrPvH8+IPT0eJSdEdB/DhVS4a0Ong2nx+RyrN4eH7w5XiO2zxSD4n8dRdUzsmeoJ+@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwSQ5rP4hm6HFKWz629LQMLKxPGiCmfRxrRnR+KZX0dImxj3FKu
 LtrkkH4pCynUei0jiOUgTJGb0DvnKBN4RnD62Ds/OaoDupcze566yW5nclZinhsqBfmsnagx6IZ
 jQGioodBwBwp2u+kuw4I4oQpI8/Z8cQ==
X-Gm-Gg: ASbGncviahATCRI9z2JQhJpm9EwYFZmxRaT58Orx3Lp+gVSV9+HepwkROp2c7DzG4TK
 +L356jMNxXePim3p0uz728e0YEJrbhmlbuTon2TjQ2xyTdoqPSfSC1Nds8jJ37QLW7726abiv9B
 l7JAWWXj8c1wu+mS3fsooUKQ==
X-Google-Smtp-Source: AGHT+IHtANwdOwnyZVAZyWG7bxkWpJTjnuhbEvR+POK0BBMCyz0ntsEAgsALnnngJ9mx+KvCmA9aHzRvQMHIC8ih5TI=
X-Received: by 2002:a17:90b:1b10:b0:2fe:b972:a2c3 with SMTP id
 98e67ed59e1d1-30a331d6956mr146928a91.0.1745953517898; Tue, 29 Apr 2025
 12:05:17 -0700 (PDT)
MIME-Version: 1.0
References: <20250428212050.1098434-1-alexander.deucher@amd.com>
 <20250428212050.1098434-5-alexander.deucher@amd.com>
 <SJ1PR12MB626846D071EF8DD342E4900294802@SJ1PR12MB6268.namprd12.prod.outlook.com>
 <CADnq5_P+kCk0vDm4W5K4QUF8_AR9iBRL2+-EgDJJTQVduMiLSw@mail.gmail.com>
 <CH0PR12MB53724E7D012C8D79AB497A5AF4802@CH0PR12MB5372.namprd12.prod.outlook.com>
In-Reply-To: <CH0PR12MB53724E7D012C8D79AB497A5AF4802@CH0PR12MB5372.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 29 Apr 2025 15:05:06 -0400
X-Gm-Features: ATxdqUFVujsVB7uTLLL5eg8Z5kfzS5ixO8A4RpYEmx6HUtgo-06P8mzzSI_ssEU
Message-ID: <CADnq5_P+Nv+SUZO+f14-Yp+D=kybtGyuKT2tA1teijDdiqbOOw@mail.gmail.com>
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

On Tue, Apr 29, 2025 at 2:56=E2=80=AFPM Liu, Shaoyun <Shaoyun.Liu@amd.com> =
wrote:
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Correctly , the gang submission related stuff only used for scheduler pip=
e , kiq is for used for kernel driver only and  should not expose to the  u=
ser queue.

What about kernel queues mapped through MES?  Do those need to go
through KIQ or is SCHED ok?  They seem to go through KIQ today.  Is
going through SCHED ok?

Alex


>
> Regards
> Shaoyun.liu
>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex D=
eucher
> Sent: Tuesday, April 29, 2025 2:39 PM
> To: Chen, Michael <Michael.Chen@amd.com>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; amd-gfx@lists.freedes=
ktop.org; Khatri, Sunil <Sunil.Khatri@amd.com>; Liang, Prike <Prike.Liang@a=
md.com>
> Subject: Re: [PATCH 5/8] drm/amdgpu/mes12: add support for setting gang s=
ubmit
>
> On Tue, Apr 29, 2025 at 2:23=E2=80=AFPM Chen, Michael <Michael.Chen@amd.c=
om> wrote:
> >
> > [Public]
> >
> >
> >
> >
> > ________________________________
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of
> > Alex Deucher <alexander.deucher@amd.com>
> > Sent: Monday, April 28, 2025 5:20 PM
> > To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Khatri, Sunil
> > <Sunil.Khatri@amd.com>; Liang, Prike <Prike.Liang@amd.com>
> > Subject: [PATCH 5/8] drm/amdgpu/mes12: add support for setting gang
> > submit
> >
> > Enable a primary and secondary queue that schedule together.
> >
> > v2: fix offset of api_status (Prike)
> >
> > Acked-by: Sunil Khatri <sunil.khatri@amd.com>
> > Reviewed-by: Prike Liang <Prike.Liang@amd.com>
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 28
> > ++++++++++++++++++++++++++
> >  1 file changed, 28 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> > b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> > index f9f2fbc0a7166..57d8b78210f9f 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> > @@ -879,6 +879,33 @@ static int mes_v12_0_reset_hw_queue(struct amdgpu_=
mes *mes,
> >                          offsetof(union MESAPI__RESET, api_status));
> > }
> >
> > +static int mes_v12_0_set_gang_submit(struct amdgpu_mes *mes,
> > +                                    struct mes_set_gang_submit_input
> > +*input) {
> > +       union MESAPI__SET_GANG_SUBMIT mes_gang_submit_pkt;
> > +       int pipe;
> > +
> > +       memset(&mes_gang_submit_pkt, 0, sizeof(mes_gang_submit_pkt));
> > +
> > +       mes_gang_submit_pkt.header.type =3D MES_API_TYPE_SCHEDULER;
> > +       mes_gang_submit_pkt.header.opcode =3D MES_SCH_API_SET_GANG_SUBM=
IT;
> > +       mes_gang_submit_pkt.header.dwsize =3D API_FRAME_SIZE_IN_DWORDS;
> > +
> > +       mes_gang_submit_pkt.set_gang_submit.gang_context_addr =3D
> > +               input->primary_gang_context_addr;
> > +       mes_gang_submit_pkt.set_gang_submit.slave_gang_context_addr =3D
> > +               input->secondary_gang_context_addr;
> > +
> > +       if (mes->adev->enable_uni_mes)
> > +               pipe =3D AMDGPU_MES_KIQ_PIPE;
> > +       else
> > +               pipe =3D AMDGPU_MES_SCHED_PIPE;
> >
> > I think this packet should be always submitted to
> > AMDGPU_MES_SCHED_PIPE, same pipe as in mes_v12_0_add_hw_queue where the=
 queue is created.
> > This is because HWS on AMDGPU_MES_KIQ_PIPE does not have the queue info=
rmation.
>
> Sounds like the reset queue function and the map and unmap legacy queues =
should also be changed?
>
> Alex
>
> >
> > +
> > +       return mes_v12_0_submit_pkt_and_poll_completion(mes, pipe,
> > +                       &mes_gang_submit_pkt, sizeof(mes_gang_submit_pk=
t),
> > +                       offsetof(union MESAPI__SET_GANG_SUBMIT,
> > +api_status)); }
> > +
> >  static const struct amdgpu_mes_funcs mes_v12_0_funcs =3D {
> >          .add_hw_queue =3D mes_v12_0_add_hw_queue,
> >          .remove_hw_queue =3D mes_v12_0_remove_hw_queue, @@ -888,6
> > +915,7 @@ static const struct amdgpu_mes_funcs mes_v12_0_funcs =3D {
> >          .resume_gang =3D mes_v12_0_resume_gang,
> >          .misc_op =3D mes_v12_0_misc_op,
> >          .reset_hw_queue =3D mes_v12_0_reset_hw_queue,
> > +       .set_gang_submit =3D mes_v12_0_set_gang_submit,
> >  };
> >
> >  static int mes_v12_0_allocate_ucode_buffer(struct amdgpu_device
> > *adev,
> > --
> > 2.49.0
> >
