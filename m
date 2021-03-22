Return-Path: <SRS0=Az3f=IU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F4CC433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Mar 2021 11:55:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26F3961990
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Mar 2021 11:55:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26F3961990
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4C3889E1D;
	Mon, 22 Mar 2021 11:55:07 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AF5989E1D;
 Mon, 22 Mar 2021 11:55:06 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id B672C6198B;
 Mon, 22 Mar 2021 11:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1616414104;
 bh=NQBKDv/xaUzATP3yqfPz6TIrtay/vvss0zT4f9fjrSI=;
 h=From:To:Cc:Subject:Date:From;
 b=e1myS2raWRh96kX7ZJKmiBHBzDIu2m8qv6Ix7gWSD9vrjhn7/vFY0poWWvjq0dmls
 Bk7F/1R7UOc3oaf9W+ldRUhOmIUO6c4oLAYCqlE+OYOq5iLrf6chM6jT3yGn4oUZ4D
 68aT/Eg56zDIlJ3ZVSqMuu/AH0S0qpvWF//xs6wodR9wgKEE2FhqbFbsp5tx/qfuz4
 vhvWBJca31stzUgCzR7csVRzFD/ELTuPOl1uTt+fSDO9kop2sHHKqQiAHSM9r50rZo
 0IvOArywDi2AnNEd6XUlKdtCUTIodPsZJmGmyTVaxoxc5FA8cPB7Sjwpu4jgAaYfKv
 dHja6Dr5uYO1Q==
From: Arnd Bergmann <arnd@kernel.org>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH] amdgpu: avoid incorrect %hu format string
Date: Mon, 22 Mar 2021 12:54:42 +0100
Message-Id: <20210322115458.3961825-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
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
Cc: Sonny Jiang <sonny.jiang@amd.com>, Arnd Bergmann <arnd@arndb.de>,
 Tom Rix <trix@redhat.com>, dri-devel@lists.freedesktop.org,
 xinhui pan <xinhui.pan@amd.com>, Nick Desaulniers <ndesaulniers@google.com>,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 Nathan Chancellor <nathan@kernel.org>, clang-built-linux@googlegroups.com,
 Chen Li <chenli@uniontech.com>, Lee Jones <lee.jones@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Arnd Bergmann <arnd@arndb.de>

clang points out that the %hu format string does not match the type
of the variables here:

drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:263:7: warning: format specifies type 'unsigned short' but the argument has type 'unsigned int' [-Wformat]
                                  version_major, version_minor);
                                  ^~~~~~~~~~~~~
include/drm/drm_print.h:498:19: note: expanded from macro 'DRM_ERROR'
        __drm_err(fmt, ##__VA_ARGS__)
                  ~~~    ^~~~~~~~~~~

Change it to a regular %u, the same way a previous patch did for
another instance of the same warning.

Fixes: 0b437e64e0af ("drm/amdgpu: remove h from printk format specifier")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
index e2ed4689118a..c6dbc0801604 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
@@ -259,7 +259,7 @@ int amdgpu_uvd_sw_init(struct amdgpu_device *adev)
 		if ((adev->asic_type == CHIP_POLARIS10 ||
 		     adev->asic_type == CHIP_POLARIS11) &&
 		    (adev->uvd.fw_version < FW_1_66_16))
-			DRM_ERROR("POLARIS10/11 UVD firmware version %hu.%hu is too old.\n",
+			DRM_ERROR("POLARIS10/11 UVD firmware version %u.%u is too old.\n",
 				  version_major, version_minor);
 	} else {
 		unsigned int enc_major, enc_minor, dec_minor;
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
