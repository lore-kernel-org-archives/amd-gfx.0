Return-Path: <SRS0=NdEU=ZS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF83C43215
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Nov 2019 12:13:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BBF82075C
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Nov 2019 12:13:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BBF82075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 356BB6E2FF;
	Tue, 26 Nov 2019 12:13:32 +0000 (UTC)
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5951689C37
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Nov 2019 12:13:30 +0000 (UTC)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAQC8qCq110989;
 Tue, 26 Nov 2019 12:13:27 GMT
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by aserp2120.oracle.com with ESMTP id 2wevqq6e09-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 26 Nov 2019 12:13:27 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAQC8jAc033385;
 Tue, 26 Nov 2019 12:13:26 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3030.oracle.com with ESMTP id 2wgvh9w5w7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 26 Nov 2019 12:13:26 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xAQCDPjf020044;
 Tue, 26 Nov 2019 12:13:25 GMT
Received: from kili.mountain (/129.205.23.165)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 26 Nov 2019 04:13:24 -0800
Date: Tue, 26 Nov 2019 15:13:17 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: leo.liu@amd.com
Subject: [bug report] drm/amdgpu: add initial VCN2.0 support (v2)
Message-ID: <20191126121317.vlczon6in5gystl3@kili.mountain>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9452
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=665
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911260110
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9452
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=727 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911260110
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=+Ew1A6llv7yBFx5CI5RV4GMRUEtDL1E5W97Eh/G9cUQ=;
 b=sCJcv6qeXl4raIU5KNgQbv+yk8CT7ZZw0oH6WLJVOTeFb/t6rQfTUp0jcysOjicuZcon
 MXM8QTTUDf/fVd1iQEM5ji1/LUuSGiABFig2NNVTeL5EWcmIEyNXGrixjP8InrsgnRD/
 j5ZUoj7tqoWu/1/CVkqREOcPH5CrjRf6kz2NfXto/x5610ptdfykDn7vdThUq/jQJHkY
 QmoIboxJrdO546h9awjhEVnORQ5tURSGrriw06rbOH0+gKtiUSKjSBohgf4Fx9TXpSPG
 G1Gxv/DcV5JcCQ6yaVT81y0mCD8FrQ/9Mu4Mo7BTkerL1XaM2aezAbD+vzpbB7rRLuE8 qw== 
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191126121317.MiX7XSfIlpegrtDrdWXozWGYAA5ofybqM_Zk8deapLE@z>

SGVsbG8gTGVvIExpdSwKClRoZSBwYXRjaCAxYjYxZGU0NWRmYWY6ICJkcm0vYW1kZ3B1OiBhZGQg
aW5pdGlhbCBWQ04yLjAgc3VwcG9ydCAodjIpIgpmcm9tIE9jdCAxNSwgMjAxOCwgbGVhZHMgdG8g
dGhlIGZvbGxvd2luZyBzdGF0aWMgY2hlY2tlciB3YXJuaW5nOgoKCWRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L3Zjbl92Ml8wLmM6MTA4MyB2Y25fdjJfMF9zdG9wKCkKCWVycm9yOiB1bmluaXRp
YWxpemVkIHN5bWJvbCAncicuCgpkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y25fdjJfMC5j
CiAgMTA2OSAgc3RhdGljIGludCB2Y25fdjJfMF9zdG9wKHN0cnVjdCBhbWRncHVfZGV2aWNlICph
ZGV2KQogIDEwNzAgIHsKICAxMDcxICAgICAgICAgIHVpbnQzMl90IHRtcDsKICAxMDcyICAgICAg
ICAgIGludCByOwogIDEwNzMgIAogIDEwNzQgICAgICAgICAgaWYgKGFkZXYtPnBnX2ZsYWdzICYg
QU1EX1BHX1NVUFBPUlRfVkNOX0RQRykgewogIDEwNzUgICAgICAgICAgICAgICAgICByID0gdmNu
X3YyXzBfc3RvcF9kcGdfbW9kZShhZGV2KTsKICAxMDc2ICAgICAgICAgICAgICAgICAgaWYgKHIp
CiAgMTA3NyAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIHI7CiAgMTA3OCAgICAgICAg
ICAgICAgICAgIGdvdG8gcG93ZXJfb2ZmOwogIDEwNzkgICAgICAgICAgfQogIDEwODAgIAogIDEw
ODEgICAgICAgICAgLyogd2FpdCBmb3IgdXZkIGlkbGUgKi8KICAxMDgyICAgICAgICAgIFNPQzE1
X1dBSVRfT05fUlJFRyhWQ04sIDAsIG1tVVZEX1NUQVRVUywgVVZEX1NUQVRVU19fSURMRSwgMHg3
LCByKTsKICAxMDgzICAgICAgICAgIGlmIChyKQoKciBpcyBvbmx5IHNldCBvbiBlcnJvciwgbm90
IHN1Y2Nlc3MuCgogIDEwODQgICAgICAgICAgICAgICAgICByZXR1cm4gcjsKICAxMDg1ICAKICAx
MDg2ICAgICAgICAgIHRtcCA9IFVWRF9MTUlfU1RBVFVTX19WQ1BVX0xNSV9XUklURV9DTEVBTl9N
QVNLIHwKICAxMDg3ICAgICAgICAgICAgICAgICAgVVZEX0xNSV9TVEFUVVNfX1JFQURfQ0xFQU5f
TUFTSyB8CiAgMTA4OCAgICAgICAgICAgICAgICAgIFVWRF9MTUlfU1RBVFVTX19XUklURV9DTEVB
Tl9NQVNLIHwKICAxMDg5ICAgICAgICAgICAgICAgICAgVVZEX0xNSV9TVEFUVVNfX1dSSVRFX0NM
RUFOX1JBV19NQVNLOwogIDEwOTAgICAgICAgICAgU09DMTVfV0FJVF9PTl9SUkVHKFZDTiwgMCwg
bW1VVkRfTE1JX1NUQVRVUywgdG1wLCB0bXAsIHIpOwogIDEwOTEgICAgICAgICAgaWYgKHIpCiAg
MTA5MiAgICAgICAgICAgICAgICAgIHJldHVybiByOwoKcmVnYXJkcywKZGFuIGNhcnBlbnRlcgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1h
aWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
