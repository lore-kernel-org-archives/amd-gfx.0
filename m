Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB754CAC5A7
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Sep 2025 15:59:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C19410E982;
	Thu, 25 Sep 2025 15:59:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kQrYLilY";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBB2410E981
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Sep 2025 15:59:27 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 4967145392;
 Thu, 25 Sep 2025 15:59:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DA8DC4CEF0;
 Thu, 25 Sep 2025 15:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1758815967;
 bh=INk8pAkP1MKRcuSN9wuYkgmnh4DJkRPi0ztA4HKAiUU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=kQrYLilY0sI7d0B37e4LLUA+Kip4Xz3sHc+NCAn96xhjxjfbAOMejuhXqv6fuLGSa
 CJ+7PyE/aMP4AGuftLxy/AIHUjfmN6HLHl40oNXSbcvBNQLXcaTzXwCuN2VJIOQ5ig
 dsO79KIBBDuEfi2HYwKlTD2WeZVHsQ4OuFbUEFqHwmaBTUSXPpWGGWt5kvKNrO515Z
 ge6YKEO4Uq+ez5/vdReAg2/+4RNAyJ4wQupGKZnNlQ2pHrV3g/aAROKseSWbZ9goz/
 xZlEOUBoNbqmeSmjEYnKUsI5KXmbDkWEs/YTKQbbkPv/ykw1udXGGj32TtwEQbti28
 GKcusOwSF5dwA==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: Alex Deucher <alexander.deucher@amd.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Samuel Zhang <guoqing.zhang@amd.com>,
 amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
 linux-pm@vger.kernel.org (open list:HIBERNATION (aka Software Suspend,
 aka swsusp)), "Mario Limonciello (AMD)" <superm1@kernel.org>,
 Ionut Nechita <ionut_n2001@yahoo.com>, Kenneth Crudup <kenny@panix.com>
Subject: [PATCH v2 2/3] PM: hibernate: Add pm_hibernation_mode_is_suspend()
Date: Thu, 25 Sep 2025 10:59:17 -0500
Message-ID: <20250925155918.2725474-3-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250925155918.2725474-1-superm1@kernel.org>
References: <20250925155918.2725474-1-superm1@kernel.org>
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
Tested-by: Kenneth Crudup <kenny@panix.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
v2:
 * Move under CONFIG_SUSPEND scope (LKP robot)
 * Add tags
---
 include/linux/suspend.h  |  2 ++
 kernel/power/hibernate.c | 11 +++++++++++
 2 files changed, 13 insertions(+)

diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index 317ae31e89b37..0664c685f0b24 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -276,6 +276,7 @@ extern void arch_suspend_enable_irqs(void);
 
 extern int pm_suspend(suspend_state_t state);
 extern bool sync_on_suspend_enabled;
+bool pm_hibernation_mode_is_suspend(void);
 #else /* !CONFIG_SUSPEND */
 #define suspend_valid_only_mem	NULL
 
@@ -288,6 +289,7 @@ static inline bool pm_suspend_via_firmware(void) { return false; }
 static inline bool pm_resume_via_firmware(void) { return false; }
 static inline bool pm_suspend_no_platform(void) { return false; }
 static inline bool pm_suspend_default_s2idle(void) { return false; }
+static inline bool pm_hibernation_mode_is_suspend(void) { return false; }
 
 static inline void suspend_set_ops(const struct platform_suspend_ops *ops) {}
 static inline int pm_suspend(suspend_state_t state) { return -ENOSYS; }
diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 52c1818749724..09f5271c98f35 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -80,6 +80,17 @@ static const struct platform_hibernation_ops *hibernation_ops;
 
 static atomic_t hibernate_atomic = ATOMIC_INIT(1);
 
+#ifdef CONFIG_SUSPEND
+/**
+ * pm_hibernation_mode_is_suspend - Check if hibernation has been set to suspend
+ */
+bool pm_hibernation_mode_is_suspend(void)
+{
+	return hibernation_mode == HIBERNATION_SUSPEND;
+}
+EXPORT_SYMBOL_GPL(pm_hibernation_mode_is_suspend);
+#endif
+
 bool hibernate_acquire(void)
 {
 	return atomic_add_unless(&hibernate_atomic, -1, 0);
-- 
2.43.0

