Return-Path: <SRS0=5Use=ZK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D589FC432C0
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Nov 2019 09:20:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B313320692
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Nov 2019 09:20:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B313320692
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FB3A89DBC;
	Mon, 18 Nov 2019 09:20:53 +0000 (UTC)
Received: from NAM03-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr790045.outbound.protection.outlook.com [40.107.79.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11D4889DBC
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Nov 2019 09:20:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hZ3WOYbwChVTlfKHLJuX6Hnh1xkBsnmOybdc+hgNUW2idxEupukLXVr1/tM34J1/cBYRZdN9uID0EQORBO5MINk77lIDI68Y2lZIwp22344vs2wvgieas3spFx2QZoskyHhUCzMe93cIc5g2PeE15/keOvxOYYAmFani32bQ3es/mjxmqamnqw6KqUx0xXjvaYbZppdGkcMVSrdhEmwYDz9odPFSZBtVst01UEzy/SzRfOCV3CFySxamVudrzYIVn1cKHuDGVQ+EEotw6X6mjuAnS62AIt0MVu7Gy4YrGpkYfVQGbOA8qtWKqM/U7/kLiXDD5GUU+j+otlirrznakQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TbCt3koLkpeFvfdDgTCgtyu5qhKYcHO+PcfgFnarYBA=;
 b=nK6TEzRBJuYKn9e5zGAvbvNaNwphF7t19yLoQHG3qMH6butaIgmuxh0niVu775Nh1PS/iOSQJBal9SysHPMlUuhmBokTKjgu+xwwSK6KVJqMjkuLvEw4n7XOGkGFug951uvfC/JGEGQlw4/y5D4KIzijIxx/amLau6a5lGS4B82fh3itnWrVz39zxmRr3+Sf6WVpujJqZ4v+X2we8g73hxC74sYAekN0Ok7xEFcGJ/A65SGvXfwB6PH44ozCWqsq9a1djvE1Ie9/u6/XNNZskil7yI2UbN3Gt+QJaPC3AePXbwgRoBkYPVHi2QpLdIDqslG0HaMWwDlySlw9RJd/qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB4191.namprd12.prod.outlook.com (52.135.48.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.26; Mon, 18 Nov 2019 09:20:49 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::5895:bbd8:c1d6:1587]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::5895:bbd8:c1d6:1587%7]) with mapi id 15.20.2451.029; Mon, 18 Nov 2019
 09:20:49 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amd/powerplay: add Arcturus baco reset support
Date: Mon, 18 Nov 2019 17:20:19 +0800
Message-Id: <20191118092019.11127-2-evan.quan@amd.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191118092019.11127-1-evan.quan@amd.com>
References: <20191118092019.11127-1-evan.quan@amd.com>
X-ClientProxiedBy: HK2PR0401CA0006.apcprd04.prod.outlook.com
 (2603:1096:202:2::16) To MN2PR12MB3344.namprd12.prod.outlook.com
 (2603:10b6:208:c5::10)
MIME-Version: 1.0
X-Mailer: git-send-email 2.24.0
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d990581a-c17c-4d34-c905-08d76c089989
X-MS-TrafficTypeDiagnostic: MN2PR12MB4191:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4191BCFCEA0E358A84EE7E9FE44D0@MN2PR12MB4191.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:883;
X-Forefront-PRVS: 0225B0D5BC
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(376002)(136003)(396003)(366004)(346002)(199004)(189003)(36756003)(11346002)(8676002)(486006)(99286004)(5660300002)(52116002)(14444005)(81156014)(81166006)(476003)(76176011)(316002)(6506007)(386003)(478600001)(2616005)(14454004)(66556008)(66476007)(6916009)(86362001)(446003)(66946007)(6486002)(44832011)(25786009)(2870700001)(50466002)(2906002)(2361001)(8936002)(50226002)(6436002)(51416003)(6512007)(305945005)(1076003)(4326008)(6116002)(48376002)(26005)(3846002)(186003)(47776003)(2351001)(7736002)(6666004)(66066001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4191;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wxDwPVVohKzJ79UVNSz5DXVJRxrxwhor/vm0liiSANCd2bfX/lXyiil9M3MNsdonL1B3cjgjw1TMcitVazQpc0U1vOaDIaRIxiwwMp5OnywuNtzbEP0bG+LDIPvfOU05BCP+XdRy9FHRMxSavgkuSreaA599vHFJe7fPB9XyVbqUX2ukAAAa5M9VtD/PSikZ6aNeF8IWYvdnnyu1TOvnGusLZoXPw8NzUWjBeV30/Z40F8unSF7lIfuQVwzL4Mq3grvvbiYla+aDSy34iVmnGB9T2Owxc7xgRiv6Kwvx3/32lXaax+AhxyjrEFN0RYnDykZdCt/IZviSeykQjmZCt3Yrj2E6LtnbJLRzDItboBRXPRt7AFu/E4WQAaqf0DxxYI/HC2aaDNPW0JdIBgwgCDVSr6FjftM0gZbtT0Hpc3HI5o6XJo+xYb4BMyoEO4rF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d990581a-c17c-4d34-c905-08d76c089989
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2019 09:20:49.8820 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GMS9LXbhi2Q2S978T6Xsf3vyIcXzPiev4AemGysAxVtAa31e4wkCRhWaAAOPi5Ng
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4191
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TbCt3koLkpeFvfdDgTCgtyu5qhKYcHO+PcfgFnarYBA=;
 b=K6S0FnbQrMz3/f6VNfnSYv9QuCWe50U2jV/HKUprwbd3kMs63wxe5uAXg42//kQXv3p/O1G5MzbEXGsY4zrpN7o0BnbNYC0erW9yWlsWTGDLpQ35WC6CjvkfahA4/Wu/yHJgWixznx7XjQzZvUDVDhJjxhzwAiYEcPQPHYNSPPo=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
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
Cc: Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191118092019.VqqlmwFLEUD-X-eHzhO86T3a5o0rMsRha81a_2LY7kM@z>

RW5hYmxlIGJhY28gcmVzZXQgc3VwcG9ydCBvbiBBcmN0dXJ1cy4KCkNoYW5nZS1JZDogSTdiNjkw
MTZlZTBkMjM4ZTBmY2IzMjNhYTEwMjE1ZTI5OTI0YTZjYTYKU2lnbmVkLW9mZi1ieTogRXZhbiBR
dWFuIDxldmFuLnF1YW5AYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9z
b2MxNS5jICAgICAgICAgICB8ICAxICsKIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2Fy
Y3R1cnVzX3BwdC5jIHwgIDcgKysrKysrKwogZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkv
c211X3YxMV8wLmMgICAgfCAxNCArKysrKysrKysrLS0tLQogMyBmaWxlcyBjaGFuZ2VkLCAxOCBp
bnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L3NvYzE1LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zb2MxNS5j
CmluZGV4IGIyNWU5ZWNhNWQzMS4uODZjZmVlNTI4ZDNiIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9zb2MxNS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L3NvYzE1LmMKQEAgLTU2NSw2ICs1NjUsNyBAQCBzb2MxNV9hc2ljX3Jlc2V0X21ldGhvZChzdHJ1
Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKIAkJcmV0dXJuIEFNRF9SRVNFVF9NRVRIT0RfTU9ERTI7
CiAJY2FzZSBDSElQX1ZFR0ExMDoKIAljYXNlIENISVBfVkVHQTEyOgorCWNhc2UgQ0hJUF9BUkNU
VVJVUzoKIAkJc29jMTVfYXNpY19nZXRfYmFjb19jYXBhYmlsaXR5KGFkZXYsICZiYWNvX3Jlc2V0
KTsKIAkJYnJlYWs7CiAJY2FzZSBDSElQX1ZFR0EyMDoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvcG93ZXJwbGF5L2FyY3R1cnVzX3BwdC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9w
b3dlcnBsYXkvYXJjdHVydXNfcHB0LmMKaW5kZXggNThjN2M0YTMwNTNlLi4xYWYwYjFhYjZmNzAg
MTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2FyY3R1cnVzX3BwdC5j
CisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2FyY3R1cnVzX3BwdC5jCkBAIC00
OTUsNiArNDk1LDcgQEAgc3RhdGljIGludCBhcmN0dXJ1c19zdG9yZV9wb3dlcnBsYXlfdGFibGUo
c3RydWN0IHNtdV9jb250ZXh0ICpzbXUpCiB7CiAJc3RydWN0IHNtdV8xMV8wX3Bvd2VycGxheV90
YWJsZSAqcG93ZXJwbGF5X3RhYmxlID0gTlVMTDsKIAlzdHJ1Y3Qgc211X3RhYmxlX2NvbnRleHQg
KnRhYmxlX2NvbnRleHQgPSAmc211LT5zbXVfdGFibGU7CisJc3RydWN0IHNtdV9iYWNvX2NvbnRl
eHQgKnNtdV9iYWNvID0gJnNtdS0+c211X2JhY287CiAJaW50IHJldCA9IDA7CiAKIAlpZiAoIXRh
YmxlX2NvbnRleHQtPnBvd2VyX3BsYXlfdGFibGUpCkBAIC01MDcsNiArNTA4LDEyIEBAIHN0YXRp
YyBpbnQgYXJjdHVydXNfc3RvcmVfcG93ZXJwbGF5X3RhYmxlKHN0cnVjdCBzbXVfY29udGV4dCAq
c211KQogCiAJdGFibGVfY29udGV4dC0+dGhlcm1hbF9jb250cm9sbGVyX3R5cGUgPSBwb3dlcnBs
YXlfdGFibGUtPnRoZXJtYWxfY29udHJvbGxlcl90eXBlOwogCisJbXV0ZXhfbG9jaygmc211X2Jh
Y28tPm11dGV4KTsKKwlpZiAocG93ZXJwbGF5X3RhYmxlLT5wbGF0Zm9ybV9jYXBzICYgU01VXzEx
XzBfUFBfUExBVEZPUk1fQ0FQX0JBQ08gfHwKKwkgICAgcG93ZXJwbGF5X3RhYmxlLT5wbGF0Zm9y
bV9jYXBzICYgU01VXzExXzBfUFBfUExBVEZPUk1fQ0FQX01BQ08pCisJCXNtdV9iYWNvLT5wbGF0
Zm9ybV9zdXBwb3J0ID0gdHJ1ZTsKKwltdXRleF91bmxvY2soJnNtdV9iYWNvLT5tdXRleCk7CisK
IAlyZXR1cm4gcmV0OwogfQogCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2Vy
cGxheS9zbXVfdjExXzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L3NtdV92MTFf
MC5jCmluZGV4IDcxZTJiYmUyNWNmNi4uMjM4ZDU4NDgwNWIzIDEwMDY0NAotLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL3Bvd2VycGxheS9zbXVfdjExXzAuYworKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL3Bvd2VycGxheS9zbXVfdjExXzAuYwpAQCAtMTY0MSw3ICsxNjQxLDkgQEAgYm9vbCBzbXVf
djExXzBfYmFjb19pc19zdXBwb3J0KHN0cnVjdCBzbXVfY29udGV4dCAqc211KQogCWlmICghYmFj
b19zdXBwb3J0KQogCQlyZXR1cm4gZmFsc2U7CiAKLQlpZiAoIXNtdV9mZWF0dXJlX2lzX2VuYWJs
ZWQoc211LCBTTVVfRkVBVFVSRV9CQUNPX0JJVCkpCisJLyogQXJjdHVydXMgZG9lcyBub3Qgc3Vw
cG9ydCB0aGlzIGJpdCBtYXNrICovCisJaWYgKHNtdV9mZWF0dXJlX2lzX3N1cHBvcnRlZChzbXUs
IFNNVV9GRUFUVVJFX0JBQ09fQklUKSAmJgorCSAgICFzbXVfZmVhdHVyZV9pc19lbmFibGVkKHNt
dSwgU01VX0ZFQVRVUkVfQkFDT19CSVQpKQogCQlyZXR1cm4gZmFsc2U7CiAKIAl2YWwgPSBSUkVH
MzJfU09DMTUoTkJJTywgMCwgbW1SQ0NfQklGX1NUUkFQMCk7CkBAIC0xNzEzLDExICsxNzE1LDE1
IEBAIGludCBzbXVfdjExXzBfYmFjb19zZXRfc3RhdGUoc3RydWN0IHNtdV9jb250ZXh0ICpzbXUs
IGVudW0gc211X2JhY29fc3RhdGUgc3RhdGUpCiAKIGludCBzbXVfdjExXzBfYmFjb19yZXNldChz
dHJ1Y3Qgc211X2NvbnRleHQgKnNtdSkKIHsKKwlzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiA9
IHNtdS0+YWRldjsKIAlpbnQgcmV0ID0gMDsKIAotCXJldCA9IHNtdV92MTFfMF9iYWNvX3NldF9h
cm1kM19zZXF1ZW5jZShzbXUsIEJBQ09fU0VRX0JBQ08pOwotCWlmIChyZXQpCi0JCXJldHVybiBy
ZXQ7CisJLyogQXJjdHVydXMgZG9lcyBub3QgbmVlZCB0aGlzIGF1ZGlvIHdvcmthcm91bmQgKi8K
KwlpZiAoYWRldi0+YXNpY190eXBlICE9IENISVBfQVJDVFVSVVMpIHsKKwkJcmV0ID0gc211X3Yx
MV8wX2JhY29fc2V0X2FybWQzX3NlcXVlbmNlKHNtdSwgQkFDT19TRVFfQkFDTyk7CisJCWlmIChy
ZXQpCisJCQlyZXR1cm4gcmV0OworCX0KIAogCXJldCA9IHNtdV92MTFfMF9iYWNvX3NldF9zdGF0
ZShzbXUsIFNNVV9CQUNPX1NUQVRFX0VOVEVSKTsKIAlpZiAocmV0KQotLSAKMi4yNC4wCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxp
bmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
