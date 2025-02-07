Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF03FC02192
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2025 06:51:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 779D910EA2F;
	Fri,  7 Feb 2025 06:51:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="kzEFL7Cs";
	dkim-atps=neutral
Received: from out30-110.freemail.mail.aliyun.com
 (out30-110.freemail.mail.aliyun.com [115.124.30.110])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04DC810EA2E
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Feb 2025 06:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1738910661; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=Sg1xuCkxbSMJnYh3UkLKU0Fa57qhHtUw+FbZshcYYj0=;
 b=kzEFL7Cseg6e5yZhHe3/ox3Wg3F601ARqJoPddMLF6V/U+Hr8WEm70XJ8gfOEAQCmFKA80owmqDYJaaftMDOFtNUG5WvVE6OpeubfPhAaK31ybHFRYJdU2BuYXA3dRGmIfiaBBw+vmIsHf/S5yBhmxSxMCgp0cwFZa9k8H8aCdE=
Received: from i32d02263.sqa.eu95.tbsite.net(mailfrom:gerry@linux.alibaba.com
 fp:SMTPD_---0WOyQdz5_1738910660 cluster:ay36) by smtp.aliyun-inc.com;
 Fri, 07 Feb 2025 14:44:20 +0800
From: Jiang Liu <gerry@linux.alibaba.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch, sunil.khatri@amd.com, lijo.lazar@amd.com,
 Hawking.Zhang@amd.com, mario.limonciello@amd.com, xiaogang.chen@amd.com,
 Kent.Russell@amd.com, shuox.liu@linux.alibaba.com,
 amd-gfx@lists.freedesktop.org
Cc: Jiang Liu <gerry@linux.alibaba.com>
Subject: [v1 2/4] drm/amdgpu: accumulate gfx_off_entrycount in smu_suspend()
Date: Fri,  7 Feb 2025 14:44:15 +0800
Message-ID: <9253f9f4144fd2e126e6b7307c63eb75764dce21.1738910203.git.gerry@linux.alibaba.com>
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

As pwfw resets entrycount when device is suspended, so we should
accmulate the gfx_off_entrycount value instead of save the last value
of it.

Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index ed9dac00ebfb..70a5ab649e5f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2134,12 +2134,12 @@ static int smu_suspend(struct amdgpu_ip_block *ip_block)
 	smu_set_gfx_cgpg(smu, false);
 
 	/*
-	 * pwfw resets entrycount when device is suspended, so we save the
-	 * last value to be used when we resume to keep it consistent
+	 * pwfw resets entrycount when device is suspended, so we accumulate
+	 * the `gfx_off_entrycount` value.
 	 */
 	ret = smu_get_entrycount_gfxoff(smu, &count);
 	if (!ret)
-		adev->gfx.gfx_off_entrycount = count;
+		adev->gfx.gfx_off_entrycount += count;
 
 	/* clear this on suspend so it will get reprogrammed on resume */
 	smu->workload_mask = 0;
-- 
2.43.5

