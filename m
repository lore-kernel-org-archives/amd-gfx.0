Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71532C87FCC
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Jul 2025 03:12:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAB0910E3FF;
	Fri, 25 Jul 2025 03:12:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HqYHFdRA";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43A0310E3FF
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Jul 2025 03:12:31 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 6D081601EA;
 Fri, 25 Jul 2025 03:12:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2C1FC4CEEF;
 Fri, 25 Jul 2025 03:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1753413150;
 bh=gBVJKWkjRYncHw/GLlE78qOWMSmPprFRRHale2QDS68=;
 h=From:To:Cc:Subject:Date:From;
 b=HqYHFdRAxFXBintXF2RjSbIuSKxIJVY4vBh6AwPwTAiZuXz55IXyvyJHUxAA3b5m9
 hDxxnCqSNYTnFN4/Ow53gQpGwxNivkY/8mDw9pL+uutOTYOS+Jn4BJn2MkoLKtBqJ0
 iAEqxSISLucrpYNJhPta95KvSH4nBIVz1nJpPbl7kD/6jdnh97y9p58KuZz/thgSiK
 obydEYQPOkuqCqm6KG+NcuvkVI7YHjRb8eiB/sHEOhJyTszImqDvVLLplCdMyJx8t2
 vhdeMXh/Uq9xkoFLjRRSzcyDHHNLUAtwOdJKu/DbBHRMReQ4+Oyx65GGOeWNJfEPBR
 HBoEe+nw81ZPg==
From: Mario Limonciello <superm1@kernel.org>
To: amd-gfx@lists.freedesktop.org
Cc: Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 0/2] Restore cached power limit and custom clocks
Date: Thu, 24 Jul 2025 22:12:20 -0500
Message-ID: <20250725031222.3015095-1-superm1@kernel.org>
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

If userspace has programmed a custom power limit and/or custom clock
table the state will not be maintained across an S3 suspend cycle.

The values are already cached, so restore them in the resume sequence.

Mario Limonciello (2):
  drm/amd: Restore cached power limit during resume
  drm/amd: Restore cached manual clock settings during resume

 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

-- 
2.43.0

