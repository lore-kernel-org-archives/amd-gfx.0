Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72677C4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Dec 2023 19:46:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 186C489DC0;
	Thu, 14 Dec 2023 19:45:56 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DD5510E258;
 Thu, 14 Dec 2023 19:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=hT59JfzhB9C9oPzE8B3dJnvP0SZ39JBwJuYWOPRT5gE=; b=aVJEQ1IJhigTNekJ8K/FpqxBkh
 XrYFzP0GerQdIeUQdoKPiBmIxj7qWgSXke4SmbW+twoQo9y6ez4UM2b+OM/U9ZNWyHTwkR9MXd8Lc
 FnabyME8qxzLrX7jnm4xVrt05LJjowki7HU7j+IKDmmuM2fIeyxgR8usBXEaUU5sd67ZB1wi7XpJ/
 JsJIXRLq3FlKV8wS28PdaNYVLppN6EsXwKEukYTpYuvnrQoA1BK09v85NT2wnRLCfiOVol9iRqPxj
 uu3spE/phRC7R/qL3iXBlnw/T2AhfwBHlS8aAkZllpDmnWWmRJg0etcuzXLFJ3pewqFJVc2bpcWzc
 KKsKlg6w==;
Received: from [102.213.205.115] (helo=killbill.home)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1rDreJ-00E0Eu-Dx; Thu, 14 Dec 2023 20:45:35 +0100
From: Melissa Wen <mwen@igalia.com>
To: harry.wentland@amd.com, sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, daniel@ffwll.ch
Subject: [PATCH] drm/amd/display: fix documentation for
 dm_crtc_additional_color_mgmt()
Date: Thu, 14 Dec 2023 18:45:16 -0100
Message-ID: <20231214194533.444097-1-mwen@igalia.com>
X-Mailer: git-send-email 2.42.0
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
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org,
 kernel test robot <lkp@intel.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

warning: expecting prototype for drm_crtc_additional_color_mgmt().
Prototype was for dm_crtc_additional_color_mgmt() instead

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202312141801.o9eBCxt9-lkp@intel.com/
Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index 8b3aa674741d..4439e5a27362 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -292,7 +292,7 @@ static int amdgpu_dm_crtc_late_register(struct drm_crtc *crtc)
 
 #ifdef AMD_PRIVATE_COLOR
 /**
- * drm_crtc_additional_color_mgmt - enable additional color properties
+ * dm_crtc_additional_color_mgmt - enable additional color properties
  * @crtc: DRM CRTC
  *
  * This function lets the driver enable post-blending CRTC regamma transfer
-- 
2.42.0

