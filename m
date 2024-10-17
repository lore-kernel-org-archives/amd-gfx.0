Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2E17D2F7D6
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Oct 2024 16:25:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0D9D10E86F;
	Thu, 17 Oct 2024 16:25:58 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8B3710E87F
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Oct 2024 16:25:56 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 49HGPnKZ1551510; Thu, 17 Oct 2024 21:55:49 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 49HGPnB21551509;
 Thu, 17 Oct 2024 21:55:49 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Leo Liu <leo.liu@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v5 04/12] drm/amdgpu: add helper function
 amdgpu_ip_block_resume
Date: Thu, 17 Oct 2024 21:55:23 +0530
Message-Id: <20241017162531.1551442-5-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241017162531.1551442-1-sunil.khatri@amd.com>
References: <20241017162531.1551442-1-sunil.khatri@amd.com>
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

Use the helper function amdgpu_ip_block_resume where
same checks and calls are repeated.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 17 +++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index df57efa019ba..fba10ad44be9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -366,6 +366,8 @@ bool amdgpu_device_ip_is_valid(struct amdgpu_device *adev,
 			      enum amd_ip_block_type block_type);
 int amdgpu_ip_block_suspend(struct amdgpu_ip_block *ip_block);
 
+int amdgpu_ip_block_resume(struct amdgpu_ip_block *ip_block);
+
 #define AMDGPU_MAX_IP_NUM 16
 
 struct amdgpu_ip_block_status {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 2d098c876151..77669eab3511 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -289,6 +289,23 @@ int amdgpu_ip_block_suspend(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
+int amdgpu_ip_block_resume(struct amdgpu_ip_block *ip_block)
+{
+	int r;
+
+	if (ip_block->version->funcs->resume) {
+		r = ip_block->version->funcs->resume(ip_block);
+		if (r) {
+			dev_err(ip_block->adev->dev,
+				"resume of IP block <%s> failed %d\n",
+				ip_block->version->funcs->name, r);
+			return r;
+		}
+	}
+
+	return 0;
+}
+
 /**
  * DOC: board_info
  *
-- 
2.34.1

