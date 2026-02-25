Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64F8DFD3747
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Feb 2026 12:19:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3DE010E761;
	Wed, 25 Feb 2026 12:19:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="YTrm9rkm";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D98910E761;
 Wed, 25 Feb 2026 12:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=42oAOmqxtUswAq2HZxFhuZLV5OviQlfZVCTMX9+HeKg=; b=YTrm9rkmQg1L7aj6RdKvqCHNlH
 HwSDBnnal0ivj2jLiAwH9hQqtvfSx42vmXEbQJSmOmFXCPf9GNPh6kHMR0cDpdFVQ3EXwDy9Ve7zQ
 ERAodFdfhNY2mjF8gGhleibY76bLJqpZ8y6XcuuZjjtxIiEqUOJMaks2rq5ZvtCEvSRJg2cWdqaN2
 ZqPTf7kdoxUL/6vFv2YiUm91zDbVaHlmkKa3M+59NeQbPfkzdwRtHRVLMtroYfgpvIB4m0URDP4yB
 0Y8qfUJcr1+gvAxz0OgZLXnrXwK2Q2E+bCHk3gWe5nsS0PZdqgM7GOxeh98PpGLTUJh82CuaBFXUI
 NJmM1R0g==;
Received: from [186.208.68.119] (helo=killbill.home)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1vvDrc-005DpP-T6; Wed, 25 Feb 2026 13:19:37 +0100
From: Melissa Wen <mwen@igalia.com>
To: airlied@gmail.com, alexander.deucher@amd.com, alex.hung@amd.com,
 andrzej.hajda@intel.com, christian.koenig@amd.com, harry.wentland@amd.com,
 jernej.skrabec@gmail.com, jonas@kwiboo.se,
 Laurent.pinchart@ideasonboard.com, maarten.lankhorst@linux.intel.com,
 mario.limonciello@amd.com, mripard@kernel.org, mwen@igalia.com,
 neil.armstrong@linaro.org, rfoss@kernel.org, simona@ffwll.ch,
 siqueira@igalia.com, sunpeng.li@amd.com, tzimmermann@suse.de
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
 Michel Daenzer <michel.daenzer@mailbox.org>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 kernel-dev@igalia.com
Subject: [PATCH v8 4/8] drm/amd/display: use drm_edid helper to set analog
 EDID caps
Date: Wed, 25 Feb 2026 09:04:33 -0300
Message-ID: <20260225121903.236115-5-mwen@igalia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260225121903.236115-1-mwen@igalia.com>
References: <20260225121903.236115-1-mwen@igalia.com>
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

Use drm_edid_is_digital helper instead of open-coded mask.

Reviewed-by: Timur Kristóf <timur.kristof@gmail.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 93db85543440..e553b9cbe179 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -135,7 +135,7 @@ enum dc_edid_status dm_helpers_parse_edid_caps(
 	edid_caps->serial_number = le32_to_cpu(product_id.serial_number);
 	edid_caps->manufacture_week = product_id.week_of_manufacture;
 	edid_caps->manufacture_year = product_id.year_of_manufacture;
-	edid_caps->analog = !(edid_buf->input & DRM_EDID_INPUT_DIGITAL);
+	edid_caps->analog = !drm_edid_is_digital(drm_edid);
 
 	drm_edid_get_monitor_name(edid_buf,
 				  edid_caps->display_name,
-- 
2.51.0

