Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AB47CDB474
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Oct 2023 13:10:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8898610E1DA;
	Mon, 23 Oct 2023 13:10:39 +0000 (UTC)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8FBF10E102
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Oct 2023 13:06:38 +0000 (UTC)
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-777754138bdso221846085a.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Oct 2023 06:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698066397; x=1698671197; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Uotvsa1EjZ2ndNuA93mYTR/FesXr2b/ZGkkiiDPj7Bc=;
 b=IPVAgAtayj+3x0aFFR1k6iWZc6ovMjEf1Avop8o/Hnln4+JDCsFMOY1SKq+iX3kBbd
 11RzJnXJjIICu9DdojjPb38GmMgkIbJf27uKy1L3PrJc7U+quNLCEi2CUoMEFHNNd17E
 2rxW+CZsYJ9xrTuOvGDT0gwmO3svD15si0MFgMEF26gTH7pnwPnxqKe12LTwRA5C8lD0
 zzwebi4jWOay34h7p5J6zbDzavEg2Ypa83JtAgG/mMdfRegrCPDI7wMU1K/I86sn2s99
 pP0dY5wlH/bUD0a2ZUsVawZC3QI7u6uU3BwUHZ/FciQw8/8TztWWkrj3CtI4b6mzpu7a
 7Wjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698066397; x=1698671197;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Uotvsa1EjZ2ndNuA93mYTR/FesXr2b/ZGkkiiDPj7Bc=;
 b=VrI3kPb8bteMDL9aDEfvVKSkZzNTFcCNMCx0PWdHHh8T3/TdNrBsL+BlzbJ7qMIpuQ
 MXJN3XsKn65qNvZQhV6cirlKwT6mvWosLOFgcXYLCylO00YPgEJIszgOeVSxWSBE7jQv
 IoXwuYDAwkqfd6d7WyXXk7qaRlEvoQaVgQsia1TXw5TLikl/fkRyP0rxIztm5iP4cEAy
 nkBkPrFkK5ongVevcJQ3vuJ6Ps6QKB2/t3V1VzrvOgnREPd7cdwlSKlqD/c3HrUTRzFq
 HAfwXmarn81/3/5uCBIhFYZ/IvnyapAW5i/0W9X87nvNHxymVbWiwsAOEd/esm15Vlcp
 wFJg==
X-Gm-Message-State: AOJu0YxU4m/jVIPKitOwhuwJx6p6Mc/XPOYHaIbUbJ0Y6RqSEaslfr34
 Kb5ouc4UJwHRrqsFTgs8oonSHEMUTzfUA//x
X-Google-Smtp-Source: AGHT+IF87FfpZ9Z/GbH5/09ZExmd1tqBfvP/KOWolhHd9mEsPm9DbAeicvlDX8SJhYdyIsXIV6mBmw==
X-Received: by 2002:a05:620a:458d:b0:778:9824:4b6c with SMTP id
 bp13-20020a05620a458d00b0077898244b6cmr10227295qkb.16.1698066397173; 
 Mon, 23 Oct 2023 06:06:37 -0700 (PDT)
Received: from daniel-desktop2.localnet ([174.95.207.100])
 by smtp.gmail.com with ESMTPSA id
 o10-20020a05620a22ca00b0076cc4610d0asm2704410qki.85.2023.10.23.06.06.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 06:06:36 -0700 (PDT)
From: Daniel Tang <danielzgtg.opensource@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] Revert "drm/amdgpu: remove vm sanity check from
 amdgpu_vm_make_compute"
Date: Mon, 23 Oct 2023 09:06:34 -0400
Message-ID: <5984374.lOV4Wx5bFT@daniel-desktop2>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Mailman-Approved-At: Mon, 23 Oct 2023 13:10:26 +0000
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
Cc: Xiaogang Chen <xiaogang.chen@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

That commit causes the screen to freeze a few moments after running
clinfo on v6.6-rc7 and ROCm 5.6. Sometimes the rest of the computer
including ssh also freezes. On v6.5-rc1, it only results in a NULL pointer
deference message in dmesg and the process to become a zombie whose
unkillableness prevents shutdown without REISUB. Although llama.cpp and
hashcat were working in v6.2 and ROCm 5.6, broke, and are not fixed by
this revert, pytorch-rocm is now working with stability and without
whole-computer freezes caused by any accidental running of clinfo.

This reverts commit 1d7776cc148b9f2f3ebaf1181662ba695a29f639.

Closes: https://github.com/RadeonOpenCompute/ROCm/issues/2596
Signed-off-by: Daniel Tang <danielzgtg.opensource@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 82f25996ff5e..602f311ab766 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2243,16 +2243,16 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 	if (r)
 		return r;
 
+	/* Sanity checks */
+	if (!amdgpu_vm_pt_is_root_clean(adev, vm)) {
+		r = -EINVAL;
+		goto unreserve_bo;
+	}
+
 	/* Check if PD needs to be reinitialized and do it before
 	 * changing any other state, in case it fails.
 	 */
 	if (pte_support_ats != vm->pte_support_ats) {
-		/* Sanity checks */
-		if (!amdgpu_vm_pt_is_root_clean(adev, vm)) {
-			r = -EINVAL;
-			goto unreserve_bo;
-		}
-
 		vm->pte_support_ats = pte_support_ats;
 		r = amdgpu_vm_pt_clear(adev, vm, to_amdgpu_bo_vm(vm->root.bo),
 				       false);
--
2.40.1



