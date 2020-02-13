Return-Path: <SRS0=YeOH=4B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24BEFC3F68F
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Feb 2020 15:51:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC44424649
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Feb 2020 15:51:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="HsBBbauo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC44424649
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9EFE6E34E;
	Thu, 13 Feb 2020 15:51:25 +0000 (UTC)
Received: from condef-05.nifty.com (condef-05.nifty.com [202.248.20.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9648C6E34C;
 Thu, 13 Feb 2020 15:51:23 +0000 (UTC)
Received: from conuserg-08.nifty.com ([10.126.8.71])by condef-05.nifty.com
 with ESMTP id 01DFeg6Q004079; Fri, 14 Feb 2020 00:40:43 +0900
Received: from grover.flets-west.jp (softbank126093102113.bbtec.net
 [126.93.102.113]) (authenticated)
 by conuserg-08.nifty.com with ESMTP id 01DFdZHW005809;
 Fri, 14 Feb 2020 00:39:37 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 01DFdZHW005809
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1581608377;
 bh=CfJCXYbZyd9BrXzzHCGYQJ2nq7lm/XIX9LdBbFyn7y0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=HsBBbauoUybEtrfn3+2H3+F41G0+jLVrnwKEsgjcE45ITaP0X56kk+pfz0PvDxtp0
 C7BqfP6FkxlOTo5PpU0Dbl5q0YcA7mayQ1npkdr7HLjzJ8m1PXwv8TBMoEFgcSHuvl
 hn1hVn/1fEw/XnOSdsG1bMd34N1CrefL5TKMo1LamM1ILdJG0nANYBx4oEtVHCKfmY
 oWHC4Oq9MyB0sOfEgOB15ADba8/ZFXSEwami3fhbGycBki9yzERT+iN2Nb7ZH7OW7w
 z8eKE/t7QLxGqAYV/doWA8/I5Yg+IYhThyO/bWGFLv7tX8LJYOs2qMuno1xRa0vd7W
 oAAbFf/RfEe+Q==
X-Nifty-SrcIP: [126.93.102.113]
From: Masahiro Yamada <masahiroy@kernel.org>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=8F=AB=D3nig?= <christian.koenig@amd.com>,
 David Zhou <David1.Zhou@amd.com>, amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/4] drm/radeon: fix build rules of *_reg_safe.h
Date: Fri, 14 Feb 2020 00:39:25 +0900
Message-Id: <20200213153928.28407-2-masahiroy@kernel.org>
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

if_changed must have FORCE as a prerequisite, and the targets must be
added to 'targets'.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 drivers/gpu/drm/radeon/Makefile | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/radeon/Makefile b/drivers/gpu/drm/radeon/Makefile
index 9d5d3dc1011f..fda115cefe4d 100644
--- a/drivers/gpu/drm/radeon/Makefile
+++ b/drivers/gpu/drm/radeon/Makefile
@@ -4,39 +4,39 @@
 # Direct Rendering Infrastructure (DRI) in XFree86 4.1.0 and higher.
 
 hostprogs := mkregtable
-clean-files := rn50_reg_safe.h r100_reg_safe.h r200_reg_safe.h rv515_reg_safe.h r300_reg_safe.h r420_reg_safe.h rs600_reg_safe.h r600_reg_safe.h evergreen_reg_safe.h cayman_reg_safe.h
+targets := rn50_reg_safe.h r100_reg_safe.h r200_reg_safe.h rv515_reg_safe.h r300_reg_safe.h r420_reg_safe.h rs600_reg_safe.h r600_reg_safe.h evergreen_reg_safe.h cayman_reg_safe.h
 
 quiet_cmd_mkregtable = MKREGTABLE $@
       cmd_mkregtable = $(obj)/mkregtable $< > $@
 
-$(obj)/rn50_reg_safe.h: $(src)/reg_srcs/rn50 $(obj)/mkregtable
+$(obj)/rn50_reg_safe.h: $(src)/reg_srcs/rn50 $(obj)/mkregtable FORCE
 	$(call if_changed,mkregtable)
 
-$(obj)/r100_reg_safe.h: $(src)/reg_srcs/r100 $(obj)/mkregtable
+$(obj)/r100_reg_safe.h: $(src)/reg_srcs/r100 $(obj)/mkregtable FORCE
 	$(call if_changed,mkregtable)
 
-$(obj)/r200_reg_safe.h: $(src)/reg_srcs/r200 $(obj)/mkregtable
+$(obj)/r200_reg_safe.h: $(src)/reg_srcs/r200 $(obj)/mkregtable FORCE
 	$(call if_changed,mkregtable)
 
-$(obj)/rv515_reg_safe.h: $(src)/reg_srcs/rv515 $(obj)/mkregtable
+$(obj)/rv515_reg_safe.h: $(src)/reg_srcs/rv515 $(obj)/mkregtable FORCE
 	$(call if_changed,mkregtable)
 
-$(obj)/r300_reg_safe.h: $(src)/reg_srcs/r300 $(obj)/mkregtable
+$(obj)/r300_reg_safe.h: $(src)/reg_srcs/r300 $(obj)/mkregtable FORCE
 	$(call if_changed,mkregtable)
 
-$(obj)/r420_reg_safe.h: $(src)/reg_srcs/r420 $(obj)/mkregtable
+$(obj)/r420_reg_safe.h: $(src)/reg_srcs/r420 $(obj)/mkregtable FORCE
 	$(call if_changed,mkregtable)
 
-$(obj)/rs600_reg_safe.h: $(src)/reg_srcs/rs600 $(obj)/mkregtable
+$(obj)/rs600_reg_safe.h: $(src)/reg_srcs/rs600 $(obj)/mkregtable FORCE
 	$(call if_changed,mkregtable)
 
-$(obj)/r600_reg_safe.h: $(src)/reg_srcs/r600 $(obj)/mkregtable
+$(obj)/r600_reg_safe.h: $(src)/reg_srcs/r600 $(obj)/mkregtable FORCE
 	$(call if_changed,mkregtable)
 
-$(obj)/evergreen_reg_safe.h: $(src)/reg_srcs/evergreen $(obj)/mkregtable
+$(obj)/evergreen_reg_safe.h: $(src)/reg_srcs/evergreen $(obj)/mkregtable FORCE
 	$(call if_changed,mkregtable)
 
-$(obj)/cayman_reg_safe.h: $(src)/reg_srcs/cayman $(obj)/mkregtable
+$(obj)/cayman_reg_safe.h: $(src)/reg_srcs/cayman $(obj)/mkregtable FORCE
 	$(call if_changed,mkregtable)
 
 $(obj)/r100.o: $(obj)/r100_reg_safe.h $(obj)/rn50_reg_safe.h
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
