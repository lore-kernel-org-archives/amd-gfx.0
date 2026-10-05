Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A20FCA5FED
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Oct 2026 07:35:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 788D610F218;
	Tue,  6 Oct 2026 07:35:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="blBrEYTY";
	dkim-atps=neutral
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7226810E1FE
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Oct 2026 21:28:34 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-49cdc4080ddso1865185e9.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 05 Oct 2026 14:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1791235713; x=1791840513;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:mime-version:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0xprJZ+dVNe+ileaYqsNOlXMxIVtzZ4ZsXq2YAl6CD4=;
 b=blBrEYTYBQIq8TToee/rQj8RP8y7pEMYlfyjgl5kw+cq5X/vVCFObTlbMm+qybjVgl
 7hwb+5SVUlrqOS4TX81eUz6C2UtCR1HFEPx9PuDuVs81W+NkxLP9SbRTu/mCksruN5JQ
 exy/7mo0xW5J7imO/tNq56wixG6JadYTUdcuAmO3GpPADWCM4hEG0socibU6QT1ULk/O
 sSG2YAgk/LbQqGKi1eGbKQf22APRZRjIlgwxECwkkVJtL3frnLAMdZz/Ybv1DAZsUDXH
 fSX/AkqlaLAGXsFNYY62WaP+HwSXu3Wy7U62MDx4+PoFASxdyEHb6kU27eP95tHWxyml
 iWUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791235713; x=1791840513;
 h=content-type:cc:to:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0xprJZ+dVNe+ileaYqsNOlXMxIVtzZ4ZsXq2YAl6CD4=;
 b=TlGyWdXZ+NtZn+U9B0D6RgOVA8xkTcuF0dIQG2KoW0FN6pcG27xDz9JqCNQExHqxDg
 IF8y7/wX7jJaB23k2c4rcGwt975rYGgRXB1S4GFw5luAzOvCKhPBzeohoosPIvfgvkKl
 2QrmR+VtudpiHPis8URPvY71KWLMrEMl+mVTTRTj3bFaL6slJAElqTB3dAfKyxbZLYXt
 pkaaSOpSIQ6/V+t1JmN7mehMKeY7HNvorXnQsT24ObmnjH8i0Qwi+W/uizbztS8vbj6Y
 SvrbjaqTz4w6lQn7WvCZM3jO9kwAvSJKyO8NmzQa/Bxci/GXfkV8CRbNEVWZmdasKBPb
 TTwg==
X-Gm-Message-State: AFuF++lnp4fLL9/VUuKZT+etkFXxg4/SYxaTESJBtZSjdPo41dq0FjR1
 DeKZSAHDYjRtdSBCgLemkczdyWlIa2kSfTt+ncFhLWHSFHFwgiCZj5hQkZofo6/QDvcydhnOnDm
 sMVWyyAriOlB6M2BS2MDWSZ3Csf15VhqaquS9+pmNzQXt4CR4GNZ4oCgE3CFl3UoaVqT0y/wdsj
 XVlEDwbcApL1gnLGl1goPjSJrGLG5whcWiD0Yu2abwXqalPw==
X-Received: from wmqf13.prod.google.com ([2002:a05:600c:4e8d:b0:4a1:70cb:4416])
 (user=darekm job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600d:109:b0:49f:c5aa:9ef4
 with SMTP id 5b1f17b1804b1-4a1788f2c1bmr12068245e9.8.1791235712215; Mon, 05
 Oct 2026 14:28:32 -0700 (PDT)
Date: Mon,  5 Oct 2026 23:28:14 +0200
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.360.g66cac248cb-goog
Message-ID: <20261005212814.341475-1-darekm@google.com>
Subject: [RESEND PATCH] drm/amdgpu: check amdgpu_vm_ready() in dma-buf move
 notify
From: Dariusz Marcinkiewicz <darekm@google.com>
To: amd-gfx@lists.freedesktop.org
Cc: Dariusz Marcinkiewicz <darekm@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 06 Oct 2026 07:35:16 +0000
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

amdgpu_dma_buf_move_notify() touches the page tables without first
calling amdgpu_vm_ready(). When a process is SIGKILLed, its VM entities
are stopped. Teardown of an imported dma-buf then tries to clear PTEs by
submitting to one of those stopped entities. That eventually hangs the
task.

Commit aa5fc4362fac ("drm/amdgpu: fix task hang from failed job
submission during process kill") added the stopped entity check in
amdgpu_vm_ready() and used it in amdgpu_cs_vm_handling(). That did not
cover a call in amdgpu_dma_buf_move_notify(), what was already mentioned
in:
https://lists.freedesktop.org/archives/amd-gfx/2025-October/133076.html

Tested by SIGKILLing a GPU workload holding imported dma-bufs. Without
the patch "Trying to push to a killed entity" errors are logged, then a
task hangs. With the patch there are no hung tasks. This was tested on a
6.18 kernel.

Signed-off-by: Dariusz Marcinkiewicz <darekm@google.com>
Assisted-by: LLM
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
index 9c80eef79e32..ee473a888331 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -481,6 +481,11 @@ amdgpu_dma_buf_move_notify(struct dma_buf_attachment *attach)
 				continue;
 		}
 
+		if (!amdgpu_vm_ready(vm)) {
+			dma_resv_unlock(resv);
+			continue;
+		}
+
 		/* Reserve fences for two SDMA page table updates */
 		r = dma_resv_reserve_fences(resv, 2);
 		if (!r)
-- 
2.55.0.1082.g2b9226bbc0-goog

