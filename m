Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51955C54E67
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Mar 2024 12:10:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B898710FAD8;
	Wed, 27 Mar 2024 12:10:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="N5sAach7";
	dkim-atps=neutral
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBF8710FAD8;
 Wed, 27 Mar 2024 12:10:24 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 01024CE16C2;
 Wed, 27 Mar 2024 12:10:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5537C433C7;
 Wed, 27 Mar 2024 12:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1711541422;
 bh=n15hOzHIXDB2VbiSNmKcqjhmERERL1RmXbb9LVlt/O8=;
 h=From:To:Cc:Subject:Date:From;
 b=N5sAach7eBznevmSH4vxulrM/JZqSVz7GYZox22+HUMeieVOas5RtfMX5DuWCAvSV
 PCVkHiD83+rrcApfvmKVUPWg8Rfd1iLZzrY8JQZq0BaZz0hNM1UTWA3HWDIL7RKMCf
 ACYSwvbEcldYQegOh78cwI1X9Lk5sJK4YXi9AYHCHwojySCkXrUYBrAze4fuiRyqo/
 5zHjO7PXzG6eKqQC9EcFhvo563ENWLoL9MUud1UiSv00+ZQla8T+9qR3p8LaqOg7wh
 tG/9LxGyD1mTrvo2wUKe8ntDa0sUA/0DSI2aycOIWQtnxEN/Q27vRjF+NSw8QL0Ieq
 U0meDPa5zNVZw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	wenjing.liu@amd.com
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
 Nevenko Stupar <nevenko.stupar@amd.com>,
 Chaitanya Dhere <chaitanya.dhere@amd.com>,
 Tom Chung <chiahsuan.chung@amd.com>,
 Daniel Wheeler <daniel.wheeler@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: FAILED: Patch "drm/amd/display: fix incorrect mpc_combine array size"
 failed to apply to 6.6-stable tree
Date: Wed, 27 Mar 2024 08:10:19 -0400
Message-ID: <20240327121019.2827857-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 607e1b0cf480cb8dbd65b372397871d7389942b5 Mon Sep 17 00:00:00 2001
From: Wenjing Liu <wenjing.liu@amd.com>
Date: Thu, 18 Jan 2024 15:14:15 -0500
Subject: [PATCH] drm/amd/display: fix incorrect mpc_combine array size

[why]
MAX_SURFACES is per stream, while MAX_PLANES is per asic. The
mpc_combine is an array that records all the planes per asic. Therefore
MAX_PLANES should be used as the array size. Using MAX_SURFACES causes
array overflow when there are more than 3 planes.

[how]
Use the MAX_PLANES for the mpc_combine array size.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Reviewed-by: Nevenko Stupar <nevenko.stupar@amd.com>
Reviewed-by: Chaitanya Dhere <chaitanya.dhere@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 9b80f65c04664..a7981a0c4158f 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -1113,7 +1113,7 @@ struct pipe_slice_table {
 		struct pipe_ctx *pri_pipe;
 		struct dc_plane_state *plane;
 		int slice_count;
-	} mpc_combines[MAX_SURFACES];
+	} mpc_combines[MAX_PLANES];
 	int mpc_combine_count;
 };
 
-- 
2.43.0




