Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D803FCB625
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2026 16:35:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 667A210EDB2;
	Fri,  6 Mar 2026 16:35:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="SQFhq1ky";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9F6410EDA8;
 Fri,  6 Mar 2026 16:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=dahDAIqqNAxTfhLdFyGangUM2N0bRSP4ciQbAF7UBw8=; b=SQFhq1ky5B7diw7lHaOJJZ0Mj+
 28A4+28x7O0G+nqRES+e2yW7JnMLYQvNu9bbqb5ZINNOHy5ja15JzMhOWKnvqbbzfKN66sBA/eaUp
 dHwtkVoijUjoyyktWF6J8kAMnAMLouyW2ljmp2Qa06y4N1slbUj4Hx/QCmkZ92SOBhlhyufjV6opN
 Da/f34AAjvaoypUFXDvmuxonoNlkSDy+k4tZWiWfc4OxT7u+Qz4hqwa4pkpVbAo8Lhh54QZtNON2d
 ewErT2/VUZOmSe9E3vb93cSp6J7f2JvWlFCsyWgWuJ+ZnUf0iq5e9LXSsXZhNxEW46gdYX4A7S57m
 /8Egc3iA==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1vyY8j-00APUQ-Rt; Fri, 06 Mar 2026 17:35:01 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, intel-xe@lists.freedesktop.org,
 Danilo Krummrich <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, Min Ma <mamin506@gmail.com>,
 Lizhi Hou <lizhi.hou@amd.com>, Oded Gabbay <ogabbay@kernel.org>
Subject: [PATCH v7 15/29] accel/amdxdna: Remove drm_sched_init_args->num_rqs
 usage
Date: Fri,  6 Mar 2026 16:34:31 +0000
Message-ID: <20260306163445.97243-16-tvrtko.ursulin@igalia.com>
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
Cc: Min Ma <mamin506@gmail.com>
Cc: Lizhi Hou <lizhi.hou@amd.com>
Cc: Oded Gabbay <ogabbay@kernel.org>
Reviewed-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/accel/amdxdna/aie2_ctx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/amdxdna/aie2_ctx.c
index afee5e667f77..9d4791fb6c45 100644
--- a/drivers/accel/amdxdna/aie2_ctx.c
+++ b/drivers/accel/amdxdna/aie2_ctx.c
@@ -545,7 +545,6 @@ int aie2_hwctx_init(struct amdxdna_hwctx *hwctx)
 	struct amdxdna_dev *xdna = client->xdna;
 	const struct drm_sched_init_args args = {
 		.ops = &sched_ops,
-		.num_rqs = DRM_SCHED_PRIORITY_COUNT,
 		.credit_limit = HWCTX_MAX_CMDS,
 		.timeout = msecs_to_jiffies(HWCTX_MAX_TIMEOUT),
 		.name = "amdxdna_js",
-- 
2.52.0

