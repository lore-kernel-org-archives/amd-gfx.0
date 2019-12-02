Return-Path: <SRS0=0KW4=ZY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBDF1C432C0
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 17:35:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD93F20848
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 17:35:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD93F20848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 753736E2C0;
	Mon,  2 Dec 2019 17:35:14 +0000 (UTC)
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr820054.outbound.protection.outlook.com [40.107.82.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 763B96E2C0
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Dec 2019 17:35:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cwuq25lslZHe7mmIQk32QPoCCtZJsSBME8bdiF9bRsJ22txHPjy36KdgXUYmyYYVmBFp51X6EDF2YUSK4kAY3/SZ45V7M7YhIFP/MoDxTQ0xoZBQYNdzybwJmbWMYOy5QRkkTGEgkNKSFv4+DLqkiv2uRYeWryT/LfeSsYcJc7ypN71sJ/teiiJYfO4KKh0fpfELbwP5LPFVDS38Nc/ZdOPLxbz00Ol0kPld5fyZX4gqlf+UneY0nwxxIp3Nx8YHxAdzblTAaU2x2Hi5COHHS8SMGiD5AopZCBMbOS8ynYHFRRmvRt0puP3erAu063rA3jhhWaFn9gxzEJOE3SUoKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3OANg3pb77vSPrRf9q7JBq/KaBPdWO9VLhXNz7IZy+g=;
 b=N9HL7PoS0/V7/E0x6Q2d/TFgVUweFL1OIZWmnF6MvEc1oPk4GLTJxlyhG/hgscrtP5iWa4DysxLnY5/ZgEuLX0TVadNISOetrNBrpWV/tZplU2VZbcNoS1RVoxjlNzeKzO+l5qPZucg8q8AoRZipY2h/tl1qw8iWE9zPtB3AoFUVAJE6KSjrx3FNyo51wOE5BFEVrkIvlqGvaczSs3uVZk3IMhtHmS2fIT0r0eItCYUO+tjJKc6GD/g7jgmtVWTh3e7Tz73mgv+qg06+GZV0J0RgSvsRc8JVcYqLS0CFhyVzU/3DTjeLI0FPH+BNDsyYJGhe0+E7G20M6WRNxELDPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BN7PR12MB2593.namprd12.prod.outlook.com (20.176.27.87) by
 BN7PR12MB2802.namprd12.prod.outlook.com (20.176.27.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.22; Mon, 2 Dec 2019 17:35:06 +0000
Received: from BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::2070:7583:3718:d019]) by BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::2070:7583:3718:d019%3]) with mapi id 15.20.2495.014; Mon, 2 Dec 2019
 17:35:06 +0000
From: sunpeng.li@amd.com
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 20/51] drm/amd/display: fixed that I2C over AUX didn't read
 data issue
Date: Mon,  2 Dec 2019 12:33:34 -0500
Message-Id: <20191202173405.31582-21-sunpeng.li@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9c0128ce-03eb-4d02-9274-08d7774df860
X-MS-TrafficTypeDiagnostic: BN7PR12MB2802:|BN7PR12MB2802:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN7PR12MB28021C305B3FC2CCF3971C3082430@BN7PR12MB2802.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-Forefront-PRVS: 0239D46DB6
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(136003)(366004)(376002)(396003)(39860400002)(189003)(199004)(81166006)(81156014)(86362001)(6486002)(9686003)(6506007)(2870700001)(478600001)(386003)(76176011)(5660300002)(51416003)(186003)(1076003)(52116002)(3846002)(6116002)(47776003)(2616005)(26005)(66946007)(66066001)(25786009)(316002)(446003)(11346002)(14454004)(66476007)(66556008)(48376002)(8676002)(50226002)(305945005)(6512007)(36756003)(2906002)(99286004)(6666004)(7736002)(2351001)(54906003)(4326008)(2361001)(6916009)(6436002)(50466002)(8936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN7PR12MB2802;
 H:BN7PR12MB2593.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FvKIPPFp6rgT1x5oar/nb0TfBe3Q8AUdj/+5Yz8npQT3BIWD8cAfyWJXYAiPdrbEQ70C5+l+77ffYfC/w9ohYkBSqjrbnrY3ckhdXy/DPkKBaVOT9cZM8c1LnaAqav0gpnigpzUbpIlBnOO5L4LZxUAIufLKUUU1A7bwHELLwtqlMdvKsk6GsFC5/yBCw1SmN5k2OGRlxY70U/OqR4khFa3mUNP5ziWhu6WjQMPWLZwrOYyK+B3VrOKdR9GtOaJ/o3ahcWAt6Cx/dMxVuMy9fNVMAyBj2PhevMHrugoqbqN+tPFfbrwlji6Pyaknr7Y3DcJNyydn6FTq18u2qntg2xnOFpXM3y1KMiglU8bR3rZaaDY4rVNcYs2a5v/qxe0RGMT2xmZAWhGQJSFoV8ZfIdEVgxCVe8iyYhiEc/lgTZphSi21EJRjaOgiWFyctMHV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c0128ce-03eb-4d02-9274-08d7774df860
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2019 17:35:06.1758 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gMxbH3Fjm9YiAyFHg+CkXU95iPYcety0beI4Yj+r6D+ImqpoqXrThyDZF9XqDoG2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2802
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3OANg3pb77vSPrRf9q7JBq/KaBPdWO9VLhXNz7IZy+g=;
 b=FQh42epUMI4o3JaKG6xga9MRVCmLe9yNC0WPiAOVwwcqYegQjdJXndlx/GoIgZPGcftpKcwF1WwO2C3B/xOWTw/Bmlmqx0uNBSL+k2L4xAddZSRO5L/UtwLi107F+7CIvLpVxY+aXVqisMSGih9T7OirIJZSFylwsxxMDNH8RZc=
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
Cc: Charlene Liu <Charlene.Liu@amd.com>, Leo Li <sunpeng.li@amd.com>,
 harry.wentland@amd.com, rodrigo.siqueira@amd.com,
 Brandon Syu <Brandon.Syu@amd.com>, bhawanpreet.lakha@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RnJvbTogQnJhbmRvbiBTeXUgPEJyYW5kb24uU3l1QGFtZC5jb20+CgpbV2h5XQpUaGUgdmFyaWFi
bGUgbWlzbWF0Y2ggYXNzaWdubWVudCBlcnJvci4KCltIb3ddClRvIHVzZSB1aW50MzJfdCByZXBs
YWNlIGl0LgoKU2lnbmVkLW9mZi1ieTogQnJhbmRvbiBTeXUgPEJyYW5kb24uU3l1QGFtZC5jb20+
ClJldmlld2VkLWJ5OiBDaGFybGVuZSBMaXUgPENoYXJsZW5lLkxpdUBhbWQuY29tPgpBY2tlZC1i
eTogTGVvIExpIDxzdW5wZW5nLmxpQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9k
aXNwbGF5L2RjL2NvcmUvZGNfbGlua19kZGMuYyAgICAgIHwgMiArLQogZHJpdmVycy9ncHUvZHJt
L2FtZC9kaXNwbGF5L2luY2x1ZGUvaTJjYXV4X2ludGVyZmFjZS5oIHwgMiArLQogMiBmaWxlcyBj
aGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGNfbGlua19kZGMuYyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjX2xpbmtfZGRjLmMKaW5kZXggM2ZjOTc1MmVk
ZmUwLi5jMmMxMzZiMTIxODQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxh
eS9kYy9jb3JlL2RjX2xpbmtfZGRjLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5
L2RjL2NvcmUvZGNfbGlua19kZGMuYwpAQCAtNTg5LDcgKzU4OSw3IEBAIGJvb2wgZGFsX2RkY19z
ZXJ2aWNlX3F1ZXJ5X2RkY19kYXRhKAogYm9vbCBkYWxfZGRjX3N1Ym1pdF9hdXhfY29tbWFuZChz
dHJ1Y3QgZGRjX3NlcnZpY2UgKmRkYywKIAkJc3RydWN0IGF1eF9wYXlsb2FkICpwYXlsb2FkKQog
ewotCXVpbnQ4X3QgcmV0cmlldmVkID0gMDsKKwl1aW50MzJfdCByZXRyaWV2ZWQgPSAwOwogCWJv
b2wgcmV0ID0gMDsKIAogCWlmICghZGRjKQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9kaXNwbGF5L2luY2x1ZGUvaTJjYXV4X2ludGVyZmFjZS5oIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9kaXNwbGF5L2luY2x1ZGUvaTJjYXV4X2ludGVyZmFjZS5oCmluZGV4IGJiMDEyY2IxYTlmNS4u
YzdmYmI5YzNhZDZiIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvaW5j
bHVkZS9pMmNhdXhfaW50ZXJmYWNlLmgKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5
L2luY2x1ZGUvaTJjYXV4X2ludGVyZmFjZS5oCkBAIC00Miw3ICs0Miw3IEBAIHN0cnVjdCBhdXhf
cGF5bG9hZCB7CiAJYm9vbCB3cml0ZTsKIAlib29sIG1vdDsKIAl1aW50MzJfdCBhZGRyZXNzOwot
CXVpbnQ4X3QgbGVuZ3RoOworCXVpbnQzMl90IGxlbmd0aDsKIAl1aW50OF90ICpkYXRhOwogCS8q
CiAJICogdXNlZCB0byByZXR1cm4gdGhlIHJlcGx5IHR5cGUgb2YgdGhlIHRyYW5zYWN0aW9uCi0t
IAoyLjI0LjAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
