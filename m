Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A293C5CFC1
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Aug 2026 07:01:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31C8D10E67E;
	Mon, 17 Aug 2026 07:01:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=spasswolf@web.de header.b="e6kYapuQ";
	dkim-atps=neutral
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C738710F66E
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 15:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1786720623; x=1787325423; i=spasswolf@web.de;
 bh=hFk7A3Hga2ecZPHi4AsnGUOdUM6GiEXHY4BW4+o9Tms=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=e6kYapuQwmE9Ao10An5XBz7+C3gn0g7R+JEqkHJoPcHO7u1tZjd7lLgeyDL/PKgU
 QFEd3W/ZMju7HWltYxpkLeSXPv4eSVOZpI7lAxezZ229KPCkJELWhJ7QipCT/7pSh
 3O9PtjenVn8qVoI8Fq86iYNkmekVkydNzOQsklpoAo1OlUMsTUME0HXlu+bQe0sVb
 +lGGi9Ura0fSPq9eD3rGnyCJYyZ81zEyZychzAE2T+WUu+cQy3FKu574C6oCXpAT9
 YPSJkecGc+Ios+DjeYheF8s+docsAcMGA9kBCNRIcVO9mplMNQtQWwk53/6ctSwLZ
 2EFdi5s0qAWbXFtXAQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MfKxj-1xMnga1dOt-00j762; Fri, 14
 Aug 2026 17:17:03 +0200
From: Bert Karwatzki <spasswolf@web.de>
To: linux-kernel@vger.kernel.org
Cc: Bert Karwatzki <spasswolf@web.de>, linux-next@vger.kernel.org,
 Alex Deucher <alexander.deucher@amd.com>,
 Leandro Ribeiro <leandro.ribeiro@collabora.com>,
 "Wentland, Harry" <Harry.Wentland@amd.com>, Leo Li <Sunpeng.Li@amd.com>,
 Alex Hung <alex.hung@amd.com>, amd-gfx@lists.freedesktop.org,
 Jesse Zhang <jesse.zhang@amd.com>, Amber Lin <Amber.Lin@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 1/8] display: fix blend_mode for non-overlay planes
Date: Fri, 14 Aug 2026 17:17:00 +0200
Message-ID: <20260814151701.65222-1-spasswolf@web.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <514c5423b98376e2e6f1fe4bb56c0f3607b4cd52.camel@web.de>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1sEBU9lz15Dmjo8p1ofV2vkfxDivMNI/rM5z9s2l2iIjBJKzkeU
 8N45NFq9PJkQNDOIURkikeKUlPsQ1l6YjlamIh4Z1gDfsWFhg2F8uEh019kFYjyoFr1wn6E
 Fk7b2o1SF1HxSG1ga3LpimAqLhOKAgSWVJ1dCE72v7PrHQoNLv8nAGNEObZD+nC/xzfrLdu
 kqxRtgEi6XWpwUgtZPffg==
UI-OutboundReport: notjunk:1;M01:P0:kWOmFJ2rfbg=;3n7cLuPnhOmQPCsRTNRg60RrDR2
 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
 alj2HbA==
X-Mailman-Approved-At: Mon, 17 Aug 2026 07:01:16 +0000
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

Previously drm_plane_create_blend_mode_property() was only called for
planes of type DRM_PLANE_TYPE_OVERLAY. Since commit commit 860e748bddcc
("drm: ensure blend mode supported if pixel format with alpha exposed")
this results in warnings from validate_blend_mode_for_alpha_formats().
We fix this here by calling drm_plane_create_blend_mode_property() for
all plane types if the plane is supporting a format with
per_pixel_alpha.

Signed-off-by: Bert Karwatzki <spasswolf@web.de>
=2D--
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c  | 5 ++++-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c | 3 +--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/driv=
ers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index 62eac6e65334..a6a54351ea56 100644
=2D-- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -755,13 +755,16 @@ int amdgpu_dm_crtc_init(struct amdgpu_display_manage=
r *dm,
 	struct drm_plane *cursor_plane;
 	bool has_degamma;
 	int res =3D -ENOMEM;
+	struct dc_plane_cap dummy_cap =3D {
+		.per_pixel_alpha =3D 1,
+	};
=20
 	cursor_plane =3D kzalloc_obj(*cursor_plane);
 	if (!cursor_plane)
 		goto fail;
=20
 	cursor_plane->type =3D DRM_PLANE_TYPE_CURSOR;
-	res =3D amdgpu_dm_plane_init(dm, cursor_plane, 0, NULL);
+	res =3D amdgpu_dm_plane_init(dm, cursor_plane, 0, &dummy_cap);
=20
 	acrtc =3D kzalloc_obj(struct amdgpu_crtc);
 	if (!acrtc)
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/dri=
vers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index 824ef3ce5de0..4c0c6a8a0dac 100644
=2D-- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -2208,8 +2208,7 @@ int amdgpu_dm_plane_init(struct amdgpu_display_manag=
er *dm,
 	if (res)
 		return res;
=20
-	if (plane->type =3D=3D DRM_PLANE_TYPE_OVERLAY &&
-	    plane_cap && plane_cap->per_pixel_alpha) {
+	if (plane_cap && plane_cap->per_pixel_alpha) {
 		unsigned int blend_caps =3D BIT(DRM_MODE_BLEND_PIXEL_NONE) |
 					  BIT(DRM_MODE_BLEND_PREMULTI) |
 					  BIT(DRM_MODE_BLEND_COVERAGE);
=2D-=20
2.55.0

