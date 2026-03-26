Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 101A110AB827
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2026 21:33:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82C0810EC1E;
	Thu, 26 Mar 2026 21:33:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YcR/Y/fp";
	dkim-atps=neutral
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C35F610EC1E
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 21:33:09 +0000 (UTC)
Received: by mail-dl1-f44.google.com with SMTP id
 a92af1059eb24-1277863a912so208911c88.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 14:33:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774560789; cv=none;
 d=google.com; s=arc-20240605;
 b=YXCQ+tLWqfBQxd2/edH6LOwgKui+jPgxjt5CwuA2K4t871LQ0Dq5IUdOxJAxd0dYYA
 xybrJ8MXrep0VHrF/eiT7VB6qM0MicxQlusNeJs05LERl2wXR+bPgXNQitUyuPF2JH3o
 JsjKBCv0XKGq/qZKg0aNH3g7PMV7554WJjoFJ0Y0R7N5jMJCwlrACCYAwgtGg8WP0FhN
 sBzGkSpBVOULjxxLjCYNYY9P2bEgj01T31ZRcuaa2OIF3jbFntfW3bqr7PLGtt7eKB+u
 UV4JqYVwfqSp9RSZE5lRkkuOHshBuzyvJAiS/2YoX4X3FJOQH1RijL65TuAZ+JdeZ7d2
 b49w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=wkBp3yqCcEL7QYRuAZHO2ZMU8QoOpQA9ogtRXEC76cw=;
 fh=nTADSEbj1detMp9dbfRn6y87YUHMr6oPm46+RSV4Wgk=;
 b=DoOrZBkJ9Pv+hhCFqFhRcsnmjzSasi0/di0QchV09o8jI3ooHSQg3dLPsXO4TkDbfZ
 +dtBY6fmg0W73rl9SQWEJpA4z8mb+2V7mEy6r1YTBZNoSZ+JNajqk50ZfiLV0yhwBPmX
 5QX3gRsjKghdBp8+TWWg8wuw2v1/5GIq+F3yXa/MNy2NTY2/McXfvKp/F4W36IqNcPAL
 Z2r57RyrDDGRyII6RY6T+Lo4o/mJkeBqCD1FALe1VsCPxDuy1K8PbZHNXuiam73g3jgm
 fgtol8LpdwD7o8bnZV9OgqXAsEs46y2Wu1JtXNY0xApwgW7Isu/eJUlCigym+azhmo9A
 psyA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774560789; x=1775165589; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wkBp3yqCcEL7QYRuAZHO2ZMU8QoOpQA9ogtRXEC76cw=;
 b=YcR/Y/fpBBF+FTfZr60KhQvAGsjQGpxpdqVWM2JfHurgGatDPcKz50rmeLVVtovOQ+
 MPkwyVjF9Vvw3/rWZtL/UcVsloikxVQEZz2eYe4MUea/y9BnGmFvbhfwVnwZzcUlegq6
 0yjxIFSO4IlpVuGowD87mOJt39NI8K74LJ038n7d3DcWkGY48u5GYupR5A6WdHHcsPys
 7OvRUYtqvPrLnIf9FvvC4fNpckS4LiFlGgaBajcGPI2x4CVe+ay0Gp8GekuJiUl8wo+p
 TicL4sUpNN7Pd+7hB2CPtk3Zh3W3LCx93z2k7l0C/9tobXrfBwjAAfuhGVLtAFIPsU4n
 3yVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774560789; x=1775165589;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wkBp3yqCcEL7QYRuAZHO2ZMU8QoOpQA9ogtRXEC76cw=;
 b=Syrd2MpP6Dy94jItAIv4yWsMzHBVxrj5eWjTnTadyma//Mi/VRubflNtzXsfLbY/lH
 hm6p61FRno0GoqSCjPhiPUP6Ozx+D0FoT+dXw0a0zIziOF3KVjdf1QKtjQ/A2vuZljtp
 4HQdppaA+EaAXudm2dwxs66bxLhiLlzVasObkC4Bpid7o1ErWIoSGbLC/JZW8GVUCqid
 OvyucKjYyfuTyOgT90gnLG+hczBgk4Kf2MyiN0SidhdILnUpua12LYuXQcjc4bhoPZBD
 ATrsbym+CYKpeymfmZbCKfClMlvnwGj642DF7l1pa7sZEjDVRJ2rskY1dT20lgxMVWoF
 5bzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/1+RRg+I+jzW6miMB30Yb8pz3Il0XfN3wlRiA5+NpzeqNscxzipKvTJeFGHqijXBrBKazGP8S@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyhbxdsXv4tmcmrZ4L2qvkzt0ihrjtWjx0fQfyoKR+/K1qA/u42
 0kKoipPwzPau/O/C0eL1U0QbQPRVhS54PtGOGbx15lMINkSQHvObNSwsRQDwOogJsDvkNXKcsyq
 bhtONzchY1PSMfDEhZJdKHU8vmRn1zD0t1Q==
X-Gm-Gg: ATEYQzxLeXWRKbmAPW7EyJLLms7Er+U/SuRGAD1lSjjkcIT/ws49PEHXLzQdqz/kI3j
 XFoZgZnUu2JpHbyEOXKOxip4lQ6mGbblS29c6e+aeHOuByUp0rBQLODMPwasZ4ENx0zOncAMZiI
 yCnuX5DRVu/o/KMtucVgMASlquE0+UbB06rV2KegNL3LdbQRMLx6gCKIBLU3FyX0G9M9SG9tUAq
 xg7zz3oUjGt746dmk5jVbWiG9pE1q3HZgq/vhMENMLgnJ0tb+H4a8jpWi0uvpccLibe6g3uoMWR
 Juxl/s5p+PUT3AjgNUOdYclXi3+/e/2QoEPGe8/fw0pnLNHrGDroEl2JGm3PfqE5ZRzzJQ==
X-Received: by 2002:a05:7022:2209:b0:12a:716c:d29c with SMTP id
 a92af1059eb24-12ab28fd96fmr31028c88.7.1774560788849; Thu, 26 Mar 2026
 14:33:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260326020445.1187519-1-kevinyang.wang@amd.com>
 <a35ca9d5-354f-4b98-a186-3a4797176b55@amd.com>
In-Reply-To: <a35ca9d5-354f-4b98-a186-3a4797176b55@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 26 Mar 2026 17:32:57 -0400
X-Gm-Features: AQROBzDiK5rS8y7xT03M4Skhri--dAANv-UMNON1TVEvPedb9X6nLy-FlrW-beU
Message-ID: <CADnq5_PRGtHXruP9Y4UxA9-XmJ6UH=VA3OFfE+qs6tfgz3r1ug@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: correct mem_busy_percent display due to
 calculation errors
To: "Lazar, Lijo" <lijo.lazar@amd.com>
Cc: Yang Wang <kevinyang.wang@amd.com>, amd-gfx@lists.freedesktop.org, 
 alexander.deucher@amd.com, hawking.zhang@amd.com, kenneth.feng@amd.com
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

On Thu, Mar 26, 2026 at 12:37=E2=80=AFAM Lazar, Lijo <lijo.lazar@amd.com> w=
rote:
>
>
>
> On 26-Mar-26 7:34 AM, Yang Wang wrote:
> > PMFW may return invalid values due to internal calculation errors.
> > so, the kmd driver must validate and sanitize the returned values to
> > prevent issues caused by firmware calculation errors.
> >
> > For example, values 0xfffe (-2) and 0xffff (-1) are treated
> > as invalid and clamped to 0.
> >
>
> The problem with clamping is that the issue takes a different direction
> after that.
>
> Presently, the issue is reported as garbage values reported in activity.
> With clamping, the issue could get reported as 100% activity with light
> load or 0% activity with a heavy load. That will take the debug in a
> different direction.
>
> Instead, isn't it better to keep this as some errata and let user apps
> filter out garbage values? The previous or next sample could reflect the
> activity correctly. Later fix can be added to newer firmware, if that is
> an option.

What about returning -EBUSY or -EAGAIN if the value is negative?

Alex

>
> Thanks,
> Lijo
>
>
> > this applies to devices with CAB (Cache As Buffer) functionality.
> >
> > Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/4905
> >
> > Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
> > ---
> >   drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h   | 17 ++++++++++++++++=
+
> >   .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c    | 10 +++++-----
> >   .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c    | 10 +++++-----
> >   .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c    | 10 +++++-----
> >   4 files changed, 32 insertions(+), 15 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gp=
u/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> > index 609f5ab07d8a..365946c43e11 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> > @@ -2164,4 +2164,21 @@ static inline void smu_feature_init(struct smu_c=
ontext *smu, int feature_num)
> >       smu_feature_list_clear_all(smu, SMU_FEATURE_LIST_ALLOWED);
> >   }
> >
> > +/*
> > + * smu_safe_u16_nn - Make u16 safe by filtering negative overflow erro=
rs
> > + * @val: Input u16 value, may contain invalid negative overflows
> > + *
> > + * Convert u16 to non-negative value. Cast to s16 to detect negative v=
alues
> > + * caused by calculation errors. Return 0 for negative errors, return
> > + * original value if valid.
> > + *
> > + * Return: Valid u16 value or 0
> > + */
> > +static inline u16 smu_safe_u16_nn(u16 val)
> > +{
> > +    s16 tmp =3D (s16)val;
> > +
> > +    return tmp < 0 ? 0 : val;
> > +}
> > +
> >   #endif
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/dri=
vers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> > index 9be7a2af560d..16f69b548ca4 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> > @@ -774,13 +774,13 @@ static int smu_v13_0_0_get_smu_metrics_data(struc=
t smu_context *smu,
> >                       *value =3D metrics->AverageGfxclkFrequencyPreDs;
> >               break;
> >       case METRICS_AVERAGE_FCLK:
> > -             if (metrics->AverageUclkActivity <=3D SMU_13_0_0_BUSY_THR=
ESHOLD)
> > +             if (smu_safe_u16_nn(metrics->AverageUclkActivity) <=3D SM=
U_13_0_0_BUSY_THRESHOLD)
> >                       *value =3D metrics->AverageFclkFrequencyPostDs;
> >               else
> >                       *value =3D metrics->AverageFclkFrequencyPreDs;
> >               break;
> >       case METRICS_AVERAGE_UCLK:
> > -             if (metrics->AverageUclkActivity <=3D SMU_13_0_0_BUSY_THR=
ESHOLD)
> > +             if (smu_safe_u16_nn(metrics->AverageUclkActivity) <=3D SM=
U_13_0_0_BUSY_THRESHOLD)
> >                       *value =3D metrics->AverageMemclkFrequencyPostDs;
> >               else
> >                       *value =3D metrics->AverageMemclkFrequencyPreDs;
> > @@ -801,7 +801,7 @@ static int smu_v13_0_0_get_smu_metrics_data(struct =
smu_context *smu,
> >               *value =3D metrics->AverageGfxActivity;
> >               break;
> >       case METRICS_AVERAGE_MEMACTIVITY:
> > -             *value =3D metrics->AverageUclkActivity;
> > +             *value =3D smu_safe_u16_nn(metrics->AverageUclkActivity);
> >               break;
> >       case METRICS_AVERAGE_VCNACTIVITY:
> >               *value =3D max(metrics->Vcn0ActivityPercentage,
> > @@ -2086,7 +2086,7 @@ static ssize_t smu_v13_0_0_get_gpu_metrics(struct=
 smu_context *smu,
> >                                            metrics->AvgTemperature[TEMP=
_VR_MEM1]);
> >
> >       gpu_metrics->average_gfx_activity =3D metrics->AverageGfxActivity=
;
> > -     gpu_metrics->average_umc_activity =3D metrics->AverageUclkActivit=
y;
> > +     gpu_metrics->average_umc_activity =3D smu_safe_u16_nn(metrics->Av=
erageUclkActivity);
> >       gpu_metrics->average_mm_activity =3D max(metrics->Vcn0ActivityPer=
centage,
> >                                              metrics->Vcn1ActivityPerce=
ntage);
> >
> > @@ -2103,7 +2103,7 @@ static ssize_t smu_v13_0_0_get_gpu_metrics(struct=
 smu_context *smu,
> >       else
> >               gpu_metrics->average_gfxclk_frequency =3D metrics->Averag=
eGfxclkFrequencyPreDs;
> >
> > -     if (metrics->AverageUclkActivity <=3D SMU_13_0_0_BUSY_THRESHOLD)
> > +     if (smu_safe_u16_nn(metrics->AverageUclkActivity) <=3D SMU_13_0_0=
_BUSY_THRESHOLD)
> >               gpu_metrics->average_uclk_frequency =3D metrics->AverageM=
emclkFrequencyPostDs;
> >       else
> >               gpu_metrics->average_uclk_frequency =3D metrics->AverageM=
emclkFrequencyPreDs;
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/dri=
vers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> > index 5cc15545da6e..34a5973b9a06 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> > @@ -784,13 +784,13 @@ static int smu_v13_0_7_get_smu_metrics_data(struc=
t smu_context *smu,
> >               *value =3D metrics->AverageGfxclkFrequencyPreDs;
> >               break;
> >       case METRICS_AVERAGE_FCLK:
> > -             if (metrics->AverageUclkActivity <=3D SMU_13_0_7_BUSY_THR=
ESHOLD)
> > +             if (smu_safe_u16_nn(metrics->AverageUclkActivity) <=3D SM=
U_13_0_7_BUSY_THRESHOLD)
> >                       *value =3D metrics->AverageFclkFrequencyPostDs;
> >               else
> >                       *value =3D metrics->AverageFclkFrequencyPreDs;
> >               break;
> >       case METRICS_AVERAGE_UCLK:
> > -             if (metrics->AverageUclkActivity <=3D SMU_13_0_7_BUSY_THR=
ESHOLD)
> > +             if (smu_safe_u16_nn(metrics->AverageUclkActivity) <=3D SM=
U_13_0_7_BUSY_THRESHOLD)
> >                       *value =3D metrics->AverageMemclkFrequencyPostDs;
> >               else
> >                       *value =3D metrics->AverageMemclkFrequencyPreDs;
> > @@ -815,7 +815,7 @@ static int smu_v13_0_7_get_smu_metrics_data(struct =
smu_context *smu,
> >               *value =3D metrics->AverageGfxActivity;
> >               break;
> >       case METRICS_AVERAGE_MEMACTIVITY:
> > -             *value =3D metrics->AverageUclkActivity;
> > +             *value =3D smu_safe_u16_nn(metrics->AverageUclkActivity);
> >               break;
> >       case METRICS_AVERAGE_SOCKETPOWER:
> >               *value =3D metrics->AverageSocketPower << 8;
> > @@ -2092,7 +2092,7 @@ static ssize_t smu_v13_0_7_get_gpu_metrics(struct=
 smu_context *smu,
> >                                            metrics->AvgTemperature[TEMP=
_VR_MEM1]);
> >
> >       gpu_metrics->average_gfx_activity =3D metrics->AverageGfxActivity=
;
> > -     gpu_metrics->average_umc_activity =3D metrics->AverageUclkActivit=
y;
> > +     gpu_metrics->average_umc_activity =3D smu_safe_u16_nn(metrics->Av=
erageUclkActivity);
> >       gpu_metrics->average_mm_activity =3D max(metrics->Vcn0ActivityPer=
centage,
> >                                              metrics->Vcn1ActivityPerce=
ntage);
> >
> > @@ -2105,7 +2105,7 @@ static ssize_t smu_v13_0_7_get_gpu_metrics(struct=
 smu_context *smu,
> >       else
> >               gpu_metrics->average_gfxclk_frequency =3D metrics->Averag=
eGfxclkFrequencyPreDs;
> >
> > -     if (metrics->AverageUclkActivity <=3D SMU_13_0_7_BUSY_THRESHOLD)
> > +     if (smu_safe_u16_nn(metrics->AverageUclkActivity) <=3D SMU_13_0_7=
_BUSY_THRESHOLD)
> >               gpu_metrics->average_uclk_frequency =3D metrics->AverageM=
emclkFrequencyPostDs;
> >       else
> >               gpu_metrics->average_uclk_frequency =3D metrics->AverageM=
emclkFrequencyPreDs;
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/dri=
vers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> > index 28c1b084fe62..aaec3a251e0f 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> > @@ -660,13 +660,13 @@ static int smu_v14_0_2_get_smu_metrics_data(struc=
t smu_context *smu,
> >                       *value =3D metrics->AverageGfxclkFrequencyPreDs;
> >               break;
> >       case METRICS_AVERAGE_FCLK:
> > -             if (metrics->AverageUclkActivity <=3D SMU_14_0_2_BUSY_THR=
ESHOLD)
> > +             if (smu_safe_u16_nn(metrics->AverageUclkActivity) <=3D SM=
U_14_0_2_BUSY_THRESHOLD)
> >                       *value =3D metrics->AverageFclkFrequencyPostDs;
> >               else
> >                       *value =3D metrics->AverageFclkFrequencyPreDs;
> >               break;
> >       case METRICS_AVERAGE_UCLK:
> > -             if (metrics->AverageUclkActivity <=3D SMU_14_0_2_BUSY_THR=
ESHOLD)
> > +             if (smu_safe_u16_nn(metrics->AverageUclkActivity) <=3D SM=
U_14_0_2_BUSY_THRESHOLD)
> >                       *value =3D metrics->AverageMemclkFrequencyPostDs;
> >               else
> >                       *value =3D metrics->AverageMemclkFrequencyPreDs;
> > @@ -687,7 +687,7 @@ static int smu_v14_0_2_get_smu_metrics_data(struct =
smu_context *smu,
> >               *value =3D metrics->AverageGfxActivity;
> >               break;
> >       case METRICS_AVERAGE_MEMACTIVITY:
> > -             *value =3D metrics->AverageUclkActivity;
> > +             *value =3D smu_safe_u16_nn(metrics->AverageUclkActivity);
> >               break;
> >       case METRICS_AVERAGE_VCNACTIVITY:
> >               *value =3D max(metrics->AverageVcn0ActivityPercentage,
> > @@ -2146,7 +2146,7 @@ static ssize_t smu_v14_0_2_get_gpu_metrics(struct=
 smu_context *smu,
> >                                            metrics->AvgTemperature[TEMP=
_VR_MEM1]);
> >
> >       gpu_metrics->average_gfx_activity =3D metrics->AverageGfxActivity=
;
> > -     gpu_metrics->average_umc_activity =3D metrics->AverageUclkActivit=
y;
> > +     gpu_metrics->average_umc_activity =3D smu_safe_u16_nn(metrics->Av=
erageUclkActivity);
> >       gpu_metrics->average_mm_activity =3D max(metrics->AverageVcn0Acti=
vityPercentage,
> >                                              metrics->Vcn1ActivityPerce=
ntage);
> >
> > @@ -2158,7 +2158,7 @@ static ssize_t smu_v14_0_2_get_gpu_metrics(struct=
 smu_context *smu,
> >       else
> >               gpu_metrics->average_gfxclk_frequency =3D metrics->Averag=
eGfxclkFrequencyPreDs;
> >
> > -     if (metrics->AverageUclkActivity <=3D SMU_14_0_2_BUSY_THRESHOLD)
> > +     if (smu_safe_u16_nn(metrics->AverageUclkActivity) <=3D SMU_14_0_2=
_BUSY_THRESHOLD)
> >               gpu_metrics->average_uclk_frequency =3D metrics->AverageM=
emclkFrequencyPostDs;
> >       else
> >               gpu_metrics->average_uclk_frequency =3D metrics->AverageM=
emclkFrequencyPreDs;
>
