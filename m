Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30F03CA0EED
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Aug 2025 15:02:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9C7010EA11;
	Thu, 28 Aug 2025 15:02:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AdkWlYSd";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A57D110EA10
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Aug 2025 15:02:04 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-45b627ea685so8468895e9.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Aug 2025 08:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756393323; x=1756998123; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jA7DlHJSjOpB/Itq3V8hmRsrfa+VYLwiVXgVafz/5Ko=;
 b=AdkWlYSddUM56Qsglf2its+JSmHIi9Uf5NtPg8tpB+sa6alAFXcgFS6OUhgh332jof
 kxxGUf3fX9kttB3co4WLVeNZswcfJN+K+62j5+NS/BgLSCUOEcIrjhJ/0L2lkAKLRxsq
 W4xn2uB7sTWgL747ptKB7BMO+ZWHFhvNMAkiCCP66oJSnW6+ga3+UflwVahjP1c+yq4j
 kHRlNyA7omemySc63ov5sIrL1asNY0m2GX+NZKWxULq6+/GMqTVnbAIfrGFAmX1YNg0N
 j/cbS2/Hv/ZeCR1gUwOb5VTAiVmppuSzD6/ZckKE9d9nuPVYA1A9XsQ7tGCeJmyffDNs
 /93g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756393323; x=1756998123;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jA7DlHJSjOpB/Itq3V8hmRsrfa+VYLwiVXgVafz/5Ko=;
 b=QEgGWi2rdVFko2PeZ1J5p0KAhcfz6kSvVT3gCA+IdiZzWDEzDp7k2TZ/DJVEpwS0f+
 mns25J5EGY1W2zP4us4H1JYg1M83cspGrXKXxRhXc3s1iX2dI+a8ao6v1/pFE2UqjO/C
 Hbx5Hm43CRFZuK1+Cq3DMBVe9XhvqQ6vfs7Z5g6Vf74VvgflU4HqEgwURzuTD2jligcY
 8WrMF3My0cfdIuToWfrZJ5pU9l16Gp95zwFryAvP0To/jHdpcLNmpSA54B9UpGcBPdtd
 bUIL2LUfYAUde3lbEq14CnPLcvuQCCnSC9ls4mwLOKsnQghvoSWCQuaO57cwGI0CS7Af
 jtWQ==
X-Gm-Message-State: AOJu0YyZscqXQPW1S7sdJoK01htKGgl+6GvHdBvtlza8dv8R04uJbH75
 Yec1ZpLfvcfpH8hrh8FjKG99qzG0OrkPCWUunL1HtFWyIxXekiDzMIjb0gljLQ==
X-Gm-Gg: ASbGnctDdW9PQWwPJxaXEXbQ7No8ymk6QE2b0TlP6iENQXGR/6me0UCc7omCe2+hJof
 /VBu2IW67ALi5tLvDiQMZrMwgdUFqBzin3PkP+VclsAGUHKvslilOe1iN+2A2RaP50n24k53Hhk
 QvBbXI77X1O6h/ROhYX3A2ocpiYHndCX4wzJJzpJLGwVjzzFm5ZJ3SCsM9ywUuwXI+mBXxSabqt
 cBAPFHZ85HqjL0wzjoYCrPMR/iwabOn38VLkx578ix1R0nIzIaJeU+B2warUyXAE2kQY0rkEWtK
 +9Iw3ohKYDuZyu4be4sEJy4jBjflwHMnrnQr/dXggEco39/V3WsUwkxyxHDWxJgIa0WmtUADttr
 wL22cSitEffR++Da5BS3FRglLQCkmCPCVBg==
X-Google-Smtp-Source: AGHT+IGozPS4GJRamxgmWElxpIvQoPa4FR2lS26XoLuUQuO9FzlhwGKocDWg+o/+Rjh4NjwyVtfmDQ==
X-Received: by 2002:a05:600c:3594:b0:459:f90e:4f5a with SMTP id
 5b1f17b1804b1-45b5179ebbdmr190224995e9.15.1756393322713; 
 Thu, 28 Aug 2025 08:02:02 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:1520:b00:8770:5cba:6330:4e5e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b71c10e3csm78212655e9.20.2025.08.28.08.02.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 08:02:02 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: Sunil.Khatri@amd.com
Cc: amd-gfx@lists.freedesktop.org,
	alexander.deucher@amd.com
Subject: [PATCH 2/3] drm/amdgpu: remove check for BO reservation add assert
 instead
Date: Thu, 28 Aug 2025 17:01:59 +0200
Message-ID: <20250828150200.4035-2-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828150200.4035-1-christian.koenig@amd.com>
References: <20250828150200.4035-1-christian.koenig@amd.com>
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

We should leave such checks to lockdep and not implement something
manually.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 16451c9bbe1f..a0339187eccd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -651,18 +651,7 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		spin_unlock(&vm->status_lock);
 
 		bo = bo_base->bo;
-
-		if (dma_resv_locking_ctx(bo->tbo.base.resv) != ticket) {
-			struct amdgpu_task_info *ti = amdgpu_vm_get_task_info_vm(vm);
-
-			pr_warn_ratelimited("Evicted user BO is not reserved\n");
-			if (ti) {
-				pr_warn_ratelimited("pid %d\n", ti->pid);
-				amdgpu_vm_put_task_info(ti);
-			}
-
-			return -EINVAL;
-		}
+		dma_resv_assert_held(bo->tbo.base.resv);
 
 		r = validate(param, bo);
 		if (r)
-- 
2.43.0

