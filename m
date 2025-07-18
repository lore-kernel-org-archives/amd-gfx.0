Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D9F0C83F17
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Jul 2025 19:20:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0707510E088;
	Fri, 18 Jul 2025 19:20:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="g5njN7x5";
	dkim-atps=neutral
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58D1910E088;
 Fri, 18 Jul 2025 19:20:58 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 8B260A5762A;
 Fri, 18 Jul 2025 19:20:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B5DEC4CEF1;
 Fri, 18 Jul 2025 19:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1752866457;
 bh=UMO7VCHRgltCuD5iOMDyxKMHGiUo217+s252zInL0TA=;
 h=From:To:Cc:Subject:Date:From;
 b=g5njN7x5mT92EEmStwxdyGT4wY6TsrnW0vMx5R7WkBevFpC3FtMos8kPnRP/6my5B
 eZHLJYAbaKME0YHOG5EkFNiPZpJVRAOxIzsRZqSPYHcTiGbbAt6V3cE5/NS4BfGUpb
 IyAhELVVQDyjyHb7tiXJ1YYKWEvymJgWW17BnMIKOi/HmXqwYWZ06MIfpj2LKOSfKg
 8oJc2pFjI2smgcFO+/phf/SJaptEFzf6wICR43hVqjpliJ5ZLxeR7Y5zlSPzHYZ9EO
 hiuGlQTtAkIyC0bxhWLBFjEVXvZD1q7xsWO9QPRl9BMfm61ohVzGAuRze8E7GU2dFa
 366+64qJjJuoA==
From: Mario Limonciello <superm1@kernel.org>
To: amd-gfx@lists.freedesktop.org
Cc: Simon Ser <contact@emersion.fr>, Harry Wentland <Harry.Wentland@amd.com>,
 Xaver Hugl <xaver.hugl@gmail.com>, dri-devel@lists.freedesktop.org,
 Leo Li <sunpeng.li@amd.com>, Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v6 0/1] Panel power savings revisit
Date: Fri, 18 Jul 2025 14:20:44 -0500
Message-ID: <20250718192045.2091650-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Mario Limonciello <mario.limonciello@amd.com>

During the 2025 Display Next Hackfest the topic from the 2024 display
next hackfest about what to do with adaptive backlight modulation was
revisited.

The general consensus was that the 2024 proposed solution [1] although
functional was not desirable because it was a binary decision that the
compositor could decide to enable/disable but still couldn't control
the intensity.

The new proposal was to return back to a vendor property. I prototyped
this and wanted to balance the existing userspace using a sysfs file,
and thus it's an enum that will default to letting the sysfs file work,
but if the compositor sets the property to any other value the sysfs
file will turn read only.

I have not yet done IGT for this, but wanted to get it on the list to
make sure folks are amenable to the approach.  If so; I'll write up
an IGT test for it too.

Link: https://lore.kernel.org/dri-devel/20250621152657.1048807-1-superm1@kernel.org/T/#m71d78efe2ef1d6c680b26fca3f74f07a3d9af6f9 [1]

Mario Limonciello (1):
  drm/amd: Re-introduce property to control adaptive
           backlight modulation

 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c   |  8 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h      |  2 ++
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 29 +++++++++++++++++--
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  1 +
 4 files changed, 38 insertions(+), 2 deletions(-)

-- 
2.43.0

