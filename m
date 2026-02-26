Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE5EEFCE086
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Feb 2026 13:55:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C88DA10E0B8;
	Thu, 26 Feb 2026 13:55:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="gPnVYc02";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CC9110E0D9;
 Thu, 26 Feb 2026 03:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772074925; x=1803610925;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=jEJUzFHoRE3d2/ezJ6fU2pSSD3BXkE7mH0J33xBDPd8=;
 b=gPnVYc02LY5neZH+6+4un5d4sHb8U8MHy+Yzdja64H9nWOMzR6uM0YCS
 IyC8bHU/8XJezNrTniTqAZM6XZ47sQrza2C4fZNJn6NIqfnoBHkd0mnpW
 w6Wsatdxjm3FO2SZScp9xE4uOM1wiDz/W6KnaEwtT1rT5zP3My+BbjEGL
 qtpNRSQUS/ewGlhpR6KSkOk2P8dcB+d2axFILevzzsGBvSoSfkeDhCjce
 3WcRSSZOA/331ymTNBJsHpeRSgBTjJJpmdnElwUQnAbzzjcKgHTIIIZdl
 Z/QAfA/Sbu9YxlV6Ppb7QgJD3TjZW2R2oPrsnuO3WOZUGIRtPLD/6DE3Z w==;
X-CSE-ConnectionGUID: sOtRJX8dRcixtHcZ5BwEMQ==
X-CSE-MsgGUID: bcDEkqbNRdO9/ReOkr7Nsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11712"; a="72160418"
X-IronPort-AV: E=Sophos;i="6.21,311,1763452800"; d="scan'208";a="72160418"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2026 19:02:05 -0800
X-CSE-ConnectionGUID: 45t1mdtRSPCAMUTsuExbTg==
X-CSE-MsgGUID: NbK7EVlaSrueUaDq1PrAgg==
X-ExtLoop1: 1
Received: from x299.sh.intel.com ([10.239.159.77])
 by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2026 19:01:58 -0800
From: Yujie Liu <yujie.liu@intel.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kenneth Feng <kenneth.feng@amd.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Danilo Krummrich <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Sunil Khatri <sunil.khatri@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Asad Kamal <asad.kamal@amd.com>, Yang Wang <kevinyang.wang@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Gangliang Xie <ganglxie@amd.com>, Candice Li <candice.li@amd.com>,
 YiPeng Chai <YiPeng.Chai@amd.com>, Matthew Auld <matthew.auld@intel.com>,
 Luben Tuikov <luben.tuikov@amd.com>,
 =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
 =?UTF-8?q?Micha=C5=82=20Winiarski?= <michal.winiarski@intel.com>,
 Michal Wajdeczko <michal.wajdeczko@intel.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, intel-xe@lists.freedesktop.org
Subject: [PATCH 4/7] drm/amdgpu: fix kernel-doc warning for
 amdgpu_ttm_alloc_mmio_remap_bo()
Date: Thu, 26 Feb 2026 11:00:35 +0800
Message-ID: <20260226030038.1182961-5-yujie.liu@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260226030038.1182961-1-yujie.liu@intel.com>
References: <20260226030038.1182961-1-yujie.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 26 Feb 2026 13:55:07 +0000
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

Warning: drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:1923 expecting prototype for amdgpu_ttm_mmio_remap_bo_init(). Prototype was for amdgpu_ttm_alloc_mmio_remap_bo() instead

Fixes: 96e97a562d06 ("drm/amdgpu: Drop MMIO_REMAP domain bit and keep it Internal")
Signed-off-by: Yujie Liu <yujie.liu@intel.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index eeaa56c8d129..9789b778d491 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1908,7 +1908,7 @@ static void amdgpu_ttm_pools_fini(struct amdgpu_device *adev)
 }
 
 /**
- * amdgpu_ttm_mmio_remap_bo_init - Allocate the singleton MMIO_REMAP BO
+ * amdgpu_ttm_alloc_mmio_remap_bo - Allocate the singleton MMIO_REMAP BO
  * @adev: amdgpu device
  *
  * Allocates a global BO with backing AMDGPU_PL_MMIO_REMAP when the
-- 
2.43.0

