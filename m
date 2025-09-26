Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C0B3CAC5BC
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Sep 2025 11:10:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E59DE10EA1B;
	Fri, 26 Sep 2025 11:10:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Xj/Qhp/t";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E2D310EA1B
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Sep 2025 11:10:27 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id A5F184013E;
 Fri, 26 Sep 2025 11:10:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A27D8C16AAE;
 Fri, 26 Sep 2025 11:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1758885026;
 bh=KrSTaivsd8i5geUp+S3za4RDWwkfaab6BWCnjplvC4Q=;
 h=From:To:Cc:Subject:Date:From;
 b=Xj/Qhp/tnzgsUnerwAJ+/vY5DkVhpYa/OS28dD1RQaH8aHNjUjGxLXn85Haqg6CFM
 vjqeEmJ73RyQ5HzXWbmlBIjJYAZe7j3YGk5rpvOKBG/y/3nNDPrQm+7ji+DVVsZbDv
 EJzPZ7ZKuteO2BmidDv++9dJnE+vxj53LY9arB7REUw5hIxGq3/wRKDlxYj0OxIstj
 enRPIGkqw3gbZAwF498XY0GrW1j8wnU5KVll/bQUEKWtlZlHP1TzHJ/eEhzLQqgKj3
 bC9HNXd45S1OmNjhxUfUbpl3cv/ngUnRj7GlCZ0ALHvwH/gndsU2xfCLHxyywhQ1wB
 tfUw94923oxmg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Ionut Nechita <ionut_n2001@yahoo.com>,
 Alex Deucher <alexander.deucher@amd.com>, Kenneth Crudup <kenny@panix.com>,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH v1] PM: hibernate: Fix pm_hibernation_mode_is_suspend() build
 breakage
Date: Fri, 26 Sep 2025 13:10:22 +0200
Message-ID: <12746883.O9o76ZdvQC@rafael.j.wysocki>
Organization: Linux Kernel Development
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
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

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Commit 495c8d35035e ("PM: hibernate: Add pm_hibernation_mode_is_suspend()")
that introduced pm_hibernation_mode_is_suspend() did not define it in
the case when CONFIG_HIBERNATION is unset, but CONFIG_SUSPEND is set.

Subsequent commit 0a6e9e098fcc ("drm/amd: Fix hybrid sleep") made the
amdgpu driver use that function which led to kernel build breakage in
the case mentioned above [1].

Address this by using appropriate #ifdeffery aroung the definition of
pm_hibernation_mode_is_suspend().

Fixes: 0a6e9e098fcc ("drm/amd: Fix hybrid sleep")
Reported-by: KernelCI bot <bot@kernelci.org> 
Closes: https://groups.io/g/kernelci-results/topic/regression_pm_testing/115439919 [1]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/linux/suspend.h |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -276,7 +276,6 @@ extern void arch_suspend_enable_irqs(voi
 
 extern int pm_suspend(suspend_state_t state);
 extern bool sync_on_suspend_enabled;
-bool pm_hibernation_mode_is_suspend(void);
 #else /* !CONFIG_SUSPEND */
 #define suspend_valid_only_mem	NULL
 
@@ -289,7 +288,6 @@ static inline bool pm_suspend_via_firmwa
 static inline bool pm_resume_via_firmware(void) { return false; }
 static inline bool pm_suspend_no_platform(void) { return false; }
 static inline bool pm_suspend_default_s2idle(void) { return false; }
-static inline bool pm_hibernation_mode_is_suspend(void) { return false; }
 
 static inline void suspend_set_ops(const struct platform_suspend_ops *ops) {}
 static inline int pm_suspend(suspend_state_t state) { return -ENOSYS; }
@@ -420,6 +418,12 @@ static inline int hibernate_quiet_exec(i
 }
 #endif /* CONFIG_HIBERNATION */
 
+#if defined(CONFIG_HIBERNATION) && defined(CONFIG_SUSPEND)
+bool pm_hibernation_mode_is_suspend(void);
+#else
+static inline bool pm_hibernation_mode_is_suspend(void) { return false; }
+#endif
+
 int arch_resume_nosmt(void);
 
 #ifdef CONFIG_HIBERNATION_SNAPSHOT_DEV



