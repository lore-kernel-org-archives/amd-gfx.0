Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 865E3E73155
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Feb 2026 10:07:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC25910E403;
	Mon,  2 Feb 2026 10:07:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="NmB/7xYc";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04A9D10E3F7;
 Mon,  2 Feb 2026 10:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770026873; x=1801562873;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Tm2G7MUXkuyXbS4oxiX8ruOc6c7mq9dhfxznPV/oKG4=;
 b=NmB/7xYcpLgGI+qlsJuT8UDI9KoxrTPyKpVzBzaGILvV3cJOXpG7G9EN
 mJ91hGDSQ6/HPy9jDqAnb6o631pdj3DI0p8GCVBvQPaO4dzMy9XqMSwZV
 sO1ATGOpa7aQoDDvdXAl9xspqcRi3uwE6RJO2yEirT5Y8JDKmnuiYPExV
 2GpWJZYteNLjGEN74Xh+g0QrC+UzaMifS0j+TdBju3hC+f5mPdiwRFw+Y
 kME65nhoyF8XlMpr9aJ7oBP40qFDn6WmvoMXuck3BJRu3D7ZNd7PwBUBQ
 480SEDidCGbNhhhiTpLHpLHwCX4NVBmYXoeB81NTD+qL0Ues7RnB4+66a g==;
X-CSE-ConnectionGUID: MFafiqDuTHi3Xyjqb9sjiw==
X-CSE-MsgGUID: 25ciHi12So2z34Who/XlYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11689"; a="71163406"
X-IronPort-AV: E=Sophos;i="6.21,268,1763452800"; d="scan'208";a="71163406"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Feb 2026 02:07:53 -0800
X-CSE-ConnectionGUID: XwfO/Ad+SB67wNs4IVbmMg==
X-CSE-MsgGUID: V7YLjXliTBapz+gcDP79cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,268,1763452800"; d="scan'208";a="208984862"
Received: from dut-2a59.iind.intel.com ([10.190.239.113])
 by fmviesa007.fm.intel.com with ESMTP; 02 Feb 2026 02:07:48 -0800
From: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
To: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Cc: harry.wentland@amd.com, jani.nikula@linux.intel.com,
 louis.chauvet@bootlin.com, mwen@igalia.com, contact@emersion.fr,
 alex.hung@amd.com, daniels@collabora.com, uma.shankar@intel.com,
 suraj.kandpal@intel.com, nfraprado@collabora.com,
 ville.syrjala@linux.intel.com, matthew.d.roper@intel.com,
 maarten.lankhorst@intel.com, chaitanya.kumar.borah@intel.com
Subject: [RESEND 7/9] drm/vkms: Remove drm_colorop_pipeline_destroy() from
 vkms_destroy()
Date: Mon,  2 Feb 2026 15:12:00 +0530
Message-Id: <20260202094202.2871478-8-chaitanya.kumar.borah@intel.com>
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

Now that colorops are cleaned from drm_mode_config_cleanup(), remove
drm_colorop_pipeline_destroy() from  vkms_destroy().

Signed-off-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
Reviewed-by: Uma Shankar <uma.shankar@intel.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Acked-by: Jani Nikula <jani.nikula@intel.com>
---
 drivers/gpu/drm/vkms/vkms_drv.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
index 434c295f44ba..95020765c4c2 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.c
+++ b/drivers/gpu/drm/vkms/vkms_drv.c
@@ -259,7 +259,6 @@ void vkms_destroy(struct vkms_config *config)
 
 	fdev = config->dev->faux_dev;
 
-	drm_colorop_pipeline_destroy(&config->dev->drm);
 	drm_dev_unregister(&config->dev->drm);
 	drm_atomic_helper_shutdown(&config->dev->drm);
 	devres_release_group(&fdev->dev, NULL);
-- 
2.25.1

