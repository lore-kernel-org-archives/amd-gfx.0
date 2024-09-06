Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5B68CE7B1B
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Sep 2024 14:16:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6389E10E09A;
	Fri,  6 Sep 2024 14:16:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="X7ridRbF";
	dkim-atps=neutral
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E55710E9C9
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Sep 2024 08:50:24 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-371ba7e46easo1064588f8f.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 06 Sep 2024 01:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1725612622; x=1726217422;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SR/9jqMaY4ZkJhVpjV584ea+FY7mIMJMTafocuSMEVI=;
 b=X7ridRbFO21NIcwatqjdkfzuKoZLSI7Kh6aJyaxPOyzjMtsJ26PviNx7zM54RyiKrh
 qS+Ul93hocCiVRdRrvR/epJYJYGGD7sIurh0Sp4e7rYEPujPDcPBAPH4u7zRqxqpa+Lp
 Z9MmP8TP8RD7LFMs3tW1zZyGsGUdy9CWpNdfE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725612622; x=1726217422;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SR/9jqMaY4ZkJhVpjV584ea+FY7mIMJMTafocuSMEVI=;
 b=rEA2+Y8lpnPFUUHBJf0QpqJ44yAlV00N8d+XqrlP+DpNGYBRkf+q5nP0cTLHBnsKzd
 3yX7madCjDuXAoUAulx+sdswYWSpTVUAlmKT9j6llZ5rlauxchQt5aPCh+4x50bxehET
 EX8fXDPSxU5z2r7fKECoG/Nai2zIz0i9PRQjBXn8KnU92pBt+4x0dPOY0iRY8ljaZQf8
 81tJwDegTP0rxxG1UJR97rejkLb87wBHt+TFEmZ6HS8ip4AdTR1yJfei8AnQkJwxsfYU
 LSuVvOYj5sdCFlnWOV8y/LADSSGzmnK41/lOjpZFJEEtUcdGP9g1jEAWE9TRR3jIAJmI
 nQrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcGovJGhPWOYW6AuWkRJeL4OB2S54sV2JL2739bba4LzKKc/4Vz/MBdLbwoMRIvISwIdkCJTtw@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzFcBXalXPfeY4zsB9/veWEgOSQibSikQzlBTcYkLwink+ATa4k
 AtMZ5tIOnRJlmdjg/G1p26bn72rlOGI8bUa5kX8IZN1VDZ6mfX+VbeVljAExSXRMUl945LY3tJC
 hkg5A2hBpwLGVs2n++8DlfqccDbWYaj/w8zg9
X-Google-Smtp-Source: AGHT+IEf3kS+J5eIcH9aoEI8sQEx7ql08PzycsM89+gtgjd5bmyXErbV7K7VP95PFXMisPnX+f8aCwG5eZm6hdTL5O8=
X-Received: by 2002:a5d:4983:0:b0:371:86b2:a7e4 with SMTP id
 ffacd0b85a97d-37889682e03mr1118424f8f.37.1725612621485; Fri, 06 Sep 2024
 01:50:21 -0700 (PDT)
MIME-Version: 1.0
References: <20240903045809.5025-1-mukul.sikka@broadcom.com>
 <CADnq5_OVSD1DXgi_9f_H-uT7KSjMwz-FfhP=vRQvposSxv=BMw@mail.gmail.com>
In-Reply-To: <CADnq5_OVSD1DXgi_9f_H-uT7KSjMwz-FfhP=vRQvposSxv=BMw@mail.gmail.com>
From: Mukul Sikka <mukul.sikka@broadcom.com>
Date: Fri, 6 Sep 2024 14:20:09 +0530
Message-ID: <CAG99D9Jss=h5aVLDq0tkDjfZgGUbrNV1gqwcw631RbwCiPVqNg@mail.gmail.com>
Subject: Re: [PATCH v5.15-v5.10] drm/amd/pm: Fix the null pointer dereference
 for vega10_hwmgr
To: Alex Deucher <alexdeucher@gmail.com>
Cc: stable@vger.kernel.org, gregkh@linuxfoundation.org, evan.quan@amd.com, 
 alexander.deucher@amd.com, christian.koenig@amd.com, airlied@linux.ie, 
 daniel@ffwll.ch, Jun.Ma2@amd.com, kevinyang.wang@amd.com, sashal@kernel.org, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, ajay.kaher@broadcom.com, 
 alexey.makhalov@broadcom.com, vasavi.sirnapalli@broadcom.com, 
 Bob Zhou <bob.zhou@amd.com>, Tim Huang <Tim.Huang@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 06 Sep 2024 14:16:25 +0000
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

On Fri, Sep 6, 2024 at 12:05=E2=80=AFAM Alex Deucher <alexdeucher@gmail.com=
> wrote:
>
> On Tue, Sep 3, 2024 at 5:53=E2=80=AFAM sikkamukul <mukul.sikka@broadcom.c=
om> wrote:
> >
> > From: Bob Zhou <bob.zhou@amd.com>
> >
> > [ Upstream commit 50151b7f1c79a09117837eb95b76c2de76841dab ]
> >
> > Check return value and conduct null pointer handling to avoid null poin=
ter dereference.
> >
> > Signed-off-by: Bob Zhou <bob.zhou@amd.com>
> > Reviewed-by: Tim Huang <Tim.Huang@amd.com>
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > Signed-off-by: Mukul Sikka <mukul.sikka@broadcom.com>
>
> Just out of curiosity, are you actually seeing an issue?  This and a
> lot of the other recent NULL check patches are just static checker
> fixes.  They don't actually fix a known issue.
>
No, according to the description of this patch and CVE-2024-43905.
It seems to be applicable to LTS.

- Mukul

> > ---
> >  .../drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c | 30 ++++++++++++++++---
> >  1 file changed, 26 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c b/dr=
ivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
> > index 10678b519..304874cba 100644
> > --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
> > +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
> > @@ -3391,13 +3391,17 @@ static int vega10_find_dpm_states_clocks_in_dpm=
_table(struct pp_hwmgr *hwmgr, co
> >         const struct vega10_power_state *vega10_ps =3D
> >                         cast_const_phw_vega10_power_state(states->pnew_=
state);
> >         struct vega10_single_dpm_table *sclk_table =3D &(data->dpm_tabl=
e.gfx_table);
> > -       uint32_t sclk =3D vega10_ps->performance_levels
> > -                       [vega10_ps->performance_level_count - 1].gfx_cl=
ock;
> >         struct vega10_single_dpm_table *mclk_table =3D &(data->dpm_tabl=
e.mem_table);
> > -       uint32_t mclk =3D vega10_ps->performance_levels
> > -                       [vega10_ps->performance_level_count - 1].mem_cl=
ock;
> > +       uint32_t sclk, mclk;
> >         uint32_t i;
> >
> > +       if (vega10_ps =3D=3D NULL)
> > +               return -EINVAL;
> > +       sclk =3D vega10_ps->performance_levels
> > +                       [vega10_ps->performance_level_count - 1].gfx_cl=
ock;
> > +       mclk =3D vega10_ps->performance_levels
> > +                       [vega10_ps->performance_level_count - 1].mem_cl=
ock;
> > +
> >         for (i =3D 0; i < sclk_table->count; i++) {
> >                 if (sclk =3D=3D sclk_table->dpm_levels[i].value)
> >                         break;
> > @@ -3704,6 +3708,9 @@ static int vega10_generate_dpm_level_enable_mask(
> >                         cast_const_phw_vega10_power_state(states->pnew_=
state);
> >         int i;
> >
> > +       if (vega10_ps =3D=3D NULL)
> > +               return -EINVAL;
> > +
> >         PP_ASSERT_WITH_CODE(!vega10_trim_dpm_states(hwmgr, vega10_ps),
> >                         "Attempt to Trim DPM States Failed!",
> >                         return -1);
> > @@ -4828,6 +4835,9 @@ static int vega10_check_states_equal(struct pp_hw=
mgr *hwmgr,
> >
> >         psa =3D cast_const_phw_vega10_power_state(pstate1);
> >         psb =3D cast_const_phw_vega10_power_state(pstate2);
> > +       if (psa =3D=3D NULL || psb =3D=3D NULL)
> > +               return -EINVAL;
> > +
> >         /* If the two states don't even have the same number of perform=
ance levels they cannot be the same state. */
> >         if (psa->performance_level_count !=3D psb->performance_level_co=
unt) {
> >                 *equal =3D false;
> > @@ -4953,6 +4963,8 @@ static int vega10_set_sclk_od(struct pp_hwmgr *hw=
mgr, uint32_t value)
> >                 return -EINVAL;
> >
> >         vega10_ps =3D cast_phw_vega10_power_state(&ps->hardware);
> > +       if (vega10_ps =3D=3D NULL)
> > +               return -EINVAL;
> >
> >         vega10_ps->performance_levels
> >         [vega10_ps->performance_level_count - 1].gfx_clock =3D
> > @@ -5004,6 +5016,8 @@ static int vega10_set_mclk_od(struct pp_hwmgr *hw=
mgr, uint32_t value)
> >                 return -EINVAL;
> >
> >         vega10_ps =3D cast_phw_vega10_power_state(&ps->hardware);
> > +       if (vega10_ps =3D=3D NULL)
> > +               return -EINVAL;
> >
> >         vega10_ps->performance_levels
> >         [vega10_ps->performance_level_count - 1].mem_clock =3D
> > @@ -5239,6 +5253,9 @@ static void vega10_odn_update_power_state(struct =
pp_hwmgr *hwmgr)
> >                 return;
> >
> >         vega10_ps =3D cast_phw_vega10_power_state(&ps->hardware);
> > +       if (vega10_ps =3D=3D NULL)
> > +               return;
> > +
> >         max_level =3D vega10_ps->performance_level_count - 1;
> >
> >         if (vega10_ps->performance_levels[max_level].gfx_clock !=3D
> > @@ -5261,6 +5278,9 @@ static void vega10_odn_update_power_state(struct =
pp_hwmgr *hwmgr)
> >
> >         ps =3D (struct pp_power_state *)((unsigned long)(hwmgr->ps) + h=
wmgr->ps_size * (hwmgr->num_ps - 1));
> >         vega10_ps =3D cast_phw_vega10_power_state(&ps->hardware);
> > +       if (vega10_ps =3D=3D NULL)
> > +               return;
> > +
> >         max_level =3D vega10_ps->performance_level_count - 1;
> >
> >         if (vega10_ps->performance_levels[max_level].gfx_clock !=3D
> > @@ -5451,6 +5471,8 @@ static int vega10_get_performance_level(struct pp=
_hwmgr *hwmgr, const struct pp_
> >                 return -EINVAL;
> >
> >         ps =3D cast_const_phw_vega10_power_state(state);
> > +       if (ps =3D=3D NULL)
> > +               return -EINVAL;
> >
> >         i =3D index > ps->performance_level_count - 1 ?
> >                         ps->performance_level_count - 1 : index;
> > --
> > 2.39.4
> >
