Return-Path: <SRS0=0KW4=ZY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC4C1C432C3
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 06:03:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DE2B20715
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 06:03:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DE2B20715
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5839889F4A;
	Mon,  2 Dec 2019 06:03:59 +0000 (UTC)
Received: from NAM05-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr720084.outbound.protection.outlook.com [40.107.72.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80C7A89F4A
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Dec 2019 06:03:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=APUoTvUVoUf+ySjxfbNSc4Rs7F5MEtO4V7AQk7izr5KfjQQAEtHBonp9IyhgwkRjo7g70cPxL+UuX2up5q8y0YaI14N5XGEgQ/RhXuPnteAYrtb9QQuIvrMa7FvS3+p7VKrlj6iLjKUrUMucU8LJKq0iOHBZJEREgfiscvYfbd4koEgDkwW+6yUItq36fYq/h/opBE30Qroh+7Q06wOEcHRiyLjt5NpyC9YtALvh83pljt+LtOjvDpN1x5pFEhByY7v/WHbvdBx2rxlycisKQTUX9ZBSA5wM6SKwMh+71EBO2tw8XGaMjCSdkk+yXzXA/GZMEfqRnzZ8LF2K+t31jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7mpA7Zi+kFF/5PZQHVehu2+KQZmufPqVsOb3XY8Sk44=;
 b=KbxJFKkFMdN95Bnmu4+IPONwD7hpyGZn3JMhubckNUrP6GqDVH8xES8b9qh1qnDhe6ArlWh1eRKn/1j2ySCk7kh0SkW5QfY2TOIWTq1SeowBypd5bS63rHrrxEpcG9sUCN3GQ503N/m88izEW8x+RItL3E8od4yQg1ia8q3lDF0W46+t+EOYxVoNllFukfA03DGg2Cl5lMvkeCw5SKSoQJmiEbTr3U7u9/+pRLNntdPMWvaiVL5F2T5xkZ2cfWw78wNvTXhtppemtHcAvl8EKYKe2Y5TV0MH2Lvv223PpVyRfgsHh3OOVgP935L/8OMcI9l5DEXLrWnjVYJ3Ub2frA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from BN6PR1201CA0010.namprd12.prod.outlook.com
 (2603:10b6:405:4c::20) by BYAPR12MB2982.namprd12.prod.outlook.com
 (2603:10b6:a03:a8::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.18; Mon, 2 Dec
 2019 06:03:53 +0000
Received: from BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eae::200) by BN6PR1201CA0010.outlook.office365.com
 (2603:10b6:405:4c::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.18 via Frontend
 Transport; Mon, 2 Dec 2019 06:03:53 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT048.mail.protection.outlook.com (10.13.177.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2451.23 via Frontend Transport; Mon, 2 Dec 2019 06:03:53 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 2 Dec 2019
 00:03:52 -0600
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Mon, 2 Dec 2019 00:03:50 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Min Frank <Frank.Min@amd.com>, "John
 Clements" <John.Clements@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: unload asd in psp hw de-init phase
Date: Mon, 2 Dec 2019 14:03:36 +0800
Message-ID: <20191202060337.22435-2-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191202060337.22435-1-Hawking.Zhang@amd.com>
References: <20191202060337.22435-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(39860400002)(396003)(136003)(376002)(428003)(189003)(199004)(26005)(8936002)(1076003)(2906002)(446003)(478600001)(2616005)(5660300002)(36756003)(48376002)(7696005)(305945005)(51416003)(76176011)(11346002)(47776003)(81156014)(356004)(6666004)(81166006)(14444005)(70586007)(6636002)(50226002)(86362001)(8676002)(70206006)(50466002)(186003)(336012)(426003)(4326008)(316002)(16586007)(110136005)(53416004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB2982; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3d6b6624-0acf-4e0d-e933-08d776ed6899
X-MS-TrafficTypeDiagnostic: BYAPR12MB2982:
X-Microsoft-Antispam-PRVS: <BYAPR12MB298263013E1AA439A09D6A65FC430@BYAPR12MB2982.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:213;
X-Forefront-PRVS: 0239D46DB6
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EZnw6GpmoAqMuOIpU1tNqMvBaDfq8o9eOTTKMRbVWafzoIMMqygV42Es8eAs8my3CSx/X+mcmn7zUGB+HkDJsu5yikCAVM6Z1jsxHL1oycYqjZwcRpu/sfesM9O9AnmAfgVTV6L/jIYLu5YNEqrezuHgycrKHyKc9E8jia2fl11gc+LK3Vho/FeWLRMN0scVZeBP5EvLS4glUcrJdIoVNJPR7Ls32XT6rgL0xcloQP+AYwBSF1IALynAGmfD8Fd3nWDJi4V4iT8uwKLnnBwGuApG2lEPRpLX7thwRvECboF9WGIzc9p+EK9Gz0hkILxJHDnBEjAIKyJmXWcAloLuVAfHKt6I98enDtP2JL8gPnJe0xF6ABwTWF/AnJHlOw7WGfcs8oUOqgh6KK8vCnWaKAY9v5v8Hi0RHvUVAztZzPF9PX+iXmfUtyKiDbtyRz+s
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2019 06:03:53.0038 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d6b6624-0acf-4e0d-e933-08d776ed6899
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2982
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7mpA7Zi+kFF/5PZQHVehu2+KQZmufPqVsOb3XY8Sk44=;
 b=mtLnMZNNhIOhH6SbQy7thyxKl7AikH2DnjtLshicbKs3k/pQW7MOkMWG49QHzl3kqD8mkRc+CEmwxfCWwiJKvbACwKQt3/tW4lNdBMiMvLOaAQypesr6QyNZaBbxexBCAIh6M0iPuEQr+qrpY7k4mM70+ApuCwNRWxamuVTWgpM=
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

aXNzdWUgdW5sb2FkX3RhX2NtZCB0byB0T1MgdG8gdW5sb2FkIGFzZCBkcml2ZXIKCkNoYW5nZS1J
ZDogSTY5N2NmYzE3NzQyMDVlZDZjYmUyMmViM2MxNjE0M2I2MDM1NDM1NjQKU2lnbmVkLW9mZi1i
eTogSGF3a2luZyBaaGFuZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYyB8IDM2ICsrKysrKysrKysrKysrKysrKysrKysr
KysKIDEgZmlsZSBjaGFuZ2VkLCAzNiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3BzcC5jCmluZGV4IGJkYzllN2FlNDg5Mi4uMGU4OTA3MTc5ZTA3IDEwMDY0
NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMKKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5jCkBAIC0zNTYsNiArMzU2LDQwIEBA
IHN0YXRpYyBpbnQgcHNwX2FzZF9sb2FkKHN0cnVjdCBwc3BfY29udGV4dCAqcHNwKQogCXJldHVy
biByZXQ7CiB9CiAKK3N0YXRpYyB2b2lkIHBzcF9wcmVwX2FzZF91bmxvYWRfY21kX2J1ZihzdHJ1
Y3QgcHNwX2dmeF9jbWRfcmVzcCAqY21kLAorCQkJCQl1aW50MzJfdCBhc2Rfc2Vzc2lvbl9pZCkK
K3sKKwljbWQtPmNtZF9pZCA9IEdGWF9DTURfSURfVU5MT0FEX1RBOworCWNtZC0+Y21kLmNtZF91
bmxvYWRfdGEuc2Vzc2lvbl9pZCA9IGFzZF9zZXNzaW9uX2lkOworfQorCitzdGF0aWMgaW50IHBz
cF9hc2RfdW5sb2FkKHN0cnVjdCBwc3BfY29udGV4dCAqcHNwKQoreworCWludCByZXQ7CisJc3Ry
dWN0IHBzcF9nZnhfY21kX3Jlc3AgKmNtZDsKKworCWlmIChhbWRncHVfc3Jpb3ZfdmYocHNwLT5h
ZGV2KSkKKwkJcmV0dXJuIDA7CisKKwlpZiAoIXBzcC0+YXNkX2NvbnRleHQuYXNkX2luaXRpYWxp
emVkKQorCQlyZXR1cm4gMDsKKworCWNtZCA9IGt6YWxsb2Moc2l6ZW9mKHN0cnVjdCBwc3BfZ2Z4
X2NtZF9yZXNwKSwgR0ZQX0tFUk5FTCk7CisJaWYgKCFjbWQpCisJCXJldHVybiAtRU5PTUVNOwor
CisJcHNwX3ByZXBfYXNkX3VubG9hZF9jbWRfYnVmKGNtZCwgcHNwLT5hc2RfY29udGV4dC5zZXNz
aW9uX2lkKTsKKworCXJldCA9IHBzcF9jbWRfc3VibWl0X2J1Zihwc3AsIE5VTEwsIGNtZCwKKwkJ
CQkgcHNwLT5mZW5jZV9idWZfbWNfYWRkcik7CisJaWYgKCFyZXQpCisJCXBzcC0+YXNkX2NvbnRl
eHQuYXNkX2luaXRpYWxpemVkID0gZmFsc2U7CisKKwlrZnJlZShjbWQpOworCisJcmV0dXJuIHJl
dDsKK30KKwogc3RhdGljIHZvaWQgcHNwX3ByZXBfcmVnX3Byb2dfY21kX2J1ZihzdHJ1Y3QgcHNw
X2dmeF9jbWRfcmVzcCAqY21kLAogCQl1aW50MzJfdCBpZCwgdWludDMyX3QgdmFsdWUpCiB7CkBA
IC0xNTgzLDYgKzE2MTcsOCBAQCBzdGF0aWMgaW50IHBzcF9od19maW5pKHZvaWQgKmhhbmRsZSkK
IAkJcHNwX2hkY3BfdGVybWluYXRlKHBzcCk7CiAJfQogCisJcHNwX2FzZF91bmxvYWQocHNwKTsK
KwogCXBzcF9yaW5nX2Rlc3Ryb3kocHNwLCBQU1BfUklOR19UWVBFX19LTSk7CiAKIAlwcHRyID0g
YW1kZ3B1X3NyaW92X3ZmKHBzcC0+YWRldikgPyAmdG1yX2J1ZiA6IE5VTEw7Ci0tIAoyLjE3LjEK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZngg
bWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
