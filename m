Return-Path: <SRS0=0yA7=YY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58324CA9ECB
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Oct 2019 14:42:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 175F320873
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Oct 2019 14:42:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 175F320873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 029DE6EEA9;
	Thu, 31 Oct 2019 14:42:33 +0000 (UTC)
Received: from NAM05-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr730081.outbound.protection.outlook.com [40.107.73.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E7AD6EEA8
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Oct 2019 14:42:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a3leLnzNofZG1eO6X8kN8B7Ibyl/HAlAhoDxlla4zGuyYqdS+DdGJ3prv0WzvNi9eIej6LNpQLVGmasgOTix+7eDgxihqVO8P0oJnW6LURo7qx6Nf4wCA7Wlyoy14hlzdLcrUi/eldKYC728B5HxflhMd8zVA9G/RaffVjRcRF6ZCDIn4NhS1J1ZFddxXXF2rRXzc1Bu8Grmgqzd6cKc0p6/bINKuOW6jmZf3M9YHbNsnCe8PLBnDFojqIMAf4+qwfTm9ZnjMzHJIDkZrrwWhY/GT+Sh9yH/arLO8fjqKTHUJmxq+lAKMzeylb2BIzu1TX4n530nAZ9f8XL/LMSqaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NoNH0G2x0TQcZIveJiAwQleWY/xKkhg1iA5H5DJFHzs=;
 b=j8BdehgoZhG2OdXZ8GUP+FU4oZFPOVF0OcByCJRwbuBg9Lpe2INaB++h7UgGWzTyAx79mkicdWyStFct5LmGIYx4ToSRSoLRPYm81UDOgqVHjNZ/FR++pBeUU9e+hb8KVHALi8rNG6VVLPsMskyzVTuBx27ZKuy7Oj93Obv4rDZktfXGjwl9wEpq+BhErCo+KaGIuX/UTo+G7gddj9bC3Son3EDXZMxWB281DNMitzjj6z0iyK22En3AE6YuQo3xcLDrO6XUcDWfHdRUAxVQOYxNNm09k0xOiSEpRio9IjYdPOsETyHBwYrhQLSJGpK/UIxE97fmOdZVYCgyYvrwEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from DM3PR12CA0102.namprd12.prod.outlook.com (2603:10b6:0:55::22) by
 CY4PR1201MB2517.namprd12.prod.outlook.com (2603:10b6:903:da::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2387.24; Thu, 31 Oct
 2019 14:42:29 +0000
Received: from CO1NAM03FT044.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e48::203) by DM3PR12CA0102.outlook.office365.com
 (2603:10b6:0:55::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2408.19 via Frontend
 Transport; Thu, 31 Oct 2019 14:42:29 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM03FT044.mail.protection.outlook.com (10.152.81.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2387.20 via Frontend Transport; Thu, 31 Oct 2019 14:42:28 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 31 Oct
 2019 09:42:28 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 31 Oct
 2019 09:42:27 -0500
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 31 Oct 2019 09:42:27 -0500
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/20] drm/amd/display: 3.2.57
Date: Thu, 31 Oct 2019 10:41:51 -0400
Message-ID: <20191031144210.24011-2-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191031144210.24011-1-Bhawanpreet.Lakha@amd.com>
References: <20191031144210.24011-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(376002)(346002)(136003)(39860400002)(428003)(189003)(199004)(426003)(16586007)(186003)(316002)(2906002)(1076003)(48376002)(50466002)(26005)(50226002)(8936002)(86362001)(36756003)(2351001)(4744005)(14444005)(47776003)(336012)(6666004)(305945005)(356004)(76176011)(4326008)(7696005)(446003)(11346002)(53416004)(51416003)(8676002)(5660300002)(81166006)(81156014)(2616005)(476003)(126002)(486006)(70206006)(70586007)(478600001)(6916009);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR1201MB2517; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9f9b4e62-b9c3-46c2-a7c9-08d75e108e00
X-MS-TrafficTypeDiagnostic: CY4PR1201MB2517:
X-Microsoft-Antispam-PRVS: <CY4PR1201MB2517864EBF867A52CD68C9C1F9630@CY4PR1201MB2517.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-Forefront-PRVS: 02070414A1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4kZueV7H8JxHg6Nj5h3bsHTrs0HBFWsh0/81bknwbQ4Tht/It/Q0TptcSVDFkFE2Yh854l2DrnHJ2E1vP69B686AmyY4MUY3WHJkmjFqdZg8dOd41K87LJ4oW5xSmU6AfZbp1QkeEW+NtrQ1nT+szOoWb8oc+ay4RZjaO0N0dKEGkkJMAokuozqzhRdt9o4x7mbfSu/SGbl2G+T3DHG9KEdTZfzK/H235m0kv7/j7A0qHKOdFb2UvXMjOeGiDn+iR5IGqoxfVvHHJiKMz2rOWFWQRrDsQAr4JGovQyOulrZNEcHohwaXqREUqPLn+jz2Sf6Exv2rBTIamXBkG6Y3IypBfuY0ZnzNha1foXW6zepJYIQ+urdiYuwe4CWfpSwHghiQgicy+Yhxacm4BRhChTDu7mD7zOvew3bZxM6dNHcAS1M9ZdWNz4xh/V6SMzbz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2019 14:42:28.9438 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f9b4e62-b9c3-46c2-a7c9-08d75e108e00
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2517
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NoNH0G2x0TQcZIveJiAwQleWY/xKkhg1iA5H5DJFHzs=;
 b=RqBaAB12GLWqYgSuf8DYdRCZx6j45wQEv6RSrzzhSQ7ymqDxzTHabMT41OrZpN/ScGWKpCFTXxBUhRewy7vlJxltTht6dX7Saae6RU6EK6B1A44U/bLGAqX4+qOpLtii8LsZdMWIxC5lHfHgN8845On/OT1AjRoTJ9w//RMKBVk=
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
Message-ID: <20191031144151.BwNg4BC5bJshDtz_GgpWqMI8XzTCOJGzt_l2-YuLGCs@z>

RnJvbTogQXJpYyBDeXIgPGFyaWMuY3lyQGFtZC5jb20+CgpTaWduZWQtb2ZmLWJ5OiBBcmljIEN5
ciA8YXJpYy5jeXJAYW1kLmNvbT4KUmV2aWV3ZWQtYnk6IEJoYXdhbnByZWV0IExha2hhIDxCaGF3
YW5wcmVldC5MYWtoYUBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9k
Yy9kYy5oIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9u
KC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjLmggYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGMuaAppbmRleCAwNDE2YTE3YjA4OTcuLmQ5
MzFlNTg3OGI0YyAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2Rj
LmgKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjLmgKQEAgLTM5LDcgKzM5
LDcgQEAKICNpbmNsdWRlICJpbmMvaHcvZG1jdS5oIgogI2luY2x1ZGUgImRtbC9kaXNwbGF5X21v
ZGVfbGliLmgiCiAKLSNkZWZpbmUgRENfVkVSICIzLjIuNTYiCisjZGVmaW5lIERDX1ZFUiAiMy4y
LjU3IgogCiAjZGVmaW5lIE1BWF9TVVJGQUNFUyAzCiAjZGVmaW5lIE1BWF9QTEFORVMgNgotLSAK
Mi4xNy4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwph
bWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
