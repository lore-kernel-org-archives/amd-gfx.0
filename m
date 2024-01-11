Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78433C47422
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jan 2024 14:03:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF61810E919;
	Thu, 11 Jan 2024 14:03:32 +0000 (UTC)
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
 by gabe.freedesktop.org (Postfix) with ESMTP id 058D410E80C;
 Thu, 11 Jan 2024 09:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=From:Subject:Date:Message-Id; bh=grwVG+AmXoGKqTy2la
 H8uBXIiMvnlbZHKoSxHFDFIx0=; b=Kxd6mT6ou2yDWT6nJzl+KbGQfofmaClbZ1
 rgXuVFC6Jd9CPH29TccLw5ksGML03L33ll7Vpixj9IFCLUPoMJA509LfUquo4eZr
 FxLXCrmdDdHtz8OLvBZuTVwECMEaNvNpfwB/xH/H1EXX0Er20GZ9MIWlO1k2+Aab
 0RzY955jA=
Received: from localhost.localdomain (unknown [182.148.14.173])
 by gzga-smtp-mta-g1-3 (Coremail) with SMTP id _____wD3H7l_t59l0N42AA--.10079S2;
 Thu, 11 Jan 2024 17:40:15 +0800 (CST)
From: XueBing Chen <chenxb_99091@126.com>
To: daniel@ffwll.ch, Xinhui.Pan@amd.com, alexander.deucher@amd.com,
 airlied@gmail.com, christian.koenig@amd.com
Subject: [PATCH] drm/radeon/evergreen_cs: Clean up errors in evergreen_cs.c
Date: Thu, 11 Jan 2024 09:40:13 +0000
Message-Id: <20240111094013.14347-1-chenxb_99091@126.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: _____wD3H7l_t59l0N42AA--.10079S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7XF1fZFWDGw45tF48GrWrAFb_yoWftrX_Cr
 4rX3s8X3sru3ZFkF1xZF48WFWvkFW5ZrW8Cayfta4fGry5AF10grWS9ryFqw45W3WUJFZ5
 Aw4kWFW3Xr97WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRioUq5UUUUU==
X-Originating-IP: [182.148.14.173]
X-CM-SenderInfo: hfkh05lebzmiizr6ij2wof0z/1tbiHB1ixWV2z0UUrQAAsG
X-Mailman-Approved-At: Thu, 11 Jan 2024 14:03:28 +0000
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
Cc: XueBing Chen <chenxb_99091@126.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix the following errors reported by checkpatch:

ERROR: space required after that ',' (ctx:VxV)
ERROR: spaces required around that '>' (ctx:VxV)
ERROR: spaces required around that '<' (ctx:VxV)

Signed-off-by: XueBing Chen <chenxb_99091@126.com>
---
 drivers/gpu/drm/radeon/evergreen_cs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/radeon/evergreen_cs.c b/drivers/gpu/drm/radeon/evergreen_cs.c
index 0de79f3a7e3f..1fe6e0d883c7 100644
--- a/drivers/gpu/drm/radeon/evergreen_cs.c
+++ b/drivers/gpu/drm/radeon/evergreen_cs.c
@@ -33,8 +33,8 @@
 #include "evergreen_reg_safe.h"
 #include "cayman_reg_safe.h"
 
-#define MAX(a,b)                   (((a)>(b))?(a):(b))
-#define MIN(a,b)                   (((a)<(b))?(a):(b))
+#define MAX(a, b)                   (((a) > (b)) ? (a) : (b))
+#define MIN(a, b)                   (((a) < (b)) ? (a) : (b))
 
 #define REG_SAFE_BM_SIZE ARRAY_SIZE(evergreen_reg_safe_bm)
 
-- 
2.17.1

