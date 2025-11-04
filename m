Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24A7ACCFA08
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Nov 2025 14:06:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 970D410E5F1;
	Tue,  4 Nov 2025 14:06:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="K6683WI6";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBACF10E5E7
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Nov 2025 14:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=9bqd2bSs5AOUObOY1sAO8OgeHSt2It0wLL4pUYqZ6io=; b=K6683WI6Cy6ni4TMd/GyAuN/m2
 Hun9cK+IuJ3rQMWU34mHOsUaFqWRbiWiK3W8GQI0rAJHxdVKoxVqoWyE3hlGC4hU2ss/bmn5JJ9ui
 fu+Ba/2Eu1NuhXGWXNUt98uiufJA4GMyzZnf3Nrk1ZaYvBr/hHYYiMzQcG0E3Nx35f4AoeLEp9Kuz
 LmG/DRV2g1ZIZZgT6sFBsXAG8MefILqA0expEkIlnqrrHF82NoZrN7PkzfWZuk/rYq7ObRBP+EuKH
 9Je7c8mN7dqzas5kNgt8mrX5GK05vCSt5+N2FClkIe4bX3n9aY/7Lftv0irbpxT4IJXLX+oIhhsp/
 497SQKcg==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1vGHg5-001OED-F1; Tue, 04 Nov 2025 15:06:29 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Alex Deucher <alexdeucher@gmail.com>
Subject: [RFC 00/25] Grab bag of size savings, or amdgpu goes on the pen
Date: Tue,  4 Nov 2025 14:03:56 +0000
Message-ID: <20251104140421.88520-1-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.48.0
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Removing almost half a megabyte of redundant instructions is not bad for a
mornings work:

add/remove: 18/39 grow/shrink: 78/1161 up/down: 21752/-473345 (-451593)
...
Total: Before=9421643, After=8970050, chg -4.79%

Smoke tested on the Steam Deck but not very thoroughly.

Important to note is that I still do not see a problem in either VCE or UVD6
which Alex was detecting. But as I had some more shrinkage ideas I thought to
float them and see what sticks.

Also, one of the concepts from the series, the one starting in
"drm/amdgpu/sdma5.2: Use local variables more" could be replicated to more files
if there is interest for me to do so.

Otherwise I suppose I am most curious about the feedback on the SOC15 RLC and
instance map patches, since they are the ones which remove the most of
redundant code. For example it is possible I missed some important gotcha which
would make them not as simple as they currently are.

Cc: Alex Deucher <alexdeucher@gmail.com>

Tvrtko Ursulin (25):
  drm/amdgpu/vcn4.0.3: Use an existing local variable
  drm/amdgpu/jpeg3.0 Simplify idle check
  drm/amdgpu: Choose SOC15 RLC register read write functions at init
    time
  drm/amdgpu: Only calculate register offset once in SOC15 RLC
  drm/amdgpu: Extend logical to device instance lookup to all devices
  drm/amdgpu/gfx10.0: More compact reading of wave data
  drm/amdgpu/sdma5.2: Use local variables more
  drm/amdgpu/vcn2.0: Use local variables more
  drm/amdgpu/vcn3.0.0: Use local variables more
  drm/amdgpu/jpeg: Use more local variables
  drm/amdgpu: More compact VCE IB emission
  drm/amdgpu: More compact VCN IB emission
  drm/amdgpu: More compact UVD 6 IB emission
  drm/amdgpu: More compact UVD 7 IB emission
  drm/amdgpu: More compact SI SDMA emission
  drm/amdgpu: More compact CIK SDMA IB emission
  drm/amdgpu: More compact GFX 9.4.2 IB emission
  drm/amdgpu: More compact SDMA 2.4 IB emission
  drm/amdgpu: More compact SDMA 3.0 IB emission
  drm/amdgpu: More compact SDMA 4.0 IB emission
  drm/amdgpu: More compact SDMA 4.4.2 IB emission
  drm/amdgpu: More compact SDMA 5.0 IB emission
  drm/amdgpu: More compact SDMA 5.2 IB emission
  drm/amdgpu: More compact SDMA 6.0 IB emission
  drm/amdgpu: More compact SDMA 7.0 IB emission

 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   8 +-
 .../drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c   |   1 +
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c        |  49 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h        |  15 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c      |  11 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c       |  39 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h       |  10 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c       |  96 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c       | 134 ++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c       |   1 +
 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c    |   2 +-
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c         | 105 ++++---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c        |  40 ++-
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        |   2 +
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c        |   2 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c         |   2 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c       |  51 +--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c       |  10 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c      |   1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c        |   1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c        |   1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c        |   1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         |   1 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c        |   7 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c      |   1 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c      |   1 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c      |   1 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c      |   1 +
 drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c        |   1 +
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c        | 108 ++++---
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c        | 108 ++++---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c        | 109 ++++---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c      | 109 ++++---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c        | 106 ++++---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c        | 295 ++++++++++--------
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c        | 110 ++++---
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c        | 119 ++++---
 drivers/gpu/drm/amd/amdgpu/si_dma.c           |  84 +++--
 drivers/gpu/drm/amd/amdgpu/soc15_common.h     |  61 ++--
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c         |  72 +++--
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c         |  72 +++--
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c         |  72 +++--
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c         |   1 +
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c         |   9 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c         |   1 +
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c       |   3 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c       |   1 +
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c       |   1 +
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c       |   1 +
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       |   1 +
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c |   1 +
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  |   1 +
 drivers/gpu/drm/amd/ras/ras_mgr/ras_sys.h     |   7 +-
 56 files changed, 1203 insertions(+), 849 deletions(-)

-- 
2.48.0

