Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0FA8D116F6
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Dec 2025 15:12:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31A1A10E0B6;
	Tue,  2 Dec 2025 15:12:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PqunClgn";
	dkim-atps=neutral
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com
 [209.85.208.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4456D10E0A7
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Dec 2025 15:12:45 +0000 (UTC)
Received: by mail-ed1-f45.google.com with SMTP id
 4fb4d7f45d1cf-640a3317b89so8827046a12.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 02 Dec 2025 07:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764688364; x=1765293164; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gMaJyn451V4gch7sed4+jMHNNjvzFY0bouzPGINGQyw=;
 b=PqunClgnFXQESOous4n/sdq4IraK8uCqlR8q2C2Kra1ObJbHMxzaR6eN1p2UNmX9DB
 ye0ph/BoeEXebBdJ6HCRiSUU0t2aeYsgrKM6AqUIT10kt5S9ZtmdSY0bqfH43lGyaJdt
 1rhLorAks73JWU2gvOSKSNXifuAmoJ1QG10IsJ5/Quv6qU2nM6AOcDNiufpstzPk+z5H
 JqLSEHPAAqhM8iW9mxkFIjym0lSui569ilDQMybspp0cUiQfxwh1R5qfK4LjdvlIimmn
 vn0NLnZT1Gx5psDWSweo4+TuLkEjzUazS8ilcHVV9xHDoajqlhOYUe0qHAbwUPjiCvc/
 XAQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764688364; x=1765293164;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=gMaJyn451V4gch7sed4+jMHNNjvzFY0bouzPGINGQyw=;
 b=RBXeLRjH1C32xxja4X5HQbiTWiJ8idsopwvqLY2Jt3FZ2c484MNcaZqveYoJcaeDcT
 iz5HM7/Bhf15OlqKZBZ2/qp551/t9TTUKmXm7gcnjlqG3U+mrlb58qB2y/kcA68BVgMc
 QKeG9wH4I8JGgKRHZfelnH2ioNjI2/X+FLB8x00qe4hZO9oLByOJR5vKhDTp4xjCBpCz
 KUTwhmtI4VeFTXa1Uq6DcZyqqkNqcrXMtW2dhuaTSup/22yBrfwSqvS2z/ef6EEDpHDS
 knxxB7U6gu8iMsJgP9NgX4yrCyEMo2DGoSuHCAdxeswzdNR60nvTZc60dSsArJbNiLKU
 qKbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDdv26ubo/tWtuZHeryMrm3LIjr8lf0pN7YE8ZQozmcoZMBjuciqH5SoSIyx7GLwyOQkCt8HYt@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzi6orf8NALA5vVIFu7XGmjXMqwiX4cRegbkdCX59gevdr6Z7h5
 GCmmh+CS9RMnQI2HnDgpQ3GuV06GrWdejFFazXPxiYpuVj7AubAk8wAM
X-Gm-Gg: ASbGncuQExplkUMiJ7udBvIz2RIo+TMaA6q2Fwk0i2A9c5EMcjcTHK4aMsrqvSFqHBI
 tiJ3uP6fXpAkAuiuNILO0ekluQYn8e+EzefCzaNfO7jQF0gyXjemSmQ3wUeoAqK0gAHP27tj914
 scf+FKUPbNrESSO0riIoFv5qubgZ6v3R3TthxeWlPsVkAlwARLFtxdrPhIzm6nRHWucn6Cbc1nG
 Ak6YFQM/b3Y4PHJ/Gt8UHwWn6JOgEaSxDyBQuSZgS8fsXmDUcUOJ0AN7xQOXQTHWORLBg55lACM
 LW5TfQ66MVt4BoxI/Cs2RzWE4h02oLWD6gSF3THzjSEUNmUVhX5rozYE8NFOHhcetjaBtKJTivP
 fmro4C2mjcR7aaom6sUk047p3gNI81N3p0mKsQO3EbXSKnhOs/5r8GRsbCXuyyKJ/e/njOaaDcz
 ioBFF/pnEORsvcPeDJ9m7W1lj7Steca8KPbkQ=
X-Google-Smtp-Source: AGHT+IGsONeYtasocXe30FUeSMhguDtoCnThbOKeIRYdequ69DJYlRNnCT89ziTuXQmlk8dhUJlMlg==
X-Received: by 2002:a05:6402:350f:b0:640:a356:e797 with SMTP id
 4fb4d7f45d1cf-645eb2648b3mr30628056a12.13.1764688363613; 
 Tue, 02 Dec 2025 07:12:43 -0800 (PST)
Received: from able.fritz.box ([2a00:e180:1566:ae00:9ed7:ba17:59d5:1db2])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-64751035c3bsm15520882a12.19.2025.12.02.07.12.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Dec 2025 07:12:43 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: alexdeucher@gmail.com, srinivasan.shanmugam@amd.com, Leo.Liu@amd.com,
 Ruijing.Dong@amd.com, amd-gfx@lists.freedesktop.org
Subject: [RFC PATCH 2/3] drm/amdgpu: add AMDGPU_GEM_OP_OPEN_GLOBAL
Date: Tue,  2 Dec 2025 16:12:40 +0100
Message-ID: <20251202151241.2212-2-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251202151241.2212-1-christian.koenig@amd.com>
References: <20251202151241.2212-1-christian.koenig@amd.com>
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

Instead of abusing the create IOCTL to open global BO add a new
AMDGPU_GEM_OP_OPEN_GLOBAL functionality.

The new AMDGPU_GEM_OP_OPEN_GLOBAL functionality expects an enum which tells
it which global BO to open and copies the information about the BO to
userspace similar to the AMDGPU_GEM_OP_GET_GEM_CREATE_INFO operation.

The advantage is that we don't start overloading the create IOCTL with
tons of special cases and opening the global BOs doesn't requires knowing
the exact size and parameters of it in userspace any more.

Heavily WIP and only compile tested.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 26 ++++++++++++++++++++-----
 include/uapi/drm/amdgpu_drm.h           |  5 ++++-
 2 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 9b81a6677f90..9e9b94dcb699 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -968,22 +968,34 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
 			struct drm_file *filp)
 {
+	struct amdgpu_fpriv *fpriv = filp->driver_priv;
 	struct drm_amdgpu_gem_op *args = data;
 	struct drm_gem_object *gobj;
 	struct amdgpu_vm_bo_base *base;
 	struct amdgpu_bo *robj;
 	struct drm_exec exec;
-	struct amdgpu_fpriv *fpriv = filp->driver_priv;
 	int r;
 
 	if (args->padding)
 		return -EINVAL;
 
-	gobj = drm_gem_object_lookup(filp, args->handle);
-	if (!gobj)
-		return -ENOENT;
+	if (args->op == AMDGPU_GEM_OP_OPEN_GLOBAL) {
+		switch (args->handle) {
+		case AMDGPU_GEM_GLOBAL_MMIO_REMAP:
+			robj = drm_to_adev(dev)->rmmio_remap.bo;
+			break;
+		default:
+			return -EINVAL;
+		}
+		gobj = &robj->tbo.base;
+		drm_gem_object_get(gobj);
+	} else {
+		gobj = drm_gem_object_lookup(filp, args->handle);
+		if (!gobj)
+			return -ENOENT;
 
-	robj = gem_to_amdgpu_bo(gobj);
+		robj = gem_to_amdgpu_bo(gobj);
+	}
 
 	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT |
 			  DRM_EXEC_IGNORE_DUPLICATES, 0);
@@ -1002,6 +1014,7 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
 	}
 
 	switch (args->op) {
+	case AMDGPU_GEM_OP_OPEN_GLOBAL:
 	case AMDGPU_GEM_OP_GET_GEM_CREATE_INFO: {
 		struct drm_amdgpu_gem_create_in info;
 		void __user *out = u64_to_user_ptr(args->value);
@@ -1096,6 +1109,9 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
 		r = -EINVAL;
 	}
 
+	if (!r && args->op == AMDGPU_GEM_OP_OPEN_GLOBAL)
+		r = drm_gem_handle_create(filp, gobj, &args->handle);
+
 	drm_gem_object_put(gobj);
 	return r;
 out_exec:
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index c1336ed4ff75..6927c864a6d1 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -807,6 +807,9 @@ union drm_amdgpu_wait_fences {
 #define AMDGPU_GEM_OP_GET_GEM_CREATE_INFO	0
 #define AMDGPU_GEM_OP_SET_PLACEMENT		1
 #define AMDGPU_GEM_OP_GET_MAPPING_INFO		2
+#define AMDGPU_GEM_OP_OPEN_GLOBAL		3
+
+#define AMDGPU_GEM_GLOBAL_MMIO_REMAP		0
 
 struct drm_amdgpu_gem_vm_entry {
 	/* Start of mapping (in bytes) */
@@ -824,7 +827,7 @@ struct drm_amdgpu_gem_vm_entry {
 
 /* Sets or returns a value associated with a buffer. */
 struct drm_amdgpu_gem_op {
-	/** GEM object handle */
+	/** GEM object handle or AMDGPU_GEM_GLOBAL_* */
 	__u32	handle;
 	/** AMDGPU_GEM_OP_* */
 	__u32	op;
-- 
2.43.0

