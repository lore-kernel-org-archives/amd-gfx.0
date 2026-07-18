Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4366EC4450A
	for <amd-gfx@archiver.kernel.org>; Sun, 19 Jul 2026 01:44:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD90E10E629;
	Sun, 19 Jul 2026 01:44:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=spasswolf@web.de header.b="Dtc4W3v/";
	dkim-atps=neutral
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07B4D10E0FA
 for <amd-gfx@lists.freedesktop.org>; Sat, 18 Jul 2026 12:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1784377368; x=1784982168; i=spasswolf@web.de;
 bh=ophsb4TC4FD28+SkdnDgfY4KzIucqgCPoxvDF5HB71U=;
 h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=Dtc4W3v/STaSJxTCoif98N0iXITIMcyZYaGqVtWhgONg7lIWKoMtiygCElNpqugN
 k1qy6C1A+aDlWKIyZv23D47WSQ8zXw6IbId+xoIhzjyLzokbbi+miEnPCWHYjIYF1
 +SLqoYKvtQpQ9EfzMylLFZtNS1kpuVUvp1TqCBOG2XGdZTDlN9wjgyic3MoW3vYpZ
 F6nmGSqAphAGu/LHKs/bvvASjKJjP8bXEO7bBIRIX+8wV4DilKqOWFpDZvEeOWiNf
 417CA8eEla7Jrkki6a2E5vzJ0RSJNwLP7vr2dTJpIMtiS6Xuz0ZGQpG38p4PR4hZz
 FPJPW4KUO3mDD8aWPA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M1rP8-1wisCm2eIS-009p6Q; Sat, 18
 Jul 2026 14:22:48 +0200
Message-ID: <514c5423b98376e2e6f1fe4bb56c0f3607b4cd52.camel@web.de>
Subject: Re: warnings from validate_blend_mode_for_alpha_formats() in
 next-20260715
From: Bert Karwatzki <spasswolf@web.de>
To: Leandro Ribeiro <leandro.ribeiro@collabora.com>, Alex Deucher
 <alexdeucher@gmail.com>, "Wentland, Harry" <Harry.Wentland@amd.com>, "Leo
 (Sunpeng) Li" <Sunpeng.Li@amd.com>, Alex Hung <alex.hung@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, linux-kernel@vger.kernel.org, 
 amd-gfx@lists.freedesktop.org, linux-next@vger.kernel.org, Jesse Zhang
 <jesse.zhang@amd.com>, Amber Lin <Amber.Lin@amd.com>, Mario Limonciello
 <mario.limonciello@amd.com>, spasswolf@web.de
Date: Sat, 18 Jul 2026 14:22:47 +0200
In-Reply-To: <cd96faf15c338157e49a858f9e4f94acba4c28ab.camel@web.de>
References: <20260716152933.6744-1-spasswolf@web.de>
 <CADnq5_PEN=iuspWbQ9C3gJZ5qJVOLmJ5hrsi6FH0Dg2Y_u2mZQ@mail.gmail.com>
 <45d341e6-d438-4e34-bba2-f6d23dbcf7fb@collabora.com>
 <cd96faf15c338157e49a858f9e4f94acba4c28ab.camel@web.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-10 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yiHcwlPeUGTAYBqD7HKQNKtHRtnNTpT00YRXyF8trDeMNqwfehY
 homsdZH/U2IV+s9Yp4xCzk87kkNSJnQFfogtb5zYlBQd/lbpZN5hmWR27u2YYoKrFS4c5xk
 IcHcpX6K4SC3z/aH4nydBMOdA+dw3UL+MfM93W0GRC97l+VhurL3oh9e6f4exU4tajkzqya
 DKyGVxeEGi60mAFHiDY/A==
UI-OutboundReport: notjunk:1;M01:P0:cTXVYsrGP4A=;3vAR6zcMoCvb55nUUtVjM05h5BP
 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
X-Mailman-Approved-At: Sun, 19 Jul 2026 01:43:58 +0000
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

Am Samstag, dem 18.07.2026 um 11:21 +0200 schrieb Bert Karwatzki:
> Am Freitag, dem 17.07.2026 um 19:54 -0300 schrieb Leandro Ribeiro:
> >=20
> > On 7/17/26 11:55 AM, Alex Deucher wrote:
> > > + Some display folks
> > >=20
> > > On Fri, Jul 17, 2026 at 9:04=E2=80=AFAM Bert Karwatzki <spasswolf@we=
b.de> wrote:
> > > >=20
> > > > commit 860e748bddcc ("drm: ensure blend mode supported if pixel fo=
rmat with alpha exposed")
> > > > introduces validate_blend_mode_for_alpha_formats() which prints wa=
rnings for amdpgu as
> > > > amdgpu only set blend_mode_property for planes of type DRM_PLANE_T=
YPE_OVERLAY. I tried to fix
> > > > this by removing he (plane->type =3D=3D DRM_PLANE_TYPE_OVERLAY) ch=
eck in amdgpu_dm_plane_init():
> > > >=20
> > > >         printk(KERN_INFO "%s: plane=3D%px plane->type=3D0x%x plane=
_cap=3D%px\n", __func__, plane, plane->type, plane_cap);
> > > >         if (plane_cap)
> > > >                 printk(KERN_INFO "%s: per_pixel_alpha =3D%u\n", __=
func__, plane_cap->per_pixel_alpha);
> > > >         if (plane_cap && plane_cap->per_pixel_alpha) {
> > > >                 unsigned int blend_caps =3D BIT(DRM_MODE_BLEND_PIX=
EL_NONE) |
> > > >                                           BIT(DRM_MODE_BLEND_PREMU=
LTI) |
> > > >                                           BIT(DRM_MODE_BLEND_COVER=
AGE);
> > > >=20
> > > >                 printk(KERN_INFO "%s: creating alpha and blend mod=
e properties for plane %px\n", __func__, plane);
> > > >                 drm_plane_create_alpha_property(plane);
> > > >                 drm_plane_create_blend_mode_property(plane, blend_=
caps);
> > > >         }
> > > >=20
> > > > But this does not completely silence the warnings becuase for plan=
es of type DRM_PLANE_TYPE_CURSOR plane_cap is NULL.
> > > > Is this a problem that should be fixed in amdgpu or is should vali=
date_blend_mode_for_alpha_formats() only be called
> > > > for planes of certain types?
> >=20
> > IMO validate_blend_mode_for_alpha_formats() should be called for all
> > types of planes. I can't think of anything special about a cursor plan=
e
> > that would justify it being allowed to expose formats with alpha but n=
ot
> > the blend mode property.
> >=20
> > I'm not familiar with the AMD codebase to suggest the best fix, but th=
e
> > driver would need some way to know whether cursor planes are exposing
> > formats with alpha.
> >=20
> > > >=20
> > > > Bert Karwatzki
> > > >=20
>=20
> So I looked through the code and found that the cursor planes are initia=
llized by=C2=A0
> amdgpu_dm_crtc_init() which calls amdgpu_dm_plane_init() with plane_cap =
=3D NULL.
> So I was able to silence the warning by introducing a dummy_plane_cap in=
 amdgpu_dm_crtc_init()
> and dropping the plane->type check in amdgpu_dm_plane_init().
>=20
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/dr=
ivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> index d63688b9d93d..7fb118444d14 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> @@ -731,13 +731,17 @@ int amdgpu_dm_crtc_init(struct amdgpu_display_mana=
ger *dm,
>         struct drm_plane *cursor_plane;
>         bool has_degamma;
>         int res =3D -ENOMEM;
> +       struct dc_plane_cap dummy_cap =3D {
> +               .type =3D DC_PLANE_TYPE_DCE_RGB,
> +               .per_pixel_alpha =3D 1,
> +       };
> =20
>         cursor_plane =3D kzalloc_obj(*cursor_plane);
>         if (!cursor_plane)
>                 goto fail;
> =20
>         cursor_plane->type =3D DRM_PLANE_TYPE_CURSOR;
> -       res =3D amdgpu_dm_plane_init(dm, cursor_plane, 0, NULL);
> +       res =3D amdgpu_dm_plane_init(dm, cursor_plane, 0, &dummy_cap);
> =20
>         acrtc =3D kzalloc_obj(struct amdgpu_crtc);
>         if (!acrtc)
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/d=
rivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> index 26f35434a92f..20785fb451dd 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> @@ -1932,8 +1932,7 @@ int amdgpu_dm_plane_init(struct amdgpu_display_man=
ager *dm,
>         if (res)
>                 return res;
> =20
> -       if (plane->type =3D=3D DRM_PLANE_TYPE_OVERLAY &&
> -           plane_cap && plane_cap->per_pixel_alpha) {
> +       if (plane_cap && plane_cap->per_pixel_alpha) {
>                 unsigned int blend_caps =3D BIT(DRM_MODE_BLEND_PIXEL_NON=
E) |
>                                           BIT(DRM_MODE_BLEND_PREMULTI) |
>                                           BIT(DRM_MODE_BLEND_COVERAGE);
>=20
> One can probably also omit the .type field in the dummy_cap struct and
> also does not have to check if plance_cap is NULL anymore.
>=20
> Bert Karwatzki

This might seem problematic as this unconditionally sets per_pixel_alpha =
=3D true for cursor planes,
but currently the only pixel format used for cursor planes in amdgpu is DR=
M_FORMAT_ARGB8888:

$ grep -B 1 -A 3 'cursor_formats\[\]' drivers/gpu/drm/amd/display/amdgpu_d=
m/amdgpu_dm_plane.c

static const u32 cursor_formats[] =3D {
	DRM_FORMAT_ARGB8888
};

Bert Karwatzki
