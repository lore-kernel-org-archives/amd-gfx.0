Return-Path: <SRS0=eP35=BG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D266C433E4
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jul 2020 13:42:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 520202070A
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jul 2020 13:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ru9FHjwY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 520202070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B0AC89CA0;
	Mon, 27 Jul 2020 13:42:05 +0000 (UTC)
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5AFB89CA0
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Jul 2020 13:42:04 +0000 (UTC)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06RDalhA125037;
 Mon, 27 Jul 2020 13:42:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=C79hoc+bChITH02F5tCpLD3vLSaoHC5D5jC4/tNpnZQ=;
 b=ru9FHjwY/mUY8HtHss0i08Sck2VlGiFM+JAapqQ/1DaNbh1197LqjRmOhh8DXUDAji9f
 LCqINFEqC4cJdtAbjoA7Lsptjhvb2DMfWnTQ38m6/vt/XKpgMG9nv8pIxX41on97k38o
 oOYS+u9t7hmNpWxnoXKN3mkF2++zm5C8HeGofLx8ZGbpQjNCqJ9BE6enYO+5cUjVb7y1
 nT6EDYRqv646nHqgVIpavh50SqMz7UevJoZOyIXRUD1wKFzrvc60x0tkqULNhjIONw6v
 UwdCb+uk9fNhrODboTuAA/J1X5rNBI+r+PgVvN/PSQWMG+wu0gbvifH3/95ukqBcUa4A 6g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2130.oracle.com with ESMTP id 32hu1j1ka2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 27 Jul 2020 13:42:00 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06RDcMq5007680;
 Mon, 27 Jul 2020 13:39:59 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3020.oracle.com with ESMTP id 32hu5qqe7x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 27 Jul 2020 13:39:59 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06RDdmE1003749;
 Mon, 27 Jul 2020 13:39:48 GMT
Received: from mwanda (/41.57.98.10) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 27 Jul 2020 06:39:47 -0700
Date: Mon, 27 Jul 2020 16:39:40 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Evan Quan <evan.quan@amd.com>
Subject: [PATCH] drm/amd/powerplay: off by one bugs in
 smu_cmn_to_asic_specific_index()
Message-ID: <20200727133940.GA391897@mwanda>
MIME-Version: 1.0
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9694
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 adultscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007270100
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9694
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 clxscore=1015
 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007270100
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
Cc: David Airlie <airlied@linux.ie>, kernel-janitors@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

These tables have _COUNT number of elements so the comparisons should be
>= instead of > to prevent reading one element beyond the end of the
array.

Fixes: 8264ee69f0d8 ("drm/amd/powerplay: drop unused code")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/gpu/drm/amd/powerplay/smu_cmn.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/smu_cmn.c b/drivers/gpu/drm/amd/powerplay/smu_cmn.c
index be4b678d0e60..5c23c44c33bd 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_cmn.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_cmn.c
@@ -166,7 +166,7 @@ int smu_cmn_to_asic_specific_index(struct smu_context *smu,
 
 	switch (type) {
 	case CMN2ASIC_MAPPING_MSG:
-		if (index > SMU_MSG_MAX_COUNT ||
+		if (index >= SMU_MSG_MAX_COUNT ||
 		    !smu->message_map)
 			return -EINVAL;
 
@@ -181,7 +181,7 @@ int smu_cmn_to_asic_specific_index(struct smu_context *smu,
 		return msg_mapping.map_to;
 
 	case CMN2ASIC_MAPPING_CLK:
-		if (index > SMU_CLK_COUNT ||
+		if (index >= SMU_CLK_COUNT ||
 		    !smu->clock_map)
 			return -EINVAL;
 
@@ -192,7 +192,7 @@ int smu_cmn_to_asic_specific_index(struct smu_context *smu,
 		return mapping.map_to;
 
 	case CMN2ASIC_MAPPING_FEATURE:
-		if (index > SMU_FEATURE_COUNT ||
+		if (index >= SMU_FEATURE_COUNT ||
 		    !smu->feature_map)
 			return -EINVAL;
 
@@ -203,7 +203,7 @@ int smu_cmn_to_asic_specific_index(struct smu_context *smu,
 		return mapping.map_to;
 
 	case CMN2ASIC_MAPPING_TABLE:
-		if (index > SMU_TABLE_COUNT ||
+		if (index >= SMU_TABLE_COUNT ||
 		    !smu->table_map)
 			return -EINVAL;
 
@@ -214,7 +214,7 @@ int smu_cmn_to_asic_specific_index(struct smu_context *smu,
 		return mapping.map_to;
 
 	case CMN2ASIC_MAPPING_PWR:
-		if (index > SMU_POWER_SOURCE_COUNT ||
+		if (index >= SMU_POWER_SOURCE_COUNT ||
 		    !smu->pwr_src_map)
 			return -EINVAL;
 
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
