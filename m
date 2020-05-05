Return-Path: <SRS0=bavc=6T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6CEAC47254
	for <amd-gfx@archiver.kernel.org>; Tue,  5 May 2020 09:12:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8870F206A4
	for <amd-gfx@archiver.kernel.org>; Tue,  5 May 2020 09:12:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="z57iqsl5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8870F206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B90B6E581;
	Tue,  5 May 2020 09:12:50 +0000 (UTC)
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38BCF6E581
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 May 2020 09:12:49 +0000 (UTC)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04597baW098270;
 Tue, 5 May 2020 09:12:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=JD3EzMFrjg+I00Sw6a33/2ygB5SEGRKsBEQm33OI+4E=;
 b=z57iqsl5dOaHmxp04gjHQI+ab22ZxuWH6uob0oajIRCMhom0UY7jvYp9wmss9SLI5TUN
 v0SISckp2l6Khkrr6M+Jzk94cDkoEzJcbuK0QIBZhqr+2omkzW+E69f6eIcCtQGfB5eN
 lhs70WQ4YYm+sCDw54lg4HEGl5ARsmbdMo/SXlkpDrH2EA/mUUUM0ZsoqFN371TEXys1
 aSU5DLqLVWodhh3OHsq1iNPGK8+NotrIlCCI2yNCsP5L+9oanh2cTVSplut8KKYYgcK9
 ee+IWBLWe6SL97KESkTJsR64CujI+gCwTRoyjVYvyIkCyKfjnWZjW6Uvt4eqp0hfNUPG zg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2130.oracle.com with ESMTP id 30s09r3kyj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 05 May 2020 09:12:45 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04596sHR143856;
 Tue, 5 May 2020 09:12:44 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3030.oracle.com with ESMTP id 30sjdskcac-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 05 May 2020 09:12:44 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0459CiP4012726;
 Tue, 5 May 2020 09:12:44 GMT
Received: from mwanda (/41.57.98.10) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 05 May 2020 02:12:43 -0700
Date: Tue, 5 May 2020 12:12:39 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: xinhui.pan@amd.com
Subject: [bug report] drm/amdgpu: add amdgpu_ras.c to support ras (v2)
Message-ID: <20200505091239.GA117990@mwanda>
MIME-Version: 1.0
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9611
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=3 mlxscore=0
 bulkscore=0 adultscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005050074
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9611
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 clxscore=1011 suspectscore=3
 priorityscore=1501 malwarescore=0 mlxlogscore=999 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005050074
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

Hello xinhui pan,

The patch c030f2e4166c: "drm/amdgpu: add amdgpu_ras.c to support ras
(v2)" from Oct 31, 2018, leads to the following static checker
warning:

	drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:620 amdgpu_ras_feature_enable()
	warn: uncapped user index 'ras_block_string[head->block]'

drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
   587  int amdgpu_ras_feature_enable(struct amdgpu_device *adev,
   588                  struct ras_common_if *head, bool enable)
   589  {
   590          struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
   591          union ta_ras_cmd_input info;
   592          int ret;
   593  
   594          if (!con)
   595                  return -EINVAL;
   596  
   597          if (!enable) {
   598                  info.disable_features = (struct ta_ras_disable_features_input) {
   599                          .block_id =  amdgpu_ras_block_to_ta(head->block),
   600                          .error_type = amdgpu_ras_error_to_ta(head->type),
   601                  };
   602          } else {
   603                  info.enable_features = (struct ta_ras_enable_features_input) {
   604                          .block_id =  amdgpu_ras_block_to_ta(head->block),
   605                          .error_type = amdgpu_ras_error_to_ta(head->type),
   606                  };
   607          }
   608  
   609          /* Do not enable if it is not allowed. */
   610          WARN_ON(enable && !amdgpu_ras_is_feature_allowed(adev, head));
   611          /* Are we alerady in that state we are going to set? */
   612          if (!(!!enable ^ !!amdgpu_ras_is_feature_enabled(adev, head)))
   613                  return 0;
   614  
   615          if (!amdgpu_ras_intr_triggered()) {
   616                  ret = psp_ras_enable_features(&adev->psp, &info, enable);
   617                  if (ret) {
   618                          amdgpu_ras_parse_status_code(adev,
   619                                                       enable ? "enable":"disable",
   620                                                       ras_block_str(head->block),
                                                                           ^^^^^^^^^^^
The head->block value can be set to anything using debugfs.  That's a
problem because it could easily lead to a kernel panic (which is
annoying) and also because these days we try to restrict what root can
do.

   621                                                      (enum ta_ras_status)ret);
   622                          if (ret == TA_RAS_STATUS__RESET_NEEDED)
   623                                  return -EAGAIN;
   624                          return -EINVAL;
   625                  }
   626          }
   627  
   628          /* setup the obj */
   629          __amdgpu_ras_feature_enable(adev, head, enable);
   630  
   631          return 0;
   632  }

regards,
dan carpenter
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
