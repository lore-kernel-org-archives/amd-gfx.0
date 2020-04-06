Return-Path: <SRS0=+i0l=5W=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EB7CC2BA19
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Apr 2020 09:19:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 226B8206F8
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Apr 2020 09:19:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="0P3ufm3u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 226B8206F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACDE96E2EC;
	Mon,  6 Apr 2020 09:19:41 +0000 (UTC)
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C4746E2EC
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Apr 2020 09:19:40 +0000 (UTC)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0369Hv3Y026949;
 Mon, 6 Apr 2020 09:19:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=tJLkLbkX3XejL8jAx8gN3emhNfQRl/ysMNjDxqG7obQ=;
 b=0P3ufm3uCb790cFvDuHUpbMdazUaeh+9RWCjGqh8CHiFZT9ounOUqiRTHpGyf8lrSBcI
 4mqQoNhLbYevMUlFapxUmh5MjtaxIKFMU4iOhd4hcpYVeozZ30xAQj/pCz7zNvwHVh4g
 J5JcxANV6iUh23SI8RR0bIyj8G4ij88F4O/dwtfiDwGnC34ELNVPMaSJySHqcCod+TLY
 Tye4rdnyOdNfPABNzO/oJUCfdpvXQND++esOk6hqcBsoG3fJSoMWzId9ubAZi1+YV9RB
 D85lOza9XVQsm0URY96a6Ty9KM0G3PhO8Jn7t4RgS9SyrpuO9VLU7Vyg39tGUoKg9A+y cw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by aserp2120.oracle.com with ESMTP id 306j6m5qa9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 06 Apr 2020 09:19:33 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0369HDul001582;
 Mon, 6 Apr 2020 09:19:32 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3030.oracle.com with ESMTP id 3073qcmed2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 06 Apr 2020 09:19:32 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0369JLNB021307;
 Mon, 6 Apr 2020 09:19:22 GMT
Received: from mwanda (/41.57.98.10) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 06 Apr 2020 02:19:21 -0700
Date: Mon, 6 Apr 2020 12:19:10 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Harry Wentland <harry.wentland@amd.com>,
 Melissa Wen <melissa.srw@gmail.com>
Subject: [PATCH net-next] drm/amd/display: Fix link_detect_sink()
Message-ID: <20200406091910.GA5405@mwanda>
MIME-Version: 1.0
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9582
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxscore=0 mlxlogscore=999
 spamscore=0 bulkscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004060080
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9582
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxlogscore=999 spamscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 mlxscore=0 phishscore=0 adultscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004060080
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
Cc: "David \(ChunMing\) Zhou" <David1.Zhou@amd.com>,
 kernel-janitors@vger.kernel.org, Chris Park <Chris.Park@amd.com>,
 Zhan Liu <Zhan.Liu@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Wenjing Liu <Wenjing.Liu@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Roman Li <Roman.Li@amd.com>, amd-gfx@lists.freedesktop.org,
 Nikola Cornij <nikola.cornij@amd.com>, David Airlie <airlied@linux.ie>,
 Lucy Li <lucy.li@amd.com>, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>,
 David Galiffi <David.Galiffi@amd.com>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Anthony Koo <Anthony.Koo@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This TODO stub originally had curly braces but we deleted them as part
of a clean up.  Unfortunately that changes the behavior of the code
because now the switch statement is part of the if statement.  Smatch
complains that the indenting doesn't make sense.

    drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link.c:425
    link_detect_sink() warn: if statement not indented

Also I changed "ZAZTODO" to just "TODO".  The ZAZ isn't used anywhere
else.

Fixes: 621514aa4140 ("drm/amd/display: codestyle cleanup on dc_link file until detect_dp func")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
Another idea is we should just delete this stub.  Stub code is generally
against kernel style.  I can send a V2 if people want.

 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index a93997ff0419..188670d374a3 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -423,7 +423,7 @@ static enum signal_type link_detect_sink(struct dc_link *link,
 
 	/* PCIE detects the actual connector on add-on board */
 	if (link->link_id.id == CONNECTOR_ID_PCIE)
-		/* ZAZTODO implement PCIE add-on card detection */
+		; /* TODO implement PCIE add-on card detection */
 
 	switch (link->link_id.id) {
 	case CONNECTOR_ID_HDMI_TYPE_A: {
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
