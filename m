Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98343CA0EFF
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Aug 2025 00:48:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EC1510E225;
	Mon, 25 Aug 2025 00:48:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="c+R+ADoJ";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0975910E057
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Aug 2025 00:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=/r9LAkYPK+vHMBzLDptuNIpNrYn1ubBGAGKuMYwCkCA=; b=c+R+ADoJJN3OIrLv9ptfWA3Rbn
 M7ofG7fRzsjDHnvA+O/z2sO5ry3MZfJM17jiljyluFXTLotnd2p8D8Uz2IppwNfar0A4AUVuyD0eB
 sooqDJEbJibh8T9ttuVT2aiEw6JyWtBYBqHQlBBSKr+xpCT1RyxGr3KVwE8TrFU7I9ehyEHRjyt9H
 c6876tKJDhO15QZoOfk05gAnDx392RKd33r2f7GS6H6Zjodq6mxy3WMO8HX8W+lzM89CKsmHG/eei
 /QkpcYWa3cJnp8SSDoJMsKQJVT9Nn1p2nqZyM90JM5r9ksR1xs33l0F0W0IXjKuozpY5kgpPfDv/7
 3b4dMzig==;
Received: from [104.193.135.201] (helo=debian.lan)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1uqLNd-001AML-8C; Mon, 25 Aug 2025 02:48:13 +0200
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Alex Deucher <alexander.deucher@amd.com>, James Zhu <James.Zhu@amd.com>,
 Jesse Zhang <jesse.zhang@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH v2 0/2] Add some adjustment for VCN 4.0.3 and 5.0.1
Date: Sun, 24 Aug 2025 18:46:39 -0600
Message-ID: <20250825004800.3851474-1-siqueira@igalia.com>
X-Mailer: git-send-email 2.47.2
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

While I was looking into the ring buffer interface, I noticed some minor
issues in the VCN 4.0.3 and 5.0.1. This series has some code
improvements in those two components.

Changes since V1:
After Alex's feedback, this second version changed a lot, but I decided
to send this as a V2 to make it easy to follow the series evolution.
Follows the change summary:
- Patch 1: Rewrite the patch to describe VCN 4.0.3-specific behavior.
- Patch 2: Change amdgpu_vcn_sw_fini() return to void, and add the required modification.
Link to V1: https://patchwork.freedesktop.org/series/153016/

Thanks

Rodrigo Siqueira (2):
  drm/amdgpu/vcn: Document IRQ per-instance irq behavior for VCN 4.0.3
  drm/amdgpu/vcn: Change amdgpu_vcn_sw_fini return to void

 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c |  6 ++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c   |  4 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   |  4 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   |  4 +---
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   |  4 +---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   |  7 ++-----
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 13 +++++++------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c |  4 +---
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c |  7 ++-----
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c |  9 +++------
 11 files changed, 24 insertions(+), 40 deletions(-)

-- 
2.47.2

