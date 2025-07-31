Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1D3BC87FCC
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Jul 2025 09:44:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4712510E744;
	Thu, 31 Jul 2025 09:44:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WfkwxAZe";
	dkim-atps=neutral
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC3C710E260
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Jul 2025 09:44:16 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-3b782cca9a0so568208f8f.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Jul 2025 02:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753955055; x=1754559855; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O20uDbVY81dZwSqvDtQG4ukhsb4J7rbpMVm451fexdc=;
 b=WfkwxAZebke18xIjzWpqs8o+1LUASK9e15sE99vTA12CVxNZvI+lV8vkTg7Pz0Rmur
 Ei8R9MYqWKN2q2OVT/fQ2paJ3UhUefXl13pQL6h5lLQKwW+wosLHgPyvnVbK7k7apUen
 USxvEPgk0XyqJXy4sBc/Y7z3x2aex7FoURhyDqC6hrQOJ+3BE3RNqRnuKuGX1Pr3zQ1a
 6OUZ/s5HfhYLByOIo/g2NuvN4MJIgnSYiLFD03sV+ZPLE8DqrEFRrLDAIttwXJl0/XPY
 gBt0scs/+7rX1r5n9nwp8JfZBeVsfEdZ10e6zOgpo556foQmVjF/ACD+o4C2vrld/VOR
 MGEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753955055; x=1754559855;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O20uDbVY81dZwSqvDtQG4ukhsb4J7rbpMVm451fexdc=;
 b=R1IJrWsRcBM0BI8XSEJcCpKQM1E8bwiuIcRZCQ9MK1QjMxfCRF1mTUM+lnXy3ydJMx
 8T6rmBKDpsHS1vD8f7JGNbuvpO8vw8E6l6Za7+ERVfUVhaF/cMhqEIWWcdRBYIseKYW2
 2jjC+e5cXxx85txxbhPoQA8gami6wdQx4rJK+qDm6YQ+EcKQS5omYhdGZVyE+ecseEtS
 QDsAvHoo3qX321f3RKeHRY6OqXqT7WZp+ynRcic6lTI0i0qaZ9aVSvroi627sfqS+ytN
 duFV/V2ScTWjlFKzNk8IO1Gi0QJKYE9qrJP/V3SM6CH3wOlbDyb1BSsVig48JkG0V1qH
 /I4g==
X-Gm-Message-State: AOJu0YwiVUG6WZgmDOm2AObuaWio1qMx24F8a5qfPp63tUh5WbQCqjPO
 RbDPGqQlA3mEjKkD8Tss2S8SX6apIz0F6wNTz5ponC3vZZnrInfMq2aZOiD+Cw==
X-Gm-Gg: ASbGncvT6JV8yY53qDTMUIpMS5lSEQ3wnJm8hQhF3sxc2RNMv0EDLUHZfQdnq+nHtK3
 QM1nmVmnGhLc4zOftMVzVCXTAPl8Up1mcZ6ofnhR/fkpbcssPSF9nmwLFLpjj/EnvGa39m1DirZ
 2Xxyj6FRLqWhfxCMvMLBzf+iHojgKqgvxP2nCk4Xk70GciG/huI1TVmKM4YjIF2SCSX/oVtbyF5
 Q+yQl3V/nKEMMbF0bI/hwSGGhO7cQBjoogRoRrER9uDCRPbxLU6J6AgBy72xvy+XuYev7gXaeFZ
 8e/nOGX261jj0JgqtD1SSdBU+WpR61zut7tQQD/iYqAkrF25y7tmUMrwwwQaRBO7J8y+xjn6rCF
 ro1gxpqbUmweUR10oGUvQZRupGQfAUqMBaHDsMAcmTQEKR8FfEMQ3Ygm0WH7Gz6b2fpawTu9KOI
 rmQpYzGM4h3AoDtQ11+0OVyCgaz5LgQz+pyEuAWvWz
X-Google-Smtp-Source: AGHT+IGBufhk05bRGT2D93tlaNROwblBMqkTlIqjIKvd0GSIxJqYovFNoLhuCSzT0+rJ6HupEHG98g==
X-Received: by 2002:a05:6000:208a:b0:3b7:9d99:c0cc with SMTP id
 ffacd0b85a97d-3b79d99c3bbmr1106833f8f.51.1753955054978; 
 Thu, 31 Jul 2025 02:44:14 -0700 (PDT)
Received: from Timur-Hyperion
 (20014C4E24DDB700267C66B850A0E369.dsl.pool.telekom.hu.
 [2001:4c4e:24dd:b700:267c:66b8:50a0:e369])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4589536b3b4sm58252835e9.3.2025.07.31.02.44.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Jul 2025 02:44:13 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 1/7] drm/amd/display: Don't overclock DCE 6 by 15%
Date: Thu, 31 Jul 2025 11:43:46 +0200
Message-ID: <20250731094352.29528-2-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250731094352.29528-1-timur.kristof@gmail.com>
References: <20250731094352.29528-1-timur.kristof@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The extra 15% clock was added as a workaround for a Polaris issue
which uses DCE 11, and should not have been used on DCE 6 which
is already hardcoded to the highest possible display clock.
Unfortunately, the extra 15% was mistakenly copied and kept
even on code paths which don't affect Polaris.

This commit fixes that and also adds a check to make sure
not to exceed the maximum DCE 6 display clock.

Fixes: 8cd61c313d8b ("drm/amd/display: Raise dispclk value for Polaris")
Fixes: dc88b4a684d2 ("drm/amd/display: make clk mgr soc specific")
Fixes: 3ecb3b794e2c ("drm/amd/display: dc/clk_mgr: add support for SI parts (v2)")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 .../gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c  | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c
index 0267644717b2..cfd7309f2c6a 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c
@@ -123,11 +123,9 @@ static void dce60_update_clocks(struct clk_mgr *clk_mgr_base,
 {
 	struct clk_mgr_internal *clk_mgr_dce = TO_CLK_MGR_INTERNAL(clk_mgr_base);
 	struct dm_pp_power_level_change_request level_change_req;
-	int patched_disp_clk = context->bw_ctx.bw.dce.dispclk_khz;
-
-	/*TODO: W/A for dal3 linux, investigate why this works */
-	if (!clk_mgr_dce->dfs_bypass_active)
-		patched_disp_clk = patched_disp_clk * 115 / 100;
+	const int max_disp_clk =
+		clk_mgr_dce->max_clks_by_state[DM_PP_CLOCKS_STATE_PERFORMANCE].display_clk_khz;
+	int patched_disp_clk = MIN(max_disp_clk, context->bw_ctx.bw.dce.dispclk_khz);
 
 	level_change_req.power_level = dce_get_required_clocks_state(clk_mgr_base, context);
 	/* get max clock state from PPLIB */
-- 
2.50.1

