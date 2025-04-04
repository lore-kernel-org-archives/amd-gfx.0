Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59552C3601E
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Apr 2025 05:42:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E7E410E2EF;
	Fri,  4 Apr 2025 05:42:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GVNKfZ43";
	dkim-atps=neutral
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com
 [209.85.222.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48D7410E2EF
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Apr 2025 05:42:40 +0000 (UTC)
Received: by mail-qk1-f179.google.com with SMTP id
 af79cd13be357-7c5e39d1db2so97185885a.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 03 Apr 2025 22:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743745359; x=1744350159; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Uz90HOw/eluV/Zl57BedSpSKoIqREVHSLoH3imcDggc=;
 b=GVNKfZ437dtRTDM2V5JPYKxaGUjJJX5g7bbJK7VbC0xU3yWJPPvwnI42szQXzWkTP5
 XDlE3RuWkxeMSs5q5KjVts7wd3uokPmCJD40YF1V3oDQvGKZ+GdqSgnAqPteiKUIrng9
 Tm/v5g0M6yWKk8lKQHM/ZpB99d+ThB5C50JThseIjlSbwaGmQnuKd9oqcW8+8PxfSnWn
 Xm5qV2GHie2Th5C81YuhWmpPE3qHWQ9onk63mo8dabuWBHvkqX9SVnniWW+c6+ZCkJwg
 liasySDdSVeKj9STWvx7+EOgSK2cOItkyO8aHlByocRX1I683L3QqN92BzPbGHsk7urE
 gfVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743745359; x=1744350159;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Uz90HOw/eluV/Zl57BedSpSKoIqREVHSLoH3imcDggc=;
 b=tkzAZfJRunTqJ4uuhSHlsXUnjWWO44Y3i+Te19YMzoDGyXeFtDySbnQep/gbQRSuP2
 rl6kV59cBEapKrl6BTisPJajNqdYvTI/EvOA4srt+jY0tq8Agmgapc2f/7evpqsa9RTc
 cRFa7VqOQjG5nQ9H2tuExhG09X/DnHGgdixtP/pnwbAeIbnY1ign8tK1feNcUxzEv9bT
 fGE0aUCDzz4Mx9CsWkxZD8EnJDhGk4O3gifEXg35Lh6sJwcBm/Su2Cswj2A1wBtgjw9u
 hxXgSPfn4RhcAm96N6v+oFBJbbgvd9RD/sFwlmjaRZ7DXtK1lN350TZnZLkKhQdiF3et
 vpvQ==
X-Gm-Message-State: AOJu0Ywww9FqokcTji8MEMZK01o+DeNCrbTTKyARMaWF6bqs5pOnljAH
 6RvxmojAycyF/6V66jIHu2TGp0PEZa50EUIZOD3lqaAyFb3z6eDvQcKMhA==
X-Gm-Gg: ASbGncv1iv8ym2vhIfH+85NZvZoG1nAbR5WMyqnHT6wDc/t2FDgn9FTeWv8Lw1xZOEU
 rcucmOdsY7ZxY0bsv13xvESW3c7Ls66/yxE1YmycszOa/mNqzKZ8xUaButisaUrCGWa3lO+BXwa
 fo/lODTxbUHql5SDud2RI8V234AZ2E6bXoL9VCfxcitLdbQvkop4Za3A274gh/BCepicd01hEP0
 NauA2BuQCJ7HMcAoGG6H3UogXFuBwjRXvVQmWyBwMP5yVFxObDyqDaxBK9rMPK0xSXBdTJaGSkO
 FFSaJqQsL3Rol5Z1KFfNgaQm93/mwTcHWhpFY/46t0dcOh+3xPiCCrtcN57sLsqMOXKQ
X-Google-Smtp-Source: AGHT+IFoWQKFAHL93yobplY0e67LFogBvTKH8WCGzy/Pa/1KeVocY/WADrZLTzV0SGQG9E2uLKB7xQ==
X-Received: by 2002:a05:620a:372c:b0:7c5:a5a2:eea3 with SMTP id
 af79cd13be357-7c775a3a33bmr158023185a.34.1743745359081; 
 Thu, 03 Apr 2025 22:42:39 -0700 (PDT)
Received: from localhost.localdomain ([38.121.253.36])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c76e96e566sm171746385a.63.2025.04.03.22.42.38
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Apr 2025 22:42:38 -0700 (PDT)
From: Alexandre Demers <alexandre.f.demers@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu: fill in gmc_v6_0_set_clockgating_state()
Date: Fri,  4 Apr 2025 01:42:25 -0400
Message-ID: <20250404054225.101791-3-alexandre.f.demers@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250404054225.101791-1-alexandre.f.demers@gmail.com>
References: <20250404054225.101791-1-alexandre.f.demers@gmail.com>
MIME-Version: 1.0
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

Pretty much was already there, just not ported to amdgpu.

Tested-by: Alexandre Demers <alexandre.f.demers@gmail.com>
Signed-off-by: Alexandre Demers <alexandre.f.demers@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c | 44 +++++++++++++++++----------
 1 file changed, 28 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
index 2942fe8f80ec..6bfaf37464c2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
@@ -626,17 +626,16 @@ static void gmc_v6_0_vm_decode_fault(struct amdgpu_device *adev,
 	       "write" : "read", block, mc_client, mc_id);
 }
 
-/*
 static const u32 mc_cg_registers[] = {
-	MC_HUB_MISC_HUB_CG,
-	MC_HUB_MISC_SIP_CG,
-	MC_HUB_MISC_VM_CG,
-	MC_XPB_CLK_GAT,
-	ATC_MISC_CG,
-	MC_CITF_MISC_WR_CG,
-	MC_CITF_MISC_RD_CG,
-	MC_CITF_MISC_VM_CG,
-	VM_L2_CG,
+	mmMC_HUB_MISC_HUB_CG,
+	mmMC_HUB_MISC_SIP_CG,
+	mmMC_HUB_MISC_VM_CG,
+	mmMC_XPB_CLK_GAT,
+	mmATC_MISC_CG,
+	mmMC_CITF_MISC_WR_CG,
+	mmMC_CITF_MISC_RD_CG,
+	mmMC_CITF_MISC_VM_CG,
+	mmVM_L2_CG,
 };
 
 static const u32 mc_cg_ls_en[] = {
@@ -671,7 +670,7 @@ static void gmc_v6_0_enable_mc_ls(struct amdgpu_device *adev,
 
 	for (i = 0; i < ARRAY_SIZE(mc_cg_registers); i++) {
 		orig = data = RREG32(mc_cg_registers[i]);
-		if (enable && (adev->cg_flags & AMDGPU_CG_SUPPORT_MC_LS))
+		if (enable && (adev->cg_flags & AMD_CG_SUPPORT_MC_LS))
 			data |= mc_cg_ls_en[i];
 		else
 			data &= ~mc_cg_ls_en[i];
@@ -688,7 +687,7 @@ static void gmc_v6_0_enable_mc_mgcg(struct amdgpu_device *adev,
 
 	for (i = 0; i < ARRAY_SIZE(mc_cg_registers); i++) {
 		orig = data = RREG32(mc_cg_registers[i]);
-		if (enable && (adev->cg_flags & AMDGPU_CG_SUPPORT_MC_MGCG))
+		if (enable && (adev->cg_flags & AMD_CG_SUPPORT_MC_MGCG))
 			data |= mc_cg_en[i];
 		else
 			data &= ~mc_cg_en[i];
@@ -704,7 +703,7 @@ static void gmc_v6_0_enable_bif_mgls(struct amdgpu_device *adev,
 
 	orig = data = RREG32_PCIE(ixPCIE_CNTL2);
 
-	if (enable && (adev->cg_flags & AMDGPU_CG_SUPPORT_BIF_LS)) {
+	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_BIF_LS)) {
 		data = REG_SET_FIELD(data, PCIE_CNTL2, SLV_MEM_LS_EN, 1);
 		data = REG_SET_FIELD(data, PCIE_CNTL2, MST_MEM_LS_EN, 1);
 		data = REG_SET_FIELD(data, PCIE_CNTL2, REPLAY_MEM_LS_EN, 1);
@@ -727,7 +726,7 @@ static void gmc_v6_0_enable_hdp_mgcg(struct amdgpu_device *adev,
 
 	orig = data = RREG32(mmHDP_HOST_PATH_CNTL);
 
-	if (enable && (adev->cg_flags & AMDGPU_CG_SUPPORT_HDP_MGCG))
+	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_HDP_MGCG))
 		data = REG_SET_FIELD(data, HDP_HOST_PATH_CNTL, CLOCK_GATING_DIS, 0);
 	else
 		data = REG_SET_FIELD(data, HDP_HOST_PATH_CNTL, CLOCK_GATING_DIS, 1);
@@ -743,7 +742,7 @@ static void gmc_v6_0_enable_hdp_ls(struct amdgpu_device *adev,
 
 	orig = data = RREG32(mmHDP_MEM_POWER_LS);
 
-	if (enable && (adev->cg_flags & AMDGPU_CG_SUPPORT_HDP_LS))
+	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_HDP_LS))
 		data = REG_SET_FIELD(data, HDP_MEM_POWER_LS, LS_ENABLE, 1);
 	else
 		data = REG_SET_FIELD(data, HDP_MEM_POWER_LS, LS_ENABLE, 0);
@@ -751,7 +750,6 @@ static void gmc_v6_0_enable_hdp_ls(struct amdgpu_device *adev,
 	if (orig != data)
 		WREG32(mmHDP_MEM_POWER_LS, data);
 }
-*/
 
 static int gmc_v6_0_convert_vram_type(int mc_seq_vram_type)
 {
@@ -1097,6 +1095,20 @@ static int gmc_v6_0_process_interrupt(struct amdgpu_device *adev,
 static int gmc_v6_0_set_clockgating_state(void *handle,
 					  enum amd_clockgating_state state)
 {
+	bool gate = false;
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+
+	if (state == AMD_CG_STATE_GATE)
+		gate = true;
+
+	if (!(adev->flags & AMD_IS_APU)) {
+		gmc_v6_0_enable_mc_mgcg(adev, gate);
+		gmc_v6_0_enable_mc_ls(adev, gate);
+	}
+	gmc_v6_0_enable_bif_mgls(adev, gate);
+	gmc_v6_0_enable_hdp_mgcg(adev, gate);
+	gmc_v6_0_enable_hdp_ls(adev, gate);
+
 	return 0;
 }
 
-- 
2.49.0

