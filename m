Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B425AC19F4F
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Apr 2024 16:44:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B2A810F983;
	Fri, 26 Apr 2024 16:44:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="mZgYRzhw";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 481C810F983
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Apr 2024 16:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Ky29+U4DR6TpygkNCcPFZmran/tB0CSwfxWyT6ySLBo=; b=mZgYRzhwlfe3z/xi+VAUmcisz8
 ZjbLjisyjvHT4xGz1PeEl6gH+r/opvrCvgSLoJ222ajmbrdT9gYyNGm5HEp4UnaiYwR5KR6WOxeIR
 nKCxZ8EY9sXV6uC9voU1PeRmq86udsCcJHLo1qdB/z3oIzAJGrk/V2Yc6gQsJKmdxGeWb0f0U0SjL
 PBQeE6WqTLpIA1Rkw81YTk0IVWzE9V02AtnaxtcR0UX4DkaKwppTf0maCmwKl1il8cWJoZndWCqIK
 BVxPxhdppqJWaW+e99vkZV0drzEQgzZy7Y6j5Ai6+nKNztS6LOHz+lQmc+e2HPqIQcS6IxJJvcib2
 Xdsu/y5A==;
Received: from [84.65.0.132] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1s0OgQ-000CGr-C6; Fri, 26 Apr 2024 18:44:22 +0200
From: Tvrtko Ursulin <tursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: Fix pinned GART area accounting and fdinfo
 reporting
Date: Fri, 26 Apr 2024 17:43:55 +0100
Message-ID: <20240426164355.1563-4-tursulin@igalia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240426164355.1563-1-tursulin@igalia.com>
References: <20240426164355.1563-1-tursulin@igalia.com>
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

When commit b453e42a6e8b ("drm/amdgpu: Add new placement for preemptible
SG BOs") added a new TTM region it missed to notice the conceptual
imbalance in GART pin size accounting as done in amdgpu_bo_pin/unpin.

That imbalance leads to such objects getting accounted against the
resource, but are not un-accounted when unpinned.

Fix by extending the accounting criteria in amdgpu_bo_unpin.

What also aappears needs fixing is not reporting their size from the
amdgpu_bo_get_memory, which is used to implement fdinfo stats, so they are
not mixed with the regular userspace created and driver owned objects.

And also amdgpu_bo_print_info for debugfs reporting.

Note that the patch depends on the previous one which broke down the
relevant checks from the domain based to placement based.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Fixes: b453e42a6e8b ("drm/amdgpu: Add new placement for preemptible SG BOs")
Cc: Felix Kuehling <Felix.Kuehling@amd.com>
Cc: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index fb984669fc3a..5a2bbc793953 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1032,7 +1032,8 @@ void amdgpu_bo_unpin(struct amdgpu_bo *bo)
 		atomic64_sub(amdgpu_bo_size(bo), &adev->vram_pin_size);
 		atomic64_sub(amdgpu_vram_mgr_bo_visible_size(bo),
 			     &adev->visible_pin_size);
-	} else if (bo->tbo.resource->mem_type == TTM_PL_TT) {
+	} else if (bo->tbo.resource->mem_type == TTM_PL_TT ||
+		   bo->tbo.resource->mem_type == AMDGPU_PL_PREEMPT) {
 		atomic64_sub(amdgpu_bo_size(bo), &adev->gart_pin_size);
 	}
 
@@ -1298,7 +1299,6 @@ void amdgpu_bo_get_memory(struct amdgpu_bo *bo,
 			stats->vram_shared += size;
 		break;
 	case TTM_PL_TT:
-	case AMDGPU_PL_PREEMPT:
 		stats->gtt += size;
 		if (shared)
 			stats->gtt_shared += size;
@@ -1599,7 +1599,6 @@ u64 amdgpu_bo_print_info(int id, struct amdgpu_bo *bo, struct seq_file *m)
 				placement = "VRAM";
 			break;
 		case TTM_PL_TT:
-		case AMDGPU_PL_PREEMPT:
 			placement = "GTT";
 			break;
 		case TTM_PL_SYSTEM:
-- 
2.44.0

