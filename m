Return-Path: <SRS0=bavc=6T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F39C47254
	for <amd-gfx@archiver.kernel.org>; Tue,  5 May 2020 12:40:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4070320746
	for <amd-gfx@archiver.kernel.org>; Tue,  5 May 2020 12:40:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="tGRGNBpF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4070320746
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E187E6E212;
	Tue,  5 May 2020 12:40:01 +0000 (UTC)
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F36C26E212
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 May 2020 12:39:59 +0000 (UTC)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 045CXav2048040;
 Tue, 5 May 2020 12:39:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=zr9TJX0UgWxw32J6fVKLtEwCcvg31U2kAG0T4bRjjRk=;
 b=tGRGNBpFfG0V7+fQ9qKKfwZ+F/iWtqjCGHt5qLL4yhuc2JBao96aqTybGLSl7J1neYEc
 OMW5hU8YVtFM6yyuxOF45AIukWsg2nweZDXbvvqbeld7sZzydOHsJETkYh+Fi6fXIw6I
 Y+/igbCVZ418Qeklng8kaJ5KCsMBHcCKU/HujJLrMI7/JXco+aFIpYKpL3zlY8YxGyzC
 V5Q1PFuSETDZkitxnZ+17Qfax9e1emjceK3ux7wbuMKOFWcmLLV1+zxEas+/4l/pJCda
 VZM9hxvKbAeqEvLX8dSdS5Co6MdI3JPMehz9HOcXNhBQ7Pl5hbSSiI5HKZ2x6YZN8SIw Zw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2130.oracle.com with ESMTP id 30s09r4ea4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 05 May 2020 12:39:55 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 045CarZH131976;
 Tue, 5 May 2020 12:37:55 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3030.oracle.com with ESMTP id 30sjdsxkbd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 05 May 2020 12:37:54 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 045Cbqte023844;
 Tue, 5 May 2020 12:37:53 GMT
Received: from kadam (/41.57.98.10) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 05 May 2020 05:37:52 -0700
Date: Tue, 5 May 2020 15:37:46 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: xinhui.pan@amd.com
Subject: Re: [bug report] drm/amdgpu: add amdgpu_ras.c to support ras (v2)
Message-ID: <20200505123746.GF1992@kadam>
References: <20200505091239.GA117990@mwanda>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200505091239.GA117990@mwanda>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9611
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=1 mlxscore=0
 bulkscore=0 adultscore=0 phishscore=0 mlxlogscore=930 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005050100
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9611
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 clxscore=1015 suspectscore=1
 priorityscore=1501 malwarescore=0 mlxlogscore=978 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005050100
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

Here are a couple more:

drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:534 amdgpu_ras_is_feature_allowed() error: undefined (user controlled) shift '(((1))) << (head->block)'
drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:542 amdgpu_ras_is_feature_enabled() error: undefined (user controlled) shift '(((1))) << (head->block)'

regards,
dan carpenter

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
