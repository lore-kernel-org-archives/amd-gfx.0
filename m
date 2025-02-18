Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 855C5C021AA
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2025 04:59:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED7A710E611;
	Tue, 18 Feb 2025 04:59:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="uJg0WQPh";
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98D0C10E60C
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Feb 2025 04:59:02 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id BED265C4C3D;
 Tue, 18 Feb 2025 04:58:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 587BEC4CEE2;
 Tue, 18 Feb 2025 04:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1739854741;
 bh=zk8H4/bbYYI7JxAtzD01dM2ULQw1tUAqmMPNz7jNToc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=uJg0WQPh43DheThmWgMGT78Q0CbaVpNfZcNElt67XIbHxhSNaCKYvvR09CD3GdWjn
 XiaE6l7xq8uE7As/pjbxJDuL7rC6n6llEVLRjPd/cT0ZfYr77CF/JZhTHwQr0FKJYS
 y3vkGB0LBS/IZxlgIPaeSyf/rMYGIGiAoplzvbGeXjd0fjitcVAu2wGtTn4Z9H9Q+d
 TSoa7d5ltYl2huqjzezY01vM+G3QRIPlLQ+ZKQ0CwfUJjQUzQrduOMxxUv3ObM6KmU
 F/Lt000foeIRynqWwqo/9mwumzU4l1QWptFXoWDlRW+kh5C1a2bLlTRxytWDLHOm4G
 WvD2U2zkdl3bA==
From: Mario Limonciello <superm1@kernel.org>
To: amd-gfx@lists.freedesktop.org
Cc: harry.wentland@amd.com,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 09/13] drm/amd/display: Use _free(kfree) for
 dm_gpureset_commit_state()
Date: Mon, 17 Feb 2025 22:58:36 -0600
Message-ID: <20250218045840.2469890-10-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250218045840.2469890-1-superm1@kernel.org>
References: <20250218045840.2469890-1-superm1@kernel.org>
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

Using a _free(kfree) macro drops the need for a goto statement
as it will be freed when it goes out of scope.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index e7a9e60a6405c..33bed74c5b4c0 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3243,14 +3243,14 @@ static void dm_gpureset_commit_state(struct dc_state *dc_state,
 		struct dc_scaling_info scaling_infos[MAX_SURFACES];
 		struct dc_flip_addrs flip_addrs[MAX_SURFACES];
 		struct dc_stream_update stream_update;
-	} *bundle;
+	} *bundle __free(kfree);
 	int k, m;
 
 	bundle = kzalloc(sizeof(*bundle), GFP_KERNEL);
 
 	if (!bundle) {
 		drm_err(dm->ddev, "Failed to allocate update bundle\n");
-		goto cleanup;
+		return;
 	}
 
 	for (k = 0; k < dc_state->stream_count; k++) {
@@ -3270,9 +3270,6 @@ static void dm_gpureset_commit_state(struct dc_state *dc_state,
 					 &bundle->stream_update,
 					 bundle->surface_updates);
 	}
-
-cleanup:
-	kfree(bundle);
 }
 
 static int dm_resume(struct amdgpu_ip_block *ip_block)
-- 
2.43.0

