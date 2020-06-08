Return-Path: <SRS0=JmOw=7V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84ABAC433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 23:08:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DD73208B6
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 23:08:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="f4Lj95gh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DD73208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17DBE6E029;
	Mon,  8 Jun 2020 23:08:45 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C29E989FF9;
 Mon,  8 Jun 2020 23:08:43 +0000 (UTC)
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A7FD920890;
 Mon,  8 Jun 2020 23:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1591657723;
 bh=7IiQDXdq9Z5dE9WWdDCDCvrJ4FHOUElT9vMdc58iVhs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=f4Lj95ghCpXTJQqlfuuZHf7dryN6Fo+aQ3BoWQTVM5Dv+ueDnAckKCN1EMlR2uG8l
 ulVrJsFgu0Y8+gbMSc6EpvyVRuK9wPJ0prj3LJuWjl47SedX5yKLQxaRTyzBg0naWU
 ZN/wFuOgq+YxXqA+5pd5RskMRDXnb86qP5eAxNto=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.7 116/274] drm/amd/display: Correct updating logic
 of dcn21's pipe VM flags
Date: Mon,  8 Jun 2020 19:03:29 -0400
Message-Id: <20200608230607.3361041-116-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608230607.3361041-1-sashal@kernel.org>
References: <20200608230607.3361041-1-sashal@kernel.org>
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
Cc: Sasha Levin <sashal@kernel.org>, Sung Lee <sung.lee@amd.com>,
 Dale Zhao <dale.zhao@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 amd-gfx@lists.freedesktop.org, Yongqiang Sun <yongqiang.sun@amd.com>,
 dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dale Zhao <dale.zhao@amd.com>

[ Upstream commit 2a28fe92220a116735ef45939b7edcfee83cc6b0 ]

[Why]:
Renoir's pipe VM flags are not correctly updated if pipe strategy has
changed during some scenarios. It will result in watermarks mistakenly
calculation, thus underflow and garbage appear.

[How]:
Correctly update pipe VM flags to pipes which have been populated.

Signed-off-by: Dale Zhao <dale.zhao@amd.com>
Signed-off-by: Sung Lee <sung.lee@amd.com>
Reviewed-by: Yongqiang Sun <yongqiang.sun@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
index a721bb401ef0..6d1736cf5c12 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
@@ -1694,12 +1694,8 @@ static int dcn21_populate_dml_pipes_from_context(
 {
 	uint32_t pipe_cnt = dcn20_populate_dml_pipes_from_context(dc, context, pipes);
 	int i;
-	struct resource_context *res_ctx = &context->res_ctx;
 
-	for (i = 0; i < dc->res_pool->pipe_count; i++) {
-
-		if (!res_ctx->pipe_ctx[i].stream)
-			continue;
+	for (i = 0; i < pipe_cnt; i++) {
 
 		pipes[i].pipe.src.hostvm = 1;
 		pipes[i].pipe.src.gpuvm = 1;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
