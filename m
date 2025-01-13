Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8757E7719F
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jan 2025 01:42:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94E4710E344;
	Mon, 13 Jan 2025 01:42:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="GmFPkNr9";
	dkim-atps=neutral
Received: from out30-132.freemail.mail.aliyun.com
 (out30-132.freemail.mail.aliyun.com [115.124.30.132])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B254710E337
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jan 2025 01:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1736732551; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=dXl3unWslDFk7RwKVL04IpeV6gsjq4+VdP9EvC1f9lw=;
 b=GmFPkNr93HO0gCKlsAZTHo7L1qIeSgA6aXc60gkw83mtktL9K8it3bOnFO5GjmC40pCv79JfCMutFe6qknzgg3V7a5YsxCQviIYkoobKXu7HYkcem3HmOsqNqPXEqf0qXRS0mtWAK3NNBCGJ26MpafOw1tFKD9FCn9iQTTC7QpQ=
Received: from i32d02263.sqa.eu95.tbsite.net(mailfrom:gerry@linux.alibaba.com
 fp:SMTPD_---0WNS0NGi_1736732550 cluster:ay36) by smtp.aliyun-inc.com;
 Mon, 13 Jan 2025 09:42:30 +0800
From: Jiang Liu <gerry@linux.alibaba.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, simona@ffwll.ch, sunil.khatri@amd.com,
 lijo.lazar@amd.com, Hawking.Zhang@amd.com, mario.limonciello@amd.com,
 xiaogang.chen@amd.com, Kent.Russell@amd.com, shuox.liu@linux.alibaba.com,
 amd-gfx@lists.freedesktop.org
Cc: Jiang Liu <gerry@linux.alibaba.com>
Subject: [RFC v2 13/15] drm/amdgpu: walk IP blocks in reverse order when
 shutdown
Date: Mon, 13 Jan 2025 09:42:18 +0800
Message-ID: <2d37b65e4f19bcac7ed68819e1f67e9a398a8163.1736732063.git.gerry@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1736732062.git.gerry@linux.alibaba.com>
References: <cover.1736732062.git.gerry@linux.alibaba.com>
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

Walk IP blocks in reverse order in function amdgpu_device_ip_fini_early
and amdgpu_device_smu_fini_early, to keep consistence with other finish
functions.

Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index af356226fbca..a1501344f336 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3358,7 +3358,7 @@ static void amdgpu_device_smu_fini_early(struct amdgpu_device *adev)
 	if (amdgpu_ip_version(adev, GC_HWIP, 0) > IP_VERSION(9, 0, 0))
 		return;
 
-	amdgpu_for_each_ip_block(adev, ip_block) {
+	amdgpu_for_each_ip_block_reverse(adev, ip_block) {
 		if (amdgpu_ip_block_state(ip_block) < AMDGPU_IP_STATE_HW)
 			continue;
 		if (ip_block->version->type == AMD_IP_BLOCK_TYPE_SMC) {
@@ -3373,7 +3373,7 @@ static int amdgpu_device_ip_fini_early(struct amdgpu_device *adev)
 	int r;
 	struct amdgpu_ip_block *ip_block;
 
-	amdgpu_for_each_ip_block(adev, ip_block) {
+	amdgpu_for_each_ip_block_reverse(adev, ip_block) {
 		if (!ip_block->version->funcs->early_fini)
 			continue;
 
-- 
2.43.5

