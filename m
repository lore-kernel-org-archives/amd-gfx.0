Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56057CC6B14
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2026 07:57:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAC4110F5D8;
	Tue, 13 Oct 2026 07:56:59 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.217.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AB4C10F5DB
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 07:56:51 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 69D7uk93775246; Tue, 13 Oct 2026 13:26:46 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 69D7ukr7775245;
 Tue, 13 Oct 2026 13:26:46 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Mukul Joshi <mukul.joshi@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v3 09/13] drm/amdgpu: reserve SPM VMID on gfx12
Date: Tue, 13 Oct 2026 13:26:40 +0530
Message-Id: <20261013075644.775162-9-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261013075644.775162-1-sunil.khatri@amd.com>
References: <20261013075644.775162-1-sunil.khatri@amd.com>
MIME-Version: 1.0
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

Set vm_manager.spm_vmid to the top GFXHUB VMID so the SPM reservation
path hands out a fixed, isolated VMID on gfx12 instead of borrowing
one from the graphics pool. This also covers gfx12.1, whose VMID setup
is handled in this file.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index e4a74cd6574f4..cd276a138e101 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -1006,6 +1006,9 @@ static int gmc_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 	if (adev->gfx.disable_kq)
 		last_kq_vmid = 0;
 
+	/* Reserve the last VMID for SPM */
+	adev->vm_manager.spm_vmid = AMDGPU_NUM_VMID - 1;
+
 	amdgpu_vmid_mgr_set_vmid_mask(adev, GENMASK(last_kq_vmid, 1),
 				      GENMASK(AMDGPU_NUM_VMID - 1, 1));
 
-- 
2.34.1

