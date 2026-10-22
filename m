Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706CC606A31B
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2026 09:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NiPUQ2Ks
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A003112467;
	Thu, 22 Oct 2026 09:45:00 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F1861123CE
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2026 08:10:29 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4a1ec92f655so7057165e9.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2026 01:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792656627; x=1793261427; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5WlGP2aYrjDFuUc+YNVO9vArip6u9SIM0c4z3P59W+A=;
 b=NiPUQ2Ksc777yciunid9id1/ZTvIcvKp9Ey1XnnvF41hq1HkTMOv1oq03lW8Dhf/qt
 zg6U5QVyMLisyY2OC7JEpHpYtJjwjOopeNLT/GPUukc04SIT/sKSeGk9+P8pi+5Tua8W
 JgO+K2aq61rAjG0UFA0SfqXc7cD7JWwze9neHTHc7VVsG2/ynEbVk98/tyPDKTlGyeos
 nwucdUfSpRERymb2t6/i2cg4GnCG9/FgZwzsnYNEyxtLe6eUY04PuJ/RK3/G9CvoOAgL
 kA/N2LExEtiWa4IG8vLFNVqvSrbIUOVkpVTwQf/6pvmN1dLaM0vgOu+c5z0awdaojZie
 ri+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792656627; x=1793261427;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5WlGP2aYrjDFuUc+YNVO9vArip6u9SIM0c4z3P59W+A=;
 b=r0joUm746oHTAvvKfuulTJXK/Dh5GwpNCHXtJ2zoo+gEJhMFXVy1aa0w+IE4OQ8GJn
 0bHF8XTrHah4kQoWrv+dGrw7SrRjmnQMlBS2W2jNEnVJjssj1sTMdOW2pXqPDlUOmmcU
 NO1UDKOpfFzOZIXGTL3szjRc9EPxUQmGhLeCZezztlPyNftONCoaL9dIS2/n58T+Pd5m
 A1gEtLZizUvUmERqkofy0t1ji+VaXh4EDcpbn2+yMN8533lz5yX6PMl5S2qh3tGDZCnl
 EYL1uFWk9eVkqpzNC2ODaBxSEJgEVt0cMEu8yldtt2APkttCXg4Po+o7WsrGiaILd7ej
 7EUw==
X-Gm-Message-State: AFq9FYKq5D2DOKhknh9OnA+AYnULCswEC3QQCTcUxVXyTEso0oAFwIPi
 J6jkGhHfg8hx6jUMK4d53xZ0NlAgnxsLdFUc9alQ/PTV6vEHVUocKOC6GyMgSpqOU7Yr8g==
X-Gm-Gg: AYBFou0JlL0CWgKAIRj3rENZ3SPecuy2RgNQRAqaGX8y19lHs3Acj165ruUuEUDmWOm
 mXkxncmlJMOAhcTCvbEfJdGnR8130Invdz9oUSWcXP+KxgA55oRd3550rby99/Iq6ltBIHxWgWR
 pn+IPntTb89+3cdqxd1neNSzrDpXpazlbGszwrTdUdSp8J86v8FCggcrT70h0syOEgUApFzjWi8
 MsPuXX+pLRVFwQiHJhtNhjcgQE8pQuFyliq5dEfJcSODFpVtFnk7R1YxBQqHeiX+PCp7XjZcHWK
 UiEDlLEI4hNElWa6ZuT32k8svByP/I+tlEgSDMMi77uw4lCUTGrFHmtjPidatCtBxsEQu3IvssL
 TeyIQ6+bdka0VoImdYLyun7VlWGI+Of6oBeTxkABBf4i4Room1HM0HZbBfKjG3UrxuJI7ib1/6+
 lSAzoLi1sum5UXFRqPzJZVQ9dNB1sdKG/PdeqhJNKBbRFM7u7/hwWdarVN1XxbWEK65zChUsHbN
 yc7WIMNEVMdXDI56rYg5qglSexIIbeyrEpGJL+cZJjpRzgpuR9m70fMa+8i1H68zDyxAC0BXA/3
 sul4Bbm8CcRknw52oCbdimsOHjUbeDHI+TEUuvPl+NrU8B5p
X-Received: by 2002:a05:600c:8b22:b0:4a1:c27d:e1a8 with SMTP id
 5b1f17b1804b1-4a204b1f425mr31189595e9.10.1792656627397; 
 Thu, 22 Oct 2026 01:10:27 -0700 (PDT)
Received: from tvab-pc (v2202507270734364850.supersrv.de. [152.53.198.198])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1fcd234fasm72133325e9.3.2026.10.22.01.10.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 01:10:27 -0700 (PDT)
From: Ilya Shidlovskiy <shidlovskiyilya@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: Ilya Shidlovskiy <shidlovskiyilya@gmail.com>,
 Kenneth Feng <kenneth.feng@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH v2 1/3] drm/amd/display: dcn32: rebuild WM range table when
 memclk states change
Date: Thu, 22 Oct 2026 11:09:23 +0300
Message-ID: <20261022080925.13994-2-shidlovskiyilya@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261022080925.13994-1-shidlovskiyilya@gmail.com>
References: <20261022080925.13994-1-shidlovskiyilya@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 22 Oct 2026 09:44:57 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

dcn32_get_memclk_states_from_smu() refreshes the UCLK levels,
max_memclk_mhz and the bounding box, but the watermark range table and
the dummy P-state table (which are derived from the same memclk levels)
are only built once in dcn32_init_clocks(). Build them at the end of
dcn32_get_memclk_states_from_smu() instead, so that every caller which
re-reads the memclk states from PMFW also gets matching WM ranges.

No functional change for the init path.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/6009
Acked-by: Leo Li <sunpeng.li@amd.com>
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Ilya Shidlovskiy <shidlovskiyilya@gmail.com>
---

Notes:
    v2:
    - rebased on amd-staging-drm-next, no code changes
    - added Leo's Acked-by (given in drm/amd#6009)

 .../gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
index 22dfca6ef..7abb13ffd 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
@@ -256,11 +256,8 @@ void dcn32_init_clocks(struct clk_mgr *clk_mgr_base)
 		if (clk_mgr_base->bw_params->clk_table.entries[i].dppclk_mhz > 1950)
 			clk_mgr_base->bw_params->clk_table.entries[i].dppclk_mhz = 1950;
 
-	/* Get UCLK, update bounding box */
+	/* Get UCLK, update bounding box and WM range table */
 	clk_mgr_base->funcs->get_memclk_states_from_smu(clk_mgr_base);
-
-	/* WM range table */
-	dcn32_build_wm_range_table(clk_mgr);
 }
 
 static void dcn32_update_clocks_update_dtb_dto(struct clk_mgr_internal *clk_mgr,
@@ -1079,6 +1076,9 @@ static void dcn32_get_memclk_states_from_smu(struct clk_mgr *clk_mgr_base)
 	/* Refresh bounding box */
 	clk_mgr_base->ctx->dc->res_pool->funcs->update_bw_bounding_box(
 			clk_mgr->base.ctx->dc, clk_mgr_base->bw_params);
+
+	/* WM range table and dummy P-state table depend on the memclk levels */
+	dcn32_build_wm_range_table(clk_mgr);
 }
 
 static bool dcn32_are_clock_states_equal(struct dc_clocks *a,
-- 
2.55.0

