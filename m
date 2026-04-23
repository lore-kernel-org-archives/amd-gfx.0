Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43C7BFAD3E5
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2026 01:16:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDDE710EAC0;
	Thu, 23 Apr 2026 01:16:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="A8iHWjH4";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B40110EACF
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2026 01:16:28 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-488d2079582so71373455e9.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2026 18:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776906986; x=1777511786; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MY/zFyfOHN/H5yYosIfwq1Me/nRVpVNU1LMXsn5rPtk=;
 b=A8iHWjH4+bQq3W9efo0DKP/8K7kRbPSuQsCD0zzGYQZeV33xINebqUKU2gVSTZ8u6k
 kp0IucjSw08ZDnNP0XFqgMQGUzp2BrvRpCEYcbxk/TrBX09OGuT9bncriA9GMMo/GZak
 +x/5oU5TexS7LVMR/x1JaGbboBuX37ewv8zMulM4o9xFG9QU0iPHZQcXAOBloRnv25GO
 d3ZU4QqdYpCvU5ovIxPN/yjTW7u+eucSJJSN8urONLgD7TTjjYNO/MGmeadhMbIKOL+E
 1BNAhAZWrs1sonKptgsc9Fgi3dtOilvESvjXY6EtalctPDGmHOHZkrR474gDDyIkzPcm
 NujQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776906986; x=1777511786;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MY/zFyfOHN/H5yYosIfwq1Me/nRVpVNU1LMXsn5rPtk=;
 b=NRPJy6JLIMVZWXVyUU3aRAFwgmv+RQCpNKJI+NR97Mz09JRu85ffAcYytjVxe66mqI
 HD2bNrev/LIb36zRafMHlKyCGYrVTIPijP10H/ywA7HNjxi6S0af/0FUD5eLExRccAnJ
 05kTr61zC9kYZslY8TCKC8MZb4gg8DCedXX5lyajjo2EYcSXdjpalFP+TxkJObHY6reE
 ex7J4COVGLtIsEUfnTg5DMgOTg1SJgmVhqMjMm8bzTtf86XuJaEaa5uhfed8LSlpa1gE
 nsYwnFYIYZUjqa8ELPstkWyGC7aHtSl88vYgCDHgGyd45Cc08hBgQhPOR5wxC9+yY3k4
 IF2Q==
X-Gm-Message-State: AOJu0Yzr2A511Sk+o9851FTc/0qYsErGaI3rVLquiaPy54qrrgisvwwH
 bWEXtZPkTVdkoy37tURspDD8bzOYGORUeCLroSZhbgdkm/x/N3Zsg1MMq/jFjw==
X-Gm-Gg: AeBDievw/3n6ybtyd2X96ch2CtriLjMt6OdwsEVtz+YBlJ5nhR+x1u0l2go3rKDKdpg
 lRqa26UQE7dS3Qcr26NlSBuIaiRRytClIQcz+SUAKRXyq+yjUZ4lSsWDC3dK108ddmLzPOOvowI
 6NkiW/DuXC1v0KTyGGL3EphzTVlGJe0xp1amPWheRJMHCAjc2hhWJnxEEdCf91HhPPl+NYtcZyi
 qzfaQl5BW50DycbpCwP6nryBI/baDjYXmSsxrUPXVu4/p8hBlKFa1c1JdpIep0FDewoRS/ypZ9P
 MFM/rNXyH8p7BMY28+Q4R3/k4BR9bY9JUeBP+XIAXPRbkK4QfsuV+37VcqkJr2ON6YIis9JYrk+
 1v6tFRLIT+xh721mw50ZDxd6zqRdonq679oKc6PRG1bYokdmHww394Md8Pwye3erS57ROVc0kfX
 ruxtbSWJExHtlzo8xQq6bCEofbZ4U76giEUMKZK4p8jqR3B+LAvnE0r/VAeZEoLOjP6wY4TnBie
 eealg==
X-Received: by 2002:a05:600c:4fd1:b0:488:78f2:6b0 with SMTP id
 5b1f17b1804b1-488fb78ede0mr356468345e9.29.1776906986425; 
 Wed, 22 Apr 2026 18:16:26 -0700 (PDT)
Received: from Timur-Hyperion.home (5E1B98A2.dsl.pool.telekom.hu.
 [94.27.152.162]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a4b329542sm370664435e9.3.2026.04.22.18.16.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 18:16:25 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 christian.koenig@amd.com, John Olender <john.olender@gmail.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 08/11] drm/amdgpu/vce: Check maximum ucode size in
 amdgpu_vce_resume()
Date: Thu, 23 Apr 2026 03:16:11 +0200
Message-ID: <20260423011614.309180-9-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423011614.309180-1-timur.kristof@gmail.com>
References: <20260423011614.309180-1-timur.kristof@gmail.com>
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

Verify that the ucode fits the part of the BO that is
specifically meant for it to avoid overflowing it.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c | 5 ++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h | 2 +-
 drivers/gpu/drm/amd/amdgpu/vce_v2_0.c   | 4 ++--
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c   | 4 ++--
 drivers/gpu/drm/amd/amdgpu/vce_v4_0.c   | 4 ++--
 5 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
index efdebd9c0a1f3..8c620254f0374 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
@@ -324,7 +324,7 @@ int amdgpu_vce_suspend(struct amdgpu_device *adev)
  * @adev: amdgpu_device pointer
  *
  */
-int amdgpu_vce_resume(struct amdgpu_device *adev)
+int amdgpu_vce_resume(struct amdgpu_device *adev, const unsigned long max_size)
 {
 	const struct common_firmware_header *hdr;
 	unsigned int offset;
@@ -336,6 +336,9 @@ int amdgpu_vce_resume(struct amdgpu_device *adev)
 	hdr = (const struct common_firmware_header *)adev->vce.fw->data;
 	offset = le32_to_cpu(hdr->ucode_array_offset_bytes);
 
+	if (adev->vce.fw->size - offset > max_size)
+		return -EINVAL;
+
 	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
 		memset_io(adev->vce.cpu_addr, 0, amdgpu_bo_size(adev->vce.vcpu_bo));
 		memcpy_toio(adev->vce.cpu_addr, adev->vce.fw->data + offset,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h
index 778c714c8385d..a57e2f6f5f930 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h
@@ -60,7 +60,7 @@ int amdgpu_vce_sw_init(struct amdgpu_device *adev, unsigned long size);
 int amdgpu_vce_sw_fini(struct amdgpu_device *adev);
 int amdgpu_vce_entity_init(struct amdgpu_device *adev, struct amdgpu_ring *ring);
 int amdgpu_vce_suspend(struct amdgpu_device *adev);
-int amdgpu_vce_resume(struct amdgpu_device *adev);
+int amdgpu_vce_resume(struct amdgpu_device *adev, const unsigned long max_size);
 void amdgpu_vce_free_handles(struct amdgpu_device *adev, struct drm_file *filp);
 int amdgpu_vce_ring_parse_cs(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
 			     struct amdgpu_ib *ib);
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
index db149eda62044..00b4037d4bc89 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
@@ -437,7 +437,7 @@ static int vce_v2_0_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	r = amdgpu_vce_resume(adev);
+	r = amdgpu_vce_resume(adev, VCE_V2_0_FW_SIZE);
 	if (r)
 		return r;
 
@@ -533,7 +533,7 @@ static int vce_v2_0_resume(struct amdgpu_ip_block *ip_block)
 {
 	int r;
 
-	r = amdgpu_vce_resume(ip_block->adev);
+	r = amdgpu_vce_resume(ip_block->adev, VCE_V2_0_FW_SIZE);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
index 03d79e464f04f..2e97376ff30e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
@@ -440,7 +440,7 @@ static int vce_v3_0_sw_init(struct amdgpu_ip_block *ip_block)
 	if (adev->vce.fw_version < FW_52_8_3)
 		adev->vce.num_rings = 2;
 
-	r = amdgpu_vce_resume(adev);
+	r = amdgpu_vce_resume(adev, VCE_V3_0_FW_SIZE);
 	if (r)
 		return r;
 
@@ -544,7 +544,7 @@ static int vce_v3_0_resume(struct amdgpu_ip_block *ip_block)
 {
 	int r;
 
-	r = amdgpu_vce_resume(ip_block->adev);
+	r = amdgpu_vce_resume(ip_block->adev, VCE_V3_0_FW_SIZE);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
index ee445d8abe474..3309e7b8f2a2e 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
@@ -462,7 +462,7 @@ static int vce_v4_0_sw_init(struct amdgpu_ip_block *ip_block)
 			ALIGN(le32_to_cpu(hdr->ucode_size_bytes), PAGE_SIZE);
 		drm_info(adev_to_drm(adev), "PSP loading VCE firmware\n");
 	} else {
-		r = amdgpu_vce_resume(adev);
+		r = amdgpu_vce_resume(adev, VCE_V4_0_FW_SIZE);
 		if (r)
 			return r;
 	}
@@ -624,7 +624,7 @@ static int vce_v4_0_resume(struct amdgpu_ip_block *ip_block)
 			drm_dev_exit(idx);
 		}
 	} else {
-		r = amdgpu_vce_resume(adev);
+		r = amdgpu_vce_resume(adev, VCE_V4_0_FW_SIZE);
 		if (r)
 			return r;
 	}
-- 
2.53.0

