Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5FD0C10F1A
	for <amd-gfx@archiver.kernel.org>; Thu,  9 May 2024 11:19:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CFE210E399;
	Thu,  9 May 2024 11:19:36 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62CAC10E23F
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 May 2024 11:19:34 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 449BJTua4058412; Thu, 9 May 2024 16:49:29 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 449BJT4j4058411;
 Thu, 9 May 2024 16:49:29 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v1 4/4] drm/amdgpu: add prints while ip registr dump
Date: Thu,  9 May 2024 16:49:04 +0530
Message-Id: <20240509111904.4058197-5-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240509111904.4058197-1-sunil.khatri@amd.com>
References: <20240509111904.4058197-1-sunil.khatri@amd.com>
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

add prints before and after during ip registers
dump. It avoids user to think of system being
stuck/hung as register dump takes time after a
gpu hang.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 77f6fd50002a..45cc470058a2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5373,11 +5373,13 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
 	if (!test_bit(AMDGPU_SKIP_COREDUMP, &reset_context->flags)) {
 		amdgpu_reset_reg_dumps(tmp_adev);
 
+		dev_info(tmp_adev->dev, "Dumping IP Registers\n");
 		/* Trigger ip dump before we reset the asic */
 		for (i = 0; i < tmp_adev->num_ip_blocks; i++)
 			if (tmp_adev->ip_blocks[i].version->funcs->dump_ip_state)
 				tmp_adev->ip_blocks[i].version->funcs
 				->dump_ip_state((void *)tmp_adev);
+		dev_info(tmp_adev->dev, "Dumping IP Registers Completed\n");
 	}
 
 	reset_context->reset_device_list = device_list_handle;
-- 
2.34.1

