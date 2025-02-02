Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B08DDC0219B
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Feb 2025 10:51:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AAB610E46E;
	Mon,  3 Feb 2025 10:51:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=treblig.org header.i=@treblig.org header.b="XAY1wUM5";
	dkim-atps=neutral
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C450010E2DA;
 Sun,  2 Feb 2025 21:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
 :Subject; bh=EiBopR9dtV9yxHm9Kvdf5kaAuKnjm8bl8Embt4vm7VY=; b=XAY1wUM5bsBuhHCn
 IDc+NMVbaI72ZwsfOIWxm9bF+WIQKAh8Mr8R6zwMWgOtofWWe8fiGXRUiPN5jwd69VR6HQTsnohMZ
 RoJjjulwBD1dOH502cazwuq+DhOxowqLdq/cnwzkAt8WPqd13V04ChNnKd9x2fviG+tiVo+sJdpQf
 cP1IsDtakV+oBxH+SWZ2jEGvnMTOo6vpcXevDd9JoqPE6/Hap/bon/3zI5j0KnxkdgtZrjF1/BQZm
 OqY674Ed1xTjx5eQzyiWdZ2I8IlBwmzvLDUqCqi41AfVy+Ux7ZzaZHq3lRJZ4ANS4oxbKbH2062ht
 3uZPP1rkCa9210i0yA==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
 by mx.treblig.org with esmtp (Exim 4.96)
 (envelope-from <linux@treblig.org>) id 1tehzZ-00D9GV-1s;
 Sun, 02 Feb 2025 21:59:01 +0000
From: linux@treblig.org
To: patrik.r.jakobsson@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, alexander.deucher@amd.com, harry.wentland@amd.com,
 sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com, christian.koenig@amd.com,
 Xinhui.Pan@amd.com, airlied@gmail.com, simona@ffwll.ch
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, "Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 6/7] drm/amd/display: Remove unused
 get_max_support_fbc_buffersize
Date: Sun,  2 Feb 2025 21:58:55 +0000
Message-ID: <20250202215856.252439-7-linux@treblig.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250202215856.252439-1-linux@treblig.org>
References: <20250202215856.252439-1-linux@treblig.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 03 Feb 2025 10:51:05 +0000
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

get_max_support_fbc_buffersize() is unused since 2021's
commit 94f0d0c80cf3 ("drm/amd/display/dc/dce110/dce110_compressor: Remove
unused function 'dce110_get_required_compressed_surfacesize")
removed it's only caller.

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 .../drm/amd/display/dc/dce110/dce110_compressor.c   | 13 -------------
 .../drm/amd/display/dc/dce110/dce110_compressor.h   |  2 --
 2 files changed, 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_compressor.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_compressor.c
index d241ee13b293..59a0961b49da 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_compressor.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_compressor.c
@@ -409,19 +409,6 @@ void dce110_compressor_destroy(struct compressor **compressor)
 	*compressor = NULL;
 }
 
-void get_max_support_fbc_buffersize(unsigned int *max_x, unsigned int *max_y)
-{
-	*max_x = FBC_MAX_X;
-	*max_y = FBC_MAX_Y;
-
-	/* if (m_smallLocalFrameBufferMemory == 1)
-	 * {
-	 *	*max_x = FBC_MAX_X_SG;
-	 *	*max_y = FBC_MAX_Y_SG;
-	 * }
-	 */
-}
-
 static const struct compressor_funcs dce110_compressor_funcs = {
 	.power_up_fbc = dce110_compressor_power_up_fbc,
 	.enable_fbc = dce110_compressor_enable_fbc,
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_compressor.h b/drivers/gpu/drm/amd/display/dc/dce110/dce110_compressor.h
index 26c7335a1cbf..223c57941e92 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_compressor.h
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_compressor.h
@@ -75,7 +75,5 @@ void dce110_compressor_program_lpt_control(struct compressor *cp,
 
 bool dce110_compressor_is_lpt_enabled_in_hw(struct compressor *cp);
 
-void get_max_support_fbc_buffersize(unsigned int *max_x, unsigned int *max_y);
-
 #endif
 
-- 
2.48.1

