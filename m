Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0233EC52D7C
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Aug 2024 12:02:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0DDD10E4D9;
	Wed,  7 Aug 2024 12:02:29 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F2E510E4DA
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Aug 2024 12:02:28 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 477C2NEp2863977; Wed, 7 Aug 2024 17:32:23 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 477C2NQi2863976;
 Wed, 7 Aug 2024 17:32:23 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v1 1/5] drm/amdgpu: fix ptr check warning in gfx9 ip_dump
Date: Wed,  7 Aug 2024 17:32:13 +0530
Message-Id: <20240807120217.2863917-2-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240807120217.2863917-1-sunil.khatri@amd.com>
References: <20240807120217.2863917-1-sunil.khatri@amd.com>
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

Change if (ptr == NULL) to if (!ptr) for a better
format and fix the warning.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 991f7c2fc1a2..ab10a05c7885 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -2129,7 +2129,7 @@ static void gfx_v9_0_alloc_ip_dump(struct amdgpu_device *adev)
 	uint32_t inst;
 
 	ptr = kcalloc(reg_count, sizeof(uint32_t), GFP_KERNEL);
-	if (ptr == NULL) {
+	if (!ptr) {
 		DRM_ERROR("Failed to allocate memory for GFX IP Dump\n");
 		adev->gfx.ip_dump_core = NULL;
 	} else {
@@ -2142,7 +2142,7 @@ static void gfx_v9_0_alloc_ip_dump(struct amdgpu_device *adev)
 		adev->gfx.mec.num_queue_per_pipe;
 
 	ptr = kcalloc(reg_count * inst, sizeof(uint32_t), GFP_KERNEL);
-	if (ptr == NULL) {
+	if (!ptr) {
 		DRM_ERROR("Failed to allocate memory for Compute Queues IP Dump\n");
 		adev->gfx.ip_dump_compute_queues = NULL;
 	} else {
-- 
2.34.1

