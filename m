Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C190FC48BE4
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Aug 2022 01:39:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEC17D0BCA;
	Thu, 25 Aug 2022 01:38:05 +0000 (UTC)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D81ED0BF9;
 Thu, 25 Aug 2022 01:37:38 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id D84DEB826E0;
 Thu, 25 Aug 2022 01:37:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3413C433C1;
 Thu, 25 Aug 2022 01:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1661391454;
 bh=JDAFhXSkDBBGX52pifLUdEO2PYCrCaPG4d6XhRYnTMM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=bXHbdXSuUHtFyY5FtUNjKPdRwDcYv+Z4oTF4bu43e1oTGPKPOSybkyjBN2AOb0koB
 m0adZzm2Z8HD+da3adXc02f7D+Jg/YxrSxfehaux1syUJt2Qf35t9J9rmeR3Bgd5VQ
 uMLkkh9zPMaA2kQTxuKVjRIwto0YSuSrW3ya/HA60Stzfr4n6SP5R7BOuayZaRueTL
 JYmVMRYnTQVq6fxYqd4Tht5VDTofyBglUS2edNTGR5eDEvO+ZoKCGnZP9jFjSJLJtb
 DeyvMUyXrx6THbyEdbDLTvdER9UwWIXgQJMQzL/KpqNqEpTqMAZFkeXZE5fB4Apbgj
 jZDAeqMUnNxhg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 05/20] drm/amd/display: For stereo keep
 "FLIP_ANY_FRAME"
Date: Wed, 24 Aug 2022 21:36:57 -0400
Message-Id: <20220825013713.22656-5-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220825013713.22656-1-sashal@kernel.org>
References: <20220825013713.22656-1-sashal@kernel.org>
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
Cc: Sasha Levin <sashal@kernel.org>, Tom Chung <chiahsuan.chung@amd.com>,
 sunpeng.li@amd.com, dri-devel@lists.freedesktop.org, Xinhui.Pan@amd.com,
 Rodrigo.Siqueira@amd.com, amd-gfx@lists.freedesktop.org, airlied@linux.ie,
 Daniel Wheeler <daniel.wheeler@amd.com>, Alvin Lee <alvin.lee2@amd.com>,
 daniel@ffwll.ch, Martin Leung <Martin.Leung@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, harry.wentland@amd.com,
 christian.koenig@amd.com, joshua@froggi.es, Pavle.Kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <alvin.lee2@amd.com>

[ Upstream commit 84ef99c728079dfd21d6bc70b4c3e4af20602b3c ]

[Description]
Observed in stereomode that programming FLIP_LEFT_EYE
can cause hangs. Keep FLIP_ANY_FRAME in stereo mode so
the surface flip can take place before left or right eye

Reviewed-by: Martin Leung <Martin.Leung@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubp.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubp.c
index f24612523248..33c2337c4edf 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubp.c
@@ -86,7 +86,7 @@ bool hubp3_program_surface_flip_and_addr(
 			VMID, address->vmid);
 
 	if (address->type == PLN_ADDR_TYPE_GRPH_STEREO) {
-		REG_UPDATE(DCSURF_FLIP_CONTROL, SURFACE_FLIP_MODE_FOR_STEREOSYNC, 0x1);
+		REG_UPDATE(DCSURF_FLIP_CONTROL, SURFACE_FLIP_MODE_FOR_STEREOSYNC, 0);
 		REG_UPDATE(DCSURF_FLIP_CONTROL, SURFACE_FLIP_IN_STEREOSYNC, 0x1);
 
 	} else {
-- 
2.35.1

