Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B22C1EFD20B
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Feb 2026 08:32:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 566F510E70F;
	Wed, 25 Feb 2026 08:32:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="B7MEhGR9";
	dkim-atps=neutral
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com
 [209.85.128.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7104010E66B
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Feb 2026 01:44:48 +0000 (UTC)
Received: by mail-yw1-f173.google.com with SMTP id
 00721157ae682-79853c0f5b9so19364507b3.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Feb 2026 17:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771983887; x=1772588687; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6Zk4C6UtJMJyPH9EQHsgjkzqaQp6RJoNMe6g8WK2O3A=;
 b=B7MEhGR9/h/uoqQ1RAQmcnJTfHVL3ONixdlcypP0TugZPkUlg3ZNl+yCYqygeLusEN
 S3MLgaj9lku800uxaO4nRP3KW9F+ArxfUFq2+LQiY6KHgeOk4vKjMPHI8pRGan8OjMcl
 RtFGk+Iyl18EMPAjMwHB1SNOcT0aTPfmpx06OzAnrawCHkXJB4xTaDRbEg2OWVWhvFTx
 sHmR9id0gA8yYeLsYRyWCGHaDQAWA1I3NJlRUll3pSk4CdwvD7aiC8m9aqSFsKCw3EsE
 +YxBfi6+dQ3iv2x39sXscNRWvDlHhqne7NSnOlu5ebG7UvynYtvvadAPRQ9lg71N7bQl
 KwUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771983887; x=1772588687;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6Zk4C6UtJMJyPH9EQHsgjkzqaQp6RJoNMe6g8WK2O3A=;
 b=tKKhtL911HjHjKHPdj2qELO7wBuINmaCRlSMLRNpmrl18lfmHROCBcNI5N/H4VXZ+z
 urBq6C6Ad6kTSHPOPxxXt550LvG0NCX0GPGXUchxQvDo0S5mu7ZJS6ulBS7VmHUm0L3k
 a1K59CY6wsc2NURAGwnSle2Q8CIRNZv5Pe6jrBNQFJtiSt694mt2MUruvbajpvIEW14w
 0C6b4kSIKCvsZZ4qPqci31lIW8B2H/Y3+EwhkQXhlzNhOlVUC4iD0Z0HxtX9Y0OZAnym
 ZMlihdXJCgU+GIC6lN9TkLvwOpmEHMHKYipSsn9GUDbJRoQj7P44iK+j1w7N0mUo2J97
 Xe5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJRd17Q2fNFFawdawcP48JFeG5vaOaMVJ8XoOg63Qkcy1/ZM/8eDo7Lwl5qILtchCDiMabddJR@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzKHQRXFeQad1ohFdWZn3fmc/JlDRaCro94VbNRxsIJh4b8F+x5
 r2foNdhBBJzry05YRaaJS0RsMUCF60IbkfC9rijCteTH7CMiS8542CVC
X-Gm-Gg: ATEYQzxZ40Vw8fpb1io3rkryg5HJM3T2VDYjG0HBF0xrNtS/9WsFE5VvlEvW9s7+bM1
 OOHVIEu9F4DIuhBuFaDwbz8FTgVBnFzA/CkpuZP3m2rXve1to0y445JhsCvSoEw4XGVvjOGM6U5
 poPQLAlCSmcxEzzEn8S7RSHdwedYVFz1dQbj9HZKNGZ90KVi1/zQyzt283QotsitTPHAvQUJoWD
 0dBrTbTxSSC4crfiwyorWRueNrsXd6khoGaEaxYHm1qIF9EEjmdKMkTYIkehKeOdV5H9rsI/aDo
 Wy8z1Hj7rI3MLPBLzUonNFncn7lSgQIXim7fiYcFkhpDrKLKA/CLmhvmSZKwTJvvoAG6WJ8aU+k
 AbOjZ+ptHxX8PWwYwpuFozheN9+vkJ/ZdoPj0IY0+c1FF7tfBO9ZXUwbJC5wcpRbsumpPhidyW4
 yhmxne6vkGGhhcljNGI2QER5u85xhVHuyuFhtzxQmLBgElRL9X2TAQvehWARzFypSJ5HIQfi84O
 rRljXw4Zegap+I4z4wN1OxRFB4CmXAKCIk=
X-Received: by 2002:a81:b80c:0:b0:795:294c:fd31 with SMTP id
 00721157ae682-798681c628emr4982557b3.38.1771983887323; 
 Tue, 24 Feb 2026 17:44:47 -0800 (PST)
Received: from tux ([2601:7c0:c37c:4c00::5c0b])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-7985937e56dsm16231057b3.38.2026.02.24.17.44.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 17:44:47 -0800 (PST)
From: Ethan Tidmore <ethantidmore06@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Lijo Lazar <lijo.lazar@amd.com>, Mario Limonciello <superm1@kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>, Ce Sun <cesun102@amd.com>,
 Yo-Jung Leo Lin <Leo.Lin@amd.com>, Jammy Zhou <Jammy.Zhou@amd.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Ethan Tidmore <ethantidmore06@gmail.com>
Subject: [PATCH] drm/amdgpu: Fix resource leaks
Date: Tue, 24 Feb 2026 19:44:25 -0600
Message-ID: <20260225014425.2474802-1-ethantidmore06@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 25 Feb 2026 08:31:40 +0000
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

There are multiple resource leaks due to ioremap() being used and
iounmap never being called in multiple possible error paths.

Change ioremap() to devm_ioremap() to fix all resource leaks at
once.

Detected by Smatch:
drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:4834 amdgpu_device_init() warn:
'adev->rmmio' from ioremap() not released on lines:
4539,4549,4563,4574,4592,4834.

Fixes: d38ceaf99ed01 ("drm/amdgpu: add core driver (v4)")
Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 0acddcb04730..5cb58bed64ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4520,7 +4520,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	for (i = 0; i < AMD_IP_BLOCK_TYPE_NUM; i++)
 		atomic_set(&adev->pm.pwr_state[i], POWER_STATE_UNKNOWN);
 
-	adev->rmmio = ioremap(adev->rmmio_base, adev->rmmio_size);
+	adev->rmmio = devm_ioremap(adev->dev, adev->rmmio_base, adev->rmmio_size);
 	if (!adev->rmmio)
 		return -ENOMEM;
 
@@ -4843,8 +4843,6 @@ static void amdgpu_device_unmap_mmio(struct amdgpu_device *adev)
 	/* Unmap all mapped bars - Doorbell, registers and VRAM */
 	amdgpu_doorbell_fini(adev);
 
-	iounmap(adev->rmmio);
-	adev->rmmio = NULL;
 	if (adev->mman.aper_base_kaddr)
 		iounmap(adev->mman.aper_base_kaddr);
 	adev->mman.aper_base_kaddr = NULL;
@@ -4970,13 +4968,6 @@ void amdgpu_device_fini_sw(struct amdgpu_device *adev)
 	if ((adev->pdev->class >> 8) == PCI_CLASS_DISPLAY_VGA)
 		vga_client_unregister(adev->pdev);
 
-	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
-
-		iounmap(adev->rmmio);
-		adev->rmmio = NULL;
-		drm_dev_exit(idx);
-	}
-
 	if (IS_ENABLED(CONFIG_PERF_EVENTS))
 		amdgpu_pmu_fini(adev);
 	if (adev->discovery.bin)
-- 
2.53.0

