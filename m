Return-Path: <SRS0=FndT=ZH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F49C432C3
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 07:28:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D89D2073A
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 07:28:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D89D2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C2196E0C9;
	Fri, 15 Nov 2019 07:28:15 +0000 (UTC)
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECD246E0C9
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2019 07:28:13 +0000 (UTC)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAF7PK9L072180;
 Fri, 15 Nov 2019 07:27:56 GMT
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2120.oracle.com with ESMTP id 2w9gxphhd9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 15 Nov 2019 07:27:56 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAF7Oaj7014107;
 Fri, 15 Nov 2019 07:27:55 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3030.oracle.com with ESMTP id 2w9h141c2q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 15 Nov 2019 07:27:55 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xAF7Rmln025094;
 Fri, 15 Nov 2019 07:27:49 GMT
Received: from kili.mountain (/129.205.23.165)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 14 Nov 2019 23:27:48 -0800
Date: Fri, 15 Nov 2019 10:27:40 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 Junwei Zhang <Jerry.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Release the correct object on error in
 amdgpu_benchmark_move()
Message-ID: <20191115072740.4gznld4t3ngbmcsd@kili.mountain>
MIME-Version: 1.0
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9441
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911150066
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9441
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911150066
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=kShEmvEIV2LHdYJUNimhavJ4662/jmjscEAQx2pgszk=;
 b=fQyxU5mRGaf7tY/X2JzrhEINhg0bNSWueIFW7/U8PStiWRokqwTB2uOvuJDwwZWAkuuV
 EHtRTuNnHsALNxcpWAvYen8fJIj5azzu3OvfTftpb9ZMKakamCUT9wbEKXncTOCawxmO
 aHq/KHPp2rPS9G+xeo9yEJDBV8jYiC0YkMtrR7Wz8mUgHBhlauG7yhk+2RXNWx0fzqDV
 uQZieBOnc3Nv2MIe11D+miTldDfJYHL3f08pw/TCxHeVrB5V21g3jUGkE0N9gK5fIpTg
 1j7sJsO3GXk/kgAtBr5f0HRwlT/9ODP8NhF6yCLc+wOrSy39Tk9Ffe4A3q7VA9QS8c3A Kg== 
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
Cc: "David \(ChunMing\) Zhou" <David1.Zhou@amd.com>,
 David Airlie <airlied@linux.ie>, Felix Kuehling <Felix.Kuehling@amd.com>,
 kernel-janitors@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Pan Bian <bianpan2016@163.com>,
 Christian K??nig <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191115072740.cASqn1lrXWwo7frsesK9ADDRP6bOVvD957S1bxGNGqU@z>

VGhlcmUgaXMgYSB0eXBvIHNvIHRoaXMgdW5yZXNlcnZlcyAic29iaiIgaW5zdGVhZCBvZiAiZG9i
aiIuCgpGaXhlczogYmI4MTJmMWVhODdkICgiZHJtL2FtZGdwdTogYWxsb2NhdGUgZ2FydCBtZW1v
cnkgd2hlbiBpdCdzIHJlcXVpcmVkICh2MykiKQpTaWduZWQtb2ZmLWJ5OiBEYW4gQ2FycGVudGVy
IDxkYW4uY2FycGVudGVyQG9yYWNsZS5jb20+Ci0tLQpGcm9tIHN0YXRpYyBhbmFseXNpcy4gIE5v
dCB0ZXN0ZWQuCgogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2JlbmNobWFyay5j
IHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2JlbmNobWFyay5j
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2JlbmNobWFyay5jCmluZGV4IGQx
NDk1ZTFjOTI4OS4uNDNkOWQwM2JjN2U3IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfYmVuY2htYXJrLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2JlbmNobWFyay5jCkBAIC0xMTQsNyArMTE0LDcgQEAgc3RhdGljIHZvaWQgYW1k
Z3B1X2JlbmNobWFya19tb3ZlKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCB1bnNpZ25lZCBz
aXplLAogCQlnb3RvIG91dF9jbGVhbnVwOwogCXIgPSBhbWRncHVfYm9fcGluKGRvYmosIGRkb21h
aW4pOwogCWlmIChyKSB7Ci0JCWFtZGdwdV9ib191bnJlc2VydmUoc29iaik7CisJCWFtZGdwdV9i
b191bnJlc2VydmUoZG9iaik7CiAJCWdvdG8gb3V0X2NsZWFudXA7CiAJfQogCXIgPSBhbWRncHVf
dHRtX2FsbG9jX2dhcnQoJmRvYmotPnRibyk7Ci0tIAoyLjExLjAKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
