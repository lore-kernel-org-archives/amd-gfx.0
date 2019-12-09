Return-Path: <SRS0=Fyns=Z7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB176C43603
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Dec 2019 17:26:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA1302073D
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Dec 2019 17:26:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA1302073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73CA16E4FF;
	Mon,  9 Dec 2019 17:26:39 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2079.outbound.protection.outlook.com [40.107.236.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 994A56E4FF
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Dec 2019 17:26:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OTb8B5gSFit7SDzT7e+OMCnZk4Hynz9bdu8R63Y1WjUNmL6cKk8mSldFzPmNhlrrKBNe3UIA0Mjps4JbS5NyP5XD/r9706Wp0dfYDdZRUtVSgYnPafPzkF0u6+JNjtGIksZ0IwQEQRgO8LCG03OOqMb8NU+qPNeOqFLoeUFwKF45wWHyPxRbhanyDmqLSawDpkdt4FYGhJl39ag9BRFa0547bdXyhoraM8b3798Hqp/i6AYrVBXvuFqFJAdxSXU+RWV72iPYPwGmtBFh5+6dWnOwI/tHUyJjwzdGgvNtnsfYu8BBqJUFrcAwe/BeCIoOcbE5ZtgbSbaRGbfMDVsbKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HFbT/j3PqcJ+LLuL9nsqZ1Rue6+D3P4Ixsl/9tAxpQw=;
 b=Tj0LiFkt55hA2Amt42J7ALFBZTexo6VRDoVqkttau6C7lue3LXHQIvWCIfEjXsrrL5kfuaAtlAnzB2wa6J2euf4atHg6+ME3DT3965wktO3C/dVPLg76IyXWqWzStnCpDNs1rLZ+VY5+J/UFQBtyQ6KtTUxu0H8T1NWSyTJLKJ62gbFexvaW/nZKRouG991HWpblKTnD3M8UB8sfSW8UHwg12UbwS7wYPyFJLiyHADPKRQ8ay3uR2+bnVSa8bIkd9VnuYz57FajmJLtiHdeDax6O72DeOocw+h5ZGLkA7TpXhvMT2p7ObH4RiBLpSzKIE4sdJ8DRHH45Y5M5SQpvVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from DM5PR12CA0010.namprd12.prod.outlook.com (2603:10b6:4:1::20) by
 BN8PR12MB2899.namprd12.prod.outlook.com (2603:10b6:408:6b::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.16; Mon, 9 Dec 2019 17:26:35 +0000
Received: from BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eae::209) by DM5PR12CA0010.outlook.office365.com
 (2603:10b6:4:1::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2516.13 via Frontend
 Transport; Mon, 9 Dec 2019 17:26:35 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT041.mail.protection.outlook.com (10.13.177.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2451.23 via Frontend Transport; Mon, 9 Dec 2019 17:26:35 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 9 Dec 2019
 11:26:34 -0600
Received: from yttao-code-machine.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Mon, 9 Dec 2019 11:26:33 -0600
From: Yintian Tao <yttao@amd.com>
To: <Alexander.Deucher@amd.com>, <kenneth.feng@amd.com>
Subject: [PATCH] drm/amd/powerplay: avoid null pointer
Date: Tue, 10 Dec 2019 01:26:31 +0800
Message-ID: <20191209172631.17618-1-yttao@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(376002)(39860400002)(136003)(346002)(428003)(189003)(199004)(4744005)(5660300002)(186003)(356004)(26005)(316002)(305945005)(6636002)(54906003)(1076003)(2616005)(70586007)(70206006)(7696005)(336012)(426003)(110136005)(2906002)(478600001)(8936002)(8676002)(81166006)(81156014)(4326008)(36756003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN8PR12MB2899; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a6f7c312-24ab-44d9-e6f6-08d77cccf0ea
X-MS-TrafficTypeDiagnostic: BN8PR12MB2899:
X-Microsoft-Antispam-PRVS: <BN8PR12MB2899F45DE6DB157EE1738D2AE5580@BN8PR12MB2899.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-Forefront-PRVS: 02462830BE
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cqbuJyMXRNdPx7h491c56LMYfOaWbN7PMYWQL7zkdjbfQxfAm2PjPvYuHL2Wnm3BAfW7XSaFI0ens2wjqr1rOT9OvfMYdppEEQAdd4ByVsC0mLKArR1LmmKX0MaJzZVBimsoPPT2xTk7SkOHnHpqB6r3i+1qW56+z3iwPdwQERXrc/wBeGE9fJIxbVL+6cr3UaoiMNYGtnxPPXirDmW87lg2pWUrNaUtKniqlndQLUKfA00K1Lz4aM5JoWJG2Cb2gphFMNazC0C4Ug+wJ7a+dEkNd/nt+t4H3mAt/mMewNZgfmyPoBUH3UtD1jymPnTfPydpXf3p2H/F4D9eYOpHounsuAwZMZn71EwNLd1N4mbWlGohdovKZ6SJqbndBOHlmoNFD2S5bQTzC8ZtoE5X7oiqQE8huPfzxDsXvyqVFFyEuzrvblvHylZEeLVm4I41
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2019 17:26:35.2883 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6f7c312-24ab-44d9-e6f6-08d77cccf0ea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2899
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HFbT/j3PqcJ+LLuL9nsqZ1Rue6+D3P4Ixsl/9tAxpQw=;
 b=SZmRKVAwW09kUPX1Hc0wGjRiCaw7dw96xYK/sLQlLNR6fFZlIPaaPKai2PKbXN7hZljCUC9K/L24VRZCsfFKw2B2rQ+o5vMjeDKJEe1QgzabrYMZ+8P7+rzGzoJu/P21Xh016yWHThOfZvErn5Y+RryiW+IEkRMBtT4Uhqlf+io=
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
Cc: amd-gfx@lists.freedesktop.org, Yintian Tao <yttao@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

YmVjYXVzZSBzb21lIGFzaWNzIGhhdmUgbm8gc211LnBwdF9mdW5jcwp3ZSBuZWVkIGFkZCBvbmUg
Y2hlY2sgZm9yIGl0IG90aGVyd2lzZQppdCB3aWxsIHJhaXNlIG51bGwgcG9pbnRlciBwcm9ibGVt
LgoKU2lnbmVkLW9mZi1ieTogWWludGlhbiBUYW8gPHl0dGFvQGFtZC5jb20+Ci0tLQogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BtLmMgfCAzICsrLQogMSBmaWxlIGNoYW5nZWQs
IDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wbS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3BtLmMKaW5kZXggYTIxZWUwMzVjYTU3Li5iOGE0MmViYjJmNWEgMTAwNjQ0Ci0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wbS5jCisrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wbS5jCkBAIC0xNjAsNyArMTYwLDggQEAgc3RhdGljIHNz
aXplX3QgYW1kZ3B1X2dldF9kcG1fc3RhdGUoc3RydWN0IGRldmljZSAqZGV2LAogCWVudW0gYW1k
X3BtX3N0YXRlX3R5cGUgcG07CiAKIAlpZiAoaXNfc3VwcG9ydF9zd19zbXUoYWRldikpIHsKLQkJ
aWYgKGFkZXYtPnNtdS5wcHRfZnVuY3MtPmdldF9jdXJyZW50X3Bvd2VyX3N0YXRlKQorCQlpZiAo
YWRldi0+c211LnBwdF9mdW5jcyAmJgorCQkgICAgYWRldi0+c211LnBwdF9mdW5jcy0+Z2V0X2N1
cnJlbnRfcG93ZXJfc3RhdGUpCiAJCQlwbSA9IHNtdV9nZXRfY3VycmVudF9wb3dlcl9zdGF0ZSgm
YWRldi0+c211KTsKIAkJZWxzZQogCQkJcG0gPSBhZGV2LT5wbS5kcG0udXNlcl9zdGF0ZTsKLS0g
CjIuMTcuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
YW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6
Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
