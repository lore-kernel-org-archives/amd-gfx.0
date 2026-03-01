Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47574FD0049
	for <amd-gfx@archiver.kernel.org>; Sun,  1 Mar 2026 02:03:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D431810E3B0;
	Sun,  1 Mar 2026 02:03:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bdEVD9zj";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E36FE10E3AC;
 Sun,  1 Mar 2026 02:03:28 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 60C4E60123;
 Sun,  1 Mar 2026 02:03:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BF9AC19421;
 Sun,  1 Mar 2026 02:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1772330608;
 bh=ZDNF0Ql9rh/0gOrBydFrtk7SK5dKJptrpQPwFM58kT4=;
 h=From:To:Cc:Subject:Date:From;
 b=bdEVD9zjjXa3JxbBDYGXq8w6u51U8GVJRU87Tp1hU7la9tLyfaVjsQkyuTT+ISbis
 /ZRxamS2RFT+tMTczLq8qHa9F9gLhK6ASA5myAuqcrjmkUq4PqtEj4amIXEgmLTGJy
 mxons4/mho+RmtU6X3qAWYO8nerOFihBjSRywrlQjQJ4YquJ6vkLCUcYP6GUppRZ/h
 9R1zpBXJKZcO2+RuOcosIXffABoh0xWir6zya3HuLgzUM+CQf9qpp+yaXVE2k9JeSM
 kTCEVD/XoT040dGTouxRhDq+Scc5v8POHDqdDNRZOQhATLHp/D3pGg5nNHwhNCgkda
 qwX3MXyH+RPVw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Philip.Yang@amd.com
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: FAILED: Patch "drm/amdgpu: Use 5-level paging if gmc support 57-bit
 VA" failed to apply to 5.10-stable tree
Date: Sat, 28 Feb 2026 21:03:26 -0500
Message-ID: <20260301020326.1731500-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Type: text/plain; charset=UTF-8
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 3b948dd0366a0b64c02e4ed1aefdf7825942e803 Mon Sep 17 00:00:00 2001
From: Philip Yang <Philip.Yang@amd.com>
Date: Tue, 27 Jan 2026 13:52:33 -0500
Subject: [PATCH] drm/amdgpu: Use 5-level paging if gmc support 57-bit VA
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Regardless if CPU enable 5-level paging, GPU vm use 5-level paging if
gmc init with 57-bit address space support, because

ARM64 4-level paging support 48-bit VA, x86 and GPU 4-level paging
support 47-bit VA, require 5-level paging on GPU to support ARM64.

NPA address space 52-bit mapping on NPA GPU VM require 5-level paging.

Debugger trap get device snapshot expect LDS and Scratch base, limit
above 57-bit, which is set only for 5-level paging.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org # 6.19.x
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 6a2ea200d90c8..31383583fc682 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2360,26 +2360,9 @@ void amdgpu_vm_adjust_size(struct amdgpu_device *adev, uint32_t min_vm_size,
 			   unsigned max_bits)
 {
 	unsigned int max_size = 1 << (max_bits - 30);
-	bool sys_5level_pgtable = false;
 	unsigned int vm_size;
 	uint64_t tmp;
 
-#ifdef CONFIG_X86_64
-	/*
-	 * Refer to function configure_5level_paging() for details.
-	 */
-	sys_5level_pgtable = (native_read_cr4() & X86_CR4_LA57);
-#endif
-
-	/*
-	 * If GPU supports 5-level page table, but system uses 4-level page table,
-	 * then use 4-level page table on GPU
-	 */
-	if (max_level == 4 && !sys_5level_pgtable) {
-		min_vm_size = 256 * 1024;
-		max_level = 3;
-	}
-
 	/* adjust vm size first */
 	if (amdgpu_vm_size != -1) {
 		vm_size = amdgpu_vm_size;
-- 
2.51.0




