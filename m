Return-Path: <SRS0=L2kD=ME=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E62C07E99
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Jul 2021 07:18:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9537460FF1
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Jul 2021 07:18:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9537460FF1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7342589B67;
	Mon, 12 Jul 2021 07:18:39 +0000 (UTC)
Received: from smtprelay.hostedemail.com (smtprelay0182.hostedemail.com
 [216.40.44.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D22889C14;
 Sun, 11 Jul 2021 19:46:16 +0000 (UTC)
Received: from omf11.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
 by smtprelay07.hostedemail.com (Postfix) with ESMTP id 1FECF1834334A;
 Sun, 11 Jul 2021 19:46:15 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by
 omf11.hostedemail.com (Postfix) with ESMTPA id 1461720A295; 
 Sun, 11 Jul 2021 19:46:13 +0000 (UTC)
Message-ID: <d3a180c3dc8db68a25440edf466cfeddcaae5a64.camel@perches.com>
Subject: drm/amd/display: Simplify hdcp validate_bksv
From: Joe Perches <joe@perches.com>
To: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Date: Sun, 11 Jul 2021 12:46:12 -0700
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
X-Stat-Signature: 539sh6xq8seofo8ke64ezq5hhueemyjt
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 1461720A295
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX199Uq/CjUUQdOfJPyou+ohMOJSTDeqoedM=
X-HE-Tag: 1626032773-460936
X-Mailman-Approved-At: Mon, 12 Jul 2021 07:18:38 +0000
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 dri-devel <dri-devel@lists.freedesktop.org>, Kees Cook <keescook@chromium.org>,
 amd-gfx@lists.freedesktop.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

commit 06888d571b51 ("drm/amd/display: Avoid HDCP over-read and corruption")
fixed an overread with an invalid buffer length but added an unnecessary
buffer and copy.

Simplify the code by using a single uint64_t and __builtin_popcountll to
count the number of bits set in the original bksv buffer instead of a loop.

This also avoid a possible unaligned access of the temporary bksv.

Signed-off-by: Joe Perches <joe@perches.com>
---

It seems quite odd 20 bits set is a magic number here.
Should it be a specific be/le value instead?

 drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c
index de872e7958b06..78a4c6dd95d99 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c
@@ -28,17 +28,10 @@
 static inline enum mod_hdcp_status validate_bksv(struct mod_hdcp *hdcp)
 {
 	uint64_t n = 0;
-	uint8_t count = 0;
-	u8 bksv[sizeof(n)] = { };
 
-	memcpy(bksv, hdcp->auth.msg.hdcp1.bksv, sizeof(hdcp->auth.msg.hdcp1.bksv));
-	n = *(uint64_t *)bksv;
+	memcpy(&n, hdcp->auth.msg.hdcp1.bksv, sizeof(hdcp->auth.msg.hdcp1.bksv));
 
-	while (n) {
-		count++;
-		n &= (n - 1);
-	}
-	return (count == 20) ? MOD_HDCP_STATUS_SUCCESS :
+	return (__builtin_popcountll(n) == 20) ? MOD_HDCP_STATUS_SUCCESS :
 			MOD_HDCP_STATUS_HDCP1_INVALID_BKSV;
 }
 


_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
