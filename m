Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 794AFD78783
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Dec 2025 14:52:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F352910E499;
	Fri, 19 Dec 2025 14:52:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LfpqVPEE";
	dkim-atps=neutral
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89F8510EF43
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Dec 2025 11:35:56 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-34c2f52585fso1389706a91.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Dec 2025 03:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766144156; x=1766748956; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JA5intEY20oPKSii3rLvk45WSR+ZyHeegPBmceUZplA=;
 b=LfpqVPEEyxBQS9DyY7yDpt6IqgfaAbb6/WI1U44GafphUxV+Yld9PGZ4BeUI2xWj4r
 Bs6DcbSxm4nIzl3qWELmVCspLr4OLT7aFxSlYyg6rv3XX9jbrdbT7nzedYFu6We17GHd
 KncC+wODSkAOK+TK7qGCFXjAH7/pJHPQeTKuXXKJjHgCnFsLN20PraOW0x24ylWm4vgB
 e+5F8ArY3H0b5v9tyOaVgFeYBKAlcTNdU/b9OhYvXXADnnXf3dLJbeGpWav4umsIueq8
 hypRQp9I/+XvKAv7xbVfBjFr6nD9zSXvfXYXR5ZPcYclrmMB6TSa2hglkUIW/y46gtTL
 Aiqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766144156; x=1766748956;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JA5intEY20oPKSii3rLvk45WSR+ZyHeegPBmceUZplA=;
 b=GfFWrb20d/rWZfE1v9kPLpxzxI1v6fkrodDU5GSmdCccfU/POAZjC+mMFkrjN/f/tG
 VUWCQmX7Jjb7Q5vE458xmnXwnoquSAEMBlu5MhfKYswOZh2UtSTF0/M4jckj166j2tdP
 fNOPF4Vd2Mk4SLfGKsydmlovXJXZjIpfHSZN/tTxnYNDx1KobQ5qHe+gRvNZrkuOO7mu
 mnPLk4KRtDMnGRQv4rSShkAytCvOiQb3Is2Qcamyr2us4yLvALKa/JlILLjzdXSxt5a4
 Nk+C7Jk33qXm//JbsnefO+H5ipYUU5FXGCW3w4ZRUOYDJ1NDRK96NepyP+2FRtskrO/L
 btdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGKBEGbDdwRBZjtML60Z/TC1fgqVhf1crUc8uJBV2uT63nKBl9T7B2PTnTLDrLHk2l4ZLftGmO@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyyI0Q1t14+jH+qKQugflDa4dhNYkYw+l7CzlQxBK3gQYbHnbM+
 QTd/+nxLWRPqNsqbV/KR9ri0E5VGZw5kkDHEk4CNXytMri82ieuqD+Cx
X-Gm-Gg: AY/fxX5IAwCEfo7jSP8lUhPrZKjmw3D4Y20nIQgsLL2C86K0ZbgswSoGsjg9jPuB9B1
 pi4I4ffWtfLhvsEfTCDt5WLM+fGly3lJ92tRbFUD+fFYgFME8TMOJX4KkS82eCCzX3m1XWADJ7h
 CFHRzsTp0QATdC2bGwLvcuBL/f/bz2Q3YUesJIQ+BN2OiV9gYkrmPZiBj1n7hzY1ol0h/fZbgom
 FslxBFUghtanIkWQDFCE6YFVMBX2Krl0EsnrX/QNcrymfGe//oX9QaCt58pLMvpG7upXdloZG1r
 WzwOpQG6Y1b2bVznhg2hN5Dn8iZfD7XV02PBZT6lh3TGHa8QRG04nPRITColP6Q6j0utfij8fPg
 ncMq6iwMWVjWbshFpTSvVKm+DX0fqdJgrVaRxp6qshCZIpE1ueauujMt9XwJOSx0MG27TxabR9M
 ORYdKTJ11RVAiwk2ZsnxKYd8rL1XGIbT//diivpM0RQ+JL8o0GJwU+NfZLZoHheg==
X-Google-Smtp-Source: AGHT+IFtCut35HMjFifxg7L5t/Pbn005/ktmA3HlwcWvREH16NYGHRExGDLh7PckZyKPgPc9irSTjw==
X-Received: by 2002:a05:7022:2586:b0:11b:9386:a3cf with SMTP id
 a92af1059eb24-12172312215mr2945203c88.48.1766144155767; 
 Fri, 19 Dec 2025 03:35:55 -0800 (PST)
Received: from titanite-d300.amd.com ([165.204.154.57])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1217254c734sm6857661c88.13.2025.12.19.03.35.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Dec 2025 03:35:55 -0800 (PST)
From: Mukesh Ogare <mukeshogare871@gmail.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch, amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Mukesh Ogare <mukeshogare871@gmail.com>
Subject: [PATCH] drm/radeon: convert VCE logging to drm_* helpers
Date: Fri, 19 Dec 2025 19:35:41 +0800
Message-ID: <20251219113541.1264030-1-mukeshogare871@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 19 Dec 2025 14:52:41 +0000
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

Replace legacy DRM_ERROR() and DRM_INFO() logging in the VCE code
with drm_err() and drm_info() helpers that take a struct drm_device.

Using drm_* logging provides proper device context in dmesg, which is
important for systems with multiple DRM devices, and aligns the radeon
driver with current DRM logging practices.

No functional change intended.

Signed-off-by: Mukesh Ogare <mukeshogare871@gmail.com>

diff --git a/Makefile b/Makefile
index 2f545ec1690f..e404e4767944 100644
--- a/Makefile
+++ b/Makefile
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
-PATCHLEVEL = 18
+PATCHLEVEL = 19
 SUBLEVEL = 0
-EXTRAVERSION =
+EXTRAVERSION = -rc1
 NAME = Baby Opossum Posse
 
 # *DOCUMENTATION*
diff --git a/drivers/gpu/drm/radeon/radeon_vce.c b/drivers/gpu/drm/radeon/radeon_vce.c
index bdbc1bbe8a9b..a203992cb932 100644
--- a/drivers/gpu/drm/radeon/radeon_vce.c
+++ b/drivers/gpu/drm/radeon/radeon_vce.c
@@ -121,7 +121,7 @@ int radeon_vce_init(struct radeon_device *rdev)
 	if (sscanf(c, "%2u]", &rdev->vce.fb_version) != 1)
 		return -EINVAL;
 
-	DRM_INFO("Found VCE firmware/feedback version %d.%d.%d / %d!\n",
+	drm_err(&rdev->ddev, "Found VCE firmware/feedback version %d.%d.%d / %d!\n",
 		 start, mid, end, rdev->vce.fb_version);
 
 	rdev->vce.fw_version = (start << 24) | (mid << 16) | (end << 8);
@@ -325,7 +325,7 @@ void radeon_vce_free_handles(struct radeon_device *rdev, struct drm_file *filp)
 		r = radeon_vce_get_destroy_msg(rdev, TN_RING_TYPE_VCE1_INDEX,
 					       handle, NULL);
 		if (r)
-			DRM_ERROR("Error destroying VCE handle (%d)!\n", r);
+			drm_err(&rdev->ddev, "Error destroying VCE handle (%d)!\n", r);
 
 		rdev->vce.filp[i] = NULL;
 		atomic_set(&rdev->vce.handles[i], 0);
@@ -352,7 +352,7 @@ int radeon_vce_get_create_msg(struct radeon_device *rdev, int ring,
 
 	r = radeon_ib_get(rdev, ring, &ib, NULL, ib_size_dw * 4);
 	if (r) {
-		DRM_ERROR("radeon: failed to get ib (%d).\n", r);
+		drm_err(&rdev->ddev, "radeon: failed to get ib (%d).\n", r);
 		return r;
 	}
 
@@ -388,7 +388,7 @@ int radeon_vce_get_create_msg(struct radeon_device *rdev, int ring,
 
 	r = radeon_ib_schedule(rdev, &ib, NULL, false);
 	if (r)
-		DRM_ERROR("radeon: failed to schedule ib (%d).\n", r);
+		drm_err(&rdev->ddev, "radeon: failed to schedule ib (%d).\n", r);
 
 
 	if (fence)
@@ -419,7 +419,7 @@ int radeon_vce_get_destroy_msg(struct radeon_device *rdev, int ring,
 
 	r = radeon_ib_get(rdev, ring, &ib, NULL, ib_size_dw * 4);
 	if (r) {
-		DRM_ERROR("radeon: failed to get ib (%d).\n", r);
+		drm_err(&rdev->ddev, "radeon: failed to get ib (%d).\n", r);
 		return r;
 	}
 
@@ -445,7 +445,7 @@ int radeon_vce_get_destroy_msg(struct radeon_device *rdev, int ring,
 
 	r = radeon_ib_schedule(rdev, &ib, NULL, false);
 	if (r) {
-		DRM_ERROR("radeon: failed to schedule ib (%d).\n", r);
+		drm_err(&rdev->ddev, "radeon: failed to schedule ib (%d).\n", r);
 	}
 
 	if (fence)
@@ -479,7 +479,7 @@ int radeon_vce_cs_reloc(struct radeon_cs_parser *p, int lo, int hi,
 	idx = radeon_get_ib_value(p, hi);
 
 	if (idx >= relocs_chunk->length_dw) {
-		DRM_ERROR("Relocs at %d after relocations chunk end %d !\n",
+		drm_err(&p->rdev->ddev, "Relocs at %d after relocations chunk end %d !\n",
 			  idx, relocs_chunk->length_dw);
 		return -EINVAL;
 	}
@@ -493,11 +493,11 @@ int radeon_vce_cs_reloc(struct radeon_cs_parser *p, int lo, int hi,
 	p->ib.ptr[hi] = start >> 32;
 
 	if (end <= start) {
-		DRM_ERROR("invalid reloc offset %llX!\n", offset);
+		drm_err(&p->rdev->ddev, "invalid reloc offset %llX!\n", offset);
 		return -EINVAL;
 	}
 	if ((end - start) < size) {
-		DRM_ERROR("buffer to small (%d / %d)!\n",
+		drm_err(&p->rdev->ddev, "buffer to small (%d / %d)!\n",
 			(unsigned)(end - start), size);
 		return -EINVAL;
 	}
@@ -526,7 +526,7 @@ static int radeon_vce_validate_handle(struct radeon_cs_parser *p,
 	for (i = 0; i < RADEON_MAX_VCE_HANDLES; ++i) {
 		if (atomic_read(&p->rdev->vce.handles[i]) == handle) {
 			if (p->rdev->vce.filp[i] != p->filp) {
-				DRM_ERROR("VCE handle collision detected!\n");
+				drm_err(&p->rdev->ddev, "VCE handle collision detected!\n");
 				return -EINVAL;
 			}
 			return i;
@@ -543,7 +543,7 @@ static int radeon_vce_validate_handle(struct radeon_cs_parser *p,
 		}
 	}
 
-	DRM_ERROR("No more free VCE handles!\n");
+	drm_err(&p->rdev->ddev, "No more free VCE handles!\n");
 	return -EINVAL;
 }
 
@@ -566,13 +566,13 @@ int radeon_vce_cs_parse(struct radeon_cs_parser *p)
 		uint32_t cmd = radeon_get_ib_value(p, p->idx + 1);
 
 		if ((len < 8) || (len & 3)) {
-			DRM_ERROR("invalid VCE command length (%d)!\n", len);
+			drm_err(&p->rdev->ddev, "invalid VCE command length (%d)!\n", len);
 			r = -EINVAL;
 			goto out;
 		}
 
 		if (destroyed) {
-			DRM_ERROR("No other command allowed after destroy!\n");
+			drm_err(&p->rdev->ddev, "No other command allowed after destroy!\n");
 			r = -EINVAL;
 			goto out;
 		}
@@ -593,7 +593,7 @@ int radeon_vce_cs_parse(struct radeon_cs_parser *p)
 		case 0x01000001: // create
 			created = true;
 			if (!allocated) {
-				DRM_ERROR("Handle already in use!\n");
+				drm_err(&p->rdev->ddev, "Handle already in use!\n");
 				r = -EINVAL;
 				goto out;
 			}
@@ -650,13 +650,13 @@ int radeon_vce_cs_parse(struct radeon_cs_parser *p)
 			break;
 
 		default:
-			DRM_ERROR("invalid VCE command (0x%x)!\n", cmd);
+			drm_err(&p->rdev->ddev, "invalid VCE command (0x%x)!\n", cmd);
 			r = -EINVAL;
 			goto out;
 		}
 
 		if (session_idx == -1) {
-			DRM_ERROR("no session command at start of IB\n");
+			drm_err(&p->rdev->ddev, "no session command at start of IB\n");
 			r = -EINVAL;
 			goto out;
 		}
@@ -665,7 +665,7 @@ int radeon_vce_cs_parse(struct radeon_cs_parser *p)
 	}
 
 	if (allocated && !created) {
-		DRM_ERROR("New session without create command!\n");
+		drm_err(&p->rdev->ddev, "New session without create command!\n");
 		r = -ENOENT;
 	}
 
@@ -760,7 +760,7 @@ int radeon_vce_ring_test(struct radeon_device *rdev, struct radeon_ring *ring)
 
 	r = radeon_ring_lock(rdev, ring, 16);
 	if (r) {
-		DRM_ERROR("radeon: vce failed to lock ring %d (%d).\n",
+		drm_err(&rdev->ddev, "radeon: vce failed to lock ring %d (%d).\n",
 			  ring->idx, r);
 		return r;
 	}
@@ -774,10 +774,10 @@ int radeon_vce_ring_test(struct radeon_device *rdev, struct radeon_ring *ring)
 	}
 
 	if (i < rdev->usec_timeout) {
-		DRM_INFO("ring test on %d succeeded in %d usecs\n",
+		drm_info(&rdev->ddev, "ring test on %d succeeded in %d usecs\n",
 			 ring->idx, i);
 	} else {
-		DRM_ERROR("radeon: ring %d test failed\n",
+		drm_err(&rdev->ddev, "radeon: ring %d test failed\n",
 			 ring->idx);
 		r = -ETIMEDOUT;
 	}
@@ -799,25 +799,25 @@ int radeon_vce_ib_test(struct radeon_device *rdev, struct radeon_ring *ring)
 
 	r = radeon_vce_get_create_msg(rdev, ring->idx, 1, NULL);
 	if (r) {
-		DRM_ERROR("radeon: failed to get create msg (%d).\n", r);
+		drm_err(&rdev->ddev, "radeon: failed to get create msg (%d).\n", r);
 		goto error;
 	}
 
 	r = radeon_vce_get_destroy_msg(rdev, ring->idx, 1, &fence);
 	if (r) {
-		DRM_ERROR("radeon: failed to get destroy ib (%d).\n", r);
+		drm_err(&rdev->ddev, "radeon: failed to get destroy ib (%d).\n", r);
 		goto error;
 	}
 
 	r = radeon_fence_wait_timeout(fence, false, usecs_to_jiffies(
 		RADEON_USEC_IB_TEST_TIMEOUT));
 	if (r < 0) {
-		DRM_ERROR("radeon: fence wait failed (%d).\n", r);
+		drm_err(&rdev->ddev, "radeon: fence wait failed (%d).\n", r);
 	} else if (r == 0) {
-		DRM_ERROR("radeon: fence wait timed out.\n");
+		drm_err(&rdev->ddev, "radeon: fence wait timed out.\n");
 		r = -ETIMEDOUT;
 	} else {
-		DRM_INFO("ib test on ring %d succeeded\n", ring->idx);
+		drm_info(&rdev->ddev, "ib test on ring %d succeeded\n", ring->idx);
 		r = 0;
 	}
 error:
-- 
2.43.0

