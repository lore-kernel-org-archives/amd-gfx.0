Return-Path: <SRS0=UpsA=OS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12469C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 21:51:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBD6061368
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 21:51:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CBD6061368
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6384A6E06B;
	Tue, 28 Sep 2021 21:51:11 +0000 (UTC)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E67206E06B
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Sep 2021 21:51:09 +0000 (UTC)
Received: by mail-ot1-x32b.google.com with SMTP id
 77-20020a9d0ed3000000b00546e10e6699so324537otj.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Sep 2021 14:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=58yJeliGr+CUYg6aOkmIrZzaNvrv5tDGflJAQS98cUA=;
 b=Y3aJMaXchxDUQaunVokiILlLEuyk1fit+1VbTcCibPOYdq9FZpnl3YEtUJOD5n5/n3
 5avGB+I18RgjWqirwqYeL09ZvbFceLELeD3coVS1BSALcagvYWekagAyVDJ2ew7YOv1F
 rv8Vi36HkCtC1OJdqcZM4XK2jvhwLvalTMe0rjpk2WeLf9wK1kQFYWQ8r1IXAot9IxNl
 6o7NbiAgKYiD22PefcM23eO3KsWFckHxFha2F2+mFRrRFHgrfnO3mPBbnRDSBumO9F0t
 UJB/i+kqvaprof9ayn9onfwlVP2VPCrcihQZyPGd9UFphpqDK491HAgn+l/wUlAz5SYR
 tVug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=58yJeliGr+CUYg6aOkmIrZzaNvrv5tDGflJAQS98cUA=;
 b=u+MDRcytC6VuGSWN0vY1FKYWpb6S2mP/Gz2ZRulNwlMHqACCg+d+oAxscSKGyaZj/4
 bJ1tHD6okstqnweTbLYtEkijc27CFMybHg17n4A3BqvvQlv90tYpjvFDoX5uZdHFQiF9
 bNAn3zuKa3SvGMgh813BXWC6i4C8j/8E+TgpULkP58Cb3YSVVY5ohcNT7Yv45HZpWu/G
 JuLhPz1ujg78V8/3wandwDfg41RgGWa4DCBKNpHHxZfRa9W8AhdjHmGIuB9OvpNn9SS9
 tg85+r6L1BgF8zruYPWYAYLwO2VyCpRBkIjG/DyMpVbZ2l57a9Q5q6k4GvD6Icq8is/d
 LeEQ==
X-Gm-Message-State: AOAM5336wBX4afDTjcV1hgozGFHHS8l7zCZrx4CFcIPrsNBF7v9/5JZt
 TNe6EWhK6XiL9jhLPiChPtjb0xaQn8sM9Qj805w=
X-Google-Smtp-Source: ABdhPJz2eGEb0GIzYS3lT2mtiGtur4am7ePCHaCAAU075yL8Psni3oJ+YQBbi0+rNck1w0pyc98jpqsp4zK/x05dt/A=
X-Received: by 2002:a9d:6d14:: with SMTP id o20mr7264385otp.357.1632865868813; 
 Tue, 28 Sep 2021 14:51:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210928004941.6978-1-huangyizhi@hnu.edu.cn>
 <5e4e8b4e-a8be-300c-8c9c-96a65e0a467f@gmail.com>
In-Reply-To: <5e4e8b4e-a8be-300c-8c9c-96a65e0a467f@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 28 Sep 2021 17:50:57 -0400
Message-ID: <CADnq5_Mw_652K=Oe0OGPCfzcdfk68nqXp-yLeUDLGxM-41HVSw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: Fix that RPM cannot be obtained for specific
 GPU
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: huangyizhi <huangyizhi@hnu.edu.cn>, "Quan, Evan" <evan.quan@amd.com>, 
 "Deucher, Alexander" <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>, 
 xinhui pan <Xinhui.Pan@amd.com>, Dave Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, 
 Lee Jones <lee.jones@linaro.org>, "Lazar, Lijo" <lijo.lazar@amd.com>, 
 amd-gfx list <amd-gfx@lists.freedesktop.org>
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

On Tue, Sep 28, 2021 at 2:29 AM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Am 28.09.21 um 02:49 schrieb huangyizhi:
> > The current mechanism for obtaining RPM is to read tach_period from
> > the register, and then calculate the RPM together with the frequency.
> > But we found that on specific GPUs, such as RX 550 and RX 560D,
> > tach_period always reads as 0 and smu7_fan_ctrl_get_fan_speed_rpm
> > will returns -EINVAL.
> >
> > To solve this problem, when reading tach_period as 0, we try
> > to estimate the current RPM using the percentage of current pwm, the
> > maximum and minimum RPM.
>
> Well that is most likely a bad idea.
>
> When the fan speed is not available faking some value is certainly not
> the right solution, especially when you don't know the topology of the
> DC conversion driven by the PWM.
>

I think there is a flag in the vbios to determine whether a specific
board supports rpm based fan control.  This used to be an AIB specific
option.  If the flag is not set, the driver should not expose the rpm
interface for fan control, only the PWM interface.  I think at some
point rpm fan control became mandatory, but maybe it was still an
option on polaris and we are missing a check for that flag.

Alex


> Christian.
>
> >
> > Signed-off-by: huangyizhi <huangyizhi@hnu.edu.cn>
> > ---
> >   .../drm/amd/pm/powerplay/hwmgr/smu7_thermal.c | 28 ++++++++++++++++--=
-
> >   1 file changed, 24 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_thermal.c b/dr=
ivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_thermal.c
> > index a6c3610db23e..307dd87d6882 100644
> > --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_thermal.c
> > +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_thermal.c
> > @@ -81,6 +81,11 @@ int smu7_fan_ctrl_get_fan_speed_rpm(struct pp_hwmgr =
*hwmgr, uint32_t *speed)
> >   {
> >       uint32_t tach_period;
> >       uint32_t crystal_clock_freq;
> > +     uint32_t duty100;
> > +     uint32_t duty;
> > +     uint32_t speed_percent;
> > +     uint64_t tmp64;
> > +
> >
> >       if (hwmgr->thermal_controller.fanInfo.bNoFan ||
> >           !hwmgr->thermal_controller.fanInfo.ucTachometerPulsesPerRevol=
ution)
> > @@ -89,13 +94,28 @@ int smu7_fan_ctrl_get_fan_speed_rpm(struct pp_hwmgr=
 *hwmgr, uint32_t *speed)
> >       tach_period =3D PHM_READ_VFPF_INDIRECT_FIELD(hwmgr->device, CGS_I=
ND_REG__SMC,
> >                       CG_TACH_STATUS, TACH_PERIOD);
> >
> > -     if (tach_period =3D=3D 0)
> > -             return -EINVAL;
> > +     if (tach_period =3D=3D 0) {
> >
> > -     crystal_clock_freq =3D amdgpu_asic_get_xclk((struct amdgpu_device=
 *)hwmgr->adev);
> > +             duty100 =3D PHM_READ_VFPF_INDIRECT_FIELD(hwmgr->device, C=
GS_IND_REG__SMC,
> > +                             CG_FDO_CTRL1, FMAX_DUTY100);
> > +             duty =3D PHM_READ_VFPF_INDIRECT_FIELD(hwmgr->device, CGS_=
IND_REG__SMC,
> > +                             CG_THERMAL_STATUS, FDO_PWM_DUTY);
> >
> > -     *speed =3D 60 * crystal_clock_freq * 10000 / tach_period;
> > +             if (duty100 =3D=3D 0)
> > +                     return -EINVAL;
> >
> > +             tmp64 =3D (uint64_t)duty * 100;
> > +             do_div(tmp64, duty100);
> > +             speed_percent =3D MIN((uint32_t)tmp64, 100);
> > +
> > +             *speed =3D speed_percent * (hwmgr->thermal_controller.fan=
Info.ulMaxRPM
> > +                     - hwmgr->thermal_controller.fanInfo.ulMinRPM) / 1=
00;
> > +     } else {
> > +
> > +             crystal_clock_freq =3D amdgpu_asic_get_xclk((struct amdgp=
u_device *)hwmgr->adev);
> > +
> > +             *speed =3D 60 * crystal_clock_freq * 10000 / tach_period;
> > +     }
> >       return 0;
> >   }
> >
>
