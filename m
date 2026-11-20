Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD18606A320
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Nov 2026 17:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fRmq9DGx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A705810E30D;
	Fri, 20 Nov 2026 17:38:16 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0145F112BF6
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Nov 2026 17:24:29 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-4a42b34e930so928497f8f.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Nov 2026 09:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795195467; x=1795800267; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BHqPylqqQ4jkiLe/fLsfVBeed3OHv35wn6aq9NQW6gc=;
 b=fRmq9DGxP3KWZEZeasJc3QfXF0pm0MO/aQ+w2P0tk8kKlJ4axllIk/49Vw/7a7pNPc
 ibmd35hjUAfV3Pki4pcCvOIKfJ7QSLVYUUle3hrqj/lXIbwph9g9+Ou4n23cxJqlCNrJ
 FqB+6uQxopmGCnH88f1V2yy98xwwAS3ZMzkugvQLn50pawrILHk1vDRekIY6+KIpBnbU
 5uhcnuOIZLZY7TW7ItB4tk4mWWFAqX9mNKxwZHvEKkrPyIMOlHzMGU/x+Vm2vHFAVbUb
 NVWYkhGYAeQk+hSs97HSGo7gUOlOAuLrDP3NRZMzWPBwQnLvg8pDAUMp7YsF2q4wkoMq
 GsBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795195467; x=1795800267;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=BHqPylqqQ4jkiLe/fLsfVBeed3OHv35wn6aq9NQW6gc=;
 b=LZVQ4mgVKLDYiATEazmFn7VSG/4uFACyTiI4zCh3DX2yot2YyNjMHbq8C63wa0dHnt
 GJxfs+KOrxWYkp63XGZpvdMQ0p+4NEqg6FIecq3jFhWZPSjh1fpQzTFQ8pNVyviQ+tlx
 9ylylDDJEDDj5uAtVLVPdKz8Gn6nKcXbdhOc771GcxUuldSglsQYyffGc/HzXfW0oPE4
 hliHWhQRZWT1uawWaNQV+Rt79RmS7vx4MK9o1TNnomwiHYN9I0qxV4Yx5D0gRtXu2MZS
 gt7kfCrTtRIDKo9U6P8EEgO9oZ4AB3VhrxLJl+ClupRt6l9BcK+rKKPZHxIontMjr+IQ
 tFvg==
X-Gm-Message-State: APuU4Z8Rec2lS/mNZWlJeTwmPfkvVu9uAsYLsU/TRPWpMLNeOBVIU36J
 IdpMU0ZAIbjlhlMUV6z3uWN0qEl1Musm9xmP8FwxnjHduxm4rQVKpzqQmqyhizE+
X-Gm-Gg: AZFdTZeI0uQ9LpytmpDook6y2b21zLAqyR2FjnQBtGMYGqh4NmVf/TXRPbI2QO7QZAQ
 hzrf6/voSWuvzFG6hlLJPhivL85NqAY8M5MVZBuXcDrsrPzWT1fnKv8kv/LudBt8pFQ3QDDrm2c
 7Ax8G2l52X++k3O/pZwmk2HhcRXnL2K5q/UUl4/G3Lm0eKk8NlwFuOL7yDMxjDXnc5F3xdr02Gw
 QcSlrSwzuXiPy7/L+adZbPu73Vra8E+eACwb5Jj2ZoUGhZeLIWqXcqUzGVQ34edKcEKCpuVbXFk
 I8AJ6PoGJdmDhGFNRyMiBpsmq6ysEUg5WTKLyx8O+xJxGB3DALcmUbDLgrPaei/353QztjfPq6H
 CmZw1Eojv0EtCeokhzaWaXn4FI+Djy6YfH5z9zgJdMAl6uOMMHtg/cl/q3tVhnzHqmNNu1pve/j
 u+C/B+F5AjqSqakGEIT9BHS5OnemKqxzpfo7KQIKclmu4tZXswEf4SbZehHEgpwwzphgxc2LTx6
 ZavXhJNUxwOPI1FkxkSnFWhrA1U2OaDWE+iA/uE5cV67Kg0ai9Q3irfQ1lWMFOSZKkMHze8jhO2
 sokB2xwuRYKQr0q2fwyVTHcPGu/2MtyU5TUd38Bn4TUKPqkU9IfP1twqQHDXTVIZaS9RAVjJuFj
 3tlwCDrCeZdQ36uLzu2NnZI05l9buUCS/Y08=
X-Received: by 2002:a5d:59c9:0:b0:4ab:f5b0:a7fa with SMTP id
 ffacd0b85a97d-4abf5b0a975mr6980231f8f.33.1795195467201; 
 Fri, 20 Nov 2026 09:24:27 -0800 (PST)
Received: from Arbeitszimmer.fritz.box
 ([2001:9e8:db29:4c00:a7d0:374b:43f1:90ea])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6b110c3csm6924137f8f.36.2026.11.20.09.24.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 09:24:26 -0800 (PST)
From: Christoph Berliner <caberliner@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, Jiqian.Chen@amd.com,
 Christoph Berliner <caberliner@gmail.com>
Subject: [PATCH 2/2] drm/amdgpu/gfx9: deactivate all compute HQDs before MODE2
 on Renoir
Date: Fri, 20 Nov 2026 18:24:07 +0100
Message-ID: <20261120172407.64651-3-caberliner@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261120172407.64651-1-caberliner@gmail.com>
References: <20261120172407.64651-1-caberliner@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 20 Nov 2026 17:38:15 +0000
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
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Renoir (GC 9.3.0) MODE2 does not reset the CP HQD registers. Commit
c3988a7ad479 ("drm/amdgpu/gfx9: Fix Ring and IB test fail after mode2")
deactivates the HQDs of the kernel compute queues before MODE2, but the
HQDs owned by KFD stay active as well:

- the HIQ is never destroyed during a GPU reset, because
  kq_uninitialize() skips destroy_mqd() when it cannot take the reset
  domain semaphore, which amdgpu_device_gpu_recover() holds for write
  before calling amdgpu_amdkfd_pre_reset();
- user queues mapped by the HWS stay active when the preceding unmap
  failed (which is the usual reason for the reset).

After MODE2 the MEC is unhalted with the stale HIQ. The reset reports
success and graphics/KCQs work again, but the HWS no longer answers:
the next KFD queue creation runs into

  amdgpu: qcm fence wait loop timeout expired
  amdgpu: The cp might be in an unrecoverable state due to an unsuccessful queues preemption
  amdgpu: process pid ... DQM create queue type 0 failed. ret -62

which triggers another reset, and KFD stays unusable until reboot.

On Renoir, deactivate every active HQD of all MECs before MODE2 except
the KIQ, which gfx_v9_0_kiq_init_register() reprograms on resume. The
KIQ is also identified by its MQD address, because on Renoir the HQD
registers of MEC2 pipes 2/3 read back as those of pipes 0/1 and the KIQ
would otherwise get a dequeue request through the alias.

Tested on Ryzen 5 5600G (Cezanne, gfx90c, GC 9.3.0), MEC firmware
0x1e3, HWS enabled, amdgpu.noretry=1, with an instrumented build that
uses the old path for the first MODE2 and the new one afterwards (same
boot):

- MODE2 #1 (old path): after the reset, before KIQ init, the HIQ
  (MEC2 pipe 0 queue 0) is still ACTIVE with its old MQD/PQ; the next
  HIP program fails with the messages above (GPU hang) and KFD triggers
  MODE2 #2.
- MODE2 #2 (new path, first revision without the alias check): all
  active HQDs deactivated, only the KIQ active at resume; HIP and
  rocBLAS tests pass afterwards.

This version (with the KIQ alias check) was then tested on its own,
loaded at boot: a requested reset deactivated 9 HQDs (8 KCQs + HIQ),
skipped the KIQ seen through the pipe alias, and HIP/rocBLAS tests
passed before and after the reset.

Other gfx9 APUs (Raven/Picasso, gfx902/gfx909) probably have the same
issue, since kq_uninitialize() behaves the same there, but they keep
the existing KCQ-only behaviour because this could not be tested on
them.

Fixes: c3988a7ad479 ("drm/amdgpu/gfx9: Fix Ring and IB test fail after mode2")
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/6177
Assisted-by: Claude Code
Signed-off-by: Christoph Berliner <caberliner@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 55 ++++++++++++++++++++++++++-
 1 file changed, 53 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index b60b6fa88..59c0cbd86 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -4119,6 +4119,53 @@ static void gfx_v9_0_deactivate_kcq_hqd(struct amdgpu_device *adev)
 	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
 }
 
+/*
+ * Renoir: MODE2 does not reset the CP HQD registers. Besides the KCQs, the
+ * HQDs owned by KFD (HIQ and the user queues mapped by the HWS) also stay
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
+				 * On Renoir the HQD registers of MEC2 pipes 2/3
+				 * read back as those of pipes 0/1, so the KIQ
+				 * shows up a second time. Skip it by its MQD
+				 * address instead of sending it a dequeue.
+				 */
+				mqd_addr = ((u64)RREG32_SOC15(GC, 0, mmCP_MQD_BASE_ADDR_HI) << 32) |
+					   RREG32_SOC15(GC, 0, mmCP_MQD_BASE_ADDR);
+				if (mqd_addr == kiq_mqd_addr)
+					continue;
+				if (gfx_v9_0_deactivate_hqd(adev, me, pipe, queue))
+					n++;
+			}
+		}
+	}
+	soc15_grbm_select(adev, 0, 0, 0, 0, 0);
+	mutex_unlock(&adev->srbm_mutex);
+	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
+
+	dev_dbg(adev->dev, "deactivated %u active compute HQDs before MODE2\n", n);
+}
+
 static int gfx_v9_0_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
@@ -4144,8 +4191,12 @@ static int gfx_v9_0_hw_fini(struct amdgpu_ip_block *ip_block)
 	}
 
 	if ((adev->flags & AMD_IS_APU) && amdgpu_in_reset(adev) &&
-		amdgpu_asic_reset_method(adev) == AMD_RESET_METHOD_MODE2)
-		gfx_v9_0_deactivate_kcq_hqd(adev);
+	    amdgpu_asic_reset_method(adev) == AMD_RESET_METHOD_MODE2) {
+		if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 3, 0))
+			gfx_v9_0_deactivate_all_hqd(adev);
+		else
+			gfx_v9_0_deactivate_kcq_hqd(adev);
+	}
 
 	/* Use deinitialize sequence from CAIL when unbinding device from driver,
 	 * otherwise KIQ is hanging when binding back
-- 
2.56.1

