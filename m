Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C3EBCDC19F
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jan 2026 14:00:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4330310E3D6;
	Tue,  6 Jan 2026 14:00:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TL8be2bi";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98BA510E4AE
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jan 2026 13:00:48 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4779cc419b2so7749835e9.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 06 Jan 2026 05:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767704447; x=1768309247; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Nbo9CTKl9iI9p+wpU++4dDR3MBazactVN245YZgjtV0=;
 b=TL8be2bi2AlgsDgU/idXWLQEPa3BBdrWebSOVNuy4RYSVqoiA91f53NQ9Y0PWvZcqH
 zeRGyHlaw550mBEQmYEOvVVng43nca2gm0XXqzsEPjeXFy9WDmKO6L8RX1+D/l7Dh+K2
 AjXGAClKgQXiIgUU+59Nz6pqsFhctgwYwezFuNkR2qm32LIyie9y/1V9t8SyDQ+8yUdC
 iHXeFtA47TLmeZFSptzmtHXzJIsvkEF/CXc9IyZWljdcrQmhotONvQJUv4HYqssDN4DP
 pKszHLWHU1Rw4NZOGNFDbaL8glqSpvCABMDyh8kcmR3kAWr8R4VW0VXOIn0nNomEySg6
 76gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767704447; x=1768309247;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nbo9CTKl9iI9p+wpU++4dDR3MBazactVN245YZgjtV0=;
 b=lnTQW5PCYc/zWYU2k3CMmJbmkZlUbL5crS9Tg10UZ/4Ko+4H2Gs+CRrb8WOAKuYNu5
 qbI9xIrmmvaPls+7p1bHG4XH91ulfpY0YgnplNkQvKkXS+peXE3k/O8hx8RsA33x2I+p
 XTW1ZMVpdgVXaxgC+ntaN+gilNPG8cLG7dlb+BWh/LI7ZiXN3IsT1aJq6uU4eVSzopEu
 uVidvfHWz4wBjBSufY2jziWx2QoZML36y/7xSmzFGmeNH2c5RcPYJlu1DYxJdhZBfq79
 8McomHw6tStpSLwnA5oylxgVKCoyla3YImDM4jGl14VaZ4zcPDgh3SR8fw00YidW3ilB
 It1g==
X-Gm-Message-State: AOJu0YzYKKRmR66h1vRoMqz8rop/OMAwpweMLBM8wJyyqS5gxeTkNmiy
 vuYU8dDeYmFE1xtlwlUBUJ1B5hPj05edkOlTUkkl8Z+nkYcQp8dyIC4H
X-Gm-Gg: AY/fxX4c9CY51ObzVSGIIsGjpDssenoJYgrPU/nhrlt9DOvJ4coMgFSyO5wlH4hnqKq
 p1wgpT5FebiUupO9TyFKYndmioNwat24FoNRvOl4q10kuWKOiov+p7KL35AFwQKQKRKZXHFVWiC
 KD5ht5lA4dFt7xuJL7wxOszNh7uQIyyDBcArKuDTf24/jGOr27CC7DjC24ogbJWPq1USfRfvpJS
 eaU+ZQ2xhxo91V1y/O6nE9viyOmAPPC+g33Hq4Le3YtQ5gobYoRkGRYsPOAg4z6I7n0ua0rDG+0
 E7k3HSAwb3qbwtykWhBZBTNGXd79F3HUurJfS9TCINouwXMp0sBUL99iV6q29XwO5Kh868FbD6F
 BP9wJ4a6zWkG3IiEF320DYOVLC2Bx5uuC/slkHG7pup4kGVdxYD1K5H9FIvEnTheOtDbWwL4FUv
 TNC87iS6rPUJptJggcpFhZqptC4bXm6Eg1vxywZbw=
X-Google-Smtp-Source: AGHT+IHhEw9eqkK1KQJPCzdybojiNr+2Qye8Rob2jwtE95qwCczcNJiecqF6pkxIxbyLsgpc1DZoEA==
X-Received: by 2002:a05:600c:4704:b0:477:b0b9:312a with SMTP id
 5b1f17b1804b1-47d7f066c43mr26446565e9.7.1767704446642; 
 Tue, 06 Jan 2026 05:00:46 -0800 (PST)
Received: from ionutnechita-arz2022.local
 ([2a02:2f0e:ca09:7000:33fc:5cce:3767:6b22])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f68f69dsm42684065e9.1.2026.01.06.05.00.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jan 2026 05:00:46 -0800 (PST)
From: "Ionut Nechita (Sunlight Linux)" <sunlightlinux@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Mario Limonciello <superm1@kernel.org>,
 Ionut Nechita <ionut_n2001@yahoo.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] drm/amdgpu: Fix TLB flush failures after hibernation
 resume
Date: Tue,  6 Jan 2026 14:59:30 +0200
Message-ID: <20260106125929.25214-3-sunlightlinux@gmail.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 06 Jan 2026 14:00:21 +0000
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

From: Ionut Nechita <ionut_n2001@yahoo.com>

Hi,

This patch addresses critical TLB flush failures that occur during
hibernation resume on AMD GPUs, particularly affecting ROCm workloads.

Problem:
--------
After resuming from hibernation (S4), the amdgpu driver consistently
fails TLB invalidation operations with these errors:

  amdgpu: TLB flush failed for PASID xxxxx
  amdgpu: failed to write reg 28b4 wait reg 28c6
  amdgpu: failed to write reg 1a6f4 wait reg 1a706

These failures cause compute workloads to malfunction or crash, making
hibernation unreliable for systems running ROCm/OpenCL applications.

Root Cause:
-----------
During resume, the KIQ (Kernel Interface Queue) ring is marked as ready
(ring.sched.ready = true) before the GPU hardware has fully initialized.
When TLB invalidation attempts to use KIQ for register access during
this window, the commands fail because the GPU is not yet stable.

Solution:
---------
This patch introduces a resume_gpu_stable flag that:
- Starts as false during resume
- Forces TLB invalidation to use the reliable MMIO path initially
- Gets set to true after ring tests pass in gfx_v9_0_cp_resume()
- Allows switching to the faster KIQ path once GPU is confirmed stable

This ensures TLB flushes work correctly during early resume while still
benefiting from KIQ-based invalidation after the GPU is fully operational.

Testing:
--------
Tested on AMD Cezanne (Renoir) with ROCm workloads across multiple
hibernation cycles. The patch eliminates all TLB flush failures and
restores reliable hibernation support for compute workloads.

Impact:
-------
Affects all AMD GPUs using KIQ for TLB invalidation, particularly
visible on systems with active compute workloads (ROCm, OpenCL).

Ionut Nechita (1):
  drm/amdgpu: Fix TLB flush failures after hibernation resume

 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  6 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c    |  9 +++++++--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c      | 10 ++++++++++
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      |  6 +++++-
 5 files changed, 29 insertions(+), 3 deletions(-)

-- 
2.52.0

