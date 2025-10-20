Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B2E6CCD1A7
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Oct 2025 16:53:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10D1410E480;
	Mon, 20 Oct 2025 16:53:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ly7YWfNU";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FEAD10E486;
 Mon, 20 Oct 2025 16:53:34 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 35BB745072;
 Mon, 20 Oct 2025 16:53:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA132C113D0;
 Mon, 20 Oct 2025 16:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1760979214;
 bh=1rkkZ5AZJ1f6tx+F7MiJYeMTvVjq0iVEGK4upPvLgz4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ly7YWfNUgbVv3Pn+Pbo5Pc8AMCOcOM6wlyp67ru21Ff5AKntHmv4GVUMprIhExqJN
 3AFV89l4OniDqENxwIrZ5QLfdH0+X0jVJTqEvtNzNuiwNs/WtsZrCbWdsUS3ojOSnD
 zX881mOUzZEG6wEXmkHpBVX3BOdaJxUNrUDbyBQ9P2AArtYK0+bQ5+Xdjd7XzM3TO8
 259wwJEOkKW8oxZmdgsI+UhiqDJfONNfIlRKVbUuVtKvQhTWmzlrGf0XGUhW5gNk0H
 w5MmAZIvQ1Nzw75hoyOe+IzPEQlG8frbq9WJq91ldvDI0/7kAI8JHY5sZs1c4sLMDM
 yxWMPbwhReyrA==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: mario.limonciello@amd.com, airlied@gmail.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, dakr@kernel.org, gregkh@linuxfoundation.org,
 lenb@kernel.org, pavel@kernel.org, rafael@kernel.org, simona@ffwll.ch
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-pm@vger.kernel.org
Subject: [RFC 3/3] drm/amd: Return -EBUSY for amdgpu_pmops_thaw() on success
Date: Mon, 20 Oct 2025 11:50:49 -0500
Message-ID: <20251020165317.3992933-4-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251020165317.3992933-1-superm1@kernel.org>
References: <20251020165317.3992933-1-superm1@kernel.org>
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

The PM core should be notified that thaw was skipped for the device
so that if it's tried to be resumed (such as an aborted hibernate)
that it gets another chance to resume.

Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 61268aa82df4d..d40af069f24dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2681,7 +2681,7 @@ static int amdgpu_pmops_thaw(struct device *dev)
 
 	/* do not resume device if it's normal hibernation */
 	if (!pm_hibernate_is_recovering() && !pm_hibernation_mode_is_suspend())
-		return 0;
+		return -EBUSY;
 
 	return amdgpu_device_resume(drm_dev, true);
 }
-- 
2.43.0

