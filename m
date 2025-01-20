Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F084C02185
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jan 2025 19:49:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4085E10E482;
	Mon, 20 Jan 2025 19:49:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kRl0etsL";
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEED610E481
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Jan 2025 19:49:23 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id BB5DA5C583C;
 Mon, 20 Jan 2025 19:48:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D7C0C4CEDD;
 Mon, 20 Jan 2025 19:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1737402563;
 bh=autT3Exk8e2qBsjqr9/WAKTrvdBGNo8waczoSOjenTU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=kRl0etsL4Z6UA0t03Fh9lwLuR8eL8dEpdYFEzZ3h+/YY9Z2+Pz1VYri+0GtWZeztN
 l7+WSc91m1UZ3AEoWJF8epNdajyYN9HV1imHbSNg5FMIrhqBHGioDkwOd682pNDNKf
 LeWuUIz1vxiP65V1dBKdWLBD60gYYFHSwJZb3GV8IH2+Bu6NMHKD5MGvpsIhkXQ3g9
 6oa6JPjcD0/wWqNorFYavwDU+4/RczCAnhsip9e3RXK9aO6yXXDa1dT/0Tz01ccfDg
 NYeLHi6YkPQUlShjfc0oK4i7rNmyUP7yJuJa8is77aZCaiJ+1sfCKQqZ2ZVdfDvi5N
 TIbiJ8qO01Izw==
From: Mario Limonciello <superm1@kernel.org>
To: Harry Wentland <Harry.Wentland@amd.com>,
 "amd-gfx @ lists . freedesktop . org" <amd-gfx@lists.freedesktop.org>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 3/4] drm/amd/display: Add new log type `DC_LOG_INFO`
Date: Mon, 20 Jan 2025 13:49:02 -0600
Message-ID: <20250120194903.1048811-3-superm1@kernel.org>
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

`DC_LOG_INFO` will wrap `drm_info()` and be used for the typical
`INFO` level printk messages but in DC code.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/display/include/logger_types.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/include/logger_types.h b/drivers/gpu/drm/amd/display/include/logger_types.h
index 4d68c1c6e2100..177acb0574f1c 100644
--- a/drivers/gpu/drm/amd/display/include/logger_types.h
+++ b/drivers/gpu/drm/amd/display/include/logger_types.h
@@ -32,6 +32,7 @@
 #define DC_LOG_WARNING(...) drm_warn((DC_LOGGER)->dev, __VA_ARGS__)
 #define DC_LOG_DEBUG(...) drm_dbg((DC_LOGGER)->dev, __VA_ARGS__)
 #define DC_LOG_DC(...) drm_dbg((DC_LOGGER)->dev, __VA_ARGS__)
+#define DC_LOG_INFO(...) drm_info((DC_LOGGER)->dev, __VA_ARGS__)
 #define DC_LOG_SURFACE(...) pr_debug("[SURFACE]:"__VA_ARGS__)
 #define DC_LOG_HW_HOTPLUG(...) drm_dbg((DC_LOGGER)->dev, __VA_ARGS__)
 #define DC_LOG_HW_LINK_TRAINING(...) pr_debug("[HW_LINK_TRAINING]:"__VA_ARGS__)
-- 
2.43.0

