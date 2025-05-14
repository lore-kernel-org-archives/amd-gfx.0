Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D3A2C3ABD8
	for <amd-gfx@archiver.kernel.org>; Wed, 14 May 2025 19:34:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 303AC10E722;
	Wed, 14 May 2025 19:34:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DXUYXXhh";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76F1D10E716
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 May 2025 19:34:37 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 0D14D4A989;
 Wed, 14 May 2025 19:34:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE84FC4CEF0;
 Wed, 14 May 2025 19:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1747251276;
 bh=3ivflG2b+7xFcnqYwqOf1n0ZgZzhrPJqm9pltBGm89A=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=DXUYXXhh1Lp6DWU4WJjVQppnWAxqGKSCRSpGi3CJfEniKt3svhcIM9CX3bR3s0x6F
 SD/fmcO36MpRMYWCIpqiQdDirGY4TgI8yVhVJWe0XvAOtP6A57D2EqhgmwutMrG2gz
 q91V3jgyJLR4B9XT98Gwlx6MlNO6tg+e3Miu1QtR3laCfTo38PKzT4hLIbmW+Eww/3
 1HP0zI14cnhdOoJLjEUhtf6cuCOHuZ7bpOXpR0SZSUwozjqzTa8veODfabMRtvg4wD
 kx2Ul/DL0X7R1C8nMbXzzgs2fICc61tZGNKF5jzzG3UajOqwAqC32+bj1baAUy8sCB
 7ZLR5Vc4jOReg==
From: Mario Limonciello <superm1@kernel.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 Bjorn Helgaas <bhelgaas@google.com>
Cc: amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
 linux-pm@vger.kernel.org (open list:HIBERNATION (aka Software Suspend,
 aka swsusp)), linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM),
 linux-kernel@vger.kernel.org (open list),
 Mario Limonciello <mario.limonciello@amd.com>,
 AceLan Kao <acelan.kao@canonical.com>, Kai-Heng Feng <kaihengf@nvidia.com>,
 Mark Pearson <mpearson-lenovo@squebb.ca>,
 =?UTF-8?q?Merthan=20Karaka=C5=9F?= <m3rthn.k@gmail.com>,
 Denis Benato <benato.denis96@gmail.com>
Subject: [PATCH v2 1/3] PM: Use hibernate flows for system power off
Date: Wed, 14 May 2025 14:34:04 -0500
Message-ID: <20250514193406.3998101-2-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250514193406.3998101-1-superm1@kernel.org>
References: <20250514193406.3998101-1-superm1@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

When the system is powered off the kernel will call device_shutdown()
which will issue callbacks into PCI core to wake up a device and call
it's shutdown() callback.  This will leave devices in ACPI D0 which can
cause some devices to misbehave with spurious wakeups and also leave some
devices on which will consume power needlessly.

The issue won't happen if the device is in D3 before system shutdown, so
putting device to low power state before shutdown solves the issue.

ACPI Spec 6.5, "7.4.2.5 System \_S4 State" says "Devices states are
compatible with the current Power Resource states. In other words, all
devices are in the D3 state when the system state is S4."

The following "7.4.2.6 System \_S5 State (Soft Off)" states "The S5
state is similar to the S4 state except that OSPM does not save any
context." so it's safe to assume devices should be at D3 for S5.

To accomplish this, modify the PM core to call all the device hibernate
callbacks when turning off the system when the kernel is compiled with
hibernate support. If compiled without hibernate support or hibernate fails
fall back into the previous shutdown flow.

Cc: AceLan Kao <acelan.kao@canonical.com>
Cc: Kai-Heng Feng <kaihengf@nvidia.com>
Cc: Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: Merthan Karakaş <m3rthn.k@gmail.com>
Tested-by: Denis Benato <benato.denis96@gmail.com>
Link: https://lore.kernel.org/linux-pci/20231213182656.6165-1-mario.limonciello@amd.com/
Link: https://lore.kernel.org/linux-pci/20250506041934.1409302-1-superm1@kernel.org/
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2:
 * Handle failures to hibernate (fall back to shutdown)
 * Don't use dedicated events
 * Only allow under CONFIG_HIBERNATE_CALLBACKS
---
 kernel/reboot.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel/reboot.c b/kernel/reboot.c
index ec087827c85cd..52f5e6e36a6f8 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -13,6 +13,7 @@
 #include <linux/kexec.h>
 #include <linux/kmod.h>
 #include <linux/kmsg_dump.h>
+#include <linux/pm.h>
 #include <linux/reboot.h>
 #include <linux/suspend.h>
 #include <linux/syscalls.h>
@@ -305,6 +306,17 @@ static void kernel_shutdown_prepare(enum system_states state)
 		(state == SYSTEM_HALT) ? SYS_HALT : SYS_POWER_OFF, NULL);
 	system_state = state;
 	usermodehelper_disable();
+#ifdef CONFIG_HIBERNATE_CALLBACKS
+	if (dpm_suspend_start(PMSG_HIBERNATE))
+		goto resume_devices;
+	if (dpm_suspend_end(PMSG_HIBERNATE))
+		goto resume_devices;
+	return;
+
+resume_devices:
+	pr_emerg("Failed to power off devices, using shutdown instead.\n");
+	dpm_resume_end(PMSG_RESTORE);
+#endif
 	device_shutdown();
 }
 /**
-- 
2.43.0

