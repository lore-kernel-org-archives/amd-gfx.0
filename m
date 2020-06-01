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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3216FC433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:21:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A04C2073B
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:21:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aLr8yNhw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A04C2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B00426E2F8;
	Mon,  1 Jun 2020 18:21:26 +0000 (UTC)
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com
 [IPv6:2607:f8b0:4864:20::f44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B97006E2FF
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:21:24 +0000 (UTC)
Received: by mail-qv1-xf44.google.com with SMTP id g7so468458qvx.11
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=B/xv3lNsAzkYv7SrpNGxgXr/ag3M82VVwTdNxdrsdDk=;
 b=aLr8yNhwIVNqKcMflZnc1wQW8NWeRjnOEaouBi6aQjJX5IKw1xos4cv+j4VO2ILom8
 JSZQQeDf1OEVPzEJs0J63n4qojhEAIlQZJJbYyFmXbAfo6vLtHLSGMr2Htel7sKbXcAf
 ZgwAJO5hHuHo3KkdIevrU12lK7x1PwQteBsLsYtXvi93pBfGFsUILqTQEYutQFVDMNYY
 kPKkz+SYtYPWHRfi60MEOzP0ogM8H7EQigabBR+5zs7qX8Vg6fgCOA307y1Fulaulasv
 cT1dMOUpcYMYedVAnpxf2i7/BjbZtzeQh5ydzh8gD+Rh9j3aOHgTUwFZ71bT/NJk0dCt
 EEYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=B/xv3lNsAzkYv7SrpNGxgXr/ag3M82VVwTdNxdrsdDk=;
 b=YTS3NRzSdTDJGVvNjQNekM/14ks+LtG8SKVSlgji+KBPWORIP3Pk2JJpzZsPVQE2fb
 ukctTgV9TarRSBBIYmgmlXG3PK7IrJQHdgT/23nLfuyN8HnLoPZ0uTYOCzOlEgIKOgne
 4yy2tJUG1XNV8YbnVFYysEWQlhkhWSxgHWqJr9xc08EuFGfNifS/hBhjHUbimsueY0cZ
 WBYcl2SpPKZkrWwENSO3Fo0Qj9l5OPfVqjK1bhhOGmWOxh6u6Ut9OLERARXGI9zeZa88
 6/VIyEbHYfsckWN8rC0C3Ca1kgJzDuMncPFtP417jgjVEDnvCaIT6IPfiPwMYtpKpnZZ
 ZQHg==
X-Gm-Message-State: AOAM532PPdZMrqueRYVbVICr/DvAoTnjnAohQ93CmXaDCZBpZ2iBESnd
 gFri0bAaD2YnfZu6VXb9RJWQ/jkw
X-Google-Smtp-Source: ABdhPJyyP87MpSVZOvsJiZtiB0qAfQEPi8pu0ECUHYwDDnimQ7wrHLT0pyVBr1e9atMrnrI5Jv7YgA==
X-Received: by 2002:a0c:b44c:: with SMTP id e12mr21605973qvf.30.1591035683692; 
 Mon, 01 Jun 2020 11:21:23 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id w10sm106849qtc.15.2020.06.01.11.21.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:21:23 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 105/207] drm/amdgpu: set the LMI ctrl and reset earlier
Date: Mon,  1 Jun 2020 14:19:12 -0400
Message-Id: <20200601182054.1267858-16-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Leo Liu <leo.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Leo Liu <leo.liu@amd.com>

So the LMI register will be programmed properly

Signed-off-by: Leo Liu <leo.liu@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index dddae2b8f0f9..517484292303 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -712,6 +712,15 @@ static int vcn_v3_0_start(struct amdgpu_device *adev)
 		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_MASTINT_EN), 0,
 			~UVD_MASTINT_EN__VCPU_EN_MASK);
 
+		/* enable LMI MC and UMC channels */
+		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_LMI_CTRL2), 0,
+			~UVD_LMI_CTRL2__STALL_ARB_UMC_MASK);
+
+		tmp = RREG32_SOC15(VCN, i, mmUVD_SOFT_RESET);
+		tmp &= ~UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
+		tmp &= ~UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
+		WREG32_SOC15(VCN, i, mmUVD_SOFT_RESET, tmp);
+
 		/* setup mmUVD_LMI_CTRL */
 		tmp = RREG32_SOC15(VCN, i, mmUVD_LMI_CTRL);
 		WREG32_SOC15(VCN, i, mmUVD_LMI_CTRL, tmp |
@@ -752,15 +761,6 @@ static int vcn_v3_0_start(struct amdgpu_device *adev)
 		WREG32_SOC15(VCN, i, mmUVD_GFX10_ADDR_CONFIG,
 			adev->gfx.config.gb_addr_config);
 
-		/* enable LMI MC and UMC channels */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_LMI_CTRL2), 0,
-			~UVD_LMI_CTRL2__STALL_ARB_UMC_MASK);
-
-		tmp = RREG32_SOC15(VCN, i, mmUVD_SOFT_RESET);
-		tmp &= ~UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
-		tmp &= ~UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
-		WREG32_SOC15(VCN, i, mmUVD_SOFT_RESET, tmp);
-
 		/* unblock VCPU register access */
 		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_RB_ARB_CTRL), 0,
 			~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
