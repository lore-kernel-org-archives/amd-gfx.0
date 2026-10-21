Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26843606A327
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2026 13:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LjXYoBHC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCDAB10E2F4;
	Wed, 21 Oct 2026 13:09:29 +0000 (UTC)
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com
 [209.85.222.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE60410FDAB
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 11:41:56 +0000 (UTC)
Received: by mail-ua1-f51.google.com with SMTP id
 a1e0cc1a2514c-9906a5410f5so1241210241.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 04:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792582915; x=1793187715; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BzvnC7BX4lHpgCzhnJO5oI/EjW4Sy80MjAmOtqEc83U=;
 b=LjXYoBHCll9XcFOkn3r69yRnoguU1kbYyfx7WHevFx5MTlRdTNb2teJ9CsVAX6zBUX
 grxsSRg8JBnfXtSlpTbgrJ7sMfvyqzY48QYW0BtzicCmi5frgDQGkQiwNvstoHnaPmzv
 pZve5rIvwiqf434yio7jUyDkpbKNKXB2Fk3TWvKPX1x5LDi2KftLpxBf2j3DlcXMEF9x
 0CbHKs0sC39ktoSlAKwz8DAohfQvt8cltH4s7rjosJ67ABPj1vzvi/p2/KoeH5mEkZRA
 VAuXSKJxIPE0zTmRtj7KFLa4fDM1fV/Ce6bI6gPM4nktT31wlWNvzYpJfE7SAdFqO3rD
 S4ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792582915; x=1793187715;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=BzvnC7BX4lHpgCzhnJO5oI/EjW4Sy80MjAmOtqEc83U=;
 b=E41o/SkN/BM6X/5+wXNk7JHuvRGmLkzxRN8/PglaOXl/JjOGudHPRqcOKeBwE9GUwi
 EUHErFgUYfFuVG27Epi2fA5EHcaVzDzTIPtYr0gZW7v9UpiUUA93ZnSQffyDH0qkwkZy
 yO0oIJFt+wRizlSDugcRDtRiMPyOj2RlqUCR0TJeYWS/MkmSrlXie71dMPwwdw7f1KAA
 cOnnGsG8d/OhJ6k6eaffAC0L3aUmiU7cZhM0j/vXmhRvaRw8Kap2DRKaPZvys1t6n9/o
 eZ6yyC42gpkuZwTJnOdU6xJ4fCIrk0KZlUV/NQPJSidc4DSBUgh6kvSqRTiJrUAlsoUf
 0gmw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzLO+EZTnELtN8UnZSQlFjAsC/0wPsyWV0KIRzKzBJI6SGwE8LV6Upa/mKlAJVqk2B6teSYxSqz@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJuv5RSVRCVj5pxr5jJr4uAFpa6ntxr8b+/NUg0q3ZRI+mcXw2N
 Wa+kY+aytALUR7aTZXYDZqKLKJpld8rjzr0osstCbnUG/JV8F+DSUILx
X-Gm-Gg: AYBFou2VjX2qcP93vIGW62ke7IiKemUznCTaMxMjuAxXY2DFSDs0BPe58k6G4hXnHpk
 Lk++1RhGFCQtSheYXtWrPzhq0C5YB1j/Vq+KQ0alhD7ZxoBg08LntewAjn0t80DEH0GzZ/h3rWJ
 q3QnjNyY0bPx/e6CmSf/IBW8c2SY9pCgMSIwX8ngaI/796QEaL9/ZWhSI1mzWVqHaTi4tWBF7NV
 Ukt+JrEhX8YSkzHVJ7lL9u8yWjEcR14m19Q3Ly27su5Y6HgxfsY5TtCPj7N7CTT72rVfkRdWuSw
 oZ5je1DgE1t/KN/tzvPGxFoe+7lxkhsDFYYfZxYZf1w2cuPRt9guh3Z5Ry1R3x/ndOaSKRaHcPP
 ktG1rd7HOItZieFqDe4chTXUBeG6MP6bEpv28B26yGKhde54rD7jaZX9MpMOLl1m5jl94Ob1aws
 7p7MgLP9WLDK/6oRLUAnd3qUG8PAbyvzymqUGgEceKJgsS0oufassoZasSeshGjB+9hwcqUTOFN
 wJMvvfDpD4b3igz7d1c3WwLQmKW6FE9qDQL13eknFlwxU0EQr73GMUXkT6ClTfzmUCf9z86Oy5v
 SvqYr28tH/j7anZ+
X-Received: by 2002:a05:6102:21cd:b0:7ca:9674:a58f with SMTP id
 ada2fe7eead31-7cc7bcdf51amr931833137.32.1792582915474; 
 Wed, 21 Oct 2026 04:41:55 -0700 (PDT)
Received: from localhost.localdomain ([177.155.254.119])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-7cc91f9c7f1sm2365006137.0.2026.10.21.04.41.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 04:41:55 -0700 (PDT)
From: Matheus Tagliari <mptagliari@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Matheus Tagliari <mptagliari@gmail.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] drm/radeon: process the VCE interrupt on SI and Trinity
Date: Wed, 21 Oct 2026 08:41:17 -0300
Message-ID: <20261021114122.94008-2-mptagliari@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261021114122.94008-1-mptagliari@gmail.com>
References: <20261021114122.94008-1-mptagliari@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 21 Oct 2026 13:09:26 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

radeon_vce_fence_emit() ends every VCE fence with VCE_CMD_TRAP, which
raises the VCE trap interrupt (IH src_id 167).  cik_irq_process()
handles it by calling radeon_fence_process() for the matching VCE ring,
but si_irq_process() and evergreen_irq_process(), which serve the other
ASICs with VCE1 (SI and Trinity/Richland), have no case for it.

Add the same handling.  The trap interrupt is not enabled on these
ASICs yet, so this does not change behaviour on its own; the next patch
enables it.

The SI part was tested together with the next patch.  The Trinity part
mirrors the CIK and SI code and has not been tested on Trinity/Richland
hardware.

Fixes: a918efab631a ("drm/radeon: add VCE 1.0 support v4")
Cc: stable@vger.kernel.org
Signed-off-by: Matheus Tagliari <mptagliari@gmail.com>
---
 drivers/gpu/drm/radeon/evergreen.c | 14 ++++++++++++++
 drivers/gpu/drm/radeon/si.c        | 14 ++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/drivers/gpu/drm/radeon/evergreen.c b/drivers/gpu/drm/radeon/evergreen.c
index 3cbc6eedb..eb94916c8 100644
--- a/drivers/gpu/drm/radeon/evergreen.c
+++ b/drivers/gpu/drm/radeon/evergreen.c
@@ -4847,6 +4847,20 @@ int evergreen_irq_process(struct radeon_device *rdev)
 			drm_dbg(ddev, "IH: UVD int: 0x%08x\n", src_data);
 			radeon_fence_process(rdev, R600_RING_TYPE_UVD_INDEX);
 			break;
+		case 167: /* VCE */
+			drm_dbg(ddev, "IH: VCE int: 0x%08x\n", src_data);
+			switch (src_data) {
+			case 0:
+				radeon_fence_process(rdev, TN_RING_TYPE_VCE1_INDEX);
+				break;
+			case 1:
+				radeon_fence_process(rdev, TN_RING_TYPE_VCE2_INDEX);
+				break;
+			default:
+				drm_err(ddev, "Unhandled interrupt: %d %d\n", src_id, src_data);
+				break;
+			}
+			break;
 		case 146:
 		case 147:
 			addr = RREG32(VM_CONTEXT1_PROTECTION_FAULT_ADDR);
diff --git a/drivers/gpu/drm/radeon/si.c b/drivers/gpu/drm/radeon/si.c
index 4681ff286..af3c4026d 100644
--- a/drivers/gpu/drm/radeon/si.c
+++ b/drivers/gpu/drm/radeon/si.c
@@ -6347,6 +6347,20 @@ int si_irq_process(struct radeon_device *rdev)
 			DRM_DEBUG("IH: UVD int: 0x%08x\n", src_data);
 			radeon_fence_process(rdev, R600_RING_TYPE_UVD_INDEX);
 			break;
+		case 167: /* VCE */
+			DRM_DEBUG("IH: VCE int: 0x%08x\n", src_data);
+			switch (src_data) {
+			case 0:
+				radeon_fence_process(rdev, TN_RING_TYPE_VCE1_INDEX);
+				break;
+			case 1:
+				radeon_fence_process(rdev, TN_RING_TYPE_VCE2_INDEX);
+				break;
+			default:
+				DRM_ERROR("Unhandled interrupt: %d %d\n", src_id, src_data);
+				break;
+			}
+			break;
 		case 146:
 		case 147:
 			addr = RREG32(VM_CONTEXT1_PROTECTION_FAULT_ADDR);
-- 
2.47.3

