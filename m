Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 027CBC6FA83
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Sep 2022 16:47:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DAAAB10E6FD;
	Tue,  6 Sep 2022 16:47:17 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5788010E6FC
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Sep 2022 16:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=3i8ZteomJHZnY2d87I5hV7ZIxy9TXQRXJCQVLhhNasI=; b=i0rwEizNWrGLjx5UKH6HL0SKpB
 6SPfE0Sa1HJXbPCnXQPLdp3CbQ1IJ8081MrCT0u/06YG3F2xnAfXypcNiQecV+gD3o9qBKcbGf1Kz
 YzBKdC5IWLS+GjTYrGcGgLZOeFiK+f9yYuRIqOYUA4y3UCB4R2tgjFGl8BnyV10I+Q9Khj6ooFZLl
 mcC4BgWUpeBXx4H0cejsVjgDpDf83j8/qB5uVeCd4kwPHQiGuaIfInkmSXCF9wsYfBXM7IxTPZykg
 KYKqRQViQyQsRKjwh8yAAz7PXo42ViLPfwp4oZpzgq3396Mh7Nhn+EMI6Agj2syAj2TsRK4+fWn2V
 fA29BCfg==;
Received: from [38.44.74.92] (helo=killbill.home)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1oVbjE-00CALM-GC; Tue, 06 Sep 2022 18:47:12 +0200
From: Melissa Wen <mwen@igalia.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 alex.hung@amd.com, harry.wentland@amd.com, sunpeng.li@amd.com,
 Rodrigo.Siqueira@amd.com
Subject: [RFC PATCH v2 8/9] drm/amd/display: update lut3d and shaper lut to
 stream
Date: Tue,  6 Sep 2022 15:46:27 -0100
Message-Id: <20220906164628.2361811-9-mwen@igalia.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220906164628.2361811-1-mwen@igalia.com>
References: <20220906164628.2361811-1-mwen@igalia.com>
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
Cc: amd-gfx@lists.freedesktop.org, nikola.cornij@amd.com, kernel-dev@igalia.com,
 bhawanpreet.lakha@amd.com, nicholas.kazlauskas@amd.com, sungjoon.kim@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It follows the same path of out_transfer_func for stream updates, since
shaper LUT and 3D LUT is programmed in funcs.set_output_transfer_func()
and this function is called in the atomic commit_tail when
update_flags.bits.out_tf is set.

Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 9860bf38c547..d1fa87ddf1dd 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2405,7 +2405,7 @@ static enum surface_update_type check_update_surfaces_for_stream(
 			stream_update->integer_scaling_update)
 			su_flags->bits.scaling = 1;
 
-		if (stream_update->out_transfer_func)
+		if (stream_update->out_transfer_func || stream_update->lut3d_func)
 			su_flags->bits.out_tf = 1;
 
 		if (stream_update->abm_level)
@@ -2754,6 +2754,14 @@ static void copy_stream_update_to_stream(struct dc *dc,
 		       sizeof(struct dc_transfer_func_distributed_points));
 	}
 
+	if (update->func_shaper &&
+	    stream->func_shaper != update->func_shaper)
+		stream->func_shaper = update->func_shaper;
+
+	if (update->lut3d_func &&
+	    stream->lut3d_func != update->lut3d_func)
+		stream->lut3d_func = update->lut3d_func;
+
 	if (update->hdr_static_metadata)
 		stream->hdr_static_metadata = *update->hdr_static_metadata;
 
-- 
2.35.1

