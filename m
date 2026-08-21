Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01C5BC5DF7D
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 20:40:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA7A310F56D;
	Fri, 21 Aug 2026 18:51:17 +0000 (UTC)
Received: from smtp.forwardemail.net (unknown [121.127.44.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0965710F56D
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 18:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ubuntu.com;
 h=In-Reply-To: References: To: From: Subject: Cc: Message-Id: Date:
 Content-Type: Content-Transfer-Encoding: Mime-Version; q=dns/txt;
 s=fe-953a8a3ca9; t=1787338234;
 bh=nsNVBb9noAGwLm3N5qP79tHFDl2D832+fV5F/3bLxPY=;
 b=b7u+tk1vyQ37sWIzlUso/WMBqSY9XaFnvTEQS/aBC2zBZB+448B6ddGuc4bFrNj2gvpt1trUe
 rvH+RyocJbC48ntcfpxCRv8TFCqnp6VqglQBn/Hq998yqQAopX/g6y1V+GQ0Qp+n919n5+aDBmt
 2eY3Thrsekzmchv/DXNhthq7bkx6Rte0l+sjGQoCMJW1YQ0hMv8H+vOm7CImogOlE4GVegxwSYI
 LT0sLl0ogFpDpRaPmFSsNmS1UKxIqRYdL9U4U9n+evzG+1pYXvkOAXZOXI1vcWuE5tvkqB6m427
 pzieyaQQN63ooAaXdpvWwOW9+XJTAb5NAHbn4dq8HG3A==
X-Forward-Email-ID: 6a889d46fb9ca77f277b6258
X-Forward-Email-Sender: rfc822; jpeisach@ubuntu.com, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.13.16
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8; format=Flowed
Date: Fri, 21 Aug 2026 14:47:33 -0400
Message-Id: <DKUUGMJ1H5N5.2FRQG3ZKH6SNB@ubuntu.com>
Cc: <linux-next@vger.kernel.org>, "Alex Deucher"
 <alexander.deucher@amd.com>, "Leandro Ribeiro"
 <leandro.ribeiro@collabora.com>, "Wentland, Harry"
 <Harry.Wentland@amd.com>, "Leo Li" <Sunpeng.Li@amd.com>, "Alex Hung"
 <alex.hung@amd.com>, <amd-gfx@lists.freedesktop.org>, "Jesse Zhang"
 <jesse.zhang@amd.com>, "Amber Lin" <Amber.Lin@amd.com>, "Mario Limonciello"
 <mario.limonciello@amd.com>, "amd-gfx"
 <amd-gfx-bounces@lists.freedesktop.org>
Subject: Re: [PATCH 1/8] display: fix blend_mode for non-overlay planes
From: "Joshua Peisach" <jpeisach@ubuntu.com>
To: "Bert Karwatzki" <spasswolf@web.de>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <514c5423b98376e2e6f1fe4bb56c0f3607b4cd52.camel@web.de>
 <20260814151701.65222-1-spasswolf@web.de>
In-Reply-To: <20260814151701.65222-1-spasswolf@web.de>
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

On Fri Aug 14, 2026 at 11:17 AM EDT, Bert Karwatzki wrote:
> Previously drm_plane_create_blend_mode_property() was only called for
> planes of type DRM_PLANE_TYPE_OVERLAY. Since commit commit 860e748bddcc
> ("drm: ensure blend mode supported if pixel format with alpha exposed")
> this results in warnings from validate_blend_mode_for_alpha_formats().
> We fix this here by calling drm_plane_create_blend_mode_property() for
> all plane types if the plane is supporting a format with
> per_pixel_alpha.
>
> Signed-off-by: Bert Karwatzki <spasswolf@web.de>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c  | 5 ++++-
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c | 3 +--
>  2 files changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/dri=
vers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> index 62eac6e65334..a6a54351ea56 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> @@ -755,13 +755,16 @@ int amdgpu_dm_crtc_init(struct amdgpu_display_manag=
er *dm,
>  	struct drm_plane *cursor_plane;
>  	bool has_degamma;
>  	int res =3D -ENOMEM;
> +	struct dc_plane_cap dummy_cap =3D {
> +		.per_pixel_alpha =3D 1,
> +	};
> =20
>  	cursor_plane =3D kzalloc_obj(*cursor_plane);
>  	if (!cursor_plane)
>  		goto fail;
> =20
>  	cursor_plane->type =3D DRM_PLANE_TYPE_CURSOR;
> -	res =3D amdgpu_dm_plane_init(dm, cursor_plane, 0, NULL);
> +	res =3D amdgpu_dm_plane_init(dm, cursor_plane, 0, &dummy_cap);
> =20
>  	acrtc =3D kzalloc_obj(struct amdgpu_crtc);
>  	if (!acrtc)
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/dr=
ivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> index 824ef3ce5de0..4c0c6a8a0dac 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> @@ -2208,8 +2208,7 @@ int amdgpu_dm_plane_init(struct amdgpu_display_mana=
ger *dm,
>  	if (res)
>  		return res;
> =20
> -	if (plane->type =3D=3D DRM_PLANE_TYPE_OVERLAY &&
> -	    plane_cap && plane_cap->per_pixel_alpha) {
> +	if (plane_cap && plane_cap->per_pixel_alpha) {
>  		unsigned int blend_caps =3D BIT(DRM_MODE_BLEND_PIXEL_NONE) |
>  					  BIT(DRM_MODE_BLEND_PREMULTI) |
>  					  BIT(DRM_MODE_BLEND_COVERAGE);

Not sure where the full patch set is, but this does make the warning
go away.

Tested-by: Joshua Peisach <jpeisach@ubuntu.com>
