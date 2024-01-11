Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BE45C4707B
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jan 2024 09:04:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6330510E87E;
	Thu, 11 Jan 2024 09:04:26 +0000 (UTC)
Received: from m16.mail.163.com (m15.mail.163.com [45.254.50.220])
 by gabe.freedesktop.org (Postfix) with ESMTP id 0103610E18A;
 Thu, 11 Jan 2024 08:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id; bh=GbOAo++7oysYIAnWef
 V3Jn+5qb8czDoPosnXjp6SIEM=; b=QfemAd+L8FqnQ1bjDeYAB6DSoS8SBadTeh
 cHqOcyBHhilHX/unh86Au+adIkLgmXDSwOKuBYGX5aTsnNHYyxunsgouiCaTzAgl
 o+mJUx8eq9REF7XsxURVnvLQZOFwbN3hHQXjSALI9U2+UzeS8oI1qCrdxxBQ/gFa
 3FVfpj7gI=
Received: from localhost.localdomain (unknown [182.148.14.173])
 by gzga-smtp-mta-g0-1 (Coremail) with SMTP id _____wD331Q2op9lFNkQAA--.1687S2; 
 Thu, 11 Jan 2024 16:09:27 +0800 (CST)
From: GuoHua Chen <chenguohua_716@163.com>
To: daniel@ffwll.ch, Xinhui.Pan@amd.com, airlied@gmail.com,
 christian.koenig@amd.com, alexander.deucher@amd.com
Subject: [PATCH] drm/radeon/dpm: Clean up errors in trinity_dpm.h
Date: Thu, 11 Jan 2024 08:09:23 +0000
Message-Id: <20240111080923.11317-1-chenguohua_716@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: _____wD331Q2op9lFNkQAA--.1687S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtF1kXF13tr13WFyDWFWDtwb_yoWxKFg_C3
 4UX3yDXrW2kFn5uF18AFsxAryIva1FvF48Cr1ft348Jry2vr1fuayv9r9rXayUGFn3ZFn8
 Aa1kXrs3ZFsrXjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUUtC7UUUUUU==
X-Originating-IP: [182.148.14.173]
X-CM-SenderInfo: xfkh0w5xrk3tbbxrlqqrwthudrp/xtbBEBti1mVOBk9XvwAAs1
X-Mailman-Approved-At: Thu, 11 Jan 2024 09:04:25 +0000
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
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, GuoHua Chen <chenguohua_716@163.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix the following errors reported by checkpatch:

ERROR: open brace '{' following struct go on the same line

Signed-off-by: GuoHua Chen <chenguohua_716@163.com>
---
 drivers/gpu/drm/radeon/trinity_dpm.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/radeon/trinity_dpm.h b/drivers/gpu/drm/radeon/trinity_dpm.h
index c261657750ca..431e2b68d21e 100644
--- a/drivers/gpu/drm/radeon/trinity_dpm.h
+++ b/drivers/gpu/drm/radeon/trinity_dpm.h
@@ -64,8 +64,7 @@ struct trinity_ps {
 
 #define TRINITY_NUM_NBPSTATES   4
 
-struct trinity_uvd_clock_table_entry
-{
+struct trinity_uvd_clock_table_entry {
 	u32 vclk;
 	u32 dclk;
 	u8 vclk_did;
-- 
2.17.1

