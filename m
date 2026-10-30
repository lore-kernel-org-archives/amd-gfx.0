Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DCC606A326
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2026 08:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yD3Zn9ml
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E39D10EBE5;
	Mon,  2 Nov 2026 08:06:54 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49D6E10E217
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Oct 2026 16:58:50 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-48c4d870d54so614754f8f.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Oct 2026 09:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793379529; x=1793984329; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=M+gDtiunP4sJjVlGzpdrJNzIkGfyAeJ8NOXezuCcCwA=;
 b=yD3Zn9mloCBMdX+/BFEF8ZlsO8jHwzV/u+5M2s4Tt/MQBqmCx41vYF4ml1pnO5rBCj
 6u284L1sT6wohARmdO8uPJZqx2Q3sziBBquaUm45BqUBaxQxCdJeEtcta2pS7yfj2ElM
 y3vMuqQbWnY53tLnSYKdzXCkNMMfzSWlCJ6Guxpp5hfMitNzB+q1Q2din+/UXuJwUtIQ
 z2ajM79HftZQDoz2p/fugHe/GwhAwmMrH/Msqcbfa+Z0D3zQ8kOeW2WNvblMKpFQ/8Nd
 YGGk63XPyYG77c1y0MsrHsmqDF60oYDMeJeZGYY6ACNjK2rYfBsMSOwyI5GpMGJWW7y/
 /tCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793379529; x=1793984329;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=M+gDtiunP4sJjVlGzpdrJNzIkGfyAeJ8NOXezuCcCwA=;
 b=lNlfG7kQ9w8wHrTK9C+6KdZ8s1WHTgnVtBJp2W1+hVluuQceTL0NLUYev9A+hMXiAB
 70qE5AjOHaoHq4Dc4w78wDAF+9hy9Xi4TWhlqNJ+KXiUi8w+7me2WlejhXuNKiaVkyTk
 eElaJQJHgVDd1MUBNIlqlOUMKfMBDDTuNF7SYyPd3nJzxZVlskVZSopeVEFzmXwXo3Bx
 p7kQUon8G+ovqHSqwmEKjJgq5eKTUR91Q8EvXIVgqEtx9xiLP8l+GgBLCWeU7ggY9yxn
 BD7fG3OblQELjxua++l1D3qGsjgnY9qfo8UBm7DH1sWseN9/beRDoPCa6toP+WbnPgsm
 M8+A==
X-Gm-Message-State: AFq9FYLZJeS2fg09M9YtOyoma2o0a/LrUZeh+zDgjBgJbFiDpqOmT6gV
 LphUqdJzKM28l3iKQdRfoNIcZBOMZ9RkIdbnhwginSV2+YyKO6yNjbnqqHCwOwrkP6uGkQ==
X-Gm-Gg: AYBFou3amjZ4bosv2zz+MSKLFrisfr8NBHT2VN2pwO6K4UEDqt5aGlunQFlSDIXHswa
 BEs9yvktMGBQVap+tJx0zIn8GbkDVBYxO4BUC5/aBqAmW6k4trqqxqTQ4Qm/3/AnF0oC+GfVH9t
 kJ6xoIRgO+xZXtl2+rq24I5zHYx6NajMSEFMaS7HN8OgAWmd5A6+k/nCAUbrISoFrFIGpKbsxUd
 Vj/mcaSxCXIut48cAtnnlrF7T31MYUcYod+3Kc9oNPAFJvaclzqk/dam9u5wWY64rRCN/Eqx5KI
 p3x3nD3w0hUtmihmY6U+2pAAr8/Sizo+pM6NXvtoeE2f+jy+Bk1SmgcaV2lopXVdN5yrr7fgcEz
 b6s4ArInNvv4Q0fqXlj+ujW1XBHRDrVeXyRy7++9M93llMPCmYwgk4Z/QX5F7r3U42P+hG0Cxev
 e2Ife56RWGa5YBKQJZg2Tg7EjjnvMBtJNOcl2AneCRvSmMqIo/uXDHdMkcsiCFN9Jx2G2LvXGC/
 ZoXBTsJ+v23CNOQSfvux0IVcWotjmgTE7vRU9DRw+nXfWddeJkIMDZcO5N0YkCWxwSBbIZnP7w6
 LIUcxMIOXm5LbCEkxMeyPmcmMuycPzqOsUXvB5zQk64kJ+vUoTjD4qQ6tiuMMhib3QZHXC1RT67
 MvZZSOS2XaJcBCJU70gQTzOo=
X-Received: by 2002:a05:6000:29d6:b0:48e:4300:c6d8 with SMTP id
 ffacd0b85a97d-48e6e2ff1b4mr4452611f8f.35.1793379528572; 
 Fri, 30 Oct 2026 09:58:48 -0700 (PDT)
Received: from tvab-pc (v2202507270734364850.supersrv.de. [152.53.198.198])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71ba24f6sm4033465f8f.51.2026.10.30.09.58.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 09:58:48 -0700 (PDT)
From: Ilya Shidlovskiy <shidlovskiyilya@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: Ilya Shidlovskiy <shidlovskiyilya@gmail.com>,
 Kenneth Feng <kenneth.feng@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Kevin Wang <kevin.wang@amd.com>
Subject: [PATCH v3 1/3] drm/amd/display: dcn32: rebuild WM range table when
 memclk states change
Date: Fri, 30 Oct 2026 19:58:36 +0300
Message-ID: <20261030165838.248622-2-shidlovskiyilya@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261030165838.248622-1-shidlovskiyilya@gmail.com>
References: <CADnq5_Pv0wkPx9AzooUf=dyWgQuneMc6K9-qcT6PW53Gg4L5rg@mail.gmail.com>
 <20261030165838.248622-1-shidlovskiyilya@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 02 Nov 2026 08:06:53 +0000
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
Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>
Acked-by: Leo Li <sunpeng.li@amd.com>
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Ilya Shidlovskiy <shidlovskiyilya@gmail.com>
---

Notes:
    v3:
    - rebased on top of Kevin Wang's "preserve committed OD features" patches,
      no changes
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

