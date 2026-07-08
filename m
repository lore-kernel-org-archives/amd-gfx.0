Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CD45C43458
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2026 07:27:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E60C10F40F;
	Thu,  9 Jul 2026 07:26:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ky+fqACu";
	dkim-atps=neutral
Received: from mail-pj2-f1.google.com (mail-pj2-f1.google.com [74.125.227.129])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BC3A10E610
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jul 2026 16:30:46 +0000 (UTC)
Received: by mail-pj2-f1.google.com with SMTP id
 98e67ed59e1d1-3821a6fbcdbso921323a91.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 08 Jul 2026 09:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783528246; x=1784133046; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=HZ3tnpLmuxVn6RG46V9wPX6GdF132bX99ersePpQd08=;
 b=ky+fqACuNOzkciRdtmWZ0qGqoM/dpWTNN7NysmSRjQV+3a7NLPY0aa877xUySwRNBM
 jAb9Aj8lkZBlE2UC8THutURSjJZtDsgzRE1RCtpPQ/lDpdvv1RiGO1lOCnifiGdBpZ9s
 xiOWNzjnlYOrt70ao6/YjuNdFN6vdPjE58PRW3s+Z+rzYS030sk1PIuYh44ub9e7A/IX
 BeYjmyjp6cO+o5ucNrha7601USLj8VQGWVkvsCyUjBwlvrNGfGCnHk00zPymcJZQUBYb
 jo2PX0XsoFb/vxg20RQGzzSbyU13wWD8DtDHDM782O4hOOAJf90MJqyuRw8fGUrwwLrm
 RbZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783528246; x=1784133046;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HZ3tnpLmuxVn6RG46V9wPX6GdF132bX99ersePpQd08=;
 b=aiqL26sX5dXEI7NImlctH5Y6+Se/gwNUGOGVMixGWOA3QX1fyz1j1sNyRbG0dZll21
 CJUSUt+xlNX/uu0eNaoMb2jZMIktmpSmxDnqiXef6k8CfxRMorU7JTUjQDcvaDulVQB7
 Uyham5n9BN5VKshnqs5745DQsy/T/oD9H3/xySNS36MBAI3trjEAOE2V++8AEXE5iobh
 X1LzRAiWIIAnvFg1QJhKkGsgyLI/Uy8zL0BX9Jx5cifwe7G2yxUJkJg3oVg1LCphiy0+
 NJTS1nOfjsOiQ/VzUAZvApy81EcebZWhKfGaKkYz/Azm3cLSncU+DIAbSLwmo73DNF1M
 01lg==
X-Gm-Message-State: AOJu0YwcA1r47hKMyhp0vazeFKK/cn1K1v731hrSfG8qA01KOBGnm9Cd
 YyejBTUHJHjzf1F39KjywcVdRVnQryTYwSJ2B0WGaV41ylwWAWzORQgqQ66qFInn
X-Gm-Gg: AfdE7cmQrpTZuvJi42NBqOmDW9FbBOkOdEiHGys0vkuxq2Gbcy1Fmh7xWnRkVcFkdrQ
 3AjaSr2xe6v9/WwmTlrfBkOaWauPYc8x8qstesSG4qpMkIH+oD4ApfSd7EVdJNCou1MEqkTpyZ0
 16ocOFfAJd2Q8+e8sVQ/5P2mFH87ObS8c3AkLbLGZE0uJ7ctsfqsMlaSeGNrIJ3+8Tq7u5vhmyW
 Yjc1CnfNs0a/IaQ+yMPYilPi+gOLEvM9kskaHpx9eqtX5f92kG1qGQLCAdpTgDNW0jhAbAx+bLB
 9FAhz3qzVH6jywVcSi5+m57UH093Z575JAgoj1tfor+dyxOinf7hU6WqY0zWjwx7g6PVymjPG+0
 jZNkkkozhx92Up3iy+WAufgGuIkHTM9+VuGSCepS5rPphRv2cy7bzLROppZ4T+tq3JSMWrjWrOc
 Y5ESm0vhUgHGWO7eJyV61watq2gUmA67eSbu/tdbR/S5g=
X-Received: by 2002:a17:90b:2ccd:b0:381:528a:808a with SMTP id
 98e67ed59e1d1-38941cc5987mr3015296a91.27.1783528245829; 
 Wed, 08 Jul 2026 09:30:45 -0700 (PDT)
Received: from andrel-LOQ.semfio.usp.br (nat.ime.usp.br. [143.107.45.1])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3118ee6091dsm12654063eec.14.2026.07.08.09.30.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 09:30:45 -0700 (PDT)
From: Andre Luiz Batista Bueno <andrebueno.mac@gmail.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch
Cc: Andre Luiz Batista Bueno <andrebueno.mac@gmail.com>,
 Enzo Furegatti Spinella <enzo.spinella@usp.br>,
 dri-devel@lists.freedesktop.org
Subject: [PATCH V2] drm/amdgpu: deduplicate JPEG v5.0 interrupt routine
Date: Wed,  8 Jul 2026 13:28:50 -0300
Message-ID: <20260708163013.221986-1-andrebueno.mac@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 09 Jul 2026 07:26:29 +0000
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

Both jpeg_v5_0_1.c and jpeg_v5_0_2.c implement identical
interrupt processing routines. To avoid code duplication,
make the implementation in jpeg_v5_0_1.c non-static and
call it directly from jpeg_v5_0_2.c.

Signed-off-by: Andre Luiz Batista Bueno <andrebueno.mac@gmail.com>
Co-developed-by: Enzo Furegatti Spinella <enzo.spinella@usp.br>
Signed-off-by: Enzo Furegatti Spinella <enzo.spinella@usp.br>
---

v2:
 - Dropped the new jpeg_v5_0_interrupt.c/h files and Makefile changes.
 - Kept the interrupt routine in jpeg_v5_0_1.c but removed the 'static' modifier.
 - Declared the function prototype in jpeg_v5_0_1.h and included it in jpeg_v5_0_2.c to call it directly, as suggested by Alex Deucher.

 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.h |  8 +++
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c | 63 ++----------------------
 3 files changed, 12 insertions(+), 61 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
index edecbfe66c79..46bcbecd89e8 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
@@ -755,7 +755,7 @@ static int jpeg_v5_0_1_set_ras_interrupt_state(struct amdgpu_device *adev,
 
 
 
-static int jpeg_v5_0_1_process_interrupt(struct amdgpu_device *adev,
+int jpeg_v5_0_1_process_interrupt(struct amdgpu_device *adev,
 					 struct amdgpu_irq_src *source,
 					 struct amdgpu_iv_entry *entry)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.h b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.h
index a7e58d5fb246..67346faecb47 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.h
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.h
@@ -108,4 +108,12 @@ enum amdgpu_jpeg_v5_0_1_sub_block {
 	AMDGPU_JPEG_V5_0_1_MAX_SUB_BLOCK,
 };
 
+struct amdgpu_irq_src;
+struct amdgpu_iv_entry;
+struct amdgpu_device;
+
+int jpeg_v5_0_1_process_interrupt(struct amdgpu_device *adev,
+					struct amdgpu_irq_src *source,
+					struct amdgpu_iv_entry *entry);
+
 #endif /* __JPEG_V5_0_1_H__ */
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
index 285c459379c4..250e7f849037 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
@@ -34,6 +34,8 @@
 #include "vcn/vcn_5_0_0_sh_mask.h"
 #include "ivsrcid/vcn/irqsrcs_vcn_5_0.h"
 
+#include "jpeg_v5_0_1.h"
+
 static void jpeg_v5_0_2_set_dec_ring_funcs(struct amdgpu_device *adev);
 static void jpeg_v5_0_2_set_irq_funcs(struct amdgpu_device *adev);
 static int jpeg_v5_0_2_set_powergating_state(struct amdgpu_ip_block *ip_block,
@@ -583,65 +585,6 @@ static int jpeg_v5_0_2_set_interrupt_state(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int jpeg_v5_0_2_process_interrupt(struct amdgpu_device *adev,
-					 struct amdgpu_irq_src *source,
-					 struct amdgpu_iv_entry *entry)
-{
-	u32 i, inst;
-
-	i = node_id_to_phys_map[entry->node_id];
-	DRM_DEV_DEBUG(adev->dev, "IH: JPEG TRAP\n");
-
-	for (inst = 0; inst < adev->jpeg.num_jpeg_inst; ++inst)
-		if (adev->jpeg.inst[inst].aid_id == i)
-			break;
-
-	if (inst >= adev->jpeg.num_jpeg_inst) {
-		dev_WARN_ONCE(adev->dev, 1,
-			      "Interrupt received for unknown JPEG instance %d",
-			      entry->node_id);
-		return 0;
-	}
-
-	switch (entry->src_id) {
-	case VCN_5_0__SRCID__JPEG_DECODE:
-		amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[0]);
-		break;
-	case VCN_5_0__SRCID__JPEG1_DECODE:
-		amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[1]);
-		break;
-	case VCN_5_0__SRCID__JPEG2_DECODE:
-		amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[2]);
-		break;
-	case VCN_5_0__SRCID__JPEG3_DECODE:
-		amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[3]);
-		break;
-	case VCN_5_0__SRCID__JPEG4_DECODE:
-		amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[4]);
-		break;
-	case VCN_5_0__SRCID__JPEG5_DECODE:
-		amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[5]);
-		break;
-	case VCN_5_0__SRCID__JPEG6_DECODE:
-		amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[6]);
-		break;
-	case VCN_5_0__SRCID__JPEG7_DECODE:
-		amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[7]);
-		break;
-	case VCN_5_0__SRCID__JPEG8_DECODE:
-		amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[8]);
-		break;
-	case VCN_5_0__SRCID__JPEG9_DECODE:
-		amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[9]);
-		break;
-	default:
-		DRM_DEV_ERROR(adev->dev, "Unhandled interrupt: %d %d\n",
-			      entry->src_id, entry->src_data[0]);
-		break;
-	}
-
-	return 0;
-}
 
 static void jpeg_v5_0_2_core_stall_reset(struct amdgpu_ring *ring)
 {
@@ -749,7 +692,7 @@ static void jpeg_v5_0_2_set_dec_ring_funcs(struct amdgpu_device *adev)
 
 static const struct amdgpu_irq_src_funcs jpeg_v5_0_2_irq_funcs = {
 	.set = jpeg_v5_0_2_set_interrupt_state,
-	.process = jpeg_v5_0_2_process_interrupt,
+	.process = jpeg_v5_0_1_process_interrupt,
 };
 
 static void jpeg_v5_0_2_set_irq_funcs(struct amdgpu_device *adev)
-- 
2.43.0

