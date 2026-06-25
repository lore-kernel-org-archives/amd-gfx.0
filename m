Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7FD0CDB479
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jun 2026 14:15:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C5E110F2CD;
	Thu, 25 Jun 2026 14:15:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="WQJqJbZA";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 785F310F2D1
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jun 2026 14:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=WJ9QibhEm+C894LhqiIc+I7gRh1EQckMZoQNOVqS0sc=; b=WQJqJbZAMpl+xFvTPAtILSheXf
 uLsRFz89+Z7Ec0ElR/kwk34UQYeOOZ9NIq2U4KAxECwozT8yGu2kkQeuXvj6Wv9pgUtY/muW+Bzbn
 W2zFt+fq3FTKuKSxHVuCHZtbm1syzEXUcQHjQngROUBY8rdnSG9+FLZSBRvZ0KU8KYlpgNBhmOZrP
 KT4p76Zp5xoYa2yhjXyef+7DU5c65We1vWwcLfd2divz57XmsW0eMaq5JQuyDaKzWrfzETEb5WLC8
 SKj8hjQOfeFGWECXkr1BSwvRhX7OLlPzj3Eq6jhLPXUOpQ56WmRhRcweNX1ZCIWOjLMive6n4Tutj
 rQ/GKVsw==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wckr2-0055O9-HG; Thu, 25 Jun 2026 16:14:56 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [RFC 2/2] drm/amdgpu: Remove unused amdgpu_device_ip_is_hw
Date: Thu, 25 Jun 2026 15:14:53 +0100
Message-ID: <20260625141453.83100-2-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260625141453.83100-1-tvrtko.ursulin@igalia.com>
References: <20260625141453.83100-1-tvrtko.ursulin@igalia.com>
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
index d5cd3f19d2bf..0036b992330e 100644
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

