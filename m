Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D859DD5B171
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Dec 2025 01:12:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FE0D10E0D3;
	Mon, 15 Dec 2025 01:12:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="B1GN3nRR";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42EFA10E0BC
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Dec 2025 01:12:35 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id B9FB760127
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Dec 2025 01:12:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2346FC4CEFB;
 Mon, 15 Dec 2025 01:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1765761154;
 bh=+0/CQChQ5ZoO5fq6fSlRNiANBUwJtDRameV8mlFYzBg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=B1GN3nRR7N61nOUAA44BPspAUUNWFLBrv/0ESSLP89xjKGIdDo9Lo5d/ZBuMLiEmY
 6lo23lB1yabu5xGKooEipi83P3oZVQ9XPTXby0xTORWAvMbP9LqU9vtxr/eYNit5p7
 sHXgSXWXu74sgLWq6sIAH1RivZ+HoEAua5ysoddKOc/l7napOWnJZqB943+j65oiuM
 NnR/r2ZOyGfLA6g+/HJYYZ4TN/nu88SqRNo9MIyYGllt/S9rNJ/XHSc9mksDB/+XAt
 GAgzBUrUvi5ShDGfcB5tp+dxm1xdzMNdvivfd6ZWuFHOFdvjg75bDJU1kXfigNSJgQ
 y3Q3TMFSkQGQg==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: amd-gfx@lists.freedesktop.org
Cc: "Mario Limonciello (AMD)" <superm1@kernel.org>
Subject: [PATCH 3/9] drm/amd: Add correct prefix for VBIOS message
Date: Sun, 14 Dec 2025 19:12:21 -0600
Message-ID: <20251215011227.161597-4-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251215011227.161597-1-superm1@kernel.org>
References: <20251215011227.161597-1-superm1@kernel.org>
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

It's not obvious which GPU the ATOM BIOS message goes with. Use
drm_info() to show the correct one.

Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/atom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdgpu/atom.c
index 7a063e44d4298..371ee82a89126 100644
--- a/drivers/gpu/drm/amd/amdgpu/atom.c
+++ b/drivers/gpu/drm/amd/amdgpu/atom.c
@@ -1463,7 +1463,7 @@ static void atom_get_vbios_pn(struct atom_context *ctx)
 		ctx->vbios_pn[count] = 0;
 	}
 
-	pr_info("ATOM BIOS: %s\n", ctx->vbios_pn);
+	drm_info(ctx->card->dev, "ATOM BIOS: %s\n", ctx->vbios_pn);
 }
 
 static void atom_get_vbios_version(struct atom_context *ctx)
-- 
2.43.0

