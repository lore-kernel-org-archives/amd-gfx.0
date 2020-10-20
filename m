Return-Path: <SRS0=LN+i=D3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C9E7C4363A
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Oct 2020 22:31:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E48F82225C
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Oct 2020 22:31:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=basnieuwenhuizen.nl header.i=@basnieuwenhuizen.nl header.b="S0/o9WsR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E48F82225C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=basnieuwenhuizen.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AF616E0AB;
	Tue, 20 Oct 2020 22:31:18 +0000 (UTC)
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com
 [IPv6:2a00:1450:4864:20::541])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 646726E0AB
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Oct 2020 22:31:17 +0000 (UTC)
Received: by mail-ed1-x541.google.com with SMTP id x1so392312eds.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Oct 2020 15:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen.nl; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=tGN8J791ASBz1j8o3HjXKbXShdB4woQMBp9g9JyHw2o=;
 b=S0/o9WsRZmtA5VRpW33loclxPL0lNMUDfE1aaFoPwpRHlbUITAynRBOjCpLQ1e9gwK
 5kgDAyngnQQUfAKHAhtaLaVmeFONgsB1MrSztQIxeckDUZQVUThcpP2YJCysnzuAgLKC
 FHUqhhq7MaSslfsFK1nklza6RH40NVLjbrPAiFcCwqLq7LcDOeosvjbUvjRlDdGS/x6z
 bOVwwBo9u4uHkqAOb1gXqLDvLAbnV45RWKdQ1QucDFov7dVJmDtJlNzQ0GktC7ZbqZtQ
 FTW06wLkHn2rU5c87FjX+kLWJDlU/CSpMaKXhF3AFTeAWH4ZvSjmsRvTkyBYikUoXrIS
 dJJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=tGN8J791ASBz1j8o3HjXKbXShdB4woQMBp9g9JyHw2o=;
 b=RK3QipAsa8A3DeHbcymRjDsTJuYkbH7LuHyezmk5k4F2vmFvHa6Phb0688i2iLfegZ
 1QaZYHStAAS6PML+AzNy+lIHsmaAG1Ko27zCYyeQQla+cUPm9H6wVZNFFlrMaTPEnqlo
 UdH4bEIrCbVGe3MvZn09Z5rhxlI+Q0ixPToThu9/emQLwXKWJWjbsP2KTLb31zl7LGNR
 gdW+pBnDu6VqzDeewPpGmktXbLn+pQvcruvy1qe3YuNH8HNgHtFhYVjsTEGE7yVhU2ql
 FmFi6HrXOCNf8uyeCQaOiAHE524Shzj79YC1tTmqdkEFe/c+OpbLNj9C5/tnpMk+5uxG
 HEyg==
X-Gm-Message-State: AOAM530L5R+9SSN396eq5/gGFdXgyISWcvwZhBF+WOhKpJcst9jzOWPt
 s/RshGIpg57XYTbJPak7Ylo0Vogr3Gsnpg==
X-Google-Smtp-Source: ABdhPJzveGIQXzkftDsBLdRx4kuzcE2BKV6nPKX7ymtf9vAzW8EoOKcxxW8bQDOLOadBxE1uPw7Omg==
X-Received: by 2002:a05:6402:395:: with SMTP id o21mr202457edv.2.1603233075600; 
 Tue, 20 Oct 2020 15:31:15 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:aa12:a77f:2000:4cea:81e7:5fd4:93f7])
 by smtp.gmail.com with ESMTPSA id p3sm331995edy.38.2020.10.20.15.31.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2020 15:31:14 -0700 (PDT)
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/display: Initialize num_pkrs on VANGOGH.
Date: Wed, 21 Oct 2020 00:31:13 +0200
Message-Id: <20201020223113.310402-1-bas@basnieuwenhuizen.nl>
X-Mailer: git-send-email 2.28.0
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
Cc: alexander.deucher@amd.com, Roman.Li@amd.com,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

As far a I can tell uses a variant of DCN3xx which uses num_pkrs.

If we do not initialize the variable we will set the register field
to ilog2(0) = -1, though the mask will reduce that to 7. Pretty sure
7 is not the value we want here.

Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
---

Found while rebasing my modifiers series. Not tested on HW.

 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 6855aad7f312..2713caac4f2a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4074,7 +4074,8 @@ fill_plane_buffer_attributes(struct amdgpu_device *adev,
 #ifdef CONFIG_DRM_AMD_DC_DCN3_0
 		if (adev->asic_type == CHIP_SIENNA_CICHLID ||
 		    adev->asic_type == CHIP_NAVY_FLOUNDER ||
-		    adev->asic_type == CHIP_DIMGREY_CAVEFISH)
+		    adev->asic_type == CHIP_DIMGREY_CAVEFISH ||
+		    adev->asic_type == CHIP_VANGOGH)
 			tiling_info->gfx9.num_pkrs = adev->gfx.config.gb_addr_config_fields.num_pkrs;
 #endif
 		ret = fill_plane_dcc_attributes(adev, afb, format, rotation,
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
