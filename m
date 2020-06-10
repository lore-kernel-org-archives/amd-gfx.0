Return-Path: <SRS0=jeuu=7X=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9707C433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jun 2020 08:57:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEAEB204EA
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jun 2020 08:57:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eFzdfKGK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEAEB204EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A87D89E86;
	Wed, 10 Jun 2020 08:57:18 +0000 (UTC)
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BEE589E57
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jun 2020 08:57:16 +0000 (UTC)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05A8qZtf057987;
 Wed, 10 Jun 2020 08:57:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2020-01-29; bh=U3rmNlKU4okJAzL7TELrQhC3V+3dWp+gWSymDbfp8zg=;
 b=eFzdfKGKDuHAfoMxn9wNH76A04atieHJ3qriyUKIMe5l4CIGwnfB4Q0ebeKE1+nfQuP9
 YrsQeErvU2R1cXFFJ5do/guhwSkkMpnU8IMC70vWETfMIsXKaOhKnkmB8UQ0iw0j30Wn
 vfAKp8gEYkG1tpncUOuciYsOBxen+ZKG7woGLhmzCNZAorlfjRiIDT1R0HT3fKDMf79S
 KdIoHR7CQzBPM6AOpqbO3fSiIb16S2wELW+7lbNFK3xvKsxNwocCQ16bIiMNq+ohPos9
 5DtSd2/FSdh3Uz9hBKqQTxeL0vuC+pgd4wLsP8mUQupfQryFA9vLkHUqfOsQl1Y9gO2w 1Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2130.oracle.com with ESMTP id 31g2jr98xh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 10 Jun 2020 08:57:12 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05A8liLD186955;
 Wed, 10 Jun 2020 08:57:11 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3030.oracle.com with ESMTP id 31gn2y4axg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 10 Jun 2020 08:57:11 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 05A8v2NT013173;
 Wed, 10 Jun 2020 08:57:03 GMT
Received: from mwanda (/41.57.98.10) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 10 Jun 2020 01:57:02 -0700
Date: Wed, 10 Jun 2020 11:56:53 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v2] drm/amdgpu: Fix a buffer overflow handling the serial
 number
Message-ID: <20200610085653.GA5439@mwanda>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <DM6PR12MB26194168100E5F96FF94D066E4820@DM6PR12MB2619.namprd12.prod.outlook.com>
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9647
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 phishscore=0 malwarescore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006100068
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9647
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 impostorscore=0
 cotscore=-2147483648 priorityscore=1501 spamscore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 phishscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006100068
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
Cc: Jack Xiao <Jack.Xiao@amd.com>, Jonathan Kim <jonathan.kim@amd.com>,
 Joseph Greathouse <Joseph.Greathouse@amd.com>, David Airlie <airlied@linux.ie>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 kernel-janitors@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 Le Ma <le.ma@amd.com>, Daniel Vetter <daniel@ffwll.ch>,
 Evan Quan <evan.quan@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The comments say that the serial number is a 16-digit HEX string so the
buffer needs to be at least 17 characters to hold the NUL terminator.

The other issue is that "size" returned from sprintf() is the number of
characters before the NUL terminator so the memcpy() wasn't copying the
terminator.  The serial number needs to be NUL terminated so that it
doesn't lead to a read overflow in amdgpu_device_get_serial_number().
Also it's just cleaner and faster to sprintf() directly to adev->serial[]
instead of using a temporary buffer.

Fixes: 81a16241114b ("drm/amdgpu: Add unique_id and serial_number for Arcturus v3")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
v2: Change adev->serial.  The original patch would have just moved the
overflow until amdgpu_device_get_serial_number() is called.

 drivers/gpu/drm/amd/amdgpu/amdgpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h          | 2 +-
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c | 6 ++----
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 135530286f34f..905cf0bac100c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -986,7 +986,7 @@ struct amdgpu_device {
 	/* Chip product information */
 	char				product_number[16];
 	char				product_name[32];
-	char				serial[16];
+	char				serial[20];
 
 	struct amdgpu_autodump		autodump;
 
diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
index df7b408319f76..d58146a5fa21d 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -2265,8 +2265,7 @@ static void arcturus_i2c_eeprom_control_fini(struct i2c_adapter *control)
 static void arcturus_get_unique_id(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
-	uint32_t top32, bottom32, smu_version, size;
-	char sn[16];
+	uint32_t top32, bottom32, smu_version;
 	uint64_t id;
 
 	if (smu_get_smc_version(smu, NULL, &smu_version)) {
@@ -2289,8 +2288,7 @@ static void arcturus_get_unique_id(struct smu_context *smu)
 	/* For Arcturus-and-later, unique_id == serial_number, so convert it to a
 	 * 16-digit HEX string for convenience and backwards-compatibility
 	 */
-	size = sprintf(sn, "%llx", id);
-	memcpy(adev->serial, &sn, size);
+	sprintf(adev->serial, "%llx", id);
 }
 
 static bool arcturus_is_baco_supported(struct smu_context *smu)
-- 
2.26.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
