Return-Path: <SRS0=V/Q8=BI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E6E4C433E1
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jul 2020 17:34:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67C8D207F5
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jul 2020 17:34:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kpUFItnM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67C8D207F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DF386E5C1;
	Wed, 29 Jul 2020 17:34:56 +0000 (UTC)
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com
 [IPv6:2607:f8b0:4864:20::f44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C4BB6E5C0
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jul 2020 17:34:54 +0000 (UTC)
Received: by mail-qv1-xf44.google.com with SMTP id l13so4869805qvt.10
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jul 2020 10:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=DDymwZ64nOKQVp+UZ6s7IlleNOHqfxqgSwVWLOm7Yek=;
 b=kpUFItnMUIrrgPtTdrwzLfLK53UT1rrElg2Sxk4wBemQo4roj14x7t00T0lp20B8WZ
 CkqV1HLZk57QSPhcWq5oWPNgVxfpwIhH/b4rqosjcEjJLcmaqDPJmkwp6tSvnCEzO/Ph
 gngHcF1YBf5NZYVLPMSvxMx/Z7nhoJ69HtNpUFBNdBDzeVPj4JHgb5KQIWMkmOPYneGi
 UbhvCb9fl230UvpRkl0xKetV9qAWxzvzN0Sv0RiZb0PJNzZOXQisDnTKtq6qn7UoIDlC
 52Cv8d8VArxUe46WAGwwr5oXE3O03mdYaSJ6eDQrqUQIdsEL3OEO8pmOfxvlZMSaw4wZ
 BPfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DDymwZ64nOKQVp+UZ6s7IlleNOHqfxqgSwVWLOm7Yek=;
 b=exXDoZklOlxvCo8z+vUpJOagZlIMrkoXiJEUIX2iYigpsbPDUvFk/BLg04WVo2VDAR
 6VtT/tgcAjww1Vr6gplPIL7x+/NQ8TVXgfVwtyPG4W3XbkI4hpVFfckw7d+fduWFEwJR
 Ud/Hq6KlxvMswPZx7GXbJCVdMtctbiFr+NtanWqPGE16vLD90HvLl7AbaK/XlLZSvriC
 1FSd+4nXODWiG4j/hBFoPDlwIixPdmVgb9H2hlzzaHWOBQn0xrXQf8S1CniuVZfxo6h4
 9DA7VDaClyVW3FcGDX4nxVqLvDkVPzgLwGTgV5jeFTHW7/P2XN8AeurVWdm0QcFK714y
 Vauw==
X-Gm-Message-State: AOAM533c3PU28xhbpFBBwPHkUSGhGffXTHCNPZKkM3gERlQH/qf3z0Pc
 MMZF9i0SrVccIxERFLio8FNBMI0K
X-Google-Smtp-Source: ABdhPJw/Nq5o5oUVosdVviCUrP7VkvUkbA3Uis9JTnecmJU6xjhswq1DpZIkgu/dTUa/3dFeSQfhPg==
X-Received: by 2002:a0c:ea8e:: with SMTP id d14mr17677316qvp.37.1596044093467; 
 Wed, 29 Jul 2020 10:34:53 -0700 (PDT)
Received: from localhost.localdomain ([71.219.66.138])
 by smtp.gmail.com with ESMTPSA id z72sm2132956qka.107.2020.07.29.10.34.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2020 10:34:52 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 07/17] drm/amdgpu/gmc: add new helper to get the FB size used
 by pre-OS console
Date: Wed, 29 Jul 2020 13:34:29 -0400
Message-Id: <20200729173439.3698-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200729173439.3698-1-alexander.deucher@amd.com>
References: <20200729173439.3698-1-alexander.deucher@amd.com>
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
 Felix Kuehling <Felix.Kuehling@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This adds a new gmc callback to get the size reserved by the pre-OS
console and provides a helper function for use by gmc IP drivers.

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 43 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  5 +++
 2 files changed, 48 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 21d2c8543f85..fc9e18aaa76e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -27,6 +27,7 @@
 #include <linux/io-64-nonatomic-lo-hi.h>
 
 #include "amdgpu.h"
+#include "amdgpu_gmc.h"
 #include "amdgpu_ras.h"
 #include "amdgpu_xgmi.h"
 
@@ -431,3 +432,45 @@ void amdgpu_gmc_set_vm_fault_masks(struct amdgpu_device *adev, int hub_type,
 		WREG32(reg, tmp);
 	}
 }
+
+void amdgpu_gmc_get_vbios_allocations(struct amdgpu_device *adev)
+{
+	unsigned size;
+
+	/*
+	 * TODO:
+	 * Currently there is a bug where some memory client outside
+	 * of the driver writes to first 8M of VRAM on S3 resume,
+	 * this overrides GART which by default gets placed in first 8M and
+	 * causes VM_FAULTS once GTT is accessed.
+	 * Keep the stolen memory reservation until the while this is not solved.
+	 */
+	switch (adev->asic_type) {
+	case CHIP_VEGA10:
+	case CHIP_RAVEN:
+	case CHIP_ARCTURUS:
+	case CHIP_RENOIR:
+		adev->gmc.keep_stolen_vga_memory = true;
+		break;
+	default:
+		adev->gmc.keep_stolen_vga_memory = false;
+		break;
+	}
+
+	if (!amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_DCE))
+		size = 0;
+	else
+		size = amdgpu_gmc_get_vbios_fb_size(adev);
+
+	/* set to 0 if the pre-OS buffer uses up most of vram */
+	if ((adev->gmc.real_vram_size - size) < (8 * 1024 * 1024))
+		size = 0;
+
+	if (size > AMDGPU_VBIOS_VGA_ALLOCATION) {
+		adev->gmc.stolen_vga_size = AMDGPU_VBIOS_VGA_ALLOCATION;
+		adev->gmc.stolen_extended_size = size - adev->gmc.stolen_vga_size;
+	} else {
+		adev->gmc.stolen_vga_size = size;
+		adev->gmc.stolen_extended_size = 0;
+	}
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index 8f4af955d72c..c2a85d0b1546 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -131,6 +131,8 @@ struct amdgpu_gmc_funcs {
 	void (*get_vm_pte)(struct amdgpu_device *adev,
 			   struct amdgpu_bo_va_mapping *mapping,
 			   uint64_t *flags);
+	/* get the amount of memory used by the vbios for pre-OS console */
+	unsigned int (*get_vbios_fb_size)(struct amdgpu_device *adev);
 };
 
 struct amdgpu_xgmi {
@@ -253,6 +255,7 @@ struct amdgpu_gmc {
 #define amdgpu_gmc_map_mtype(adev, flags) (adev)->gmc.gmc_funcs->map_mtype((adev),(flags))
 #define amdgpu_gmc_get_vm_pde(adev, level, dst, flags) (adev)->gmc.gmc_funcs->get_vm_pde((adev), (level), (dst), (flags))
 #define amdgpu_gmc_get_vm_pte(adev, mapping, flags) (adev)->gmc.gmc_funcs->get_vm_pte((adev), (mapping), (flags))
+#define amdgpu_gmc_get_vbios_fb_size(adev) (adev)->gmc.gmc_funcs->get_vbios_fb_size((adev))
 
 /**
  * amdgpu_gmc_vram_full_visible - Check if full VRAM is visible through the BAR
@@ -307,4 +310,6 @@ extern void
 amdgpu_gmc_set_vm_fault_masks(struct amdgpu_device *adev, int hub_type,
 			      bool enable);
 
+void amdgpu_gmc_get_vbios_allocations(struct amdgpu_device *adev);
+
 #endif
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
