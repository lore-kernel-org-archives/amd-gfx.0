Return-Path: <SRS0=eSA1=JK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D792EC433B4
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Apr 2021 09:45:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EA54613B6
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Apr 2021 09:45:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EA54613B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D04B6E17F;
	Tue, 13 Apr 2021 09:45:08 +0000 (UTC)
Received: from aserp2130.oracle.com (aserp2130.oracle.com [141.146.126.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BA8A6E17F
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Apr 2021 09:45:07 +0000 (UTC)
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13D9TZJW138108;
 Tue, 13 Apr 2021 09:45:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=viHfCiHXuKXJ6QWQdKKYnbca6eS13KAeGS8MNUQLQMA=;
 b=y5R6HbtbBWTxMi9T1NtZnWg9glVmOy+MJuggM6WSSD4FQHJiLn01I3Iqpj0ua0P0a0rj
 f96NYsOE+ZH4Fv5SUWEpb0PQrhl0s4B2a/G1DKutp1z9/b+7ptX2C/3fp6P5MCNJexJm
 jD0yiu/0BCuozSs2E0MjTBnmltSBOBreKT68iy4MZnQ7QUeauejFpdropUsYy3Utblz9
 4nexZTltKQpFUFsFxpzsomD8GWAotH/RQRnCQee/ux823h3alcH1vDsO+nDN5Mgsy4mD
 DZCheVjcDjuJ/clIQHG7BQsiC21fUoCX0gEsDLqm1IElLPZIbvQ3Krd/a5KLPRVhbx0l NA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by aserp2130.oracle.com with ESMTP id 37u1hbem28-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 13 Apr 2021 09:45:02 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13D9UMHP156907;
 Tue, 13 Apr 2021 09:45:00 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3030.oracle.com with ESMTP id 37unxwmevn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 13 Apr 2021 09:45:00 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 13D9ix72019134;
 Tue, 13 Apr 2021 09:44:59 GMT
Received: from mwanda (/102.36.221.92) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 13 Apr 2021 02:44:58 -0700
Date: Tue, 13 Apr 2021 12:44:48 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: john.clements@amd.com
Subject: [bug report] drm/amdgpu: page retire over debugfs mechanism
Message-ID: <YHVoEIX8Ko2C+5Ke@mwanda>
MIME-Version: 1.0
Content-Disposition: inline
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9952
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 bulkscore=0 malwarescore=0
 spamscore=0 adultscore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104130065
X-Proofpoint-GUID: VKspokbuZWoKMkDl8twc6JlMhkcbH6pn
X-Proofpoint-ORIG-GUID: VKspokbuZWoKMkDl8twc6JlMhkcbH6pn
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9952
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 priorityscore=1501
 clxscore=1011 adultscore=0 mlxlogscore=999 impostorscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104130065
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

Hello John Clements,

The patch cbb8f989d5a0: "drm/amdgpu: page retire over debugfs
mechanism" from Apr 9, 2021, leads to the following static checker
warning:

	drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:377 amdgpu_ras_debugfs_ctrl_write()
	info: return a literal instead of 'ret'

drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
   366          ret = amdgpu_ras_debugfs_ctrl_parse_data(f, buf, size, pos, &data);
   367          if (ret)
   368                  return -EINVAL;
   369  
   370          if (data.op == 3)
   371          {
                ^
Please use scripts/checkpatch.pl...  :(  Bonus points for replacing the
magic number 3 with a define?

   372                  ret = amdgpu_reserve_page_direct(adev, data.inject.address);
   373  
   374                  if (ret)
   375                          return size;
   376                  else
   377                          return ret;

This static checker warning is disguised as a style warning, but it's
really to detect code like this where the if statements are reversed as
appears to be the case here.

		ret = amdgpu_reserve_page_direct(adev, data.inject.address);
		if (ret)
			return ret;

		return size;

   378          }
   379  
   380          if (!amdgpu_ras_is_supported(adev, data.head.block))
   381                  return -EINVAL;

regards,
dan carpenter
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
