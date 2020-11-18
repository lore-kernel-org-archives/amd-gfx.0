Return-Path: <SRS0=Rejl=EY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B4CC2D0E4
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2020 02:58:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 968D822228
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2020 02:58:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 968D822228
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vivo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1A6E6E235;
	Wed, 18 Nov 2020 02:58:34 +0000 (UTC)
Received: from m17618.mail.qiye.163.com (m17618.mail.qiye.163.com
 [59.111.176.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDA7B6E235
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2020 02:55:12 +0000 (UTC)
Received: from ubuntu.localdomain (unknown [112.80.34.205])
 by m17618.mail.qiye.163.com (Hmail) with ESMTPA id DD1734E16BE;
 Wed, 18 Nov 2020 10:55:09 +0800 (CST)
From: Bernard Zhao <bernard@vivo.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
 Monk Liu <Monk.Liu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 Yintian Tao <yttao@amd.com>, Dennis Li <Dennis.Li@amd.com>,
 Wenhui Sheng <Wenhui.Sheng@amd.com>, chen gong <curry.gong@amd.com>,
 Bokun Zhang <Bokun.Zhang@amd.com>, "Stanley.Yang" <Stanley.Yang@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] amd/amdgpu: use kmalloc_array to replace kmalloc with multiply
Date: Tue, 17 Nov 2020 18:55:01 -0800
Message-Id: <20201118025503.102699-1-bernard@vivo.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
 oVCBIfWUFZHUxCS0geH0lCTEIfVkpNS05NTUNKSktPSEhVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
 FZT0tIVUpKS09ISFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nww6Kww6Kj8hKw8#SjI0Sy4Q
 TCNPFCpVSlVKTUtOTU1DSkpLQ05NVTMWGhIXVRkeCRUaCR87DRINFFUYFBZFWVdZEgtZQVlKSklV
 Q0tVSE9VSUtOWVdZCAFZQUlCTk43Bg++
X-HM-Tid: 0a75d946ff7f9376kuwsdd1734e16be
X-Mailman-Approved-At: Wed, 18 Nov 2020 02:58:33 +0000
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
Cc: opensource.kernel@vivo.com, Bernard Zhao <bernard@vivo.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix check_patch.pl warning:
WARNING: Prefer kmalloc_array over kmalloc with multiply
+bps = kmalloc(align_space * sizeof((*data)->bps), GFP_KERNEL);
WARNING: Prefer kmalloc_array over kmalloc with multiply
+bps_bo = kmalloc(align_space * sizeof((*data)->bps_bo),
GFP_KERNEL);
kmalloc_array has multiply overflow check, which will be safer.

Signed-off-by: Bernard Zhao <bernard@vivo.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index d0aea5e39531..f2a0851c804f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -280,8 +280,8 @@ static int amdgpu_virt_init_ras_err_handler_data(struct amdgpu_device *adev)
 	if (!*data)
 		return -ENOMEM;
 
-	bps = kmalloc(align_space * sizeof((*data)->bps), GFP_KERNEL);
-	bps_bo = kmalloc(align_space * sizeof((*data)->bps_bo), GFP_KERNEL);
+	bps = kmalloc_array(align_space, sizeof((*data)->bps), GFP_KERNEL);
+	bps_bo = kmalloc_array(align_space, sizeof((*data)->bps_bo), GFP_KERNEL);
 
 	if (!bps || !bps_bo) {
 		kfree(bps);
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
