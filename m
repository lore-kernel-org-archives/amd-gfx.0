Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ACFEEB64DD
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Aug 2023 10:53:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B41810E051;
	Thu, 17 Aug 2023 10:53:12 +0000 (UTC)
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E82310E442
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Aug 2023 10:53:08 +0000 (UTC)
Date: Thu, 17 Aug 2023 10:53:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail2; t=1692269586; x=1692528786;
 bh=NiDVN4jcg6mPbWta1MYd2uLSseaTYGfgk3v6KuyVmMc=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=dNY5MsuogKiYdOP3gA2Bs6nZipnaJseRVwhh3JVYKkbmt47KOdOlwpEl5MV1zgSZ2
 2nKBhS1E2+tdhtQwn23UTSWsLaRTAo6mDY8ZYCtZ4KBS86oQF7BJJlamirier4X8xg
 0x37b2MOHlzAv5WZkQYhheCk29awNBjinqzIEr0+oXiAXf30o+s7SROIfSYycjKEQu
 hz8lFOgKPP61FXcy2m5C84qCZHoK0WfGqVQ8AU0b42qQbg8H2dC3FUjBuiRUOZZORK
 LUqUkfHwWC6Gytkb4BKMOl/brCAIMGEd0VySLgxct2t8DPSFOnykCQq0JRi+rUA5IP
 WW0OOW/zC6U0g==
To: amd-gfx@lists.freedesktop.org
From: Simon Ser <contact@emersion.fr>
Subject: [PATCH v3 1/4] amd/display: add cursor check for YUV underlying pipe
Message-ID: <20230817105251.103228-2-contact@emersion.fr>
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

The cursor plane can't be displayed if the underlying pipe isn't
using an RGB format. Reject such atomic commits so that user-space
can have a fallback instead of an invisible cursor.

In theory we could support YUV if the cursor is also YUV, but at the
moment only ARGB8888 cursors are supported.

Signed-off-by: Simon Ser <contact@emersion.fr>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Harry Wentland <hwentlan@amd.com>
Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Cc: Michel D=C3=A4nzer <michel@daenzer.net>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 268cb99a4c4b..f60858112d3d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -9844,6 +9844,15 @@ static int dm_check_crtc_cursor(struct drm_atomic_st=
ate *state,
 =09=09=09return -EINVAL;
 =09=09}
=20
+=09=09/* In theory we could probably support YUV cursors when the underlyi=
ng
+=09=09 * plane uses a YUV format, but there's no use-case for it yet. */
+=09=09if (new_underlying_state->fb->format->is_yuv) {
+=09=09=09drm_dbg_atomic(crtc->dev,
+=09=09=09=09       "Cursor [PLANE:%d:%s] can't be used with YUV underlying=
 [PLANE:%d:%s]\n",
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


