Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF2E1FD0049
	for <amd-gfx@archiver.kernel.org>; Sun,  1 Mar 2026 02:03:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BA9010E3AF;
	Sun,  1 Mar 2026 02:03:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TRO1b5fg";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C13C10E3AD;
 Sun,  1 Mar 2026 02:03:26 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 0C39B60123;
 Sun,  1 Mar 2026 02:03:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C00AC19421;
 Sun,  1 Mar 2026 02:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1772330605;
 bh=EPyp2cKwgi12SOhZru/ZbXWba426Io6EQRZaqnvZ0AA=;
 h=From:To:Cc:Subject:Date:From;
 b=TRO1b5fghTfz8Qf8NV5dDUqYR72FEOnQOuYL/3VVNMR516sacfLg5sgn79Fp3aav2
 FaNFbIgR3nLd/hdGG/oQkmQDwmH+cuilLIkLTdw0QieFDfGNISEdm+2d/RCDrZ+08X
 ZKpug6ikR9GTO4mJEA9Bl2eT35A4khrDVkKneeUfI8Q14DoyzM7JUdFY8yAcXXmhBv
 +OtFVFBXKk5jRGDOTtUPq3Ler7yNSVZlE+Nx5LrXhy4UTQwk9+ODpAlTGThAjxaD0S
 EANPSjjQUFBmKsRFbwoe00OIDpbwYOY6GsvOL8Zmz4PM0QJ26716mTlXjlbDXGy+aZ
 LVYFK1kSbD53Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Sunday.Clement@amd.com
Cc: Alexander Deucher <Alexander.Deucher@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: FAILED: Patch "drm/amdkfd: Fix out-of-bounds write in
 kfd_event_page_set()" failed to apply to 5.10-stable tree
Date: Sat, 28 Feb 2026 21:03:23 -0500
Message-ID: <20260301020324.1731455-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 8a70a26c9f34baea6c3199a9862ddaff4554a96d Mon Sep 17 00:00:00 2001
From: Sunday Clement <Sunday.Clement@amd.com>
Date: Mon, 2 Feb 2026 12:41:39 -0500
Subject: [PATCH] drm/amdkfd: Fix out-of-bounds write in kfd_event_page_set()

The kfd_event_page_set() function writes KFD_SIGNAL_EVENT_LIMIT * 8
bytes via memset without checking the buffer size parameter. This allows
unprivileged userspace to trigger an out-of bounds kernel memory write
by passing a small buffer, leading to  potential privilege
escalation.

Signed-off-by: Sunday Clement <Sunday.Clement@amd.com>
Reviewed-by: Alexander Deucher <Alexander.Deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/amd/amdkfd/kfd_events.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
index 1ad312af8ff0c..13416bff77636 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
@@ -331,6 +331,12 @@ static int kfd_event_page_set(struct kfd_process *p, void *kernel_address,
 	if (p->signal_page)
 		return -EBUSY;
 
+	if (size < KFD_SIGNAL_EVENT_LIMIT * 8) {
+		pr_err("Event page size %llu is too small, need at least %lu bytes\n",
+				size, (unsigned long)(KFD_SIGNAL_EVENT_LIMIT * 8));
+		return -EINVAL;
+	}
+
 	page = kzalloc(sizeof(*page), GFP_KERNEL);
 	if (!page)
 		return -ENOMEM;
-- 
2.51.0




