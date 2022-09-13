Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F172C6FA82
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Sep 2022 12:46:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B13BA10E6ED;
	Tue, 13 Sep 2022 12:46:55 +0000 (UTC)
Received: from out30-131.freemail.mail.aliyun.com
 (out30-131.freemail.mail.aliyun.com [115.124.30.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C14510E64B;
 Tue, 13 Sep 2022 08:38:45 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R121e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046050;
 MF=jiapeng.chong@linux.alibaba.com; NM=1; PH=DS; RN=10; SR=0;
 TI=SMTPD_---0VPem1pz_1663058320; 
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com
 fp:SMTPD_---0VPem1pz_1663058320) by smtp.aliyun-inc.com;
 Tue, 13 Sep 2022 16:38:42 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: alexander.deucher@amd.com
Subject: [PATCH 5/5] drm/amd/display: Remove the unused function
 copy_stream_update_to_stream()
Date: Tue, 13 Sep 2022 16:38:05 +0800
Message-Id: <20220913083805.22549-5-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
In-Reply-To: <20220913083805.22549-1-jiapeng.chong@linux.alibaba.com>
References: <20220913083805.22549-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 13 Sep 2022 12:46:43 +0000
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
Cc: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, airlied@linux.ie,
 Xinhui.Pan@amd.com, Abaci Robot <abaci@linux.alibaba.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, daniel@ffwll.ch, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The function copy_stream_update_to_stream() is defined in the notif.c
file, but not called elsewhere, so delete this unused function.

drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:2852:6: warning: no previous prototype for ‘dc_reset_state’.

Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=2113
Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 9860bf38c547..2ee0b5a2ce62 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2849,16 +2849,6 @@ static void copy_stream_update_to_stream(struct dc *dc,
 	}
 }
 
-void dc_reset_state(struct dc *dc, struct dc_state *context)
-{
-	dc_resource_state_destruct(context);
-
-	/* clear the structure, but don't reset the reference count */
-	memset(context, 0, offsetof(struct dc_state, refcount));
-
-	init_state(dc, context);
-}
-
 static bool update_planes_and_stream_state(struct dc *dc,
 		struct dc_surface_update *srf_updates, int surface_count,
 		struct dc_stream_state *stream,
-- 
2.20.1.7.g153144c

