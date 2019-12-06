Return-Path: <SRS0=UM6f=Z4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E51CC43603
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Dec 2019 10:26:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A09C2173E
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Dec 2019 10:26:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A09C2173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 117FF6F9B9;
	Fri,  6 Dec 2019 10:26:32 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2087.outbound.protection.outlook.com [40.107.236.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D19906F9B9
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Dec 2019 10:26:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m79mPNo2b98arxq1Ra1gPm/hmkR6X/kA1A6FIk3HHSbm1a5WIAjud4C3wboYLJsnbQDoNzk1pgyLwSCxkSlkN/BCRztzQru43PKUm4UFz7Z7H8PpF13PXCsjXYeQjf7QyivAuNmhOaD4LjQCzYEudsb0G0Jd63/KH8quA+N6ffIfXlqklPwlV3A7gARgED0xjTlCqhbK38uH3OQNrpOoZYys8TM75ZqUGRrXCcoVCzuWEF5DU8fthxzmbSgVwvieBJ+PKfyCqs8tmJNPDaHc6UmD5tqJngwQw6PKclHiESje/abWosOKBWeb2tdMfnt6tsw9fQ5TU8RSKr3PF8QZUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=20f2wEJwvuLPErk+CnDSLRXFf5mfnH/szfchr4onQHM=;
 b=n3ocIzfxQFpU7C2lMNUJcT/Cv5YALaV+bk6DH5Rxe5QssU1RYfncVY3FSTZ5+uaH9ABifMC1oacb3fbWsvthST4AvbfzObSK9BmxbWz1fGdcBjHnG24EfpJdm52VJgMFrmQM+PVFHUCQqqC+htf/R6MJAj7y2elGKm7X9twSRiy7EA4IxbPnI0NtKVlgamdQB4bYMpx5FaUoUcgWVdnuhrG63tfhLPDmDik9KmZbxVyMQMYT79rpUROzCt0uA8p3oUQ0hI0xxXRJrC3FOdPIMcPnNFdqLRc7vDpSsoer5FjCpNNlL+9QEg+GsfiHDOcKpy720bL2uhG63gFHWoDa8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from DM5PR12CA0024.namprd12.prod.outlook.com (2603:10b6:4:1::34) by
 BYAPR12MB3175.namprd12.prod.outlook.com (2603:10b6:a03:13a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.13; Fri, 6 Dec
 2019 10:12:09 +0000
Received: from DM6NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eaa::203) by DM5PR12CA0024.outlook.office365.com
 (2603:10b6:4:1::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.12 via Frontend
 Transport; Fri, 6 Dec 2019 10:12:09 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT019.mail.protection.outlook.com (10.13.172.172) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2451.23 via Frontend Transport; Fri, 6 Dec 2019 10:12:09 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 6 Dec 2019
 04:12:08 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 6 Dec 2019
 04:12:08 -0600
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Fri, 6 Dec 2019 04:12:06 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Le Ma <Le.Ma@amd.com>, John Clements
 <John.clements@amd.com>, Alex Deucher <alexander.deucher@amd.com>, "Guchun
 Chen" <Guchun.Chen@amd.com>
Subject: [PATCH] drm/amdgpu: fix resume failures due to psp fw loading
 sequence change (v3)
Date: Fri, 6 Dec 2019 18:12:04 +0800
Message-ID: <20191206101204.5374-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(136003)(376002)(346002)(396003)(428003)(199004)(189003)(356004)(478600001)(50466002)(305945005)(48376002)(70586007)(86362001)(36756003)(5660300002)(8676002)(2906002)(16586007)(7696005)(81166006)(81156014)(50226002)(14444005)(70206006)(53416004)(110136005)(186003)(51416003)(8936002)(316002)(26005)(1076003)(4326008)(2616005)(6636002)(426003)(336012);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3175; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 63144852-201f-41b6-c2be-08d77a34c0fe
X-MS-TrafficTypeDiagnostic: BYAPR12MB3175:
X-Microsoft-Antispam-PRVS: <BYAPR12MB31753107F33C32889147888AFC5F0@BYAPR12MB3175.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 0243E5FD68
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6mnfEF4Ih9pP8NOIVccoCOlguyT6OygG2CVCE6apKVvSh6y7YU0YnN6jVbPzmTjKcMIt9Pf+67QcsfqJ8ddVSWmJsPSS+L2b4Msszs+eRkD4yBYuZWRrbOqp6m3TVKscXiD3afHtXujFRvtM+l+RHea+MCZiqrM/+fwm+Eg41nq83EW8JVMLOAOepOQxKIvtVLG+g1t0L7pbGkmj7Io55ZY4AX8WnYtBj8mKIKjpTebLAj95E5IZyiWkYjbJIaKf7twH3A+uprIMMKG4O26KeNzEc+sY3CH6D+KutgvTjZkeHl02JRFKI3g2IgEcKxWoTPn9YGRp76iiQOSJo7muO6mBRBjez8U0WKsB+AcG7luHOVZ6j3fBELgIgrLConNYjuxwrDZ1kyw5jabi4S1J+gUo1LyVJOPQgzx2yRPz5npv1G+S+CxTEx8t6lRRjmKE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2019 10:12:09.0203 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63144852-201f-41b6-c2be-08d77a34c0fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3175
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=20f2wEJwvuLPErk+CnDSLRXFf5mfnH/szfchr4onQHM=;
 b=cH+pC2f4dOf+MY4lQpVgGgl49OliXtWj6CFuQR24dJ3bUrdKoE3cLZ0vZG+WkxJ/fnf/R7mtTOTIg1jSmQtUp1IShEpol1/2NFdRh1qKwK9QTwrUN7j0iZSOBcQ9ue5nJFbLaF9FzVTEfYHpeH9Ki/OOXSRU1nX5bsl2WC2oB1I=
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
CmFkanVzdG1lbnQgcmVjZW50bHkuIGFzZC90YSBsb2FkaW5nIHdhcyBtb3ZlIG91dCBmcm9tCmh3
X3N0YXJ0IGFuZCBzaG91bGQgYWxzbyBiZSBhcHBsaWVkIHRvIHBzcF9yZXN1bWUuCm90aGVyd2lz
ZSB0aG9zZSBmdyBsb2FkaW5nIHdpbGwgYmUgaWdub3JlZCBpbiByZXN1bWUgcGhhc2UuCgp2Mjog
YWRkIHRoZSBtdXRleCB1bmxvY2sgZm9yIGFzZCBsb2FkaW5nIGZhaWx1cmUgY2FzZQp2MzogbWVy
Z2UgdGhlIGVycm9yIGhhbmRsaW5nIHRvIGZhaWxlZCB0YWcKCkNoYW5nZS1JZDogSTIwZDM2NTFm
MzI1ZTc5M2UxZWE3ZTczZGYxYzc2MjE5ZWFhMGI1YWIKU2lnbmVkLW9mZi1ieTogSGF3a2luZyBa
aGFuZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9wc3AuYyB8IDMzICsrKysrKysrKysrKysrKysrKysrKysrKysKIDEgZmlsZSBj
aGFuZ2VkLCAzMyBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X3BzcC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3BzcC5jCmluZGV4IGNlZWE4MzE0ZDg4ZC4uMmRmZGE1NTkwZTc3IDEwMDY0NAotLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMKKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5jCkBAIC0xNzAyLDYgKzE3MDIsMzkgQEAgc3RhdGljIGlu
dCBwc3BfcmVzdW1lKHZvaWQgKmhhbmRsZSkKIAlpZiAocmV0KQogCQlnb3RvIGZhaWxlZDsKIAor
CXJldCA9IHBzcF9hc2RfbG9hZChwc3ApOworCWlmIChyZXQpIHsKKwkJRFJNX0VSUk9SKCJQU1Ag
bG9hZCBhc2QgZmFpbGVkIVxuIik7CisJCWdvdG8gZmFpbGVkOworCX0KKworCWlmIChhZGV2LT5n
bWMueGdtaS5udW1fcGh5c2ljYWxfbm9kZXMgPiAxKSB7CisJCXJldCA9IHBzcF94Z21pX2luaXRp
YWxpemUocHNwKTsKKwkJLyogV2FybmluZyB0aGUgWEdNSSBzZWVzaW9uIGluaXRpYWxpemUgZmFp
bHVyZQorCQkgKiBJbnN0ZWFkIG9mIHN0b3AgZHJpdmVyIGluaXRpYWxpemF0aW9uCisJCSAqLwor
CQlpZiAocmV0KQorCQkJZGV2X2Vycihwc3AtPmFkZXYtPmRldiwKKwkJCQkiWEdNSTogRmFpbGVk
IHRvIGluaXRpYWxpemUgWEdNSSBzZXNzaW9uXG4iKTsKKwl9CisKKwlpZiAocHNwLT5hZGV2LT5w
c3AudGFfZncpIHsKKwkJcmV0ID0gcHNwX3Jhc19pbml0aWFsaXplKHBzcCk7CisJCWlmIChyZXQp
CisJCQlkZXZfZXJyKHBzcC0+YWRldi0+ZGV2LAorCQkJCQkiUkFTOiBGYWlsZWQgdG8gaW5pdGlh
bGl6ZSBSQVNcbiIpOworCisJCXJldCA9IHBzcF9oZGNwX2luaXRpYWxpemUocHNwKTsKKwkJaWYg
KHJldCkKKwkJCWRldl9lcnIocHNwLT5hZGV2LT5kZXYsCisJCQkJIkhEQ1A6IEZhaWxlZCB0byBp
bml0aWFsaXplIEhEQ1BcbiIpOworCisJCXJldCA9IHBzcF9kdG1faW5pdGlhbGl6ZShwc3ApOwor
CQlpZiAocmV0KQorCQkJZGV2X2Vycihwc3AtPmFkZXYtPmRldiwKKwkJCQkiRFRNOiBGYWlsZWQg
dG8gaW5pdGlhbGl6ZSBEVE1cbiIpOworCX0KKwogCW11dGV4X3VubG9jaygmYWRldi0+ZmlybXdh
cmUubXV0ZXgpOwogCiAJcmV0dXJuIDA7Ci0tIAoyLjE3LjEKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vYW1kLWdmeA==
