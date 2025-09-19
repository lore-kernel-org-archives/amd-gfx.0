Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02668CA1013
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Sep 2025 00:48:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6941D10E211;
	Fri, 19 Sep 2025 00:48:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DvqlhhEQ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 743EA10E211
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Sep 2025 00:48:08 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 2AA0740C59;
 Fri, 19 Sep 2025 00:48:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0236C4CEE7;
 Fri, 19 Sep 2025 00:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1758242888;
 bh=59+MAsqQt72hVVPijRLAqol7FmK1p2+UD7Xa6dmUcoE=;
 h=From:To:Cc:Subject:Date:From;
 b=DvqlhhEQjUWFkIKptgkSe/db1kfA2D8DjAwsQx3AoyKkhSD86lOSnu1MvB/Ye7WeF
 YmIWkOA3bXVXb9aW55/c76eV4Mx8yD9Px4pCnzYZi3E7vq+tFFOfyBsuplpuibDTwB
 SrfhBWzPMD4VKq0y/q8ukVnh79mbf+jnzY3bwfm7qqZTvPu0GPoUJ2EZTiXpjGgpQ+
 ss7Vj1/F2yYkIg0Gc7bjHrOLH4+PLvgJ79r7juYEsEGIqPW2xis7c81b9XP+jRY6KM
 KX9jOkBjgzwisK4wrIweZRCpWin1W5lEf/TNOhDblU0getD/Ks+8+YLncCx16hvJ2E
 cpOoic0N6kZQw==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: amd-gfx@lists.freedesktop.org
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 Yifan Zhang <yifan1.zhang@amd.com>
Subject: [PATCH v3] drm/amdgpu: Enable MES lr_compute_wa by default
Date: Thu, 18 Sep 2025 19:48:00 -0500
Message-ID: <20250919004800.125555-1-superm1@kernel.org>
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

From: Mario Limonciello <mario.limonciello@amd.com>

The MES set resources packet has an optional bit 'lr_compute_wa'
which can be used for preventing MES hangs on long compute jobs.

Set this bit by default.

Co-developed-by: Yifan Zhang <yifan1.zhang@amd.com>
Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v3:
 * gate on fw version
v2:
 * drop module parameter
 * add more description to commit text
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        | 6 ++++++
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c        | 5 +++++
 drivers/gpu/drm/amd/include/mes_v11_api_def.h | 3 ++-
 drivers/gpu/drm/amd/include/mes_v12_api_def.h | 3 ++-
 4 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 3b91ea601add4..e82188431f796 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -713,6 +713,12 @@ static int mes_v11_0_set_hw_resources(struct amdgpu_mes *mes)
 	mes_set_hw_res_pkt.enable_reg_active_poll = 1;
 	mes_set_hw_res_pkt.enable_level_process_quantum_check = 1;
 	mes_set_hw_res_pkt.oversubscription_timer = 50;
+	if ((mes->adev->mes.sched_version & AMDGPU_MES_VERSION_MASK) >= 0x7f)
+		mes_set_hw_res_pkt.enable_lr_compute_wa = 1;
+	else
+		dev_info_once(mes->adev->dev,
+			      "MES FW version must be >= 0x7f to enable LR compute workaround.\n");
+
 	if (amdgpu_mes_log_enable) {
 		mes_set_hw_res_pkt.enable_mes_event_int_logging = 1;
 		mes_set_hw_res_pkt.event_intr_history_gpu_mc_ptr =
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 998893dff08e9..aff06f06aeeec 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -769,6 +769,11 @@ static int mes_v12_0_set_hw_resources(struct amdgpu_mes *mes, int pipe)
 	mes_set_hw_res_pkt.use_different_vmid_compute = 1;
 	mes_set_hw_res_pkt.enable_reg_active_poll = 1;
 	mes_set_hw_res_pkt.enable_level_process_quantum_check = 1;
+	if ((mes->adev->mes.sched_version & AMDGPU_MES_VERSION_MASK) >= 0x82)
+		mes_set_hw_res_pkt.enable_lr_compute_wa = 1;
+	else
+		dev_info_once(adev->dev,
+			      "MES FW version must be >= 0x82 to enable LR compute workaround.\n");
 
 	/*
 	 * Keep oversubscribe timer for sdma . When we have unmapped doorbell
diff --git a/drivers/gpu/drm/amd/include/mes_v11_api_def.h b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
index 15680c3f49704..ab1cfc92dbeb1 100644
--- a/drivers/gpu/drm/amd/include/mes_v11_api_def.h
+++ b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
@@ -238,7 +238,8 @@ union MESAPI_SET_HW_RESOURCES {
 				uint32_t enable_mes_sch_stb_log : 1;
 				uint32_t limit_single_process : 1;
 				uint32_t is_strix_tmz_wa_enabled  :1;
-				uint32_t reserved : 13;
+				uint32_t enable_lr_compute_wa : 1;
+				uint32_t reserved : 12;
 			};
 			uint32_t	uint32_t_all;
 		};
diff --git a/drivers/gpu/drm/amd/include/mes_v12_api_def.h b/drivers/gpu/drm/amd/include/mes_v12_api_def.h
index c04bd351b2505..69611c7e30e35 100644
--- a/drivers/gpu/drm/amd/include/mes_v12_api_def.h
+++ b/drivers/gpu/drm/amd/include/mes_v12_api_def.h
@@ -287,7 +287,8 @@ union MESAPI_SET_HW_RESOURCES {
 				uint32_t limit_single_process : 1;
 				uint32_t unmapped_doorbell_handling: 2;
 				uint32_t enable_mes_fence_int: 1;
-				uint32_t reserved : 10;
+				uint32_t enable_lr_compute_wa : 1;
+				uint32_t reserved : 9;
 			};
 			uint32_t uint32_all;
 		};
-- 
2.43.0

