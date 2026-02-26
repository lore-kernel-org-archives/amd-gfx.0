Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1359DFCE085
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Feb 2026 13:55:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F59010E950;
	Thu, 26 Feb 2026 13:55:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="irB5J4JG";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 257C810E0D9;
 Thu, 26 Feb 2026 03:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772074912; x=1803610912;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=EMyw7QkTIGd6JUcIN1XEuwyKhym7f5E8Crv3cebehYA=;
 b=irB5J4JGZhuXIEr4KViqTWxA+rHtAe2vRxosCMOOGHqFoNVAtw6HrBmA
 9D4KGTpL1Kt3mVrjYgL8VYWkcOL+g7g3G1DgLc9+U538+8tLAQpn5Igpu
 fpGNqhRrT6S779Rqi06L6NRxDZGMOVpTyU1Sw6FQl+kJWL4OZVJNyz+4f
 EuiunKhubZC9Zq1o5bNtY91Xb1G942oC/CCWCeUXkd+jB59KPxLNIEB5S
 sNlcpb1RkhtSYqZF9mwu9ilcnaqAOrmLO6rLVNf4qvnggPMM2bghu5IdW
 fpZaBtD8EQhd2ijyHZEeRdj8Pv+NYq8vqkBPeGR8W47+dTVB4ZUEb5ixI g==;
X-CSE-ConnectionGUID: sOPJxlYlRSy+maPjoO16Kw==
X-CSE-MsgGUID: BDVeGbXVT1W2YnnZy3EUOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11712"; a="72160306"
X-IronPort-AV: E=Sophos;i="6.21,311,1763452800"; d="scan'208";a="72160306"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2026 19:01:35 -0800
X-CSE-ConnectionGUID: K7D9cgqmT1CKgaCWNp6deg==
X-CSE-MsgGUID: DC9Tt5RFRhuFtePJlYdziQ==
X-ExtLoop1: 1
Received: from x299.sh.intel.com ([10.239.159.77])
 by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2026 19:01:28 -0800
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
Subject: [PATCH 0/7] drm: fix some kernel-doc warnings
Date: Thu, 26 Feb 2026 11:00:31 +0800
Message-ID: <20260226030038.1182961-1-yujie.liu@intel.com>
X-Mailer: git-send-email 2.43.0
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

Yujie Liu (7):
  drm/gpusvm: fix kernel-doc warning for
    drm_gpusvm_pages_valid_unlocked()
  drm/scheduler: fix kernel-doc warning for drm_sched_job_done()
  drm/gma500: fix kernel-doc warning for framebuffer init/create
    functions
  drm/amdgpu: fix kernel-doc warning for
    amdgpu_ttm_alloc_mmio_remap_bo()
  drm/xe/pf: fix kernel-doc warning for SR-IOV VF restore function
  drm/amd/pm: fix kernel-doc warning for smu_msg_v1_send_msg()
  drm/amd/ras: fix kernel-doc warning for ras_eeprom_append()

 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c      | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c       | 2 +-
 drivers/gpu/drm/amd/ras/rascore/ras_eeprom.c | 4 ++--
 drivers/gpu/drm/drm_gpusvm.c                 | 4 ++--
 drivers/gpu/drm/gma500/framebuffer.c         | 2 ++
 drivers/gpu/drm/scheduler/sched_main.c       | 1 +
 drivers/gpu/drm/xe/xe_gt_sriov_pf_control.c  | 2 +-
 7 files changed, 10 insertions(+), 7 deletions(-)

-- 
2.43.0

