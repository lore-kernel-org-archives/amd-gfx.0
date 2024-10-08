Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C818CEFC23
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Oct 2024 15:05:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CD3010E579;
	Tue,  8 Oct 2024 15:05:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="GaORHnJ1";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EEA310E576
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Oct 2024 15:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=U/d1CJ2rpfi49lrD2ilrXq0unQpHBjslHOoYK/zpjEM=; b=GaORHnJ1a4Y3ZrawckoSzhwUpw
 pLdCMVA+2xB9v2vR4dOaocSFpUZ13RERijA3z4wWr87Z8zjWnuORam7WBSOdRTSzlQaHwCWZXvNEu
 wm4HU+R38Lf8Jc1s/wIUG3Ex+AyCL4BHhoyK6nOkME6PnPcP0c+ncgT7RFLO0mYE+S1H9Bsd9Je4C
 0ae17QcTras/Ye0sIus44SiDcV/amYm9sadmTl6ZLRXzAU61Jx/nSd3YMBfmcm95/E89nqGEk37IH
 vvr1IAQG0hBKhvkC8kAbOHDseAaAGCZdFQ/j4Jeu3Bud2J3DjBiOvkZbhULw+b0g8sJEQugjIEaHv
 +f47p1+A==;
Received: from [90.241.98.187] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1syBmU-006bkl-B2; Tue, 08 Oct 2024 17:05:46 +0200
From: Tvrtko Ursulin <tursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH 0/4] Ring padding CPU optimisation and some RFC bits
Date: Tue,  8 Oct 2024 16:05:28 +0100
Message-ID: <20241008150532.23661-1-tursulin@igalia.com>
X-Mailer: git-send-email 2.46.0
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

I've noticed the hardware ring padding optimisations have landed so I decided
to respin the CPU side optimisations.

First two patches are simply adding ring fill helpers which deal with reducing
the CPU cost of emitting hundreds of nops from the for-amdgpu_ring_write loops.

If receptive for the idea, please double-check I preserved endianess behaviour
as is.

Last two patches are new and RFC. Both are incomplete conversion to two new
helpers intended to deal with an often repeated pattern of:

-               amdgpu_ring_write(ring, lower_32_bits(addr));
-               amdgpu_ring_write(ring, upper_32_bits(addr));
+               amdgpu_ring_write_addr(ring, addr);

Last patch is the most uncertain one where there seems to be some magic bit
used only on big endian. It has no name so I couldn't figure out what it was
about.

-       amdgpu_ring_write(ring,
-#ifdef __BIG_ENDIAN
-                               (2 << 0) |
-#endif
-                               lower_32_bits(ib->gpu_addr));
-       amdgpu_ring_write(ring, upper_32_bits(ib->gpu_addr));
+       amdgpu_ring_write_addr_xbe(ring, ib->gpu_addr);

Anyway, both patterns have a lot of users so reductions in source code and
binary size aside, main question is do these kind of helpers improve readability
or are making it worse.

(Note that the _xbe name in the last patch is just a placeholder.)

Cc: Christian König <ckoenig.leichtzumerken@gmail.com>
Cc: Sunil Khatri <sunil.khatri@amd.com>

Tvrtko Ursulin (4):
  drm/amdgpu: More efficient ring padding
  drm/amdgpu: More more efficient ring padding
  drm/amdgpu: Add and use amdgpu_ring_write_addr() helper
  drm/amdgpu: Document the magic big endian bit

 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c |  19 ++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 101 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c  |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c  |  25 +++---
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c    |  27 +++---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   |  66 +++++----------
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c   |  60 +++++---------
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c   |  45 ++++------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    |  63 +++++---------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c  |  48 ++++-------
 drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c   |   8 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c   |   8 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c |   8 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c   |  16 ++--
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c   |  16 ++--
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c   |  16 ++--
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c |  16 ++--
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   |  16 ++--
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c   |  16 ++--
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c   |  16 ++--
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c   |  16 ++--
 drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c    |   7 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c    |   7 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c    |   7 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c    |   7 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c    |   9 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c    |   8 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c    |   7 +-
 28 files changed, 319 insertions(+), 345 deletions(-)

-- 
2.46.0

