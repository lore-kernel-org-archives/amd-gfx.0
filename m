Return-Path: <SRS0=QenQ=FP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,BIGNUM_EMAILS,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D57F9C433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Dec 2020 10:24:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 757A023C82
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Dec 2020 10:24:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 757A023C82
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 148B06ED80;
	Fri, 11 Dec 2020 10:24:02 +0000 (UTC)
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 961656ED80
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Dec 2020 10:24:00 +0000 (UTC)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BBANdbT165539;
 Fri, 11 Dec 2020 10:23:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=fejwFdDPmQ4t/DDGC+Wt1NYIwdlW+XHbeTvH0GnIQAw=;
 b=OpV3+xCBgsoiFrqSS6ObYn7BFdDSCIbR3zNaXDW1whkPPc0dCXPGtJR7yezXbtmGQ/8B
 wEsq8XVHX2k47iMtnvK4RAsEbdPr31l3+SSssV1DE/OW5fp27q74yTCatnXP//Yy1L7A
 VOD/3fTIpFwbvhjJoLlOEHneYl4PZnrYsvLnx5pcCx/FTKokloe/n6Aw936oBMI2PyjS
 rUryFPfF105nUgOkE0TfV0PBoXig86h+mHop7Mp/f4qyNafNtCfYVNi1vXqJaj6D51b4
 GzOrXZUy5USly7WzvlXwke5rCuTK0KscIhLBzGTK087tYKnQwqBtTimnRHji1FQeb8TA pw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by aserp2120.oracle.com with ESMTP id 35825mhych-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 11 Dec 2020 10:23:58 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BBAEohJ160562;
 Fri, 11 Dec 2020 10:23:57 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3020.oracle.com with ESMTP id 358kyxsegn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 11 Dec 2020 10:23:57 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0BBANsln022434;
 Fri, 11 Dec 2020 10:23:54 GMT
Received: from mwanda (/102.36.221.92) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 11 Dec 2020 02:23:53 -0800
Date: Fri, 11 Dec 2020 13:23:47 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Reza.Amini@amd.com
Subject: [bug report] drm/amd/display: Implement VSIF V3 extended refresh
 rate feature
Message-ID: <X9NIswZNSeghVkLG@mwanda>
MIME-Version: 1.0
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9831
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 spamscore=0 mlxscore=0
 malwarescore=0 suspectscore=3 mlxlogscore=691 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012110063
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9831
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3
 adultscore=0 bulkscore=0
 phishscore=0 mlxlogscore=677 clxscore=1011 priorityscore=1501 mlxscore=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012110064
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

Hello Reza Amini,

The patch 9bc416266582: "drm/amd/display: Implement VSIF V3 extended
refresh rate feature" from Jul 9, 2020, leads to the following static
checker warning:

	drivers/gpu/drm/amd/amdgpu/../display/modules/freesync/freesync.c:617 build_vrr_infopacket_data_v3()
	warn: both sides of ternary the same: 'max_refresh' max_refresh max_refresh

drivers/gpu/drm/amd/amdgpu/../display/modules/freesync/freesync.c
   606  
   607          min_refresh = (vrr->min_refresh_in_uhz + 500000) / 1000000;
   608          max_refresh = (vrr->max_refresh_in_uhz + 500000) / 1000000;
   609          fixed_refresh = (vrr->fixed_refresh_in_uhz + 500000) / 1000000;
   610  
   611          min_programmed = (vrr->state == VRR_STATE_ACTIVE_FIXED) ? fixed_refresh :
   612                          (vrr->state == VRR_STATE_ACTIVE_VARIABLE) ? min_refresh :
   613                          (vrr->state == VRR_STATE_INACTIVE) ? min_refresh :
   614                          max_refresh; // Non-fs case, program nominal range
   615  
   616          max_programmed = (vrr->state == VRR_STATE_ACTIVE_FIXED) ? fixed_refresh :
   617                          (vrr->state == VRR_STATE_ACTIVE_VARIABLE) ? max_refresh :
                                                                            ^^^^^^^^^^^
Probably "min_refresh" was intended here?

   618                          max_refresh;// Non-fs case, program nominal range
                                ^^^^^^^^^^^

   619  
   620          /* PB7 = FreeSync Minimum refresh rate (Hz) */
   621          infopacket->sb[7] = min_programmed & 0xFF;
   622  
   623          /* PB8 = FreeSync Maximum refresh rate (Hz) */
   624          infopacket->sb[8] = max_programmed & 0xFF;
   625  

regards,
dan carpenter
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
