Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9011FC5472C
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Aug 2024 07:42:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54BF410EC2F;
	Fri, 23 Aug 2024 07:42:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Sw2A2xgz";
	dkim-atps=neutral
X-Greylist: delayed 303 seconds by postgrey-1.36 at gabe;
 Fri, 23 Aug 2024 00:40:23 UTC
Received: from out30-112.freemail.mail.aliyun.com
 (out30-112.freemail.mail.aliyun.com [115.124.30.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F9B110EBF6;
 Fri, 23 Aug 2024 00:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1724373621; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=JZ+Jb+HK5jzvd/d+WSjQLa2+SibX5DcDHdq7Wfdl5ac=;
 b=Sw2A2xgzwjDUIlt3PbjTNn2IK9olISfyjUufTnnyIHFOjBRG2N18HqHkz0iYuVgHcKsUWN4kdj1AXvC4b2Kv6uAfTU9ZLS6tfiR0ZTbnsDUsPqgYVY3zUA7iOvmmjsQAv1t+McAjVKbNejvNRD+MHL+e42apFz9ILVk6ofUtU2U=
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com
 fp:SMTPD_---0WDRYTIY_1724373316) by smtp.aliyun-inc.com;
 Fri, 23 Aug 2024 08:35:17 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: airlied@gmail.com,
	daniel@ffwll.ch,
	alexander.deucher@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
 Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] drm/amd/display: Remove unnecessary semicolon after
 switch statement
Date: Fri, 23 Aug 2024 08:35:15 +0800
Message-Id: <20240823003515.57035-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 23 Aug 2024 07:42:15 +0000
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

This commit removes the unnecessary semicolon (`;`) following the
closing brace of the switch statement in the function
'dml2_core_utils_get_tile_block_size_bytes'.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=9804
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 .../amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_utils.c   | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_utils.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_utils.c
index ab229e1598ae..695fe99e44d2 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_utils.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_utils.c
@@ -310,7 +310,7 @@ unsigned int dml2_core_utils_get_tile_block_size_bytes(enum dml2_swizzle_mode sw
 	default:
 		DML2_ASSERT(0);
 		return 256;
-	};
+	}
 }
 
 
-- 
2.32.0.3.g01195cf9f

