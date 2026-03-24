Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95BC8F54AC0
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2026 14:13:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E5FB10E6D7;
	Tue, 24 Mar 2026 14:13:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Od66X8Pp";
	dkim-atps=neutral
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A259610E6D7
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Mar 2026 14:12:58 +0000 (UTC)
Received: by mail-dl1-f47.google.com with SMTP id
 a92af1059eb24-124b07e5fe4so427741c88.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Mar 2026 07:12:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774361578; cv=none;
 d=google.com; s=arc-20240605;
 b=L5JC2NK/ROw8Z6IR7nl2OTLeXiyTgkvScquE8XfngTGU9agX1POSl8AfriyeZuoD/Y
 RdH4jNHUziiGUIJBBP86Ev4rOiFhtUqhtu4TvUFuXQIVBKO5IXO9E36ZhxmYWkhh9ijh
 x7TigwKwJpIREY3VHnCUNfEAaWAiYh50sQTRBf9qBdtBmazphGCh9XEkbqElW6uZ04pi
 G5fNHTpayCnjnGNUi3xgXHDT3itNF6OlwvarN7qR/MoeIlIz5FYrKpcpMgTGbfTlbWgd
 pC1eenCkB7RmQtTr1esr1B0sfBuGpqP0slF6XaAik1IG8Gkbu9kQGRrqJE9XaQpqfZHL
 BxoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=BaLM9jHJwB9jdRIwIzzYE3rayyLno9MIdFG9d5T0/A0=;
 fh=S8zJ5gKYj2sjaf1G2mxc04ZMYUx7MlAi0a3XP8/+mBw=;
 b=QaQdUuB5/mTWbzNj8ST729j3hVjzm4JnMjU9IFucNhpOI39cxHg1sprWvtT11Lwdo0
 xkX5G2xjfDC3JZ5mxTwXB7Rx6YmbMokjQTPswpoz+vMIVqbiJWjdMiF7lOTRt59UFp3Z
 oK7TC208K2f9XrYukuPl0vsdp9UX2SQyXURux7kP+ij2pyKapNdtRTmYVzbz6OqHS9i/
 12dIdaI7vrd3LBuEc5Qf6VoPqEXLaoSMMVr7LiRXlKiDfN/+86yLJGz/olm9tV1xaoU1
 B76OggGy5c5TGqlDaWXTZLvNXkJJoVj7yS0nJzYxX/Z3R8sjcGHbRv/5CnuFJTkd9lNG
 P/8Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774361578; x=1774966378; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BaLM9jHJwB9jdRIwIzzYE3rayyLno9MIdFG9d5T0/A0=;
 b=Od66X8PpoZazZfiVZfEWjrdJ0BLcce+BZzn/KI4fc+WjX4ma4aV0VOYhd/rRNBhWiC
 UCMcQvNv7GC1WRTtSXglCXP0gp2voSbQ/E6K01aF13Ziy3k/O2RiJclD1SvWKxs1MG+s
 9BzOtW1ZnXK2CjWbWfJo4jXAKv33IBzSiq44C7OxwWO76i+4wncXHs1PDthqno8/7T9z
 2k3Uw3VGeZ3gO+3QAvcov4d3fS3xf//bIs6WP5q2uRB293jVsqs3lPi3KHf+zaZWjJOe
 Xe7Eg7t37z48ok2kcBJeQV6SuKIgnOo2zuGA8YENqte0mzlXznHBk8wb+PinL0are4rH
 WHYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774361578; x=1774966378;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BaLM9jHJwB9jdRIwIzzYE3rayyLno9MIdFG9d5T0/A0=;
 b=MOltoj08kDHzHaMlZkpUpBUQUMD3DgAGB/T4yiVdSJHTYykBKkxKsCZMhwlKASd/+u
 NLcr8obsbBjuIt4jPlLmVRjeIEls9wYrX0JSSQOmi4mZQ4Dmb7YUnXx/qXwAk+IaS/am
 k1R6/WKEbyzsVuzEhN7/aUpll7a/WNIoWXn5AUHRs7Zz0+KK0KA+JE2hDvgN0w3aHGRa
 vvfeeg6ViLVOZgM9TGcZuKxtbsQlf+th2OtY6OymStlZ1cBXLQS92TBxfeA1fx5RtPgS
 5kwxySbgpHg4O8aDmojNz4vO9if5ZV/zVEwvpmwVROr7Ykj2LfmuSQeMilvYr7uXH0hR
 +ubw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMWG7ZqJicdALjWmBWLkNvbcZ4ZtvtvxvtUvxUjyZVyiYU4uVCnrPKzKi2MKxDtQHEA1EJwEzH@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwIUt0ACs5etpvjxJTFHnmin0bMU32vKPINcPKvZF/riq4PsEtD
 S0ZiAV3AniKTyiyLlmBi4fuF2BYBughDdq/G3iXstqucy5F9gr6W0q27yHb+Ed/yFas6gnzrClv
 96RbgLBo1VDh3dI8fRQ6x4JBOfoDOkME=
X-Gm-Gg: ATEYQzy1ICKqPdRrqVOpSmlUmOuOiI2SKNQ/zSKJLGLjmvDfJ2Ih3YDm9aTGSHozFkZ
 iHcBYBZX4fjfNaOAfdoUYslEDRv8Y1lE7bxirtIGfpTQkBjhKiUgirMrS792B97G9Yk7KQ8WNVZ
 RI1fg5vfeWI9/Eq1JARxoL9pIN4Gn6U21ame6Z02GGCo6fdtEcHCVxNejgOKNNVgiMtIAUgly71
 tBCgI8A4bMmN94KfZCIS4B7QV+Hsu90mlvDbjLHaPP44RrhTcT7wzTMZVoTLc2mPXb+AxDKse2B
 Nqd0mlSCr2cuJS/Jljf6JGf8zT7miupeFaTfnBkcYArOklKoz6/ic7iezoVjTE2meqABQg==
X-Received: by 2002:a05:7022:661e:b0:128:d359:92bb with SMTP id
 a92af1059eb24-12a726569cdmr3513310c88.1.1774361577709; Tue, 24 Mar 2026
 07:12:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260323153923.1055788-1-alexander.deucher@amd.com>
 <20260323153923.1055788-2-alexander.deucher@amd.com>
 <CADnq5_NaEEH1-Kcpmbze96g6GucAanpZF6AgFmhMcDHu90uSRg@mail.gmail.com>
 <IA0PR12MB82080E42594DA1C4940FD8569048A@IA0PR12MB8208.namprd12.prod.outlook.com>
In-Reply-To: <IA0PR12MB82080E42594DA1C4940FD8569048A@IA0PR12MB8208.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 24 Mar 2026 10:12:46 -0400
X-Gm-Features: AaiRm52Uh5SDaNjN-2QTztfvDfZ7drVwf7aasOJAL8cLYAWlZswfQvKULT4e4_k
Message-ID: <CADnq5_PtxmANpDoN6h1_T_x42U6wwgAF+Q6TOk4tRRnSpg0Ujg@mail.gmail.com>
Subject: Re: [PATCH 2/3] drm/amd/display: Fix DCE LVDS handling
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Li,
 Roman" <Roman.Li@amd.com>
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

On Tue, Mar 24, 2026 at 10:10=E2=80=AFAM SHANMUGAM, SRINIVASAN
<SRINIVASAN.SHANMUGAM@amd.com> wrote:
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Hi Alex,
>
> Do we need to handle similar cases in DCN resource paths (e.g., dcn10/dcn=
401) ie., dcn401_resource.c and dcn10_resource.c?
> They also reject encoder creation when hpd_source is out of range, but un=
like
> DCE they don=E2=80=99t have no_hpd handling. Or is this not applicable si=
nce DCN
> doesn=E2=80=99t support LVDS/no-HPD cases?

Correct.  Everything should have HPD for DCN.

Alex

>
> Thanks,
> Srini
>
> > -----Original Message-----
> > From: Alex Deucher <alexdeucher@gmail.com>
> > Sent: Tuesday, March 24, 2026 6:18 PM
> > To: Deucher, Alexander <Alexander.Deucher@amd.com>
> > Cc: amd-gfx@lists.freedesktop.org; SHANMUGAM, SRINIVASAN
> > <SRINIVASAN.SHANMUGAM@amd.com>; Li, Roman <Roman.Li@amd.com>
> > Subject: Re: [PATCH 2/3] drm/amd/display: Fix DCE LVDS handling
> >
> > Ping?  This fixes a regression on LVDS systems.
> >
> > Alex
> >
> > On Mon, Mar 23, 2026 at 11:41=E2=80=AFAM Alex Deucher <alexander.deuche=
r@amd.com>
> > wrote:
> > >
> > > LVDS does not use an HPD pin so it may be invalid.  Handle this case
> > > correctly in link encoder creation.
> > >
> > > Fixes: 7c8fb3b8e9ba ("drm/amd/display: Add hpd_source index check for
> > > DCE60/80/100/110/112/120 link encoders")
> > > Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/5012
> > > Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> > > Cc: Roman Li <roman.li@amd.com>
> > > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > > ---
> > >  .../display/dc/resource/dce100/dce100_resource.c   |  6 ++----
> > >  .../display/dc/resource/dce110/dce110_resource.c   |  5 +++--
> > >  .../display/dc/resource/dce112/dce112_resource.c   |  5 +++--
> > >  .../display/dc/resource/dce120/dce120_resource.c   |  5 +++--
> > >  .../amd/display/dc/resource/dce60/dce60_resource.c | 14
> > > ++++++--------  .../amd/display/dc/resource/dce80/dce80_resource.c |
> > > 6 ++----
> > >  6 files changed, 19 insertions(+), 22 deletions(-)
> > >
> > > diff --git
> > > a/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
> > > b/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
> > > index 05f7ff60f8f5a..2b884e28727ba 100644
> > > --- a/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.=
c
> > > +++ b/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.=
c
> > > @@ -651,9 +651,6 @@ static struct link_encoder *dce100_link_encoder_c=
reate(
> > >                 return &enc110->base;
> > >         }
> > >
> > > -       if (enc_init_data->hpd_source >=3D ARRAY_SIZE(link_enc_hpd_re=
gs))
> > > -               return NULL;
> > > -
> > >         link_regs_id =3D
> > >
> > > map_transmitter_id_to_phy_instance(enc_init_data->transmitter);
> > >
> > > @@ -662,7 +659,8 @@ static struct link_encoder *dce100_link_encoder_c=
reate(
> > >                                       &link_enc_feature,
> > >                                       &link_enc_regs[link_regs_id],
> > >                                       &link_enc_aux_regs[enc_init_dat=
a->channel - 1],
> > > -                                     &link_enc_hpd_regs[enc_init_dat=
a->hpd_source]);
> > > +                                     enc_init_data->hpd_source >=3D
> > ARRAY_SIZE(link_enc_hpd_regs) ?
> > > +                                     NULL :
> > > + &link_enc_hpd_regs[enc_init_data->hpd_source]);
> > >         return &enc110->base;
> > >  }
> > >
> > > diff --git
> > > a/drivers/gpu/drm/amd/display/dc/resource/dce110/dce110_resource.c
> > > b/drivers/gpu/drm/amd/display/dc/resource/dce110/dce110_resource.c
> > > index 7c09825cd9bd3..d957598911cbc 100644
> > > --- a/drivers/gpu/drm/amd/display/dc/resource/dce110/dce110_resource.=
c
> > > +++ b/drivers/gpu/drm/amd/display/dc/resource/dce110/dce110_resource.=
c
> > > @@ -672,7 +672,7 @@ static struct link_encoder *dce110_link_encoder_c=
reate(
> > >                 kzalloc(sizeof(struct dce110_link_encoder), GFP_KERNE=
L);
> > >         int link_regs_id;
> > >
> > > -       if (!enc110 || enc_init_data->hpd_source >=3D
> > ARRAY_SIZE(link_enc_hpd_regs))
> > > +       if (!enc110)
> > >                 return NULL;
> > >
> > >         link_regs_id =3D
> > > @@ -683,7 +683,8 @@ static struct link_encoder *dce110_link_encoder_c=
reate(
> > >                                       &link_enc_feature,
> > >                                       &link_enc_regs[link_regs_id],
> > >                                       &link_enc_aux_regs[enc_init_dat=
a->channel - 1],
> > > -                                     &link_enc_hpd_regs[enc_init_dat=
a->hpd_source]);
> > > +                                     enc_init_data->hpd_source >=3D
> > ARRAY_SIZE(link_enc_hpd_regs) ?
> > > +                                     NULL :
> > > + &link_enc_hpd_regs[enc_init_data->hpd_source]);
> > >         return &enc110->base;
> > >  }
> > >
> > > diff --git
> > > a/drivers/gpu/drm/amd/display/dc/resource/dce112/dce112_resource.c
> > > b/drivers/gpu/drm/amd/display/dc/resource/dce112/dce112_resource.c
> > > index 3f0a6bc4dcc23..1cce903d477aa 100644
> > > --- a/drivers/gpu/drm/amd/display/dc/resource/dce112/dce112_resource.=
c
> > > +++ b/drivers/gpu/drm/amd/display/dc/resource/dce112/dce112_resource.=
c
> > > @@ -633,7 +633,7 @@ static struct link_encoder *dce112_link_encoder_c=
reate(
> > >                 kzalloc(sizeof(struct dce110_link_encoder), GFP_KERNE=
L);
> > >         int link_regs_id;
> > >
> > > -       if (!enc110 || enc_init_data->hpd_source >=3D
> > ARRAY_SIZE(link_enc_hpd_regs))
> > > +       if (!enc110)
> > >                 return NULL;
> > >
> > >         link_regs_id =3D
> > > @@ -644,7 +644,8 @@ static struct link_encoder *dce112_link_encoder_c=
reate(
> > >                                       &link_enc_feature,
> > >                                       &link_enc_regs[link_regs_id],
> > >                                       &link_enc_aux_regs[enc_init_dat=
a->channel - 1],
> > > -                                     &link_enc_hpd_regs[enc_init_dat=
a->hpd_source]);
> > > +                                     enc_init_data->hpd_source >=3D
> > ARRAY_SIZE(link_enc_hpd_regs) ?
> > > +                                     NULL :
> > > + &link_enc_hpd_regs[enc_init_data->hpd_source]);
> > >         return &enc110->base;
> > >  }
> > >
> > > diff --git
> > > a/drivers/gpu/drm/amd/display/dc/resource/dce120/dce120_resource.c
> > > b/drivers/gpu/drm/amd/display/dc/resource/dce120/dce120_resource.c
> > > index 92890784caa6e..8b568be20a77b 100644
> > > --- a/drivers/gpu/drm/amd/display/dc/resource/dce120/dce120_resource.=
c
> > > +++ b/drivers/gpu/drm/amd/display/dc/resource/dce120/dce120_resource.=
c
> > > @@ -717,7 +717,7 @@ static struct link_encoder *dce120_link_encoder_c=
reate(
> > >                 kzalloc(sizeof(struct dce110_link_encoder), GFP_KERNE=
L);
> > >         int link_regs_id;
> > >
> > > -       if (!enc110 || enc_init_data->hpd_source >=3D
> > ARRAY_SIZE(link_enc_hpd_regs))
> > > +       if (!enc110)
> > >                 return NULL;
> > >
> > >         link_regs_id =3D
> > > @@ -728,7 +728,8 @@ static struct link_encoder *dce120_link_encoder_c=
reate(
> > >                                       &link_enc_feature,
> > >                                       &link_enc_regs[link_regs_id],
> > >                                       &link_enc_aux_regs[enc_init_dat=
a->channel - 1],
> > > -                                     &link_enc_hpd_regs[enc_init_dat=
a->hpd_source]);
> > > +                                     enc_init_data->hpd_source >=3D
> > ARRAY_SIZE(link_enc_hpd_regs) ?
> > > +                                     NULL :
> > > + &link_enc_hpd_regs[enc_init_data->hpd_source]);
> > >
> > >         return &enc110->base;
> > >  }
> > > diff --git
> > > a/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
> > > b/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
> > > index d41d24b76c11f..2f5ee9d8536af 100644
> > > --- a/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
> > > +++ b/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
> > > @@ -747,18 +747,16 @@ static struct link_encoder
> > *dce60_link_encoder_create(
> > >                 return &enc110->base;
> > >         }
> > >
> > > -       if (enc_init_data->hpd_source >=3D ARRAY_SIZE(link_enc_hpd_re=
gs))
> > > -               return NULL;
> > > -
> > >         link_regs_id =3D
> > >
> > > map_transmitter_id_to_phy_instance(enc_init_data->transmitter);
> > >
> > >         dce60_link_encoder_construct(enc110,
> > > -                                     enc_init_data,
> > > -                                     &link_enc_feature,
> > > -                                     &link_enc_regs[link_regs_id],
> > > -                                     &link_enc_aux_regs[enc_init_dat=
a->channel - 1],
> > > -                                     &link_enc_hpd_regs[enc_init_dat=
a->hpd_source]);
> > > +                                    enc_init_data,
> > > +                                    &link_enc_feature,
> > > +                                    &link_enc_regs[link_regs_id],
> > > +                                    &link_enc_aux_regs[enc_init_data=
->channel - 1],
> > > +                                    enc_init_data->hpd_source >=3D
> > ARRAY_SIZE(link_enc_hpd_regs) ?
> > > +                                    NULL :
> > > + &link_enc_hpd_regs[enc_init_data->hpd_source]);
> > >         return &enc110->base;
> > >  }
> > >
> > > diff --git
> > > a/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c
> > > b/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c
> > > index a68e799d58854..406705fac7d64 100644
> > > --- a/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c
> > > +++ b/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c
> > > @@ -753,9 +753,6 @@ static struct link_encoder *dce80_link_encoder_cr=
eate(
> > >                 return &enc110->base;
> > >         }
> > >
> > > -       if (enc_init_data->hpd_source >=3D ARRAY_SIZE(link_enc_hpd_re=
gs))
> > > -               return NULL;
> > > -
> > >         link_regs_id =3D
> > >
> > > map_transmitter_id_to_phy_instance(enc_init_data->transmitter);
> > >
> > > @@ -764,7 +761,8 @@ static struct link_encoder *dce80_link_encoder_cr=
eate(
> > >                                       &link_enc_feature,
> > >                                       &link_enc_regs[link_regs_id],
> > >                                       &link_enc_aux_regs[enc_init_dat=
a->channel - 1],
> > > -                                     &link_enc_hpd_regs[enc_init_dat=
a->hpd_source]);
> > > +                                     enc_init_data->hpd_source >=3D
> > ARRAY_SIZE(link_enc_hpd_regs) ?
> > > +                                     NULL :
> > > + &link_enc_hpd_regs[enc_init_data->hpd_source]);
> > >         return &enc110->base;
> > >  }
> > >
> > > --
> > > 2.53.0
> > >
