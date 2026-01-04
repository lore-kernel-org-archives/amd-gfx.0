Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9A5AC2A075
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Jan 2026 08:27:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96E7210E088;
	Mon,  5 Jan 2026 08:27:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=proton.me header.i=@proton.me header.b="GEsu1fy9";
	dkim-atps=neutral
Received: from mail-4327.protonmail.ch (mail-4327.protonmail.ch [185.70.43.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4295910E135
 for <amd-gfx@lists.freedesktop.org>; Sun,  4 Jan 2026 16:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail; t=1767545407; x=1767804607;
 bh=Ms1cIXEZKr3RfHKUKatTLDHIp8yBOqIYlMqTRvvRhgc=;
 h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=GEsu1fy9TcNW0ku+UKHfHW+DUniSuilVSoUtuJFNfJZRt9GDwR9fFUCt/CLc12O/E
 L3dmjRAzGzHbeAd7z7/AQo8NTGcLvreUaa3iCpDfHg3uza7w1DnOMsvvM+PWKekfD6
 Ns6oam4Fgtq2i88CsmjmwZymZ+fQZzTlKF18V1HpPPs5eiwunz8pA7gE2ziuCLUU0m
 xS7AKh4XQHsUA1XmaJGCkXNf5mlvftUihboyvLn7U5P007YRFa1ulIAkULGoFFB9+5
 q3+Rjpp4mEWxHh/D/fk2VuFUlfhJZ6NroG1fvqcDJOQe5Xe2qX2qyqCL9qFNaSgzaa
 VT4tuGW6Mk76w==
Date: Sun, 04 Jan 2026 16:50:01 +0000
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
From: Tj <tj.iam.tj@proton.me>
Subject: amdgpu vs kexec (revisited)
Message-ID: <ysJdpPASgf9bkP75jPcCdDen8lcrK6X5ZnBZ0rCORBKpDxuQY9QfveJNc6k5I0Kf5YGC_0RgHj6HOvLkRjxYLVvTeDbjJrJ-VQggla6IxU4=@proton.me>
Feedback-ID: 113488376:user:proton
X-Pm-Message-ID: 3e816a947aea77e76095c6e9c37dbfe9cf29f9aa
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 05 Jan 2026 08:27:08 +0000
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

In this list on 2025-06-16 Peter Zijlstra reported "amdgpu vs kexec":

https://lists.freedesktop.org/archives/amd-gfx/2025-June/126086.html

and there was follow-up with possible solutions but with no reported resolu=
tion.

I'm trying to resolve the same issue and would welcome some help.

In Peter's thread there were two suggested options for amdgpu_pci_shutdown(=
):

1. amdgpu_asic_reset(adev); (suggested by Mario Limonciello)
2. amdgpu_dpm_set_mp1_state(adev, PP_MP1_STATE_UNLOAD); (suggested my Alex =
Deucher)

I also went back through all commits to amdgpu_pci_shutdown() and saw in fa=
efba95c9e8ca3
 the call to amdgpu_pci_remove() was replaced by amdgpu_suspend():

3. amdgpu_pci_remove();

I've tried all three; individually and combined (1 followed by 2 followed b=
y 3)=20
 - none manage it.

(3) triggers a stack trace before the kexec and after restart amdgpu trigge=
rs many
 traces and then the PC does a full power reset.

(1) and (2) kexec then amdgpu triggers many traces then hangs the system.

I have (large) logs for all three captured over serial port and can provide=
 a link to them
 if required.

As Peter found I also needed to add EXPORT_SYMBOL(kexec_in_progress) so the=
 loadable module
 would link. My eventual combined patch showing all three options is:

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_drv.c
index 848e6b7db482d..81384eaada538 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -35,6 +35,7 @@
 #include <linux/cc_platform.h>
 #include <linux/console.h>
 #include <linux/dynamic_debug.h>
+#include <linux/kexec.h>
 #include <linux/module.h>
 #include <linux/mmu_notifier.h>
 #include <linux/pm_runtime.h>
@@ -2583,9 +2584,21 @@ amdgpu_pci_shutdown(struct pci_dev *pdev)
         */
        if (!amdgpu_passthrough(adev))
                adev->mp1_state =3D PP_MP1_STATE_UNLOAD;
+#ifdef CONFIG_KEXEC
+       if (kexec_in_progress)
+               adev->mp1_state =3D PP_MP1_STATE_UNLOAD;
+#endif
        amdgpu_device_prepare(dev);
        amdgpu_device_suspend(dev, true);
        adev->mp1_state =3D PP_MP1_STATE_NONE;
+#ifdef CONFIG_KEXEC
+       if (kexec_in_progress)
+               amdgpu_asic_reset(adev);
+#endif
+#ifdef CONFIG_KEXEC
+       if (kexec_in_progress)
+               amdgpu_pci_remove(pdev);
+#endif
 }

 static int amdgpu_pmops_prepare(struct device *dev)
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 95c585c6ddc33..5c4d88df7466b 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -54,6 +54,7 @@ atomic_t __kexec_lock =3D ATOMIC_INIT(0);

 /* Flag to indicate we are going to kexec a new kernel */
 bool kexec_in_progress =3D false;
+EXPORT_SYMBOL(kexec_in_progress);

 bool kexec_file_dbg_print;

My workstation uses a FirePro W4100 (Southern Islands / Cape Verde / TAHITI=
 ).
Until now it was using radeon. Until maybe Spring 2025 it would successfull=
y
 kexec but I've lost track of the version where it worked.

Recently wanted to get kexec working again so thought I'd try amdgpu and fo=
und
 it has the same issue. In working on this over the last few days saw
 ccd3b4c7c37fbbd3 "drm/amdgpu: Use amdgpu by default on SI dedicated GPUs (=
v2)"
 so need to resolve this issue somehow and it seems amdgpu is the place to =
do that.

Thanks.

Tj.
