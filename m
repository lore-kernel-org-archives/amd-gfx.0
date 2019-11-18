Return-Path: <SRS0=5Use=ZK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6346C432C3
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Nov 2019 08:21:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B17F0206F4
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Nov 2019 08:21:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B17F0206F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6337D89EAE;
	Mon, 18 Nov 2019 08:21:58 +0000 (UTC)
Received: from NAM03-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr790052.outbound.protection.outlook.com [40.107.79.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FA1E89EAE
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Nov 2019 08:21:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=boIoamAzTTkKBnuXsjrvQASyVp6I3EsM89UEt+FILSPgo7iQGDzP7g/EO/wTK3wQSUMISP8E6RE9J+u0t3m3VY2Yd9lH/0U8cRTh7Dry8FwuDGBrFYIldKwnpVZGT0RW0akUdHHTB1wL5kQlY0B7YLCketsGsHUPI8mrvejZdCGKh0UDTuomVnYtM2uqny4XIPYyTtOnseqtxno7K9g1+at+6S+LaKenoWcokQroXLH54V1WjDyF6pCoIgpvujlCEZTrNTwt3fExIFZdw35OxdgRBO/ton/ZR14ySWBPcwsVtGvojcmq9ajNRkV5CWQ28Kqc9Q9KEpohU+PkVznW9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fzcwTpiumXaSLjZKuBYvAMBkdE1jQa6TXv4/4B55v08=;
 b=EsGZClEOOXk2dsBQrU9XWBpJXPKNWRYZHYx1nMZwqzUl1JVkuE5i9HsKC/1shvxVbJs6gmhEAMV278iiJ5qFzNHzCJ4JJDJz8cvszujSYIXPbsHri4i+2NTCdM+P1gd+aWisvXpI2gPlfJ3C1dw7YheiIp62LugJF3mqk9KjrTtnPGKnr+43yzwypTczwXCR9F+iZhCaMjEEoNNZrEyUv+CQH9+b0ivqlMgjgaSrAQBEdJqGlwagsACleW+redf5F3mWa1uswOLaqXGrH9IXrq89owT6LZLJo6PELd9cgxZM9IR6zcpZWjgIXRtaUOcXfTiniNVe4i5ichqAuknBiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from DM3PR12CA0083.namprd12.prod.outlook.com (2603:10b6:0:57::27) by
 DM6PR12MB2683.namprd12.prod.outlook.com (2603:10b6:5:52::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.30; Mon, 18 Nov 2019 08:21:55 +0000
Received: from BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eae::209) by DM3PR12CA0083.outlook.office365.com
 (2603:10b6:0:57::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2451.23 via Frontend
 Transport; Mon, 18 Nov 2019 08:21:55 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT034.mail.protection.outlook.com (10.13.176.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2451.23 via Frontend Transport; Mon, 18 Nov 2019 08:21:55 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 18 Nov
 2019 02:21:54 -0600
Received: from yttao-code-machine.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Mon, 18 Nov 2019 02:21:53 -0600
From: Yintian Tao <yttao@amd.com>
To: <christian.koenig@amd.com>
Subject: [PATCH] drm/amdgpu: put cancel dealyed work at first
Date: Mon, 18 Nov 2019 16:21:49 +0800
Message-ID: <20191118082149.16712-1-yttao@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(136003)(396003)(39860400002)(376002)(428003)(199004)(189003)(54906003)(2906002)(1076003)(14444005)(6862004)(476003)(6636002)(4326008)(8676002)(70586007)(26005)(70206006)(186003)(7696005)(51416003)(48376002)(6666004)(356004)(305945005)(50466002)(2351001)(47776003)(53416004)(81156014)(81166006)(316002)(37006003)(50226002)(478600001)(426003)(2616005)(336012)(126002)(486006)(5660300002)(8936002)(16586007)(36756003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB2683; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1a164f37-fd76-47f7-b2f8-08d76c005f64
X-MS-TrafficTypeDiagnostic: DM6PR12MB2683:
X-Microsoft-Antispam-PRVS: <DM6PR12MB2683F1E414E34B1ED58939DEE54D0@DM6PR12MB2683.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0225B0D5BC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7glRaI9ywUixIwwOtx/0ZTfs2nrcaC/TyTVLFj0W7I3I1oDezkHhDKIHMvJeXs5565t2aAhRD/WFxqjb1sNaZo/nWcnWSjemAtd7RVuIgqldxTZhSRA4fzWkcBtwoy2vxsLzWyk0KKKwtjc5ZKuzyNL4FkDyxUYREQ4KN8VPOPv/yGOgKUQxgh9LxdjKKW6KFnC60wkk0JFVDJa9nx0ya+OxfSMgTqbmXsD6yhW+fsVxW443NfGf4CQVgq5Q2KnZxt6sWCZ3JEQBk6lNflBhp4JoEnw9IgBGu51e4ZZIoN9hr6tmXgXY9CZnHQLO8Qh9rLoPtlXOFJI5ZNFW85MODSOxX/+knWs5fAlvH3MnfeQuCGv51sNFD815yyEZV/OUxQVVOk8Qd4AuVh3nxeft+B5ZCkNOKdpmj2/RnydPkKM3/awFQOs4I/7+Y/O7RVGx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2019 08:21:55.2028 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a164f37-fd76-47f7-b2f8-08d76c005f64
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2683
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fzcwTpiumXaSLjZKuBYvAMBkdE1jQa6TXv4/4B55v08=;
 b=Y1Zv/KemRPsTGU2qOTBlr6wrASx2wDZiiwqHUGd7NYDQQRCI0dbDfjNORxqA+XW0YXJ1YleHmC70Ods/Rry0PfIQ+1McbBU1lmiLqDfoc2OLvmHGExrYSJnhVsNRHSYP3/L0kEKPZ4DBQOe8fJbXy2jKBrFmQZfnTod4FI4ODL8=
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
Message-ID: <20191118082149.71s81AAlz6Q_5GoghCqvBDodpY7MH0hLX27TEANzb40@z>

VGhlcmUgaXMgb25lIHJlZ3Jlc3Npb24gZnJvbSAwNDJmM2Q3Yjc0NWNkNzZhYQphbmQgb25lIGlt
cHJvdmVtZW50IGhlcmUuCi1yZWdyZXNzaW9uOgpwdXQgZmx1c2hfZGVsYXllZF93b3JrIGFmdGVy
IGFkZXYtPnNodXRkb3duID0gdHJ1ZQp3aGljaCB3aWxsIG1ha2UgYW1kZ3B1X2loX3Byb2Nlc3Mg
bm90IHJlc3BvbnNlIHRoZSBpcnEKQXQgbGFzdCwgYWxsIGliIHJpbmcgdGVzdHMgd2lsbCBiZSBm
YWlsZWQganVzdCBsaWtlIGJlbG93CgpbZHJtXSBhbWRncHU6IGZpbmlzaGluZyBkZXZpY2UuCltk
cm1dIEZlbmNlIGZhbGxiYWNrIHRpbWVyIGV4cGlyZWQgb24gcmluZyBnZngKW2RybV0gRmVuY2Ug
ZmFsbGJhY2sgdGltZXIgZXhwaXJlZCBvbiByaW5nIGNvbXBfMS4wLjAKW2RybV0gRmVuY2UgZmFs
bGJhY2sgdGltZXIgZXhwaXJlZCBvbiByaW5nIGNvbXBfMS4xLjAKW2RybV0gRmVuY2UgZmFsbGJh
Y2sgdGltZXIgZXhwaXJlZCBvbiByaW5nIGNvbXBfMS4yLjAKW2RybV0gRmVuY2UgZmFsbGJhY2sg
dGltZXIgZXhwaXJlZCBvbiByaW5nIGNvbXBfMS4zLjAKW2RybV0gRmVuY2UgZmFsbGJhY2sgdGlt
ZXIgZXhwaXJlZCBvbiByaW5nIGNvbXBfMS4wLjEKYW1kZ3B1IDAwMDA6MDA6MDcuMDogW2RybTph
bWRncHVfaWJfcmluZ190ZXN0cyBbYW1kZ3B1XV0gKkVSUk9SKiBJQiB0ZXN0IGZhaWxlZCBvbiBj
b21wXzEuMS4xICgtMTEwKS4KYW1kZ3B1IDAwMDA6MDA6MDcuMDogW2RybTphbWRncHVfaWJfcmlu
Z190ZXN0cyBbYW1kZ3B1XV0gKkVSUk9SKiBJQiB0ZXN0IGZhaWxlZCBvbiBjb21wXzEuMi4xICgt
MTEwKS4KYW1kZ3B1IDAwMDA6MDA6MDcuMDogW2RybTphbWRncHVfaWJfcmluZ190ZXN0cyBbYW1k
Z3B1XV0gKkVSUk9SKiBJQiB0ZXN0IGZhaWxlZCBvbiBjb21wXzEuMy4xICgtMTEwKS4KYW1kZ3B1
IDAwMDA6MDA6MDcuMDogW2RybTphbWRncHVfaWJfcmluZ190ZXN0cyBbYW1kZ3B1XV0gKkVSUk9S
KiBJQiB0ZXN0IGZhaWxlZCBvbiBzZG1hMCAoLTExMCkuCmFtZGdwdSAwMDAwOjAwOjA3LjA6IFtk
cm06YW1kZ3B1X2liX3JpbmdfdGVzdHMgW2FtZGdwdV1dICpFUlJPUiogSUIgdGVzdCBmYWlsZWQg
b24gc2RtYTEgKC0xMTApLgphbWRncHUgMDAwMDowMDowNy4wOiBbZHJtOmFtZGdwdV9pYl9yaW5n
X3Rlc3RzIFthbWRncHVdXSAqRVJST1IqIElCIHRlc3QgZmFpbGVkIG9uIHV2ZF9lbmNfMC4wICgt
MTEwKS4KYW1kZ3B1IDAwMDA6MDA6MDcuMDogW2RybTphbWRncHVfaWJfcmluZ190ZXN0cyBbYW1k
Z3B1XV0gKkVSUk9SKiBJQiB0ZXN0IGZhaWxlZCBvbiB2Y2UwICgtMTEwKS4KW2RybTphbWRncHVf
ZGV2aWNlX2RlbGF5ZWRfaW5pdF93b3JrX2hhbmRsZXIgW2FtZGdwdV1dICpFUlJPUiogaWIgcmlu
ZyB0ZXN0IGZhaWxlZCAoLTExMCkuCgotaW1wcm92ZW1lbnQ6CkluIGZhY3QsIHRoZXJlIGlzIGNh
bmNlbF9kZWxheWVkX3dvcmtfc3luYyBpbiB0aGlzIGZ1Y250aW9uClNvIHRoZXJlIGlzIG5vIG5l
ZWQgdG8gaW52b2tlIGZsdXNoX2RlbGF5ZWRfd29yayBiZWZvcmUKY2FuY2VsX2RlbGF5ZWRfd29y
a19zeW5jLiBKdXN0IHB1dCBjYW5jZWwgYXQgZmlyc3QKClNpZ25lZC1vZmYtYnk6IFlpbnRpYW4g
VGFvIDx5dHRhb0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9kZXZpY2UuYyB8IDQgKy0tLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAzIGRl
bGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9kZXZpY2UuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYwpp
bmRleCAxN2JlNjM4OWFkZjcuLmEyNDU0YzNlZmM2NSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9kZXZpY2UuYwpAQCAtMzEwOSwxMCArMzEwOSw5IEBAIHZvaWQgYW1kZ3B1
X2RldmljZV9maW5pKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQogCWludCByOwogCiAJRFJN
X0lORk8oImFtZGdwdTogZmluaXNoaW5nIGRldmljZS5cbiIpOworCWNhbmNlbF9kZWxheWVkX3dv
cmtfc3luYygmYWRldi0+ZGVsYXllZF9pbml0X3dvcmspOwogCWFkZXYtPnNodXRkb3duID0gdHJ1
ZTsKIAotCWZsdXNoX2RlbGF5ZWRfd29yaygmYWRldi0+ZGVsYXllZF9pbml0X3dvcmspOwotCiAJ
LyogZGlzYWJsZSBhbGwgaW50ZXJydXB0cyAqLwogCWFtZGdwdV9pcnFfZGlzYWJsZV9hbGwoYWRl
dik7CiAJaWYgKGFkZXYtPm1vZGVfaW5mby5tb2RlX2NvbmZpZ19pbml0aWFsaXplZCl7CkBAIC0z
MTMwLDcgKzMxMjksNiBAQCB2b2lkIGFtZGdwdV9kZXZpY2VfZmluaShzdHJ1Y3QgYW1kZ3B1X2Rl
dmljZSAqYWRldikKIAkJYWRldi0+ZmlybXdhcmUuZ3B1X2luZm9fZncgPSBOVUxMOwogCX0KIAlh
ZGV2LT5hY2NlbF93b3JraW5nID0gZmFsc2U7Ci0JY2FuY2VsX2RlbGF5ZWRfd29ya19zeW5jKCZh
ZGV2LT5kZWxheWVkX2luaXRfd29yayk7CiAJLyogZnJlZSBpMmMgYnVzZXMgKi8KIAlpZiAoIWFt
ZGdwdV9kZXZpY2VfaGFzX2RjX3N1cHBvcnQoYWRldikpCiAJCWFtZGdwdV9pMmNfZmluaShhZGV2
KTsKLS0gCjIuMTcuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
