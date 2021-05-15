Return-Path: <SRS0=Ip1/=KM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B123DC433B4
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 07:32:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56DC7611C2
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 07:32:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56DC7611C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E46136E8E1;
	Mon, 17 May 2021 07:32:38 +0000 (UTC)
X-Greylist: delayed 578 seconds by postgrey-1.36 at gabe;
 Sat, 15 May 2021 17:11:08 UTC
Received: from smtprelay.hostedemail.com (smtprelay0126.hostedemail.com
 [216.40.44.126])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 033C16E422
 for <amd-gfx@lists.freedesktop.org>; Sat, 15 May 2021 17:11:08 +0000 (UTC)
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com
 [10.5.19.251])
 by smtpgrave04.hostedemail.com (Postfix) with ESMTP id 71A421800CDE1
 for <amd-gfx@lists.freedesktop.org>; Sat, 15 May 2021 17:01:32 +0000 (UTC)
Received: from omf14.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
 by smtprelay06.hostedemail.com (Postfix) with ESMTP id C31D81822494D;
 Sat, 15 May 2021 17:01:29 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by
 omf14.hostedemail.com (Postfix) with ESMTPA id 61850268E38; 
 Sat, 15 May 2021 17:01:28 +0000 (UTC)
Message-ID: <e5f8613b96fe43bd8ab2ac304a2c9fb57a87a2ca.camel@perches.com>
Subject: [trivial PATCH] drm/amd/display: Fix typo of format termination
 newline
From: Joe Perches <joe@perches.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>
Date: Sat, 15 May 2021 10:01:26 -0700
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
X-Rspamd-Queue-Id: 61850268E38
X-Stat-Signature: 1n1bipcbf8r5mj9twb3dsoacrqhrzwam
X-Rspamd-Server: rspamout03
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/vUQKcwaGcFvtEcpO9mg1PoKuCIHLWcwk=
X-HE-Tag: 1621098088-693195
X-Mailman-Approved-At: Mon, 17 May 2021 07:32:38 +0000
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
Cc: David Airlie <airlied@linux.ie>, LKML <linux-kernel@vger.kernel.org>,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

/n should be \n

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c   | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index 45f96221a094..b38fee783277 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -1724,7 +1724,7 @@ static bool init_soc_bounding_box(struct dc *dc,
 	DC_LOGGER_INIT(dc->ctx->logger);
 
 	if (!is_soc_bounding_box_valid(dc)) {
-		DC_LOG_ERROR("%s: not valid soc bounding box/n", __func__);
+		DC_LOG_ERROR("%s: not valid soc bounding box\n", __func__);
 		return false;
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
index 5b54b7fc5105..3bf66c994dd5 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
@@ -1497,7 +1497,7 @@ static bool init_soc_bounding_box(struct dc *dc,
 	DC_LOGGER_INIT(dc->ctx->logger);
 
 	if (!is_soc_bounding_box_valid(dc)) {
-		DC_LOG_ERROR("%s: not valid soc bounding box/n", __func__);
+		DC_LOG_ERROR("%s: not valid soc bounding box\n", __func__);
 		return false;
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
index fc2dea243d1b..84c61128423e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
@@ -1093,7 +1093,7 @@ static bool init_soc_bounding_box(struct dc *dc,  struct resource_pool *pool)
 	DC_LOGGER_INIT(dc->ctx->logger);
 
 	if (!is_soc_bounding_box_valid(dc)) {
-		DC_LOG_ERROR("%s: not valid soc bounding box/n", __func__);
+		DC_LOG_ERROR("%s: not valid soc bounding box\n", __func__);
 		return false;
 	}
 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
