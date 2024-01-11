Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 218E5C47DA2
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jan 2024 14:03:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33FE010E91E;
	Thu, 11 Jan 2024 14:03:32 +0000 (UTC)
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.7])
 by gabe.freedesktop.org (Postfix) with ESMTP id 9567910E86D;
 Thu, 11 Jan 2024 09:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=From:Subject:Date:Message-Id; bh=4RnQa9j8lJke799FaJ
 Yqbse5UEFE3lI4nXdUQ6qOVAY=; b=qTnRWg+GKk2jAeGytCptI2ieD19igLkIbJ
 q8/5xVdHETzpS+PcAocI1L0GbhZdbaDBjlA61bx8V7BKvGSPdeCnaAcX7wMsPpgO
 s9zDXrzRie8oOgF/2SuzY2EzxsfvEHPu99APSKeVZbTFshjX+Pmk8Ywxp99hpnQi
 bwoGhkbn4=
Received: from localhost.localdomain (unknown [182.148.14.173])
 by gzga-smtp-mta-g1-3 (Coremail) with SMTP id _____wD3f9M7tp9le8c2AA--.42261S2;
 Thu, 11 Jan 2024 17:34:51 +0800 (CST)
From: XueBing Chen <chenxb_99091@126.com>
To: daniel@ffwll.ch, Xinhui.Pan@amd.com, alexander.deucher@amd.com,
 airlied@gmail.com, christian.koenig@amd.com
Subject: [PATCH] drm/radeon: Clean up errors in radeon.h
Date: Thu, 11 Jan 2024 09:34:50 +0000
Message-Id: <20240111093450.14174-1-chenxb_99091@126.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: _____wD3f9M7tp9le8c2AA--.42261S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtF1kKrWDGw1kWFy3Kry7trb_yoW3ZFb_Cw
 10q3y7XayvgFnaqFnxuF1UuFZ0kw409r48Cw1xtryftry7Xr1fZF9xGF1UXw45JayfXFn8
 Aw4kXFy3GrsagjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRRt8nDUUUUU==
X-Originating-IP: [182.148.14.173]
X-CM-SenderInfo: hfkh05lebzmiizr6ij2wof0z/1tbiGBJixWVLZWlesAABsg
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

ERROR: open brace '{' following struct go on the same line

Signed-off-by: XueBing Chen <chenxb_99091@126.com>
---
 drivers/gpu/drm/radeon/radeon.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon.h b/drivers/gpu/drm/radeon/radeon.h
index 3d3d2109dfeb..3e5ff17e3caf 100644
--- a/drivers/gpu/drm/radeon/radeon.h
+++ b/drivers/gpu/drm/radeon/radeon.h
@@ -1355,14 +1355,12 @@ struct radeon_dpm_thermal {
 	bool               high_to_low;
 };
 
-enum radeon_clk_action
-{
+enum radeon_clk_action {
 	RADEON_SCLK_UP = 1,
 	RADEON_SCLK_DOWN
 };
 
-struct radeon_blacklist_clocks
-{
+struct radeon_blacklist_clocks {
 	u32 sclk;
 	u32 mclk;
 	enum radeon_clk_action action;
-- 
2.17.1

