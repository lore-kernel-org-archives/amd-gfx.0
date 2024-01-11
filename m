Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79457C47DA2
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jan 2024 09:05:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1606110E8C7;
	Thu, 11 Jan 2024 09:05:16 +0000 (UTC)
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
 by gabe.freedesktop.org (Postfix) with ESMTP id C4EF710E7F3
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jan 2024 07:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id; bh=5T0AHkxZ0BUdC30HXl
 e6vf8EoCWrpjRutkeHm3gI4X8=; b=Hezbn2R0UcTrThAh2Y53WDMxRlrS4Z7jUm
 PJEwiMvDRuUhi/iLp4vhNX5WnV0nBRidvhWmd+pWEiQuy8us3OOtG++6Cd1iabJa
 fioOfn+nCQ1nwiVdIdSkmf+Y9uvWzPO3kBUkoRXSOS7Xn7S+ql6XqmQ2xpCRHxSG
 M/Vh1FJ/8=
Received: from localhost.localdomain (unknown [182.148.14.173])
 by gzga-smtp-mta-g0-4 (Coremail) with SMTP id _____wD3P5Dhmp9l+sqRAA--.14643S2;
 Thu, 11 Jan 2024 15:38:09 +0800 (CST)
From: GuoHua Chen <chenguohua_716@163.com>
To: daniel@ffwll.ch, Xinhui.Pan@amd.com, airlied@gmail.com,
 christian.koenig@amd.com, alexander.deucher@amd.com
Subject: [PATCH] drm/radeon/r100: Clean up errors in r100.c
Date: Thu, 11 Jan 2024 07:38:07 +0000
Message-Id: <20240111073807.10577-1-chenguohua_716@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: _____wD3P5Dhmp9l+sqRAA--.14643S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFy8tFWUGrWfWr48ZrW3Awb_yoW3ArcEgF
 18XFsFqas29F9IgF1j9FWvvryIvr45urs5Cr1Iya4fKF1xZryxZ3sak39xXws5Aa9IqFWD
 Jw4ktFy3ArsFgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUUtC7UUUUUU==
X-Originating-IP: [182.148.14.173]
X-CM-SenderInfo: xfkh0w5xrk3tbbxrlqqrwthudrp/xtbBEBpi1mVOBk6DhgADsb
X-Mailman-Approved-At: Thu, 11 Jan 2024 09:04:24 +0000
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

ERROR: spaces required around that '+=' (ctx:VxV)o

Signed-off-by: GuoHua Chen <chenguohua_716@163.com>
---
 drivers/gpu/drm/radeon/r100.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/r100.c b/drivers/gpu/drm/radeon/r100.c
index cfeca2694d5f..86b8b770af19 100644
--- a/drivers/gpu/drm/radeon/r100.c
+++ b/drivers/gpu/drm/radeon/r100.c
@@ -1327,7 +1327,7 @@ int r100_packet3_load_vbpntr(struct radeon_cs_parser *p,
 	    return -EINVAL;
 	}
 	track->num_arrays = c;
-	for (i = 0; i < (c - 1); i+=2, idx+=3) {
+	for (i = 0; i < (c - 1); i += 2, idx += 3) {
 		r = radeon_cs_packet_next_reloc(p, &reloc, 0);
 		if (r) {
 			DRM_ERROR("No reloc for packet3 %d\n",
-- 
2.17.1

