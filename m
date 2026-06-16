Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F28ECD98E7
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2026 12:49:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDF7810EB6E;
	Tue, 16 Jun 2026 12:49:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=usp.br header.i=@usp.br header.b="kfbGB/D5";
	dkim-atps=neutral
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com
 [209.85.221.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D29EF10E7B0
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 02:12:42 +0000 (UTC)
Received: by mail-vk1-f172.google.com with SMTP id
 71dfb90a1353d-59cfbfe64baso1432503e0c.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2026 19:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1781575962; x=1782180762; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vi/anKo0gGqlfMkLrdymWNF41Yu2KeWLiH5QFrH1EaY=;
 b=kfbGB/D5uGTBMq3X6n0/JmwILAs4N6N0pNtQzZjnZBhY90m0bYYgioK+cLbl1+9QaQ
 urvZp0hgO6hRxSrClhFS1cGrAI/v39keB+b52iTaXyh1/xjtMHjunuHAmC12UenELcok
 q8aCjuDLoR8/8MS46oRVJkwqWOtZjMttK6JTcnsJ18v1Z5d34tz9hyxSzDe14/yPc0ld
 sYNucLjf/uzuB+kA31RCk0adB8D6fjI03p5b51T1xRFOgvy6y4T2LF3slLqkgyrgavwc
 yZ2CzfrWuyW0PMeN7kF/RfbadQzOEtBECnvEZF76xvI5+3x+jqzu9vQTglji4DMOjBFh
 RZ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781575962; x=1782180762;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vi/anKo0gGqlfMkLrdymWNF41Yu2KeWLiH5QFrH1EaY=;
 b=EOSBNgC9JhqGJD4tMAeEqsubQkzDyMtokaXCA/Bc2DohMb1UjuCKs8Cy3fOL0UKZda
 A+pFauAbHtGEp5Wf+1ideVg+z9B/HxYt6K5Gsdi0Ro/DhoJEvK6QxSoLzD1IbMZ9lUSK
 wjp+Nalv6XM1yhTuaA6jpOUaM5bDhTo75N71WfogfiNO9XGmhG/Qm/TWxK+tMLujanVX
 bAJPX3bKHAJ1mPXYwd/Hd3GKGY+5TAjqFvhHpprWp5A+r1Bq+cI5/grb10KfM7Waa+hy
 9yh8lsccMT8UF85HqHnfHCmqpvIWg0VcGvCxNM2MRd+l2mrLw+19UIze6Q9TjjlnA3kT
 o1ZA==
X-Gm-Message-State: AOJu0Yy+L/u2W67YSRcYBvZni3ro9JDF+URjVdrEJnHRWT4Grmm9l6ry
 q2TCRlEuZ8oc3Fd5TcLqZAGig8s1p9SBAmfwdLD1QHn4K2GH7LICDBJPKa91E3O+uKgpQ3RgnY1
 oRPaR
X-Gm-Gg: Acq92OHKSXbLnmw/KEGP1eztR7m6nMCB2C9RgGHeeWVsNsUxSU8lPEscd1KbpSazyqd
 ngZAiV2DOmfqJC8v5v9amKbpzWF0NRGyZ0M747IrFCE57r8XC/jyAkZXN/iAsYlMk7bj5M2lFK0
 zuptNjMwm/7acyosE+4llnT9M8QNpSs4NpOryK2+PfR+nDh6Uy/JrQBZ1vzr+yRAU/6tGf28fy/
 XJP605O0XLK1UOmQ6RWifXRkD2anNyWk5rhENftBY33NhlrEE+DzZe5S+LuWm3+1asYFhGTzPGl
 +K3e70eFprCEMWSF2KjIDO5TRB0qnOMQZlAL8z9GLFQ8UzgYTxvS1CF6cn/+sCstjpo8FhRn9wz
 rig5mUCWPuWDHi01M+DuM9BRJfPElh84u7D1BuL7pXHT1bZqwAj94+WA7msg19GL64KSfd8hWIy
 ah6s/FOKub3SO8B3rkmTtnEmrbemn3qbPUMbIvIn6M6m2mKguwssM7Ji85xDV9WDNefJvK1mbQy
 rL5J78=
X-Received: by 2002:a05:6122:238d:b0:575:44b3:300d with SMTP id
 71dfb90a1353d-5bb79cb15fcmr5885740e0c.10.1781575961770; 
 Mon, 15 Jun 2026 19:12:41 -0700 (PDT)
Received: from voyager.. ([179.119.39.86]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5bb900138e8sm5514855e0c.6.2026.06.15.19.12.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 19:12:41 -0700 (PDT)
From: Tiago Dourado <tiagodourado@usp.br>
To: amd-gfx@lists.freedesktop.org
Cc: luiz.f.f.fernandes@usp.br,
	Tiago Dourado <tiagodourado@usp.br>
Subject: [PATCH RESEND 1/2] drm/amdgpu/jpeg: deduplicate jpeg_v3_0
 process_interrupt
Date: Mon, 15 Jun 2026 23:08:30 -0300
Message-ID: <20260616020942.18980-2-tiagodourado@usp.br>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616020942.18980-1-tiagodourado@usp.br>
References: <20260616020942.18980-1-tiagodourado@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 16 Jun 2026 12:49:33 +0000
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

The jpeg_v3_0_process_interrupt function is identical to
jpeg_v2_0_process_interrupt. Remove the duplicate implementation
in jpeg_v3_0 and reuse the jpeg_v2_0 version via a macro alias.
Export jpeg_v2_0_process_interrupt through jpeg_v2_0.h to allow
cross-version reuse.

Signed-off-by: Tiago Dourado <tiagodourado@usp.br>
Co-developed-by: Luiz Fernandes <luiz.f.f.fernandes@usp.br>
Signed-off-by: Luiz Fernandes <luiz.f.f.fernandes@usp.br>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h |  4 ++++
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c | 21 ++-------------------
 3 files changed, 7 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
index 9fe8d10ab..9006fc57e 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
@@ -747,7 +747,7 @@ static int jpeg_v2_0_set_interrupt_state(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int jpeg_v2_0_process_interrupt(struct amdgpu_device *adev,
+int jpeg_v2_0_process_interrupt(struct amdgpu_device *adev,
 				      struct amdgpu_irq_src *source,
 				      struct amdgpu_iv_entry *entry)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h
index 654e43e83..4f400fb47 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h
@@ -58,6 +58,10 @@ void jpeg_v2_0_dec_ring_emit_vm_flush(struct amdgpu_ring *ring,
 void jpeg_v2_0_dec_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg, uint32_t val);
 void jpeg_v2_0_dec_ring_nop(struct amdgpu_ring *ring, uint32_t count);
 
+int jpeg_v2_0_process_interrupt(struct amdgpu_device *adev,
+				struct amdgpu_irq_src *source,
+				struct amdgpu_iv_entry *entry);
+
 extern const struct amdgpu_ip_block_version jpeg_v2_0_ip_block;
 
 #endif /* __JPEG_V2_0_H__ */
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
index 98f5e0622..5010dafc2 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
@@ -34,6 +34,8 @@
 
 #define mmUVD_JPEG_PITCH_INTERNAL_OFFSET	0x401f
 
+#define jpeg_v3_0_process_interrupt jpeg_v2_0_process_interrupt
+
 static const struct amdgpu_hwip_reg_entry jpeg_reg_list_3_0[] = {
 	SOC15_REG_ENTRY_STR(JPEG, 0, mmUVD_JPEG_POWER_STATUS),
 	SOC15_REG_ENTRY_STR(JPEG, 0, mmUVD_JPEG_INT_STAT),
@@ -539,25 +541,6 @@ static int jpeg_v3_0_set_interrupt_state(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int jpeg_v3_0_process_interrupt(struct amdgpu_device *adev,
-				      struct amdgpu_irq_src *source,
-				      struct amdgpu_iv_entry *entry)
-{
-	DRM_DEBUG("IH: JPEG TRAP\n");
-
-	switch (entry->src_id) {
-	case VCN_2_0__SRCID__JPEG_DECODE:
-		amdgpu_fence_process(adev->jpeg.inst->ring_dec);
-		break;
-	default:
-		DRM_ERROR("Unhandled interrupt: %d %d\n",
-			  entry->src_id, entry->src_data[0]);
-		break;
-	}
-
-	return 0;
-}
-
 static int jpeg_v3_0_ring_reset(struct amdgpu_ring *ring,
 				unsigned int vmid,
 				struct amdgpu_fence *timedout_fence)
-- 
2.43.0

