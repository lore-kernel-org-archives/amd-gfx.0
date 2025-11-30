Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CB57CFD2F6
	for <amd-gfx@archiver.kernel.org>; Sun, 30 Nov 2025 01:46:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC38610E23F;
	Sun, 30 Nov 2025 01:46:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PQdbTdvB";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6911A10E23F
 for <amd-gfx@lists.freedesktop.org>; Sun, 30 Nov 2025 01:46:43 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 93E126000A
 for <amd-gfx@lists.freedesktop.org>; Sun, 30 Nov 2025 01:46:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D483FC4CEF7;
 Sun, 30 Nov 2025 01:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1764467202;
 bh=OqXlEtz2rn8wqWNvDF9whkiZxpiuh7vhQ56XscaI0bU=;
 h=From:To:Cc:Subject:Date:From;
 b=PQdbTdvBWFT60cxRW2RvBOZ8zmLanqsMd3RIHqQwniDx1lzIKhwePj904rGMhxp1p
 9CZ9WJ+j6Qv7aP5efc3UMkn+m3+5XXczxEOnfbWHSnydrJi/6N4PctPu9v7Y8lHAda
 4X55O99OOxUzPKZYJ3bVfdIQKvKOyq4YGUhX7qRORZHQ6nHv5yxo+ofrgZ5ujVzheH
 H3DQ+0/k7Pnwb+JprVLt2xG5c3H33cDDHnLRAGEkvujNP0jL3DcRa+jG2jowXxByf0
 0ZSS1hKlEJpFNCPw+0Rv+N5n4bbX11Db6sJJngM+eX2n0q7HVYCxSiFFDPU09gDb1h
 qRclpWnngrchw==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: amd-gfx@lists.freedesktop.org
Cc: "Mario Limonciello (AMD)" <superm1@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH] Revert "drm/amd: Skip power ungate during suspend for VPE"
Date: Sat, 29 Nov 2025 19:46:31 -0600
Message-ID: <20251130014631.29755-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
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

Skipping power ungate exposed some scenarios that will fail
like below:

```
amdgpu: Register(0) [regVPEC_QUEUE_RESET_REQ] failed to reach value 0x00000000 != 0x00000001n
amdgpu 0000:c1:00.0: amdgpu: VPE queue reset failed
...
amdgpu: [drm] *ERROR* wait_for_completion_timeout timeout!
```

The underlying s2idle issue that prompted this commit is going to
be fixed in BIOS.
This reverts commit 31ab31433c9bd2f255c48dc6cb9a99845c58b1e4.

Fixes: 31ab31433c9bd ("drm/amd: Skip power ungate during suspend for VPE")
Cc: stable@vger.kernel.org
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 076bbc09f30ce..2819aceaab749 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3414,11 +3414,10 @@ int amdgpu_device_set_pg_state(struct amdgpu_device *adev,
 		    (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GFX ||
 		     adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_SDMA))
 			continue;
-		/* skip CG for VCE/UVD/VPE, it's handled specially */
+		/* skip CG for VCE/UVD, it's handled specially */
 		if (adev->ip_blocks[i].version->type != AMD_IP_BLOCK_TYPE_UVD &&
 		    adev->ip_blocks[i].version->type != AMD_IP_BLOCK_TYPE_VCE &&
 		    adev->ip_blocks[i].version->type != AMD_IP_BLOCK_TYPE_VCN &&
-		    adev->ip_blocks[i].version->type != AMD_IP_BLOCK_TYPE_VPE &&
 		    adev->ip_blocks[i].version->type != AMD_IP_BLOCK_TYPE_JPEG &&
 		    adev->ip_blocks[i].version->funcs->set_powergating_state) {
 			/* enable powergating to save power */
-- 
2.43.0

