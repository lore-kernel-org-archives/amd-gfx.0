Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46820C38A2D
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Oct 2022 09:07:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0101A10E4A1;
	Wed, 26 Oct 2022 09:07:52 +0000 (UTC)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6441F10E4A2
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Oct 2022 09:07:46 +0000 (UTC)
Received: by mail-wr1-x436.google.com with SMTP id bk15so25215409wrb.13
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Oct 2022 02:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=99Ikmff/ok2ie90X0nHk8GS8umihlNe/idqZiMW1vBc=;
 b=mDOg3S6sR3jwv6cTqrarYYwZbXpUim2vzPSRm/aDKZXhxaAYKK92/VPiQaMDYdPAxw
 TOd5JSsuCs16nxJVUlcQhiRvjhOy3eB6p0Tua8+rbJKUMm6GcbiCYM8kbaFi+TYDRHdR
 j+ZMPI05+vC4S8NbsNj7KN+LlFOyVkhdl+TNGEkuUMBuvkWXwB8qORj+GgVt7oJfY5XW
 Vv5H4gWP+97/aSE/yHR03mBb/k0NDGyybE4XMvK3KY77YXD4PqtUakPMxefvVLwQV80L
 tPkpiDZxyEEYk8BuNJBWteYMOE0fGVIArH8Vu0qb1VsgyoUig1vAAwpnsxi8yBTU2bRH
 xp0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=99Ikmff/ok2ie90X0nHk8GS8umihlNe/idqZiMW1vBc=;
 b=k+AJs8+0lL0F8wqZ4MzCPThADr5tupKKqsXEGW6t9zmIYS3CTlg9oUJ409Qzc5/CTp
 iG9p8gfGypAIMmsTzDfuN3HkWWA8y5iMf31DjwxFwtG8iaVgoysQ2Jg/sUgug7CVIda+
 NZNVz7SmO8S9In1Jj5WgpHFTj44QQ/tR3NKZ8Edbha0yMejPE6GyiRM0b0Uufh723w+6
 s2Uy81GgwDJaYtcywovgymJ6uH4onf2u8CGqgzO+59JskFapEybOzKf4X5qUefnu50Qq
 H/mnLTe0U0HwO+hZxbpXkefgypIehz9ivtszdopBIrDZ7XwGBD/wBYYptzdbzMYKSOvT
 rQsw==
X-Gm-Message-State: ACrzQf1ezqkNUqCJj1TgqrpOOjiZNP2iniNFvtujFB5iChTqSXHDqMNV
 VKmjY6zGleiObR10srCx98si0OfEGGF43kpmvFCFQagV8ZI=
X-Google-Smtp-Source: AMsMyM6HrM2MdS4pZ7YTjxlsdKrcE7PTaIatD27tuc8FGypF/AFf75EMYUKwzPZr9o900QhIdXPYzRCe+VfrTEWteZo=
X-Received: by 2002:a05:6000:23a:b0:236:71d7:5f90 with SMTP id
 l26-20020a056000023a00b0023671d75f90mr9598924wrz.322.1666775264715; Wed, 26
 Oct 2022 02:07:44 -0700 (PDT)
MIME-Version: 1.0
References: <20221014041456.139813-1-Asher.Song@amd.com>
 <CANiD2e8PHA7u1qs8YkWkbbjxqB7JCnLNdR5OcHTH=dpfBWe7rg@mail.gmail.com>
 <DM4PR12MB513603C468CE9BA8DC933D118B309@DM4PR12MB5136.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB513603C468CE9BA8DC933D118B309@DM4PR12MB5136.namprd12.prod.outlook.com>
From: Yury Zhuravlev <stalkerg@gmail.com>
Date: Wed, 26 Oct 2022 18:07:32 +0900
Message-ID: <CANiD2e-jjJyycgmBUDirBD+pGjf+Etifbvj5aBa0Q8Zd=KFxOg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Revert "drm/amdgpu: getting fan speed pwm for
 vega10 properly"
To: "Song, Asher" <Asher.Song@amd.com>
Content-Type: multipart/alternative; boundary="00000000000092e97d05ebec5b9d"
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Meng,
 Xiaohu" <Xiaohu.Meng@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Chen,
 Guchun" <Guchun.Chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--00000000000092e97d05ebec5b9d
Content-Type: text/plain; charset="UTF-8"

Hello Asher,

Thanks for the information, is it open-source tests? Can I reproduce it?

Also, it seems like Radeon Instinct MI25 was released before Radeon RX
Vega, is it possible that they have different PowerPlay subsystems?
On my Vega56, all these registers from vega20 are working very well.
Seems like we should split implementation somehow.

Regards,

On Wed, Oct 26, 2022 at 3:51 PM Song, Asher <Asher.Song@amd.com> wrote:

> [AMD Official Use Only - General]
>
>
>
> +@Meng, Xiaohu <Xiaohu.Meng@amd.com>
>
>
>
> Hi Zhuravlev,
>
>
>
> The information of test card is as following:
>
> Lspci name: [AMD/ATI] Vega 10 [Radeon Instinct MI25 MxGPU] (rev 05)
>
> Firmware: ATOM BIOS: 113-D0531800-C04
>
>
>
> When run test scripts compute-rocm-*/utils/run_rsmitst.sh, the below test
> cases fail.
>
> [  FAILED  ] 4 tests, listed below:
>
> [  FAILED  ] rsmitstReadOnly.TestOverdriveRead
>
> [  FAILED  ] rsmitstReadWrite.FanReadWrite
>
> [  FAILED  ] rsmitstReadWrite.TestOverdriveReadWrite
>
> [  FAILED  ] rsmitstReadWrite.TestPowerCapReadWrite
>
>
>
> Best Regards,
>
> Asher
>
> *From:* Yury Zhuravlev <stalkerg@gmail.com>
> *Sent:* Wednesday, October 26, 2022 9:31 AM
> *To:* Song, Asher <Asher.Song@amd.com>
> *Cc:* Deucher, Alexander <Alexander.Deucher@amd.com>; Chen, Guchun <
> Guchun.Chen@amd.com>; Quan, Evan <Evan.Quan@amd.com>;
> amd-gfx@lists.freedesktop.org
> *Subject:* Re: [PATCH] drm/amdgpu: Revert "drm/amdgpu: getting fan speed
> pwm for vega10 properly"
>
>
>
> Hello,
> Can you write here your card name and firmware version? Without this
> patch, my fan sensors are broken, and it's sensitive to my pc case with
> water cooling.
> My card is:  Sapphire Pulse Radeon RX Vega 56  vd6546 SA
> lspci name: [AMD/ATI] Vega 10 XL/XT [Radeon RX Vega 56/64] (rev c3)
> Firmware: ATOM BIOS: 113-376XL-UO2
> This patch is 100% working correct on my machine, and I tested it last 2
> months.
>
> Regards,
>
>
>
> On Fri, Oct 14, 2022 at 1:15 PM Asher Song <Asher.Song@amd.com> wrote:
>
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

--00000000000092e97d05ebec5b9d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div><div>Hello Asher,<br><br></div>Thanks =
for the information, is it open-source tests? Can I reproduce it? <br><br><=
/div>Also, it seems like Radeon Instinct MI25 was released before Radeon RX=
 Vega, is it possible that they have different PowerPlay subsystems? <br></=
div>On my Vega56, all these registers from vega20 are working very well. <b=
r></div>Seems like we should split implementation somehow. <br><br></div>Re=
gards, <br></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"g=
mail_attr">On Wed, Oct 26, 2022 at 3:51 PM Song, Asher &lt;<a href=3D"mailt=
o:Asher.Song@amd.com">Asher.Song@amd.com</a>&gt; wrote:<br></div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex"><div class=3D"msg772269019603494117=
3">





<div style=3D"overflow-wrap: break-word;" lang=3D"EN-US">
<div class=3D"m_7722690196034941173WordSection1">
<p class=3D"m_7722690196034941173msipheaderdf3d92d6" style=3D"margin:0in"><=
span style=3D"font-size:10pt;font-family:&quot;Arial&quot;,sans-serif;color=
:blue">[AMD Official Use Only - General]</span><u></u><u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<p class=3D"MsoNormal">+<a id=3D"m_7722690196034941173OWAAM2C3FD9A9EF544EB3=
A89BBBB72AF67D08" href=3D"mailto:Xiaohu.Meng@amd.com" target=3D"_blank"><sp=
an style=3D"font-family:&quot;Calibri&quot;,sans-serif;text-decoration:none=
">@Meng, Xiaohu</span></a><u></u><u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<p class=3D"MsoNormal">Hi Zhuravlev,<u></u><u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<p class=3D"MsoNormal">The information of test card is as following:<u></u>=
<u></u></p>
<p class=3D"MsoNormal">Lspci name: [AMD/ATI] Vega 10 [Radeon Instinct MI25 =
MxGPU] (rev 05)<u></u><u></u></p>
<p class=3D"MsoNormal">Firmware: ATOM BIOS: 113-D0531800-C04<u></u><u></u><=
/p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<p class=3D"MsoNormal">When run test scripts compute-rocm-*/utils/run_rsmit=
st.sh, the below test cases fail.
<u></u><u></u></p>
<p class=3D"MsoNormal">[=C2=A0 FAILED=C2=A0 ] 4 tests, listed below:<u></u>=
<u></u></p>
<p class=3D"MsoNormal">[=C2=A0 FAILED=C2=A0 ] rsmitstReadOnly.TestOverdrive=
Read<u></u><u></u></p>
<p class=3D"MsoNormal">[=C2=A0 FAILED=C2=A0 ] rsmitstReadWrite.FanReadWrite=
<u></u><u></u></p>
<p class=3D"MsoNormal">[=C2=A0 FAILED=C2=A0 ] rsmitstReadWrite.TestOverdriv=
eReadWrite<u></u><u></u></p>
<p class=3D"MsoNormal">[=C2=A0 FAILED=C2=A0 ] rsmitstReadWrite.TestPowerCap=
ReadWrite<u></u><u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<p class=3D"MsoNormal">Best Regards,<u></u><u></u></p>
<p class=3D"MsoNormal">Asher<u></u><u></u></p>
<div style=3D"border-color:rgb(225,225,225) currentcolor currentcolor;borde=
r-style:solid none none;border-width:1pt medium medium;padding:3pt 0in 0in"=
>
<p class=3D"MsoNormal"><b>From:</b> Yury Zhuravlev &lt;<a href=3D"mailto:st=
alkerg@gmail.com" target=3D"_blank">stalkerg@gmail.com</a>&gt; <br>
<b>Sent:</b> Wednesday, October 26, 2022 9:31 AM<br>
<b>To:</b> Song, Asher &lt;<a href=3D"mailto:Asher.Song@amd.com" target=3D"=
_blank">Asher.Song@amd.com</a>&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher@amd.c=
om" target=3D"_blank">Alexander.Deucher@amd.com</a>&gt;; Chen, Guchun &lt;<=
a href=3D"mailto:Guchun.Chen@amd.com" target=3D"_blank">Guchun.Chen@amd.com=
</a>&gt;; Quan, Evan &lt;<a href=3D"mailto:Evan.Quan@amd.com" target=3D"_bl=
ank">Evan.Quan@amd.com</a>&gt;; <a href=3D"mailto:amd-gfx@lists.freedesktop=
.org" target=3D"_blank">amd-gfx@lists.freedesktop.org</a><br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: Revert &quot;drm/amdgpu: getting fa=
n speed pwm for vega10 properly&quot;<u></u><u></u></p>
</div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<div>
<div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12pt">Hello,<br>
Can you write here your card name and firmware version? Without this patch,=
 my fan sensors are broken, and it&#39;s sensitive to my pc case with water=
 cooling.<br>
My card is: =C2=A0Sapphire Pulse Radeon RX Vega 56 =C2=A0vd6546 SA<br>
lspci name: [AMD/ATI] Vega 10 XL/XT [Radeon RX Vega 56/64] (rev c3)<br>
Firmware: ATOM BIOS: 113-376XL-UO2<br>
This patch is 100% working correct on my machine, and I tested it last 2 mo=
nths.<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal">Regards,<u></u><u></u></p>
</div>
</div>
</div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<div>
<div>
<p class=3D"MsoNormal">On Fri, Oct 14, 2022 at 1:15 PM Asher Song &lt;<a hr=
ef=3D"mailto:Asher.Song@amd.com" target=3D"_blank">Asher.Song@amd.com</a>&g=
t; wrote:<u></u><u></u></p>
</div>
<blockquote style=3D"border-color:currentcolor currentcolor currentcolor rg=
b(204,204,204);border-style:none none none solid;border-width:medium medium=
 medium 1pt;padding:0in 0in 0in 6pt;margin:5pt 0in 5pt 4.8pt">
<p class=3D"MsoNormal" style=3D"margin-bottom:12pt">This reverts commit fe0=
1cb24b81c0091d7e5668874d51ce913e44a97.<br>
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
2.25.1<u></u><u></u></p>
</blockquote>
</div>
</div>
</div>

</div></blockquote></div>

--00000000000092e97d05ebec5b9d--
