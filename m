Return-Path: <SRS0=dvhx=GP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,BIGNUM_EMAILS,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C8AC433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jan 2021 09:10:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A107C22D2A
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jan 2021 09:10:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A107C22D2A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A462D6E177;
	Tue, 12 Jan 2021 09:10:40 +0000 (UTC)
Received: from aserp2130.oracle.com (aserp2130.oracle.com [141.146.126.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D5756E171
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Jan 2021 09:10:39 +0000 (UTC)
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10C95Vsp089588;
 Tue, 12 Jan 2021 09:10:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=l3WIKeXpc0tlVXoI11Q/j58MFqziQd+s/dyD5AMW3XI=;
 b=CacPqTFbAUYvouOz2uWsvlzUQtK30j/j/MH9D0XvtKKAJrEta0eG5G3mrTYWxNH4e3jm
 85LTWvPFcZ2b2HDkNSwrNi970KhxELGPPvwRh1CwelmwWns8fqA2hmvTQqw9eRKj/T4W
 BKX/NPPz0YTI3BVnDO5x3Me/3Di86uKEgbYPIEuaKQtIL+cAuzVmBAMQ/xHga3MMkNyI
 J6djTvDeLiKjeSbKgugWAwNjoKFBHmUzmGTMnf7DG54+jpkERKaloMduv530Sr3tVWy1
 5YzmL5bjWWulE2vFwS2R08TtzwsTqJU15Ev2qV7z870tFrTvNk154Cxq8a1HY1ufxCvA 2g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by aserp2130.oracle.com with ESMTP id 360kg1n85w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 12 Jan 2021 09:10:35 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10C94Sr4016340;
 Tue, 12 Jan 2021 09:10:34 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3020.oracle.com with ESMTP id 360kf534c7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 12 Jan 2021 09:10:34 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 10C9AS0X018424;
 Tue, 12 Jan 2021 09:10:28 GMT
Received: from mwanda (/102.36.221.92) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 12 Jan 2021 01:10:28 -0800
Date: Tue, 12 Jan 2021 12:10:22 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Xiaojian.Du@amd.com
Subject: [bug report] drm/amd/pm: add the parameters of power profiles for
 vangogh
Message-ID: <X/1nfini+LArqHmE@mwanda>
MIME-Version: 1.0
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9861
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101120051
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9861
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 suspectscore=0
 clxscore=1011 impostorscore=0 spamscore=0 priorityscore=1501 mlxscore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101120051
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

Hello Xiaojian Du,

The patch 307f049bfcad: "drm/amd/pm: add the parameters of power
profiles for vangogh" from Jan 7, 2021, leads to the following static
checker warning:

	drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu11/vangogh_ppt.c:801 vangogh_get_power_profile_mode()
	error: buffer overflow 'profile_name' 5 <= 6

drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu11/vangogh_ppt.c
   773  static int vangogh_get_power_profile_mode(struct smu_context *smu,
   774                                             char *buf)
   775  {
   776          static const char *profile_name[] = {
   777                                          "FULL_SCREEN_3D",
   778                                          "VIDEO",
   779                                          "VR",
   780                                          "COMPUTE",
   781                                          "CUSTOM"};

This list leaves out DEFAULT and POWERSAVING profiles, so I don't think
it's correct.

   782          uint32_t i, size = 0;
   783          int16_t workload_type = 0;
   784  
   785          if (!buf)
   786                  return -EINVAL;
   787  
   788          for (i = 0; i <= PP_SMC_POWER_PROFILE_CUSTOM; i++) {
   789                  /*
   790                   * Conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT
   791                   * Not all profile modes are supported on vangogh.
   792                   */
   793                  workload_type = smu_cmn_to_asic_specific_index(smu,
   794                                                                 CMN2ASIC_MAPPING_WORKLOAD,
   795                                                                 i);
   796  
   797                  if (workload_type < 0)
   798                          continue;
   799  
   800                  size += sprintf(buf + size, "%2d %14s%s\n",
   801                          i, profile_name[i], (i == smu->power_profile_mode) ? "*" : " ");
                                   ^^^^^^^^^^^^^^^
Also it leads to an array overflow.

   802          }
   803  
   804          return size;
   805  }

regards,
dan carpenter
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
