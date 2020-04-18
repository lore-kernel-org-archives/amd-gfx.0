Return-Path: <SRS0=W5zw=6C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 962FAC4CC77
	for <amd-gfx@archiver.kernel.org>; Sat, 18 Apr 2020 14:09:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D6F022251
	for <amd-gfx@archiver.kernel.org>; Sat, 18 Apr 2020 14:09:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cNOpOwh2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D6F022251
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 274CB6EC8A;
	Sat, 18 Apr 2020 14:09:38 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8ECBD6EC8A;
 Sat, 18 Apr 2020 14:09:37 +0000 (UTC)
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 8966C22264;
 Sat, 18 Apr 2020 14:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1587218977;
 bh=t+ZPscPzbyfoTQHlhnzdFV0Ms4DnznSLNomF0dIU/q8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=cNOpOwh21cNpoqE8mlZgZwlPEpugpnJXu/TnAQFSec9ehhL+VpUdlY0b1kuj2iTyl
 /9x16LcXozkIUjKvRxxEZJ59nJw9tSG2/dOwEcra/V9l/f+6UtUHVLJkOx4lOX4O6H
 UUeFpwhc2/9y6UGnP13xUuI/g34N/vZ1XYa+1g90=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.5 22/75] drm/amd/display: Update stream adjust in
 dc_stream_adjust_vmin_vmax
Date: Sat, 18 Apr 2020 10:08:17 -0400
Message-Id: <20200418140910.8280-22-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200418140910.8280-1-sashal@kernel.org>
References: <20200418140910.8280-1-sashal@kernel.org>
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
Cc: Sasha Levin <sashal@kernel.org>, Isabel Zhang <isabel.zhang@amd.com>,
 dri-devel@lists.freedesktop.org, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 amd-gfx@lists.freedesktop.org, Alvin Lee <Alvin.Lee2@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Isabel Zhang <isabel.zhang@amd.com>

[ Upstream commit 346d8a0a3c91888a412c2735d69daa09c00f0203 ]

[Why]
After v_total_min and max are updated in vrr structure, the changes are
not reflected in stream adjust. When these values are read from stream
adjust it does not reflect the actual state of the system.

[How]
Set stream adjust values equal to vrr adjust values after vrr adjust
values are updated.

Signed-off-by: Isabel Zhang <isabel.zhang@amd.com>
Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 8904a85186aab..7fdbb47e8c259 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -283,6 +283,8 @@ bool dc_stream_adjust_vmin_vmax(struct dc *dc,
 	int i = 0;
 	bool ret = false;
 
+	stream->adjust = *adjust;
+
 	for (i = 0; i < MAX_PIPES; i++) {
 		struct pipe_ctx *pipe = &dc->current_state->res_ctx.pipe_ctx[i];
 
-- 
2.20.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
