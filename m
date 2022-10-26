Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2545C38A2D
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Oct 2022 01:32:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D23610E1E7;
	Wed, 26 Oct 2022 01:32:33 +0000 (UTC)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1DCF10E1E7
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Oct 2022 01:32:30 +0000 (UTC)
Received: by mail-wr1-x431.google.com with SMTP id k8so15304142wrh.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Oct 2022 18:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DVVSLUf6xdfeGz47EfSVZGasRf0LZUbefLvgnRwj7Ek=;
 b=I5Ba1k+zb7UtkQ4KgNxP4r79dGGSQNMLf0yEV85j7g7QvNyErbraBav7Lzp00/zv2Y
 Jq/D9RrvOa0+TupuIVw3zumNLl79xYak4UFZp4JUnr/TEWVDZIURwfnAr9JAWQ3ZaVby
 tzfJPnDJsZkMeCIlJZGLO7HbOCt4K26PJeZBeFtfb1eCRdDirleaYKG63KTmVtN0Ma+d
 PzsXccdAnb30D5TSy2tmMxKAvGLFN9ahvkXVcS7Yielw15TjqVgVP3Squ4ULLgCZmfph
 Ky87zLy99/pMkMMdTqYyJ3wkIIvPRyoxBObv4CmoomHdKCcigpQMGfEMHw9VOjbH55oT
 LRXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DVVSLUf6xdfeGz47EfSVZGasRf0LZUbefLvgnRwj7Ek=;
 b=ERIpz0f8s/MfAr05ePE7WyVSPvZWTd3G5I6lPJIcjbKbMabbE5MS49JGva3KliN95s
 Cx2n72RKsvSOLbyfvdlNF2E+lMrkfvidZPjmRhnHmNpS8cK2RluYM8+0Vn6hmbwyYAIb
 UgtYeXj8/rvduk/87Zlc9SqEL/p22dJDumrxdamBi6Ag4RLA2gXI4nlf3Pmnqb484T46
 99Hf9IR4eFkMuTKP0sFrQapg9ujWFmyGAy8pqxNsFkHIFG0MkMJx39ExkL+C13YdzKJ4
 M+XlbdKGH1AncIZ9zH/2F7oHSAL3UvU54sK35H1Zl9ck/3by5LrDSp+qh69nmO9ll8N5
 T66w==
X-Gm-Message-State: ACrzQf3GwsaLxrhad6q0dt5KA9FEiLQ2Xb+FWAM96zamwhu3H39oa8uS
 Yxj4tE39RhdyZTSjzZQIMOVZf3pp4sUNizEC/Lo=
X-Google-Smtp-Source: AMsMyM6E9Ej2rxbH7eUZ1AgJMohYD4xiFypT8D49yX/peME87P6rteVgV1pQIWVs4eG/6qRig71/x1XLIzKzxx7flMc=
X-Received: by 2002:a5d:47a8:0:b0:231:ca77:ac57 with SMTP id
 8-20020a5d47a8000000b00231ca77ac57mr27019878wrb.384.1666747949006; Tue, 25
 Oct 2022 18:32:29 -0700 (PDT)
MIME-Version: 1.0
References: <20221014041456.139813-1-Asher.Song@amd.com>
In-Reply-To: <20221014041456.139813-1-Asher.Song@amd.com>
From: Yury Zhuravlev <stalkerg@gmail.com>
Date: Wed, 26 Oct 2022 10:31:01 +0900
Message-ID: <CANiD2e8PHA7u1qs8YkWkbbjxqB7JCnLNdR5OcHTH=dpfBWe7rg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Revert "drm/amdgpu: getting fan speed pwm for
 vega10 properly"
To: Asher Song <Asher.Song@amd.com>
Content-Type: multipart/alternative; boundary="0000000000006e465305ebe5ff23"
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
Cc: alexander.deucher@amd.com, evan.quan@amd.com, amd-gfx@lists.freedesktop.org,
 Guchun.Chen@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--0000000000006e465305ebe5ff23
Content-Type: text/plain; charset="UTF-8"

Hello,
Can you write here your card name and firmware version? Without this patch,
my fan sensors are broken, and it's sensitive to my pc case with water
cooling.
My card is:  Sapphire Pulse Radeon RX Vega 56  vd6546 SA
lspci name: [AMD/ATI] Vega 10 XL/XT [Radeon RX Vega 56/64] (rev c3)
Firmware: ATOM BIOS: 113-376XL-UO2
This patch is 100% working correct on my machine, and I tested it last 2
months.

Regards,

On Fri, Oct 14, 2022 at 1:15 PM Asher Song <Asher.Song@amd.com> wrote:

> This reverts commit fe01cb24b81c0091d7e5668874d51ce913e44a97.
>
> Unfortunately, that commit causes fan monitors can't be read and written
> properly.
>
> Signed-off-by: Asher Song <Asher.Song@amd.com>
> ---
>  .../amd/pm/powerplay/hwmgr/vega10_thermal.c   | 25 ++++++++++---------
>  1 file changed, 13 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c
> b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c
> index 190af79f3236..dad3e3741a4e 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c
> @@ -67,21 +67,22 @@ int vega10_fan_ctrl_get_fan_speed_info(struct pp_hwmgr
> *hwmgr,
>  int vega10_fan_ctrl_get_fan_speed_pwm(struct pp_hwmgr *hwmgr,
>                 uint32_t *speed)
>  {
> -       struct amdgpu_device *adev = hwmgr->adev;
> -       uint32_t duty100, duty;
> -       uint64_t tmp64;
> +       uint32_t current_rpm;
> +       uint32_t percent = 0;
>
> -       duty100 = REG_GET_FIELD(RREG32_SOC15(THM, 0, mmCG_FDO_CTRL1),
> -                               CG_FDO_CTRL1, FMAX_DUTY100);
> -       duty = REG_GET_FIELD(RREG32_SOC15(THM, 0, mmCG_THERMAL_STATUS),
> -                               CG_THERMAL_STATUS, FDO_PWM_DUTY);
> +       if (hwmgr->thermal_controller.fanInfo.bNoFan)
> +               return 0;
>
> -       if (!duty100)
> -               return -EINVAL;
> +       if (vega10_get_current_rpm(hwmgr, &current_rpm))
> +               return -1;
> +
> +       if (hwmgr->thermal_controller.
> +                       advanceFanControlParameters.usMaxFanRPM != 0)
> +               percent = current_rpm * 255 /
> +                       hwmgr->thermal_controller.
> +                       advanceFanControlParameters.usMaxFanRPM;
>
> -       tmp64 = (uint64_t)duty * 255;
> -       do_div(tmp64, duty100);
> -       *speed = MIN((uint32_t)tmp64, 255);
> +       *speed = MIN(percent, 255);
>
>         return 0;
>  }
> --
> 2.25.1
>
>

--0000000000006e465305ebe5ff23
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>Hello,<br>Can you write here your card name and =
firmware version? Without this patch, my fan sensors are broken, and it&#39=
;s sensitive to my pc case with water cooling.<br>My card is: =C2=A0Sapphir=
e Pulse Radeon RX Vega 56 =C2=A0vd6546 SA<br>lspci name: [AMD/ATI] Vega 10 =
XL/XT [Radeon RX Vega 56/64] (rev c3)<br>Firmware: ATOM BIOS: 113-376XL-UO2=
<br>This patch is 100% working correct on my machine, and I tested it last =
2 months.<br><br></div><div>Regards,<br></div></div></div><br><div class=3D=
"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Oct 14, 2022 at=
 1:15 PM Asher Song &lt;<a href=3D"mailto:Asher.Song@amd.com">Asher.Song@am=
d.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">This reverts commit fe01cb24b81c0091d7e5668874d51ce913e44a97.<br>
<br>
Unfortunately, that commit causes fan monitors can&#39;t be read and writte=
n<br>
properly.<br>
<br>
Signed-off-by: Asher Song &lt;<a href=3D"mailto:Asher.Song@amd.com" target=
=3D"_blank">Asher.Song@amd.com</a>&gt;<br>
---<br>
=C2=A0.../amd/pm/powerplay/hwmgr/vega10_thermal.c=C2=A0 =C2=A0| 25 ++++++++=
++---------<br>
=C2=A01 file changed, 13 insertions(+), 12 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c b/driv=
ers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c<br>
index 190af79f3236..dad3e3741a4e 100644<br>
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c<br>
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c<br>
@@ -67,21 +67,22 @@ int vega10_fan_ctrl_get_fan_speed_info(struct pp_hwmgr =
*hwmgr,<br>
=C2=A0int vega10_fan_ctrl_get_fan_speed_pwm(struct pp_hwmgr *hwmgr,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t *speed)<br=
>
=C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0struct amdgpu_device *adev =3D hwmgr-&gt;adev;<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t duty100, duty;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t tmp64;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t current_rpm;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t percent =3D 0;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0duty100 =3D REG_GET_FIELD(RREG32_SOC15(THM, 0, =
mmCG_FDO_CTRL1),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CG_FDO_CTRL1, FMAX_DUTY100);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0duty =3D REG_GET_FIELD(RREG32_SOC15(THM, 0, mmC=
G_THERMAL_STATUS),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CG_THERMAL_STATUS, FDO_PWM_DUTY);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (hwmgr-&gt;thermal_controller.fanInfo.bNoFan=
)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!duty100)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (vega10_get_current_rpm(hwmgr, &amp;current_=
rpm))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (hwmgr-&gt;thermal_controller.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0advanceFanControlParameters.usMaxFanRPM !=3D 0)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0percent =3D current=
_rpm * 255 /<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0hwmgr-&gt;thermal_controller.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0advanceFanControlParameters.usMaxFanRPM;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0tmp64 =3D (uint64_t)duty * 255;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0do_div(tmp64, duty100);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0*speed =3D MIN((uint32_t)tmp64, 255);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0*speed =3D MIN(percent, 255);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
=C2=A0}<br>
-- <br>
2.25.1<br>
<br>
</blockquote></div>

--0000000000006e465305ebe5ff23--
