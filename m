Return-Path: <SRS0=VQNv=YW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A01D9CA9EAE
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Oct 2019 09:18:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7250820830
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Oct 2019 09:18:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7250820830
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 139F76E161;
	Tue, 29 Oct 2019 09:18:43 +0000 (UTC)
Received: from NAM05-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr730085.outbound.protection.outlook.com [40.107.73.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 532826E161
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Oct 2019 09:18:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gW6HelzTHI9rvqXzlD/qkqAybgt+cx5mH6x8/pbRkNyyaewqVfSiSz+eSjhZX7dk1VQHnUwnddl1Iplj/M2LSiu1shXDC7nazcO1bev4oibPKJJuCJSGtLFOu2o23v24V0yZildWAbx2CIUl3mS843nYybYXwjN2sRI9MBTCdOFFOPQXtUk/7AJtwvcKycnhe3cmqnYvNbsPQraNb/khVyvxRaskQfQbNKjztk2Mc3he02C3mJ1mj4Hpfjzeylt6yz/nSafGlB2FJmzS404QHJlhnfwK18Yh3a7F/A5SURyHMQWSc8xdH2Sd+qqQnA2aYjRY5TCfpYRikNT5U4R/AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aauHL9N4BOuT67Ar/qgmvPRZfjdMAZ6eVIEiDYfKH/A=;
 b=PWcOLmoDnop2A7R+/b0mj+sKAeuFxGSMPUph1w64kzCoJ9ZI4zOiU9EoxJlX+/zK8w/aIowCZcnceZX/16lp/PE8IPqFE780Y791E0bExPfkprolyGxqHesxJCRR4s5o2w3PO9UAF+NnREA6OAY7BspHTavg+M7B0PVAryiXXAEG77kMHRdLsMqv5PiF514Djbto2XanWbawpOt3Td1cIgWsg7d+zhheZrS6QwGC5rktByJd42z3KSjP7TyO2FmQlb2yDM4q61SpKY4tdKqs+73WMx0Zq3a2deKM1Udk1zA4fFL2cIN/EQwKFFPJabusg1ulZ5r+onB/jV4FV6Ryew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from BN6PR12CA0043.namprd12.prod.outlook.com (2603:10b6:405:70::29)
 by CY4PR12MB1398.namprd12.prod.outlook.com (2603:10b6:903:40::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2387.22; Tue, 29 Oct
 2019 09:18:39 +0000
Received: from DM3NAM03FT005.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e49::204) by BN6PR12CA0043.outlook.office365.com
 (2603:10b6:405:70::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2387.22 via Frontend
 Transport; Tue, 29 Oct 2019 09:18:39 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM3NAM03FT005.mail.protection.outlook.com (10.152.82.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2387.20 via Frontend Transport; Tue, 29 Oct 2019 09:18:38 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 29 Oct
 2019 04:18:38 -0500
Received: from ubuntu.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Tue, 29 Oct 2019 04:18:37 -0500
From: HaiJun Chang <HaiJun.Chang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: fix gfx VF FLR test fail on navi
Date: Tue, 29 Oct 2019 17:18:13 +0800
Message-ID: <1572340693-122958-1-git-send-email-HaiJun.Chang@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(376002)(39860400002)(396003)(136003)(428003)(189003)(199004)(336012)(305945005)(6666004)(356004)(6916009)(478600001)(2906002)(48376002)(50466002)(126002)(476003)(2616005)(81156014)(316002)(81166006)(186003)(16586007)(486006)(5660300002)(26005)(426003)(36756003)(8936002)(47776003)(70586007)(50226002)(70206006)(53416004)(8676002)(4744005)(14444005)(4326008)(2351001)(7696005)(51416003)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR12MB1398; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 398c982d-57e5-418e-2e14-08d75c50fbf9
X-MS-TrafficTypeDiagnostic: CY4PR12MB1398:
X-Microsoft-Antispam-PRVS: <CY4PR12MB1398B43A6B80C2E122E448EE81610@CY4PR12MB1398.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1360;
X-Forefront-PRVS: 0205EDCD76
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IhdJffAj/+nijDP/5CgN+jXGAdd2aU85hd6sVccwbS6NW1R8RMsiaP7BhWK3o69LHExcwPSZiIunGTZUwKsUXY3PdVVorzmYd0oSOjGhgnffStjfkWrDHBWxgdexUFcrpRhfk4GzvajOqBdw9BeyrpdAyYj9Ve1sTEUVSjvotGMgP2dcZIXIzNRgMax2FEVvgsA1m56OpwxnIN98KVReQuRE8AoWNVoIzAh9QmPS3sL6mmeK4h21+3I0nqww1ECGivvh9NyYBiKtYqjF0XQNRVHrNP6Dtgk2FB2FMibXUXqzrz6jr/BL3JMScI9yxysTdNdnqambvsLoJBoibm3TaO5o1MIi3Y2qSKcjZ6bAluK6MAL3ueX74xNIehCbIQ4DlICiInKAY/eR8D+EGIfY1oej/1OWpENBccRp0tmLQH+SsRSesOBi26gcTlbCUzFP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2019 09:18:38.9934 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 398c982d-57e5-418e-2e14-08d75c50fbf9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1398
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aauHL9N4BOuT67Ar/qgmvPRZfjdMAZ6eVIEiDYfKH/A=;
 b=2b0DWC7kC8ywnLXhreGyfzV4Y4nprrnFTx/U+2wQxQHodqYJ9wiAOlbv0oF+YjRNO8SBKaTs4m+uCmfJL1/EZyhKIIUCGt/d2raIjkp871B6la62g9nHaw6UkWYzF2zRS4rjtosShhCEcgTcvQYkDhThCw18Mr1/JshGLmUN72w=
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
Cc: HaiJun Chang <HaiJun.Chang@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191029091813.lNo__fySFMBsjAbpRmup79xpu5abiScbbKUiTsuxFyA@z>

Q3Agd3B0ciBpbiB3YiBidWZmZXIgaXMgb3V0ZGF0ZWQgYWZ0ZXIgVkYgRkxSLgpUaGUgb3V0ZGF0
ZWQgd3B0ciBtYXkgY2F1c2UgY3AgdG8gZXhlY3V0ZSB1bmV4cGVjdGVkIHBhY2tldHMuClJlc2V0
IGNwIHdwdHIgaW4gd2IgYnVmZmVyLgoKU2lnbmVkLW9mZi1ieTogSGFpSnVuIENoYW5nIDxIYWlK
dW4uQ2hhbmdAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEw
XzAuYyB8IDEgKwogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCgpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9nZnhfdjEwXzAuYwppbmRleCBkMTI2ZDY2Li4xMzM2M2YyIDEwMDY0NAotLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYworKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYwpAQCAtMzEwNyw2ICszMTA3LDcgQEAgc3RhdGlj
IGludCBnZnhfdjEwXzBfZ2Z4X2luaXRfcXVldWUoc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nKQog
CQkJbWVtY3B5KG1xZCwgYWRldi0+Z2Z4Lm1lLm1xZF9iYWNrdXBbQU1ER1BVX01BWF9HRlhfUklO
R1NdLCBzaXplb2YoKm1xZCkpOwogCQkvKiByZXNldCB0aGUgcmluZyAqLwogCQlyaW5nLT53cHRy
ID0gMDsKKwkJYWRldi0+d2Iud2JbcmluZy0+d3B0cl9vZmZzXSA9IDA7CiAJCWFtZGdwdV9yaW5n
X2NsZWFyX3JpbmcocmluZyk7CiAjaWZkZWYgQlJJTkdfVVBfREVCVUcKIAkJbXV0ZXhfbG9jaygm
YWRldi0+c3JibV9tdXRleCk7Ci0tIAoyLjcuNAoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4
