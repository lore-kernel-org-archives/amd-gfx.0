Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDC1DC00528
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jun 2023 07:29:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE8E610E626;
	Fri, 23 Jun 2023 07:29:05 +0000 (UTC)
X-Greylist: delayed 570 seconds by postgrey-1.36 at gabe;
 Thu, 22 Jun 2023 00:56:17 UTC
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3546410E04C
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Jun 2023 00:56:17 +0000 (UTC)
Received: from submission (posteo.de [185.67.36.169]) 
 by mout02.posteo.de (Postfix) with ESMTPS id 59D26240101
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Jun 2023 02:46:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
 t=1687394804; bh=VKO5kAlvwT2Tg2zsi0T5+7i3uYFbcdeRVjfmpdaksA0=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
 Content-Transfer-Encoding:From;
 b=a/oEtG0KJ+MdDAU6YvpoP+NjHlFRoZMzls3XOuzZJ+XQ1E/UujAIOUkEiwxLBgUxi
 yuBZMD8dHkENO03ShRf+cCrvF3nyBp9cDORJF29oCaGsFqFXgc8/n4gJi4SD4jhdvI
 ckcitvlwfasYJuKUDn713StJ2qZ10FvM6MuetM8W+4tsEqq301jMozkfY2ZDuEFm9J
 bZyc9NpkiUZy8Ecv5ouiy4uSQSOeoR/jIgRI0fEyjHWlvqe4jYY0gekq6O4foXc8GZ
 6s1KdL4I6ii5aqN34wazqSbDSZSOC1IXijjZGr/Y2kTy/tZHWKZtHACAPswz1MD3kt
 Z6vdyjBOxlBbw==
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 4QmhX10KDVz9rxL;
 Thu, 22 Jun 2023 02:46:40 +0200 (CEST)
From: Yueh-Shun Li <shamrocklee@posteo.net>
To: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/display: fix comment typo
Date: Thu, 22 Jun 2023 00:42:27 +0000
Message-Id: <20230622004226.7177-1-shamrocklee@posteo.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 23 Jun 2023 07:28:58 +0000
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
Cc: Yueh-Shun Li <shamrocklee@posteo.net>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Spell "transmission" properly.

Found by searching for keyword "tranm".

Signed-off-by: Yueh-Shun Li <shamrocklee@posteo.net>
---
 .../gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_stream_encoder.c  | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_stream_encoder.c
index 0278bae50a9d..45143459eedd 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_stream_encoder.c
@@ -154,7 +154,7 @@ static void dcn31_hpo_dp_stream_enc_dp_blank(
 			VID_STREAM_STATUS, 0,
 			10, 5000);
 
-	/* Disable SDP tranmission */
+	/* Disable SDP transmission */
 	REG_UPDATE(DP_SYM32_ENC_SDP_CONTROL,
 			SDP_STREAM_ENABLE, 0);
 
-- 
2.38.1

