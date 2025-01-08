Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82595E7719F
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2025 14:00:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CAD710E8BA;
	Wed,  8 Jan 2025 14:00:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="mb+IOo3f";
	dkim-atps=neutral
Received: from out30-110.freemail.mail.aliyun.com
 (out30-110.freemail.mail.aliyun.com [115.124.30.110])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A65710E8B7
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jan 2025 14:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1736344814; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=muPGBYzk7UkjdTGRTYasPFohDCXJeDGRc/XUBFnysuE=;
 b=mb+IOo3fswFSMuW70vpnJ2u5/ixV+pUty7cBKSIJfUO0ATUY32Z6VE86kpanBKKeOQdRsNizTSS8kou//ewZnN52nf1dmwBSYDLZU9BinanQso71fdlUfjhOtZFbax3nYGz4TaRrmHSSbO4EnyDo044XADbE23EarC0j7vQxXl0=
Received: from i32d02263.sqa.eu95.tbsite.net(mailfrom:gerry@linux.alibaba.com
 fp:SMTPD_---0WNEHXF0_1736344813 cluster:ay36) by smtp.aliyun-inc.com;
 Wed, 08 Jan 2025 22:00:14 +0800
From: Jiang Liu <gerry@linux.alibaba.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, simona@ffwll.ch, sunil.khatri@amd.com,
 lijo.lazar@amd.com, Hawking.Zhang@amd.com, mario.limonciello@amd.com,
 Jun.Ma2@amd.com, xiaogang.chen@amd.com, Kent.Russell@amd.com,
 shuox.liu@linux.alibaba.com, amd-gfx@lists.freedesktop.org
Cc: Jiang Liu <gerry@linux.alibaba.com>
Subject: [RFC PATCH 09/13] drm/amdgpu: make IP block state machine works in
 stack like way
Date: Wed,  8 Jan 2025 22:00:01 +0800
Message-ID: <d8d9a5e10dc0cfb8a9d625eccae714a1634d28e5.1736344725.git.gerry@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1736344725.git.gerry@linux.alibaba.com>
References: <cover.1736344725.git.gerry@linux.alibaba.com>
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

There are some mismatch between IP block state machine and its associated
status flags, especially about the meaning of `status.late_initialized`.
So let's make the state machine and associated status flas work in stack-like
way as below:
Callback	Status
early_init:	valid = true
sw_init: 	sw = true
hw_init:	hw = true
late_init:	late_initialized = true
early_fini:	late_initialized = false
hw_fini:	hw = false
sw_fini:	sw = false
late_fini:	valid = false

Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 0e69c7c7fe1f..36a33a391411 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3332,6 +3332,8 @@ static int amdgpu_device_ip_fini_early(struct amdgpu_device *adev)
 			DRM_DEBUG("early_fini of IP block <%s> failed %d\n",
 				  adev->ip_blocks[i].version->funcs->name, r);
 		}
+
+		adev->ip_blocks[i].status.late_initialized = false;
 	}
 
 	amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
@@ -3407,15 +3409,14 @@ static int amdgpu_device_ip_fini(struct amdgpu_device *adev)
 				  adev->ip_blocks[i].version->funcs->name, r);
 		}
 		adev->ip_blocks[i].status.sw = false;
-		adev->ip_blocks[i].status.valid = false;
 	}
 
 	for (i = adev->num_ip_blocks - 1; i >= 0; i--) {
-		if (!adev->ip_blocks[i].status.late_initialized)
+		if (!adev->ip_blocks[i].status.valid)
 			continue;
 		if (adev->ip_blocks[i].version->funcs->late_fini)
 			adev->ip_blocks[i].version->funcs->late_fini(&adev->ip_blocks[i]);
-		adev->ip_blocks[i].status.late_initialized = false;
+		adev->ip_blocks[i].status.valid = false;
 	}
 
 	amdgpu_ras_fini(adev);
-- 
2.43.5

