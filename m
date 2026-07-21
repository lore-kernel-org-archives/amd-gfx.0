Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CF20C44532
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2026 11:43:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 253A310E96B;
	Tue, 21 Jul 2026 11:43:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Qtgs7pst";
	dkim-atps=neutral
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com
 [209.85.218.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE86310E955
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jul 2026 11:43:36 +0000 (UTC)
Received: by mail-ej1-f44.google.com with SMTP id
 a640c23a62f3a-c15c42a45adso748220566b.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jul 2026 04:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784634215; x=1785239015; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7+zwR+OnDf7HsHGmEn7AY8sFqEnzEpCyE3kXwECz6bo=;
 b=Qtgs7pstmVUhNSi1EJz9BzFkcwYJXDTGSDe/H93GEyzczet2KoX9m1vftVkFVD1gGK
 QE3yClm7Lckk5LKzVhcZIawSpg9D4SnlhkB7U0MuXHe2kk3AcoXQRXLuIMAn76h0Doks
 1p37mgS3KSn7tjlCkafZYBhpHy4l78DynsbSq/2XM+MOxCN9gmc3u/Cv52G+Btky2QhE
 rscqsTN491QcGIjUjK9Y8T4RuHRwzQFZon8KbWFuzpEHXojgm+OUpRYmH7wiyTMNbf5g
 dmNu96CTBqpKy9oOD8BAQVkSd04RGd5lJ6AX5pyvzKW+N4owutu5P486WoN5ADle0Lbp
 BXLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784634215; x=1785239015;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7+zwR+OnDf7HsHGmEn7AY8sFqEnzEpCyE3kXwECz6bo=;
 b=Aop7jE4Ysr7naWVOiEzWAOQeMAsZ2zhg2qKZHGxXoyassQ+r/aufInOFc1ykxwQQJY
 PNtdxRIQLMtoNhNjy6Dq6aT+5br0jwaHwWc+41+WCLzhPnYH7BCNhUql+KBhyCILNwTO
 T7MYqpmP44P1e4AtmLFK171qYGGY9lsjP+GiisOW1scft5T/iAKuoi4/mmumgWIs8+8y
 pQALTisjYHN4hBnillRRftX/YJt/LHAZpKSaj4pZHmj1LnuYODe82DD5/gxQjD+PI+SR
 g/KD1b49geXWjrAtDYQiG3XlfSzleaw9Jz3zV/R6qCIURmnsPTHS4gcR7RJLHZ6+iuNf
 Eitg==
X-Gm-Message-State: AOJu0YwfBmGVim1zkH7TjaCwdmIMrDAScFciJ/aQF2hKNrY5cQjFGoe5
 +to/oVgXtAP9KPafQjm7+FX/4dTeBgtOfGtrIGzIBRNLWc4nhGWPgT2JSF2VdCBr
X-Gm-Gg: AR+sD10HHAtkK0zVJKt5jYc9rTLlDSoiSgbobllgMosR53Irmfknrq+o0kE4sKD6t4S
 S0zXb5p/YzWFot1Ul2Hlq+y4oZy1JRXTRxgq05pvlIDFVDl6y/MlzCEGHfkJ4gg5eHglCfqorAv
 AMwSnFdlWKphDA2rnm5XhHd3zS9mGVYbKMPCtOQgUZmYHx8iBYFvA2xfK6Vf6Z/HdoOtFrlAHxC
 2d+VoVB5HVkF4ftydRHDLU6D0Fnv8XhfMGjPsWLWcQt97/UxULxgCpNCidFCtS/9fx26Sekwbgf
 ghnqHrNLcSOQQDgmE4f3s5vy2AFz8sy0BJ5u1arFdN4Uc2j6pwlVN9N4+CwZ+cS2kXLIUvrfAH9
 E7M5ZBhoORgkY49liC0LoUKqG9FMuhrnnS7/pnG9wyxm8ypIRkNaTVaQy5R9r2kkNLQsUIyOQ+U
 vajf4ekbCcnixNZ6mhC932o3RbjFUJPH8QFy4XqcCNr0E=
X-Received: by 2002:a17:907:961f:b0:c10:10c9:6d8c with SMTP id
 a640c23a62f3a-c169244bd7cmr1111217266b.28.1784634215036; 
 Tue, 21 Jul 2026 04:43:35 -0700 (PDT)
Received: from Timur-Hyperion.home (5401D94C.dsl.pool.telekom.hu.
 [84.1.217.76]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c17009ae00asm571635366b.7.2026.07.21.04.43.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 04:43:34 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, pierre-eric.pelloux-prayer@amd.com,
 Natalie Vock <natalie.vock@gmx.de>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [PATCH 7/9] drm/amdgpu/gfx7: Use COND_EXEC
Date: Tue, 21 Jul 2026 13:43:20 +0200
Message-ID: <20260721114322.17535-8-timur.kristof@gmail.com>
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

COND_EXEC tells the CP to discard the dwords following it
when its condition is zero (false).

This is useful for GPU recovery because it can help reduce
collateral damage during GFX IP block soft reset, meaning
that it reduces the likelyhood that we fail some jobs which
are not guilty of the hang as the IP block soft reset
mechanism clears the condition before doing the reset.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index 67dfda7c0a45..dbd4667100b6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -3160,6 +3160,22 @@ static void gfx_v7_0_ring_emit_vm_flush(struct amdgpu_ring *ring,
 	}
 }
 
+static unsigned int gfx_v7_0_ring_emit_init_cond_exec(struct amdgpu_ring *ring,
+						      uint64_t gpu_addr)
+{
+	unsigned int ret;
+
+	/* Discard following DWs after this packet when gpu_addr==0 */
+	amdgpu_ring_write(ring, PACKET3(PACKET3_COND_EXEC, 3));
+	amdgpu_ring_write(ring, lower_32_bits(gpu_addr));
+	amdgpu_ring_write(ring, upper_32_bits(gpu_addr));
+	amdgpu_ring_write(ring, 0);
+	ret = ring->wptr & ring->buf_mask;
+	/* patch dummy value later */
+	amdgpu_ring_write(ring, 0);
+	return ret;
+}
+
 static void gfx_v7_0_ring_emit_wreg(struct amdgpu_ring *ring,
 				    uint32_t reg, uint32_t val)
 {
@@ -4941,6 +4957,8 @@ static const struct amdgpu_ring_funcs gfx_v7_0_ring_funcs_gfx = {
 	.get_wptr = gfx_v7_0_ring_get_wptr_gfx,
 	.set_wptr = gfx_v7_0_ring_set_wptr_gfx,
 	.emit_frame_size =
+		5 + /* gfx_v7_0_ring_emit_init_cond_exec (from amdgpu_ib_schedule) */
+		5 + /* gfx_v7_0_ring_emit_init_cond_exec (from amdgpu_vm_flush) */
 		20 + /* gfx_v7_0_ring_emit_gds_switch */
 		7 + /* gfx_v7_0_ring_emit_hdp_flush */
 		5 + /* hdp invalidate */
@@ -4963,6 +4981,7 @@ static const struct amdgpu_ring_funcs gfx_v7_0_ring_funcs_gfx = {
 	.pad_ib = amdgpu_ring_generic_pad_ib,
 	.emit_switch_buffer = gfx_v7_0_ring_emit_sb,
 	.emit_cntxcntl = gfx_v7_ring_emit_cntxcntl,
+	.init_cond_exec = gfx_v7_0_ring_emit_init_cond_exec,
 	.emit_wreg = gfx_v7_0_ring_emit_wreg,
 	.soft_recovery = gfx_v7_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v7_0_emit_mem_sync,
@@ -4977,6 +4996,8 @@ static const struct amdgpu_ring_funcs gfx_v7_0_ring_funcs_compute = {
 	.get_wptr = gfx_v7_0_ring_get_wptr_compute,
 	.set_wptr = gfx_v7_0_ring_set_wptr_compute,
 	.emit_frame_size =
+		5 + /* gfx_v7_0_ring_emit_init_cond_exec (from amdgpu_ib_schedule) */
+		5 + /* gfx_v7_0_ring_emit_init_cond_exec (from amdgpu_vm_flush) */
 		20 + /* gfx_v7_0_ring_emit_gds_switch */
 		7 + /* gfx_v7_0_ring_emit_hdp_flush */
 		5 + /* hdp invalidate */
@@ -4995,6 +5016,7 @@ static const struct amdgpu_ring_funcs gfx_v7_0_ring_funcs_compute = {
 	.test_ib = gfx_v7_0_ring_test_ib,
 	.insert_nop = amdgpu_ring_insert_nop,
 	.pad_ib = amdgpu_ring_generic_pad_ib,
+	.init_cond_exec = gfx_v7_0_ring_emit_init_cond_exec,
 	.emit_wreg = gfx_v7_0_ring_emit_wreg,
 	.soft_recovery = gfx_v7_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v7_0_emit_mem_sync_compute,
-- 
2.55.0

