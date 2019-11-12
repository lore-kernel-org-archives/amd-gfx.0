Return-Path: <SRS0=8kND=ZE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F3CCC17447
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 00:34:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D3682184C
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 00:34:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D3682184C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C10436EA32;
	Tue, 12 Nov 2019 00:33:59 +0000 (UTC)
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr800044.outbound.protection.outlook.com [40.107.80.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88C956EA31
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Nov 2019 00:33:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fv0Dy7vv3wPsoj9cb062mlWa6MlInm7gUIoD3d+dYJfFuThJppExUM+o9KCT83pDUKhgtuvHzRkyT/XTFLyU6A2PWbtLJ5b0CW3emS5g65ZdfP5OHpLa6Fpz58YRml3H8HoJYDOFKqvOnxNq9+Lsvmm2k8POofi8oaRuXXmooiK92N+3oMgP8y5+ENDXhORiolokQ/SrRGLHCnOVloylCslMNnWMHktY3vh+9F+LzgnImcWyugudS2e9lN2WpJif9D7ZLaTTV286uINJ+G8o7D+z4jT9G4fiN7NL7MBrec1pE+jDTe+ecptYILeLru5pu10Gm31ECdTZHJwWqrgOxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7kqhVxI0jvvEBLv2cxzFV/Binm5ss2x3sLWJ6+bmU0c=;
 b=XuaWjmRmuLUensmPqS/NfdJEx3x/F5TaQ+NCu4/mhDE5y//2a8OnN5XEv52LY5cLlo2kEq/NHga79CtXlYmmG+Hfh2QEY+33DoftpW0oHV9uF1k6xwQTXXSR2ZIRBFJb1IwCYfgHimRT0OAkwjQl6b3/lN9kp3pTDklg4Bb29KYFFIY7hZgseFq0nkKLsJ08iPWmt5hUmo63rdyRtdKZh68zXJOA/INkBH/hHuXko0UqRt6bcCBjcO/3IdG7Sp7vsjHiuiMdxBN1NAn0vSD7+2uFnP7Hu+/bFBlYp9AZal5a0PQuYdRJnHr1sBQwBgj54GfS25QqjuVsXiK2ZuGpnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) by
 MW2PR12MB2554.namprd12.prod.outlook.com (52.132.180.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.25; Tue, 12 Nov 2019 00:33:54 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69%5]) with mapi id 15.20.2430.027; Tue, 12 Nov 2019
 00:33:54 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 13/30] drm/amd/display: Connect DIG FE to its BE before link
 training starts
Date: Mon, 11 Nov 2019 19:33:07 -0500
Message-Id: <20191112003324.8419-14-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191112003324.8419-1-Rodrigo.Siqueira@amd.com>
References: <20191112003324.8419-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTBPR01CA0012.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::25) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-Mailer: git-send-email 2.24.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 783cc29a-8939-4201-0663-08d76707ff28
X-MS-TrafficTypeDiagnostic: MW2PR12MB2554:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2554F99EF7682C356158ED4498770@MW2PR12MB2554.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 021975AE46
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(366004)(396003)(346002)(39860400002)(376002)(189003)(199004)(76176011)(6916009)(81166006)(81156014)(386003)(8676002)(478600001)(6506007)(51416003)(52116002)(2870700001)(25786009)(2906002)(186003)(2361001)(3846002)(316002)(66066001)(47776003)(50466002)(4326008)(26005)(66946007)(6116002)(36756003)(1076003)(8936002)(48376002)(50226002)(54906003)(2616005)(305945005)(486006)(5660300002)(6512007)(14454004)(2351001)(446003)(6486002)(6666004)(99286004)(66556008)(476003)(66476007)(11346002)(86362001)(6436002)(7736002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2554;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FU61mGeiXdLbFiPbRc/okFhSRgWVanpiBkybi12TUz57h2648/p9EQ2N7lL5oWACMzNIFziIefhXYFerV5ZUG+PBBwXsZ4XqnR1orV9doB9o9q1be28NiVadhl0wH4KdzUQP8bAtGgfhxtk+XqBCgBeHaIDn0uzbRqzGR6iiLahucC/HD8JGg+ZGLlh+AJSzHNvnwFZleXaw8xD7OrRjhPWZ6Lcu7Wp1NrNh2L0TjKptllf0BbhzTthIWRKKf9XdxTtV+mdiwfthZ7F05aZHsa8iCsqozAiOa30gUNnBhEa2fnFKUIm8ccBr/LPUMKmVmA48EJagtXe3TNNTYAu5AMlzycrfmDd/1ZoLw3/yO/n2lFbuemAitrBZbFN3Eo0x37U+rCca8JJD88ya1MNl9PllpRDgl2Z6LKKAP5esEzmCGGuGrQ+KkonwBVG/M718
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 783cc29a-8939-4201-0663-08d76707ff28
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2019 00:33:54.2208 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WrllqmksaNQVM3cChfCbzjmt3Tb5hRxzQNeoH2eMJ39o7lRiBVTz0aB9Jr0IqUVxtJ3nNNRR8iuMr8Ab4CxuqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2554
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7kqhVxI0jvvEBLv2cxzFV/Binm5ss2x3sLWJ6+bmU0c=;
 b=JYnIgCAw8awYrr9bFfL8L3jKw0GBZfsHdJEVqvzvo2qbWgiTp8ZVt5bQGay3oTwr4OpCeFgluU4Q78myYviESDs5XpbHL+VTPON8o1KJab4Ybyl5PsiBHRyLSQX4BZ/6EC6LoLpqqSN2GA2tGYQG9WgP7Dc1TawW+miyLaqS390=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
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
Cc: Tony Cheng <Tony.Cheng@amd.com>, Nikola Cornij <nikola.cornij@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191112003307.rtsBCzxNJMHNc7E-Wc93YzTfGYx2i76gW4hqbOldhx8@z>

RnJvbTogTmlrb2xhIENvcm5paiA8bmlrb2xhLmNvcm5pakBhbWQuY29tPgoKW3doeV0KSW4gU1NU
IG1vZGUgbm8gaWRsZSBwYXR0ZXJuIHdpbGwgYmUgZ2VuZXJhdGVkIGFmdGVyIGxpbmsgdHJhaW5p
bmcgaWYKRElHIEZFIGlzIG5vdCBjb25uZWN0ZWQgdG8gRElHIEJFLgoKU2lnbmVkLW9mZi1ieTog
Tmlrb2xhIENvcm5paiA8bmlrb2xhLmNvcm5pakBhbWQuY29tPgpSZXZpZXdlZC1ieTogVG9ueSBD
aGVuZyA8VG9ueS5DaGVuZ0BhbWQuY29tPgpBY2tlZC1ieTogUm9kcmlnbyBTaXF1ZWlyYSA8Um9k
cmlnby5TaXF1ZWlyYUBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9k
Yy9jb3JlL2RjX2xpbmsuYyB8IDQgKysrKwogMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygr
KQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjX2xp
bmsuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjX2xpbmsuYwppbmRl
eCBiZGM4YmUzNzNmZjAuLjFlMWY0NjFjYmIzYyAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9kaXNwbGF5L2RjL2NvcmUvZGNfbGluay5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
ZGlzcGxheS9kYy9jb3JlL2RjX2xpbmsuYwpAQCAtMTU0Niw2ICsxNTQ2LDEwIEBAIHN0YXRpYyBl
bnVtIGRjX3N0YXR1cyBlbmFibGVfbGlua19kcCgKIAlwYW5lbF9tb2RlID0gZHBfZ2V0X3BhbmVs
X21vZGUobGluayk7CiAJZHBfc2V0X3BhbmVsX21vZGUobGluaywgcGFuZWxfbW9kZSk7CiAKKwkv
KiBXZSBuZWVkIHRvIGRvIHRoaXMgYmVmb3JlIHRoZSBsaW5rIHRyYWluaW5nIHRvIGVuc3VyZSB0
aGUgaWRsZSBwYXR0ZXJuIGluIFNTVAorCSAqIG1vZGUgd2lsbCBiZSBzZW50IHJpZ2h0IGFmdGVy
IHRoZSBsaW5rIHRyYWluaW5nICovCisJbGluay0+bGlua19lbmMtPmZ1bmNzLT5jb25uZWN0X2Rp
Z19iZV90b19mZShsaW5rLT5saW5rX2VuYywKKwkJCQkJCSAgICBwaXBlX2N0eC0+c3RyZWFtX3Jl
cy5zdHJlYW1fZW5jLT5pZCwgdHJ1ZSk7CiAJc2tpcF92aWRlb19wYXR0ZXJuID0gdHJ1ZTsKIAog
CWlmIChsaW5rX3NldHRpbmdzLmxpbmtfcmF0ZSA9PSBMSU5LX1JBVEVfTE9XKQotLSAKMi4yNC4w
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4
IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
