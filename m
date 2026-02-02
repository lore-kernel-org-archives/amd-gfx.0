Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 270FEE7314A
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Feb 2026 10:07:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75DEC10E3ED;
	Mon,  2 Feb 2026 10:07:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="VNK/izUD";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4965310E3EC;
 Mon,  2 Feb 2026 10:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770026844; x=1801562844;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Sda6mzWU3H3Dd0al4RaXm66Utb2rYLYYx0KwXkwuGIw=;
 b=VNK/izUDD3wpETl6LsWDkI6R7mz0/SrfVzZBjvxJSv2Fg+EjQhvWNy0B
 BsQ6i/a1CL25go+VE/aXmaqPOJJGEbdtbT+NOBqsBeiyU0luHtp2A78Bw
 FcR/abfghncvY1dYe3H+tuF2uHaNieVjuPn9xwOlzW1qe/RLswjBnoaMQ
 vC71zZGjm2KNkQkh0MYvkegjXe0hyr3UIuNeGDu2x98BR7NjvroLmvqA+
 2G5O/HHUYxG19XAtcQ2vjC+RQPwbWmzjXMxTgEKdXCOdC4TNeXcusVH6v
 pmNlZzNDS6fbgp4LP5gncoomSyUb4CwJvhcONSi70dEbOTmV7/oc/bHOO g==;
X-CSE-ConnectionGUID: Bo7a7KdrRFOVDhCEx2iziw==
X-CSE-MsgGUID: zMUUku0XQyWwcuWecdqBSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11689"; a="71163347"
X-IronPort-AV: E=Sophos;i="6.21,268,1763452800"; d="scan'208";a="71163347"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Feb 2026 02:07:24 -0800
X-CSE-ConnectionGUID: ZRkMhK/ZRlSOA3lfkSQ1iw==
X-CSE-MsgGUID: acjZgYf6Q6yN4xVwRkpUMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,268,1763452800"; d="scan'208";a="208984817"
Received: from dut-2a59.iind.intel.com ([10.190.239.113])
 by fmviesa007.fm.intel.com with ESMTP; 02 Feb 2026 02:07:20 -0800
From: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
To: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Cc: harry.wentland@amd.com, jani.nikula@linux.intel.com,
 louis.chauvet@bootlin.com, mwen@igalia.com, contact@emersion.fr,
 alex.hung@amd.com, daniels@collabora.com, uma.shankar@intel.com,
 suraj.kandpal@intel.com, nfraprado@collabora.com,
 ville.syrjala@linux.intel.com, matthew.d.roper@intel.com,
 maarten.lankhorst@intel.com, chaitanya.kumar.borah@intel.com
Subject: [RESEND 1/9] drm/colorop: Add destroy helper for colorop objects
Date: Mon,  2 Feb 2026 15:11:54 +0530
Message-Id: <20260202094202.2871478-2-chaitanya.kumar.borah@intel.com>
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

Add a helper that performs common cleanup and frees the
associated object. This can be used by drivers if they do not
require any driver-specific teardown.

v2:
- Add function documentation only before definition (Jani)

Signed-off-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
Reviewed-by: Suraj Kandpal <suraj.kandpal@intel.com>
Reviewed-by: Uma Shankar <uma.shankar@intel.com>
Reviewed-by: Alex Hung <alex.hung@amd.com>
Acked-by: Jani Nikula <jani.nikula@intel.com>
---
 drivers/gpu/drm/drm_colorop.c | 15 +++++++++++++++
 include/drm/drm_colorop.h     |  2 ++
 2 files changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/drm_colorop.c b/drivers/gpu/drm/drm_colorop.c
index 44eb823585d2..c226870fde9e 100644
--- a/drivers/gpu/drm/drm_colorop.c
+++ b/drivers/gpu/drm/drm_colorop.c
@@ -178,6 +178,21 @@ void drm_colorop_cleanup(struct drm_colorop *colorop)
 }
 EXPORT_SYMBOL(drm_colorop_cleanup);
 
+/**
+ * drm_colorop_destroy - destroy colorop
+ * @colorop: drm colorop
+ *
+ * Destroys @colorop by performing common DRM cleanup and freeing the
+ * colorop object. This can be used by drivers if they do not
+ * require any driver-specific teardown.
+ */
+void drm_colorop_destroy(struct drm_colorop *colorop)
+{
+	drm_colorop_cleanup(colorop);
+	kfree(colorop);
+}
+EXPORT_SYMBOL(drm_colorop_destroy);
+
 /**
  * drm_colorop_pipeline_destroy - Helper for color pipeline destruction
  *
diff --git a/include/drm/drm_colorop.h b/include/drm/drm_colorop.h
index a3a32f9f918c..3056f3f02597 100644
--- a/include/drm/drm_colorop.h
+++ b/include/drm/drm_colorop.h
@@ -420,6 +420,8 @@ void drm_colorop_atomic_destroy_state(struct drm_colorop *colorop,
  */
 void drm_colorop_reset(struct drm_colorop *colorop);
 
+void drm_colorop_destroy(struct drm_colorop *colorop);
+
 /**
  * drm_colorop_index - find the index of a registered colorop
  * @colorop: colorop to find index for
-- 
2.25.1

