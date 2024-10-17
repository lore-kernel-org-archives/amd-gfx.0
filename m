Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46024D21278
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Oct 2024 10:06:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F392F10E7DC;
	Thu, 17 Oct 2024 10:06:25 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A31A10E7D6
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Oct 2024 10:06:23 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 49HA6IFP1492188; Thu, 17 Oct 2024 15:36:18 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 49HA6IL61492187;
 Thu, 17 Oct 2024 15:36:18 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v4 03/15] drm/amdgpu: validate sw_fini before function call
Date: Thu, 17 Oct 2024 15:36:03 +0530
Message-Id: <20241017100615.1492144-4-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241017100615.1492144-1-sunil.khatri@amd.com>
References: <20241017100615.1492144-1-sunil.khatri@amd.com>
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

Before making a function call to sw_fini, validate
the function pointer like we do in sw_init.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 782f01ab39e2..cf84b50f2355 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3379,12 +3379,13 @@ static int amdgpu_device_ip_fini(struct amdgpu_device *adev)
 			amdgpu_ib_pool_fini(adev);
 			amdgpu_seq64_fini(adev);
 		}
-
-		r = adev->ip_blocks[i].version->funcs->sw_fini(&adev->ip_blocks[i]);
-		/* XXX handle errors */
-		if (r) {
-			DRM_DEBUG("sw_fini of IP block <%s> failed %d\n",
-				  adev->ip_blocks[i].version->funcs->name, r);
+		if (adev->ip_blocks[i].version->funcs->sw_fini) {
+			r = adev->ip_blocks[i].version->funcs->sw_fini(&adev->ip_blocks[i]);
+			/* XXX handle errors */
+			if (r) {
+				DRM_DEBUG("sw_fini of IP block <%s> failed %d\n",
+					  adev->ip_blocks[i].version->funcs->name, r);
+			}
 		}
 		adev->ip_blocks[i].status.sw = false;
 		adev->ip_blocks[i].status.valid = false;
-- 
2.34.1

