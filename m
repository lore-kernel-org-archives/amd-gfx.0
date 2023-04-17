Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11D69C77B7E
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Apr 2023 07:24:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6680210E6B2;
	Tue, 18 Apr 2023 07:24:47 +0000 (UTC)
Received: from smtp.smtpout.orange.fr (smtp-18.smtpout.orange.fr
 [80.12.242.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFD3B10E3ED
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Apr 2023 21:41:16 +0000 (UTC)
Received: from pop-os.home ([86.243.2.178]) by smtp.orange.fr with ESMTPA
 id oWb2plnaxzvWyoWb2pO3Ap; Mon, 17 Apr 2023 23:41:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=orange.fr;
 s=t20230301; t=1681767674;
 bh=hmKpFuD4ncU+rcAtBi5ifTB/BJFqTFHbSAvPEjZcz3w=;
 h=From:To:Cc:Subject:Date;
 b=Ndv3FWjnt02YRKTfsZ2vbwcNqVmy7vEKr+nkYGk6v06OlVMmVmfhdeZJH5u6X1xJH
 CXMA0vfkC+bgSCUisSpkMH+DuB1yV/+g5/JPNWybSxeZyek7WyY/8Y5ZVCOaXjfl/A
 2MaL1KMBkxxn9gDyThLO7YFz+GxhquOA5w5PbDUqF94R+7YH9PGWkr+fk4sqnaNRUg
 nYNFVMlO3/5+l8wsG2P3L9ACpmg1uU+6j9AKq7nPrKGj/65+240vsDZxKhhSnCTM5/
 PKpSAzzOxbsbBsy2zy8XIDoJYBdmmzj2i8ZlJ3qa4OmieEvMnxnbMDZXhiAxwJdgFP
 DgmumidLM/epA==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 17 Apr 2023 23:41:14 +0200
X-ME-IP: 86.243.2.178
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
Subject: [PATCH] drm/amd/display: Fix a test dml32_rq_dlg_get_rq_reg()
Date: Mon, 17 Apr 2023 23:41:11 +0200
Message-Id: <3ba86bbe8cca149774835659885ddf39034a4306.1681767659.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 18 Apr 2023 07:24:45 +0000
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
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It is likely p1_min_meta_chunk_bytes was expected here, instead of
min_meta_chunk_bytes.

Test the correct variable.

Fixes: dda4fb85e433 ("drm/amd/display: DML changes for DCN32/321")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 .../gpu/drm/amd/display/dc/dml/dcn32/display_rq_dlg_calc_32.c   | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_rq_dlg_calc_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_rq_dlg_calc_32.c
index 395ae8761980..9ba6cb67655f 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_rq_dlg_calc_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_rq_dlg_calc_32.c
@@ -116,7 +116,7 @@ void dml32_rq_dlg_get_rq_reg(display_rq_regs_st *rq_regs,
 	else
 		rq_regs->rq_regs_l.min_meta_chunk_size = dml_log2(min_meta_chunk_bytes) - 6 + 1;
 
-	if (min_meta_chunk_bytes == 0)
+	if (p1_min_meta_chunk_bytes == 0)
 		rq_regs->rq_regs_c.min_meta_chunk_size = 0;
 	else
 		rq_regs->rq_regs_c.min_meta_chunk_size = dml_log2(p1_min_meta_chunk_bytes) - 6 + 1;
-- 
2.34.1

