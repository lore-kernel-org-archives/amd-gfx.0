Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AE2DE77191
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Dec 2024 11:19:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 278AA10E3A1;
	Fri, 27 Dec 2024 11:19:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="cL+i+cTx";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3A2610E07E
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Dec 2024 11:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=TNrfvEcKHxqvVPDZ4J12Bos315z1TUXnIUZt5UIvT0Q=; b=cL+i+cTxV5G4SYdkbwrWss9uuz
 LncUF8/cAc6zSV78656nZN0pZh/z3Pl78r6nEDmrbXV3bd3MY1xy48LvbfvRgig2CjjWeTn5BuLQC
 k7nK6MFh1F9s/v3rz5rDxafLfnWHMZO+UaZuUvL/NgOtbrgh1+nTfsCaz0ikkntlS99kjK2cB/nAi
 UPbUJDy/vUqSTIOGZnLAopNG30cYgAlkZjMVT1zXQg9Epg2nk6J8bED4ev0mVj3Q0DdYj8IriCmrt
 sSQESVZFienvWY98f/DGMPHZzLOy6iBC33B3vHoCNY2RGbOG4j13PSrGQJ8qI/+VsQWSbGQEVT2ED
 Jw1Kp4JA==;
Received: from [90.241.98.187] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1tR8Nh-008EG4-O6; Fri, 27 Dec 2024 12:19:49 +0100
From: Tvrtko Ursulin <tursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>
Subject: [RFC v4 00/12] Ring padding micro-optimisation etc
Date: Fri, 27 Dec 2024 11:19:26 +0000
Message-ID: <20241227111938.22974-1-tursulin@igalia.com>
X-Mailer: git-send-email 2.47.1
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

From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

[Re-send after fdo mailman got recovered out of the -ENOSPC state.]

There is a few ideas in this series and not all might stick.

Trivial stuff aside, the two main things to higlight are:

1) Ther departure from the existing state of "duplicate everything" by
consolidating some SDMA insert nop vfuncs.

2) Conversion of amdgpu_ring_write() to variadic to allow for more compact
compiled code.

For the latter I have only included VCE, GFX v10.0 and SDMA v5.2 as examples.
(But note the code shrink is already noticable with even only those three.)

But it is churny and looks different so people may not like it. TBD.

Other than those two, the remaining general idea of the series is to consolidate
the padding approach to memset32, especially on rings with 64 or 256 dword
alignment.

Binary size comparison:

    text    data     bss     dec     hex filename
 10439777   542501  188232 11170510   aa72ce amdgpu.ko.before
 10412793   542609  188232 11143634   aa09d2 amdgpu.ko.after

Cc: Christian König <christian.koenig@amd.com>
Cc: Sunil Khatri <sunil.khatri@amd.com>

Tvrtko Ursulin (12):
  drm/amdgpu: Use memset32 for IB padding
  drm/amdgpu: Use memset32 for ring clearing
  drm/amdgpu: Cache SDMA instance and index in the ring
  drm/amdgpu: Consolidate a bunch of similar sdma insert nop vfuncs
  drm/amdgpu: Use memset32 for sdma insert nops
  drm/amdgpu: Use amdgpu_ring_fill() for VPE padding
  drm/amdgpu: Convert JPEG, VCE and UVD to more efficient ring padding
  drm/amdgpu: Cache some values in ring emission helpers
  drm/amdgpu: Optimise amdgpu_ring_write()
  drm/amdgpu: Convert VCE to variadic amdgpu_ring_write()
  drm/amdgpu: Convert GFX v10.0 to variadic amdgpu_ring_write()
  drm/amdgpu: Convert SDMA v5.2 to variadic amdgpu_ring_write()

 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c |  32 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 321 +++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c |  43 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c  |  22 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c  |  13 +-
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c    |   4 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   | 399 ++++++++++++-----------
 drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c   |   8 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c   |   8 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c |   8 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c   |  24 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c   |  24 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c   |  31 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c |  31 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   |  28 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c   | 182 +++++------
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c   |  31 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c   |  31 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c    |   7 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c    |   7 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c    |   7 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c    |   7 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c    |   9 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c    |   8 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c    |   7 +-
 26 files changed, 745 insertions(+), 551 deletions(-)

-- 
2.47.1

