Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 306C1C5B552
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Jun 2025 19:12:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C663010E2FE;
	Tue, 10 Jun 2025 19:12:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=free.fr header.i=@free.fr header.b="HPO6k/DW";
	dkim-atps=neutral
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A614A10E2FE
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Jun 2025 19:12:51 +0000 (UTC)
Received: from over.fork.zz (unknown [82.65.94.41])
 (Authenticated sender: patrick9876@free.fr)
 by smtp6-g21.free.fr (Postfix) with ESMTPSA id 4E244780383;
 Tue, 10 Jun 2025 21:12:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1749582770;
 bh=6itRN0YbhR5GmCAeHTTBzRX189oItj5jHaRMaf72nJA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=HPO6k/DWSonMkx8v44Ef1Zs4KCKcs50cfFbn1FVnc4xC3rCraNnO9UlkFSt7XYzwL
 oZLLv13h/C9wvHVJrF4rrh6ou6hAHGgjly3qIQiZDZ0h2SWupk3GHmce0Rv66xC4R9
 RPCLyDbgPAB4f54MfcOIo0+Dm+Nq5zXFDZ9BzDcPp0eMgR0Dc3ZoYshCUsYG0sItgP
 QD4iQTvolG688FxdHEIxu5ouWdfVFl+N2h3J72Qjb8/kjgCbio/vhw6GZZkcVp0Se2
 /tCiuLh8mZ3vIkenwKoJUUAX4OjY9LKL22Z1M2ZxZl6+Xajt1iFX+EqesOQG/ztiNI
 UqBzr4O9mtVtw==
From: Patrick Lerda <patrick9876@free.fr>
To: amd-gfx@lists.freedesktop.org
Cc: Patrick Lerda <patrick9876@free.fr>
Subject: [PATCH 2/2] drm/radeon/evergreen_cs: lower
 evergreen_surface_check_linear_aligned restriction
Date: Tue, 10 Jun 2025 21:12:23 +0200
Message-ID: <20250610191232.15597-2-patrick9876@free.fr>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250610191232.15597-1-patrick9876@free.fr>
References: <20250610191232.15597-1-patrick9876@free.fr>
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

This change removes the restriction when palign=64 and nbx=32.
This makes two piglit tests working. This is discussed on the
thread linked below.

Link: https://gitlab.freedesktop.org/mesa/mesa/-/issues/9056
Signed-off-by: Patrick Lerda <patrick9876@free.fr>
---
 drivers/gpu/drm/radeon/evergreen_cs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/evergreen_cs.c b/drivers/gpu/drm/radeon/evergreen_cs.c
index 7d00096fc915..266c57733136 100644
--- a/drivers/gpu/drm/radeon/evergreen_cs.c
+++ b/drivers/gpu/drm/radeon/evergreen_cs.c
@@ -211,7 +211,7 @@ static int evergreen_surface_check_linear_aligned(struct radeon_cs_parser *p,
 	surf->base_align = track->group_size;
 	surf->palign = palign;
 	surf->halign = 1;
-	if (surf->nbx & (palign - 1)) {
+	if ((surf->nbx & (palign - 1)) && !(palign == 64 && surf->nbx == 32)) {
 		if (prefix) {
 			dev_warn(p->dev, "%s:%d %s pitch %d invalid must be aligned with %d\n",
 				 __func__, __LINE__, prefix, surf->nbx, palign);
-- 
2.49.0

