Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74240C02182
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jan 2025 19:49:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F158810E483;
	Mon, 20 Jan 2025 19:49:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="M2+m1h4i";
	dkim-atps=neutral
Received: from nyc.source.kernel.org (nyc.source.kernel.org
 [IPv6:2604:1380:45d1:ec00::3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A379010E482
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Jan 2025 19:49:24 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 4FF03A40077;
 Mon, 20 Jan 2025 19:47:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AA7CC4CEE0;
 Mon, 20 Jan 2025 19:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1737402563;
 bh=lEo+w9wpFv8j0s1MiFxaJBnir99rGje6x2K/s2GWwlg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=M2+m1h4iJmSsR630wtuGI4eK+cUUr6i54b9inuAC09D30oZdLG0IUxRRPkQzIfZ1j
 tdtkgR2Fk38rfMzT8kOOMsBGHpGg0Bmxx86UZHx/ONVQv9RvetLkRLV4nxxAd2jvq+
 FBxl6thnkvWg2u1Ik0dIgn4xkwqWNvgd2UaSv1DVvUAMM95RTT+4JAujN77cX7i2SO
 oWh0XQYnJbZ4EpOdKnoWfVqm8NlykxoZ2LjA/Oefc1zF4jurYj0g07VxP1tKya4aQE
 f6H2OWGwOxHrc1PPM9A0kThxfRJ3DRf472v4XlHj0RmseYA+9rTFsy0cvYn7JgPCCS
 a060RlkC1O+Ow==
From: Mario Limonciello <superm1@kernel.org>
To: Harry Wentland <Harry.Wentland@amd.com>,
 "amd-gfx @ lists . freedesktop . org" <amd-gfx@lists.freedesktop.org>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 4/4] drm/amd/display: Refactor mark_seamless_boot_stream()
Date: Mon, 20 Jan 2025 13:49:03 -0600
Message-ID: <20250120194903.1048811-4-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250120194903.1048811-1-superm1@kernel.org>
References: <20250120194903.1048811-1-superm1@kernel.org>
MIME-Version: 1.0
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

From: Mario Limonciello <mario.limonciello@amd.com>

mark_seamless_boot_stream() can be called multiple times to run
the more expensive checks in dc_validate_boot_timing().

Refactor the function so that if those have already passed once
the function isn't called again.

Also add a message the first time that they have passed to let
the user know the stream will be used for seamless boot.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_resource.c  | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 626f75b6ad003..78bad889ba065 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -3525,16 +3525,20 @@ static int acquire_resource_from_hw_enabled_state(
 	return -1;
 }
 
-static void mark_seamless_boot_stream(
-		const struct dc  *dc,
-		struct dc_stream_state *stream)
+static void mark_seamless_boot_stream(const struct dc  *dc,
+				      struct dc_stream_state *stream)
 {
 	struct dc_bios *dcb = dc->ctx->dc_bios;
 
-	if (dc->config.allow_seamless_boot_optimization &&
-			!dcb->funcs->is_accelerated_mode(dcb)) {
-		if (dc_validate_boot_timing(dc, stream->sink, &stream->timing))
-			stream->apply_seamless_boot_optimization = true;
+	if (stream->apply_seamless_boot_optimization)
+		return;
+	if (!dc->config.allow_seamless_boot_optimization)
+		return;
+	if (dcb->funcs->is_accelerated_mode(dcb))
+		return;
+	if (dc_validate_boot_timing(dc, stream->sink, &stream->timing)) {
+		stream->apply_seamless_boot_optimization = true;
+		DC_LOG_INFO("Marked stream for seamless boot optimization\n");
 	}
 }
 
-- 
2.43.0

