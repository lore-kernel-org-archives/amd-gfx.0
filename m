Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE337C001DF
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Aug 2023 07:20:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4629C10E504;
	Wed,  2 Aug 2023 07:20:18 +0000 (UTC)
Received: from out28-173.mail.aliyun.com (out28-173.mail.aliyun.com
 [115.124.28.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E216010E051;
 Wed,  2 Aug 2023 06:14:35 +0000 (UTC)
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.7543166|0.4514992; CH=green;
 DM=|SPAM|false|; DS=CONTINUE|ham_alarm|0.0711045-0.00413473-0.924761;
 FP=0|0|0|0|0|-1|-1|-1; HT=ay29a033018047212; MF=sunran001@208suo.com; NM=1;
 PH=DS; RN=5; RT=5; SR=0; TI=SMTPD_---.U6X1g.p_1690956865; 
Received: from localhost.localdomain(mailfrom:sunran001@208suo.com
 fp:SMTPD_---.U6X1g.p_1690956865) by smtp.aliyun-inc.com;
 Wed, 02 Aug 2023 14:14:27 +0800
From: Ran Sun <sunran001@208suo.com>
To: alexander.deucher@amd.com
Subject: [PATCH] drm/amd/display: Clean up errors in dc_stream.c
Date: Wed,  2 Aug 2023 06:14:23 +0000
Message-Id: <20230802061423.11155-1-sunran001@208suo.com>
X-Mailer: git-send-email 2.17.1
X-Mailman-Approved-At: Wed, 02 Aug 2023 07:20:04 +0000
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
Cc: Ran Sun <sunran001@208suo.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix the following errors reported by checkpatch:

ERROR: that open brace { should be on the previous line

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index ea3d4b328e8e..05bb23bc122d 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -71,8 +71,7 @@ static bool dc_stream_construct(struct dc_stream_state *stream,
 
 	/* Copy audio modes */
 	/* TODO - Remove this translation */
-	for (i = 0; i < (dc_sink_data->edid_caps.audio_mode_count); i++)
-	{
+	for (i = 0; i < (dc_sink_data->edid_caps.audio_mode_count); i++) {
 		stream->audio_info.modes[i].channel_count = dc_sink_data->edid_caps.audio_modes[i].channel_count;
 		stream->audio_info.modes[i].format_code = dc_sink_data->edid_caps.audio_modes[i].format_code;
 		stream->audio_info.modes[i].sample_rates.all = dc_sink_data->edid_caps.audio_modes[i].sample_rate;
-- 
2.17.1

