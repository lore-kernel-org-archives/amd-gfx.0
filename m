Return-Path: <SRS0=Av9g=OK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 810CFC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Sep 2021 10:31:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37D0160ED7
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Sep 2021 10:31:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 37D0160ED7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=emersion.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFFB689F41;
	Mon, 20 Sep 2021 10:31:52 +0000 (UTC)
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch
 [185.70.40.134])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E841B89F41
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Sep 2021 10:31:51 +0000 (UTC)
Date: Mon, 20 Sep 2021 10:31:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail; t=1632133905;
 bh=538pw+f4s641JXfl2w/imeBv+sAGk2oxK/9OqeBNg+c=;
 h=Date:To:From:Cc:Reply-To:Subject:From;
 b=Dri1j21eQXKeQ957NM0EyzyjWk6LpfhU8U6ObTV0jiMPn0zw95jlEowMUozOxtZuj
 q1WJW4GKIex/uQgqRU8e3oLKpxXdohCvKsCJqzAw/7ougkQe9LIE15TXLsCfJ0zdBa
 h4rk4ip4qjocDLJUi8JXsgfQi5EugS2Y4CmZF0AtxCFxR9HZcfzabI2oL2Rf3iGuXb
 Kkexh5+mNbq8IYwr6mPwTiTgSMJWA5pICH6MsHggbRrnt0cRAWyJxOGLMWYn42u9jh
 /8rnTTH4x1wWaxzLtbG1ode03RLURrUY32TGhkUN0YZUZyWL6+GOs8dN6wp+DtFDAG
 FTUjSnhV5mNOA==
To: amd-gfx@lists.freedesktop.org
From: Simon Ser <contact@emersion.fr>
Cc: stable@vger.kernel.org, Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <hwentlan@amd.com>,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
 =?utf-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Subject: [PATCH] amdgpu: check tiling flags when creating FB on GFX8-
Message-ID: <20210920103133.3573-1-contact@emersion.fr>
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

On GFX9+, format modifiers are always enabled and ensure the
frame-buffers can be scanned out at ADDFB2 time.

On GFX8-, format modifiers are not supported and no other check
is performed. This means ADDFB2 IOCTLs will succeed even if the
tiling isn't supported for scan-out, and will result in garbage
displayed on screen [1].

Fix this by adding a check for tiling flags for GFX8 and older.
The check is taken from radeonsi in Mesa (see how is_displayable
is populated in gfx6_compute_surface).

[1]: https://github.com/swaywm/wlroots/issues/3185

Signed-off-by: Simon Ser <contact@emersion.fr>
Cc: stable@vger.kernel.org
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Harry Wentland <hwentlan@amd.com>
Cc: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Cc: Michel D=C3=A4nzer <michel@daenzer.net>
Cc: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 31 +++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_display.c
index 58bfc7f00d76..dfe434a56a8c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -837,6 +837,28 @@ static int convert_tiling_flags_to_modifier(struct amd=
gpu_framebuffer *afb)
 =09return 0;
 }
=20
+/* Mirrors the is_displayable check in radeonsi's gfx6_compute_surface */
+static int check_tiling_flags_gfx6(struct amdgpu_framebuffer *afb)
+{
+=09u64 micro_tile_mode;
+
+=09/* Zero swizzle mode means linear */
+=09if (AMDGPU_TILING_GET(afb->tiling_flags, SWIZZLE_MODE) =3D=3D 0)
+=09=09return 0;
+
+=09micro_tile_mode =3D AMDGPU_TILING_GET(afb->tiling_flags, MICRO_TILE_MOD=
E);
+=09switch (micro_tile_mode) {
+=09case 0: /* DISPLAY */
+=09case 3: /* RENDER */
+=09=09return 0;
+=09default:
+=09=09drm_dbg_kms(afb->base.dev,
+=09=09=09    "Micro tile mode %llu not supported for scanout\n",
+=09=09=09    micro_tile_mode);
+=09=09return -EINVAL;
+=09}
+}
+
 static void get_block_dimensions(unsigned int block_log2, unsigned int cpp=
,
 =09=09=09=09 unsigned int *width, unsigned int *height)
 {
@@ -1103,6 +1125,7 @@ int amdgpu_display_framebuffer_init(struct drm_device=
 *dev,
 =09=09=09=09    const struct drm_mode_fb_cmd2 *mode_cmd,
 =09=09=09=09    struct drm_gem_object *obj)
 {
+=09struct amdgpu_device *adev =3D drm_to_adev(dev);
 =09int ret, i;
=20
 =09/*
@@ -1122,6 +1145,14 @@ int amdgpu_display_framebuffer_init(struct drm_devic=
e *dev,
 =09if (ret)
 =09=09return ret;
=20
+=09if (!dev->mode_config.allow_fb_modifiers) {
+=09=09drm_WARN(dev, adev->family >=3D AMDGPU_FAMILY_AI,
+=09=09=09 "GFX9+ requires FB check based on format modifier\n");
+=09=09ret =3D check_tiling_flags_gfx6(rfb);
+=09=09if (ret)
+=09=09=09return ret;
+=09}
+
 =09if (dev->mode_config.allow_fb_modifiers &&
 =09    !(rfb->base.flags & DRM_MODE_FB_MODIFIERS)) {
 =09=09ret =3D convert_tiling_flags_to_modifier(rfb);

base-commit: cdccf1ffe1a37f5eb84a2d2096abe1dd6dbeeec3
--=20
2.33.0


