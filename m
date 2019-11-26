Return-Path: <SRS0=NdEU=ZS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDCEBC432C0
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Nov 2019 04:51:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B274020637
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Nov 2019 04:51:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B274020637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 566806E1F6;
	Tue, 26 Nov 2019 04:51:16 +0000 (UTC)
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E70D6E1F6
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Nov 2019 04:51:15 +0000 (UTC)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAQ4nes6116453;
 Tue, 26 Nov 2019 04:51:10 GMT
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2120.oracle.com with ESMTP id 2wewdr405f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 26 Nov 2019 04:51:10 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAQ4n97N178773;
 Tue, 26 Nov 2019 04:51:09 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3030.oracle.com with ESMTP id 2wfex7g9k8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 26 Nov 2019 04:51:09 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xAQ4p6ek017322;
 Tue, 26 Nov 2019 04:51:07 GMT
Received: from kili.mountain (/129.205.23.165)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 25 Nov 2019 20:51:05 -0800
Date: Tue, 26 Nov 2019 07:50:59 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: christian.koenig@amd.com
Subject: [bug report] drm/radeon: never unpin UVD bo v3
Message-ID: <20191126045059.xod22qsrqrh3n22l@kili.mountain>
MIME-Version: 1.0
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9452
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=270
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911260039
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9452
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=325 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911260039
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=SJHnKpS6DIXYe2ph5SuxZ9ZVHhgeKakWyZ/2ZkFkwbs=;
 b=mJGO4OPz9zwGV5A/MB6s2pSJDNKExrsPKPRGlvjykbPtLtHODLV3B+vDYwNWv96pG6RL
 ZX5pRuX7Ox5iMH/sDDatLXVvK2Jl4qnJ2oPHXB7hrKj4rabWeYlIcwp3cmwkqQbhxBOU
 SF5Nl9Zi/eqNOS3VTBFhI9HbB0WxDHduOt4xgOZLuQHQNi8G1uPxxcF5+HmpnZwDdIdV
 ncSe/eWEcwDh7zvm5I0GMD1tBq9OFNJqkkm5tywN/V8wnJZ3V2cf6cm99IxWBRKoVYO+
 it2l70xOPZBx+W/C3vgYDbZRt+0G4mIHVBdkhNQipaLeCUM6hGgOOBi6PYj5FbamqgqF 7g== 
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
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
Content-Type: multipart/mixed; boundary="===============0315566366=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191126045059.bU7qi17AR3lfN9N6DZQRa2mqcEtld2b9oKz3affxRwc@z>

--===============0315566366==
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hello Christian König,

The patch 9cc2e0e9f133: "drm/radeon: never unpin UVD bo v3" from Jul
12, 2013, leads to the following static checker warning:

	drivers/gpu/drm/radeon/radeon_uvd.c:225 radeon_uvd_init()
	warn: inconsistent returns '*rdev->uvd.vcpu_bo->tbo.base.resv'.

drivers/gpu/drm/radeon/radeon_uvd.c
   195          r = radeon_bo_reserve(rdev->uvd.vcpu_bo, false);
                ^^^^^^^^^^^^^^^^^^^^^^
   196          if (r) {
   197                  radeon_bo_unref(&rdev->uvd.vcpu_bo);
   198                  dev_err(rdev->dev, "(%d) failed to reserve UVD bo\n", r);
   199                  return r;
   200          }
   201  
   202          r = radeon_bo_pin(rdev->uvd.vcpu_bo, RADEON_GEM_DOMAIN_VRAM,
   203                            &rdev->uvd.gpu_addr);
   204          if (r) {
   205                  radeon_bo_unreserve(rdev->uvd.vcpu_bo);
                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
   206                  radeon_bo_unref(&rdev->uvd.vcpu_bo);
   207                  dev_err(rdev->dev, "(%d) UVD bo pin failed\n", r);
   208                  return r;
   209          }
   210  
   211          r = radeon_bo_kmap(rdev->uvd.vcpu_bo, &rdev->uvd.cpu_addr);
   212          if (r) {
   213                  dev_err(rdev->dev, "(%d) UVD map failed\n", r);
   214                  return r;
                        ^^^^^^^^
Do we have to unreserve this?

   215          }
   216  
   217          radeon_bo_unreserve(rdev->uvd.vcpu_bo);
   218  
   219          for (i = 0; i < rdev->uvd.max_handles; ++i) {
   220                  atomic_set(&rdev->uvd.handles[i], 0);
   221                  rdev->uvd.filp[i] = NULL;
   222                  rdev->uvd.img_size[i] = 0;
   223          }
   224  
   225          return 0;


regards,
dan carpenter

--===============0315566366==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0315566366==--
