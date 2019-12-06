Return-Path: <SRS0=UM6f=Z4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56280C43603
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Dec 2019 09:00:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3609420659
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Dec 2019 09:00:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3609420659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C93C6F988;
	Fri,  6 Dec 2019 09:00:08 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4994B6F986
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Dec 2019 09:00:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SjwYs1nv5PesZYUnF8WYDL9tkCAWVGIWNdYNgVpyclEP2YL7EgMCthsUunLEBZQL58dUyslW9fK8+mLXyY5wc1SdqicCXmmP+jMKSySTRKWzguVEmR5IAzgeEUTsFeDyjRCLHCC6W4eLnLRQLQfxgz7p7OIGZz3400F94gdt4QH5v0NhAQogjCcOCHtuNGBg87kv+0CJzxqU9QZX1zW9vZgua+cKnpsguhwSDUSYEZLF6LHg3lf9ZUlEsEJmhOF3FTDgPRskeFyOGjZcb2K/Dmg4cQ97db5/5j4a8J4zz7GXIh3+oh7qI7JPNd9h6uKuXSNkJqXHynlElkdW8HBBsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2JeBK/lVmRex+sEvUlIWMZJqAT3YSNpDGIqtrrvFmeI=;
 b=atnQt3NkQHKXAy4miuTaX16VVwDVGeh3+3AyBsSHGPwNocwiNPXl07X0fOKxAFnh+cp8roXEY0/zkmlQ6mbJeXKj6unAvYZYPZJ1oEVp5JNlcYURfdo1Cdxh9lh3E9uyVYIImFUXLb562NWyWOnnBT1Slj5tZ80xWusXUEXoGpv0+NQxr0/l0Xiw40I16SPI/sVaqxwTDvsjzCLxXTdBiHGxSCJRWDf416Vi/IiZj6rEQNRxLZm6N/PY1/LsrzKtnpR2ZmHopzewXquJESwIpnM5ypThV7TXu1Ur/SWrFTCzMLR69BnL3goP6ke/O2hsoa3tQe4xqvERnXmv/NNeHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from CY4PR12CA0037.namprd12.prod.outlook.com (2603:10b6:903:129::23)
 by BN6PR1201MB0036.namprd12.prod.outlook.com (2603:10b6:405:4e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.16; Fri, 6 Dec
 2019 09:00:03 +0000
Received: from BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eae::204) by CY4PR12CA0037.outlook.office365.com
 (2603:10b6:903:129::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2516.12 via Frontend
 Transport; Fri, 6 Dec 2019 09:00:03 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT038.mail.protection.outlook.com (10.13.176.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2451.23 via Frontend Transport; Fri, 6 Dec 2019 09:00:02 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 6 Dec 2019
 03:00:00 -0600
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Fri, 6 Dec 2019 02:59:58 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Le Ma <Le.Ma@amd.com>, John Clements
 <John.clements@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: fix resume failures casued by psp fw loading
 sequence change
Date: Fri, 6 Dec 2019 16:59:56 +0800
Message-ID: <20191206085956.4681-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(346002)(136003)(396003)(376002)(428003)(189003)(199004)(8936002)(1076003)(8676002)(81156014)(81166006)(305945005)(53416004)(50226002)(5660300002)(186003)(2906002)(14444005)(50466002)(26005)(6636002)(316002)(356004)(48376002)(36756003)(4326008)(110136005)(16586007)(86362001)(426003)(2616005)(478600001)(336012)(70586007)(51416003)(7696005)(70206006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR1201MB0036; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 85c721c0-70e0-4609-8c60-08d77a2aae62
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0036:
X-Microsoft-Antispam-PRVS: <BN6PR1201MB0036D24B4888BD1D73AF3B3DFC5F0@BN6PR1201MB0036.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 0243E5FD68
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kirxuDlqM1HLWc9/ZP6onsPfcfq2pzWqGP9lNx9Ovyg9RRZsOjql3QqrASgPkQPz3QwaSk5swRqxgCUmUyyDOPDSBs2JR753svlQurfmRo2egh1ZzyB9JuVWno40BbPUff8mcYL41BZkR+MwXVKyA4R9TxPRbo0v+EphI7OcIL1Lgi9Dx76g/RBwpHiQTwRJREYeX/Heb+9TuNGPmCXJ/ClqFWH31PBo0FFroOe+i0LnxhvJuE421Nj5I9MPMUSYS3txiD+FeKtNSJB1qyj7pkXmEdOO+NMvXf5JgXMsWifYnnfKOezdZBctS/E7F59wCfuIe7AkmB/9w9MKGa5ja1sR5muLcSkg7ldQiyUKj4U0zWE5XvOIw1LG5a0Z/+knJj8LPyT05nhYk9Yo0qslRsRz7+zx89r0yPJl6FenwiWudKyem0DWeeuDNIPyHN0c
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2019 09:00:02.8683 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85c721c0-70e0-4609-8c60-08d77a2aae62
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0036
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2JeBK/lVmRex+sEvUlIWMZJqAT3YSNpDGIqtrrvFmeI=;
 b=xFaKLXBNYwzMsxvtd6lU2MqG631X/qOTwvINbrywf+M7ao+YwZIQxDnP6gIffgFkXRD5uUguEcKBCFT3HrdK++GKjLKAGAridA+obE9V4LztUh3j/7WEPTnKPV9zD9x4iqw3bHat2esXbpXsNPmOMBvSpasJH9Nxd8q+EZR+5WQ=
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
Z2UtSWQ6IEk1NzAxMGJjN2RkZjcxYWM0NmQzZmI1NDRkMjc5MzI2NjQxOTBjZjA0ClNpZ25lZC1v
ZmYtYnk6IEhhd2tpbmcgWmhhbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT4KLS0tCiBkcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMgfCAzMyArKysrKysrKysrKysrKysrKysr
KysrKysrCiAxIGZpbGUgY2hhbmdlZCwgMzMgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9wc3AuYwppbmRleCBjZWVhODMxNGQ4OGQuLjJlZjE2ZDRjNzUyZCAx
MDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5jCisrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYwpAQCAtMTcwMiw2ICsxNzAy
LDM5IEBAIHN0YXRpYyBpbnQgcHNwX3Jlc3VtZSh2b2lkICpoYW5kbGUpCiAJaWYgKHJldCkKIAkJ
Z290byBmYWlsZWQ7CiAKKwlyZXQgPSBwc3BfYXNkX2xvYWQocHNwKTsKKwlpZiAocmV0KSB7CisJ
CURSTV9FUlJPUigiUFNQIGxvYWQgYXNkIGZhaWxlZCFcbiIpOworCQlyZXR1cm4gcmV0OworCX0K
KworCWlmIChhZGV2LT5nbWMueGdtaS5udW1fcGh5c2ljYWxfbm9kZXMgPiAxKSB7CisJCXJldCA9
IHBzcF94Z21pX2luaXRpYWxpemUocHNwKTsKKwkJLyogV2FybmluZyB0aGUgWEdNSSBzZWVzaW9u
IGluaXRpYWxpemUgZmFpbHVyZQorCQkgKiBJbnN0ZWFkIG9mIHN0b3AgZHJpdmVyIGluaXRpYWxp
emF0aW9uCisJCSAqLworCQlpZiAocmV0KQorCQkJZGV2X2Vycihwc3AtPmFkZXYtPmRldiwKKwkJ
CQkiWEdNSTogRmFpbGVkIHRvIGluaXRpYWxpemUgWEdNSSBzZXNzaW9uXG4iKTsKKwl9CisKKwlp
ZiAocHNwLT5hZGV2LT5wc3AudGFfZncpIHsKKwkJcmV0ID0gcHNwX3Jhc19pbml0aWFsaXplKHBz
cCk7CisJCWlmIChyZXQpCisJCQlkZXZfZXJyKHBzcC0+YWRldi0+ZGV2LAorCQkJCQkiUkFTOiBG
YWlsZWQgdG8gaW5pdGlhbGl6ZSBSQVNcbiIpOworCisJCXJldCA9IHBzcF9oZGNwX2luaXRpYWxp
emUocHNwKTsKKwkJaWYgKHJldCkKKwkJCWRldl9lcnIocHNwLT5hZGV2LT5kZXYsCisJCQkJIkhE
Q1A6IEZhaWxlZCB0byBpbml0aWFsaXplIEhEQ1BcbiIpOworCisJCXJldCA9IHBzcF9kdG1faW5p
dGlhbGl6ZShwc3ApOworCQlpZiAocmV0KQorCQkJZGV2X2Vycihwc3AtPmFkZXYtPmRldiwKKwkJ
CQkiRFRNOiBGYWlsZWQgdG8gaW5pdGlhbGl6ZSBEVE1cbiIpOworCX0KKwogCW11dGV4X3VubG9j
aygmYWRldi0+ZmlybXdhcmUubXV0ZXgpOwogCiAJcmV0dXJuIDA7Ci0tIAoyLjE3LjEKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGlu
ZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
