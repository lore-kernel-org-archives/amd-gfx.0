Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16603C7115B
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Jun 2025 04:14:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A37D010E0C1;
	Fri, 20 Jun 2025 04:14:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="c+yohatB";
	dkim-atps=neutral
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9BAD10E0C1
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Jun 2025 04:14:40 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 211E8A4E11F;
 Fri, 20 Jun 2025 04:14:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66523C4CEE3;
 Fri, 20 Jun 2025 04:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1750392870;
 bh=liT4et+IKhwdMP2TTkMhpIAfDQerXADZUawyuMDtSRY=;
 h=From:To:Cc:Subject:Date:From;
 b=c+yohatBq9erriw3eaNxKp1f4LoKpBkB0FP4Dr+ZlGCUFMLjg9WmGzKsKncFmSQNM
 3axxc455JC7irmrBG95IzfuFJiwz89kfEUVoVSues6khVUZRR7OYLByH79xiKFUykH
 DZhZ3AJoXTDEQiZRXJ1V4mOwJ7PqiP4mgat8sYEWvtF4dx/uI+TnS7hygChvnhQXAO
 fI4ZkTXUaRQ3cEbNODD2nRWpFjvCUkt0mYkys/kfXwcaSr4QdwuOTOiGv4gPLhPi4M
 8y2q9zDFuGmYvFwjjQ72BumqWjoV+S+kHYm0gZ9+t9C7+TdY0+G8k4XWdn5NlsK6bW
 zpQFFMG2E66Tg==
From: Mario Limonciello <superm1@kernel.org>
To: amd-gfx@lists.freedesktop.org
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] drm/amd: Add missing kdoc for amd_ip_funcs `complete` callback
Date: Thu, 19 Jun 2025 23:14:20 -0500
Message-ID: <20250620041420.3585005-1-superm1@kernel.org>
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

The `complete` callback should be described in kernel doc.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/linux-next/20250619205931.41cf9332@canb.auug.org.au/
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/include/amd_shared.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index a06e92b1b2ef9..bfb446736ca8c 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -396,6 +396,7 @@ enum amd_dpm_forced_level;
  *                   (such as allocating any required memory)
  * @suspend: handles IP specific hw/sw changes for suspend
  * @resume: handles IP specific hw/sw changes for resume
+ * @complete: handles IP specific changes after resume
  * @is_idle: returns current IP block idle status
  * @wait_for_idle: poll for idle
  * @check_soft_reset: check soft reset the IP block
-- 
2.43.0

