Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29DBAD78779
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Dec 2025 13:42:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 897B310EF9A;
	Fri, 19 Dec 2025 13:42:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="Lo+e3QkU";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CF4910EEE8
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Dec 2025 13:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=jamUmdv9vhWlMvcEaX8xMKr/0VJ5CdTMJgBeCAZK/bo=; b=Lo+e3QkUe9qgym3BYX9AwB0bAr
 bi2lNNymJ4AmxmcAD5A0jSh26ePzlAhpDaI5JWDLkwEe0Cu8UzCAdoHLb2J8byPPJ+H6xHY2O7ZNz
 TDPmPV/mMo6mh+iJeRSiTLCSmjshxPPuR/Q1HqFASzHS0pna3mLH0SzjYJUkzM1SBCJKoAq+nyrSw
 S76Mje2DwsDjsJ32jgAOX2pJxO4+uy2i/gfkLXYpTUVonJe6eldSkp7KILOYL+ftdxQwoBYcOnIIu
 HKVjWoQRcyHs6NdMqN7FVa5COd0mmZBCPTvclsHlZXYJzUH8rGTM+IIFYrKx1Ki0X60zYVM757X5/
 pc11sgkw==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with utf8esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1vWakD-00EeQb-PT; Fri, 19 Dec 2025 14:42:09 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [PATCH v2 03/12] drm/amdgpu: Remove unneccessary memset in bo list
 creation
Date: Fri, 19 Dec 2025 13:41:56 +0000
Message-ID: <20251219134205.25450-4-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251219134205.25450-1-tvrtko.ursulin@igalia.com>
References: <20251219134205.25450-1-tvrtko.ursulin@igalia.com>
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

The code will either fully populate the allocated array with userspace
provided data, or abort and free the memory, so there is no need to clear
the array before populating it.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
index 87ec46c56a6e..72c5096c3b18 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
@@ -201,7 +201,6 @@ int amdgpu_bo_create_list_entry_array(struct drm_amdgpu_bo_list_in *in,
 		if (!info)
 			return -ENOMEM;
 
-		memset(info, 0, bo_number * info_size);
 		for (i = 0; i < bo_number; ++i, uptr += bo_info_size) {
 			if (copy_from_user(&info[i], uptr, bytes)) {
 				kvfree(info);
-- 
2.51.1

