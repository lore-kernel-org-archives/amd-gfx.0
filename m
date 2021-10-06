Return-Path: <SRS0=XefO=O2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 868FCC433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Oct 2021 14:06:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51A1B6105A
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Oct 2021 14:06:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 51A1B6105A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=emersion.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC5F66E519;
	Wed,  6 Oct 2021 14:06:15 +0000 (UTC)
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA6E16E519
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Oct 2021 14:06:14 +0000 (UTC)
Date: Wed, 06 Oct 2021 14:06:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail; t=1633529171;
 bh=OW1I7xGAQ5I6A4OWhXRaD5G0E2rkYFE7Gx44dkct0Hk=;
 h=Date:To:From:Cc:Reply-To:Subject:From;
 b=W1hx6YmRRFl3kAs+Mh4iGF9tdfN4GtciRdevMJ7tRm4LED/OLwODPs2QOw4qL0Lsh
 2miLiBUN/wH0syQQte1sW2VfvjROjnlEQgIGm4Huc8MNyqoUhqe2LJmJD/Th1Y4D6c
 TIayZbWHCcCy88hFCaxZ1rMKonKZFjWUctqepBG+HSd7809PCiyk19VvD4gCq70lxe
 /l93aEoiHA3q/fP7WtV1wYPeAjdzZ/yxnulW57TcJ7UQG9sgT/mdqCjU8WtboOJB4a
 I3ZgQyBA1GaibRK37WzTOvO0HDBp3J7r+VAYWtf/YShggHVH9knG9I2B9rEZQbszq8
 8k3CWlQueKw+w==
To: amd-gfx@lists.freedesktop.org
From: Simon Ser <contact@emersion.fr>
Cc: Alex Deucher <alexander.deucher@amd.com>, Harry Wentland <hwentlan@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Sean Paul <seanpaul@chromium.org>
Subject: [PATCH v4 1/2] amd/display: check cursor plane matches underlying
 plane
Message-ID: <20211006140558.254349-1-contact@emersion.fr>
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

The current logic checks whether the cursor plane blending
properties match the primary plane's. However that's wrong,
because the cursor is painted on all planes underneath. If
the cursor is over the primary plane and the overlay plane,
it's painted on both pipes.

Iterate over the CRTC planes and check their scaling match
the cursor's.

v4: fix typo in commit message (Harry)

Signed-off-by: Simon Ser <contact@emersion.fr>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Harry Wentland <hwentlan@amd.com>
Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Cc: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Sean Paul <seanpaul@chromium.org>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 49 +++++++++++++------
 1 file changed, 34 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index a399a984b8a6..5746980454e5 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -10517,18 +10517,18 @@ static int dm_check_crtc_cursor(struct drm_atomic=
_state *state,
 =09=09=09=09struct drm_crtc *crtc,
 =09=09=09=09struct drm_crtc_state *new_crtc_state)
 {
-=09struct drm_plane_state *new_cursor_state, *new_primary_state;
-=09int cursor_scale_w, cursor_scale_h, primary_scale_w, primary_scale_h;
+=09struct drm_plane *cursor =3D crtc->cursor, *underlying;
+=09struct drm_plane_state *new_cursor_state, *new_underlying_state;
+=09int i;
+=09int cursor_scale_w, cursor_scale_h, underlying_scale_w, underlying_scal=
e_h;
=20
 =09/* On DCE and DCN there is no dedicated hardware cursor plane. We get a
 =09 * cursor per pipe but it's going to inherit the scaling and
 =09 * positioning from the underlying pipe. Check the cursor plane's
-=09 * blending properties match the primary plane's. */
+=09 * blending properties match the underlying planes'. */
=20
-=09new_cursor_state =3D drm_atomic_get_new_plane_state(state, crtc->cursor=
);
-=09new_primary_state =3D drm_atomic_get_new_plane_state(state, crtc->prima=
ry);
-=09if (!new_cursor_state || !new_primary_state ||
-=09    !new_cursor_state->fb || !new_primary_state->fb) {
+=09new_cursor_state =3D drm_atomic_get_new_plane_state(state, cursor);
+=09if (!new_cursor_state || !new_cursor_state->fb) {
 =09=09return 0;
 =09}
=20
@@ -10537,15 +10537,34 @@ static int dm_check_crtc_cursor(struct drm_atomic=
_state *state,
 =09cursor_scale_h =3D new_cursor_state->crtc_h * 1000 /
 =09=09=09 (new_cursor_state->src_h >> 16);
=20
-=09primary_scale_w =3D new_primary_state->crtc_w * 1000 /
-=09=09=09 (new_primary_state->src_w >> 16);
-=09primary_scale_h =3D new_primary_state->crtc_h * 1000 /
-=09=09=09 (new_primary_state->src_h >> 16);
+=09for_each_new_plane_in_state_reverse(state, underlying, new_underlying_s=
tate, i) {
+=09=09/* Narrow down to non-cursor planes on the same CRTC as the cursor *=
/
+=09=09if (new_underlying_state->crtc !=3D crtc || underlying =3D=3D crtc->=
cursor)
+=09=09=09continue;
=20
-=09if (cursor_scale_w !=3D primary_scale_w ||
-=09    cursor_scale_h !=3D primary_scale_h) {
-=09=09drm_dbg_atomic(crtc->dev, "Cursor plane scaling doesn't match primar=
y plane\n");
-=09=09return -EINVAL;
+=09=09/* Ignore disabled planes */
+=09=09if (!new_underlying_state->fb)
+=09=09=09continue;
+
+=09=09underlying_scale_w =3D new_underlying_state->crtc_w * 1000 /
+=09=09=09=09     (new_underlying_state->src_w >> 16);
+=09=09underlying_scale_h =3D new_underlying_state->crtc_h * 1000 /
+=09=09=09=09     (new_underlying_state->src_h >> 16);
+
+=09=09if (cursor_scale_w !=3D underlying_scale_w ||
+=09=09    cursor_scale_h !=3D underlying_scale_h) {
+=09=09=09drm_dbg_atomic(crtc->dev,
+=09=09=09=09       "Cursor [PLANE:%d:%s] scaling doesn't match underlying =
[PLANE:%d:%s]\n",
+=09=09=09=09       cursor->base.id, cursor->name, underlying->base.id, und=
erlying->name);
+=09=09=09return -EINVAL;
+=09=09}
+
+=09=09/* If this plane covers the whole CRTC, no need to check planes unde=
rneath */
+=09=09if (new_underlying_state->crtc_x <=3D 0 &&
+=09=09    new_underlying_state->crtc_y <=3D 0 &&
+=09=09    new_underlying_state->crtc_x + new_underlying_state->crtc_w >=3D=
 new_crtc_state->mode.hdisplay &&
+=09=09    new_underlying_state->crtc_y + new_underlying_state->crtc_h >=3D=
 new_crtc_state->mode.vdisplay)
+=09=09=09break;
 =09}
=20
 =09return 0;
--=20
2.33.0


