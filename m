Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8171C25B74
	for <amd-gfx@archiver.kernel.org>; Fri, 10 May 2024 18:12:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53C3610EE03;
	Fri, 10 May 2024 18:12:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="IP3MsZ84";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B2BE10EC25;
 Fri, 10 May 2024 18:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715364749; x=1746900749;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=FHTK70PvgfwZLpvlBe7dbX6rxP07L9nO9XQci2fkrOQ=;
 b=IP3MsZ84GlEzqdCCAfTwxL00y3MFnDhI+uPHlDTCIlZgPAA4pbI5/1dX
 oWdVJwhSzc59vuZQLzG49pG4PZ7VKJDcVxWDlFE3sXFNLoUR79ITyMawr
 euDb2+foZ93BuF7YXzR9aA+ZxQcX6qIZTBB6pO+gXn3uIr3syFVtRyKyl
 Y8th4cy3wMoMgDbkLRL83NMlN/Kg5jqSbQZJ55NfoIw+CcIw7nRmFQZmY
 lzeFDt4vJHK5eMZ3lDlGfsZEvWqLRg1nIBtaSBHPUgZfoL/e2JE+5qewL
 qrPEUrfHwHsKYzW9bJjkQjrkG6xoTwVYIA1U5LXICj1yE8e1OxBFIm146 Q==;
X-CSE-ConnectionGUID: fyfs6I8xSj6hnZD6kSZN3w==
X-CSE-MsgGUID: BdN3mDP3RSGyCwnCLwBw6w==
X-IronPort-AV: E=McAfee;i="6600,9927,11069"; a="28844566"
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; d="scan'208";a="28844566"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 May 2024 11:12:29 -0700
X-CSE-ConnectionGUID: LBG46i8qQN+DRzmAquV0BA==
X-CSE-MsgGUID: Ee8/ek3QQVSw6QrKxczPGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; d="scan'208";a="60544056"
Received: from maurocar-mobl2.ger.corp.intel.com (HELO mwauld-desk.intel.com)
 ([10.245.244.149])
 by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 May 2024 11:12:27 -0700
From: Matthew Auld <matthew.auld@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Daniel Vetter <daniel.vetter@ffwll.ch>, amd-gfx@lists.freedesktop.org
Subject: [PATCH 02/20] drm/amdgpu: don't trample pdev drvdata
Date: Fri, 10 May 2024 19:12:15 +0100
Message-ID: <20240510181212.264622-24-matthew.auld@intel.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240510181212.264622-22-matthew.auld@intel.com>
References: <20240510181212.264622-22-matthew.auld@intel.com>
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

The driver release callback is called when a particular drm_device goes
away, just like with drmm, so here we should never nuke the pdev drvdata
pointer, since that could already be pointing to a new drvdata.
For example something hotunplugs the device, for which we have an open
driver fd, keeping the drm_device alive, and in the meantime the same
physical device is re-attached to a new drm_device therefore setting
drvdata again. Once the original drm_device goes away, we might then
call the release which then incorrectly tramples the drvdata.

The driver core will already nuke the pointer for us when the pci device
is removed, so should be safe to simply drop. Alternative would be to
move to the driver pci remove callback.

Signed-off-by: Matthew Auld <matthew.auld@intel.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index a0ea6fe8d060..d5fed007c698 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1450,7 +1450,6 @@ void amdgpu_driver_release_kms(struct drm_device *dev)
 	struct amdgpu_device *adev = drm_to_adev(dev);
 
 	amdgpu_device_fini_sw(adev);
-	pci_set_drvdata(adev->pdev, NULL);
 }
 
 /*
-- 
2.45.0

