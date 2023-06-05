Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4A23C7EE23
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Jun 2023 10:58:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC2D910E288;
	Mon,  5 Jun 2023 10:58:43 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C49B10E288;
 Mon,  5 Jun 2023 10:58:42 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 588FD6135D;
 Mon,  5 Jun 2023 10:58:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E8AAC433EF;
 Mon,  5 Jun 2023 10:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1685962720;
 bh=zFZh3DbitN9/k0ynfjMxiJVKXQDruFuT+gVPq2YmqCo=;
 h=From:To:Cc:Subject:Date:From;
 b=rBrmPNUsgjY6al0qoJqoSXyT5aYOhiIKrmiF/ZdmjXFxlThaQMW7jlGR9p1jzPNQc
 IpMDKNokZ4FTmzs4tvOl+sb/RxGbQCXpx7nMXMXI4N9xPZRtzW/zNYMlC+abLbnSnS
 eMwz2g1ZKQ2JxWuIGKGhjNEtqUwj+x7pwlTHsmM+srlIG/j5yWcEQk3qSL39F+I3XL
 RklCd6dmIlnbLCD98jmsSMASvZX+QzU9u42KgyLZfnP1tClmLBqjux4OcTTXjLZlV0
 aoaW5QYhEg28wGfb/GUYKYQzEzbMQmy+ukoGcUW1OeEiC8CRNuWwClPV/go/0IUHHi
 t6UzQ30QEb6CQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Jonathan Kim <jonathan.kim@amd.com>
Subject: [PATCH] drm/amdkfd: mark som eclear_address_watch() callback static
Date: Mon,  5 Jun 2023 12:58:28 +0200
Message-Id: <20230605105834.702945-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
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
Cc: Mukul Joshi <mukul.joshi@amd.com>, Arnd Bergmann <arnd@arndb.de>,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 Le Ma <le.ma@amd.com>, Ramesh Errabolu <Ramesh.Errabolu@amd.com>,
 dri-devel@lists.freedesktop.org, Yifan Zha <Yifan.Zha@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Arnd Bergmann <arnd@arndb.de>

Some of the newly introduced clear_address_watch callback handlers have
no prototype because they are only used in one file, which causes a W=1
warning:

drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c:164:10: error: no previous prototype for 'kgd_gfx_aldebaran_clear_address_watch' [-Werror=missing-prototypes]
drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c:782:10: error: no previous prototype for 'kgd_gfx_v11_clear_address_watch' [-Werror=missing-prototypes]

Mark these ones static. If another user comes up in the future, that
can be reverted along with adding the prototype.

Fixes: cfd9715f741a1 ("drm/amdkfd: add debug set and clear address watch points operation")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
index efd6a72aab4eb..bdda8744398fe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
@@ -161,7 +161,7 @@ static uint32_t kgd_gfx_aldebaran_set_address_watch(
 	return watch_address_cntl;
 }
 
-uint32_t kgd_gfx_aldebaran_clear_address_watch(struct amdgpu_device *adev,
+static uint32_t kgd_gfx_aldebaran_clear_address_watch(struct amdgpu_device *adev,
 					uint32_t watch_id)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
index 52efa690a3c21..131859ce3e7e9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
@@ -779,7 +779,7 @@ static uint32_t kgd_gfx_v11_set_address_watch(struct amdgpu_device *adev,
 	return watch_address_cntl;
 }
 
-uint32_t kgd_gfx_v11_clear_address_watch(struct amdgpu_device *adev,
+static uint32_t kgd_gfx_v11_clear_address_watch(struct amdgpu_device *adev,
 					uint32_t watch_id)
 {
 	return 0;
-- 
2.39.2

