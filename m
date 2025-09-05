Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0BD8CA1013
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Sep 2025 11:27:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96E1B10EB7E;
	Fri,  5 Sep 2025 11:27:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Hiv2pJS1";
	dkim-atps=neutral
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com
 [209.85.218.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0374010EB7E
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Sep 2025 11:27:05 +0000 (UTC)
Received: by mail-ej1-f53.google.com with SMTP id
 a640c23a62f3a-b042ec947e4so273863566b.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 05 Sep 2025 04:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757071623; x=1757676423; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mwj1099bRWbI++t9TUsxRRzVsY4QOSd+fL5cxnHhcIw=;
 b=Hiv2pJS1Vi6IMEcRkBh6p5Yyh7TAzcjBTE1XLBnSD+1wjwkG8MwKmb5tWP62wvdRDi
 SLoX6QZnEXHuUJIrIwiqQLdAaKG038zOcmGtUOSpH1gY7CxcfkxlY5keMGheCA5HGKPT
 vATn9pU+t/Pg1Sv34YadpdtkSqASBZ6w060ZSHZJVkBGv734wQdWpHh5ljSBQnOc1yB4
 maBLDvLYeVPcDE0GW+rF5JOqGvK4Xf3zbXFW05uPygYRtaPne43ceQvncG2Lx3moV/gC
 gDMJ3wdZjgACTp9HKpUTQZrXe5NqLiciMs+VfJQ7hHhMBv0hlmgRAgqonYSZh0g4/87M
 CANw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757071623; x=1757676423;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mwj1099bRWbI++t9TUsxRRzVsY4QOSd+fL5cxnHhcIw=;
 b=w9/t6cB4qUrbkPNWJeS4BLadL1QfV4Z1JhAKKSfrzYUZYACTu1XU7HxqaTlH3eEi7i
 cfjzhJsWwSbgwkQ/D/QWNNK8PIo3BllqECpyn9zMGi5uTb+NVvu1esEDm26uhB63+ZM5
 vn8ZDgFxnanLyGABPDNGHCABiz/dr5WEAIaEksRKL91zkqRJiethig8IAhOS77f2QRtn
 pnnQkJZWuQL/TS8Ti0n5pxG9SElLQD37IEes4N4qdQfqmBkoapqXCGWNTG5eRhfaoEJq
 9J1eYF9TEBKkKS3VRYnvVTCww5mK17dvQug7MUinTc8aWsPMxf3ftg9ootGcNdWY/u0q
 VhTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlsVM30jJ+oBcM+DDR3Os3D96NVyyssyAGbfOIz3gYt/ywDXLUyEXnvOq83BtsXwGr8YX6CyxR@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyD3dL4gh/N0uNEKw6P1MZ4UNBaNHQTq42+guCLunq7nsgiCXBb
 7KXbNETzXPlozHXqYPh0Gj4HY9PCiYe0Oi+CjoIf9rpJMUJyh12OOwcojpoemw==
X-Gm-Gg: ASbGncs4kwu7L++9R9pGDZjSjWW3xLt6C90/hMhEQqF0lGdTojlM/2egHol/ehDtt3G
 Y9G8/yjEFBtN8p+wTl6qwVM46H82z7opdfY/D/O3ne4NDn/VnthuU/t/VNGpUZrbhjCbHWMPsIR
 51ilhrFX1MiSuW/rCbrU6BnMdGY1DlwlPsOJQoN+bZb7dhbYbP7t7L9LwLGmgV4tleTKEBTSmxH
 7AgSrE7y5FcPY9xEXrJiOZcWQ00JEhkqhmsUbqMCFsBCFM87U244ngm/s5CP/uTtvkSLdV910Nf
 Mn4iZnUt9d+FWhHmRBoVcKLI0vPpO92rpyXb8JhoLfHBz8W/834HP65UvmtzdFzkRXxNJIuGO02
 3nTMnOZGCDYJQqxiXNo9WPcLz/4nU5uB/VC8eUZrSwEMPb9Y=
X-Google-Smtp-Source: AGHT+IHEcARB/EIy5q3YyH4AVYDE9BD3WYdlTZzgk2dfqlmviXW9EoVPCieRd3l/LbCV7PaCfQkR9g==
X-Received: by 2002:a17:907:fdc1:b0:afe:b878:a175 with SMTP id
 a640c23a62f3a-b01d97a0c24mr2447655766b.46.1757071623388; 
 Fri, 05 Sep 2025 04:27:03 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:15bd:7900:c026:1908:2e29:be84])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b0079183496sm1551044366b.13.2025.09.05.04.27.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Sep 2025 04:27:03 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: Sunil.Khatri@amd.com
Cc: alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org,
 Prike.Liang@amd.com
Subject: [PATCH 2/3] drm/amdgpu: remove check for BO reservation add assert
 instead
Date: Fri,  5 Sep 2025 13:27:00 +0200
Message-ID: <20250905112701.2443-2-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250905112701.2443-1-christian.koenig@amd.com>
References: <20250905112701.2443-1-christian.koenig@amd.com>
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
Acked-by: Sunil Khatri <sunil.khatri@amd.com>
Reviewed-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index ec29fec1739e..31976ef75014 100644
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
-				pr_warn_ratelimited("pid %d\n", ti->task.pid);
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

