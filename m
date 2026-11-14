Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D34606A329
	for <amd-gfx@archiver.kernel.org>; Sat, 14 Nov 2026 19:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mVrHBS+6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EB6610F0DC;
	Sat, 14 Nov 2026 19:11:08 +0000 (UTC)
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com
 [74.125.82.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A77010EC66
 for <amd-gfx@lists.freedesktop.org>; Sat, 14 Nov 2026 16:10:29 +0000 (UTC)
Received: by mail-dy1-f171.google.com with SMTP id
 5a478bee46e88-3704d30b84fso2581593eec.1
 for <amd-gfx@lists.freedesktop.org>; Sat, 14 Nov 2026 08:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794672628; x=1795277428; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sS1w6ypVXjVKbAJDNdl2VMNTbmFYN5LqfnAkQkSsnPU=;
 b=mVrHBS+63NLIa+Iqnw48LFBfcnC6VClCrIDXn386oAnvHMzkWlI4X36fC/kS5ETMOm
 xcq1L3jbzeVaFCM5urfbozTIWjsLB+GzWW4GUzgry4/XR4Xj3W5Hkv/jzbQDEtRNPzhb
 c9UOPb+DUOVf44qfSOOBF5BkMS9bhJsRA+VdkbVs17lWoxIIDmZxqsxToY2cl4V2I+VW
 D7vMFYJ89KrDo9UMOFGg+xvzcdg5or8nzQjmld+NT4jv5oA4BQe0Z5rKyGBZ2xaUBkcg
 vK9xQEejSFj2ckNEED3UE6Cv9qz3XoKffzSPu2XvkMdHatZVtpe9cwrn44cJgvhicLSG
 XvaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794672628; x=1795277428;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=sS1w6ypVXjVKbAJDNdl2VMNTbmFYN5LqfnAkQkSsnPU=;
 b=f7WT80fcbJ05xNjQLoF3PSpT+Zz1hbv2gLVU+LwGStlC0WmToMPNrGEBVKRKavRBhR
 ofHa1f+auPhp0sIJOaD5VoDIZkQKovxuBmOQnmpi6dxeCB+spvFOh8YgKZ0Ow/ChoqRe
 1tizDsQkmBNeGJEn189pi4T3aX0uSl+h5c/4E2nwi0eWpkRVTRVCu/TYsFL7LiMV9NnV
 rCIqawXMpCO24OVsf+ceR2uJyCkG7nOS7zjH4ouhuVURU1SZRfRXqa6YedDnVLtFwd4b
 F95Dx6/NizI/qyQslE59hTz2U7QsS3hyZGQKuoZFeMMF60xDdBOTJV2j2GojW37y7y+P
 TTXQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFj42Abhr/JVfiEkFdlh3Le4OFfOnzI2iXctnwZxE6fDGtb7nIhNloI4Drg37IY6XjMWqQDC1bw@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/DpuPDSdIVAcQ3wT5mvMjAQ6SPuog9z4JB1TzNrkCEgoI3R9KM
 NeefLrjBzqoddRpM6gVqamOogdoWQZZyqm9TbbeymHlqp2aY6ogQ37g=
X-Gm-Gg: AYBFou1LtZNfuXl/XS+5zd4Po71TiYTFJpISJV2Prvp7y6RXNm7Je1/sc6PJg6nQpCv
 U3Kpc4IrBs9XUOG6vS8zTNT4huQQSauO3oJS689icvLJIxQhKwzeePszlhlxkMoF4kw3QbNZj53
 Kg2WMCjgBzrsu9TOwoqO8fIDB151+VNv61Dx2jMA1hkTZSLNPCYfoIPgTa1TExTwphqTzSKAFyK
 kgzeWQVHYlXrTeQ+h70pegTLxFm8Effe591N+RP0oeVJ8g2mr0WmebNqkWLCMozP8HbuNQIUyIX
 dwhnVw6/hKEV4KenC7Uh++61VGjJSlzQsgPJdY5i5aaO6HMGmekUbI09apfcr7g94lebza31k2S
 gZD3oFMDtT7SNDWwbkiJhCRi13qsIQAOQd2Lnsue9/KfOxiPGbmA02Wc1iFbApc5xJ4Lo/2NheF
 rnZb3uj0kHWkWOLJfhIowp0Jyw+c4nrCj0r/Gs4DBQd6190VcY1Ex7/IRXCBri4tW3QhICmLpUw
 kKBmf52W4P8luKLE4ZnyRQdw80DyRWJZjpdtCmGlKK8nMxbIulDin03By4+OZq3QTHU784zxhRJ
 QWxEKw0FozK6P+NetEinWaDjnPzheGdKJ2QfxJGhtms1737iRZA=
X-Received: by 2002:a05:7301:d812:b0:373:d25b:8cf0 with SMTP id
 5a478bee46e88-379681cc558mr5747473eec.29.1794672627992; 
 Sat, 14 Nov 2026 08:10:27 -0800 (PST)
Received: from at-Standard-PC-Q35-ICH9-2009 ([106.202.127.108])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-37956bb0919sm17567582eec.29.2026.11.14.08.10.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 08:10:27 -0800 (PST)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: 
Cc: Andre Eikmeyer <dev@deq.rocks>, Sebastian Zygadlo <szgit@icloud.com>,
 Yossef Osman <yossef.osman@proton.me>,
 Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
 "H. Peter Anvin" <hpa@zytor.com>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Kenneth Feng <kenneth.feng@amd.com>, Hans de Goede <hansg@kernel.org>,
 =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM),
 linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)), 
 amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
 dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
 platform-driver-x86@vger.kernel.org (open list:X86 PLATFORM DRIVERS)
Subject: [PATCH v2 09/12] drm/amdgpu: Catch register access while GMUX keeps
 the GPU off
Date: Sat, 14 Nov 2026 11:06:33 -0500
Message-ID: <20261114160731.3756-10-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261114160731.3756-1-atharvatiwarilinuxdev@gmail.com>
References: <20261114160731.3756-1-atharvatiwarilinuxdev@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 14 Nov 2026 19:10:55 +0000
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
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

Tested-by: Sebastian Zygadlo <szgit@icloud.com>
Tested-by: Yossef Osman <yossef.osman@proton.me>
Signed-off-by: Andre Eikmeyer <dev@deq.rocks>
Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  5 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  5 ++++
 .../gpu/drm/amd/amdgpu/amdgpu_reg_access.c    | 24 +++++++++++++++++++
 4 files changed, 35 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 6fd607587..9938ae48f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -881,6 +881,7 @@ struct amdgpu_device {
 	/* enable runtime pm on the device */
 	bool                            in_runpm;
 	bool                            has_pr3;
+	bool                            runpm_active;
 
 	bool                            ucode_sysfs_en;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index ac336594b..ed205352f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -947,6 +947,10 @@ bool amdgpu_device_skip_hw_access(struct amdgpu_device *adev)
 	if (adev->no_hw_access)
 		return true;
 
+	if (unlikely(!READ_ONCE(adev->runpm_active))) {
+		WARN_RATELIMIT(1, "%s: register access while powered off\n", dev_name(adev->dev));
+		return true;
+	}
 #ifdef CONFIG_LOCKDEP
 	/*
 	 * This is a bit complicated to understand, so worth a comment. What we assert
@@ -2029,6 +2033,7 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 	int i, r;
 
 	amdgpu_device_enable_virtual_display(adev);
+	adev->runpm_active = true;
 
 	if (amdgpu_sriov_vf(adev)) {
 		/*
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 3978ed284..d1b0c6c73 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2935,6 +2935,9 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
 		amdgpu_device_baco_enter(adev);
 	}
 
+	if (adev->pm.rpm_mode == AMDGPU_RUNPM_GMUX)
+		WRITE_ONCE(adev->runpm_active, false);
+
 	dev_dbg(&pdev->dev, "asic/device is runtime suspended\n");
 
 	return 0;
@@ -2963,6 +2966,8 @@ static int amdgpu_pmops_runtime_resume(struct device *dev)
 	if (adev->pm.rpm_mode == AMDGPU_RUNPM_NONE)
 		return -EINVAL;
 
+	WRITE_ONCE(adev->runpm_active, true);
+
 	/* Avoids registers access if device is physically gone */
 	if (!pci_device_is_present(adev->pdev))
 		adev->no_hw_access = true;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c
index 7468855c1..64eba8a97 100644
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
 
@@ -617,6 +620,9 @@ u32 amdgpu_device_indirect_rreg_ext(struct amdgpu_device *adev, u64 reg_addr)
 	void __iomem *pcie_index_hi_offset;
 	void __iomem *pcie_data_offset;
 
+	if (amdgpu_device_skip_hw_access(adev))
+		return 0;
+
 	if (unlikely(!adev->nbio.funcs)) {
 		pcie_index = AMDGPU_PCIE_INDEX_FALLBACK;
 		pcie_data = AMDGPU_PCIE_DATA_FALLBACK;
@@ -677,6 +683,9 @@ u64 amdgpu_device_indirect_rreg64(struct amdgpu_device *adev, u32 reg_addr)
 	void __iomem *pcie_data_offset;
 	u64 r;
 
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

