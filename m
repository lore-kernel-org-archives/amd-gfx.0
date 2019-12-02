Return-Path: <SRS0=0KW4=ZY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C98B5C432C0
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 11:05:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81F07214AF
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 11:05:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81F07214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F3946E148;
	Mon,  2 Dec 2019 11:05:29 +0000 (UTC)
Received: from NAM05-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr730068.outbound.protection.outlook.com [40.107.73.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB8C46E169
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Dec 2019 11:05:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mc/S8vBjyOyCBMSfMYEmrxj7GsQXbO1PGjRIXIRj+UDJxXMjyHMtyMm/+54Nwrg42aC2UaooT25C+TU7FWgUP+42Ro6AztZR7cIzjqHmRsMk1QQa9OhivHlD1dVj2j7f7G90gBtsyQfaxXb92idGtN50ijuTDdTm3PCeYWBkubsX1oS4cp9TLzhXPclTDssA7rLqEQrIYK+Q3j423jtZSXRniicNqFu/vnQqrWAH3UT1CA2f8CmYLsCJ1rUqTdw1cTyIyhwu/50S1Vn3mRqTdDVZPfPe2A8OuYfPFAuGms3o2JQNetbKQzoxKdHtrOOcxSYnxYMY6SiTA/FL+hi7PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZYtNovF+SbYNGNfoztut+F15gbQROWBkn5WzfVKxXBA=;
 b=eK7VPxrTHQtfhQHPfU2JGtJp98Ft0UUNYzzGaYo++HFseAyrxJf/v2yyiKNmR01sNRKLzdrLzpQ3M8qKDOHzZMJ8GUMdNSg71qcfB6tJBkq2IR4Se2FweKgTX/4vgZizKVzikXWyFJg1p8pPLQzpmfE5SAYY9wn/G7gU65xjpz+YT3ZaPtNVLD5T/9YGHFz4HjgK33V+ZNsClMLv8XM31kcafkSvn18abqxap65MzyWD+Af5KwN68hjeYCelejNGqUXZk793n+oRwYRK5p9kwrRhieXc4ZWbly2s/x1XYVWcvIN0jPL1YAeO3joOpE5emUSgI5gbVp9d/SJHY2gdmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from MWHPR12CA0044.namprd12.prod.outlook.com (2603:10b6:301:2::30)
 by MN2PR12MB3838.namprd12.prod.outlook.com (2603:10b6:208:16c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.22; Mon, 2 Dec
 2019 11:05:25 +0000
Received: from CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::207) by MWHPR12CA0044.outlook.office365.com
 (2603:10b6:301:2::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2495.19 via Frontend
 Transport; Mon, 2 Dec 2019 11:05:24 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT063.mail.protection.outlook.com (10.13.175.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2451.23 via Frontend Transport; Mon, 2 Dec 2019 11:05:23 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 2 Dec 2019
 05:05:22 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 2 Dec 2019
 05:05:22 -0600
Received: from ubuntu-mi100.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Mon, 2 Dec 2019 05:05:21 -0600
From: Jack Zhang <Jack.Zhang1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] amd/amdgpu/sriov swSMU disable for sriov
Date: Mon, 2 Dec 2019 19:05:19 +0800
Message-ID: <20191202110519.3504-1-Jack.Zhang1@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(39860400002)(136003)(376002)(396003)(428003)(199004)(189003)(50466002)(316002)(51416003)(70206006)(70586007)(305945005)(7696005)(8676002)(81156014)(6916009)(50226002)(14444005)(47776003)(86362001)(356004)(2906002)(5660300002)(36756003)(4326008)(16586007)(48376002)(81166006)(8936002)(1076003)(53416004)(478600001)(426003)(336012)(186003)(2616005)(26005)(2351001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3838; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5a671904-2b8e-42ae-f8a8-08d7771787b2
X-MS-TrafficTypeDiagnostic: MN2PR12MB3838:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3838A323BC1521A81AE23D14BB430@MN2PR12MB3838.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0239D46DB6
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0Icbq6bECWY4pFGINJlRyHhaizKSVBWm81rav+MvP/zMeSdqstwW0vQVMs+Q0njExxt3GKFdQ8HHskZ14e32JTVeAcW4Z4sFjcyab3O36gEDqBLyHgEv6aLO3PcetFcnTIFvkpEQRCen/m3LHKgfNLh8HyoiacpzLfcuCoIvMRwonlY6PXqGLmIJjCgiRGCW4O5YombqBYSk3pA2AwfDcjSGP52p0HqG9u4DjSwgUMW11NJb0QGb5m0HwnlxFHlU7W74KcsI5qcyRKjNxYBtHCg2tP2BDXsYyTLqRXUCOOMGv02vI8Vy0YQbsxuSBV0RC5+J3RgLigUfq+4T7URaxJKg3DhjU7yL0Zuf1fWo4Yl8bqb4ukduk0gedRtOPKdqq6GLYltZ/2CSOIpRV7he2z8+dasaduVc95JEu7e9r0IKcNu+b0S2AgnApkHjeh7B
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2019 11:05:23.9229 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a671904-2b8e-42ae-f8a8-08d7771787b2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3838
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZYtNovF+SbYNGNfoztut+F15gbQROWBkn5WzfVKxXBA=;
 b=ryjuXNOnWWp9q9cPPK/sIWnI0ZFkzAbHIjuvgmBC1ktts3uhbpEMMyKJUkNESfuEr+u+W48VaOcRwSJwWfqA4nVj476LZo/JQGNWrWjShF/fDmj6/DNv22VKMf/jjJB03RED2c7SVvx0fgTcO3D4x8+22M6JKGT3APxNdN3Bix8=
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
Cc: Jack Zhang <Jack.Zhang1@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rm9yIGJvYXJkcyBncmVhdGVyIHRoYW4gQVJDVFVSVVMsIGFuZCB1bmRlciBzcmlvdiBwbGF0Zm9y
bSwKc3dTTVUgaXMgbm90IHN1cHBvcnRlZCBiZWNhdXNlIHNtdSBpcCBibG9jayBpcyBjb21tZW50
ZWQgYXQKZ3Vlc3QgZHJpdmVyLgoKR2VuZXJhbGx5IGZvciBzcmlvdiwgaW5pdGlhbGl6YXRpb24g
b2Ygc211IGlzIG1vdmVkIHRvIGhvc3QgZHJpdmVyLgpUaHVzLCBzbXUgc3dfaW5pdCBhbmQgaHdf
aW5pdCB3aWxsIG5vdCBiZSBleGVjdXRlZCBhdCBndWVzdCBkcml2ZXIuCgpXaXRob3V0IHN3IHN0
cnVjdHVyZSBiZWluZyBpbml0aWFsaXplZCBpbiBndWVzdCBkcml2ZXIsIHN3U01VIGNhbm5vdApk
ZWNsYXJlIHRvIGJlIHN1cHBvcnRlZC4KClNpZ25lZC1vZmYtYnk6IEphY2sgWmhhbmcgPEphY2su
WmhhbmcxQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvYW1kZ3B1
X3NtdS5jIHwgNSArKysrLQogMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMSBkZWxl
dGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2FtZGdw
dV9zbXUuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2FtZGdwdV9zbXUuYwppbmRl
eCAzNjAwMWE0Li4wYjhhNTNiIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2Vy
cGxheS9hbWRncHVfc211LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvYW1k
Z3B1X3NtdS5jCkBAIC01MzEsNyArNTMxLDEwIEBAIGJvb2wgaXNfc3VwcG9ydF9zd19zbXUoc3Ry
dWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiAJaWYgKGFkZXYtPmFzaWNfdHlwZSA9PSBDSElQX1ZF
R0EyMCkKIAkJcmV0dXJuIChhbWRncHVfZHBtID09IDIpID8gdHJ1ZSA6IGZhbHNlOwogCWVsc2Ug
aWYgKGFkZXYtPmFzaWNfdHlwZSA+PSBDSElQX0FSQ1RVUlVTKQotCQlyZXR1cm4gdHJ1ZTsKKwkJ
aWYgKGFtZGdwdV9zcmlvdl92ZihhZGV2KSkKKwkJCXJldHVybiBmYWxzZTsKKwkJZWxzZQorCQkJ
cmV0dXJuIHRydWU7CiAJZWxzZQogCQlyZXR1cm4gZmFsc2U7CiB9Ci0tIAoyLjcuNAoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5n
IGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
