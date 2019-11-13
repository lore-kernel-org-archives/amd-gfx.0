Return-Path: <SRS0=4UxD=ZF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A86C43331
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2019 14:57:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06AF4222C9
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2019 14:57:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06AF4222C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C81FA6ED40;
	Wed, 13 Nov 2019 14:57:19 +0000 (UTC)
Received: from NAM05-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr730067.outbound.protection.outlook.com [40.107.73.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE8426ED40
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Nov 2019 14:57:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fKbw2KCOe9PLbEVYQZL31cbWo7OEWn/WWP0JaKgb+VZ7a1bUxMZsBQLgsJyHeQSeAobV3DYISDzVHIH0FRCGQnIyqi0upR82W2z3509ddDNTyVbk8l2kBrA1tL9u6CKxh5sSuONzLIJuRQxpklCWZhwl3wBOlVQDnhuTxy6D0EjQDBAAfV5DU6OUfZrzFU2VSxnOMfhB+dn2UktxJTO4LdW4utWAlEqUEHp4vKple+pMgVCKz9NH61EPd0Y88azZqoAyzewfA6oYW87CJkniKn9yW0qF4/jgsLJ46Ae5HkovemRWXGAq+3kiZw+bTCznUSAj86+yqo639k0z7324uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cJu6rtaZn2s/5MjyEpaJHFVv5JdLwB5lBDDZY3esRFg=;
 b=NMgvJjZPANf0LzFVReglQE3FCEdYRjnwRWroVIqtqZjJQO6VC5TSJU5VaBT7fCbtO7Tpt9l5c9FTj2ilnqNn3Kvn4XN6mpgU+fqY8fZqbGZNm1goDSIRHqRN8hk0mNf6SZqyExp7P24hHgU0x0GSesU5OJnf2JI5jpXKCoQ8Ba6tecXgwIdN+mrXGpDCdXuh9FPMlNce04MYn1Yg1gGyO0KH9rPt2rzJsdtdblohiZlztEvepOMyUepjpkXO5i0RjuCFzazPfdZS01QuxujImEnLbl/1iCNKfn7C8k8ZFs9eGrfIV31moyGYHk0odCiOYOtEx/oHByMPNhIts97yWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from BN6PR1201CA0019.namprd12.prod.outlook.com
 (2603:10b6:405:4c::29) by MW2PR12MB2476.namprd12.prod.outlook.com
 (2603:10b6:907:c::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.20; Wed, 13 Nov
 2019 14:57:13 +0000
Received: from BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eae::205) by BN6PR1201CA0019.outlook.office365.com
 (2603:10b6:405:4c::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2451.22 via Frontend
 Transport; Wed, 13 Nov 2019 14:57:13 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT040.mail.protection.outlook.com (10.13.177.166) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2451.23 via Frontend Transport; Wed, 13 Nov 2019 14:57:13 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 13 Nov
 2019 08:57:13 -0600
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Wed, 13 Nov 2019 08:57:11 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>, 
 Dennis Li <Dennis.Li@amd.com>, John Clements <John.Clements@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: init umc functions for arcturus umc ras
Date: Wed, 13 Nov 2019 22:57:05 +0800
Message-ID: <20191113145705.12298-2-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191113145705.12298-1-Hawking.Zhang@amd.com>
References: <20191113145705.12298-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(396003)(376002)(136003)(39860400002)(428003)(189003)(199004)(48376002)(50466002)(7696005)(186003)(5660300002)(356004)(6666004)(305945005)(6636002)(1076003)(81156014)(126002)(8676002)(336012)(50226002)(2906002)(486006)(4326008)(110136005)(446003)(316002)(11346002)(53416004)(16586007)(426003)(47776003)(70586007)(70206006)(76176011)(51416003)(86362001)(36756003)(2616005)(476003)(8936002)(81166006)(26005)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2476; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 079ec575-845b-42e7-0624-08d76849c47b
X-MS-TrafficTypeDiagnostic: MW2PR12MB2476:
X-Microsoft-Antispam-PRVS: <MW2PR12MB24768BA62C79415E94520658FC760@MW2PR12MB2476.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0220D4B98D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9fiDgnytFi2Ll0KEodRMC6AC+RRe/AErVNvU0pFRUUDBpmyNF1tV4+dcjE+f9HgHLADenUdIs22xTXT3d/JpMISUnMFPaeYl9t17PLg4fsetogDy2UAI5myzKw0+pzh7Dkc0TZgWPnHPhj8271DXCHi5mR7JKLbM3cmXVaGx4usmBqwtLRhEzXmwfuPZ5Ik0wFP5vDwb8KQd3978xFE+NpHN79xUBkaNzpk42Fj9g8oMcGEF2RX5h70zAd84VJBAqhKcRJ6FyWtq2gwSOCK2BHojRQMdtyCrNIWHjtI1skLWll5a9tYmI3TjHL4TXt29F4NwTDssmrGFwNNvqcEepWnWNFR0sRLvfrqM/GukolPrmwYIuPIr0zJpiOlWfooj824qosFExIP84dYlyTiFBWh72+oJvHZaZud9XgCF8+mexn288z+O92mZnHiP018O
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2019 14:57:13.4062 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 079ec575-845b-42e7-0624-08d76849c47b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2476
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cJu6rtaZn2s/5MjyEpaJHFVv5JdLwB5lBDDZY3esRFg=;
 b=gP0KD5ksa8OUnTZZkipPDlsHQlvhsnC7uTZUXzdbzDcve9w+DRWBZdDzZ/SqBsJxq+kFTBdBSHzoC1NCVroowWbAeWyNVmK4QR4Wn0Xfp+DAm/N4hxVoPGL64cDXIDWsX0o+MP+ltALVeMZdZxtBUDZmEOAgLJWUUNZxrX/lE/8=
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
Message-ID: <20191113145705.DuuYu7nUrBF6wkKJxk1NPOM6Pf2Pi7X1nAfps7HXS8s@z>

cmV1c2UgdmcyMCB1bWMgZnVuY3Rpb25zIGZvciBhcmN0dXJ1cyB1bWMgcmFzCgpDaGFuZ2UtSWQ6
IElhOGFmM2MyMGE3MTdjNzZlYzE4YWE1ZmEzMzJjZmQ4MWNhNjBmZjY5ClNpZ25lZC1vZmYtYnk6
IEhhd2tpbmcgWmhhbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9nbWNfdjlfMC5jIHwgMiArKwogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0
aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192OV8w
LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjlfMC5jCmluZGV4IDM3ODRiNjIy
MDFiMC4uOGE1YjcyMmNlNWI3IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9nbWNfdjlfMC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192OV8wLmMK
QEAgLTYzNSw2ICs2MzUsNyBAQCBzdGF0aWMgdm9pZCBnbWNfdjlfMF9zZXRfdW1jX2Z1bmNzKHN0
cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQogCQlhZGV2LT51bWMuZnVuY3MgPSAmdW1jX3Y2XzBf
ZnVuY3M7CiAJCWJyZWFrOwogCWNhc2UgQ0hJUF9WRUdBMjA6CisJY2FzZSBDSElQX0FSQ1RVUlVT
OgogCQlhZGV2LT51bWMubWF4X3Jhc19lcnJfY250X3Blcl9xdWVyeSA9IFVNQ19WNl8xX1RPVEFM
X0NIQU5ORUxfTlVNOwogCQlhZGV2LT51bWMuY2hhbm5lbF9pbnN0X251bSA9IFVNQ19WNl8xX0NI
QU5ORUxfSU5TVEFOQ0VfTlVNOwogCQlhZGV2LT51bWMudW1jX2luc3RfbnVtID0gVU1DX1Y2XzFf
VU1DX0lOU1RBTkNFX05VTTsKQEAgLTc0OCw2ICs3NDksNyBAQCBzdGF0aWMgaW50IGdtY192OV8w
X2xhdGVfaW5pdCh2b2lkICpoYW5kbGUpCiAJCXN3aXRjaCAoYWRldi0+YXNpY190eXBlKSB7CiAJ
CWNhc2UgQ0hJUF9WRUdBMTA6CiAJCWNhc2UgQ0hJUF9WRUdBMjA6CisJCWNhc2UgQ0hJUF9BUkNU
VVJVUzoKIAkJCXIgPSBhbWRncHVfYXRvbWZpcm13YXJlX21lbV9lY2Nfc3VwcG9ydGVkKGFkZXYp
OwogCQkJaWYgKCFyKSB7CiAJCQkJRFJNX0lORk8oIkVDQyBpcyBub3QgcHJlc2VudC5cbiIpOwot
LSAKMi4xNy4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRw
czovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
