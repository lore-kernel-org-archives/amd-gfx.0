Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 276EFCDE012
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jun 2026 08:56:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DFB710E34A;
	Fri, 26 Jun 2026 08:56:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="V/P2mOZn";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95B1210E341
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jun 2026 08:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=dvIhcLHngvM0Qs8lDk9ASHoq7YmKNqGR25SibmDdWS8=; b=V/P2mOZnO019W3zvEioU/ZSfDZ
 ez6WNQfUBX3gQdT9jwFkqWXRSObxIjNtywZXhXPZpFGwC8ktRXIYsnCQ22bOMgEkAU9UwtsgYBaHu
 2uYbjtWJGOPsbP1Hl9u/yaFQHUBHG4gV8RN5t6pCWYxfj+/VJXJIroJ/fSlSTbNd6WOwZduh6lpH4
 NKwQkwErmmWLHmujxyBt09bKcnZpMDdWXD9i8OyLgB4PTkRGfgXZgCExfcszoB1Bayr36IyT8a8O/
 8wok/lcmv9tCtop9DRWroka16ZJBlip9H5wCBjNDZOEi5xAlAl5hE+IhbwqVoXq2MAxemydq50TJq
 eW2tftZA==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wd2Lz-005Pwc-M0; Fri, 26 Jun 2026 10:56:03 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 1/3] drm/amdgpu: Remove unused amdgpu_device_ip_is_hw
Date: Fri, 26 Jun 2026 09:55:56 +0100
Message-ID: <20260626085558.97923-2-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260626085558.97923-1-tvrtko.ursulin@igalia.com>
References: <20260626085558.97923-1-tvrtko.ursulin@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

This function is unused so lets remove it.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c | 21 ---------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h |  2 --
 2 files changed, 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
index 6aa54156bbc9..62285e973c5c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
@@ -368,27 +368,6 @@ int amdgpu_device_ip_wait_for_idle(struct amdgpu_device *adev,
 	return 0;
 }
 
-/**
- * amdgpu_device_ip_is_hw - is the hardware IP enabled
- *
- * @adev: amdgpu_device pointer
- * @block_type: Type of hardware IP (SMU, GFX, UVD, etc.)
- *
- * Check if the hardware IP is enable or not.
- * Returns true if it the IP is enable, false if not.
- */
-bool amdgpu_device_ip_is_hw(struct amdgpu_device *adev,
-			    enum amd_ip_block_type block_type)
-{
-	struct amdgpu_ip_block *ip_block;
-
-	ip_block = amdgpu_device_ip_get_ip_block(adev, block_type);
-	if (ip_block)
-		return ip_block->status.hw;
-
-	return false;
-}
-
 /**
  * amdgpu_device_ip_is_valid - is the hardware IP valid
  *
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h
index 1d0df6d93957..11739fbdeaa6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h
@@ -146,8 +146,6 @@ void amdgpu_device_ip_get_clockgating_state(struct amdgpu_device *adev,
 					    u64 *flags);
 int amdgpu_device_ip_wait_for_idle(struct amdgpu_device *adev,
 				   enum amd_ip_block_type block_type);
-bool amdgpu_device_ip_is_hw(struct amdgpu_device *adev,
-			    enum amd_ip_block_type block_type);
 bool amdgpu_device_ip_is_valid(struct amdgpu_device *adev,
 			       enum amd_ip_block_type block_type);
 
-- 
2.54.0

