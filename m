Return-Path: <SRS0=CzGJ=J6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B0ECC4360C
	for <amd-gfx@archiver.kernel.org>; Mon,  3 May 2021 16:38:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB1D6613D0
	for <amd-gfx@archiver.kernel.org>; Mon,  3 May 2021 16:38:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB1D6613D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFCCB6E96A;
	Mon,  3 May 2021 16:38:16 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DF2D6E971;
 Mon,  3 May 2021 16:38:15 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 426A2613C6;
 Mon,  3 May 2021 16:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1620059895;
 bh=+HgmHTOTaMq1E0gDxXCL9uXYquSbuU8ATcw7dyeRPWo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=p/Th7vVD2W6755jh2wLGo0262c7smoK6YAfSwaRUf4EYAF7fiy2T1t5qwHD4F4RtI
 PlVny9bigcHQOFEhddWOiSZGz331e6SmZebFL0OkiSlUTCk4koB7qfg3cKTXCfwUoG
 JQP0Bp7xJq7v6QHE6zbj5/Khb5zSwBothDklI6w4Tk5moWufayVrnKbLvadRil54cU
 Yt+dITOPqeX62aqlRyNElP6qTLCpWLzBDfYmbg1cCIBLgPwOkX3ugRxPZMfxoDal/o
 1THRA6ynHYmiUdzV+YLYN63PI2xglYWAoLZllhHBW+t+zFbgJO4P/lglgl1eA2pUJs
 iKDV5W+vmhJ2A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.11 049/115] drm/amdgpu: Fix memory leak
Date: Mon,  3 May 2021 12:35:53 -0400
Message-Id: <20210503163700.2852194-49-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210503163700.2852194-1-sashal@kernel.org>
References: <20210503163700.2852194-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Sasha Levin <sashal@kernel.org>,
 xinhui pan <xinhui.pan@amd.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: xinhui pan <xinhui.pan@amd.com>

[ Upstream commit 79fcd446e7e182c52c2c808c76f8de3eb6714349 ]

drm_gem_object_put() should be paired with drm_gem_object_lookup().

All gem objs are saved in fb->base.obj[]. Need put the old first before
assign a new obj.

Trigger VRAM leak by running command below
$ service gdm restart

Signed-off-by: xinhui pan <xinhui.pan@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index 48cb33e5b382..f5fa1befa7e2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -910,8 +910,9 @@ int amdgpu_display_framebuffer_init(struct drm_device *dev,
 	}
 
 	for (i = 1; i < rfb->base.format->num_planes; ++i) {
+		drm_gem_object_get(rfb->base.obj[0]);
+		drm_gem_object_put(rfb->base.obj[i]);
 		rfb->base.obj[i] = rfb->base.obj[0];
-		drm_gem_object_get(rfb->base.obj[i]);
 	}
 
 	return 0;
@@ -960,6 +961,7 @@ amdgpu_display_user_framebuffer_create(struct drm_device *dev,
 		return ERR_PTR(ret);
 	}
 
+	drm_gem_object_put(obj);
 	return &amdgpu_fb->base;
 }
 
-- 
2.30.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
