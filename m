Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 730F8C3F6B0
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Aug 2022 01:42:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCF77D0F14;
	Thu, 25 Aug 2022 01:40:16 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4123BD103C;
 Thu, 25 Aug 2022 01:40:07 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 36E2E61AE9;
 Thu, 25 Aug 2022 01:40:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F0EFC433C1;
 Thu, 25 Aug 2022 01:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1661391605;
 bh=WHIGOCMF5jj4+J+XKDZEc8raVthLDXgWJrM3xxG8eoQ=;
 h=From:To:Cc:Subject:Date:From;
 b=cPQtAfFITr5pIwrfGh6r2Ol/2JGdXhjSFoHzO2VQv8hwFxvhUDGM6rwP21yR7Hpgx
 /OGXlUI8+ruoi5ypKiVCDQtVkZ5V/VoFkYROJZdNOMT3xTi13/ug/VOAWaia5FQTLf
 NTJW85MYbOr6m1MGJRnQ2msoTIl9eZ4m4GRbJERkS9XB/+9d2wYIr9q05cwzvfkemm
 yxQCCkIjJSWMegsWEziyerMhzBrPB4qwyjFQdk6IYmHHxoPmjH+FnoOFTf2jnEvI64
 ZnG/nagZAlczIC6uX/jErjqENMu3B2TMuGodCyfzRu7VG60Rwr+RCWlJanFJ6rHp76
 LMQA7nDW+cDAA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 1/5] drm/amd/display: clear optc underflow before
 turn off odm clock
Date: Wed, 24 Aug 2022 21:39:55 -0400
Message-Id: <20220825014001.24008-1-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
Cc: Fudong Wang <Fudong.Wang@amd.com>, Sasha Levin <sashal@kernel.org>,
 Anson.Jacob@amd.com, Tom Chung <chiahsuan.chung@amd.com>, Charlene.Liu@amd.com,
 sunpeng.li@amd.com, dri-devel@lists.freedesktop.org, Xinhui.Pan@amd.com,
 Rodrigo.Siqueira@amd.com, amd-gfx@lists.freedesktop.org, airlied@linux.ie,
 Daniel Wheeler <daniel.wheeler@amd.com>, Alvin Lee <alvin.lee2@amd.com>,
 daniel@ffwll.ch, Alex Deucher <alexander.deucher@amd.com>,
 isabbasso@riseup.net, harry.wentland@amd.com, christian.koenig@amd.com,
 oliver.logush@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Fudong Wang <Fudong.Wang@amd.com>

[ Upstream commit b2a93490201300a749ad261b5c5d05cb50179c44 ]

[Why]
After ODM clock off, optc underflow bit will be kept there always and clear not work.
We need to clear that before clock off.

[How]
Clear that if have when clock off.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Fudong Wang <Fudong.Wang@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
index 411f89218e01..cb5c44b339e0 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
@@ -452,6 +452,11 @@ void optc1_enable_optc_clock(struct timing_generator *optc, bool enable)
 				OTG_CLOCK_ON, 1,
 				1, 1000);
 	} else  {
+
+		//last chance to clear underflow, otherwise, it will always there due to clock is off.
+		if (optc->funcs->is_optc_underflow_occurred(optc) == true)
+			optc->funcs->clear_optc_underflow(optc);
+
 		REG_UPDATE_2(OTG_CLOCK_CONTROL,
 				OTG_CLOCK_GATE_DIS, 0,
 				OTG_CLOCK_EN, 0);
-- 
2.35.1

