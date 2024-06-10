Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3008CC27C5E
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Jun 2024 09:26:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DD6C10E3D0;
	Mon, 10 Jun 2024 09:26:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NZB6/4z3";
	dkim-atps=neutral
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6885410E3BD
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Jun 2024 09:26:19 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-35f1dc4ab9aso1063228f8f.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Jun 2024 02:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718011578; x=1718616378; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nwvtUmn8BTHAUVm+ozwgRi8ET4/R7RH9C1+L/G3hxIU=;
 b=NZB6/4z3uQOQoWnsRp1ou4bfziVlOLDTD64p++5qDpVV1znYfKfMoqLey4pu/sCm+M
 n53c/5O86o+nuryVK7Du7HXEjDKFnU4f2lLbFfgr/Ultx9+d2BACYXhWEfob0qFhy4Ie
 Pv9TwAdgKX1zrXv1mnRFp7Kj3OT+SrBZK3hOotTA8tGJ0/FBddVCPjE2YlEG1VyASRoj
 lXojDL0z96NGOFxFT8Jh5kNAV0UrOgPhc+dhCEvsmqRCRhEqnvt9dnSBW1cOlM6xAXWL
 bOaeIxexHd0fP6NY3FFTeWXPNpo42moewtk6IjqdLEDAZwdNhjrK5LnRAXzfsroPd0Py
 1/3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718011578; x=1718616378;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nwvtUmn8BTHAUVm+ozwgRi8ET4/R7RH9C1+L/G3hxIU=;
 b=U7rP3eM4eDqo38/YPgIReguIYvztdrOqX1pCqDIjVagT+uOjdceScgf3ukIn5SxCXt
 VxbKT8f54URwfDYd0zSn87ti3sDQenVpAMG4xpAc1JvdrEYkXzItsqQPPZy23huGY1GY
 U/KKFi821t3yKW62spoMohZgVOVS15SA9YzxOS1nNYZ4gNhM80yuRCL/TJvemb/+i/w3
 Fc+SFGJx4b9b2W4nAoYaPNAmr7suyUYEF3dOd4yBZqDiL+1ADljbUE4N18/xERn0GPFU
 QcXzycdU/kREHW4QMPa+Q5Pp8iYY63XtD7STW8xpO9UWd2YJdGA8C+Jb/TpNamed/iOb
 lJjg==
X-Gm-Message-State: AOJu0YxwkggFarVnCcto1oMGeS+Wfm1DBOBHF5h4iZhgQCmhciCNShXk
 JxgiJH6qbjRXPA4ttWQl8z97SZaTPM5D22k91NiiS8WryCThLUe6
X-Google-Smtp-Source: AGHT+IEXfilJVbhV1hmnkfUFjwJwyNKZ85qXuzu2ydH9Qp8BMKgU0lZYnBy/c/Q3wxYbSJToDnOBTA==
X-Received: by 2002:adf:cd08:0:b0:35f:1bb2:4354 with SMTP id
 ffacd0b85a97d-35f1bb24641mr2697798f8f.35.1718011577747; 
 Mon, 10 Jun 2024 02:26:17 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:15f9:7000:4916:a8ec:dd12:5894])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35f2169fc45sm3075827f8f.10.2024.06.10.02.26.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jun 2024 02:26:17 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: pierre-eric.pelloux-prayer@amd.com
Cc: amd-gfx@lists.freedesktop.org
Subject: [PATCH 8/9] drm/amdgpu: drop the runtim PM in amdgpu_driver_open_kms
Date: Mon, 10 Jun 2024 11:26:10 +0200
Message-Id: <20240610092611.2894-8-christian.koenig@amd.com>
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

Fingers crossed that this works now.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 28a8f13ab8a7..1e8c8d9c0c67 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1312,24 +1312,16 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 
 	/* Ensure IB tests are run on ring */
 	flush_delayed_work(&adev->delayed_init_work);
-
+	file_priv->driver_priv = NULL;
 
 	if (amdgpu_ras_intr_triggered()) {
 		DRM_ERROR("RAS Intr triggered, device disabled!!");
 		return -EHWPOISON;
 	}
 
-	file_priv->driver_priv = NULL;
-
-	r = pm_runtime_get_sync(dev->dev);
-	if (r < 0)
-		goto pm_put;
-
 	fpriv = kzalloc(sizeof(*fpriv), GFP_KERNEL);
-	if (unlikely(!fpriv)) {
-		r = -ENOMEM;
-		goto out_suspend;
-	}
+	if (unlikely(!fpriv))
+		return -ENOMEM;
 
 	pasid = amdgpu_pasid_alloc(16);
 	if (pasid < 0) {
@@ -1374,7 +1366,7 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 	amdgpu_ctx_mgr_init(&fpriv->ctx_mgr, adev);
 
 	file_priv->driver_priv = fpriv;
-	goto out_suspend;
+	return 0;
 
 error_vm:
 	amdgpu_vm_fini(adev, &fpriv->vm);
@@ -1386,12 +1378,6 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 	}
 
 	kfree(fpriv);
-
-out_suspend:
-	pm_runtime_mark_last_busy(dev->dev);
-pm_put:
-	pm_runtime_put_autosuspend(dev->dev);
-
 	return r;
 }
 
-- 
2.34.1

