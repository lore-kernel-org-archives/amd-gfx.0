Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AC8DFCB622
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2026 16:35:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9479410ED87;
	Fri,  6 Mar 2026 16:35:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="dVVtTPKw";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2010E10EDAD;
 Fri,  6 Mar 2026 16:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=MvFJei+e5hb9YZqgU+dj2sTVv62BmdDgcX0UMdx61ME=; b=dVVtTPKwEVkrqBmAWEnWub47sN
 5L2blp+aziQ3PxBAIaajnmkefmP3Z29fIiNFOJPCvo4vt9iTao2IRHrhRZIk5Ztb/+fakATTye9na
 P9o/yR+XXcm5K9Z0N6NmYDc9L5ej6J7NEqOpu1fo55X+lS1gapVsuzvySRTIH4yzwVR6202Ti6twO
 om9oTLInFAZ7XsvTBMiIw91HPxDku9DneSP5xXOfZyzktQDZURw8Z0WGlE/ccTK2UzbMFhnBg0zRc
 uFZ2Q5hoOAgnGluLUgRnPPhSSnUK5+5l4ht3NmTRdpp1KfKHav4n+rAgXDKlfZOcsvx5O3lX1EXpg
 SdziCQ/w==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1vyY8k-00APUi-M8; Fri, 06 Mar 2026 17:35:02 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, intel-xe@lists.freedesktop.org,
 Danilo Krummrich <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>
Subject: [PATCH v7 16/29] accel/rocket: Remove drm_sched_init_args->num_rqs
 usage
Date: Fri,  6 Mar 2026 16:34:32 +0000
Message-ID: <20260306163445.97243-17-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260306163445.97243-1-tvrtko.ursulin@igalia.com>
References: <20260306163445.97243-1-tvrtko.ursulin@igalia.com>
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
Cc: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Cc: Oded Gabbay <ogabbay@kernel.org>
Reviewed-by: Tomeu Vizoso <tomeu@tomeuvizoso.net>
---
 drivers/accel/rocket/rocket_job.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
index ac51bff39833..2f1861f960cc 100644
--- a/drivers/accel/rocket/rocket_job.c
+++ b/drivers/accel/rocket/rocket_job.c
@@ -437,7 +437,6 @@ int rocket_job_init(struct rocket_core *core)
 {
 	struct drm_sched_init_args args = {
 		.ops = &rocket_sched_ops,
-		.num_rqs = DRM_SCHED_PRIORITY_COUNT,
 		.credit_limit = 1,
 		.timeout = msecs_to_jiffies(JOB_TIMEOUT_MS),
 		.name = dev_name(core->dev),
-- 
2.52.0

