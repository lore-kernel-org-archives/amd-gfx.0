Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3D36EB64DD
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Aug 2023 10:53:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFC6110E443;
	Thu, 17 Aug 2023 10:53:23 +0000 (UTC)
Received: from mail-4018.proton.ch (mail-4018.proton.ch [185.70.40.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B19510E442
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Aug 2023 10:53:22 +0000 (UTC)
Date: Thu, 17 Aug 2023 10:53:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail2; t=1692269600; x=1692528800;
 bh=fLZIP5eaXNjderIZPVMt9YKbdGdx+br5eRRmbc78k6M=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=mlwEKhe7xHoooair4BbREULQNkzJSFQtPz46BvX1VdtMwd16JK/oa31sLLPehkyej
 ILfUauZoVtlApb1ANFEEN5ehLf62AJ/lRJzuKdMNKuDWkn7Rqv8uj7bPVLJhFlEAlw
 ifpgZWswucBpUIloNSB1ghhAJXAavX4zQGzgZ6t39x4V0eH4R6deEaW065GXzamE1h
 ge4pOwrf9FKT3d/OX71ixxbLecY/jZWTJhU1sHlGFv0TXDx0RoROYe6EcYJYtrFTC0
 ath+OaK9n3G16SKVehhCPDjwB5fGWAcfB8Z778GHB9Sf4T5m/ZAonTKS6woCNp/efq
 qnK7PSqHqAccg==
To: amd-gfx@lists.freedesktop.org
From: Simon Ser <contact@emersion.fr>
Subject: [PATCH v3 2/4] amd/display: add cursor alpha and blend mode checks
Message-ID: <20230817105251.103228-3-contact@emersion.fr>
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

We don't want a semi-transparent overlay to make the cursor plane
semi-transparent as well. Same for the pixel blend mode.

Signed-off-by: Simon Ser <contact@emersion.fr>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Harry Wentland <hwentlan@amd.com>
Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Cc: Michel D=C3=A4nzer <michel@daenzer.net>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index f60858112d3d..df40f74f5a15 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -9853,6 +9853,20 @@ static int dm_check_crtc_cursor(struct drm_atomic_st=
ate *state,
 =09=09=09return -EINVAL;
 =09=09}
=20
+=09=09if (new_underlying_state->alpha !=3D DRM_BLEND_ALPHA_OPAQUE) {
+=09=09=09drm_dbg_atomic(crtc->dev,
+=09=09=09=09       "Cursor [PLANE:%d:%s] can't be used with non-opaque und=
erlying [PLANE:%d:%s]\n",
+=09=09=09=09       cursor->base.id, cursor->name, underlying->base.id, und=
erlying->name);
+=09=09=09return -EINVAL;
+=09=09}
+
+=09=09if (new_underlying_state->pixel_blend_mode !=3D DRM_MODE_BLEND_PREMU=
LTI) {
+=09=09=09drm_dbg_atomic(crtc->dev,
+=09=09=09=09       "Cursor [PLANE:%d:%s] can't be used with non-premultipl=
ied underlying [PLANE:%d:%s]\n",
+=09=09=09=09       cursor->base.id, cursor->name, underlying->base.id, und=
erlying->name);
+=09=09=09return -EINVAL;
+=09=09}
+
 =09=09/* If this plane covers the whole CRTC, no need to check planes unde=
rneath */
 =09=09if (new_underlying_state->crtc_x <=3D 0 &&
 =09=09    new_underlying_state->crtc_y <=3D 0 &&
--=20
2.41.0


