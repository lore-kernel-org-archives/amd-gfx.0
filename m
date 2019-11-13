Return-Path: <SRS0=4UxD=ZF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BFAAC432C3
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2019 22:45:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FC662063A
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2019 22:45:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FC662063A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B20846EE8D;
	Wed, 13 Nov 2019 22:45:37 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700065.outbound.protection.outlook.com [40.107.70.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02ED06EE8D
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Nov 2019 22:45:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B31du+JUXYxI4zOSgjRG8FAm9F6AdQJOfqJtjrBlZwfVbyX1/PuJP6D24iWpegbek1JfwddGFNp0JFaXy/5Z+IW0k7LvTpoeJygDH7YIz7VIRNV8+pFdoVwJkKVo3xrIW4R7V4qgE8Kv3Oklh0iIxEAy/GXW02umu/lVj9cAMKqV2AfNVHHhMHz6VjCuTp3Loos+F2oK46h4fQ0Ok7AKHa9uUDlcmM6uUO3gIJQlyHcakEmQXaXuof0L0z8Gizvlf9DiXW0HCe41r/MRWdzcaZyjhYjBKC8kiA5oYrE/8pN2C8PMqA8Z0aTiBvudPlmakVWLe0lLpl5DCBpPN1sqLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lNkzdIwFnk77wacJ/nUIQMpYqmWmaaHUEeMFbHb5LEE=;
 b=SMboaeHP7caEkCCCobgrjl0MF65kOgEBnUHHAAJCKIP+mzZXCMXEFlJ3ydIO2xt/cEcWYq6tlAWVbm2bBrzJzRx/UJ1BP/rUYezJ4DrGUy6/ZIZUN6UTBgeNSg0nblRjKKPvIT7gsc0aodmWCVY/C/coFdULfa9j6flnwB+u27rWUBO/WWu06jEC7iwa74mZB55NbG0iaov2qsewcFMrMu/P+FrcBhyUNb62XcIu6XUP/c213XvOjfW1SLQ6H8sySAJruFsSfMjm/QodXGc3P4DEarnonZEeeimO5lrHrD0AVWbSEwSvN0d67QIefhATe4WtQ6pranC8FPrwKRKvkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from BN8PR12CA0020.namprd12.prod.outlook.com (2603:10b6:408:60::33)
 by BY5PR12MB4321.namprd12.prod.outlook.com (2603:10b6:a03:204::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.20; Wed, 13 Nov
 2019 22:45:30 +0000
Received: from CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::209) by BN8PR12CA0020.outlook.office365.com
 (2603:10b6:408:60::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2451.23 via Frontend
 Transport; Wed, 13 Nov 2019 22:45:30 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT043.mail.protection.outlook.com (10.13.174.193) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2451.23 via Frontend Transport; Wed, 13 Nov 2019 22:45:30 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 13 Nov
 2019 16:45:29 -0600
Received: from agrodzovsky-All-Series.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Wed, 13 Nov 2019 16:45:28 -0600
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: Reserve bad pages after ASIC was reset.
Date: Wed, 13 Nov 2019 17:45:25 -0500
Message-ID: <1573685125-2335-2-git-send-email-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1573685125-2335-1-git-send-email-andrey.grodzovsky@amd.com>
References: <1573685125-2335-1-git-send-email-andrey.grodzovsky@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(396003)(136003)(39860400002)(428003)(189003)(199004)(186003)(50226002)(478600001)(5660300002)(76176011)(70586007)(50466002)(81166006)(44832011)(36756003)(81156014)(8676002)(26005)(48376002)(8936002)(4744005)(51416003)(70206006)(53416004)(4326008)(336012)(7696005)(305945005)(2351001)(426003)(476003)(11346002)(54906003)(2906002)(126002)(2616005)(356004)(446003)(6666004)(16586007)(316002)(6916009)(86362001)(486006)(47776003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BY5PR12MB4321; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c29afdc-997a-42a2-bc4c-08d7688b2f8d
X-MS-TrafficTypeDiagnostic: BY5PR12MB4321:
X-Microsoft-Antispam-PRVS: <BY5PR12MB4321F5B3AA2728A603D95ACDEA760@BY5PR12MB4321.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-Forefront-PRVS: 0220D4B98D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lzl35NoL/WscsbYiv4Ifb7PzIhLZb3VkrdPzf9BAXYlTqli68nMNNTbY5YcaIUaRPy8lkfZLatvMWt4Y1hCPL7Sh0nPpEmHhftcllmEsXEpaTCf9sCvyYGRTRik/0CbHABDRSv+DRDCEEHNcQuhFKbdaAUsDsmDmFnlRn3c//ompYqM+7IeSqdvRGDxKLPmdjbZ11awDqieGJKVo0ylrIfZGAUnVD8piWDSOn0Y11zb/Ury1cSIMFwVe7HaJq70jPpDtxex++5U/xbYGkeqvTaqVvLCiPyiqoQcTumzMgxx6wKEqy5VLGbAp4SiE9FY73g3I9ac0zzqXkm2ShEW/mFXGpmA4Z+EbfahotfsyDg/NWPv/Z42euagzhMqSA7bXBm3mqW3fr3iU1Ru4HRFkvecJsvDcXr9hJYHIr3EpKf+caYpUnXAdIJudb8leNz9a
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2019 22:45:30.2201 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c29afdc-997a-42a2-bc4c-08d7688b2f8d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4321
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lNkzdIwFnk77wacJ/nUIQMpYqmWmaaHUEeMFbHb5LEE=;
 b=fspsOmxNwNgT4B4SP570QgEMXiGaV0aeob0A/yBHAeHOf3OIW2HO7Tg7Cn0JegV/PWX0xvGvmcRE48VWdgpBAQgdYvqZE6QPdN3XYYEcqVvc0GThSoXGNnoPmB0rm3j6/YvTYKU8gXJe7nc8u8tWwyP18HibBYDiLJiMoqckyWM=
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
Cc: alexdeucher@gmail.com, Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 guchun.chen@amd.com, Hawking.Zhang@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191113224525.h8v8wqr686ie8eO-cestjBh_1vjY5RU6RaTYPUp3agg@z>

UHJvYmxlbToKVGhlcmUgaXMgbm8gcG9pbnQgdG8gcmVzZXJ2ZSBiYWQgcGFnZXMgYmVmb3JlIEdQ
VSByZXNldCBhcwppdCB3YXMgZG9uZSB1bnRpbGwgbm93IHNpbmNlIHdlIG5lZWQgdG8gZG8gaXQg
YWZ0ZXIgQVNJQyB3YXMKcmVzZXQgYXMgd2UgbG9zZSBhbGwgcmVzZXJ2YXRpb24gZHVyaW5nIEFT
SUMgcmVzZXQuCgpGaXg6CkNhbGwgYW1kZ3B1X3Jhc19yZXNlcnZlX2JhZF9wYWdlcyBhZnRlciBB
U0lDIGlzIHJlc2V0IGFuZCBub3QgYmVmb3JlLgoKU2lnbmVkLW9mZi1ieTogQW5kcmV5IEdyb2R6
b3Zza3kgPGFuZHJleS5ncm9kem92c2t5QGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jIHwgNCArKysrCiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNl
cnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2RldmljZS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jCmlu
ZGV4IGYyZmVmZjQuLmVhYWMyYjcgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9kZXZpY2UuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfZGV2aWNlLmMKQEAgLTM4MDQsNiArMzgwNCwxMCBAQCBzdGF0aWMgaW50IGFtZGdwdV9kb19h
c2ljX3Jlc2V0KHN0cnVjdCBhbWRncHVfaGl2ZV9pbmZvICpoaXZlLAogCQkJCQkJYnJlYWs7CiAJ
CQkJfQogCQkJfQorCisJCQkvKiBNYXJrIHZyYW0gcGFnZXMgd2l0aCBlcnJvcnMgYXMgYmFkIGFm
dGVyIEFTSUMgd2FzIHJlc2V0ICovCisJCQlsaXN0X2Zvcl9lYWNoX2VudHJ5KHRtcF9hZGV2LCBk
ZXZpY2VfbGlzdF9oYW5kbGUsIGdtYy54Z21pLmhlYWQpCisJCQkgICAgICAgYW1kZ3B1X3Jhc19y
ZXNlcnZlX2JhZF9wYWdlcyh0bXBfYWRldik7CiAJCX0KIAl9CiAKLS0gCjIuNy40CgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcg
bGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
