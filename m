Return-Path: <SRS0=jhpT=HR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14EF8C433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Feb 2021 14:54:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B54A164DEE
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Feb 2021 14:54:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B54A164DEE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 602AB89FA5;
	Mon, 15 Feb 2021 14:54:27 +0000 (UTC)
X-Greylist: delayed 1010 seconds by postgrey-1.36 at gabe;
 Mon, 15 Feb 2021 10:39:29 UTC
Received: from m12-11.163.com (m12-11.163.com [220.181.12.11])
 by gabe.freedesktop.org (Postfix) with SMTP id C4DD689FAC;
 Mon, 15 Feb 2021 10:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id; bh=qILXK4GORBkA7fjOMr
 MyU72nwmgjVF7Si6pXWrVEMZU=; b=Nx1c/GJQpxF9wDcInVh27Undlz2HAywEjs
 HZjIn2kzhlrj2E/RUgocfdTUjExJyS769GRsCs4e/f9wbbwqt9e7SVen5T9bMQxg
 cH+d8B3VbJbdi8i70f11r+sZNTskBrDJqYVOreJys/r3rzT5AcCkwjgKLvowSs0c
 s95mB//So=
Received: from localhost.localdomain (unknown [125.70.196.55])
 by smtp7 (Coremail) with SMTP id C8CowACnI7Q8SypgiR08Nw--.5666S2;
 Mon, 15 Feb 2021 18:21:52 +0800 (CST)
From: Chen Lin <chen45464546@163.com>
To: airlied@linux.ie,
	daniel@ffwll.ch
Subject: [PATCH] drm/radeon: Remove unused function pointer typedef
 radeon_packet3_check_t
Date: Mon, 15 Feb 2021 18:21:29 +0800
Message-Id: <1613384489-3102-1-git-send-email-chen45464546@163.com>
X-Mailer: git-send-email 1.7.9.5
X-CM-TRANSID: C8CowACnI7Q8SypgiR08Nw--.5666S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKw1UZr4DuryxJw4DGw4rKrg_yoW3Wrc_Kr
 10q34aqa4kArs2q3W5uFsrJFyjkrW09r48Gw1Fqr93tayqqr1rZFySkr1xZrs8Aa1SgFnx
 J3ykXF13Aws3tjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0_ucJUUUUU==
X-Originating-IP: [125.70.196.55]
X-CM-SenderInfo: hfkh0kqvuwkkiuw6il2tof0z/1tbiXAA6nlXlytycbQAAsv
X-Mailman-Approved-At: Mon, 15 Feb 2021 14:54:26 +0000
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
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Chen Lin <chen.lin5@zte.com.cn>, amd-gfx@lists.freedesktop.org,
 alexander.deucher@amd.com, christian.koenig@amd.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Chen Lin <chen.lin5@zte.com.cn>

Remove the 'radeon_packet3_check_t' typedef as it is not used.

Signed-off-by: Chen Lin <chen.lin5@zte.com.cn>
---
 drivers/gpu/drm/radeon/radeon.h |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon.h b/drivers/gpu/drm/radeon/radeon.h
index 5f3adba..a1c38b5 100644
--- a/drivers/gpu/drm/radeon/radeon.h
+++ b/drivers/gpu/drm/radeon/radeon.h
@@ -1111,9 +1111,6 @@ struct radeon_cs_packet {
 typedef int (*radeon_packet0_check_t)(struct radeon_cs_parser *p,
 				      struct radeon_cs_packet *pkt,
 				      unsigned idx, unsigned reg);
-typedef int (*radeon_packet3_check_t)(struct radeon_cs_parser *p,
-				      struct radeon_cs_packet *pkt);
-
 
 /*
  * AGP
-- 
1.7.9.5

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
