Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D96E7C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Feb 2022 08:27:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92F9910E573;
	Tue,  8 Feb 2022 08:26:47 +0000 (UTC)
Received: from qq.com (smtpbg465.qq.com [59.36.132.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E474510E227;
 Tue,  8 Feb 2022 03:16:01 +0000 (UTC)
X-QQ-mid: bizesmtp5t1644290101twk3qzvo1
Received: from localhost.localdomain (unknown [58.240.82.166])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 08 Feb 2022 11:14:55 +0800 (CST)
X-QQ-SSF: 01400000002000B0G000B00A0000000
X-QQ-FEAT: JykYnMR+PRaregM+pIQhKrCVgehtTaXMsvfTUbZBq8GKqCGcWGTTX7/H02IY0
 Xny1+TYdI5N9onp89RFeBj7W2HlImuB/4IoErmVjLgtrwJTgNKSxyDNihuFgEpKWpzbv5bR
 Vxub8i3/Evxpe50Kb/Q7g+dtHYPsPiD+HDeuEAAVA8FeczBi+gziHPKcub94J8vSQvwEeQm
 i819Rfxt1S+Sv1tgFKqD/ry5UP8pRPJrWdzQUU4BGQpb/5ipMlZTZOs53G2sSTW6+P4Pb4X
 TNcJv7LkJcpk8xR/UdoWvUKJ0vJ7ABvV/M8t4c+ykCKXr+rRmoy8hD7LhmC3f6gV/7yBD4g
 FdjG1sx
X-QQ-GoodBg: 2
From: zhanglianjie <zhanglianjie@uniontech.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH v2 2/2] drm/radeon/uvd: Fix forgotten unmap buffer objects
Date: Tue,  8 Feb 2022 11:14:54 +0800
Message-Id: <20220208031454.24232-1-zhanglianjie@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign6
X-QQ-Bgrelay: 1
X-Mailman-Approved-At: Tue, 08 Feb 2022 08:26:44 +0000
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
Cc: David Airlie <airlied@linux.ie>, Xinhui.Pan@amd.com,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 zhanglianjie <zhanglianjie@uniontech.com>, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

after the buffer object is successfully mapped, call radeon_bo_kunmap before the function returns.

Signed-off-by: zhanglianjie <zhanglianjie@uniontech.com>

diff --git a/drivers/gpu/drm/radeon/radeon_uvd.c b/drivers/gpu/drm/radeon/radeon_uvd.c
index 377f9cdb5b53..0558d928d98d 100644
--- a/drivers/gpu/drm/radeon/radeon_uvd.c
+++ b/drivers/gpu/drm/radeon/radeon_uvd.c
@@ -497,6 +497,7 @@ static int radeon_uvd_cs_msg(struct radeon_cs_parser *p, struct radeon_bo *bo,
 	handle = msg[2];

 	if (handle == 0) {
+		radeon_bo_kunmap(bo);
 		DRM_ERROR("Invalid UVD handle!\n");
 		return -EINVAL;
 	}
@@ -559,12 +560,10 @@ static int radeon_uvd_cs_msg(struct radeon_cs_parser *p, struct radeon_bo *bo,
 		return 0;

 	default:
-
 		DRM_ERROR("Illegal UVD message type (%d)!\n", msg_type);
-		return -EINVAL;
 	}

-	BUG();
+	radeon_bo_kunmap(bo);
 	return -EINVAL;
 }

--
2.20.1



