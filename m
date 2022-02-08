Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 716E4C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Feb 2022 08:27:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEC7210E595;
	Tue,  8 Feb 2022 08:26:48 +0000 (UTC)
X-Greylist: delayed 15949 seconds by postgrey-1.36 at gabe;
 Tue, 08 Feb 2022 08:03:05 UTC
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40F9C10E13A
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Feb 2022 08:03:05 +0000 (UTC)
X-QQ-mid: bizesmtp33t1644307361t10mqirs
Received: from localhost.localdomain (unknown [58.240.82.166])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 08 Feb 2022 16:02:37 +0800 (CST)
X-QQ-SSF: 00400000002000B0H000B00A0000000
X-QQ-FEAT: zD6y7hNAcUB0CO7eAtJeOBqOod74zZzxKc9Z5p7I4/HrPepLCfJzCWjdo72xF
 gQZlUSwaOM05cGmmj58PWwdBNEHju8GTAvTUnuOAqnawnSBQQMYzyUeUjy3u8Hc/rfjzBcL
 Ee66Z2FskkgLFReyfCgL4+rMBCxm9KMZrSNk8hvZ41FhZQ0j+bVPh9UTUNy/FWBVE2dgxje
 07ap/9lyPyQnGQFbHOEiOb5F3/yQNStKnYkbzIXteJpKJpLHB8R7et1eU0JMjAFmmes8im8
 uMqPeuvzCr6NOSWvkzw4/qtkAi8WX0oufIDctkJTwwcZOOY9Ao6bTUOu/VSREoQ2ZhODd8y
 FN2DwSkR/lqc2673+vk6htik4RUikaU+zjxdwhR
X-QQ-GoodBg: 2
From: zhanglianjie <zhanglianjie@uniontech.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH v3 2/2] drm/radeon/uvd: Fix forgotten unmap buffer objects
Date: Tue,  8 Feb 2022 16:02:35 +0800
Message-Id: <20220208080235.26349-1-zhanglianjie@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign2
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
Cc: David Airlie <airlied@linux.ie>, PanXinhui <Xinhui.Pan@amd.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 zhanglianjie <zhanglianjie@uniontech.com>, amd-gfx@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

after the buffer object is successfully mapped, call radeon_bo_kunmap before the function returns.

Signed-off-by: zhanglianjie <zhanglianjie@uniontech.com>
Reviewed-by: Christian König <christian.koenig@amd.com>

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



