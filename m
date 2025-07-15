Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7515AC83F27
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Jul 2025 07:19:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFE0510E23F;
	Wed, 16 Jul 2025 07:19:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=protonmail.com header.i=@protonmail.com header.b="J8QIw5Qp";
	dkim-atps=neutral
Received: from mail-4327.protonmail.ch (mail-4327.protonmail.ch [185.70.43.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28C8689954
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Jul 2025 14:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1752590680; x=1752849880;
 bh=hvhi00gjiKEMGqqIg2U9ZxBYHj2Kh4LS7UuattcsqlM=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=J8QIw5QpTdA8tM2AxmQFrnnLjTgUtDgZvICRad+UylIQC6ceal4ZPYT4nvaw5r0Wk
 F0S0NpXMHNf5wXocYcRGxvw1+CWO5UxpltqwgniUKJmTQqINb+wWQHyHJn7RShkk9k
 1Q/IMS6w4GcFkaMLGWibcnUZLLE0/cmfJLBLnvly/J9aZeTKWE0VI4oJmj46JhMWFz
 ZC3u9GhLSeN1kLrz4CaJRRzaDYlI6026pghpEZSHZwRJWCgwwHW2Euju77fMgSqLGv
 9znZIFL1XGwDHsJYlwMGXSsNNJ3nxmVuopONTeKy5e6WUVBrTypWSe7EVuxAp6VTWu
 LNEnHIib9G4sw==
Date: Tue, 15 Jul 2025 14:44:35 +0000
To: amd-gfx@lists.freedesktop.org
From: Umio Yasuno <coelacanth_dream@protonmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/pm: fix null pointer access
Message-ID: <20250715144315.26642-1-coelacanth_dream@protonmail.com>
Feedback-ID: 19510729:user:proton
X-Pm-Message-ID: e97ea36b95cd3d4d789d47d3641cd7de31f8d45b
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 16 Jul 2025 07:19:36 +0000
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

Writing a string without delimiters (' ', '\n', '\0') to the under
gpu_od/fan_ctrl sysfs or pp_power_profile_mode for the CUSTOM profile
will result in a null pointer dereference.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4401

Signed-off-by: Umio Yasuno <coelacanth_dream@protonmail.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
Thank you for your comment. I just fixed the patch message.

 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c
index edd9895b4..39ee81085 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -1398,6 +1398,8 @@ static ssize_t amdgpu_set_pp_power_profile_mode(struc=
t device *dev,
 =09=09=09if (ret)
 =09=09=09=09return -EINVAL;
 =09=09=09parameter_size++;
+=09=09=09if (!tmp_str)
+=09=09=09=09break;
 =09=09=09while (isspace(*tmp_str))
 =09=09=09=09tmp_str++;
 =09=09}
@@ -3645,6 +3647,9 @@ static int parse_input_od_command_lines(const char *b=
uf,
 =09=09=09return -EINVAL;
 =09=09parameter_size++;
=20
+=09=09if (!tmp_str)
+=09=09=09break;
+
 =09=09while (isspace(*tmp_str))
 =09=09=09tmp_str++;
 =09}
--=20
2.47.2


