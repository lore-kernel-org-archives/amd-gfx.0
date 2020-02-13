Return-Path: <SRS0=YeOH=4B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FF99C3B189
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Feb 2020 15:53:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71B5D217F4
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Feb 2020 15:53:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="BjoOjoPD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71B5D217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 364156E34C;
	Thu, 13 Feb 2020 15:53:57 +0000 (UTC)
Received: from condef-10.nifty.com (condef-10.nifty.com [202.248.20.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4B796E34C;
 Thu, 13 Feb 2020 15:53:55 +0000 (UTC)
Received: from conuserg-08.nifty.com ([10.126.8.71])by condef-10.nifty.com
 with ESMTP id 01DFegoi008347; Fri, 14 Feb 2020 00:40:43 +0900
Received: from grover.flets-west.jp (softbank126093102113.bbtec.net
 [126.93.102.113]) (authenticated)
 by conuserg-08.nifty.com with ESMTP id 01DFdZHY005809;
 Fri, 14 Feb 2020 00:39:39 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 01DFdZHY005809
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1581608379;
 bh=mUXWSCOUhmEqCqZ+TwM1+NYP6yh2Anh0WoMXN2qQ3Co=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=BjoOjoPDyjlxgE30NXzuz2035Uk/UrfOBulP31p7kYSGDl0fDCvGDT6Ta5pYhtzJP
 X5m4LllyJfotrdVbuyp/oio2EbEP1ABXpKQUaR19zjHrsMvpSemmcqi9Id1VCSm3W4
 VWcyYisjaAsi5lCpfHcNaAjlxO1uKsGDBxV2d7pDk6zReCaqAREj6yq+5izqvS6upq
 Sie9lX9l+gSP439Q2zyk4imA+XOGMhRrreyhRhZPF8ydWS1rE+UT12jAkcjUqe7hol
 LYRVf2NVA/B7XHERPhoNwAB3SQqfEsKulmJTR35gp3cf0E/scVM9XTS8eL0bMWIe2l
 mA6VHKdSbBRNg==
X-Nifty-SrcIP: [126.93.102.113]
From: Masahiro Yamada <masahiroy@kernel.org>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=8F=AB=D3nig?= <christian.koenig@amd.com>,
 David Zhou <David1.Zhou@amd.com>, amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/4] drm/radeon: align short build log
Date: Fri, 14 Feb 2020 00:39:27 +0900
Message-Id: <20200213153928.28407-4-masahiroy@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200213153928.28407-1-masahiroy@kernel.org>
References: <20200213153928.28407-1-masahiroy@kernel.org>
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
Cc: David Airlie <airlied@linux.ie>, Masahiro Yamada <masahiroy@kernel.org>,
 dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This beautifies the build log.

[Before]

  HOSTCC  drivers/gpu/drm/radeon/mkregtable
  MKREGTABLE drivers/gpu/drm/radeon/r100_reg_safe.h
  MKREGTABLE drivers/gpu/drm/radeon/rn50_reg_safe.h
  CC [M]  drivers/gpu/drm/radeon/r100.o
  MKREGTABLE drivers/gpu/drm/radeon/r300_reg_safe.h
  CC [M]  drivers/gpu/drm/radeon/r300.o

[After]

  HOSTCC  drivers/gpu/drm/radeon/mkregtable
  MKREG   drivers/gpu/drm/radeon/r100_reg_safe.h
  MKREG   drivers/gpu/drm/radeon/rn50_reg_safe.h
  CC [M]  drivers/gpu/drm/radeon/r100.o
  MKREG   drivers/gpu/drm/radeon/r300_reg_safe.h
  CC [M]  drivers/gpu/drm/radeon/r300.o

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 drivers/gpu/drm/radeon/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/Makefile b/drivers/gpu/drm/radeon/Makefile
index 480a8d4a3c82..11c97edde54d 100644
--- a/drivers/gpu/drm/radeon/Makefile
+++ b/drivers/gpu/drm/radeon/Makefile
@@ -6,7 +6,7 @@
 hostprogs := mkregtable
 targets := rn50_reg_safe.h r100_reg_safe.h r200_reg_safe.h rv515_reg_safe.h r300_reg_safe.h r420_reg_safe.h rs600_reg_safe.h r600_reg_safe.h evergreen_reg_safe.h cayman_reg_safe.h
 
-quiet_cmd_mkregtable = MKREGTABLE $@
+quiet_cmd_mkregtable = MKREG   $@
       cmd_mkregtable = $(obj)/mkregtable $< > $@
 
 $(obj)/%_reg_safe.h: $(src)/reg_srcs/% $(obj)/mkregtable FORCE
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
