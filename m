Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC596C4167B
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Dec 2023 12:55:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2301510E2C5;
	Fri,  8 Dec 2023 12:55:25 +0000 (UTC)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A58B910EA9E
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Dec 2023 12:55:23 +0000 (UTC)
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a1caddd6d28so271945366b.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 08 Dec 2023 04:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702040122; x=1702644922; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=OKtnoWVE3yBL1SQe5+tJ47srUCtIcYEkP/nshBvHeAc=;
 b=Db4BS9wFGH+BXAGjiT8KlEquacYwXRzbyvLpUBEkAYBrrarMyqfUOzLIXmkfy6nbsO
 v1L+g3S2maU4WgtHJUJWjDki1lhrRJhS7mNZg1T4xvFCdVWNNxFMyLBaj3yyS3ikYhWP
 smFlMQqY8Cl9QigEKF2ZtYWdTDNpT5ynrBE+oRyO1e+xmPQTX81zd7r7E/SR2b4fnWyY
 zftWwyO1zHGRLYA5w8mBUMXu484RQfo656xKM8pYpk52jf8NODP/9j1A2pMRKQDKLm4B
 gu+Sj7B3mK5btYfhFMVuBUEdZtrJmFuAVFiVwl/oy2SMULdAqTeUvehGh3DHJp0KjLia
 jPrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702040122; x=1702644922;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OKtnoWVE3yBL1SQe5+tJ47srUCtIcYEkP/nshBvHeAc=;
 b=rJVj0FEsLKvLZ26nmgSEPV3NITatRC2Rpx9h6hq1Yeznx2Kv4tM7g5o/2GdbxeP8pm
 BLEuxZZaeM38HMQCYUBjEChGJHYWqyvm0+U7TwIHvcDQPENlGFGqLydfoOeZb5eLFJIA
 OjvEGhHcH3ni0FFHyv+Tu3b3sN7PIRTgGKGcaHpnkv0M5gC5ChN5Zvp0UYJovwwqfSy5
 zUWLfSPyxVghvjg7ec5iGqAroXg+ZyS7wNyL2yPoBYiF1A7kwu73Za5G4RjUSnvlNFsu
 yIXFpX7zjlSdDWv/5UGP8cb5rCkLqH9LDuGvG4jr2K6sw0iqWYHOonQ18ta+8BcNTv60
 gVTg==
X-Gm-Message-State: AOJu0YxYqqqvmU3xApZ71f1lovPyt8M0WCKGa5sW95pNBRKAmnUY4fvI
 bGz9WH3Y0DeXUrbM3amA55mbb/zT02Q=
X-Google-Smtp-Source: AGHT+IFsBdpKSRLDZDrWFdNsBn+6Z61hy6NmM3zpOFtgtxyR46R8Lg5HRuNxlfzoH/tIsurQzLb5xw==
X-Received: by 2002:a17:906:fa95:b0:a1a:582d:f0e9 with SMTP id
 lt21-20020a170906fa9500b00a1a582df0e9mr1661838ejb.73.1702040121858; 
 Fri, 08 Dec 2023 04:55:21 -0800 (PST)
Received: from able.fritz.box ([2a00:e180:155c:b600:9612:d720:3125:86b])
 by smtp.gmail.com with ESMTPSA id
 ry9-20020a1709068d8900b009adc77fe164sm983174ejc.66.2023.12.08.04.55.20
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Dec 2023 04:55:21 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu: fix tear down order in amdgpu_vm_pt_free
Date: Fri,  8 Dec 2023 13:55:19 +0100
Message-Id: <20231208125520.2278-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
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

When freeing PD/PT with shadows it can happen that the shadow
destruction races with detaching the PD/PT from the VM causing a NULL
pointer dereference in the invalidation code.

Fix this by detaching the the PD/PT from the VM first and then
freeinguthe shadow instead.

Signed-off-by: Christian König <christian.koenig@amd.com>
Fixes: https://gitlab.freedesktop.org/drm/amd/-/issues/2867
Cc: <stable@vger.kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index a2287bb25223..a160265ddc07 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -642,13 +642,14 @@ static void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry)
 
 	if (!entry->bo)
 		return;
+
+	entry->bo->vm_bo = NULL;
 	shadow = amdgpu_bo_shadowed(entry->bo);
 	if (shadow) {
 		ttm_bo_set_bulk_move(&shadow->tbo, NULL);
 		amdgpu_bo_unref(&shadow);
 	}
 	ttm_bo_set_bulk_move(&entry->bo->tbo, NULL);
-	entry->bo->vm_bo = NULL;
 
 	spin_lock(&entry->vm->status_lock);
 	list_del(&entry->vm_status);
-- 
2.34.1

