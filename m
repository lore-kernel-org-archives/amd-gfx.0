Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 097E9E92FD7
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Dec 2025 22:04:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5D4310E738;
	Mon, 29 Dec 2025 22:04:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="e3XAcbPZ";
	dkim-atps=neutral
Received: from mail-yx1-f99.google.com (mail-yx1-f99.google.com
 [74.125.224.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 684B410E739
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Dec 2025 22:04:54 +0000 (UTC)
Received: by mail-yx1-f99.google.com with SMTP id
 956f58d0204a3-6446704997cso7490646d50.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Dec 2025 14:04:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767045893; x=1767650693;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VopAtg5cwECNDVQxgLsoKH79OtjRDL2VW4PpyQapOpE=;
 b=xDB8gd3R6r67HNCZheWHvJV1xen8ML/neGJ0AhPCb9DlaURKyj3DtGXOmG6QnDoQLg
 T6qBAnn8eeVGNsoO9ONIwDpS6BM3eHN0kif+M88y+WBFmn36NKl+ELJkkd1anxz9w4k2
 +rmGAO/vS3B+dmJz30mipF/aZoE/qEJOJhkOYGndVKAfY+9fUbJ1Kid10fX2sSe/Qgii
 /TedDJ2QwCINaYKq8AOiJF/pgCOdBGBOmaO5ig4pPJglDw38Dx1XOCD8ouz4u2OqUas2
 VfE1pTHS/9gF5MxDHDpCAAV/2EYbJNdNv6tFTkuGSi3eA5dxfETtdp1mDchbE+GsuwiA
 nbBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCURU8YKHLFblYMjr8xKhU3gALFaFZDZ4eKAth158m4Tyh/LVc++dA2P9iZ//9+uwlD7VmnwTO/w@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywtdhbh+7joAaGl3JBxJ2joqpsZPmfilUVBCwT543oH0WP2dAlN
 /KWLA/RunV9h86tE49B9i/I5y8WZTWP2fzynkdcpp5TzgRXVZc5OkOxJeGcvbL51ZBly4YL6V0M
 sb5emnyzb7yUGS8bAQ/byQr4pWG46DFGxUO8QKIJFcQ6lSb0CriKEfsqN775Z3RTPO6K293Cztx
 Tt/A2v38VkSooglemfYuK+hKxdt6zIDU1pVjf99XKPgR/MDA3reiEnAIAJWq+W9mkOFU7TiYozZ
 8VlSfd2jxiSHmUpaQ==
X-Gm-Gg: AY/fxX7RU9RTqO+fp3BFPP3+v3hJroOpjs1rJv9RKo5Ml3vvdo1mnz4wAei9AovD63B
 n/JaFWtWM+5udG0DaBYqIsbvk/r113ST1V86Pm7kXB2KRI2c0hpzw6RACZExnF2enrvYNZZSzb3
 HIhdxhJ40AQqFi1MrhYCbVtpXkOeHhvSGFV37vIyq85VsGMqrAea1lc1FTCS8jajfIQnTeM/889
 fXgkfaIabM1BMTs0U36sbYdex1OT9cvx+iALpEmAsffNO01RSIm+po4LLUXM7swSxd4GVlg5GgM
 9YXDGmQBBi2Bl1YksZ+821cSGaq7llDuUqGI2W6y3UG/lVzar5kZSCXtNNNderatZvK15eqdcyW
 LKHnvmPn7QpV2kYaCkvVfdMbwSimDzv3ueI1T8bLOyvPSIO3KB5/4sKWyC9J6xeWd9hMzY3qYGK
 VJTKmo4Rf5/Lad3JeIloVLaFbx7SFjnfkEqPrMQfhMJAtU
X-Google-Smtp-Source: AGHT+IFuJX6tyluxmKg9FmGIxTiSKUYeHEpyZb7Gttedmt2t7zxXrAetkXjMx+LsgKAG8y4o80dhRkwaoHGH
X-Received: by 2002:a05:690e:1904:b0:641:f5bc:699f with SMTP id
 956f58d0204a3-6466a8c0b8amr23694065d50.77.1767045893134; 
 Mon, 29 Dec 2025 14:04:53 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
 by smtp-relay.gmail.com with ESMTPS id
 00721157ae682-78fb43e8ae9sm14164547b3.8.2025.12.29.14.04.52
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 29 Dec 2025 14:04:53 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4f4a92bf359so213425071cf.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Dec 2025 14:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1767045892; x=1767650692;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VopAtg5cwECNDVQxgLsoKH79OtjRDL2VW4PpyQapOpE=;
 b=e3XAcbPZ3k+VF8stgcC115RARyqJaEObGrYXUzrxj0iU0dJfDhRR7rwrfe1s4Jtchd
 /AW527HhCUStohOK1Rf6DAOwNHQFLgwIEzOnjizZF0wzQwvwBEsZxgNbjGb2iMpoIspu
 9adohgofv0XoLwOfqgcqOBDXbrP6vnFyDYpCg=
X-Forwarded-Encrypted: i=1;
 AJvYcCUj6uFK8dNKLg4l63qr6tggBskg/298+j6BnXAbGyFyMrKIon8GDkN1IfYbvbNxWhd59vSBHZwp@lists.freedesktop.org
X-Received: by 2002:a05:6214:252a:b0:87c:2967:fd32 with SMTP id
 6a1803df08f44-88d8281226bmr511303426d6.22.1767045561925; 
 Mon, 29 Dec 2025 13:59:21 -0800 (PST)
X-Received: by 2002:a05:6214:252a:b0:87c:2967:fd32 with SMTP id
 6a1803df08f44-88d8281226bmr511303186d6.22.1767045561579; 
 Mon, 29 Dec 2025 13:59:21 -0800 (PST)
Received: from localhost.localdomain
 (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-88d9759f164sm231530026d6.24.2025.12.29.13.59.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Dec 2025 13:59:19 -0800 (PST)
From: Zack Rusin <zack.rusin@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Lijo Lazar <lijo.lazar@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>, Ce Sun <cesun102@amd.com>,
 "Mario Limonciello (AMD)" <superm1@kernel.org>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Vitaly Prosyak <vitaly.prosyak@amd.com>, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 04/12] drm/amdgpu: Use devm aperture helpers for sysfb restore
 on probe failure
Date: Mon, 29 Dec 2025 16:58:10 -0500
Message-ID: <20251229215906.3688205-5-zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251229215906.3688205-1-zack.rusin@broadcom.com>
References: <20251229215906.3688205-1-zack.rusin@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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

Use devm_aperture_remove_conflicting_pci_devices() instead of the
non-devm variant to automatically restore the system framebuffer
(efifb/simpledrm) if the driver's probe fails after removing the
firmware framebuffer.

Call devm_aperture_remove_conflicting_pci_devices_done() after
successful probe to cancel the automatic restore, as the driver
is now responsible for display output.

The aperture removal only applies to VGA and display class devices,
matching the existing behavior. This ensures users don't lose
display output if the amdgpu driver fails to probe after removing
the firmware framebuffer.

Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: Lijo Lazar <lijo.lazar@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Ce Sun <cesun102@amd.com>
Cc: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: "Timur Kristóf" <timur.kristof@gmail.com>
Cc: Vitaly Prosyak <vitaly.prosyak@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 9 +++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 7 +++++++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 58c3ffe707d1..6c867657225e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4737,8 +4737,13 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	 */
 	if ((pdev->class >> 8) == PCI_CLASS_DISPLAY_VGA ||
 	    (pdev->class >> 8) == PCI_CLASS_DISPLAY_OTHER) {
-		/* Get rid of things like offb */
-		r = aperture_remove_conflicting_pci_devices(adev->pdev, amdgpu_kms_driver.name);
+		/*
+		 * Get rid of things like offb. Use devm variant to
+		 * automatically restore sysfb if probe fails. This ensures
+		 * the user doesn't lose display if our probe fails after
+		 * removing the firmware framebuffer (efifb/simpledrm).
+		 */
+		r = devm_aperture_remove_conflicting_pci_devices(adev->pdev, amdgpu_kms_driver.name);
 		if (r)
 			return r;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 2dfbddcef9ab..fc2d2dbaebe8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -32,6 +32,7 @@
 #include <drm/drm_probe_helper.h>
 #include <drm/drm_vblank.h>
 
+#include <linux/aperture.h>
 #include <linux/cc_platform.h>
 #include <linux/dynamic_debug.h>
 #include <linux/module.h>
@@ -2528,6 +2529,12 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
 			amdgpu_get_secondary_funcs(adev);
 	}
 
+	/*
+	 * Probe succeeded - cancel the automatic sysfb restore action.
+	 * We're now responsible for display output.
+	 */
+	devm_aperture_remove_conflicting_pci_devices_done(pdev);
+
 	return 0;
 
 err_pci:
-- 
2.48.1

