Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D82CAC43219
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Nov 2021 02:34:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DF5F6E4FF;
	Fri, 26 Nov 2021 02:34:14 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCA1C6E4FF;
 Fri, 26 Nov 2021 02:34:13 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 855F5611BD;
 Fri, 26 Nov 2021 02:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1637894053;
 bh=GS9jBDXv4hv8mV0fPr8imW97TpER2Lo9bSrdDSoF28o=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=sT+MCl5CMAZsp4Qv31131j0SlEOLcjScJjPfFJWMxUTNIr8pVrkkVWqUir10agBc0
 Yev1uuQV4t0BG4uq7RJ/lYDGMTK8HrdmP77i6jEquUMwdo9ZEWmn77owCyhyn/kNTI
 8c6f/fTCQcg0WF75NVFDYcPGtjX6JvnGl9mCvxD4JBaBZHDYd20heNY8raf2xojgQk
 T8bn30x9acCQ8gTJmdLeyDaldxnlCEB5kIAGsJk5qrvs4QoSMYvoM5zx+boI8OjxHM
 d3Hq/qKQB2MUxIVBLZQPdmSIVrpxII8Rsj0tIJRtVLYZTooRQBs13+c4AYIuCHJKRB
 NB75IiD7418tQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 18/28] drm/amd/amdkfd: Fix kernel panic when
 reset failed and been triggered again
Date: Thu, 25 Nov 2021 21:33:33 -0500
Message-Id: <20211126023343.442045-18-sashal@kernel.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211126023343.442045-1-sashal@kernel.org>
References: <20211126023343.442045-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
Cc: Sasha Levin <sashal@kernel.org>, airlied@linux.ie,
 Felix Kuehling <Felix.Kuehling@amd.com>, Xinhui.Pan@amd.com,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 daniel@ffwll.ch, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, shaoyunl <shaoyun.liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: shaoyunl <shaoyun.liu@amd.com>

[ Upstream commit 2cf49e00d40d5132e3d067b5aa6d84791929ab15 ]

In SRIOV configuration, the reset may failed to bring asic back to normal but stop cpsch
already been called, the start_cpsch will not be called since there is no resume in this
case.  When reset been triggered again, driver should avoid to do uninitialization again.

Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 352a32dc609b2..2645ebc63a14d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1207,6 +1207,11 @@ static int stop_cpsch(struct device_queue_manager *dqm)
 	bool hanging;
 
 	dqm_lock(dqm);
+	if (!dqm->sched_running) {
+		dqm_unlock(dqm);
+		return 0;
+	}
+
 	if (!dqm->is_hws_hang)
 		unmap_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES, 0);
 	hanging = dqm->is_hws_hang || dqm->is_resetting;
-- 
2.33.0

