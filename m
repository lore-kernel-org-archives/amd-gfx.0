Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5505EC282EC
	for <amd-gfx@archiver.kernel.org>; Sat,  8 Mar 2025 14:27:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1D5F10E1E9;
	Sat,  8 Mar 2025 14:27:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="Mrq7TrhR";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99EAF10E1E9
 for <amd-gfx@lists.freedesktop.org>; Sat,  8 Mar 2025 14:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=nOD5Y2qeskSmo7Il7idHtC4lkBIsi+0tWcMeX8C+c+U=; b=Mrq7TrhRa83IZcCFqlZzBY5H1K
 DMqptww/xhKKuG4Q+/AKEeA+krx8FWOKg+C/NF+gh9M6z5B5QE350zc78yDQuuh2AZve7f9LAZi8q
 A6GjbrQF55wvS1kvv1CdXeiSIbnrYI6ArbDyW7hjK0FZ7Ff4dWrx5kCRUF5ijwaaz5N9brzT2JJYG
 BHB8WWje9D14MI8k+Lg57S30lQ6+vO0mXHj86NDIExvLkadwjk0VH/FPxXaTkXQ9o67zqS1g8zyj8
 2i4VDcosAKR/lBhiqT4pQznI42UiXb97OkT742pev/5baqB6hqD7Nh9+RWBDtcJpdr3L13KbLfYaV
 mbv/EzUA==;
Received: from [189.6.35.67] (helo=killbill.home)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1tqv8s-005pIP-E4; Sat, 08 Mar 2025 15:27:12 +0100
From: Melissa Wen <mwen@igalia.com>
To: harry.wentland@amd.com, sunpeng.li@amd.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, mario.limonciello@amd.com, alex.hung@amd.com,
 siqueira@igalia.com
Cc: amd-gfx@lists.freedesktop.org,
	kernel-dev@igalia.com
Subject: [RFC PATCH 4/7] drm/amd/display: parse display name from drm_eld
Date: Sat,  8 Mar 2025 11:26:08 -0300
Message-ID: <20250308142650.35920-5-mwen@igalia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250308142650.35920-1-mwen@igalia.com>
References: <20250308142650.35920-1-mwen@igalia.com>
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

We don't need to parse dc_edid to get the display name since it's
already set in drm_eld which in turn had it values updated when updating
connector with the opaque drm_edid.

Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c  | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 0e37039dead0..0def4f59b05a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -34,7 +34,7 @@
 #include <drm/amdgpu_drm.h>
 #include <drm/drm_edid.h>
 #include <drm/drm_fixed.h>
-
+#include <drm/drm_eld.h>
 #include "dm_services.h"
 #include "amdgpu.h"
 #include "dc.h"
@@ -90,6 +90,7 @@ static void apply_edid_quirks(struct drm_device *dev, struct edid *edid, struct
 	}
 }
 
+#define AMDGPU_ELD_DISPLAY_NAME_SIZE_IN_CHARS 13
 /**
  * dm_helpers_parse_edid_caps() - Parse edid caps
  *
@@ -135,9 +136,10 @@ enum dc_edid_status dm_helpers_parse_edid_caps(
 	edid_caps->manufacture_week = product_id.week_of_manufacture;
 	edid_caps->manufacture_year = product_id.year_of_manufacture;
 
-	drm_edid_get_monitor_name(edid_buf,
-				  edid_caps->display_name,
-				  AUDIO_INFO_DISPLAY_NAME_SIZE_IN_CHARS);
+	memset(edid_caps->display_name, 0, AUDIO_INFO_DISPLAY_NAME_SIZE_IN_CHARS);
+	memcpy(edid_caps->display_name,
+	       &connector->eld[DRM_ELD_MONITOR_NAME_STRING],
+	       AMDGPU_ELD_DISPLAY_NAME_SIZE_IN_CHARS);
 
 	edid_caps->edid_hdmi = connector->display_info.is_hdmi;
 
-- 
2.47.2

