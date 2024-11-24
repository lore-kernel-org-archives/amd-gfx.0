Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC1D4E66887
	for <amd-gfx@archiver.kernel.org>; Sun, 24 Nov 2024 13:53:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A85E10E561;
	Sun, 24 Nov 2024 13:53:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FLgpbS9n";
	dkim-atps=neutral
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87B9610E55B;
 Sun, 24 Nov 2024 13:53:01 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 8F71BA40D44;
 Sun, 24 Nov 2024 13:51:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9951C4CECC;
 Sun, 24 Nov 2024 13:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1732456380;
 bh=VrMC/qm3yF6vGuNO7pBmx5unBh37CgIKAFGLyrw8szc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=FLgpbS9njvzaDO8vz84wrmi5rAmdF8WaLZ7idBEI5TwdWvqzILeAfq4P3ReK3/D2V
 KAwxX3u1SeAaSjT+tE/bdGN/Wj9xZCGBJPaEobMXHAZFmMA3Dcwo8f8JcQeXyOGpQw
 1dNsEx6opaHzkb9zJLuXiYPXJrquDgQi+SP8hwibr0qTsZxEGUFQb2QWO9blDvcLuc
 NYNB4qL33mF9RNKu8woDXsdsH5wallmoqr7w5ru9cK+FX5AtBcVvZRQJWn0l69qVTw
 h6zam+zwgGK2H52d4bDo9CcZEMhJF4tfJ9Ky1v98ikjLa+UqdC/lKi3Epou/RHKv0Y
 Y30JnMAUFajyQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Prike Liang <Prike.Liang@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Sasha Levin <sashal@kernel.org>,
 christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
 simona@ffwll.ch, mario.limonciello@amd.com, Jun.Ma2@amd.com,
 antonio@mandelbit.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.15 20/36] drm/amdgpu: Dereference the ATCS ACPI
 buffer
Date: Sun, 24 Nov 2024 08:51:34 -0500
Message-ID: <20241124135219.3349183-20-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124135219.3349183-1-sashal@kernel.org>
References: <20241124135219.3349183-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.173
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

From: Prike Liang <Prike.Liang@amd.com>

[ Upstream commit 32e7ee293ff476c67b51be006e986021967bc525 ]

Need to dereference the atcs acpi buffer after
the method is executed, otherwise it will result in
a memory leak.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index 592ca0cfe61d0..0adc992e4630a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -761,6 +761,7 @@ int amdgpu_acpi_power_shift_control(struct amdgpu_device *adev,
 		return -EIO;
 	}
 
+	kfree(info);
 	return 0;
 }
 
-- 
2.43.0

