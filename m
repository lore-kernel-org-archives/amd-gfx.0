Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BC92C35FF8
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Mar 2025 09:54:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BAE110E0A4;
	Tue, 18 Mar 2025 09:54:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GAS0NPcg";
	dkim-atps=neutral
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com
 [209.85.208.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE3DF10E18C
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Mar 2025 15:11:25 +0000 (UTC)
Received: by mail-ed1-f42.google.com with SMTP id
 4fb4d7f45d1cf-5e616736458so646786a12.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Mar 2025 08:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742224284; x=1742829084; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+lkR+51SMSC7+EyYuzUrNctSWGt4/G2H8+jOfS0heeU=;
 b=GAS0NPcgFGjfBDvl7Rv1ATS9MOZcKQD3d5cZyls81WUQu8Nbm0GGJtDQRzFaiUfhrt
 SnjeUV7Ru/9i6HoBvRjagZ/3XOgwonBXpw4/3bUdNXaSEQMyEUV7GnGoM73bE1IapC94
 zxDrPLD13bumC0/fvTWNh8ZKLg+5eh9qtu53AvhrdbbVbl9NtwETfGsdYmSxoN8bmT73
 tzl4U/plOtp38ZTEyZaIqRBs/knUTBr694HKVo/BFVTLLKwLRHyMi34G3X1pqQhSC4Jp
 ItEayr4EiDaaaHhfL1rH16KOtbfA5Q6ksfqgO/n0MV7jDmHaaACUmd7z1R+kTWAt+Dny
 EJZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742224284; x=1742829084;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+lkR+51SMSC7+EyYuzUrNctSWGt4/G2H8+jOfS0heeU=;
 b=mLpeC9USkk3JaXTBtFZ9DEkIhc+qCn1VPZYLo9EFA/IzlQX03PEqw4vZnetRDA6iWa
 CRjUcg0pd3ozD8dOHK2HgRAhhPYE6bRAiu6xlRf4vOugwgyffNtATY4hBlOcWt0J1a27
 lv2uGZ2X9qVnEPolsnHyWIBfmHGgf+AgPr59I7wLwl4jLyxWWY9QBIlAsY3eNJAbTwip
 DbwkonWItsayJga71FolifCrxoBaiUsKFRyx39MHft8tq1Q03n0Mg+CBQU/S1pp+XKx5
 bH5ni2IDU8DNN04U32t4gDId08tc7dEjSpoLcFGJEXKxuuNsrUx62prE6V0X/crYYMZM
 Uimw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8AF0ALZIV3lyAozS8EKYzkrOc+1cejK0VHk6LE1iOK1D+DQEnAmHPrpa9iNICtAgLxphXGDCL@lists.freedesktop.org
X-Gm-Message-State: AOJu0YygtbMIjmifuyM/dmR2f6mczAtl1gNo2Id6fGmuM+ks2IYGvKUH
 dX5wDH6SWFDLOq0iM9K5AODH5wB67pFyBMr1s7E9+RVfTJT6I68T411Y1i4Ot9KSIfgp507UT7l
 OBoud5wFjnsr+Jchv13n44VpZMLQ=
X-Gm-Gg: ASbGncuYrtb6XiCAa6VAprQsamy8TLvhw0PXqA3LM+3Md1c/rhTZx6xv34m1m/YLQwt
 laaMjSHJUFZSdEx2OaT6hVDBwyiOJCbEK9hiPANh4N1EK8EHr+EyPap7MxN2D8d5Mo3eIABVAz0
 E3OuPEzrWgWT1IZH5x9lpe0Cbf
X-Google-Smtp-Source: AGHT+IHTobdLb5UkowlCz8eWC+Two9G3JwHDYwJ23rjr+6PEyF53H4SKiXT5HUa/gEa/91i6qMPIU0x326tbIX0ar5w=
X-Received: by 2002:a05:6402:518a:b0:5de:cb8d:1c82 with SMTP id
 4fb4d7f45d1cf-5e89f24dd3cmr4175995a12.4.1742224283711; Mon, 17 Mar 2025
 08:11:23 -0700 (PDT)
MIME-Version: 1.0
References: <20250315201558.339913-1-tomasz.pakula.oficjalny@gmail.com>
 <20250315201558.339913-3-tomasz.pakula.oficjalny@gmail.com>
 <CADnq5_OdsHpqcJCo77ktjnu8nQRMmTz7wqRLL5qZC8Sc-AOVYQ@mail.gmail.com>
In-Reply-To: <CADnq5_OdsHpqcJCo77ktjnu8nQRMmTz7wqRLL5qZC8Sc-AOVYQ@mail.gmail.com>
From: =?UTF-8?Q?Tomasz_Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
Date: Mon, 17 Mar 2025 16:11:11 +0100
X-Gm-Features: AQ5f1Jpq5eSEKTIXMWDEvZTaYWJAdS2JwujghaMGE3MvTL7sxOVS0b2S5o4V2EA
Message-ID: <CAFqprmxwRPVCNPge-wr_WLYG2DWdgCMXzQ3uCvYthqt8q1B-3Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amd/pm: add zero RPM stop temp OD setting support
 for SMU 14.0.2
To: Alex Deucher <alexdeucher@gmail.com>
Cc: alexander.deucher@amd.com, kenneth.feng@amd.com, KevinYang.Wang@amd.com, 
 amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 18 Mar 2025 09:54:43 +0000
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

On Mon, 17 Mar 2025 at 15:15, Alex Deucher <alexdeucher@gmail.com> wrote:
>
> On Mon, Mar 17, 2025 at 6:53=E2=80=AFAM Tomasz Paku=C5=82a
> <tomasz.pakula.oficjalny@gmail.com> wrote:
> >
> > Hook up zero RPM stop temperature for 9070 and 9070 XT based on RDNA3
> > (smu 13.0.0 and 13.0.7) code.
> >
> > Signed-off-by: Tomasz Paku=C5=82a <tomasz.pakula.oficjalny@gmail.com>
> > ---
> >  .../swsmu/inc/pmfw_if/smu14_driver_if_v14_0.h |  3 +-
> >  .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  | 50 ++++++++++++++++++-
> >  2 files changed, 51 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu14_driver_if_v=
14_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu14_driver_if_v14_0.h
> > index c2fd0a4a13e5..a5eba7b91e2f 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu14_driver_if_v14_0.h
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu14_driver_if_v14_0.h
> > @@ -846,9 +846,10 @@ typedef struct {
> >    uint16_t               FanTargetTemperature; // Degree Celcius
> >    //zero fan
> >    uint8_t                FanZeroRpmEnable;
> > +  uint8_t                FanZeroRpmStopTemp;
> >    //temperature
> >    uint8_t                MaxOpTemp;
> > -  uint8_t                Padding1[2];
> > +  uint8_t                Padding1;
> >
> >    //Full Ctrl
> >    uint16_t               GfxVoltageFullCtrlMode;
>
> This makes a change to the firmware interface.  Presumably it works
> differently here.  @Kenneth Feng or @Wang, Yang(Kevin) to confirm how
> this works with respect to the firmware.

This change in `smu14_driver_if_v14_0.h` to `OverDriveLimits_t` is based on=
 the
`OverDriveTable_t` which already has FanZeroRpmStopTemp. It was just missin=
g
from the limits table. I chalked it up to an omission. Here's the fan
control part of
the OverDriveTable_t:

//Fan control
uint8_t FanLinearPwmPoints[NUM_OD_FAN_MAX_POINTS];
uint8_t FanLinearTempPoints[NUM_OD_FAN_MAX_POINTS];
uint16_t FanMinimumPwm;
uint16_t AcousticTargetRpmThreshold;
uint16_t AcousticLimitRpmThreshold;
uint16_t FanTargetTemperature; // Degree Celcius
uint8_t FanZeroRpmEnable;
uint8_t FanZeroRpmStopTemp;
uint8_t FanMode;
uint8_t MaxOpTemp;

Based on my logical guess, `Padding1` which I changed from [2] to just a si=
ngle
`uint8_t` is still probably in a place where `MaxOpTemp` should actually be=
 and
`FanMode` should be added as well? Or maybe just MaxOpTemp and Padding
should be swapped? Of course, all that is just my best guess as I don't hav=
e the
firmware tables to confirm.

The only thing I can compare to is smu 13.0.0 and 13.0.7 code and they have
identical layout in their respective `OverDriveTable_t` and `OverDriveLimit=
s_t`.

In testing on my RX 9070 XT Hellhound, I was able to get range and adjust t=
he
Zero RPM stop temperature from `gpu_od/fan_ctrl/fan_zero_rpm_*`:

tomek@komputr /sys/class/drm/card1/device/gpu_od/fan_ctrl $ cat
fan_zero_rpm_enable
FAN_ZERO_RPM_ENABLE:
1
OD_RANGE:
ZERO_RPM_ENABLE: 0 1

tomek@komputr /sys/class/drm/card1/device/gpu_od/fan_ctrl $ cat
fan_zero_rpm_stop_temperature
FAN_ZERO_RPM_STOP_TEMPERATURE:
50
OD_RANGE:
ZERO_RPM_STOP_TEMPERATURE: 50 110

tomek@komputr /sys/class/drm/card1/device/gpu_od/fan_ctrl $ sudo tee
fan_target_temperature <<< "65"
65

tomek@komputr /sys/class/drm/card1/device/gpu_od/fan_ctrl $ sudo tee
fan_target_temperature <<< "c"
c

tomek@komputr /sys/class/drm/card1/device/gpu_od/fan_ctrl $ cat
fan_zero_rpm_stop_temperature
FAN_ZERO_RPM_STOP_TEMPERATURE:
50
OD_RANGE:
ZERO_RPM_STOP_TEMPERATURE: 50 110

tomek@komputr /sys/class/drm/card1/device/gpu_od/fan_ctrl $ sudo tee
fan_zero_rpm_stop_temperature <<< "45"
45
tee: fan_zero_rpm_stop_temperature: Invalid argument

And some dmesg info when trying to set a value that's out of range:
amdgpu 0000:0f:00.0: amdgpu: zero RPM stop temperature setting(45)
must be within [50, 110]!

Tomasz
