Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D44CC02184
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jan 2025 01:42:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5535C10E34E;
	Mon, 13 Jan 2025 01:42:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="vDUQUn9x";
	dkim-atps=neutral
Received: from out30-131.freemail.mail.aliyun.com
 (out30-131.freemail.mail.aliyun.com [115.124.30.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC1B710E332
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jan 2025 01:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1736732549; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=S4rK4MeDwCnElP2tC5+lM6Xw1/eEyLwhl/3ReA/55Jw=;
 b=vDUQUn9xguRsLRTV7lvsfovpL9aQPU0HrI6jipah5NI1cTlAFEwreYITGOKP7PQQjiwvMnCqyaFN088Wv5RSMb3Lec1mjfMysLTYObmLI7x4S/wVDklNZgejS8C2ZDwhGlrw+Q/lVkms/nrqWAYzJfXFvaAoRMCnKT8YItZvY4o=
Received: from i32d02263.sqa.eu95.tbsite.net(mailfrom:gerry@linux.alibaba.com
 fp:SMTPD_---0WNS0NFl_1736732547 cluster:ay36) by smtp.aliyun-inc.com;
 Mon, 13 Jan 2025 09:42:27 +0800
From: Jiang Liu <gerry@linux.alibaba.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, simona@ffwll.ch, sunil.khatri@amd.com,
 lijo.lazar@amd.com, Hawking.Zhang@amd.com, mario.limonciello@amd.com,
 xiaogang.chen@amd.com, Kent.Russell@amd.com, shuox.liu@linux.alibaba.com,
 amd-gfx@lists.freedesktop.org
Cc: Jiang Liu <gerry@linux.alibaba.com>
Subject: [RFC v2 08/15] drm/amdgpu: make IP block state machine works in stack
 like way
Date: Mon, 13 Jan 2025 09:42:13 +0800
Message-ID: <4f627f06fab99e7534f590dfa16f1db13b16f7ea.1736732062.git.gerry@linux.alibaba.com>
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

There are some mismatches between IP block state machine and its
associated status flags, especially about the meaning of
`status.late_initialized`. So let's make the state machine and
associated status flas work in stack-like way as below:
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
index 6cbd19ad0fa5..6b503fb7e366 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3376,6 +3376,8 @@ static int amdgpu_device_ip_fini_early(struct amdgpu_device *adev)
 			DRM_DEBUG("early_fini of IP block <%s> failed %d\n",
 				  adev->ip_blocks[i].version->funcs->name, r);
 		}
+
+		adev->ip_blocks[i].status.late_initialized = false;
 	}
 
 	amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
@@ -3445,15 +3447,14 @@ static int amdgpu_device_ip_fini(struct amdgpu_device *adev)
 			}
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

