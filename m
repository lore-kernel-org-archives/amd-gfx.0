Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F8FAC55179
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Aug 2026 13:23:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA74F10E6BB;
	Mon,  3 Aug 2026 13:23:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="rPUz0/tR";
	dkim-atps=neutral
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com
 [209.85.218.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE99910E6A6
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Aug 2026 13:23:14 +0000 (UTC)
Received: by mail-ej1-f43.google.com with SMTP id
 a640c23a62f3a-c1c24ec9525so567395166b.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 03 Aug 2026 06:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785763393; x=1786368193; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nbIx4qxIEd3wLOlS9LN/dJJu9lLZcDjYmzB8FCBPBAY=;
 b=rPUz0/tRpWpguw7VIIPg7R3KeNcXfheCahMBVD1JwGQ5lHtKWoKXJWyKW7FrYykagB
 f3lLmTGh1SDf2eW6tzczOgTG05cj67JP8210Wi1q6dzBS6Dygk8aDGw9ncR9mrXZ9cMY
 2PSWXf+PGSyi6ge0ThT9wTtK6HNO0yUP4PN9BJr9P8nIGP6jiEWu555WYKS3TohvCuGL
 UXvT4DSLDkAMZ+l/ZhrGpsa7lDPgBPLPFr0O7Xbfu7t7+w27Owyy6He2a9cuIJytxjBH
 TphHANdg0VflTJtmM/fPBIwdoKQP8B2OLuZUX5oh9eX/OQMMxKBOJuakhFDQWf1+vbHB
 bXww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785763393; x=1786368193;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nbIx4qxIEd3wLOlS9LN/dJJu9lLZcDjYmzB8FCBPBAY=;
 b=Rlt+aouF5dSZUHx8sZCeoYT+3WWXs753Cp4QCXmNHXWxht6FeSEzfLrFxoNKRz1aVS
 oclFKhwLfPgvm2lgQ4xPTdR+9Zs3pT4Vp2bFhG5duQ9F2cq607SHLd1XHHDxj9FSJ0U9
 N2R0sS/23Ur2kt6m3FmdivcKTOlMFD34fWmaWr9BHZia2q6AAn1YYHptGEOiuFBSEjk9
 cJGOq61nVNwFWfFs4t9n8MAqWSOv9nQ+kf5d4FX+/33bZvaxjpRzgRHgQgmyEhWCkVUp
 ulirISu29vdueevhNsyNzHuc3VV8ceIlk3QeF0KGMD/qbDtDO6PovjEeO4NllmQ7wWRo
 L/TA==
X-Gm-Message-State: AOJu0YxX+8xZ3DiTNGvFEYlBFLcrtpO0XcLNLl9DRJvierYw5E09QVnV
 Tt2oKaPJ8jr/Zu64VhLTnVFcHc7dgL4XU53aWMoexui2wqrn/EorUbnq03MEzorc
X-Gm-Gg: AR+sD12sFQpYVLBCFKKjTtR+yDzD+GcAGnBY2IkwUYyEi2X55yuzQTGjTsoPA5mSsCm
 IldstaFM0rmFCPCipruyDnq0vRlB10PspiCto0pJk9yaYhzqvhRAIWDsqC3PJYm99cW6J9fs/mV
 tprqiJ9h3HXZJiD7NEwBodlUgQEZTNxgzp18xBqBlEWwj2/UJdTfrG67zpHLIoFuG+2mivwxEXD
 iw7ocVHhkMmZ6bKRLEYyaOacAiBYJCL0e6qFalkUQ/1mYtOYjP6yaVoXn/W/T0Rs1/l63WnTU/Z
 hIUAk9IG5ck4aSwKM2fepGhRthVcxsuqPN2UXcBAo0s+hn7S+/05q/O6Bp7jEguFqkYvQHRclWH
 e98UO6Oc2qMEa4B+oK/icAy1WFuyiuGUUyKN1zwYI0rTXcixic5sT7cvm+C6bTwDRM+zpsk2UxI
 AlwMk2erA/QUTZiGJhr/eWcK+Z6sTwLXutdgskCPkP2QMDPiSCZQPFoEarUJ9xATKKfEiJl8DgN
 S6VXdPIxHHR+fpFj7DVbiYJ8ltLKyg=
X-Received: by 2002:a17:907:97d6:b0:c20:899:b8bc with SMTP id
 a640c23a62f3a-c200899bac0mr454181266b.6.1785763392919; 
 Mon, 03 Aug 2026 06:23:12 -0700 (PDT)
Received: from Timur-Hyperion.home (5401D2B5.dsl.pool.telekom.hu.
 [84.1.210.181]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1fd445432dsm549201266b.41.2026.08.03.06.23.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 06:23:12 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, Natalie Vock <nat@pixelcluster.dev>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 01/10] drm/amdgpu/gfx6: Fixup emit_cntxcntl()
Date: Mon,  3 Aug 2026 15:23:00 +0200
Message-ID: <20260803132309.36326-2-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260803132309.36326-1-timur.kristof@gmail.com>
References: <20260803132309.36326-1-timur.kristof@gmail.com>
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

Set bits on dword 2 like GFX7-8 except load_global_uconfig
which doesn't exist on GFX6.

Emit VS_PARTIAL_FLUSH before VGT_FLUSH like GFX7-8.

For reference see old PAL which explains the bit fields in
this register and that load_global_uconfig doesn't exist on GFX6
and also see gfx_v7_ring_emit_cntxcntl() for the GFX7 code
which this commit follows.

Fixes: 2cd46ad22383 ("drm/amdgpu: add graphic pipeline implementation for si v8")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c | 28 ++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
index cd2a14ecdba8..0cbaae73a0bf 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
@@ -1882,11 +1882,13 @@ static int gfx_v6_0_ring_test_ring(struct amdgpu_ring *ring)
 	return r;
 }
 
-static void gfx_v6_0_ring_emit_vgt_flush(struct amdgpu_ring *ring)
+static void gfx_v6_0_ring_emit_event_write(struct amdgpu_ring *ring,
+					   uint32_t event_type,
+					   uint32_t event_index)
 {
 	amdgpu_ring_write(ring, PACKET3(PACKET3_EVENT_WRITE, 0));
-	amdgpu_ring_write(ring, EVENT_TYPE(VGT_FLUSH) |
-		EVENT_INDEX(0));
+	amdgpu_ring_write(ring, EVENT_TYPE(event_type) |
+				EVENT_INDEX(event_index));
 }
 
 static void gfx_v6_0_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
@@ -2997,10 +2999,22 @@ static uint64_t gfx_v6_0_get_gpu_clock_counter(struct amdgpu_device *adev)
 
 static void gfx_v6_ring_emit_cntxcntl(struct amdgpu_ring *ring, uint32_t flags)
 {
-	if (flags & AMDGPU_HAVE_CTX_SWITCH)
-		gfx_v6_0_ring_emit_vgt_flush(ring);
+	u32 dw2 = 0x80000000; /* set load_enable otherwise this package is just NOPs */
+
+	if (flags & AMDGPU_HAVE_CTX_SWITCH) {
+		gfx_v6_0_ring_emit_event_write(ring, VS_PARTIAL_FLUSH, 4);
+		gfx_v6_0_ring_emit_event_write(ring, VGT_FLUSH, 0);
+
+		/* set load_global_config (load_global_uconfig doesn't exist on GFX6) */
+		dw2 |= 0x1;
+		/* set load_cs_sh_regs */
+		dw2 |= 0x01000000;
+		/* set load_per_context_state & load_gfx_sh_regs */
+		dw2 |= 0x10002;
+	}
+
 	amdgpu_ring_write(ring, PACKET3(PACKET3_CONTEXT_CONTROL, 1));
-	amdgpu_ring_write(ring, 0x80000000);
+	amdgpu_ring_write(ring, dw2);
 	amdgpu_ring_write(ring, 0);
 }
 
@@ -3527,7 +3541,7 @@ static const struct amdgpu_ring_funcs gfx_v6_0_ring_funcs_gfx = {
 		14 + 14 + 14 + /* gfx_v6_0_ring_emit_fence x3 for user fence, vm fence */
 		7 + 4 + /* gfx_v6_0_ring_emit_pipeline_sync */
 		SI_FLUSH_GPU_TLB_NUM_WREG * 5 + 7 + 6 + /* gfx_v6_0_ring_emit_vm_flush */
-		3 + 2 + /* gfx_v6_ring_emit_cntxcntl including vgt flush */
+		3 + 2 + 2 + /* gfx_v6_ring_emit_cntxcntl including VGT flush */
 		5, /* SURFACE_SYNC */
 	.emit_ib_size = 6, /* gfx_v6_0_ring_emit_ib */
 	.emit_ib = gfx_v6_0_ring_emit_ib,
-- 
2.55.0

