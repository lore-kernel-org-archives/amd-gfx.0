Return-Path: <SRS0=8BU1=C7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43329C2D0E2
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2020 08:30:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC579239E5
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2020 08:30:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC579239E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E2BC6E0DE;
	Tue, 22 Sep 2020 08:30:20 +0000 (UTC)
Received: from mail-m17613.qiye.163.com (mail-m17613.qiye.163.com
 [59.111.176.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A74D6E7D0
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2020 02:11:21 +0000 (UTC)
Received: from ubuntu.localdomain (unknown [157.0.31.124])
 by mail-m17613.qiye.163.com (Hmail) with ESMTPA id A31534827CA;
 Tue, 22 Sep 2020 10:11:13 +0800 (CST)
From: Bernard Zhao <bernard@vivo.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Jun Lei <Jun.Lei@amd.com>,
 Aric Cyr <aric.cyr@amd.com>, Wenjing Liu <wenjing.liu@amd.com>,
 Brandon Syu <Brandon.Syu@amd.com>,
 Michael Strauss <michael.strauss@amd.com>,
 abdoulaye berthe <abdoulaye.berthe@amd.com>,
 Martin Leung <martin.leung@amd.com>, Bernard Zhao <bernard@vivo.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/amd/display: optimize code runtime a bit
Date: Mon, 21 Sep 2020 19:11:03 -0700
Message-Id: <20200922021106.24733-1-bernard@vivo.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
 oVCBIfWUFZSh5ISRhJSB5CQ0kaVkpNS0tMT0tNTE9LTEhVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
 FZT0tIVUpKS0hKTFVKS0tZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pkk6EQw*Qj8hPA8PMEkONSJJ
 GQNPCxdVSlVKTUtLTE9LTUxPTk1PVTMWGhIXVRkeCRUaCR87DRINFFUYFBZFWVdZEgtZQVlKTkxV
 S1VISlVKSU9ZV1kIAVlBSElNQzcG
X-HM-Tid: 0a74b3944a0993bakuwsa31534827ca
X-Mailman-Approved-At: Tue, 22 Sep 2020 08:30:06 +0000
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
Cc: opensource.kernel@vivo.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In the function dal_ddc_service_query_ddc_data,
get rid of dal_ddc_i2c_payloads_destroy, call
dal_vector_destruct() directly.
This change is to make the code run a bit fast.

Signed-off-by: Bernard Zhao <bernard@vivo.com>
Changes since V1:
*get rid of dal_ddc_i2c_payloads_destroy, call
dal_vector_destruct() directly.

Link for V1:
*https://lore.kernel.org/patchwork/patch/1309014/
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c
index b984eecca58b..dec12de37642 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c
@@ -148,14 +148,6 @@ static uint32_t dal_ddc_i2c_payloads_get_count(struct i2c_payloads *p)
 	return p->payloads.count;
 }
 
-static void dal_ddc_i2c_payloads_destroy(struct i2c_payloads *p)
-{
-	if (!p)
-		return;
-
-	dal_vector_destruct(&p->payloads);
-}
-
 #define DDC_MIN(a, b) (((a) < (b)) ? (a) : (b))
 
 void dal_ddc_i2c_payloads_add(
@@ -582,7 +574,7 @@ bool dal_ddc_service_query_ddc_data(
 				ddc->link,
 				&command);
 
-		dal_ddc_i2c_payloads_destroy(&payloads);
+		dal_vector_destruct(&payloads.payloads);
 	}
 
 	return success;
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
