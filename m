Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B075C83F10
	for <amd-gfx@archiver.kernel.org>; Sat, 12 Jul 2025 14:13:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CF5F10E16A;
	Sat, 12 Jul 2025 14:13:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=protonmail.com header.i=@protonmail.com header.b="H51IS8LT";
	dkim-atps=neutral
Received: from mail-4327.protonmail.ch (mail-4327.protonmail.ch [185.70.43.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6187710E3CC
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jul 2025 21:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1752270047; x=1752529247;
 bh=hJ0jSzcfOdcIeibWpnzc5LfKFvCLTxGO8F/0VNnJlgQ=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=H51IS8LT3w4HQoTbwB9r7RnEJGxRzOQB4EwLvQv7ovnUnB89v2rcPX/EgXzOSGrOi
 2soot8EZW08LsGTDPHM+W//gM3Moi4/VvEp/laYHucQNp/R8SoIcgQNsRo55LhUZPD
 BQYESJrXJJ21njZ8GIugMI3C2CYFj7eFRjGucS7H474VAjg6bMSAzS9PdOfDQhOrPW
 5oI9KCRiJgva2ZyPjr6OzlPgBcNX7ntlHSFHbMT3tmcbeSmUXT+tmlnB+Z3fl9d07z
 3Xl6nBT556T+czTMFs67chanGiXjDb5T2N5uDF+iVQcjz+2tW+cP1nK0U1P8CH9SMM
 ppSB8Qg3ZFyYw==
Date: Fri, 11 Jul 2025 21:40:41 +0000
To: amd-gfx@lists.freedesktop.org
From: Umio Yasuno <coelacanth_dream@protonmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>,
 Ma Jun <Jun.Ma2@amd.com>
Subject: [PATCH] drm/amd/pm: fix null pointer access
Message-ID: <20250711213720.48928-1-coelacanth_dream@protonmail.com>
Feedback-ID: 19510729:user:proton
X-Pm-Message-ID: 1e366993ce0a54a14c99e159dbbbfe7831f86801
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sat, 12 Jul 2025 14:13:40 +0000
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
---
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


