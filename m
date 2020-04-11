Return-Path: <SRS0=mFKL=53=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5737FC2BA19
	for <amd-gfx@archiver.kernel.org>; Sat, 11 Apr 2020 23:04:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A46A20787
	for <amd-gfx@archiver.kernel.org>; Sat, 11 Apr 2020 23:04:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jcbBOntt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A46A20787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0A456E046;
	Sat, 11 Apr 2020 23:04:47 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 271F46E215;
 Sat, 11 Apr 2020 23:04:46 +0000 (UTC)
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 022CB20CC7;
 Sat, 11 Apr 2020 23:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1586646286;
 bh=eSQG4zjJI2NpYKdRyk6k4YozKTs/eWEKTA1IfJRxfKE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=jcbBOnttAsuezGXK/p8T3jt//rhJehNe+jLVokJIYe531xnf/Cfe6nrNTNwJu+ktU
 0YomcTCi7qI/OuqM6auHQgv16NXqW86eSdMHXkBBdVpTKVGByLmqSNIKOCAPXIJTBM
 mXZJQuOuHetHFMt0JfR4B+x+7hCCVSvzuOEeDYWo=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 047/149] drm/amd/display: Fix HDMI repeater
 authentication
Date: Sat, 11 Apr 2020 19:02:04 -0400
Message-Id: <20200411230347.22371-47-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200411230347.22371-1-sashal@kernel.org>
References: <20200411230347.22371-1-sashal@kernel.org>
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
Cc: Sasha Levin <sashal@kernel.org>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Wenjing Liu <Wenjing.Liu@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Harry Wentland <harry.wentland@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>

[ Upstream commit 63a85ff6c35d8a7aaf0fb60ddbab93530d495bf3 ]

when the rxstatus split was done the index was incorrect. This
lead to HDMI repeater authentication failure for HDCP2.X So fix it

Fixes: 302169003733 ("drm/amd/display: split rxstatus for hdmi and dp")
Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_execution.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_execution.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_execution.c
index 55246711700ba..6fd68326452ce 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_execution.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_execution.c
@@ -34,7 +34,7 @@ static inline enum mod_hdcp_status check_receiver_id_list_ready(struct mod_hdcp
 	if (is_dp_hdcp(hdcp))
 		is_ready = HDCP_2_2_DP_RXSTATUS_READY(hdcp->auth.msg.hdcp2.rxstatus_dp) ? 1 : 0;
 	else
-		is_ready = (HDCP_2_2_HDMI_RXSTATUS_READY(hdcp->auth.msg.hdcp2.rxstatus[0]) &&
+		is_ready = (HDCP_2_2_HDMI_RXSTATUS_READY(hdcp->auth.msg.hdcp2.rxstatus[1]) &&
 				(HDCP_2_2_HDMI_RXSTATUS_MSG_SZ_HI(hdcp->auth.msg.hdcp2.rxstatus[1]) << 8 |
 						hdcp->auth.msg.hdcp2.rxstatus[0])) ? 1 : 0;
 	return is_ready ? MOD_HDCP_STATUS_SUCCESS :
@@ -67,7 +67,7 @@ static inline enum mod_hdcp_status check_reauthentication_request(
 				MOD_HDCP_STATUS_HDCP2_REAUTH_REQUEST :
 				MOD_HDCP_STATUS_SUCCESS;
 	else
-		ret = HDCP_2_2_HDMI_RXSTATUS_REAUTH_REQ(hdcp->auth.msg.hdcp2.rxstatus[0]) ?
+		ret = HDCP_2_2_HDMI_RXSTATUS_REAUTH_REQ(hdcp->auth.msg.hdcp2.rxstatus[1]) ?
 				MOD_HDCP_STATUS_HDCP2_REAUTH_REQUEST :
 				MOD_HDCP_STATUS_SUCCESS;
 	return ret;
-- 
2.20.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
