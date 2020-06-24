Return-Path: <SRS0=jISE=AF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA0EC433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2020 19:05:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAFA120702
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2020 19:05:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L7zDo1XQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAFA120702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 832966E420;
	Wed, 24 Jun 2020 19:05:37 +0000 (UTC)
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com
 [IPv6:2607:f8b0:4864:20::1044])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A5276E420
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2020 19:05:37 +0000 (UTC)
Received: by mail-pj1-x1044.google.com with SMTP id q90so1038070pjh.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2020 12:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=i3hsj7LIKCCAraOjaSOKvw7iF5QSB2i5Go5t144lENM=;
 b=L7zDo1XQ4eCp9KA6bAeDWScW5jWyKsTWGis3ElzGgDQ8yIk2L9ych+fA6Ywg/DGbx0
 DaLcZFFhC02QXgBr8tKpokEiEm21c7YI9e0W4vihBhQ9v+VTsz02wPk3qpKt6b6TcR9z
 6b9FfyRx5+rUjY/a5qKjGYglZ+HfqWghqRlVG0UW2pEq9aP08oRw17AgOE+ng5N0QI5D
 vEAGxpiZOc4qIlGrTaozbpoybwUkWLoTCYZej8cHY5CCtzVMlrPl6zTGLamXTjeXJiq/
 EGZLwbLtvXotlMkaeH3Mb/zMiUu6PuxTuX72y1xYhGcVati9Yh8Rsh8bZSF1tTFlHCiL
 Q4Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=i3hsj7LIKCCAraOjaSOKvw7iF5QSB2i5Go5t144lENM=;
 b=SYtP30JzKgp8Jrn7M6sWYFeZH9fOyNYQ5zGmuIplTHXlL8IUYHm2fR01B825K73X7p
 j8vmVZw4OPusm2qUPjRHRXawmBTDqZCiCEsTTyTL58fn0G8H35lY3G9ixKHD0Wh940C0
 /NWrjpobGbBxqOaenynya6t5MNn1IdVfMM9xj8plXVqsyzeRbTQtAnPKczNH1NeFBJVR
 teRLgC0Yf7qOw4+MnewCrnwOtpmdM16iFWWNf9lUIvxGp3QJNl/W2W9EZ7LWZXjGLapZ
 vRFAmifRu9sTl2MhhABeyzpQ+JpD8Sj3sVGQETDUFyPEkh2tBUJR+CDrGhyGZX/cYJm4
 +CdQ==
X-Gm-Message-State: AOAM5311GSuDWaFs1B9EBho9cf1icpdq1M9yGoBkEwRsEXQlix2GA+3y
 Fw//zzT6WKlNHLylfRdseqlZWMiv
X-Google-Smtp-Source: ABdhPJzGCjoRP6tct1jv+xWDgfI25VwkOAIJYKH+sGCgDOfU0CSVUeoME68EP7pga9jZ8/nzeUfOfw==
X-Received: by 2002:a17:90b:1495:: with SMTP id
 js21mr29855430pjb.48.1593025536290; 
 Wed, 24 Jun 2020 12:05:36 -0700 (PDT)
Received: from localhost.localdomain ([71.219.51.205])
 by smtp.gmail.com with ESMTPSA id v9sm20662377pfe.198.2020.06.24.12.05.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2020 12:05:35 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu: rework runtime pm enablement for BACO
Date: Wed, 24 Jun 2020 15:05:18 -0400
Message-Id: <20200624190519.2378793-1-alexander.deucher@amd.com>
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

Add a switch statement to simplify asic checks.  Note
that BACO is not supported on APUs, so there is no
need to check them.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 34 ++++++++++++++++---------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 4ec544783a45..0fec39eed164 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -167,19 +167,29 @@ int amdgpu_driver_load_kms(struct drm_device *dev, unsigned long flags)
 	}
 
 	if (amdgpu_device_supports_boco(dev) &&
-	    (amdgpu_runtime_pm != 0)) /* enable runpm by default for boco */
-		adev->runpm = true;
-	else if (amdgpu_device_supports_baco(dev) &&
-		 (amdgpu_runtime_pm != 0) &&
-		 (adev->asic_type >= CHIP_TOPAZ) &&
-		 (adev->asic_type != CHIP_VEGA10) &&
-		 (adev->asic_type != CHIP_VEGA20) &&
-		 (adev->asic_type != CHIP_SIENNA_CICHLID) &&
-		 (adev->asic_type != CHIP_ARCTURUS)) /* enable runpm on VI+ */
-		adev->runpm = true;
-	else if (amdgpu_device_supports_baco(dev) &&
-		 (amdgpu_runtime_pm > 0))  /* enable runpm if runpm=1 on CI */
+	    (amdgpu_runtime_pm != 0)) { /* enable runpm by default for boco */
 		adev->runpm = true;
+	} else if (amdgpu_device_supports_baco(dev) &&
+		   (amdgpu_runtime_pm != 0)) {
+		switch (adev->asic_type) {
+#ifdef CONFIG_DRM_AMDGPU_CIK
+		case CHIP_BONAIRE:
+		case CHIP_HAWAII:
+#endif
+		case CHIP_VEGA10:
+		case CHIP_VEGA20:
+		case CHIP_ARCTURUS:
+		case CHIP_SIENNA_CICHLID:
+			/* enable runpm if runpm=1 */
+			if (amdgpu_runtime_pm > 0)
+				adev->runpm = true;
+			break;
+		default:
+			/* enable runpm on VI+ */
+			adev->runpm = true;
+			break;
+		}
+	}
 
 	/* Call ACPI methods: require modeset init
 	 * but failure is not fatal
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
