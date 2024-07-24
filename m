Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B6FEC3DA63
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jul 2024 12:57:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35F9510E6B6;
	Wed, 24 Jul 2024 12:57:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="h7XeOrRh";
	dkim-atps=neutral
Received: from out30-99.freemail.mail.aliyun.com
 (out30-99.freemail.mail.aliyun.com [115.124.30.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDB9F10E03A;
 Wed, 24 Jul 2024 07:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1721806680; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=rAGYYc4I8IT8kc2kTezhDQbo9h4T2Gzxv5TX4WM92Cc=;
 b=h7XeOrRhSeH1vbwE0H7ADL3Z+qv9fWqZxS1VJoczW9qCf9HDZOiC9+HtKh036TyJ9gQwPtVRXNQ8g9IjAKcWUW2NBxkVBYG9+qK3sltq/oP9ID74iU4A3M6/4qUtk7RJjUrl142DCZagfJ7HRe32Yn5gWA7vMW2QcpyC+2cqVjQ=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R491e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037067113;
 MF=jiapeng.chong@linux.alibaba.com; NM=1; PH=DS; RN=13; SR=0;
 TI=SMTPD_---0WBDLO5j_1721806670; 
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com
 fp:SMTPD_---0WBDLO5j_1721806670) by smtp.aliyun-inc.com;
 Wed, 24 Jul 2024 15:37:59 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: harry.wentland@amd.com
Cc: sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
 daniel@ffwll.ch, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
 Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] drm/amd/display: use swap() in sort()
Date: Wed, 24 Jul 2024 15:37:49 +0800
Message-Id: <20240724073749.14338-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 24 Jul 2024 12:56:51 +0000
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

Use existing swap() function rather than duplicating its implementation.

./drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn3.c:17:29-30: WARNING opportunity for swap().

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=9573
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 .../display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn3.c    | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn3.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn3.c
index 717536d7bb30..8e68a8094658 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn3.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn3.c
@@ -7,16 +7,12 @@
 
 static void sort(double *list_a, int list_a_size)
 {
-	double temp;
 	// For all elements b[i] in list_b[]
 	for (int i = 0; i < list_a_size - 1; i++) {
 		// Find the first element of list_a that's larger than b[i]
 		for (int j = i; j < list_a_size - 1; j++) {
-			if (list_a[j] > list_a[j + 1]) {
-				temp = list_a[j];
-				list_a[j] = list_a[j + 1];
-				list_a[j + 1] = temp;
-			}
+			if (list_a[j] > list_a[j + 1])
+				swap(list_a[j], list_a[j + 1]);
 		}
 	}
 }
-- 
2.32.0.3.g01195cf9f

