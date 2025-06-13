Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E8A8C7115E
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Jun 2025 13:10:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD98610E39E;
	Mon, 16 Jun 2025 13:10:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="d2VKEaFV";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6D3B10E986;
 Fri, 13 Jun 2025 18:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=TUXPkE87OXJAHaOZK6ahNNVbIJxz7eNpz1YGq7eIuRc=; b=d2VKEaFVWxssYhQV70dvsctYtZ
 +vtX/HI7fMGE6d3djo2Av0potudAUBDIuSyRxvbYdKIFVmc8v6hiS4nzDLaCi074yM4pIb+YoPcTL
 IDrCR4NORRfnU4GOsRyiO0aaAe5PlNTDpRXJKff1hCdi6WXvE87wJWS1/0Atz7hSWX9Tr3Yyc4/TK
 mVeFutgOlORgqSn+pblbGqmOe+HhP1/z0S6QRj1yhPbvDkMF1xmy/poNOHS+mBkrOf41RMHWbrSde
 DrzpCxsGDo6kFmyVJ45yMkZzANcfTYsCyooJKG/+wyRyH2Eg92IjEU8JtTPzSkBBaRN2lTYG/AEVn
 4/ha6o0A==;
Received: from [191.204.192.64] (helo=localhost.localdomain)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1uQ97K-0039wK-OM; Fri, 13 Jun 2025 20:27:07 +0200
From: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To: "Alex Deucher" <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel-dev@igalia.com, amd-gfx@lists.freedesktop.org,
 =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH 2/2] drm/amd: Include <linux/export.h> when needed
Date: Fri, 13 Jun 2025 15:26:51 -0300
Message-ID: <20250613182651.1758760-3-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250613182651.1758760-1-andrealmeid@igalia.com>
References: <20250613182651.1758760-1-andrealmeid@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 16 Jun 2025 13:10:04 +0000
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

Fix the following compile time warning when building with W=1:

warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c  | 1 +
 drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 73403744331a..e9530ed6ad43 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -32,6 +32,7 @@
 #include <linux/list.h>
 #include <linux/slab.h>
 #include <linux/dma-buf.h>
+#include <linux/export.h>
 
 #include <drm/drm_drv.h>
 #include <drm/amdgpu_drm.h>
diff --git a/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c b/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c
index faed84172dd4..8bc36f04b1b7 100644
--- a/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c
+++ b/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c
@@ -21,6 +21,7 @@
  *
  */
 
+#include <linux/export.h>
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
-- 
2.49.0

