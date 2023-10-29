Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8160C4332F
	for <amd-gfx@archiver.kernel.org>; Sun, 29 Oct 2023 22:56:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7574A10E19D;
	Sun, 29 Oct 2023 22:56:22 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26D8110E1AB;
 Sun, 29 Oct 2023 22:56:20 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 82CBC60ED8;
 Sun, 29 Oct 2023 22:56:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CC04C43395;
 Sun, 29 Oct 2023 22:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1698620179;
 bh=1kR/CjoxHbIlGsir+rK7ZCbvL48WL1v8bLuqsLL3sds=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=qXShCsmf2ThUHKcpIoHfKv9dt4/ldtvRy9eMB4o4fBFgKnPb2E9yt+a3OCI7qC2y+
 0dxHG4CCMsuNZ/UU2ZyuG/8c316Gkrjo3N2MZ3F9jBwfOG0plAS9emrNNmZWgRx3t/
 Ly7jfoYC3wSvbcn5lYFVEelHRalk7W36WQT6VOPYJlMh5xzmIf0gG+5Q+rtNm58/JD
 HCMWxafr6eJ1Qk9klrabRIWRr9m61SdXvfIe++MiLMDXAjhThl6akYQWGdYWwlCT4Y
 2khIlO9/zIhkLS4/tx/M3vdJA4fhpYNoZ6d6SWAiK1Vt6qcz4Dyw4CJ8pPJ9K6j9WO
 NSorb8npxiJ4A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 6.5 39/52] gpu/drm: Eliminate DRM_SCHED_PRIORITY_UNSET
Date: Sun, 29 Oct 2023 18:53:26 -0400
Message-ID: <20231029225441.789781-39-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231029225441.789781-1-sashal@kernel.org>
References: <20231029225441.789781-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.9
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
Cc: Sasha Levin <sashal@kernel.org>, pierre-eric.pelloux-prayer@amd.com,
 lijo.lazar@amd.com, dri-devel@lists.freedesktop.org, Xinhui.Pan@amd.com,
 amd-gfx@lists.freedesktop.org, Luben Tuikov <luben.tuikov@amd.com>,
 zhenguo.yin@amd.com, daniel@ffwll.ch, alexander.deucher@amd.com,
 James.Zhu@amd.com, airlied@gmail.com,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Luben Tuikov <luben.tuikov@amd.com>

[ Upstream commit fa8391ad68c16716e2c06ada397e99ceed2fb647 ]

Eliminate DRM_SCHED_PRIORITY_UNSET, value of -2, whose only user was
amdgpu. Furthermore, eliminate an index bug, in that when amdgpu boots, it
calls drm_sched_entity_init() with DRM_SCHED_PRIORITY_UNSET, which uses it to
index sched->sched_rq[].

Cc: Alex Deucher <Alexander.Deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
Acked-by: Alex Deucher <Alexander.Deucher@amd.com>
Link: https://lore.kernel.org/r/20231017035656.8211-2-luben.tuikov@amd.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 3 ++-
 include/drm/gpu_scheduler.h             | 3 +--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index 092962b93064f..aac52d9754e6d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -64,7 +64,8 @@ amdgpu_ctx_to_drm_sched_prio(int32_t ctx_prio)
 {
 	switch (ctx_prio) {
 	case AMDGPU_CTX_PRIORITY_UNSET:
-		return DRM_SCHED_PRIORITY_UNSET;
+		pr_warn_once("AMD-->DRM context priority value UNSET-->NORMAL");
+		return DRM_SCHED_PRIORITY_NORMAL;
 
 	case AMDGPU_CTX_PRIORITY_VERY_LOW:
 		return DRM_SCHED_PRIORITY_MIN;
diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
index f9544d9b670d3..ac65f0626cfc9 100644
--- a/include/drm/gpu_scheduler.h
+++ b/include/drm/gpu_scheduler.h
@@ -68,8 +68,7 @@ enum drm_sched_priority {
 	DRM_SCHED_PRIORITY_HIGH,
 	DRM_SCHED_PRIORITY_KERNEL,
 
-	DRM_SCHED_PRIORITY_COUNT,
-	DRM_SCHED_PRIORITY_UNSET = -2
+	DRM_SCHED_PRIORITY_COUNT
 };
 
 /* Used to chose between FIFO and RR jobs scheduling */
-- 
2.42.0

