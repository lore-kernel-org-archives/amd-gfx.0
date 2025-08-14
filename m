Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16244CA0EE3
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Aug 2025 08:20:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6854C10E823;
	Thu, 14 Aug 2025 08:20:04 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB7E510E128
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Aug 2025 08:20:02 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 57E8D57i1336161; Thu, 14 Aug 2025 13:43:05 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 57E8D4EX1336160;
 Thu, 14 Aug 2025 13:43:04 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Tom.StDenis@amd.com, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: add more information in debugfs to pagetable
 dump
Date: Thu, 14 Aug 2025 13:42:47 +0530
Message-Id: <20250814081248.1336050-1-sunil.khatri@amd.com>
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

Add more information in the debugfs which is needed to dump
a pagetable correctly for userqueues where vmid is not known
in the kernel.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 63cd790b1d7b..6d52832fa9b6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -2136,12 +2136,14 @@ static int amdgpu_pt_info_read(struct seq_file *m, void *unused)
 	struct drm_file *file;
 	struct amdgpu_fpriv *fpriv;
 	struct amdgpu_bo *root_bo;
+	struct amdgpu_device *adev;
 	int r;
 
 	file = m->private;
 	if (!file)
 		return -EINVAL;
 
+	adev = drm_to_adev(file->minor->dev);
 	fpriv = file->driver_priv;
 	if (!fpriv || !fpriv->vm.root.bo)
 		return -ENODEV;
@@ -2154,6 +2156,10 @@ static int amdgpu_pt_info_read(struct seq_file *m, void *unused)
 	}
 
 	seq_printf(m, "gpu_address: 0x%llx\n", amdgpu_bo_gpu_offset(fpriv->vm.root.bo));
+	seq_printf(m, "max_pfn: 0x%llx\n", adev->vm_manager.max_pfn);
+	seq_printf(m, "num_level: 0x%x\n", adev->vm_manager.num_level);
+	seq_printf(m, "block_size: 0x%x\n", adev->vm_manager.block_size);
+	seq_printf(m, "fragment_size: 0x%x\n", adev->vm_manager.fragment_size);
 
 	amdgpu_bo_unreserve(root_bo);
 	amdgpu_bo_unref(&root_bo);
-- 
2.34.1

