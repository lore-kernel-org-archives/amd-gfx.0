Return-Path: <SRS0=KDYH=4M=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C9FC11D2F
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Feb 2020 10:31:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FB6D20828
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Feb 2020 10:31:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="k+ZSB0dJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FB6D20828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF5676E423;
	Mon, 24 Feb 2020 10:31:46 +0000 (UTC)
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C10656E418;
 Mon, 24 Feb 2020 10:31:45 +0000 (UTC)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01OAVImf169236;
 Mon, 24 Feb 2020 10:31:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=vm2BUHNE+rpmkpN2Az3/A1jgSzhKYXcojpJsMycW6Zw=;
 b=k+ZSB0dJiE20BHsYwCnMsFjRhKBSV4cIoK+uzK9EMQNYHVKoeuku7Ln1h41qlGlrGKwU
 a56/o71y11iBJDWuHijH/vsjReJNvE+mlWFMx0a+/P7tj2eHM8oasxl4pQfeIiFOxpuu
 DTdYGHbpSFvYOM3fU6uRufcJ5Q1Ej7xnlzSSWSWm0PXWEqQVhqW8YzRhW6FEQiqKgrPt
 4B2b6HEPLyV6U/sYXdbDUbgZxVIi2bLq+7sxG8K6KdTJMUc+Es173/D08236yMUmyF07
 lxira0aOWIWu/dI1sfCaDX0mVriFUJ+kNiedQogLS1edBrZOMRvCzu4PPXDEK38PaSx0 2A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2130.oracle.com with ESMTP id 2yauqu6ffe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Feb 2020 10:31:39 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01OAV0hL193596;
 Mon, 24 Feb 2020 10:31:38 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3030.oracle.com with ESMTP id 2ybduu2w23-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Feb 2020 10:31:38 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01OAVZ2A031820;
 Mon, 24 Feb 2020 10:31:36 GMT
Received: from kili.mountain (/129.205.23.165)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 24 Feb 2020 02:31:35 -0800
Date: Mon, 24 Feb 2020 13:31:20 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH] drm/amdgpu/display: clean up some indenting
Message-ID: <20200224103120.zrvgqaokmoehs5y7@kili.mountain>
MIME-Version: 1.0
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9540
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002240090
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9540
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 bulkscore=0
 clxscore=1011 malwarescore=0 impostorscore=0 adultscore=0 phishscore=0
 priorityscore=1501 mlxlogscore=999 spamscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002240090
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
 Mario Kleiner <mario.kleiner.de@gmail.com>, Leo Li <sunpeng.li@amd.com>,
 David Francis <David.Francis@amd.com>, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

These lines were accidentally indented 4 spaces more than they should
be.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 4cb3eb7c6745..408405d9f30c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2138,10 +2138,10 @@ static void handle_hpd_rx_irq(void *param)
 		}
 	}
 #ifdef CONFIG_DRM_AMD_DC_HDCP
-	    if (hpd_irq_data.bytes.device_service_irq.bits.CP_IRQ) {
-		    if (adev->dm.hdcp_workqueue)
-			    hdcp_handle_cpirq(adev->dm.hdcp_workqueue,  aconnector->base.index);
-	    }
+	if (hpd_irq_data.bytes.device_service_irq.bits.CP_IRQ) {
+		if (adev->dm.hdcp_workqueue)
+			hdcp_handle_cpirq(adev->dm.hdcp_workqueue,  aconnector->base.index);
+	}
 #endif
 	if ((dc_link->cur_link_settings.lane_count != LANE_COUNT_UNKNOWN) ||
 	    (dc_link->type == dc_connection_mst_branch))
-- 
2.11.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
