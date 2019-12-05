Return-Path: <SRS0=ZBu5=Z3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5685C43603
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Dec 2019 19:29:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82965206D9
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Dec 2019 19:29:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82965206D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26A646E176;
	Thu,  5 Dec 2019 19:29:43 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 198ED6E176
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Dec 2019 19:29:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SzM9TGxisVEz4pabDhPYQG7HId0zb23Ji4HSX+mWXTbzKt6ZEQSFnZt/zJhrutFH3vzC5eYx840TWAjcJ2Q0raJOtmzs/+OXRZNOAoCh9gkCQ4vgdlW2Zm+5tMRAcz7tjM0GDrFb0X3PAvJqMjQ9SQDeYXif0GtH9Tv8qQ5Z/Qnu3Vyfk47juIy07suWc8epQtznzYu5We2seEQ2J9Jo/YXa09aXmtgq8H8/x3P8y4lUxCBTtumQia0GcvM/i+ocADDecfS2IMttGe8X1va+xOsaIOtgMubi+n0nreq3fM8F7xthilQjoRCuhvrN1baK8UDqyxNKfxG7B1sdYm7aLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pn0AxBNt/LsQHqOTlQKoIufTCMdHFuYJMK1WqiS1uWc=;
 b=Mle/37rYItpB213mH9svEk0Mw7BLoiz7/gKhEthpwDQrYPq1xcNldR5uvtWSTt2xFpDZ5jW/wJIQDsEmgftDrTMxV+9u5wiVJpeQ3wxOJ7qyjRfOBJqW65bH6OhYMR39xiPd0R6iy26NyZzeJ64EieFT0Og+IUFcnlt6ndKmH+nL6d7Jp9yZgaorDi5RRulVrPTWPA9J4FMdHxIpkFrqmEUAWIGkxgbXLWng05tjELr+1GWVFDZg9X0ZCYPm2UvNexVMfrC1vSnehiJhmgcu1MF5sGnfnJ50DT2bRHcZ6ybjkbfRCyHK7I+zxrpdYNwl3wSu5XAUHrMNwix0sMny0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from DM5PR12CA0057.namprd12.prod.outlook.com (2603:10b6:3:103::19)
 by MWHPR12MB1870.namprd12.prod.outlook.com (2603:10b6:300:10a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.22; Thu, 5 Dec
 2019 19:29:38 +0000
Received: from BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eae::208) by DM5PR12CA0057.outlook.office365.com
 (2603:10b6:3:103::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2516.13 via Frontend
 Transport; Thu, 5 Dec 2019 19:29:38 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT056.mail.protection.outlook.com (10.13.177.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2451.23 via Frontend Transport; Thu, 5 Dec 2019 19:29:38 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 5 Dec 2019
 13:29:37 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 5 Dec 2019
 13:29:37 -0600
Received: from agrodzovsky-All-Series.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Thu, 5 Dec 2019 13:29:37 -0600
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Fix BACO entry failure in NAVI10.
Date: Thu, 5 Dec 2019 14:29:35 -0500
Message-ID: <1575574175-20765-1-git-send-email-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(428003)(199004)(189003)(70206006)(4744005)(70586007)(86362001)(8936002)(81166006)(81156014)(50226002)(8676002)(305945005)(4326008)(51416003)(186003)(26005)(7696005)(36756003)(50466002)(336012)(53416004)(44832011)(14444005)(2906002)(5660300002)(2616005)(426003)(6916009)(54906003)(356004)(498600001)(48376002)(16586007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR12MB1870; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 07072576-15c5-4b61-3e9e-08d779b977b6
X-MS-TrafficTypeDiagnostic: MWHPR12MB1870:
X-Microsoft-Antispam-PRVS: <MWHPR12MB187082B861AFE5ABBEED3C6DEA5C0@MWHPR12MB1870.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-Forefront-PRVS: 02426D11FE
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m8SV+OAh979PYNlOVd8sJEY59JY6EkvKhUhE6kEvURLiAJgKC4LN38BCLUTQaUdLrwZdV5WvSnZac/Oofru6WEd52yr2pC4hZwHRQfJRwGSa6h9IMirdLgRpnZgS/Q7eHeohCrqvkdBETb1dMe8e4GHSAqGbUay2QCl0p12jk1uvz827YMeszcJ0EOOarzidcOzDt+QohZnS/I5isJ1BfeYbsNc9MNOQjO+frhERTZensr0u9adJpe+WrC5rz7LgIrK33drNKZGU/sziqL4/n8dw0iKj95gLVrbvx0PCL/XfKqRSQFAqZCqAwik1+5YwEPwuHFhRdZ4/YPooKd0z1P6xI+e1jB230W0OOwLTgu1/KXnSIHKiS1bNQbBn9cPYvMbvMBUP7orqOMtfLEZQgVpyhdl0ow3D68/Cv61MR48nEg/J5BDsrKGocng3++QO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2019 19:29:38.0137 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07072576-15c5-4b61-3e9e-08d779b977b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1870
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pn0AxBNt/LsQHqOTlQKoIufTCMdHFuYJMK1WqiS1uWc=;
 b=2gRne2vOh4PyTpG565lt8Dtzv3v0Zyy8LXNSZgP9lOerlS+yvDTI7lSM8mh3yP6sd2R7zYN6DnyYF9nwgDUZW+xIp5x/Qg0LdAE4OEWPx4HgsR9TGiNcikZdPawkKA10Th1EelWs0gVVlcOUTOvuie/73lvj8N/3afOmyPrXPIc=
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
Cc: Alexander.Deucher@amd.com, Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QkFDTyBmZWF0dXJlIG11c3QgYmUga2VwdCBlbmFibGVkIHRvIGFsbG93IGVudHJ5IGludG8KQkFD
TyBzdGF0ZSBpbiBTTVUgZHVyaW5nIHJ1bnRpbWUgc3VzcGVuZC4KClNpZ25lZC1vZmYtYnk6IEFu
ZHJleSBHcm9kem92c2t5IDxhbmRyZXkuZ3JvZHpvdnNreUBhbWQuY29tPgotLS0KIGRyaXZlcnMv
Z3B1L2RybS9hbWQvcG93ZXJwbGF5L2FtZGdwdV9zbXUuYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvcG93ZXJwbGF5L2FtZGdwdV9zbXUuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93
ZXJwbGF5L2FtZGdwdV9zbXUuYwppbmRleCBjMzBmOWEyLi42ZGRkZDc4IDEwMDY0NAotLS0gYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9hbWRncHVfc211LmMKKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9wb3dlcnBsYXkvYW1kZ3B1X3NtdS5jCkBAIC0xMzgzLDcgKzEzODMsNyBAQCBz
dGF0aWMgaW50IHNtdV9zdXNwZW5kKHZvaWQgKmhhbmRsZSkKIAlpZiAocmV0KQogCQlyZXR1cm4g
cmV0OwogCi0JaWYgKGFkZXYtPmluX2dwdV9yZXNldCAmJiBiYWNvX2ZlYXR1cmVfaXNfZW5hYmxl
ZCkgeworCWlmIChiYWNvX2ZlYXR1cmVfaXNfZW5hYmxlZCkgewogCQlyZXQgPSBzbXVfZmVhdHVy
ZV9zZXRfZW5hYmxlZChzbXUsIFNNVV9GRUFUVVJFX0JBQ09fQklULCB0cnVlKTsKIAkJaWYgKHJl
dCkgewogCQkJcHJfd2Fybigic2V0IEJBQ08gZmVhdHVyZSBlbmFibGVkIGZhaWxlZCwgcmV0dXJu
ICVkXG4iLCByZXQpOwotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
YW1kLWdmeA==
