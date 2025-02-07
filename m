Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 917EDC02196
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2025 06:54:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 444B810EA32;
	Fri,  7 Feb 2025 06:54:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="bpj54gYr";
	dkim-atps=neutral
Received: from out30-130.freemail.mail.aliyun.com
 (out30-130.freemail.mail.aliyun.com [115.124.30.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D144910EA2E
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Feb 2025 06:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1738910661; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=op/efRNKk9vNHc3Q66ryUGhxRGQqOOZAoUOpOdV/wC0=;
 b=bpj54gYryAKqUse7EWQawbzr6Hb6kpRdVd/mDBRYSqzRSmUb0HzXevxS/6NCtVJ3xXSi4oKLslbPP3wwBnqYJEwlOF4z2P6z8Z5n947c3tYoNuwfEZfBhAqOk/s/a7KvMzA24469QkXSdIMdfJEAsLQtFDGfyqD/q3rpP3YeAsA=
Received: from i32d02263.sqa.eu95.tbsite.net(mailfrom:gerry@linux.alibaba.com
 fp:SMTPD_---0WOyQdzX_1738910660 cluster:ay36) by smtp.aliyun-inc.com;
 Fri, 07 Feb 2025 14:44:21 +0800
From: Jiang Liu <gerry@linux.alibaba.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch, sunil.khatri@amd.com, lijo.lazar@amd.com,
 Hawking.Zhang@amd.com, mario.limonciello@amd.com, xiaogang.chen@amd.com,
 Kent.Russell@amd.com, shuox.liu@linux.alibaba.com,
 amd-gfx@lists.freedesktop.org
Cc: Jiang Liu <gerry@linux.alibaba.com>
Subject: [v1 3/4] drm/amdgpu: treat VCN as enabled if either VCN or JPEC is
 enabled
Date: Fri,  7 Feb 2025 14:44:16 +0800
Message-ID: <aaa3ce4700cea30d3ed1f3aa2920fee5aae65fea.1738910203.git.gerry@linux.alibaba.com>
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

Function is_vcn_enabled() returns false if either the VCN or JPEG ip
block is disabled, which sounds unreasonable. It should returns true
when either VCN and JPEG is enabled.

Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 70a5ab649e5f..08b42c7a4ad1 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -230,11 +230,11 @@ static bool is_vcn_enabled(struct amdgpu_device *adev)
 	for (i = 0; i < adev->num_ip_blocks; i++) {
 		if ((adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_VCN ||
 			adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_JPEG) &&
-			!adev->ip_blocks[i].status.valid)
-			return false;
+			adev->ip_blocks[i].status.valid)
+			return true;
 	}
 
-	return true;
+	return false;
 }
 
 static int smu_dpm_set_vcn_enable(struct smu_context *smu,
-- 
2.43.5

