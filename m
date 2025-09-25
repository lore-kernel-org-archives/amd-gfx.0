Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D1BACAC5BA
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Sep 2025 18:45:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A84710E079;
	Thu, 25 Sep 2025 18:45:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ck5QihVc";
	dkim-atps=neutral
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4806410E079
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Sep 2025 18:45:37 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-24457f581aeso14083335ad.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Sep 2025 11:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758825937; x=1759430737; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JKycbhJXisjcgPZHUWgHik0b20sOaXtiH2SHOgT5qeA=;
 b=Ck5QihVcefzC1pl/ZNHODeprJnDlPgsLUC6L9VzcMEtyQFVrjEgrvVypFbLPNEJeDL
 XdH5Ub4I65Sqbv0shCUKAMs7fhTTgpFS7MpJ9OEzruA99Tm6j8xVwQXH3q81aMPzbXCF
 USmJRa7PT+MxkcKQJ7Gk0xNog+rHRUGPuOpwJ3swJeH7PD/0CP2dIdhEaJO6FPza+uyN
 mD5JWsh90BDBLlz85gyZ0FlV5RxTa3UrJGovt7ZojKFtBoR3ZDf6fyBEIvsDLZLkJQs3
 121pxNNivuV7PtNTZz7AWh/4gsyb1xkImDS2xT3vN4RtGyAnYRd7K0LVm98fYnRzqjVH
 WCgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758825937; x=1759430737;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JKycbhJXisjcgPZHUWgHik0b20sOaXtiH2SHOgT5qeA=;
 b=jnnTh2Xq9dC8qbUs/BcUIoE0yjINFvUGD+N3vH+wjohqWbdWLMciJQ90pwOpnDHOUp
 VqdiLvUMWXuAV7ijPQMlFBliJEnOCZFjZKAxg7ad+ogYtlXuWxCmn2QrOW+RRkSg7oYH
 lF5QwPMX5qy0wzH9+uW2dOIJAvsVgtgnk9eCj1w5cDkouV78/3B6rAgWFAQJlt47K3Sx
 V2+DPHF1nJkITxgOAmA2q5pAtjga0+UNn7+zt/nv2wSxKcAfbEKqRipNyhfGXic4H6Tk
 hFc1c2nMegvXi88kLZ6Wr4609z5s6nQNskNAuQm+k6zaNRbLngL9uEYacjFYhE2sVSOj
 uBzw==
X-Gm-Message-State: AOJu0Yy5YcorRcRr9VZ/4DEJzS8BXYXL+y1wqGUzcqR9bF/NwtP41REA
 cg31ns+bAg1EwXuk7INqoyLAPhKcvS17K07W3fOn8aXbbH6iUX1wuiPOKvHf0g==
X-Gm-Gg: ASbGncsMH1L2208zo6rtKyE5CWwhbWubcz9Vpvai0L5xMjAYQ8n3PkVbEPsD+niExVv
 8syk6dWWEXCIHmZEou9+U8OIQ3fWQKYd8YOGcu+BOxwE9HoUL2ZUMvtq2rZNipcghBt9fTsIquk
 krO+brM6rmz9fk4FJTBavpmupL+vrtnYGcNciaECXniaPv7IMtGxgigLC2eeY750ny3ipn34aUC
 c2bYiCVbYX567Ka6BhyhKBmsfUYV1+RHxEsfVZ28Aj4Bf+1Daf4sYla+B1p22v2n+tMosvBIgcz
 nqq8Zbja1KilX4etlZd9D7vzBsilwriQqvueRuJE+y9o+Agdo1A+uCkOUdsU92q0xaAuVTKjYKi
 WMfBGRNscBGXzgMzcCKLmoO6H+U6ClxU5CnSsmBN6CzM9V4e/W/tL/GLrwl19lw+DHQlPSGuZhQ
 sViVCuJfd6KLrXRLp6Ertif4o8VQ==
X-Google-Smtp-Source: AGHT+IFTibrcXo4I5eQqPSoJImd8upAGoRFki9lwvUWALlR7oJRXf1/F4vEAFado7nOyFP6MRuOvYA==
X-Received: by 2002:a17:903:22ca:b0:277:9193:f2ca with SMTP id
 d9443c01a7336-27ed4a29e9amr44805105ad.9.1758825936719; 
 Thu, 25 Sep 2025 11:45:36 -0700 (PDT)
Received: from Timur-Hyperion.home
 (20014C4E24D06700C9F588200B1ECEA8.dsl.pool.telekom.hu.
 [2001:4c4e:24d0:6700:c9f5:8820:b1e:cea8])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-27eeb9a8ebfsm4244125ad.67.2025.09.25.11.45.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Sep 2025 11:45:36 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, alex.hung@amd.com, harry.wentland@amd.com,
 siqueira@igalia.com,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 0/5] DC: Properly disable scaling on DCE6
Date: Thu, 25 Sep 2025 20:45:20 +0200
Message-ID: <20250925184525.43290-1-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This series fixes visual glitches on systems with SI GPUs
where the BIOS sets up a default mode with scaling.
Alex was kind enough to give me an extra register definition
that can actually bypass the scaler on DCE6.

Additionally, while testing the scaler under KDE, I noticed
that it doesn't work with fractional scaling at high
resolutions with the current register programming.
It causes serious visual distortion when enabling the
vertical filter. So, let's disable the scaler on DCE6
until we figure out how to properly program it.

Alex Deucher (1):
  drm/amdgpu: Add additional DCE6 SCL registers

Timur Kristóf (4):
  drm/amd/display: Add missing DCE6 SCL_HORZ_FILTER_INIT* SRIs
  drm/amd/display: Properly clear SCL_*_FILTER_CONTROL on DCE6
  drm/amd/display: Properly disable scaling on DCE6
  drm/amd/display: Disable scaling on DCE6 for now

 .../drm/amd/display/dc/dce/dce_transform.c    | 21 ++++++++++++-------
 .../drm/amd/display/dc/dce/dce_transform.h    |  4 ++++
 .../dc/resource/dce60/dce60_resource.c        |  4 ++--
 .../drm/amd/include/asic_reg/dce/dce_6_0_d.h  |  7 +++++++
 .../include/asic_reg/dce/dce_6_0_sh_mask.h    |  2 ++
 5 files changed, 28 insertions(+), 10 deletions(-)

-- 
2.51.0

