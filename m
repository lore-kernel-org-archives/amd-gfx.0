Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30DA6C001B0
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Aug 2023 16:43:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5C0E10E1DA;
	Tue,  8 Aug 2023 16:43:32 +0000 (UTC)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14F4B10E1DA
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Aug 2023 16:43:31 +0000 (UTC)
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-56cca35d8c3so3171346eaf.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 08 Aug 2023 09:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691513010; x=1692117810;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AV2llAvpGWS4YFm4dzatLYVkWQQgvQvM8ERcCwjUdJA=;
 b=n4PDU8fJW8qYhaZGSvx4qgyywvmVjK8p9TJy2HpUnNMFpXgrT4k1uOgRYgVOJfUKLq
 v4jZah+1JklBnaGVsA7TbS3MOKp6MO9k7/HuWZ9YhE9DpoqCu/OnZsfSuN/7frlQs9Us
 5dmGhuxkBi56l7SjHTqAlAoo0LrwZLEZHXKE5Sw1VnjtD7DROV6fn8NYjkWaBkWUFUyp
 nfs42tg6/oFOd/AFOeEhTGneRmnCJNBZQzE6UcOCd13ysva1UkRW2n5LV3GLP1ING6f6
 E5yUyW8i4rD4Hxl149TR+qMYQ57dW8PZUkrj8vpGuMuDq9xsVpOdH4jUvZaDY49noMkR
 d/ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691513010; x=1692117810;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AV2llAvpGWS4YFm4dzatLYVkWQQgvQvM8ERcCwjUdJA=;
 b=lgtaqnG4J+uIgFDEBTAE12bN2x1ZkzZjb7biMm2QxUgiSBGSwszKc7jmKedQ5k3/r5
 eKX9o0UufT0RPDo455zbRRr9XNb9t4iKwfcryPr8GrPAFxYfd+SAtxDMdlTRIjBua5fI
 SbO1JWjnRoRg6Cj5JMliS3Yn/E8citELqYVuktejlj2UZHyOgMjbXdX2D8nrEUkoy/Cd
 cRHrg9A1osmMFnHe0jxpkxgAa7zaZOlcEpmwSc1BpgX+6DSEmkE9/FJyNdom//AnzdyK
 V3X9vXjYeOGF+uUukZCU/GVnYXSD7GZ3c8I2Q8wl0FrSBeXdiel/phjYghYkOtFGCK4P
 JO3g==
X-Gm-Message-State: AOJu0Yygd+xsak6irKrzqcJo13tzcasb9iyMB8XoDFLCnEqzIGyUXCYt
 xo3o2P9JcratnLkhsk1hWBdT5TCn2VYnxYgBzUA=
X-Google-Smtp-Source: AGHT+IF25d5D9qfekQp6CgUDlGTtGlpckP1hQU9W8Z1DU+goXVzzsvcs5hBMA0k3HgBVWZkvbYP7AHzVT9LZyHI1wQg=
X-Received: by 2002:a05:6871:54f:b0:1bf:dc26:4947 with SMTP id
 t15-20020a056871054f00b001bfdc264947mr122019oal.46.1691513010029; Tue, 08 Aug
 2023 09:43:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230808064025.1008680-1-coelacanth_dream@protonmail.com>
 <DM6PR12MB26194F879FCE037C745B6D97E40DA@DM6PR12MB2619.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB26194F879FCE037C745B6D97E40DA@DM6PR12MB2619.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 8 Aug 2023 12:43:18 -0400
Message-ID: <CADnq5_NdZzofSAoaEg+fZbbn1weELA8acJ++RuekVWH13+YLeA@mail.gmail.com>
Subject: Re: [PATCH] fix throttle_status for other than MP0 11.0.7
To: "Quan, Evan" <Evan.Quan@amd.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Umio Yasuno <coelacanth_dream@protonmail.com>, "Limonciello,
 Mario" <Mario.Limonciello@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Tue, Aug 8, 2023 at 4:38=E2=80=AFAM Quan, Evan <Evan.Quan@amd.com> wrote=
:
>
> [AMD Official Use Only - General]
>
> Reviewed-by: Evan Quan <evan.quan@amd.com>
>
> > -----Original Message-----
> > From: Umio Yasuno <coelacanth_dream@protonmail.com>
> > Sent: Tuesday, August 8, 2023 2:41 PM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan
> > <Evan.Quan@amd.com>; Limonciello, Mario <Mario.Limonciello@amd.com>
> > Subject: [PATCH] fix throttle_status for other than MP0 11.0.7
> >
> > Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2720
> > Signed-off-by: Umio Yasuno <coelacanth_dream@protonmail.com>
> > ---
> >  .../drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c    | 14 +++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> > b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> > index 85d53597e..548d25cf3 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> > @@ -578,7 +578,9 @@ static int sienna_cichlid_tables_init(struct
> > smu_context *smu)
> >       return -ENOMEM;
> >  }
> >
> > -static uint32_t sienna_cichlid_get_throttler_status_locked(struct
> > smu_context *smu)
> > +static uint32_t sienna_cichlid_get_throttler_status_locked(struct
> > smu_context *smu,
> > +                                                        bool
> > use_metrics_v3,
> > +                                                        bool
> > use_metrics_v2)
> >  {
> >       struct smu_table_context *smu_table=3D &smu->smu_table;
> >       SmuMetricsExternal_t *metrics_ext =3D
> > @@ -586,13 +588,11 @@ static uint32_t
> > sienna_cichlid_get_throttler_status_locked(struct smu_context *s
> >       uint32_t throttler_status =3D 0;
> >       int i;
> >
> > -     if ((smu->adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(11, 0,=
 7))
> > &&
> > -          (smu->smc_fw_version >=3D 0x3A4900)) {
> > +     if (use_metrics_v3) {
> >               for (i =3D 0; i < THROTTLER_COUNT; i++)
> >                       throttler_status |=3D
> >                               (metrics_ext-
> > >SmuMetrics_V3.ThrottlingPercentage[i] ? 1U << i : 0);
> > -     } else if ((smu->adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION=
(11,
> > 0, 7)) &&
> > -          (smu->smc_fw_version >=3D 0x3A4300)) {
> > +     } else if (use_metrics_v2) {
> >               for (i =3D 0; i < THROTTLER_COUNT; i++)
> >                       throttler_status |=3D
> >                               (metrics_ext-
> > >SmuMetrics_V2.ThrottlingPercentage[i] ? 1U << i : 0);
> > @@ -854,7 +854,7 @@ static int sienna_cichlid_get_smu_metrics_data(stru=
ct
> > smu_context *smu,
> >                       metrics->TemperatureVrSoc) *
> > SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
> >               break;
> >       case METRICS_THROTTLER_STATUS:
> > -             *value =3D sienna_cichlid_get_throttler_status_locked(smu=
);
> > +             *value =3D sienna_cichlid_get_throttler_status_locked(smu=
,
> > use_metrics_v3, use_metrics_v2);
> >               break;
> >       case METRICS_CURR_FANSPEED:
> >               *value =3D use_metrics_v3 ? metrics_v3->CurrFanSpeed :
> > @@ -4056,7 +4056,7 @@ static ssize_t
> > sienna_cichlid_get_gpu_metrics(struct smu_context *smu,
> >       gpu_metrics->current_dclk1 =3D use_metrics_v3 ? metrics_v3-
> > >CurrClock[PPCLK_DCLK_1] :
> >               use_metrics_v2 ? metrics_v2->CurrClock[PPCLK_DCLK_1] :
> > metrics->CurrClock[PPCLK_DCLK_1];
> >
> > -     gpu_metrics->throttle_status =3D
> > sienna_cichlid_get_throttler_status_locked(smu);
> > +     gpu_metrics->throttle_status =3D
> > sienna_cichlid_get_throttler_status_locked(smu, use_metrics_v3,
> > use_metrics_v2);
> >       gpu_metrics->indep_throttle_status =3D
> >                       smu_cmn_get_indep_throttler_status(gpu_metrics-
> > >throttle_status,
> >
> > sienna_cichlid_throttler_map);
> > --
> > 2.40.1
> >
>
