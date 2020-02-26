Return-Path: <SRS0=BS7L=4O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96842C4BA21
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Feb 2020 20:34:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6619D2072D
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Feb 2020 20:34:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P6Wtyomq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6619D2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17FAA6EBD1;
	Wed, 26 Feb 2020 20:34:38 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60EE06EBCD
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Feb 2020 20:34:36 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id z3so441797wru.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Feb 2020 12:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wCY0tN7j0B2h1HgUXDuiDci3q0m2gDpBZ/NQ/AtbCPc=;
 b=P6WtyomqzTLQIdUbJMldtoJVTzN3NuxCSQPVsB+2L+hXvDYwmlnqTEQAArOx4t15u9
 g6QMh9uVdAtwgDSk/ST9G68CBuehJ9QZZmvqrQrOgyWzgfBUXhjBRM647X7n9kfYTC1O
 QopbVCfIfOGmhIcEdGHGvuWyiA9/Men8SmmSi3THLOeNE5tCJvWpXa5zOoxSK8iUZdKm
 L1/upRCGK9OfBpuVhogJYCOx7Orcb/8Bcv76CcGPDBhoX/unz3623/jKGy/6v5kL+njZ
 mkOx8c/Yqhh2SYbGDGaXSLXv+VfhbfnRk5V/ie11866ol5SgrB8vxNeXth1MAmwhW6IX
 Fbyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wCY0tN7j0B2h1HgUXDuiDci3q0m2gDpBZ/NQ/AtbCPc=;
 b=XXIzM/QVQGUfcDhKAVXEe3Iv6b9bQNzxA8KdjShTv3utIVihoPt7JxBJK6UL+f1GtT
 GwjR/r2S2TNY4/bnTGxz0L3HFBcf6u2sfhl/HdL3rv6htNjHMZcdJuYgtDf87jCl3jmY
 hO3Dm1R9vKSEstvTTwYIeg7I2sa+MHeDqdVix+NiYmDemRbRLgKBRhpL2iZ3pUNP9pvS
 OzhLo46ArTdgNhGxWNuYiu4WqwaPzV22SfsvwfQRZuQ0yvVR74DyNHxZn4TegCpXWmNf
 23om7VqHbw6iGG0W+Mr9qyZBSw6nHRh4mF/gDfcd29WJ8OP08dpzDK8/S3/JY63UCfYn
 qP1A==
X-Gm-Message-State: APjAAAVAkOzAPWorwaYWXWxD8eHccIl45DlO/B98mivqmLq8zu9YUHXp
 n4pRxn864q3ssUtJyeX7ns2j1DXnElI=
X-Google-Smtp-Source: APXvYqylwZjGQ2UMqNiByP/VYlkKgTFG4ZlgX3awSrqA/25nHaBnhBIuUoEAarYqDWxmVMnMLlrXHA==
X-Received: by 2002:adf:f641:: with SMTP id x1mr435750wrp.248.1582749274675;
 Wed, 26 Feb 2020 12:34:34 -0800 (PST)
Received: from brihaspati.fritz.box
 (p200300C58F275300BB8A7FF1D96B1B54.dip0.t-ipconnect.de.
 [2003:c5:8f27:5300:bb8a:7ff1:d96b:1b54])
 by smtp.gmail.com with ESMTPSA id d76sm4406191wmd.39.2020.02.26.12.34.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2020 12:34:32 -0800 (PST)
From: Nirmoy Das <nirmoy.aiemd@gmail.com>
X-Google-Original-From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [RFC PATCH 1/3] drm/amdgpu: implement ring init_priority for compute
 ring
Date: Wed, 26 Feb 2020 21:37:28 +0100
Message-Id: <20200226203730.4621-2-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200226203730.4621-1-nirmoy.das@amd.com>
References: <20200226203730.4621-1-nirmoy.das@amd.com>
MIME-Version: 1.0
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
Cc: alexander.deucher@amd.com, Ray.Huang@amd.com, nirmoy.das@amd.com,
 christian.koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

init_priority will set second compute queue(gfx8 and gfx9) of a pipe to high priority
and 1st queue to normal priority.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c    | 14 ++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    | 13 +++++++++++++
 3 files changed, 28 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 24caff085d00..a109373b9fe8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -170,6 +170,7 @@ struct amdgpu_ring_funcs {
 	/* priority functions */
 	void (*set_priority) (struct amdgpu_ring *ring,
 			      enum drm_sched_priority priority);
+	void (*init_priority) (struct amdgpu_ring *ring);
 	/* Try to soft recover the ring to make the fence signal */
 	void (*soft_recovery)(struct amdgpu_ring *ring, unsigned vmid);
 	int (*preempt_ib)(struct amdgpu_ring *ring);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index fa245973de12..14bab6e08bd6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -6334,6 +6334,19 @@ static void gfx_v8_0_ring_set_priority_compute(struct amdgpu_ring *ring,
 	gfx_v8_0_pipe_reserve_resources(adev, ring, acquire);
 }

+static void gfx_v8_0_ring_init_priority_compute(struct amdgpu_ring *ring)
+{
+	/* set pipe 0 to normal priority and pipe 1 to high priority*/
+	if (ring->queue == 1) {
+		gfx_v8_0_hqd_set_priority(ring->adev, ring, true);
+		gfx_v8_0_ring_set_pipe_percent(ring, true);
+	} else {
+		gfx_v8_0_hqd_set_priority(ring->adev, ring, false);
+		gfx_v8_0_ring_set_pipe_percent(ring, false);
+	}
+
+}
+
 static void gfx_v8_0_ring_emit_fence_compute(struct amdgpu_ring *ring,
 					     u64 addr, u64 seq,
 					     unsigned flags)
@@ -6967,6 +6980,7 @@ static const struct amdgpu_ring_funcs gfx_v8_0_ring_funcs_compute = {
 	.insert_nop = amdgpu_ring_insert_nop,
 	.pad_ib = amdgpu_ring_generic_pad_ib,
 	.set_priority = gfx_v8_0_ring_set_priority_compute,
+	.init_priority = gfx_v8_0_ring_init_priority_compute,
 	.emit_wreg = gfx_v8_0_ring_emit_wreg,
 };

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 1c7a16b91686..0c66743fb6f5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -5143,6 +5143,18 @@ static void gfx_v9_0_ring_set_priority_compute(struct amdgpu_ring *ring,
 	gfx_v9_0_pipe_reserve_resources(adev, ring, acquire);
 }

+static void gfx_v9_0_ring_init_priority_compute(struct amdgpu_ring *ring)
+{
+	/* set pipe 0 to normal priority and pipe 1 to high priority*/
+	if (ring->queue == 1) {
+		gfx_v9_0_hqd_set_priority(ring->adev, ring, true);
+		gfx_v9_0_ring_set_pipe_percent(ring, true);
+	} else {
+		gfx_v9_0_hqd_set_priority(ring->adev, ring, false);
+		gfx_v9_0_ring_set_pipe_percent(ring, true);
+	}
+}
+
 static void gfx_v9_0_ring_set_wptr_compute(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
@@ -6514,6 +6526,7 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_compute = {
 	.insert_nop = amdgpu_ring_insert_nop,
 	.pad_ib = amdgpu_ring_generic_pad_ib,
 	.set_priority = gfx_v9_0_ring_set_priority_compute,
+	.init_priority = gfx_v9_0_ring_init_priority_compute,
 	.emit_wreg = gfx_v9_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v9_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v9_0_ring_emit_reg_write_reg_wait,
--
2.25.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
