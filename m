Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CD80CCFA03
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Oct 2025 08:25:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 200AB10E173;
	Fri, 31 Oct 2025 08:25:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AoSjKFNn";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70F3C10E173
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Oct 2025 08:25:34 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4770c34ca8eso17295645e9.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Oct 2025 01:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761899133; x=1762503933; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WNhpKMV40zyRTVdFiwn1mRrkA9xDpsjN9KPL22xqgpE=;
 b=AoSjKFNn91iiPPA06KyR7lGowzyttx4MsNgFk6+RfGx/vECZFJEHBpvfg1m3jevEzR
 RVjdPe8TFKwGWSr09t6JA6vrb0ssM4MIkqxFlxFJMdDFiteJUM9DcSR4CcK1c7tZnKAW
 XlEjEqZPAgbPehzxLMGo1XhsSJ4bp/haxTwyKjrPWmBGrF09f50MVTmKgr84NZTVG6zr
 jkL1JKVDM6ojqDBvSup4M5ECjD3QI7r4FAIbAGnZk4/bnjq7X8n5KTV6FNNPgPMOdNjj
 ba8Ivi9rNM9dJo3TAarB37qfNkOZVwUYlVBs5NDGRlaMz7gOjHTbSlZ0gAezehGlMDdO
 dY9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761899133; x=1762503933;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WNhpKMV40zyRTVdFiwn1mRrkA9xDpsjN9KPL22xqgpE=;
 b=VU5+iKPUDoQ0hma2RTxkcpLV/fgK3l/64QZTCPtq/qTp4Lkdk6EWKRBOTKxfn454ez
 YRqWfFbMw4DaxF/L/zfqe6r8Cg2NjLEXrCINmuo+QTeX1udYlyXaepUKSxrWD7GxzIpC
 oRlXygD0IhykXXI4nA+OJjbgU8L8RIsnVjv8CGjVZOJ1xZBriLZO6ldoHszK4gDsXF5T
 SM/1RWqNd+p/LnaNODb6Dp+XQpyFmAK/BKig+AwUEOAPRuBy7nSbai1AaM+x1qLNU+9v
 YKHMA8SyrCbYSbCdcRTA8mnMAEp694hHAIrP1YWI2azzRARILLaPvHiH6GlxtNs63/Ml
 Sd8g==
X-Gm-Message-State: AOJu0YwhKVxVlKqnfnPhHcRWdGhkIMowi9mSF4h7h2nbljQT3Ixh99f5
 ccfnz6MOh7jAKhjxEF3gdxDDqPFAFyUHBxdtKwO7YcVZ8Dh/pSqtnn644b+Urg==
X-Gm-Gg: ASbGnctIq6WcxHg6CR/n1qIebKEyWAItWC+GcIUMJb650KSVMnKxrSUaxHZo8Eqj3dB
 S0af1Thwccfns3QeBKwN/ZW9GvmXxu3N0zofWmgkF353mdL+OHQ8m1rTurHW3zu6kbFumvjiBPE
 z7z0xTqCjOyEPCHULgU6rMSEQ1fXwg4aBle2iWGuplnVlEviA964rqk0QcdTBewzBmSE121haWd
 MZFL8PcbcW5H1tkVN1cXkAEkZQzQOPVvTQWiG43MCBHK2020zv7v/CYrATyjESvxCQYKHF4dI2K
 X9mRHwOnENID5MOyCUjEh1FJzGawVELt47LGxcNDuUxtQyyjdQ2C4SAIbnRLouCzPMIzA9JsWmB
 w1V5QFVtxHvHbQmhJ53TGs5bWionpFQr20Ixzbj9697rttICbvukqLaYPBjzHh50MlfdbINgALt
 XHhoirgnCAsU2hUw==
X-Google-Smtp-Source: AGHT+IFeS7aIQhjufM7wEu1LeLTDwTiH0ylzCWXSVF4a2nszECPR/etT/bCTJidcwc3a55bxD5Vcag==
X-Received: by 2002:a05:600c:19d4:b0:475:dd59:d8da with SMTP id
 5b1f17b1804b1-477308c8e97mr22424955e9.40.1761899132679; 
 Fri, 31 Oct 2025 01:25:32 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:1599:7d00:73cb:d446:bf90:f1c0])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47732ff7fdbsm19653125e9.16.2025.10.31.01.25.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Oct 2025 01:25:32 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org
Cc: Sunil.Khatri@amd.com
Subject: [PATCH] drm/amdgpu: grab a BO reference in vm_lock_done_list.
Date: Fri, 31 Oct 2025 09:25:31 +0100
Message-ID: <20251031082531.32715-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
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

Otherwise it is possible that between dropping the status lock and
locking the BO that the BO is freed up.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index db66b4232de0..c3dfb949a9b8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -484,15 +484,19 @@ int amdgpu_vm_lock_done_list(struct amdgpu_vm *vm, struct drm_exec *exec,
 	spin_lock(&vm->status_lock);
 	while (!list_is_head(prev->next, &vm->done)) {
 		bo_va = list_entry(prev->next, typeof(*bo_va), base.vm_status);
-		spin_unlock(&vm->status_lock);
 
 		bo = bo_va->base.bo;
 		if (bo) {
+			amdgpu_bo_ref(bo);
+			spin_unlock(&vm->status_lock);
+
 			ret = drm_exec_prepare_obj(exec, &bo->tbo.base, 1);
+			amdgpu_bo_unref(&bo);
 			if (unlikely(ret))
 				return ret;
+
+			spin_lock(&vm->status_lock);
 		}
-		spin_lock(&vm->status_lock);
 		prev = prev->next;
 	}
 	spin_unlock(&vm->status_lock);
-- 
2.43.0

