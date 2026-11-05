Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34968606A32E
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2026 09:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pJoLQB6d
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA195112C97;
	Fri,  6 Nov 2026 09:26:03 +0000 (UTC)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com
 [209.85.222.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5837210E95E
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Nov 2026 17:22:02 +0000 (UTC)
Received: by mail-qk1-f177.google.com with SMTP id
 af79cd13be357-93e503815adso190448685a.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 05 Nov 2026 09:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793899321; x=1794504121; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=c87zgpoa7/zhE82S4M0oH9iDSuCjOwBm1i6IyAwk/JU=;
 b=pJoLQB6dxpTxcI8d8zMARK1Al9eVT4Yb0EFqwYJ+va2rTO/hA2xzr++KznsUVnEHgN
 hh5bgnVZsxMyhrbBogtBZIaoEtvuzzp7mh9ubVNtnRR37eO/03MQw8j6RYyFb42I0R5W
 tEoU7C7oCReeic7d6sDPuC/GONbOvUsK2M0fjYWVcQBX5hsCTK4wTXcCDpjF191kfPvP
 GRV/qEQiy6BDmvWByjUnjUQm6XKos2HSYtP4Gl06imAkuma48X4SIM6i+zhNxQ30TQgZ
 FwfC+I1RtPhVhICcQB8DKYDohgwGB9h2vqJtw0X8kHGPyRD89MKqC0dx4Kv5oOlAFNJB
 LwIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793899321; x=1794504121;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=c87zgpoa7/zhE82S4M0oH9iDSuCjOwBm1i6IyAwk/JU=;
 b=Wy5UMWskXsMg2sHmABwsN7MuRs1T0Ye28tqv5yWr5OQnTGAAlKc3SL9OUCm4ZTjpBh
 oPB/AVKl9gXbOwR2J//3dIep6nBD8H2jSdFhKoAFQhvK2hfaWgw0l5uefzr7c2TN9+rS
 MHS5lCgmtKlrcXJwBD4TTaDSDG/4U015rUtoaGgL/3VMjsIpVzQXJojgwcwREDbem8mi
 nPU3kbkaTqShFAr6NtRi8EDSlbkZxKQOnrHmywGpJ6a3STleTynkucNNG2+eTTBH45jJ
 G6z5031ry01IESk7fLn43oxSvGnwoO6A83OaGQcgFupfDSeOKsdsKJ5m0cMtYSUIiWxN
 KW8w==
X-Gm-Message-State: APuU4Z9fBc976RlOQRJ5uVak5XhqaBscp3juNAD6lmva/0TMXq4gDPef
 ceJ7DYfP5TPlSOaBAMeP0sdmgqxQoRTHVzZMaypYLrUpbTR6tzbxSjfhCIvncwJo
X-Gm-Gg: AYBFou1VKml+RoyjLfAoON/++p2TpiANK0fwlXZH4xK2TcVNodEXY3+D3Vz4Y/TYo1g
 3B+FDvBKdNod9k/j+ulRM5s5WMTPXy7B+/ONjG6myaFQvppgtR5exlZlbFU5uXtk9egtAOD2Lgb
 jbA8Yx4Bkyn75taxZSjfW36o+MQT+HTLqpjtsUkolK/bR6h3F4WcMCD5Sqhf2UqLNuLRmoWXOQh
 GZTu1tlwPwKS+v5UHcwIcUa+JLSuPjWZt550Pv2a0DIu2J0dgDOspwNgEnh1lUUuRxhNuS9/9y8
 YutPsJiNxhEFWsCZP2zf13CWeW8gHFu6f12kEynlsA0PJirOnZ/O1E1w/X/rgbupUjAFGzD7ihR
 6RfVjA5RwS22Y6Iy6jPlEEvH4VRkz25/LlvJv+m6T+dLtnnPGCe7yFcxmF7RDxdQWR+hC1VJ4rY
 noU/46erdIizar2PgSgIoj7eShuWiZzwOTlNgyT5YiE0mPhsvcBEsteDaAXRS7+sWkCQlJbS0fq
 +8KWHxkeaHlhfBfnIPKFY804rOvHmXGe1NfEpZZOeUv1Ae/G9CixYXiUHoW3ZOoFRQAylboHLqj
 5tpnW+4p/91ThytlRh72B4/5Y0eiPhbRArGcpb85vEVZvCEuQVXwHdeA68hHrYRZy40NXiewWv4
 2lKgdgDc=
X-Received: by 2002:a05:620a:270b:b0:93f:565f:e40 with SMTP id
 af79cd13be357-944217dc91fmr3114890385a.65.1793899320866; 
 Thu, 05 Nov 2026 09:22:00 -0800 (PST)
Received: from cachyos-ryzen.taila03a6e.ts.net ([66.65.129.117])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-945d479a1c8sm504633985a.15.2026.11.05.09.21.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 09:22:00 -0800 (PST)
From: Robert Testagrossa <fluxist@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: Robert Testagrossa <fluxist@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Mario Limonciello <superm1@kernel.org>
Subject: [PATCH] drm/amdgpu: freeze GFX 11.5 APUs in the late phase of
 hibernation
Date: Thu,  5 Nov 2026 12:18:26 -0500
Message-ID: <20261105171936.22410-1-fluxist@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 06 Nov 2026 09:26:02 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On GFX 11.5 APUs resume from hibernation intermittently fails because MES
stops responding while gfx_v11_0 is being resumed, for example:

  amdgpu: ring mes_kiq_3.1.0 test failed (-110)
  amdgpu: MES failed to respond to msg=SET_HW_RSRC
  amdgpu: MES failed to respond to msg=ADD_QUEUE
  amdgpu: resume of IP block <gfx_v11_0> failed -110

MES keeps timing out after the MODE2 reset done by the subsequent GPU
recovery, the display stays dark and the session is lost.

This reproduces without a power cycle with the PM test facility:

  echo platform > /sys/power/pm_test
  echo disk > /sys/power/state

On a Framework Laptop 13 (Ryzen AI 9 HX 370, GC 11.5.0, MES 0x94) about
one in four freeze/restore cycles fails, at a different point of the MES
bring-up each time.  GCVM and MMVM report no faults.

The failure depends on the GPU being frozen while other devices are
still running their freeze callbacks:

 - pm_async=0: no failure in 45 cycles
 - freeze callback delayed by 1 s: none in 45 cycles (60 ms: 1 in 20)
 - a 1 s pause right before the PG/CG ungate at the start of
   amdgpu_device_suspend() avoids it, the same pause right after the
   ungate does not; skipping the VRAM eviction does not help either
 - unbinding or unloading all devices that freeze concurrently and can
   be removed (TPM, NPU, PMF, xHCI/USB4, WLAN, HDA/ACP/CCP) together
   does not avoid it; the driver state at the start of the freeze is
   the same in passing and failing cycles

The PM core runs the late freeze callbacks only after all regular freeze
callbacks have completed, so do the freeze from .freeze_late on these
APUs.  This applies both to the kernel that creates the image and to the
boot kernel that quiesces the device before jumping into the image.
Since the device is no longer frozen in .freeze, don't resume it in
.thaw/.restore when the transition was aborted before the late phase.

With this change the same machine passed 40 of 40 cycles with
pm_test=platform (without it, the run failed at cycle 2), and real
hibernate/restore cycles with power-off, including s2idle followed by
hibernation, all resumed cleanly.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/5379
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/5788
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/4545
Signed-off-by: Robert Testagrossa <fluxist@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 45 ++++++++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 04b4f1e72..e1b28ecde 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2718,7 +2718,20 @@ static int amdgpu_pmops_resume(struct device *dev)
 	return r;
 }
 
-static int amdgpu_pmops_freeze(struct device *dev)
+/*
+ * On GFX 11.5 APUs MES intermittently fails to come back on restore from
+ * hibernation when the GPU is frozen while other devices are still running
+ * their freeze callbacks.  Do the freeze in the late phase for these parts,
+ * after all regular freeze callbacks have completed.
+ */
+static bool amdgpu_pmops_freeze_in_late_phase(struct amdgpu_device *adev)
+{
+	return (adev->flags & AMD_IS_APU) &&
+	       amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(11, 5, 0) &&
+	       amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(11, 6, 0);
+}
+
+static int amdgpu_pmops_do_freeze(struct device *dev)
 {
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(drm_dev);
@@ -2737,11 +2750,35 @@ static int amdgpu_pmops_freeze(struct device *dev)
 	return 0;
 }
 
+static int amdgpu_pmops_freeze(struct device *dev)
+{
+	struct drm_device *drm_dev = dev_get_drvdata(dev);
+
+	if (amdgpu_pmops_freeze_in_late_phase(drm_to_adev(drm_dev)))
+		return 0;
+
+	return amdgpu_pmops_do_freeze(dev);
+}
+
+static int amdgpu_pmops_freeze_late(struct device *dev)
+{
+	struct drm_device *drm_dev = dev_get_drvdata(dev);
+
+	if (!amdgpu_pmops_freeze_in_late_phase(drm_to_adev(drm_dev)))
+		return 0;
+
+	return amdgpu_pmops_do_freeze(dev);
+}
+
 static int amdgpu_pmops_thaw(struct device *dev)
 {
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(drm_dev);
 
+	/* the transition may have been aborted before the late freeze phase */
+	if (!adev->in_suspend)
+		return 0;
+
 	/* do not resume device if it's normal hibernation */
 	if (!adev->debug_hibernation_thaw_resume_gpu &&
 	    !pm_hibernate_is_recovering() &&
@@ -2766,6 +2803,11 @@ static int amdgpu_pmops_poweroff(struct device *dev)
 static int amdgpu_pmops_restore(struct device *dev)
 {
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(drm_dev);
+
+	/* nothing to do if the device was never frozen, e.g. pm_test=devices */
+	if (!adev->in_suspend)
+		return 0;
 
 	return amdgpu_device_resume(drm_dev, true);
 }
@@ -3052,6 +3094,7 @@ static const struct dev_pm_ops amdgpu_pm_ops = {
 	.suspend_noirq = pm_sleep_ptr(amdgpu_pmops_suspend_noirq),
 	.resume = pm_sleep_ptr(amdgpu_pmops_resume),
 	.freeze = pm_sleep_ptr(amdgpu_pmops_freeze),
+	.freeze_late = pm_sleep_ptr(amdgpu_pmops_freeze_late),
 	.thaw = pm_sleep_ptr(amdgpu_pmops_thaw),
 	.poweroff = pm_sleep_ptr(amdgpu_pmops_poweroff),
 	.restore = pm_sleep_ptr(amdgpu_pmops_restore),
-- 
2.56.0

