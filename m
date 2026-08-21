Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14BE2C5DF9C
	for <amd-gfx@archiver.kernel.org>; Sun, 23 Aug 2026 09:28:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CFD510E4A7;
	Sun, 23 Aug 2026 09:28:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=spasswolf@web.de header.b="aqvhxhDQ";
	dkim-atps=neutral
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C319610F3F4
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 19:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1787341718; x=1787946518; i=spasswolf@web.de;
 bh=L/wGrymbJre+BwdT2dFIcH2imnHsz2YncuuQg3ewfY4=;
 h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=aqvhxhDQr54FRnGBeOt2jx1YFYoByus9toXpOdCIU1sbnRN/Zrt+r9asEps6okyI
 L8zNI9ytH+vdxwBVLy4ITgC+jd3ttQrcvVZalDfO5Ku4lIAE5mR2Iadu05ZrqfGmD
 c6gdSou7DhxNAos1TD9aiJl/8snYC45W+L86PeC9Hmt5hNh8iQImdfl//Rn7r9ra0
 fkPa3yJv+m2EB8DrHTfSi00PT2q34DO/E5JgF1QnLmoLHDLuyqbIjxEMHZhnNq40n
 vXKD61rptj685ILjFhkaaVrNHJm9WeilmjGIR6jmCiM9d34UFuyAy2r0aUBCoNOpP
 3XTgwOwXZk/7WhRZdg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M3m59-1wyKDc2d1v-00Bfy1; Fri, 21
 Aug 2026 21:42:55 +0200
Message-ID: <7ac562a41bc25f459c2102a01f2d07f2437984b8.camel@web.de>
Subject: Re: [PATCH 1/8] display: fix blend_mode for non-overlay planes
From: Bert Karwatzki <spasswolf@web.de>
To: Joshua Peisach <jpeisach@ubuntu.com>, linux-kernel@vger.kernel.org
Cc: linux-next@vger.kernel.org, Alex Deucher <alexander.deucher@amd.com>, 
 Leandro Ribeiro <leandro.ribeiro@collabora.com>, "Wentland, Harry"
 <Harry.Wentland@amd.com>, Leo Li	 <Sunpeng.Li@amd.com>, Alex Hung
 <alex.hung@amd.com>, 	amd-gfx@lists.freedesktop.org, Jesse Zhang
 <jesse.zhang@amd.com>, Amber Lin	 <Amber.Lin@amd.com>, Mario Limonciello
 <mario.limonciello@amd.com>, amd-gfx	
 <amd-gfx-bounces@lists.freedesktop.org>, spasswolf@web.de
Date: Fri, 21 Aug 2026 21:42:52 +0200
In-Reply-To: <DKUUGMJ1H5N5.2FRQG3ZKH6SNB@ubuntu.com>
References: <514c5423b98376e2e6f1fe4bb56c0f3607b4cd52.camel@web.de>
 <20260814151701.65222-1-spasswolf@web.de>
 <DKUUGMJ1H5N5.2FRQG3ZKH6SNB@ubuntu.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-10+b1 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:O+jFhhnhcUrZ1gERpbv9PR2Fcp7lLTp8UzDx1qSErBLirjkrFyI
 z7kh6LKWbHEAxrZJ4bo32KiRk06VgYiTNIppELl72dRYvbqRf02cSRWFFW+4BD08+86tund
 u415Qa7WoqJD/wIRnjjtkdHLmsEDWASUvm6Jf+9xspLlc6sWmq+H+zJjelld/YXIb3M6sLL
 fx5TudJeLjjilHCEHl5Yg==
UI-OutboundReport: notjunk:1;M01:P0:XrFY4k8eghQ=;UoiO6mz1eIr0sgUzAtF+HLm9OEq
 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
X-Mailman-Approved-At: Sun, 23 Aug 2026 09:28:04 +0000
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

Am Freitag, dem 21.08.2026 um 14:47 -0400 schrieb Joshua Peisach:
> On Fri Aug 14, 2026 at 11:17 AM EDT, Bert Karwatzki wrote:
> > Previously drm_plane_create_blend_mode_property() was only called for
> > planes of type DRM_PLANE_TYPE_OVERLAY. Since commit commit 860e748bddc=
c
> > ("drm: ensure blend mode supported if pixel format with alpha exposed"=
)
> > this results in warnings from validate_blend_mode_for_alpha_formats().
> > We fix this here by calling drm_plane_create_blend_mode_property() for
> > all plane types if the plane is supporting a format with
> > per_pixel_alpha.
> >=20
> > Signed-off-by: Bert Karwatzki <spasswolf@web.de>
> > ---
> >  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c  | 5 ++++-
> >  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c | 3 +--
> >  2 files changed, 5 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/=
drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> > index 62eac6e65334..a6a54351ea56 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> > @@ -755,13 +755,16 @@ int amdgpu_dm_crtc_init(struct amdgpu_display_ma=
nager *dm,
> >  	struct drm_plane *cursor_plane;
> >  	bool has_degamma;
> >  	int res =3D -ENOMEM;
> > +	struct dc_plane_cap dummy_cap =3D {
> > +		.per_pixel_alpha =3D 1,
> > +	};
> > =20
> >  	cursor_plane =3D kzalloc_obj(*cursor_plane);
> >  	if (!cursor_plane)
> >  		goto fail;
> > =20
> >  	cursor_plane->type =3D DRM_PLANE_TYPE_CURSOR;
> > -	res =3D amdgpu_dm_plane_init(dm, cursor_plane, 0, NULL);
> > +	res =3D amdgpu_dm_plane_init(dm, cursor_plane, 0, &dummy_cap);
> > =20
> >  	acrtc =3D kzalloc_obj(struct amdgpu_crtc);
> >  	if (!acrtc)
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b=
/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> > index 824ef3ce5de0..4c0c6a8a0dac 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> > @@ -2208,8 +2208,7 @@ int amdgpu_dm_plane_init(struct amdgpu_display_m=
anager *dm,
> >  	if (res)
> >  		return res;
> > =20
> > -	if (plane->type =3D=3D DRM_PLANE_TYPE_OVERLAY &&
> > -	    plane_cap && plane_cap->per_pixel_alpha) {
> > +	if (plane_cap && plane_cap->per_pixel_alpha) {
> >  		unsigned int blend_caps =3D BIT(DRM_MODE_BLEND_PIXEL_NONE) |
> >  					  BIT(DRM_MODE_BLEND_PREMULTI) |
> >  					  BIT(DRM_MODE_BLEND_COVERAGE);
>=20
> Not sure where the full patch set is, but this does make the warning
> go away.
>=20
> Tested-by: Joshua Peisach <jpeisach@ubuntu.com>

This is actually the only patch, the 1/8 is an artifact from using=20
git format-patch which I forgot to remove.

Bert Karwatzki
