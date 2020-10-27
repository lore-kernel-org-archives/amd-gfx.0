Return-Path: <SRS0=SqeI=EC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05D40C5517A
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 15:04:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91BAC22275
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 15:04:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M23xPyiU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91BAC22275
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD3976EB89;
	Tue, 27 Oct 2020 15:04:07 +0000 (UTC)
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 484EC6EB89
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2020 15:04:06 +0000 (UTC)
Received: by mail-qk1-x743.google.com with SMTP id b18so1423992qkc.9
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2020 08:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=/rmzDJnJYJegRVYldaip9VlFH7rA/50dWobZRK4sTfQ=;
 b=M23xPyiUdX1mTSQCVZFR93y4Kz5pgbgyo0UN+8X2lvQdczu2z5Srz4iEbj9UUWlZ1F
 fQrkwHgIDHkIGRQ17jROieWb61v3JDioCfNNU4xERmn2C3Yu1+cY2roZx8CAs1vhpQB5
 NeNbPyRN0Tm7BKhsD9+a9kuyGASFCMKRWW27QiH5u1vslCGF/IP+t0DTcHgPSGRACVxS
 8/V4x1ab5TjM8ETOhd4ph+byaBCRBa9+2t5IKzB8GuGMUReVqXtFTX/T8sC8VhZBTLul
 oEDySX/Hg5Nm/SbRC8bqjC59fCHOjMkWma1bFiXs9nNhzNQhfo52iSSZpACjwYNG6QXB
 /MkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=/rmzDJnJYJegRVYldaip9VlFH7rA/50dWobZRK4sTfQ=;
 b=EoKasbv8v8gJSz9o0kOtI9xHMMMO3/Huo2zA6BZXP3QHjwcW0JSHX7I4OjNMFqpp88
 QnadLzIPB7NmJTNSIiXWHeFs5DB71kRpxEciC8sNPqsbC2b4F25RhP/v3qHo2v0S4eS5
 wiQYEU4rue50DOr9FI6msP14e1fvXnK9M12ixJl+AHo27yCOjwSwxUQr9ZjW3Y9nk4sC
 L6zCL9XgrzGl15oWDbLvAwHWJkGbp3hazKXocKmkjVjrE+uG+ZWd+QUSkl04isZyAVMH
 KOMrXUvVZg2mCtLECo9WyfydMoqyQG3C2qCMIBuvOLqoead2xQg8gaIkDz9W6LSJJpOO
 LA6g==
X-Gm-Message-State: AOAM533x5e5PGI0i4pI3uMqUrYPASYjMxueNGAgtxu8eLu5sedlwYYLO
 AmKB93CwMfsdQcwowtqaE4PTktVC+pY=
X-Google-Smtp-Source: ABdhPJzyxF4BM7uypDwXYdn92P0cRsm8vZzbHnEqzDi3423y/spN29FcEY1EkMmdoj6GzWSnNj8UgA==
X-Received: by 2002:a05:620a:15f1:: with SMTP id
 p17mr2612577qkm.349.1603811045076; 
 Tue, 27 Oct 2020 08:04:05 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id g24sm822291qka.111.2020.10.27.08.04.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2020 08:04:04 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/display: fix warnings when CONFIG_DRM_AMD_DC_DCN
 is not set
Date: Tue, 27 Oct 2020 11:03:56 -0400
Message-Id: <20201027150356.1786991-1-alexander.deucher@amd.com>
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

Properly protect the relevant code with CONFIG_DRM_AMD_DC_DCN.

Fixes: 0b08c54bb7a3 ("drm/amd/display: Fix the display corruption issue on Navi10")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index fdb1fa72061a..843080e4c39e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -893,6 +893,7 @@ static int dm_dmub_hw_init(struct amdgpu_device *adev)
 	return 0;
 }
 
+#if defined(CONFIG_DRM_AMD_DC_DCN)
 static void mmhub_read_system_context(struct amdgpu_device *adev, struct dc_phy_addr_space_config *pa_config)
 {
 	uint64_t pt_base;
@@ -945,6 +946,7 @@ static void mmhub_read_system_context(struct amdgpu_device *adev, struct dc_phy_
 	pa_config->is_hvm_enabled = 0;
 
 }
+#endif
 
 static int amdgpu_dm_init(struct amdgpu_device *adev)
 {
@@ -952,7 +954,6 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 #ifdef CONFIG_DRM_AMD_DC_HDCP
 	struct dc_callback_init init_params;
 #endif
-	struct dc_phy_addr_space_config pa_config;
 	int r;
 
 	adev->dm.ddev = adev_to_drm(adev);
@@ -1060,6 +1061,8 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 	if (adev->asic_type == CHIP_RENOIR) {
+		struct dc_phy_addr_space_config pa_config;
+
 		mmhub_read_system_context(adev, &pa_config);
 
 		// Call the DC init_memory func
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
