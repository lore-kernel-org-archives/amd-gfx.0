Return-Path: <SRS0=4UxD=ZF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5756BC43331
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2019 14:57:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27D5B222CA
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2019 14:57:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27D5B222CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC24B6E0B6;
	Wed, 13 Nov 2019 14:57:14 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680049.outbound.protection.outlook.com [40.107.68.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76DED6E0B6
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Nov 2019 14:57:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hiv4vGJahkJmtM2IZgzAqTU9aDOJzrVDueGTd63I674kmUVWK7f0SZfqcGa3BPSqesOY9dLUhfjLiZpOCxMZpix4op3b5bC4h1LRtPVpyk6G/u13ViZw9zM/mXn3Ejy6kYQYr0G/lynvNJBG4LFM4FpckwyDYd8b/Zc1jgd2hAVDB6mpEDZPHnjqJ/xBNFgjuY+ndII20WkOVjCz8VkCg+X316K4MKk+q3aTEGHTLFDGd2GvTYT6pcldrwosRyOGMk+gDYB2m2CsRApv515cYbYRaabGnM3V90j+Q66Fzvpwzev9V1Sz399qO8kbzyWTP4jrpyFSs9IGfrFZJOYo5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R/yyDyKZ6MOPnLOXCRg3ZwGcAyiDxgunIz7Oyso3mYQ=;
 b=RBJ3j2NPlcuOiDbNohUvUENYhdSTRD2GfZbLOBQfE6197kwo3ZZIiYCThaZ0H7MzndNNS3XHZSTOWi0FnC8AoY5/7k4EvXU2zDmGtftO8ffP0ZbqCrMOYh4z14OKG9ruKGjHUpbddCorfDDyb0zAGJ/pxHWrW2Vm1lEf2gZu+AySDexCpDH0AqlS3yAL98b35oYRNWe1byEiFsiPY3mCMBlSx9fakJFQBzSL545tEa0LlgAGa4EMWJv6p2uJiwlAV6iXH+tqm5b3XcQcnaAKCiFmmeSxCP/SFZj1IPgEbG3lyzoRUMrMovhfD3NAsri1GFyey2ZcN7Qp7wqItIjPqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from CY4PR1201CA0015.namprd12.prod.outlook.com
 (2603:10b6:910:16::25) by DM6PR12MB3899.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.23; Wed, 13 Nov
 2019 14:57:10 +0000
Received: from BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eae::205) by CY4PR1201CA0015.outlook.office365.com
 (2603:10b6:910:16::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2451.23 via Frontend
 Transport; Wed, 13 Nov 2019 14:57:10 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT038.mail.protection.outlook.com (10.13.176.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2451.23 via Frontend Transport; Wed, 13 Nov 2019 14:57:10 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 13 Nov
 2019 08:57:09 -0600
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Wed, 13 Nov 2019 08:57:07 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>, 
 Dennis Li <Dennis.Li@amd.com>, John Clements <John.Clements@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: enable ras capablity check on arcturus
Date: Wed, 13 Nov 2019 22:57:04 +0800
Message-ID: <20191113145705.12298-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(396003)(346002)(39860400002)(376002)(428003)(189003)(199004)(5660300002)(4744005)(478600001)(14444005)(2616005)(486006)(126002)(476003)(81156014)(4326008)(81166006)(6666004)(8936002)(305945005)(6636002)(8676002)(356004)(50226002)(50466002)(316002)(70206006)(16586007)(110136005)(36756003)(47776003)(186003)(53416004)(51416003)(7696005)(2906002)(426003)(48376002)(86362001)(70586007)(1076003)(336012)(26005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3899; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a84b0ad-bc55-4ffe-5771-08d76849c275
X-MS-TrafficTypeDiagnostic: DM6PR12MB3899:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3899F6EA13826AB78981462AFC760@DM6PR12MB3899.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:346;
X-Forefront-PRVS: 0220D4B98D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sl/CTe/gQ6AlhOgVCLdA886Uq9WMYdSlyqgVKYRqNgSVxBxR9RwI7W2XYfIKE8Q+GmoaRKk9/f9b9NETNtFe5ILOqNb8X9IwzAsE9iHZngT5OiN/mBXtbtqwjnSEjQJKnxmClgDCC93vrTRgyCI2NUdwgIMNifRF8DTeIdiob6L0EmVmTQF/dUWkkEEf6jMoc9GrNMxxAX2qWYfwNMYeZBKVqPmXp/t/wf0ad4+sXnJUuxhdczyf0Rqec1NISoxxjL4qQdVhM9DRuJZq0lIvr3a17rReqR3WFm1WEdR9TQh0vjNWvwULdGyhaEN81onc8Mf8MxmGzvIEJucS89ij2yMHWhXbaFirM/jgeRQnZQgdpJH/i3SIgXek/MXUssP5kSl6U5iVFNloO90jHq4zxzqSoijvlQwg89PZL4MrWqBnhNzQGr7JydeAmORQu9a5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2019 14:57:10.0155 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a84b0ad-bc55-4ffe-5771-08d76849c275
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3899
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R/yyDyKZ6MOPnLOXCRg3ZwGcAyiDxgunIz7Oyso3mYQ=;
 b=1n277yGVD0dmPNqq+gc5jJSjMhGwR+XOg441UjHOofgBXU5TY0K8mnzNzcdMyYaO7SJGue6jgBy1qVoDOZ42kRgvAfDWsUIJYp6yvIiLqT30IEZyIXYlKDo81eqfKta66rWdwnUncFAvfJFvluq3tArNibfemlhfERNh+3P2JA8=
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
Message-ID: <20191113145704.ZDUvEMDvpAqtbgeYw5K8TClBqP3yRhzft8qM7QKq9co@z>

Y2hlY2sgaHcgcmFzIGNhcGFibGl0eSB2aWEgYXRvbWZpcm13YXJlCgpDaGFuZ2UtSWQ6IEk0OTVi
NzNhYzZjMDQ5MTBkZTJhZDhkOWM0NmU5ODg3M2ZiNWJjNDRkClNpZ25lZC1vZmYtYnk6IEhhd2tp
bmcgWmhhbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfcmFzLmMgfCAzICsrLQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9u
cygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9yYXMuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMu
YwppbmRleCBkMmUwODU5ZjU3YTAuLjk4ZTQxZDljMmZjMCAxMDA2NDQKLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9yYXMuYwpAQCAtMTY2MSw3ICsxNjYxLDggQEAgc3RhdGljIHZvaWQgYW1k
Z3B1X3Jhc19jaGVja19zdXBwb3J0ZWQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiAJKnN1
cHBvcnRlZCA9IDA7CiAKIAlpZiAoYW1kZ3B1X3NyaW92X3ZmKGFkZXYpIHx8Ci0JCQlhZGV2LT5h
c2ljX3R5cGUgIT0gQ0hJUF9WRUdBMjApCisJICAgIChhZGV2LT5hc2ljX3R5cGUgIT0gQ0hJUF9W
RUdBMjAgJiYKKwkgICAgIGFkZXYtPmFzaWNfdHlwZSAhPSBDSElQX0FSQ1RVUlVTKSkKIAkJcmV0
dXJuOwogCiAJaWYgKGFkZXYtPmlzX2F0b21fZncgJiYKLS0gCjIuMTcuMQoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QK
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
