Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89D18CD6E53
	for <amd-gfx@archiver.kernel.org>; Fri, 29 May 2026 11:40:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC91D10FDCE;
	Fri, 29 May 2026 11:40:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fyT1kmdW";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B61F10FDC9
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 11:40:45 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4893940bb5eso74669695e9.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 04:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780054844; x=1780659644; darn=lists.freedesktop.org;
 h=content-transfer-encoding:reply-to:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to;
 bh=i1CMImYRSDrGRZFwJ+P75FpzfYfCqK24IhCaOuArPBE=;
 b=fyT1kmdWXBrXLBdE260qQKUlkldWlMlZ7EIySzoglb0gzvQ6Jz0tN4YDfc9V1On7Ow
 +CIBBYRBsk4rkLm+iAEqLB83Ixwcr7FqlOEqyLL+KTlcJpG7GNDrNK7HN1Pp8Pm1lN7H
 UArjB4WYIZvb0BoD14OVJtYoH+5u1mKuXJZ5Hg4VCiHaSufWKIAgeAk3xatV5nYgKHXy
 lkr+0qeWd8GSFMhmGCJijD3QVbQLav8wZriZXZRGayepUy6G5BKUFX3CtovmVJfJc0BU
 5TK4x9oitDDtfN77UEVH4KvAdSOWHxmcm37mypye8e8OHCdQmM9tNAEN6b3R5IeRikP/
 QqGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780054844; x=1780659644;
 h=content-transfer-encoding:reply-to:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=i1CMImYRSDrGRZFwJ+P75FpzfYfCqK24IhCaOuArPBE=;
 b=kPsnJrAx9xB8KOH3Kh8nogLBeKjl9161mSQZZYECBEAsmJ2FdzoojMQWd1WS/cU1kF
 Q5Nt+RlJEQhoGkPAbaTm6kUL38Uz2iVk7ZJSk2BTRBqkY1VWO24Kt66/Wsdxv+1oCd4j
 eHxt3PeGDEJfXOw4I70eGWls1QsmHhEPd3cDZ3VYFKQltIIqy7LcGB7a6pHCONH19pZN
 f0UdkQfn1Ef457sHCLSzoNmQ37maORUZiTM94VnnXoYaRSztq16lMtKWt5nJ9kWdKwTh
 XDuP/hTx+DylEbTkV65FtWfbJrm46UdwLtR6NVJrpWIeJhID1CiWcZLU0qVOAwAgz65j
 Zz+Q==
X-Gm-Message-State: AOJu0YwMfkei76lHerxvRnGbQnKW897fkagU/vlsu8bymXgeHn+RVnaz
 zztMfHKDKE5L+mP3fBTQoma3o5sX3z19lqMFQFN8yvTiOXi9Cc0XgAnV
X-Gm-Gg: Acq92OGqtwui2UMOuaL368GzRlUkSXI9yGRLPoOGuMDBG61tXxjWzuyCNvNdeZ5NQnB
 EJrccXqI2bksFXGeVCh3wKEZSBcKv+dUJPmG02gMcPGCjpWT/Qwp0PYqjzgdPo0KJHZogX/00c6
 zJnpWt49kz4hvK0DhEUJLDMDHSFGqp0yRz8CxZwRX0l6ZXEzH7iw5e+8DXl6hFM9IWUFsIQd6ZW
 6OeL2YMdRdt6oSbkbpz/xlZFvWcmhQbgp/Tpkdi/n+iwiu5Mz2IWZ2wOQh4TtcpoFa0p31o60Tn
 76Y3a0pzvfcw54coiXaPXbx67vxCwgEpjqATIbAF33suMnLYYrlK9PUxwc1o8WM5Au0EQgQoNrj
 PkLURb3SNuPCKVgKJ2kKImzzm8RL9MpdVk069EnGFyL/bGo49kkqdYYv/gcR2KPI3n7yLgBEP7w
 gb9e/91OKXoUgOiiZs/lxXuQPoJ/YI0aHpXYLCAPDEyL8=
X-Received: by 2002:a05:600c:a3a1:b0:48a:525b:e148 with SMTP id
 5b1f17b1804b1-4909c0787bdmr32086045e9.4.1780054843847; 
 Fri, 29 May 2026 04:40:43 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:1544:8100:da55:fa26:bd:a26])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef354cf0dsm2993109f8f.17.2026.05.29.04.40.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 04:40:43 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: natalie.vock@gmx.de, honghuan@amd.com, Alexander.Deucher@amd.com,
 Felix.Kuehling@amd.com, Philip.Yang@amd.com, timur.kristof@gmail.com
Cc: amd-gfx@lists.freedesktop.org
Subject: [PATCH 10/13] drm/amdgpu: remove unecessary parameters from
 trace_amdgpu_vm_update_ptes
Date: Fri, 29 May 2026 13:24:12 +0200
Message-ID: <20260529114031.3714-11-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260529114031.3714-1-christian.koenig@amd.com>
References: <20260529114031.3714-1-christian.koenig@amd.com>
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
Reply-To: christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Those can be determined by the parameter structure as well.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h | 10 +++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 11 ++---------
 2 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
index d6def9bec72c..4580ab533ca9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
@@ -325,9 +325,8 @@ TRACE_EVENT(amdgpu_vm_update_ptes,
 	    TP_PROTO(struct amdgpu_vm_update_params *p,
 		     uint64_t start, uint64_t end,
 		     unsigned int nptes, uint64_t dst,
-		     uint64_t incr, uint64_t flags,
-		     pid_t pid, uint64_t vm_ctx),
-	TP_ARGS(p, start, end, nptes, dst, incr, flags, pid, vm_ctx),
+		     uint64_t incr, uint64_t flags),
+	TP_ARGS(p, start, end, nptes, dst, incr, flags),
 	TP_STRUCT__entry(
 			 __field(u64, start)
 			 __field(u64, end)
@@ -347,8 +346,9 @@ TRACE_EVENT(amdgpu_vm_update_ptes,
 			__entry->flags = flags;
 			__entry->incr = incr;
 			__entry->nptes = nptes;
-			__entry->pid = pid;
-			__entry->vm_ctx = vm_ctx;
+			__entry->pid = p->vm->task_info ?
+				p->vm->task_info->tgid : 0;
+			__entry->vm_ctx = p->vm->immediate.fence_context;
 			for (i = 0; i < nptes; ++i) {
 				u64 addr = p->pages_addr ? amdgpu_vm_map_gart(
 					p->pages_addr, dst) : dst;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index f9c93a71e153..6026d6f27842 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -783,8 +783,6 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
 			  uint64_t dst, uint64_t flags)
 {
 	struct amdgpu_device *adev = params->adev;
-	struct amdgpu_vm *vm = params->vm;
-	pid_t tgid = vm->task_info ? vm->task_info->tgid : 0;
 	struct amdgpu_vm_pt_cursor cursor;
 	uint64_t frag_start = start, frag_end;
 	unsigned int frag;
@@ -873,8 +871,7 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
 
 			trace_amdgpu_vm_update_ptes(params, frag_start, upd_end,
 						    min(nptes, 32u), dst, incr,
-						    upd_flags, tgid,
-						    vm->immediate.fence_context);
+						    upd_flags);
 			amdgpu_vm_pte_update_flags(params, to_amdgpu_bo_vm(pt),
 						   cursor.level, pe_start, dst,
 						   nptes, incr, upd_flags);
@@ -937,8 +934,6 @@ void amdgpu_vm_update_leaves(struct amdgpu_vm_update_params *params,
 			     int64_t dst, uint64_t flags)
 {
 	struct amdgpu_device *adev = params->adev;
-	struct amdgpu_vm *vm = params->vm;
-	pid_t tgid = vm->task_info ? vm->task_info->tgid : 0;
 	struct amdgpu_vm_pt_cursor cursor;
 
 	amdgpu_vm_pt_start(adev, params->vm, start, &cursor);
@@ -971,9 +966,7 @@ void amdgpu_vm_update_leaves(struct amdgpu_vm_update_params *params,
 		nptes = max(nptes, 1u);
 
 		trace_amdgpu_vm_update_ptes(params, cursor.pfn, entry_end,
-					    min(nptes, 32u), dst, 0, flags,
-					    tgid,
-					    vm->immediate.fence_context);
+					    min(nptes, 32u), dst, 0, flags);
 		amdgpu_vm_pte_update_flags(params, to_amdgpu_bo_vm(pt),
 					   cursor.level - 1, pe_start, dst,
 					   nptes, 0, flags);
-- 
2.43.0

