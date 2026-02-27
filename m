Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42A6EFEFB56
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Feb 2026 14:16:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2359B10EB9D;
	Fri, 27 Feb 2026 14:16:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="mPHNCI+N";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49F1A10E150;
 Fri, 27 Feb 2026 08:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772180741; x=1803716741;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=pcansuz8FNSKTE6JS2AWXhRwCuOm3DsoE4PhS6ombG0=;
 b=mPHNCI+NLZwRh5XnQImC1fuHf2LTkXv6HSLwzXyKiFYWRwpnfU7efrKj
 ct7IHj2bWGA27t1rM2L/Hp5c8wdxzMUu059mcl7679InkD4zSizHDCaET
 8c++h0YjShu6wYGkYR79SpCx+LItTAtblTlrQMJK/Fuu9ROtdlKP4x1Yt
 +TNYrXXzil5vLeygI9Sm+Qgf6+X72p/GlZ0DlkKd9EJFqO5LSKQnzEeMy
 pzPbRCj24GyYeR4tB8XLhJhndUwhogqTTOKDrL4F7+nG3aqgAq07sad7q
 0AYclNlDYIELRvKZrawtDxSiw8gc1gjYsbec66BxKoyK7lUF3QbEL+Htg Q==;
X-CSE-ConnectionGUID: o9ugULp+RFCZpM8qSynjDA==
X-CSE-MsgGUID: 5PQgyJ74Rr6DW3pj14Q5JQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11713"; a="73305004"
X-IronPort-AV: E=Sophos;i="6.21,313,1763452800"; d="scan'208";a="73305004"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Feb 2026 00:25:39 -0800
X-CSE-ConnectionGUID: AwmlggsSQ9mHPlDg1xps3w==
X-CSE-MsgGUID: IKEyTlFASL+qykd9gMuOZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,313,1763452800"; d="scan'208";a="216940278"
Received: from x299.sh.intel.com ([10.239.159.77])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Feb 2026 00:25:32 -0800
From: Yujie Liu <yujie.liu@intel.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Alex Deucher <Alexander.Deucher@amd.com>,
 Philipp Stanner <phasta@kernel.org>, amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] drm/scheduler: fix kernel-doc warning for
 drm_sched_job_done()
Date: Fri, 27 Feb 2026 16:24:52 +0800
Message-ID: <20260227082452.1802922-1-yujie.liu@intel.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 27 Feb 2026 14:16:40 +0000
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

Warning: drivers/gpu/drm/scheduler/sched_main.c:367 function parameter 'result' not described in 'drm_sched_job_done'

Fixes: 539f9ee4b52a ("drm/scheduler: properly forward fence errors")
Signed-off-by: Yujie Liu <yujie.liu@intel.com>
---
Changes in v2:
- Split from the original patch set
  https://lore.kernel.org/all/20260226030038.1182961-1-yujie.liu@intel.com/
- Rebase onto latest drm-tip

Changes in v3:
- Change "errno" to uppercase "ERRNO" (suggested by Philipp)

 drivers/gpu/drm/scheduler/sched_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index e6ee35406165..2d5cb21a05b6 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -361,6 +361,7 @@ static void drm_sched_run_free_queue(struct drm_gpu_scheduler *sched)
 /**
  * drm_sched_job_done - complete a job
  * @s_job: pointer to the job which is done
+ * @result: 0 on success, -ERRNO on error
  *
  * Finish the job's fence and resubmit the work items.
  */
-- 
2.43.0

