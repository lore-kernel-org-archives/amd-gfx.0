Return-Path: <SRS0=4UxD=ZF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D98C432C3
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2019 18:33:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 225FB2068F
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2019 18:33:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 225FB2068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70B846EDE7;
	Wed, 13 Nov 2019 18:33:37 +0000 (UTC)
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 680AC6EDF9
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Nov 2019 18:33:35 +0000 (UTC)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xADIT0ar097482;
 Wed, 13 Nov 2019 18:33:33 GMT
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2120.oracle.com with ESMTP id 2w5p3qxas9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 13 Nov 2019 18:33:33 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xADIT1Qb160547;
 Wed, 13 Nov 2019 18:33:33 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3030.oracle.com with ESMTP id 2w7vppqxc5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 13 Nov 2019 18:33:32 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xADIXVqF024240;
 Wed, 13 Nov 2019 18:33:31 GMT
Received: from kili.mountain (/129.205.23.165) by default (Oracle Beehive
 Gateway v4.0) with ESMTP ; Wed, 13 Nov 2019 10:32:42 -0800
USER-AGENT: NeoMutt/20170113 (1.7.2)
MIME-Version: 1.0
Message-ID: <20191113183236.tieyl67afjy5so55@kili.mountain>
Date: Wed, 13 Nov 2019 10:32:36 -0800 (PST)
From: Dan Carpenter <dan.carpenter@oracle.com>
To: nicholas.kazlauskas@amd.com
Subject: [bug report] drm/amd/display: Register DMUB service with DC
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9440
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=439
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1910280000 definitions=main-1911130158
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9440
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=503 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1910280000
 definitions=main-1911130158
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.com; h=mime-version :
 message-id : date : from : to : cc : subject : content-type :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=yNcaewiQr4qtKmEWTwzXlcmpJUGdq17UFUfoNSHMI4k=;
 b=GkRxAIitQkIFzghk6zOqdnVrDuCO4tH2vuLXvym3ZfcUSXbbszrudOSvaDezN2CTsVv9
 aXfxoS6uD1Docu7jii09uRrLyo+aFdWHdbspfKnZrnbgagDaP1HEnvp6gX5RzryHJU1Y
 U9vPnGytEdrSsegpqkbkQIvn/nyLqDqjjZZwhj7fNzn2/ySSgDIkAGHqwPrqOvDiCJW7
 ilvBAhygjwQFmtGQ2Osq3y+uwYR+2SASumxlCpg7ovKnYz5+S4sPNVd08YAUQ95ANwUu
 tpqtKj+Y5h8qv2K8ONZvyB4CdNa1t46ZPZ7VgcXJn5izCfcqtaE2Ei0Gj9kaO4+QYb80 +w== 
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
Message-ID: <20191113183236.R5SD9iv4apaUQ3qvsLKnD1njP-J6MvztMA3kq-2yQL8@z>

SGVsbG8gTmljaG9sYXMgS2F6bGF1c2thcywKClRoaXMgaXMgYSBzZW1pLWF1dG9tYXRpYyBlbWFp
bCBhYm91dCBuZXcgc3RhdGljIGNoZWNrZXIgd2FybmluZ3MuCgpUaGUgcGF0Y2ggMGY4MGU3Y2Rj
MDEyOiAiZHJtL2FtZC9kaXNwbGF5OiBSZWdpc3RlciBETVVCIHNlcnZpY2Ugd2l0aCAKREMiIGZy
b20gT2N0IDI4LCAyMDE5LCBsZWFkcyB0byB0aGUgZm9sbG93aW5nIFNtYXRjaCBjb21wbGFpbnQ6
CgogICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9hbWRncHVfZG0vYW1k
Z3B1X2RtLmM6MTA0OSBhbWRncHVfZG1fZmluaSgpCiAgICAgd2FybjogdmFyaWFibGUgZGVyZWZl
cmVuY2VkIGJlZm9yZSBjaGVjayAnYWRldi0+ZG0uZGMnIChzZWUgbGluZSAxMDM4KQoKZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMKICAx
MDI5ICAjaWZkZWYgQ09ORklHX0RSTV9BTURfRENfSERDUAogIDEwMzAgICAgICAgICAgaWYgKGFk
ZXYtPmRtLmhkY3Bfd29ya3F1ZXVlKSB7CiAgMTAzMSAgICAgICAgICAgICAgICAgIGhkY3BfZGVz
dHJveShhZGV2LT5kbS5oZGNwX3dvcmtxdWV1ZSk7CiAgMTAzMiAgICAgICAgICAgICAgICAgIGFk
ZXYtPmRtLmhkY3Bfd29ya3F1ZXVlID0gTlVMTDsKICAxMDMzICAgICAgICAgIH0KICAxMDM0ICAK
ICAxMDM1ICAgICAgICAgIGlmIChhZGV2LT5kbS5kYykKICAgICAgICAgICAgICAgICAgICBeXl5e
Xl5eXl5eXgpDaGVjawoKICAxMDM2ICAgICAgICAgICAgICAgICAgZGNfZGVpbml0X2NhbGxiYWNr
cyhhZGV2LT5kbS5kYyk7CiAgMTAzNwkjZW5kaWYKICAxMDM4CQlpZiAoYWRldi0+ZG0uZGMtPmN0
eC0+ZG11Yl9zcnYpIHsKICAgICAgICAgICAgICAgICAgICBeXl5eXl5eXl5eXl5eXl5eClVuY2hl
Y2tlZCBkZXJlZmVyZW5jZQoKICAxMDM5CQkJZGNfZG11Yl9zcnZfZGVzdHJveSgmYWRldi0+ZG0u
ZGMtPmN0eC0+ZG11Yl9zcnYpOwogIDEwNDAJCQlhZGV2LT5kbS5kYy0+Y3R4LT5kbXViX3NydiA9
IE5VTEw7CiAgMTA0MQkJfQogIDEwNDIJCiAgMTA0MwkJaWYgKGFkZXYtPmRtLmRtdWJfYm8pCiAg
MTA0NAkJCWFtZGdwdV9ib19mcmVlX2tlcm5lbCgmYWRldi0+ZG0uZG11Yl9ibywKICAxMDQ1CQkJ
CQkgICAgICAmYWRldi0+ZG0uZG11Yl9ib19ncHVfYWRkciwKICAxMDQ2CQkJCQkgICAgICAmYWRl
di0+ZG0uZG11Yl9ib19jcHVfYWRkcik7CiAgMTA0NwkKICAxMDQ4CQkvKiBEQyBEZXN0cm95IFRP
RE86IFJlcGxhY2UgZGVzdHJveSBEQUwgKi8KICAxMDQ5CQlpZiAoYWRldi0+ZG0uZGMpCiAgICAg
ICAgICAgICAgICAgICAgXl5eXl5eXl5eXl4KQ2hlY2sKCiAgMTA1MAkJCWRjX2Rlc3Ryb3koJmFk
ZXYtPmRtLmRjKTsKICAxMDUxCQkvKgoKcmVnYXJkcywKZGFuIGNhcnBlbnRlcgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlz
dAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
