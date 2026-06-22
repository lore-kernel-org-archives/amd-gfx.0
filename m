Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A12E8CD98F2
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2026 14:37:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 027A210E715;
	Mon, 22 Jun 2026 14:37:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="fxrvVOz5";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3986710E633
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 14:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=xecKuYiTv9gp4aGB0mWqNh9PxMPm4U8AFGKas9vvFRY=; b=fxrvVOz542duFxNX3MqoChFQ56
 qw1QzVEp2T+CCWRMXzJnZbSsRMrtljWK6Jg9wJTt0EMRTWunTuqVwaZB+/oRduagEyWNT4Axrk2tj
 BBp7ypj3g8uH4yTnJ4M3vCmsI7Q99tgyFE20/LBa16d4R5pwEIPO6Beqod/srTvEFJtpHSb1T4EuC
 bbcCuGr7J7KWa8rfpeKOIYh3Xq0+uVySpk/wZIahyUrGyiHx8QNOAFuzF6VfmKVvw6W6S1RIv57B8
 GPLqHvLuIH/REVbMWBlghBFNNSHJREaFfEROmpklUJcWbXAZKOf2F8gul7SV1DERRi4u/wSn8RGdm
 yqA64mhQ==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wbflc-003mJo-Ll; Mon, 22 Jun 2026 16:36:52 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [RFC 0/2] Store SDMA ring instance and index in the ring
Date: Mon, 22 Jun 2026 15:36:47 +0100
Message-ID: <20260622143649.54632-1-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.54.0
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

I am not sure TBH if any workloads end up calling these often enough to matter,
but ages ago I noticed SDMA rings doing runtime lookup of "what instance am I"
by repeatedly searching the device array, and thought to float it to see if
there are any comments. At least the init path consolidation could be worth it,
although that too is not perfect.

Cc: Alex Deucher <alexander.deucher@amd.com>

Tvrtko Ursulin (2):
  drm/amdgpu: Store SDMA instance and index in the ring
  drm/amdgpu: Drop null SDMA instance checks from SDMA vfuncs

 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  6 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 51 +++++++++---------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |  6 +--
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c    |  4 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c   | 17 ++++----
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c   | 17 ++++----
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c   | 23 ++++-------
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 29 ++++++--------
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   | 21 ++++------
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c   | 22 +++++-----
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c   | 24 +++++------
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c   | 23 +++++------
 drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c   | 29 ++++++--------
 13 files changed, 112 insertions(+), 160 deletions(-)

-- 
2.54.0

