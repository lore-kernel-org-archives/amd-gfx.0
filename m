Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37F8410ED664
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2026 12:42:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C25BB10EE35;
	Fri, 27 Mar 2026 12:42:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Tvp6jQTg";
	dkim-atps=neutral
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CE0510EE37
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Mar 2026 12:42:12 +0000 (UTC)
Received: by mail-dl1-f46.google.com with SMTP id
 a92af1059eb24-127337e3870so144732c88.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Mar 2026 05:42:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774615332; cv=none;
 d=google.com; s=arc-20240605;
 b=Kj/SQxgxxqSIfUeYHQAVHtw2P5FsUmw6N6yqTG8xJdPW8RmrKPwcOIIVGSMk9WNfF/
 Yu+3NlcTFdPFiCcgX480kueFiEWkLZYpcmkOtdhR6QUMSbhO6mSaBVjonxq6VD47Gl5J
 5RhKrmmyXmfaSCpl1ZwpiUDrhEirzItuSIUts+kp6wDrdrFXNbhW1TyGpUHreVIsoHaO
 U9shq/gu7K0OhoK5LCJHl/ynIBs4MfTle5BEV1jsp8zEDIgBTF70nPepxLLCQIVdWS7N
 dJZ2iCH1+8IUbVV6iMmVn35IoPNNajHmTFrcFymBxmIQ3BYWNYCq9SZkXlH5Z+QU3QUB
 kZSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=0Sq/Qtz6+u5veUEQh7t7gc8Ia7s1I7ZECBNvi0zrGTg=;
 fh=71VkXJtsWnrS0YqLNTqW148VSsoh0S3c+hQD0YDWlqM=;
 b=H3W1JtIXJ86EG43wsB9gLJQY6uX7pI55UoImlAz9ano6zTOcWokS/v5VTG6HG25Bk9
 TnoD8baLIPyFJM4Thi/6x0WlBP16s2pWbPBPDenZlai474o2QbU9DaHXJEpE6IEDkjGx
 zbotcwY07dwPXFVgqPwnJniOBtrPKvf0aTwLYzqcnV854PinybeygafqP+c528UCqiqr
 oyI76j7NxWJ8XoVcaZlNjhSqDZ5molWWsIfKRO1hJLgXkRY6Moq0se17NV7xUm03+Z79
 KHyp+huM/F+WBFfTRp+EZEPLyiNyHTqe5qpthC3MXOAc1itMigt/7Rh5szQH3F5sPX0l
 I4wA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774615332; x=1775220132; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0Sq/Qtz6+u5veUEQh7t7gc8Ia7s1I7ZECBNvi0zrGTg=;
 b=Tvp6jQTgzH9TwkGZjN3DqT7nRnCPOPS6WWzVI1AN3vHxskYw/n4i+2f9w+RcipuG8u
 +nR7Py6zvSOFB4ALfTOhJqz9+IFbM99IEBeAGzhLsYDcUzNgnD/MX+w/eID8l/KXQ53L
 Qo1rTEZmKaRztsQ7IhsCauR6zydF+UMaZtonkyMSgUq783Z3HIUSxqDM/1V2zjQVKSmh
 SrT2F/JENBJaXHRf7O/yNbrGsFoPvEgy70+xdj5pPAihyISPukK/42PGTnqvGQhiOL5R
 TBBpsRYH8gYZ2neZea3gtul4X+nKLTK0pzJD48fyuql/WDTT3c+kT8FFVob8QapbKOQz
 zj9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774615332; x=1775220132;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0Sq/Qtz6+u5veUEQh7t7gc8Ia7s1I7ZECBNvi0zrGTg=;
 b=pOcACR0ArcZNPU6dUkLL2XZ0q2mX90s8w37jMyssIw/fNmsEe7sZR34w/gIjio3rYa
 rq+XPj1pkKUQlbIl20MWPjcGJkQUIddxM1pNgK4h4Ppq/d1OyZk2jeJbkWrB30C8LsYv
 OfSeTsjMvhjYFLBvnbJTqfLJjxy51kiidL35YKRZvp3A1MTb+13nMadso14tyHdLf8GT
 BeuNcQT9qmN85fBkA04ORreEFCjFtFP0mFhhh6Dn25I5Q90xf4jF0mlPi5tiliJy+pVp
 8cXKVxPACpJbhVERVrB1aWXRTqy+3WfcGoiCvE7MXdOpoAmczt2ldawuKc+gc0V821o2
 e3hw==
X-Gm-Message-State: AOJu0YxJxe/8YYLZfCMh6h2KGH/YcFnd1LFXQZFnAFQ/K2ZPP+qnnedE
 vql5oev8sc4Wx452qRtMINdA6tgeu3BG56RGPxFVlmBkmvDZKxgUcr4kf306igRaRXJPDhq/0ii
 o3qzqj9p0GtT8c7N+a28NGSznKY/ZDr7m4w==
X-Gm-Gg: ATEYQzyJtlA9orcfzFdY4tUYfGiOmPUY1vhbSe1R8EuhIBYsBkTjJh7t7N1xKMQVf+A
 sx1rgoQpDzcyXAX2uzRk44l5HW6RpM1JdMW9nrJBqyPkYV2Uh5l4nYJk2HHQM70j/a/0E6G+sZE
 SiCMW5l/JS6Y0/KueaY4gvKOeL4YBW1pd6YTKu8mct8RUv+i3bGVrrT7/0Ztv+jPZfLkbFCiKq+
 HIbl7TXP2oLdRVSq00aktoWGJE2do+IWdMHTIWgiGZBkcO8eacdiU2Hyi5XRq3AHHoF081hpv46
 JmK2Q+elDHhqfeDVAAXuQGj4NaCjP5n7gbZgPB1U+Js0tjyVwlW8ogHDdyE096lVGlTaIQ==
X-Received: by 2002:a05:7022:628f:b0:127:332d:63e with SMTP id
 a92af1059eb24-12ab29307c2mr619378c88.5.1774615331511; Fri, 27 Mar 2026
 05:42:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260326020445.1187519-1-kevinyang.wang@amd.com>
 <a35ca9d5-354f-4b98-a186-3a4797176b55@amd.com>
 <CADnq5_PRGtHXruP9Y4UxA9-XmJ6UH=VA3OFfE+qs6tfgz3r1ug@mail.gmail.com>
 <DM6PR12MB2972A6DE7761B40B1733A0818256A@DM6PR12MB2972.namprd12.prod.outlook.com>
 <DM6PR12MB2972D38A0949301AA988BFC08256A@DM6PR12MB2972.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB2972D38A0949301AA988BFC08256A@DM6PR12MB2972.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 27 Mar 2026 08:42:00 -0400
X-Gm-Features: AQROBzBgoMB3hGjWNrhScEchi7E6XG_lNLjArUW2V-kISGmuWNg4RgObZhYab5E
Message-ID: <CADnq5_N_Mckv4NkZhLxBhscftg7XM8B3a=ZuJvYwiQjuyO_GOg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: correct mem_busy_percent display due to
 calculation errors
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>
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

On Thu, Mar 26, 2026 at 7:15=E2=80=AFPM Wang, Yang(Kevin)
<KevinYang.Wang@amd.com> wrote:
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> >> However, this wrong value will still affect how 'pp_dpm_uclk' and 'gpu=
_metrics' show their results.
> change to
> However, this wrong value will still affect how 'pp_dpm_uclk','pp_dpm_fcl=
k' and 'gpu_metrics' show their results.
>
> Best Regards,
> Kevin
>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Wang, =
Yang(Kevin)
> Sent: Friday, March 27, 2026 7:10 AM
> To: Alex Deucher <alexdeucher@gmail.com>
> Cc: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@=
amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Feng, Kenneth <Kenneth.Fe=
ng@amd.com>
> Subject: RE: [PATCH] drm/amd/pm: correct mem_busy_percent display due to =
calculation errors
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> >> What about returning -EBUSY or -EAGAIN if the value is negative?
>
> However, this wrong value will still affect how 'pp_dpm_uclk' and 'gpu_me=
trics' show their results.
> While the 'mem_busy_percent' sysfs node is fine as it is, the KMD still n=
eeds a special code path to handle it properly.
> Also, for 'gpu_metrics', the driver must return some value to fill the bu=
ffer no matter what to avoid breaking node function.
>
> For "activity" variables, we can safely assume they should only be betwee=
n 0 and 100.
> Besides, PMFW uses a similar method internally, So, I think limiting the =
value to 0 is a reasonable fix.

Acked-by: Alex Deucher <alexander.deucher@amd.com>

>
> Best Regards,
> Kevin
>
> -----Original Message-----
> From: Alex Deucher <alexdeucher@gmail.com>
> Sent: Friday, March 27, 2026 5:33 AM
> To: Lazar, Lijo <Lijo.Lazar@amd.com>
> Cc: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; amd-gfx@lists.freedesktop=
.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawki=
ng.Zhang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>
> Subject: Re: [PATCH] drm/amd/pm: correct mem_busy_percent display due to =
calculation errors
>
> On Thu, Mar 26, 2026 at 12:37=E2=80=AFAM Lazar, Lijo <lijo.lazar@amd.com>=
 wrote:
> >
> >
> >
> > On 26-Mar-26 7:34 AM, Yang Wang wrote:
> > > PMFW may return invalid values due to internal calculation errors.
> > > so, the kmd driver must validate and sanitize the returned values to
> > > prevent issues caused by firmware calculation errors.
> > >
> > > For example, values 0xfffe (-2) and 0xffff (-1) are treated as
> > > invalid and clamped to 0.
> > >
> >
> > The problem with clamping is that the issue takes a different
> > direction after that.
> >
> > Presently, the issue is reported as garbage values reported in activity=
.
> > With clamping, the issue could get reported as 100% activity with
> > light load or 0% activity with a heavy load. That will take the debug
> > in a different direction.
> >
> > Instead, isn't it better to keep this as some errata and let user apps
> > filter out garbage values? The previous or next sample could reflect
> > the activity correctly. Later fix can be added to newer firmware, if
> > that is an option.
>
> What about returning -EBUSY or -EAGAIN if the value is negative?
>
> Alex
>
> >
> > Thanks,
> > Lijo
> >
> >
> > > this applies to devices with CAB (Cache As Buffer) functionality.
> > >
> > > Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/4905
> > >
> > > Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
> > > ---
> > >   drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h   | 17 ++++++++++++++=
+++
> > >   .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c    | 10 +++++-----
> > >   .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c    | 10 +++++-----
> > >   .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c    | 10 +++++-----
> > >   4 files changed, 32 insertions(+), 15 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> > > b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> > > index 609f5ab07d8a..365946c43e11 100644
> > > --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> > > +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> > > @@ -2164,4 +2164,21 @@ static inline void smu_feature_init(struct smu=
_context *smu, int feature_num)
> > >       smu_feature_list_clear_all(smu, SMU_FEATURE_LIST_ALLOWED);
> > >   }
> > >
> > > +/*
> > > + * smu_safe_u16_nn - Make u16 safe by filtering negative overflow
> > > +errors
> > > + * @val: Input u16 value, may contain invalid negative overflows
> > > + *
> > > + * Convert u16 to non-negative value. Cast to s16 to detect
> > > +negative values
> > > + * caused by calculation errors. Return 0 for negative errors,
> > > +return
> > > + * original value if valid.
> > > + *
> > > + * Return: Valid u16 value or 0
> > > + */
> > > +static inline u16 smu_safe_u16_nn(u16 val) {
> > > +    s16 tmp =3D (s16)val;
> > > +
> > > +    return tmp < 0 ? 0 : val;
> > > +}
> > > +
> > >   #endif
> > > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> > > b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> > > index 9be7a2af560d..16f69b548ca4 100644
> > > --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> > > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> > > @@ -774,13 +774,13 @@ static int smu_v13_0_0_get_smu_metrics_data(str=
uct smu_context *smu,
> > >                       *value =3D metrics->AverageGfxclkFrequencyPreDs=
;
> > >               break;
> > >       case METRICS_AVERAGE_FCLK:
> > > -             if (metrics->AverageUclkActivity <=3D SMU_13_0_0_BUSY_T=
HRESHOLD)
> > > +             if (smu_safe_u16_nn(metrics->AverageUclkActivity) <=3D
> > > + SMU_13_0_0_BUSY_THRESHOLD)
> > >                       *value =3D metrics->AverageFclkFrequencyPostDs;
> > >               else
> > >                       *value =3D metrics->AverageFclkFrequencyPreDs;
> > >               break;
> > >       case METRICS_AVERAGE_UCLK:
> > > -             if (metrics->AverageUclkActivity <=3D SMU_13_0_0_BUSY_T=
HRESHOLD)
> > > +             if (smu_safe_u16_nn(metrics->AverageUclkActivity) <=3D
> > > + SMU_13_0_0_BUSY_THRESHOLD)
> > >                       *value =3D metrics->AverageMemclkFrequencyPostD=
s;
> > >               else
> > >                       *value =3D metrics->AverageMemclkFrequencyPreDs=
;
> > > @@ -801,7 +801,7 @@ static int smu_v13_0_0_get_smu_metrics_data(struc=
t smu_context *smu,
> > >               *value =3D metrics->AverageGfxActivity;
> > >               break;
> > >       case METRICS_AVERAGE_MEMACTIVITY:
> > > -             *value =3D metrics->AverageUclkActivity;
> > > +             *value =3D
> > > + smu_safe_u16_nn(metrics->AverageUclkActivity);
> > >               break;
> > >       case METRICS_AVERAGE_VCNACTIVITY:
> > >               *value =3D max(metrics->Vcn0ActivityPercentage,
> > > @@ -2086,7 +2086,7 @@ static ssize_t
> > > smu_v13_0_0_get_gpu_metrics(struct smu_context *smu,
> > >
> > > metrics->AvgTemperature[TEMP_VR_MEM1]);
> > >
> > >       gpu_metrics->average_gfx_activity =3D metrics->AverageGfxActivi=
ty;
> > > -     gpu_metrics->average_umc_activity =3D metrics->AverageUclkActiv=
ity;
> > > +     gpu_metrics->average_umc_activity =3D
> > > + smu_safe_u16_nn(metrics->AverageUclkActivity);
> > >       gpu_metrics->average_mm_activity =3D
> > > max(metrics->Vcn0ActivityPercentage,
> > >
> > > metrics->Vcn1ActivityPercentage);
> > >
> > > @@ -2103,7 +2103,7 @@ static ssize_t smu_v13_0_0_get_gpu_metrics(stru=
ct smu_context *smu,
> > >       else
> > >               gpu_metrics->average_gfxclk_frequency =3D
> > > metrics->AverageGfxclkFrequencyPreDs;
> > >
> > > -     if (metrics->AverageUclkActivity <=3D SMU_13_0_0_BUSY_THRESHOLD=
)
> > > +     if (smu_safe_u16_nn(metrics->AverageUclkActivity) <=3D
> > > + SMU_13_0_0_BUSY_THRESHOLD)
> > >               gpu_metrics->average_uclk_frequency =3D metrics->Averag=
eMemclkFrequencyPostDs;
> > >       else
> > >               gpu_metrics->average_uclk_frequency =3D
> > > metrics->AverageMemclkFrequencyPreDs;
> > > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> > > b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> > > index 5cc15545da6e..34a5973b9a06 100644
> > > --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> > > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> > > @@ -784,13 +784,13 @@ static int smu_v13_0_7_get_smu_metrics_data(str=
uct smu_context *smu,
> > >               *value =3D metrics->AverageGfxclkFrequencyPreDs;
> > >               break;
> > >       case METRICS_AVERAGE_FCLK:
> > > -             if (metrics->AverageUclkActivity <=3D SMU_13_0_7_BUSY_T=
HRESHOLD)
> > > +             if (smu_safe_u16_nn(metrics->AverageUclkActivity) <=3D
> > > + SMU_13_0_7_BUSY_THRESHOLD)
> > >                       *value =3D metrics->AverageFclkFrequencyPostDs;
> > >               else
> > >                       *value =3D metrics->AverageFclkFrequencyPreDs;
> > >               break;
> > >       case METRICS_AVERAGE_UCLK:
> > > -             if (metrics->AverageUclkActivity <=3D SMU_13_0_7_BUSY_T=
HRESHOLD)
> > > +             if (smu_safe_u16_nn(metrics->AverageUclkActivity) <=3D
> > > + SMU_13_0_7_BUSY_THRESHOLD)
> > >                       *value =3D metrics->AverageMemclkFrequencyPostD=
s;
> > >               else
> > >                       *value =3D metrics->AverageMemclkFrequencyPreDs=
;
> > > @@ -815,7 +815,7 @@ static int smu_v13_0_7_get_smu_metrics_data(struc=
t smu_context *smu,
> > >               *value =3D metrics->AverageGfxActivity;
> > >               break;
> > >       case METRICS_AVERAGE_MEMACTIVITY:
> > > -             *value =3D metrics->AverageUclkActivity;
> > > +             *value =3D
> > > + smu_safe_u16_nn(metrics->AverageUclkActivity);
> > >               break;
> > >       case METRICS_AVERAGE_SOCKETPOWER:
> > >               *value =3D metrics->AverageSocketPower << 8; @@ -2092,7
> > > +2092,7 @@ static ssize_t smu_v13_0_7_get_gpu_metrics(struct
> > > +smu_context *smu,
> > >
> > > metrics->AvgTemperature[TEMP_VR_MEM1]);
> > >
> > >       gpu_metrics->average_gfx_activity =3D metrics->AverageGfxActivi=
ty;
> > > -     gpu_metrics->average_umc_activity =3D metrics->AverageUclkActiv=
ity;
> > > +     gpu_metrics->average_umc_activity =3D
> > > + smu_safe_u16_nn(metrics->AverageUclkActivity);
> > >       gpu_metrics->average_mm_activity =3D
> > > max(metrics->Vcn0ActivityPercentage,
> > >
> > > metrics->Vcn1ActivityPercentage);
> > >
> > > @@ -2105,7 +2105,7 @@ static ssize_t smu_v13_0_7_get_gpu_metrics(stru=
ct smu_context *smu,
> > >       else
> > >               gpu_metrics->average_gfxclk_frequency =3D
> > > metrics->AverageGfxclkFrequencyPreDs;
> > >
> > > -     if (metrics->AverageUclkActivity <=3D SMU_13_0_7_BUSY_THRESHOLD=
)
> > > +     if (smu_safe_u16_nn(metrics->AverageUclkActivity) <=3D
> > > + SMU_13_0_7_BUSY_THRESHOLD)
> > >               gpu_metrics->average_uclk_frequency =3D metrics->Averag=
eMemclkFrequencyPostDs;
> > >       else
> > >               gpu_metrics->average_uclk_frequency =3D
> > > metrics->AverageMemclkFrequencyPreDs;
> > > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> > > b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> > > index 28c1b084fe62..aaec3a251e0f 100644
> > > --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> > > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> > > @@ -660,13 +660,13 @@ static int smu_v14_0_2_get_smu_metrics_data(str=
uct smu_context *smu,
> > >                       *value =3D metrics->AverageGfxclkFrequencyPreDs=
;
> > >               break;
> > >       case METRICS_AVERAGE_FCLK:
> > > -             if (metrics->AverageUclkActivity <=3D SMU_14_0_2_BUSY_T=
HRESHOLD)
> > > +             if (smu_safe_u16_nn(metrics->AverageUclkActivity) <=3D
> > > + SMU_14_0_2_BUSY_THRESHOLD)
> > >                       *value =3D metrics->AverageFclkFrequencyPostDs;
> > >               else
> > >                       *value =3D metrics->AverageFclkFrequencyPreDs;
> > >               break;
> > >       case METRICS_AVERAGE_UCLK:
> > > -             if (metrics->AverageUclkActivity <=3D SMU_14_0_2_BUSY_T=
HRESHOLD)
> > > +             if (smu_safe_u16_nn(metrics->AverageUclkActivity) <=3D
> > > + SMU_14_0_2_BUSY_THRESHOLD)
> > >                       *value =3D metrics->AverageMemclkFrequencyPostD=
s;
> > >               else
> > >                       *value =3D metrics->AverageMemclkFrequencyPreDs=
;
> > > @@ -687,7 +687,7 @@ static int smu_v14_0_2_get_smu_metrics_data(struc=
t smu_context *smu,
> > >               *value =3D metrics->AverageGfxActivity;
> > >               break;
> > >       case METRICS_AVERAGE_MEMACTIVITY:
> > > -             *value =3D metrics->AverageUclkActivity;
> > > +             *value =3D
> > > + smu_safe_u16_nn(metrics->AverageUclkActivity);
> > >               break;
> > >       case METRICS_AVERAGE_VCNACTIVITY:
> > >               *value =3D max(metrics->AverageVcn0ActivityPercentage,
> > > @@ -2146,7 +2146,7 @@ static ssize_t
> > > smu_v14_0_2_get_gpu_metrics(struct smu_context *smu,
> > >
> > > metrics->AvgTemperature[TEMP_VR_MEM1]);
> > >
> > >       gpu_metrics->average_gfx_activity =3D metrics->AverageGfxActivi=
ty;
> > > -     gpu_metrics->average_umc_activity =3D metrics->AverageUclkActiv=
ity;
> > > +     gpu_metrics->average_umc_activity =3D
> > > + smu_safe_u16_nn(metrics->AverageUclkActivity);
> > >       gpu_metrics->average_mm_activity =3D
> > > max(metrics->AverageVcn0ActivityPercentage,
> > >
> > > metrics->Vcn1ActivityPercentage);
> > >
> > > @@ -2158,7 +2158,7 @@ static ssize_t smu_v14_0_2_get_gpu_metrics(stru=
ct smu_context *smu,
> > >       else
> > >               gpu_metrics->average_gfxclk_frequency =3D
> > > metrics->AverageGfxclkFrequencyPreDs;
> > >
> > > -     if (metrics->AverageUclkActivity <=3D SMU_14_0_2_BUSY_THRESHOLD=
)
> > > +     if (smu_safe_u16_nn(metrics->AverageUclkActivity) <=3D
> > > + SMU_14_0_2_BUSY_THRESHOLD)
> > >               gpu_metrics->average_uclk_frequency =3D metrics->Averag=
eMemclkFrequencyPostDs;
> > >       else
> > >               gpu_metrics->average_uclk_frequency =3D
> > > metrics->AverageMemclkFrequencyPreDs;
> >
