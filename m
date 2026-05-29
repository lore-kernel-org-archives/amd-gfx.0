Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 626D3CD5BD2
	for <amd-gfx@archiver.kernel.org>; Fri, 29 May 2026 09:34:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECDA810FBD3;
	Fri, 29 May 2026 09:34:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="X8b+uGUe";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 455B510FBCF
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 09:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=f+3ZDZqo9/jLB1XMtTFyAuAH41nBPsTbqIoQm5Y/FJU=; b=X8b+uGUesy68uDZ27J+MNiYmGC
 BxkIVIZJHIVATc5Q93a3t2qJjC4HrNPx22ynF+wmo32oJ2kczh25GrpB7j1B1slLUpL1JJ05azeEm
 vcR5ZOm0262lWMxQW4ZKHH3zHeo7LUSxVpFSKZIpb14AotvsbErxVf9A9Ks4w0CNZU9TWDDNryjwX
 ZppDv6DSmPTofOBhsLQ8+Alu6wDY4wvlo/pMT5c2xV109aed1xNtO5jZFbqkFi2F83jTTQYhGaEgW
 FVTOOYHO/rxF8HjHl+Bhh/4YWL5/gexn/VuQnr35oMGK2EkSIzjEphHIt59rzj5IZEunLk/IbZFkn
 ru+rHvRg==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wStc1-009nUG-FW; Fri, 29 May 2026 11:34:41 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 0/4] BO list handling cleanups
Date: Fri, 29 May 2026 10:34:32 +0100
Message-ID: <20260529093436.82149-1-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.54.0
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

Resurrecting some old cleanup patches which have fallen through the cracks.

Series needed a gentle rebase but they have all even been reviewed.

I *think* the reason they haven't been merged was that before I have been
"bundling" them with the context handling XArray conversion and the combined
series was failing the internal (AMD) CI. So maybe try separate now in attempt
to isolate the problem.

Cc: Christian König <christian.koenig@amd.com>

Tvrtko Ursulin (4):
  drm/amdgpu: Drop support for variable struct drm_amdgpu_bo_list_entry
    size
  drm/amdgpu: Remove the bo list mutex
  drm/amdgpu: Replace idr with xarray in amdgpu_bo_list
  drm/amdgpu: Remove output parameter in bo list handling

 drivers/gpu/drm/amd/amdgpu/amdgpu.h         |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c | 169 ++++++++------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h |  22 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c      |  67 ++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c     |  11 +-
 5 files changed, 109 insertions(+), 164 deletions(-)

-- 
2.54.0

