Return-Path: <SRS0=JNIh=LB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78254C48BE5
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 16:14:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E607613FA
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 16:14:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E607613FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04C516E917;
	Mon,  7 Jun 2021 16:14:42 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DCD06E917;
 Mon,  7 Jun 2021 16:14:41 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1C9B76161F;
 Mon,  7 Jun 2021 16:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1623082480;
 bh=f80SMjVXuFIG2vJ6MBNISobFfAFhDGaZoem9OetOAbY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=W69zjaYceNwq//dRUVFIePtkjk6zsPxK1JUUauaOb4ajtbMJGFpvrOrhJL9rtYZHU
 h6RpP2FuPBVA5NAmSBYAvyCDYrDKHxBqVY0FyIDmzOfI8lXMSjdDgIL2zkbMMjKuSe
 gcpSk25cr+IcCKC0JeQKqLSkxipuyxa1QFzjrszZNuY8hhe/trMcYpqnxvfhJ3NbO4
 fDe5I6s3pXy0Bz4VCWu+hMe/3Rebn5heiO+HTTYcTSDj41JP6ABMYO1gq/GeD2izcW
 KQQbt/9BFZ8z3BfU5nHlsiYxnvfV1MCDFaa+arTkIFGAIWJXZMnoLB9rmLuRivSMwf
 TJum/DdLLbxMA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 24/29] drm/amd/display: Allow bandwidth validation
 for 0 streams.
Date: Mon,  7 Jun 2021 12:14:05 -0400
Message-Id: <20210607161410.3584036-24-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210607161410.3584036-1-sashal@kernel.org>
References: <20210607161410.3584036-1-sashal@kernel.org>
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
Cc: Sasha Levin <sashal@kernel.org>, Roman Li <Roman.Li@amd.com>,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>, Bindu Ramamurthy <bindu.r@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Bindu Ramamurthy <bindu.r@amd.com>

[ Upstream commit ba8e59773ae59818695d1e20b8939282da80ec8c ]

[Why]
Bandwidth calculations are triggered for non zero streams, and
in case of 0 streams, these calculations were skipped with
pstate status not being updated.

[How]
As the pstate status is applicable for non zero streams, check
added for allowing 0 streams inline with dcn internal bandwidth
validations.

Signed-off-by: Bindu Ramamurthy <bindu.r@amd.com>
Reviewed-by: Roman Li <Roman.Li@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index 08062de3fbeb..2b1175bb2dae 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -2917,7 +2917,7 @@ bool dcn20_validate_bandwidth(struct dc *dc, struct dc_state *context,
 	voltage_supported = dcn20_validate_bandwidth_internal(dc, context, false);
 	dummy_pstate_supported = context->bw_ctx.bw.dcn.clk.p_state_change_support;
 
-	if (voltage_supported && dummy_pstate_supported) {
+	if (voltage_supported && (dummy_pstate_supported || !(context->stream_count))) {
 		context->bw_ctx.bw.dcn.clk.p_state_change_support = false;
 		goto restore_dml_state;
 	}
-- 
2.30.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
