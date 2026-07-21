Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90ABAC44529
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2026 11:43:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B02910E972;
	Tue, 21 Jul 2026 11:43:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eDDYeBeX";
	dkim-atps=neutral
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com
 [209.85.218.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8941A10E962
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jul 2026 11:43:34 +0000 (UTC)
Received: by mail-ej1-f51.google.com with SMTP id
 a640c23a62f3a-c15cb6f5c12so1987783866b.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jul 2026 04:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784634213; x=1785239013; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XFYTN/LYRJYhMLbFRn+CI8HZyJMlOUT62F6H44W5mjY=;
 b=eDDYeBeX5J28XwuIggED3ysZBUpQVBkYk6qkAdHpMWFOvG7ilBaXcp3VEuf6EpLQKN
 SykXKMvvwbZ1mJRcNiQGCULcusdO3VmdBODkb7kKJoo5C+v+bUu47JlObJarBiPsjVVI
 W4KCf5A4LcNWlX0XeYePRiU7k45n5lb1a0OSj9EFy/fznEgmjD6tAOIPAmEFXrTtTnE7
 uv341KIviz9aHeqee08QjwVCQKq1SILADGaJHErkttMRP643LAHIjKV7K6fZ1Y+Esz5C
 UuY5TS7nbWGxYGG9aNn7aPylP909ZwZKUWHRs78DHXdC/laI8HhwA4maMveuF+dSQzfW
 4SgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784634213; x=1785239013;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XFYTN/LYRJYhMLbFRn+CI8HZyJMlOUT62F6H44W5mjY=;
 b=LHWOtrwUkZEjgu6oH21T5pqVcvNBN4vkLIEwhKC4BOJD2D2HF96NaKc8i8KBjWoQnP
 KJIAazmcqzTJGOB/3rf/GAbGoa6f8rErTJvqB7VL1WkglqUiCA2WItQYeNrfg/aphPA2
 trPIT3alb2zUfSnAEPRe7Sow0JGqQdpKagW0jTJYbdKPjrw8O88eRJ0mYNNAMHPUMB37
 alIzf87QuUgXHHTxkv2nOfZQOoUYHBAyBOwNL4SwlwDxVxmFEY1AvQZz6a6d/ScrtPbB
 JdzRDHBsQhy5Nb2E1IIwuaZ4lFx39SXYZ8b1Dp0YbWPvqrIspNN75zLvZJENI3i2kVNz
 /rLA==
X-Gm-Message-State: AOJu0YwI0c7aXRBGInRvwEE/YzEm6a7KopNPuFa2ydRKp0eB72AdJLfl
 WMsox2Hm9cmj5rbZuQlRmJTGUY9+4RG9Pceb5D6W0f0OKpcU8kH/zCptEE3BcRvX
X-Gm-Gg: AR+sD11mJOdlk7/D4qzE7wVrWrFbw0OwRG5E+Iozwvhx/Ec9brvTbVdIAkldTmYoru2
 DFmuwUTDtLIub+2vAct/FCXdKIOK76wxDVzHE6lEZPs3y4LoTe56AgK+dken61HDdjLTRc4N5bD
 dAxvqgciSQ0Px3+/kCevJL4ZM2x8FGqNfruljPEDccMgIyyOzkQRbog0wEy6dlR8Fw09l9avlsA
 ImzG3wkpjOxLz/rDoYetrhhwRBGYGP1Fq73J+mO7utyqJGmiDnJ+BwjWMquSIhdn7Cu/8cjK+QU
 9tOB7jgI9LHDxgAydYiOB0xcRiQbEJntlqYZ0gpb2UqP/aX6DfyEoO3oCM/qbWeukFB19ul4LbN
 NPlIwWFJXccrBdFUY35RyrkGZ8CuprsYoLQn0wP15RjO2ez8daFwk5yd5RnurSOqLcntGekCCfr
 3Vq8xe3fnA3dzZpiuAm5n3xiGJtWiuBtnmhq+zQAyNj4o=
X-Received: by 2002:a17:907:c80e:b0:c16:72ba:d352 with SMTP id
 a640c23a62f3a-c16b47d6f0fmr661292966b.31.1784634212572; 
 Tue, 21 Jul 2026 04:43:32 -0700 (PDT)
Received: from Timur-Hyperion.home (5401D94C.dsl.pool.telekom.hu.
 [84.1.217.76]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c17009ae00asm571635366b.7.2026.07.21.04.43.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 04:43:32 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, pierre-eric.pelloux-prayer@amd.com,
 Natalie Vock <natalie.vock@gmx.de>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 5/9] drm/amdgpu/gfx7: Fixup emitting SWITCH_BUFFER packets
Date: Tue, 21 Jul 2026 13:43:18 +0200
Message-ID: <20260721114322.17535-6-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260721114322.17535-1-timur.kristof@gmail.com>
References: <20260721114322.17535-1-timur.kristof@gmail.com>
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

This packet is interpreted by the CE (constant engine).
The reason why this packet is emitted is basically to
make sure the CE can't start executing packets from the
next job submission until the current one is finished.

(Note that CE is not utilized by any maintained userspace
driver and is discontinued in new GPUs. It is now also
deprecated in the kernel.)

Implement the emit_switch_buffer() function instead of emitting
them duing emit_ib, emit_pipeline_sync and emit_vm_flush.

It isn't necessary to emit these in both emit_pipeline_sync()
and emit_vm_flush() because amdgpu_vm_flush() already calls
these when calling either of those functions.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c |  7 +++++-
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c  | 32 ++++++++------------------
 2 files changed, 16 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 157d4168907c..bba29862e532 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -892,7 +892,12 @@ void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 
 	amdgpu_ring_patch_cond_exec(ring, patch);
 
-	/* the double SWITCH_BUFFER here *cannot* be skipped by COND_EXEC */
+	/*
+	 * Sync CE with ME to prevent CE from fetching the next CE IB
+	 * before the context switch is done. This is emitted before
+	 * the first IB of a job submission after a context switch.
+	 * The double SWITCH_BUFFER here *cannot* be skipped by COND_EXEC.
+	 */
 	if (ring->funcs->emit_switch_buffer) {
 		amdgpu_ring_emit_switch_buffer(ring);
 		amdgpu_ring_emit_switch_buffer(ring);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index a1dcf452ed17..6b76cf31b4d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -2201,12 +2201,6 @@ static void gfx_v7_0_ring_emit_ib_gfx(struct amdgpu_ring *ring,
 	unsigned vmid = AMDGPU_JOB_GET_VMID(job);
 	u32 header, control = 0;
 
-	/* insert SWITCH_BUFFER packet before first IB in the ring frame */
-	if (flags & AMDGPU_HAVE_CTX_SWITCH) {
-		amdgpu_ring_write(ring, PACKET3(PACKET3_SWITCH_BUFFER, 0));
-		amdgpu_ring_write(ring, 0);
-	}
-
 	if (ib->flags & AMDGPU_IB_FLAG_CE)
 		header = PACKET3(PACKET3_INDIRECT_BUFFER_CONST, 2);
 	else
@@ -2258,6 +2252,12 @@ static void gfx_v7_0_ring_emit_ib_compute(struct amdgpu_ring *ring,
 	amdgpu_ring_write(ring, control);
 }
 
+static void gfx_v7_0_ring_emit_sb(struct amdgpu_ring *ring)
+{
+	amdgpu_ring_write(ring, PACKET3(PACKET3_SWITCH_BUFFER, 0));
+	amdgpu_ring_write(ring, 0);
+}
+
 static void gfx_v7_ring_emit_cntxcntl(struct amdgpu_ring *ring, uint32_t flags)
 {
 	uint32_t dw2 = 0;
@@ -3111,14 +3111,6 @@ static void gfx_v7_0_ring_emit_pipeline_sync(struct amdgpu_ring *ring)
 	amdgpu_ring_write(ring, seq);
 	amdgpu_ring_write(ring, 0xffffffff);
 	amdgpu_ring_write(ring, 4); /* poll interval */
-
-	if (usepfp) {
-		/* sync CE with ME to prevent CE fetch CEIB before context switch done */
-		amdgpu_ring_write(ring, PACKET3(PACKET3_SWITCH_BUFFER, 0));
-		amdgpu_ring_write(ring, 0);
-		amdgpu_ring_write(ring, PACKET3(PACKET3_SWITCH_BUFFER, 0));
-		amdgpu_ring_write(ring, 0);
-	}
 }
 
 /*
@@ -3160,12 +3152,6 @@ static void gfx_v7_0_ring_emit_vm_flush(struct amdgpu_ring *ring,
 		/* sync PFP to ME, otherwise we might get invalid PFP reads */
 		amdgpu_ring_write(ring, PACKET3(PACKET3_PFP_SYNC_ME, 0));
 		amdgpu_ring_write(ring, 0x0);
-
-		/* synce CE with ME to prevent CE fetch CEIB before context switch done */
-		amdgpu_ring_write(ring, PACKET3(PACKET3_SWITCH_BUFFER, 0));
-		amdgpu_ring_write(ring, 0);
-		amdgpu_ring_write(ring, PACKET3(PACKET3_SWITCH_BUFFER, 0));
-		amdgpu_ring_write(ring, 0);
 	}
 }
 
@@ -4954,8 +4940,9 @@ static const struct amdgpu_ring_funcs gfx_v7_0_ring_funcs_gfx = {
 		7 + /* gfx_v7_0_ring_emit_hdp_flush */
 		5 + /* hdp invalidate */
 		12 + 12 + 12 + /* gfx_v7_0_ring_emit_fence_gfx x3 for user fence, vm fence */
-		7 + 4 + /* gfx_v7_0_ring_emit_pipeline_sync */
-		CIK_FLUSH_GPU_TLB_NUM_WREG * 5 + 7 + 6 + /* gfx_v7_0_ring_emit_vm_flush */
+		7 + /* gfx_v7_0_ring_emit_pipeline_sync */
+		CIK_FLUSH_GPU_TLB_NUM_WREG * 5 + 7 + 2 + /* gfx_v7_0_ring_emit_vm_flush */
+		3 * 2 + /* gfx_v7_0_ring_emit_sb x3 (from amdgpu_vm_flush, amdgpu_ib_schedule) */
 		3 + 4 + /* gfx_v7_ring_emit_cntxcntl including vgt flush*/
 		5, /* SURFACE_SYNC */
 	.emit_ib_size = 4, /* gfx_v7_0_ring_emit_ib_gfx */
@@ -4969,6 +4956,7 @@ static const struct amdgpu_ring_funcs gfx_v7_0_ring_funcs_gfx = {
 	.test_ib = gfx_v7_0_ring_test_ib,
 	.insert_nop = amdgpu_ring_insert_nop,
 	.pad_ib = amdgpu_ring_generic_pad_ib,
+	.emit_switch_buffer = gfx_v7_0_ring_emit_sb,
 	.emit_cntxcntl = gfx_v7_ring_emit_cntxcntl,
 	.emit_wreg = gfx_v7_0_ring_emit_wreg,
 	.soft_recovery = gfx_v7_0_ring_soft_recovery,
-- 
2.55.0

