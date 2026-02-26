Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3C2CFCE089
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Feb 2026 13:55:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B79E10E94E;
	Thu, 26 Feb 2026 13:55:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="NE+M5LRr";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 694BC10E0FE;
 Thu, 26 Feb 2026 03:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772074932; x=1803610932;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=rLKrqWvXZmiRlPwNwT0KN1pdGmTSu7/QIs0m2zyAKGc=;
 b=NE+M5LRrHIe2iCP53+y1gD+BMtI239gUORorniTK+UPhEi49pXA+4Z/N
 NNYlpA2Wj8peK2ZHEEh2SnhzLJwex0SK6h/3cDqIklFCLaRg3kpISyP1U
 8SUOdXPPYUvpFIotxOuChsbcQ783MAll/hWHSKvQhdPV6n/ddPmdd9dzR
 iBBaEcCi0pSi9XzZkiuqZQn79rakCqcfbQGKFwTUNU7DwQtzB2CtfHvWn
 FiTEonABd/LRpbfI4a5BKJGsCq4N0wF+qmegjLfBLbtgvMv9kWw9f1TUG
 rWDdzXEL0BzymWo+6AamVCisKQj/Yc9Dy3p+aXlCrIFHgpPFQ+gsYsa4j A==;
X-CSE-ConnectionGUID: XYgxQZfsQEyPKLkWnlAkwA==
X-CSE-MsgGUID: geFe5OpZQuGv8RSsQ3K8rg==
X-IronPort-AV: E=McAfee;i="6800,10657,11712"; a="72160439"
X-IronPort-AV: E=Sophos;i="6.21,311,1763452800"; d="scan'208";a="72160439"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2026 19:02:12 -0800
X-CSE-ConnectionGUID: 5Xwx6m21Qd+0XNc7XVEdHw==
X-CSE-MsgGUID: 9kUD08HDSyGiViiLlgh+sg==
X-ExtLoop1: 1
Received: from x299.sh.intel.com ([10.239.159.77])
 by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2026 19:02:05 -0800
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
Subject: [PATCH 5/7] drm/xe/pf: fix kernel-doc warning for SR-IOV VF restore
 function
Date: Thu, 26 Feb 2026 11:00:36 +0800
Message-ID: <20260226030038.1182961-6-yujie.liu@intel.com>
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

Warning: drivers/gpu/drm/xe/xe_gt_sriov_pf_control.c:1261 This comment starts with '/**', but isn't a kernel-doc comment. Refer to Documentation/doc-guide/kernel-doc.rst
 * xe_gt_sriov_pf_control_trigger restore_vf() - Start an SR-IOV VF migration data restore sequence.

Fixes: ed46ff0d51e4 ("drm/xe/pf: Add save/restore control state stubs and connect to debugfs")
Signed-off-by: Yujie Liu <yujie.liu@intel.com>
---
 drivers/gpu/drm/xe/xe_gt_sriov_pf_control.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_gt_sriov_pf_control.c b/drivers/gpu/drm/xe/xe_gt_sriov_pf_control.c
index bf48b05797de..5cb705c7ee7a 100644
--- a/drivers/gpu/drm/xe/xe_gt_sriov_pf_control.c
+++ b/drivers/gpu/drm/xe/xe_gt_sriov_pf_control.c
@@ -1259,7 +1259,7 @@ int xe_gt_sriov_pf_control_process_restore_data(struct xe_gt *gt, unsigned int v
 }
 
 /**
- * xe_gt_sriov_pf_control_trigger restore_vf() - Start an SR-IOV VF migration data restore sequence.
+ * xe_gt_sriov_pf_control_trigger_restore_vf() - Start an SR-IOV VF migration data restore sequence.
  * @gt: the &xe_gt
  * @vfid: the VF identifier
  *
-- 
2.43.0

