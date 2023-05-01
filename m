Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FE0AC7EE23
	for <amd-gfx@archiver.kernel.org>; Mon,  1 May 2023 02:59:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACB8110E21B;
	Mon,  1 May 2023 02:59:14 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4923810E21A;
 Mon,  1 May 2023 02:59:12 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id B171560E9E;
 Mon,  1 May 2023 02:59:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 360ACC433D2;
 Mon,  1 May 2023 02:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1682909951;
 bh=NGSX8ZalBjh4IcqNtJmf+wisKWICtruUCDIQ1/8dR7A=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=iQymLLdtj84TXZJHcwYaXrMWOHq0zHwkxycvMfPEhHiYBRxnpoMJ02ZqHxY9aoiAR
 fRtWQx1zzzHbxru5MFGXHNKdGoj+FlXNlP/iAREjwKFJbWKhoTl2hSNgI1ekxMCgdI
 +aQhWOyHCWsyojw4coG8qs7eTFjSuE1kSt6oxJ3x7k8BxSqnvuoHY8p52ey1msvnpE
 CmI2EfYrD2YAeNPNDyilgBUqZtVLUJ8v/6OVEitMEXU1eatbKoMtkv/Cssh40vapwO
 sjFK7uDjJp5ua3p9sZ/1NqUlVoND1T4ynaUa2//QjAbBENtW2Nsd3PnvPgvL1fuKkw
 8qxvG8MqUMiBg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 6.3 37/44] drm/amd/display: Correct DML calculation to
 follow HW SPEC
Date: Sun, 30 Apr 2023 22:56:25 -0400
Message-Id: <20230501025632.3253067-37-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230501025632.3253067-1-sashal@kernel.org>
References: <20230501025632.3253067-1-sashal@kernel.org>
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
Cc: wenjing.liu@amd.com, dri-devel@lists.freedesktop.org, mairacanal@riseup.net,
 hamza.mahfooz@amd.com, Jun Lei <Jun.Lei@amd.com>, airlied@gmail.com,
 Sasha Levin <sashal@kernel.org>, Charlene.Liu@amd.com,
 Rodrigo.Siqueira@amd.com, amd-gfx@lists.freedesktop.org, alex.hung@amd.com,
 aurabindo.pillai@amd.com, alvin.lee2@amd.com, harry.wentland@amd.com,
 Daniel.Miess@amd.com, sunpeng.li@amd.com, Zhongwei.Zhang@amd.com,
 Daniel Wheeler <daniel.wheeler@amd.com>, Paul Hsieh <Paul.Hsieh@amd.com>,
 nathan@kernel.org, Dillon.Varone@amd.com,
 Qingqing Zhuo <qingqing.zhuo@amd.com>, Xinhui.Pan@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>, Dmytro.Laktyushkin@amd.com,
 daniel@ffwll.ch, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Paul Hsieh <Paul.Hsieh@amd.com>

[ Upstream commit 385c3e4c29e1d4ce8f68687a8c84621e4c0e0416 ]

[Why]
In 2560x1600@240p eDP panel, driver use lowest voltage level
to play 1080p video cause underflow. According to HW SPEC,
the senario should use high voltage level.

[How]
ChromaPre value is zero when bandwidth validation.
Correct ChromaPre calculation.

Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Paul Hsieh <Paul.Hsieh@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c  | 2 +-
 drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c  | 2 +-
 .../gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c    | 2 +-
 drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c  | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
index c3d75e56410cc..997aefde32cc3 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
@@ -4866,7 +4866,7 @@ void dml30_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 							v->DETBufferSizeCThisState[k],
 							&v->UrgentBurstFactorCursorPre[k],
 							&v->UrgentBurstFactorLumaPre[k],
-							&v->UrgentBurstFactorChroma[k],
+							&v->UrgentBurstFactorChromaPre[k],
 							&v->NoUrgentLatencyHidingPre[k]);
 				}
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
index 8f8e2e7e5cc53..becad3009d26c 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
@@ -5192,7 +5192,7 @@ void dml31_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 							v->DETBufferSizeCThisState[k],
 							&v->UrgentBurstFactorCursorPre[k],
 							&v->UrgentBurstFactorLumaPre[k],
-							&v->UrgentBurstFactorChroma[k],
+							&v->UrgentBurstFactorChromaPre[k],
 							&v->NotUrgentLatencyHidingPre[k]);
 				}
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
index e8bcae63f2656..193f153df0dfb 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
@@ -5289,7 +5289,7 @@ void dml314_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_
 							v->DETBufferSizeCThisState[k],
 							&v->UrgentBurstFactorCursorPre[k],
 							&v->UrgentBurstFactorLumaPre[k],
-							&v->UrgentBurstFactorChroma[k],
+							&v->UrgentBurstFactorChromaPre[k],
 							&v->NotUrgentLatencyHidingPre[k]);
 				}
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
index 3b2a014ccf8f5..916f8c5d7d7ad 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
@@ -3353,7 +3353,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 							/* Output */
 							&mode_lib->vba.UrgentBurstFactorCursorPre[k],
 							&mode_lib->vba.UrgentBurstFactorLumaPre[k],
-							&mode_lib->vba.UrgentBurstFactorChroma[k],
+							&mode_lib->vba.UrgentBurstFactorChromaPre[k],
 							&mode_lib->vba.NotUrgentLatencyHidingPre[k]);
 				}
 
-- 
2.39.2

