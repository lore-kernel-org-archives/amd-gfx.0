Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98D5BCD5BB1
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2026 14:44:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13E9F10E685;
	Tue, 26 May 2026 14:44:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ie93BQcd";
	dkim-atps=neutral
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com
 [74.125.82.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07FA610E6B4
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2026 14:44:10 +0000 (UTC)
Received: by mail-dy1-f174.google.com with SMTP id
 5a478bee46e88-2f5ae07e2b5so878833eec.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2026 07:44:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779806649; cv=none;
 d=google.com; s=arc-20240605;
 b=MAfpHRPQ+skoI4BPJKF26LqdeVCf9f9grciQDhgFOpaS0i8BP+zhvxrprVaf2+IoTQ
 eAfLEWiMPZ/gk2w1GC+gzWqCgk3Q9i83qBbAAOVfZNqIowQ8BGJpj2YKLyBNyke1h/ke
 U45QS83HuQ+bvCx2nvXw6RGkwM59bDmUcOneSxhcsa1pEd0bKFVOEVSjvU6OgZuA3FCn
 A8hEu4mUpzndEiS6ur1odqCVMi8gVeNEbQe8yGGBCcaf/NX0JuaE2inKKHcM01uLr1qf
 ZbL2ZrU6KNSVxWZLHKmVJeS+iDRM+mEV8/bnvM6T4grlnQov+Dni/pNLrntqvEfT3ec1
 /KQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=onDrreUXj8UO+PdKcK84CFu/SdIlVa0bfR+p75TWDU8=;
 fh=Z8KoS9XFs5Oc1amUAun74POtOGZ8gF5xAaz27PMl4Kg=;
 b=Qp8megj10k42PU2SWWaImov5ddRtGbfyuS7grMnt5ZfgMGVPAdVFKUMX2L5qPVtwy8
 x2OILZELj6y19HnAgOT7DvWl96LN2v9NLzhV3557PAecy9nwzT1SQJpV/asg7EiIU3qe
 BSwbbRIvU5kJ4sM3CFAI0x2LFHKea0sqQ4KbNSI5ZCD1yWXVp5e/d9aijZBFOeApAF7n
 EhFkzcGyGYY25hA6pEbq05ekQAsPDZJjxQjtcMf7jI7ibmu3GbxQd6TTsOnps7+yZgHM
 ZAdGu8finomjk32P4vfDAoRdmGxZau8/i42UwIYMTrQi8gNy3u6/n60Y6ULjH0f+PeH8
 v+Zg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779806649; x=1780411449; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=onDrreUXj8UO+PdKcK84CFu/SdIlVa0bfR+p75TWDU8=;
 b=Ie93BQcds3HsNqVIiFHtAWbhdzoNt2HgN4/hg9o3n76IEsutt09d98nkfj6IgvE7CW
 Ft6tSCXgWqGBHGSVzrM6O9iRRFOWeplZ9mLVeG/+HfEa/iPpBPu8wzEhBYUrLvKQfkRv
 u0zYaZhtPC4+V+wg3u8oHZqRs34lDFyTpQdOuW9o/K30nHm8qz8LN+F9UzXTSEIfRyp4
 lhMYfx+PiJxaOuA3F7dWyaA7GFZ87Th5ae7LTZIFTXvc6z68Yrnz3db4RrCw/GE6b5+0
 MJzhAw6q5dwRDmr/g7z6gyoO6601LW9yUo3YHLamdcpx2XdsaR2X4r6icsE87w124RLO
 jxcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779806649; x=1780411449;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=onDrreUXj8UO+PdKcK84CFu/SdIlVa0bfR+p75TWDU8=;
 b=OD3h1C809HxPbzZ2yqRiDst8RwmmZTF1KV2HSXhIY/Sk9XpWciHSLhWOp7KczI0PWi
 vPj2JArEIESjUVSuD+uGV2hdXhIT0YR0zGr+Y7Gk9AW0IarMIusxjipZK+9j3/NAkm4e
 0w03W0YzjvxWn79VrbCbyRiNpfVrgqBtvFmtcckEIBPn4kwpCvdvSzm8sEonagtWDFM6
 lwPMZPFqeFCq1ISz9KQkyTZFsgdCEpZZI9/jK37pULjnbaCRcxzqaHr/v9sdHe0O3dLf
 q5amRp6dwbCBsUJiWSGLbYHrIUXqBfoMOlKbztKewlQLdufvKhIqDyqXMiysi1Q5Fp/Z
 BLkQ==
X-Gm-Message-State: AOJu0YxzQyXvepiR2fTO1QPb3GD51Rq+lYk5XgvPcW2LxsCd2jquzjo4
 Jtaf1c03lRCqA6u0VJ/kZqc9fycMvhlsuniXS5/h4QhkysLFszApEkgmycHsH4utN+Ykz5I4nnn
 rh7zRPnXCTXIGKvUMePsXqPlI2qZArqo=
X-Gm-Gg: Acq92OHMWUd6dOCHxcVH1PRmSD/cjyH3onf+ZL6X0vXb8gsQ5kvwN90+jUnbmjsip+B
 ntFcYlYtvBP27NWGkJFH0jbULfmN3T/Flq8LUzCX1BFzwlyNnBESac9ZXmJ7Cd92uj+lRLpSNQu
 dMqXrZH7A/VF7Sr7jDt88Fz67PXW72YTgNmlWtishFn7Xp5uSZygq0Vd2sDoJYX/0mTt00VKJyC
 0kqsi609pQB0iiHjUgMAEJlwVkAd/37M+VGNRjH5Bfv4Wiuvff1HSjWa9feoKxkChqf+4s+APQV
 Sye6R4td94szaScWW8NlH0Kievp3oVoR/Eewq43jr735DBKchh/BOp6EwIPPj1dM+Oy6ghmZ5xX
 i5lPF
X-Received: by 2002:a05:701b:2918:b0:136:b46c:31fb with SMTP id
 a92af1059eb24-136b46c3666mr918902c88.5.1779806649245; Tue, 26 May 2026
 07:44:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260523142748.50034-1-jpeisach@ubuntu.com>
 <20260523142748.50034-3-jpeisach@ubuntu.com>
In-Reply-To: <20260523142748.50034-3-jpeisach@ubuntu.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 26 May 2026 10:43:57 -0400
X-Gm-Features: AVHnY4Ic2QxJYCZjWu-ixtMOMOd8y0Sy8SHI4wjdkygVoGxyWm41zFJuuBDIHho
Message-ID: <CADnq5_M1niot3YbBxLbLnfG8KJDRBSBxmTKvgYwMEs5Ln55F5g@mail.gmail.com>
Subject: Re: [PATCH NEXT 2/2] drm/radeon/radeon_connectors: remove
 radeon_connector_free_edid
To: Joshua Peisach <jpeisach@ubuntu.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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

Applied the series.  Thanks!

Alex

On Sat, May 23, 2026 at 10:28=E2=80=AFAM Joshua Peisach <jpeisach@ubuntu.co=
m> wrote:
>
> Since we are using struct drm_edid, we can call drm_edid_free directly.
> Also make sure to set the pointer to NULL afterwards.
>
> Signed-off-by: Joshua Peisach <jpeisach@ubuntu.com>
> ---
>  drivers/gpu/drm/radeon/radeon_connectors.c | 30 +++++++++++-----------
>  1 file changed, 15 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_connectors.c b/drivers/gpu/drm=
/radeon/radeon_connectors.c
> index d3a2efbcfd0d..da678f41823d 100644
> --- a/drivers/gpu/drm/radeon/radeon_connectors.c
> +++ b/drivers/gpu/drm/radeon/radeon_connectors.c
> @@ -314,14 +314,6 @@ static void radeon_connector_get_edid(struct drm_con=
nector *connector)
>         }
>  }
>
> -static void radeon_connector_free_edid(struct drm_connector *connector)
> -{
> -       struct radeon_connector *radeon_connector =3D to_radeon_connector=
(connector);
> -
> -       kfree(radeon_connector->edid);
> -       radeon_connector->edid =3D NULL;
> -}
> -
>  static int radeon_ddc_get_modes(struct drm_connector *connector)
>  {
>         struct radeon_connector *radeon_connector =3D to_radeon_connector=
(connector);
> @@ -895,7 +887,9 @@ static void radeon_connector_destroy(struct drm_conne=
ctor *connector)
>  {
>         struct radeon_connector *radeon_connector =3D to_radeon_connector=
(connector);
>
> -       radeon_connector_free_edid(connector);
> +       drm_edid_free(radeon_connector->edid);
> +       radeon_connector->edid =3D NULL;
> +
>         kfree(radeon_connector->con_priv);
>         drm_connector_unregister(connector);
>         drm_connector_cleanup(connector);
> @@ -1007,7 +1001,8 @@ radeon_vga_detect(struct drm_connector *connector, =
bool force)
>                 dret =3D radeon_ddc_probe(radeon_connector, false);
>         if (dret) {
>                 radeon_connector->detected_by_load =3D false;
> -               radeon_connector_free_edid(connector);
> +               drm_edid_free(radeon_connector->edid);
> +               radeon_connector->edid =3D NULL;
>                 radeon_connector_get_edid(connector);
>
>                 if (!radeon_connector->edid) {
> @@ -1022,7 +1017,8 @@ radeon_vga_detect(struct drm_connector *connector, =
bool force)
>                          * with a shared ddc line (often vga + hdmi)
>                          */
>                         if (radeon_connector->use_digital && radeon_conne=
ctor->shared_ddc) {
> -                               radeon_connector_free_edid(connector);
> +                               drm_edid_free(radeon_connector->edid);
> +                               radeon_connector->edid =3D NULL;
>                                 ret =3D connector_status_disconnected;
>                         } else {
>                                 ret =3D connector_status_connected;
> @@ -1251,7 +1247,8 @@ radeon_dvi_detect(struct drm_connector *connector, =
bool force)
>         }
>         if (dret) {
>                 radeon_connector->detected_by_load =3D false;
> -               radeon_connector_free_edid(connector);
> +               drm_edid_free(radeon_connector->edid);
> +               radeon_connector->edid =3D NULL;
>                 radeon_connector_get_edid(connector);
>
>                 if (!radeon_connector->edid) {
> @@ -1277,7 +1274,8 @@ radeon_dvi_detect(struct drm_connector *connector, =
bool force)
>                          * with a shared ddc line (often vga + hdmi)
>                          */
>                         if ((!radeon_connector->use_digital) && radeon_co=
nnector->shared_ddc) {
> -                               radeon_connector_free_edid(connector);
> +                               drm_edid_free(radeon_connector->edid);
> +                               radeon_connector->edid =3D NULL;
>                                 ret =3D connector_status_disconnected;
>                         } else {
>                                 ret =3D connector_status_connected;
> @@ -1301,7 +1299,8 @@ radeon_dvi_detect(struct drm_connector *connector, =
bool force)
>                                                 if (list_connector->conne=
ctor_type !=3D DRM_MODE_CONNECTOR_VGA) {
>                                                         /* hpd is our onl=
y option in this case */
>                                                         if (!radeon_hpd_s=
ense(rdev, radeon_connector->hpd.hpd)) {
> -                                                               radeon_co=
nnector_free_edid(connector);
> +                                                               drm_edid_=
free(radeon_connector->edid);
> +                                                               radeon_co=
nnector->edid =3D NULL;
>                                                                 ret =3D c=
onnector_status_disconnected;
>                                                         }
>                                                 }
> @@ -1635,7 +1634,8 @@ radeon_dp_detect(struct drm_connector *connector, b=
ool force)
>                 goto out;
>         }
>
> -       radeon_connector_free_edid(connector);
> +       drm_edid_free(radeon_connector->edid);
> +       radeon_connector->edid =3D NULL;
>
>         if ((connector->connector_type =3D=3D DRM_MODE_CONNECTOR_eDP) ||
>             (connector->connector_type =3D=3D DRM_MODE_CONNECTOR_LVDS)) {
> --
> 2.53.0
>
