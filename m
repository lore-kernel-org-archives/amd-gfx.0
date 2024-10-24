Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A99E9D0BB7D
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Oct 2024 09:23:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EA1910E8FE;
	Thu, 24 Oct 2024 09:23:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="bCFwF6Tj";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B99C10E8DC
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Oct 2024 09:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=yoplMLVu4XXbmCmU4VRkjw8HLSNIiYLanVXHEOZYaAk=; b=bCFwF6Tj7S8bockhxTGUaI0gZg
 hwM8JLzi/3KaRhnh3SFgIYSUEQxPI+HeheaoVjmfVRSSmLMazLJGkatZwTtLlSJpFi+4HchVy6WmV
 Zb9lYcfyNzrdpjBIdSXuFRSjXypNmUqR9oz+4v2KMOdq5RL5JwcFZA+AUqgAB+9xFHjFv9OBhdr/J
 tFrKYRfmwgkTG6tLTQU0KsAzjZSJw74F4cPptvTfBV81Fx2fOYPDBI/eIuq9nIV+zOIyBbYj3GhQh
 tvzn/uagEUxThzIRY+zVBBJ1whTAIFpx+0FzoQjCUM7kMLIf1catHmdl+gLjnc77oP0LPP33uDMUf
 C0zfhwVg==;
Received: from [90.241.98.187] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1t3u4K-00ERFM-9v; Thu, 24 Oct 2024 11:23:48 +0200
From: Tvrtko Ursulin <tursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Yunxiang Li <Yunxiang.Li@amd.com>, Alex Deucher <alexdeucher@gmail.com>
Subject: [RFC 4/4] drm/amdgpu: Expose special on chip memory pools in fdinfo
Date: Thu, 24 Oct 2024 10:23:41 +0100
Message-ID: <20241024092342.98760-5-tursulin@igalia.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241024092342.98760-1-tursulin@igalia.com>
References: <20241024092342.98760-1-tursulin@igalia.com>
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

In the past these specialized on chip memory pools were reported as system
memory (aka 'cpu') which was not correct and misleading. That has since
been removed so lets make them visible as their own respective memory
regions.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Yunxiang Li <Yunxiang.Li@amd.com>
Cc: Alex Deucher <alexdeucher@gmail.com>
---
It is easy to do but is it worth it I leave to AMD experts to decide.

I gave it a quick spin and have only seen all zeros when running a Steam
game.
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
index 7a9573958d87..df2cf5c33925 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
@@ -66,6 +66,10 @@ void amdgpu_show_fdinfo(struct drm_printer *p, struct drm_file *file)
 		[TTM_PL_VRAM] = "vram",
 		[TTM_PL_TT] = "gtt",
 		[TTM_PL_SYSTEM] = "cpu",
+		[AMDGPU_PL_GDS] = "gds",
+		[AMDGPU_PL_GWS] = "gws",
+		[AMDGPU_PL_OA] = "oa",
+		[AMDGPU_PL_DOORBELL] = "doorbell",
 	};
 	unsigned int hw_ip, i;
 	int ret;
@@ -87,12 +91,16 @@ void amdgpu_show_fdinfo(struct drm_printer *p, struct drm_file *file)
 
 	drm_printf(p, "pasid:\t%u\n", fpriv->vm.pasid);
 
-	for (i = 0; i < TTM_PL_PRIV; i++)
+	for (i = 0; i < ARRAY_SIZE(pl_name); i++) {
+		if (!pl_name[i])
+			continue;
+
 		drm_print_memory_stats(p,
 				       &stats[i].drm,
 				       DRM_GEM_OBJECT_RESIDENT |
 				       DRM_GEM_OBJECT_PURGEABLE,
 				       pl_name[i]);
+	}
 
 	/* Legacy amdgpu keys, alias to drm-resident-memory-: */
 	drm_printf(p, "drm-memory-vram:\t%llu KiB\n",
-- 
2.46.0

