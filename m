Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B194EC36011
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Mar 2025 20:39:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5766E10E187;
	Thu, 27 Mar 2025 20:39:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SbpBkoUE";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6944110E169
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Mar 2025 20:39:13 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 08FFE61131;
 Thu, 27 Mar 2025 20:39:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAE07C4CEDD;
 Thu, 27 Mar 2025 20:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1743107950;
 bh=g3+dmWqshGczjMfrRMWrsesyMKoy9n9Px+ZT/TnqViY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=SbpBkoUEizmKkakdzG6HhlTJ/d3KHQOc81yvlAcO4fAqqjx/TEQkbe2ahOvTBoSRL
 QB/iFbgiY81wkWkYzlC0p8nScspdMh6XyZAbWw0FMl15f9e2pK7MMbwvLl1AdPiEuc
 c06VvGnirtcU9FyQ06hiJ7sBc44WWzIp7QdTmRcQ25EG23xBv81YUOsPRbHaT8lwwv
 uCsVRr0JkSQHZxbJoWk/ap+TNbJi5LJXoAmmDyg5khY4C0QR60gYGKGa9THBsaEn8G
 FXvhop2qFDSlCC0zGz5/4WVdO/tn6kmsf9GBQs3uuzu5KvkZqQWksgtqEk63bo6lkY
 1HhHM2YpuwKWg==
From: Mario Limonciello <superm1@kernel.org>
To: amd-gfx@lists.freedesktop.org
Cc: Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 02/14] drm/amd: Avoid showing an error about memory allocation
 in amdgpu_acpi_enumerate_xcc()
Date: Thu, 27 Mar 2025 15:38:46 -0500
Message-ID: <20250327203858.3796086-3-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250327203858.3796086-1-superm1@kernel.org>
References: <20250327203858.3796086-1-superm1@kernel.org>
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

checkpatch.pl complains about unnecessary error messages for failing
to allocate memory. These aren't needed when the return code is -ENOMEM.
Drop such a message from amdgpu_acpi_enumerate_xcc().

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index 1c5994de5a723..840901d65fed7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -1116,10 +1116,8 @@ static int amdgpu_acpi_enumerate_xcc(void)
 
 		xcc_info = kzalloc(sizeof(struct amdgpu_acpi_xcc_info),
 				   GFP_KERNEL);
-		if (!xcc_info) {
-			DRM_ERROR("Failed to allocate memory for xcc info\n");
+		if (!xcc_info)
 			return -ENOMEM;
-		}
 
 		INIT_LIST_HEAD(&xcc_info->list);
 		xcc_info->handle = acpi_device_handle(acpi_dev);
-- 
2.43.0

