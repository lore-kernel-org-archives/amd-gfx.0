Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0791C4345F
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Apr 2024 10:23:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45F8110E9A3;
	Thu, 25 Apr 2024 10:23:33 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0586110E984
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Apr 2024 10:23:30 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 43PANK7e014910; Thu, 25 Apr 2024 15:53:20 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 43PANJXg014906;
 Thu, 25 Apr 2024 15:53:19 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Ahmad Rehman <Ahmad.Rehman@amd.com>, Lijo Lazar p <lijo.lazar@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH] drm/amdgpu: skip ip dump if devcoredump flag is set
Date: Thu, 25 Apr 2024 15:53:18 +0530
Message-Id: <20240425102318.14883-1-sunil.khatri@amd.com>
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

Do not dump the ip registers during driver reload
in passthrough environment.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 869256394136..b50758482530 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5372,10 +5372,12 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
 		amdgpu_reset_reg_dumps(tmp_adev);
 
 	/* Trigger ip dump before we reset the asic */
-	for (i = 0; i < tmp_adev->num_ip_blocks; i++)
-		if (tmp_adev->ip_blocks[i].version->funcs->dump_ip_state)
-			tmp_adev->ip_blocks[i].version->funcs->dump_ip_state(
-				(void *)tmp_adev);
+	if (!test_bit(AMDGPU_SKIP_COREDUMP, &reset_context->flags)) {
+		for (i = 0; i < tmp_adev->num_ip_blocks; i++)
+			if (tmp_adev->ip_blocks[i].version->funcs->dump_ip_state)
+				tmp_adev->ip_blocks[i].version->funcs
+				->dump_ip_state((void *)tmp_adev);
+	}
 
 	reset_context->reset_device_list = device_list_handle;
 	r = amdgpu_reset_perform_reset(tmp_adev, reset_context);
-- 
2.34.1

