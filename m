Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6424CF9C76
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Sep 2024 07:25:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D54F10E399;
	Mon, 23 Sep 2024 07:25:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=treblig.org header.i=@treblig.org header.b="XNREdPqP";
	dkim-atps=neutral
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4817510E222;
 Mon, 23 Sep 2024 01:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
 :Subject; bh=RbW0B7/5rNugvdLyZ+nrDMXy1OSjf8esLFsIFlk4SaA=; b=XNREdPqPg3t611FP
 eWZ4S4Pe0jSM6ci+g1uS1gwecjVTVII66a/IZVPjTYYWGRvxJwU9PpzJF349zO73zQ0K66uGnV0nQ
 jAlE7m+wXPpuf6X44guwJL5Zl8+Tg5N4g/Efm7402eQTd+3DPBl0XFsAn99uLgek4iiNR3myyyhUX
 2vm/UAaoTvlzDOeHLfpBBs/5izYWNvVEvSFoVd+Z1uwitX06DYysq9dIXXJiDsjQA7jGfgajzEPfZ
 fPl1EyWT+1IM9UaXpDUhKJ97eECtZWef/0nZZSvKNJpPWByqRzHmWuuj05HvEJxod85nF7cTqAGvy
 sVhtfh4WQdXosiaW9A==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
 by mx.treblig.org with esmtp (Exim 4.96)
 (envelope-from <linux@treblig.org>) id 1ssXou-006k2k-27;
 Mon, 23 Sep 2024 01:24:56 +0000
From: linux@treblig.org
To: alexander.deucher@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com
Cc: airlied@gmail.com, simona@ffwll.ch, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 "Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 1/5] drm/amdgpu: Remove unused amdgpu_device_ip_is_idle
Date: Mon, 23 Sep 2024 02:24:42 +0100
Message-ID: <20240923012446.4965-2-linux@treblig.org>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240923012446.4965-1-linux@treblig.org>
References: <20240923012446.4965-1-linux@treblig.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 23 Sep 2024 07:25:17 +0000
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

amdgpu_device_ip_is_idle is unused.
It was renamed from 'amdgpu_is_idle' which was originally added in
commit 5dbbb60ba61e ("drm/amdgpu: add IP helpers for wait_for_idle and is_idle")

but hasn't been used.

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  2 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 24 ----------------------
 2 files changed, 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index dcd59040c449..c654668e2a56 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -365,8 +365,6 @@ void amdgpu_device_ip_get_clockgating_state(struct amdgpu_device *adev,
 					    u64 *flags);
 int amdgpu_device_ip_wait_for_idle(struct amdgpu_device *adev,
 				   enum amd_ip_block_type block_type);
-bool amdgpu_device_ip_is_idle(struct amdgpu_device *adev,
-			      enum amd_ip_block_type block_type);
 
 #define AMDGPU_MAX_IP_NUM 16
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index f4628412dac4..dc4679e53463 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2169,30 +2169,6 @@ int amdgpu_device_ip_wait_for_idle(struct amdgpu_device *adev,
 
 }
 
-/**
- * amdgpu_device_ip_is_idle - is the hardware IP idle
- *
- * @adev: amdgpu_device pointer
- * @block_type: Type of hardware IP (SMU, GFX, UVD, etc.)
- *
- * Check if the hardware IP is idle or not.
- * Returns true if it the IP is idle, false if not.
- */
-bool amdgpu_device_ip_is_idle(struct amdgpu_device *adev,
-			      enum amd_ip_block_type block_type)
-{
-	int i;
-
-	for (i = 0; i < adev->num_ip_blocks; i++) {
-		if (!adev->ip_blocks[i].status.valid)
-			continue;
-		if (adev->ip_blocks[i].version->type == block_type)
-			return adev->ip_blocks[i].version->funcs->is_idle((void *)adev);
-	}
-	return true;
-
-}
-
 /**
  * amdgpu_device_ip_get_ip_block - get a hw IP pointer
  *
-- 
2.46.1

