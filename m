Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCBA606A31B
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2026 08:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XBOOyAbX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1279110ECAE;
	Mon, 26 Oct 2026 08:43:52 +0000 (UTC)
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6D1110E680
 for <amd-gfx@lists.freedesktop.org>; Sun, 25 Oct 2026 04:03:43 +0000 (UTC)
Received: by mail-dl1-f41.google.com with SMTP id
 a92af1059eb24-1846bc43c28so2098584c88.0
 for <amd-gfx@lists.freedesktop.org>; Sat, 24 Oct 2026 21:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792901022; x=1793505822; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iig0z0KMkzGM7EBZYC3zYQ+uH8lNfEJyczCziU7pfIM=;
 b=XBOOyAbX+KSDCpWeBM5p55Wm1E0pPnWkG3s8yJOUQiG/2G/EE258rXDnxTyz7DDREP
 JHgKaSThpNZTBXBgg1vg9ZnV72Fas/hKOIW1KoQOz5kKUFrfl1FZp5SUgbg6/BOm0P1j
 juDCDPieONgIap+0JFe77Z2iP1PnoWEmbHK8PG+kn49gRkm3KPtQfLVtj9u2zir5TvoP
 JjjwkV3K4cCx8WBEoplx6cwZyF25OCLkEx2LD0G4tKpTs/g1GCwPZ2ltaphqJgGY77fl
 M8avXdIXINTa89J3yyVD7+n5N2RPG0E9Ijbl6pVi0SzFivgUywkPejpXb8WP/FvQH00f
 o4og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792901022; x=1793505822;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=iig0z0KMkzGM7EBZYC3zYQ+uH8lNfEJyczCziU7pfIM=;
 b=Jr1ieh3L3rZSODN82AVnFln0F/g5zx1W532/oCLD/HwNQOK9zuP3ZYXjqKRQ6PFqin
 sDjAZL6FFOGhi8NxxF0ptV+hDoX97cBnWm/IvlXhqlV9v93tXSLim6mwH/+SyOWAMj6U
 a3ZYJOoeIbMfxfOfSu8AiY4xhiPbLnKH8i0gmymj4N2b9C2aHGHrEKZ1HF1Rswz0fbyC
 UCRsUq1mH35att7pOLyeXP2n25dTGhUs3+2gwO/Ady83Bse/zUCI4SPpUeqR2zOtwsDn
 BcaIRJE/72cXm05KkJnYCvi0gI8LM++skUo7CNB6YrFkclE2UtydXBkL3xuQwMY4fQ8B
 eo1A==
X-Forwarded-Encrypted: i=1;
 AKwUvBxq0NPnOF6oP7PJnmTJIYmRKu6gdjtdcaOxE3hsKlGXX/UXVHnEnkgXO5FZ/1PMQxt9QMEPg21p@lists.freedesktop.org
X-Gm-Message-State: AFq9FYITomq5TKDUBq5ABh+Fa26njekPRkzQYYEbaez3ViFjzKakjeXb
 cCgY9lArgD1VEDqq6Bx1wVK5rIrp8tytbITWQpq7r+Qbn81BGIVvomg=
X-Gm-Gg: AYBFou1aC/iX5Q2avPflQr7WVfL7PtH8FYKCOcv8zshmDcKvuUg7ytJVk9VAfEFawTj
 G/RZ510jsdB2u4G4StMTs5iutoQiohGx5NxPpPjKRlUC0Tzt1sDG3RIYRJveILW5mV8hjXTjdk9
 H7nX0668q1JtMolziZs7wii+zkSoSDhVinJ+6LfpbosPkkAcnOMmJL7WmMQ9eywIJit9XDj+vws
 0yQhptlh/ObsoTuj/yLqt3kcrluZERIyXOZK80hJHTVYcIu9ngKbU5HM4Opf2tIWG218vxXIt99
 aXZ6bPyOX+CGmMnwQmyeVBl7/Lz8YxHWk9WI0oveIT5y6RllVkzZgRIO5mgyjKUQK2PHtlgFdFl
 FLlCNHsvVIqniZboSinKfHV18LZ76QHM0IxlWkiAb6LPqe1faBUeNtUiHcGuzYkHPsmAm5dEABb
 LDQdb7SibHQhduMhY4cm2U7HpYkN11XK9o8wFrr2QczdgtWAVybhuIFnbSxANyCCVyfeUgGj1Ev
 M7lyAU+S6PPwbMtO+SlO602bghV5Tmgn7ZMaBfJ44B76U1PVINcMePQNgt5bHouhEa13qPDp57q
 /O72tMQo5fvReXFy
X-Received: by 2002:a05:7022:7f12:b0:176:2095:1ac4 with SMTP id
 a92af1059eb24-19935be809dmr5230234c88.18.1792901022034; 
 Sat, 24 Oct 2026 21:03:42 -0700 (PDT)
Received: from at-Standard-PC-Q35-ICH9-2009 ([106.221.76.40])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-198a32ff780sm11635283c88.22.2026.10.24.21.03.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 21:03:41 -0700 (PDT)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: 
Cc: Andre Eikmeyer <dev@deq.rocks>, Bjorn Helgaas <bhelgaas@google.com>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
 "H. Peter Anvin" <hpa@zytor.com>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Kenneth Feng <kenneth.feng@amd.com>, Hans de Goede <hansg@kernel.org>,
 =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>,
 linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM),
 linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)), 
 amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
 dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
 platform-driver-x86@vger.kernel.org (open list:X86 PLATFORM DRIVERS)
Subject: [PATCH 10/13] drm/amdgpu: Catch register access while GMUX keeps the
 GPU off
Date: Sat, 24 Oct 2026 23:59:46 -0400
Message-ID: <20261025040046.1602-11-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261025040046.1602-1-atharvatiwarilinuxdev@gmail.com>
References: <20261025040046.1602-1-atharvatiwarilinuxdev@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 26 Oct 2026 08:43:34 +0000
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

From: Andre Eikmeyer <dev@deq.rocks>

As mentioned previous any access to the GPU when the GMUX has
shut off the rails results in a CPU CATTER, skip and report
any register access after the GPU was runtime suspended for GMUX power-off.

Signed-off-by: Andre Eikmeyer <dev@deq.rocks>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  5 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  5 ++++
 .../gpu/drm/amd/amdgpu/amdgpu_reg_access.c    | 24 +++++++++++++++++++
 4 files changed, 36 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 6fd607587..ac8dfc3ab 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -881,6 +881,8 @@ struct amdgpu_device {
 	/* enable runtime pm on the device */
 	bool                            in_runpm;
 	bool                            has_pr3;
+	/* GMUX has cut power, any register access would hang the PEG link */
+	bool                            gmux_off;
 
 	bool                            ucode_sysfs_en;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index c1f196242..8185934b4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -946,6 +946,11 @@ bool amdgpu_device_skip_hw_access(struct amdgpu_device *adev)
 	if (adev->no_hw_access)
 		return true;
 
+	if (unlikely(READ_ONCE(adev->gmux_off))) {
+		WARN_RATELIMIT(1, "%s: register access while powered off by GMUX\n",
+					dev_name(adev->dev));
+		return true;
+	}
 #ifdef CONFIG_LOCKDEP
 	/*
 	 * This is a bit complicated to understand, so worth a comment. What we assert
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 5ad7b6dd8..135798c76 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2932,6 +2932,9 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
 		amdgpu_device_baco_enter(adev);
 	}
 
+	if (adev->pm.rpm_mode == AMDGPU_RUNPM_GMUX)
+		WRITE_ONCE(adev->gmux_off, true);
+
 	dev_dbg(&pdev->dev, "asic/device is runtime suspended\n");
 
 	return 0;
@@ -2960,6 +2963,8 @@ static int amdgpu_pmops_runtime_resume(struct device *dev)
 	if (adev->pm.rpm_mode == AMDGPU_RUNPM_NONE)
 		return -EINVAL;
 
+	WRITE_ONCE(adev->gmux_off, false);
+
 	/* Avoids registers access if device is physically gone */
 	if (!pci_device_is_present(adev->pdev))
 		adev->no_hw_access = true;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c
index 7468855c1..bb5dbeb7f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c
@@ -594,6 +594,9 @@ u32 amdgpu_device_indirect_rreg(struct amdgpu_device *adev, u32 reg_addr)
 	void __iomem *pcie_data_offset;
 	u32 r;
 
+	if (amdgpu_device_skip_hw_access(adev))
+		return 0;
+
 	pcie_index = adev->nbio.funcs->get_pcie_index_offset(adev);
 	pcie_data = adev->nbio.funcs->get_pcie_data_offset(adev);
 
@@ -677,6 +680,12 @@ u64 amdgpu_device_indirect_rreg64(struct amdgpu_device *adev, u32 reg_addr)
 	void __iomem *pcie_data_offset;
 	u64 r;
 
+	if (amdgpu_device_skip_hw_access(adev))
+		return 0;
+
+	if (amdgpu_device_skip_hw_access(adev))
+		return 0;
+
 	pcie_index = adev->nbio.funcs->get_pcie_index_offset(adev);
 	pcie_data = adev->nbio.funcs->get_pcie_data_offset(adev);
 
@@ -706,6 +715,9 @@ u64 amdgpu_device_indirect_rreg64_ext(struct amdgpu_device *adev, u64 reg_addr)
 	void __iomem *pcie_data_offset;
 	u64 r;
 
+	if (amdgpu_device_skip_hw_access(adev))
+		return 0;
+
 	pcie_index = adev->nbio.funcs->get_pcie_index_offset(adev);
 	pcie_data = adev->nbio.funcs->get_pcie_data_offset(adev);
 	if ((reg_addr >> 32) && (adev->nbio.funcs->get_pcie_index_hi_offset))
@@ -762,6 +774,9 @@ void amdgpu_device_indirect_wreg(struct amdgpu_device *adev, u32 reg_addr,
 	void __iomem *pcie_index_offset;
 	void __iomem *pcie_data_offset;
 
+	if (amdgpu_device_skip_hw_access(adev))
+		return;
+
 	pcie_index = adev->nbio.funcs->get_pcie_index_offset(adev);
 	pcie_data = adev->nbio.funcs->get_pcie_data_offset(adev);
 
@@ -784,6 +799,9 @@ void amdgpu_device_indirect_wreg_ext(struct amdgpu_device *adev, u64 reg_addr,
 	void __iomem *pcie_index_hi_offset;
 	void __iomem *pcie_data_offset;
 
+	if (amdgpu_device_skip_hw_access(adev))
+		return;
+
 	pcie_index = adev->nbio.funcs->get_pcie_index_offset(adev);
 	pcie_data = adev->nbio.funcs->get_pcie_data_offset(adev);
 	if ((reg_addr >> 32) && (adev->nbio.funcs->get_pcie_index_hi_offset))
@@ -832,6 +850,9 @@ void amdgpu_device_indirect_wreg64(struct amdgpu_device *adev, u32 reg_addr,
 	void __iomem *pcie_index_offset;
 	void __iomem *pcie_data_offset;
 
+	if (amdgpu_device_skip_hw_access(adev))
+		return;
+
 	pcie_index = adev->nbio.funcs->get_pcie_index_offset(adev);
 	pcie_data = adev->nbio.funcs->get_pcie_data_offset(adev);
 
@@ -861,6 +882,9 @@ void amdgpu_device_indirect_wreg64_ext(struct amdgpu_device *adev, u64 reg_addr,
 	void __iomem *pcie_index_hi_offset;
 	void __iomem *pcie_data_offset;
 
+	if (amdgpu_device_skip_hw_access(adev))
+		return;
+
 	pcie_index = adev->nbio.funcs->get_pcie_index_offset(adev);
 	pcie_data = adev->nbio.funcs->get_pcie_data_offset(adev);
 	if ((reg_addr >> 32) && (adev->nbio.funcs->get_pcie_index_hi_offset))
-- 
2.55.0

