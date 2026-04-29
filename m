Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9A6FCD13D2
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Apr 2026 10:26:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40D1F10EF7B;
	Wed, 29 Apr 2026 10:26:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ll64YMHV";
	dkim-atps=neutral
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com
 [209.85.210.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D484C10E03A
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Apr 2026 03:26:24 +0000 (UTC)
Received: by mail-ot1-f44.google.com with SMTP id
 46e09a7af769-7dcdaf06498so5541141a34.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Apr 2026 20:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777433184; x=1778037984; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=40JxlhhqZWV8GMu2G5Kn5Dej6BzcRUpmj8d/0CBVtY8=;
 b=ll64YMHVhf1VGmOnIFL3epUstL2L6hY+b8bp2mpasS4TGUjT/RVxQYFepQoguu8l0g
 vQcAj+Z4czYfQmc6Fb9wWsluFadHfxoCeWDkg8O83osp8IF0u2fKN6N4tzyj3ktpyTV8
 8fEPxM3w6ppRLE0aG3UikQuCdXoYMyxJM5PLDmL6F3n2njA1wQjLS4zHe2mZ0DzYkVjR
 Xw3EBnRI6+3snUxVUyZ66Y665D3ZS932ALzY6MSK15Iw1JMJ9IPHfcyKiwmrkeJuK+Cg
 Bg4Nzhz9khoe5Ts6XzsI36JCFj9HIh6tDGMj+ZmaD47j6MFzM3CBQMO7ZxLFkQXXEvhb
 9kUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777433184; x=1778037984;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=40JxlhhqZWV8GMu2G5Kn5Dej6BzcRUpmj8d/0CBVtY8=;
 b=D9W6/F4YwYpQuTM8y21HALrE0ey/L6lPnQd6O0tzNUKUVGZ1WD3SRC2jh4d/uPdG/Y
 LCCQH+9Dt01DI9/Ulvx9bK12+dvl7t+oLVGh+Vo+NbCQfBg6ui9EjhhGbJ6X0aLJH+v7
 CNdVLemGZcbf3fqKTV9jm/UFXpwMGq7QDNDzJ/5xwHr4QZWiMXUv4GlARy6Iqb+S20MF
 ay47mLEiHDajO1kzvZ1OzLp5cYmEcojwUXHkO0wUXOM15BF+t4cuM8NpkDlp29z1a9BY
 pvo6nppaYwsFI6AhIr6g6rJtABTxgrxanFgwFbGKCThgePsttTp57RUDKlpqO9HxvhrL
 IcnQ==
X-Gm-Message-State: AOJu0YweS2oQdydzFE3CCXy4fz3JocczLREZuv31iMRCpLUa2JntU8UM
 FJGnhqde/lWzPSBTXhKXspGAkOBd+TDhR/O072oUDxFcaS5u551YwXU=
X-Gm-Gg: AeBDievUpIDcjPMvkfOSvxPYd9DoEX2TibEn3wbxqVZePDxC0Tj1ocJzF75kTB/+Y8D
 54y60jgWUAWqgl76y0qA0D601P9oyi1ov5mtO02oPPqUE8loYLWevEA4o6TSTTk+HxvZuVSFbie
 mW62DdiPia84gocHfWOxRpr5ml6gRn1f46GrG1BYb18dFH5j42k6+k02bUDRq/SZq73mrvdXtLH
 zyNELvUnqevz84FF66Q2CCg23oWSxj11NWdTOOJqgAucie21uI5SFaihMELTtHHIBQnTUhCLLIh
 K5XsC4BZbLzl8JmHFEZeB2Blpy++6PuGGx8kbBM/LmIZeCrwm9Gs/14NKOdgRFClyjN+FyiF8Hq
 /T23eEN/h5j8gFlhF8qzn/7AFW9JhX5M50FVn8vGJJ/EoG8fJqfV8GYtse645ZROhPwBfp754FV
 sNmnrCvGwxGRAkD6iEby93EvBZ36DBXY4YHfPSLMcCWrSHlQwKQuL+eqibwGbwLZ14PpP+LIATO
 cHOenNcNwpLalAD4YtZh71+vWMPxcKzhKQ=
X-Received: by 2002:a4a:ee07:0:b0:696:248f:807a with SMTP id
 006d021491bc7-6965cb96417mr3063406eaf.40.1777433183875; 
 Tue, 28 Apr 2026 20:26:23 -0700 (PDT)
Received: from localhost.localdomain ([47.188.191.104])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6966bc3be04sm405156eaf.8.2026.04.28.20.26.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 20:26:23 -0700 (PDT)
From: "John B. Moore" <jbmoore61@gmail.com>
To: christian.koenig@amd.com,
	alexander.deucher@amd.com
Cc: amd-gfx@lists.freedesktop.org,
	jbmoore61@gmail.com
Subject: [PATCH v4 1/2] drm/amdgpu/gfx9: replace BUG_ON/BUG with WARN_ON_ONCE
 in ring emission
Date: Tue, 28 Apr 2026 22:26:20 -0500
Message-ID: <20260429032621.10888-1-jbmoore61@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Replace all BUG_ON() and BUG() assertions in the gfx_v9_0 ring
emission paths with WARN_ON_ONCE() and graceful recovery, or proper
error returns.

Nine sites are converted across wait_reg_mem, gpu_early_init,
parse_ind_reg_list, init_rlc_save_restore_list, kiq_read_clock,
emit_ib_gfx, emit_ib_compute, emit_fence, and get/set_wptr_compute.

Changes since v3 (incorporating Christian König's review):
- gfx_v9_1_init_rlc_save_restore_list: return -EINVAL and kfree()
  instead of WARN_ON_ONCE + break, to properly abort driver loading.
  Caller gfx_v9_0_init_pg now checks the return value.
- gfx_v9_0_kiq_read_clock: drop the BUG_ON(!emit_rreg) check entirely
  rather than converting to WARN_ON. If KIQ cannot emit registers the
  driver would never have loaded in the first place.
- gfx_v9_0_ring_get/set_wptr_compute: drop the if (ring->use_doorbell)
  guard entirely since gfx9 compute always uses doorbell. Replace
  atomic64_read/set with READ_ONCE/WRITE_ONCE since wptr_cpu_addr
  points to system memory, not MMIO.

The remaining BUG_ON in emit_fence_kiq (64-bit flag) is addressed
separately in the KIQ fence flag patch series.

Found by a custom amdgpu DRM ioctl fuzzer.

Fixes: b1023571479020e9 ("drm/amdgpu: implement GFX 9.0 support (v2)")
Signed-off-by: John B. Moore <jbmoore61@gmail.com>
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 60 ++++++++++++++-------------
 1 file changed, 31 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 7e9d753f4..1153121e0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -1182,8 +1182,8 @@ static void gfx_v9_0_wait_reg_mem(struct amdgpu_ring *ring, int eng_sel,
 				 WAIT_REG_MEM_FUNCTION(3) |  /* equal */
 				 WAIT_REG_MEM_ENGINE(eng_sel)));
 
-	if (mem_space)
-		BUG_ON(addr0 & 0x3); /* Dword align */
+	if (mem_space && WARN_ON_ONCE(addr0 & 0x3))
+		addr0 &= ~0x3; /* Force dword align */
 	amdgpu_ring_write(ring, addr0);
 	amdgpu_ring_write(ring, addr1);
 	amdgpu_ring_write(ring, ref);
@@ -2107,8 +2107,10 @@ static int gfx_v9_0_gpu_early_init(struct amdgpu_device *adev)
 			return err;
 		break;
 	default:
-		BUG();
-		break;
+		dev_err(adev->dev,
+			"unsupported GFX IP version 0x%x for gfx_v9_0\n",
+			amdgpu_ip_version(adev, GC_HWIP, 0));
+		return -EINVAL;
 	}
 
 	adev->gfx.config.gb_addr_config = gb_addr_config;
@@ -2808,7 +2810,8 @@ static void gfx_v9_1_parse_ind_reg_list(int *register_list_format,
 					break;
 			}
 
-			BUG_ON(idx >= unique_indirect_reg_count);
+			if (WARN_ON_ONCE(idx >= unique_indirect_reg_count))
+				break;
 
 			if (!unique_indirect_regs[idx])
 				unique_indirect_regs[idx] = register_list_format[indirect_offset];
@@ -2885,7 +2888,11 @@ static int gfx_v9_1_init_rlc_save_restore_list(struct amdgpu_device *adev)
 			}
 		}
 
-		BUG_ON(j >= unique_indirect_reg_count);
+		if (j >= unique_indirect_reg_count) {
+			dev_err(adev->dev, "init_rlc_save_restore_list: indirect reg not found in unique list\n");
+			kfree(register_list_format);
+			return -EINVAL;
+		}
 
 		i++;
 	}
@@ -3103,8 +3110,10 @@ static void gfx_v9_0_init_pg(struct amdgpu_device *adev)
 	if (adev->gfx.rlc.is_rlc_v2_1) {
 		if (amdgpu_ip_version(adev, GC_HWIP, 0) ==
 			    IP_VERSION(9, 2, 1) ||
-		    (adev->apu_flags & AMD_APU_IS_RAVEN2))
-			gfx_v9_1_init_rlc_save_restore_list(adev);
+		    (adev->apu_flags & AMD_APU_IS_RAVEN2)) {
+			if (gfx_v9_1_init_rlc_save_restore_list(adev))
+				return;
+		}
 		gfx_v9_0_enable_save_restore_machine(adev);
 	}
 
@@ -4205,8 +4214,6 @@ static uint64_t gfx_v9_0_kiq_read_clock(struct amdgpu_device *adev)
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
 	struct amdgpu_ring *ring = &kiq->ring;
 
-	BUG_ON(!ring->funcs->emit_rreg);
-
 	spin_lock_irqsave(&kiq->ring_lock, flags);
 	if (amdgpu_device_wb_get(adev, &reg_val_offs)) {
 		pr_err("critical bug! too many kiq readers\n");
@@ -5427,7 +5434,8 @@ static void gfx_v9_0_ring_emit_ib_gfx(struct amdgpu_ring *ring,
 	}
 
 	amdgpu_ring_write(ring, header);
-	BUG_ON(ib->gpu_addr & 0x3); /* Dword align */
+	if (WARN_ON_ONCE(ib->gpu_addr & 0x3)) /* Dword align */
+		ib->gpu_addr &= ~0x3ULL;
 	amdgpu_ring_write(ring,
 #ifdef __BIG_ENDIAN
 		(2 << 0) |
@@ -5523,7 +5531,8 @@ static void gfx_v9_0_ring_emit_ib_compute(struct amdgpu_ring *ring,
 	}
 
 	amdgpu_ring_write(ring, PACKET3(PACKET3_INDIRECT_BUFFER, 2));
-	BUG_ON(ib->gpu_addr & 0x3); /* Dword align */
+	if (WARN_ON_ONCE(ib->gpu_addr & 0x3)) /* Dword align */
+		ib->gpu_addr &= ~0x3ULL;
 	amdgpu_ring_write(ring,
 #ifdef __BIG_ENDIAN
 				(2 << 0) |
@@ -5563,10 +5572,13 @@ static void gfx_v9_0_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
 	 * the address should be Qword aligned if 64bit write, Dword
 	 * aligned if only send 32bit data low (discard data high)
 	 */
-	if (write64bit)
-		BUG_ON(addr & 0x7);
-	else
-		BUG_ON(addr & 0x3);
+	if (write64bit) {
+		if (WARN_ON_ONCE(addr & 0x7))
+			addr &= ~0x7ULL;
+	} else {
+		if (WARN_ON_ONCE(addr & 0x3))
+			addr &= ~0x3ULL;
+	}
 	amdgpu_ring_write(ring, lower_32_bits(addr));
 	amdgpu_ring_write(ring, upper_32_bits(addr));
 	amdgpu_ring_write(ring, lower_32_bits(seq));
@@ -5632,14 +5644,8 @@ static u64 gfx_v9_0_ring_get_rptr_compute(struct amdgpu_ring *ring)
 
 static u64 gfx_v9_0_ring_get_wptr_compute(struct amdgpu_ring *ring)
 {
-	u64 wptr;
-
 	/* XXX check if swapping is necessary on BE */
-	if (ring->use_doorbell)
-		wptr = atomic64_read((atomic64_t *)ring->wptr_cpu_addr);
-	else
-		BUG();
-	return wptr;
+	return READ_ONCE(*(u64 *)ring->wptr_cpu_addr);
 }
 
 static void gfx_v9_0_ring_set_wptr_compute(struct amdgpu_ring *ring)
@@ -5647,12 +5653,8 @@ static void gfx_v9_0_ring_set_wptr_compute(struct amdgpu_ring *ring)
 	struct amdgpu_device *adev = ring->adev;
 
 	/* XXX check if swapping is necessary on BE */
-	if (ring->use_doorbell) {
-		atomic64_set((atomic64_t *)ring->wptr_cpu_addr, ring->wptr);
-		WDOORBELL64(ring->doorbell_index, ring->wptr);
-	} else{
-		BUG(); /* only DOORBELL method supported on gfx9 now */
-	}
+	WRITE_ONCE(*(u64 *)ring->wptr_cpu_addr, ring->wptr);
+	WDOORBELL64(ring->doorbell_index, ring->wptr);
 }
 
 static void gfx_v9_0_ring_emit_fence_kiq(struct amdgpu_ring *ring, u64 addr,
-- 
2.43.0

