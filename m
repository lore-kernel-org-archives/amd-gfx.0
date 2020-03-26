Return-Path: <SRS0=Hz3R=5M=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB7C0C43331
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2020 08:08:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF4BD20714
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2020 08:08:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF4BD20714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C80A6E9D4;
	Fri, 27 Mar 2020 08:08:43 +0000 (UTC)
X-Greylist: delayed 320 seconds by postgrey-1.36 at gabe;
 Thu, 26 Mar 2020 21:15:26 UTC
Received: from pokefinder.org (sauhun.de [88.99.104.3])
 by gabe.freedesktop.org (Postfix) with ESMTP id 9F1A06E929
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2020 21:15:26 +0000 (UTC)
Received: from localhost (p54B3331F.dip0.t-ipconnect.de [84.179.51.31])
 by pokefinder.org (Postfix) with ESMTPSA id F1D592C1F94;
 Thu, 26 Mar 2020 22:10:05 +0100 (CET)
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-i2c@vger.kernel.org
Subject: [PATCH 1/6] drm/amdgpu: convert to use i2c_new_client_device()
Date: Thu, 26 Mar 2020 22:09:59 +0100
Message-Id: <20200326211005.13301-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200326211005.13301-1-wsa+renesas@sang-engineering.com>
References: <20200326211005.13301-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 27 Mar 2020 08:08:39 +0000
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
Cc: "David \(ChunMing\) Zhou" <David1.Zhou@amd.com>,
 David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, Wolfram Sang <wsa+renesas@sang-engineering.com>,
 dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Move away from the deprecated API.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c
index ba1bb95a3cf9..0e8018c9aa8e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c
@@ -856,7 +856,7 @@ void amdgpu_add_thermal_controller(struct amdgpu_device *adev)
 				const char *name = pp_lib_thermal_controller_names[controller->ucType];
 				info.addr = controller->ucI2cAddress >> 1;
 				strlcpy(info.type, name, sizeof(info.type));
-				i2c_new_device(&adev->pm.i2c_bus->adapter, &info);
+				i2c_new_client_device(&adev->pm.i2c_bus->adapter, &info);
 			}
 		} else {
 			DRM_INFO("Unknown thermal controller type %d at 0x%02x %s fan control\n",
-- 
2.20.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
