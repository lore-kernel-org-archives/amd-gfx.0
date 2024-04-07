Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B4AECD128A
	for <amd-gfx@archiver.kernel.org>; Sun,  7 Apr 2024 13:12:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B119010E2A0;
	Sun,  7 Apr 2024 13:12:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="uft8BOVT";
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3949910E376;
 Sun,  7 Apr 2024 13:12:13 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 4287560C5F;
 Sun,  7 Apr 2024 13:12:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28269C433F1;
 Sun,  7 Apr 2024 13:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1712495531;
 bh=6zzbWAyna2YyQAnGbGIAMsDqYnksI8cYUqLblgad2V8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=uft8BOVTnOyYmSXjAYbxepZXL12TuFL5NKUdLaJ5D4isZxSaISHG4OjVraHlSenHr
 DD+wuHWreF6HTf97R5iDFEsdPL/pIXouhrarEfgxMJVO7+mEhYrpzGgk0BvOUYJvFU
 97bYxUslbUe7/uxctx1arNa/v1M6yOyVv4QsJsGKRJHRA/UI0YqYBQc/FUQ6WF5C7J
 KV4UPYg9ZH9l6hHlIF+0PEl7gl2VdIrb3CQJ+215HfL7s2LkdSWuNfuxXnKvQr8n/8
 VrfFBh2RwR7MAUHOLrHUVYn69epKRiwydV70la33M6Q/h4t2vNkm/gHPPpbQfpDKL8
 grdKpy6SUP3Kw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peyton Lee <peytolee@amd.com>, Lang Yu <lang.yu@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Sasha Levin <sashal@kernel.org>,
 christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
 daniel@ffwll.ch, Lang.Yu@amd.com, yifan1.zhang@amd.com, lijo.lazar@amd.com,
 srinivasan.shanmugam@amd.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.8 21/25] drm/amdgpu/vpe: power on vpe when hw_init
Date: Sun,  7 Apr 2024 09:11:09 -0400
Message-ID: <20240407131130.1050321-21-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240407131130.1050321-1-sashal@kernel.org>
References: <20240407131130.1050321-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.4
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

From: Peyton Lee <peytolee@amd.com>

[ Upstream commit eed14eb48ee176fe0144c6a999d00c855d0b199b ]

To fix mode2 reset failure.
Should power on VPE when hw_init.

Signed-off-by: Peyton Lee <peytolee@amd.com>
Reviewed-by: Lang Yu <lang.yu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
index b9a15d51eb5c3..ad44012cc01e2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
@@ -390,6 +390,12 @@ static int vpe_hw_init(void *handle)
 	struct amdgpu_vpe *vpe = &adev->vpe;
 	int ret;
 
+	/* Power on VPE */
+	ret = amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VPE,
+						     AMD_PG_STATE_UNGATE);
+	if (ret)
+		return ret;
+
 	ret = vpe_load_microcode(vpe);
 	if (ret)
 		return ret;
-- 
2.43.0

