Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E62FC3ABC5
	for <amd-gfx@archiver.kernel.org>; Thu,  8 May 2025 13:02:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A889010E90D;
	Thu,  8 May 2025 13:02:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=treblig.org header.i=@treblig.org header.b="BWrXuOuf";
	dkim-atps=neutral
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63AD910E869;
 Wed,  7 May 2025 17:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
 :Subject; bh=mdvcmG+pr6izOQ7iKhUgbPE6Eufkwe+TQMBeVd0mk4o=; b=BWrXuOufb/Y9cgZi
 +OfTXNNxxg93bzC2uLEpWea9qvrYjUiZnoPMyMolIBNXSFs40EshAI59Rcs3T109JfPXYB+lJVvwt
 ELBY2IcHnEorneocHCreEe/Y3lnmwJ70AMJ+eKQY7/Y0Kn4wmH9xUbCayAYEndP4iUVSV1Vkmko4b
 2eRgNk4oxggzP7wxFS1BAjqJLuyZQJQMVW6/9wNyT7P4C4r/a62JhuMAU9T0rzn2GtBK01vnOim+0
 ySS4gVUYmmDhJ8uDZrD1LVqDUlxm0ObqlDIVAtkjhXeNJ6ifYA0mvj78x6rOYJu4n2GFBmZHLvykV
 8AyT+DVBeS/KNaCXLA==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
 by mx.treblig.org with esmtp (Exim 4.96)
 (envelope-from <linux@treblig.org>) id 1uCi9T-002EIU-1I;
 Wed, 07 May 2025 17:01:47 +0000
From: linux@treblig.org
To: alexander.deucher@amd.com, kenneth.feng@amd.com, christian.koenig@amd.com
Cc: airlied@gmail.com, simona@ffwll.ch, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 "Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 2/3] drm/amd/pm: Remove unused smu_mode2_reset_is_support
Date: Wed,  7 May 2025 18:01:44 +0100
Message-ID: <20250507170145.102508-3-linux@treblig.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250507170145.102508-1-linux@treblig.org>
References: <20250507170145.102508-1-linux@treblig.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 08 May 2025 13:02:11 +0000
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

From: "Dr. David Alan Gilbert" <linux@treblig.org>

smu_mode2_reset_is_support() was added in 2020 by
commit 5c03e5843e6b ("drm/amdgpu:add smu mode1/2 support for aldebaran")
but has remained unused.

See discussion at:
https://lore.kernel.org/all/DM4PR12MB5165D85BD85BC8FC8BF7A3B48E88A@DM4PR12MB5165.namprd12.prod.outlook.com/

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 13 -------------
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  1 -
 2 files changed, 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 46cce1d2aaf3..04bbeeac98a3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -3432,19 +3432,6 @@ bool smu_mode1_reset_is_support(struct smu_context *smu)
 	return ret;
 }
 
-bool smu_mode2_reset_is_support(struct smu_context *smu)
-{
-	bool ret = false;
-
-	if (!smu->pm_enabled)
-		return false;
-
-	if (smu->ppt_funcs && smu->ppt_funcs->mode2_reset_is_support)
-		ret = smu->ppt_funcs->mode2_reset_is_support(smu);
-
-	return ret;
-}
-
 int smu_mode1_reset(struct smu_context *smu)
 {
 	int ret = 0;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index dd6d0e7aa242..a5ba37f57650 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -1601,7 +1601,6 @@ int smu_get_power_limit(void *handle,
 			enum pp_power_type pp_power_type);
 
 bool smu_mode1_reset_is_support(struct smu_context *smu);
-bool smu_mode2_reset_is_support(struct smu_context *smu);
 int smu_mode1_reset(struct smu_context *smu);
 
 extern const struct amd_ip_funcs smu_ip_funcs;
-- 
2.49.0

