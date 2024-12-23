Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00C8AE7718E
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Dec 2024 16:39:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 930F810E57D;
	Mon, 23 Dec 2024 16:39:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="OpLe75P9";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9515B10E57D
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Dec 2024 16:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=odyIiMY+fJi4Xvj2M0QM0nlZ1wjfdzKtIAW1q+9vAOY=; b=OpLe75P9vFjJ9EnAHjSSeBAGJY
 a2xs33X/ZCaDdXqtLgARt/Y0jktKmnXev62X3O9dhSYbwAlQi3k89PUB1C28qP5eYYa/Ma6CoNXi+
 He1meztGrLvxZ9LuZwVY7UaTH9onqpMvvb4aDinu7ByOWkkRH1STti9B9rEEgIu7OiSKpJzgbq4kJ
 QLA6WQVWXgdendrFMrayFgine62+L7zkug7wqi3oIIRtdPJg2aktzzao4ej8Ek3I8pGtIijYSogjf
 mb5LxYd3wZ5vRl9x669C+9JZOT7ig0L7aKwAaJNabw4Gg5bx3w+SOCN2opBJBAcP6eUfHVm5Mmawp
 cMTUGcfw==;
Received: from [90.241.98.187] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1tPlSo-006tt1-IK; Mon, 23 Dec 2024 17:39:26 +0100
From: Tvrtko Ursulin <tursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v3 0/3] Ring padding micro-optimisation etc
Date: Mon, 23 Dec 2024 16:39:10 +0000
Message-ID: <20241223163913.38767-1-tursulin@igalia.com>
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

I have finally rebased my old series from July and October on top of the similar
approach Sunil landed in October but limited to GFX rings.

This covers SDMA and VPE (as an outlier, because it uses the same helper), plus
contains a patch to cache the SDMA instance in the ring since I've noticed the
constant use of amdgpu_sdma_get_instance_from_ring() from SDMA vfuncs looked a
bit lazy. And again, also to use the same approach, memset32 for IB padding.

I don't know what is the maximum padding for SDMA but at least on the Steam
Deck 10 dwords seems rather typical, so that, coupled with the fact it is just
nicer to use the same approach across the rings, I thought it makes sense to do
this.

For now I have dropped the patch which added the memset64 based padding for UVD,
JPEG and VCN rings. I can re-surface that one later if people will be
interested.

Cc: Christian König <christian.koenig@amd.com>
Cc: Sunil Khatri <sunil.khatri@amd.com>

Tvrtko Ursulin (3):
  drm/amdgpu: Use memset32 for padding IB ring
  drm/amdgpu: Use efficient ring padding with more rings
  drm/amdgpu: Cache SDMA instance and index in the ring

 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 56 +++++++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  7 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 39 ++---------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |  3 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c  | 16 ++++---
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c    | 19 ++++----
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c   | 20 +++++----
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c   | 20 +++++----
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c   | 20 +++++----
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 20 +++++----
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   | 24 +++++-----
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c   | 27 ++++++------
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c   | 27 ++++++------
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c   | 27 ++++++------
 14 files changed, 173 insertions(+), 152 deletions(-)

-- 
2.47.1

