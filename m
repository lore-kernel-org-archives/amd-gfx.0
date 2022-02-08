Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C686EC433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Feb 2022 08:26:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3C1610E26C;
	Tue,  8 Feb 2022 08:26:46 +0000 (UTC)
X-Greylist: delayed 16019 seconds by postgrey-1.36 at gabe;
 Tue, 08 Feb 2022 08:03:49 UTC
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C641D10E16C
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Feb 2022 08:03:49 +0000 (UTC)
X-QQ-mid: bizesmtp11t1644307407tplb3bxa
Received: from localhost.localdomain (unknown [58.240.82.166])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 08 Feb 2022 16:03:22 +0800 (CST)
X-QQ-SSF: 01400000002000B0H000B00A0000000
X-QQ-FEAT: FXvDfBZI5O4IwGAI4Arhf0Dt8rHM7FibgTP78zDJF6wrXhJ/JLYUvVyC1W7a1
 qRmp3/fmzDIVWYaBhbyc8lSBKamRQ5NTx+30u0DdfHrn3meV9adKtjly2GR2w1+juwcH2uK
 HtPitFRw4l5tS/AgwIXCFuXA4/BVyJyfpl9L56dsx662NTrOTjx6Y9J+nihms76pDBUc+aY
 ajXC9MjN+QmbR91xgW+SkkmSVWde44T5t4BYIO5koO7hZ8Z5sL5D0CypqA9AqXfSag9qKx7
 FCMfHK8gs8Sxe7Ofsja6yJAGXp1Bm7nuVC+I+tEOI5AlSUD2H8jNTTBhrR3dY+WZWVXqgg4
 rjaWYxRgUowaIjYHBR6dpVEMUDLlKXqsBGrqyAX
X-QQ-GoodBg: 2
From: zhanglianjie <zhanglianjie@uniontech.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH v3 2/2] drm/radeon/uvd: Fix forgotten unmap buffer objects
Date: Tue,  8 Feb 2022 16:03:20 +0800
Message-Id: <20220208080320.26484-1-zhanglianjie@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign5
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



