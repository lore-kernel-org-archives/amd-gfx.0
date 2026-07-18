Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF6DEC44523
	for <amd-gfx@archiver.kernel.org>; Sun, 19 Jul 2026 01:44:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE7CC10E61F;
	Sun, 19 Jul 2026 01:44:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=spasswolf@web.de header.b="Ifw56hwo";
	dkim-atps=neutral
X-Greylist: delayed 312 seconds by postgrey-1.36 at gabe;
 Sat, 18 Jul 2026 09:26:49 UTC
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA9AC10E558
 for <amd-gfx@lists.freedesktop.org>; Sat, 18 Jul 2026 09:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1784366808; x=1784971608; i=spasswolf@web.de;
 bh=Txcj6lg11fs/bItCCmYN6HDREpRxvcKAtvpvqm9w3yU=;
 h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=Ifw56hwoNPZkV1j1cPEIcO0NCUvvRJzaonUR/R3dABfQ+PAaisQUwfwG3R0+nmD5
 ZHUlMCvrQTmKn5Wbgm/v8eSNNn31HajXZRYTA8DXapN6iy4M6vIJuQi7d0tbAG7Rg
 rivtc8WgXY48AJG83X8YbJRPhy/K94CJErK25I/zlz1DC/oW60Sj1pbF72U6Gk0Td
 DUKB45PkJXhzif7uWwemc0bghXrxc+/8xponRiJ8Uokk4f0bUpq3GVbAiVB8k+k1k
 aBBZbzFnsyD6niVn2rP8wyNCQeAqzFOBxHO0OxfIKPH/TvvCNPJeeXlDPXo9fHC4e
 XeB4PPULXu56Y/IQTw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M3m9J-1wkC9V47Ot-00BBjJ; Sat, 18
 Jul 2026 11:21:19 +0200
Message-ID: <cd96faf15c338157e49a858f9e4f94acba4c28ab.camel@web.de>
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
Date: Sat, 18 Jul 2026 11:21:17 +0200
In-Reply-To: <45d341e6-d438-4e34-bba2-f6d23dbcf7fb@collabora.com>
References: <20260716152933.6744-1-spasswolf@web.de>
 <CADnq5_PEN=iuspWbQ9C3gJZ5qJVOLmJ5hrsi6FH0Dg2Y_u2mZQ@mail.gmail.com>
 <45d341e6-d438-4e34-bba2-f6d23dbcf7fb@collabora.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-10 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:L2mAw1aAzvAI8hU9onNPPOqvecXR1Pvp8SNqERZ4jIsar0WPWhN
 IKi5BzFShA6JClwJ/XzqUJJIKvqPdgtZuSeN1HtLmrk8rZahw0EKkaxnvabnF/Vr32bBsuB
 l3MYEjr13cKT5DX69mneIfWR8RBdb0wvwpUoG8N2Q53TBDC6poj24Hqdeub9LR89qjYsZzr
 eRnloXCgz605cfIBXU6WQ==
UI-OutboundReport: notjunk:1;M01:P0:NHKbEdz8Cy8=;bgiIe122O+ETWEpsWwCzZiCecRI
 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
 PKrK7+IjRQJULlx0ALxVW
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

Am Freitag, dem 17.07.2026 um 19:54 -0300 schrieb Leandro Ribeiro:
>=20
> On 7/17/26 11:55 AM, Alex Deucher wrote:
> > + Some display folks
> >=20
> > On Fri, Jul 17, 2026 at 9:04=E2=80=AFAM Bert Karwatzki <spasswolf@web.=
de> wrote:
> > >=20
> > > commit 860e748bddcc ("drm: ensure blend mode supported if pixel form=
at with alpha exposed")
> > > introduces validate_blend_mode_for_alpha_formats() which prints warn=
ings for amdpgu as
> > > amdgpu only set blend_mode_property for planes of type DRM_PLANE_TYP=
E_OVERLAY. I tried to fix
> > > this by removing he (plane->type =3D=3D DRM_PLANE_TYPE_OVERLAY) chec=
k in amdgpu_dm_plane_init():
> > >=20
> > >         printk(KERN_INFO "%s: plane=3D%px plane->type=3D0x%x plane_c=
ap=3D%px\n", __func__, plane, plane->type, plane_cap);
> > >         if (plane_cap)
> > >                 printk(KERN_INFO "%s: per_pixel_alpha =3D%u\n", __fu=
nc__, plane_cap->per_pixel_alpha);
> > >         if (plane_cap && plane_cap->per_pixel_alpha) {
> > >                 unsigned int blend_caps =3D BIT(DRM_MODE_BLEND_PIXEL=
_NONE) |
> > >                                           BIT(DRM_MODE_BLEND_PREMULT=
I) |
> > >                                           BIT(DRM_MODE_BLEND_COVERAG=
E);
> > >=20
> > >                 printk(KERN_INFO "%s: creating alpha and blend mode =
properties for plane %px\n", __func__, plane);
> > >                 drm_plane_create_alpha_property(plane);
> > >                 drm_plane_create_blend_mode_property(plane, blend_ca=
ps);
> > >         }
> > >=20
> > > But this does not completely silence the warnings becuase for planes=
 of type DRM_PLANE_TYPE_CURSOR plane_cap is NULL.
> > > Is this a problem that should be fixed in amdgpu or is should valida=
te_blend_mode_for_alpha_formats() only be called
> > > for planes of certain types?
>=20
> IMO validate_blend_mode_for_alpha_formats() should be called for all
> types of planes. I can't think of anything special about a cursor plane
> that would justify it being allowed to expose formats with alpha but not
> the blend mode property.
>=20
> I'm not familiar with the AMD codebase to suggest the best fix, but the
> driver would need some way to know whether cursor planes are exposing
> formats with alpha.
>=20
> > >=20
> > > Bert Karwatzki
> > >=20

So I looked through the code and found that the cursor planes are initiall=
ized by=C2=A0
amdgpu_dm_crtc_init() which calls amdgpu_dm_plane_init() with plane_cap =
=3D NULL.
So I was able to silence the warning by introducing a dummy_plane_cap in a=
mdgpu_dm_crtc_init()
and dropping the plane->type check in amdgpu_dm_plane_init().

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/driv=
ers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index d63688b9d93d..7fb118444d14 100644
=2D-- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -731,13 +731,17 @@ int amdgpu_dm_crtc_init(struct amdgpu_display_manage=
r *dm,
        struct drm_plane *cursor_plane;
        bool has_degamma;
        int res =3D -ENOMEM;
+       struct dc_plane_cap dummy_cap =3D {
+               .type =3D DC_PLANE_TYPE_DCE_RGB,
+               .per_pixel_alpha =3D 1,
+       };
=20
        cursor_plane =3D kzalloc_obj(*cursor_plane);
        if (!cursor_plane)
                goto fail;
=20
        cursor_plane->type =3D DRM_PLANE_TYPE_CURSOR;
-       res =3D amdgpu_dm_plane_init(dm, cursor_plane, 0, NULL);
+       res =3D amdgpu_dm_plane_init(dm, cursor_plane, 0, &dummy_cap);
=20
        acrtc =3D kzalloc_obj(struct amdgpu_crtc);
        if (!acrtc)
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/dri=
vers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index 26f35434a92f..20785fb451dd 100644
=2D-- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -1932,8 +1932,7 @@ int amdgpu_dm_plane_init(struct amdgpu_display_manag=
er *dm,
        if (res)
                return res;
=20
-       if (plane->type =3D=3D DRM_PLANE_TYPE_OVERLAY &&
-           plane_cap && plane_cap->per_pixel_alpha) {
+       if (plane_cap && plane_cap->per_pixel_alpha) {
                unsigned int blend_caps =3D BIT(DRM_MODE_BLEND_PIXEL_NONE)=
 |
                                          BIT(DRM_MODE_BLEND_PREMULTI) |
                                          BIT(DRM_MODE_BLEND_COVERAGE);

One can probably also omit the .type field in the dummy_cap struct and
also does not have to check if plance_cap is NULL anymore.

Bert Karwatzki
