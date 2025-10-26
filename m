Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40FE0CCF9E5
	for <amd-gfx@archiver.kernel.org>; Sun, 26 Oct 2025 04:30:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1E9F10E049;
	Sun, 26 Oct 2025 04:30:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jbSJJGbZ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A159510E049
 for <amd-gfx@lists.freedesktop.org>; Sun, 26 Oct 2025 04:30:02 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 1A8D06026F
 for <amd-gfx@lists.freedesktop.org>; Sun, 26 Oct 2025 04:30:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76A80C4CEF7;
 Sun, 26 Oct 2025 04:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1761453001;
 bh=I16n8fGCETp1BK00kMZYIkYz3piA23yVG360rJlNfhU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=jbSJJGbZR4FaDYknCIMHrwVDKIUWocAdTdm2rLjITBecjnpe6bamZbNLBETrhNrmR
 OmYYTHXrCQfW12tbOIqctpCX16L4rdb8jCX7yezJ7YL15CH73l3epAb0HaUmU7gwI8
 pnU7LRTHLivqv3SU6asBLnpXbJ9dmVEeLSWxNMyDQu6STlSCA0qKU2C+SK8R87xKS2
 bvj0c93yGs/9a59dKawGf9epi6wGPSSp7i7cJjsk/7G/udOVC4cTptRu1Gpp4/TnKy
 pttQ2SW6BB5bk0kgNkyFRHcw4cF9Z/hKFTq+GrB8WBpXlvdQKHbJn8iUVhsPsc7Tb0
 lpQp7C75cJ0Nw==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: amd-gfx@lists.freedesktop.org
Cc: "Mario Limonciello (AMD)" <superm1@kernel.org>
Subject: [PATCH v5 2/5] drm/amd: Add an unwind for failures in
 amdgpu_device_ip_suspend_phase1()
Date: Sat, 25 Oct 2025 23:29:37 -0500
Message-ID: <20251026042942.549389-3-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251026042942.549389-1-superm1@kernel.org>
References: <20251026042942.549389-1-superm1@kernel.org>
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

If any hardware IPs involved with the first phase of suspend fail, unwind
all steps to restore back to original state.

Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index f6850b86e96f..b9ea91b2c92f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -178,6 +178,7 @@ struct amdgpu_init_level amdgpu_init_minimal_xgmi = {
 		BIT(AMD_IP_BLOCK_TYPE_COMMON) | BIT(AMD_IP_BLOCK_TYPE_IH) |
 		BIT(AMD_IP_BLOCK_TYPE_PSP)
 };
+static int amdgpu_device_ip_resume_phase3(struct amdgpu_device *adev);
 
 static void amdgpu_device_load_switch_state(struct amdgpu_device *adev);
 
@@ -3784,7 +3785,7 @@ static void amdgpu_device_delay_enable_gfx_off(struct work_struct *work)
  */
 static int amdgpu_device_ip_suspend_phase1(struct amdgpu_device *adev)
 {
-	int i, r;
+	int i, r, rec;
 
 	amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
 	amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
@@ -3807,10 +3808,23 @@ static int amdgpu_device_ip_suspend_phase1(struct amdgpu_device *adev)
 
 		r = amdgpu_ip_block_suspend(&adev->ip_blocks[i]);
 		if (r)
-			return r;
+			goto unwind;
 	}
 
 	return 0;
+unwind:
+	rec = amdgpu_device_ip_resume_phase3(adev);
+	if (rec)
+		dev_err(adev->dev,
+			"amdgpu_device_ip_resume_phase3 failed during unwind: %d\n",
+			rec);
+
+	amdgpu_dpm_set_df_cstate(adev, DF_CSTATE_ALLOW);
+
+	amdgpu_device_set_pg_state(adev, AMD_PG_STATE_GATE);
+	amdgpu_device_set_cg_state(adev, AMD_CG_STATE_GATE);
+
+	return r;
 }
 
 /**
-- 
2.51.1

