Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46D98CA1016
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Sep 2025 12:09:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9B5410EAE2;
	Thu, 11 Sep 2025 12:09:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="drOPsWq4";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B40610EAE2
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Sep 2025 12:09:54 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-45de56a042dso4251465e9.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Sep 2025 05:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757592592; x=1758197392; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TaDpUHeC6qKsxle4Xam1ThXAgH72SAJB9Ceehz/mgXc=;
 b=drOPsWq4Uke8DdDhWuDdFygsSADSOMBHSMdrGoox1bytoPyc8j1ww9w/tW6CWdew5V
 1W4xuukEC991g7bWq6l8d2C63beX2Czv6X8trYxeyCOwIFIfx0gJhz0yDMCExcnFoyAw
 0IN39F0qOchwYQxyNNY/6d+h29wRNvXTDEKpPxUj5I4ZOMze9VVIo8i+ocAdY/3l0ezd
 JCT1FHE1YSwq2y+vWDsYi3GDfa7f9Ss34NB0i5tFVuJn9rsQkOMaNXcWhvtk8UDnKpXB
 RdTJz5rfCT3KAjEnUJjuqNg3oKFzeylkA8WZWGRUKTiNTY+h3lDm1JNkcs17El4aMsGo
 oxJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757592592; x=1758197392;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TaDpUHeC6qKsxle4Xam1ThXAgH72SAJB9Ceehz/mgXc=;
 b=XlgDoN8lfQO7Afo+IQNLzRE9DxoCB4ggajV6AEQNtOQl8i2+3fR1JD+0wTLx2Tk/8B
 KxLRTlZJPdIL4Xo1PsW93NykLFiYSiF/pumG+ItDgtf/yDF+VmDY2qSKSZ98NSyz1uGw
 sqPHAouiP1Jpio+LTVjtUxLYp00n9loUW8B1lT/L14UO94Mju+xrHNUCtl7dieKlkxW8
 4eOKScOEEWbrWgo15OOB0i8uORzuCnoEV01yZMZAGw06PsrFYBogzHrXbcnTeqEXA5HT
 u/RbFtoc/GVdlhq6EbZxrAhRVOOEh5UZWQ+9VBBXqHSPln7SWoJgoyVO6PY7Qodol+NC
 x+2w==
X-Gm-Message-State: AOJu0YwEIdrALCZQphvK4KtUk2Icg4ciWoPzeI7SIqVhjLgBnTSjTUut
 Zb4CSyHWRQ1iLbk9ekmol7YnAk9ktyu9a49FJF5TVqQ+/oyYB5FRvxqExELE17ud
X-Gm-Gg: ASbGncsmvawnsy8DGsiMWowRJnxaYjzY8MBStLxQWMpboOLP5YTwseejDa4gPlRkDS3
 5OrDC2B9J1wvWRqj5xlgsct8yz83jia3GLEgk2UKSE3SjBYa5Ln3JstzhtxinLGXe6tQ1AGXVnz
 5jniu83lGjmIsI7a2Ocm3q5n4y1Cac3d0xMgEJpMfmKUmEEhdR1uTYWmlzJbTutj94kJZN+IehJ
 tza1uJKmFmq6Co/GcOaKULua+uPXPqv8XknqPp3WYtA9Ff45X6BCaL3Wa0t/dLP9X4jKfc5Mu6e
 vaZ1cVcOFgyYyZcvdH/fGQE/vGIur0GPP3dmGJ7DHQ0CcCVEIEKoqy9JKZZ//VgW/NUWUO1N43I
 CjKdpy3PithIkFIWyU6qQUuU2c2clm5Yf94TRmnY2O+v1LKc=
X-Google-Smtp-Source: AGHT+IFLaThCqcOyAvH/1Mh86aE8AvUqnIs7DyU7MPUZiRW8E4OO9A5D7sj97gNIZkYwAZA1RCR8fw==
X-Received: by 2002:a05:600c:45c6:b0:45b:8ac2:975e with SMTP id
 5b1f17b1804b1-45dddef0139mr167724485e9.26.1757592592427; 
 Thu, 11 Sep 2025 05:09:52 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:1539:fb00:efcb:f439:6900:a9d9])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e7607e1400sm2224744f8f.55.2025.09.11.05.09.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Sep 2025 05:09:52 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: alexdeucher@gmail.com, Sunil.Khatri@amd.com, Philip.Yang@amd.com,
 Prike.Liang@amd.com
Cc: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/4] drm/amdgpu: remove check for BO reservation add assert
 instead
Date: Thu, 11 Sep 2025 14:09:48 +0200
Message-ID: <20250911120950.3343-2-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250911120950.3343-1-christian.koenig@amd.com>
References: <20250911120950.3343-1-christian.koenig@amd.com>
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
index 9980c0cded94..d0c95fb0ef81 100644
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

