Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 476A0C5DF9B
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2026 15:22:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8334810E7E5;
	Mon, 24 Aug 2026 15:22:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=spasswolf@web.de header.b="s3FLsZAN";
	dkim-atps=neutral
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10F5D10E6C0;
 Mon, 24 Aug 2026 09:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1787564034; x=1788168834; i=spasswolf@web.de;
 bh=NnrtWTSI+yTC1O8xCprjsvmA8g5+c7EGm+vGNiBKslk=;
 h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=s3FLsZANkgNhrPEZM2RChJGa0pU4ZbPxXF8+ggMmdqjVSV5a1+XifHbyk2Fy3BRw
 Okqtl3wY1EId5xmyMyjF+dwnqqYD1V5ycbfKHFbXKjfLzULFrSuldrcscSatyLn8F
 C+r788d57MgxMEl3a4lnYqUQJF7nTevb67Jp2B1eHagC9mgNypgXtVuK98/6B8pja
 eEZ2AqXZAf32IcI7TgSQSrfHvqffonDlFtfN4qJNq5WXrBgDCjFLVuKft32FVDbjh
 CZuuXHUIrwf66LmswEWk9H0ubRrSM94KztPkk1Yd3SIbvody2rp8vvXzwaVZUYRb4
 KpBYtjgBfb7DFFvqJQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MIyeU-1xESqW1qxu-00RHCx; Mon, 24
 Aug 2026 11:33:54 +0200
Message-ID: <228da09239b8944dffbe175133434171b163ad7c.camel@web.de>
Subject: Re: [PATCH 1/8] display: fix blend_mode for non-overlay planes
From: Bert Karwatzki <spasswolf@web.de>
To: Alex Hung <alex.hung@amd.com>, Joshua Peisach <jpeisach@ubuntu.com>, 
 linux-kernel@vger.kernel.org
Cc: linux-next@vger.kernel.org, Alex Deucher <alexander.deucher@amd.com>, 
 Leandro Ribeiro <leandro.ribeiro@collabora.com>, "Wentland, Harry"
 <Harry.Wentland@amd.com>, Leo Li	 <Sunpeng.Li@amd.com>,
 amd-gfx@lists.freedesktop.org, Jesse Zhang	 <jesse.zhang@amd.com>, Amber
 Lin <Amber.Lin@amd.com>, Mario Limonciello	 <mario.limonciello@amd.com>,
 amd-gfx <amd-gfx-bounces@lists.freedesktop.org>,  Melissa Wen
 <mwen@igalia.com>, "Wheeler, Daniel" <Daniel.Wheeler@amd.com>,
 spasswolf@web.de
Date: Mon, 24 Aug 2026 11:33:53 +0200
In-Reply-To: <edb965a1-3d35-4dd6-924f-52e88b91a8fd@amd.com>
References: <514c5423b98376e2e6f1fe4bb56c0f3607b4cd52.camel@web.de>
 <20260814151701.65222-1-spasswolf@web.de>
 <DKUUGMJ1H5N5.2FRQG3ZKH6SNB@ubuntu.com>
 <7ac562a41bc25f459c2102a01f2d07f2437984b8.camel@web.de>
 <edb965a1-3d35-4dd6-924f-52e88b91a8fd@amd.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-10+b1 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7SphhXu5O8oqZbbf0nDGpDPVKr+oPcR/8Fk/22xJzTpe/FumONF
 dgYbTZnDnMgR94zkX5S7q/WbnoR7ehZdozFlwOLFEDXnuPFSg/ZOTuimds6j1RKcx9NfN7H
 1ihRBtyB82JYRQk3cbMUU2pzC4u2iueeGg8OMqPSI9wZ1R/yC2cRkdQeq9+7GLptHCGAxnE
 7VXba4EG6TTcZ7G+4489g==
UI-OutboundReport: notjunk:1;M01:P0:BkJn6NUSvew=;HJWLGyUYLhOnbnlTe+I71GRNxic
 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
 4HVXE1aFL/s=
X-Mailman-Approved-At: Mon, 24 Aug 2026 15:22:53 +0000
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

Am Freitag, dem 21.08.2026 um 14:31 -0600 schrieb Alex Hung:
> This looks like a fix for the same problem Melissa tried to address in
>=20
> https://lore.kernel.org/amd-gfx/DS0PR12MB65342AEDED0D035DFA92E4189CA32@D=
S0PR12MB6534.namprd12.prod.outlook.com/T/#mf6847a9e8d013adae40afa3c2ca0c64=
ebd3fcb50
>=20
> Please advise if it is for a different issue.
>=20
> Thanks.
>=20
> On 8/21/26 13:42, Bert Karwatzki wrote:
> > Am Freitag, dem 21.08.2026 um 14:47 -0400 schrieb Joshua Peisach:
> > > On Fri Aug 14, 2026 at 11:17 AM EDT, Bert Karwatzki wrote:
> > > > Previously drm_plane_create_blend_mode_property() was only called =
for
> > > > planes of type DRM_PLANE_TYPE_OVERLAY. Since commit commit 860e748=
bddcc
> > > > ("drm: ensure blend mode supported if pixel format with alpha expo=
sed")
> > > > this results in warnings from validate_blend_mode_for_alpha_format=
s().
> > > > We fix this here by calling drm_plane_create_blend_mode_property()=
 for
> > > > all plane types if the plane is supporting a format with
> > > > per_pixel_alpha.
> > > >=20
> > > > Signed-off-by: Bert Karwatzki <spasswolf@web.de>
> > > > ---
> > > >   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c  | 5 ++++=
-
> > > >   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c | 3 +--
> > > >   2 files changed, 5 insertions(+), 3 deletions(-)
> > > >=20
> > > > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.=
c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> > > > index 62eac6e65334..a6a54351ea56 100644
> > > > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> > > > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> > > > @@ -755,13 +755,16 @@ int amdgpu_dm_crtc_init(struct amdgpu_displa=
y_manager *dm,
> > > >   	struct drm_plane *cursor_plane;
> > > >   	bool has_degamma;
> > > >   	int res =3D -ENOMEM;
> > > > +	struct dc_plane_cap dummy_cap =3D {
> > > > +		.per_pixel_alpha =3D 1,
> > > > +	};
> > > >  =20
> > > >   	cursor_plane =3D kzalloc_obj(*cursor_plane);
> > > >   	if (!cursor_plane)
> > > >   		goto fail;
> > > >  =20
> > > >   	cursor_plane->type =3D DRM_PLANE_TYPE_CURSOR;
> > > > -	res =3D amdgpu_dm_plane_init(dm, cursor_plane, 0, NULL);
> > > > +	res =3D amdgpu_dm_plane_init(dm, cursor_plane, 0, &dummy_cap);
> > > >  =20
> > > >   	acrtc =3D kzalloc_obj(struct amdgpu_crtc);
> > > >   	if (!acrtc)
> > > > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane=
.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> > > > index 824ef3ce5de0..4c0c6a8a0dac 100644
> > > > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> > > > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> > > > @@ -2208,8 +2208,7 @@ int amdgpu_dm_plane_init(struct amdgpu_displ=
ay_manager *dm,
> > > >   	if (res)
> > > >   		return res;
> > > >  =20
> > > > -	if (plane->type =3D=3D DRM_PLANE_TYPE_OVERLAY &&
> > > > -	    plane_cap && plane_cap->per_pixel_alpha) {
> > > > +	if (plane_cap && plane_cap->per_pixel_alpha) {
> > > >   		unsigned int blend_caps =3D BIT(DRM_MODE_BLEND_PIXEL_NONE) |
> > > >   					  BIT(DRM_MODE_BLEND_PREMULTI) |
> > > >   					  BIT(DRM_MODE_BLEND_COVERAGE);
> > >=20
> > > Not sure where the full patch set is, but this does make the warning
> > > go away.
> > >=20
> > > Tested-by: Joshua Peisach <jpeisach@ubuntu.com>
> >=20
> > This is actually the only patch, the 1/8 is an artifact from using
> > git format-patch which I forgot to remove.
> >=20
> > Bert Karwatzki

Patch 2 of this series

https://lore.kernel.org/amd-gfx/DS0PR12MB65342AEDED0D035DFA92E4189CA32@DS0=
PR12MB6534.namprd12.prod.outlook.com/T/#mf6847a9e8d013adae40afa3c2ca0c64eb=
d3fcb50

is fixing the same issue, I think.

Bert Karwatzki
