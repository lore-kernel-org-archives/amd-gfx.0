Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 344A1D3ABEF
	for <amd-gfx@archiver.kernel.org>; Sun,  7 Dec 2025 19:49:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B21510E35A;
	Sun,  7 Dec 2025 19:49:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Zzc03Zni";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 316B310E2EE
 for <amd-gfx@lists.freedesktop.org>; Sun,  7 Dec 2025 19:49:19 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id E227A600AC;
 Sun,  7 Dec 2025 19:49:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9531C4CEFB;
 Sun,  7 Dec 2025 19:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1765136957;
 bh=FN2jZrN17NYkIKNqhI77JauZu9Rq+aTR5b/WZAOd/R8=;
 h=From:To:Cc:Subject:Date:From;
 b=Zzc03Zniu+J+hvam8lHns7cSGr+C0T5Fuq3mpSAoNECylgSLJtxLGRp9rVkuMDr7r
 FXpl7OjDjqtivlMH3mTba52fnagSHQB+TpbHrYkaaAyDI6+L30CWFnCG9Gmbot6zvN
 I0BerN2jIWZmQueoXLN2CFI7AyLTkzR0QtgPGcQXeshDJU65V53Wx3L/krNuKyDWCp
 1Pr0mMaI5xhHjtnlqBeYaocX/TEcbpPDBOSDDyOgcD9QQqXZMeysZGQaffeMDG0sAf
 cYdqoThB3pxh+ta0qK9HHYG2KLxG6/J1LEGRcZBN+mBJoBuPcsxhyhHcAStqTvkICu
 PUnkoUOOHRrJA==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: amd-gfx@lists.freedesktop.org
Cc: "Mario Limonciello (AMD)" <superm1@kernel.org>,
 Antheas Kapenekakis <lkml@antheas.dev>
Subject: [RFC PATCH 0/1] Runtime suspend for APUs
Date: Sun,  7 Dec 2025 13:49:09 -0600
Message-ID: <20251207194910.122711-1-superm1@kernel.org>
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

Set up APUs to follow similar policies as dGPUs in that they can
potentially runtime suspend.  If an APU is runtime suspended then
prepare it for the matching system state (s0ix or s3) so that steps
can be skipped when runtime suspended.

The thought with this series is that if the compositor has turned
off displays and no other work is running an APU's GPU can enter
runtime PM. If the system later enters system suspend the GPU steps
can be skipped because the GPU is already in the runtime PM state
to match the intended system state.

It's important to note that default runtime PM policy will prevent
entering runtime PM when displays are connected. This can be changed
by setting amdgpu.runpm=-2.

This series isn't yet tested, I just share it for feedback on
the approach. If anyone wants to test it as well, please feel free.

Cc: Antheas Kapenekakis <lkml@antheas.dev>

Mario Limonciello (AMD) (1):
  drm/amd: Expand runtime suspend to APUs

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  6 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 17 +++++++++++++++--
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h    |  1 +
 3 files changed, 22 insertions(+), 2 deletions(-)

-- 
2.43.0

