Return-Path: <SRS0=cmay=4C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B550C2BA83
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2020 16:04:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03B382067D
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2020 16:04:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ioM3+H28"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03B382067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 905A16FA20;
	Fri, 14 Feb 2020 16:04:04 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86C016FA20;
 Fri, 14 Feb 2020 16:04:03 +0000 (UTC)
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4571C24654;
 Fri, 14 Feb 2020 16:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1581696243;
 bh=NZZ++dKabZITguBBZrDnUclhdXCvf46rq0sMNW0akCU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ioM3+H28YgHdNvd0lyqDqvXbsSqyJb9ZNMWLwOYyFl3etkLQ1PjMlgUdbsQndXPEv
 1dnDAx+146dELEEtaKSskXyRLvhMY029iJ64IKtHhMMSeGIY+3ApAY4hugDUkTFomV
 SC6xDUR/hddtmYvfcIjcq0bhChv6qdrPn0ueXsHo=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 101/459] drm/amd/display: Retrain dongles when
 SINK_COUNT becomes non-zero
Date: Fri, 14 Feb 2020 10:55:51 -0500
Message-Id: <20200214160149.11681-101-sashal@kernel.org>
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
Cc: Sasha Levin <sashal@kernel.org>, Eric Yang <Eric.Yang2@amd.com>,
 Wenjing Liu <Wenjing.Liu@amd.com>, amd-gfx@lists.freedesktop.org,
 Hersen Wu <hersenxs.wu@amd.com>, dri-devel@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Louis Li <Ching-shih.Li@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Harry Wentland <harry.wentland@amd.com>

[ Upstream commit 3eb6d7aca53d81ce888624f09cd44dc0302161e8 ]

[WHY]
Two years ago the patch referenced by the Fixes tag stopped running
dp_verify_link_cap_with_retries during DP detection when the reason
for the detection was a short-pulse interrupt. This effectively meant
that we were no longer doing the verify_link_cap training on active
dongles when their SINK_COUNT changed from 0 to 1.

A year ago this was partly remedied with:
commit 80adaebd2d41 ("drm/amd/display: Don't skip link training for empty dongle")

This made sure that we trained the dongle on initial hotplug (without
connected downstream devices).

This is all fine and dandy if it weren't for the fact that there are
some dongles on the market that don't like link training when SINK_COUNT
is 0 These dongles will in fact indicate a SINK_COUNT of 0 immediately
after hotplug, even when a downstream device is connected, and then
trigger a shortpulse interrupt indicating a SINK_COUNT change to 1.

In order to play nicely we will need our policy to not link train an
active DP dongle when SINK_COUNT is 0 but ensure we train it when the
SINK_COUNT changes to 1.

[HOW]
Call dp_verify_link_cap_with_retries on detection even when the detection
is triggered from a short pulse interrupt.

With this change we can also revert this commit which we'll do in a separate
follow-up change:
commit 80adaebd2d41 ("drm/amd/display: Don't skip link training for empty dongle")

Fixes: 0301ccbaf67d ("drm/amd/display: DP Compliance 400.1.1 failure")
Suggested-by: Louis Li <Ching-shih.Li@amd.com>
Tested-by: Louis Li <Ching-shih.Li@amd.com>
Cc: Wenjing Liu <Wenjing.Liu@amd.com>
Cc: Hersen Wu <hersenxs.wu@amd.com>
Cc: Eric Yang <Eric.Yang2@amd.com>
Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index c0f1c62c59b42..3aedc724241ef 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -948,8 +948,7 @@ bool dc_link_detect(struct dc_link *link, enum dc_detect_reason reason)
 			same_edid = is_same_edid(&prev_sink->dc_edid, &sink->dc_edid);
 
 		if (link->connector_signal == SIGNAL_TYPE_DISPLAY_PORT &&
-			sink_caps.transaction_type == DDC_TRANSACTION_TYPE_I2C_OVER_AUX &&
-			reason != DETECT_REASON_HPDRX) {
+			sink_caps.transaction_type == DDC_TRANSACTION_TYPE_I2C_OVER_AUX) {
 			/*
 			 * TODO debug why Dell 2413 doesn't like
 			 *  two link trainings
-- 
2.20.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
