Return-Path: <SRS0=Az3f=IU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DC0FC433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Mar 2021 13:51:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D227619A4
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Mar 2021 13:51:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D227619A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C49746E492;
	Mon, 22 Mar 2021 13:51:00 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 329556E491;
 Mon, 22 Mar 2021 13:50:59 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 57F90619A3;
 Mon, 22 Mar 2021 13:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1616421058;
 bh=YA9YxD1Hu+DERDZ6cRSWdcGKGXcYVO3XLjCTjk6a89c=;
 h=Date:From:To:Cc:Subject:From;
 b=M4CHKLXyIARQtuW0IHzOkTDnqSQjfjn6Zt5hkAnIQ2Monol6/1f4qAbjvZQnQNSI4
 PRcVXi/vGJHG9kujjdUlGwmtX8sbmqkDQT0+4Tw1Ox2gTKiM4SiMZABZLJTxpf1Es0
 gV2V/BTEQWIB6kXzKnW3rgwwNal+yqcOCUSkEOiyfTa7xBSbRVu7c9ycTVsh/VUcS4
 5F562g4ZIA6aClkEnxF2Nv2jXlr/t5+bR5BmsKoWw+45JshZ/4f1+B6KlRT/P7OBCP
 jctyHT6dR6P5Q+jm0P4Eewm+7aN86ETIod/MOFuAABy3gocbOXdZN89D3EjzEilcCl
 1kzdMHSpYnh6g==
Date: Mon, 22 Mar 2021 07:50:50 -0500
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Lee Jones <lee.jones@linaro.org>, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH][next] drm/amd/display: Fix sizeof arguments in bw_calcs_init()
Message-ID: <20210322125050.GA236782@embeddedor>
MIME-Version: 1.0
Content-Disposition: inline
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
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The wrong sizeof values are currently being used as arguments to
kzalloc().

Fix this by using the right arguments *dceip and *vbios,
correspondingly.

Addresses-Coverity-ID: 1502901 ("Wrong sizeof argument")
Fixes: fca1e079055e ("drm/amd/display/dc/calcs/dce_calcs: Remove some large variables from the stack")
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c b/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
index 556ecfabc8d2..1244fcb0f446 100644
--- a/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
@@ -2051,11 +2051,11 @@ void bw_calcs_init(struct bw_calcs_dceip *bw_dceip,
 
 	enum bw_calcs_version version = bw_calcs_version_from_asic_id(asic_id);
 
-	dceip = kzalloc(sizeof(dceip), GFP_KERNEL);
+	dceip = kzalloc(sizeof(*dceip), GFP_KERNEL);
 	if (!dceip)
 		return;
 
-	vbios = kzalloc(sizeof(vbios), GFP_KERNEL);
+	vbios = kzalloc(sizeof(*vbios), GFP_KERNEL);
 	if (!vbios) {
 		kfree(dceip);
 		return;
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
