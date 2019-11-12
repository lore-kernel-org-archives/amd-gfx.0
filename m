Return-Path: <SRS0=8kND=ZE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E4DC43331
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 18:04:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B28D2067B
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 18:04:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B28D2067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B1206EBB5;
	Tue, 12 Nov 2019 18:04:20 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690083.outbound.protection.outlook.com [40.107.69.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 298C36EBAD
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Nov 2019 18:04:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lpq4SqrQwmqGf+OFcDrkXGwo9qhAprEkAsKh+SMDtCr/YjJAjD3uSrhNorJEkGFeacD3NwNnz6nhCKLCtnvLwUngRgjmkDMr2NKbWUG2l/JRTb1EquKMf0QAfHossInlkYpyrZKk0sZzJ1N5ggEniBAtgNByh4IqeN4aYvK89/hPftlGKS2n+l/7On1hxoeTtZ1tzRyz6eNaxm8o5qbgwDFCTvCxkwgR8NOyI9haduScKaeulc1li3XPFiVoPtc5PN6r4vJfpgyWVPm3aUrQWQCyY+GMgVLJamDvLTEhyrUYIvS6s3UUhTztHMzVjxxuQgbltBA5RzxdwbzMOaDcJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xqR+xi1/x3EH4Fm4x/b72ucS/DQqocJu/e5gdGK4VF4=;
 b=ji6ySxs9AD4HX4iZt8jZOzswNbMUrpMsG4JVFp3ynu3ge5M5IqP311FYpcdyOpjoLClAjGC2ymwNbtPUJ7zjnW+DNeeasFmyAhMt8K2zdyYqGLzgT5c43v+saCJ84v02uTLzA+erCwwF4GG4dzRMndIjhwKkx7UYtiEfh93d2OIXX9vn6ioGNYfp4a72EcB/S/pFUTEqn7monGjQPlPNnEiYcFW/q40E7zelBmfBLBfLTNHKaTAlZUlD1upNVpKFZsMKZe0rPEMYkc4spINxFkbGhzIfyHNnvmoxANsCisD8faBMIyQ0k3ruXJRYa+l9iKLaSduKREzc6aronxTrjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM5PR12MB2456.namprd12.prod.outlook.com (52.132.141.37) by
 DM5PR12MB1580.namprd12.prod.outlook.com (10.172.40.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Tue, 12 Nov 2019 18:04:15 +0000
Received: from DM5PR12MB2456.namprd12.prod.outlook.com
 ([fe80::75bf:bd52:2f61:656b]) by DM5PR12MB2456.namprd12.prod.outlook.com
 ([fe80::75bf:bd52:2f61:656b%7]) with mapi id 15.20.2451.023; Tue, 12 Nov 2019
 18:04:15 +0000
From: Leo Liu <leo.liu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 14/21] drm/amd/powerplay: add JPEG power control for Renoir
Date: Tue, 12 Nov 2019 13:03:22 -0500
Message-Id: <20191112180329.3927-15-leo.liu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191112180329.3927-1-leo.liu@amd.com>
References: <20191112180329.3927-1-leo.liu@amd.com>
X-ClientProxiedBy: YTOPR0101CA0059.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::36) To DM5PR12MB2456.namprd12.prod.outlook.com
 (2603:10b6:4:b4::37)
MIME-Version: 1.0
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bd04fbf4-f5a5-4df4-5283-08d7679abaf4
X-MS-TrafficTypeDiagnostic: DM5PR12MB1580:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB15800C707D5360DE1B8FB483E5770@DM5PR12MB1580.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:288;
X-Forefront-PRVS: 021975AE46
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(376002)(366004)(346002)(396003)(136003)(199004)(189003)(478600001)(6512007)(305945005)(186003)(26005)(8936002)(6436002)(6486002)(5660300002)(76176011)(99286004)(25786009)(14454004)(51416003)(476003)(446003)(2616005)(4326008)(386003)(6506007)(6916009)(16586007)(7736002)(316002)(52116002)(86362001)(11346002)(50226002)(6666004)(486006)(2361001)(8676002)(44832011)(1076003)(36756003)(3846002)(6116002)(66066001)(47776003)(14444005)(50466002)(2906002)(48376002)(66946007)(66556008)(2351001)(66476007)(81156014)(81166006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1580;
 H:DM5PR12MB2456.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MPI0cgyZhse68eggC3HwLcgi3ILY00uSSHTmra2AFkeapL9m1GrzppXeJ/H6NUdVvJNGI9pi59LSUZI7tJrYMYqkfV2ZLtO32wNh+6TBgDdjhC7QcTYHnzwUoE2tLKZb/qezqu/LCHze5cba0w3SXyRpN2Vh3uPC1gcsWCz84Xb7WuBxEGtIjxb3V44nc3MMaqTqx4vW7xbLG2y0XP4Yrab1WplAts5Sm+ZV441nfUowTinjBDlkASSyLCJkhUyu2xwm7ofL0n8cpcvodcvRmqZM3CWT9ae9RavIrY/DNZk7bmP76jI7wYAQ4anz01iDCxLvXn5sgy7BZCYSjY7lT9AMoTjEXL7m+RpBPSI7z6zwpu35TX4+sjIVSN63uHJrHFA1EwHWRdz3NwZF5Ieaskb0G75x6wOSJdCg1ZeAznYreLbfVvsJpItvmIo7jAF4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd04fbf4-f5a5-4df4-5283-08d7679abaf4
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2019 18:04:15.7941 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Mgkjw5mSOKM2tLS4KDbAm4qhHUSTGfgFX2nERuJwuszVDtjF+yInOdd7H3Bo4Ak
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1580
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xqR+xi1/x3EH4Fm4x/b72ucS/DQqocJu/e5gdGK4VF4=;
 b=L8XEOXbz/CmaEb0Oj84iUQPNmbIF/qC/L7NVmDmH1pJ8oNxY52ouml34/XMpiThvfsqafiDZ6eCXjeN8MJtXi/DErHK1YA9w1gDe/v2yqDoAKtuZW81V+ai5bEr09mK/YsGDDJQZQNyCUxl0t9wdY1L4exY3Q5J7l5l5lacvGws=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Leo.Liu@amd.com; 
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
Cc: Leo Liu <leo.liu@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191112180322.ZHzruLSBaCk_T4CCNMUB46NiWw7aUGjMGKu4ODQBhYc@z>

QnkgdXNpbmcgaXRzIG93biBKUEVHIFBvd2VyVXAgYW5kIFBvd2VyRG93biBtZXNzYWdlcwoKU2ln
bmVkLW9mZi1ieTogTGVvIExpdSA8bGVvLmxpdUBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvcG93ZXJwbGF5L3Jlbm9pcl9wcHQuYyB8IDI2ICsrKysrKysrKysrKysrKysrKysrKysK
IDEgZmlsZSBjaGFuZ2VkLCAyNiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9wb3dlcnBsYXkvcmVub2lyX3BwdC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9w
b3dlcnBsYXkvcmVub2lyX3BwdC5jCmluZGV4IDQ5MmEyMDE1NTRlOC4uZjU2MWZiOWNjOTUxIDEw
MDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9yZW5vaXJfcHB0LmMKKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvcmVub2lyX3BwdC5jCkBAIC0zMDEsNiAr
MzAxLDMxIEBAIHN0YXRpYyBpbnQgcmVub2lyX2RwbV9zZXRfdXZkX2VuYWJsZShzdHJ1Y3Qgc211
X2NvbnRleHQgKnNtdSwgYm9vbCBlbmFibGUpCiAJcmV0dXJuIHJldDsKIH0KIAorc3RhdGljIGlu
dCByZW5vaXJfZHBtX3NldF9qcGVnX2VuYWJsZShzdHJ1Y3Qgc211X2NvbnRleHQgKnNtdSwgYm9v
bCBlbmFibGUpCit7CisJc3RydWN0IHNtdV9wb3dlcl9jb250ZXh0ICpzbXVfcG93ZXIgPSAmc211
LT5zbXVfcG93ZXI7CisJc3RydWN0IHNtdV9wb3dlcl9nYXRlICpwb3dlcl9nYXRlID0gJnNtdV9w
b3dlci0+cG93ZXJfZ2F0ZTsKKwlpbnQgcmV0ID0gMDsKKworCWlmIChlbmFibGUpIHsKKwkJaWYg
KHNtdV9mZWF0dXJlX2lzX2VuYWJsZWQoc211LCBTTVVfRkVBVFVSRV9KUEVHX1BHX0JJVCkpIHsK
KwkJCXJldCA9IHNtdV9zZW5kX3NtY19tc2dfd2l0aF9wYXJhbShzbXUsIFNNVV9NU0dfUG93ZXJV
cEpwZWcsIDApOworCQkJaWYgKHJldCkKKwkJCQlyZXR1cm4gcmV0OworCQl9CisJCXBvd2VyX2dh
dGUtPmpwZWdfZ2F0ZWQgPSBmYWxzZTsKKwl9IGVsc2UgeworCQlpZiAoc211X2ZlYXR1cmVfaXNf
ZW5hYmxlZChzbXUsIFNNVV9GRUFUVVJFX0pQRUdfUEdfQklUKSkgeworCQkJcmV0ID0gc211X3Nl
bmRfc21jX21zZyhzbXUsIFNNVV9NU0dfUG93ZXJEb3duSnBlZyk7CisJCQlpZiAocmV0KQorCQkJ
CXJldHVybiByZXQ7CisJCX0KKwkJcG93ZXJfZ2F0ZS0+anBlZ19nYXRlZCA9IHRydWU7CisJfQor
CisJcmV0dXJuIHJldDsKK30KKwogc3RhdGljIGludCByZW5vaXJfZm9yY2VfZHBtX2xpbWl0X3Zh
bHVlKHN0cnVjdCBzbXVfY29udGV4dCAqc211LCBib29sIGhpZ2hlc3QpCiB7CiAJaW50IHJldCA9
IDAsIGkgPSAwOwpAQCAtNjgzLDYgKzcwOCw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgcHB0YWJs
ZV9mdW5jcyByZW5vaXJfcHB0X2Z1bmNzID0gewogCS5wcmludF9jbGtfbGV2ZWxzID0gcmVub2ly
X3ByaW50X2Nsa19sZXZlbHMsCiAJLmdldF9jdXJyZW50X3Bvd2VyX3N0YXRlID0gcmVub2lyX2dl
dF9jdXJyZW50X3Bvd2VyX3N0YXRlLAogCS5kcG1fc2V0X3V2ZF9lbmFibGUgPSByZW5vaXJfZHBt
X3NldF91dmRfZW5hYmxlLAorCS5kcG1fc2V0X2pwZWdfZW5hYmxlID0gcmVub2lyX2RwbV9zZXRf
anBlZ19lbmFibGUsCiAJLmZvcmNlX2RwbV9saW1pdF92YWx1ZSA9IHJlbm9pcl9mb3JjZV9kcG1f
bGltaXRfdmFsdWUsCiAJLnVuZm9yY2VfZHBtX2xldmVscyA9IHJlbm9pcl91bmZvcmNlX2RwbV9s
ZXZlbHMsCiAJLmdldF93b3JrbG9hZF90eXBlID0gcmVub2lyX2dldF93b3JrbG9hZF90eXBlLAot
LSAKMi4xNy4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRw
czovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
