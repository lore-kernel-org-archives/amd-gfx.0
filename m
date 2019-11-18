Return-Path: <SRS0=5Use=ZK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6A39C432C0
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Nov 2019 22:25:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6D7222309
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Nov 2019 22:25:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6D7222309
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B4246E842;
	Mon, 18 Nov 2019 22:25:32 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700082.outbound.protection.outlook.com [40.107.70.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 872776E842
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Nov 2019 22:25:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QUEnxsNiUPHaeHgNEhKV+gO04lDK/0XVl4uq51Nujh/UPH4FuJnWIepjhGHKTA9ku3VM7/nR7ukLcy0Xo3OILyAa7z0AlBZUPDllTfJOG12B+ccc7g7YklsFSHvSX6Cb+fUmW/h3kSBugpj+yywzckD2HBezjI6H9WCCN0Cvd6JyQW6ddEo+RuHOORWtsCAsDXO3OnPJZE65gVFXAU6ZmTfLmy76hlvLRFTEUHcb1Wmy3iktiIAiSeO2/5JHtcNhX4Gko4dQwK8ys3G9rtzkMw5YNUF6TE9ng5M1DZo+9k73SobgWYAFyZdTEeL9vIdiQphPIoZn/f+CM1cP7N1Ujw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e5gAzZMq3bmsOAdaqwOjZU5ieK04xuQT9mZxiY4Y2kE=;
 b=NoIneFXmPmI5Fi7GercDilRJ9O4TbviSlPuZxsXkY+C1RAZI2tCUaaUs14g4E0gVFA6047o3/+0KXX8OiXhjHTm+o3eRTqPrbhtIxhbqGVws0p6xB0vc8AeEjvder53T8mnnxYaZdzVSQjm1fwPYIF4pagZUgWU3QAnnXRu6/ARVSb/GNU1Lto06j+tfdwc4yxCw6BrCN5hAElwXdC6Zh+QzwLHPUBNh3pIxKwSRMxTeewN29ppBQawLWs3xCRgfI+e9dqpoIjXJVMr/vOl5kNsMXV1RIEJOcB3JdMgvK/K1Krnp6NmwFH+zB9PzVxlAnYv7ZGw4Ew6+j+tRScsgPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from CH2PR12MB4182.namprd12.prod.outlook.com (20.180.16.11) by
 CH2PR12MB3701.namprd12.prod.outlook.com (52.132.244.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.30; Mon, 18 Nov 2019 22:25:30 +0000
Received: from CH2PR12MB4182.namprd12.prod.outlook.com
 ([fe80::24d1:40a8:f811:6be1]) by CH2PR12MB4182.namprd12.prod.outlook.com
 ([fe80::24d1:40a8:f811:6be1%6]) with mapi id 15.20.2451.029; Mon, 18 Nov 2019
 22:25:30 +0000
From: Alex Sierra <alex.sierra@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] amd/amdgpu: force to trigger a no-retry-fault after a
 retry-fault
Date: Mon, 18 Nov 2019 16:24:35 -0600
Message-Id: <20191118222435.93134-2-alex.sierra@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191118222435.93134-1-alex.sierra@amd.com>
References: <20191118222435.93134-1-alex.sierra@amd.com>
X-ClientProxiedBy: SN6PR0102CA0018.prod.exchangelabs.com (2603:10b6:805:1::31)
 To CH2PR12MB4182.namprd12.prod.outlook.com
 (2603:10b6:610:ae::11)
MIME-Version: 1.0
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 02909c89-9781-4884-2c67-08d76c76382a
X-MS-TrafficTypeDiagnostic: CH2PR12MB3701:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB3701CA014B43DE96843F1363FD4D0@CH2PR12MB3701.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0225B0D5BC
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(39860400002)(136003)(376002)(366004)(396003)(199004)(189003)(25786009)(305945005)(6916009)(48376002)(6506007)(486006)(476003)(2616005)(14444005)(5660300002)(2906002)(14454004)(478600001)(6486002)(3846002)(6436002)(50466002)(186003)(86362001)(44832011)(6116002)(11346002)(446003)(51416003)(2361001)(66946007)(66556008)(66476007)(6512007)(47776003)(2351001)(8936002)(386003)(36756003)(50226002)(66066001)(4326008)(7736002)(76176011)(81156014)(8676002)(81166006)(99286004)(26005)(52116002)(1076003)(16586007)(316002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB3701;
 H:CH2PR12MB4182.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1HwEQH6/Hq283DrjdAHoSx8kJjjcZDudEKExhb8m7I+1O+q81I04kEr5YR/tFNo1DfN+nkTE1uzr86cqdajB70KuBKO77Bb0sdRS8+1TydZJGj5Kn8HxOzWy13RecTmK+1COa5OcBgZz1ykmIoXz5uPeEUPxG3pKeAa2eE94JP3alb0C4w18q06SZ8rMNmGu2pOVGnUz+krLf1/6araA8JpyL6CBv76oEthjMovjYYLvcZmsqRv5XSDT9lqnh9WNkneYvrBcX0OTNERQ9yn+uhZUOxfPt3quVFNikpsDG5U4xajSAnOSO/AFvdzBSR0q3blJh6xpOTuKZGRsVNnNPROzFoG7Q/ABGpiaPTFV4qa9N/swHAtyV5YcuVIrEqd1BQ4cSeBGD+cTCNT/3ttAzicJfL4nwD/xKNsMpwkPXs4vSPCLsXq9RFUGMNzWb9m5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02909c89-9781-4884-2c67-08d76c76382a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2019 22:25:30.2852 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: axXBx6zZ2Fy7dzF4KY2UukWynjVVpW9RECIts+fft2SVNa7h9MKULoliCnlpBO4pKARAm8nExk1IaFqrIxyVvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3701
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e5gAzZMq3bmsOAdaqwOjZU5ieK04xuQT9mZxiY4Y2kE=;
 b=GYPIK/0ENZtv2o6hAXDI9QLd6mdo3ep/c3mxGTue2F2sCEKS66oIzLZfasdKW6sqDGUOR3fx31zPEeOyoGvmEB3Epk0IHCXQO+MOgDE2mdwMCancC+mPH2n1XoKHhjVLbQjUR5oYzlbkjLRdKMOGPK0buA1JSDBGqZ/Z4H0bZ0c=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Alex.Sierra@amd.com; 
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
Cc: Alex Sierra <alex.sierra@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191118222435.mDNDxVdUI370M5MRKKRYWDEb0zFLOXQLs63E1SOt40M@z>

T25seSBmb3IgdGhlIGRlYnVnZ2VyIHVzZSBjYXNlLgoKW3doeV0KQXZvaWQgZW5kbGVzcyB0cmFu
c2xhdGlvbiByZXRyaWVzLCBhZnRlciBhbiBpbnZhbGlkIGFkZHJlc3MgYWNjZXNzIGhhcwpiZWVu
IGlzc3VlZCB0byB0aGUgR1BVLiBJbnN0ZWFkLCB0aGUgdHJhcCBoYW5kbGVyIGlzIGZvcmNlZCB0
byBlbnRlciBieQpnZW5lcmF0aW5nIGEgbm8tcmV0cnktZmF1bHQuCkEgc190cmFwIGluc3RydWN0
aW9uIGlzIGluc2VydGVkIGluIHRoZSBkZWJ1Z2dlciBjYXNlIHRvIGxldCB0aGUgd2F2ZSB0bwpl
bnRlciB0cmFwIGhhbmRsZXIgdG8gc2F2ZSBjb250ZXh0LgoKW2hvd10KSW50ZW50aW9uYWxseSB1
c2luZyBhbiBpbnZhbGlkIGZsYWcgY29tYmluYXRpb24gKEYgYW5kIFAgc2V0IGF0IHRoZSBzYW1l
CnRpbWUpIHRvIHRyaWdnZXIgYSBuby1yZXRyeS1mYXVsdCwgYWZ0ZXIgYSByZXRyeS1mYXVsdCBo
YXBwZW5zLiBUaGlzIGlzCm9ubHkgdmFsaWQgdW5kZXIgY29tcHV0ZSBjb250ZXh0LgoKQ2hhbmdl
LUlkOiBJNDE4MGMzMGUyNjMxZGMwNDAxY2JkNjE3MWY4YTY3NzZlNDczM2M5YQpTaWduZWQtb2Zm
LWJ5OiBBbGV4IFNpZXJyYSA8YWxleC5zaWVycmFAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYyB8IDYgKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgNiBp
bnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3ZtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYwppbmRleCBk
NTFhYzg3NzFhZTAuLjM1OGE0ZjUwZmNmYiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X3ZtLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3ZtLmMKQEAgLTMyMDcsNiArMzIwNywxMiBAQCBib29sIGFtZGdwdV92bV9oYW5kbGVfZmF1
bHQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHVuc2lnbmVkIGludCBwYXNpZCwKIAkJdmFs
dWUgPSBhZGV2LT5kdW1teV9wYWdlX2FkZHI7CiAJCWZsYWdzIHw9IEFNREdQVV9QVEVfRVhFQ1VU
QUJMRSB8IEFNREdQVV9QVEVfUkVBREFCTEUgfAogCQkJQU1ER1BVX1BURV9XUklURUFCTEU7CisK
KwkJaWYgKHZtLT5pc19jb21wdXRlX2NvbnRleHQpIHsKKwkJCS8qIFNldHRpbmcgUFRFIGZsYWdz
IHRvIHRyaWdnZXIgYSBuby1yZXRyeS1mYXVsdCAgKi8KKwkJCWZsYWdzID0gQU1ER1BVX1BURV9F
WEVDVVRBQkxFIHwgQU1ER1BVX1BERV9QVEUgfAorCQkJCUFNREdQVV9QVEVfVEY7CisJCX0KIAl9
IGVsc2UgewogCQkvKiBMZXQgdGhlIGh3IHJldHJ5IHNpbGVudGx5IG9uIHRoZSBQVEUgKi8KIAkJ
dmFsdWUgPSAwOwotLSAKMi4xNy4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Ft
ZC1nZng=
