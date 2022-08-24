Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CED3CC00140
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Aug 2022 15:09:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8D51112E41;
	Wed, 24 Aug 2022 15:09:24 +0000 (UTC)
Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 284F210FF86
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Aug 2022 15:09:03 +0000 (UTC)
Date: Wed, 24 Aug 2022 15:08:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail3; t=1661353740; x=1661612940;
 bh=n1A2ggxu3pIYdjxTxMkSPhFHZAStB51cg+/tPzAJRSs=;
 h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
 References:Feedback-ID:From:To:Cc:Date:Subject:Reply-To:
 Feedback-ID:Message-ID;
 b=UtyS4dzxz0bwlsZ2cDy7jrD1+uI88WPAJ2JPFj+B9xNiNULTyZumtpJde47eL4gQ2
 egIjQGmQSQsaeixIIU2/Qc26bOp7Ut7dV4WRYye+as1e1zyw7ui36wJuMk6Y1uSjjW
 FI8iOQsEoVtrHNloqakg9Vk5jo7Cj2yrh7KLFZg5O/X/+51bGL2CzaMr0BF0bYHMiq
 +5UrYApW1tf6zrIevt4+iwJmg/l6RIWHR6zmtU7z5oXzmindeZVoE+fN4MlHo6rG2K
 i7ImrhvAHEG8opd2Q+k3nYwSP8+yMvYXE/V9Ir16pZU8bwuKrTllF5LVKMxyuM/NAm
 KA+ffxurZ5k4w==
To: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
From: Simon Ser <contact@emersion.fr>
Subject: [PATCH 2/4] drm: allow DRM_MODE_PAGE_FLIP_ASYNC for atomic commits
Message-ID: <20220824150834.427572-3-contact@emersion.fr>
In-Reply-To: <20220824150834.427572-1-contact@emersion.fr>
References: <20220824150834.427572-1-contact@emersion.fr>
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
Reply-To: Simon Ser <contact@emersion.fr>
Cc: daniel.vetter@ffwll.ch, mwen@igalia.com, alexander.deucher@amd.com,
 hwentlan@amd.com, nicholas.kazlauskas@amd.com, joshua@froggi.es
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

If the driver supports it, allow user-space to supply the
DRM_MODE_PAGE_FLIP_ASYNC flag to request an async page-flip.
Set drm_crtc_state.async_flip accordingly.

Signed-off-by: Simon Ser <contact@emersion.fr>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Joshua Ashton <joshua@froggi.es>
Cc: Melissa Wen <mwen@igalia.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Harry Wentland <hwentlan@amd.com>
Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/drm_atomic_uapi.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic=
_uapi.c
index 79730fa1dd8e..ee24ed7e2edb 100644
--- a/drivers/gpu/drm/drm_atomic_uapi.c
+++ b/drivers/gpu/drm/drm_atomic_uapi.c
@@ -1278,6 +1278,18 @@ static void complete_signaling(struct drm_device *de=
v,
 =09kfree(fence_state);
 }
=20
+static void
+set_async_flip(struct drm_atomic_state *state)
+{
+=09struct drm_crtc *crtc;
+=09struct drm_crtc_state *crtc_state;
+=09int i;
+
+=09for_each_new_crtc_in_state(state, crtc, crtc_state, i) {
+=09=09crtc_state->async_flip =3D true;
+=09}
+}
+
 int drm_mode_atomic_ioctl(struct drm_device *dev,
 =09=09=09  void *data, struct drm_file *file_priv)
 {
@@ -1318,9 +1330,16 @@ int drm_mode_atomic_ioctl(struct drm_device *dev,
 =09}
=20
 =09if (arg->flags & DRM_MODE_PAGE_FLIP_ASYNC) {
-=09=09drm_dbg_atomic(dev,
-=09=09=09       "commit failed: invalid flag DRM_MODE_PAGE_FLIP_ASYNC\n");
-=09=09return -EINVAL;
+=09=09if (!dev->mode_config.async_page_flip) {
+=09=09=09drm_dbg_atomic(dev,
+=09=09=09=09       "commit failed: DRM_MODE_PAGE_FLIP_ASYNC not supported\=
n");
+=09=09=09return -EINVAL;
+=09=09}
+=09=09if (dev->mode_config.atomic_async_page_flip_not_supported) {
+=09=09=09drm_dbg_atomic(dev,
+=09=09=09=09       "commit failed: DRM_MODE_PAGE_FLIP_ASYNC not supported =
with atomic\n");
+=09=09=09return -EINVAL;
+=09=09}
 =09}
=20
 =09/* can't test and expect an event at the same time. */
@@ -1418,6 +1437,9 @@ int drm_mode_atomic_ioctl(struct drm_device *dev,
 =09if (ret)
 =09=09goto out;
=20
+=09if (arg->flags & DRM_MODE_PAGE_FLIP_ASYNC)
+=09=09set_async_flip(state);
+
 =09if (arg->flags & DRM_MODE_ATOMIC_TEST_ONLY) {
 =09=09ret =3D drm_atomic_check_only(state);
 =09} else if (arg->flags & DRM_MODE_ATOMIC_NONBLOCK) {
--=20
2.37.2


