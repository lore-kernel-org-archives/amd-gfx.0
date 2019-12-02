Return-Path: <SRS0=0KW4=ZY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB70C43141
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 17:35:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FCA220881
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 17:35:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FCA220881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5A516E2DD;
	Mon,  2 Dec 2019 17:35:55 +0000 (UTC)
Received: from NAM05-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr720041.outbound.protection.outlook.com [40.107.72.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04ACE6E2C8
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Dec 2019 17:35:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VNizgpSFb+c157yCYd+Et6deuXA3nFFaw9eh8mn6bBZuViuFtiJGR7qgnfVZt3fI3O8W/Pv94Jk+4AYfR7UT1UbkS73eSNbXbU0ne7eX0dVtsMH3fBVIAEKYg/vHr7UoFVFw/voApoYIis7vcmwuDLw/gvolRv/mCw5zUMVgDXoGa9deHQYJqMUKGgh33TmbD9HkCGXaFL4DLlJgI3ZbsiTV55W9c17J0RFRhBjUSlTLmdOMcEV2kv/RBR/TaOFaQ66ghoahXZgAUByeeBwTvHzPgoSSMLtQXeY7h6yngs+GvEQb/Y0nJnOdLMEy5613gCZ6Gd5VBXH5S7FOGfOZgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I5f324btuhIvs/zY0JRubIAkoSzv9Gf4I+BouzKCT+o=;
 b=Y0MdeFHGMkjkmtYXLxEqOTAw/7mYqe3u5xWDVHygpWxveobs1ytl+xk0o58EvITsGr5BbXZt0/Eui9Gf+s17CHCj+O70mv39c/otZ2agxtPz9zzkuPWmZ1ouJDRDtl27OyxEki73m9k9PQvATRtzjPh+UqqMBRxmzVqfZaKa54YOUKlwEH+/9x+2JRBQ9WIMa7oOCM033muI2s3+2B6Ln+nQNC6AgHntaddO1AR485hEhitYYvBIXW66K0xjIELdBtYLIfRncfu4Gp54fOXlg55RJLYU4HH2VROE4eJTpqOoZHfwt5m1spJ1A6V0HOv+jyHGJB0OqKEjuakU3uJrQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BN7PR12MB2593.namprd12.prod.outlook.com (20.176.27.87) by
 BN7PR12MB2802.namprd12.prod.outlook.com (20.176.27.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.22; Mon, 2 Dec 2019 17:35:52 +0000
Received: from BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::2070:7583:3718:d019]) by BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::2070:7583:3718:d019%3]) with mapi id 15.20.2495.014; Mon, 2 Dec 2019
 17:35:52 +0000
From: sunpeng.li@amd.com
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 41/51] drm/amd/display: fix cursor positioning for multiplane
 cases
Date: Mon,  2 Dec 2019 12:33:55 -0500
Message-Id: <20191202173405.31582-42-sunpeng.li@amd.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191202173405.31582-1-sunpeng.li@amd.com>
References: <20191202173405.31582-1-sunpeng.li@amd.com>
X-ClientProxiedBy: YTBPR01CA0029.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::42) To BN7PR12MB2593.namprd12.prod.outlook.com
 (2603:10b6:408:25::23)
MIME-Version: 1.0
X-Mailer: git-send-email 2.24.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ab1d7527-fbd7-4694-38de-08d7774e0367
X-MS-TrafficTypeDiagnostic: BN7PR12MB2802:|BN7PR12MB2802:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN7PR12MB2802CFED028F25AB7623D80282430@BN7PR12MB2802.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:751;
X-Forefront-PRVS: 0239D46DB6
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(136003)(366004)(376002)(396003)(39860400002)(189003)(199004)(81166006)(81156014)(86362001)(6486002)(9686003)(6506007)(2870700001)(478600001)(386003)(76176011)(5660300002)(51416003)(186003)(1076003)(52116002)(3846002)(6116002)(47776003)(2616005)(26005)(66946007)(66066001)(25786009)(316002)(446003)(11346002)(14454004)(66476007)(66556008)(48376002)(8676002)(50226002)(305945005)(6512007)(36756003)(2906002)(14444005)(99286004)(7736002)(2351001)(54906003)(4326008)(2361001)(6916009)(6436002)(50466002)(8936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN7PR12MB2802;
 H:BN7PR12MB2593.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: woP32vAzmAxzM465pzCbPJp4aR0lrUmGnwKjN5aXN1gKR7TbrTzET6qZFZ0ERUcxJCXUHE1ZcGSJ5YABVkjsnzjYxKWN5RPRrZCVMF1J+ewmK2Raqa2o/RxOlAQ79dHezFJOFIanfiwYDGyd9T/s+XoX/AzAVb0Ww8Lm7/ConcV6uuPGqskfE2iO1qGlc96U2pqZ99aVfrI1EgczwHVFFamkTo4hjSilvlMNAGOtaSmCaiNy56yFYu2qFvx1rVZaryWlcpBqMXsSBjrXQWWu72R5wSBMEkDYmB1mb3ozII0U/S+S4e8HdSd45JqsTgsrhJPRNEWiLj8iTzcfPC1aK9ZZY8+pkLLUqGQUIchXvLu5nfr8JVhACt2CdwRp+PQJhioTwBWJRtlq9V3ZU6+TGow2FNk3bOsMWVG309F9YMUS8zlxqoZFh9wYP/enfcyu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab1d7527-fbd7-4694-38de-08d7774e0367
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2019 17:35:24.6554 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yOYCeCHtdbDeZRS0OuWBJlqVWUuffGzeq7VrhFV7gNlE8azJkntVAXYdYgd/4iyp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2802
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I5f324btuhIvs/zY0JRubIAkoSzv9Gf4I+BouzKCT+o=;
 b=oRHZsQbPy3ZNMXg8zE0M+sbmU3Jvqt9oTh8wzU4qVHp9zzKoEl+JGjlojGxwPFetbpYujldmFjMyi45DXRlTFF91gCQU6iQYmZB4maon7lt6feRfs22sD8SyIFLcmOPfVIf1nNORpVpd9Y8zTO5RuOokEW3KWHZ2+/WpF4jmtXI=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Sunpeng.Li@amd.com; 
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
Cc: Aric Cyr <aric.cyr@amd.com>, Leo Li <sunpeng.li@amd.com>,
 harry.wentland@amd.com, rodrigo.siqueira@amd.com, bhawanpreet.lakha@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
 Anthony Koo <Anthony.Koo@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RnJvbTogQXJpYyBDeXIgPGFyaWMuY3lyQGFtZC5jb20+CgpbV2h5XQpDdXJzb3IgcG9zaXRpb24g
bmVlZHMgdG8gdGFrZSBpbnRvIGFjY291bnQgcGxhbmUgc2NhbGluZyBhcyB3ZWxsLgoKW0hvd10K
VHJhbnNsYXRlIGN1cnNvciBjb29yZHMgZnJvbSBzdHJlYW0gc3BhY2UgdG8gcGxhbmUgc3BhY2Uu
CgpTaWduZWQtb2ZmLWJ5OiBBcmljIEN5ciA8YXJpYy5jeXJAYW1kLmNvbT4KUmV2aWV3ZWQtYnk6
IEFudGhvbnkgS29vIDxBbnRob255Lktvb0BhbWQuY29tPgpBY2tlZC1ieTogTGVvIExpIDxzdW5w
ZW5nLmxpQGFtZC5jb20+CkFja2VkLWJ5OiBOaWNob2xhcyBLYXpsYXVza2FzIDxOaWNob2xhcy5L
YXpsYXVza2FzQGFtZC5jb20+Ci0tLQogLi4uL2FtZC9kaXNwbGF5L2RjL2RjbjEwL2RjbjEwX2h3
X3NlcXVlbmNlci5jIHwgMzMgKysrKysrKysrKysrKystLS0tLQogMSBmaWxlIGNoYW5nZWQsIDI0
IGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjEwL2RjbjEwX2h3X3NlcXVlbmNlci5jIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjEwL2RjbjEwX2h3X3NlcXVlbmNlci5jCmluZGV4IDk1
NTFmZWZiOWQxZC4uNjFkMmYxMjMzZjhjIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2Rpc3BsYXkvZGMvZGNuMTAvZGNuMTBfaHdfc2VxdWVuY2VyLmMKKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjEwL2RjbjEwX2h3X3NlcXVlbmNlci5jCkBAIC0yOTEzLDE1
ICsyOTEzLDMwIEBAIHZvaWQgZGNuMTBfc2V0X2N1cnNvcl9wb3NpdGlvbihzdHJ1Y3QgcGlwZV9j
dHggKnBpcGVfY3R4KQogCQkucm90YXRpb24gPSBwaXBlX2N0eC0+cGxhbmVfc3RhdGUtPnJvdGF0
aW9uLAogCQkubWlycm9yID0gcGlwZV9jdHgtPnBsYW5lX3N0YXRlLT5ob3Jpem9udGFsX21pcnJv
cgogCX07Ci0JdWludDMyX3QgeF9wbGFuZSA9IHBpcGVfY3R4LT5wbGFuZV9zdGF0ZS0+ZHN0X3Jl
Y3QueDsKLQl1aW50MzJfdCB5X3BsYW5lID0gcGlwZV9jdHgtPnBsYW5lX3N0YXRlLT5kc3RfcmVj
dC55OwotCXVpbnQzMl90IHhfb2Zmc2V0ID0gbWluKHhfcGxhbmUsIHBvc19jcHkueCk7Ci0JdWlu
dDMyX3QgeV9vZmZzZXQgPSBtaW4oeV9wbGFuZSwgcG9zX2NweS55KTsKLQotCXBvc19jcHkueCAt
PSB4X29mZnNldDsKLQlwb3NfY3B5LnkgLT0geV9vZmZzZXQ7Ci0JcG9zX2NweS54X2hvdHNwb3Qg
Kz0gKHhfcGxhbmUgLSB4X29mZnNldCk7Ci0JcG9zX2NweS55X2hvdHNwb3QgKz0gKHlfcGxhbmUg
LSB5X29mZnNldCk7CisKKwlpbnQgeF9wbGFuZSA9IHBpcGVfY3R4LT5wbGFuZV9zdGF0ZS0+ZHN0
X3JlY3QueDsKKwlpbnQgeV9wbGFuZSA9IHBpcGVfY3R4LT5wbGFuZV9zdGF0ZS0+ZHN0X3JlY3Qu
eTsKKwlpbnQgeF9wb3MgPSBwb3NfY3B5Lng7CisJaW50IHlfcG9zID0gcG9zX2NweS55OworCisJ
Ly8gdHJhbnNsYXRlIGN1cnNvciBmcm9tIHN0cmVhbSBzcGFjZSB0byBwbGFuZSBzcGFjZQorCXhf
cG9zID0gKHhfcG9zIC0geF9wbGFuZSkgKiBwaXBlX2N0eC0+cGxhbmVfc3RhdGUtPnNyY19yZWN0
LndpZHRoIC8KKwkJCXBpcGVfY3R4LT5wbGFuZV9zdGF0ZS0+ZHN0X3JlY3Qud2lkdGg7CisJeV9w
b3MgPSAoeV9wb3MgLSB5X3BsYW5lKSAqIHBpcGVfY3R4LT5wbGFuZV9zdGF0ZS0+c3JjX3JlY3Qu
aGVpZ2h0IC8KKwkJCXBpcGVfY3R4LT5wbGFuZV9zdGF0ZS0+ZHN0X3JlY3QuaGVpZ2h0OworCisJ
aWYgKHhfcG9zIDwgMCkgeworCQlwb3NfY3B5LnhfaG90c3BvdCAtPSB4X3BvczsKKwkJeF9wb3Mg
PSAwOworCX0KKworCWlmICh5X3BvcyA8IDApIHsKKwkJcG9zX2NweS55X2hvdHNwb3QgLT0geV9w
b3M7CisJCXlfcG9zID0gMDsKKwl9CisKKwlwb3NfY3B5LnggPSAodWludDMyX3QpeF9wb3M7CisJ
cG9zX2NweS55ID0gKHVpbnQzMl90KXlfcG9zOwogCiAJaWYgKHBpcGVfY3R4LT5wbGFuZV9zdGF0
ZS0+YWRkcmVzcy50eXBlCiAJCQk9PSBQTE5fQUREUl9UWVBFX1ZJREVPX1BST0dSRVNTSVZFKQot
LSAKMi4yNC4wCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRw
czovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
