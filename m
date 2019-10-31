Return-Path: <SRS0=0yA7=YY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 496F7CA9ECE
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Oct 2019 14:42:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2970920873
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Oct 2019 14:42:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2970920873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5AA26EEB4;
	Thu, 31 Oct 2019 14:42:55 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770080.outbound.protection.outlook.com [40.107.77.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 104566EEB1
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Oct 2019 14:42:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EP1ppbl+WHCiZrsELgWVN8UD1Vc3Hd07RGqtXpUzYLX0UEJuqF6hWJM3RzVvuq9hRcwR2GvSxIsMFC9uah30zlfZ81S9V8MWhzxl/W9p+s3xdZ9Vng9Usg7wjGz8qNYSGqcUvE0Hzvtr4gyoRouBrh32RA+pNBYYB2fbv8BpsO+/N+imi7m9oLw2HQNZjUP4mWBMp8t3miDciTYId1f/f6xlmgRACNnOyb8nEhXTmHEpzQrhItWBeSMkQxZBEIZvjvZ+RAFtKLVNUJHqntMryufW6xeeAnx+sC1gPBFJSex0toCKF707fnvldvvGuJvNgIs71JIX62OcKSk024XdNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=im14hV8q3d6de8JopOHrqkGko1Ch4mZTBMoAf9RX8Uk=;
 b=R+GoxU4pM7vGqMNsmB52Vzm/CfOWZkIjcGecixmsvS9MKEJcOFfE73pwqALzGLTvx5+oMgftB/f5KaPbX39ZOBJtwy4jTZCMkeFCryGBiHvYQMoOAl5L+Oqcla7MyRk4wO+c3qVse3OCcgoJotTwZp9o93obv1/iJDUxxLOu+zDKjWcxj1krKx4re20WCNxCTrt4NbIMNFQNfnfOZAar56aWnXVbL/C3Nf+QXuv4ToDwfKb3ffVnDiGFkZnIp+djOQxsNc4F2flftW/GF0BcHEhHL0oTWQbDFL42ZBhavG98xm7WJxtKMzo0b6DjOh2/PgGvwp9FIC2JgHnZO817iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from MWHPR1201CA0019.namprd12.prod.outlook.com
 (2603:10b6:301:4a::29) by MWHPR1201MB0047.namprd12.prod.outlook.com
 (2603:10b6:301:54::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2387.22; Thu, 31 Oct
 2019 14:42:41 +0000
Received: from DM3NAM03FT046.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e49::200) by MWHPR1201CA0019.outlook.office365.com
 (2603:10b6:301:4a::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2408.19 via Frontend
 Transport; Thu, 31 Oct 2019 14:42:41 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM3NAM03FT046.mail.protection.outlook.com (10.152.83.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2387.20 via Frontend Transport; Thu, 31 Oct 2019 14:42:40 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 31 Oct
 2019 09:42:38 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 31 Oct
 2019 09:42:38 -0500
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 31 Oct 2019 09:42:37 -0500
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/20] drm/amd/display: 3.2.58
Date: Thu, 31 Oct 2019 10:42:00 -0400
Message-ID: <20191031144210.24011-11-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191031144210.24011-1-Bhawanpreet.Lakha@amd.com>
References: <20191031144210.24011-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(396003)(39860400002)(136003)(376002)(428003)(189003)(199004)(478600001)(2351001)(8936002)(50466002)(6666004)(356004)(48376002)(70206006)(6916009)(305945005)(336012)(186003)(86362001)(26005)(446003)(486006)(426003)(76176011)(11346002)(16586007)(51416003)(36756003)(8676002)(2906002)(4326008)(70586007)(2616005)(316002)(50226002)(4744005)(126002)(1076003)(14444005)(5660300002)(53416004)(476003)(7696005)(47776003)(81166006)(81156014);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR1201MB0047; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1eb6a394-3855-461b-4baa-08d75e109510
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0047:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB004711439B1B766ACFFD3754F9630@MWHPR1201MB0047.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-Forefront-PRVS: 02070414A1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: seXuzZ+WMbcwWwnYOX/u+Nt6etJgca/4Ii6ofR1p0Kmkq35NH67u1eD4leC8lZD98p/E4COqd1/xaS/YMxDu/JJr7XEFIUlFh/WmO6/CLr1Yq3FOj83Q+2oGDHL7ABA+lRneJMILC8WRyp9F+CDMNj430dg4Mk8MwZSaOXM02YhoG3WHOsV6J8UeDSjRvYvYIFUW7gh8STFRYmTtzl9w4QsL7UmGbjbFMXxyFYzqaZRAqYvb//V7iaaV6YCkDUCY2cTCJXNIrAJrMkoclN2rYV6dOIjbVWQPiaLJ2pBKLbky+Wpu5z7LOMTqecVaOi7Jh9JF3Wmp6EQGNCIbvLt5bsAIuyWri0473SY7EFjW1ST9C6Dfk1GQkfY07GEo73nUt3Wsj9u0KoZ3LpOBBS1QQx1ZpQy90D35gNw+rdluq/K8o4w06J6yA540plvC5cZx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2019 14:42:40.8594 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eb6a394-3855-461b-4baa-08d75e109510
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0047
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=im14hV8q3d6de8JopOHrqkGko1Ch4mZTBMoAf9RX8Uk=;
 b=Kosyz1l7y6KAnCIFaH5sjE/4UWld4iGVuIkqijr2BB1xwu/JRiYnjQ8w91QRY/JEc+SMqiuha7K1vdKL+HQwwzVHPioIIt7ecWu5aujhbhkFelKfpdZxqr89fS8bfYAZr7G5KAsHcUrBd3YLoXcLZCDl4q1SyzeYmsul1F8j860=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is
 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
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
Cc: Aric Cyr <aric.cyr@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191031144200.ffM_1jlut0xIb1jrxWK8hVOpKR_KKYZIQIkZqWqTTk0@z>

RnJvbTogQXJpYyBDeXIgPGFyaWMuY3lyQGFtZC5jb20+CgpTaWduZWQtb2ZmLWJ5OiBBcmljIEN5
ciA8YXJpYy5jeXJAYW1kLmNvbT4KUmV2aWV3ZWQtYnk6IEJoYXdhbnByZWV0IExha2hhIDxCaGF3
YW5wcmVldC5MYWtoYUBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9k
Yy9kYy5oIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9u
KC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjLmggYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGMuaAppbmRleCA3YmYwMjQxOTk5YzcuLjMy
ZWFmZmY2YjA0MyAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2Rj
LmgKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjLmgKQEAgLTM5LDcgKzM5
LDcgQEAKICNpbmNsdWRlICJpbmMvaHcvZG1jdS5oIgogI2luY2x1ZGUgImRtbC9kaXNwbGF5X21v
ZGVfbGliLmgiCiAKLSNkZWZpbmUgRENfVkVSICIzLjIuNTciCisjZGVmaW5lIERDX1ZFUiAiMy4y
LjU4IgogCiAjZGVmaW5lIE1BWF9TVVJGQUNFUyAzCiAjZGVmaW5lIE1BWF9QTEFORVMgNgotLSAK
Mi4xNy4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwph
bWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
