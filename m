Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13798CDE038
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Nov 2025 08:17:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEE6810E9EB;
	Fri, 14 Nov 2025 08:17:16 +0000 (UTC)
X-Greylist: delayed 353 seconds by postgrey-1.36 at gabe;
 Fri, 14 Nov 2025 01:13:40 UTC
Received: from rebatir.fr (rebatir.fr [212.129.56.80])
 by gabe.freedesktop.org (Postfix) with ESMTP id 2276010E21A
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Nov 2025 01:13:40 +0000 (UTC)
Received: from gollum.aman.illwieckz.net (unknown [82.67.166.215])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by rebatir.fr (Postfix) with ESMTPSA id 57F652025B;
 Fri, 14 Nov 2025 02:07:45 +0100 (CET)
From: Thomas Debesse <dev@illwieckz.net>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Thomas Debesse <dev@illwieckz.net>
Subject: [PATCH] drm/radeon: no 'auto' default DPM level on GRENADA 0x67B0/1
 Radeon R9 390(X)
Date: Fri, 14 Nov 2025 02:06:19 +0100
Message-ID: <20251114010619.184918-1-dev@illwieckz.net>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 14 Nov 2025 08:17:13 +0000
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

The "auto" DPM level is known to be faulty on this specific GPU model,
so having it set by default makes the kernel hang quickly after booting.

The bug has been reported on 2015-09-04, and the present patch
writen on 2017-09-10, unfortunately it never made it upstream:
https://bugs.freedesktop.org/show_bug.cgi?id=91880#c167

This bug is making Linux-based systems unusable as the kernel would
experience the hang at startup, sometimes even before the users get a
shell and become able to switch the DPM level to another safe options.

This bug also prevents to install Linux distributions on workstations
featuring this GPU since the kernel from the installation media will
experience the hang before the installation process completes itself.

The two other known safe DPM levels are "low" or "high".

This specific GRENADA model (variant of HAWAII), also known as R9 390
and R9 390X, was an expensive and powerful top-of-the line GPU card for
workstations. It was a flagship of the “Pirate Island” generation, the
one targeted by ROCm at the time, meant for high-performance gaming,
media production and GPGPU computation. Hence it is safe to assume the
users expect the default DPM level for it to be "high" when "auto" is
not available.

The users can still manually switch the DPM level to "low" when they
care about energy saving, thanks to this fix allowing them to complete
the system init and be able to get a shell to change that settings.

The bug was reported as bug #91880 on the freedesktop.org bugzilla:
https://bugs.freedesktop.org/show_bug.cgi?id=91880
for which the discussion continued there as #1222 on mesa/mesa GitLab:
https://gitlab.freedesktop.org/mesa/mesa/-/issues/1222#note_764999
then continued there as #1816 on drm/amd GitLab:
https://gitlab.freedesktop.org/drm/amd/-/issues/1816

Details about the bug also have been discussed there:
https://bugs.freedesktop.org/show_bug.cgi?id=92495
https://bugs.freedesktop.org/show_bug.cgi?id=93288

Without this patch, users have to rely on third-party tools setting
the DPM profile early as part of their init system, like this:
https://github.com/illwieckz/dpm-query

This patch was initially written for both radeon and amdgpu drivers as
as both suffered from the problem at the time. This now targets only
the radeon driver. It looks like the amdgpu driver doesn't suffer from
the hang anymore, so it may be theoretically possible to implement a
better fix for radeon, but none has been done in 10 years, so we better
not wait for another decade. This looks good enough to preven the hang.

This patch does not prevent the users to set the faulty DPM level and
then experience the crash because of his own actions, what this patch
does is to not set this faulty level by default, so the kernel doesn't
experience a hang with its default configuration.

It is also known that plugging a 4K screen may make the bug disappear,
likely by triggering some unexposed performance profie configuration,
but we cannot expect users to own such screen to run the Linux kernel.

The amdgpu driver being made the default one for this hardware is
also a way to workaround the bug. This is finally becoming a thing:
https://lists.freedesktop.org/archives/amd-gfx/2025-November/133615.html

But such switch is not meant to be backported to older kernels with
their less complete amdgpu driver, so this patch better be backported
to any older kernel running the radeon driver by default with such GPU.

The support for such hardware isn't removed in the radeon yet so there
can still be some situations where the radeon driver could be used with
future kernels, so this patch is still relevant for the development
branches and future stable ones.

This patch was first written against Linux 4.12.11 and was rebased
over Linux 6.16 without any conflict, so it should be straightforward
to rebase it over any kernel version from the last decade.

I rebased that patch on 2025-10-13 over Linux 6.16 because that was
the version Timur Kristóf was using when he reproduced the hang on
2025-10-23, so I could test with an environment as close as his:
https://gitlab.freedesktop.org/drm/amd/-/issues/1816#note_3160858

I reproduced the hang on 2025-11-14 after making sure all the
hardware and configuration to reproduce the hang was there:
a Radeon R9 390X GPU, a non-4K screen (1080p), and the radeon driver.
I confirm this patch still works as expected at preventing the hang
to happen:
https://gitlab.freedesktop.org/drm/amd/-/issues/1816#note_3192547

Reported-by: Lauri Gustafsson
Reported-by: John Frei
Reported-by: Thomas Debesse <dev@illwieckz.net>
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/1816
Link: https://gitlab.freedesktop.org/mesa/mesa/-/issues/1222
Link: https://bugs.freedesktop.org/show_bug.cgi?id=91880
Link: https://bugs.freedesktop.org/show_bug.cgi?id=92495
Link: https://bugs.freedesktop.org/show_bug.cgi?id=93288
Signed-off-by: Thomas Debesse <dev@illwieckz.net>
---
 drivers/gpu/drm/radeon/radeon_pm.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/radeon_pm.c b/drivers/gpu/drm/radeon/radeon_pm.c
index b4fb7e70320b..dc09c9a58b01 100644
--- a/drivers/gpu/drm/radeon/radeon_pm.c
+++ b/drivers/gpu/drm/radeon/radeon_pm.c
@@ -1421,7 +1421,20 @@ static int radeon_pm_init_dpm(struct radeon_device *rdev)
 	/* default to balanced state */
 	rdev->pm.dpm.state = POWER_STATE_TYPE_BALANCED;
 	rdev->pm.dpm.user_state = POWER_STATE_TYPE_BALANCED;
-	rdev->pm.dpm.forced_level = RADEON_DPM_FORCED_LEVEL_AUTO;
+
+	switch (rdev->pdev->device) {
+	case 0x67B0:
+	case 0x67B1:
+		/* The "auto" DPM level is known to hang these
+		 * high-performance grenada variants.
+		 */
+		rdev->pm.dpm.forced_level = RADEON_DPM_FORCED_LEVEL_HIGH;
+		break;
+	default:
+		rdev->pm.dpm.forced_level = RADEON_DPM_FORCED_LEVEL_AUTO;
+		break;
+	}
+
 	rdev->pm.default_sclk = rdev->clock.default_sclk;
 	rdev->pm.default_mclk = rdev->clock.default_mclk;
 	rdev->pm.current_sclk = rdev->clock.default_sclk;
-- 
2.43.0

