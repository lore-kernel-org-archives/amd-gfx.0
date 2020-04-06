Return-Path: <SRS0=+i0l=5W=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C72C2BA19
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Apr 2020 11:43:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 353D0206C3
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Apr 2020 11:43:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SraRxc1/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 353D0206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDC4589DC0;
	Mon,  6 Apr 2020 11:43:54 +0000 (UTC)
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CF6989DC0
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Apr 2020 11:43:53 +0000 (UTC)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 036BhR59022781;
 Mon, 6 Apr 2020 11:43:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=MMNugVTmCgdLiFUI5tCluolzt5dezr5sh7pgKbpR7/8=;
 b=SraRxc1/UpY8Jq/uNdCpWOvclR0xN4IxbyFPA8JYiwCP8V5ok/VH8azVfhdXGOuAHha5
 76iTBTSC7xcBKoLLXozdH3n1q9JWXhZtB3uHt0pHgzduCCwSSKyry7FsZaWGwAux9kaw
 0bPl+RHDDZg9uKDAMXWltgFQFUmL649C1/faTkK2I3O3lmlMhPTIpTPaaUE6HAbcm2Vw
 7fbTyG/+6B8ePorf11JzyJnViqLkcBa2FJkuEAo6auxOsepUZLHgSOi0UcAW1BBEuAyW
 Sys1hH6HqXn0c9fzkY2VXQuqaHlj3DWbXTGohtgdbu+B3+s7GYrvRyx8ZyUOlI0DsiUA 6w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2120.oracle.com with ESMTP id 306jvmx7cy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 06 Apr 2020 11:43:50 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 036BgZ7k067081;
 Mon, 6 Apr 2020 11:43:50 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3030.oracle.com with ESMTP id 3073sps8ws-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 06 Apr 2020 11:43:50 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 036BhnbP006063;
 Mon, 6 Apr 2020 11:43:49 GMT
Received: from mwanda (/41.57.98.10) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 06 Apr 2020 04:43:48 -0700
Date: Mon, 6 Apr 2020 14:43:43 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: wyatt.wood@amd.com
Subject: [bug report] drm/amd/display: Add ABM driver implementation
Message-ID: <20200406114343.GA40464@mwanda>
MIME-Version: 1.0
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9582
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 phishscore=0 spamscore=0
 malwarescore=0 suspectscore=3 adultscore=0 bulkscore=0 mlxlogscore=987
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004060103
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9582
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 suspectscore=3
 mlxlogscore=999 mlxscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004060103
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

Hello Wyatt Wood,

This is a semi-automatic email about new static checker warnings.

The patch 16012806e697: "drm/amd/display: Add ABM driver
implementation" from Feb 20, 2020, leads to the following Smatch
complaint:

    drivers/gpu/drm/amd/amdgpu/../display/modules/power/power_helpers.c:661 dmcu_load_iram()
    warn: variable dereferenced before check 'dmcu' (see line 659)

drivers/gpu/drm/amd/amdgpu/../display/modules/power/power_helpers.c
   658		bool result = false;
   659		struct abm *abm = dmcu->ctx->dc->res_pool->abm;
                                  ^^^^^^
The patch adds a dereference

   660	
   661		if (dmcu == NULL && abm == NULL)
                    ^^^^^^^^^^^^

   662			return false;
   663	
   664          if (dmcu && !dmcu->funcs->is_dmcu_initialized(dmcu))
                    ^^^^
And it also adds NULL checking on dmcu.

   665                  return true;
   666  
   667          memset(&ram_table, 0, sizeof(ram_table));
   668  

regards,
dan carpenter
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
