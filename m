Return-Path: <SRS0=Gn/P=56=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76C8EC2BB86
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Apr 2020 13:05:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E1DC2084D
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Apr 2020 13:05:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E1DC2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D48B6E4CB;
	Tue, 14 Apr 2020 13:05:06 +0000 (UTC)
X-Greylist: delayed 383 seconds by postgrey-1.36 at gabe;
 Tue, 14 Apr 2020 11:41:50 UTC
Received: from m17618.mail.qiye.163.com (m17618.mail.qiye.163.com
 [59.111.176.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 745AE89A0E;
 Tue, 14 Apr 2020 11:41:50 +0000 (UTC)
Received: from ubuntu.localdomain (unknown [157.0.31.122])
 by m17618.mail.qiye.163.com (Hmail) with ESMTPA id 8F71F4E1434;
 Tue, 14 Apr 2020 19:35:23 +0800 (CST)
From: Bernard Zhao <bernard@vivo.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
 David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Bernard Zhao <bernard@vivo.com>,
 Xiaojie Yuan <xiaojie.yuan@amd.com>, Oak Zeng <Oak.Zeng@amd.com>,
 Sam Ravnborg <sam@ravnborg.org>, Alex Sierra <alex.sierra@amd.com>,
 Huang Rui <ray.huang@amd.com>, Kent Russell <kent.russell@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] Optimized division operation to shift operation
Date: Tue, 14 Apr 2020 04:35:08 -0700
Message-Id: <1586864113-30682-1-git-send-email-bernard@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZT1VOS01LS0tLT0pCTUpNTFlXWShZQU
 hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nxw6Ajo*Tjg1TwoNNAg1Fz4v
 Lk0KFDJVSlVKTkNNQ01PSklIQk5OVTMWGhIXVRkeCRUaCR87DRINFFUYFBZFWVdZEgtZQVlKTkxV
 S1VISlVKSUlZV1kIAVlBT0NPSTcG
X-HM-Tid: 0a717878efd19376kuws8f71f4e1434
X-Mailman-Approved-At: Tue, 14 Apr 2020 13:05:05 +0000
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
Cc: kernel@vivo.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On some processors, the / operate will call the compiler`s div lib,
which is low efficient, We can replace the / operation with shift,
so that we can replace the call of the division library with one
shift assembly instruction.

Signed-off-by: Bernard Zhao <bernard@vivo.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c | 4 ++--
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c | 4 ++--
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
index b205039..66cd078 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
@@ -175,10 +175,10 @@ static int gmc_v6_0_mc_load_microcode(struct amdgpu_device *adev)
 	amdgpu_ucode_print_mc_hdr(&hdr->header);
 
 	adev->gmc.fw_version = le32_to_cpu(hdr->header.ucode_version);
-	regs_size = le32_to_cpu(hdr->io_debug_size_bytes) / (4 * 2);
+	regs_size = le32_to_cpu(hdr->io_debug_size_bytes) >> 3;
 	new_io_mc_regs = (const __le32 *)
 		(adev->gmc.fw->data + le32_to_cpu(hdr->io_debug_array_offset_bytes));
-	ucode_size = le32_to_cpu(hdr->header.ucode_size_bytes) / 4;
+	ucode_size = le32_to_cpu(hdr->header.ucode_size_bytes) >> 2;
 	new_fw_data = (const __le32 *)
 		(adev->gmc.fw->data + le32_to_cpu(hdr->header.ucode_array_offset_bytes));
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
index 9da9596..ca26d63 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
@@ -193,10 +193,10 @@ static int gmc_v7_0_mc_load_microcode(struct amdgpu_device *adev)
 	amdgpu_ucode_print_mc_hdr(&hdr->header);
 
 	adev->gmc.fw_version = le32_to_cpu(hdr->header.ucode_version);
-	regs_size = le32_to_cpu(hdr->io_debug_size_bytes) / (4 * 2);
+	regs_size = le32_to_cpu(hdr->io_debug_size_bytes) >> 3;
 	io_mc_regs = (const __le32 *)
 		(adev->gmc.fw->data + le32_to_cpu(hdr->io_debug_array_offset_bytes));
-	ucode_size = le32_to_cpu(hdr->header.ucode_size_bytes) / 4;
+	ucode_size = le32_to_cpu(hdr->header.ucode_size_bytes) >> 2;
 	fw_data = (const __le32 *)
 		(adev->gmc.fw->data + le32_to_cpu(hdr->header.ucode_array_offset_bytes));
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index 27d83204..295039c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -318,10 +318,10 @@ static int gmc_v8_0_tonga_mc_load_microcode(struct amdgpu_device *adev)
 	amdgpu_ucode_print_mc_hdr(&hdr->header);
 
 	adev->gmc.fw_version = le32_to_cpu(hdr->header.ucode_version);
-	regs_size = le32_to_cpu(hdr->io_debug_size_bytes) / (4 * 2);
+	regs_size = le32_to_cpu(hdr->io_debug_size_bytes) >> 3;
 	io_mc_regs = (const __le32 *)
 		(adev->gmc.fw->data + le32_to_cpu(hdr->io_debug_array_offset_bytes));
-	ucode_size = le32_to_cpu(hdr->header.ucode_size_bytes) / 4;
+	ucode_size = le32_to_cpu(hdr->header.ucode_size_bytes) >> 2;
 	fw_data = (const __le32 *)
 		(adev->gmc.fw->data + le32_to_cpu(hdr->header.ucode_array_offset_bytes));
 
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
