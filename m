Return-Path: <SRS0=sMqH=7L=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45756C433E1
	for <amd-gfx@archiver.kernel.org>; Fri, 29 May 2020 08:47:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A7DD2072D
	for <amd-gfx@archiver.kernel.org>; Fri, 29 May 2020 08:47:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KX8n89wO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A7DD2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC12C6E8A6;
	Fri, 29 May 2020 08:47:46 +0000 (UTC)
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D9FD6E8A6
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2020 08:47:45 +0000 (UTC)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04T8lgks079211;
 Fri, 29 May 2020 08:47:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=GGOp+xeMKyK3ISXC1WYVc0XAFo6EUiE0bM40mZxN7OM=;
 b=KX8n89wOFtdSunIRbJ0tPKEogd+L/7ASi+9jVHRSGcjpkw8hJPdxuGaLTrpPb+Drg9ds
 GPdPf8xMJOya5xqi/W7S1AdVeQsuk9vO3aae9LFiRV1TBhTVhBQ5KfwtE1FF/vW7Iw2d
 S20w89BuDBgb8V4exGpKAG2N0fKav5019dkVLZE+sRWPUsTWa3lKDK5aMEWUNCOaq+lI
 fJxPw+1FBrK1r4qjcfBnm4JQCPEY2BT65/bYQhvAoTIni9oMx09Z0khYFdp2yITIknjS
 NCKI9QMDtGcNTeQs0O+50sUm+VSGahi/cZSJJZxvzqYlocjbQNdNF0Rg9gKaarVrKRIp 8Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2130.oracle.com with ESMTP id 316u8r98ec-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 29 May 2020 08:47:42 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04T8gxo6184880;
 Fri, 29 May 2020 08:47:39 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3030.oracle.com with ESMTP id 317ds400qq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 29 May 2020 08:47:38 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04T8lav9000903;
 Fri, 29 May 2020 08:47:37 GMT
Received: from mwanda (/41.57.98.10) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 29 May 2020 01:47:36 -0700
Date: Fri, 29 May 2020 11:47:30 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: mukul.joshi@amd.com
Subject: [bug report] drm/amdkfd: Track SDMA utilization per process
Message-ID: <20200529084730.GA1299127@mwanda>
MIME-Version: 1.0
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9635
 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 malwarescore=0
 mlxlogscore=875 adultscore=0 suspectscore=3 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005290069
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9635
 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0
 priorityscore=1501 spamscore=0 cotscore=-2147483648 suspectscore=3
 phishscore=0 clxscore=1011 mlxlogscore=911 bulkscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005290070
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

Hello Mukul Joshi,

This is a semi-automatic email about new static checker warnings.

The patch 522b89c63370: "drm/amdkfd: Track SDMA utilization per 
process" from May 26, 2020, leads to the following Smatch complaint:

    drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_process.c:109 kfd_sdma_activity_worker()
    warn: variable dereferenced before check 'pdd' (see line 106)

    drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_process.c:109 kfd_sdma_activity_worker()
    warn: address of 'pdd->qpd' is non-NULL

drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_process.c
   105		pdd = workarea->pdd;
   106		dqm = pdd->dev->dqm;
                      ^^^^^^^^
Dereference.

   107		qpd = &pdd->qpd;
   108	
   109		if (!pdd || !dqm || !qpd)
                     ^^^             ^^^
pdd is checked too late and qpd can't possibly be NULL.

   110			return;
   111	

regards,
dan carpenter
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
