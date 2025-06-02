Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF29BC5B555
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Jun 2025 01:44:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5088A10E45C;
	Mon,  2 Jun 2025 01:44:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="A9cvP680";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C39010E174
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Jun 2025 01:44:46 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 71C0B61127;
 Mon,  2 Jun 2025 01:44:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3DB3C4CEE7;
 Mon,  2 Jun 2025 01:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1748828680;
 bh=w5r5SeHc37+UD8EAGYS7R8Ty8dvRsT8Te6+stFvuwcs=;
 h=From:To:Cc:Subject:Date:From;
 b=A9cvP680BnnApmWRZIJd78sMwedT017IRjESQxCeTiewgtomUdrGDGxNXH43ntY4h
 /DDr2za+z7bHcbs0XUjnZn3/7cd+BjiidZEu9Fpausw1k0oJ/I1tvkkaDC11JAhu25
 I6bEsys8wTBNqR88gU0cnbR6jHN4ATC9JssBtLTvGP3J8Mzallyz0l7Z888+IDR/yJ
 D/5Dtlorfc7yxu10QfEe6hQYG626UtX6h5vWzE10M2yX/+Y2pnpj32YFMbsIlEgXcb
 9Bk4mioCKQwstk/pRnaHC2sby02bsMKbvRt5M9/nxmP5pTz3EFyD4lFmwD6RhyXla1
 r8/PU5lSbe1Tg==
From: Mario Limonciello <superm1@kernel.org>
To: amd-gfx@lists.freedesktop.org
Cc: Chris Bainbridge <chris.bainbridge@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 0/3] Handle aborted suspend better
Date: Sun,  1 Jun 2025 20:44:29 -0500
Message-ID: <20250602014432.3538345-1-superm1@kernel.org>
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

Chris Bainbridge reported some list corruption occurring around the
suspend sequence when an aborted suspend occurs.

I couldn't reproduce this specific problem, but when I tried I found
some other issues where the cached DM state isn't properly destroyed.

This is because there isn't a complete() callback to match the prepare()
callback used by amdgpu. Normally the PM core will call complete() after
every suspend attempt (succesful or not).

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/4280

Mario Limonciello (3):
  drm/amd: Add support for a complete pmops action
  drm/amd/display: Stop storing failures into adev->dm.cached_state
  drm/amd/display: Destroy cached state in complete() callback

 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  22 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   2 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 125 +++++++++++-------
 drivers/gpu/drm/amd/include/amd_shared.h      |   1 +
 5 files changed, 103 insertions(+), 48 deletions(-)

-- 
2.43.0

