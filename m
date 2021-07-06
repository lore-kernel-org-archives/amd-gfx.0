Return-Path: <SRS0=iwxs=L6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 155FAC11F66
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jul 2021 11:14:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC794619C5
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jul 2021 11:14:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC794619C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28BC889F6E;
	Tue,  6 Jul 2021 11:14:22 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E1F689F5F;
 Tue,  6 Jul 2021 11:14:20 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5321661C20;
 Tue,  6 Jul 2021 11:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1625570060;
 bh=5lNEDT8qos+QLc8MRVxXgKYOzcrK5fqrjXUcMPRfdMg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=NSbSsBsviB61XKXoBWYtR1Ue4YWqbRnGeuX5UXg7bUQp2NTK/4GlQrqvQ2PxR6L7t
 aD5QDX0VqSGL8mc9MUP5qRFOKmykCmnAH/YnkKjiBNU5PQ4trV5wBhbVWhRZFjAYjC
 li+CDSpXYTEpXwH0lrVkDkjSsIvSoWE2e7HmrnYUbT6WF5MoQpi9fEE/lnEmlCl6o9
 zE7771nWSTd7l3Uoh/U+pCW60VOphmhEBFNlYoZjQfOj55LsaYczZw9JYNv9K7Vehw
 vvAOqvDka2Lon6/bkmMPfb9J2lIwCGypt5eR7DKDa+rXjAZaehok1OPsQIKtTNWt56
 5f/uoVyohlklw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.13 007/189] drm/amd/display: Fix BSOD with NULL check
Date: Tue,  6 Jul 2021 07:11:07 -0400
Message-Id: <20210706111409.2058071-7-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210706111409.2058071-1-sashal@kernel.org>
References: <20210706111409.2058071-1-sashal@kernel.org>
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
Cc: Sasha Levin <sashal@kernel.org>, Chris Park <Chris.Park@amd.com>,
 amd-gfx@lists.freedesktop.org, Daniel Wheeler <daniel.wheeler@amd.com>,
 Wayne Lin <waynelin@amd.com>, dri-devel@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Chris Park <Chris.Park@amd.com>

[ Upstream commit b2d4b9f72fb14c1e6e4f0128964a84539a72d831 ]

[Why]
CLK mgr is null for server settings.

[How]
Guard the function with NULL check.

Signed-off-by: Chris Park <Chris.Park@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Wayne Lin <waynelin@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index e57df2f6f824..a869702d77af 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3274,7 +3274,7 @@ void dc_allow_idle_optimizations(struct dc *dc, bool allow)
 	if (dc->debug.disable_idle_power_optimizations)
 		return;
 
-	if (dc->clk_mgr->funcs->is_smu_present)
+	if (dc->clk_mgr != NULL && dc->clk_mgr->funcs->is_smu_present)
 		if (!dc->clk_mgr->funcs->is_smu_present(dc->clk_mgr))
 			return;
 
-- 
2.30.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
