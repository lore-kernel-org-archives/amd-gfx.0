Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30DBEC54734
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Aug 2024 08:09:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB7D510E4CB;
	Wed, 28 Aug 2024 08:09:25 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FD1510E4CB
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Aug 2024 08:09:23 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 47S89IOU1498043; Wed, 28 Aug 2024 13:39:18 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 47S89Iad1498042;
 Wed, 28 Aug 2024 13:39:18 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 Trigger Huang <Trigger.Huang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH] drm/amdgpu: Move the dumping log out of for loop
Date: Wed, 28 Aug 2024 13:39:16 +0530
Message-Id: <20240828080916.1498029-1-sunil.khatri@amd.com>
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

log message "Dumping IP State Completed" needs to
be logged only once when state dumping is complete.

Hence moving it out of the for loop.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 3000a49b3e5c..381c886298bf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -39,12 +39,11 @@ static void amdgpu_job_do_core_dump(struct amdgpu_device *adev,
 	int i;
 
 	dev_info(adev->dev, "Dumping IP State\n");
-	for (i = 0; i < adev->num_ip_blocks; i++) {
+	for (i = 0; i < adev->num_ip_blocks; i++)
 		if (adev->ip_blocks[i].version->funcs->dump_ip_state)
 			adev->ip_blocks[i].version->funcs
 				->dump_ip_state((void *)adev);
-		dev_info(adev->dev, "Dumping IP State Completed\n");
-	}
+	dev_info(adev->dev, "Dumping IP State Completed\n");
 
 	amdgpu_coredump(adev, true, false, job);
 }
-- 
2.34.1

