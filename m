Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E600CCD1AA
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Oct 2025 13:37:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E5E810EC2C;
	Fri, 17 Oct 2025 13:37:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="sN9e3DB2";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FB3910EC18;
 Fri, 17 Oct 2025 13:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=LuroRRxeLOFwNohk0s+UBm8zjVI2tRnmlYQm2PFfDXU=; b=sN9e3DB2/1ZztXyF9wNx0MVbBl
 EY+hb5L72EyyoRYbU/CiixaUztqw7wePk5tD2Is9eqALjw9vGNg2fgua0VYEUoHTQX2MrnUJQgl+I
 hoqH30HpegOyxbELzWQa9SEAuY0oKx0ajZN8lFgbM+NRNwmnqepYsYROB2SCZLif2a4U9zq+hnnuE
 +0RBzLE8JuhoaAj3nHvM9sMBe2JzWTcyzYijn2hM+Y35ElAUojIeb8+MOKIh+3nR2olru9XSoFkfI
 xheziJEWh/hWgZDBxnSvQbab4XfWhNFzOlzAskefl/s87FAO6z7rwgOh+SUvNfXsCHf29ikKuD6E2
 6LmYxlKg==;
Received: from [90.242.12.242] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1v9kdf-00B3wo-Vh; Fri, 17 Oct 2025 15:37:00 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Frank Binns <frank.binns@imgtec.com>, Matt Coster <matt.coster@imgtec.com>
Subject: [PATCH v2 18/27] drm/imagination: Remove drm_sched_init_args->num_rqs
 usage
Date: Fri, 17 Oct 2025 14:36:35 +0100
Message-ID: <20251017133644.44747-19-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20251017133644.44747-1-tvrtko.ursulin@igalia.com>
References: <20251017133644.44747-1-tvrtko.ursulin@igalia.com>
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

Remove member no longer used by the scheduler core.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Frank Binns <frank.binns@imgtec.com>
Cc: Matt Coster <matt.coster@imgtec.com>
Cc: dri-devel@lists.freedesktop.org
Reviewed-by: Matt Coster <matt.coster@imgtec.com>
---
 drivers/gpu/drm/imagination/pvr_queue.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/imagination/pvr_queue.c b/drivers/gpu/drm/imagination/pvr_queue.c
index fc415dd0d7a7..3509bea293bd 100644
--- a/drivers/gpu/drm/imagination/pvr_queue.c
+++ b/drivers/gpu/drm/imagination/pvr_queue.c
@@ -1228,7 +1228,6 @@ struct pvr_queue *pvr_queue_create(struct pvr_context *ctx,
 	const struct drm_sched_init_args sched_args = {
 		.ops = &pvr_queue_sched_ops,
 		.submit_wq = pvr_dev->sched_wq,
-		.num_rqs = 1,
 		.credit_limit = 64 * 1024,
 		.hang_limit = 1,
 		.timeout = msecs_to_jiffies(500),
-- 
2.48.0

