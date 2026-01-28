Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61025E63C8C
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jan 2026 11:08:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3BDB10E67E;
	Wed, 28 Jan 2026 11:08:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="Nfze/VEU";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B629B10E67F;
 Wed, 28 Jan 2026 11:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=KfXO1HhvV/I6fbgD2CqMkvHmSRYAO24KIOi2Zmjxm/o=; b=Nfze/VEUq4eeZwZO2LhsQilckG
 30e1V5E2KG5FJoX/WamBlRnwX9pxjKmXAbWBhSgTDGGlTl0RxgxdAFDKdqqw/4jHUucL0VGdlR1ck
 VJ6WLnci6VVHIZBV+OTLz1VBJc7yFz83FT3K9vBLoP7AQD8stQLoAIgZD+wPPnXqu7si2GB+PlXip
 ncRFUrGhFrjKmfmBMOkggcIVd3KYAZP9P2nTv6Q0mEok42ypTGaR1UoAY2VTs2THawKDwVcI3irQ2
 o9LHghsGwhX5UmahczpM+zuSfg9nkuTkK1yjOAVoY0nySG4qhWo2SGWM89uqm9YysUs4dv+WWES5m
 4u06qNZA==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1vl3PO-00Aqeh-0i; Wed, 28 Jan 2026 12:08:26 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Qiang Yu <yuq825@gmail.com>, lima@lists.freedesktop.org
Subject: [PATCH v6 23/31] drm/lima: Remove drm_sched_init_args->num_rqs usage
Date: Wed, 28 Jan 2026 11:07:58 +0000
Message-ID: <20260128110806.38350-24-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128110806.38350-1-tvrtko.ursulin@igalia.com>
References: <20260128110806.38350-1-tvrtko.ursulin@igalia.com>
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
Cc: Qiang Yu <yuq825@gmail.com>
Cc: lima@lists.freedesktop.org
Reviewed-by: Qiang Yu <yuq825@gmail.com>
---
 drivers/gpu/drm/lima/lima_sched.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/lima/lima_sched.c b/drivers/gpu/drm/lima/lima_sched.c
index 9a1e6b9ecbe5..0a01213c4878 100644
--- a/drivers/gpu/drm/lima/lima_sched.c
+++ b/drivers/gpu/drm/lima/lima_sched.c
@@ -521,7 +521,6 @@ int lima_sched_pipe_init(struct lima_sched_pipe *pipe, const char *name)
 			       lima_sched_timeout_ms : 10000;
 	const struct drm_sched_init_args args = {
 		.ops = &lima_sched_ops,
-		.num_rqs = DRM_SCHED_PRIORITY_COUNT,
 		.credit_limit = 1,
 		.hang_limit = lima_job_hang_limit,
 		.timeout = msecs_to_jiffies(timeout),
-- 
2.52.0

