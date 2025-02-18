Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90DA0C02198
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2025 04:58:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1252E10E08D;
	Tue, 18 Feb 2025 04:58:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="H9sFLGUs";
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16D9B10E08D
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Feb 2025 04:58:57 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 31EA95C4C3D;
 Tue, 18 Feb 2025 04:58:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C048FC4CEE2;
 Tue, 18 Feb 2025 04:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1739854736;
 bh=mtzY8RI9U9lcDytEfGqFJNSYea06NxAEtZ9r925NCWc=;
 h=From:To:Cc:Subject:Date:From;
 b=H9sFLGUsBZymUKQehz2QR9wItawJGya4mBq60fUpLsJnnrBIdbBP6VUb+vUzElSZr
 mH8VerNIafuSA4CRyjcDdraGV8MC35J2aP7d9iZQ2A0bmI51Qu9iufLrDZf6lOqBe2
 4kRooON3+b2JBvf0Prsg6GypurO8rXlI7mbm3sodpsxdigmFFjF6D0+/LNA8PUCvgW
 mcZjgC+l/j89sOZ98m37b2Kdw1g0V1PW8lbfE113Lfnyd3BCMkHkKzYEtNuljYdZF2
 E+QSHGEV2dTkroSgNV+tZdGt9qNEdwoLNrL5jByGj/RcQMA7i5janSBsAGML4k7baU
 /L45TuMHuctCg==
From: Mario Limonciello <superm1@kernel.org>
To: amd-gfx@lists.freedesktop.org
Cc: harry.wentland@amd.com,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 00/13] drm/amd/display: Various cleanups to amdgpu_dm
Date: Mon, 17 Feb 2025 22:58:27 -0600
Message-ID: <20250218045840.2469890-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
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

From: Mario Limonciello <mario.limonciello@amd.com>

I was looking at amdgpu_dm for some issues and just noticed some cases
that could use cleanups for scoped cleanups and error messaging.

Mario Limonciello (13):
  drm/amd/display: Change amdgpu_dm_irq_suspend() to void
  drm/amd/display: Drop `ret` variable from dm_suspend()
  drm/amd/display: Catch failures for amdgpu_dm_commit_zero_streams()
  drm/amd/display: Use a _free() macro for
    amdgpu_dm_commit_zero_streams()
  drm/amd/display: Use drm_err() instead of DRM_ERROR in dm_resume()
  drm/amd/display: Use scoped guard for dm_resume()
  drm/amd/display: Change amdgpu_dm_irq_resume_*() to use drm_dbg()
  drm/amd/display: Change amdgpu_dm_irq_resume_*() to void
  drm/amd/display: Use _free(kfree) for dm_gpureset_commit_state()
  drm/amd/display: Use scoped guard for
    amdgpu_dm_update_connector_after_detect()
  drm/amd/display: Use _free() macro fro releasing sink in
    amdgpu_dm_update_connector_after_detect()
  drm/amd/display: Use scoped guards for handle_hpd_irq_helper()
  drm/amd/display: Use drm_err() for handle_hpd_irq_helper()

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 89 ++++++++-----------
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c | 14 ++-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h |  6 +-
 3 files changed, 44 insertions(+), 65 deletions(-)

-- 
2.43.0

