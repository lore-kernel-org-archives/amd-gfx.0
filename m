Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7717EC43217
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Dec 2021 23:30:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7135310E901;
	Mon, 13 Dec 2021 23:30:40 +0000 (UTC)
Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [IPv6:2a01:e0c:1:1599::14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E746D10E8EA
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Dec 2021 23:30:38 +0000 (UTC)
Received: from localhost.localdomain (unknown [88.120.44.86])
 by smtp5-g21.free.fr (Postfix) with ESMTP id BFA0A5FF95;
 Tue, 14 Dec 2021 00:30:36 +0100 (CET)
From: Yann Dirson <ydirson@free.fr>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v3 4/4] amdgpu: fix some comment typos
Date: Tue, 14 Dec 2021 00:30:30 +0100
Message-Id: <20211213233030.6719-5-ydirson@free.fr>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211213233030.6719-1-ydirson@free.fr>
References: <20211213233030.6719-1-ydirson@free.fr>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Yann Dirson <ydirson@free.fr>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, linux-doc@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Signed-off-by: Yann Dirson <ydirson@free.fr>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/soc15.c     | 2 +-
 include/uapi/drm/amdgpu_drm.h          | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 0e7dc23f78e7..b23cb463b106 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -53,7 +53,7 @@
  * can be mapped as snooped (cached system pages) or unsnooped
  * (uncached system pages).
  * Each VM has an ID associated with it and there is a page table
- * associated with each VMID.  When execting a command buffer,
+ * associated with each VMID.  When executing a command buffer,
  * the kernel tells the the ring what VMID to use for that command
  * buffer.  VMIDs are allocated dynamically as commands are submitted.
  * The userspace drivers maintain their own address space and the kernel
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index a06c4944ed37..0fc1747e4a70 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -744,7 +744,7 @@ static void soc15_reg_base_init(struct amdgpu_device *adev)
 		vega10_reg_base_init(adev);
 		break;
 	case CHIP_RENOIR:
-		/* It's safe to do ip discovery here for Renior,
+		/* It's safe to do ip discovery here for Renoir,
 		 * it doesn't support SRIOV. */
 		if (amdgpu_discovery) {
 			r = amdgpu_discovery_reg_base_init(adev);
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 26e45fc5eb1a..0b94ec7b73e7 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -80,7 +80,7 @@ extern "C" {
  *
  * %AMDGPU_GEM_DOMAIN_GTT	GPU accessible system memory, mapped into the
  * GPU's virtual address space via gart. Gart memory linearizes non-contiguous
- * pages of system memory, allows GPU access system memory in a linezrized
+ * pages of system memory, allows GPU access system memory in a linearized
  * fashion.
  *
  * %AMDGPU_GEM_DOMAIN_VRAM	Local video memory. For APUs, it is memory
-- 
2.31.1

