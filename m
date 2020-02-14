Return-Path: <SRS0=cmay=4C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE86C3B19D
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2020 16:03:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E541724680
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2020 16:03:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="eIRNsu5v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E541724680
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A75866FA19;
	Fri, 14 Feb 2020 16:03:26 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B4D06FA19;
 Fri, 14 Feb 2020 16:03:25 +0000 (UTC)
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D6BBF2187F;
 Fri, 14 Feb 2020 16:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1581696205;
 bh=kXOCbXtX884i/0EwkkynxVIHBuW1afWpJr5gJ0/prvE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=eIRNsu5v1n5yyVWB+D8PWh0X/fAlbz5dDZOX4WwxZVJq5MRqho+VVLu+VVHk4Ce3d
 JwvvnyfsEBf/gxWxwL8I/U0Tcra/h9pZoexlB7EobMcHExaUti9OhBrXUcNgc2VBip
 Hg16r8gIQ3UlfSl+qKq72JDqgPMcLsKli+WSw18E=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 070/459] drm/amd/display: Clear state after
 exiting fixed active VRR state
Date: Fri, 14 Feb 2020 10:55:20 -0500
Message-Id: <20200214160149.11681-70-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214160149.11681-1-sashal@kernel.org>
References: <20200214160149.11681-1-sashal@kernel.org>
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
Cc: Sasha Levin <sashal@kernel.org>, Anthony Koo <Anthony.Koo@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Amanda Liu <amanda.liu@amd.com>, Harry Wentland <harry.wentland@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Amanda Liu <amanda.liu@amd.com>

[ Upstream commit 6f8f76444baf405bacb0591d97549a71a9aaa1ac ]

[why]
Upon exiting a fixed active VRR state, the state isn't cleared. This
leads to the variable VRR range to be calculated incorrectly.

[how]
Set fixed active state to false when updating vrr params

Signed-off-by: Amanda Liu <amanda.liu@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/modules/freesync/freesync.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
index 0978c698f0f85..7d67cb2c61f04 100644
--- a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
+++ b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
@@ -803,6 +803,7 @@ void mod_freesync_build_vrr_params(struct mod_freesync *mod_freesync,
 			2 * in_out_vrr->min_refresh_in_uhz)
 		in_out_vrr->btr.btr_enabled = false;
 
+	in_out_vrr->fixed.fixed_active = false;
 	in_out_vrr->btr.btr_active = false;
 	in_out_vrr->btr.inserted_duration_in_us = 0;
 	in_out_vrr->btr.frames_to_insert = 0;
@@ -822,6 +823,7 @@ void mod_freesync_build_vrr_params(struct mod_freesync *mod_freesync,
 		in_out_vrr->adjust.v_total_max = stream->timing.v_total;
 	} else if (in_out_vrr->state == VRR_STATE_ACTIVE_VARIABLE &&
 			refresh_range >= MIN_REFRESH_RANGE_IN_US) {
+
 		in_out_vrr->adjust.v_total_min =
 			calc_v_total_from_refresh(stream,
 				in_out_vrr->max_refresh_in_uhz);
-- 
2.20.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
