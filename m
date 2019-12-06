Return-Path: <SRS0=UM6f=Z4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC694C43603
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Dec 2019 09:45:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8848A2245C
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Dec 2019 09:45:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8848A2245C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2869F6F994;
	Fri,  6 Dec 2019 09:45:33 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21AC16F994
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Dec 2019 09:45:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L0Wma+42NflfIgiZSMSakLOsY/8dHEDAuZpNILUuFIITuXX9K6BxCBWBhis//Z6By5XzfiQsSrLP7HJFWxRJjyANxkq4QOII2/wugJDBaH5GzdCXMCep447Z0SgGffnxc94MJ5/iD0MhNxqeWO5CTj4UGeHHFJJf/yQPIh39T56yHyJ7utdZ/DKNN0Edj0G6QZwuBDfsp7JeXtXLCmvz23Xe2UBUJ0zNqZxaBcWfK9qpIzV05HxxeN1p/7Bx5DtpcEvUAFj1P0cWKOXePxNQcpSVKe7AGtKuwiSXxDoPR5OsjmB16nhEiDx7xhsK8Bjwa6EfD/2aXfdBDQz3gw3sjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KZnzNRzRJsKqrzgci192oAtXu5Z5eU+n4oflLyLNxnA=;
 b=XIpVdSzUaKrJjk1Y9BBy6HR86/MNLDyZtymagEILtOzy+Dju9fCtk/pp0c282KN42Pd7gX7Y1eIzs4YoqaqLW6MY7fLi5zYvtumxqjV8cJrCVqQLZkmpXgn6/EuDie9qwunSQwBSYQTXtN1mkDiHBp4wvw/pUFdpdn3gbadhxAcl8SkswwUpX7y79bWYiZyEdS6KB5EpuU4x2L9WZ7SmBsnVi8S9TJURW/+kPgFznh9NxvcVkdVxcX974svq5LPy5s1KiFJLC7L11kG1UUMUTZ/Zpm/XIoRg7HJ8WE/czeekToJnrFYAMU0V/rYPVxQDQI1ETLrZ29CsC81rOmw1ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from DM5PR12CA0009.namprd12.prod.outlook.com (2603:10b6:4:1::19) by
 BYAPR12MB2790.namprd12.prod.outlook.com (2603:10b6:a03:69::28) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.13; Fri, 6 Dec 2019 09:45:29 +0000
Received: from CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::205) by DM5PR12CA0009.outlook.office365.com
 (2603:10b6:4:1::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2516.13 via Frontend
 Transport; Fri, 6 Dec 2019 09:45:29 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT010.mail.protection.outlook.com (10.13.175.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2451.23 via Frontend Transport; Fri, 6 Dec 2019 09:45:28 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 6 Dec 2019
 03:45:28 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 6 Dec 2019
 03:45:27 -0600
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Fri, 6 Dec 2019 03:45:25 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Le Ma <Le.Ma@amd.com>, John Clements
 <John.clements@amd.com>, Alex Deucher <alexander.deucher@amd.com>, "Guchun
 Chen" <Guchun.Chen@amd.com>
Subject: [PATCH] drm/amdgpu: fix resume failures due to psp fw loading
 sequence change (v2)
Date: Fri, 6 Dec 2019 17:45:23 +0800
Message-ID: <20191206094523.5069-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(376002)(136003)(39860400002)(396003)(428003)(189003)(199004)(110136005)(1076003)(356004)(6636002)(305945005)(8676002)(48376002)(26005)(81166006)(8936002)(14444005)(2906002)(81156014)(16586007)(4326008)(70586007)(5660300002)(51416003)(426003)(50226002)(7696005)(2616005)(478600001)(86362001)(36756003)(316002)(53416004)(50466002)(336012)(186003)(70206006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB2790; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5e4bfd67-ccc0-4440-4130-08d77a31074d
X-MS-TrafficTypeDiagnostic: BYAPR12MB2790:
X-Microsoft-Antispam-PRVS: <BYAPR12MB2790A06532939F91B4BC4F91FC5F0@BYAPR12MB2790.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 0243E5FD68
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7m5Kk1exKGtqErDFLN11HjcTmKoWkLEGQKtG/BsTAoLvvXz3k6jaOw1ID1/9ODp1+r7oAjRRlnT7P+Ox7jWmsTVaJuTEnbTQ9eJMjgz1BrgZDcOsoCxABvKFQg6/F8NvTXXObSyXKDq1IXs4o0ln72fe2kL7YLFIdwkFhPHsDNKYElp2GGQ4Ux6YO8e08eEUqJWfMBlJvkDlZEL7NoCbu80qGfhpzZOY7jTDMPFz+8uPWuaqQKMz1F/DwDUs5npdR8umJuAfcQSjZ3XpFrMeytYhqmnH0csyvp1I90LqeN17S1mdO5W1142Re9L5ZTBm0tckmr0JATR7W7woTQYJq4fDzHaV9Hc38PGHEG6D3Z7m1p5S8F1CNCF3IsLKMJynf8WQMU2ZpOgCrB2eovkE8jJIrzrkskEvv0GusrHOsYaFvwqb1S4eIcURuNBLyeii
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2019 09:45:28.9113 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e4bfd67-ccc0-4440-4130-08d77a31074d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2790
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KZnzNRzRJsKqrzgci192oAtXu5Z5eU+n4oflLyLNxnA=;
 b=l5zlSCuJfZVoXo3n4YlkhtgD2WuqQkCI0zdaYlaIxcBITZvdJk2Oux9ub04QQjEcOewlEm2sjzaLQ/B+NaKaosqS4Wu3JVfRxwcnGawW3iG4059pitzFgAOvm+ApO8YM/ztBRVOkwwf/BwppmBA4hILaf4O8dXlfwuo3qdYyDb4=
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

dGhpcyBmaXggdGhlIHJlZ3Jlc3Npb24gY2F1c2VkIGJ5IGFzZC90YSBsb2FkaW5nIHNlcXVlbmNl
CmFkanVzdG1lbnQgcmVjZW50bHkuIGFzZC90YSBsb2FkaW5nIHdhcyBtb3ZlIG91dCBmcm9tIGh3
X3N0YXJ0CmFuZCBzaG91bGQgYWxzbyBiZSBhcHBsaWVkIHRvIHBzcF9yZXN1bWUuIG90aGVyd2lz
ZSB0aG9zZSBmdwpsb2FkaW5nIHdpbGwgYmUgaWdub3JlZCBpbiByZXN1bWUgcGhhc2UuCgpDaGFu
Z2UtSWQ6IEk2NzhmODJiNWRkNTUyZDcwNDM1YmZkYmQwMTBjNGVkODUzNjMxNGM5ClNpZ25lZC1v
ZmYtYnk6IEhhd2tpbmcgWmhhbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT4KLS0tCiBkcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMgfCAzNCArKysrKysrKysrKysrKysrKysr
KysrKysrCiAxIGZpbGUgY2hhbmdlZCwgMzQgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9wc3AuYwppbmRleCBjZWVhODMxNGQ4OGQuLjAzYzRhMjIzYzA1ZiAx
MDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5jCisrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYwpAQCAtMTcwMiw2ICsxNzAy
LDQwIEBAIHN0YXRpYyBpbnQgcHNwX3Jlc3VtZSh2b2lkICpoYW5kbGUpCiAJaWYgKHJldCkKIAkJ
Z290byBmYWlsZWQ7CiAKKwlyZXQgPSBwc3BfYXNkX2xvYWQocHNwKTsKKwlpZiAocmV0KSB7CisJ
CURSTV9FUlJPUigiUFNQIGxvYWQgYXNkIGZhaWxlZCFcbiIpOworCQltdXRleF91bmxvY2soJmFk
ZXYtPmZpcm13YXJlLm11dGV4KTsKKwkJcmV0dXJuIHJldDsKKwl9CisKKwlpZiAoYWRldi0+Z21j
LnhnbWkubnVtX3BoeXNpY2FsX25vZGVzID4gMSkgeworCQlyZXQgPSBwc3BfeGdtaV9pbml0aWFs
aXplKHBzcCk7CisJCS8qIFdhcm5pbmcgdGhlIFhHTUkgc2Vlc2lvbiBpbml0aWFsaXplIGZhaWx1
cmUKKwkJICogSW5zdGVhZCBvZiBzdG9wIGRyaXZlciBpbml0aWFsaXphdGlvbgorCQkgKi8KKwkJ
aWYgKHJldCkKKwkJCWRldl9lcnIocHNwLT5hZGV2LT5kZXYsCisJCQkJIlhHTUk6IEZhaWxlZCB0
byBpbml0aWFsaXplIFhHTUkgc2Vzc2lvblxuIik7CisJfQorCisJaWYgKHBzcC0+YWRldi0+cHNw
LnRhX2Z3KSB7CisJCXJldCA9IHBzcF9yYXNfaW5pdGlhbGl6ZShwc3ApOworCQlpZiAocmV0KQor
CQkJZGV2X2Vycihwc3AtPmFkZXYtPmRldiwKKwkJCQkJIlJBUzogRmFpbGVkIHRvIGluaXRpYWxp
emUgUkFTXG4iKTsKKworCQlyZXQgPSBwc3BfaGRjcF9pbml0aWFsaXplKHBzcCk7CisJCWlmIChy
ZXQpCisJCQlkZXZfZXJyKHBzcC0+YWRldi0+ZGV2LAorCQkJCSJIRENQOiBGYWlsZWQgdG8gaW5p
dGlhbGl6ZSBIRENQXG4iKTsKKworCQlyZXQgPSBwc3BfZHRtX2luaXRpYWxpemUocHNwKTsKKwkJ
aWYgKHJldCkKKwkJCWRldl9lcnIocHNwLT5hZGV2LT5kZXYsCisJCQkJIkRUTTogRmFpbGVkIHRv
IGluaXRpYWxpemUgRFRNXG4iKTsKKwl9CisKIAltdXRleF91bmxvY2soJmFkZXYtPmZpcm13YXJl
Lm11dGV4KTsKIAogCXJldHVybiAwOwotLSAKMi4xNy4xCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2FtZC1nZng=
