Return-Path: <SRS0=8rPh=AD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E07C433DF
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2020 22:12:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30D4620738
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2020 22:12:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gv1gATg3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30D4620738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C68D56E927;
	Mon, 22 Jun 2020 22:12:30 +0000 (UTC)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3CD86E927
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2020 22:12:29 +0000 (UTC)
Received: by mail-qk1-x742.google.com with SMTP id l17so17060976qki.9
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2020 15:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=efGDABAFw741FfexPsj08vWZnhg8ahbi8j4xIN0Duxg=;
 b=gv1gATg37JHyGCjuMYaqUWwQwhtuNj95jmVCl6EOljL+FoqHxjAJiFeQ5VcL5yJxEw
 rTa2TylEv3Bk9jNz9+DO1lWc2HvSHAufLIJJJHn3RTnz3pK/F3OACnyQnQxpTvNK7nyL
 duxMCX418vSuTgnDfsixxwfnu1Rr72XjpG2kvLZCKbv8qWgjbD9gerv1eeh39SpYfhJs
 5y/D8zNZLYvuEku2l8mdo0dLjNTZwUEwDxhk9lN7oWNJ35NZMNBLPJbgc6eLvM1XTult
 8V0bS0xhphwy2pON1yqtUn/kyyRMEEqjeHjBOLaRW5cpip08hNPLh11c9K8fAelOzh+E
 7bmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=efGDABAFw741FfexPsj08vWZnhg8ahbi8j4xIN0Duxg=;
 b=t16IwsLIEcOsE6r0QozTWW9HROT/WeVgIvoRf1lEjNcJV79Jyq1Ebp75bPEYCftYtN
 CmePKf5xvC8T7jpZB0rSCE8lTJTGInTmnOWkoWGnAiLo7OIh0Mj1+Gh6e01RtakwkZoa
 c/Ku4nJ6swrDjdSgMsIZetDMvAy1AsO+F66tit9UaX4uRLOd0OYaftjxhly0a3ExN/QP
 TiIBriC0ag5+iKbFMaF/zH1Zs0TVIazRvxkZgAna6d/bN1XAnbl33sWWoBB3cfw/0yS+
 oV35iFVHx/19kGXwMg+DnfbprOAu6If8LniwJZ0GCYfAHstCz3fVskx4RL8tNqJlL85i
 Xj8w==
X-Gm-Message-State: AOAM533qFXnwIklevxZb6yHi1qXDJFdupC2IiASZ02ST4YMTmZCzRPpk
 gRD0Z3vUxs8iQaBlG4HXdiaefW6C
X-Google-Smtp-Source: ABdhPJzUuj4uSk+cRtxhjbVWEF6BVW2wuOv6+uS5inpq449z/Mh638UHgKjcOOzbkWLnbPChePhSYQ==
X-Received: by 2002:a37:b341:: with SMTP id c62mr17455255qkf.128.1592863948665; 
 Mon, 22 Jun 2020 15:12:28 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id j24sm3309074qkl.79.2020.06.22.15.12.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2020 15:12:28 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/uvd3.x: fix register definition warnings
Date: Mon, 22 Jun 2020 18:12:19 -0400
Message-Id: <20200622221219.1046290-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

drop the duplicate register macros from sid.h and use the
standard ones in the oss register headers.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/si.c    |  1 +
 drivers/gpu/drm/amd/amdgpu/si_ih.c |  2 ++
 drivers/gpu/drm/amd/amdgpu/sid.h   | 19 -------------------
 3 files changed, 3 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
index cda9aa5e4b9e..9b12285177e3 100644
--- a/drivers/gpu/drm/amd/amdgpu/si.c
+++ b/drivers/gpu/drm/amd/amdgpu/si.c
@@ -45,6 +45,7 @@
 #include "dce_virtual.h"
 #include "gca/gfx_6_0_d.h"
 #include "oss/oss_1_0_d.h"
+#include "oss/oss_1_0_sh_mask.h"
 #include "gmc/gmc_6_0_d.h"
 #include "dce/dce_6_0_d.h"
 #include "uvd/uvd_4_0_d.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/si_ih.c b/drivers/gpu/drm/amd/amdgpu/si_ih.c
index 88ae27a5a03d..621727d7fd18 100644
--- a/drivers/gpu/drm/amd/amdgpu/si_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/si_ih.c
@@ -27,6 +27,8 @@
 #include "amdgpu_ih.h"
 #include "sid.h"
 #include "si_ih.h"
+#include "oss/oss_1_0_d.h"
+#include "oss/oss_1_0_sh_mask.h"
 
 static void si_ih_set_interrupt_funcs(struct amdgpu_device *adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sid.h b/drivers/gpu/drm/amd/amdgpu/sid.h
index 75b5d441b628..5f660f0c819f 100644
--- a/drivers/gpu/drm/amd/amdgpu/sid.h
+++ b/drivers/gpu/drm/amd/amdgpu/sid.h
@@ -2341,11 +2341,6 @@
 #       define NI_INPUT_GAMMA_XVYCC_222                3
 #       define NI_OVL_INPUT_GAMMA_MODE(x)              (((x) & 0x3) << 4)
 
-#define IH_RB_WPTR__RB_OVERFLOW_MASK	0x1
-#define IH_RB_CNTL__WPTR_OVERFLOW_CLEAR_MASK 0x80000000
-#define SRBM_STATUS__IH_BUSY_MASK	0x20000
-#define SRBM_SOFT_RESET__SOFT_RESET_IH_MASK	0x400
-
 #define	BLACKOUT_MODE_MASK			0x00000007
 #define	VGA_RENDER_CONTROL			0xC0
 #define R_000300_VGA_RENDER_CONTROL             0xC0
@@ -2432,18 +2427,6 @@
 #define MC_SEQ_MISC0__MT__HBM    0x60000000
 #define MC_SEQ_MISC0__MT__DDR3   0xB0000000
 
-#define SRBM_STATUS__MCB_BUSY_MASK 0x200
-#define SRBM_STATUS__MCB_BUSY__SHIFT 0x9
-#define SRBM_STATUS__MCB_NON_DISPLAY_BUSY_MASK 0x400
-#define SRBM_STATUS__MCB_NON_DISPLAY_BUSY__SHIFT 0xa
-#define SRBM_STATUS__MCC_BUSY_MASK 0x800
-#define SRBM_STATUS__MCC_BUSY__SHIFT 0xb
-#define SRBM_STATUS__MCD_BUSY_MASK 0x1000
-#define SRBM_STATUS__MCD_BUSY__SHIFT 0xc
-#define SRBM_STATUS__VMC_BUSY_MASK 0x100
-#define SRBM_STATUS__VMC_BUSY__SHIFT 0x8
-
-
 #define GRBM_STATUS__GUI_ACTIVE_MASK 0x80000000
 #define CP_INT_CNTL_RING__TIME_STAMP_INT_ENABLE_MASK 0x4000000
 #define CP_INT_CNTL_RING0__PRIV_REG_INT_ENABLE_MASK 0x800000
@@ -2468,8 +2451,6 @@
 
 #define PCIE_BUS_CLK    10000
 #define TCLK            (PCIE_BUS_CLK / 10)
-#define CC_DRM_ID_STRAPS__ATI_REV_ID_MASK		0xf0000000
-#define CC_DRM_ID_STRAPS__ATI_REV_ID__SHIFT 0x1c
 #define	PCIE_PORT_INDEX					0xe
 #define	PCIE_PORT_DATA					0xf
 #define EVERGREEN_PIF_PHY0_INDEX                        0x8
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
