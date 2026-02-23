Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FEBAEA4FB7
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Feb 2026 12:38:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E79710E387;
	Mon, 23 Feb 2026 12:38:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DC39kg3T";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 810AC10E387;
 Mon, 23 Feb 2026 12:38:09 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 6971440231;
 Mon, 23 Feb 2026 12:38:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5E5EC2BC86;
 Mon, 23 Feb 2026 12:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1771850289;
 bh=piEMGXZwt8wLWfoaik1WxIGNNWEo8qL2QNNyNKrGrEs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=DC39kg3To/G/iH8uBAviqkTV5NDtM+9k3vUOe5XbEO7nKBRk2Vt6FbmB6G4jg30cl
 Y8/8e3KdlovKP8RSEeKqbqid68NFUm0lQiDZmcy9KvelXxA5IZvQnfBhgIhw/92IuR
 6jh2WwfU9PT4OJG9G1T2Zoq9z9918+0OIsrGmPnD+rElRLC3malUYUiNh/38BPUuKz
 THFmIGwGz3fnm2WPD7j8Ady3/7zJWGbV+lOOIU5gsJAb4qfFdUFa7MJsKYyiNn3PU0
 WYrAG4MAhXyvCG4jaDUaQw1qte1WbzJOBadT0jNob1P1LG1ZDm0d2KL1syAbZt3wR0
 rQJXHb1dGA1rw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: YiLing Chen <yi-lchen@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Tom Chung <chiahsuan.chung@amd.com>,
 Daniel Wheeler <daniel.wheeler@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Sasha Levin <sashal@kernel.org>,
 harry.wentland@amd.com, sunpeng.li@amd.com, christian.koenig@amd.com,
 airlied@gmail.com, simona@ffwll.ch, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.19] drm/amd/display: set enable_legacy_fast_update
 to false for DCN36
Date: Mon, 23 Feb 2026 07:37:25 -0500
Message-ID: <20260223123738.1532940-20-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260223123738.1532940-1-sashal@kernel.org>
References: <20260223123738.1532940-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.19.3
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: YiLing Chen <yi-lchen@amd.com>

[ Upstream commit d0728aee5090853d0b9982757f5fb1b13e2e2b27 ]

[Why/How]
Align the default value of the flag with DCN35/351.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: YiLing Chen <yi-lchen@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

The background task completed but doesn't change my analysis. My
decision stands - this is a valid one-line bug fix for user-visible
display stuttering on DCN36 hardware.

**YES**

 drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c
index 6469d5fe2e6d4..a1132102afde4 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c
@@ -769,7 +769,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 };
 
 static const struct dc_check_config config_defaults = {
-	.enable_legacy_fast_update = true,
+	.enable_legacy_fast_update = false,
 };
 
 static const struct dc_panel_config panel_config_defaults = {
-- 
2.51.0

