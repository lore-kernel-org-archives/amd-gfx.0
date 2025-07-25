Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1D24C87FCD
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Jul 2025 03:12:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A4FE10E413;
	Fri, 25 Jul 2025 03:12:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="C6KP9xxm";
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F39D310E412
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Jul 2025 03:12:31 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 0D34C5C69A2;
 Fri, 25 Jul 2025 03:12:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62482C4CEF6;
 Fri, 25 Jul 2025 03:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1753413150;
 bh=wuUXX73O4Iz11Mt/D5AcISQdNlm41Uixp/9nTGpEqI8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=C6KP9xxmtlXt8U8TbrmGh0Yyxz1LbnTDkF4sp58AkiJUiScmhQSzVqqPOMO72BDOj
 d21TYI5ZVWVKsFP3fmV9d6nlkIqAY3WBCQwLODhtO4Y5ShHyTzb17qX6VJjuJ61aES
 c8ZQGS4F0mpiAR8OB6Gd9m6DFFWKknE7i1QdoGihLURlIQy87Z/eDXZ/X1FY7c93yb
 OD4SF08e6Y4l4MU6Lw0I3k3lo2/lsNk+4dXM5iHYWAR2Ghph7cp09XO6S1yBbDKKcR
 J9lnBNCJUnIIbRpt7GvevIEkrEx4qfK94lFQRHc3wQwZnmsnYCg2CXKRr9zKHbILH4
 rTqMha8bV5uhQ==
From: Mario Limonciello <superm1@kernel.org>
To: amd-gfx@lists.freedesktop.org
Cc: Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 1/2] drm/amd: Restore cached power limit during resume
Date: Thu, 24 Jul 2025 22:12:21 -0500
Message-ID: <20250725031222.3015095-2-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250725031222.3015095-1-superm1@kernel.org>
References: <20250725031222.3015095-1-superm1@kernel.org>
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

The power limit will be cached in smu->current_power_limit but
if the ASIC goes into S3 this value won't be restored.

Restore the value during SMU resume.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index d79a1d94661a5..7537964c3c998 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2175,6 +2175,12 @@ static int smu_resume(struct amdgpu_ip_block *ip_block)
 
 	adev->pm.dpm_enabled = true;
 
+	if (smu->current_power_limit) {
+		ret = smu_set_power_limit(smu, smu->current_power_limit);
+		if (ret && ret != -EOPNOTSUPP)
+			return ret;
+	}
+
 	dev_info(adev->dev, "SMU is resumed successfully!\n");
 
 	return 0;
-- 
2.43.0

