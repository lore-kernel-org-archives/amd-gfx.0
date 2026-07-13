Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98CA6C44507
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2026 12:58:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 352C610E96E;
	Mon, 13 Jul 2026 12:58:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mVKW/iRP";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54C3610E96E
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 12:58:56 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-493f45e20cdso18870695e9.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 05:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783947535; x=1784552335; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ILaQRYSezNwpezNT9xke8PAPfa2SvCB6myZAQ0EdRrQ=;
 b=mVKW/iRPFYlI1yMdKivfS0wzeHWVK5nz0g7We7fZcWixIc7BZJ3GMspn2lgMSYVDYm
 PKcjWeIC1EgiwcIzFIecaOCQwdJ+sAqMpyedmXhuFxoBpFtgFVQL4x9A0n7QewB3+Qdw
 Nw/xKlIZV/823yzMG/DUOBzSyYuAvH780KrXnazUL8c1zTOnRdDaknVmI7LbmQwWTrUu
 34au/DEe5NZtU90apTvDcJPiyblQaMUyykZE2ryHGVc7YmHSt1XuM798lbR1SPBZ1X0M
 yPkLorcEu9VsjpTeTkE06izq7FDIoxXc+uAO49nH0CW/f7/WCGIt7TSPkw1wG/4pG3WD
 Mnwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783947535; x=1784552335;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ILaQRYSezNwpezNT9xke8PAPfa2SvCB6myZAQ0EdRrQ=;
 b=TIi6BBoSNRkwIVMp2jZoM9Qoaf5gRrv/Rc6yY5f3iLlsGY7hQxG3X6EAZW62I5Zst/
 1bpl1jGFoYym5Et1ZF+Gfzhsiu7wKlJ8mZMs4kqMi0ekrZA0ATd8Ia7rASBiv0E9W4ys
 Eu744QomrDYxyUemu8Z9t8hFT8YQ8ppPPs15wKTMq69cikwGXbQ1YIaHGHF8usHf7hGV
 4ziBv1r45qx9rtKa5J2umjVi/MGVANolwKINeYovR1H/HZ58o20Qe30M3eTbQMfZeAad
 zkcfaFFdh9E/12lm1XIOgxj92DWq8lJllwOqdDD5olQry1HQoloyso0Wib/pstcA/jXl
 papw==
X-Gm-Message-State: AOJu0YwNraRlrzJggtKlJfSLDqq2D0Odbx82Q2z3XI7CRmVumCKFFM1b
 MFJhCXEUJTIyQSfOzRijPPuE/baImQhtLoC597kKcPlfTSI2cUvHY1TGMptCbg==
X-Gm-Gg: AfdE7ckzjgWReI0yJhNhKgr1IdFStZNSafUO+NS6IBY+Ctks4KCw2z0eDjHtzCu5FMH
 /FUTGKNboIr85S/WhsnAPMY/obkSih6uVfjGs5nvCtJJl2okqH+FYxR1eCAsVT1NZwUzwbTju6o
 y5Y9vg3Cyzjppu4BJM0UX+4ezOASh8oj1qb4C3CXyq1k8uwbmXWlPUIDXNO9F5RTncqvS0wD6tc
 cowaD5KIs9/EbClrMHP+NpADHgHUdv7HogkAx97A9ApPUZqSt0kXwIpBtxiaoJUiMM5yZn7C1/h
 pqvaV5sgCuMrDjNJcbaYpiNHPvQNkVm9PI7xUtA7JZQWV8d5P5koVEWP+AVwT31MdKyHe4bU03i
 ddoq+huM5fb7SkGMfsPF1BSwq4BqHDY3R+MmkSuwnrp2srt7kVH9E0SiLnMaejSq3HS6oWOtF+3
 QaF+LrPapvp+/QvlA3L7vuZh2aLr4QfeqF/HYIZajC7BONprucMJgsMA==
X-Received: by 2002:a05:600c:a14:b0:493:e311:5f10 with SMTP id
 5b1f17b1804b1-493f87e72ecmr97664035e9.10.1783947534638; 
 Mon, 13 Jul 2026 05:58:54 -0700 (PDT)
Received: from Timur-Hyperion.home (54001386.dsl.pool.telekom.hu.
 [84.0.19.134]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9e4d6e4csm80456918f8f.10.2026.07.13.05.58.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 05:58:53 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, Tvrtko Ursulin <tursulin@ursulin.net>,
 pierre-eric.pelloux-prayer@amd.com, Natalie Vock <natalie.vock@gmx.de>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 7/9] drm/amdgpu/gfx7: Use COND_EXEC
Date: Mon, 13 Jul 2026 14:58:36 +0200
Message-ID: <20260713125838.30607-8-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260713125838.30607-1-timur.kristof@gmail.com>
References: <20260713125838.30607-1-timur.kristof@gmail.com>
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
---
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index 915612628f9a..6d52b8710437 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -3162,6 +3162,22 @@ static void gfx_v7_0_ring_emit_vm_flush(struct amdgpu_ring *ring,
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
@@ -4943,6 +4959,8 @@ static const struct amdgpu_ring_funcs gfx_v7_0_ring_funcs_gfx = {
 	.get_wptr = gfx_v7_0_ring_get_wptr_gfx,
 	.set_wptr = gfx_v7_0_ring_set_wptr_gfx,
 	.emit_frame_size =
+		5 + /* gfx_v7_0_ring_emit_init_cond_exec (from amdgpu_ib_schedule) */
+		5 + /* gfx_v7_0_ring_emit_init_cond_exec (from amdgpu_vm_flush) */
 		20 + /* gfx_v7_0_ring_emit_gds_switch */
 		7 + /* gfx_v7_0_ring_emit_hdp_flush */
 		5 + /* hdp invalidate */
@@ -4965,6 +4983,7 @@ static const struct amdgpu_ring_funcs gfx_v7_0_ring_funcs_gfx = {
 	.pad_ib = amdgpu_ring_generic_pad_ib,
 	.emit_switch_buffer = gfx_v7_0_ring_emit_sb,
 	.emit_cntxcntl = gfx_v7_ring_emit_cntxcntl,
+	.init_cond_exec = gfx_v7_0_ring_emit_init_cond_exec,
 	.emit_wreg = gfx_v7_0_ring_emit_wreg,
 	.soft_recovery = gfx_v7_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v7_0_emit_mem_sync,
@@ -4979,6 +4998,8 @@ static const struct amdgpu_ring_funcs gfx_v7_0_ring_funcs_compute = {
 	.get_wptr = gfx_v7_0_ring_get_wptr_compute,
 	.set_wptr = gfx_v7_0_ring_set_wptr_compute,
 	.emit_frame_size =
+		5 + /* gfx_v7_0_ring_emit_init_cond_exec (from amdgpu_ib_schedule) */
+		5 + /* gfx_v7_0_ring_emit_init_cond_exec (from amdgpu_vm_flush) */
 		20 + /* gfx_v7_0_ring_emit_gds_switch */
 		7 + /* gfx_v7_0_ring_emit_hdp_flush */
 		5 + /* hdp invalidate */
@@ -4997,6 +5018,7 @@ static const struct amdgpu_ring_funcs gfx_v7_0_ring_funcs_compute = {
 	.test_ib = gfx_v7_0_ring_test_ib,
 	.insert_nop = amdgpu_ring_insert_nop,
 	.pad_ib = amdgpu_ring_generic_pad_ib,
+	.init_cond_exec = gfx_v7_0_ring_emit_init_cond_exec,
 	.emit_wreg = gfx_v7_0_ring_emit_wreg,
 	.soft_recovery = gfx_v7_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v7_0_emit_mem_sync_compute,
-- 
2.55.0

