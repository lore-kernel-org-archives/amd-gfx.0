Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9032C982D7
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Sep 2026 07:44:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F197710F215;
	Fri, 18 Sep 2026 07:44:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="gzFkZjsZ";
	dkim-atps=neutral
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9621E10E03F
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Sep 2026 06:33:04 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-490a767c7dcso2923345e9.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Sep 2026 23:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1789713183; x=1790317983;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:mime-version:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0xprJZ+dVNe+ileaYqsNOlXMxIVtzZ4ZsXq2YAl6CD4=;
 b=gzFkZjsZJyGtAeifsI6WRFxaSnks2EDgxNUimqhKmABQbC6mft2KZOmkxvbPGpFrHM
 cBWFZXrd0NWNfwCcjOSU8onWjuDSOaK+oJ206owFcvA9v5WaexBMoPyoMlPdAexp7IEY
 qQd8Xlnhx2hdGuFwuZZqesAVYvHdHkWiEnL3OXhImRsav4vUoYW6xa62LucF+oEoGE5P
 BvOxFJ7mh3yBa4tFd99AD+PlUDW8TFfWCykZrmhk0PKFRCbs2ko7CInTUuEUiOCcvBof
 rMztVtDBCgkKeuHT9aQPQ97OH7YxtiIAPLUiHRz+VpHnwdMbltG/qd2J/cV3SAAvU5zg
 35IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789713183; x=1790317983;
 h=content-type:cc:to:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0xprJZ+dVNe+ileaYqsNOlXMxIVtzZ4ZsXq2YAl6CD4=;
 b=bSebJBB1v608LbDX2KkhpRBEGXhZw/2cOYv3XnHhXel8JGQ3dGgfT5JCb/hWZI0NMv
 JoBXcBpHvjxTsWnWdu0sIY/YXdrykEFMweuTr9vdVzsa8D/wbUuhUeWlGWyBQlcVAIFG
 xqq/xzO0jAmjs9N9ItGrHMkiGuTh/0eZP3dDgS57hRCG5NBt8mvJ0LlmkwNaXb2jmAo3
 AQmo7T08KdTdkpdjCxx8rcWt75YBVTVwbGp8jC3JHQvV7R9l1O1g7rfKuUPai0qixu8N
 CWAGdlRXBrvAkKYWJF37ugY7h3mpAEP4P2Bnt2h11DX1BjkzWs+zRP2y21R6mr8sfXib
 ZisA==
X-Gm-Message-State: AFuF++mIpe3rQy2j5MtZNdTOWdpE4r2uFSycqZcKtzFyjJFUpeeNmdY+
 rzMKpy9wEOvhoD7wyqjIUpecKUl+T/TtH3ZOIvGD1clTZkM3eW/IEuq3PywVfvTPJWeDEGtQcm/
 aHnahUB1LjhyESs+Xw1O9UBAAIuyoVPvtu5JzmKUxWoqk6XEIElS6LHPVzJ5xtyqMFb62PJATaX
 52QEk1JTLTaIXjBp/WNsb4SZCQo0JHqBHHVuwfeDtPy40O4Q==
X-Received: from wmpr35.prod.google.com ([2002:a05:600c:3223:b0:49c:ce06:6657])
 (user=darekm job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1daa:b0:49c:fc6c:bdfc
 with SMTP id 5b1f17b1804b1-49fc574643bmr14248215e9.19.1789713182768; Thu, 17
 Sep 2026 23:33:02 -0700 (PDT)
Date: Fri, 18 Sep 2026 08:33:01 +0200
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260918063301.161664-1-darekm@google.com>
Subject: [PATCH] drm/amdgpu: check amdgpu_vm_ready() in dma-buf move notify
From: Dariusz Marcinkiewicz <darekm@google.com>
To: amd-gfx@lists.freedesktop.org
Cc: Dariusz Marcinkiewicz <darekm@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Fri, 18 Sep 2026 07:44:40 +0000
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

