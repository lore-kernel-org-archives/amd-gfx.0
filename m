Return-Path: <SRS0=MNBo=HS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37449C433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Feb 2021 14:09:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB52164DFF
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Feb 2021 14:09:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB52164DFF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FF746E0EB;
	Tue, 16 Feb 2021 14:09:14 +0000 (UTC)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B2506E0EB
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Feb 2021 14:09:13 +0000 (UTC)
Received: by mail-qv1-xf32.google.com with SMTP id gi9so3527874qvb.10
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Feb 2021 06:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=76zfWbuCQgFXYXeJCYzOoIRvJ9KdsJhWFmiaupDIEGc=;
 b=X0VWCEqWSqlBUdkkRjUrwe1k5oYCCOfEoaNwtNW5gBvnxXSv+URhWUPtDXAWbBFntE
 5uZ7K07x1aEPQmQgL2nnAlTAVZ8flQx9Wde7xafDc6i01FWmxFf9cC7zXFD6/Nxqk2SD
 nSWFeIi0skOI7i8PhgdHGDUyzqIvP7YDrLOSJ6YmH4JWU7LU+/8pDgE/82hKc3PE+aXC
 OCaSmH955IPg5UM1YinYQ7W1bI9Buq6EOQ11SXLXTkvDjlpIAcFgKklodYUpl1X2Rt3v
 TaoxIXdR4+TkrOaaCPyujMXx4dqksHe3703UG3u2X2DruYzvAFIlKf5Z5V/xf2a40KuT
 6tDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=76zfWbuCQgFXYXeJCYzOoIRvJ9KdsJhWFmiaupDIEGc=;
 b=atul3rnXePeGt0bk54C3sKVIEf4OFL8JQDWGicfM8P+09Oucgd9XpCUAxrN+s+3s7l
 VQa0ZpIY+6KE3Xz9xJBNH58WAbBdRd6FcQXDUfvSl8qhboMvFUCSgftOTwSC4dTOBJ1o
 ObY5mu2lxVmam79T4NRT+18Zz5obwqP9X+YD6P7XLdyeadCkbzwUB1W2aza2oZcxFTho
 x4Aw3KEP0f5qbPsPqaMUeK4x8XKA/Xfn9Wzn5rfwAGnVerxDovjiGk9RrlRgPszoY/OW
 hOsTnI8PsOSbYjoMZUmZ3NcEjWZ95ytoftDFPl8MUC2psA+4dMQn2AdJV5ERDP71TrWw
 myHg==
X-Gm-Message-State: AOAM530x9eBl11Awd/y5PbL24rrd3T+Jpf2sf5pO34I5I3l0vJQ8s5c9
 KczACN+LIbQl4+yIe6C9KMrTCWbc+MM=
X-Google-Smtp-Source: ABdhPJwjakg+RU0jRNFaqB2nJreXjw0d0HGTdhsseTSmClORgg5QGqZhcjUK2tZOm+PDlL28VCveaQ==
X-Received: by 2002:ad4:554c:: with SMTP id v12mr19765292qvy.41.1613484552314; 
 Tue, 16 Feb 2021 06:09:12 -0800 (PST)
Received: from localhost.localdomain ([192.161.79.229])
 by smtp.gmail.com with ESMTPSA id a206sm10311919qkc.7.2021.02.16.06.09.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Feb 2021 06:09:11 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/radeon: OLAND boards don't have VCE
Date: Tue, 16 Feb 2021 09:09:03 -0500
Message-Id: <20210216140903.1655665-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
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

Disable it on those boards.  No functional change, this just
removes the message about VCE failing to initialize.

Bug: https://bugzilla.kernel.org/show_bug.cgi?id=197327
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/radeon/radeon_asic.c | 3 +++
 drivers/gpu/drm/radeon/radeon_vce.c  | 1 -
 drivers/gpu/drm/radeon/vce_v1_0.c    | 1 -
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_asic.c b/drivers/gpu/drm/radeon/radeon_asic.c
index 8becbe09af2f..bfacf8fe5cc1 100644
--- a/drivers/gpu/drm/radeon/radeon_asic.c
+++ b/drivers/gpu/drm/radeon/radeon_asic.c
@@ -2478,6 +2478,9 @@ int radeon_asic_init(struct radeon_device *rdev)
 		if (rdev->family == CHIP_HAINAN) {
 			rdev->has_uvd = false;
 			rdev->has_vce = false;
+		} else if (rdev->family == CHIP_OLAND) {
+			rdev->has_uvd = true;
+			rdev->has_vce = false;
 		} else {
 			rdev->has_uvd = true;
 			rdev->has_vce = true;
diff --git a/drivers/gpu/drm/radeon/radeon_vce.c b/drivers/gpu/drm/radeon/radeon_vce.c
index a450497368b2..511a942e851d 100644
--- a/drivers/gpu/drm/radeon/radeon_vce.c
+++ b/drivers/gpu/drm/radeon/radeon_vce.c
@@ -68,7 +68,6 @@ int radeon_vce_init(struct radeon_device *rdev)
 	case CHIP_TAHITI:
 	case CHIP_PITCAIRN:
 	case CHIP_VERDE:
-	case CHIP_OLAND:
 	case CHIP_ARUBA:
 		fw_name = FIRMWARE_TAHITI;
 		break;
diff --git a/drivers/gpu/drm/radeon/vce_v1_0.c b/drivers/gpu/drm/radeon/vce_v1_0.c
index 70c5da2141d7..bdfbcf14b864 100644
--- a/drivers/gpu/drm/radeon/vce_v1_0.c
+++ b/drivers/gpu/drm/radeon/vce_v1_0.c
@@ -169,7 +169,6 @@ int vce_v1_0_load_fw(struct radeon_device *rdev, uint32_t *data)
 		chip_id = 0x01000015;
 		break;
 	case CHIP_PITCAIRN:
-	case CHIP_OLAND:
 		chip_id = 0x01000016;
 		break;
 	case CHIP_ARUBA:
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
