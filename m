Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66DF9C47258
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jan 2024 14:03:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D3C610E90E;
	Thu, 11 Jan 2024 14:03:32 +0000 (UTC)
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
 by gabe.freedesktop.org (Postfix) with ESMTP id DA97310E802;
 Thu, 11 Jan 2024 09:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=From:Subject:Date:Message-Id; bh=wD5zN4hzyUEjpnUjnj
 XzVLQvtOsmM60ckERcp/meCTE=; b=obw9noa5m3ceEvV/dm96uUjOYmOkLrX7u1
 8eE8ejHpiWDq7t3c0o/2kdHVvjvj0TS5iQydy5JgBKn4I7FUVzzYuMUC2sN9Rgaz
 MuUaiNNaX2Xb9vVhpWnwyCgCpaUHwJCu9aa1r1U3z8H/r7vv0zO+09Thnd+l7WR4
 uimyom1SA=
Received: from localhost.localdomain (unknown [182.148.14.173])
 by gzga-smtp-mta-g0-4 (Coremail) with SMTP id _____wDXH3gps59lddWkAA--.12795S2;
 Thu, 11 Jan 2024 17:21:45 +0800 (CST)
From: XueBing Chen <chenxb_99091@126.com>
To: daniel@ffwll.ch, Xinhui.Pan@amd.com, alexander.deucher@amd.com,
 airlied@gmail.com, christian.koenig@amd.com
Subject: [PATCH] drm/radeon: Clean up errors in clearstate_ci.h
Date: Thu, 11 Jan 2024 09:21:43 +0000
Message-Id: <20240111092143.13739-1-chenxb_99091@126.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: _____wDXH3gps59lddWkAA--.12795S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKFWDZrWxuFyUWF4xCrWxWFg_yoW3ZrX_Cw
 48J397WrW2vF9xX3W3Ar4rXFWv9r45uanru3Wvva4fCr17Zrs5ua43ury5Xw15XFs8JF1D
 Aw4rXFnxCrn2gjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRR_OzPUUUUU==
X-Originating-IP: [182.148.14.173]
X-CM-SenderInfo: hfkh05lebzmiizr6ij2wof0z/1tbiHBRixWV2z0TRLgABsJ
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

ERROR: that open brace { should be on the previous line

Signed-off-by: XueBing Chen <chenxb_99091@126.com>
---
 drivers/gpu/drm/radeon/clearstate_ci.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/radeon/clearstate_ci.h b/drivers/gpu/drm/radeon/clearstate_ci.h
index c1b6c22dbed7..0045d42aa27c 100644
--- a/drivers/gpu/drm/radeon/clearstate_ci.h
+++ b/drivers/gpu/drm/radeon/clearstate_ci.h
@@ -23,8 +23,7 @@
 
 #include "clearstate_defs.h"
 
-static const unsigned int ci_SECT_CONTEXT_def_1[] =
-{
+static const unsigned int ci_SECT_CONTEXT_def_1[] = {
     0x00000000, // DB_RENDER_CONTROL
     0x00000000, // DB_COUNT_CONTROL
     0x00000000, // DB_DEPTH_VIEW
-- 
2.17.1

