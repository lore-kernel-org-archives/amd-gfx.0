Return-Path: <SRS0=nRto=KA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D443C4360C
	for <amd-gfx@archiver.kernel.org>; Wed,  5 May 2021 16:36:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0361061928
	for <amd-gfx@archiver.kernel.org>; Wed,  5 May 2021 16:36:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0361061928
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72AAA6EC09;
	Wed,  5 May 2021 16:36:20 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C39526EC07;
 Wed,  5 May 2021 16:36:19 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5929E61424;
 Wed,  5 May 2021 16:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1620232579;
 bh=cuJraNm/ySXusB0u5w9lhScTSuhxVXyuD3eYZplHLlQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=S8w248PEnXNwjONsGd6NJM2wIVd4LGOswzZhrjzTbhNRxSX5CVTdRHznOpJ7B82MM
 24s6V59dtxcYRIvoRmJilp/05A9TK0tVppaXOsZPVdq4XrOu6IJ8zo4TtetmIl6SaH
 3NDdFlbrxRiD7kJ8WhDU79DJ0snGXebpCcsRIV4tNZT5J3mcrIew4tAwuVax1GyQh1
 +qQfDas9T7ngF8MzJLjtFp2Tuao8N4NZVWxc0FITD4uOOFHPHcMC4svbotT9CCINba
 f5cWt1c/Djeo7aZ62qJ2Plol+780G8u/D76+gZI1kt5l37+W9ohp0eFi4lhcu69bps
 to6Yvagu7jxjg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.11 086/104] drm/amd/display: add handling for hdcp2
 rx id list validation
Date: Wed,  5 May 2021 12:33:55 -0400
Message-Id: <20210505163413.3461611-86-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210505163413.3461611-1-sashal@kernel.org>
References: <20210505163413.3461611-1-sashal@kernel.org>
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
 "Dingchen \(David\) Zhang" <dingchen.zhang@amd.com>,
 amd-gfx@lists.freedesktop.org, Daniel Wheeler <daniel.wheeler@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, dri-devel@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Dingchen (David) Zhang" <dingchen.zhang@amd.com>

[ Upstream commit 4ccf9446b2a3615615045346c97f8a1e2a16568a ]

[why]
the current implementation of hdcp2 rx id list validation does not
have handler/checker for invalid message status, e.g. HMAC, the V
parameter calculated from PSP not matching the V prime from Rx.

[how]
return a generic FAILURE for any message status not SUCCESS or
REVOKED.

Signed-off-by: Dingchen (David) Zhang <dingchen.zhang@amd.com>
Reviewed-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
index 3a367a5968ae..972f2600f967 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
@@ -789,6 +789,8 @@ enum mod_hdcp_status mod_hdcp_hdcp2_validate_rx_id_list(struct mod_hdcp *hdcp)
 			   TA_HDCP2_MSG_AUTHENTICATION_STATUS__RECEIVERID_REVOKED) {
 			hdcp->connection.is_hdcp2_revoked = 1;
 			status = MOD_HDCP_STATUS_HDCP2_RX_ID_LIST_REVOKED;
+		} else {
+			status = MOD_HDCP_STATUS_HDCP2_VALIDATE_RX_ID_LIST_FAILURE;
 		}
 	}
 	mutex_unlock(&psp->hdcp_context.mutex);
-- 
2.30.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
