Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 637A7C2FC14
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Aug 2023 10:53:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45D1010E446;
	Thu, 17 Aug 2023 10:53:24 +0000 (UTC)
Received: from mail-4022.proton.ch (mail-4022.proton.ch [185.70.40.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60F0610E442
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Aug 2023 10:53:22 +0000 (UTC)
Date: Thu, 17 Aug 2023 10:53:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail2; t=1692269600; x=1692528800;
 bh=w/7sZIksOoSa8YJMYq1DR0emOqjcL7b+5Bq0YLKEzxw=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=bsrMeOmaKkIL12a9Qw9JK/soxKSS99pJvGGEzn+nysHcTLkv2gD2pCBPEQHLaTWi9
 0DQ0CoAf/TExh1MCP5S0gW5d/Ffw2nbKeBXKSbjl9/cCKG+wuitaJmETeALZJmbzSR
 2pg8Lg3xM+IGrFy9CEtN8HI+JdtG3/h+nyXKnbWilfG4/o8jqmtnmKGVzpb0s9GCBh
 6VNwT0VHpT+mtk0y1QiqtGSf2Vlxmnz9xprSqE+ZLmLQ+QfxnASNN8fNmXpRtj5LGE
 LTuvoFFsHFEYN0vwluGgT3D6/E1MHJhNvIGK5mRTxYvEc9y7B6jVpkVs2moviF0whf
 qUDTtVykJVzEw==
To: amd-gfx@lists.freedesktop.org
From: Simon Ser <contact@emersion.fr>
Subject: [PATCH v3 4/4] amd/display: re-introduce cursor plane rotation prop
Message-ID: <20230817105251.103228-5-contact@emersion.fr>
In-Reply-To: <20230817105251.103228-1-contact@emersion.fr>
References: <20230817105251.103228-1-contact@emersion.fr>
Feedback-ID: 1358184:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?utf-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>,
 Harry Wentland <hwentlan@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Allow user-space to use the cursor plane with a rotated underlying
plane under the condition that both planes have the same rotation.

Signed-off-by: Simon Ser <contact@emersion.fr>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Harry Wentland <hwentlan@amd.com>
Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Cc: Michel D=C3=A4nzer <michel@daenzer.net>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c       | 4 ++--
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c | 3 +--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index aba01255ba12..23ff33c78879 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -9867,9 +9867,9 @@ static int dm_check_crtc_cursor(struct drm_atomic_sta=
te *state,
 =09=09=09return -EINVAL;
 =09=09}
=20
-=09=09if (new_underlying_state->rotation !=3D DRM_MODE_ROTATE_0) {
+=09=09if (new_underlying_state->rotation !=3D new_cursor_state->rotation) =
{
 =09=09=09drm_dbg_atomic(crtc->dev,
-=09=09=09=09       "Cursor [PLANE:%d:%s] can't be used with rotated underl=
ying [PLANE:%d:%s]\n",
+=09=09=09=09       "Cursor [PLANE:%d:%s] rotation doesn't match underlying=
 [PLANE:%d:%s]\n",
 =09=09=09=09       cursor->base.id, cursor->name, underlying->base.id, und=
erlying->name);
 =09=09=09return -EINVAL;
 =09=09}
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/driv=
ers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index 8eeca160d434..1b3ef68f5bc4 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -1487,8 +1487,7 @@ int amdgpu_dm_plane_init(struct amdgpu_display_manage=
r *dm,
 =09=09DRM_MODE_ROTATE_0 | DRM_MODE_ROTATE_90 |
 =09=09DRM_MODE_ROTATE_180 | DRM_MODE_ROTATE_270;
=20
-=09if (dm->adev->asic_type >=3D CHIP_BONAIRE &&
-=09    plane->type !=3D DRM_PLANE_TYPE_CURSOR)
+=09if (dm->adev->asic_type >=3D CHIP_BONAIRE)
 =09=09drm_plane_create_rotation_property(plane, DRM_MODE_ROTATE_0,
 =09=09=09=09=09=09   supported_rotations);
=20
--=20
2.41.0


