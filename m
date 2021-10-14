Return-Path: <SRS0=AM0C=PC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60652C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Oct 2021 15:35:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B60F60ED4
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Oct 2021 15:35:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1B60F60ED4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=emersion.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A53406E16F;
	Thu, 14 Oct 2021 15:35:26 +0000 (UTC)
Received: from mail-40136.proton.ch (mail-40136.proton.ch [185.70.40.136])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DF0D6E16F
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Oct 2021 15:35:25 +0000 (UTC)
Date: Thu, 14 Oct 2021 15:35:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail; t=1634225722;
 bh=j1mECW+vPzc0Mw/48CC43zPn0HB+6IpsBcgg4TIYQME=;
 h=Date:To:From:Cc:Reply-To:Subject:From;
 b=vbfI1OxICGKFhywARmHgcXFvlBluxehnFG1DYO7jhBizRkCv/jkZUOPMlbopqv0xt
 dY8gDFMnkBdqBK8Lv6Vf3+7J1lB1rG3iu8NwBY2YYGvfAeCC3hdIl8QtBPWt5xZhQd
 rCfFqMzgLboEutprBxnVw0cR3UbvJJQCYsEWZx/ggb5+dLbryumeah8haU0FpuaMRk
 MI9P3xJwL4Wbp8X0H4gIxN+9g4KE9FHWA+LYP1VmOvtSQW8DHh103FFhZJiFTwN7iH
 okowYM8G+Mc6RNzctKBzmEQc1GykQHH6T2vS8j2sHLi48m1CZFQNv9EgDPDhxhzmvV
 DHAZMPSNdaDnA==
To: amd-gfx@lists.freedesktop.org
From: Simon Ser <contact@emersion.fr>
Cc: Alex Deucher <alexander.deucher@amd.com>, Harry Wentland <hwentlan@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Sean Paul <seanpaul@chromium.org>
Subject: [PATCH] amd/display: remove ChromeOS workaround
Message-ID: <20211014153433.169454-1-contact@emersion.fr>
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
Reply-To: Simon Ser <contact@emersion.fr>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This reverts commits ddab8bd788f5 ("drm/amd/display: Fix two cursor duplica=
tion
when using overlay") and e7d9560aeae5 ("Revert "drm/amd/display: Fix overla=
y
validation by considering cursors"").

tl;dr ChromeOS uses the atomic interface for everything except the cursor. =
This
is incorrect and forces amdgpu to disable some hardware features. Let's rev=
ert
the ChromeOS-specific workaround in mainline and allow the Chrome team to k=
eep
it internally in their own tree.

See [1] for more details. This patch is an alternative to [2], which added
ChromeOS detection.

[1]: https://lore.kernel.org/amd-gfx/JIQ_93_cHcshiIDsrMU1huBzx9P9LVQxucx8hQ=
ArpQu7Wk5DrCl_vTXj_Q20m_L-8C8A5dSpNcSJ8ehfcCrsQpfB5QG_Spn14EYkH9chtg0=3D@em=
ersion.fr/
[2]: https://lore.kernel.org/amd-gfx/20211011151609.452132-1-contact@emersi=
on.fr/

Signed-off-by: Simon Ser <contact@emersion.fr>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Harry Wentland <hwentlan@amd.com>
Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Cc: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Sean Paul <seanpaul@chromium.org>
Fixes: ddab8bd788f5 ("drm/amd/display: Fix two cursor duplication when usin=
g overlay")
Fixes: e7d9560aeae5 ("Revert "drm/amd/display: Fix overlay validation by co=
nsidering cursors"")
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 51 -------------------
 1 file changed, 51 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 20065a145851..014c5a9fe461 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -10628,53 +10628,6 @@ static int add_affected_mst_dsc_crtcs(struct drm_a=
tomic_state *state, struct drm
 }
 #endif
=20
-static int validate_overlay(struct drm_atomic_state *state)
-{
-=09int i;
-=09struct drm_plane *plane;
-=09struct drm_plane_state *new_plane_state;
-=09struct drm_plane_state *primary_state, *overlay_state =3D NULL;
-
-=09/* Check if primary plane is contained inside overlay */
-=09for_each_new_plane_in_state_reverse(state, plane, new_plane_state, i) {
-=09=09if (plane->type =3D=3D DRM_PLANE_TYPE_OVERLAY) {
-=09=09=09if (drm_atomic_plane_disabling(plane->state, new_plane_state))
-=09=09=09=09return 0;
-
-=09=09=09overlay_state =3D new_plane_state;
-=09=09=09continue;
-=09=09}
-=09}
-
-=09/* check if we're making changes to the overlay plane */
-=09if (!overlay_state)
-=09=09return 0;
-
-=09/* check if overlay plane is enabled */
-=09if (!overlay_state->crtc)
-=09=09return 0;
-
-=09/* find the primary plane for the CRTC that the overlay is enabled on *=
/
-=09primary_state =3D drm_atomic_get_plane_state(state, overlay_state->crtc=
->primary);
-=09if (IS_ERR(primary_state))
-=09=09return PTR_ERR(primary_state);
-
-=09/* check if primary plane is enabled */
-=09if (!primary_state->crtc)
-=09=09return 0;
-
-=09/* Perform the bounds check to ensure the overlay plane covers the prim=
ary */
-=09if (primary_state->crtc_x < overlay_state->crtc_x ||
-=09    primary_state->crtc_y < overlay_state->crtc_y ||
-=09    primary_state->crtc_x + primary_state->crtc_w > overlay_state->crtc=
_x + overlay_state->crtc_w ||
-=09    primary_state->crtc_y + primary_state->crtc_h > overlay_state->crtc=
_y + overlay_state->crtc_h) {
-=09=09DRM_DEBUG_ATOMIC("Overlay plane is enabled with hardware cursor but =
does not fully cover primary plane\n");
-=09=09return -EINVAL;
-=09}
-
-=09return 0;
-}
-
 /**
  * amdgpu_dm_atomic_check() - Atomic check implementation for AMDgpu DM.
  * @dev: The DRM device
@@ -10856,10 +10809,6 @@ static int amdgpu_dm_atomic_check(struct drm_devic=
e *dev,
 =09=09=09goto fail;
 =09}
=20
-=09ret =3D validate_overlay(state);
-=09if (ret)
-=09=09goto fail;
-
 =09/* Add new/modified planes */
 =09for_each_oldnew_plane_in_state_reverse(state, plane, old_plane_state, n=
ew_plane_state, i) {
 =09=09ret =3D dm_update_plane_state(dc, state, plane,
--=20
2.33.0


