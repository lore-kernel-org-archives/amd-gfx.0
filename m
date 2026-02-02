Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 280E8E73154
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Feb 2026 10:08:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DD1310E3E5;
	Mon,  2 Feb 2026 10:07:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="XwyUQLlw";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0BA710E3E5;
 Mon,  2 Feb 2026 10:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770026878; x=1801562878;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=U/ty4QMF2fDJpFbuAugdjBT2iSAtFi6lXMMgWaONO6Q=;
 b=XwyUQLlwkydogs6VNO6zHXOgpp8YJeGutx6EY8NpJ2qG8d/BJ7g2dw2R
 /4p7innJp6wSAImYJyHvAcZEDumnEztzCV/hUyAJq2sQ7A75Z4sIGEK5V
 fyy5JhE01Y8q0rCvW54JY5NuyxtWqlayy9vTIfXB41/v4fPH/DaKpTsE6
 cXP4fKwHFTcRalI6/oxIHLF1WfseCHw9SYxvUyJnGv3ebeLsbpL4dwqaB
 OJkKK83aAIlf53vG8dBPHulCRPtHm1qWloMOWs5f7XLkbXte++4LeWNrF
 j6PldqWPaWmx5woT2T/qYiseuRDqwwLxFCHE3dedqoEJeWnJBq+jYgnw+ A==;
X-CSE-ConnectionGUID: 4FHsiBxMSbGTG9JFgK8bag==
X-CSE-MsgGUID: FtInP57sQlqXddnM+CW7Eg==
X-IronPort-AV: E=McAfee;i="6800,10657,11689"; a="71163415"
X-IronPort-AV: E=Sophos;i="6.21,268,1763452800"; d="scan'208";a="71163415"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Feb 2026 02:07:57 -0800
X-CSE-ConnectionGUID: EAZ6Yd1LQemWlAYJ/+iWzQ==
X-CSE-MsgGUID: xWt/8ixdQO6VjoVXCJP0ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,268,1763452800"; d="scan'208";a="208984868"
Received: from dut-2a59.iind.intel.com ([10.190.239.113])
 by fmviesa007.fm.intel.com with ESMTP; 02 Feb 2026 02:07:53 -0800
From: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
To: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Cc: harry.wentland@amd.com, jani.nikula@linux.intel.com,
 louis.chauvet@bootlin.com, mwen@igalia.com, contact@emersion.fr,
 alex.hung@amd.com, daniels@collabora.com, uma.shankar@intel.com,
 suraj.kandpal@intel.com, nfraprado@collabora.com,
 ville.syrjala@linux.intel.com, matthew.d.roper@intel.com,
 maarten.lankhorst@intel.com, chaitanya.kumar.borah@intel.com
Subject: [RESEND 8/9] drm/colorop: Use destroy callback for color pipeline
 teardown
Date: Mon,  2 Feb 2026 15:12:01 +0530
Message-Id: <20260202094202.2871478-9-chaitanya.kumar.borah@intel.com>
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

Switch drm_colorop_pipeline_destroy() to use the driver-provided
destroy callback instead of directly calling drm_colorop_cleanup()
and freeing the object.

This allows drivers that embed struct drm_colorop in driver-specific
objects to perform correct teardown.

Signed-off-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
Reviewed-by: Suraj Kandpal <suraj.kandpal@intel.com>
Reviewed-by: Uma Shankar <uma.shankar@intel.com>
Reviewed-by: Alex Hung <alex.hung@amd.com>
Acked-by: Jani Nikula <jani.nikula@intel.com>
---
 drivers/gpu/drm/drm_colorop.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_colorop.c b/drivers/gpu/drm/drm_colorop.c
index 2bce29176ab3..aa19de769eb2 100644
--- a/drivers/gpu/drm/drm_colorop.c
+++ b/drivers/gpu/drm/drm_colorop.c
@@ -208,8 +208,7 @@ void drm_colorop_pipeline_destroy(struct drm_device *dev)
 	struct drm_colorop *colorop, *next;
 
 	list_for_each_entry_safe(colorop, next, &config->colorop_list, head) {
-		drm_colorop_cleanup(colorop);
-		kfree(colorop);
+		colorop->funcs->destroy(colorop);
 	}
 }
 EXPORT_SYMBOL(drm_colorop_pipeline_destroy);
-- 
2.25.1

