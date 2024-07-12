Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BBE5C3DA50
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Jul 2024 15:29:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDFD710ED36;
	Fri, 12 Jul 2024 15:29:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="rgdT30Hi";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB17210ED2A
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jul 2024 15:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=lnZnQ1KR4UXOJep6ifldXszgAzt2wkcGqTH9/dJomp8=; b=rgdT30HielYCCe3W1yAsYTSPfk
 KPSObjSnQGbC+cbCKd/qHE64yTzZr5Ln0oB2n63l+/Wpi9aU92N7f+u2WRBTwQc+/MowW5X2K3Mw8
 FbcnDDQDNhJ3L+tPs6kO8zmA6Wdn/cVixb31LaUpLOnyoh+OvHICpDwUV83nMkSEjASXGQhhuG+T7
 EAEpASIE9nXbTcwduixK6UIvnx/oaLK9a1XbSdkYktUMcnvDjZQf0VehiRFKpuvNwJbXpo71641y3
 cbi3PCTLRobI2NRDmMwGEHfiZf0dcWkTjk2+GnIcOkjUOvyx8SRyQavoLw2JKLrJbZtDzUaHe9FKB
 1XMge67Q==;
Received: from [84.69.19.168] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1sSICf-00ENIq-Js; Fri, 12 Jul 2024 17:28:57 +0200
From: Tvrtko Ursulin <tursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Subject: [PATCH 0/3] Ring commit and padding micro-optimisations
Date: Fri, 12 Jul 2024 16:28:52 +0100
Message-ID: <20240712152855.45284-1-tursulin@igalia.com>
X-Mailer: git-send-email 2.44.0
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

A three patches to streamline the ring nop padding process which happens on
every submission.

I smoke tested graphics and video decode on the Steam Deck but cannot do much
more testing than that. Therefore no guarantees I did not break something.


Cc: Christian König <ckoenig.leichtzumerken@gmail.com>

Tvrtko Ursulin (3):
  drm/amdpgu: Micro-optimise amdgpu_ring_commit
  drm/amdgpu: More efficient ring padding
  drm/amdpug: More more efficient ring padding

 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 24 +++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 58 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c  | 13 +++---
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c    | 15 +++---
 drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c   |  7 +--
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c   |  7 +--
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c |  7 +--
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c   | 16 ++++---
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c   | 16 ++++---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c   | 16 ++++---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 16 ++++---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   | 16 ++++---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c   | 16 ++++---
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c   | 16 ++++---
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c   | 16 ++++---
 drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c    |  7 +--
 drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c    |  7 +--
 drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c    |  7 +--
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c    |  7 +--
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c    |  8 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c    |  8 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c    |  6 +--
 22 files changed, 176 insertions(+), 133 deletions(-)

-- 
2.44.0

