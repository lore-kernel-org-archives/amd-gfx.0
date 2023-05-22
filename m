Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A7D7C7EE26
	for <amd-gfx@archiver.kernel.org>; Mon, 22 May 2023 11:51:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBA5810E2EC;
	Mon, 22 May 2023 11:51:30 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5E5910E2EC;
 Mon, 22 May 2023 11:51:28 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 2050962177;
 Mon, 22 May 2023 11:51:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3408BC4339C;
 Mon, 22 May 2023 11:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1684756287;
 bh=wsmVaRXDTHdYbuzmc+ErLrw25ByhRTk9OeHIp7wng8k=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=VTNepLXJ+mYAtmR4o5JKpUOvPO1eRVNdd7Bhp2iGfAJip1Q/5PSMSIx0CI+vW2Fp6
 Vq/NmHzdGFrnK14KS8GQJrTGU+eG4+EdqOoELESOGtqfl+UPv5KMXTgjdxQ/iZkS5g
 E8ey02Rhx6A+T41wu2pPHqoRyIMJnbfEt7hfLkwEGfubolT3Wvjgk1cKzLQQjpWfyK
 Lu2KuvvISEEHKmhr2QpSpVcxQw12jCW5bmFlYtdp6bGb1SoKjW3SiD/Jfny61b9n5Z
 SpVkb8W7HZi266CLcAGhRx8GH1P9hlVZxTsYxOSTFnvzof4aoe9KXj8mjTtXppwN9v
 xac9IM03fxpYQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Lijo Lazar <lijo.lazar@amd.com>,
 Le Ma <le.ma@amd.com>
Subject: [PATCH 5/5] drm/amdgpu: fix acpi build warnings
Date: Mon, 22 May 2023 13:50:32 +0200
Message-Id: <20230522115047.1169839-5-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230522115047.1169839-1-arnd@kernel.org>
References: <20230522115047.1169839-1-arnd@kernel.org>
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
Cc: Tim Huang <tim.huang@amd.com>, Jingyu Wang <jingyuwang_vip@163.com>,
 Arnd Bergmann <arnd@arndb.de>, Bokun Zhang <Bokun.Zhang@amd.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, Hans de Goede <hdegoede@redhat.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Arnd Bergmann <arnd@arndb.de>

Two newly introduced functions are in the global namespace but have no prototypes
or callers outside of amdgpu_acpi.c, another function is static but only has
a caller inside of an #ifdef:

drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c:902:13: error: no previous prototype for 'amdgpu_acpi_get_node_id' [-Werror=missing-prototypes]
drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c:928:30: error: no previous prototype for 'amdgpu_acpi_get_dev' [-Werror=missing-prototypes]
drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c:860:33: error: 'amdgpu_acpi_get_numa_info' defined but not used [-Werror=unused-function]

Avoid the warnings by marking all of them static and ensuring that the compiler is
able to see the callsites.

Fixes: c34db97b8217 ("drm/amdgpu: Add API to get numa information of XCC")
Fixes: 1f6f659d06e1 ("drm/amdgpu: Store additional numa node information")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index 873532c4adbe..1dbcd0e62478 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -899,13 +899,15 @@ static struct amdgpu_numa_info *amdgpu_acpi_get_numa_info(uint32_t pxm)
  *
  * Returns ACPI STATUS OK with Node ID on success or the corresponding failure reason
  */
-acpi_status amdgpu_acpi_get_node_id(acpi_handle handle,
+static acpi_status amdgpu_acpi_get_node_id(acpi_handle handle,
 				    struct amdgpu_numa_info **numa_info)
 {
-#ifdef CONFIG_ACPI_NUMA
 	u64 pxm;
 	acpi_status status;
 
+	if (!IS_ENABLED(CONFIG_ACPI_NUMA))
+		return_ACPI_STATUS(AE_NOT_EXIST);
+
 	if (!numa_info)
 		return_ACPI_STATUS(AE_ERROR);
 
@@ -920,12 +922,9 @@ acpi_status amdgpu_acpi_get_node_id(acpi_handle handle,
 		return_ACPI_STATUS(AE_ERROR);
 
 	return_ACPI_STATUS(AE_OK);
-#else
-	return_ACPI_STATUS(AE_NOT_EXIST);
-#endif
 }
 
-struct amdgpu_acpi_dev_info *amdgpu_acpi_get_dev(u16 bdf)
+static struct amdgpu_acpi_dev_info *amdgpu_acpi_get_dev(u16 bdf)
 {
 	struct amdgpu_acpi_dev_info *acpi_dev;
 
-- 
2.39.2

