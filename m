Return-Path: <SRS0=SMOw=MZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17FC3C4338F
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Aug 2021 07:57:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D08C160FC1
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Aug 2021 07:57:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D08C160FC1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vivo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B1E16E245;
	Mon,  2 Aug 2021 07:57:04 +0000 (UTC)
X-Greylist: delayed 549 seconds by postgrey-1.36 at gabe;
 Mon, 02 Aug 2021 07:41:56 UTC
Received: from mail-m17655.qiye.163.com (mail-m17655.qiye.163.com
 [59.111.176.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE5C16E1F4
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Aug 2021 07:41:56 +0000 (UTC)
Received: from ubuntu.localdomain (unknown [36.152.145.182])
 by mail-m17655.qiye.163.com (Hmail) with ESMTPA id 717234014F;
 Mon,  2 Aug 2021 15:32:44 +0800 (CST)
From: zhouchuangao <zhouchuangao@vivo.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, Hawking Zhang <Hawking.Zhang@amd.com>,
 John Clements <john.clements@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 Jinzhou Su <Jinzhou.Su@amd.com>, Wenhui Sheng <Wenhui.Sheng@amd.com>,
 Victor Zhao <Victor.Zhao@amd.com>, Kevin Wang <kevin1.wang@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: zhouchuangao <zhouchuangao@vivo.com>
Subject: [PATCH] gpu/drm/amd: Remove duplicated include of drm_drv.h
Date: Mon,  2 Aug 2021 00:32:32 -0700
Message-Id: <1627889555-56431-1-git-send-email-zhouchuangao@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
 kWDxoPAgseWUFZKDYvK1lXWShZQUhPN1dZLVlBSVdZDwkaFQgSH1lBWUJCSktWH0hPQ0JNGR9PHU
 5LVRMBExYaEhckFA4PWVdZFhoPEhUdFFlBWU9LSFVKSktISkNVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MjY6Shw*Gj9MPTMKKjY#KDIi
 NC4wFCxVSlVKTUlMQ0NCTk1OTUJMVTMWGhIXVQETFA4YEw4aFRwaFDsNEg0UVRgUFkVZV1kSC1lB
 WUhNVUpOSVVKT05VSkNJWVdZCAFZQUlOS083Bg++
X-HM-Tid: 0a7b05c77c4eda01kuws717234014f
X-Mailman-Approved-At: Mon, 02 Aug 2021 07:57:01 +0000
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

Duplicate include header file <drm/drm_drv.h>
line 28: #include <drm/drm_drv.h>
line 44: #include <drm/drm_drv.h>

Signed-off-by: zhouchuangao <zhouchuangao@vivo.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 3ec5099..05f864f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -41,8 +41,6 @@
 #include "amdgpu_securedisplay.h"
 #include "amdgpu_atomfirmware.h"
 
-#include <drm/drm_drv.h>
-
 static int psp_sysfs_init(struct amdgpu_device *adev);
 static void psp_sysfs_fini(struct amdgpu_device *adev);
 
-- 
2.7.4

