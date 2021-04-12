Return-Path: <SRS0=UsYE=JJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9091C433ED
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Apr 2021 16:23:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CA0B61289
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Apr 2021 16:23:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CA0B61289
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 134E789D99;
	Mon, 12 Apr 2021 16:23:56 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59F7789D99;
 Mon, 12 Apr 2021 16:23:55 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6CFFC61287;
 Mon, 12 Apr 2021 16:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1618244635;
 bh=FNUg1XRVrOeOXuEXVMppXQbDhVGuqH6mQqna3Sckp14=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=BvLtEjwfc9pXkWzymVd3UIHgjJ2nSu0ZhkzZiSAEJQeFnH795aQ5P4khRUnENyleG
 6dzc/gHNO6RW9+d2QfGVdk8geckAAK1XTBZiDR/sthJr9YwyF1j2zoTfVhplgH+S/j
 c46Zh00VSNQl8Q4J+RRcP7X5cU54XROUVcIr/6euaPTnasHcBqe1as35oTtjXS0obJ
 astHl+HIIOzB505aXmZuMhcPtXYXXbD1631MMrIHNFFfxn2RNg1a1fB+fWd6KdGo7v
 sQU3P+Aw/2OniSDtuHrrQW7m3ip3bXJTDVEWsHCtZTspqbvFfT6IAb2Iu7Mjl/Ts83
 dktyOyDUnoe3g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.11 47/51] drm/amd/display: Add missing mask for DCN3
Date: Mon, 12 Apr 2021 12:22:52 -0400
Message-Id: <20210412162256.313524-47-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210412162256.313524-1-sashal@kernel.org>
References: <20210412162256.313524-1-sashal@kernel.org>
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
Cc: Sasha Levin <sashal@kernel.org>, Qingqing Zhuo <qingqing.zhuo@amd.com>,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Qingqing Zhuo <qingqing.zhuo@amd.com>

[ Upstream commit df7232c4c676be29f1cf45058ec156c1183539ff ]

[Why]
DCN3 is not reusing DCN1 mask_sh_list, causing
SURFACE_FLIP_INT_MASK missing in the mapping.

[How]
Add the corresponding entry to DCN3 list.

Signed-off-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubp.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubp.h b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubp.h
index 5fa150f34c60..2e89acf46e54 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubp.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubp.h
@@ -133,6 +133,7 @@
 	HUBP_SF(HUBPREQ0_DCSURF_SURFACE_CONTROL, SECONDARY_SURFACE_DCC_EN, mask_sh),\
 	HUBP_SF(HUBPREQ0_DCSURF_SURFACE_CONTROL, SECONDARY_SURFACE_DCC_IND_BLK, mask_sh),\
 	HUBP_SF(HUBPREQ0_DCSURF_SURFACE_CONTROL, SECONDARY_SURFACE_DCC_IND_BLK_C, mask_sh),\
+	HUBP_SF(HUBPREQ0_DCSURF_SURFACE_FLIP_INTERRUPT, SURFACE_FLIP_INT_MASK, mask_sh),\
 	HUBP_SF(HUBPRET0_HUBPRET_CONTROL, DET_BUF_PLANE1_BASE_ADDRESS, mask_sh),\
 	HUBP_SF(HUBPRET0_HUBPRET_CONTROL, CROSSBAR_SRC_CB_B, mask_sh),\
 	HUBP_SF(HUBPRET0_HUBPRET_CONTROL, CROSSBAR_SRC_CR_R, mask_sh),\
-- 
2.30.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
