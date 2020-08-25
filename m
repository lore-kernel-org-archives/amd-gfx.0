Return-Path: <SRS0=LR/f=CD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BEFBC433E1
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Aug 2020 10:24:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F93120706
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Aug 2020 10:24:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MTLwCVR6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F93120706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAA866E095;
	Tue, 25 Aug 2020 10:24:35 +0000 (UTC)
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23F406E095
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Aug 2020 10:24:34 +0000 (UTC)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07PAJhp4091015;
 Tue, 25 Aug 2020 10:24:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=aIZyE6r+C2bL1csEM0lvONIWcfx5iU1k9jbQduloOLM=;
 b=MTLwCVR6QUDoiPyRTxGCvqazJ9+bxQ+u7oLELbiiAFyVP7iZpFabw/Se2yn5CrGJE0KN
 esB7Fy0AjeQNr+7eEXVAMH/J5t2MkfE2/zEZal9n75KQgBk+hLbvGxk5eQzuSDFOQ5pm
 5GFU0mXqvIuNOqG2Cl3z7NVvrxoCx1vDzDHNoSTI35Wry3iFyThtIE/oqXy0EnGpuL7A
 efL5hP1tYQ8hj3fr36tlwAZHUL7aHJsOwwLs+wfe7cyyERWjV7tisOaInl5IKhBe8d3o
 sOLVSrMzVGFqVl1wmPetfzLj1qMksCMuI68cqfZ2CWm9Af5o55K0EkYlKViVb/5iuLKI hw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2120.oracle.com with ESMTP id 333w6tr6f0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 25 Aug 2020 10:24:32 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07PALIg7148338;
 Tue, 25 Aug 2020 10:24:31 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3030.oracle.com with ESMTP id 333r9jcg5y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 25 Aug 2020 10:24:31 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07PAOVcf030403;
 Tue, 25 Aug 2020 10:24:31 GMT
Received: from mwanda (/41.57.98.10) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 25 Aug 2020 03:24:30 -0700
Date: Tue, 25 Aug 2020 13:24:25 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Rex.Zhu@amd.com
Subject: [bug report] drm/amd/powerplay: add point check to avoid NULL point
 hang.
Message-ID: <20200825102425.GA272450@mwanda>
MIME-Version: 1.0
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9723
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0
 suspectscore=3 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008250077
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9723
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 impostorscore=0
 mlxlogscore=999 suspectscore=3 phishscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 clxscore=1011 mlxscore=0 lowpriorityscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008250077
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

Hello Rex Zhu,

The patch 88b8dcbe21fd: "drm/amd/powerplay: add point check to avoid
NULL point hang." from Dec 11, 2015, leads to the following static
checker warning:

	drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/hardwaremanager.c:274 phm_check_smc_update_required_for_display_configuration()
	warn: signedness bug returning '(-22)'

drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/hardwaremanager.c
   272  bool phm_check_smc_update_required_for_display_configuration(struct pp_hwmgr *hwmgr)
   273  {
   274          PHM_FUNC_CHECK(hwmgr);

PHM_FUNC_CHECK() has a hiddren -EINVAL return that becomes true when
casted to bool.

   275          if (hwmgr->pp_one_vf)
   276                  return false;
   277  
   278          if (hwmgr->hwmgr_func->check_smc_update_required_for_display_configuration == NULL)
   279                  return false;
   280  
   281          return hwmgr->hwmgr_func->check_smc_update_required_for_display_configuration(hwmgr);
   282  }

regards,
dan carpenter
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
