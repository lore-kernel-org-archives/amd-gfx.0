Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5942DCD98F8
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Oct 2023 07:26:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D33C510E201;
	Wed, 11 Oct 2023 07:26:07 +0000 (UTC)
X-Greylist: delayed 910 seconds by postgrey-1.36 at gabe;
 Wed, 11 Oct 2023 01:37:17 UTC
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.219])
 by gabe.freedesktop.org (Postfix) with ESMTP id 9A59F10E3BC
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Oct 2023 01:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=Vr7Bs
 tkKmldss60EUl/n4EYbPgUE5JxJ5+BpG7bzkYQ=; b=AkSI/sGdPGFgpvQqRApYk
 DgNxb1fFcsvtgE0LcqGEn/AZs5OcgDhYyWCTyL4BOpUZvH2QgNicuZm0FdPNuFfS
 myzuCrppFgQiVngRc3p3b18bsUoa+53PmtDeQk6wGREuxjJKlEnNM9s4OfLyTojG
 MKBl4Cstx1ai+A4iEGXieg=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
 by zwqz-smtp-mta-g2-4 (Coremail) with SMTP id _____wBHZiep+CVluP_jAA--.11044S4;
 Wed, 11 Oct 2023 09:21:54 +0800 (CST)
From: Ma Ke <make_ruc2021@163.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, daniel@ffwll.ch
Subject: [PATCH] drm/radeon: fix a possible null pointer dereference
Date: Wed, 11 Oct 2023 09:21:43 +0800
Message-Id: <20231011012143.4091532-1-make_ruc2021@163.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wBHZiep+CVluP_jAA--.11044S4
X-Coremail-Antispam: 1Uf129KBjvdXoWruryxAF1xKr4fJr13WFW7Arb_yoWDWrg_WF
 ykXa9rXa90vas5AF1UZFn7Jr9F9rW8ZFWkJw1fta4S9397tF1xCFW3GFWYv3y3Xay5AF98
 Aw4rKr13CF4xKjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRKpBTDUUUUU==
X-Originating-IP: [183.174.60.14]
X-CM-SenderInfo: 5pdnvshuxfjiisr6il2tof0z/xtbBFQUFC2B9odECqQABsZ
X-Mailman-Approved-At: Wed, 11 Oct 2023 07:26:05 +0000
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
Cc: Ma Ke <make_ruc2021@163.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In radeon_tv_get_modes(), the return value of drm_cvt_mode()
is assigned to mode, which will lead to a NULL pointer
dereference on failure of drm_cvt_mode(). Add a check to
avoid null point dereference.

Signed-off-by: Ma Ke <make_ruc2021@163.com>
---
 drivers/gpu/drm/radeon/radeon_connectors.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/radeon/radeon_connectors.c b/drivers/gpu/drm/radeon/radeon_connectors.c
index d2f02c3dfce2..b84b58926106 100644
--- a/drivers/gpu/drm/radeon/radeon_connectors.c
+++ b/drivers/gpu/drm/radeon/radeon_connectors.c
@@ -1119,6 +1119,8 @@ static int radeon_tv_get_modes(struct drm_connector *connector)
 	else {
 		/* only 800x600 is supported right now on pre-avivo chips */
 		tv_mode = drm_cvt_mode(dev, 800, 600, 60, false, false, false);
+		if (!tv_mode)
+			return 0;
 		tv_mode->type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED;
 		drm_mode_probed_add(connector, tv_mode);
 	}
-- 
2.37.2

