Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1799DC47077
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jan 2024 09:05:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7F5C10E8BE;
	Thu, 11 Jan 2024 09:05:14 +0000 (UTC)
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
 by gabe.freedesktop.org (Postfix) with ESMTP id 8B8DE10E362;
 Thu, 11 Jan 2024 08:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id; bh=yIzZtNZgUk+hSg+LRm
 vyXhs5mkbZ/NoO0/JblU6W9xQ=; b=pR+FxTnYzQfJ26kf7/SYkr44nWiV0torxa
 S24RKhmDyBfnUeC9FVTisuJqbJOyFvcoYE2H/H1nSHATAZ7knm3gQUnERlCQ3Ry7
 YiTrQe/LYBXmWAXjuExiRdNE0H7jaLl29tI5gyvAODd7Z+mRGYANZkcAPXdodJxF
 WJHnO2hJg=
Received: from localhost.localdomain (unknown [182.148.14.173])
 by gzga-smtp-mta-g0-1 (Coremail) with SMTP id _____wDnjxEVpJ9lJ0sRAA--.4258S2; 
 Thu, 11 Jan 2024 16:17:25 +0800 (CST)
From: GuoHua Chen <chenguohua_716@163.com>
To: daniel@ffwll.ch, Xinhui.Pan@amd.com, airlied@gmail.com,
 christian.koenig@amd.com, alexander.deucher@amd.com
Subject: [PATCH] drm/radeon: Clean up errors in rv6xx_dpm.h
Date: Thu, 11 Jan 2024 08:17:24 +0000
Message-Id: <20240111081724.11578-1-chenguohua_716@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: _____wDnjxEVpJ9lJ0sRAA--.4258S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKFWDZrWxuFy5Kry8JFWfuFg_yoWfWFb_Gr
 n7Xa93CrW7uryv9F1xArsIyrWIv398uFs3G3W8KF43J347X3WxZ3srZF9rX345JF4xAFn7
 Ka1vgFyfCrs3WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUj2YLDUUUUU==
X-Originating-IP: [182.148.14.173]
X-CM-SenderInfo: xfkh0w5xrk3tbbxrlqqrwthudrp/1tbiqBZi1mVOBlBo9wAAso
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

ERROR: that open brace { should be on the previous line

Signed-off-by: GuoHua Chen <chenguohua_716@163.com>
---
 drivers/gpu/drm/radeon/atombios_crtc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/radeon/atombios_crtc.c b/drivers/gpu/drm/radeon/atombios_crtc.c
index ade13173921b..ecebebe2e7a6 100644
--- a/drivers/gpu/drm/radeon/atombios_crtc.c
+++ b/drivers/gpu/drm/radeon/atombios_crtc.c
@@ -213,8 +213,7 @@ static void atombios_enable_crtc_memreq(struct drm_crtc *crtc, int state)
 	atom_execute_table(rdev->mode_info.atom_context, index, (uint32_t *)&args);
 }
 
-static const u32 vga_control_regs[6] =
-{
+static const u32 vga_control_regs[6] = {
 	AVIVO_D1VGA_CONTROL,
 	AVIVO_D2VGA_CONTROL,
 	EVERGREEN_D3VGA_CONTROL,
-- 
2.17.1

