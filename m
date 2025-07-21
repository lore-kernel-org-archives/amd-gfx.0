Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9203DC83F3E
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jul 2025 02:14:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 629AF10E46F;
	Mon, 21 Jul 2025 02:14:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="L1B/Wcf7";
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D0C810E243
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Jul 2025 02:14:51 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 0DF845C352B;
 Mon, 21 Jul 2025 02:14:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20F44C4CEEB;
 Mon, 21 Jul 2025 02:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1753064089;
 bh=eUNHcPK3pcHwZwv1Zbc8v3IzjTChfCKOraZl9NmUGhw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=L1B/Wcf7Qj/+x06wVVmZiUTGo8eakkjDN/6g/ITjT8TmvU6ZnW9TSRlFxcY8vMBZ1
 7Q69ZT/XMKRMS0aVB06zdyaCeimMy0Dn+ZMQimpmGmUOit1SIMTWAtGSq9qe3TZ8h5
 ogrAiApo55Y8HW1vcHasmBq9c6IiuIMyHnGu04TTNjH+grkZUvygss+YsqNPWPZRc2
 PQpY5zgpoq8pLjhSADsHAOrycPlM2+YkgxMh8Se42U/PJlE3yHU0LXSGLsYl2+N2Aw
 irielm7L+XYKR2iUspWrskeLC14LpL3Ksh0N7hmLAlbiT+vz3OP7wh4aFotqaSFWD6
 JlwERsuHU5O+A==
From: Mario Limonciello <superm1@kernel.org>
To: amd-gfx@lists.freedesktop.org
Cc: Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 1/3] tests/amdgpu: Remove unneeded includes
Date: Sun, 20 Jul 2025 21:13:17 -0500
Message-ID: <20250721021320.2346961-2-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250721021320.2346961-1-superm1@kernel.org>
References: <20250721021320.2346961-1-superm1@kernel.org>
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

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 tests/amdgpu/amd_abm.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tests/amdgpu/amd_abm.c b/tests/amdgpu/amd_abm.c
index 97813d80f..f55b055f9 100644
--- a/tests/amdgpu/amd_abm.c
+++ b/tests/amdgpu/amd_abm.c
@@ -20,7 +20,6 @@
  * OTHER DEALINGS IN THE SOFTWARE.
  */
 
-#include "igt.h"
 #include "drmtest.h"
 #include "igt_kms.h"
 #include <limits.h>
@@ -28,7 +27,6 @@
 #include <stdbool.h>
 #include <stdlib.h>
 #include <stdio.h>
-#include <string.h>
 #include <fcntl.h>
 #include <time.h>
 
-- 
2.50.1

