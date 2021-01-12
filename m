Return-Path: <SRS0=dvhx=GP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4459EC433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jan 2021 12:56:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D48412336F
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jan 2021 12:56:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D48412336F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4378F6E203;
	Tue, 12 Jan 2021 12:56:35 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D41C56E201;
 Tue, 12 Jan 2021 12:56:33 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id B22D22333B;
 Tue, 12 Jan 2021 12:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1610456193;
 bh=IO07lAPmVIHL6U9iLfamBIZXzOpk67bl0Wv3eCpJyL4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=KDio7TW/YhbSgh15W+Ct9JQQeZjMT2tk8f4xosGw7S3JGGv3RJkM9GFCPHn/QrU7O
 4n4WMKf+d44A4rhX48V6PFetMUX0OThQkNLfxezAFDQMWKM2KqpmoqqKA6wyihODSu
 m6OdbHgeWrt6Pi+Q/9ZKgL8z6MVTgOJKxDBOMO9GIIR+NO6mVT8g4iryq9pkL9Il5c
 0J1ZnW7YGbukA+j9TWzc27odOSU9COYkTdmVpmGY/0PGOjY3lrUqdKTp2SEi5E3SKb
 tcVmRgDCmErCx/jjwEqAxzAuiAV7bpB7u+XLqo2OgMmAmIVyDu9QKA+heJM4uI9XSF
 HvkDV6hCIotpQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 44/51] drm/amdgpu: fix potential memory leak
 during navi12 deinitialization
Date: Tue, 12 Jan 2021 07:55:26 -0500
Message-Id: <20210112125534.70280-44-sashal@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210112125534.70280-1-sashal@kernel.org>
References: <20210112125534.70280-1-sashal@kernel.org>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Sasha Levin <sashal@kernel.org>,
 Jiawei Gu <Jiawei.Gu@amd.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jiawei Gu <Jiawei.Gu@amd.com>

[ Upstream commit e6d5c64efaa34aae3815a9afeb1314a976142e83 ]

Navi12 HDCP & DTM deinitialization needs continue to free bo if already
created though initialized flag is not set.

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jiawei Gu <Jiawei.Gu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index a6dbe4b83533f..2f47f81a74a57 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1283,8 +1283,12 @@ static int psp_hdcp_terminate(struct psp_context *psp)
 	if (amdgpu_sriov_vf(psp->adev))
 		return 0;
 
-	if (!psp->hdcp_context.hdcp_initialized)
-		return 0;
+	if (!psp->hdcp_context.hdcp_initialized) {
+		if (psp->hdcp_context.hdcp_shared_buf)
+			goto out;
+		else
+			return 0;
+	}
 
 	ret = psp_hdcp_unload(psp);
 	if (ret)
@@ -1292,6 +1296,7 @@ static int psp_hdcp_terminate(struct psp_context *psp)
 
 	psp->hdcp_context.hdcp_initialized = false;
 
+out:
 	/* free hdcp shared memory */
 	amdgpu_bo_free_kernel(&psp->hdcp_context.hdcp_shared_bo,
 			      &psp->hdcp_context.hdcp_shared_mc_addr,
@@ -1430,8 +1435,12 @@ static int psp_dtm_terminate(struct psp_context *psp)
 	if (amdgpu_sriov_vf(psp->adev))
 		return 0;
 
-	if (!psp->dtm_context.dtm_initialized)
-		return 0;
+	if (!psp->dtm_context.dtm_initialized) {
+		if (psp->dtm_context.dtm_shared_buf)
+			goto out;
+		else
+			return 0;
+	}
 
 	ret = psp_dtm_unload(psp);
 	if (ret)
@@ -1439,6 +1448,7 @@ static int psp_dtm_terminate(struct psp_context *psp)
 
 	psp->dtm_context.dtm_initialized = false;
 
+out:
 	/* free hdcp shared memory */
 	amdgpu_bo_free_kernel(&psp->dtm_context.dtm_shared_bo,
 			      &psp->dtm_context.dtm_shared_mc_addr,
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
