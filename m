Return-Path: <SRS0=W/Sk=6I=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22FF1C2BA1A
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Apr 2020 10:29:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E92472071E
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Apr 2020 10:29:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fcNuztLa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E92472071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6D556E452;
	Fri, 24 Apr 2020 10:29:51 +0000 (UTC)
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F0F96E452
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Apr 2020 10:29:50 +0000 (UTC)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03OASj7O181885;
 Fri, 24 Apr 2020 10:29:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=73ENselyCq+l9fcOsj5tItCGgciLFbtnwQ+/yFd4WnU=;
 b=fcNuztLa1YkcAaYd35i5er+TrEkyf4vhxjj/aN85EEhV8bYbS/bdVM4k/giD1uERW7uq
 mdVBPFf478v0qkasTGddJzCKOu8TGaS0X8K6CZhlQGvAoB7dXv3Vvx81IYqqTQxghTtX
 lYOdfbzKZM+jZNw5aMG7ZQOubJhaD1MYx3JpMhPKjRwzq4x4tT0Hap6NAD1o6Vvn5MGq
 b6AD7h2lDGufrilDf2VHGhaVWNAww8WfIU2ye7NKhqxoGe71CIJCkUhBpcG2ngtMylb7
 7NnEnpiBt+jcWESyFzC+VWUU3JYfQERI4GXVb7inxXYaVUTF6xCyvtNyRsVBBiPKDVYs qw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by aserp2120.oracle.com with ESMTP id 30jvq50b7n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 24 Apr 2020 10:29:47 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03OAMNRV021903;
 Fri, 24 Apr 2020 10:27:46 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3030.oracle.com with ESMTP id 30gb1pg68a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 24 Apr 2020 10:27:46 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 03OARjWo021152;
 Fri, 24 Apr 2020 10:27:45 GMT
Received: from mwanda (/41.57.98.10) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 24 Apr 2020 03:27:44 -0700
Date: Fri, 24 Apr 2020 13:27:39 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: evan.quan@amd.com
Subject: [bug report] drm/amdgpu: optimize the gpu reset for XGMI setup V2
Message-ID: <20200424102739.GA414781@mwanda>
MIME-Version: 1.0
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9600
 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 suspectscore=3 spamscore=0
 mlxlogscore=730 mlxscore=0 malwarescore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004240080
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9600
 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 malwarescore=0
 mlxscore=0 adultscore=0 mlxlogscore=782 phishscore=0 impostorscore=0
 clxscore=1011 bulkscore=0 spamscore=0 priorityscore=1501 suspectscore=3
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004240081
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
Cc: amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hello Evan Quan,

This is a semi-automatic email about new static checker warnings.

The patch 9e94d22c0085: "drm/amdgpu: optimize the gpu reset for XGMI
setup V2" from Apr 16, 2020, leads to the following Smatch complaint:

    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:4199 amdgpu_device_gpu_recover()
    error: we previously assumed 'hive' could be null (see line 4196)

drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
  4195		list_for_each_entry(tmp_adev, device_list_handle, gmc.xgmi.head) {
  4196			if (!amdgpu_device_lock_adev(tmp_adev, !hive)) {
                                                               ^^^^^
There are a ton of double negatives in this snippet.

Assume hive is NULL, then not NULL is true, so in amdgpu_device_lock_adev()
we try to take the lock, and lets assume that fails.  That's only path
which returns false.  In other words, we know that "hive" is NULL inside
this condition.

  4197				DRM_INFO("Bailing on TDR for s_job:%llx, as another already in progress",
  4198					  job ? job->base.id : -1);
  4199				mutex_unlock(&hive->hive_lock);
                                              ^^^^
NULL dereference.

  4200				return 0;
  4201			}

regards,
dan carpenter
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
