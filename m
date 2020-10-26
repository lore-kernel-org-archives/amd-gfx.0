Return-Path: <SRS0=jB5Z=EB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 986FDC388F9
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2020 21:01:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EF8120882
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2020 21:01:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rtBeg7mo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EF8120882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E75596EA70;
	Mon, 26 Oct 2020 21:01:38 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 710726EA70;
 Mon, 26 Oct 2020 21:01:37 +0000 (UTC)
Received: from localhost.localdomain (unknown [192.30.34.233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D79C920829;
 Mon, 26 Oct 2020 21:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1603746097;
 bh=Sl0AeOUeKfSSE44S4mD27orpF56Z7J4Bt+Y+zUMMhI4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=rtBeg7moyP4a3B0SOX45SiZm/0H9T7+m88WonKBeQpCZrNXuvsDDBReECtc89l7mB
 HTATx/M+wvYCcJqGBOrPtSYLFQRYvxrzpO/F2uouCVJxPK+YugcbhDvk5M/yQMcO6g
 rbWaVRMU2coTP9psQFMCCYLW8u3avu/7Roo7jnGA=
From: Arnd Bergmann <arnd@kernel.org>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH 5/5] drm/amdgpu: disable -Woverride-init warning
Date: Mon, 26 Oct 2020 22:00:33 +0100
Message-Id: <20201026210039.3884312-5-arnd@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201026210039.3884312-1-arnd@kernel.org>
References: <20201026210039.3884312-1-arnd@kernel.org>
MIME-Version: 1.0
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
Cc: Yong Zhao <Yong.Zhao@amd.com>, Arnd Bergmann <arnd@arndb.de>,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 Huang Rui <ray.huang@amd.com>, dri-devel@lists.freedesktop.org,
 Likun Gao <Likun.Gao@amd.com>, Evan Quan <evan.quan@amd.com>,
 Leo Liu <leo.liu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Arnd Bergmann <arnd@arndb.de>

Building with 'make W=1' produces countless warnings like

amdgpu/../include/vega10_ip_offset.h:276:51: warning: initialized field overwritten [-Woverride-init]

Shut these up by disabling the particular warning in the
amdgpu driver.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/amd/amdgpu/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 247dd46e1681..5a46949bc17c 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -36,7 +36,8 @@ ccflags-y := -I$(FULL_AMD_PATH)/include/asic_reg \
 	-I$(FULL_AMD_DISPLAY_PATH)/include \
 	-I$(FULL_AMD_DISPLAY_PATH)/dc \
 	-I$(FULL_AMD_DISPLAY_PATH)/amdgpu_dm \
-	-I$(FULL_AMD_PATH)/amdkfd
+	-I$(FULL_AMD_PATH)/amdkfd \
+	-Wno-override-init
 
 amdgpu-y := amdgpu_drv.o
 
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
