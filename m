Return-Path: <SRS0=nRto=KA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 127A7C433ED
	for <amd-gfx@archiver.kernel.org>; Wed,  5 May 2021 01:27:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F486613C4
	for <amd-gfx@archiver.kernel.org>; Wed,  5 May 2021 01:27:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F486613C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=basnieuwenhuizen.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A230F6E2B4;
	Wed,  5 May 2021 01:27:48 +0000 (UTC)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E13BC6E2B4
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 May 2021 01:27:47 +0000 (UTC)
Received: by mail-wr1-x433.google.com with SMTP id l2so13231wrm.9
 for <amd-gfx@lists.freedesktop.org>; Tue, 04 May 2021 18:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen.nl; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=HugnEq1lb7WCdz0HIeR2ZcLu0AgN9Exbt8YC0ehCyZc=;
 b=hYYhHmJnYVwUT7ecUQDu/iI3ch3/rbYvBuGnGfNVtagX6IhqH+JpAGTcY7RKihUg7I
 Gmdcaz6t2RPUMdSuKsuwW7HAgipv8bF5sJ0hYDgDR0yf5s9TE4EBV/uQiM/Q+LurlA+v
 2N0dT4fdR0Mx2jmXvdsTQMkXk2XNOR3pbW0YGT6sci2WVHeQYfZwaUccxVoYZHfVEHl4
 D22YzQNQcvu/eNvtVEL8VrBzmkNCPnZbYTgH3LabaZRNcs3PuBqM9NpxuLciGbtlXXps
 6RyEdCWMwEmFjIu+3yWBHSBtE/gRt+Q0wSuV5YNBd70iynnb8p1+JgRZMluNz+DlGE/T
 zXVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=HugnEq1lb7WCdz0HIeR2ZcLu0AgN9Exbt8YC0ehCyZc=;
 b=N6kaMeCJWxVHdgs82kqlJbITyvRgEG1uk4XouP4q9/IgpBf2L0lNkmem4X1olFPkuU
 EShP0kxVJ2z7XT3Wig1No9H/o1rswCvmio87yFFid5el4HcJ02KixAVoyxYHegKUEMmC
 UwLEBVK2/p0dmBKKTS48n2advUwBoMTSHElAKU4x1abAr8pMfK3SS9SSg8ayt69m1Zfp
 kKFjni1hWzDJ8/+3Kykb0s6046y5RxKje6ap/xJ2czaMR0XT0GMLV2ySKNa0OeZ13pYC
 AqEIqDs0KVWP2euNTNPQoUaWwXyisHNcPSlQU6o15q8ODf/DDOqWLoO2L07C3uQo5Pie
 HZ2A==
X-Gm-Message-State: AOAM5303DQaV6J63+Q1MaBEVCldqVQfoegOFpBzSS3RRqFYyQBysopYF
 KNBH94jpRuDw+O1QgjATF5EhdTKXW6CRMQ==
X-Google-Smtp-Source: ABdhPJwfonobNPbupSiBkVqnp2tL/7/FN1q47QlRUO7yjSVFyyMFt9YyAExtYbbKCJat4jLrvzdSPA==
X-Received: by 2002:a5d:4304:: with SMTP id h4mr8420973wrq.210.1620178066553; 
 Tue, 04 May 2021 18:27:46 -0700 (PDT)
Received: from bas-workstation.. ([2a02:aa12:a77f:2000:7285:c2ff:fe67:a82f])
 by smtp.gmail.com with ESMTPSA id l5sm4261813wmh.0.2021.05.04.18.27.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 May 2021 18:27:46 -0700 (PDT)
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Init GFX10_ADDR_CONFIG for VCN v3 in DPG mode.
Date: Wed,  5 May 2021 03:27:49 +0200
Message-Id: <20210505012749.1803406-1-bas@basnieuwenhuizen.nl>
X-Mailer: git-send-email 2.31.1
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
Cc: alexdeucher@gmail.com, boyuan.zhang@amd.com,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Otherwise tiling modes that require the values form this field
(In particular _*_X) would be corrupted upon video decode.

Copied from the VCN v2 code.

Fixes: 99541f392b4d ("drm/amdgpu: add mc resume DPG mode for VCN3.0")
Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 3f15bf34123a..cf165ab5dd26 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -589,6 +589,10 @@ static void vcn_v3_0_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_idx
 	WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 			VCN, inst_idx, mmUVD_VCPU_NONCACHE_SIZE0),
 			AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_fw_shared)), 0, indirect);
+
+	/* VCN global tiling registers */
+	WREG32_SOC15_DPG_MODE(0, SOC15_DPG_MODE_OFFSET(
+		UVD, 0, mmUVD_GFX10_ADDR_CONFIG), adev->gfx.config.gb_addr_config, 0, indirect);
 }
 
 static void vcn_v3_0_disable_static_power_gating(struct amdgpu_device *adev, int inst)
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
