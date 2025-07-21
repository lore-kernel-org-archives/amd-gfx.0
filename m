Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3DF0C83F1A
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jul 2025 02:14:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 510EE10E10A;
	Mon, 21 Jul 2025 02:14:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JWEeQP4r";
	dkim-atps=neutral
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BAC010E10A
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Jul 2025 02:14:50 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 30AC7A50A5C;
 Mon, 21 Jul 2025 02:14:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CB14C4CEE7;
 Mon, 21 Jul 2025 02:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1753064088;
 bh=YlWlFbGerR7OWGvt9al5Uv4wUfz9bpSGV7W9CMKmRp4=;
 h=From:To:Cc:Subject:Date:From;
 b=JWEeQP4r0zQxwObCpNEe/m3K0x0HhUecK4W5QuvHEHsk3SdJgD47ZluAej+2oyd0B
 n5u11jUm5BUXITnwpGiXXnVYnPU+jkiCQVfF2MUwnIWLvOdI9NgMIWzBDt5asSDt3e
 is8R2bRIIsKsTL6wLG2SAByiScKJnkTwv3Ez4xO6QFjHFwpPHrr4tDByDISU5GuPDj
 bQtACXButF7BsUhQGxymS0TpziQh9dbB0vuszyz5peNRtizGPz4+Gcx2IAZHt4dpUQ
 pUjtJBG1SNGR5C+vsx3G7/IYwNxAeTN5e3HO5ZXeC1W6e7ZEEs2NUYIn4y5XxAK5UL
 zxZkRagJ8w3ng==
From: Mario Limonciello <superm1@kernel.org>
To: amd-gfx@lists.freedesktop.org
Cc: Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 0/3] Add IGT test for compositor control of ABM
Date: Sun, 20 Jul 2025 21:13:16 -0500
Message-ID: <20250721021320.2346961-1-superm1@kernel.org>
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

After the Display Next 2025 hackfest a patch series was introduced to
allow the compositor to control ABM. sysfs writes are blocked when set.

Add support for testing that the writes really are blocked.

Link: https://lore.kernel.org/amd-gfx/20250718192045.2091650-1-superm1@kernel.org/T/#m5124cd2eb62e50f220f462c5bd8e9043a035dd81

Mario Limonciello (3):
  tests/amdgpu: Remove unneeded includes
  tests/amdgpu: Rename set_abm_level to set_abm_level_sysfs
  tests/amdgpu: Add support for testing compositor control of ABM

 tests/amdgpu/amd_abm.c | 103 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 91 insertions(+), 12 deletions(-)

-- 
2.50.1

