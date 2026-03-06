Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E22A7FCB630
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2026 16:35:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 268A810EDB7;
	Fri,  6 Mar 2026 16:35:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="Gf8kjuB5";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FCD710EDBB;
 Fri,  6 Mar 2026 16:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=fd2zji5naxBLwhuDN8nbTck4slemvTjhXqRq7f9PhCU=; b=Gf8kjuB5CPsoHG2IlULyQSZcI1
 HaJT/xDVLr3I9YD2+R4CkZZ/Y2dq6QIp485Yml6gKXLRwn28RoNhQ76TVyjx8SEYD8y0Uf1aDQkFB
 2nzn5MR328fIscKDo2Du6jECMg+DqhD58u8jupFXLoppP4W+NAw+AZNGlt5/7E3HIpabnIMhviycb
 pHiLflSxSmjkghAMefbKGZIOBRwM9W0jb9aOmEEA28UNiUSD9l9sEx+dO3QjJBqL3pyNRPwjz8C40
 RKtRBhwexqx8JtKx7Iqf1m3qtMU0MP0D/CSJGNlRgY3NqoxkOieKoDlxqkA0XmUi5KzVMqZ4xxG5c
 FUeDUD7Q==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1vyY8n-00APVj-RI; Fri, 06 Mar 2026 17:35:05 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, intel-xe@lists.freedesktop.org,
 Danilo Krummrich <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Frank Binns <frank.binns@imgtec.com>, Matt Coster <matt.coster@imgtec.com>
Subject: [PATCH v7 20/29] drm/imagination: Remove drm_sched_init_args->num_rqs
 usage
Date: Fri,  6 Mar 2026 16:34:36 +0000
Message-ID: <20260306163445.97243-21-tvrtko.ursulin@igalia.com>
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
Cc: Frank Binns <frank.binns@imgtec.com>
Cc: Matt Coster <matt.coster@imgtec.com>
Cc: dri-devel@lists.freedesktop.org
Reviewed-by: Matt Coster <matt.coster@imgtec.com>
---
 drivers/gpu/drm/imagination/pvr_queue.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/imagination/pvr_queue.c b/drivers/gpu/drm/imagination/pvr_queue.c
index dd88949f6194..2b8ec4f87799 100644
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
2.52.0

