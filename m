Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E47FECAAD3
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Sep 2022 15:54:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93E4910E039;
	Mon, 19 Sep 2022 15:54:04 +0000 (UTC)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0833A10E039
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Sep 2022 15:54:01 +0000 (UTC)
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-127ba06d03fso32454fac.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Sep 2022 08:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date;
 bh=CV5DvHMHjLExrcItKX4N05NTUEal191X/QBnilo1/VA=;
 b=PLeS51PHtR/Rsq/h+buTAk8fCJyV9zVz5RtyrYxMObvDJfEz3tJK1tCV20T2Zyu5KR
 5643R9qSqQwrxjoVELL8hZSsvtbENM72JEax5qVXb7t3R25g7bC1ppdgXDY7fCIx7uzd
 3RFppf07tXS9DoE/5S1k2SZ3cpUUqtsVKOjXQMeIJv38dbjgYI/x25hLn312mSJ4IGbU
 fJw8TMwxCoj1GaIdVVRHE+ZPbgwh55DeBI6REfWXwbSxnxubhd7alqshAsDb4arBTu9V
 SzWb08xRDqNeGOtBa34ioX9PngHw/ixux5dWyaJgxtKblb3xfw1lgvY9I7i6FUXE7SLx
 hy3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=CV5DvHMHjLExrcItKX4N05NTUEal191X/QBnilo1/VA=;
 b=ZsretO6Tg1tb9416akpI7OQULiTJFwq5rPcYLz+X+0DwHdCQYKoBILewOaakDaWOiv
 wzJ3IKPJCbr3jHfyO0oreBl7NeReO8XGDebGYKlv4VWo/zjvbrdaANzU9T3tm5mVZKs3
 zIJBesIlkAjH/qkZ7GWbF6fiWQ5yQFZJ2wyAuLYwao3yIAbI7+MFNupTQ43Q5TasmUlL
 FMQFxtRfJeG0NNQrnW1BKIi48dEEixYpKBwQZjx2lUbRKCOHKb/irE8rn3oDJkDzRMXM
 JD3yDA2d0Bt4OxCPgQCB/M9GL+0kdqscnRGOg+tI8LPbAwsVtQY9i8RsIyRJ6WvXq4mc
 n6cw==
X-Gm-Message-State: ACrzQf2Tc5P88+j8i3pLleLWv/PHYa49ahbpcjdR/tryrwlBt5NiNW/Z
 yIuUjEkPhRHfmLfS8zUVzt50+iIcPPejLnM58eU=
X-Google-Smtp-Source: AMsMyM5aDGe5qqtGNMMjbMfqv5X4vdt79bt5CoXTj7E2GUVc+J892ez3LCeCbVxVv8xBBGbAcOYQZQR5pqamqv5HwCQ=
X-Received: by 2002:a05:6870:738d:b0:125:1b5:420f with SMTP id
 z13-20020a056870738d00b0012501b5420fmr10274564oam.96.1663602841331; Mon, 19
 Sep 2022 08:54:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220918072314.28870-1-stalkerg@gmail.com>
 <DM6PR12MB261982DE6EACF869254AEDF1E44D9@DM6PR12MB2619.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB261982DE6EACF869254AEDF1E44D9@DM6PR12MB2619.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 19 Sep 2022 11:53:49 -0400
Message-ID: <CADnq5_PxJu7WN6sGUi+9sj3x0pfOQCJwb7rGdKrc_nNg2pGhFQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: getting fan speed pwm for vega10 properly
To: "Quan, Evan" <Evan.Quan@amd.com>
Content-Type: text/plain; charset="UTF-8"
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
 stalkerg <stalkerg@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Sun, Sep 18, 2022 at 10:06 PM Quan, Evan <Evan.Quan@amd.com> wrote:
>
> [AMD Official Use Only - General]
>
> Reviewed-by: Evan Quan <evan.quan@amd.com>
>
> > -----Original Message-----
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> > stalkerg
> > Sent: Sunday, September 18, 2022 3:23 PM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; stalkerg
> > <stalkerg@gmail.com>
> > Subject: [PATCH] drm/amdgpu: getting fan speed pwm for vega10 properly
> >
> > Instead of using RPM speed, we will use a function from vega20 based on
> > PWM registers.
> >
> > Signed-off-by: Yury Zhuravlev <stalkerg@gmail.com>
> > ---
> >  .../amd/pm/powerplay/hwmgr/vega10_thermal.c   | 25 +++++++++----------
> >  1 file changed, 12 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c
> > b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c
> > index dad3e3741a4e..190af79f3236 100644
> > --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c
> > +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c
> > @@ -67,22 +67,21 @@ int vega10_fan_ctrl_get_fan_speed_info(struct
> > pp_hwmgr *hwmgr,
> >  int vega10_fan_ctrl_get_fan_speed_pwm(struct pp_hwmgr *hwmgr,
> >               uint32_t *speed)
> >  {
> > -     uint32_t current_rpm;
> > -     uint32_t percent = 0;
> > -
> > -     if (hwmgr->thermal_controller.fanInfo.bNoFan)
> > -             return 0;
> > +     struct amdgpu_device *adev = hwmgr->adev;
> > +     uint32_t duty100, duty;
> > +     uint64_t tmp64;
> >
> > -     if (vega10_get_current_rpm(hwmgr, &current_rpm))
> > -             return -1;
> > +     duty100 = REG_GET_FIELD(RREG32_SOC15(THM, 0,
> > mmCG_FDO_CTRL1),
> > +                             CG_FDO_CTRL1, FMAX_DUTY100);
> > +     duty = REG_GET_FIELD(RREG32_SOC15(THM, 0,
> > mmCG_THERMAL_STATUS),
> > +                             CG_THERMAL_STATUS, FDO_PWM_DUTY);
> >
> > -     if (hwmgr->thermal_controller.
> > -                     advanceFanControlParameters.usMaxFanRPM != 0)
> > -             percent = current_rpm * 255 /
> > -                     hwmgr->thermal_controller.
> > -                     advanceFanControlParameters.usMaxFanRPM;
> > +     if (!duty100)
> > +             return -EINVAL;
> >
> > -     *speed = MIN(percent, 255);
> > +     tmp64 = (uint64_t)duty * 255;
> > +     do_div(tmp64, duty100);
> > +     *speed = MIN((uint32_t)tmp64, 255);
> >
> >       return 0;
> >  }
> > --
> > 2.35.1
