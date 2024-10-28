Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8F2CD33994
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2024 15:11:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 606A010E4E2;
	Mon, 28 Oct 2024 15:11:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=yahoo.com.ar header.i=@yahoo.com.ar header.b="Fy2XeqKc";
	dkim-atps=neutral
Received: from sonic301-21.consmr.mail.gq1.yahoo.com
 (sonic301-21.consmr.mail.gq1.yahoo.com [98.137.64.147])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF5F210E4E2
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2024 15:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com.ar; s=s2048;
 t=1730128261; bh=kYqeG5qKQ9xauQ08dituZlLDLNDIl2ifkDWobBFO4aY=;
 h=Date:From:To:Subject:References:From:Subject:Reply-To;
 b=Fy2XeqKcPAvx4A9W5CM9zbUEatm2bJRI5nQE5ocCiOwhSUvYO7aVxq1cLdfuOm3RRpHrGtiYl0baDFoBdD4GPogDr4VwlAJ0M/rC+KbQKNitXNNDLQATmlRDY4/QD67RkBUzKcX8b2bbbLZFP+D/wJB4hz5coesK6T2iLHi0WihvJZUJNH4asls/hLxFG+CjUv/uCU4Y2iNPxfkbgIkJxJjfVyQr5Qd3h0CFK/QlQQgOrFmEvAoghcuhYVNF6swrOowT+B5tVHiGK61mfOivm0/HQWzPrZkjm2Hfqtw9ixUNUMKwnS3T90M1NMf7oBFdiZ8gkRYmVyxIk3ol6rcWOw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1730128261; bh=bm6LeNMwDR9P6BdVLHB/uWtZUbz3OH3s4pSgDcOxkRs=;
 h=X-Sonic-MF:Date:From:To:Subject:From:Subject;
 b=j652GoIiSGNJVUC84MNbVq+Zkk70Fbo07opS5fb9chgDMANqNUhrtLOBGfEd4U2tGis2Yts/rGBwjHXfkfft4SRpDlqbDyz3WVIxQXd5SStHp3HH7zEzD4w8xz9uSzaBFZu0auE0A2kv1XcONGLhd278jvwa6c0C7siTrXrTa/6bcwkRnTu0f0M4Acci8K5wft8Movy5KmmmeN0Rpmg/4kte1dThYY0UUZnWB0xYD8thhWluAaifGNgloRXjd8edxCILbTody4IgyfRM99megvAV/4j+th52Y7KbJdhtLVLGiCmjmy0mGqHQwsyc5UeSdYV1HHLjKEawN+nEDkREjQ==
X-YMail-OSG: GO4XgS0VM1lRltw2zcL7DCrYIz6swafHfHDq7CBifwRkhiJv6fZrS5CtVGlcMCP
 u3wY9UuXXXG06uslp5ivPtiLRSQ2CnIJgViJ_pGk.eCjyFTu78aBPGr3FyNZ5BSRJ7RaiaXmQZZq
 RV9zOlUqxE71O0DwoEKQYTTdbULOjyePmmZRodmpH5se6p79M.6OE.dkK.8.3_CPOvQwhWlItszT
 CHxNpIwSWZC3x_cz6reSfEud.KP0ZjCR8hTyCRWBD9.3aiIVsxns95Jjdb8fC_EgQ_IYv._byrU.
 7JuC.6ujHDYybCaDHl8DClHVkl6JvgksfMV8PMHX2de0RzsNx9zHRtOX9pW_qJ09csJ1ObYaYiwc
 Q3FZWpsLzpM4C9cVro9GAZcO5g6LlecpmcnXhU87IpgB1NbiRBd8IZHMOEiF6pYMB7HSoWlKBkS2
 zK3hW8k23G4fVBp7rmLXrSgQE8I8kaqX8HxLOPQ7PuLn8qsp_yh5NMam9d5u8oxGDP68fG9zKd8E
 iCI6tOWHi9LMrqvpI2fV3EAa5GayK1ND3ZG3iuz2DpSxYhHXYmlkYQHFUGE7uRMpYijC3aWMMs6B
 7nOrXcQqWP9DWfGrw7K11RcYTZ919CD5xikF84_9pzBYW3FpCQs7GWovRIrGxwemvUwVZ.4Y6WnO
 ubvX8vJ783Hc5F1waSOFxNf84D_WcLFY.dx_snTDF3u8u0RFn6lmkT5l2EWCvngVXJ6l4yFb4z_N
 Vlg3uqKWYAN9o_JDuuzA0Ccfu3bSNynq6tIn0kKHZAFlNpV3s2GSIlz1hbqMmKPs0fPRUMoZ7POi
 FnvkD.ghN8rYe5cJRPh.75lGZf3GmW3MUbrrOjuPo.nlGQny1u6Z8GyyHGIgH5rfgePEAFhWj1Hl
 gQnGQm1lp_LkeIVl5wIi7nqk3.7zIf6M73_ORAVYvW.8SVSmMg97p4jzgap_hpN0HsYE4vB1yQ2N
 YYLE.ej1gzLfbWIHKpC4pOhHcfgVOcRjNjio5qvq8bB47AShiDxgdR06o4xCZBlvT_TkkX7inmxU
 XV_LT2xeifqA0LcmVepi9KFSfNiUATUlLlPdDp90CREdkPh4JA0.0MAs17gvJ1ig5rXQcNjW2maW
 2b8udFkZamV9IVAlELQBfLFcLictpmtiFwqcDyzlwD2io2_I5wWUZOIBsDCkoWHzdyx8xLMpjaur
 3e8BFbzvL3kqlHMp2VoM6C04ZF8nFiqXsMNjUqZ1wfANQSMNeG1kSozrjAmR100drlxzikvDAD29
 boP7ahmFDmmRw99gOd9YN5ct2ZhNDHg3M5RUyarG5oOMEn2D3IGjyfoL3Feo_xGD8TDamevcypGO
 H6gur_pKwB2HOD8nnxdcsKtYihpzTt5LiSS7yLOT6fEEzwphJ1gS.ksFWwmK1x9Ab7zOdQdo1jn5
 kvuCBZ5lr2qBOBQBOEhAEnW1.zvSQEjix2xOxCMpXtdC2AYa_WKqeZzhsPEdeoW0FIWobtTLr6mg
 qJLMeB8.GCKtAIIm4X3YDThjEYXLvb6O2ZKORBJ2.pJ5kEsPLZtnodUuTmbVRgnCgRMrIYOeyQk3
 LbguEvcOIp8Pqr_lK8YOzGLBEXrmw_A0xnWYj5e5.KgMd4jJ_szE4psvQbOa_3PRgiSbb.m.nXxt
 Gv4XKf8V1lSYIa4I4.M02tommL3EDaW1q0bM0stKbpJk2ePqwKGVDv2U1Ff9GJhCnz03PwKDvT8l
 CdzKsn_dppw2qWmk2DPpMFPxspKK5j5RhSqo.2KysYD3PFn6MOGgvOLJRiIST0NvX2Y_tW4HeTjF
 hQfUnwlVfdxEd8WvBq0tpuATQp8KmQaMlaYOKWLdCtNtPnA6eDzHwNLtbLJRCDMl9fr_mSPT.JxS
 vPsRKKqk9lmvXW9FhJeRYRTr8fo5UAoHP5NhC9xaaVqXWVUpWTPCELbpneNrEAcQMsAgpXJGcaVn
 Y39hcEDsI4W1V9JIeov_zNlJzqntow0u8W2Qbb.jFYRm1C51k5o8JYBP4kTJEZSKKVjZkiQTq3Cf
 _wfQVwNv3Uv_0qectSzjTxyXTe6m9YbwXLhRb.laHUAYC1UToHSLD5HXxonSpnrYHEDXxpGdRAIZ
 mL4cpwWU6bDi2dzzWiSN4Pa3NqT9MjU7ju9Tadlq_ZUGNHQaVpkdIYgI1XAm2iJNj5PxeCN4zKfX
 ScQVnx7DGASbbtlncErfewwnwMfgXflaTXQ8ufC9VPZsEgjAAoXDxJ_BLZoqHPeoNB9o6MWcx1Mz
 P2ADyljqP9dyxCL0kgos.40kc_09PK1ppgZwzbfQAEWuEV4NCdjHqHdo7kmFntTwilSiFKcNIcA-
 -
X-Sonic-MF: <dark_sylinc@yahoo.com.ar>
X-Sonic-ID: eef2915b-45e8-466c-99de-dbc3aba89da8
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic301.consmr.mail.gq1.yahoo.com with HTTP; Mon, 28 Oct 2024 15:11:01 +0000
Date: Mon, 28 Oct 2024 15:10:58 +0000 (UTC)
From: "Matias N. Goldberg" <dark_sylinc@yahoo.com.ar>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "harry.wentland@amd.com" <harry.wentland@amd.com>, 
 "xaver.hugl@kde.org" <xaver.hugl@kde.org>
Message-ID: <49676545.2155587.1730128258922@mail.yahoo.com>
Subject: [PATCH] drm/amdgpu add "pixel_encoding"
MIME-Version: 1.0
Content-Type: multipart/alternative; 
 boundary="----=_Part_2155586_1914508055.1730128258912"
References: <49676545.2155587.1730128258922.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.22849 YMailNorrin
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

------=_Part_2155586_1914508055.1730128258912
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi!
This is my first patch ever to DRM/amdgpu (technically I didn't write the p=
atch, I just kept rebasing it over 4 years, and did lots of testing).
I'm following the advise from:https://gitlab.freedesktop.org/drm/amd/-/issu=
es/476#note_2628536
Why this patch? Because it fix a practical problem with certain monitors th=
at auto-select ycbcr444 when they should be set to "rgb" (this issue also h=
appens on Windows) when plugging an HDMI monitor to a DisplayPort via passi=
ve adapter.

IMPORTANT remarks about the public API:
1. This API adds "pixel encoding" which has options "auto" (Default), "rgb"=
, "ycbcr444", and "ycbcr420"
2. Intel has "RGB Broadcast". Its options are "Full" and "Limited 16:235". =
There is a lot of overlap here. On Windows AMD Control Panel offers the opt=
ion "Pixel Encoding" and its options are:=C2=A0- RGB (full)=C2=A0- RGB (lim=
ited)=C2=A0- ycbcr444=C2=A0- ycbcr420=C2=A0- ycbcr422
Which means that it may be worth reserving more keywords for this patch.I d=
on't know why ycbcr444/ycbcr420 do not offer full/limited variants on Windo=
ws, but I suspect it's because the driver can automatically tell whether to=
 use Full vs Limited for ycbcr=C2=A0variants..
3. amdgpu already has "Colorspace" option. However this is a different (alt=
hough related) option. But there is quite the overlap:
- Full/Limited options are sometimes included as part of the colorspace, su=
ch is the case of COLOR_SPACE_2020_RGB_FULLRANGE vs COLOR_SPACE_2020_RGB_LI=
MITEDRANGE, but there is no "LIMITED"/"FULL" variants for COLOR_SPACE_2020_=
YCBCR. Yet there are for YCBCR601 and YCBCR709. This may be a spec thing (I=
 don=E2=80=99t know).- AFAIK amdgpu=E2=80=99s Limited/Full variants are not=
 controllable from the public user-space API.- Certain options in "Colorspa=
ce" only makes sense in specific pixel encoding. For example the option "op=
RGB" currently glitches when amdgpu is using ycbcr=C2=A0encoding (you can t=
ell the monitor is interpreting the RGB signal as YUV, thus white becomes p=
urple and black becomes green).- The kernel has DRM_MODE_COLORIMETRY_BT2020=
_RGB and DRM_MODE_COLORIMETRY_BT2020_YCC. AMDGPU kernel currently forces CO=
LOR_SPACE_2020_RGB_FULLRANGE or COLOR_SPACE_2020_YCBCR based on the current=
 pixel encoding (e.g. if using RGB encodings and colorspace =3D=3D DRM_MODE=
_COLORIMETRY_BT2020_YCC, it will be changed for COLOR_SPACE_2020_RGB_FULLRA=
NGE with currently no choice for Limited range).- amdgpu seems to be able t=
o automatically distinguish between Full and Limited for ycbcr=C2=A0 format=
s via the presence of flags.Y_ONLY bit. There is no such auto-detection for=
 RGB.

The way I see it, there are 3 configurations that can be arranged together:
- Pixel Encoding (RGB vs ycbcr444 vs ycbcr420).- Colorspace (YCBCR709 vs BT=
.2020 etc).- Full vs Limited.
However not all options are compatible with everything.
I suspect doing the same as what AMD does on Windows (offer RGB/Full + RGB/=
Limited + all the ycbcr variants for "pixel encoding") is the best choice (=
and leave the "Colorspace" option as is, for very advanced manipulation).
4. Xaver Hugl expressed his concerns with the current patch that having an =
option called "auto" with no way of querying what is the current auto-selec=
ted encoding is sub-optimal.

CheersMatias


From 6806baac51f1ac2028c49bcab216c19f26a7e92b Mon Sep 17 00:00:00 2001From:=
 "Matias N. Goldberg" <dark_sylinc@yahoo.com.ar>Date: Sun, 6 Oct 2024 21:04=
:11 -0300Subject: [PATCH] [amdgpu] Add "pixel_encoding" to switch between R=
GB & YUV=C2=A0color modes
Usage:xrandr --output DisplayPort-1 --set "pixel encoding" rgb
Supported options are: "auto" (Default), "rgb", "ycbcr444", and"ycbcr420"
This patch allows users to switch between pixel encodings, which isspeciall=
y important when auto gets it wrong (probably because ofmonitor's manufactu=
rer mistake) and needs user intervention.
Original patch by Yassine ImounachenRebased by Matias N. Goldberg <dark_syl=
inc@yahoo.com.ar>
Full discussion:https://gitlab.freedesktop.org/drm/amd/-/issues/476#note_26=
28536---=C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_display.c=C2=A0 =C2=A0|=C2=
=A0 35 +++=C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_display.h=C2=A0 =C2=A0|=
=C2=A0 =C2=A03 +=C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h=C2=A0 =C2=A0=
 =C2=A0 |=C2=A0 =C2=A02 +=C2=A0.../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.=
c | 215 +++++++++++++++++-=C2=A0.../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm=
.h |=C2=A0 =C2=A01 +=C2=A0drivers/gpu/drm/amd/display/dc/core/dc.c=C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 =C2=A08 +=C2=A0drivers/gpu/drm/amd/display/dc/dc_stre=
am.h=C2=A0 =C2=A0 |=C2=A0 =C2=A02 +=C2=A0drivers/gpu/drm/drm_modes.c=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 29 ++=
+=C2=A0include/drm/drm_connector.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A07 +=C2=A09 files changed, 290 ins=
ertions(+), 12 deletions(-)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_display.cindex b119d27271c1..9d201f368b6e 100644--- a/dri=
vers/gpu/drm/amd/amdgpu/amdgpu_display.c+++ b/drivers/gpu/drm/amd/amdgpu/am=
dgpu_display.c@@ -1362,6 +1362,33 @@ static const struct drm_prop_enum_list=
 amdgpu_dither_enum_list[] =3D {=C2=A0 { AMDGPU_FMT_DITHER_ENABLE, "on" },=
=C2=A0};=C2=A0+static const struct drm_prop_enum_list amdgpu_user_pixenc_li=
st[] =3D {+ { 0, "auto" },+ { DRM_COLOR_FORMAT_RGB444, "rgb" },+ { DRM_COLO=
R_FORMAT_YCBCR444, "ycbcr444" },+ { DRM_COLOR_FORMAT_YCBCR420, "ycbcr420" }=
,+};++bool amdgpu_user_pixenc_from_name(+ unsigned int *user_pixenc,+ const=
 char *pixenc_name)+{+ bool found =3D false;++ if (pixenc_name && (*pixenc_=
name !=3D '\0')) {+ const int sz =3D ARRAY_SIZE(amdgpu_user_pixenc_list);+ =
int i;++ for (i =3D 0; !found && i < sz; ++i) {+ if (strcmp(pixenc_name, am=
dgpu_user_pixenc_list[i].name) =3D=3D 0) {+ *user_pixenc =3D amdgpu_user_pi=
xenc_list[i].type;+ found =3D true;+ }+ }+ }+ return found;+}+=C2=A0int amd=
gpu_display_modeset_create_props(struct amdgpu_device *adev)=C2=A0{=C2=A0 i=
nt sz;@@ -1408,6 +1435,14 @@ int amdgpu_display_modeset_create_props(struct=
 amdgpu_device *adev)=C2=A0  "dither",=C2=A0  amdgpu_dither_enum_list, sz);=
=C2=A0+ sz =3D ARRAY_SIZE(amdgpu_user_pixenc_list);+ adev->mode_info.pixel_=
encoding_property =3D+ drm_property_create_enum(adev_to_drm(adev), 0,+ "pix=
el encoding",+ amdgpu_user_pixenc_list, sz);+ if (!adev->mode_info.pixel_en=
coding_property)+ return -ENOMEM;+=C2=A0 return 0;=C2=A0}=C2=A0diff --git a=
/drivers/gpu/drm/amd/amdgpu/amdgpu_display.h b/drivers/gpu/drm/amd/amdgpu/a=
mdgpu_display.hindex 9d19940f73c8..ee1ad49fa123 100644--- a/drivers/gpu/drm=
/amd/amdgpu/amdgpu_display.h+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display=
.h@@ -49,4 +49,7 @@ amdgpu_lookup_format_info(u32 format, uint64_t modifier=
);=C2=A0int amdgpu_display_suspend_helper(struct amdgpu_device *adev);=C2=
=A0int amdgpu_display_resume_helper(struct amdgpu_device *adev);=C2=A0+bool=
 amdgpu_user_pixenc_from_name(unsigned int *user_pixenc,+ =C2=A0 const char=
 *pixenc_name);+=C2=A0#endifdiff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_=
mode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.hindex 5e3faefc5510..b984e6=
6a5d75 100644--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h+++ b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_mode.h@@ -326,6 +326,8 @@ struct amdgpu_mode_info {=
=C2=A0 struct drm_property *audio_property;=C2=A0 /* FMT dithering */=C2=A0=
 struct drm_property *dither_property;+ /* User HDMI pixel encoding overrid=
e */+ struct drm_property *pixel_encoding_property;=C2=A0 /* hardcoded DFP =
edid from BIOS */=C2=A0 const struct drm_edid *bios_hardcoded_edid;=C2=A0di=
ff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/=
drm/amd/display/amdgpu_dm/amdgpu_dm.cindex bbfc47f6595f..2c03e0733178 10064=
4--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c+++ b/drivers/gpu/d=
rm/amd/display/amdgpu_dm/amdgpu_dm.c@@ -6069,6 +6069,115 @@ static bool adj=
ust_colour_depth_from_display_info(=C2=A0 return false;=C2=A0}=C2=A0+/* con=
vert an pixel encoding property value to a dc_pixel_encoding */+static bool=
 drm_prop_to_dc_pixel_encoding(+ enum dc_pixel_encoding *dc_pixenc,+ unsign=
ed int propval)+{+ bool ret =3D false;++ switch (propval) {+ case 0:+ *dc_p=
ixenc =3D PIXEL_ENCODING_UNDEFINED;+ ret =3D true;+ break;+ case DRM_COLOR_=
FORMAT_RGB444:+ *dc_pixenc =3D PIXEL_ENCODING_RGB;+ ret =3D true;+ break;+ =
case DRM_COLOR_FORMAT_YCBCR444:+ *dc_pixenc =3D PIXEL_ENCODING_YCBCR444;+ r=
et =3D true;+ break;+ case DRM_COLOR_FORMAT_YCBCR420:+ *dc_pixenc =3D PIXEL=
_ENCODING_YCBCR420;+ ret =3D true;+ break;+ default:+ break;+ }+ return ret=
;+}++/* convert an dc_pixel_encoding to a pixel encoding property value */+=
static unsigned int dc_pixel_encoding_to_drm_prop(+ enum dc_pixel_encoding =
pixel_encoding)+{+ unsigned int propval =3D 0;++ switch (pixel_encoding) {+=
 case PIXEL_ENCODING_RGB:+ propval =3D DRM_COLOR_FORMAT_RGB444;+ break;+ ca=
se PIXEL_ENCODING_YCBCR444:+ propval =3D DRM_COLOR_FORMAT_YCBCR444;+ break;=
+ case PIXEL_ENCODING_YCBCR420:+ propval =3D DRM_COLOR_FORMAT_YCBCR420;+ br=
eak;+ default:+ break;+ }+ return propval;+}++/*+ * Tries to read 'pixel_en=
coding' from the pixel_encoding DRM property on+ * 'state'. Returns true if=
 a supported, acceptable, non-undefined value is+ * found; false otherwise.=
 Only modifies 'pixel_encoding' if returning true.+ */+bool get_connector_s=
tate_pixel_encoding(+ enum dc_pixel_encoding *pixel_encoding,+ const struct=
 drm_connector_state *state,+ const struct drm_display_info *info,+ const s=
truct drm_display_mode *mode_in)+{+ bool ret =3D false;+ struct dm_connecto=
r_state *dm_state;++ dm_state =3D to_dm_connector_state(state);+ if (!dm_st=
ate)+ return false;++ /* check encoding is supported */+ switch (dm_state->=
pixel_encoding) {+ case PIXEL_ENCODING_RGB:+ ret =3D (info->color_formats &=
 DRM_COLOR_FORMAT_RGB444);+ break;+ case PIXEL_ENCODING_YCBCR444:+ ret =3D =
(info->color_formats & DRM_COLOR_FORMAT_YCBCR444);+ break;+ case PIXEL_ENCO=
DING_YCBCR420:+ ret =3D drm_mode_is_420(info, mode_in);+ break;+ default:+ =
break;+ }++ if (ret)+ *pixel_encoding =3D dm_state->pixel_encoding;++ retur=
n ret;+}++/*+ * Writes 'pixel_encoding' to the pixel_encoding DRM property =
on 'state', if+ * the enum value is valid and supported; otherwise writes+ =
* PIXEL_ENCODING_UNDEFINED which corresponds to the "auto" property state.+=
 */+void set_connector_state_pixel_encoding(+ const struct drm_connector_st=
ate *state,+ enum dc_pixel_encoding pixel_encoding)+{+ struct dm_connector_=
state *dm_state;++ dm_state =3D to_dm_connector_state(state);+ if (!dm_stat=
e)+ return;++ dm_state->pixel_encoding =3D pixel_encoding;+}+=C2=A0static v=
oid fill_stream_properties_from_drm_display_mode(=C2=A0 struct dc_stream_st=
ate *stream,=C2=A0 const struct drm_display_mode *mode_in,@@ -6093,19 +6202=
,23 @@ static void fill_stream_properties_from_drm_display_mode(=C2=A0 timi=
ng_out->h_border_right =3D 0;=C2=A0 timing_out->v_border_top =3D 0;=C2=A0 t=
iming_out->v_border_bottom =3D 0;- /* TODO: un-hardcode */- if (drm_mode_is=
_420_only(info, mode_in)++ if (!get_connector_state_pixel_encoding(&timing_=
out->pixel_encoding,+ connector_state, info, mode_in)) {+ /* auto-select a =
pixel encoding */+ if (drm_mode_is_420_only(info, mode_in)=C2=A0 && stream-=
>signal =3D=3D SIGNAL_TYPE_HDMI_TYPE_A)- timing_out->pixel_encoding =3D PIX=
EL_ENCODING_YCBCR420;- else if (drm_mode_is_420_also(info, mode_in)+ timing=
_out->pixel_encoding =3D PIXEL_ENCODING_YCBCR420;+ else if (drm_mode_is_420=
_also(info, mode_in)=C2=A0 && aconnector=C2=A0 && aconnector->force_yuv420_=
output)- timing_out->pixel_encoding =3D PIXEL_ENCODING_YCBCR420;- else if (=
(connector->display_info.color_formats & DRM_COLOR_FORMAT_YCBCR444)- && str=
eam->signal =3D=3D SIGNAL_TYPE_HDMI_TYPE_A)- timing_out->pixel_encoding =3D=
 PIXEL_ENCODING_YCBCR444;- else- timing_out->pixel_encoding =3D PIXEL_ENCOD=
ING_RGB;+ timing_out->pixel_encoding =3D PIXEL_ENCODING_YCBCR420;+ else if =
((connector->display_info.color_formats & DRM_COLOR_FORMAT_YCBCR444)+ && st=
ream->signal =3D=3D SIGNAL_TYPE_HDMI_TYPE_A)+ timing_out->pixel_encoding =
=3D PIXEL_ENCODING_YCBCR444;+ else+ timing_out->pixel_encoding =3D PIXEL_EN=
CODING_RGB;+ }=C2=A0=C2=A0 timing_out->timing_3d_format =3D TIMING_3D_FORMA=
T_NONE;=C2=A0 timing_out->display_color_depth =3D convert_color_depth_from_=
display_info(@@ -6169,6 +6282,9 @@ static void fill_stream_properties_from_=
drm_display_mode(=C2=A0 }=C2=A0 }=C2=A0+ /* write back final choice of pixe=
l encoding */+ set_connector_state_pixel_encoding(connector_state, timing_o=
ut->pixel_encoding);+=C2=A0 stream->output_color_space =3D get_output_color=
_space(timing_out, connector_state);=C2=A0 stream->content_type =3D get_out=
put_content_type(connector_state);=C2=A0}@@ -6875,6 +6991,9 @@ int amdgpu_d=
m_connector_atomic_set_property(struct drm_connector *connector,=C2=A0 } el=
se if (property =3D=3D adev->mode_info.underscan_property) {=C2=A0 dm_new_s=
tate->underscan_enable =3D val;=C2=A0 ret =3D 0;+ } else if (property =3D=
=3D adev->mode_info.pixel_encoding_property) {+ if (drm_prop_to_dc_pixel_en=
coding(&dm_new_state->pixel_encoding, val))+ ret =3D 0;=C2=A0 }=C2=A0=C2=A0=
 return ret;@@ -6917,6 +7036,9 @@ int amdgpu_dm_connector_atomic_get_proper=
ty(struct drm_connector *connector,=C2=A0 } else if (property =3D=3D adev->=
mode_info.underscan_property) {=C2=A0 *val =3D dm_state->underscan_enable;=
=C2=A0 ret =3D 0;+ } else if (property =3D=3D adev->mode_info.pixel_encodin=
g_property) {+ *val =3D dc_pixel_encoding_to_drm_prop(dm_state->pixel_encod=
ing);+ ret =3D 0;=C2=A0 }=C2=A0=C2=A0 return ret;@@ -7088,6 +7210,20 @@ voi=
d amdgpu_dm_connector_funcs_reset(struct drm_connector *connector)=C2=A0 st=
ate->abm_level =3D amdgpu_dm_abm_level;=C2=A0 }=C2=A0+ switch (connector->c=
mdline_mode.pixel_encoding) {+ case DRM_COLOR_FORMAT_RGB444:+ state->pixel_=
encoding =3D PIXEL_ENCODING_RGB;+ break;+ case DRM_COLOR_FORMAT_YCBCR444:+ =
state->pixel_encoding =3D PIXEL_ENCODING_YCBCR444;+ break;+ case DRM_COLOR_=
FORMAT_YCBCR420:+ state->pixel_encoding =3D PIXEL_ENCODING_YCBCR420;+ break=
;+ default:+ break;+ }+=C2=A0 __drm_atomic_helper_connector_reset(connector=
, &state->base);=C2=A0 }=C2=A0}@@ -7114,6 +7250,7 @@ amdgpu_dm_connector_at=
omic_duplicate_state(struct drm_connector *connector)=C2=A0 new_state->unde=
rscan_vborder =3D state->underscan_vborder;=C2=A0 new_state->vcpi_slots =3D=
 state->vcpi_slots;=C2=A0 new_state->pbn =3D state->pbn;+ new_state->pixel_=
encoding =3D state->pixel_encoding;=C2=A0 return &new_state->base;=C2=A0}=
=C2=A0@@ -8175,6 +8312,12 @@ void amdgpu_dm_connector_init_helper(struct am=
dgpu_display_manager *dm,=C2=A0=C2=A0 if (adev->dm.hdcp_workqueue)=C2=A0 dr=
m_connector_attach_content_protection_property(&aconnector->base, true);++ =
if (adev->mode_info.pixel_encoding_property) {+ drm_object_attach_property(=
&aconnector->base.base,+ adev->mode_info.pixel_encoding_property, 0);+ DRM_=
DEBUG_DRIVER("amdgpu: attached pixel encoding drm property");+ }=C2=A0 }=C2=
=A0}=C2=A0@@ -9377,6 +9520,38 @@ static void amdgpu_dm_commit_audio(struct =
drm_device *dev,=C2=A0 }=C2=A0}=C2=A0+static void update_stream_for_pixel_e=
ncoding(+ struct dc_stream_update *stream_update,+ struct drm_connector *co=
nnector,+ struct dm_crtc_state *dm_old_crtc_state,+ struct dm_crtc_state *d=
m_new_crtc_state,+ struct dm_connector_state *dm_new_con_state)+{+ struct a=
mdgpu_dm_connector *aconnector =3D+ to_amdgpu_dm_connector(connector);+ str=
uct dc_stream_state *new_stream =3D NULL;++ if (aconnector)+ new_stream =3D=
 create_validate_stream_for_sink(+ aconnector,+ &dm_new_crtc_state->base.mo=
de,+ dm_new_con_state,+ dm_old_crtc_state->stream);+ if (new_stream) {+ dm_=
new_crtc_state->stream->timing =3D+ new_stream->timing;+ stream_update->tim=
ing_for_pixel_encoding =3D+ &dm_new_crtc_state->stream->timing;++ dm_new_cr=
tc_state->stream->output_color_space =3D+ new_stream->output_color_space;+ =
stream_update->output_color_space =3D+ &dm_new_crtc_state->stream->output_c=
olor_space;++ dc_stream_release(new_stream);+ }+}+=C2=A0/*=C2=A0 * amdgpu_d=
m_crtc_copy_transient_flags - copy mirrored flags from DRM to DC=C2=A0 * @c=
rtc_state: the DRM CRTC state@@ -9850,7 +10025,7 @@ static void amdgpu_dm_a=
tomic_commit_tail(struct drm_atomic_state *state)=C2=A0 struct dc_stream_up=
date stream_update;=C2=A0 struct dc_info_packet hdr_packet;=C2=A0 struct dc=
_stream_status *status =3D NULL;- bool abm_changed, hdr_changed, scaling_ch=
anged;+ bool abm_changed, hdr_changed, scaling_changed, pixenc_changed;=C2=
=A0=C2=A0 memset(&stream_update, 0, sizeof(stream_update));=C2=A0@@ -9875,7=
 +10050,10 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_st=
ate *state)=C2=A0 hdr_changed =3D=C2=A0 !drm_connector_atomic_hdr_metadata_=
equal(old_con_state, new_con_state);=C2=A0- if (!scaling_changed && !abm_ch=
anged && !hdr_changed)+ pixenc_changed =3D dm_new_con_state->pixel_encoding=
 !=3D+  dm_old_con_state->pixel_encoding;++ if (!scaling_changed && !abm_ch=
anged && !hdr_changed && !pixenc_changed)=C2=A0 continue;=C2=A0=C2=A0 strea=
m_update.stream =3D dm_new_crtc_state->stream;@@ -9898,6 +10076,13 @@ stati=
c void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)=C2=A0 s=
tream_update.hdr_static_metadata =3D &hdr_packet;=C2=A0 }=C2=A0+ if (pixenc=
_changed) {+ update_stream_for_pixel_encoding(&stream_update,+ connector,+ =
dm_old_crtc_state, dm_new_crtc_state,+ dm_new_con_state);+ }+=C2=A0 status =
=3D dc_stream_get_status(dm_new_crtc_state->stream);=C2=A0=C2=A0 if (WARN_O=
N(!status))@@ -11403,6 +11588,12 @@ static int amdgpu_dm_atomic_check(struc=
t drm_device *dev,=C2=A0 if (dm_old_con_state->abm_level !=3D dm_new_con_st=
ate->abm_level ||=C2=A0 =C2=A0 =C2=A0 dm_old_con_state->scaling !=3D dm_new=
_con_state->scaling)=C2=A0 new_crtc_state->connectors_changed =3D true;++ i=
f (dm_old_con_state->pixel_encoding !=3D+ =C2=A0 =C2=A0 dm_new_con_state->p=
ixel_encoding) {+ new_crtc_state->connectors_changed =3D true;+ new_crtc_st=
ate->mode_changed =3D true;+ }=C2=A0 }=C2=A0=C2=A0 if (dc_resource_is_dsc_e=
ncoding_supported(dc)) {diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/=
amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.hindex 25e957=
75c45c..132944272c18 100644--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdg=
pu_dm.h+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h@@ -918,6 +91=
8,7 @@ struct dm_connector_state {=C2=A0 uint8_t abm_level;=C2=A0 int vcpi_=
slots;=C2=A0 uint64_t pbn;+ enum dc_pixel_encoding pixel_encoding;=C2=A0};=
=C2=A0=C2=A0#define to_dm_connector_state(x)\diff --git a/drivers/gpu/drm/a=
md/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.cindex 5a1=
2fc75f97f..4ac004536707 100644--- a/drivers/gpu/drm/amd/display/dc/core/dc.=
c+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c@@ -2765,6 +2765,11 @@ stati=
c enum surface_update_type check_update_surfaces_for_stream(=C2=A0 if (stre=
am_update->output_csc_transform || stream_update->output_color_space)=C2=A0=
 su_flags->bits.out_csc =3D 1;=C2=A0+ if (stream_update->timing_for_pixel_e=
ncoding) {+ su_flags->bits.pixel_encoding =3D 1;+ elevate_update_type(&over=
all_type, UPDATE_TYPE_FULL);+ }+=C2=A0 /* Output transfer function changes =
do not require bandwidth recalculation,=C2=A0  * so don't trigger a full up=
date=C2=A0  */@@ -3112,6 +3117,8 @@ static void copy_stream_update_to_strea=
m(struct dc *dc,=C2=A0 stream->scaler_sharpener_update =3D *update->scaler_=
sharpener_update;=C2=A0 if (update->sharpening_required)=C2=A0 stream->shar=
pening_required =3D *update->sharpening_required;+ if (update->timing_for_p=
ixel_encoding)+ stream->timing =3D *update->timing_for_pixel_encoding;=C2=
=A0}=C2=A0=C2=A0static void backup_planes_and_stream_state(@@ -3361,6 +3368=
,7 @@ static void commit_planes_do_stream_update(struct dc *dc,=C2=A0 strea=
m_update->vsc_infopacket ||=C2=A0 stream_update->vsp_infopacket ||=C2=A0 st=
ream_update->hfvsif_infopacket ||+ stream_update->timing_for_pixel_encoding=
 ||=C2=A0 stream_update->adaptive_sync_infopacket ||=C2=A0 stream_update->v=
tem_infopacket) {=C2=A0 resource_build_info_frame(pipe_ctx);diff --git a/dr=
ivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/d=
c_stream.hindex 413970588a26..de7f02f330d8 100644--- a/drivers/gpu/drm/amd/=
display/dc/dc_stream.h+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h@@ -1=
44,6 +144,7 @@ union stream_update_flags {=C2=A0 uint32_t fams_changed : 1;=
=C2=A0 uint32_t scaler_sharpener : 1;=C2=A0 uint32_t sharpening_required : =
1;+ uint32_t pixel_encoding:1;=C2=A0 } bits;=C2=A0=C2=A0 uint32_t raw;@@ -3=
50,6 +351,7 @@ struct dc_stream_update {=C2=A0 struct dc_mst_stream_bw_upda=
te *mst_bw_update;=C2=A0 struct dc_transfer_func *func_shaper;=C2=A0 struct=
 dc_3dlut *lut3d_func;+ struct dc_crtc_timing *timing_for_pixel_encoding;=
=C2=A0=C2=A0 struct test_pattern *pending_test_pattern;=C2=A0 struct dc_crt=
c_timing_adjust *crtc_timing_adjust;diff --git a/drivers/gpu/drm/drm_modes.=
c b/drivers/gpu/drm/drm_modes.cindex 1a0890083aee..b5ce8f93b672 100644--- a=
/drivers/gpu/drm/drm_modes.c+++ b/drivers/gpu/drm/drm_modes.c@@ -2161,6 +21=
61,32 @@ static int drm_mode_parse_tv_mode(const char *delim,=C2=A0 return =
0;=C2=A0}=C2=A0+static int drm_mode_parse_pixel_encoding(const char *delim,=
+  struct drm_cmdline_mode *mode)+{+ const char *value;++ if (*delim !=3D '=
=3D')+ return -EINVAL;++ value =3D delim + 1;+ delim =3D strchr(value, ',')=
;+ if (!delim)+ delim =3D value + strlen(value);++ if (!strncmp(value, "aut=
o", delim - value))+ mode->pixel_encoding =3D 0;+ else if (!strncmp(value, =
"rgb", delim - value))+ mode->pixel_encoding =3D DRM_COLOR_FORMAT_RGB444;+ =
else if (!strncmp(value, "ycbcr444", delim - value))+ mode->pixel_encoding =
=3D DRM_COLOR_FORMAT_YCBCR444;+ else if (!strncmp(value, "ycbcr420", delim =
- value))+ mode->pixel_encoding =3D DRM_COLOR_FORMAT_YCBCR420;+ else+ retur=
n -EINVAL;++ return 0;+}=C2=A0static int drm_mode_parse_cmdline_options(con=
st char *str,=C2=A0 =C2=A0 bool freestanding,=C2=A0 =C2=A0 const struct drm=
_connector *connector,@@ -2233,6 +2259,9 @@ static int drm_mode_parse_cmdli=
ne_options(const char *str,=C2=A0 } else if (!strncmp(option, "tv_mode", de=
lim - option)) {=C2=A0 if (drm_mode_parse_tv_mode(delim, mode))=C2=A0 retur=
n -EINVAL;+ } else if (!strncmp(option, "pixel_encoding", delim - option)) =
{+ if (drm_mode_parse_pixel_encoding(delim, mode))+ return -EINVAL;=C2=A0 }=
 else {=C2=A0 return -EINVAL;=C2=A0 }diff --git a/include/drm/drm_connector=
.h b/include/drm/drm_connector.hindex c754651044d4..89c0f42873df 100644--- =
a/include/drm/drm_connector.h+++ b/include/drm/drm_connector.h@@ -1666,6 +1=
666,13 @@ struct drm_cmdline_mode {=C2=A0  * Did the mode have a preferred =
TV mode?=C2=A0  */=C2=A0 bool tv_mode_specified;++ /**+  * @pixel_encoding:=
+  *+  * Initial pixel encoding.+  */+ unsigned int pixel_encoding;=C2=A0};=
=C2=A0=C2=A0/*--=C2=A02.43.0
------=_Part_2155586_1914508055.1730128258912
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<html><head></head><body><div class=3D"ydp3129e8e2yahoo-style-wrap" style=
=3D"font-family:Helvetica Neue, Helvetica, Arial, sans-serif;font-size:16px=
;"><div dir=3D"ltr" data-setdir=3D"false"><div><div>Hi!</div><div><br></div=
><div>This is my first patch ever to DRM/amdgpu (technically I didn't write=
 the patch, I just kept rebasing it over 4 years, and did lots of testing).=
</div><div><br></div><div>I'm following the advise from:</div><div>https://=
gitlab.freedesktop.org/drm/amd/-/issues/476#note_2628536</div><div><br></di=
v><div dir=3D"ltr" data-setdir=3D"false">Why this patch? Because it fix a p=
ractical problem with certain monitors that auto-select <span>ycbcr444 when=
 they should be set to "<span>rgb" (this issue also happens on Windows) whe=
n plugging an HDMI monitor to a DisplayPort via passive adapter</span></spa=
n>.</div><div><br></div><div><br></div><div dir=3D"ltr" data-setdir=3D"fals=
e">IMPORTANT remarks about the public API:</div><div><br></div><div>1. This=
 API adds "pixel encoding" which has options "auto" (Default), "rgb", "ycbc=
r444", and "ycbcr420"</div><div><br></div><div dir=3D"ltr" data-setdir=3D"f=
alse">2. Intel has "RGB Broadcast". Its options are "Full" and "Limited 16:=
235". There is a lot of overlap here. On Windows AMD Control Panel offers t=
he option "Pixel Encoding" and its options are:</div><div>&nbsp;- RGB (full=
)</div><div>&nbsp;- RGB (limited)</div><div>&nbsp;- ycbcr444</div><div>&nbs=
p;- ycbcr420</div><div dir=3D"ltr" data-setdir=3D"false">&nbsp;- <span><spa=
n style=3D"color: rgb(0, 0, 0); font-family: Helvetica Neue, Helvetica, Ari=
al, sans-serif; font-size: 16px;">ycbcr</span></span>422</div><div><br></di=
v><div>Which means that it may be worth reserving more keywords for this pa=
tch.</div><div dir=3D"ltr" data-setdir=3D"false">I don't know why ycbcr444/=
ycbcr420 do not offer full/limited variants on Windows, but I suspect it's =
because the driver can automatically tell whether to use Full vs Limited fo=
r <span>ycbcr</span>&nbsp;variants..</div><div><br></div><div>3. amdgpu alr=
eady has "Colorspace" option. However this is a different (although related=
) option. But there is quite the overlap:</div><div><br></div><div>- Full/L=
imited options are sometimes included as part of the colorspace, such is th=
e case of COLOR_SPACE_2020_RGB_FULLRANGE vs COLOR_SPACE_2020_RGB_LIMITEDRAN=
GE, but there is no "LIMITED"/"FULL" variants for COLOR_SPACE_2020_YCBCR. Y=
et there are for YCBCR601 and YCBCR709. This may be a spec thing (I don=E2=
=80=99t know).</div><div>- AFAIK amdgpu=E2=80=99s Limited/Full variants are=
 not controllable from the public user-space API.</div><div dir=3D"ltr" dat=
a-setdir=3D"false">- Certain options in "Colorspace" only makes sense in sp=
ecific pixel encoding. For example the option "opRGB" currently glitches wh=
en amdgpu is using <span>ycbcr</span>&nbsp;encoding (you can tell the monit=
or is interpreting the RGB signal as YUV, thus white becomes purple and bla=
ck becomes green).</div><div>- The kernel has DRM_MODE_COLORIMETRY_BT2020_R=
GB and DRM_MODE_COLORIMETRY_BT2020_YCC. AMDGPU kernel currently forces COLO=
R_SPACE_2020_RGB_FULLRANGE or COLOR_SPACE_2020_YCBCR based on the current p=
ixel encoding (e.g. if using RGB encodings and colorspace =3D=3D DRM_MODE_C=
OLORIMETRY_BT2020_YCC, it will be changed for COLOR_SPACE_2020_RGB_FULLRANG=
E with currently no choice for Limited range).</div><div dir=3D"ltr" data-s=
etdir=3D"false">- amdgpu seems to be able to automatically distinguish betw=
een Full and Limited for <span>ycbcr</span>&nbsp; formats via the presence =
of flags.Y_ONLY bit. There is no such auto-detection for RGB.</div><div><br=
></div><div><br></div><div>The way I see it, there are 3 configurations tha=
t can be arranged together:</div><div><br></div><div dir=3D"ltr" data-setdi=
r=3D"false">- Pixel Encoding (RGB vs  <span><span style=3D"color: rgb(0, 0,=
 0); font-family: Helvetica Neue, Helvetica, Arial, sans-serif; font-size: =
16px;">ycbcr</span></span>444 vs  <span>ycbcr</span>420).</div><div>- Color=
space (YCBCR709 vs BT.2020 etc).</div><div>- Full vs Limited.</div><div><br=
></div><div>However not all options are compatible with everything.</div><d=
iv><br></div><div>I suspect doing the same as what AMD does on Windows (off=
er RGB/Full + RGB/Limited + all the ycbcr variants for "pixel encoding") is=
 the best choice (and leave the "Colorspace" option as is, for very advance=
d manipulation).</div></div><div><br></div><div dir=3D"ltr" data-setdir=3D"=
false">4. Xaver Hugl expressed his concerns with the current patch that hav=
ing an option called "auto" with no way of querying what is the current aut=
o-selected encoding is sub-optimal.</div><div><br></div><div><br></div><div=
 dir=3D"ltr" data-setdir=3D"false">Cheers</div><div dir=3D"ltr" data-setdir=
=3D"false">Matias</div><br></div><div><br></div><div><br></div><div>From 68=
06baac51f1ac2028c49bcab216c19f26a7e92b Mon Sep 17 00:00:00 2001</div><div>F=
rom: "Matias N. Goldberg" &lt;dark_sylinc@yahoo.com.ar&gt;</div><div>Date: =
Sun, 6 Oct 2024 21:04:11 -0300</div><div>Subject: [PATCH] [amdgpu] Add "pix=
el_encoding" to switch between RGB &amp; YUV</div><div>&nbsp;color modes</d=
iv><div><br></div><div>Usage:</div><div>xrandr --output DisplayPort-1 --set=
 "pixel encoding" rgb</div><div><br></div><div>Supported options are: "auto=
" (Default), "rgb", "ycbcr444", and</div><div>"ycbcr420"</div><div><br></di=
v><div>This patch allows users to switch between pixel encodings, which is<=
/div><div>specially important when auto gets it wrong (probably because of<=
/div><div>monitor's manufacturer mistake) and needs user intervention.</div=
><div><br></div><div>Original patch by Yassine Imounachen</div><div>Rebased=
 by Matias N. Goldberg &lt;dark_sylinc@yahoo.com.ar&gt;</div><div><br></div=
><div>Full discussion:</div><div>https://gitlab.freedesktop.org/drm/amd/-/i=
ssues/476#note_2628536</div><div>---</div><div>&nbsp;drivers/gpu/drm/amd/am=
dgpu/amdgpu_display.c&nbsp; &nbsp;|&nbsp; 35 +++</div><div>&nbsp;drivers/gp=
u/drm/amd/amdgpu/amdgpu_display.h&nbsp; &nbsp;|&nbsp; &nbsp;3 +</div><div>&=
nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h&nbsp; &nbsp; &nbsp; |&nbsp; &=
nbsp;2 +</div><div>&nbsp;.../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 21=
5 +++++++++++++++++-</div><div>&nbsp;.../gpu/drm/amd/display/amdgpu_dm/amdg=
pu_dm.h |&nbsp; &nbsp;1 +</div><div>&nbsp;drivers/gpu/drm/amd/display/dc/co=
re/dc.c&nbsp; &nbsp; &nbsp; |&nbsp; &nbsp;8 +</div><div>&nbsp;drivers/gpu/d=
rm/amd/display/dc/dc_stream.h&nbsp; &nbsp; |&nbsp; &nbsp;2 +</div><div>&nbs=
p;drivers/gpu/drm/drm_modes.c&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp;|&nbsp; 29 +++</div><div>&nbsp;include/drm/drm_conne=
ctor.h&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
|&nbsp; &nbsp;7 +</div><div>&nbsp;9 files changed, 290 insertions(+), 12 de=
letions(-)</div><div><br></div><div>diff --git a/drivers/gpu/drm/amd/amdgpu=
/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c</div><div>i=
ndex b119d27271c1..9d201f368b6e 100644</div><div>--- a/drivers/gpu/drm/amd/=
amdgpu/amdgpu_display.c</div><div>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_d=
isplay.c</div><div>@@ -1362,6 +1362,33 @@ static const struct drm_prop_enum=
_list amdgpu_dither_enum_list[] =3D {</div><div>&nbsp;<span>=09</span>{ AMD=
GPU_FMT_DITHER_ENABLE, "on" },</div><div>&nbsp;};</div><div>&nbsp;</div><di=
v>+static const struct drm_prop_enum_list amdgpu_user_pixenc_list[] =3D {</=
div><div>+<span>=09</span>{ 0, "auto" },</div><div>+<span>=09</span>{ DRM_C=
OLOR_FORMAT_RGB444, "rgb" },</div><div>+<span>=09</span>{ DRM_COLOR_FORMAT_=
YCBCR444, "ycbcr444" },</div><div>+<span>=09</span>{ DRM_COLOR_FORMAT_YCBCR=
420, "ycbcr420" },</div><div>+};</div><div>+</div><div>+bool amdgpu_user_pi=
xenc_from_name(</div><div>+<span>=09</span>unsigned int *user_pixenc,</div>=
<div>+<span>=09</span>const char *pixenc_name)</div><div>+{</div><div>+<spa=
n>=09</span>bool found =3D false;</div><div>+</div><div>+<span>=09</span>if=
 (pixenc_name &amp;&amp; (*pixenc_name !=3D '\0')) {</div><div>+<span>=09=
=09</span>const int sz =3D ARRAY_SIZE(amdgpu_user_pixenc_list);</div><div>+=
<span>=09=09</span>int i;</div><div>+</div><div>+<span>=09=09</span>for (i =
=3D 0; !found &amp;&amp; i &lt; sz; ++i) {</div><div>+<span>=09=09=09</span=
>if (strcmp(pixenc_name, amdgpu_user_pixenc_list[i].name) =3D=3D 0) {</div>=
<div>+<span>=09=09=09=09</span>*user_pixenc =3D amdgpu_user_pixenc_list[i].=
type;</div><div>+<span>=09=09=09=09</span>found =3D true;</div><div>+<span>=
=09=09=09</span>}</div><div>+<span>=09=09</span>}</div><div>+<span>=09</spa=
n>}</div><div>+<span>=09</span>return found;</div><div>+}</div><div>+</div>=
<div>&nbsp;int amdgpu_display_modeset_create_props(struct amdgpu_device *ad=
ev)</div><div>&nbsp;{</div><div>&nbsp;<span>=09</span>int sz;</div><div>@@ =
-1408,6 +1435,14 @@ int amdgpu_display_modeset_create_props(struct amdgpu_d=
evice *adev)</div><div>&nbsp;<span>=09=09=09=09=09</span> "dither",</div><d=
iv>&nbsp;<span>=09=09=09=09=09</span> amdgpu_dither_enum_list, sz);</div><d=
iv>&nbsp;</div><div>+<span>=09</span>sz =3D ARRAY_SIZE(amdgpu_user_pixenc_l=
ist);</div><div>+<span>=09</span>adev-&gt;mode_info.pixel_encoding_property=
 =3D</div><div>+<span>=09=09</span>drm_property_create_enum(adev_to_drm(ade=
v), 0,</div><div>+<span>=09=09=09</span>"pixel encoding",</div><div>+<span>=
=09=09=09</span>amdgpu_user_pixenc_list, sz);</div><div>+<span>=09</span>if=
 (!adev-&gt;mode_info.pixel_encoding_property)</div><div>+<span>=09=09</spa=
n>return -ENOMEM;</div><div>+</div><div>&nbsp;<span>=09</span>return 0;</di=
v><div>&nbsp;}</div><div>&nbsp;</div><div>diff --git a/drivers/gpu/drm/amd/=
amdgpu/amdgpu_display.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.h</div>=
<div>index 9d19940f73c8..ee1ad49fa123 100644</div><div>--- a/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_display.h</div><div>+++ b/drivers/gpu/drm/amd/amdgpu/am=
dgpu_display.h</div><div>@@ -49,4 +49,7 @@ amdgpu_lookup_format_info(u32 fo=
rmat, uint64_t modifier);</div><div>&nbsp;int amdgpu_display_suspend_helper=
(struct amdgpu_device *adev);</div><div>&nbsp;int amdgpu_display_resume_hel=
per(struct amdgpu_device *adev);</div><div>&nbsp;</div><div>+bool amdgpu_us=
er_pixenc_from_name(unsigned int *user_pixenc,</div><div>+<span>=09=09=09=
=09</span>&nbsp; const char *pixenc_name);</div><div>+</div><div>&nbsp;#end=
if</div><div>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h b/driver=
s/gpu/drm/amd/amdgpu/amdgpu_mode.h</div><div>index 5e3faefc5510..b984e66a5d=
75 100644</div><div>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h</div><di=
v>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h</div><div>@@ -326,6 +326,8=
 @@ struct amdgpu_mode_info {</div><div>&nbsp;<span>=09</span>struct drm_pr=
operty *audio_property;</div><div>&nbsp;<span>=09</span>/* FMT dithering */=
</div><div>&nbsp;<span>=09</span>struct drm_property *dither_property;</div=
><div>+<span>=09</span>/* User HDMI pixel encoding override */</div><div>+<=
span>=09</span>struct drm_property *pixel_encoding_property;</div><div>&nbs=
p;<span>=09</span>/* hardcoded DFP edid from BIOS */</div><div>&nbsp;<span>=
=09</span>const struct drm_edid *bios_hardcoded_edid;</div><div>&nbsp;</div=
><div>diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/driv=
ers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c</div><div>index bbfc47f6595f.=
.2c03e0733178 100644</div><div>--- a/drivers/gpu/drm/amd/display/amdgpu_dm/=
amdgpu_dm.c</div><div>+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm=
.c</div><div>@@ -6069,6 +6069,115 @@ static bool adjust_colour_depth_from_d=
isplay_info(</div><div>&nbsp;<span>=09</span>return false;</div><div>&nbsp;=
}</div><div>&nbsp;</div><div>+/* convert an pixel encoding property value t=
o a dc_pixel_encoding */</div><div>+static bool drm_prop_to_dc_pixel_encodi=
ng(</div><div>+<span>=09</span>enum dc_pixel_encoding *dc_pixenc,</div><div=
>+<span>=09</span>unsigned int propval)</div><div>+{</div><div>+<span>=09</=
span>bool ret =3D false;</div><div>+</div><div>+<span>=09</span>switch (pro=
pval) {</div><div>+<span>=09</span>case 0:</div><div>+<span>=09=09</span>*d=
c_pixenc =3D PIXEL_ENCODING_UNDEFINED;</div><div>+<span>=09=09</span>ret =
=3D true;</div><div>+<span>=09=09</span>break;</div><div>+<span>=09</span>c=
ase DRM_COLOR_FORMAT_RGB444:</div><div>+<span>=09=09</span>*dc_pixenc =3D P=
IXEL_ENCODING_RGB;</div><div>+<span>=09=09</span>ret =3D true;</div><div>+<=
span>=09=09</span>break;</div><div>+<span>=09</span>case DRM_COLOR_FORMAT_Y=
CBCR444:</div><div>+<span>=09=09</span>*dc_pixenc =3D PIXEL_ENCODING_YCBCR4=
44;</div><div>+<span>=09=09</span>ret =3D true;</div><div>+<span>=09=09</sp=
an>break;</div><div>+<span>=09</span>case DRM_COLOR_FORMAT_YCBCR420:</div><=
div>+<span>=09=09</span>*dc_pixenc =3D PIXEL_ENCODING_YCBCR420;</div><div>+=
<span>=09=09</span>ret =3D true;</div><div>+<span>=09=09</span>break;</div>=
<div>+<span>=09</span>default:</div><div>+<span>=09=09</span>break;</div><d=
iv>+<span>=09</span>}</div><div>+<span>=09</span>return ret;</div><div>+}</=
div><div>+</div><div>+/* convert an dc_pixel_encoding to a pixel encoding p=
roperty value */</div><div>+static unsigned int dc_pixel_encoding_to_drm_pr=
op(</div><div>+<span>=09</span>enum dc_pixel_encoding pixel_encoding)</div>=
<div>+{</div><div>+<span>=09</span>unsigned int propval =3D 0;</div><div>+<=
/div><div>+<span>=09</span>switch (pixel_encoding) {</div><div>+<span>=09</=
span>case PIXEL_ENCODING_RGB:</div><div>+<span>=09=09</span>propval =3D DRM=
_COLOR_FORMAT_RGB444;</div><div>+<span>=09=09</span>break;</div><div>+<span=
>=09</span>case PIXEL_ENCODING_YCBCR444:</div><div>+<span>=09=09</span>prop=
val =3D DRM_COLOR_FORMAT_YCBCR444;</div><div>+<span>=09=09</span>break;</di=
v><div>+<span>=09</span>case PIXEL_ENCODING_YCBCR420:</div><div>+<span>=09=
=09</span>propval =3D DRM_COLOR_FORMAT_YCBCR420;</div><div>+<span>=09=09</s=
pan>break;</div><div>+<span>=09</span>default:</div><div>+<span>=09=09</spa=
n>break;</div><div>+<span>=09</span>}</div><div>+<span>=09</span>return pro=
pval;</div><div>+}</div><div>+</div><div>+/*</div><div>+ * Tries to read 'p=
ixel_encoding' from the pixel_encoding DRM property on</div><div>+ * 'state=
'. Returns true if a supported, acceptable, non-undefined value is</div><di=
v>+ * found; false otherwise. Only modifies 'pixel_encoding' if returning t=
rue.</div><div>+ */</div><div>+bool get_connector_state_pixel_encoding(</di=
v><div>+<span>=09</span>enum dc_pixel_encoding *pixel_encoding,</div><div>+=
<span>=09</span>const struct drm_connector_state *state,</div><div>+<span>=
=09</span>const struct drm_display_info *info,</div><div>+<span>=09</span>c=
onst struct drm_display_mode *mode_in)</div><div>+{</div><div>+<span>=09</s=
pan>bool ret =3D false;</div><div>+<span>=09</span>struct dm_connector_stat=
e *dm_state;</div><div>+</div><div>+<span>=09</span>dm_state =3D to_dm_conn=
ector_state(state);</div><div>+<span>=09</span>if (!dm_state)</div><div>+<s=
pan>=09=09</span>return false;</div><div>+</div><div>+<span>=09</span>/* ch=
eck encoding is supported */</div><div>+<span>=09</span>switch (dm_state-&g=
t;pixel_encoding) {</div><div>+<span>=09</span>case PIXEL_ENCODING_RGB:</di=
v><div>+<span>=09=09</span>ret =3D (info-&gt;color_formats &amp; DRM_COLOR_=
FORMAT_RGB444);</div><div>+<span>=09=09</span>break;</div><div>+<span>=09</=
span>case PIXEL_ENCODING_YCBCR444:</div><div>+<span>=09=09</span>ret =3D (i=
nfo-&gt;color_formats &amp; DRM_COLOR_FORMAT_YCBCR444);</div><div>+<span>=
=09=09</span>break;</div><div>+<span>=09</span>case PIXEL_ENCODING_YCBCR420=
:</div><div>+<span>=09=09</span>ret =3D drm_mode_is_420(info, mode_in);</di=
v><div>+<span>=09=09</span>break;</div><div>+<span>=09</span>default:</div>=
<div>+<span>=09=09</span>break;</div><div>+<span>=09</span>}</div><div>+</d=
iv><div>+<span>=09</span>if (ret)</div><div>+<span>=09=09</span>*pixel_enco=
ding =3D dm_state-&gt;pixel_encoding;</div><div>+</div><div>+<span>=09</spa=
n>return ret;</div><div>+}</div><div>+</div><div>+/*</div><div>+ * Writes '=
pixel_encoding' to the pixel_encoding DRM property on 'state', if</div><div=
>+ * the enum value is valid and supported; otherwise writes</div><div>+ * =
PIXEL_ENCODING_UNDEFINED which corresponds to the "auto" property state.</d=
iv><div>+ */</div><div>+void set_connector_state_pixel_encoding(</div><div>=
+<span>=09</span>const struct drm_connector_state *state,</div><div>+<span>=
=09</span>enum dc_pixel_encoding pixel_encoding)</div><div>+{</div><div>+<s=
pan>=09</span>struct dm_connector_state *dm_state;</div><div>+</div><div>+<=
span>=09</span>dm_state =3D to_dm_connector_state(state);</div><div>+<span>=
=09</span>if (!dm_state)</div><div>+<span>=09=09</span>return;</div><div>+<=
/div><div>+<span>=09</span>dm_state-&gt;pixel_encoding =3D pixel_encoding;<=
/div><div>+}</div><div>+</div><div>&nbsp;static void fill_stream_properties=
_from_drm_display_mode(</div><div>&nbsp;<span>=09</span>struct dc_stream_st=
ate *stream,</div><div>&nbsp;<span>=09</span>const struct drm_display_mode =
*mode_in,</div><div>@@ -6093,19 +6202,23 @@ static void fill_stream_propert=
ies_from_drm_display_mode(</div><div>&nbsp;<span>=09</span>timing_out-&gt;h=
_border_right =3D 0;</div><div>&nbsp;<span>=09</span>timing_out-&gt;v_borde=
r_top =3D 0;</div><div>&nbsp;<span>=09</span>timing_out-&gt;v_border_bottom=
 =3D 0;</div><div>-<span>=09</span>/* TODO: un-hardcode */</div><div>-<span=
>=09</span>if (drm_mode_is_420_only(info, mode_in)</div><div>+</div><div>+<=
span>=09</span>if (!get_connector_state_pixel_encoding(&amp;timing_out-&gt;=
pixel_encoding,</div><div>+<span>=09=09</span>connector_state, info, mode_i=
n)) {</div><div>+<span>=09=09</span>/* auto-select a pixel encoding */</div=
><div>+<span>=09=09</span>if (drm_mode_is_420_only(info, mode_in)</div><div=
>&nbsp;<span>=09=09=09</span>&amp;&amp; stream-&gt;signal =3D=3D SIGNAL_TYP=
E_HDMI_TYPE_A)</div><div>-<span>=09=09</span>timing_out-&gt;pixel_encoding =
=3D PIXEL_ENCODING_YCBCR420;</div><div>-<span>=09</span>else if (drm_mode_i=
s_420_also(info, mode_in)</div><div>+<span>=09=09=09</span>timing_out-&gt;p=
ixel_encoding =3D PIXEL_ENCODING_YCBCR420;</div><div>+<span>=09=09</span>el=
se if (drm_mode_is_420_also(info, mode_in)</div><div>&nbsp;<span>=09=09=09<=
/span>&amp;&amp; aconnector</div><div>&nbsp;<span>=09=09=09</span>&amp;&amp=
; aconnector-&gt;force_yuv420_output)</div><div>-<span>=09=09</span>timing_=
out-&gt;pixel_encoding =3D PIXEL_ENCODING_YCBCR420;</div><div>-<span>=09</s=
pan>else if ((connector-&gt;display_info.color_formats &amp; DRM_COLOR_FORM=
AT_YCBCR444)</div><div>-<span>=09=09=09</span>&amp;&amp; stream-&gt;signal =
=3D=3D SIGNAL_TYPE_HDMI_TYPE_A)</div><div>-<span>=09=09</span>timing_out-&g=
t;pixel_encoding =3D PIXEL_ENCODING_YCBCR444;</div><div>-<span>=09</span>el=
se</div><div>-<span>=09=09</span>timing_out-&gt;pixel_encoding =3D PIXEL_EN=
CODING_RGB;</div><div>+<span>=09=09=09</span>timing_out-&gt;pixel_encoding =
=3D PIXEL_ENCODING_YCBCR420;</div><div>+<span>=09=09</span>else if ((connec=
tor-&gt;display_info.color_formats &amp; DRM_COLOR_FORMAT_YCBCR444)</div><d=
iv>+<span>=09=09=09=09</span>&amp;&amp; stream-&gt;signal =3D=3D SIGNAL_TYP=
E_HDMI_TYPE_A)</div><div>+<span>=09=09=09</span>timing_out-&gt;pixel_encodi=
ng =3D PIXEL_ENCODING_YCBCR444;</div><div>+<span>=09=09</span>else</div><di=
v>+<span>=09=09=09</span>timing_out-&gt;pixel_encoding =3D PIXEL_ENCODING_R=
GB;</div><div>+<span>=09</span>}</div><div>&nbsp;</div><div>&nbsp;<span>=09=
</span>timing_out-&gt;timing_3d_format =3D TIMING_3D_FORMAT_NONE;</div><div=
>&nbsp;<span>=09</span>timing_out-&gt;display_color_depth =3D convert_color=
_depth_from_display_info(</div><div>@@ -6169,6 +6282,9 @@ static void fill_=
stream_properties_from_drm_display_mode(</div><div>&nbsp;<span>=09=09</span=
>}</div><div>&nbsp;<span>=09</span>}</div><div>&nbsp;</div><div>+<span>=09<=
/span>/* write back final choice of pixel encoding */</div><div>+<span>=09<=
/span>set_connector_state_pixel_encoding(connector_state, timing_out-&gt;pi=
xel_encoding);</div><div>+</div><div>&nbsp;<span>=09</span>stream-&gt;outpu=
t_color_space =3D get_output_color_space(timing_out, connector_state);</div=
><div>&nbsp;<span>=09</span>stream-&gt;content_type =3D get_output_content_=
type(connector_state);</div><div>&nbsp;}</div><div>@@ -6875,6 +6991,9 @@ in=
t amdgpu_dm_connector_atomic_set_property(struct drm_connector *connector,<=
/div><div>&nbsp;<span>=09</span>} else if (property =3D=3D adev-&gt;mode_in=
fo.underscan_property) {</div><div>&nbsp;<span>=09=09</span>dm_new_state-&g=
t;underscan_enable =3D val;</div><div>&nbsp;<span>=09=09</span>ret =3D 0;</=
div><div>+<span>=09</span>} else if (property =3D=3D adev-&gt;mode_info.pix=
el_encoding_property) {</div><div>+<span>=09=09</span>if (drm_prop_to_dc_pi=
xel_encoding(&amp;dm_new_state-&gt;pixel_encoding, val))</div><div>+<span>=
=09=09=09</span>ret =3D 0;</div><div>&nbsp;<span>=09</span>}</div><div>&nbs=
p;</div><div>&nbsp;<span>=09</span>return ret;</div><div>@@ -6917,6 +7036,9=
 @@ int amdgpu_dm_connector_atomic_get_property(struct drm_connector *conne=
ctor,</div><div>&nbsp;<span>=09</span>} else if (property =3D=3D adev-&gt;m=
ode_info.underscan_property) {</div><div>&nbsp;<span>=09=09</span>*val =3D =
dm_state-&gt;underscan_enable;</div><div>&nbsp;<span>=09=09</span>ret =3D 0=
;</div><div>+<span>=09</span>} else if (property =3D=3D adev-&gt;mode_info.=
pixel_encoding_property) {</div><div>+<span>=09=09</span>*val =3D dc_pixel_=
encoding_to_drm_prop(dm_state-&gt;pixel_encoding);</div><div>+<span>=09=09<=
/span>ret =3D 0;</div><div>&nbsp;<span>=09</span>}</div><div>&nbsp;</div><d=
iv>&nbsp;<span>=09</span>return ret;</div><div>@@ -7088,6 +7210,20 @@ void =
amdgpu_dm_connector_funcs_reset(struct drm_connector *connector)</div><div>=
&nbsp;<span>=09=09=09=09</span>state-&gt;abm_level =3D amdgpu_dm_abm_level;=
</div><div>&nbsp;<span>=09=09</span>}</div><div>&nbsp;</div><div>+<span>=09=
=09</span>switch (connector-&gt;cmdline_mode.pixel_encoding) {</div><div>+<=
span>=09=09</span>case DRM_COLOR_FORMAT_RGB444:</div><div>+<span>=09=09=09<=
/span>state-&gt;pixel_encoding =3D PIXEL_ENCODING_RGB;</div><div>+<span>=09=
=09=09</span>break;</div><div>+<span>=09=09</span>case DRM_COLOR_FORMAT_YCB=
CR444:</div><div>+<span>=09=09=09</span>state-&gt;pixel_encoding =3D PIXEL_=
ENCODING_YCBCR444;</div><div>+<span>=09=09=09</span>break;</div><div>+<span=
>=09=09</span>case DRM_COLOR_FORMAT_YCBCR420:</div><div>+<span>=09=09=09</s=
pan>state-&gt;pixel_encoding =3D PIXEL_ENCODING_YCBCR420;</div><div>+<span>=
=09=09=09</span>break;</div><div>+<span>=09=09</span>default:</div><div>+<s=
pan>=09=09=09</span>break;</div><div>+<span>=09=09</span>}</div><div>+</div=
><div>&nbsp;<span>=09=09</span>__drm_atomic_helper_connector_reset(connecto=
r, &amp;state-&gt;base);</div><div>&nbsp;<span>=09</span>}</div><div>&nbsp;=
}</div><div>@@ -7114,6 +7250,7 @@ amdgpu_dm_connector_atomic_duplicate_stat=
e(struct drm_connector *connector)</div><div>&nbsp;<span>=09</span>new_stat=
e-&gt;underscan_vborder =3D state-&gt;underscan_vborder;</div><div>&nbsp;<s=
pan>=09</span>new_state-&gt;vcpi_slots =3D state-&gt;vcpi_slots;</div><div>=
&nbsp;<span>=09</span>new_state-&gt;pbn =3D state-&gt;pbn;</div><div>+<span=
>=09</span>new_state-&gt;pixel_encoding =3D state-&gt;pixel_encoding;</div>=
<div>&nbsp;<span>=09</span>return &amp;new_state-&gt;base;</div><div>&nbsp;=
}</div><div>&nbsp;</div><div>@@ -8175,6 +8312,12 @@ void amdgpu_dm_connecto=
r_init_helper(struct amdgpu_display_manager *dm,</div><div>&nbsp;</div><div=
>&nbsp;<span>=09=09</span>if (adev-&gt;dm.hdcp_workqueue)</div><div>&nbsp;<=
span>=09=09=09</span>drm_connector_attach_content_protection_property(&amp;=
aconnector-&gt;base, true);</div><div>+</div><div>+<span>=09=09</span>if (a=
dev-&gt;mode_info.pixel_encoding_property) {</div><div>+<span>=09=09=09</sp=
an>drm_object_attach_property(&amp;aconnector-&gt;base.base,</div><div>+<sp=
an>=09=09=09=09</span>adev-&gt;mode_info.pixel_encoding_property, 0);</div>=
<div>+<span>=09=09=09</span>DRM_DEBUG_DRIVER("amdgpu: attached pixel encodi=
ng drm property");</div><div>+<span>=09=09</span>}</div><div>&nbsp;<span>=
=09</span>}</div><div>&nbsp;}</div><div>&nbsp;</div><div>@@ -9377,6 +9520,3=
8 @@ static void amdgpu_dm_commit_audio(struct drm_device *dev,</div><div>&=
nbsp;<span>=09</span>}</div><div>&nbsp;}</div><div>&nbsp;</div><div>+static=
 void update_stream_for_pixel_encoding(</div><div>+<span>=09</span>struct d=
c_stream_update *stream_update,</div><div>+<span>=09</span>struct drm_conne=
ctor *connector,</div><div>+<span>=09</span>struct dm_crtc_state *dm_old_cr=
tc_state,</div><div>+<span>=09</span>struct dm_crtc_state *dm_new_crtc_stat=
e,</div><div>+<span>=09</span>struct dm_connector_state *dm_new_con_state)<=
/div><div>+{</div><div>+<span>=09</span>struct amdgpu_dm_connector *aconnec=
tor =3D</div><div>+<span>=09=09</span>to_amdgpu_dm_connector(connector);</d=
iv><div>+<span>=09</span>struct dc_stream_state *new_stream =3D NULL;</div>=
<div>+</div><div>+<span>=09</span>if (aconnector)</div><div>+<span>=09=09</=
span>new_stream =3D create_validate_stream_for_sink(</div><div>+<span>=09=
=09=09</span>aconnector,</div><div>+<span>=09=09=09</span>&amp;dm_new_crtc_=
state-&gt;base.mode,</div><div>+<span>=09=09=09</span>dm_new_con_state,</di=
v><div>+<span>=09=09=09</span>dm_old_crtc_state-&gt;stream);</div><div>+<sp=
an>=09</span>if (new_stream) {</div><div>+<span>=09=09</span>dm_new_crtc_st=
ate-&gt;stream-&gt;timing =3D</div><div>+<span>=09=09=09</span>new_stream-&=
gt;timing;</div><div>+<span>=09=09</span>stream_update-&gt;timing_for_pixel=
_encoding =3D</div><div>+<span>=09=09=09</span>&amp;dm_new_crtc_state-&gt;s=
tream-&gt;timing;</div><div>+</div><div>+<span>=09=09</span>dm_new_crtc_sta=
te-&gt;stream-&gt;output_color_space =3D</div><div>+<span>=09=09=09</span>n=
ew_stream-&gt;output_color_space;</div><div>+<span>=09=09</span>stream_upda=
te-&gt;output_color_space =3D</div><div>+<span>=09=09=09</span>&amp;dm_new_=
crtc_state-&gt;stream-&gt;output_color_space;</div><div>+</div><div>+<span>=
=09=09</span>dc_stream_release(new_stream);</div><div>+<span>=09</span>}</d=
iv><div>+}</div><div>+</div><div>&nbsp;/*</div><div>&nbsp; * amdgpu_dm_crtc=
_copy_transient_flags - copy mirrored flags from DRM to DC</div><div>&nbsp;=
 * @crtc_state: the DRM CRTC state</div><div>@@ -9850,7 +10025,7 @@ static =
void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)</div><div=
>&nbsp;<span>=09=09</span>struct dc_stream_update stream_update;</div><div>=
&nbsp;<span>=09=09</span>struct dc_info_packet hdr_packet;</div><div>&nbsp;=
<span>=09=09</span>struct dc_stream_status *status =3D NULL;</div><div>-<sp=
an>=09=09</span>bool abm_changed, hdr_changed, scaling_changed;</div><div>+=
<span>=09=09</span>bool abm_changed, hdr_changed, scaling_changed, pixenc_c=
hanged;</div><div>&nbsp;</div><div>&nbsp;<span>=09=09</span>memset(&amp;str=
eam_update, 0, sizeof(stream_update));</div><div>&nbsp;</div><div>@@ -9875,=
7 +10050,10 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_s=
tate *state)</div><div>&nbsp;<span>=09=09</span>hdr_changed =3D</div><div>&=
nbsp;<span>=09=09=09</span>!drm_connector_atomic_hdr_metadata_equal(old_con=
_state, new_con_state);</div><div>&nbsp;</div><div>-<span>=09=09</span>if (=
!scaling_changed &amp;&amp; !abm_changed &amp;&amp; !hdr_changed)</div><div=
>+<span>=09=09</span>pixenc_changed =3D dm_new_con_state-&gt;pixel_encoding=
 !=3D</div><div>+<span>=09=09=09=09</span> dm_old_con_state-&gt;pixel_encod=
ing;</div><div>+</div><div>+<span>=09=09</span>if (!scaling_changed &amp;&a=
mp; !abm_changed &amp;&amp; !hdr_changed &amp;&amp; !pixenc_changed)</div><=
div>&nbsp;<span>=09=09=09</span>continue;</div><div>&nbsp;</div><div>&nbsp;=
<span>=09=09</span>stream_update.stream =3D dm_new_crtc_state-&gt;stream;</=
div><div>@@ -9898,6 +10076,13 @@ static void amdgpu_dm_atomic_commit_tail(s=
truct drm_atomic_state *state)</div><div>&nbsp;<span>=09=09=09</span>stream=
_update.hdr_static_metadata =3D &amp;hdr_packet;</div><div>&nbsp;<span>=09=
=09</span>}</div><div>&nbsp;</div><div>+<span>=09=09</span>if (pixenc_chang=
ed) {</div><div>+<span>=09=09=09</span>update_stream_for_pixel_encoding(&am=
p;stream_update,</div><div>+<span>=09=09=09=09</span>connector,</div><div>+=
<span>=09=09=09=09</span>dm_old_crtc_state, dm_new_crtc_state,</div><div>+<=
span>=09=09=09=09</span>dm_new_con_state);</div><div>+<span>=09=09</span>}<=
/div><div>+</div><div>&nbsp;<span>=09=09</span>status =3D dc_stream_get_sta=
tus(dm_new_crtc_state-&gt;stream);</div><div>&nbsp;</div><div>&nbsp;<span>=
=09=09</span>if (WARN_ON(!status))</div><div>@@ -11403,6 +11588,12 @@ stati=
c int amdgpu_dm_atomic_check(struct drm_device *dev,</div><div>&nbsp;<span>=
=09=09</span>if (dm_old_con_state-&gt;abm_level !=3D dm_new_con_state-&gt;a=
bm_level ||</div><div>&nbsp;<span>=09=09</span>&nbsp; &nbsp; dm_old_con_sta=
te-&gt;scaling !=3D dm_new_con_state-&gt;scaling)</div><div>&nbsp;<span>=09=
=09=09</span>new_crtc_state-&gt;connectors_changed =3D true;</div><div>+</d=
iv><div>+<span>=09=09</span>if (dm_old_con_state-&gt;pixel_encoding !=3D</d=
iv><div>+<span>=09=09</span>&nbsp; &nbsp; dm_new_con_state-&gt;pixel_encodi=
ng) {</div><div>+<span>=09=09=09</span>new_crtc_state-&gt;connectors_change=
d =3D true;</div><div>+<span>=09=09=09</span>new_crtc_state-&gt;mode_change=
d =3D true;</div><div>+<span>=09=09</span>}</div><div>&nbsp;<span>=09</span=
>}</div><div>&nbsp;</div><div>&nbsp;<span>=09</span>if (dc_resource_is_dsc_=
encoding_supported(dc)) {</div><div>diff --git a/drivers/gpu/drm/amd/displa=
y/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h=
</div><div>index 25e95775c45c..132944272c18 100644</div><div>--- a/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h</div><div>+++ b/drivers/gpu/drm/a=
md/display/amdgpu_dm/amdgpu_dm.h</div><div>@@ -918,6 +918,7 @@ struct dm_co=
nnector_state {</div><div>&nbsp;<span>=09</span>uint8_t abm_level;</div><di=
v>&nbsp;<span>=09</span>int vcpi_slots;</div><div>&nbsp;<span>=09</span>uin=
t64_t pbn;</div><div>+<span>=09</span>enum dc_pixel_encoding pixel_encoding=
;</div><div>&nbsp;};</div><div>&nbsp;</div><div>&nbsp;#define to_dm_connect=
or_state(x)\</div><div>diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.=
c b/drivers/gpu/drm/amd/display/dc/core/dc.c</div><div>index 5a12fc75f97f..=
4ac004536707 100644</div><div>--- a/drivers/gpu/drm/amd/display/dc/core/dc.=
c</div><div>+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c</div><div>@@ -27=
65,6 +2765,11 @@ static enum surface_update_type check_update_surfaces_for_=
stream(</div><div>&nbsp;<span>=09=09</span>if (stream_update-&gt;output_csc=
_transform || stream_update-&gt;output_color_space)</div><div>&nbsp;<span>=
=09=09=09</span>su_flags-&gt;bits.out_csc =3D 1;</div><div>&nbsp;</div><div=
>+<span>=09=09</span>if (stream_update-&gt;timing_for_pixel_encoding) {</di=
v><div>+<span>=09=09=09</span>su_flags-&gt;bits.pixel_encoding =3D 1;</div>=
<div>+<span>=09=09=09</span>elevate_update_type(&amp;overall_type, UPDATE_T=
YPE_FULL);</div><div>+<span>=09=09</span>}</div><div>+</div><div>&nbsp;<spa=
n>=09=09</span>/* Output transfer function changes do not require bandwidth=
 recalculation,</div><div>&nbsp;<span>=09=09</span> * so don't trigger a fu=
ll update</div><div>&nbsp;<span>=09=09</span> */</div><div>@@ -3112,6 +3117=
,8 @@ static void copy_stream_update_to_stream(struct dc *dc,</div><div>&nb=
sp;<span>=09=09</span>stream-&gt;scaler_sharpener_update =3D *update-&gt;sc=
aler_sharpener_update;</div><div>&nbsp;<span>=09</span>if (update-&gt;sharp=
ening_required)</div><div>&nbsp;<span>=09=09</span>stream-&gt;sharpening_re=
quired =3D *update-&gt;sharpening_required;</div><div>+<span>=09</span>if (=
update-&gt;timing_for_pixel_encoding)</div><div>+<span>=09=09</span>stream-=
&gt;timing =3D *update-&gt;timing_for_pixel_encoding;</div><div>&nbsp;}</di=
v><div>&nbsp;</div><div>&nbsp;static void backup_planes_and_stream_state(</=
div><div>@@ -3361,6 +3368,7 @@ static void commit_planes_do_stream_update(s=
truct dc *dc,</div><div>&nbsp;<span>=09=09=09=09=09</span>stream_update-&gt=
;vsc_infopacket ||</div><div>&nbsp;<span>=09=09=09=09=09</span>stream_updat=
e-&gt;vsp_infopacket ||</div><div>&nbsp;<span>=09=09=09=09=09</span>stream_=
update-&gt;hfvsif_infopacket ||</div><div>+<span>=09=09=09=09=09</span>stre=
am_update-&gt;timing_for_pixel_encoding ||</div><div>&nbsp;<span>=09=09=09=
=09=09</span>stream_update-&gt;adaptive_sync_infopacket ||</div><div>&nbsp;=
<span>=09=09=09=09=09</span>stream_update-&gt;vtem_infopacket) {</div><div>=
&nbsp;<span>=09=09=09=09</span>resource_build_info_frame(pipe_ctx);</div><d=
iv>diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/dr=
m/amd/display/dc/dc_stream.h</div><div>index 413970588a26..de7f02f330d8 100=
644</div><div>--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h</div><div>++=
+ b/drivers/gpu/drm/amd/display/dc/dc_stream.h</div><div>@@ -144,6 +144,7 @=
@ union stream_update_flags {</div><div>&nbsp;<span>=09=09</span>uint32_t f=
ams_changed : 1;</div><div>&nbsp;<span>=09=09</span>uint32_t scaler_sharpen=
er : 1;</div><div>&nbsp;<span>=09=09</span>uint32_t sharpening_required : 1=
;</div><div>+<span>=09=09</span>uint32_t pixel_encoding:1;</div><div>&nbsp;=
<span>=09</span>} bits;</div><div>&nbsp;</div><div>&nbsp;<span>=09</span>ui=
nt32_t raw;</div><div>@@ -350,6 +351,7 @@ struct dc_stream_update {</div><d=
iv>&nbsp;<span>=09</span>struct dc_mst_stream_bw_update *mst_bw_update;</di=
v><div>&nbsp;<span>=09</span>struct dc_transfer_func *func_shaper;</div><di=
v>&nbsp;<span>=09</span>struct dc_3dlut *lut3d_func;</div><div>+<span>=09</=
span>struct dc_crtc_timing *timing_for_pixel_encoding;</div><div>&nbsp;</di=
v><div>&nbsp;<span>=09</span>struct test_pattern *pending_test_pattern;</di=
v><div>&nbsp;<span>=09</span>struct dc_crtc_timing_adjust *crtc_timing_adju=
st;</div><div>diff --git a/drivers/gpu/drm/drm_modes.c b/drivers/gpu/drm/dr=
m_modes.c</div><div>index 1a0890083aee..b5ce8f93b672 100644</div><div>--- a=
/drivers/gpu/drm/drm_modes.c</div><div>+++ b/drivers/gpu/drm/drm_modes.c</d=
iv><div>@@ -2161,6 +2161,32 @@ static int drm_mode_parse_tv_mode(const char=
 *delim,</div><div>&nbsp;<span>=09</span>return 0;</div><div>&nbsp;}</div><=
div>&nbsp;</div><div>+static int drm_mode_parse_pixel_encoding(const char *=
delim,</div><div>+<span>=09=09=09=09=09</span> struct drm_cmdline_mode *mod=
e)</div><div>+{</div><div>+<span>=09</span>const char *value;</div><div>+</=
div><div>+<span>=09</span>if (*delim !=3D '=3D')</div><div>+<span>=09=09</s=
pan>return -EINVAL;</div><div>+</div><div>+<span>=09</span>value =3D delim =
+ 1;</div><div>+<span>=09</span>delim =3D strchr(value, ',');</div><div>+<s=
pan>=09</span>if (!delim)</div><div>+<span>=09=09</span>delim =3D value + s=
trlen(value);</div><div>+</div><div>+<span>=09</span>if (!strncmp(value, "a=
uto", delim - value))</div><div>+<span>=09=09</span>mode-&gt;pixel_encoding=
 =3D 0;</div><div>+<span>=09</span>else if (!strncmp(value, "rgb", delim - =
value))</div><div>+<span>=09=09</span>mode-&gt;pixel_encoding =3D DRM_COLOR=
_FORMAT_RGB444;</div><div>+<span>=09</span>else if (!strncmp(value, "ycbcr4=
44", delim - value))</div><div>+<span>=09=09</span>mode-&gt;pixel_encoding =
=3D DRM_COLOR_FORMAT_YCBCR444;</div><div>+<span>=09</span>else if (!strncmp=
(value, "ycbcr420", delim - value))</div><div>+<span>=09=09</span>mode-&gt;=
pixel_encoding =3D DRM_COLOR_FORMAT_YCBCR420;</div><div>+<span>=09</span>el=
se</div><div>+<span>=09=09</span>return -EINVAL;</div><div>+</div><div>+<sp=
an>=09</span>return 0;</div><div>+}</div><div>&nbsp;static int drm_mode_par=
se_cmdline_options(const char *str,</div><div>&nbsp;<span>=09=09=09=09=09</=
span>&nbsp; bool freestanding,</div><div>&nbsp;<span>=09=09=09=09=09</span>=
&nbsp; const struct drm_connector *connector,</div><div>@@ -2233,6 +2259,9 =
@@ static int drm_mode_parse_cmdline_options(const char *str,</div><div>&nb=
sp;<span>=09=09</span>} else if (!strncmp(option, "tv_mode", delim - option=
)) {</div><div>&nbsp;<span>=09=09=09</span>if (drm_mode_parse_tv_mode(delim=
, mode))</div><div>&nbsp;<span>=09=09=09=09</span>return -EINVAL;</div><div=
>+<span>=09=09</span>} else if (!strncmp(option, "pixel_encoding", delim - =
option)) {</div><div>+<span>=09=09=09</span>if (drm_mode_parse_pixel_encodi=
ng(delim, mode))</div><div>+<span>=09=09=09=09</span>return -EINVAL;</div><=
div>&nbsp;<span>=09=09</span>} else {</div><div>&nbsp;<span>=09=09=09</span=
>return -EINVAL;</div><div>&nbsp;<span>=09=09</span>}</div><div>diff --git =
a/include/drm/drm_connector.h b/include/drm/drm_connector.h</div><div>index=
 c754651044d4..89c0f42873df 100644</div><div>--- a/include/drm/drm_connecto=
r.h</div><div>+++ b/include/drm/drm_connector.h</div><div>@@ -1666,6 +1666,=
13 @@ struct drm_cmdline_mode {</div><div>&nbsp;<span>=09</span> * Did the =
mode have a preferred TV mode?</div><div>&nbsp;<span>=09</span> */</div><di=
v>&nbsp;<span>=09</span>bool tv_mode_specified;</div><div>+</div><div>+<spa=
n>=09</span>/**</div><div>+<span>=09</span> * @pixel_encoding:</div><div>+<=
span>=09</span> *</div><div>+<span>=09</span> * Initial pixel encoding.</di=
v><div>+<span>=09</span> */</div><div>+<span>=09</span>unsigned int pixel_e=
ncoding;</div><div>&nbsp;};</div><div>&nbsp;</div><div>&nbsp;/*</div><div>-=
-&nbsp;</div><div>2.43.0</div></div></body></html>
------=_Part_2155586_1914508055.1730128258912--
