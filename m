Return-Path: <SRS0=cmay=4C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 914D8C3F68F
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2020 15:51:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6958824649
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2020 15:51:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cGqHRBgH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6958824649
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B23586F98C;
	Fri, 14 Feb 2020 15:51:46 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CB966F98B;
 Fri, 14 Feb 2020 15:51:45 +0000 (UTC)
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 578F02465D;
 Fri, 14 Feb 2020 15:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1581695505;
 bh=mEbUikUJPdO2aLyeQBlvtyjvsrmBOXxH5GFU6k+4vuM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=cGqHRBgH3dtHRinDlTUa/2iD1OY39U7gAQYLDmCBNTSy/mz5+GVLLao2AgmzYBe57
 edP9J0e9KRRSrzOADlSFe1RukPwkeaUeghZOP3Vb/LGB6qIYWw7b5e0/SZwEMUWfQG
 n+R96c+9oA4ppSZacNAdqgNEYF8dSyLRZqREweow=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.5 131/542] drm/amdkfd: Fix a bug in SDMA RLC queue
 counting under HWS mode
Date: Fri, 14 Feb 2020 10:42:03 -0500
Message-Id: <20200214154854.6746-131-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214154854.6746-1-sashal@kernel.org>
References: <20200214154854.6746-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
Cc: Sasha Levin <sashal@kernel.org>, Yong Zhao <Yong.Zhao@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Yong Zhao <Yong.Zhao@amd.com>

[ Upstream commit f38abc15d157b7b31fa7f651dc8bf92858c963f8 ]

The sdma_queue_count increment should be done before
execute_queues_cpsch(), which calls pm_calc_rlib_size() where
sdma_queue_count is used to calculate whether over_subscription is
triggered.

With the previous code, when a SDMA queue is created,
compute_queue_count in pm_calc_rlib_size() is one more than the
actual compute queue number, because the queue_count has been
incremented while sdma_queue_count has not. This patch fixes that.

Signed-off-by: Yong Zhao <Yong.Zhao@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 984c2f2b24b60..d128a8bbe19d0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1225,16 +1225,18 @@ static int create_queue_cpsch(struct device_queue_manager *dqm, struct queue *q,
 
 	list_add(&q->list, &qpd->queues_list);
 	qpd->queue_count++;
+
+	if (q->properties.type == KFD_QUEUE_TYPE_SDMA)
+		dqm->sdma_queue_count++;
+	else if (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI)
+		dqm->xgmi_sdma_queue_count++;
+
 	if (q->properties.is_active) {
 		dqm->queue_count++;
 		retval = execute_queues_cpsch(dqm,
 				KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0);
 	}
 
-	if (q->properties.type == KFD_QUEUE_TYPE_SDMA)
-		dqm->sdma_queue_count++;
-	else if (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI)
-		dqm->xgmi_sdma_queue_count++;
 	/*
 	 * Unconditionally increment this counter, regardless of the queue's
 	 * type or whether the queue is active.
-- 
2.20.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
