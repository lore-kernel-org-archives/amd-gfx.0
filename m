Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 432D8C27C75
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Jun 2024 09:26:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D9EF10E3D2;
	Mon, 10 Jun 2024 09:26:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GyEavH1n";
	dkim-atps=neutral
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BD5910E3D0
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Jun 2024 09:26:20 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-35f1dc4ab9aso1063239f8f.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Jun 2024 02:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718011578; x=1718616378; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Au6qAFQ4uKFbK34ItunBq7NGtmjTqzY5tOsOiZzVOzI=;
 b=GyEavH1nTWcj9yyruTdBUddGXO4MdeEYoznoXyd+mYpTPXIgymNdSL+pm4QvdDCsKL
 y1PyC8pJBmFjsZ5c6Q2araq/2hOHyUQpJuc5GaKg49QVZzBwzNWb9wDf+Y6oUxYUR3zc
 JAGRPyhe2PW6kCIGxAbokBRnh2J3JuOLpDIO+KHm0wclW8rg1RaQocc+XDSly2w9jw7w
 tay8r6jUZtGCsZNj/1HR9p/Yam8kosILc9AIposZXq+Jr12NB7SWCfamkp8qnhTrB9w+
 JrM8pKrjhBQ/EVNhpdpS+O/yc0nGbSlK6iQtKDASpsDVIF4g8IL/TRiaFu+UkcbWHvwg
 odzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718011578; x=1718616378;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Au6qAFQ4uKFbK34ItunBq7NGtmjTqzY5tOsOiZzVOzI=;
 b=V1JW/ofT5/6/KKXJ7TjhU7q1haPabnrba9WR9uzYsBRWApuLj/Bly4AfKyaWoXTUKg
 /MWRU2AJRqCLHtUkJOYvbgQbxVXkdwXon5GKwYYPZHc0NhXmxNQHi2f0BwYdQ9xCCbe4
 dRNr0UxunQtTXaM/lFpuhl4JQwg0Jvv2Vj+/Pvsbdy+SAOi0Ly2AFvB6TGkWwPC2miCx
 H7YXNQswadDy99ko4qEY6P2bavyfS6W4GSd4xJ8oFRjLsbY15n1M1dVvWtltio+ccMSH
 pTLfZEiEfNqa3uoN57WjGBXiyvZPfT00IbU+Xnl2FFWl9KN5ROMcmY8xinFJ3Vp3mAp5
 T0Zw==
X-Gm-Message-State: AOJu0YzJH+GyNnZL0yzduVwGfFpQnVCw2iiAdBXqT9MHox5S2CyIinrt
 Zqgylm3RwmopLA8OBzjKcAzOCXAX3YZjX9P0cxAQ5PsFKymidBMq
X-Google-Smtp-Source: AGHT+IHThQxZHvinzAloWWj/NPG5EqNrhEalPVmf3qbF1RhqkkF3ukJPL0sno7jfMkqYDMlEqE27Ag==
X-Received: by 2002:a5d:6d8c:0:b0:35f:2919:8171 with SMTP id
 ffacd0b85a97d-35f291981edmr398558f8f.26.1718011578519; 
 Mon, 10 Jun 2024 02:26:18 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:15f9:7000:4916:a8ec:dd12:5894])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35f2169fc45sm3075827f8f.10.2024.06.10.02.26.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jun 2024 02:26:18 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: pierre-eric.pelloux-prayer@amd.com
Cc: amd-gfx@lists.freedesktop.org
Subject: [PATCH 9/9] drm/amdgpu: try to avoid runtime PM in
 amdgpu_driver_close_kms
Date: Mon, 10 Jun 2024 11:26:11 +0200
Message-Id: <20240610092611.2894-9-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240610092611.2894-1-christian.koenig@amd.com>
References: <20240610092611.2894-1-christian.koenig@amd.com>
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

That's a bit more trickier since we really need hw access for UVD and
VCE and eventually when the VM was in use.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 1e8c8d9c0c67..1163ece2a757 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1395,18 +1395,26 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
 	struct amdgpu_device *adev = drm_to_adev(dev);
 	struct amdgpu_fpriv *fpriv = file_priv->driver_priv;
 	struct amdgpu_bo_list *list;
+	struct amdgpu_ip_block *uvd;
+	struct amdgpu_ip_block *vce;
 	struct amdgpu_bo *pd;
+	bool vm_ready;
 	u32 pasid;
 	int handle;
 
 	if (!fpriv)
 		return;
 
-	pm_runtime_get_sync(dev->dev);
+	vm_ready = amdgpu_vm_ready(&fpriv->vm);
+	uvd = amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_UVD);
+	vce = amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_VCE);
 
-	if (amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_UVD) != NULL)
+	if (vm_ready || uvd || vce)
+		pm_runtime_get_sync(dev->dev);
+
+	if (uvd)
 		amdgpu_uvd_free_handles(adev, file_priv);
-	if (amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_VCE) != NULL)
+	if (vce)
 		amdgpu_vce_free_handles(adev, file_priv);
 
 	if (fpriv->csa_va) {
@@ -1442,8 +1450,10 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
 	kfree(fpriv);
 	file_priv->driver_priv = NULL;
 
-	pm_runtime_mark_last_busy(dev->dev);
-	pm_runtime_put_autosuspend(dev->dev);
+	if (vm_ready || uvd || vce) {
+		pm_runtime_mark_last_busy(dev->dev);
+		pm_runtime_put_autosuspend(dev->dev);
+	}
 }
 
 
-- 
2.34.1

