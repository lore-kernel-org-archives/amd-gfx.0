Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEE1CC30659
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jul 2024 14:15:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56CEB10E436;
	Mon,  1 Jul 2024 14:15:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="F8OZ1+dY";
	dkim-atps=neutral
Received: from out30-101.freemail.mail.aliyun.com
 (out30-101.freemail.mail.aliyun.com [115.124.30.101])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4806010E334;
 Mon,  1 Jul 2024 07:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1719817509; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=m5DOnA77mYO9Kov/acwk1k0qy5fyuGvG+StfdsLm5OQ=;
 b=F8OZ1+dYUjO9zNAbGgST1Km338UdtzdbuPCiY2AtwOktzptoEPCfXwB2JxrCjRMr3mZuT0NsrB+3Y9VUQqXai5q1TVlL8A+7dv5Q4KnbpMAeMwq35g/aApIxReeSFok2BsPO6NASOblJZn1vxSqQxY1pwggOcUfVw18J1lGDIQU=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R121e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037067111;
 MF=jiapeng.chong@linux.alibaba.com; NM=1; PH=DS; RN=13; SR=0;
 TI=SMTPD_---0W9b27uN_1719817507; 
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com
 fp:SMTPD_---0W9b27uN_1719817507) by smtp.aliyun-inc.com;
 Mon, 01 Jul 2024 15:05:09 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: harry.wentland@amd.com
Cc: sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
 daniel@ffwll.ch, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
 Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH 2/4] drm/amd/display: Fix warning comparing pointer to 0
Date: Mon,  1 Jul 2024 15:04:53 +0800
Message-Id: <20240701070454.106083-3-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
In-Reply-To: <20240701070454.106083-1-jiapeng.chong@linux.alibaba.com>
References: <20240701070454.106083-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 01 Jul 2024 14:15:48 +0000
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

Avoid pointer type value compared with 0 to make code clear.

./drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_mcg/dml2_mcg_factory.c:19:12-13: WARNING comparing pointer to 0.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=9458
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 .../amd/display/dc/dml2/dml21/src/dml2_mcg/dml2_mcg_factory.c   | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_mcg/dml2_mcg_factory.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_mcg/dml2_mcg_factory.c
index ce83c10253a2..55085b85f8ed 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_mcg/dml2_mcg_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_mcg/dml2_mcg_factory.c
@@ -16,7 +16,7 @@ bool dml2_mcg_create(enum dml2_project_id project_id, struct dml2_mcg_instance *
 {
 	bool result = false;
 
-	if (out == 0)
+	if (!out)
 		return false;
 
 	memset(out, 0, sizeof(struct dml2_mcg_instance));
-- 
2.20.1.7.g153144c

