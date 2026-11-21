Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE6F606A338
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2026 08:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WzwdrlXr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 139AA10E72F;
	Mon, 23 Nov 2026 08:30:11 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DF8C10E07D
 for <amd-gfx@lists.freedesktop.org>; Sat, 21 Nov 2026 06:47:48 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4bb55cda775so10291155e9.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Nov 2026 22:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795243667; x=1795848467; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=XODWv2cak1Zf76l9fgBDPop4XWaDbCm+Jd1R/aAD71Q=;
 b=WzwdrlXr5utX14ziNP3ST56gMiqh3JYaQBaAhV/6wFtISFesPkWvl7YF0s22YurIZH
 MS9NKaXxdCjbV58vPOhry4eOTZ5mDIqPpTHT8j+JIgTS6HnuH+TntFIOLpMEq6ebMfPj
 t6Vr0Yvo2B5aV2jipx3hjYAlJ8QrgDbwoAYYZCASPA5B0iTU0SMxi+Yi285h/Ih/zU7L
 AXtlewX1+aQp7W9JjHv64/ArCIdAxK1zs3iz0gT+Jz31PUnVKnjgLbJhYZJVS4esHP4G
 8HTtgVEL0tz1C2zzR2OMd1G2e4lWjsixQwv5TnZktQrqP7B9vbBJ9JApnEjEilCjqjEx
 96Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795243667; x=1795848467;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XODWv2cak1Zf76l9fgBDPop4XWaDbCm+Jd1R/aAD71Q=;
 b=ggsg7cRzlLOirSXR38z9BbdInT2ebRgeZMtOcGg3IzkUD1TAM5v2bfXWRyfqZGBWpn
 KDrfHgrEL0rz3ymcYPA2wwXGChNG3Sn7koNHs+JgXn8508W1ikiJIl6tJKJqhUNlSWuC
 o2Lip0T9zGFoS9/zhWgUgzGRv+w//u4zRk9wXBJaCB96OmzzmK/ew998mmIwu3eRmdg4
 8fWCm/8+kS5TJ54N1FMzQK4/M4ddqQYqyDarikBHRUT9Lmv+GbxzfovTweEZD1Jynj9f
 woJsRvnuWJAYWESnBiMTk0OZpHlE3Za2/nU5eLxq5gmkmZBRJz++aSW3L0e985REBPdp
 lyuQ==
X-Gm-Message-State: APuU4Z+RNw3EL+atKUmPG1s+jCYYDppr7JpTNY/tR8q2AB298SEuuZT3
 uDNaDHy352OC3TpOX3KBr0kKQ1q7KEHiM+NER4CnNiYBtrQyZo1MHpWELoQYZiaL
X-Gm-Gg: AZFdTZf9qWdcjhclGZ8KL4oyK0elnmn++nGQ6uiMlcvCtuKWlRXz0O24agfEuQJ3EeN
 QOuWxvEO4CtOzHGJGsOrPKyPAXk89GnqkBG4UN8fjDXA1l9b7xRAKIU8DY5SKeeIrNkQd3wkeVU
 zWwswLcJcJpsdmHk+AnGjDSQrWhC9g1ZPVTP+k4xmiId+HouaJ1uPPmTyEPFF9OG1tZ3aOOe0hi
 Dv/UT/xwNm10EyZr7ALJzZDIJ334Q7QJ3WbGTGPWxqjQbbLrSlqcOaSs26GgkHG4e5nlG7gjmyE
 uOP2xGHdwQT2FJKbZxWY6BsAh4MLrlGoQC6T5QC2S4dt+kFXGda/SaNgDJ4GLzFg275Gg0pWm4m
 jJosVP0aRQFHMAH8IhertHGY/yZ0iNyh7meGzYKAcSsMPJAKPoKX/zZFv8mNUJxWXrq/ylx0CDf
 AGkHMIlyuSQjAUYGin7BqpmosAzasB34aE+OPsJo+J1qfp+/J+T9fJMzkG2afO4RnSCMuvZ3kwE
 OCVjf450/IVoHlVc1BhPsYeyMu0A6elCN6QoUw88mc04/vfxQ1yVT9vEJHngjtm6el9FrLiafuz
 EVmD2L3zCY9KMWBqXFD4upXOroAPHYWC7/zNe3/gVKWIoxvF3iiqXfaasm31m6dpUOaTRuDfvvl
 AI84A/bvgSmAPYqgO8XKfkwdSN2pXoTlAvg==
X-Received: by 2002:a05:600c:4e0b:b0:49e:65f2:db64 with SMTP id
 5b1f17b1804b1-4bb887fb66cmr130205715e9.5.1795243666612; 
 Fri, 20 Nov 2026 22:47:46 -0800 (PST)
Received: from Arbeitszimmer.fritz.box
 ([2001:9e8:db36:8300:f2e4:78d1:95b7:d1cd])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853b216esm188884725e9.12.2026.11.20.22.47.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 22:47:46 -0800 (PST)
From: Christoph Berliner <caberliner@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, Jiqian.Chen@amd.com,
 Christoph Berliner <caberliner@gmail.com>
Subject: [PATCH v2] drm/amdgpu/gfx9: deactivate all compute HQDs before MODE2
 on APUs
Date: Sat, 21 Nov 2026 07:46:05 +0100
Message-ID: <20261121064605.8721-1-caberliner@gmail.com>
X-Mailer: git-send-email 2.56.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 23 Nov 2026 08:30:10 +0000
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

MODE2 does not reset the CP HQD registers on gfx9 APUs. Commit
c3988a7ad479 ("drm/amdgpu/gfx9: Fix Ring and IB test fail after mode2")
deactivates the HQDs of the kernel compute queues before MODE2, but the
HQDs owned by KFD stay active as well:

- the HIQ is never destroyed during a GPU reset, because
  kq_uninitialize() skips destroy_mqd() when it cannot take the reset
  domain semaphore, which amdgpu_device_gpu_recover() holds for write
  before calling amdgpu_amdkfd_pre_reset(), and kgd_gfx_v9_hqd_destroy()
  bails out with -EIO while amdgpu_in_reset() anyway;
- user queues mapped by the HWS stay active when the preceding unmap
  failed (which is the usual reason for the reset).

After MODE2 the MEC is unhalted with the stale HIQ. The reset reports
success and graphics/KCQs work again, but the HWS no longer answers:
the next KFD queue creation runs into

  amdgpu: qcm fence wait loop timeout expired
  amdgpu: The cp might be in an unrecoverable state due to an unsuccessful queues preemption
  amdgpu: process pid ... DQM create queue type 0 failed. ret -62

which triggers another reset, and KFD stays unusable until reboot.

Deactivate every active HQD of all MECs before MODE2 instead of only
the KCQs, except the KIQ, which gfx_v9_0_kiq_init_register()
reprograms on resume. The KIQ is also identified by its MQD address,
because at least on Renoir the HQD registers of MEC2 pipes 2/3 read back as
those of pipes 0/1 and the KIQ would otherwise get a dequeue request
through the alias. amdgpu_gfx_kiq_acquire() already avoids MEC2 pipes
2/3 for the KIQ, so this is likely not Renoir specific.

While at it, fix the timeout check of the dequeue loop: it polled for
adev->usec_timeout iterations but compared the counter against
AMDGPU_MAX_USEC_TIMEOUT. Both are equal by default, but with
amdgpu_emu_mode usec_timeout is 10x larger and the manual
CP_HQD_ACTIVE=0 fallback was never reached.

Tested on Ryzen 5 5600G (Cezanne, gfx90c, GC 9.3.0), MEC firmware
0x1e3, HWS enabled, amdgpu.noretry=1. An instrumented build used the
old path for the first MODE2 and the new one afterwards (same boot):
with the old path the HIQ was still ACTIVE with its old MQD/PQ after
the reset and the next HIP program hung the GPU; with the new path
only the KIQ was active at resume and HIP/rocBLAS tests passed. Loaded
at boot, a requested reset deactivated 9 HQDs (8 KCQs + HIQ), skipped
the KIQ seen through the pipe alias, and HIP/rocBLAS tests passed
before and after the reset. Not tested on other gfx9 APUs.

Fixes: c3988a7ad479 ("drm/amdgpu/gfx9: Fix Ring and IB test fail after mode2")
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/6177
Assisted-by: Claude Code
Signed-off-by: Christoph Berliner <caberliner@gmail.com>
---

Notes:
    v2:
    - squash the two patches into one (Alex)
    - deactivate the HQDs on all gfx9 APUs instead of only Renoir, replacing
      gfx_v9_0_deactivate_kcq_hqd() (Alex)
    - v1: https://lore.kernel.org/amd-gfx/CADnq5_OsKujx3VgWDNDYF_ANocTs0aswFaC3uGwZhp7fE+SBCQ@mail.gmail.com/

 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 98 +++++++++++++++++++--------
 1 file changed, 69 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 9d87ebbc4..2d8ab438c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -4076,39 +4076,79 @@ static int gfx_v9_0_hw_init(struct amdgpu_ip_block *ip_block)
 	return r;
 }
 
-static void gfx_v9_0_deactivate_kcq_hqd(struct amdgpu_device *adev)
+/* caller must hold srbm_mutex and have selected me/pipe/queue */
+static bool gfx_v9_0_deactivate_hqd(struct amdgpu_device *adev,
+				    u32 me, u32 pipe, u32 queue)
 {
-	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
-	for (int i = 0; i < adev->gfx.num_compute_rings; i++) {
-		u32 tmp;
-		struct amdgpu_ring *ring = &adev->gfx.compute_ring[i];
+	int j;
 
-		mutex_lock(&adev->srbm_mutex);
-		soc15_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0, 0);
-		tmp = RREG32_SOC15(GC, 0, mmCP_HQD_ACTIVE);
-		/* disable the queue if it's active */
-		if (tmp & CP_HQD_ACTIVE__ACTIVE_MASK) {
-			int j;
-
-			WREG32_SOC15(GC, 0, mmCP_HQD_DEQUEUE_REQUEST, 1);
-			for (j = 0; j < adev->usec_timeout; j++) {
-				tmp = RREG32_SOC15(GC, 0, mmCP_HQD_ACTIVE);
-				if (!(tmp & CP_HQD_ACTIVE__ACTIVE_MASK))
-					break;
-				udelay(1);
-			}
-			if (j == AMDGPU_MAX_USEC_TIMEOUT) {
-				DRM_DEBUG("comp_%u_%u_%u dequeue request failed.\n",
-							ring->me, ring->pipe, ring->queue);
-				/* Manual disable if dequeue request times out */
-				WREG32_SOC15(GC, 0, mmCP_HQD_ACTIVE, 0);
+	/* disable the queue if it's active */
+	if (!(RREG32_SOC15(GC, 0, mmCP_HQD_ACTIVE) & CP_HQD_ACTIVE__ACTIVE_MASK))
+		return false;
+
+	WREG32_SOC15(GC, 0, mmCP_HQD_DEQUEUE_REQUEST, 1);
+	for (j = 0; j < adev->usec_timeout; j++) {
+		if (!(RREG32_SOC15(GC, 0, mmCP_HQD_ACTIVE) &
+		      CP_HQD_ACTIVE__ACTIVE_MASK))
+			break;
+		udelay(1);
+	}
+	if (j == adev->usec_timeout) {
+		dev_dbg(adev->dev, "comp_%u_%u_%u dequeue request failed.\n",
+			me, pipe, queue);
+		/* Manual disable if dequeue request times out */
+		WREG32_SOC15(GC, 0, mmCP_HQD_ACTIVE, 0);
+	}
+	WREG32_SOC15(GC, 0, mmCP_HQD_DEQUEUE_REQUEST, 0);
+
+	return true;
+}
+
+/*
+ * MODE2 does not reset the CP HQD registers on gfx9 APUs. Besides the KCQs,
+ * the HQDs owned by KFD (HIQ and the user queues mapped by the HWS) also stay
+ * active, because KFD cannot unmap/destroy them while the reset domain is
+ * locked. After MODE2 the MEC then resumes with stale HQDs and the HWS no
+ * longer answers (qcm fence timeout on the next KFD queue). Deactivate every
+ * active HQD of all MECs except the KIQ, which is reprogrammed on resume.
+ */
+static void gfx_v9_0_deactivate_all_hqd(struct amdgpu_device *adev)
+{
+	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq[0].ring;
+	u64 kiq_mqd_addr = kiq_ring->mqd_gpu_addr & ~0x3ULL;
+	u32 me, pipe, queue, n = 0;
+	u64 mqd_addr;
+
+	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
+	mutex_lock(&adev->srbm_mutex);
+	for (me = 1; me <= adev->gfx.mec.num_mec; me++) {
+		for (pipe = 0; pipe < adev->gfx.mec.num_pipe_per_mec; pipe++) {
+			for (queue = 0; queue < adev->gfx.mec.num_queue_per_pipe;
+			     queue++) {
+				if (me == kiq_ring->me && pipe == kiq_ring->pipe &&
+				    queue == kiq_ring->queue)
+					continue;
+				soc15_grbm_select(adev, me, pipe, queue, 0, 0);
+				/*
+				 * At least on Renoir the HQD registers of MEC2
+				 * pipes 2/3 read back as those of pipes 0/1, so
+				 * the KIQ shows up a second time. Skip it by its
+				 * MQD address instead of sending it a dequeue.
+				 */
+				mqd_addr = ((u64)RREG32_SOC15(GC, 0, mmCP_MQD_BASE_ADDR_HI) << 32) |
+					   RREG32_SOC15(GC, 0, mmCP_MQD_BASE_ADDR);
+				if (mqd_addr == kiq_mqd_addr)
+					continue;
+				if (gfx_v9_0_deactivate_hqd(adev, me, pipe, queue))
+					n++;
 			}
-			WREG32_SOC15(GC, 0, mmCP_HQD_DEQUEUE_REQUEST, 0);
 		}
-		soc15_grbm_select(adev, 0, 0, 0, 0, 0);
-		mutex_unlock(&adev->srbm_mutex);
 	}
+	soc15_grbm_select(adev, 0, 0, 0, 0, 0);
+	mutex_unlock(&adev->srbm_mutex);
 	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
+
+	dev_dbg(adev->dev, "deactivated %u active compute HQDs before MODE2\n", n);
 }
 
 static int gfx_v9_0_hw_fini(struct amdgpu_ip_block *ip_block)
@@ -4136,8 +4176,8 @@ static int gfx_v9_0_hw_fini(struct amdgpu_ip_block *ip_block)
 	}
 
 	if ((adev->flags & AMD_IS_APU) && amdgpu_in_reset(adev) &&
-		amdgpu_asic_reset_method(adev) == AMD_RESET_METHOD_MODE2)
-		gfx_v9_0_deactivate_kcq_hqd(adev);
+	    amdgpu_asic_reset_method(adev) == AMD_RESET_METHOD_MODE2)
+		gfx_v9_0_deactivate_all_hqd(adev);
 
 	/* Use deinitialize sequence from CAIL when unbinding device from driver,
 	 * otherwise KIQ is hanging when binding back
-- 
2.56.1

