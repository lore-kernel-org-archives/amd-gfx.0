Return-Path: <SRS0=8kND=ZE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9908C17441
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 00:34:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8C532184C
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 00:34:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8C532184C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CC426EA38;
	Tue, 12 Nov 2019 00:34:04 +0000 (UTC)
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr800087.outbound.protection.outlook.com [40.107.80.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9BC26EA35
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Nov 2019 00:34:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XR1eZbybyAuUv4YHuW7ajEZehvs+Au9Tj/FfJjVtdG/gt4epQxpkzBWNNDjc2lwd7kWL24TcTVq2JJy/1cIQLngt0UV1Or5ivGUsqth/WRL8Q1P0/GsNWEaSZx0qY4y5hwb15sKGeJuDWhxhLaT0/bG3ZHmeN6TzaKLhCoGwyvylHtEFimpMU9pXJMKuITpDSQxDL+lcK2t2J5vjMcQBUO51N+JrNKIQps7LRad9Ej2sZ7WdwqFtbwN+7qAiOeN0ecvbaea1ii0sv8Xbqun8UWG0uWvxuAHqodB2ipQcRAzvh/UEWvjeELdinClOBtUyQ9Fgh+k3YUSBO3rydS9DGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A5Q7keIZUfq7YnK7Fiplun7VUFGWjlvWMkwq++7LKsU=;
 b=QEAQo5KT3RCT6TuoDHFwpYehbexF7LEKaJWKkIku7wHPE9x4fZZQd9ZTagSfhKju3h7AqK4OuPii36OselhXoZ9ARmVs243lHeibtay1xHkqvYsEF74MbH7fEZ6xqEPjwUbtrZ83f07fTsJGbcH+bvT7sB0QuT8gceVg3TiESOaFM8WzLUmAu+qUNxTDUgF6nbrQ5l8kr4JGFhvtaShwzrUpV4J1jcUc5Ohh+3K5/TtOVyHC8MzoAsWQrRFJIoSUHy9yviZLK3VCLPZo9Lgf1dG5OM00Jg24goJrt7KpDge3cNJCUFO5C5HErVKxvqBQ1yHQbR9RZC61T1WA1qZluA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) by
 MW2PR12MB2554.namprd12.prod.outlook.com (52.132.180.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.25; Tue, 12 Nov 2019 00:34:00 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69%5]) with mapi id 15.20.2430.027; Tue, 12 Nov 2019
 00:34:00 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 21/30] drm/amd/display: 3.2.60
Date: Mon, 11 Nov 2019 19:33:15 -0500
Message-Id: <20191112003324.8419-22-Rodrigo.Siqueira@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: c18146f1-5ad1-492f-8003-08d76708028e
X-MS-TrafficTypeDiagnostic: MW2PR12MB2554:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB25540A928CA55D098917D0B998770@MW2PR12MB2554.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-Forefront-PRVS: 021975AE46
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(366004)(396003)(346002)(39860400002)(376002)(189003)(199004)(76176011)(6916009)(81166006)(81156014)(386003)(8676002)(478600001)(6506007)(51416003)(52116002)(2870700001)(25786009)(14444005)(2906002)(186003)(2361001)(3846002)(316002)(66066001)(47776003)(50466002)(4326008)(26005)(66946007)(6116002)(36756003)(1076003)(8936002)(48376002)(50226002)(54906003)(2616005)(305945005)(486006)(5660300002)(6512007)(14454004)(2351001)(446003)(6486002)(6666004)(99286004)(66556008)(476003)(66476007)(11346002)(86362001)(4744005)(6436002)(7736002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2554;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V1ZOFyW7zLTK7er4WKgJjUTs8i1buhbnkpN0VLZLXdBg9YMEn4aFRuRziutFQD+XMBcR/JgRCTli3jQgneiaZVOfgvii4Vd0ORFA3topn89+RdchlIqZdYFIeXXO0F0Z4QG1nlX5fMZ2Uoso5BvbH9AxjRyQw2+9+FARRq+2oMF15MxPR1np+VlJvFehc30TKXEFA2/dfdt2LhBFplu7lNZZAcAeq5BOEZ4uh2P5HdMc7+QlxFGaADDnYWcm2UWkx8V5pqHYxdMGo2OFziAiziREctogqaOdhyLNgARoz5cSdpy/fkhJHtY10IIplSF57GAczp/yJWHbmwS5UeKY0TLnLcJMlslX+A+jqBjdOmjciIkp0WffTcLZGrZbOhb9mG2tu9uorJzuqt2pd/nwOfxpGIXkgLKlgoZN9nv/RVrDrO8UBZomcNztHfwO2yAu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c18146f1-5ad1-492f-8003-08d76708028e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2019 00:33:59.9215 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EyBCU956zNWQ4rVUd9+awbKh60DD3xvR7y5HsSBvPxWsWUES6bANfxuhpSQH7Fi7pDfiFLzVIa5ZOZ3uYt9NNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2554
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A5Q7keIZUfq7YnK7Fiplun7VUFGWjlvWMkwq++7LKsU=;
 b=0MnDF4qhodEgKYoKrxMcfomCUp6IoqbOMyLGVkb/iVlMVZS0ethzw8JUpJbLISpuXdv+AfhYutwhJNd5oQrlQX5hKoMBXdmCC9LyqVyVls2Zs2nvOpjO6QFTpy1MCmFyxMA55f1eAkJKrBvQ/JfELCvNu0hbifakwLC1XZmX5X0=
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
Cc: Aric Cyr <Aric.Cyr@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191112003315.ITmsZIbLHB8ehwC_wz7JJuatfMYVkeraugOdg8CsKUE@z>

RnJvbTogQXJpYyBDeXIgPGFyaWMuY3lyQGFtZC5jb20+CgpTaWduZWQtb2ZmLWJ5OiBBcmljIEN5
ciA8YXJpYy5jeXJAYW1kLmNvbT4KUmV2aWV3ZWQtYnk6IEFyaWMgQ3lyIDxBcmljLkN5ckBhbWQu
Y29tPgpBY2tlZC1ieTogUm9kcmlnbyBTaXF1ZWlyYSA8Um9kcmlnby5TaXF1ZWlyYUBhbWQuY29t
PgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kYy5oIHwgMiArLQogMSBmaWxl
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjLmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rp
c3BsYXkvZGMvZGMuaAppbmRleCA0YzZjMmZjYzZhOTYuLmRhOWNiN2RkMjJlNiAxMDA2NDQKLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjLmgKKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9kaXNwbGF5L2RjL2RjLmgKQEAgLTM5LDcgKzM5LDcgQEAKICNpbmNsdWRlICJpbmMv
aHcvZG1jdS5oIgogI2luY2x1ZGUgImRtbC9kaXNwbGF5X21vZGVfbGliLmgiCiAKLSNkZWZpbmUg
RENfVkVSICIzLjIuNTkiCisjZGVmaW5lIERDX1ZFUiAiMy4yLjYwIgogCiAjZGVmaW5lIE1BWF9T
VVJGQUNFUyAzCiAjZGVmaW5lIE1BWF9QTEFORVMgNgotLSAKMi4yNC4wCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAph
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
