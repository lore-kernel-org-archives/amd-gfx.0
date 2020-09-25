Return-Path: <SRS0=B05q=DC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D16D7C4741F
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 20:11:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EFD82399A
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 20:11:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z2lsavU7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EFD82399A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E10D86ED69;
	Fri, 25 Sep 2020 20:11:29 +0000 (UTC)
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F230F6ED63
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2020 20:11:28 +0000 (UTC)
Received: by mail-qk1-x744.google.com with SMTP id g72so4095352qke.8
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2020 13:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QzB8UH+3uNTdbTt7Ns9UUyyi+Y70QRQe+FEDsBrXanU=;
 b=Z2lsavU7Idt5rGjx5H/gXDxufuOFGiI492Oiw9LMeaaTmzuGFYc0neSfiXnOTFjReE
 DlLWyqPeHIPuE84DhnAdFGNSdsNdcjp3dia0q14VYM+Dt6jZZWuSmcUyYp43h5tsOdZO
 36tZIQnQ7yjzR/zprLGv58LRjrapQcKPu2YrrBQmyv2WUqfsDGajcS/2HZvSNZgmMuJw
 AJ3k7DBlNJ4miUgP+TSknXcLu+xCMbPx5R0Hkj+h5xolawyrbiTwutV67zPGLTlsSt3i
 j2MXnfaW2CJUgJ9w351PsFa3AQCOBhiJngSm9xora6ZLgYTeiIpxNpWfXwWlQzMV7J7t
 EYjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QzB8UH+3uNTdbTt7Ns9UUyyi+Y70QRQe+FEDsBrXanU=;
 b=F63Rp3C4OhzOZpdQAFmhHPzxEuVwWUKp5F+z5+Eg925CICgWFDopQteAkV+g/V2gQg
 7p4+GFejR+5dQQ1QxDhalGRL6vt8befcMsNt3rolhD8f+rA1sKQXG0xE5G1ifuhYMyE6
 JzVzSjynTp+9/XDB6eRO3wl3oxJ9ZwjbldFxGuEg86AIDfOPeVGqARaGaABNY+pTjcz6
 XjSZL0mqVrOExU2maXw+gawJxpeBn7/Xy6LmZ7hGgwD1Yh9iXIizdTUSf4cHptWGiTZb
 Imgm4arbdinBhutX5XxrKV5+X004HhN0tWouq4ramRSOHvsORt1SDJj8RzLUNnKdd5J+
 4WQg==
X-Gm-Message-State: AOAM531lLhzi3rD9xjzH8Fm762GhAu+3YyVRihmB/gv2pU+YmbYMFgUX
 5RGwClFVMZul9UeIdQXVe2zdXFdmvXw=
X-Google-Smtp-Source: ABdhPJxQxqNGtWCuv3a4zmp6CQnVIA9LvAEWcTbS5X5pB5uppUJQnwyUBQ8yoUHwtKH5Xj0l4nGIbA==
X-Received: by 2002:a37:5cc2:: with SMTP id q185mr1638356qkb.35.1601064687770; 
 Fri, 25 Sep 2020 13:11:27 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id m67sm2301237qkf.98.2020.09.25.13.11.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 13:11:27 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 24/45] drm/amdgpu: add pcie port indirect read and write on nv
Date: Fri, 25 Sep 2020 16:10:08 -0400
Message-Id: <20200925201029.1738724-24-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200925201029.1738724-1-alexander.deucher@amd.com>
References: <20200925201029.1738724-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Huang Rui <ray.huang@amd.com>

This patch is to add pcie port indirect read/write callback for nv
series. They will be used for new asic.

Signed-off-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h |  2 ++
 drivers/gpu/drm/amd/amdgpu/nv.c          | 32 ++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
index edaac242ff85..483834a62436 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
@@ -53,6 +53,8 @@ struct amdgpu_nbio_funcs {
 	u32 (*get_hdp_flush_done_offset)(struct amdgpu_device *adev);
 	u32 (*get_pcie_index_offset)(struct amdgpu_device *adev);
 	u32 (*get_pcie_data_offset)(struct amdgpu_device *adev);
+	u32 (*get_pcie_port_index_offset)(struct amdgpu_device *adev);
+	u32 (*get_pcie_port_data_offset)(struct amdgpu_device *adev);
 	u32 (*get_rev_id)(struct amdgpu_device *adev);
 	void (*mc_access_enable)(struct amdgpu_device *adev, bool enable);
 	void (*hdp_flush)(struct amdgpu_device *adev, struct amdgpu_ring *ring);
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 2711c5661a97..5b3b70a64a79 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -118,6 +118,21 @@ static u64 nv_pcie_rreg64(struct amdgpu_device *adev, u32 reg)
 	return r;
 }
 
+static u32 nv_pcie_port_rreg(struct amdgpu_device *adev, u32 reg)
+{
+	unsigned long flags, address, data;
+	u32 r;
+	address = adev->nbio.funcs->get_pcie_port_index_offset(adev);
+	data = adev->nbio.funcs->get_pcie_port_data_offset(adev);
+
+	spin_lock_irqsave(&adev->pcie_idx_lock, flags);
+	WREG32(address, reg * 4);
+	(void)RREG32(address);
+	r = RREG32(data);
+	spin_unlock_irqrestore(&adev->pcie_idx_lock, flags);
+	return r;
+}
+
 static void nv_pcie_wreg64(struct amdgpu_device *adev, u32 reg, u64 v)
 {
 	unsigned long flags, address, data;
@@ -140,6 +155,21 @@ static void nv_pcie_wreg64(struct amdgpu_device *adev, u32 reg, u64 v)
 	spin_unlock_irqrestore(&adev->pcie_idx_lock, flags);
 }
 
+static void nv_pcie_port_wreg(struct amdgpu_device *adev, u32 reg, u32 v)
+{
+	unsigned long flags, address, data;
+
+	address = adev->nbio.funcs->get_pcie_port_index_offset(adev);
+	data = adev->nbio.funcs->get_pcie_port_data_offset(adev);
+
+	spin_lock_irqsave(&adev->pcie_idx_lock, flags);
+	WREG32(address, reg * 4);
+	(void)RREG32(address);
+	WREG32(data, v);
+	(void)RREG32(data);
+	spin_unlock_irqrestore(&adev->pcie_idx_lock, flags);
+}
+
 static u32 nv_didt_rreg(struct amdgpu_device *adev, u32 reg)
 {
 	unsigned long flags, address, data;
@@ -746,6 +776,8 @@ static int nv_common_early_init(void *handle)
 	adev->pcie_wreg = &nv_pcie_wreg;
 	adev->pcie_rreg64 = &nv_pcie_rreg64;
 	adev->pcie_wreg64 = &nv_pcie_wreg64;
+	adev->pciep_rreg = &nv_pcie_port_rreg;
+	adev->pciep_wreg = &nv_pcie_port_wreg;
 
 	/* TODO: will add them during VCN v2 implementation */
 	adev->uvd_ctx_rreg = NULL;
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
