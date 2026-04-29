Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D43FCFF8877
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Apr 2026 10:26:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5621510EF73;
	Wed, 29 Apr 2026 10:26:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="N8nLTKXb";
	dkim-atps=neutral
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com
 [209.85.167.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E95A10EE2A
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Apr 2026 02:09:43 +0000 (UTC)
Received: by mail-oi1-f182.google.com with SMTP id
 5614622812f47-47bfa080d93so1985987b6e.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Apr 2026 19:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777428582; x=1778033382; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nswOFEXs658sWrvLAvjXZ4RGUs1F9xaugJk5+hXxT0M=;
 b=N8nLTKXbgblxat1YCdA59EoPJgTdr/Q0ad7HCQY29bKIXPyfbGjtciMezzBtF/oIE4
 sRpCEij5jWU604bgJ+dU99bMdIsYIJ+WWPmoALHUTVZKlJQ44/pdwAJZ8mNkeWy3bLiA
 DnRgIPusVkmiIHsw027DqvdAWGesz1RXQ+DVtKGlKcxGwEiSAkUEVtCVUj2fxki6wMQi
 k1kc1iD/ONFAduuRf/flIdjV+/CtOznIoscvzIVI/BOg+QQKaGzLUsSAtY++76f6ODWZ
 BnEqUfxRYZ/UBb55i7rfrCtz8jj0OqCYrMo7aJoRBYNI4jNIuMma5zc16Km+dFne7GI3
 kGig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777428582; x=1778033382;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nswOFEXs658sWrvLAvjXZ4RGUs1F9xaugJk5+hXxT0M=;
 b=rMBWogsoZQYf9twQmW3Cw4NT7CIlSIq33fqFnUOfRLnGW6AtLsyc7r1Vk2cxzMJ+Qd
 +ZK1jXoiDBMzOrn3IRqfqKAn5CClivHVT8IXL5Z3zfprsoo2N9/DHie+NB3KCa5d6IxP
 n5c09Gh180hVeJMHcDn1lyoJyRrjAY89WgtgCU5zylstrRZ5xRMchMXpEaH54uT/4Taz
 4cS4b3bEYtJPJlu+uGY4K04GLTqgCSC60Pk/xWOFWJqICz+7lZpj3Y09zNVwbPthrUAe
 e0F7QQps6j+43Gwp7SoG4ldKrOy8T14FbdWQpkt73EU0nyYsW4nNb+18GO8jIcZvUep9
 Xz/Q==
X-Gm-Message-State: AOJu0Yy/RywiHYfm74BE9UOzBvtRtGgcko3F0oGrhs4m1pkA+NN9lMLT
 WYK0/Fne8kVilfy8jMpzfg58Lrtbwnna5OUFTv9Nis8uGTpkojLWHqk=
X-Gm-Gg: AeBDietzG2dpRNGDsFdp55xY6P5SIg6JHqwY3Low8lM39I7lq0xlU9iGoYuWhUdTPd1
 cQ1jcMnTZPVdVgLlKqkv2MKZTfZ71SlwhPSOQXQDuid/zTL9inlKjVFb/8/eb1BFNYiYBwFUx0C
 SFBQ7wzA+DqfAxhUC0fGvTY2iWW3gyFNdoA4t+RgRNc0JEpF1J+34m9l5iPFooD3OdVzamIX+Lo
 D/lwUyH7Vf7uq9tuVtLqlL3HnHLyf8Z2UABm5w0aoHYp9+69ImfV/sb6v5XikHbS2i6ykjFQRZH
 eKj0SZ/kIlRm+Mp3+5c7lldWoP+3Nj5xzrPZ0xQSzCsaXzxNEXB4/lr2ITFozLZGZCrNJJ6lm2i
 Au9scp3tH2QmU9gGjE1LvskethbATWVR0iQA9oV5xJRYBxeqKzye/81AK6O4/iH797YqIMGD15C
 pz6TCbxzw2tijQnSVmriROXBzn2aEP9+0rOXzMj2xTnep2OR0WD9nNR5yLaec8BOvvCPW1AAUd3
 PnoUdxA1m0fu+joG2f8Pz61DItGBfXEuxjO+HhBU+yT7g==
X-Received: by 2002:a05:6808:178a:b0:463:efb4:f9a2 with SMTP id
 5614622812f47-47c28f641a2mr3316095b6e.28.1777428582200; 
 Tue, 28 Apr 2026 19:09:42 -0700 (PDT)
Received: from localhost.localdomain ([47.188.191.104])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-47c43edfd3csm293627b6e.5.2026.04.28.19.09.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 19:09:41 -0700 (PDT)
From: "John B. Moore" <jbmoore61@gmail.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alexander Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, "John B. Moore" <jbmoore61@gmail.com>,
 stable@vger.kernel.org
Subject: [PATCH v4] drm/amdgpu/gfx9: replace BUG_ON/BUG with WARN_ON_ONCE in
 ring emission
Date: Tue, 28 Apr 2026 21:09:41 -0500
Message-ID: <20260429020941.33422-1-jbmoore61@gmail.com>
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

Replace BUG_ON() and BUG() assertions in the gfx_v9_0 ring emission
and support paths with WARN_ON_ONCE() and graceful recovery.  Nine
sites are converted across wait_reg_mem, gpu_early_init,
parse_ind_reg_list, init_rlc_save_restore_list, emit_ib_gfx,
emit_ib_compute, emit_fence, get_wptr_compute, and set_wptr_compute.

These assertions guard conditions that are either:
- Address alignment checks on a deprecated byte-swap encoding from
  legacy pre-amdgpu hardware (bits [1:0] must be zero), or
- Switch-case defaults that should be unreachable but are better
  handled with dev_err + return -EINVAL than a kernel panic.

Several of the address alignment BUG_ON sites in the IB emission
paths (emit_ib_gfx, emit_ib_compute) are reachable from unprivileged
userspace via crafted DRM_IOCTL_AMDGPU_CS submissions, causing a
fatal kernel panic in a scheduler worker thread.

For address checks, clear the reserved bits and proceed.  For
unreachable switch defaults, log the error and return.  For the
doorbell-only wptr paths, log with WARN_ONCE and return zero /
no-op.  For init_rlc_save_restore_list, return -EINVAL to abort
driver loading.  Ring emission callbacks return void, so
force-aligning and proceeding is the accepted pattern.

The kiq_read_clock BUG_ON is handled separately as it requires
a larger refactor (moving to amdgpu_ring.c as common code).

Found by a custom amdgpu DRM ioctl fuzzer.

Signed-off-by: John B. Moore <jbmoore61@gmail.com>
Cc: stable@vger.kernel.org
---
Changes v3 -> v4:
  - Fixed malformed patch (v3 had wrong hunk line count)

Changes v2 -> v3:
  - Dropped kiq_read_clock hunk (separate refactor per review)
  - init_rlc_save_restore_list: return -EINVAL instead of break,
    to abort driver loading (per Christian König review)
  - Dropped Fixes tag (issue predates the referenced commit)

 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 49 ++++++++++++++++++-----------
 1 file changed, 30 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 2eb32f92a..47e81c33d 100644
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
@@ -2885,7 +2888,8 @@ static int gfx_v9_1_init_rlc_save_restore_list(struct amdgpu_device *adev)
 			}
 		}
 
-		BUG_ON(j >= unique_indirect_reg_count);
+		if (WARN_ON_ONCE(j >= unique_indirect_reg_count))
+			return -EINVAL;
 
 		i++;
 	}
@@ -5431,7 +5435,8 @@ static void gfx_v9_0_ring_emit_ib_gfx(struct amdgpu_ring *ring,
 	}
 
 	amdgpu_ring_write(ring, header);
-	BUG_ON(ib->gpu_addr & 0x3); /* Dword align */
+	if (WARN_ON_ONCE(ib->gpu_addr & 0x3)) /* Dword align */
+		ib->gpu_addr &= ~0x3ULL;
 	amdgpu_ring_write(ring,
 #ifdef __BIG_ENDIAN
 		(2 << 0) |
@@ -5527,7 +5532,8 @@ static void gfx_v9_0_ring_emit_ib_compute(struct amdgpu_ring *ring,
 	}
 
 	amdgpu_ring_write(ring, PACKET3(PACKET3_INDIRECT_BUFFER, 2));
-	BUG_ON(ib->gpu_addr & 0x3); /* Dword align */
+	if (WARN_ON_ONCE(ib->gpu_addr & 0x3)) /* Dword align */
+		ib->gpu_addr &= ~0x3ULL;
 	amdgpu_ring_write(ring,
 #ifdef __BIG_ENDIAN
 				(2 << 0) |
@@ -5567,10 +5573,13 @@ static void gfx_v9_0_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
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
@@ -5639,10 +5648,13 @@ static u64 gfx_v9_0_ring_get_wptr_compute(struct amdgpu_ring *ring)
 	u64 wptr;
 
 	/* XXX check if swapping is necessary on BE */
-	if (ring->use_doorbell)
+	if (ring->use_doorbell) {
 		wptr = atomic64_read((atomic64_t *)ring->wptr_cpu_addr);
-	else
-		BUG();
+	} else {
+		WARN_ONCE(1, "gfx_v9_0: non-doorbell wptr read on ring %s, only doorbell method supported on gfx9\n",
+			  ring->name);
+		wptr = 0;
+	}
 	return wptr;
 }
 
@@ -5654,8 +5666,9 @@ static void gfx_v9_0_ring_set_wptr_compute(struct amdgpu_ring *ring)
 	if (ring->use_doorbell) {
 		atomic64_set((atomic64_t *)ring->wptr_cpu_addr, ring->wptr);
 		WDOORBELL64(ring->doorbell_index, ring->wptr);
-	} else{
-		BUG(); /* only DOORBELL method supported on gfx9 now */
+	} else {
+		WARN_ONCE(1, "gfx_v9_0: non-doorbell wptr write on ring %s, only doorbell method supported on gfx9\n",
+			  ring->name);
 	}
 }
 
-- 
2.43.0

