Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 927F8C52D54
	for <amd-gfx@archiver.kernel.org>; Wed, 31 Jul 2024 07:20:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40A1910E43D;
	Wed, 31 Jul 2024 07:20:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=uci.edu header.i=@uci.edu header.b="kCmXRuw+";
	dkim-atps=neutral
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA1E210E246
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 Jul 2024 05:54:56 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-1ff1cd07f56so33748475ad.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jul 2024 22:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uci.edu; s=google; t=1722405296; x=1723010096; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tKqvRSmHkIVmsY2tE+MEGPilglpL1hNRDaBy1R6HENs=;
 b=kCmXRuw+BWGIX/AWeMmhXe9dUqR/stbAB54lutqXQXrZvH0hMvswjp0mVP8I7ROHX1
 xDaHY/MV+pqmPAlBw5EBjtN0Q68eaTqby9p0QcoPQgtORQF5MYbLKVVDEOFG/VhrC/N4
 enULg0q+u374kYORDTopwo/cYs6ZpJ6C7DJkI841fWCS0237GECcq2S+mKxNm9mDwC9h
 oQO+1Bc4nzeAGHJSn9Wrh1kELgNG8bqaZ64J0cVi+M3wDxyYjeKHZyexNS4it9WpwWwT
 AFEzOMUPX7ZAeObYQZkFZzUDuh0QCvh4cvj+QplIH9cDFDZeyXDhZP3nhL5Ri1/Yn6n0
 tzxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722405296; x=1723010096;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tKqvRSmHkIVmsY2tE+MEGPilglpL1hNRDaBy1R6HENs=;
 b=mLjP80J8lkqYg2PAbnJAOW4C8kY98fJUOMeHSOJH3SSL5fm0N+0g26JRfRRA88vwHM
 24kDA3mhNTcqkTSqskdI7ZAJrDiG92o/nrShWBbEFZDttgxh+G2iKtJ6diRzmoTKokp/
 0tLsqM/hcsRI6YUq9QxmVM1yVCx+S0tdZh/J0t1j+r1JLAs2add1w6dzZHFmyi+XVF4i
 uSyA7LHINp6tVZiJGFYnd99M8xTpmQPN3go42l30oHU18M2xhaUqCUDgGycbnoXuAmtZ
 TJmTTb5QgyFMi7C8UKl+WPq6V/KYXclW1JFUPBnbOB9BOsBwByUahu71zn1C9bsouAOX
 H8zA==
X-Gm-Message-State: AOJu0YzhZ+A5d+Ob+1x/yBteWyXmTA5B/4ZzPvU3kFIQ4ZyfvG+RL6O2
 U1F1ZtVgM5GpMSiVS626AllVHliVh3i7W6u3QrVVh6W5CeVlYuJQLq2rhEZQ2cY=
X-Google-Smtp-Source: AGHT+IFhCVV0PZXpK0cSSWZ1v4yPQWI6euzChZEKm8M/bxSqMPBGp7wJxtefAjhZ7cUEpLN3KGIPHQ==
X-Received: by 2002:a17:902:ea0e:b0:1fc:6740:3ce6 with SMTP id
 d9443c01a7336-1ff048270a2mr147043735ad.20.1722405295409; 
 Tue, 30 Jul 2024 22:54:55 -0700 (PDT)
Received: from alpha.mshome.net (ip68-4-168-191.oc.oc.cox.net. [68.4.168.191])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fed7ee4ce6sm112339595ad.157.2024.07.30.22.54.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jul 2024 22:54:54 -0700 (PDT)
From: Remington Brasga <rbrasga@uci.edu>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org,
 Remington Brasga <rbrasga@uci.edu>
Subject: [PATCH] drm/amdgpu/uvd4: fix mask and shift definitions
Date: Wed, 31 Jul 2024 05:54:51 +0000
Message-Id: <20240731055451.15467-1-rbrasga@uci.edu>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 31 Jul 2024 07:19:57 +0000
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

A few define's are listed twice with different, incorrect values.
This fix sets them appropriately.

Signed-off-by: Remington Brasga <rbrasga@uci.edu>
---
The second UVD_LMI_CTRL__RFU_MASK is incorrect, so it was removed. It should be
`0xf800 0000`.
The first UVD_LMI_CTRL__RFU__SHIFT is incorrect, so it was removed.
It should bei `0x1a`.

This change aligns the uvd definitions, please refer to:
drivers/gpu/drm/amd/include/asic_reg/uvd/uvd_3_1_sh_mask.h
drivers/gpu/drm/amd/include/asic_reg/uvd/uvd_4_2_sh_mask.h
drivers/gpu/drm/amd/include/asic_reg/uvd/uvd_5_0_sh_mask.h
drivers/gpu/drm/amd/include/asic_reg/uvd/uvd_6_0_sh_mask.h

 drivers/gpu/drm/amd/include/asic_reg/uvd/uvd_4_0_sh_mask.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/asic_reg/uvd/uvd_4_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/uvd/uvd_4_0_sh_mask.h
index 8ee3149df5b7..2ef1273e65ab 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/uvd/uvd_4_0_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/uvd/uvd_4_0_sh_mask.h
@@ -340,8 +340,6 @@
 #define UVD_LMI_CTRL__REQ_MODE_MASK 0x00000200L
 #define UVD_LMI_CTRL__REQ_MODE__SHIFT 0x00000009
 #define UVD_LMI_CTRL__RFU_MASK 0xf8000000L
-#define UVD_LMI_CTRL__RFU_MASK 0xfc000000L
-#define UVD_LMI_CTRL__RFU__SHIFT 0x0000001a
 #define UVD_LMI_CTRL__RFU__SHIFT 0x0000001b
 #define UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK 0x00200000L
 #define UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN__SHIFT 0x00000015
-- 
2.34.1

