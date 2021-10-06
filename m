Return-Path: <SRS0=XefO=O2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C601C433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Oct 2021 14:06:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 513546105A
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Oct 2021 14:06:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 513546105A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=emersion.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1ED46E58A;
	Wed,  6 Oct 2021 14:06:15 +0000 (UTC)
Received: from mail-4022.proton.ch (mail-4022.proton.ch [185.70.40.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A5306E58A
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Oct 2021 14:06:15 +0000 (UTC)
Date: Wed, 06 Oct 2021 14:06:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail; t=1633529171;
 bh=hCGq/OAytj40mhtH8LyiPTMZVhocpl/g+sQCxPDTD8M=;
 h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
 b=C4a7pC07m/+XncNuAhgfL/HDHr5f3OkSqrp3QnSiA8ZMt2NUgXtFqluMLc3sRNILq
 A+QuN4vAEePqJeUlKoKEwa3IP7o6vD6njh0RtKHCn95x/XNIF6wNQmXNaFsA00w9WF
 eEDqi1ccpa8HIvACCn5t3vv3HcIeVdgOQsjeSNd4B94TnMCMRF796HmEu7ABrVQQ4Z
 0/ERGqHhCqokz/SnjulOAjy8sJNJkzwu/BnQ3ni2bYBk89nuHPoSHYrCj4k/IFtjk/
 d0dodvPiesWKqU2TMtgadjly+sCxMF0R1chYbhqPKQN5soYJZhRFmay0T2WM0UN5mo
 VN7FEkgg2SEIQ==
To: amd-gfx@lists.freedesktop.org
From: Simon Ser <contact@emersion.fr>
Cc: Alex Deucher <alexander.deucher@amd.com>, Harry Wentland <hwentlan@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Sean Paul <seanpaul@chromium.org>
Subject: [PATCH v4 2/2] amd/display: only require overlay plane to cover whole
 CRTC on ChromeOS
Message-ID: <20211006140558.254349-2-contact@emersion.fr>
In-Reply-To: <20211006140558.254349-1-contact@emersion.fr>
References: <20211006140558.254349-1-contact@emersion.fr>
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

v4: fix ChromeOS detection (Harry)

[1]: https://lore.kernel.org/amd-gfx/JIQ_93_cHcshiIDsrMU1huBzx9P9LVQxucx8hQ=
ArpQu7Wk5DrCl_vTXj_Q20m_L-8C8A5dSpNcSJ8ehfcCrsQpfB5QG_Spn14EYkH9chtg0=3D@em=
ersion.fr/

Signed-off-by: Simon Ser <contact@emersion.fr>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Harry Wentland <hwentlan@amd.com>
Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Cc: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Sean Paul <seanpaul@chromium.org>
Fixes: ddab8bd788f5 ("drm/amd/display: Fix two cursor duplication when usin=
g overlay")
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 5746980454e5..0b80f779e706 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -10595,6 +10595,26 @@ static int add_affected_mst_dsc_crtcs(struct drm_a=
tomic_state *state, struct drm
 }
 #endif
=20
+static bool is_chromeos(void)
+{
+=09struct mm_struct *mm =3D current->mm;
+=09struct file *exe_file;
+=09bool ret;
+
+=09/* ChromeOS renames its thread to DrmThread. Also check the executable
+=09 * name. */
+=09if (strcmp(current->comm, "DrmThread") !=3D 0 || !mm)
+=09=09return false;
+
+=09exe_file =3D get_mm_exe_file(mm);
+=09if (!exe_file)
+=09=09return false;
+=09ret =3D strcmp(exe_file->f_path.dentry->d_name.name, "chrome") =3D=3D 0=
;
+=09fput(exe_file);
+
+=09return ret;
+}
+
 static int validate_overlay(struct drm_atomic_state *state)
 {
 =09int i;
@@ -10602,6 +10622,10 @@ static int validate_overlay(struct drm_atomic_stat=
e *state)
 =09struct drm_plane_state *new_plane_state;
 =09struct drm_plane_state *primary_state, *overlay_state =3D NULL;
=20
+=09/* This is a workaround for ChromeOS only */
+=09if (!is_chromeos())
+=09=09return 0;
+
 =09/* Check if primary plane is contained inside overlay */
 =09for_each_new_plane_in_state_reverse(state, plane, new_plane_state, i) {
 =09=09if (plane->type =3D=3D DRM_PLANE_TYPE_OVERLAY) {
--=20
2.33.0


