Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2BB1C2FC0E
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Aug 2023 10:53:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 363E210E442;
	Thu, 17 Aug 2023 10:53:23 +0000 (UTC)
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1890D10E442
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Aug 2023 10:53:20 +0000 (UTC)
Date: Thu, 17 Aug 2023 10:53:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail2; t=1692269597; x=1692528797;
 bh=pLpZkjMsAF/xzWoxIw6c8JsgU8UpAXqqMohyUmW2kqQ=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=fm9g3+1DH1CBxkkUsnL+cEayu4CytC15LBweqtDu9z72g7C51CgV+6dTihizKS8Px
 TD+jpCz3ukZkMi9eMlEyRIYPvBxh1GwCaP+qHP6PEbikZrvCEDCyV/X8SsS4Ey837W
 +nHQSVUuuPemLMeDGyKc3HcvZYQ5GcKIo9IyPQJZTlf6XwVM/otrTMRXJkpUnnjkz5
 vnIGAZFA+BBI86aW0HqrFL2mLAaHvRQIXv2aTYMYDe+3tHojjv1z13yFZJEP+tKSp/
 HGppA+5tA2iy7KWM8JfTR9SN6utQbBIjrsXZLztIxVo1uFvhwAUlaHBsmVZ2xHwRG3
 yS3oS5dKoSHaQ==
To: amd-gfx@lists.freedesktop.org
From: Simon Ser <contact@emersion.fr>
Subject: [PATCH v3 3/4] amd/display: add cursor rotation check
Message-ID: <20230817105251.103228-4-contact@emersion.fr>
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

The commit 1347385fe187 ("drm/amd/display: don't expose rotation
prop for cursor plane") removed the rotation property for the
cursor plane, assuming the cursor would always be displayed without
any rotation. However the rotation is inherited from the underlying
plane.

As a result, if the primary plane is rotated, then the cursor plane
will incorrectly be rotated as well even though it doesn't have a
rotation property.

To fix this, check that the underlying plane isn't rotated.

Signed-off-by: Simon Ser <contact@emersion.fr>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Harry Wentland <hwentlan@amd.com>
Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Cc: Michel D=C3=A4nzer <michel@daenzer.net>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index df40f74f5a15..aba01255ba12 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -9867,6 +9867,13 @@ static int dm_check_crtc_cursor(struct drm_atomic_st=
ate *state,
 =09=09=09return -EINVAL;
 =09=09}
=20
+=09=09if (new_underlying_state->rotation !=3D DRM_MODE_ROTATE_0) {
+=09=09=09drm_dbg_atomic(crtc->dev,
+=09=09=09=09       "Cursor [PLANE:%d:%s] can't be used with rotated underl=
ying [PLANE:%d:%s]\n",
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


