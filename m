Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9E2DCAC582
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Sep 2025 17:59:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 068D710ECB3;
	Fri, 12 Sep 2025 17:59:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dGl6dEr+";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C3E710ECB3
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Sep 2025 17:59:40 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 91F15601D3
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Sep 2025 17:59:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB34CC4CEF1;
 Fri, 12 Sep 2025 17:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1757699979;
 bh=B4ZsL4l4a2/aQLEwQofGlZPi1QkJ0ab8k5aIcr1xajc=;
 h=From:To:Cc:Subject:Date:From;
 b=dGl6dEr+6pFgUGdzexz0Q38W+yUsvAO3COxNorZfCQnZZrFcfDcdxib+ufMgDNkmN
 UcDafLSJskhjQcvmGBjOswbQNdbTLqG2Dbd0Z3VI+gmAQ1InNyjsTEa9Kt417gGU/R
 3VWgxomve4WjplnhXdJnH8XL3qwiAc7HCCExdbJJ+iDpITlwXDzNx2e3Wijfbr7woC
 kXm/hzTWm1Kn7iPXw4SiQKVC4Ah82E/cmyNFJgpXk4ZTHIRga6sp6KhRYE0DdDjDJi
 DkVfY5cckkJ/BSLskfE4OvCX60q64/cfMkkN6/redy98KveVClmjDrUiDdIVX/8k8Q
 rctUz1ka7bG1Q==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: amd-gfx@lists.freedesktop.org
Cc: "Mario Limonciello (AMD)" <superm1@kernel.org>
Subject: [PATCH] drm/amd: Drop unnecessary calls to smu_dpm_set_vpe_enable()
Date: Fri, 12 Sep 2025 12:59:33 -0500
Message-ID: <20250912175933.917146-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
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

smu_hw_init() and smu_hw_fini() call smu_dpm_set_vpe_enable() for
APUs as part of startup and teardown.  These calls however are
not necessary because vpe_hw_init()/vpe_hw_fini() will call at
init/fini:

```
vpe_hw_init() / vpe_hw_fini()
  amdgpu_device_ip_set_powergating_state()
    vpe_set_powergating_state()
      amdgpu_dpm_enable_vpe()
        amdgpu_dpm_set_powergating_by_smu()
          smu_dpm_set_power_gate()
            smu_dpm_set_vpe_enable()
```

Drop the extra calls.

Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index b47cb4a5f4887..49e6a2266136b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1896,7 +1896,6 @@ static int smu_hw_init(struct amdgpu_ip_block *ip_block)
 		for (i = 0; i < adev->vcn.num_vcn_inst; i++)
 			smu_dpm_set_vcn_enable(smu, true, i);
 		smu_dpm_set_jpeg_enable(smu, true);
-		smu_dpm_set_vpe_enable(smu, true);
 		smu_dpm_set_umsch_mm_enable(smu, true);
 		smu_set_mall_enable(smu);
 		smu_set_gfx_cgpg(smu, true);
@@ -2104,7 +2103,6 @@ static int smu_hw_fini(struct amdgpu_ip_block *ip_block)
 	}
 	smu_dpm_set_jpeg_enable(smu, false);
 	adev->jpeg.cur_state = AMD_PG_STATE_GATE;
-	smu_dpm_set_vpe_enable(smu, false);
 	smu_dpm_set_umsch_mm_enable(smu, false);
 
 	if (!smu->pm_enabled)
-- 
2.43.0

