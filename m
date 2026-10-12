Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD8A5CC6B00
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Oct 2026 09:25:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FD1710EF82;
	Mon, 12 Oct 2026 09:24:58 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.217.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C4FE10E644
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Oct 2026 09:24:53 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 69C9Ol0l3938008; Mon, 12 Oct 2026 14:54:47 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 69C9Ol2W3938007;
 Mon, 12 Oct 2026 14:54:47 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Mukul Joshi <mukul.joshi@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v2 07/11] drm/amdgpu: reserve SPM VMID on gfx10
Date: Mon, 12 Oct 2026 14:54:25 +0530
Message-Id: <20261012092429.3937825-7-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261012092429.3937825-1-sunil.khatri@amd.com>
References: <20261012092429.3937825-1-sunil.khatri@amd.com>
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

Set vm_manager.spm_vmid to the top GFXHUB VMID so the SPM reservation
path hands out a fixed, isolated VMID on gfx10 instead of borrowing
one from the graphics pool.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 55d286275466d..49f593fe2a876 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -869,6 +869,10 @@ static int gmc_v10_0_sw_init(struct amdgpu_ip_block *ip_block)
 	 * amdgpu graphics/compute kernel queues will use VMIDs 1-7
 	 * amdkfd/MES user queues will use VMIDs 8-15
 	 */
+
+	/* Reserve the last VMID for SPM */
+	adev->vm_manager.spm_vmid = AMDGPU_NUM_VMID - 1;
+
 	amdgpu_vmid_mgr_set_vmid_mask(adev, GENMASK(7, 1),
 				      GENMASK(AMDGPU_NUM_VMID - 1, 1));
 
-- 
2.34.1

