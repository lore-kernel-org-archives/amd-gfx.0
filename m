Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CBC6C43458
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2026 13:27:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0F3F10F8F4;
	Fri, 10 Jul 2026 13:27:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QiOegJAu";
	dkim-atps=neutral
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9D3310F8E5
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2026 13:27:36 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-381f03d7be0so182535a91.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2026 06:27:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783690056; cv=none;
 d=google.com; s=arc-20260327;
 b=n1k6RXx5YOwyAaW1TzXP/6phNBftcyPM+jLeaX5taMympEU4ClN0Un8XXB0W+c+TAU
 1OxUgg4R9Byp3BwAyC1yDM3MnxxiHynQIz17cJpUS/35KCz/A1Wan+Vy975GGhkIrUO0
 SUOtn3C2wzxCHyHc9SED2iYs7qeQ81qe31QVSQztvkP+NA3n47yzHfNIlfEhNO1tdBwZ
 dWSwC9iCks71TBL50kmV5oly0wccwgpyWKT/p87CgI7WFADNEezBevTbLbn/lO/N1Gfh
 pro2htmkUqTBMd14g4w7W5MJOQVuQ0C70yCXzsAIcFNs1TdOMO1L7TY854WLP2HG6cgu
 NKPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=8Xz8mAiIS9bhxJSnBlNVStU7ycoiUswNHhwr3rObZng=;
 fh=0IqcFP2YQzd+mxFvBoYD0Xi98xsG4fWtoE4jyMuKKvw=;
 b=gYj7Sa9Bdr2FOYwFoSiuYbc6sSvmqme9HNTECOndj8fOS/npuZT8fDuB9dsnJzU7zy
 RdE7oI7GxUf13aNi6bdBx56w011RozS/4R6IfFY4cFCsgNmlCKzAgrdUp1+5LSqk2Vpj
 Ng+7T/aaSv6lv+i8t018euJTiUdO2mBvXMuzSv0tPrZJfyL/bLj5YM9ignQwdth5dgXS
 QLsmH+Aor7voxz97AyaTAroxap6DjMdZzVfChsgXZayiauN5qreg1G6xdlLhAACNJDZ9
 b1EqcL1tX1x/j1USY/R5JFhPMb6gNRp2ezwRZwg08aduD5ARfaUqeoLFRypRhX771hyg
 eH+Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783690056; x=1784294856; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8Xz8mAiIS9bhxJSnBlNVStU7ycoiUswNHhwr3rObZng=;
 b=QiOegJAu0Dati0+Qo2es+1AYTiX16oEq7iaiLSu1D7zDZwRkJnhG9TBcMNRnFS0D39
 2cBTI8XcKO0CEJWAtP5tgUt0fmDninA3ge3AlcqyC4awgo4yDXqQo601XnlqkTBv9uHX
 rjeCj3GxuchqHtJoxzWthwKPxnJ23RWBbX75dByjy9Y5ahFor9BGhVtM8NF4RjUk6nvh
 2g3zWrYcY734NAGfqKEZuNG6l23qnEUu7BbDssgKsP62miB4hSiCW/R0hbAhjcIT/dZw
 cRMN+vqL7HmEDPtv0OhQtek/nMAWh9RswNemljl4HnHhEVdtX2LseQlTzsqWzRukEUFq
 N42Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783690056; x=1784294856;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8Xz8mAiIS9bhxJSnBlNVStU7ycoiUswNHhwr3rObZng=;
 b=ecWLu8P+k+5Gq0fEDzudKZamLMrvapviS6sHzCCipweNNnfGMu3ZqbZm+wdA2LULgp
 a3VBqqDGOmxTQacF/vVDowuc/JZGCZkWqqYZZGiMyRJ//Y/0Qv1jeMB9vjSTIzKR9lb8
 e0zqmCtxA/hF9e0y73y9wXATSBUZ4zGwN2bwbX56+3FQqGZIPmJDtswfad4eF7SgQSVk
 o5n6ARh3PN+PtmuvOR1XSybPmaKDb+S3CQOjWp+oADyysqNuRENBAEBKyTRS5KR7j2sS
 vUbU0/LwJOuY6Xum1h9SXC9N6+m5vOKkm4VdBCNPz8lSAaU9kPePFm3gk1g7BUG6pT8s
 5eRg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrlpFnnDeSOnS1dXkRsKzlzU9WMrgYn4I8mOXNhDlWCe9lmQVqtypk4GmnKmLzPrS8Lnaez+cfe@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw5/78Aqi20L4Wkx2j088pR99lKNGY7K5+FMOS2pwjm/wohz78q
 KILKm9+vWgDulTzyG80WyLsY6etIcP04Bos9uVp8FlDsLtl+Pk7E2fXq9M/lau1wff3LkGTaMWa
 QZ/WjnYiL2uXZRo8q+aJM3zP1pkdAjlw=
X-Gm-Gg: AfdE7cnl108na9CrTnaIRn9FtL6eAlt+Pwo55xkVn+xfljufWsMU3n2lChbmw/v3HOU
 Z0+Rayj+SAXu3epzKs4bqpJ4CC/hG1VCFo7NIs8RzCGV3DehzglNBGT4PGjV8tnEt6qsD1CUf1j
 3U5vTwqUntnTOgxrOnf97JFUl8Pc1NBsnt/FEjRCaraohVuT4oVlHDqk2FRITfTBjcWnTOVIiBs
 4P9FGqXP6WzyoucZX2V5a40pFhBSA8A5PUPC8dAdPVPTukcSExv5HMHoOHVRSY4Dmz9CbhQbU4A
 xErsw/zt5WKa8eJm6ftQSnl6kql/6MHmSDza1mbdriyENtgt4watj4Q+nTzDRdjlHxnuXQ==
X-Received: by 2002:a17:90b:390e:b0:381:77cd:38ca with SMTP id
 98e67ed59e1d1-38a20c48ce0mr6963500a91.4.1783690056153; Fri, 10 Jul 2026
 06:27:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260708222035.7324-1-nico.antinori.7@gmail.com>
 <fd5ecc7b-b9b5-4653-b7ad-72bdcd0b8518@suse.de>
In-Reply-To: <fd5ecc7b-b9b5-4653-b7ad-72bdcd0b8518@suse.de>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 10 Jul 2026 09:27:24 -0400
X-Gm-Features: AVVi8CfC8WMQvuOOX9IbEu4pHDNwlbHNhnBztQ4WqIxX3gf9mAdHkuUx5nllMac
Message-ID: <CADnq5_OBYXSz2HG7SCA2eK5_z1J0SmJCwCW2RkGJ5d1-tAVC6g@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Inline drm_simple_encoder_init()
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: =?UTF-8?Q?Nicol=C3=A1s_Antinori?= <nico.antinori.7@gmail.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
 Brigham Campbell <me@brighamcampbell.com>, 
 David Airlie <airlied@gmail.com>, Shuah Khan <skhan@linuxfoundation.org>, 
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org, 
 linux-kernel-mentees@lists.linux.dev, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org
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

Applied.  Thanks!

On Thu, Jul 9, 2026 at 3:17=E2=80=AFAM Thomas Zimmermann <tzimmermann@suse.=
de> wrote:
>
>
>
> Am 09.07.26 um 00:20 schrieb Nicol=C3=A1s Antinori:
> > Simple KMS helpers are deprecated because they introduce an unnecessary
> > intermediate layer between atomic modesetting and the DRM driver.
> >
> > Inline the functionality of drm_simple_encoder_init() to remove
> > dependencies on these deprecated helpers.
> >
> > Signed-off-by: Nicol=C3=A1s Antinori <nico.antinori.7@gmail.com>
>
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c | 10 ++++++++--
> >   1 file changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_vkms.c
> > index 170adaf7e76a..d5b0692fe860 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
> > @@ -2,7 +2,7 @@
> >
> >   #include <drm/drm_atomic_helper.h>
> >   #include <drm/drm_edid.h>
> > -#include <drm/drm_simple_kms_helper.h>
> > +#include <drm/drm_encoder.h>
> >   #include <drm/drm_gem_framebuffer_helper.h>
> >   #include <drm/drm_vblank.h>
> >   #include <drm/drm_vblank_helper.h>
> > @@ -316,6 +316,10 @@ static struct drm_plane *amdgpu_vkms_plane_init(st=
ruct drm_device *dev,
> >       return plane;
> >   }
> >
> > +static const struct drm_encoder_funcs drm_encoder_funcs_cleanup =3D {
> > +     .destroy =3D drm_encoder_cleanup,
> > +};
> > +
> >   static int amdgpu_vkms_output_init(struct drm_device *dev, struct
> >                                  amdgpu_vkms_output *output, int index)
> >   {
> > @@ -342,7 +346,9 @@ static int amdgpu_vkms_output_init(struct drm_devic=
e *dev, struct
> >
> >       drm_connector_helper_add(connector, &amdgpu_vkms_conn_helper_func=
s);
> >
> > -     ret =3D drm_simple_encoder_init(dev, encoder, DRM_MODE_ENCODER_VI=
RTUAL);
> > +     ret =3D drm_encoder_init(dev, encoder,
> > +                            &drm_encoder_funcs_cleanup,
> > +                            DRM_MODE_ENCODER_VIRTUAL, NULL);
> >       if (ret) {
> >               DRM_ERROR("Failed to init encoder\n");
> >               goto err_encoder;
> > --
> > 2.47.3
> >
>
> --
> --
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Frankenstr. 146, 90461 N=C3=BCrnberg, Germany, www.suse.com
> GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG N=C3=BCrnberg)
>
>
