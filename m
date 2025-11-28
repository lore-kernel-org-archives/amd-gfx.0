Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 395A1D116E2
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Nov 2025 15:08:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E4E510E7D8;
	Fri, 28 Nov 2025 15:08:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="U7ExveDd";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8588410E7D8
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Nov 2025 15:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=xWuhUs/orbUOzH/iWFF6o6bPTaU/+ittfS/NbNNS+MI=; b=U7ExveDdF8kVK+li5UMGBn5+Sx
 WWbfM7yNG+HcrQzbpBj3XZYU11gO5SFHFAYEe16m1KhRoyIuU3/95E+Hqd5Oco1o/fjYShYwjoHfl
 zDFU9LrqsQZnofQhTjCRA74DZ9IfKxwh0NWxEtMl1tbB1AiKZmX+bpmMA1sWxfu5ckj/4Pn7U1iyn
 Vlvj3fLJb9qKB7MXS16fJqyR0Cns1W9RAz4OHVWj2G5mf6/utk12tMnfkzjxL5/iOyUEeNc7fTBCm
 KtNDNNBrVksrBeL6hkXm6XOH675d7o4GnErq5gwUri6vaBzvBrZITTKQEZLZJn70GFTjid3hNY77k
 qZ/2qDvg==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with utf8esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1vP053-006UkU-P7; Fri, 28 Nov 2025 16:08:17 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Melissa Wen <mwen@igalia.com>, Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH] drm/amdgpu: Allow direct CPU drawing of DRM panic on APUs
Date: Fri, 28 Nov 2025 15:08:14 +0000
Message-ID: <20251128150814.11612-1-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.51.1
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

There is no need to draw the panic screen via the slow MMIO access on
APUs, since the frame buffer is guaranteed to be CPU accessible.

Lets skip setting the .set_pixel method which allows the DRM panic core to
just work and it renders much more quickly.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: Melissa Wen <mwen@igalia.com>
Cc: Rodrigo Siqueira <siqueira@igalia.com>
---
FWIW this draws the panic faster, but.. the whole DRM panic setup only
appears to work with non-tiled modes. There is something broken in the 
dcn10_reset_surface_dcc_and_tiling() code with "more advanced" modes
where thing the turning off compression seems to trigger some weird
display engine behaviour. (On the Steam Deck at least.)
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index b5d34797d606..7f75f1319d3f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -1900,7 +1900,8 @@ int amdgpu_display_get_scanout_buffer(struct drm_plane *plane,
 
 	sb->pitch[0] = fb->pitches[0];
 
-	if (abo->flags & AMDGPU_GEM_CREATE_NO_CPU_ACCESS) {
+	if (!(amdgpu_ttm_adev(abo->tbo.bdev)->flags & AMD_IS_APU) &&
+	    (abo->flags & AMDGPU_GEM_CREATE_NO_CPU_ACCESS)) {
 		if (abo->tbo.resource->mem_type != TTM_PL_VRAM) {
 			drm_warn(plane->dev, "amdgpu panic, framebuffer not in VRAM\n");
 			return -EINVAL;
-- 
2.51.1

