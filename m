Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FD8DC36014
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Mar 2025 20:39:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6910010E942;
	Thu, 27 Mar 2025 20:39:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="h/T2iOBV";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C76210E187
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Mar 2025 20:39:13 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 16D906113B;
 Thu, 27 Mar 2025 20:39:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7D4CC4CEEA;
 Thu, 27 Mar 2025 20:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1743107951;
 bh=KrsqYnDAY8sRR5wkPY13I7J89C+68gk9ZGt8dkkqHUA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=h/T2iOBVlGQeiMhM1CdJ+kKPDy0//ARZjpQMaaRLyBG7rWNRzV8EICJGl0FOpOprJ
 pl4XdBerXq7IdrwmlDKmZFlMdrQ4Dv+AwjjU0ZPUpX41e53szmHs/aBhIsYUIDjVC5
 6VYOwp/W0o+nZs5rzijxPnuvjpGT7sa58TOUCFduLppUnb4RqzZIHX36mP0vjI+ACI
 pjYFBNlt0ZO+uI+ls4jTNNEEnNxSpc5dHyfoKyp/ZwHNXc+34Sjm80bO7za70D6z1g
 lwHKpQzeH4MwgiTGLz7go1h/8Z6I4+Xv+Fq0YWPAFezyJuDQ7DrksOU2wb2sWeaV6d
 cH4GggwpAK7Lw==
From: Mario Limonciello <superm1@kernel.org>
To: amd-gfx@lists.freedesktop.org
Cc: Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 04/14] drm/amd: Adjust amdgpu_vpe messages from dev_*() to
 drm_*()
Date: Thu, 27 Mar 2025 15:38:48 -0500
Message-ID: <20250327203858.3796086-5-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250327203858.3796086-1-superm1@kernel.org>
References: <20250327203858.3796086-1-superm1@kernel.org>
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

From: Mario Limonciello <mario.limonciello@amd.com>

Messages emitted in amdgpu_vpe are currently device scope, but as
they are drm driver messages they should be drm scope. Adjust
accordingly.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
index 121ee17b522bd..25dfe47dc2af0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
@@ -263,7 +263,7 @@ int amdgpu_vpe_init_microcode(struct amdgpu_vpe *vpe)
 
 	return 0;
 out:
-	dev_err(adev->dev, "fail to initialize vpe microcode\n");
+	drm_err(adev_to_drm(adev), "fail to initialize vpe microcode\n");
 	release_firmware(adev->vpe.fw);
 	adev->vpe.fw = NULL;
 	return ret;
@@ -317,7 +317,8 @@ static int vpe_early_init(struct amdgpu_ip_block *ip_block)
 	vpe_set_ring_funcs(adev);
 	vpe_set_regs(vpe);
 
-	dev_info(adev->dev, "VPE: collaborate mode %s", vpe->collaborate_mode ? "true" : "false");
+	drm_info(adev_to_drm(adev), "VPE: collaborate mode %s",
+		 vpe->collaborate_mode ? "true" : "false");
 
 	return 0;
 }
@@ -347,7 +348,7 @@ static int vpe_common_init(struct amdgpu_vpe *vpe)
 				    &adev->vpe.cmdbuf_gpu_addr,
 				    (void **)&adev->vpe.cmdbuf_cpu_addr);
 	if (r) {
-		dev_err(adev->dev, "VPE: failed to allocate cmdbuf bo %d\n", r);
+		drm_err(adev_to_drm(adev), "VPE: failed to allocate cmdbuf bo %d\n", r);
 		return r;
 	}
 
@@ -635,7 +636,7 @@ static int vpe_ring_preempt_ib(struct amdgpu_ring *ring)
 
 	if (i >= adev->usec_timeout) {
 		r = -EINVAL;
-		dev_err(adev->dev, "ring %d failed to be preempted\n", ring->idx);
+		drm_err(adev_to_drm(adev), "ring %d failed to be preempted\n", ring->idx);
 	}
 
 	/* deassert IB preemption */
@@ -660,7 +661,7 @@ static int vpe_set_powergating_state(struct amdgpu_ip_block *ip_block,
 	struct amdgpu_vpe *vpe = &adev->vpe;
 
 	if (!adev->pm.dpm_enabled)
-		dev_err(adev->dev, "Without PM, cannot support powergating\n");
+		drm_err(adev_to_drm(adev), "Without PM, cannot support powergating\n");
 
 	dev_dbg(adev->dev, "%s: %s!\n", __func__, (state == AMD_PG_STATE_GATE) ? "GATE":"UNGATE");
 
@@ -756,7 +757,7 @@ static int vpe_ring_test_ring(struct amdgpu_ring *ring)
 
 	ret = amdgpu_device_wb_get(adev, &index);
 	if (ret) {
-		dev_err(adev->dev, "(%d) failed to allocate wb slot\n", ret);
+		drm_err(adev_to_drm(adev), "(%d) failed to allocate wb slot\n", ret);
 		return ret;
 	}
 
@@ -765,7 +766,8 @@ static int vpe_ring_test_ring(struct amdgpu_ring *ring)
 
 	ret = amdgpu_ring_alloc(ring, 4);
 	if (ret) {
-		dev_err(adev->dev, "amdgpu: dma failed to lock ring %d (%d).\n", ring->idx, ret);
+		drm_err(adev_to_drm(adev),
+			"amdgpu: dma failed to lock ring %d (%d).\n", ring->idx, ret);
 		goto out;
 	}
 
@@ -800,7 +802,7 @@ static int vpe_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 
 	ret = amdgpu_device_wb_get(adev, &index);
 	if (ret) {
-		dev_err(adev->dev, "(%d) failed to allocate wb slot\n", ret);
+		drm_err(adev_to_drm(adev), "(%d) failed to allocate wb slot\n", ret);
 		return ret;
 	}
 
-- 
2.43.0

