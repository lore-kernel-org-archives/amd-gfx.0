Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7F7CECAAD3
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Sep 2022 20:50:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B725610EE5A;
	Fri,  9 Sep 2022 20:50:39 +0000 (UTC)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3EF110EE5A
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Sep 2022 20:50:36 +0000 (UTC)
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-127f5411b9cso7043037fac.4
 for <amd-gfx@lists.freedesktop.org>; Fri, 09 Sep 2022 13:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date;
 bh=jtIzW4vlV/2kHTUvWN90als3zJYDARaCSFfqVbW0bDM=;
 b=FdP4S3Pb+wUEKpDqjFIT4mdRT54lWqM24bFiU01Dy7J2dBoRGCwsg/wtpPZH74fyGu
 +00a2Av00o//q9KiKcJykzAHTd7VDijCO9LWjig/QRR4Oie/w0V+aReC8iTXZdRcYOUk
 q8Mjor2sIzmuTbf01G5rKC5yisjtGZgX4ygwlLW/pTPpDalb7JIb0UhgkYzaCpwuqN/J
 ArlxvlJ01V5hII+6qm5beoOzxZFjBuWscOb220xl2ZhTVDQ66BD5UKn1Ky3gRpg3fYMw
 2URiOarDOim1s8PzWswiPY9OtZeGU3RchyvsPfl2Ngs1L9qyxBUBTwhevsl/UdgvNyBx
 PbSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date;
 bh=jtIzW4vlV/2kHTUvWN90als3zJYDARaCSFfqVbW0bDM=;
 b=Rar4AXWkvfjZELLadWk5Vw9aSbI2O5pzzaZ6/TPmcPpHlcFl3+Ki54rH32nGEy2Isz
 HwaqQIEAK4ysoqs91ucSVvoWzb1EazHUFXouaZEXbXELUdig8SIOLqy17LU8V3H1Zau3
 6/yUdhaA0XrfTHeXLkKIAp7v/n5VmIVmGrl1e+jHlRnAlvMYdy/zXLld/7wgPuCNlb8X
 ujlTUelWbE3GbePlsGgFxhc83j7aAOQxaigmNPnqBDjpJH8LgjzdOv6CAUYwsSKKKtdf
 xar948nUUBJIsL08ipeIEm4JuvfasHGafaPUCc0jNIq51OKXhUzWXuuUHrcvn03n0+OR
 ML8w==
X-Gm-Message-State: ACgBeo0qheaAby7DH8/SH+3LahAPYqpu8/f8qd/+iEOtxbhCVIzkYGX7
 ikbGAM0kSLpHHO+h1hciS5ycCBW/77j2iBAHuYJCZp4M
X-Google-Smtp-Source: AA6agR7f1JXyUyC1EyG/oW8C53xAidkCE9upg4o5TKqZcs0mzPNiBF7/3xPF3F4lJ8akLNuRolKO+L79VkjMsb2MJt4=
X-Received: by 2002:a05:6808:138e:b0:345:13d1:fd66 with SMTP id
 c14-20020a056808138e00b0034513d1fd66mr4526304oiw.96.1662756636172; Fri, 09
 Sep 2022 13:50:36 -0700 (PDT)
MIME-Version: 1.0
References: <CANiD2e9U=QXyYBOZLyTyqamtSJ3pyz45kZjEH04QbSpb=4miEg@mail.gmail.com>
In-Reply-To: <CANiD2e9U=QXyYBOZLyTyqamtSJ3pyz45kZjEH04QbSpb=4miEg@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 9 Sep 2022 16:50:25 -0400
Message-ID: <CADnq5_Mfshx+SekYBxPab7Xa8jaSQgTzgnR_JQUsC8-f4-RutQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: getting fan speed pwm for vega10 properly
To: Yury Zhuravlev <stalkerg@gmail.com>
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Sep 5, 2022 at 3:04 AM Yury Zhuravlev <stalkerg@gmail.com> wrote:
>
> Hello,
>
> During the setup, the fan manager https://github.com/markusressel/fan2go =
I found that my Vega56 was not working correctly. This fan manager expects =
what read PWM value should be the same as you wrote before, but it's not th=
e case. PWM value was volatile, and what is more critical, if I wrote 200, =
after reading I saw ~70-100, which is very confusing.
> After that, I started reading the amdgpu driver, and how fan speed works,=
 and I found what PWM value was calculated from RPM speed and not correct f=
or my case (different BIOS or fan configuration?).
> Because it looked wrong, I started looking into different implementations=
 and found that Vega20 used mmCG_FDO_CTRL1 and mmCG_THERMAL_STATUS register=
s to calculate the PWM value.
> I also checked how we set PWM for Vega10 and found the same registers. Af=
ter that, I copy-pasted the function from Vega20 to Vega10, and it started =
working much better. It still has some fluctuation, but as I understand, th=
is behavior is expected.
>
> I have no in-depth information about amdgpu, and the original function ma=
y have been for some reason (maybe for some broken BIOS?), but I suppose so=
mebody forgot to backport this code after prototype implementation.
>
> It would be my first patch here. Sorry if I skipped some procedures, will=
 be appreciated it if you help me.

Please send this as a proper patch with your Signed-off-by using git-send-e=
mail.

Alex

>
> Regards,
>
> ---
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c b/dr=
ivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c
> index dad3e3741a4e..190af79f3236 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c
> @@ -67,22 +67,21 @@ int vega10_fan_ctrl_get_fan_speed_info(struct pp_hwmg=
r *hwmgr,
>  int vega10_fan_ctrl_get_fan_speed_pwm(struct pp_hwmgr *hwmgr,
>                 uint32_t *speed)
>  {
> -       uint32_t current_rpm;
> -       uint32_t percent =3D 0;
> -
> -       if (hwmgr->thermal_controller.fanInfo.bNoFan)
> -               return 0;
> +       struct amdgpu_device *adev =3D hwmgr->adev;
> +       uint32_t duty100, duty;
> +       uint64_t tmp64;
>
> -       if (vega10_get_current_rpm(hwmgr, &current_rpm))
> -               return -1;
> +       duty100 =3D REG_GET_FIELD(RREG32_SOC15(THM, 0, mmCG_FDO_CTRL1),
> +                               CG_FDO_CTRL1, FMAX_DUTY100);
> +       duty =3D REG_GET_FIELD(RREG32_SOC15(THM, 0, mmCG_THERMAL_STATUS),
> +                               CG_THERMAL_STATUS, FDO_PWM_DUTY);
>
> -       if (hwmgr->thermal_controller.
> -                       advanceFanControlParameters.usMaxFanRPM !=3D 0)
> -               percent =3D current_rpm * 255 /
> -                       hwmgr->thermal_controller.
> -                       advanceFanControlParameters.usMaxFanRPM;
> +       if (!duty100)
> +               return -EINVAL;
>
> -       *speed =3D MIN(percent, 255);
> +       tmp64 =3D (uint64_t)duty * 255;
> +       do_div(tmp64, duty100);
> +       *speed =3D MIN((uint32_t)tmp64, 255);
>
>         return 0;
>  }
> --
