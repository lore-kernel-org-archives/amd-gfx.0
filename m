Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8163BC36002
	for <amd-gfx@archiver.kernel.org>; Sun,  6 Apr 2025 23:07:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 798A010E154;
	Sun,  6 Apr 2025 23:07:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="mz6tOsaR";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E1B010E044
 for <amd-gfx@lists.freedesktop.org>; Sun,  6 Apr 2025 23:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ix0D5ijwgoY8dLuMwiKfezPucHyAHJkD52Z2Zb8jvQg=; b=mz6tOsaRL6M5GmbnbaVF24rQCQ
 LNwEsYx/c+pAsu7nnGp0NDVcj1C0oDhbv0Ov76OGUmrjt4cgCPJTBzDE/BPZkcVOiOmNQLqsh19fN
 i88cDldAXPv6bBgQ4UPWMRlAVFSTcBhm1kqoG8JsFXEJ4DF1xWDDexahzuuvrWK5xUsa0semjrCFa
 NJSXnc5yeysU/lF7Y8a4CGZF8Stg3Ped2mGTPeTZMF904yHp54yRIvJwUFehASMiJFDIpUzVCrtgY
 dhMLIavWc7t8It+rxHsInVMWBv3ZG6UFTo5j7OF0xgGHmPDL3icdKGfTUzSu2c5SgzecGkzitNS/l
 nMHRaxWw==;
Received: from d162-157-58-14.abhsia.telus.net ([162.157.58.14]
 helo=maloca.lan) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1u1Z5I-00CfEV-6c; Mon, 07 Apr 2025 01:07:24 +0200
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?=27Christian=20K=C3=B6nig=27?= <christian.koenig@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH 0/6] Introduce a generic function to get the CSB buffer
Date: Sun,  6 Apr 2025 17:02:55 -0600
Message-ID: <20250406230703.2128148-1-siqueira@igalia.com>
X-Mailer: git-send-email 2.49.0
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

This patchset was inspired and made on top of the below series:

https://lore.kernel.org/amd-gfx/20250319162225.3775315-1-alexander.deucher@amd.com/

In the above series, there is a bug fix in many functions named
gfx_vX_0_get_csb_buffer (where X ranges from 6 to 11). After closely
looking at those functions, it became clear that most of the code could
be shared from gfx6 to gfx11. Aside from the code duplication removal,
this also improves maintainability since a bug fix in a shared function
can be propagated to all ASICs.

The first patch of this series created one dedicated file for
encapsulating common GC registers (gc_common_offset.h); this series only
adds registers associated with the CSB. In the future, this file can
keep growing as we identify common registers to be shared in the
gc_common_offset.h.

The second patch introduces the generic gfx_get_csb_buffer function,
which has the same implementation found in gfx_v10_0_get_csb_buffer and
gfx_v11_0_get_csb_buffer (these two functions have the same code). After
that, every patch is dedicated to absorbing one of the csb_buffer
functions from gfx from 9 to 6; notice that some adaptations were
required.

Thanks

Rodrigo Siqueira (6):
  drm/amd/amdgpu: Create a headears to keep some common GC registers
  drm/amdgpu/gfx: Introduce generic gfx_get_csb_buffer
  drm/amdgpu/gfx: Integrate gfx_v9_0_get_csb_buffer into
    gfx_get_csb_buffer
  drm/amdgpu/gfx: Absorb gfx_v8_0_get_csb_buffer into gfx_get_csb_buffer
  drm/amdgpu/gfx: Assimilate gfx_v7_0_get_csb_buffer into
    gfx_get_csb_buffer
  drm/amdgpu/gfx: Merge gfx_v6_0_get_csb_buffer into gfx_get_csb_buffer

 Documentation/gpu/amdgpu/amdgpu-glossary.rst  |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c       | 101 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h       |   1 +
 drivers/gpu/drm/amd/amdgpu/cik.c              |   2 +
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c        |  51 +--------
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        |  53 +--------
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c         |  46 +-------
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c         |  70 +-----------
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c         |  51 +--------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c         |  43 +-------
 drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c         |   1 +
 drivers/gpu/drm/amd/amdgpu/si.c               |   2 +
 drivers/gpu/drm/amd/amdgpu/vi.c               |   2 +
 .../include/asic_reg/gc/gc_10_1_0_offset.h    |   3 -
 .../include/asic_reg/gc/gc_10_3_0_offset.h    |   3 -
 .../include/asic_reg/gc/gc_11_0_0_offset.h    |   2 -
 .../include/asic_reg/gc/gc_11_0_3_offset.h    |   2 -
 .../include/asic_reg/gc/gc_11_5_0_offset.h    |   2 -
 .../include/asic_reg/gc/gc_12_0_0_offset.h    |   2 -
 .../amd/include/asic_reg/gc/gc_9_0_offset.h   |   3 -
 .../amd/include/asic_reg/gc/gc_9_1_offset.h   |   3 -
 .../amd/include/asic_reg/gc/gc_9_2_1_offset.h |   3 -
 .../amd/include/asic_reg/gc/gc_9_4_2_offset.h |   2 -
 .../amd/include/asic_reg/gc/gc_9_4_3_offset.h |   2 -
 .../include/asic_reg/gc/gc_common_offset.h    |  11 ++
 .../drm/amd/include/asic_reg/gca/gfx_6_0_d.h  |   1 -
 .../drm/amd/include/asic_reg/gca/gfx_7_0_d.h  |   1 -
 .../drm/amd/include/asic_reg/gca/gfx_7_2_d.h  |   1 -
 .../drm/amd/include/asic_reg/gca/gfx_8_0_d.h  |   1 -
 .../drm/amd/include/asic_reg/gca/gfx_8_1_d.h  |   1 -
 30 files changed, 141 insertions(+), 328 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/gc/gc_common_offset.h

-- 
2.49.0

