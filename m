Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA8F6CD4F26
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jun 2026 07:55:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 655FE10F4B9;
	Fri, 26 Jun 2026 07:55:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=usp.br header.i=@usp.br header.b="XDIHEVEA";
	dkim-atps=neutral
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24A9E10E2A1
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jun 2026 03:00:22 +0000 (UTC)
Received: by mail-dl1-f54.google.com with SMTP id
 a92af1059eb24-1384ebe7a10so42476c88.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jun 2026 20:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1782442821; x=1783047621; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xyfqQaJzQGqQ+w3Wgkei2isTk6qDBF7q1W+qeueb6IQ=;
 b=XDIHEVEAP6VRrDX4ISUVY1fASNy/8hg5AvqjAaHwHDBxIHLXwP/xRi8Zk2XIdUsYwM
 icW+EYvSJkmoyVh3e3Qc9O/qIEe2LEKV0ZsMqT7oWQtjvTOYmcZzOxWLxbVXISl7JP1f
 b1pFveKjDnyhfmXeFyqLkJdvBtwBdyYiVFEcNnL5brkel39L1+EHPJIeff3qWPByLwt8
 VrDeqBUjvfW7+KvThYMrcrTWpNxSKcBqBOXtqfDIApdIOwh2n6q6t/3LbsZ0raEfkxIe
 iUGiGI0masL54D7Vyh4ZtTrYwVngTC5SZkPnysL/SuQVm11mEDn1eh1cXm9EmKqiAt3K
 HJ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782442821; x=1783047621;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xyfqQaJzQGqQ+w3Wgkei2isTk6qDBF7q1W+qeueb6IQ=;
 b=RtA/undE9/6CVNpejzGEQ+TLKpCWqsvzmbUG5Idf14W+vFLdUfxJvaOjYBfzGi61QX
 YIk7YHzfnjYxbfZrcgttQZJ1QqyVO2jKv+MaGxIVOnkKcuoOX36gpaPoslljjCYOCajL
 GupTkJ4NVEwqMwaKcYf/NkBnSUlytEtAXiASRUB7tvm/XZBBHOvM3aLng0KnN14YTmrf
 IrIhr/fRs0rfJ9xgyB9gDZxS9FWmNkcv2ZHoideBVo7T2xQZMAQsUzB4KhR7utpAEErO
 qeuaJ8peDOL9rAZyqbjaRG/SmB05x6V3tlwpn+l0cu7xZZCzsw1NIBKCv3xfeGDaZv0X
 Z1Rw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8K8pFBY2IeMFSNtL1yZF5iK6dXgqkuvogDx9qzcAPRJ5azaS6YcLl8/zggKCPY18jMZ5DBE3LD@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwEK4cnX8tiMo29U+EIW6tsNsbNzPVz7E27BXknxA/G1apmiDMB
 9Yz4HNXRyxDGMwplUH+SjP/o60p7YLPfkwapOC62E/Q9gOYd9LfSmOmWqoTWRyClphE=
X-Gm-Gg: AfdE7cnSVKgC9A7FVpunDuRgSHFOTU7xvRSFL8jBI+hBCLgPkuUkMHWDIbcNyH9EBtR
 Fbh1uUaaLwB0gdiNdqSUbsUOUEfjFztPI21ekc+eczQnZPBtMC4hqGNaMUqd3p1KraUZNH+5LT0
 5EixWidXrQO1ixVjq/n409PTTdUSoELvs+CP06LyMgGJk2/mH130DU4tro95m+d1yCj7xJLsIYT
 yiRFBlrz/jBDsMSV/4q5Y1TT3lVxKKwobg2r6RzSsDaAg3oktlqKygmQRZvSP+vcuUnie7fkS+p
 3O4MKYf1xFOGBKk1hQXu2or09CeAk9/BPvRX/lxgYWwna8lLvDpIKBCYyKXdN+hUT8FCaTbxNWK
 DDB+0QaRmtUhDmGxD0DonJ1C1gXs+qiFR3LH8aBqiTvbQw0EFxLPsM5PiXksQJF21Fy6Jq/M96L
 F6HZlRajT8bZmR7U7p+tuVtH5JIXy3BgPDNogaRveVafV7HzaXCu+rRoz3vWZP69CQFJ/k9g==
X-Received: by 2002:a05:7022:5f08:b0:139:dfe9:c8b1 with SMTP id
 a92af1059eb24-139dfe9c90emr1949342c88.8.1782442821140; 
 Thu, 25 Jun 2026 20:00:21 -0700 (PDT)
Received: from voyager.. ([179.119.40.186]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139d8f6acf9sm13048415c88.6.2026.06.25.20.00.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 20:00:20 -0700 (PDT)
From: Tiago Dourado <tiagodourado@usp.br>
To: kernel@lists.ime.usp.br, airlied@gmail.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, simona@ffwll.ch
Cc: Tiago Dourado <tiagodourado@usp.br>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH v2 0/2] drm/amdgpu/jpeg: deduplicate process_interrupt across
 JPEG versions
Date: Thu, 25 Jun 2026 23:59:11 -0300
Message-ID: <20260626030013.20569-1-tiagodourado@usp.br>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 26 Jun 2026 07:54:04 +0000
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

The JPEG versions v3_0 and v5_3_0 have process_interrupt implementations identical to their predecessor versions (v2_0, v5_0_0 respectively). This patchset removes these duplicates by exporting the original functions and reusing them.

v2:
- Replaced macro alias with direct function pointer assignment in the irq_funcs struct, as requested by Alex Deucher.

Tiago Dourado (2):
  drm/amdgpu/jpeg: deduplicate jpeg_v3_0 process_interrupt
  drm/amdgpu/jpeg: deduplicate jpeg_v5_3_0 process_interrupt

 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h   |  4 ++++
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c   | 21 +--------------------
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.h |  4 ++++
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c | 22 ++--------------------
 6 files changed, 13 insertions(+), 42 deletions(-)

-- 
2.43.0

