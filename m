Return-Path: <SRS0=cmay=4C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC2AEC3B1A1
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2020 16:15:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4FED246E6
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2020 16:15:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="EiYQZ+no"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4FED246E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 801116FAC4;
	Fri, 14 Feb 2020 16:15:40 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4329B6FAC4;
 Fri, 14 Feb 2020 16:15:39 +0000 (UTC)
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0E60C246F2;
 Fri, 14 Feb 2020 16:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1581696939;
 bh=yzoiKmt3nAhRVtfsDr9a8b1lx8fMEShoEFhjBaCQzqo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=EiYQZ+no92DsJUaJqDmI+k5PTnBNU4JWikS9ySV2BtzGVPKk5lC2nZnM5kO50YMZj
 64ils+SW8zaIi8o9g4qH1fL24sbtt0EwQ/NwFnt3CN/CxYYK2/DieGxo/Y0PV2O9X8
 4lMkHONjBnYuz/A61i5TLW2DaAt7aOrjCnLysvyw=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 182/252] drm/amd/display: fixup DML dependencies
Date: Fri, 14 Feb 2020 11:10:37 -0500
Message-Id: <20200214161147.15842-182-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214161147.15842-1-sashal@kernel.org>
References: <20200214161147.15842-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
Cc: Sasha Levin <sashal@kernel.org>, Anthony Koo <Anthony.Koo@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Jun Lei <Jun.Lei@amd.com>, Harry Wentland <harry.wentland@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jun Lei <Jun.Lei@amd.com>

[ Upstream commit 34ad0230062c39cdcba564d16d122c0fb467a7d6 ]

[why]
Need to fix DML portability issues to enable SW unit testing around DML

[how]
Move calcs into dc include folder since multiple components reference it
Remove relative paths to external dependencies

Signed-off-by: Jun Lei <Jun.Lei@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dml/dml_common_defs.c          | 2 +-
 drivers/gpu/drm/amd/display/dc/dml/dml_inline_defs.h          | 2 +-
 drivers/gpu/drm/amd/display/dc/{calcs => inc}/dcn_calc_math.h | 0
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename drivers/gpu/drm/amd/display/dc/{calcs => inc}/dcn_calc_math.h (100%)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dml_common_defs.c b/drivers/gpu/drm/amd/display/dc/dml/dml_common_defs.c
index b953b02a15121..723af0b2dda04 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dml_common_defs.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dml_common_defs.c
@@ -24,7 +24,7 @@
  */
 
 #include "dml_common_defs.h"
-#include "../calcs/dcn_calc_math.h"
+#include "dcn_calc_math.h"
 
 #include "dml_inline_defs.h"
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dml_inline_defs.h b/drivers/gpu/drm/amd/display/dc/dml/dml_inline_defs.h
index e8ce08567cd8e..e4f595a3038c4 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dml_inline_defs.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dml_inline_defs.h
@@ -27,7 +27,7 @@
 #define __DML_INLINE_DEFS_H__
 
 #include "dml_common_defs.h"
-#include "../calcs/dcn_calc_math.h"
+#include "dcn_calc_math.h"
 #include "dml_logger.h"
 
 static inline double dml_min(double a, double b)
diff --git a/drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_math.h b/drivers/gpu/drm/amd/display/dc/inc/dcn_calc_math.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_math.h
rename to drivers/gpu/drm/amd/display/dc/inc/dcn_calc_math.h
-- 
2.20.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
