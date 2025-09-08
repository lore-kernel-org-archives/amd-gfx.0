Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D8D6CAC582
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Sep 2025 23:22:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBCDB10E129;
	Mon,  8 Sep 2025 23:22:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="HWerh8wo";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95BB010E129
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Sep 2025 23:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=P2poaKwHyHafCuJ1spGR+Asemhpqf4VGzJGS3HYY5Z0=; b=HWerh8wo/dUEdzfi6yckfULZIg
 KmBmORHiMPO4A9R0Kfp1kIsiDNM1LYjzM7gn4Ea4WD2HSC52atZhOCGgT1PsKY7mePu2cKr6gtY26
 ccnim42qdUhPee7nQv/uXtkI/cxEKMYuSCMJs+QqWxSATkcbCFy6JJvfZPqaQdHEoqRJfpvsMNidr
 cCzKgYTjuLWatC3iEtC5asfSao7de9rPR3DlQdh0ZqjoQnQVywvM6MerLrACq207rMIuhnTDLExP0
 UhWLv1lveqWplWORlB4QNoup079BADRrO3IXWAxAxmS5SDSclfuaErpnzk8HHUQULlvw48ltPBtSl
 V2AaWOqw==;
Received: from [104.193.135.201] (helo=debian.lan)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1uvlBa-008iqD-4d; Tue, 09 Sep 2025 01:22:10 +0200
From: Rodrigo Siqueira <siqueira@igalia.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH 0/5] Remove multiple instances of volatile from amdgpu
Date: Mon,  8 Sep 2025 17:15:35 -0600
Message-ID: <20250908232134.2223198-1-siqueira@igalia.com>
X-Mailer: git-send-email 2.50.1
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

In a series that reworked the CSB manipulation, Christian noticed the
use of volatile in some of the function parameters and pointed out that
the use of volatile in amdgpu is probably wrong [1]. He also shared the
following link about this topic:

  https://docs.kernel.org/process/volatile-considered-harmful.html

After reading the documentation and inspecting multiple parts of the
code, this series was created to remove many parts that use volatile.
The three rare cases where volatile should be used served as a guide for
making this series.

[1] https://lore.kernel.org/amd-gfx/b1c2d811-132a-47e5-a13f-086125b849b5@amd.com/

Thanks

Rodrigo Siqueira (5):
  drm/amdgpu: Remove volatile from CSB functions
  drm/amdgpu: Remove volatile from RLC files
  drm/amdgpu: Remove volatile from ring manipulation
  drm/amdgpu: Remove volatile from amdgpu and amdgpu_ih headers
  drm/amdgpu: Remove volatile references from VCN

 drivers/gpu/drm/amd/amdgpu/amdgpu.h      |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c  |  6 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h  |  6 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h   |  6 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 12 ++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c  |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h  |  8 ++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c  | 10 +++++-----
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   |  5 ++---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c   |  5 ++---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c   |  5 ++---
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c    |  7 +++----
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c    |  5 ++---
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c    |  3 +--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    |  3 +--
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c    | 10 +++++-----
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c    | 10 +++++-----
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c    | 12 ++++++------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c    | 14 +++++++-------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c  | 12 ++++++------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c  | 10 +++++-----
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c  | 10 +++++-----
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c  | 12 ++++++------
 24 files changed, 87 insertions(+), 94 deletions(-)

-- 
2.50.1

