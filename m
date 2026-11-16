Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E94C606A31C
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2026 19:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mXsrmTKV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C04AE10E45D;
	Mon, 16 Nov 2026 19:38:26 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0678E10E45D
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2026 19:38:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 027A7611FC;
 Mon, 16 Nov 2026 19:38:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 846721F000C6;
 Mon, 16 Nov 2026 19:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794857899;
 bh=T7v4+Rf0gwEsGgxNwedue3vVN/2JT5jbVXMA4mSB/rc=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=mXsrmTKVUPhj6EmuVWarWrxxtgYdhpzcjNo8KL1cUduUXYm7xQ7ZktTo1auV9h7R/
 NCqBrRhzpWlvcq5SYCGoSde8tueoTVtvYHFXHDzR0rJylCWQ02kDqSxh1KrILbs3EB
 Inh1xepnnVgDTbTt4wd5y1B19eSRACYOn4gfCiHlruQATFoVMkRoC72V0tjq8dcfhT
 3hoHOBP7mUvTINUOpQu/dqGymfACR2aH+o+lIZn383/BDEjAD6yQazvk58Y5hHi+ct
 49f14TlRHKvUbgNpwlKuiiZeRHKUIrVM5LK0yzdk0p0+VcnssjrbCjUiSG5OF/5CEh
 Di/kisetaMRlQ==
Message-ID: <sashiko-outbox-217587@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] drm/amd/display: advertise PIXEL_NONE and PREMULTI
 blend mode for DCE
To: "James Lin" <PingLei.Lin@amd.com>, amd-gfx@lists.freedesktop.org
In-Reply-To: <20261116001326.2360302-3-PingLei.Lin@amd.com>
References: <20261116001326.2360302-1-PingLei.Lin@amd.com>
 <20261116001326.2360302-3-PingLei.Lin@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 19:38:19 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [Medium] drm/amd/display: missing drm_plane_cleanup() on error in
  amdgpu_dm_plane_init() [1]
--

commit f9cd4d4e16a60ec76ad85f33f53d77691bb25467
Author: Melissa Wen <mwen@igalia.com>

drm/amd/display: advertise PIXEL_NONE and PREMULTI blend mode for DCE

This commit exposes the pixel blend mode property with PIXEL_NONE and
PREMULTI on non-DCN planes in amdgpu_dm_plane_init().

Link: https://patch.msgid.link/20260826104143.39077-4-mwen@igalia.com

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/dr=
ivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> index 9d7be2fd29aae..db07b6d9110c7 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> @@ -2233,14 +2233,24 @@ int amdgpu_dm_plane_init(struct amdgpu_display_ma=
nager *dm,
>  	if (res)
>  		return res;
> =20
> -	/* TODO: Check which blend modes are supported in DCE-generation
> -	 * planes, i.e. DC_PLANE_TYPE_DCE_RGB/UNDERLAY and expose blend mode
> -	 * property accordingly.
> +	/* Blend mode support varies on DCE generations according to HW caps
> +	 * and number of planes per CRTC. However, as current driver
> +	 * implementation only creates one primary and one cursor plane per
> +	 * CRTC for DCE (overlay is only created if
> +	 * DC_PLANE_TYPE_DCN_UNIVERSAL), the primary plane blend mode is
> +	 * ignored across DCE versions. Keep PREMULTI to avoid uAPI
> +	 * regressions: it was the default/mandatory mode for many years and,
> +	 * with no overlay plane, primary composes on top of a black
> +	 * background, where PREMULTI and PIXEL_NONE are equivalent.
>  	 */
> -	if ((plane->type =3D=3D DRM_PLANE_TYPE_OVERLAY ||
> -	     plane->type =3D=3D DRM_PLANE_TYPE_PRIMARY) &&
> -	    plane_cap && plane_cap->per_pixel_alpha &&
> -	    plane_cap->type =3D=3D DC_PLANE_TYPE_DCN_UNIVERSAL) {
> +	if (plane_cap && plane_cap->type !=3D DC_PLANE_TYPE_DCN_UNIVERSAL) {
> +		unsigned int blend_caps =3D BIT(DRM_MODE_BLEND_PIXEL_NONE) |
> +					  BIT(DRM_MODE_BLEND_PREMULTI);
> +
> +		drm_plane_create_blend_mode_property(plane, blend_caps);
> +	} else if ((plane->type =3D=3D DRM_PLANE_TYPE_OVERLAY ||
> +		    plane->type =3D=3D DRM_PLANE_TYPE_PRIMARY) &&
> +		   plane_cap && plane_cap->per_pixel_alpha) {
>  		unsigned int blend_caps =3D BIT(DRM_MODE_BLEND_PIXEL_NONE) |
>  					  BIT(DRM_MODE_BLEND_PREMULTI) |
>  					  BIT(DRM_MODE_BLEND_COVERAGE);

[Severity: Medium]
This problem wasn't introduced by this patch, but does amdgpu_dm_plane_init=
()
miss calling drm_plane_cleanup(plane) when failing after
drm_universal_plane_init() [1]?

Later in amdgpu_dm_plane_init():

drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c:amdgpu_dm_plane_ini=
t() {
	...
	res =3D dm_plane_init_colorops(plane);
	if (res)
		return res;
	...
}

If dm_plane_init_colorops() fails, returning without drm_plane_cleanup()
leaks the internal plane allocations and leaves the plane linked on
dev->mode_config.plane_list.  When initialize_plane() or
amdgpu_dm_crtc_init() then frees the plane, the dangling list entry causes a
use-after-free and double free in drm_mode_config_cleanup() during probe
teardown.

[1] https://sashiko.dev/#/bug/linux-c73cfe01-2981-40a4-9f20-42eb58a1bc98

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116001326.2360=
302-2-PingLei.Lin@amd.com?part=3D2
