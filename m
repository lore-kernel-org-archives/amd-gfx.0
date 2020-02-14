Return-Path: <SRS0=cmay=4C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70BCBC2BA83
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2020 15:52:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47C582467E
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2020 15:52:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="F5fezyZ6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47C582467E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 151FB6F9A5;
	Fri, 14 Feb 2020 15:52:24 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13EF76F9B3;
 Fri, 14 Feb 2020 15:52:22 +0000 (UTC)
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E964B222C4;
 Fri, 14 Feb 2020 15:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1581695541;
 bh=mCOEe5nfmTF5/aZn0fqadNVXIBDE7qooNGqNGL1thUc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=F5fezyZ67ZAz8XKzPI0Uxw74xhC//vz0HPYzzWPWC2Cwxap72COMJ/NZdhqCjBAxk
 +EktHa1URSPTtkkF8VBrGaIGY9h4yQXEszdzvOd50f0P06isdGKL5u+o8kywu9u/cr
 UioSdx7d2eES/z3MUepS7BsiW61JWM0i3pgjP8kU=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.5 159/542] drm/amd/display: remove set but not used
 variable 'min_content'
Date: Fri, 14 Feb 2020 10:42:31 -0500
Message-Id: <20200214154854.6746-159-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214154854.6746-1-sashal@kernel.org>
References: <20200214154854.6746-1-sashal@kernel.org>
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
Cc: Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
 zhengbin <zhengbin13@huawei.com>, Hulk Robot <hulkci@huawei.com>,
 dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: zhengbin <zhengbin13@huawei.com>

[ Upstream commit 8f72bfe8d85a827f638141d0f07de42d0c24a36f ]

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/gpu/drm/amd/display/modules/color/color_gamma.c: In function build_freesync_hdr:
drivers/gpu/drm/amd/display/modules/color/color_gamma.c:830:20: warning: variable min_content set but not used [-Wunused-but-set-variable]

It is not used since commit 50575eb5b339 ("drm/amd/display:
Only use EETF when maxCL > max display")

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: zhengbin <zhengbin13@huawei.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/modules/color/color_gamma.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/color/color_gamma.c b/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
index 1de4805cb8c7f..9b121b08c8063 100644
--- a/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
+++ b/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
@@ -937,7 +937,6 @@ static bool build_freesync_hdr(struct pwl_float_data_ex *rgb_regamma,
 	struct fixed31_32 max_display;
 	struct fixed31_32 min_display;
 	struct fixed31_32 max_content;
-	struct fixed31_32 min_content;
 	struct fixed31_32 clip = dc_fixpt_one;
 	struct fixed31_32 output;
 	bool use_eetf = false;
@@ -951,7 +950,6 @@ static bool build_freesync_hdr(struct pwl_float_data_ex *rgb_regamma,
 	max_display = dc_fixpt_from_int(fs_params->max_display);
 	min_display = dc_fixpt_from_fraction(fs_params->min_display, 10000);
 	max_content = dc_fixpt_from_int(fs_params->max_content);
-	min_content = dc_fixpt_from_fraction(fs_params->min_content, 10000);
 	sdr_white_level = dc_fixpt_from_int(fs_params->sdr_white_level);
 
 	if (fs_params->min_display > 1000) // cap at 0.1 at the bottom
-- 
2.20.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
