Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEF4CD2C122
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2024 15:16:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F5E510E107;
	Tue,  5 Nov 2024 15:16:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=yahoo.com.ar header.i=@yahoo.com.ar header.b="NY1juBE7";
	dkim-atps=neutral
Received: from sonic311-24.consmr.mail.gq1.yahoo.com
 (sonic311-24.consmr.mail.gq1.yahoo.com [98.137.65.205])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A136A10E107
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Nov 2024 15:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com.ar; s=s2048;
 t=1730819758; bh=g3dzZvF4SZd67l/ozO0UPVLnO9FKjYTGQwaJnUu30E4=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From:Subject:Reply-To;
 b=NY1juBE7onvNUWD388rugDtA9vAOTF7wDlomwLNv3sLqjP+hhnO2eb9Jhs40EoNz6beavnj+0avvyqnuqvO1B5lTPf4dXrbj2fQPVwjoaGN/D1dYYJmhM6EFNBtndRP26JWvMlhZRtSWt+e5ckUuc2nhpwQBbRmoUGgNNf6l5Pvugo8HLSCVLUmLI0VLVrRApp3kO4mD4LnGeL8t1GQZNnXmAnpW1AlZN7CgdS0dbvgeBOURe/AbvmfMXmFGTFE7+yWCwdtJJWL553lcvtDwGSQ83rtODGLQD5vbzEOzRXcD080+a41aBeBS9JaHrgF6a4QWX+aA6/et8NSuzOWjAw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1730819758; bh=TQ2lxoCmRTmmlqfPl2D7D9RGUGemnFSK+oQfPSEFZLJ=;
 h=X-Sonic-MF:Date:From:To:Subject:From:Subject;
 b=IJaR5SevU98ThUnQhuvLH1b+LulOSUl7d8zi5GZ/EfuQXbr7zTh3SYT4OCbXgFXoL7TtE5Pfvau+RyiVLhNmQ3P7p5uqDTX8YJQmSGnrH4Mp/M/QdfdovlIYm6qQQu3F0VfNPLvGNwInygggMnXN6Eh9EG926IwO9A9UujJNDSLXKKCAgNrQufK4v4mgLqZHFFJgJ6D/9S8gyypmDPJR2zoPuhem4pzUAaeEsXC3iN9tp3AQDuVs0E7myHg0krSytHyYKjS54ZE2SnDwBXGHfbNw92aXT6Qfk/SEG08IdyArzCsulAvR5CN67ZDvDFJwWeM9areoUVdTcolFc+KWYw==
X-YMail-OSG: ReZbyW4VM1nqjg8Hpz2HXzY0eICQ53ZabSs.SPBWFqHVADU1fif_55gL.gDeHvG
 fpjQPmi9Yl_tQnNNVHJ0PYpU17DUuSwr.LxDs2PXVTh2ePhEzrOd4GR5tlpoyK9yXiEHcHnJI7ud
 353xZU3TaQFR3qBpJAbZjSF90ZLxHqrPESlRI9cyPcq8qcK_66xsm2kBpfZhaDqtcJPlGO_4LwoG
 uqeTj9AfMDwh9M5b1oUpCLvB11EF68wr4XUGp2GyF8UG2.zCO2YFWCkWTerqw6raYNUjwjILZ8_c
 pvIpqXSG_M4tmnPz8VtREkrjaL.MXKnBKk1kzUN27qb8ojsZWeJGEB0BGCnOnIYCa.Ij_Z6L9Ags
 UB6vki83891Ek8XtZTbmVgoW_eoJtu1vL9dH3poNEVhqOxLhyktoECMxsK3CVwbK34GAv8TXn.X6
 WxsmWUb2YHrf7szhqN2w9bFcA3cANZH4T7mybc5ZTPyg1DtVERjbmN4k4GzhPzO8pVu2zY7xYmp8
 Ea.03ldfvgWss9ZlSdrw.FvYoUXiu.pC3Ay1Lkh7ctyQF4op.VHk0mz1aHDB2aue4ENh5XDdl69T
 YtbWM0BlgdnsbzJyvX8bhk1qVcC.ffX2z42DaOQV.ZrP7Y8m0VFmZUAIT8yQTz8TRsCSku7P3HAw
 8Au5k8..WqahOBp844okWR13SKLM.uhRhm1qI4zsFuer5Yb6BK7CXxi2aGVmE8SQpNByztu.dQW7
 eWYk2DNqYHBSd493uu6gX5S7Z25bPm4zS6FhTumMpO.mAoqunEHD1mTzBxCXY5QaXmFgXuxwFkqz
 _UnHZEeAmJa9fMy3B1Nb_VL7l1hw1g6WtgI.ftZT6smOGMi3BjjdSB76Z2u9Z09rJdSzosDZOrib
 sOUketrJBdvX08OvehXUaT8AKGgUhGnVYGOGJmHj10LWd7rnmrSBuqLoU53d1JGEWS.0YgpxJKHX
 ozFzsb3QuBUqS1Rprv0HPpyjAoxe_ouVS2tQQ4Unu_sK96m2nym4NAMQ5EsuzCLOc6GWdAOenAVO
 IBp5FLf9km02q2j9pFCoui6UK3XVYP9wS2iBGsyUeXsIX0aP0ZFCosGoj2jc6u7bSB7YK8C2lEsk
 1HEfnxuMj4.Q.EOfrmXCHBIjZYeNhtQk2.eNco9g4Py1C5v5lI3jOgBmU9PjWCmoFJyBZZkXBKcu
 dAhKDHw2mLgxqEyUOOWbpz6sKg5lm09I2lWnU.MUyJUCrvODUxn44rzKZbQNvRe98EPejEZKwYcq
 UOmjnZzZdZbFP9a7IKKGqIgu7qpG9QFoaAHybQLECGJQsLMFqr0BhbtZvdBxb89B82Zqc1Hd3nqO
 oCwOTYRSjg089tGEEMWbxUdemMLpwdkK0TLG6V4lFRRLqdPVQU0XEIfVB7lr1F1FdTrzff47AGJc
 NlhlZ_rJvDATy7_ZcvEu1IrmYravADesSUXGYhq1v.zxeE04xPY38D2AjCir7kPRobR5UoXRBcXP
 NgFapGiiCcs7kOy4154b5vIbfm9lQN6WDMCj__4CFaQtxsYmXD_vkg5hAHRxIoKOBrR_G64ru.bc
 VrZGqVXEGgu9r.Swol81dnn5p7bYnCk0xZD0E6J7HwA374xwbG7QPXr03rOFDrUJ.Ba0lS7SX9.D
 OJ2z0gAxIwoYoF_5Yy7UyQVyHJcJKeEMa37TvAQqB6F1zveqwdtjEdJBBnlx0tZCYJ8mDzEGyPXX
 bz6MUE.zh4fKSSwzd1yy6MEOjje1qOyxuXO54BgKZJ9nW5gBOo9LtBP2axf79_LQSwSS3ANoWLBX
 .nfMfL4J9B8vDHm5Ds7Tz72QvCZG.TFKMA590nn7mfbir5STau2P6Ps7AVcvuG7b4AbMIWXnlIAr
 vRiQSuusHNq3GGO1bB1HtAYTNcqnLuwYZXT1jNk.nDz6iT5.72RP13Mdn7O2HQLCdO3KV0P7IT94
 dfjWbpx44ByETFBeW_6KBy3m_rY29uauFF58WGxhpdNS8kRxyfC0kaE2tz7yTKw2a.YmrMdw7gXb
 Hiwp.Cc2oLbezm7_pRGsakH88a_HcBXNXwup3UeEKajmBhQkUMTgCYt9PWqdjDMDdHIebbDOzU8L
 NUR0BV28sZ2gY5D0yTKHKJQ6HVaNN0xV9Yga8_djWbaN2Hmwm1YNeOQo1LxXkNiD72.bQowy8RSo
 jN2cgeMBcKFq6mLhficZ4kYuOQykh3l4D_HMccTB0FekiKIpMRfgZZdohiGbjspGdAiHwxDzprPI
 qHdWEgzR6lc0c4fkb8vxlC_G4Jcr9.8m83AXV4e5AEDEj5IXy_kW0uJ2ZKiJGVbM8QH8ut2kYpiG
 TZtZmXtKUBngF.g--
X-Sonic-MF: <dark_sylinc@yahoo.com.ar>
X-Sonic-ID: b85804b5-1b3c-461d-aaa9-143faec42a44
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic311.consmr.mail.gq1.yahoo.com with HTTP; Tue, 5 Nov 2024 15:15:58 +0000
Date: Tue, 5 Nov 2024 15:15:27 +0000 (UTC)
From: "Matias N. Goldberg" <dark_sylinc@yahoo.com.ar>
To: Xaver Hugl <xaver.hugl@kde.org>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "harry.wentland@amd.com" <harry.wentland@amd.com>
Message-ID: <587512969.4692493.1730819727679@mail.yahoo.com>
In-Reply-To: <CAFZQkGzsS=QVycX_vkOa4SSaZ_+VLa_MCm-gtbnXgXwfq0ruDw@mail.gmail.com>
References: <49676545.2155587.1730128258922.ref@mail.yahoo.com>
 <49676545.2155587.1730128258922@mail.yahoo.com>
 <1193254694.2164272.1730128713802@mail.yahoo.com>
 <CAFZQkGzsS=QVycX_vkOa4SSaZ_+VLa_MCm-gtbnXgXwfq0ruDw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu add "pixel_encoding"
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: WebService/1.1.22806 YMailNorrin
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

> That's not a problem, incompatible options can just be rejected in atomic=
 tests.

I was thinking from a user perspective. It'd be easier for user-space confi=
g apps to present only the valid options, rather than offering all possible=
 combinations only to reject them after the user selected an invalid config=
 (or perform hundreds of atomic tests every time we need to show a config d=
ialog).


> opRGB is not supported by any screen I've ever looked at, so it doesn't s=
urprise me that you'd get glitches.

I don't know if it was just a fallback, but my screen *does* work when usin=
g opRGB with rgb encoding (it glitches when using yuv encoding).



Cheers
Matias



El lunes, 4 de noviembre de 2024, 11:49:28 a.=C2=A0m. ART, Xaver Hugl <xave=
r.hugl@kde.org> escribi=C3=B3:=20





Am Mo., 28. Okt. 2024 um 16:18 Uhr schrieb Matias N. Goldberg
<dark_sylinc@yahoo.com.ar>:
>
> SENDING AGAIN because it was sent with HTML formatting, which screwed up =
the email.
>
>
> Hi!
>
> This is my first patch ever to DRM/amdgpu (technically I didn't write the=
 patch, I just kept rebasing it over 4 years, and did lots of testing).
>
> I'm following the advise from:
> https://gitlab.freedesktop.org/drm/amd/-/issues/476#note_2628536
>
> Why this patch? Because it fix a practical problem with certain monitors =
that auto-select ycbcr444 when they should be set to "rgb" (this issue also=
 happens on Windows) when plugging an HDMI monitor to a DisplayPort via pas=
sive adapter.
>
>
> IMPORTANT remarks about the public API:
>
> 1. This API adds "pixel encoding" which has options "auto" (Default), "rg=
b", "ycbcr444", and "ycbcr420"
Is ycbcr420 not possible with amdgpu?

> 2. Intel has "RGB Broadcast". Its options are "Full" and "Limited 16:235"=
. There is a lot of overlap here. On Windows AMD Control Panel offers the o=
ption "Pixel Encoding" and its options are:
>=C2=A0 - RGB (full)
>=C2=A0 - RGB (limited)
>=C2=A0 - ycbcr444
>=C2=A0 - ycbcr420
>=C2=A0 - ycbcr422
>
> Which means that it may be worth reserving more keywords for this patch.
You don't need to reserve anything. Additional enum values can be
added at any time and don't need to have unique names vs. other enums.

> I don't know why ycbcr444/ycbcr420 do not offer full/limited variants on =
Windows, but I suspect it's because the driver can automatically tell wheth=
er to use Full vs Limited for ycbcr variants..
>
> 3. amdgpu already has "Colorspace" option. However this is a different (a=
lthough related) option. But there is quite the overlap:
>
> - Full/Limited options are sometimes included as part of the colorspace, =
such is the case of COLOR_SPACE_2020_RGB_FULLRANGE vs COLOR_SPACE_2020_RGB_=
LIMITEDRANGE, but there is no "LIMITED"/"FULL" variants for COLOR_SPACE_202=
0_YCBCR. Yet there are for YCBCR601 and YCBCR709. This may be a spec thing =
(I don=E2=80=99t know).
>
> - AFAIK amdgpu=E2=80=99s Limited/Full variants are not controllable from =
the public user-space API.
>
> - Certain options in "Colorspace" only makes sense in specific pixel enco=
ding. For example the option "opRGB" currently glitches when amdgpu is usin=
g ycbcr encoding (you can tell the monitor is interpreting the RGB signal a=
s YUV, thus white becomes purple and black becomes green).
opRGB is not supported by any screen I've ever looked at, so it
doesn't surprise me that you'd get glitches.

> - The kernel has DRM_MODE_COLORIMETRY_BT2020_RGB and DRM_MODE_COLORIMETRY=
_BT2020_YCC. AMDGPU kernel currently forces COLOR_SPACE_2020_RGB_FULLRANGE =
or COLOR_SPACE_2020_YCBCR based on the current pixel encoding (e.g. if usin=
g RGB encodings and colorspace =3D=3D DRM_MODE_COLORIMETRY_BT2020_YCC, it w=
ill be changed for COLOR_SPACE_2020_RGB_FULLRANGE with currently no choice =
for Limited range).
> - amdgpu seems to be able to automatically distinguish between Full and L=
imited for ycbcr=C2=A0 formats via the presence of flags.Y_ONLY bit. There =
is no such auto-detection for RGB.
>
>
> The way I see it, there are 3 configurations that can be arranged togethe=
r:
>
> - Pixel Encoding (RGB vs ycbcr444 vs ycbcr420).
> - Colorspace (YCBCR709 vs BT.2020 etc).
> - Full vs Limited.
>
> However not all options are compatible with everything.
That's not a problem, incompatible options can just be rejected in atomic t=
ests.

> I suspect doing the same as what AMD does on Windows (offer RGB/Full + RG=
B/Limited + all the ycbcr variants for "pixel encoding") is the best choice=
 (and leave the "Colorspace" option as is, for very advanced manipulation).
>
> 4. Xaver Hugl expressed his concerns with the current patch that having a=
n option called "auto" with no way of querying what is the current auto-sel=
ected encoding is sub-optimal.
>
>
> Cheers
> Matias
>
>
>
> From 6806baac51f1ac2028c49bcab216c19f26a7e92b Mon Sep 17 00:00:00 2001
> From: "Matias N. Goldberg" <dark_sylinc@yahoo.com.ar>
> Date: Sun, 6 Oct 2024 21:04:11 -0300
> Subject: [PATCH] [amdgpu] Add "pixel_encoding" to switch between RGB & YU=
V
>=C2=A0 color modes
>
> Usage:
> xrandr --output DisplayPort-1 --set "pixel encoding" rgb
>
> Supported options are: "auto" (Default), "rgb", "ycbcr444", and
> "ycbcr420"
>
> This patch allows users to switch between pixel encodings, which is
> specially important when auto gets it wrong (probably because of
> monitor's manufacturer mistake) and needs user intervention.
>
> Original patch by Yassine Imounachen
> Rebased by Matias N. Goldberg <dark_sylinc@yahoo.com.ar>
>
> Full discussion:
> https://gitlab.freedesktop.org/drm/amd/-/issues/476#note_2628536
> ---
>=C2=A0 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c=C2=A0 |=C2=A0 35 +++
>=C2=A0 drivers/gpu/drm/amd/amdgpu/amdgpu_display.h=C2=A0 |=C2=A0 3 +
>=C2=A0 drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h=C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 2 +
>=C2=A0 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 215 +++++++++++++++=
++-
>=C2=A0 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |=C2=A0 1 +
>=C2=A0 drivers/gpu/drm/amd/display/dc/core/dc.c=C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 8 +
>=C2=A0 drivers/gpu/drm/amd/display/dc/dc_stream.h=C2=A0 =C2=A0 |=C2=A0 2 +
>=C2=A0 drivers/gpu/drm/drm_modes.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 29 +++
>=C2=A0 include/drm/drm_connector.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 7 +
>=C2=A0 9 files changed, 290 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_display.c
> index b119d27271c1..9d201f368b6e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> @@ -1362,6 +1362,33 @@ static const struct drm_prop_enum_list amdgpu_dith=
er_enum_list[] =3D {
>=C2=A0 { AMDGPU_FMT_DITHER_ENABLE, "on" },
>=C2=A0 };
>
> +static const struct drm_prop_enum_list amdgpu_user_pixenc_list[] =3D {
> + { 0, "auto" },
> + { DRM_COLOR_FORMAT_RGB444, "rgb" },
> + { DRM_COLOR_FORMAT_YCBCR444, "ycbcr444" },
> + { DRM_COLOR_FORMAT_YCBCR420, "ycbcr420" },
> +};
> +
> +bool amdgpu_user_pixenc_from_name(
> + unsigned int *user_pixenc,
> + const char *pixenc_name)
> +{
> + bool found =3D false;
> +
> + if (pixenc_name && (*pixenc_name !=3D '\0')) {
> + const int sz =3D ARRAY_SIZE(amdgpu_user_pixenc_list);
> + int i;
> +
> + for (i =3D 0; !found && i < sz; ++i) {
> + if (strcmp(pixenc_name, amdgpu_user_pixenc_list[i].name) =3D=3D 0) {
> + *user_pixenc =3D amdgpu_user_pixenc_list[i].type;
> + found =3D true;
> + }
> + }
> + }
> + return found;
> +}
> +
>=C2=A0 int amdgpu_display_modeset_create_props(struct amdgpu_device *adev)
>=C2=A0 {
>=C2=A0 int sz;
> @@ -1408,6 +1435,14 @@ int amdgpu_display_modeset_create_props(struct amd=
gpu_device *adev)
>=C2=A0 =C2=A0 "dither",
>=C2=A0 =C2=A0 amdgpu_dither_enum_list, sz);
>
> + sz =3D ARRAY_SIZE(amdgpu_user_pixenc_list);
> + adev->mode_info.pixel_encoding_property =3D
> + drm_property_create_enum(adev_to_drm(adev), 0,
> + "pixel encoding",
> + amdgpu_user_pixenc_list, sz);
> + if (!adev->mode_info.pixel_encoding_property)
> + return -ENOMEM;
> +
>=C2=A0 return 0;
>=C2=A0 }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.h b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_display.h
> index 9d19940f73c8..ee1ad49fa123 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.h
> @@ -49,4 +49,7 @@ amdgpu_lookup_format_info(u32 format, uint64_t modifier=
);
>=C2=A0 int amdgpu_display_suspend_helper(struct amdgpu_device *adev);
>=C2=A0 int amdgpu_display_resume_helper(struct amdgpu_device *adev);
>
> +bool amdgpu_user_pixenc_from_name(unsigned int *user_pixenc,
> +=C2=A0 const char *pixenc_name);
> +
>=C2=A0 #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_mode.h
> index 5e3faefc5510..b984e66a5d75 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
> @@ -326,6 +326,8 @@ struct amdgpu_mode_info {
>=C2=A0 struct drm_property *audio_property;
>=C2=A0 /* FMT dithering */
>=C2=A0 struct drm_property *dither_property;
> + /* User HDMI pixel encoding override */
> + struct drm_property *pixel_encoding_property;
>=C2=A0 /* hardcoded DFP edid from BIOS */
>=C2=A0 const struct drm_edid *bios_hardcoded_edid;
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index bbfc47f6595f..2c03e0733178 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -6069,6 +6069,115 @@ static bool adjust_colour_depth_from_display_info=
(
>=C2=A0 return false;
>=C2=A0 }
>
> +/* convert an pixel encoding property value to a dc_pixel_encoding */
> +static bool drm_prop_to_dc_pixel_encoding(
> + enum dc_pixel_encoding *dc_pixenc,
> + unsigned int propval)
> +{
> + bool ret =3D false;
> +
> + switch (propval) {
> + case 0:
> + *dc_pixenc =3D PIXEL_ENCODING_UNDEFINED;
> + ret =3D true;
> + break;
> + case DRM_COLOR_FORMAT_RGB444:
> + *dc_pixenc =3D PIXEL_ENCODING_RGB;
> + ret =3D true;
> + break;
> + case DRM_COLOR_FORMAT_YCBCR444:
> + *dc_pixenc =3D PIXEL_ENCODING_YCBCR444;
> + ret =3D true;
> + break;
> + case DRM_COLOR_FORMAT_YCBCR420:
> + *dc_pixenc =3D PIXEL_ENCODING_YCBCR420;
> + ret =3D true;
> + break;
> + default:
> + break;
> + }
> + return ret;
> +}
> +
> +/* convert an dc_pixel_encoding to a pixel encoding property value */
> +static unsigned int dc_pixel_encoding_to_drm_prop(
> + enum dc_pixel_encoding pixel_encoding)
> +{
> + unsigned int propval =3D 0;
> +
> + switch (pixel_encoding) {
> + case PIXEL_ENCODING_RGB:
> + propval =3D DRM_COLOR_FORMAT_RGB444;
> + break;
> + case PIXEL_ENCODING_YCBCR444:
> + propval =3D DRM_COLOR_FORMAT_YCBCR444;
> + break;
> + case PIXEL_ENCODING_YCBCR420:
> + propval =3D DRM_COLOR_FORMAT_YCBCR420;
> + break;
> + default:
> + break;
> + }
> + return propval;
> +}
> +
> +/*
> + * Tries to read 'pixel_encoding' from the pixel_encoding DRM property o=
n
> + * 'state'. Returns true if a supported, acceptable, non-undefined value=
 is
> + * found; false otherwise. Only modifies 'pixel_encoding' if returning t=
rue.
> + */
> +bool get_connector_state_pixel_encoding(
> + enum dc_pixel_encoding *pixel_encoding,
> + const struct drm_connector_state *state,
> + const struct drm_display_info *info,
> + const struct drm_display_mode *mode_in)
> +{
> + bool ret =3D false;
> + struct dm_connector_state *dm_state;
> +
> + dm_state =3D to_dm_connector_state(state);
> + if (!dm_state)
> + return false;
> +
> + /* check encoding is supported */
> + switch (dm_state->pixel_encoding) {
> + case PIXEL_ENCODING_RGB:
> + ret =3D (info->color_formats & DRM_COLOR_FORMAT_RGB444);
> + break;
> + case PIXEL_ENCODING_YCBCR444:
> + ret =3D (info->color_formats & DRM_COLOR_FORMAT_YCBCR444);
> + break;
> + case PIXEL_ENCODING_YCBCR420:
> + ret =3D drm_mode_is_420(info, mode_in);
> + break;
> + default:
> + break;
> + }
> +
> + if (ret)
> + *pixel_encoding =3D dm_state->pixel_encoding;
> +
> + return ret;
> +}
> +
> +/*
> + * Writes 'pixel_encoding' to the pixel_encoding DRM property on 'state'=
, if
> + * the enum value is valid and supported; otherwise writes
> + * PIXEL_ENCODING_UNDEFINED which corresponds to the "auto" property sta=
te.
> + */
> +void set_connector_state_pixel_encoding(
> + const struct drm_connector_state *state,
> + enum dc_pixel_encoding pixel_encoding)
> +{
> + struct dm_connector_state *dm_state;
> +
> + dm_state =3D to_dm_connector_state(state);
> + if (!dm_state)
> + return;
> +
> + dm_state->pixel_encoding =3D pixel_encoding;
> +}
> +
>=C2=A0 static void fill_stream_properties_from_drm_display_mode(
>=C2=A0 struct dc_stream_state *stream,
>=C2=A0 const struct drm_display_mode *mode_in,
> @@ -6093,19 +6202,23 @@ static void fill_stream_properties_from_drm_displ=
ay_mode(
>=C2=A0 timing_out->h_border_right =3D 0;
>=C2=A0 timing_out->v_border_top =3D 0;
>=C2=A0 timing_out->v_border_bottom =3D 0;
> - /* TODO: un-hardcode */
> - if (drm_mode_is_420_only(info, mode_in)
> +
> + if (!get_connector_state_pixel_encoding(&timing_out->pixel_encoding,
> + connector_state, info, mode_in)) {
> + /* auto-select a pixel encoding */
> + if (drm_mode_is_420_only(info, mode_in)
>=C2=A0 && stream->signal =3D=3D SIGNAL_TYPE_HDMI_TYPE_A)
> - timing_out->pixel_encoding =3D PIXEL_ENCODING_YCBCR420;
> - else if (drm_mode_is_420_also(info, mode_in)
> + timing_out->pixel_encoding =3D PIXEL_ENCODING_YCBCR420;
> + else if (drm_mode_is_420_also(info, mode_in)
>=C2=A0 && aconnector
>=C2=A0 && aconnector->force_yuv420_output)
> - timing_out->pixel_encoding =3D PIXEL_ENCODING_YCBCR420;
> - else if ((connector->display_info.color_formats & DRM_COLOR_FORMAT_YCBC=
R444)
> - && stream->signal =3D=3D SIGNAL_TYPE_HDMI_TYPE_A)
> - timing_out->pixel_encoding =3D PIXEL_ENCODING_YCBCR444;
> - else
> - timing_out->pixel_encoding =3D PIXEL_ENCODING_RGB;
> + timing_out->pixel_encoding =3D PIXEL_ENCODING_YCBCR420;
> + else if ((connector->display_info.color_formats & DRM_COLOR_FORMAT_YCBC=
R444)
> + && stream->signal =3D=3D SIGNAL_TYPE_HDMI_TYPE_A)
> + timing_out->pixel_encoding =3D PIXEL_ENCODING_YCBCR444;
> + else
> + timing_out->pixel_encoding =3D PIXEL_ENCODING_RGB;
> + }
>
>=C2=A0 timing_out->timing_3d_format =3D TIMING_3D_FORMAT_NONE;
>=C2=A0 timing_out->display_color_depth =3D convert_color_depth_from_displa=
y_info(
> @@ -6169,6 +6282,9 @@ static void fill_stream_properties_from_drm_display=
_mode(
>=C2=A0 }
>=C2=A0 }
>
> + /* write back final choice of pixel encoding */
> + set_connector_state_pixel_encoding(connector_state, timing_out->pixel_e=
ncoding);
> +
>=C2=A0 stream->output_color_space =3D get_output_color_space(timing_out, c=
onnector_state);
>=C2=A0 stream->content_type =3D get_output_content_type(connector_state);
>=C2=A0 }
> @@ -6875,6 +6991,9 @@ int amdgpu_dm_connector_atomic_set_property(struct =
drm_connector *connector,
>=C2=A0 } else if (property =3D=3D adev->mode_info.underscan_property) {
>=C2=A0 dm_new_state->underscan_enable =3D val;
>=C2=A0 ret =3D 0;
> + } else if (property =3D=3D adev->mode_info.pixel_encoding_property) {
> + if (drm_prop_to_dc_pixel_encoding(&dm_new_state->pixel_encoding, val))
> + ret =3D 0;
>=C2=A0 }
>
>=C2=A0 return ret;
> @@ -6917,6 +7036,9 @@ int amdgpu_dm_connector_atomic_get_property(struct =
drm_connector *connector,
>=C2=A0 } else if (property =3D=3D adev->mode_info.underscan_property) {
>=C2=A0 *val =3D dm_state->underscan_enable;
>=C2=A0 ret =3D 0;
> + } else if (property =3D=3D adev->mode_info.pixel_encoding_property) {
> + *val =3D dc_pixel_encoding_to_drm_prop(dm_state->pixel_encoding);
> + ret =3D 0;
>=C2=A0 }
>
>=C2=A0 return ret;
> @@ -7088,6 +7210,20 @@ void amdgpu_dm_connector_funcs_reset(struct drm_co=
nnector *connector)
>=C2=A0 state->abm_level =3D amdgpu_dm_abm_level;
>=C2=A0 }
>
> + switch (connector->cmdline_mode.pixel_encoding) {
> + case DRM_COLOR_FORMAT_RGB444:
> + state->pixel_encoding =3D PIXEL_ENCODING_RGB;
> + break;
> + case DRM_COLOR_FORMAT_YCBCR444:
> + state->pixel_encoding =3D PIXEL_ENCODING_YCBCR444;
> + break;
> + case DRM_COLOR_FORMAT_YCBCR420:
> + state->pixel_encoding =3D PIXEL_ENCODING_YCBCR420;
> + break;
> + default:
> + break;
> + }
> +
>=C2=A0 __drm_atomic_helper_connector_reset(connector, &state->base);
>=C2=A0 }
>=C2=A0 }
> @@ -7114,6 +7250,7 @@ amdgpu_dm_connector_atomic_duplicate_state(struct d=
rm_connector *connector)
>=C2=A0 new_state->underscan_vborder =3D state->underscan_vborder;
>=C2=A0 new_state->vcpi_slots =3D state->vcpi_slots;
>=C2=A0 new_state->pbn =3D state->pbn;
> + new_state->pixel_encoding =3D state->pixel_encoding;
>=C2=A0 return &new_state->base;
>=C2=A0 }
>
> @@ -8175,6 +8312,12 @@ void amdgpu_dm_connector_init_helper(struct amdgpu=
_display_manager *dm,
>
>=C2=A0 if (adev->dm.hdcp_workqueue)
>=C2=A0 drm_connector_attach_content_protection_property(&aconnector->base,=
 true);
> +
> + if (adev->mode_info.pixel_encoding_property) {
> + drm_object_attach_property(&aconnector->base.base,
> + adev->mode_info.pixel_encoding_property, 0);
> + DRM_DEBUG_DRIVER("amdgpu: attached pixel encoding drm property");
> + }
>=C2=A0 }
>=C2=A0 }
>
> @@ -9377,6 +9520,38 @@ static void amdgpu_dm_commit_audio(struct drm_devi=
ce *dev,
>=C2=A0 }
>=C2=A0 }
>
> +static void update_stream_for_pixel_encoding(
> + struct dc_stream_update *stream_update,
> + struct drm_connector *connector,
> + struct dm_crtc_state *dm_old_crtc_state,
> + struct dm_crtc_state *dm_new_crtc_state,
> + struct dm_connector_state *dm_new_con_state)
> +{
> + struct amdgpu_dm_connector *aconnector =3D
> + to_amdgpu_dm_connector(connector);
> + struct dc_stream_state *new_stream =3D NULL;
> +
> + if (aconnector)
> + new_stream =3D create_validate_stream_for_sink(
> + aconnector,
> + &dm_new_crtc_state->base.mode,
> + dm_new_con_state,
> + dm_old_crtc_state->stream);
> + if (new_stream) {
> + dm_new_crtc_state->stream->timing =3D
> + new_stream->timing;
> + stream_update->timing_for_pixel_encoding =3D
> + &dm_new_crtc_state->stream->timing;
> +
> + dm_new_crtc_state->stream->output_color_space =3D
> + new_stream->output_color_space;
> + stream_update->output_color_space =3D
> + &dm_new_crtc_state->stream->output_color_space;
> +
> + dc_stream_release(new_stream);
> + }
> +}
> +
>=C2=A0 /*
>=C2=A0 * amdgpu_dm_crtc_copy_transient_flags - copy mirrored flags from DR=
M to DC
>=C2=A0 * @crtc_state: the DRM CRTC state
> @@ -9850,7 +10025,7 @@ static void amdgpu_dm_atomic_commit_tail(struct dr=
m_atomic_state *state)
>=C2=A0 struct dc_stream_update stream_update;
>=C2=A0 struct dc_info_packet hdr_packet;
>=C2=A0 struct dc_stream_status *status =3D NULL;
> - bool abm_changed, hdr_changed, scaling_changed;
> + bool abm_changed, hdr_changed, scaling_changed, pixenc_changed;
>
>=C2=A0 memset(&stream_update, 0, sizeof(stream_update));
>
> @@ -9875,7 +10050,10 @@ static void amdgpu_dm_atomic_commit_tail(struct d=
rm_atomic_state *state)
>=C2=A0 hdr_changed =3D
>=C2=A0 !drm_connector_atomic_hdr_metadata_equal(old_con_state, new_con_sta=
te);
>
> - if (!scaling_changed && !abm_changed && !hdr_changed)
> + pixenc_changed =3D dm_new_con_state->pixel_encoding !=3D
> +=C2=A0 dm_old_con_state->pixel_encoding;
> +
> + if (!scaling_changed && !abm_changed && !hdr_changed && !pixenc_changed=
)
>=C2=A0 continue;
>
>=C2=A0 stream_update.stream =3D dm_new_crtc_state->stream;
> @@ -9898,6 +10076,13 @@ static void amdgpu_dm_atomic_commit_tail(struct d=
rm_atomic_state *state)
>=C2=A0 stream_update.hdr_static_metadata =3D &hdr_packet;
>=C2=A0 }
>
> + if (pixenc_changed) {
> + update_stream_for_pixel_encoding(&stream_update,
> + connector,
> + dm_old_crtc_state, dm_new_crtc_state,
> + dm_new_con_state);
> + }
> +
>=C2=A0 status =3D dc_stream_get_status(dm_new_crtc_state->stream);
>
>=C2=A0 if (WARN_ON(!status))
> @@ -11403,6 +11588,12 @@ static int amdgpu_dm_atomic_check(struct drm_dev=
ice *dev,
>=C2=A0 if (dm_old_con_state->abm_level !=3D dm_new_con_state->abm_level ||
>=C2=A0 =C2=A0 =C2=A0 dm_old_con_state->scaling !=3D dm_new_con_state->scal=
ing)
>=C2=A0 new_crtc_state->connectors_changed =3D true;
> +
> + if (dm_old_con_state->pixel_encoding !=3D
> +=C2=A0 =C2=A0 dm_new_con_state->pixel_encoding) {
> + new_crtc_state->connectors_changed =3D true;
> + new_crtc_state->mode_changed =3D true;
> + }
>=C2=A0 }
>
>=C2=A0 if (dc_resource_is_dsc_encoding_supported(dc)) {
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> index 25e95775c45c..132944272c18 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> @@ -918,6 +918,7 @@ struct dm_connector_state {
>=C2=A0 uint8_t abm_level;
>=C2=A0 int vcpi_slots;
>=C2=A0 uint64_t pbn;
> + enum dc_pixel_encoding pixel_encoding;
>=C2=A0 };
>
>=C2=A0 #define to_dm_connector_state(x)\
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/a=
md/display/dc/core/dc.c
> index 5a12fc75f97f..4ac004536707 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -2765,6 +2765,11 @@ static enum surface_update_type check_update_surfa=
ces_for_stream(
>=C2=A0 if (stream_update->output_csc_transform || stream_update->output_co=
lor_space)
>=C2=A0 su_flags->bits.out_csc =3D 1;
>
> + if (stream_update->timing_for_pixel_encoding) {
> + su_flags->bits.pixel_encoding =3D 1;
> + elevate_update_type(&overall_type, UPDATE_TYPE_FULL);
> + }
> +
>=C2=A0 /* Output transfer function changes do not require bandwidth recalc=
ulation,
>=C2=A0 =C2=A0 * so don't trigger a full update
>=C2=A0 =C2=A0 */
> @@ -3112,6 +3117,8 @@ static void copy_stream_update_to_stream(struct dc =
*dc,
>=C2=A0 stream->scaler_sharpener_update =3D *update->scaler_sharpener_updat=
e;
>=C2=A0 if (update->sharpening_required)
>=C2=A0 stream->sharpening_required =3D *update->sharpening_required;
> + if (update->timing_for_pixel_encoding)
> + stream->timing =3D *update->timing_for_pixel_encoding;
>=C2=A0 }
>
>=C2=A0 static void backup_planes_and_stream_state(
> @@ -3361,6 +3368,7 @@ static void commit_planes_do_stream_update(struct d=
c *dc,
>=C2=A0 stream_update->vsc_infopacket ||
>=C2=A0 stream_update->vsp_infopacket ||
>=C2=A0 stream_update->hfvsif_infopacket ||
> + stream_update->timing_for_pixel_encoding ||
>=C2=A0 stream_update->adaptive_sync_infopacket ||
>=C2=A0 stream_update->vtem_infopacket) {
>=C2=A0 resource_build_info_frame(pipe_ctx);
> diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm=
/amd/display/dc/dc_stream.h
> index 413970588a26..de7f02f330d8 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
> +++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
> @@ -144,6 +144,7 @@ union stream_update_flags {
>=C2=A0 uint32_t fams_changed : 1;
>=C2=A0 uint32_t scaler_sharpener : 1;
>=C2=A0 uint32_t sharpening_required : 1;
> + uint32_t pixel_encoding:1;
>=C2=A0 } bits;
>
>=C2=A0 uint32_t raw;
> @@ -350,6 +351,7 @@ struct dc_stream_update {
>=C2=A0 struct dc_mst_stream_bw_update *mst_bw_update;
>=C2=A0 struct dc_transfer_func *func_shaper;
>=C2=A0 struct dc_3dlut *lut3d_func;
> + struct dc_crtc_timing *timing_for_pixel_encoding;
>
>=C2=A0 struct test_pattern *pending_test_pattern;
>=C2=A0 struct dc_crtc_timing_adjust *crtc_timing_adjust;
> diff --git a/drivers/gpu/drm/drm_modes.c b/drivers/gpu/drm/drm_modes.c
> index 1a0890083aee..b5ce8f93b672 100644
> --- a/drivers/gpu/drm/drm_modes.c
> +++ b/drivers/gpu/drm/drm_modes.c
> @@ -2161,6 +2161,32 @@ static int drm_mode_parse_tv_mode(const char *deli=
m,
>=C2=A0 return 0;
>=C2=A0 }
>
> +static int drm_mode_parse_pixel_encoding(const char *delim,
> +=C2=A0 struct drm_cmdline_mode *mode)
> +{
> + const char *value;
> +
> + if (*delim !=3D '=3D')
> + return -EINVAL;
> +
> + value =3D delim + 1;
> + delim =3D strchr(value, ',');
> + if (!delim)
> + delim =3D value + strlen(value);
> +
> + if (!strncmp(value, "auto", delim - value))
> + mode->pixel_encoding =3D 0;
> + else if (!strncmp(value, "rgb", delim - value))
> + mode->pixel_encoding =3D DRM_COLOR_FORMAT_RGB444;
> + else if (!strncmp(value, "ycbcr444", delim - value))
> + mode->pixel_encoding =3D DRM_COLOR_FORMAT_YCBCR444;
> + else if (!strncmp(value, "ycbcr420", delim - value))
> + mode->pixel_encoding =3D DRM_COLOR_FORMAT_YCBCR420;
> + else
> + return -EINVAL;
> +
> + return 0;
> +}
>=C2=A0 static int drm_mode_parse_cmdline_options(const char *str,
>=C2=A0 =C2=A0 bool freestanding,
>=C2=A0 =C2=A0 const struct drm_connector *connector,
> @@ -2233,6 +2259,9 @@ static int drm_mode_parse_cmdline_options(const cha=
r *str,
>=C2=A0 } else if (!strncmp(option, "tv_mode", delim - option)) {
>=C2=A0 if (drm_mode_parse_tv_mode(delim, mode))
>=C2=A0 return -EINVAL;
> + } else if (!strncmp(option, "pixel_encoding", delim - option)) {
> + if (drm_mode_parse_pixel_encoding(delim, mode))
> + return -EINVAL;
>=C2=A0 } else {
>=C2=A0 return -EINVAL;
>=C2=A0 }
> diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
> index c754651044d4..89c0f42873df 100644
> --- a/include/drm/drm_connector.h
> +++ b/include/drm/drm_connector.h
> @@ -1666,6 +1666,13 @@ struct drm_cmdline_mode {
>=C2=A0 =C2=A0 * Did the mode have a preferred TV mode?
>=C2=A0 =C2=A0 */
>=C2=A0 bool tv_mode_specified;
> +
> + /**
> +=C2=A0 * @pixel_encoding:
> +=C2=A0 *
> +=C2=A0 * Initial pixel encoding.
> +=C2=A0 */
> + unsigned int pixel_encoding;
>=C2=A0 };
>
>=C2=A0 /*
> --
> 2.43.0
