Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BC2ECCF9E5
	for <amd-gfx@archiver.kernel.org>; Sat, 18 Oct 2025 08:51:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C0FC10E3E6;
	Sat, 18 Oct 2025 08:50:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=0x0f.com header.i=@0x0f.com header.b="lw+k6Qvx";
	dkim-atps=neutral
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com
 [209.85.210.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6B4810E093
 for <amd-gfx@lists.freedesktop.org>; Sat, 18 Oct 2025 05:45:00 +0000 (UTC)
Received: by mail-pf1-f181.google.com with SMTP id
 d2e1a72fcca58-791c287c10dso2195219b3a.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Oct 2025 22:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=0x0f.com; s=google; t=1760766300; x=1761371100; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=89BI59zwmh1Ubu37m+UzRMVYEbxdBWMilagPFw2Lo2s=;
 b=lw+k6QvxkKY/70o7MSlJUzEGUjEPH6z7/eTVVYBQz5FhbuwvUXUd207mbC8VDTQPYZ
 ppl0s7yxW6QBYXwEcg+plkXs8+tknTIXoEWL4ocjCLEGaHDZUCWpLVhiA82W1yVcnvWp
 jJKPdssESj8PREegZX2wgijh91S2PXNw+sHsY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760766300; x=1761371100;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=89BI59zwmh1Ubu37m+UzRMVYEbxdBWMilagPFw2Lo2s=;
 b=d/i5WUvBVE9ZCcluUl79YCi9GdX1N4LJvCV7O/V3a157NwEcawx971IcJS6lnU+mGl
 9lGFs50QDoflSOd6oRaJlVD6qnJNDuENPiXKZWBRf22XDBzzWA/yBHXGCjPdaIendRT4
 s7KZoixJFeW3zkaQbu3nhcrYb19C6xF6CSBhaQ0kcwi5Vkt0BgJKRiWcKeQx6dIw1Dqo
 yUEEJAFkwLX5jt7dVKgEELJLty1AaJF+PfGcBO4CWQLO6sCswxprQJoQBQLB8d2wG4x6
 qTQnN7ODyyM3KFhGTSBRnKhm2uxI01YVRKY5D841nGXnbWKKlPMpDQq2YfYu+eUSoMP5
 H83A==
X-Gm-Message-State: AOJu0YzMinKDfpPDOur5M8w2VUMTUrFVeVZhzTf9IOMxHEngVTRUzPvM
 FNGPwl8RsrbBBxWD8uo5fbDJEusAcgo+/P57kYWQ7+OdtQCJfMSv31jLd3kw0lGlsGA=
X-Gm-Gg: ASbGncvFZvMY/7Gx5paRgTreUDRKzFFtJPYRKolismm2zDYXkmFQcZEqAWVWxn9qC+B
 MsNTvbkkvyTrnGZkZcLYthnBsbcKsoyRbYFsMUQOHMwYUHblETPeF8IYGEhm5R+y1ecJnvCZZM+
 LujHcO2YHobz+Lh8Inqe/tqufiTam1cxkmhgcVD3U7Yk07lR6ZQda8hrRpBRaO8/FvwfidFvw5Q
 +QmryIBNkbljBSOyJeSGusfQJEEsFNZEo2d5MXhHDEaS2jb4ml6E0jsrXmfIHRc0sI4wmDuF24U
 3b/I762i1EZmlTOyjTX/kvaDCknCqK6UpLm3dIL8Ry/RBtAQ6KoLL2a/3quFWPeNRnzHLN0jh4g
 ZulXti23kLOgcOBr7BXPP6h2xLWdQs/ew5yUhBfEiyxmhiHv30bzbp/YZBPy2I9Cia7HRmwrbGF
 roGxAFQPXbYRyBwnSkvZvAniwGymyAv948XnAw0phtU8otG4kvG1o=
X-Google-Smtp-Source: AGHT+IEHbWRy0UQfKYZEKhc6rfju/pKkbqQ6hk4S/GiStG+bKUHgiK4+G/rplbVGaAB9yEUU3M4bFA==
X-Received: by 2002:a05:6a21:6daa:b0:306:2a14:d0d4 with SMTP id
 adf61e73a8af0-334a8625728mr7189585637.43.1760766300265; 
 Fri, 17 Oct 2025 22:45:00 -0700 (PDT)
Received: from shiro (p1391188-ipxg00a01sizuokaden.shizuoka.ocn.ne.jp.
 [153.222.3.188]) by smtp.googlemail.com with ESMTPSA id
 41be03b00d2f7-b6a76645c61sm1657222a12.3.2025.10.17.22.44.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Oct 2025 22:45:00 -0700 (PDT)
From: Daniel Palmer <daniel@0x0f.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch, wuhoipok@gmail.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH 1/3] drm/radeon: Clean up pdev->dev instances in probe
Date: Sat, 18 Oct 2025 14:44:49 +0900
Message-ID: <20251018054451.259432-2-daniel@0x0f.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251018054451.259432-1-daniel@0x0f.com>
References: <20251018054451.259432-1-daniel@0x0f.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 18 Oct 2025 08:50:54 +0000
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

Get a struct device pointer from the start and use it.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 drivers/gpu/drm/radeon/radeon_drv.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
index 88e821d67af7..eb5138da8d5b 100644
--- a/drivers/gpu/drm/radeon/radeon_drv.c
+++ b/drivers/gpu/drm/radeon/radeon_drv.c
@@ -262,6 +262,7 @@ static int radeon_pci_probe(struct pci_dev *pdev,
 	unsigned long flags = 0;
 	struct drm_device *ddev;
 	struct radeon_device *rdev;
+	struct device *dev = &pdev->dev;
 	const struct drm_format_info *format;
 	int ret;
 
@@ -277,7 +278,7 @@ static int radeon_pci_probe(struct pci_dev *pdev,
 		case CHIP_VERDE:
 		case CHIP_OLAND:
 		case CHIP_HAINAN:
-			dev_info(&pdev->dev,
+			dev_info(dev,
 				 "SI support disabled by module param\n");
 			return -ENODEV;
 		}
@@ -289,7 +290,7 @@ static int radeon_pci_probe(struct pci_dev *pdev,
 		case CHIP_HAWAII:
 		case CHIP_KABINI:
 		case CHIP_MULLINS:
-			dev_info(&pdev->dev,
+			dev_info(dev,
 				 "CIK support disabled by module param\n");
 			return -ENODEV;
 		}
@@ -303,11 +304,11 @@ static int radeon_pci_probe(struct pci_dev *pdev,
 	if (ret)
 		return ret;
 
-	rdev = devm_drm_dev_alloc(&pdev->dev, &kms_driver, typeof(*rdev), ddev);
+	rdev = devm_drm_dev_alloc(dev, &kms_driver, typeof(*rdev), ddev);
 	if (IS_ERR(rdev))
 		return PTR_ERR(rdev);
 
-	rdev->dev = &pdev->dev;
+	rdev->dev = dev;
 	rdev->pdev = pdev;
 	ddev = rdev_to_drm(rdev);
 	ddev->dev_private = rdev;
-- 
2.51.0

