Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 769ABC7EE2C
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Aug 2023 07:38:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A05310E4A5;
	Thu, 24 Aug 2023 07:38:01 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CA7110E49D;
 Thu, 24 Aug 2023 07:37:58 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 40B8465A43;
 Thu, 24 Aug 2023 07:37:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 551FFC433C9;
 Thu, 24 Aug 2023 07:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1692862676;
 bh=HAx36VxD8SeJ19cuhWARnMLzp3fwBWyVuZuUJYdgr/w=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=jHuHQaGg4Vb86jowcTNgkWiVaVeYdqTolC0e84zCxI8iISBvWduO+la86lew1mX5S
 yrHkH1eRcW1Ar0svfHOovGuWCJpKh+e7NsKP7UE9oez3OLiEy4caGPDBggU5pDFW61
 8lXY1H+o3m5N8W19E4JZIAlwqZjssGSszLiJtwKHCQvxexYl+/3OE39X97kAKZXgO2
 ZJkjcAwCA760dNQHuSnWRkdvk/yG6NyRqKKnuRkqrD8Vev8vrazo4AxJQZ95F2mKvw
 og5sbSAmypyfGTlS+JTu6aH6bmSiw6NT70BHJAkLs9SnmNI5fXuRlmqHlu1Jb31KPG
 Zyrb3ARi6Uh8Q==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org
Subject: [PATCH 11/20] drm/amd/amdgpu/amdgpu_doorbell_mgr: Correct
 misdocumented param 'doorbell_index'
Date: Thu, 24 Aug 2023 08:36:56 +0100
Message-ID: <20230824073710.2677348-12-lee@kernel.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230824073710.2677348-1-lee@kernel.org>
References: <20230824073710.2677348-1-lee@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: Shashank Sharma <shashank.sharma@amd.com>, "Pan,
 Xinhui" <Xinhui.Pan@amd.com>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 David Airlie <airlied@gmail.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c:123: warning: Function parameter or member 'doorbell_index' not described in 'amdgpu_doorbell_index_on_bar'
 drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c:123: warning: Excess function parameter 'db_index' description in 'amdgpu_doorbell_index_on_bar'

Signed-off-by: Lee Jones <lee@kernel.org>
---
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Shashank Sharma <shashank.sharma@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
index da4be0bbb4466..d0249ada91d30 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
@@ -113,7 +113,7 @@ void amdgpu_mm_wdoorbell64(struct amdgpu_device *adev, u32 index, u64 v)
  *
  * @adev: amdgpu_device pointer
  * @db_bo: doorbell object's bo
- * @db_index: doorbell relative index in this doorbell object
+ * @doorbell_index: doorbell relative index in this doorbell object
  *
  * returns doorbell's absolute index in BAR
  */
-- 
2.42.0.rc1.204.g551eb34607-goog

