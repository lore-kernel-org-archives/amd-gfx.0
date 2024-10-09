Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD856CED62B
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Oct 2024 08:48:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71D7B10E691;
	Wed,  9 Oct 2024 08:48:34 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5660410E277
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Oct 2024 08:48:32 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 4998mRV5828250; Wed, 9 Oct 2024 14:18:27 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 4998mQot828249;
 Wed, 9 Oct 2024 14:18:26 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: validate if sw_init is defined or NULL
Date: Wed,  9 Oct 2024 14:18:22 +0530
Message-Id: <20241009084823.828235-1-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
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

Before making a function call to sw_init, validate
the function pointer.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 38a7423101f3..4a6def74964e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2851,13 +2851,15 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 	for (i = 0; i < adev->num_ip_blocks; i++) {
 		if (!adev->ip_blocks[i].status.valid)
 			continue;
-		r = adev->ip_blocks[i].version->funcs->sw_init(&adev->ip_blocks[i]);
-		if (r) {
-			DRM_ERROR("sw_init of IP block <%s> failed %d\n",
+		if (adev->ip_blocks[i].version->funcs->sw_init) {
+			r = adev->ip_blocks[i].version->funcs->sw_init(&adev->ip_blocks[i]);
+			if (r) {
+				DRM_ERROR("sw_init of IP block <%s> failed %d\n",
 				  adev->ip_blocks[i].version->funcs->name, r);
-			goto init_failed;
+				goto init_failed;
+			}
+			adev->ip_blocks[i].status.sw = true;
 		}
-		adev->ip_blocks[i].status.sw = true;
 
 		if (!amdgpu_ip_member_of_hwini(
 			    adev, adev->ip_blocks[i].version->type))
-- 
2.34.1

