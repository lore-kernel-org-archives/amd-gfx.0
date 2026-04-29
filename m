Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B305AFF8867
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Apr 2026 10:26:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EEE610EF70;
	Wed, 29 Apr 2026 10:26:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nNUI5PFk";
	dkim-atps=neutral
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com
 [209.85.161.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E4AE10E03A
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Apr 2026 03:26:25 +0000 (UTC)
Received: by mail-oo1-f44.google.com with SMTP id
 006d021491bc7-679b072ed3aso5772495eaf.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Apr 2026 20:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777433185; x=1778037985; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fDq0+Om8CwqznPOpM1JgAcMFcBij3v4uN7yEeX42s6A=;
 b=nNUI5PFkp7GDroM81vNLdzGbR76BIF+mNcfng9kan3zzgAtlLl+ctk/kND8DoCdKxO
 nF5cDVc8gTbr5yFdLLgJi9L6kKvp6sti/ZoaBCrcCt3VLaubuZZNnzKuf960ZWyR9P/8
 NaX+hbv8pygD2FEGTK1m4canmjPaNYhiv6j/1egdKtkUBL13x+tBEsl6rKyZSAiBUwXD
 XtNjdRs26ogmMWikvB1Lt082HNZEYCDO0XbBnLmw2R7AnvZUtwzEpiHS829bCvoqKJ3e
 COScVA1aYAqO63ThiOx53JkQuOZNznCRdCYCyg2Ebl8kqp31djMNlTVPVGKHOKiAikJV
 bYWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777433185; x=1778037985;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fDq0+Om8CwqznPOpM1JgAcMFcBij3v4uN7yEeX42s6A=;
 b=qPPcJLuXMXAP7J3CuqmGVzyN3SsaE8yh4tx0jIV1+QqwSusjEIs/FahQzjpEGL2+zs
 mWcrSLw8X8GxdCRX2ii5kFXiAeTs0VC2pk485itxFlU6NaIP1YPzHv8JakPZ+8GN06BR
 GqFBss4zFXa1igTdKQWF0KJO4aKjWCX8ZllWpcY0vDDfUFIZu3t5pa1rJilZKAt4z9XU
 UKMliOoRD/uAfV9Dy52LHlP/qzqJArr1G0NDvJ06+TF8dS3baUNa/pPQ06UkweGrZTJ7
 jGkqNE/j5qc/sa+YZ40GFFlN+dbmqpnk3v6gnW27JQhDLaEigO04QuzW7Iroe6JTOCNR
 kFdw==
X-Gm-Message-State: AOJu0YwrZkmq3aC67lEr42kgzTeLPDY9PNqSUixWIBNHSO++8F8vlQGD
 XG5+cEUPtKzA1qMwGpb1WV9jDBWDkgoHyPlaNfkPURuowaSEQkvkvQs=
X-Gm-Gg: AeBDiesW3B7hzQekjS8K97SdISPwFxBDA2vW5N3av6e3PxqLf8E8/kKLtYWDTonE+oR
 zfj8T+IEzgtJVbcRMWvUxixxfaB0QRrg1zcjxv1mJnbfW8Lv9B57JM6TzYTSIt+m6lddEwtYZqV
 FuAYdTn35x9Ve/Day1PPauEvPq32g9qOuF1xTQa8OgI9C08APeNNRG5RoPyugtsNiS48LEtAmPq
 jvl2+2VOVWEe3IooUMSWdq+7JzJ5rCt8TDMd4RYlBkzdc+Q3b/G2b/AHqb4GefCAVbAMgH4LRD/
 1Z+l5aTegJmI7jQPuYUwWjk/nu9mh0U6fIHg7KskWTDOtiB2DgKnh16F1cI230dOLUwYvX6c3fQ
 VL9UaKkPmLAv2MrUhxIg3CL7I3Q7FQgmROQADHosbmftkMjPKmYJIa8J5aqcyWZZvKaeOcR8yCJ
 /afQT5EgOuj7UdMOQ6dr4+wN5habl1RG2DGAcGWEAte+b23eFox51QF0qOwk9PucxkM53Wvv42p
 3AAE3TdSml6wXnKCAc7W20+M9ag9Zn45l4=
X-Received: by 2002:a4a:e903:0:b0:696:1413:496a with SMTP id
 006d021491bc7-6965ca8527dmr3146109eaf.17.1777433184671; 
 Tue, 28 Apr 2026 20:26:24 -0700 (PDT)
Received: from localhost.localdomain ([47.188.191.104])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6966bc3be04sm405156eaf.8.2026.04.28.20.26.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 20:26:24 -0700 (PDT)
From: "John B. Moore" <jbmoore61@gmail.com>
To: christian.koenig@amd.com,
	alexander.deucher@amd.com
Cc: amd-gfx@lists.freedesktop.org,
	jbmoore61@gmail.com
Subject: [PATCH v4 2/2] drm/amdgpu/ring: extract kiq_read_clock to common
 HW-agnostic code
Date: Tue, 28 Apr 2026 22:26:21 -0500
Message-ID: <20260429032621.10888-2-jbmoore61@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429032621.10888-1-jbmoore61@gmail.com>
References: <20260429032621.10888-1-jbmoore61@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 29 Apr 2026 10:25:59 +0000
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

Move gfx_v9_0_kiq_read_clock() from gfx_v9_0.c to amdgpu_ring.c
as amdgpu_kiq_read_clock(). The function uses PACKET3_COPY_DATA to
read the GPU clock counter via the KIQ ring and is not in any way
HW generation dependent -- it can be reused by any GFX IP version
that needs KIQ-based clock reads in SRIOV environments.

Preserve the original block comment explaining the gpu_recover()
deadlock avoidance logic for the reset-path bail-out.

Requested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: John B. Moore <jbmoore61@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h      |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 85 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    | 74 +--------------------
 3 files changed, 88 insertions(+), 72 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 447e734c3..75e200211 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -524,6 +524,7 @@ struct amdgpu_wb {
 
 int amdgpu_device_wb_get(struct amdgpu_device *adev, u32 *wb);
 void amdgpu_device_wb_free(struct amdgpu_device *adev, u32 wb);
+uint64_t amdgpu_kiq_read_clock(struct amdgpu_device *adev);
 
 /*
  * Benchmarking
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 4638a686a..6049215ce 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -35,6 +35,7 @@
 #include "amdgpu.h"
 #include "amdgpu_ras_mgr.h"
 #include "atom.h"
+#include "sid.h"
 
 /*
  * Rings
@@ -926,3 +927,87 @@ bool amdgpu_ring_is_reset_type_supported(struct amdgpu_ring *ring,
 	}
 	return false;
 }
+
+/**
+ * amdgpu_kiq_read_clock - read GPU clock via KIQ ring
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * Use the KIQ (Kernel Interface Queue) to issue a COPY_DATA packet
+ * that reads the GPU clock counter into a writeback buffer.
+ * This is HW-generation agnostic and can be used by any IP that
+ * needs to read the GPU clock via KIQ in SRIOV environments.
+ *
+ * Returns the 64-bit GPU clock value, or ~0 on failure.
+ */
+uint64_t amdgpu_kiq_read_clock(struct amdgpu_device *adev)
+{
+	signed long r, cnt = 0;
+	unsigned long flags;
+	uint32_t seq, reg_val_offs = 0;
+	uint64_t value = 0;
+	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
+	struct amdgpu_ring *ring = &kiq->ring;
+
+	spin_lock_irqsave(&kiq->ring_lock, flags);
+	if (amdgpu_device_wb_get(adev, &reg_val_offs)) {
+		pr_err("critical bug! too many kiq readers\n");
+		goto failed_unlock;
+	}
+	amdgpu_ring_alloc(ring, 32);
+	amdgpu_ring_write(ring, PACKET3(PACKET3_COPY_DATA, 4));
+	amdgpu_ring_write(ring, 9 |		/* src: GPU clock */
+				(5 << 8) |	/* dst: memory */
+				(1 << 16) |	/* count sel */
+				(1 << 20));	/* write confirm */
+	amdgpu_ring_write(ring, 0);
+	amdgpu_ring_write(ring, 0);
+	amdgpu_ring_write(ring, lower_32_bits(adev->wb.gpu_addr +
+				reg_val_offs * 4));
+	amdgpu_ring_write(ring, upper_32_bits(adev->wb.gpu_addr +
+				reg_val_offs * 4));
+	r = amdgpu_fence_emit_polling(ring, &seq, MAX_KIQ_REG_WAIT);
+	if (r)
+		goto failed_undo;
+
+	amdgpu_ring_commit(ring);
+	spin_unlock_irqrestore(&kiq->ring_lock, flags);
+
+	r = amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);
+
+	/* don't wait anymore for gpu reset case because this way may
+	 * block gpu_recover() routine forever, e.g. this virt_kiq_rreg
+	 * is triggered in TTM and ttm_bo_lock_delayed_workqueue() will
+	 * never return if we keep waiting in virt_kiq_rreg, which cause
+	 * gpu_recover() hang there.
+	 *
+	 * also don't wait anymore for IRQ context
+	 * */
+	if (r < 1 && (amdgpu_in_reset(adev)))
+		goto failed_kiq_read;
+
+	might_sleep();
+	while (r < 1 && cnt++ < MAX_KIQ_REG_TRY) {
+		msleep(MAX_KIQ_REG_BAILOUT_INTERVAL);
+		r = amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);
+	}
+
+	if (cnt > MAX_KIQ_REG_TRY)
+		goto failed_kiq_read;
+
+	mb();
+	value = (uint64_t)adev->wb.wb[reg_val_offs] |
+		(uint64_t)adev->wb.wb[reg_val_offs + 1] << 32ULL;
+	amdgpu_device_wb_free(adev, reg_val_offs);
+	return value;
+
+failed_undo:
+	amdgpu_ring_undo(ring);
+failed_unlock:
+	spin_unlock_irqrestore(&kiq->ring_lock, flags);
+failed_kiq_read:
+	if (reg_val_offs)
+		amdgpu_device_wb_free(adev, reg_val_offs);
+	pr_err("failed to read gpu clock\n");
+	return ~0;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 1153121e0..9ae55b060 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -4205,77 +4205,7 @@ static int gfx_v9_0_soft_reset(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static uint64_t gfx_v9_0_kiq_read_clock(struct amdgpu_device *adev)
-{
-	signed long r, cnt = 0;
-	unsigned long flags;
-	uint32_t seq, reg_val_offs = 0;
-	uint64_t value = 0;
-	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
-	struct amdgpu_ring *ring = &kiq->ring;
-
-	spin_lock_irqsave(&kiq->ring_lock, flags);
-	if (amdgpu_device_wb_get(adev, &reg_val_offs)) {
-		pr_err("critical bug! too many kiq readers\n");
-		goto failed_unlock;
-	}
-	amdgpu_ring_alloc(ring, 32);
-	amdgpu_ring_write(ring, PACKET3(PACKET3_COPY_DATA, 4));
-	amdgpu_ring_write(ring, 9 |	/* src: register*/
-				(5 << 8) |	/* dst: memory */
-				(1 << 16) |	/* count sel */
-				(1 << 20));	/* write confirm */
-	amdgpu_ring_write(ring, 0);
-	amdgpu_ring_write(ring, 0);
-	amdgpu_ring_write(ring, lower_32_bits(adev->wb.gpu_addr +
-				reg_val_offs * 4));
-	amdgpu_ring_write(ring, upper_32_bits(adev->wb.gpu_addr +
-				reg_val_offs * 4));
-	r = amdgpu_fence_emit_polling(ring, &seq, MAX_KIQ_REG_WAIT);
-	if (r)
-		goto failed_undo;
-
-	amdgpu_ring_commit(ring);
-	spin_unlock_irqrestore(&kiq->ring_lock, flags);
-
-	r = amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);
-
-	/* don't wait anymore for gpu reset case because this way may
-	 * block gpu_recover() routine forever, e.g. this virt_kiq_rreg
-	 * is triggered in TTM and ttm_bo_lock_delayed_workqueue() will
-	 * never return if we keep waiting in virt_kiq_rreg, which cause
-	 * gpu_recover() hang there.
-	 *
-	 * also don't wait anymore for IRQ context
-	 * */
-	if (r < 1 && (amdgpu_in_reset(adev)))
-		goto failed_kiq_read;
-
-	might_sleep();
-	while (r < 1 && cnt++ < MAX_KIQ_REG_TRY) {
-		msleep(MAX_KIQ_REG_BAILOUT_INTERVAL);
-		r = amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);
-	}
-
-	if (cnt > MAX_KIQ_REG_TRY)
-		goto failed_kiq_read;
-
-	mb();
-	value = (uint64_t)adev->wb.wb[reg_val_offs] |
-		(uint64_t)adev->wb.wb[reg_val_offs + 1 ] << 32ULL;
-	amdgpu_device_wb_free(adev, reg_val_offs);
-	return value;
-
-failed_undo:
-	amdgpu_ring_undo(ring);
-failed_unlock:
-	spin_unlock_irqrestore(&kiq->ring_lock, flags);
-failed_kiq_read:
-	if (reg_val_offs)
-		amdgpu_device_wb_free(adev, reg_val_offs);
-	pr_err("failed to read gpu clock\n");
-	return ~0;
-}
+/* kiq_read_clock moved to amdgpu_ring.c as amdgpu_kiq_read_clock() */
 
 static uint64_t gfx_v9_0_get_gpu_clock_counter(struct amdgpu_device *adev)
 {
@@ -4303,7 +4233,7 @@ static uint64_t gfx_v9_0_get_gpu_clock_counter(struct amdgpu_device *adev)
 		if (amdgpu_ip_version(adev, GC_HWIP, 0) ==
 			    IP_VERSION(9, 0, 1) &&
 		    amdgpu_sriov_runtime(adev)) {
-			clock = gfx_v9_0_kiq_read_clock(adev);
+			clock = amdgpu_kiq_read_clock(adev);
 		} else {
 			WREG32_SOC15(GC, 0, mmRLC_CAPTURE_GPU_CLOCK_COUNT, 1);
 			clock = (uint64_t)RREG32_SOC15(GC, 0, mmRLC_GPU_CLOCK_COUNT_LSB) |
-- 
2.43.0

