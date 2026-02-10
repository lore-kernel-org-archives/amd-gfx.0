Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39FD9EA3F21
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Feb 2026 08:20:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C89DE10E4E3;
	Tue, 10 Feb 2026 08:20:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=proton.me header.i=@proton.me header.b="IiYxKvjs";
	dkim-atps=neutral
Received: from mail-4321.protonmail.ch (mail-4321.protonmail.ch [185.70.43.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F25110E4D8
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Feb 2026 07:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail; t=1770708247; x=1770967447;
 bh=8k4jRBizb8wbTH2MvFjtt8bKoAW5NJA/sTHOq7f3wvA=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=IiYxKvjsVaNFdnWmNX2n0R0EKLWvK1FZJC9JR2YgMvlLHbooKrSQHiQQGdf9Rrctd
 W0avumKMbvp2npUqMFKIYu7uAtzb164u2snGYPuUrHP1nmAeuEETybbPqT2eNFj2Ge
 JJf/sD8GkxMUCM8kNngIRUHPmELp5fa+e5DVACgGfNgqKfnqujlGCPDXlGDqnjEAJF
 2nWyk+U64IU89LOQD6yxYXuSFBULv0fuHGJu1R+QPYjIlN0A3pkLUvnBP9tnfmFs2w
 UwWbZYN214NKJS6Ht3WOU+Zmo6Dg1zK7fhz0H3pmtFV4FpmrsfZVR0jEj981JgdPbK
 i7Vsf5lcaybkw==
Date: Tue, 10 Feb 2026 07:24:01 +0000
To: amd-gfx@lists.freedesktop.org
From: decce6 <decce6@proton.me>
Cc: decce6 <decce6@proton.me>, Kenneth Feng <kenneth.feng@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?utf-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 =?utf-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Lijo Lazar <lijo.lazar@amd.com>,
 Alexandre Demers <alexandre.f.demers@gmail.com>, "chr[]" <chris@rudorff.com>,
 Sunil Khatri <sunil.khatri@amd.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amdgpu: Add HAINAN clock adjustment
Message-ID: <20260210072309.14911-1-decce6@proton.me>
Feedback-ID: 132957244:user:proton
X-Pm-Message-ID: 1d446622ab18ce7d7d96c3c5e595d9a3697351a4
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 10 Feb 2026 08:20:22 +0000
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch limits the clock speeds of the AMD Radeon R5 M420 GPU from
850/1000MHz (core/memory) to 800/950 MHz, making it work stably. This
patch is for amdgpu.

Signed-off-by: decce6 <decce6@proton.me>
---
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/a=
md/pm/legacy-dpm/si_dpm.c
index 1f539cc65f41..b5d895537477 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
@@ -3468,6 +3468,11 @@ static void si_apply_state_adjust_rules(struct amdgp=
u_device *adev,
 =09=09=09max_sclk =3D 60000;
 =09=09=09max_mclk =3D 80000;
 =09=09}
+=09=09if ((adev->pdev->device =3D=3D 0x666f) &&
+=09=09    (adev->pdev->revision =3D=3D 0x00)) {
+=09=09=09max_sclk =3D 80000;
+=09=09=09max_mclk =3D 95000;
+=09=09}
 =09} else if (adev->asic_type =3D=3D CHIP_OLAND) {
 =09=09if ((adev->pdev->revision =3D=3D 0xC7) ||
 =09=09    (adev->pdev->revision =3D=3D 0x80) ||
--=20
2.43.0


