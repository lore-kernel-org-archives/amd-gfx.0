Return-Path: <SRS0=0vKA=BN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5CF3C433DF
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Aug 2020 14:35:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7CD12076E
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Aug 2020 14:35:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="tqgA2ECQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7CD12076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BB59891C7;
	Mon,  3 Aug 2020 14:35:46 +0000 (UTC)
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0E37891C7
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Aug 2020 14:35:44 +0000 (UTC)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 073ER85T179105;
 Mon, 3 Aug 2020 14:35:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=rmNK5gO7GIs9HZl9reoxxn3f8bE0c52R1BgKEeLZob4=;
 b=tqgA2ECQSo8e/LGISelYd4oNo5+ldklvMKBX6FccCVxdD11PQ18FAvhr/T3uGTsXDoiS
 Uzf+u+/FgF8afddon/esDsAAyZGM1ziGxzXWHuCL96Rdypc+mHipQ7+tw9LHOKgyt7EH
 OoQQs2LPJ57FrDAvGeF2K8yWQjxAHPQdSKxes+mPtLZzyx/Fz61fbdMaMocvkNC9LvPq
 c8GVJxp5QdzrOQ/53U1B7LVkLJRh2kCNH4f5gaxVrooeNfDDjDrdQ8IKiJZQQpAgYXCW
 r93UGynvpoyD3Tt+d93+PDdByDUV4tAnnl0K2EIddlAZ1kBSwNXK5uaGR0QgIao0AjKE tQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2130.oracle.com with ESMTP id 32pdnq238w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 03 Aug 2020 14:35:39 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 073EWm8T082137;
 Mon, 3 Aug 2020 14:35:38 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3020.oracle.com with ESMTP id 32pdnng3qw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 03 Aug 2020 14:35:38 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 073EZVPF008394;
 Mon, 3 Aug 2020 14:35:31 GMT
Received: from mwanda (/41.57.98.10) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 03 Aug 2020 07:35:30 -0700
Date: Mon, 3 Aug 2020 17:35:19 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Harry Wentland <harry.wentland@amd.com>,
 Mauro Rossi <issor.oruam@gmail.com>
Subject: [PATCH] drm/amd/display: Indent an if statement
Message-ID: <20200803143519.GB346925@mwanda>
MIME-Version: 1.0
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9702
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 spamscore=0 mlxscore=0
 bulkscore=0 adultscore=0 phishscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008030110
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9702
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 mlxscore=0
 suspectscore=0 clxscore=1011 priorityscore=1501 bulkscore=0 adultscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008030109
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
Cc: Charlene Liu <Charlene.Liu@amd.com>, Aric Cyr <aric.cyr@amd.com>,
 Reza Amini <Reza.Amini@amd.com>, Leo Li <sunpeng.li@amd.com>,
 kernel-janitors@vger.kernel.org, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Samson Tam <Samson.Tam@amd.com>, David Airlie <airlied@linux.ie>,
 Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>, amd-gfx@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Martin Leung <martin.leung@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The if statement wasn't indented so it's confusing.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index ca26714c800e..c6b737dd8425 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -71,7 +71,7 @@ enum dce_version resource_parse_asic_id(struct hw_asic_id asic_id)
 		if (ASIC_REV_IS_TAHITI_P(asic_id.hw_internal_rev) ||
 		    ASIC_REV_IS_PITCAIRN_PM(asic_id.hw_internal_rev) ||
 		    ASIC_REV_IS_CAPEVERDE_M(asic_id.hw_internal_rev))
-		dc_version = DCE_VERSION_6_0;
+			dc_version = DCE_VERSION_6_0;
 		else if (ASIC_REV_IS_OLAND_M(asic_id.hw_internal_rev))
 			dc_version = DCE_VERSION_6_4;
 		else
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
