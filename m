Return-Path: <SRS0=/upn=OT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D1D4C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Sep 2021 19:06:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFB59610A0
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Sep 2021 19:06:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DFB59610A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=emersion.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B013898ED;
	Wed, 29 Sep 2021 19:06:33 +0000 (UTC)
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4BE96E0B8
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Sep 2021 19:06:30 +0000 (UTC)
Date: Wed, 29 Sep 2021 19:06:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail; t=1632942388;
 bh=+8cQR2u19W48XnS/TPvp8JhQHk2vQbVRFzfSOM7p9k4=;
 h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
 b=JF6ZFhYOFVLtkm9H+JCcF6nsjyOY8XrnrS8Nbaed7+gKKx9r/ikpj6b/au50XY7pm
 pDUsrVVxWS/QkRCRpHz9kA2BRtK5sxm00HuJPunM9fUge3gXetvGcW9Vf4mTEIvWFP
 7d9W+VCNdr0YDBSq0eS/JAar8gaxt64yulVG7TcN2uisiKweVlG2ssRNuuqbxKFe3F
 InB8WZMIgnuXuqNziWLTlewra4kzgLJ2XEovUVJRUNMQ1Zi63aMSOEuCZuqOzO+z7C
 VK/u8VUVho4oEqUWimZJueATKMI16OlGrq1UKji9K+808mFerzwHumlKhmT9qDjQ4H
 QNxifG67auicg==
To: amd-gfx@lists.freedesktop.org
From: Simon Ser <contact@emersion.fr>
Cc: Alex Deucher <alexander.deucher@amd.com>, Harry Wentland <hwentlan@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Subject: [PATCH v3 2/2] amd/display: only require overlay plane to cover whole
 CRTC on ChromeOS
Message-ID: <20210929190603.48890-2-contact@emersion.fr>
In-Reply-To: <20210929190603.48890-1-contact@emersion.fr>
References: <20210929190603.48890-1-contact@emersion.fr>
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

Commit ddab8bd788f5 ("drm/amd/display: Fix two cursor duplication when
using overlay") changed the atomic validation code to forbid the
overlay plane from being used if it doesn't cover the whole CRTC. The
motivation is that ChromeOS uses the atomic API for everything except
the cursor plane (which uses the legacy API). Thus amdgpu must always
be prepared to enable/disable/move the cursor plane at any time without
failing (or else ChromeOS will trip over).

As discussed in [1], there's no reason why the ChromeOS limitation
should prevent other fully atomic users from taking advantage of the
overlay plane. Let's limit the check to ChromeOS.

[1]: https://lore.kernel.org/amd-gfx/JIQ_93_cHcshiIDsrMU1huBzx9P9LVQxucx8hQ=
ArpQu7Wk5DrCl_vTXj_Q20m_L-8C8A5dSpNcSJ8ehfcCrsQpfB5QG_Spn14EYkH9chtg0=3D@em=
ersion.fr/

Signed-off-by: Simon Ser <contact@emersion.fr>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Harry Wentland <hwentlan@amd.com>
Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Cc: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Fixes: ddab8bd788f5 ("drm/amd/display: Fix two cursor duplication when usin=
g overlay")
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 6472c0032b54..f06d6e794721 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -10590,6 +10590,10 @@ static int validate_overlay(struct drm_atomic_stat=
e *state)
 =09struct drm_plane_state *new_plane_state;
 =09struct drm_plane_state *primary_state, *overlay_state =3D NULL;
=20
+=09/* This is a workaround for ChromeOS only */
+=09if (strcmp(current->comm, "chrome") !=3D 0)
+=09=09return 0;
+
 =09/* Check if primary plane is contained inside overlay */
 =09for_each_new_plane_in_state_reverse(state, plane, new_plane_state, i) {
 =09=09if (plane->type =3D=3D DRM_PLANE_TYPE_OVERLAY) {
--=20
2.33.0


