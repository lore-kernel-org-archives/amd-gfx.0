Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B22C5C19F2A
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Aug 2022 15:48:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C53DDB480C;
	Thu, 11 Aug 2022 15:48:33 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C61BB4810;
 Thu, 11 Aug 2022 15:48:27 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 9C39B60918;
 Thu, 11 Aug 2022 15:48:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D93CC433B5;
 Thu, 11 Aug 2022 15:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1660232905;
 bh=4RPEDK7/pDS+hIUAenwUWqyEDIPspVYJye8IbBzxCI8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=A7tybXTPT4LUbkHU46Zy3o4P/zCdM79QNyhW3676RS9oANBrT4EuvLyMyBf7oV1xV
 vb+QNuPgG/iqVKRjABkrkjeLZSzXNN0N3D7CJUvDP6XbPJP2jlD2wN/dErXbrsU/k7
 TruhSV0EKXNHGnznPa6atfgy+4T+eNYtoep2BSqZp/g4OfQBbA9UleenIPKmz3h2Ag
 PKOOfXMFvyNEX5LNhwpQ0n6hHPwQcCpo3cRR1XsUXAj0Gm/AOXU51fCdPdaQ6QUye7
 z4S107RdZZfrRPWjqYXWpVLrCR/1u3pBe86RHLZN3/v+88L+r+xy30+Z+3i1IH/JYs
 Kh945uEF8J+tw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.18 53/93] drm/amd/display: Fix dmub soft hang for
 PSR 1
Date: Thu, 11 Aug 2022 11:41:47 -0400
Message-Id: <20220811154237.1531313-53-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220811154237.1531313-1-sashal@kernel.org>
References: <20220811154237.1531313-1-sashal@kernel.org>
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
Cc: Sasha Levin <sashal@kernel.org>, contact@emersion.fr, sunpeng.li@amd.com,
 shenshih@amd.com, qingqing.zhuo@amd.com, Xinhui.Pan@amd.com,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Daniel Wheeler <daniel.wheeler@amd.com>, amd-gfx@lists.freedesktop.org,
 nicholas.kazlauskas@amd.com, airlied@linux.ie, Fangzhi Zuo <Jerry.Zuo@amd.com>,
 Aurabindo Jayamohanan Pillai <Aurabindo.Pillai@amd.com>, alex.hung@amd.com,
 dri-devel@lists.freedesktop.org, daniel@ffwll.ch, Wayne.Lin@amd.com,
 Alex Deucher <alexander.deucher@amd.com>, roman.li@amd.com,
 harry.wentland@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Fangzhi Zuo <Jerry.Zuo@amd.com>

[ Upstream commit 22676bc500c27d987a0b42cbe162aebf783f1c38 ]

[Why]
Unexpected change of aux hw mapping causes dmub soft hang when
initiate aux transation at wrong aux channel.

ddc_channel stands for hw dp aux index which is from vbios,
but link_index is pure software concept for link count depending on which link
is probed first. They are not interchangeable.

dmub aux transaction could pass if happens eDP link_index gets
the same value as vbios ddc_channel, e.g., ddc_channel = 1, link_index = 1
if they gets different, e.g., ddc_channel = 2, link_index = 0, overwrite
ddc_channel with link_index will have wrong ddc channel being used for aux
transaction in dmub PSR, cause aux transaction soft hang.

[How]
ddc_channel mapping to each link is determined by vbios and further
parsed in dc. Such info. should not be touched in any kind, otherwise
the mapping is screwed up leading to aux transaction timeout.

Reviewed-by: Aurabindo Jayamohanan Pillai <Aurabindo.Pillai@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index a2575195c4e0..1991a8a4826e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8563,7 +8563,7 @@ static int amdgpu_dm_i2c_xfer(struct i2c_adapter *i2c_adap,
 
 	if (dc_submit_i2c(
 			ddc_service->ctx->dc,
-			ddc_service->ddc_pin->hw_info.ddc_channel,
+			ddc_service->link->link_index,
 			&cmd))
 		result = num;
 
@@ -8599,8 +8599,6 @@ create_i2c(struct ddc_service *ddc_service,
 	snprintf(i2c->base.name, sizeof(i2c->base.name), "AMDGPU DM i2c hw bus %d", link_index);
 	i2c_set_adapdata(&i2c->base, i2c);
 	i2c->ddc_service = ddc_service;
-	if (i2c->ddc_service->ddc_pin)
-		i2c->ddc_service->ddc_pin->hw_info.ddc_channel = link_index;
 
 	return i2c;
 }
-- 
2.35.1

