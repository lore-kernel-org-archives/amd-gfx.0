Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A682E7314A
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Feb 2026 10:07:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF30B10E3FC;
	Mon,  2 Feb 2026 10:07:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="CZ+5tEnq";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CF1F10E3F5;
 Mon,  2 Feb 2026 10:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770026868; x=1801562868;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=AqgWhp0SbFOw474GljvoV8bTi2HwEKZmNpgTIC1uipE=;
 b=CZ+5tEnq12xFuhFOK4yq0KFMcYAFAQpK5EDk0YDFWW3YYZ8EzHPkIV4m
 ZjY4a+FUwz3mZDqROb8GUIjDdLLRTfoprjVue9D4mKNud1iqINusCsA+0
 MVU+M05gySZLB2/MtBBMkc4Bb3rlvWxs4RosowZXkmwefcfxYKtC5mR+k
 6HR32qATHPWD6LJoxjj/X/+UTh0xoV9jjYs4lDZsOxXl7jHG3o5Tsnkzl
 gUycDXfls1faOR7XJXYRIC394FQV5pWbFKUcHARRXoNnHMRAiKDQqwHXD
 /B/7zjkjT1JXzhPef2wzn6ae3P6gDDnQtC+BYgbITWDXb1UH8oDhcEXWc Q==;
X-CSE-ConnectionGUID: Egviub71QDO0LYI6dE/qbw==
X-CSE-MsgGUID: 5eMAbIvUTT6g1hi4yYXbBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11689"; a="71163397"
X-IronPort-AV: E=Sophos;i="6.21,268,1763452800"; d="scan'208";a="71163397"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Feb 2026 02:07:48 -0800
X-CSE-ConnectionGUID: 4IiCGL8RSPWWCrjvdhoAgg==
X-CSE-MsgGUID: tEngsx/PQCimPhG20LymCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,268,1763452800"; d="scan'208";a="208984856"
Received: from dut-2a59.iind.intel.com ([10.190.239.113])
 by fmviesa007.fm.intel.com with ESMTP; 02 Feb 2026 02:07:44 -0800
From: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
To: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Cc: harry.wentland@amd.com, jani.nikula@linux.intel.com,
 louis.chauvet@bootlin.com, mwen@igalia.com, contact@emersion.fr,
 alex.hung@amd.com, daniels@collabora.com, uma.shankar@intel.com,
 suraj.kandpal@intel.com, nfraprado@collabora.com,
 ville.syrjala@linux.intel.com, matthew.d.roper@intel.com,
 maarten.lankhorst@intel.com, chaitanya.kumar.borah@intel.com
Subject: [RESEND 6/9] drm: Clean up colorop objects during mode_config cleanup
Date: Mon,  2 Feb 2026 15:11:59 +0530
Message-Id: <20260202094202.2871478-7-chaitanya.kumar.borah@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260202094202.2871478-1-chaitanya.kumar.borah@intel.com>
References: <20260202094202.2871478-1-chaitanya.kumar.borah@intel.com>
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

Tear down all registered drm_colorop objects during
drm_mode_config_cleanup() by invoking their destroy callbacks.

This ensures proper cleanup of color pipeline objects during DRM device
removal.

Signed-off-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
Reviewed-by: Suraj Kandpal <suraj.kandpal@intel.com>
Reviewed-by: Uma Shankar <uma.shankar@intel.com>
Reviewed-by: Alex Hung <alex.hung@amd.com>
Acked-by: Jani Nikula <jani.nikula@intel.com>
---
 drivers/gpu/drm/drm_mode_config.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/drm_mode_config.c b/drivers/gpu/drm/drm_mode_config.c
index d12db9b0bab8..84ae8a23a367 100644
--- a/drivers/gpu/drm/drm_mode_config.c
+++ b/drivers/gpu/drm/drm_mode_config.c
@@ -524,6 +524,7 @@ void drm_mode_config_cleanup(struct drm_device *dev)
 	struct drm_property *property, *pt;
 	struct drm_property_blob *blob, *bt;
 	struct drm_plane *plane, *plt;
+	struct drm_colorop *colorop, *copt;
 
 	list_for_each_entry_safe(encoder, enct, &dev->mode_config.encoder_list,
 				 head) {
@@ -553,6 +554,11 @@ void drm_mode_config_cleanup(struct drm_device *dev)
 		drm_property_destroy(dev, property);
 	}
 
+	list_for_each_entry_safe(colorop, copt, &dev->mode_config.colorop_list,
+				 head) {
+		colorop->funcs->destroy(colorop);
+	}
+
 	list_for_each_entry_safe(plane, plt, &dev->mode_config.plane_list,
 				 head) {
 		plane->funcs->destroy(plane);
-- 
2.25.1

