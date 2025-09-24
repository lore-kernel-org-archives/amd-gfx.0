Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA5D9CAC5AE
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Sep 2025 20:52:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8532A10E7EA;
	Wed, 24 Sep 2025 20:52:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aMGd07aQ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0E2710E7EA
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Sep 2025 20:52:21 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 332E6602A1;
 Wed, 24 Sep 2025 20:52:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 325FAC113CF;
 Wed, 24 Sep 2025 20:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1758747140;
 bh=1Y660VnpdTnvypQovi/8hf/y/7qhkU6Jm967mJShmfI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=aMGd07aQfrE5B+Xw9W6d5XwXycDSludKA/eYhNBflJsIwXM3Yo5zHNRHfiwyK3n8a
 dJantFjbHLN9pVEJI4TKdCm1W1fd7KjYeQrl/guOUim5Wx89LDMZBxBnvxCnZ6MebF
 bY7wu+fAJ3rMMU+V+H9HOZnBR3FUrLSzqTKEDNSgb6IFjsMmBq+mnlvqf0oyOCFbEY
 pW57459neXCPUgNzSl5tgr+bRUHPnqUaOFW2tzbn7h99fRZEWd+m7vXhxyl6byYkox
 3DqmM7OpzvkchJ5YSL1O4SpjWW9O/KEmMZX7N4v9p4lw6rJvlrefi5ZiTBjvScFYmW
 96Ip3Te0m3I0Q==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: Alex Deucher <alexander.deucher@amd.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Samuel Zhang <guoqing.zhang@amd.com>,
 amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
 linux-pm@vger.kernel.org (open list:HIBERNATION (aka Software Suspend,
 aka swsusp)), Mario Limonciello <superm1@kernel.org>,
 Ionut Nechita <ionut_n2001@yahoo.com>
Subject: [PATCH 2/3] PM: hibernate: Add pm_hibernation_mode_is_suspend()
Date: Wed, 24 Sep 2025 15:52:10 -0500
Message-ID: <20250924205211.1059571-3-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250924205211.1059571-1-superm1@kernel.org>
References: <20250924205211.1059571-1-superm1@kernel.org>
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

Some drivers have different flows for hibernation and suspend. If
the driver opportunistically will skip thaw() then it needs a hint
to know what is happening after the hibernate.

Introduce a new symbol pm_hibernation_mode_is_suspend() that drivers
can call to determine if suspending the system for this purpose.

Tested-by: Ionut Nechita <ionut_n2001@yahoo.com>
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 include/linux/suspend.h  | 2 ++
 kernel/power/hibernate.c | 9 +++++++++
 2 files changed, 11 insertions(+)

diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index 317ae31e89b3..4b11efd68729 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -479,6 +479,7 @@ extern void unlock_system_sleep(unsigned int);
 
 extern bool pm_sleep_transition_in_progress(void);
 bool pm_hibernate_is_recovering(void);
+bool pm_hibernation_mode_is_suspend(void);
 
 #else /* !CONFIG_PM_SLEEP */
 
@@ -513,6 +514,7 @@ static inline void unlock_system_sleep(unsigned int flags) {}
 
 static inline bool pm_sleep_transition_in_progress(void) { return false; }
 static inline bool pm_hibernate_is_recovering(void) { return false; }
+static inline bool pm_hibernation_mode_is_suspend(void) { return false; }
 
 #endif /* !CONFIG_PM_SLEEP */
 
diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 1defe8081e64..a991a1362d77 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -80,6 +80,15 @@ static const struct platform_hibernation_ops *hibernation_ops;
 
 static atomic_t hibernate_atomic = ATOMIC_INIT(1);
 
+/**
+ * pm_hibernation_mode_is_suspend - Check if hibernation has been set to suspend
+ */
+bool pm_hibernation_mode_is_suspend(void)
+{
+	return hibernation_mode == HIBERNATION_SUSPEND;
+}
+EXPORT_SYMBOL_GPL(pm_hibernation_mode_is_suspend);
+
 bool hibernate_acquire(void)
 {
 	return atomic_add_unless(&hibernate_atomic, -1, 0);
-- 
2.51.0

