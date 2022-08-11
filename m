Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6AF2C19F2A
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Aug 2022 15:48:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12B839A8A7;
	Thu, 11 Aug 2022 15:48:16 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A1BDB47EF;
 Thu, 11 Aug 2022 15:48:07 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id E72E261714;
 Thu, 11 Aug 2022 15:48:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF259C43141;
 Thu, 11 Aug 2022 15:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1660232886;
 bh=5VONM8AZd/i5yhEdHC2G9D7p3qdxuKwqB16hmKffJ/s=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=YX9fV2KqxB6GsKPQ3fY8UWtzIHOFYqCzGvW+rlSyY+bFOrQeyevMXF/eapWuX2G1Z
 dAq2Ch+fgykrynhrQswJBBx5RlqJu2nqppcnFNr9aRv+OHcERC2q1liuYEr/JX9C+Z
 IQV/IJjoW4/0cJwAoR9ygIpyKRBPYa7INJc2kCltp0gZI5qBI4iK/nTMAIb6dWCmmj
 kAUSppt1l9YATw0sFnoMXoAx9Ccup71VUS0+83LAW5tKoEBhK3dgjnzVMQmfwgkkWN
 qZSdymG9lYEdsffMaiPA3lLp3mA3dYcXOqsqd8QdNz6LkmfTBm8R0cl59IVC7kFv3U
 wTXngMy3cRAcQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.18 52/93] drm/amd/display: Guard against ddc_pin
 being NULL for AUX
Date: Thu, 11 Aug 2022 11:41:46 -0400
Message-Id: <20220811154237.1531313-52-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220811154237.1531313-1-sashal@kernel.org>
References: <20220811154237.1531313-1-sashal@kernel.org>
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
Cc: Sasha Levin <sashal@kernel.org>, aric.cyr@amd.com, baihaowen@meizu.com,
 arnd@arndb.de, sunpeng.li@amd.com, Jing.Zhou@amd.com, Xinhui.Pan@amd.com,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org,
 christian.koenig@amd.com, meenakshikumar.somasundaram@amd.com,
 airlied@linux.ie, Daniel Wheeler <daniel.wheeler@amd.com>,
 Michael Strauss <Michael.Strauss@amd.com>, dri-devel@lists.freedesktop.org,
 daniel@ffwll.ch, wyatt.wood@amd.com, Alex Deucher <alexander.deucher@amd.com>,
 harry.wentland@amd.com, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Jimmy.Kizito@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[ Upstream commit bc19909f19fdc8253d720d11c948935786fbfa08 ]

[Why]
In the case where we don't support DMUB aux but we have DPIA links
in the configuration we might try to message AUX using the legacy
path - where DDC pin is NULL. This causes a NULL pointer dereference.

[How]
Guard against NULL DDC pin, return a failure for aux engine acquire.

Reviewed-by: Michael Strauss <Michael.Strauss@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
index 8e814000db62..5620a3345e4d 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
@@ -573,6 +573,11 @@ int dce_aux_transfer_raw(struct ddc_service *ddc,
 	memset(&aux_req, 0, sizeof(aux_req));
 	memset(&aux_rep, 0, sizeof(aux_rep));
 
+	if (ddc_pin == NULL) {
+		*operation_result = AUX_RET_ERROR_ENGINE_ACQUIRE;
+		return -1;
+	}
+
 	aux_engine = ddc->ctx->dc->res_pool->engines[ddc_pin->pin_data->en];
 	if (!acquire(aux_engine, ddc_pin)) {
 		*operation_result = AUX_RET_ERROR_ENGINE_ACQUIRE;
-- 
2.35.1

