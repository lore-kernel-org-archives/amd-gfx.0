Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F217C46467
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Jan 2023 22:50:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9D3D10E2A0;
	Tue, 10 Jan 2023 22:50:50 +0000 (UTC)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E005410E2A0
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Jan 2023 22:50:48 +0000 (UTC)
Received: by mail-wm1-x334.google.com with SMTP id
 m8-20020a05600c3b0800b003d96f801c48so13053943wms.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Jan 2023 14:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=froggi.es; s=google;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=EJzZdP1i2UG5zCQX35cmeRkq+myXJ+3i65XYvFSeUg0=;
 b=OXuETTHOQI1mJy2ac5gXRU9u8Xn4Dw1UJX2Tauz6c6uHHvQYoD8bcU6Ghbe28vCpaF
 FyzEqCNXyhpD6cow9ero2qXkIfpfSUpMLVm7obgOplswAaGDPycz1iDzF6flff2jCFs+
 I6P6tom2TB6qG5SdSsCyCU7s3jM8Nv/qxHHxnOpizLDFhAQ7UFG5xB+4DgVllibS3RLq
 shL0iEU8dpWULdbPIYUUfNyRFzOxtSlRHS979gqyXphHgBnxAfWBFCMFNmZZBHUHVMaV
 65jsSPiQOcP3A0L45Stm7SjSTfYCvRFsuF9IjfQNF3VmUke4BV9Demafeb3Ahl0+C4K2
 WJNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EJzZdP1i2UG5zCQX35cmeRkq+myXJ+3i65XYvFSeUg0=;
 b=EdIBlt64ENTD3MBy5udX+5UnSx3CJOnoNPo3SlZd9tAr/ufpeiL4ed/a8KBxthC5Tk
 rTVNMJEE9uVStXW+TDrXN/0DD7P2BrDreAe+/R4TsuxsXOIWU6V7+/xEr0pAT1msDQRf
 8uBQyZ4NbrEcb1M90imHEyApJNHrG2Rv8eE0p+DLr6Jw6kS33Xra5lyOrrX5ulptR0qD
 yxDEH6no+vC+V97rQ3OkNze6LpC8wv0if254PLAUofSojJrSQ7z0+kol4KimRp8W8xeb
 c4Se2hOTtE4uL9K+hO6EDvOVpSi+luUDVOV9abH5/m41fz1oZU3t8WmrsAYuYsyla8wW
 Mwsw==
X-Gm-Message-State: AFqh2koRzRojQfE01IgAfpeTKSVLi5oazP7lYI8r/XW7Ej2mrdy8l/2p
 /M4HHO4HBPMqVayK2d38lHgyM1jbe9qozwK5
X-Google-Smtp-Source: AMrXdXtsVM/BFXm553yPCX09oO01189kcySGBta0Ou3nACvvVZVRvETWiOMDJJtFFLUbTlPNdzlWdw==
X-Received: by 2002:a05:600c:1c85:b0:3d3:4b18:27c6 with SMTP id
 k5-20020a05600c1c8500b003d34b1827c6mr49678255wms.11.1673391047367; 
 Tue, 10 Jan 2023 14:50:47 -0800 (PST)
Received: from localhost.localdomain
 (darl-09-b2-v4wan-165404-cust288.vm5.cable.virginm.net. [86.17.61.33])
 by smtp.gmail.com with ESMTPSA id
 p9-20020a05600c358900b003cffd3c3d6csm17958165wmq.12.2023.01.10.14.50.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Jan 2023 14:50:46 -0800 (PST)
From: Joshua Ashton <joshua@froggi.es>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/display: Fix COLOR_SPACE_YCBCR2020_TYPE matrix
Date: Tue, 10 Jan 2023 22:50:42 +0000
Message-Id: <20230110225042.6710-1-joshua@froggi.es>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: Joshua Ashton <joshua@froggi.es>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The YCC conversion matrix for RGB -> COLOR_SPACE_YCBCR2020_TYPE is
missing the values for the fourth column of the matrix.

The fourth column of the matrix is essentially just a value that is
added given that the color is 3 components in size.
These values are needed to bias the chroma from the [-1, 1] -> [0, 1]
range.

This fixes color being very green when using Gamescope HDR on HDMI
output which prefers YCC 4:4:4.

Signed-off-by: Joshua Ashton <joshua@froggi.es>
---
 drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index 471078fc3900..652270a0b498 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -90,8 +90,8 @@ static const struct out_csc_color_matrix_type output_csc_matrix[] = {
 		{ 0xE00, 0xF349, 0xFEB7, 0x1000, 0x6CE, 0x16E3,
 				0x24F, 0x200, 0xFCCB, 0xF535, 0xE00, 0x1000} },
 	{ COLOR_SPACE_YCBCR2020_TYPE,
-		{ 0x1000, 0xF149, 0xFEB7, 0x0000, 0x0868, 0x15B2,
-				0x01E6, 0x0000, 0xFB88, 0xF478, 0x1000, 0x0000} },
+		{ 0x1000, 0xF149, 0xFEB7, 0x1004, 0x0868, 0x15B2,
+				0x01E6, 0x201, 0xFB88, 0xF478, 0x1000, 0x1004} },
 	{ COLOR_SPACE_YCBCR709_BLACK_TYPE,
 		{ 0x0000, 0x0000, 0x0000, 0x1000, 0x0000, 0x0000,
 				0x0000, 0x0200, 0x0000, 0x0000, 0x0000, 0x1000} },
-- 
2.39.0

