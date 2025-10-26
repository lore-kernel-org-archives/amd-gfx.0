Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7718CCF9E5
	for <amd-gfx@archiver.kernel.org>; Sun, 26 Oct 2025 04:30:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD4F210E281;
	Sun, 26 Oct 2025 04:30:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="c7zoMMux";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBF5110E1B5
 for <amd-gfx@lists.freedesktop.org>; Sun, 26 Oct 2025 04:30:02 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 9C8B7442F5
 for <amd-gfx@lists.freedesktop.org>; Sun, 26 Oct 2025 04:30:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03A0DC113D0;
 Sun, 26 Oct 2025 04:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1761453002;
 bh=8pr3E2oHhpQ5pysY03fh7Wawxdw2hFfRO/kRfwFa5xg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=c7zoMMuxQV7QO+7zHHNHAkKqKEeVg5qd51Jozceksadj0rmhiNEHVhMtTWnNgfpiX
 A8wCZa/19B81SCrGHSHrwCpxcOrG/ovd4SorbIw4O36a2O5HUeJVryQNUDNwUfS+qT
 eRujGtTYl5IZcRjlhUHn0me0mzBG/3yyVuPc11WgQGdxlPrV5Eqnv2r5PNlr2EqmeQ
 /Lr/lXPhMxO5UUzQ+5uiIJcTtG465HvoZmRc+yJ4EqetTN5MtTcP3Pf6CpkiEHX9ba
 Lrtjxx7uIDU9kxs8q8s342t9nm/dBwk2Y0T5Ce1PD6PuZFIQgw/5fCYwYkdr7KPVNj
 knoGt1HebqbOw==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: amd-gfx@lists.freedesktop.org
Cc: "Mario Limonciello (AMD)" <superm1@kernel.org>
Subject: [PATCH v5 3/5] drm/amd: Add an unwind for failures in
 amdgpu_device_ip_suspend_phase2()
Date: Sat, 25 Oct 2025 23:29:38 -0500
Message-ID: <20251026042942.549389-4-superm1@kernel.org>
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

If any hardware IPs involved with the second phase of suspend fail, unwind
all steps to restore back to original state.

Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 36 ++++++++++++++++++++--
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index b9ea91b2c92f..5945f441d01e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -178,6 +178,9 @@ struct amdgpu_init_level amdgpu_init_minimal_xgmi = {
 		BIT(AMD_IP_BLOCK_TYPE_COMMON) | BIT(AMD_IP_BLOCK_TYPE_IH) |
 		BIT(AMD_IP_BLOCK_TYPE_PSP)
 };
+
+static int amdgpu_device_ip_resume_phase1(struct amdgpu_device *adev);
+static int amdgpu_device_ip_resume_phase2(struct amdgpu_device *adev);
 static int amdgpu_device_ip_resume_phase3(struct amdgpu_device *adev);
 
 static void amdgpu_device_load_switch_state(struct amdgpu_device *adev);
@@ -3840,7 +3843,7 @@ static int amdgpu_device_ip_suspend_phase1(struct amdgpu_device *adev)
  */
 static int amdgpu_device_ip_suspend_phase2(struct amdgpu_device *adev)
 {
-	int i, r;
+	int i, r, rec;
 
 	if (adev->in_s0ix)
 		amdgpu_dpm_gfx_state_change(adev, sGpuChangeState_D3Entry);
@@ -3903,7 +3906,7 @@ static int amdgpu_device_ip_suspend_phase2(struct amdgpu_device *adev)
 
 		r = amdgpu_ip_block_suspend(&adev->ip_blocks[i]);
 		if (r)
-			return r;
+			goto unwind;
 
 		/* handle putting the SMC in the appropriate state */
 		if (!amdgpu_sriov_vf(adev)) {
@@ -3913,13 +3916,40 @@ static int amdgpu_device_ip_suspend_phase2(struct amdgpu_device *adev)
 					dev_err(adev->dev,
 						"SMC failed to set mp1 state %d, %d\n",
 						adev->mp1_state, r);
-					return r;
+					goto unwind;
 				}
 			}
 		}
 	}
 
 	return 0;
+unwind:
+	/* suspend phase 2 = resume phase 1 + resume phase 2 */
+	rec = amdgpu_device_ip_resume_phase1(adev);
+	if (rec) {
+		dev_err(adev->dev,
+			"amdgpu_device_ip_resume_phase1 failed during unwind: %d\n",
+			rec);
+		return r;
+	}
+
+	rec = amdgpu_device_fw_loading(adev);
+	if (rec) {
+		dev_err(adev->dev,
+			"amdgpu_device_fw_loading failed during unwind: %d\n",
+			rec);
+		return r;
+	}
+
+	rec = amdgpu_device_ip_resume_phase2(adev);
+	if (rec) {
+		dev_err(adev->dev,
+			"amdgpu_device_ip_resume_phase2 failed during unwind: %d\n",
+			rec);
+		return r;
+	}
+
+	return r;
 }
 
 /**
-- 
2.51.1

