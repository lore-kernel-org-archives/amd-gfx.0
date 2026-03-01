Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D4BDFD0048
	for <amd-gfx@archiver.kernel.org>; Sun,  1 Mar 2026 01:25:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7FF010E2F3;
	Sun,  1 Mar 2026 01:25:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dtz2YYIv";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4221F10E2F3;
 Sun,  1 Mar 2026 01:25:42 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 28A6740283;
 Sun,  1 Mar 2026 01:25:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 552F2C2BC86;
 Sun,  1 Mar 2026 01:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1772328342;
 bh=iYfT2cToUYqsGSZq9JRF4W4eu/WYwHdaJ+xiafr+s90=;
 h=From:To:Cc:Subject:Date:From;
 b=dtz2YYIvaHVcvY1YgWtdcKUKeBRNnlZ615V2AVRCegJb9ycSnWz1bnLZMAE8eypZo
 2G6+bCNUD4iFnYdeJACu/BCMDqukiylgNllK8YzpRmVY2WL+R50j+ntXc9asvlLFxl
 VpaKVSsMArGSnT7x0uS+pWOm0NNO7zB2ur/V83ZiMiT70ByZlx+UHkQHPyfi5qIrYV
 Nt1ur1wEruw3JRo+0j6DKFxhEwDN0+jlUZAVbIgkZZ7Dkzw8UW/42zzIL22vso0QpF
 mBt8+BTzMnNWzMjjA/cX6v8sHt5OXVVa7UU/V4LqJyatLrY9885LHmYU3i4SeVQ8qy
 8/zkpW/X6CQLg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	yifan1.zhang@amd.com
Cc: Alex Deucher <alexander.deucher@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: FAILED: Patch "drm/amdgpu: Protect GPU register accesses in
 powergated state in some paths" failed to apply to 6.12-stable tree
Date: Sat, 28 Feb 2026 20:25:39 -0500
Message-ID: <20260301012540.1682831-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
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

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 39fc2bc4da0082c226cbee331f0a5d44db3997da Mon Sep 17 00:00:00 2001
From: Yifan Zhang <yifan1.zhang@amd.com>
Date: Mon, 2 Feb 2026 13:17:39 +0800
Subject: [PATCH] drm/amdgpu: Protect GPU register accesses in powergated state
 in some paths

Ungate GPU CG/PG in device_fini_hw and device_halt to protect GPU
register accesses, e.g. GC registers are accessed in amdgpu_irq_disable_all()
and amdgpu_fence_driver_hw_fini().

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index c1ffc63e23ab5..528990a595ec9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3504,9 +3504,6 @@ static int amdgpu_device_ip_fini_early(struct amdgpu_device *adev)
 		}
 	}
 
-	amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
-	amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
-
 	amdgpu_amdkfd_suspend(adev, true);
 	amdgpu_amdkfd_teardown_processes(adev);
 	amdgpu_userq_suspend(adev);
@@ -4902,6 +4899,9 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
 		amdgpu_virt_fini_data_exchange(adev);
 	}
 
+	amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
+	amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
+
 	/* disable all interrupts */
 	amdgpu_irq_disable_all(adev);
 	if (adev->mode_info.mode_config_initialized) {
@@ -7360,6 +7360,9 @@ void amdgpu_device_halt(struct amdgpu_device *adev)
 	amdgpu_xcp_dev_unplug(adev);
 	drm_dev_unplug(ddev);
 
+	amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
+	amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
+
 	amdgpu_irq_disable_all(adev);
 
 	amdgpu_fence_driver_hw_fini(adev);
-- 
2.51.0




