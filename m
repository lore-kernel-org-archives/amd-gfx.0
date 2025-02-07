Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B0E2C02192
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2025 06:49:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B925110EA2D;
	Fri,  7 Feb 2025 06:49:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="YUTRbXIs";
	dkim-atps=neutral
Received: from out30-97.freemail.mail.aliyun.com
 (out30-97.freemail.mail.aliyun.com [115.124.30.97])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD69810EA2D
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Feb 2025 06:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1738910663; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=C4EBYfccoT+oVJEjV6TvncZgE/3Y6lfWLPRxbsmTLMA=;
 b=YUTRbXIsj3Q6q19BBC1efh8mFacU+CTTAKgos5iaMZGVIImfx8xrQ9iyWCkBvrs7m1JgFytrQSrU2agIJcHDu/WnP7CHVyIgCgz7578CDUZur8G+Dl/4u+sJpN72WeMNG4xfnBxpnt0Mf9jRJaQqeFpahPUUlQr+Ju0DwCBsoYQ=
Received: from i32d02263.sqa.eu95.tbsite.net(mailfrom:gerry@linux.alibaba.com
 fp:SMTPD_---0WOyQe-6_1738910661 cluster:ay36) by smtp.aliyun-inc.com;
 Fri, 07 Feb 2025 14:44:21 +0800
From: Jiang Liu <gerry@linux.alibaba.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch, sunil.khatri@amd.com, lijo.lazar@amd.com,
 Hawking.Zhang@amd.com, mario.limonciello@amd.com, xiaogang.chen@amd.com,
 Kent.Russell@amd.com, shuox.liu@linux.alibaba.com,
 amd-gfx@lists.freedesktop.org
Cc: Jiang Liu <gerry@linux.alibaba.com>
Subject: [v1 4/4] drm/amdgpu: minor code style enhancement for smu
Date: Fri,  7 Feb 2025 14:44:17 +0800
Message-ID: <751aa892683cad234865404eccafacbbb73cdf6d.1738910203.git.gerry@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1738910203.git.gerry@linux.alibaba.com>
References: <cover.1738910203.git.gerry@linux.alibaba.com>
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

Minor code style enhancement for smu.

Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c            | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 08b42c7a4ad1..51e7bd4d3444 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2153,7 +2153,7 @@ static int smu_resume(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	struct smu_context *smu = adev->powerplay.pp_handle;
 
-	if (amdgpu_sriov_vf(adev)&& !amdgpu_sriov_is_pp_one_vf(adev))
+	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
 		return 0;
 
 	if (!smu->pm_enabled)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index da7bd9227afe..da55d66099fb 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -3524,8 +3524,8 @@ static const struct pptable_funcs smu_v13_0_6_ppt_funcs = {
 	.init_power = smu_v13_0_init_power,
 	.fini_power = smu_v13_0_fini_power,
 	.check_fw_status = smu_v13_0_6_check_fw_status,
-	/* pptable related */
 	.check_fw_version = smu_v13_0_6_check_fw_version,
+	/* pptable related */
 	.set_driver_table_location = smu_v13_0_set_driver_table_location,
 	.set_tool_table_location = smu_v13_0_set_tool_table_location,
 	.notify_memory_pool_location = smu_v13_0_notify_memory_pool_location,
-- 
2.43.5

