Return-Path: <SRS0=+jgF=7O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D71DC433E1
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:21:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9F162073B
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:21:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PS4l+/bW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9F162073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F4366E2EA;
	Mon,  1 Jun 2020 18:21:21 +0000 (UTC)
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com
 [IPv6:2607:f8b0:4864:20::f42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 763F56E2F2
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:21:20 +0000 (UTC)
Received: by mail-qv1-xf42.google.com with SMTP id l3so484391qvo.7
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ajyYxbCKf2MLWhPUUsZFdWgGOfrO6nLmyxnTDXLwKBg=;
 b=PS4l+/bW3+Rk4Gcjcto0jEnEG4xEJvVlodlE8bkcOqCOui/M5Xt5AhtCHuk7BMIY+d
 cczhSFG4p4XQM8o3defcj8SPIl+MEpAvmvO1NS+UmHt1uUzctQNiAWvUG86WIg8DgcdQ
 t0/5f2Y80dvKbhso4NjYhvHi7phGb6CLuqpLLsXz3ytW1drvoO/++ZfthpLRi122HHlI
 gvB05UginASqOKLSQz3GYibxikbePF4blcFhlp6KWZA4aL180KZjygenS+s+GAfqRCTF
 JarM9SVmhJA3z8x/F9TQqKeuz38ufKIWyjVn0sJjl4lWqNxQjDsDTIYP85oAAqX1cXbu
 qICw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ajyYxbCKf2MLWhPUUsZFdWgGOfrO6nLmyxnTDXLwKBg=;
 b=LzXkhdJVSNq/N4YB9Galf4EkdIE8kesWHuwZ7ZySTeZylatEfZNLFSwRGd0honUghq
 3uzgeLNUQAXNMlCdoyBW9AcBwfJvyC4uh7LyPpnMEQ0OdCwNlJVW9AXmCMHFkgTEB9w1
 6GdFpSlGOqWkGt0Dr0UL62azVZgFsG6nflzumpvmJDj6E2h5bH9m7Ql9RyCvOzAaFO8l
 xJ/txS7IzasP3vuYwiCpUf2MxLC5n1LAGmxeDIfppROF3ZOhKZmExCWaF3nv/uYyTZ1W
 d7DD/emqQTHDGk5sy4russXFufODi6aPECabcpWORUFTUueA539IqSaTgU6VsfFn0FS1
 DblA==
X-Gm-Message-State: AOAM530gHVDLksmhGNvJmgBJ5LHEeIAbi2uTz+RiGy3T9R6EvV6fYXDt
 snbWPc03jBVYwgkgBiVV1c5V4YLx
X-Google-Smtp-Source: ABdhPJzcb3mo6+XCP7B1bsecDZRQWdd/UaPVBMdf1/tAJ5WjgESC+55q65IwyrmP3yrl+fnBwAoYKA==
X-Received: by 2002:a0c:e254:: with SMTP id x20mr20998489qvl.153.1591035679380; 
 Mon, 01 Jun 2020 11:21:19 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id w10sm106849qtc.15.2020.06.01.11.21.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:21:18 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 101/207] drm/amdgpu: switch to query reserved fb size from
 vbios (v3)
Date: Mon,  1 Jun 2020 14:19:08 -0400
Message-Id: <20200601182054.1267858-12-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200601182054.1267858-1-alexander.deucher@amd.com>
References: <20200601182054.1267858-1-alexander.deucher@amd.com>
MIME-Version: 1.0
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

For Sienna_Cichlid, query fw_reserved_fb_size from vbios directly.
For navi1x, fall back to default 64K TMR size.
For pre-navi, no need to reserve tmr region in top LFB.

v2: fix TMR define (Alex)
v3: partially revert size change

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 93d057f92dcd..b5e050b82172 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -58,6 +58,7 @@
 #include "amdgpu_amdkfd.h"
 #include "amdgpu_sdma.h"
 #include "amdgpu_ras.h"
+#include "amdgpu_atomfirmware.h"
 #include "bif/bif_4_1_d.h"
 
 #define AMDGPU_TTM_VRAM_MAX_DW_READ	(size_t)128
@@ -1961,13 +1962,23 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 	 * reserve TMR memory at the top of VRAM which holds
 	 * IP Discovery data and is protected by PSP.
 	 */
+	adev->discovery_tmr_size =
+		amdgpu_atomfirmware_get_fw_reserved_fb_size(adev);
+	if (!adev->discovery_tmr_size &&
+	    adev->asic_type >= CHIP_NAVI10 &&
+	    amdgpu_discovery) {
+		/* if fw_reserved_fb_size is 0 from vbios,
+		 * then fallback to the default tmr_size */
+		adev->discovery_tmr_size = DISCOVERY_TMR_SIZE;
+	}
+
 	if (adev->discovery_tmr_size > 0) {
 		r = amdgpu_bo_create_kernel_at(adev,
-			adev->gmc.real_vram_size - adev->discovery_tmr_size,
-			adev->discovery_tmr_size,
-			AMDGPU_GEM_DOMAIN_VRAM,
-			&adev->discovery_memory,
-			NULL);
+					adev->gmc.real_vram_size - adev->discovery_tmr_size,
+					adev->discovery_tmr_size,
+					AMDGPU_GEM_DOMAIN_VRAM,
+					&adev->discovery_memory,
+					NULL);
 		if (r)
 			return r;
 	}
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
