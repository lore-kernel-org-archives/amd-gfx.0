Return-Path: <SRS0=5Use=ZK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84BAAC432C0
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Nov 2019 10:20:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FE3520727
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Nov 2019 10:20:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FE3520727
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1823989700;
	Mon, 18 Nov 2019 10:20:19 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770071.outbound.protection.outlook.com [40.107.77.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 583A489700
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Nov 2019 10:20:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OMuObCkW9eUsYpPMKSOdjxqRKVZI5f+qKrsMYUzWrMVj50LmuSx4rYa+rRJ5Q7JKS6hdgiIehYEboP0/0EYlj9A+wGr3A5Yi24R1LlwXsGO3IWJTlSa04QbXyihVeVJ1Nq7KRApuVVtzb/eNpPdt9pG9ya1NGMugOlTlunfVFwkmh5guSw6gEcFZ66G3Ku9EyQY/PAxBxeNeAD5zYqTUnFkxefc+N1WxhKZWt11PQBtUFqXeC4QNZ2W7YIAoS91Qt8u3Gfn9bHsgEZoNMwmRgkv0rzHSYZ2Xxy9pGpjIyLY272QxAji/MPoM/x/JIzadOiOs6WP0CTvXGJBBZsR0Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Y8mAtzTIiQOfCk3b+iP2tAFXFVwsBqLXD0lNRMGB/4=;
 b=lEVQDo8P6DaU1boBSIViUCsFkUj+9WujDmYNgtKSXvWdV+Mt28wJmU3RKowqOzVtOAqDYLh3KOylOjpCOUoXKEA3X4Uqi3SC8LY2UmnRdop6Ohr1LTbfIXrlM5GTKUOgAN1hYHc+puBt90zKjVLYAhmGSjgsSR3y0jgooCrzdPdaT5Zl83vPpDArvugYeJ4MTJ9335FPAbNCOFEG78cUdhqXM/fYsnlFpF8iStOImf7gfgAoszWyI/gB2CLZhtCcNSOLYr/Kats8huP1sNq/MhbGjsMZ1WFgeDiHdQGqIJmj0QYA1zlp66wmGlbE8JVGA4LPt9MS2Hk6IfgsoI/N3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from DM3PR12CA0109.namprd12.prod.outlook.com (2603:10b6:0:55::29) by
 CH2PR12MB4022.namprd12.prod.outlook.com (2603:10b6:610:22::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.29; Mon, 18 Nov 2019 10:20:15 +0000
Received: from BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eae::200) by DM3PR12CA0109.outlook.office365.com
 (2603:10b6:0:55::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2451.29 via Frontend
 Transport; Mon, 18 Nov 2019 10:20:15 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT017.mail.protection.outlook.com (10.13.177.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2451.23 via Frontend Transport; Mon, 18 Nov 2019 10:20:15 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 18 Nov
 2019 04:20:14 -0600
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Mon, 18 Nov 2019 04:20:12 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, John Clements <John.Clements@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: pull ras controller int status only when ras
 enabled
Date: Mon, 18 Nov 2019 18:20:10 +0800
Message-ID: <20191118102010.21727-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(136003)(39860400002)(396003)(346002)(428003)(199004)(189003)(186003)(6636002)(26005)(1076003)(51416003)(7696005)(8936002)(81166006)(81156014)(8676002)(47776003)(50226002)(5660300002)(70206006)(70586007)(86362001)(426003)(478600001)(2616005)(36756003)(316002)(336012)(16586007)(48376002)(2906002)(476003)(50466002)(126002)(4326008)(53416004)(486006)(356004)(110136005)(305945005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB4022; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7cefc28d-0fbe-43c6-b21a-08d76c10e758
X-MS-TrafficTypeDiagnostic: CH2PR12MB4022:
X-Microsoft-Antispam-PRVS: <CH2PR12MB4022029826082D42F0CCC4FDFC4D0@CH2PR12MB4022.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 0225B0D5BC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H11sg33179DYVI3KAwh5ZwjICUn/Xq9ZD7vgch90vK+4f9MoYRiqN54UK+6Yq8qvyoD7jO1FkndnQXVIBd57EJrSdvH0cyZDK/w+4MZciXxubUOo3traw0SQmwrGA9iIMKn2vDJj6dMykalFcjvtGV9rtRGUJr2yvjb12TcCyybhsdtAFwHhoEA9nIJXWVbcPQ4aQOBUbI/Op3moOPo0mbaaqhbN9OL7jwtV2SgMvTxmoirPLA1aRCCKNyMk+WzC3X90X6k74+CC8Q2cf61nejoZUrvUfSC279yzTJ1F2hF7E+8/38Fh1bc7MM2kIh8FfKvjxjYkjHcUv4Uo1G96pcWj9KbKeRQ6PHupDiw6Jim0uOLIhJN8LS4VlXMHtlxzsyIrTdxeHc21DLC7hVaa21Kc+G7qfkWfMTqXebeuydlvBHnoWdh7atcn5zNA1S9U
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2019 10:20:15.2380 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cefc28d-0fbe-43c6-b21a-08d76c10e758
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4022
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Y8mAtzTIiQOfCk3b+iP2tAFXFVwsBqLXD0lNRMGB/4=;
 b=wPpGmy5GaGwG8a6OirE2+Kp971Sedbt7dptfcrR+VtUd6hBDq8ZB06R5w5bZLATnzBD8e1fW83+5vmADPTWJ753dF2D4JV37xYwgJ+mSlHCIqgcwfsWvD4SxC0pw5l5LmVFSdASFpQdgXCgUUGVoAbyt2MfkST8gpwMMMro1TR4=
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
Message-ID: <20191118102010.1WIxgATjyhFxmqYemmwFcycasEG7zQuKFinDB3OhopY@z>

cmFzX2NvbnRyb2xsZXJfaXJxIGFuZCBhdGh1Yl9lcnJfZXZlbnRfaXJxIGFyZSBvbmx5IHJlZ2lz
dGVyZWQKd2hlbiBQQ0lFX0JJRiByYXMgaXMgbWFya2VkIGFzIHN1cHBvcnRlZC4gYXMgdGhlIHJl
c3VsdCwgdGhlIGRyaXZlcgphbHNvIGp1c3QgbmVlZCBwdWxsIHRoZSBpbnQgc3RhdHVzIGluIHN1
Y2ggY2FzZS4KCkNoYW5nZS1JZDogSWJkMWYyOWJlMjUzZTBlNjBmOWJlN2ZmMjIwOGY1Y2YyYjc4
YTU2YTQKU2lnbmVkLW9mZi1ieTogSGF3a2luZyBaaGFuZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29t
PgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9pcnEuYyB8IDE3ICsrKysr
KysrKystLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlv
bnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaXJx
LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaXJxLmMKaW5kZXggMGRmYTcz
OTM2YTc2Li42NjIzZmU0MmNlNGUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9pcnEuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
aXJxLmMKQEAgLTUyLDYgKzUyLDcgQEAKICNpbmNsdWRlICJhbWRncHVfY29ubmVjdG9ycy5oIgog
I2luY2x1ZGUgImFtZGdwdV90cmFjZS5oIgogI2luY2x1ZGUgImFtZGdwdV9hbWRrZmQuaCIKKyNp
bmNsdWRlICJhbWRncHVfcmFzLmgiCiAKICNpbmNsdWRlIDxsaW51eC9wbV9ydW50aW1lLmg+CiAK
QEAgLTE1OSwxMyArMTYwLDE1IEBAIGlycXJldHVybl90IGFtZGdwdV9pcnFfaGFuZGxlcihpbnQg
aXJxLCB2b2lkICphcmcpCiAJICogcmVnaXN0ZXIgdG8gY2hlY2sgd2hldGhlciB0aGUgaW50ZXJy
dXB0IGlzIHRyaWdnZXJlZCBvciBub3QsIGFuZCBwcm9wZXJseQogCSAqIGFjayB0aGUgaW50ZXJy
dXB0IGlmIGl0IGlzIHRoZXJlCiAJICovCi0JaWYgKGFkZXYtPm5iaW8uZnVuY3MgJiYKLQkgICAg
YWRldi0+bmJpby5mdW5jcy0+aGFuZGxlX3Jhc19jb250cm9sbGVyX2ludHJfbm9fYmlmcmluZykK
LQkJYWRldi0+bmJpby5mdW5jcy0+aGFuZGxlX3Jhc19jb250cm9sbGVyX2ludHJfbm9fYmlmcmlu
ZyhhZGV2KTsKLQotCWlmIChhZGV2LT5uYmlvLmZ1bmNzICYmCi0JICAgIGFkZXYtPm5iaW8uZnVu
Y3MtPmhhbmRsZV9yYXNfZXJyX2V2ZW50X2F0aHViX2ludHJfbm9fYmlmcmluZykKLQkJYWRldi0+
bmJpby5mdW5jcy0+aGFuZGxlX3Jhc19lcnJfZXZlbnRfYXRodWJfaW50cl9ub19iaWZyaW5nKGFk
ZXYpOworCWlmIChhbWRncHVfcmFzX2lzX3N1cHBvcnRlZChhZGV2LCBBTURHUFVfUkFTX0JMT0NL
X19QQ0lFX0JJRikpIHsKKwkJaWYgKGFkZXYtPm5iaW8uZnVuY3MgJiYKKwkJICAgIGFkZXYtPm5i
aW8uZnVuY3MtPmhhbmRsZV9yYXNfY29udHJvbGxlcl9pbnRyX25vX2JpZnJpbmcpCisJCQlhZGV2
LT5uYmlvLmZ1bmNzLT5oYW5kbGVfcmFzX2NvbnRyb2xsZXJfaW50cl9ub19iaWZyaW5nKGFkZXYp
OworCisJCWlmIChhZGV2LT5uYmlvLmZ1bmNzICYmCisJCSAgICBhZGV2LT5uYmlvLmZ1bmNzLT5o
YW5kbGVfcmFzX2Vycl9ldmVudF9hdGh1Yl9pbnRyX25vX2JpZnJpbmcpCisJCQlhZGV2LT5uYmlv
LmZ1bmNzLT5oYW5kbGVfcmFzX2Vycl9ldmVudF9hdGh1Yl9pbnRyX25vX2JpZnJpbmcoYWRldik7
CisJfQogCiAJcmV0dXJuIHJldDsKIH0KLS0gCjIuMTcuMQoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbWQtZ2Z4
