Return-Path: <SRS0=mGSI=DF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_ADSP_DISCARD,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E34F6C47423
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Sep 2020 07:07:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 899ED20789
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Sep 2020 07:07:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b="Sd1lid5A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 899ED20789
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 893716E2E1;
	Mon, 28 Sep 2020 07:06:48 +0000 (UTC)
Received: from services.gouders.net (services.gouders.net [141.101.32.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E158F6E059
 for <amd-gfx@lists.freedesktop.org>; Sun, 27 Sep 2020 10:46:40 +0000 (UTC)
Received: from localhost (ltea-047-066-007-142.pools.arcor-ip.net
 [47.66.7.142]) (authenticated bits=0)
 by services.gouders.net (8.14.8/8.14.8) with ESMTP id 08RAiO5n021841
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 27 Sep 2020 12:44:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
 t=1601203466; bh=aemTqKatBtqbMCYYYd/wKTQrYKgZpQbntOAIXHlmPC4=;
 h=From:To:Cc:Subject:Date;
 b=Sd1lid5AcokPfqHVSgfrBXVne/jk/3n4TUcrRkK1sBopIKCWXQlesovQSSkKqy5k0
 wi57oF7MdB/XMt3pFD0fftwnxWM19Z4Rnp2BH5uS8d3NM1FXMF17tSfwo17GQOMZWy
 e9XJ4dcalJlPt2eCI+qb0qSob0n/AOcTlnLfjmfA=
From: Dirk Gouders <dirk@gouders.net>
To: Alex Deucher <alexander.deucher@amd.com>, Christian =?utf-8?Q?K=C3=B6n?=
 =?utf-8?Q?ig?= <christian.koenig@amd.com>
Subject: [PATCH] drm/amd/display: remove duplicate call to
 rn_vbios_smu_get_smu_version()
Date: Sun, 27 Sep 2020 11:39:45 +0200
Message-ID: <ghwo0fzegq.fsf@gouders.net>
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 28 Sep 2020 07:06:47 +0000
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
Cc: Sung Lee <sung.lee@amd.com>, Yongqiang Sun <yongqiang.sun@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Commit 78fe9f63947a2b (drm/amd/display: Remove DISPCLK Limit Floor
for Certain SMU Versions) added a call to
rn_vbios_smu_get_smu_version() to set clk_mgr->smu_ver.  That field is
initialized prior to the if-statement, already.

Fixes: 78fe9f63947a2b (drm/amd/display: Remove DISPCLK Limit Floor for Certain SMU Versions)
Signed-off-by: Dirk Gouders <dirk@gouders.net>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Sung Lee <sung.lee@amd.com>
Cc: Yongqiang Sun <yongqiang.sun@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
index 543afa34d87a..21a3073c8929 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
@@ -783,7 +783,6 @@ void rn_clk_mgr_construct(
 	} else {
 		struct clk_log_info log_info = {0};
 
-		clk_mgr->smu_ver = rn_vbios_smu_get_smu_version(clk_mgr);
 		clk_mgr->periodic_retraining_disabled = rn_vbios_smu_is_periodic_retraining_disabled(clk_mgr);
 
 		/* SMU Version 55.51.0 and up no longer have an issue
-- 
2.26.2
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
