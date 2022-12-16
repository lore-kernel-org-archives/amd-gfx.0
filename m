Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA2E1C4167B
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Dec 2022 14:59:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6F4810E13C;
	Fri, 16 Dec 2022 14:59:18 +0000 (UTC)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2823410E13C
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Dec 2022 14:59:11 +0000 (UTC)
Received: by mail-oi1-x22f.google.com with SMTP id r130so2148353oih.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Dec 2022 06:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GMTeioS6jPmt5TZGUSY4JgKia8FF1d8DSjYR1HFYr08=;
 b=fH6BOEzA83HKNlS7/srU4kFnHdgQSEPYn22Auln3AHIMk+9QZelx5mLVVrFXxCZEiX
 x+cGw4oW7k+HhN5UT4wKa1F6r6FOHD7jGHp+tusZr64OWYjmEdSY603mju/TcCxbXOqS
 6ckrL3KbGjnEjRO5Ld7WUt7+Al0Vitpp5ORvlaHgvSr+SZDhMOQdKxsiqNBjlUn/TQQ5
 40/G5fMNRcxFzipJv66p6VYrH64bVF+YzRAjOgOSMJJM0xSGtdTcEx+RqXj48b6Q+5zV
 lNVxzENF32p+1frwH8R/qioSVairhoGRwl+d+wzpu8Jq8znWFz+Xk206ZgiL+WW4FMvf
 rA5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GMTeioS6jPmt5TZGUSY4JgKia8FF1d8DSjYR1HFYr08=;
 b=eIK0HlCaDqhwwBrdWCZnGJuD/uLXOC0MWNsrjmJ2T6ewnLt5VF7NO10Wg1cYGDxebU
 Qjs4mF6Z7dXNgzq9RogPhL+fwAxVxhyVR+kKdcBRn0WDZS41kiK6Wz1Ne0jsI9yYbOcI
 TBvB7KXFHRAivi7kurDkI+e5hVA2Kxx7mFXZp7h0Wz8UxGuCsKkaNuBMBeYyoKgf1djO
 Ug6k2IUQgZL/Yu1StjbpSBMe7ko2Wb0ErQB+frm1HMnljFZ0Wcq72kynllWpoOMDxXBX
 0/m5tugVcHeHvE70Y/o45g570I2lJ/njHeZQCkJU/yb0zn5fotAcyLWkKCAxlQf5h5Ad
 JYOg==
X-Gm-Message-State: ANoB5pnEnLsVfdf5jvOB5woGZp6kVjz3wqa6mjcFAphit7nS+jdQq9Ee
 6lrWg2zRbDANl8QjjqPmkYSG0LEFuBwcGc6F7u4=
X-Google-Smtp-Source: AA0mqf6Q6FewhC4WxIHhPmpvbHOL7Gh483EyWDKuMDk/8Di0p2uegpIKAkLQFqXmlKsLEzTZSMe5REJ/r6S0I3doxHo=
X-Received: by 2002:a05:6808:1cd:b0:35b:f5f7:3ed0 with SMTP id
 x13-20020a05680801cd00b0035bf5f73ed0mr669530oic.46.1671202750602; Fri, 16 Dec
 2022 06:59:10 -0800 (PST)
MIME-Version: 1.0
References: <20221216103550.2063886-1-evan.quan@amd.com>
 <0e3fc42c-d5d4-db99-ab6a-65b4f87ef201@gmail.com>
In-Reply-To: <0e3fc42c-d5d4-db99-ab6a-65b4f87ef201@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 16 Dec 2022 09:58:59 -0500
Message-ID: <CADnq5_PvbrVVfRW9m1LjkRb+fivMLkAXOTT0dx=LngKnsE6z8Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: correct the fan speed retrieving in PWM for
 some SMU13 asics
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

With Christian's comment addressed, the patch is:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

On Fri, Dec 16, 2022 at 6:50 AM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Am 16.12.22 um 11:35 schrieb Evan Quan:
> > For SMU 13.0.0 and 13.0.7, the output from PMFW is in percent. Driver
> > need to convert that into correct PMW(255) based.
> >
> > Signed-off-by: Evan Quan <evan.quan@amd.com>
> > Change-Id: I7bbeae3c0d81c6cf6e0033aa28ca6d26f5b6d178
> > ---
> >   .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 15 ++++++++++++--=
-
> >   .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 15 ++++++++++++--=
-
> >   2 files changed, 24 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/dri=
vers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> > index 636cb561fea9..283cf7cf95ab 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> > @@ -1445,12 +1445,21 @@ static void smu_v13_0_0_get_unique_id(struct sm=
u_context *smu)
> >   static int smu_v13_0_0_get_fan_speed_pwm(struct smu_context *smu,
> >                                        uint32_t *speed)
> >   {
> > +     int ret =3D 0;
>
> Please don't initialize local variables when there isn't a need for this.
>
> We often get complains about this from automated scripts.
>
> Regards,
> Christian.
>
> > +
> >       if (!speed)
> >               return -EINVAL;
> >
> > -     return smu_v13_0_0_get_smu_metrics_data(smu,
> > -                                             METRICS_CURR_FANPWM,
> > -                                             speed);
> > +     ret =3D smu_v13_0_0_get_smu_metrics_data(smu,
> > +                                            METRICS_CURR_FANPWM,
> > +                                            speed);
> > +     if (ret)
> > +             return ret;
> > +
> > +     /* Convert the PMFW output which is in percent to pwm(255) based =
*/
> > +     *speed =3D MIN(*speed * 255 / 100, 255);
> > +
> > +     return 0;
> >   }
> >
> >   static int smu_v13_0_0_get_fan_speed_rpm(struct smu_context *smu,
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/dri=
vers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> > index 5e937e4efb51..f207f102ed7e 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> > @@ -1365,12 +1365,21 @@ static int smu_v13_0_7_populate_umd_state_clk(s=
truct smu_context *smu)
> >   static int smu_v13_0_7_get_fan_speed_pwm(struct smu_context *smu,
> >                                        uint32_t *speed)
> >   {
> > +     int ret =3D 0;
> > +
> >       if (!speed)
> >               return -EINVAL;
> >
> > -     return smu_v13_0_7_get_smu_metrics_data(smu,
> > -                                             METRICS_CURR_FANPWM,
> > -                                             speed);
> > +     ret =3D smu_v13_0_7_get_smu_metrics_data(smu,
> > +                                            METRICS_CURR_FANPWM,
> > +                                            speed);
> > +     if (ret)
> > +             return ret;
> > +
> > +     /* Convert the PMFW output which is in percent to pwm(255) based =
*/
> > +     *speed =3D MIN(*speed * 255 / 100, 255);
> > +
> > +     return 0;
> >   }
> >
> >   static int smu_v13_0_7_get_fan_speed_rpm(struct smu_context *smu,
>
