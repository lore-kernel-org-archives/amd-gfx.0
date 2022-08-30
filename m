Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDECEECAAA1
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Aug 2022 17:30:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12E0910E2F0;
	Tue, 30 Aug 2022 17:30:08 +0000 (UTC)
Received: from mail-4022.proton.ch (mail-4022.proton.ch [185.70.40.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83CF610E2E4
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Aug 2022 17:30:01 +0000 (UTC)
Date: Tue, 30 Aug 2022 17:29:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail3; t=1661880599; x=1662139799;
 bh=TwYQy1JNNL4aH2zwxraqWE2mfnEhb4dsi0H7Y0gX+3w=;
 h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
 References:Feedback-ID:From:To:Cc:Date:Subject:Reply-To:
 Feedback-ID:Message-ID;
 b=CmK1WAfvlkKV/KgKgtG7ln3IMVXjxmyel2VFFbQYZI6vPch2Af3xSP8Os8phtYtbZ
 3v+Cg5dkAV9PKIfTr1ibNhO7zJCCwLCjtfW+LlOMDC37XDbiJnCud71iaAQYfzhzSE
 GfzLXJkS37vXfkdY6fsfU15686NVsXho7K38ShbJ1NHOUK3N8vOopAZoG6vjsxY2lr
 veyuQQzU8rUDqMU8AyABuBl2MfZxJIyb8U3U/38yWEDqNJXMd7wkhoOWbAHDzT0cge
 9+JM8e+SijPIPb08VQ8itxuNXKN+ZN70+5gCbXhoimwKseOckfyZfbQAyF7SbVLm5t
 /r+FjC4t52OUA==
To: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 wayland-devel@lists.freedesktop.org
From: Simon Ser <contact@emersion.fr>
Subject: [PATCH v2 6/6] amd/display: indicate support for atomic async
 page-flips on DC
Message-ID: <20220830172851.269402-7-contact@emersion.fr>
In-Reply-To: <20220830172851.269402-1-contact@emersion.fr>
References: <20220830172851.269402-1-contact@emersion.fr>
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
Cc: andrealmeid@igalia.com, daniel.vetter@ffwll.ch, mwen@igalia.com,
 ville.syrjala@linux.intel.com, alexander.deucher@amd.com, hwentlan@amd.com,
 nicholas.kazlauskas@amd.com, joshua@froggi.es
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

amdgpu_dm_commit_planes() already sets the flip_immediate flag for
async page-flips. This flag is used to set the UNP_FLIP_CONTROL
register. Thus, no additional change is required to handle async
page-flips with the atomic uAPI.

v2: make it clear this commit is about DC and not only DCN

Signed-off-by: Simon Ser <contact@emersion.fr>
Cc: Joshua Ashton <joshua@froggi.es>
Cc: Melissa Wen <mwen@igalia.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Harry Wentland <hwentlan@amd.com>
Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Cc: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index c9195e7bb649..7f96d81f4e0d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3804,7 +3804,6 @@ static int amdgpu_dm_mode_config_init(struct amdgpu_d=
evice *adev)
 =09adev_to_drm(adev)->mode_config.prefer_shadow =3D 0;
 =09/* indicates support for immediate flip */
 =09adev_to_drm(adev)->mode_config.async_page_flip =3D true;
-=09adev_to_drm(adev)->mode_config.atomic_async_page_flip_not_supported =3D=
 true;
=20
 =09adev_to_drm(adev)->mode_config.fb_base =3D adev->gmc.aper_base;
=20
--=20
2.37.2


