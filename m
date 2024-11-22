Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22AE6E65D2F
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Nov 2024 08:03:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6D2010E0D8;
	Fri, 22 Nov 2024 08:03:46 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D65010E0D8
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Nov 2024 08:03:45 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 4AM83epc2740517; Fri, 22 Nov 2024 13:33:40 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 4AM83e0i2740516;
 Fri, 22 Nov 2024 13:33:40 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v2 2/2] drm/amdgpu: add "restore" missing variable comment
Date: Fri, 22 Nov 2024 13:33:36 +0530
Message-Id: <20241122080336.2740473-2-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241122080336.2740473-1-sunil.khatri@amd.com>
References: <20241122080336.2740473-1-sunil.khatri@amd.com>
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

add "restore" missing variable in the fucntions
sdma_v4_4_2_page_resume and sdma_v4_4_2_inst_start.

This fixes the warning:
warning: Function parameter or struct member 'restore' not described in 'sdma_v4_4_2_page_resume'
warning: Function parameter or struct member 'restore' not described in 'sdma_v4_4_2_inst_start'

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index e70460693ef2..e1674da07c23 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -764,6 +764,7 @@ static void sdma_v4_4_2_gfx_resume(struct amdgpu_device *adev, unsigned int i, b
  *
  * @adev: amdgpu_device pointer
  * @i: instance to resume
+ * @restore: boolean to say restore needed or not
  *
  * Set up the page DMA ring buffers and enable them.
  * Returns 0 for success, error for failure.
@@ -928,6 +929,7 @@ static int sdma_v4_4_2_inst_load_microcode(struct amdgpu_device *adev,
  *
  * @adev: amdgpu_device pointer
  * @inst_mask: mask of dma engine instances to be enabled
+ * @restore: boolean to say restore needed or not
  *
  * Set up the DMA engines and enable them.
  * Returns 0 for success, error for failure.
-- 
2.34.1

