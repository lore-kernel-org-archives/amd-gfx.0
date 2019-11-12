Return-Path: <SRS0=8kND=ZE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A90D2C43331
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 06:37:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B45B214E0
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 06:37:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B45B214E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39C006E22B;
	Tue, 12 Nov 2019 06:37:18 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690078.outbound.protection.outlook.com [40.107.69.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A1B96E22B
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Nov 2019 06:37:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LwonLCtjkyBgU4zat8p9+EL1wPpVYOusbtODIcg2Ld8sIHA5W7tGhJI9YPw9dVQyB/a9zOd4V5VIZogTKLrb4c+UpEqhJ2ODILc/LeDeUbUgUkK1hDEYI8v0W7U/ejAr438Wh81CDLhNwqenMiA+0EcApPh5UudXzorQ6Pyv51bBLqDtO63yoPeYpsQctlbL03rHnfdY8Etr3qEXfR2RydQq4fTExijLZ1iImXp+RdPZdCBqaxq5CKKTdPXjB1RZxdwufPwJU9WfxK+b0wYO5+P+2yKFHBSQpPhW1wybERIWHinVzk2iQxVLWF6dFAmp8nvvAIm4S3hHgPuAEOQHaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v/ngLTBQoueevLz5LcCkEbnzXEOIkLhHmvwqIWLs8AY=;
 b=RzYTZZZ+m4q8KmeS5QAMK6eqjaJpFoFd7XAme+uvlNrxhPcDbrPjPQPDm/ayykdlf//vMlTsrpZRAtQMgVejbcA1dZx665I1DFMuWVNi0sQnscMzUWFMqG8yPLSCDoeE1zjERSyJT8R2kXPjDP7FbT8G6hD3gbV397RppPJAc+UbGqF1rBbF7w7wpEZbN9usHfPsJWru/AoexDk1M9R2rFnpi2nSiMxZXYxbH4db4HHsMKoEd8191OnFnQFJas1FSOsyO1iRNTldOE3Ruu4Oqiriw+GXZWvW3Z5oehpQ/glN7e9Damn+uL0HaXcirbT96DkMMv/zqespgLV1AybFzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB3741.namprd12.prod.outlook.com (10.255.236.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.22; Tue, 12 Nov 2019 06:37:15 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::5895:bbd8:c1d6:1587]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::5895:bbd8:c1d6:1587%7]) with mapi id 15.20.2430.027; Tue, 12 Nov 2019
 06:37:15 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/powerplay: issue BTC on Navi during SMU setup
Date: Tue, 12 Nov 2019 14:36:54 +0800
Message-Id: <20191112063654.5360-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.24.0
X-ClientProxiedBy: HK2PR02CA0205.apcprd02.prod.outlook.com
 (2603:1096:201:20::17) To MN2PR12MB3344.namprd12.prod.outlook.com
 (2603:10b6:208:c5::10)
MIME-Version: 1.0
X-Mailer: git-send-email 2.24.0
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8b07de50-c5fd-46c9-da7a-08d7673ac1b4
X-MS-TrafficTypeDiagnostic: MN2PR12MB3741:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB374160A02B935E213B831FACE4770@MN2PR12MB3741.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-Forefront-PRVS: 021975AE46
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(366004)(346002)(136003)(39860400002)(376002)(199004)(189003)(14454004)(36756003)(8676002)(476003)(2361001)(6436002)(51416003)(52116002)(2351001)(8936002)(14444005)(386003)(6506007)(486006)(66946007)(316002)(4326008)(50226002)(6512007)(81156014)(81166006)(5660300002)(6666004)(66476007)(66556008)(86362001)(2870700001)(25786009)(66574012)(44832011)(48376002)(1076003)(3846002)(6116002)(478600001)(2906002)(99286004)(7736002)(47776003)(186003)(66066001)(305945005)(2616005)(6486002)(26005)(6916009)(50466002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3741;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v0SYethHboARoo12Rfr3aXt6AeWbfbtwcZUS7ffgmv/ZE346ky3OH48GACxjByVM2socVyFVpQtMGvaMB1caUdl06xuJbU2gJilzpf003Qwp7BNmFDHqldOtEZKNXDIlAq5uN87/opulJEpdZ+28wJVMw3lCd/2QdV2B3Q17/G8YfDJx/wTUdFHsNLLsbGM24yrTZc4BdREaP6teUo53eFrpCg/EifKsnmwsojfh6+dk/e816+3Jsy3UPP7JbTLe9Vrf0U7ih4+FvTsk0yRR6xzku8c353JtJAjZ11IaHtAqd2yuLqrkIMWL/vWTJNQ7Bcv5kxpxNdVL4qnX8EHtnvqdyv2fOGGmzbQmcywsmPllpgB0YtFVR5X6Onov0dHSqQTVpjA7HQC/YQJsrg2Qu4y5pqh6WCBH6OhWr75eSGJRdslY+RziKkwoqnIQwhhS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b07de50-c5fd-46c9-da7a-08d7673ac1b4
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2019 06:37:15.6221 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /lBzr4694CK9BVI57wgzz7TlieJz8jcsco2rM5UBQpAUPpTJ8WCsS1X4PpRm/Y7f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3741
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v/ngLTBQoueevLz5LcCkEbnzXEOIkLhHmvwqIWLs8AY=;
 b=UK3Zo65fN//ReiVgX3YNNbf2mWSSynGSBPi9q7rWGdUDVgZ3TcfBHkmwGUhVoX/Xt9kkpAAzUE3sfjoy0rlppdACpuw3w47BcQPEzsj8RWBMOr6oSQK3DVh8rrxdppXufvqpZ+VAGMpG5UoOGE5zaYcTChp5tIi0HZmU6t/b1FM=
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
Message-ID: <20191112063654.GEgi9Py-q9OXEt36Cp3Bdfe7H3aA5vyj-QCQgTmnWOk@z>

UnVuQlRDIGlzIGFkZGVkIGZvciBOYXZpIEFTSUMgb24gaGFyZHdhcmUgc2V0dXAuCgpDaGFuZ2Ut
SWQ6IEkxYzA0YjQ4MWVkMTRkNWYxMmMyMGI3YjBkNTkyYjYyYTY1ODg5ZTRhClNpZ25lZC1vZmYt
Ynk6IEV2YW4gUXVhbiA8ZXZhbi5xdWFuQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2Ft
ZC9wb3dlcnBsYXkvbmF2aTEwX3BwdC5jIHwgMTEgKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2Vk
LCAxMSBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dl
cnBsYXkvbmF2aTEwX3BwdC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvbmF2aTEw
X3BwdC5jCmluZGV4IDAxMGJlMjFiZWU1Yi4uNDMzYWNiMGY0NTlkIDEwMDY0NAotLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9uYXZpMTBfcHB0LmMKKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9wb3dlcnBsYXkvbmF2aTEwX3BwdC5jCkBAIC0xNjUyLDYgKzE2NTIsMTYgQEAgc3Rh
dGljIGludCBuYXZpMTBfdXBkYXRlX3BjaWVfcGFyYW1ldGVycyhzdHJ1Y3Qgc211X2NvbnRleHQg
KnNtdSwKIAlyZXR1cm4gcmV0OwogfQogCitzdGF0aWMgaW50IG5hdmkxMF9ydW5fYnRjKHN0cnVj
dCBzbXVfY29udGV4dCAqc211KQoreworCWludCByZXQgPSAwOworCisJcmV0ID0gc211X3NlbmRf
c21jX21zZyhzbXUsIFNNVV9NU0dfUnVuQnRjKTsKKwlpZiAocmV0KQorCQlwcl9lcnIoIlJ1bkJ0
YyBmYWlsZWQhXG4iKTsKKworCXJldHVybiByZXQ7Cit9CiAKIHN0YXRpYyBjb25zdCBzdHJ1Y3Qg
cHB0YWJsZV9mdW5jcyBuYXZpMTBfcHB0X2Z1bmNzID0gewogCS50YWJsZXNfaW5pdCA9IG5hdmkx
MF90YWJsZXNfaW5pdCwKQEAgLTE3NDEsNiArMTc1MSw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qg
cHB0YWJsZV9mdW5jcyBuYXZpMTBfcHB0X2Z1bmNzID0gewogCS5nZXRfZHBtX3VsdGltYXRlX2Zy
ZXEgPSBzbXVfdjExXzBfZ2V0X2RwbV91bHRpbWF0ZV9mcmVxLAogCS5zZXRfc29mdF9mcmVxX2xp
bWl0ZWRfcmFuZ2UgPSBzbXVfdjExXzBfc2V0X3NvZnRfZnJlcV9saW1pdGVkX3JhbmdlLAogCS5v
dmVycmlkZV9wY2llX3BhcmFtZXRlcnMgPSBzbXVfdjExXzBfb3ZlcnJpZGVfcGNpZV9wYXJhbWV0
ZXJzLAorCS5ydW5fYnRjID0gbmF2aTEwX3J1bl9idGMsCiB9OwogCiB2b2lkIG5hdmkxMF9zZXRf
cHB0X2Z1bmNzKHN0cnVjdCBzbXVfY29udGV4dCAqc211KQotLSAKMi4yNC4wCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlz
dAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
