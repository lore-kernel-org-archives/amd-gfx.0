Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA2CDCA0ED1
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Aug 2025 09:51:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6519D10E418;
	Mon, 18 Aug 2025 09:51:53 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5B4A10E418
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Aug 2025 09:51:51 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 57I9pkZO1897323; Mon, 18 Aug 2025 15:21:46 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 57I9pkpv1897322;
 Mon, 18 Aug 2025 15:21:46 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Tom.StDenis@amd.com, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH 3/4] drm/amdgpu: dump PD address instead of GPU address of VM
 root
Date: Mon, 18 Aug 2025 15:21:45 +0530
Message-Id: <20250818095145.1897303-1-sunil.khatri@amd.com>
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

Print PD address of VM root instead of GPU address in the debugfs
so UMR tool need not workaround to get the right information of an
entry flags and other bits and not just an GPU address which hides
these bits.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 127091de0f34..a70651050acf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -2155,7 +2155,7 @@ static int amdgpu_pt_info_read(struct seq_file *m, void *unused)
 		return -EINVAL;
 	}
 
-	seq_printf(m, "gpu_address: 0x%llx\n", amdgpu_bo_gpu_offset(fpriv->vm.root.bo));
+	seq_printf(m, "pd_address: 0x%llx\n", amdgpu_gmc_pd_addr(fpriv->vm.root.bo));
 	seq_printf(m, "max_pfn: 0x%llx\n", adev->vm_manager.max_pfn);
 	seq_printf(m, "num_level: 0x%x\n", adev->vm_manager.num_level);
 	seq_printf(m, "block_size: 0x%x\n", adev->vm_manager.block_size);
-- 
2.34.1

