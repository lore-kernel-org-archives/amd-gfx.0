Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F0BECA0EEB
	for <amd-gfx@archiver.kernel.org>; Sat, 16 Aug 2025 16:28:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B9D510E3A8;
	Sat, 16 Aug 2025 16:28:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="ZjvIhKfR";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEE7710E1DB
 for <amd-gfx@lists.freedesktop.org>; Sat, 16 Aug 2025 16:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=WJJT7F4X8XIcjY2L2Rxz8UqaD6/mFbHiwNrzFiuQqeQ=; b=ZjvIhKfRnX6rOwXfe/j+sgIeJG
 1teqxKAZwJebEzNdxT+nrgzNQw3tB8jepnwo4QSrT+9GuQV92ZVxbTGsz2BDZQICIq5GASWzCJov7
 chEuFJBwR6j4InroiC/Tfo6OlwmYW9ZP9R2JGKKnOYOxPNIdXpmIwoEr8bttll6exTsjleq/3bGsZ
 mGsc117tVvtI6F+Nusq9ERm56LrFw236QYnXJBhEvVbX/MrdKB2uUDKqG3kZqS44cTEsivodHzAAv
 UnJKCm2dv0+MSFMCzEw0fTlMV0C7bduCzEc4Q3TuAQdHeFjsVPD7NABZW4lehJ8+Nlx+JMAXzAqX/
 e3rWRnWw==;
Received: from [104.193.135.201] (helo=debian.lan)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1unJlZ-00FASr-PC; Sat, 16 Aug 2025 18:28:26 +0200
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 James Zhu <James.Zhu@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH 2/3] drm/amdgpu/vcn: Remove unnecessary check
Date: Sat, 16 Aug 2025 10:27:27 -0600
Message-ID: <20250816162806.1301791-3-siqueira@igalia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250816162806.1301791-1-siqueira@igalia.com>
References: <20250816162806.1301791-1-siqueira@igalia.com>
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

The function amdgpu_vcn_sysfs_reset_mask_init already returns 0, which
makes the check of the result unnecessary in the vcn_v4_0_3_sw_init().
Just return the amdgpu_vcn_sysfs_reset_mask_init directly.

Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 018a526a8801..168c394deeba 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -242,11 +242,7 @@ static int vcn_v4_0_3_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	r = amdgpu_vcn_sysfs_reset_mask_init(adev);
-	if (r)
-		return r;
-
-	return 0;
+	return amdgpu_vcn_sysfs_reset_mask_init(adev);
 }
 
 /**
-- 
2.47.2

