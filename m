Return-Path: <SRS0=P/1w=P4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A50C2C4167B
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Nov 2021 01:00:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 755556128B
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Nov 2021 01:00:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 755556128B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2313F6E18E;
	Tue,  9 Nov 2021 01:00:53 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF6186E18E;
 Tue,  9 Nov 2021 01:00:51 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 23AF561215;
 Tue,  9 Nov 2021 01:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1636419651;
 bh=knCY6D7aCB+BkrG8V+oWIX0tCtUxpWh8jsn5yxxGT9A=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Pp/+p7Bqhq3DUnsqCDci0viNOvjue+wI76YRy70s7kKOl25elm1R+y8DtEYiJMvJ3
 mdR161TIeajXXwE1X0W7Bs3cjegj7LUXHvnXexyW3KEfnwZ5OsNSUVWQRJz+uQgBvs
 D7n0YlaK+zlRjN00nMQHme3Bz6kQS8lcFoIW7ZVG81zOln9nBnybZcLUchpHcaczMy
 TTPcgPW9mA19VpjJif65Am3QtaV/7Zv48VtVQeWXY31CjJRuTQBT6w3hp/dJmsbU01
 ZSHEsrj8WenYbvoHu+PyZZRbwcXeQCYZqwCSR7KQVLGOyvPxLqBNSS7oWNngzFa3Jt
 zo85rvUIzFGcw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 029/146] drm/amd/display: Fix null pointer
 dereference for encoders
Date: Mon,  8 Nov 2021 12:42:56 -0500
Message-Id: <20211108174453.1187052-29-sashal@kernel.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211108174453.1187052-1-sashal@kernel.org>
References: <20211108174453.1187052-1-sashal@kernel.org>
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
Cc: Aric Cyr <aric.cyr@amd.com>, airlied@linux.ie,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Samson.Tam@amd.com,
 Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>,
 wyatt.wood@amd.com, Jun.Lei@amd.com, hanghong.ma@amd.com,
 Jimmy Kizito <Jimmy.Kizito@amd.com>, Sasha Levin <sashal@kernel.org>,
 wenjing.liu@amd.com, amd-gfx@lists.freedesktop.org, Jerry.Zuo@amd.com,
 george.shen@amd.com, harry.wentland@amd.com, stylon.wang@amd.com,
 sunpeng.li@amd.com, dri-devel@lists.freedesktop.org, paul.hsieh@amd.com,
 agustin.gutierrez@amd.com, Wesley.Chalmers@amd.com, qingqing.zhuo@amd.com,
 Xinhui.Pan@amd.com, christian.koenig@amd.com, vladimir.stempen@amd.com,
 daniel@ffwll.ch, Alex Deucher <alexander.deucher@amd.com>,
 nicholas.kazlauskas@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jimmy Kizito <Jimmy.Kizito@amd.com>

[ Upstream commit 60f39edd897ea134a4ddb789a6795681691c3183 ]

[Why]
Links which are dynamically assigned link encoders have their link
encoder set to NULL.

[How]
Check that a pointer to a link_encoder object is non-NULL before using
it.

Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Reviewed-by: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Jimmy Kizito <Jimmy.Kizito@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c          | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 6d655e158267a..61c18637f84dc 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -4690,7 +4690,7 @@ enum dc_status dp_set_fec_ready(struct dc_link *link, bool ready)
 				link_enc->funcs->fec_set_ready(link_enc, true);
 				link->fec_state = dc_link_fec_ready;
 			} else {
-				link_enc->funcs->fec_set_ready(link->link_enc, false);
+				link_enc->funcs->fec_set_ready(link_enc, false);
 				link->fec_state = dc_link_fec_not_ready;
 				dm_error("dpcd write failed to set fec_ready");
 			}
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index df8a7718a85fc..3af49cdf89ebd 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -1522,7 +1522,7 @@ void dcn10_power_down_on_boot(struct dc *dc)
 		for (i = 0; i < dc->link_count; i++) {
 			struct dc_link *link = dc->links[i];
 
-			if (link->link_enc->funcs->is_dig_enabled &&
+			if (link->link_enc && link->link_enc->funcs->is_dig_enabled &&
 					link->link_enc->funcs->is_dig_enabled(link->link_enc) &&
 					dc->hwss.power_down) {
 				dc->hwss.power_down(dc);
-- 
2.33.0

