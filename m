Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBB4CC624A4
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 16:17:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CA2910E2F6;
	Mon, 31 Aug 2026 16:17:37 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.217.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1491410E2F6
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 16:17:35 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 67VGHPtK1559878; Mon, 31 Aug 2026 21:47:25 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 67VGHPq91559877;
 Mon, 31 Aug 2026 21:47:25 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH] drm/amdgpu/userq: add a warning if fw does not support
 userqueues
Date: Mon, 31 Aug 2026 21:47:24 +0530
Message-Id: <20260831161724.1559858-1-sunil.khatri@amd.com>
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

Creating a queue could fail due to various reasons and returning
-EINVAL does not suffice in case where fw does not support the uq's

It's better to add a one time log that saves unnecessary debug effort.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 4c6e080671a7..f16af852725a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -659,6 +659,24 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 
 	uq_funcs = adev->userq_funcs[args->in.ip_type];
 	if (!uq_funcs) {
+		switch (args->in.ip_type) {
+		case AMDGPU_HW_IP_GFX:
+		case AMDGPU_HW_IP_COMPUTE:
+			dev_warn_once(adev->dev,
+				      "Usermode queues for GFX/COMPUTE is not supported by the fw "
+				      "on this ASIC (me: %u, pfp: %u, mec: %u, mes: %u)\n",
+				      adev->gfx.me_fw_version, adev->gfx.pfp_fw_version,
+				      adev->gfx.mec_fw_version, adev->mes.fw_version[0]);
+			break;
+		case AMDGPU_HW_IP_DMA:
+			dev_warn_once(adev->dev,
+				      "Usermode queues for SDMA is not supported by the fw "
+				      "on this ASIC (sdma: %u)\n",
+				      adev->sdma.instance[0].fw_version);
+			break;
+		default:
+			break;
+		}
 		r = -EINVAL;
 		goto err_pm_runtime;
 	}
-- 
2.34.1

