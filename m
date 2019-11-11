Return-Path: <SRS0=+iNy=ZD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7434C43331
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Nov 2019 04:44:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BB1720869
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Nov 2019 04:44:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BB1720869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7970A6E841;
	Mon, 11 Nov 2019 04:44:13 +0000 (UTC)
Received: from NAM03-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr790041.outbound.protection.outlook.com [40.107.79.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F37CE6E183
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Nov 2019 04:44:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mlsf2BFF2LdIvK5K6YDHzPyTjztlsTRIUR7carCoRAmSbZRSxPYOvS8FzmI9TjLHRGXGUfj6X5wcMGD7J2FP9XWPbXMBv9nWuGt2Ov8okcRHRDjcxpFb7O9a4Npke7BQPLYQxzjAug6NEZ/9kqfSdwzDKAEazwUXyl4QRjvKZg2LQt0eVIWmAYIG2JYsEQ0XzN5O/XQSpGSkUbXZAuPb2zY3Dasg0X5nJSnpZcpN5xFv4R2x5uQVcsh3Gn7R2IZ5olVdhVpSnt6W0iEeAx1FvnRE/m0s6rrqQjKUGrhjryvO57DaDKsz5TC9PZAfwW71tUYUJWFPSr7fCgUnyDSZ3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YVl83OtmDs+61Fb4W7eHFSTB/amE1JPUi0MBhm9VU9Q=;
 b=POcafGW8SdO71i5pPciXp9EjZw1+Ali0oMTAmYz+R+lvpY5BSmuklt3m/nQVD315iUsLkuzbvyfLwDfOoeihhoykDvn2n3qL4gsgL1us/81LPUBqLihhdEGpyEDNwCf3HBOlipZ7vlxE5SKCNaz1EhFyoOoYY2w6j8I/KN5tGq/5OoT3l69XVySSHZMgl1nwpGhN716qqCkiL+tT1f0RCtCVluzS4E/asEhyNec2MRWmEOJnYb/ZoN8ydZtRcr55hnvvJjoo7s35jm/Kv8mILLXfOw1+7z7PnqZ4gcGMfXFYrD+d23JHvF+u8l57eVri0Ba5eX1hMys13TDt2o7maw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from CY4PR12CA0028.namprd12.prod.outlook.com (2603:10b6:903:129::14)
 by MWHPR12MB1518.namprd12.prod.outlook.com (2603:10b6:301:11::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.20; Mon, 11 Nov
 2019 04:44:07 +0000
Received: from CO1NAM03FT060.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e48::202) by CY4PR12CA0028.outlook.office365.com
 (2603:10b6:903:129::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.22 via Frontend
 Transport; Mon, 11 Nov 2019 04:44:07 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM03FT060.mail.protection.outlook.com (10.152.81.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2430.20 via Frontend Transport; Mon, 11 Nov 2019 04:44:07 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sun, 10 Nov
 2019 22:44:06 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sun, 10 Nov
 2019 22:44:05 -0600
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Sun, 10 Nov 2019 22:44:04 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>, 
 John Clements <john.clements@amd.com>, Le Ma <Le.Ma@amd.com>
Subject: [PATCH] drm/amdgpu: avoid upload corrupted ta ucode to psp
Date: Mon, 11 Nov 2019 12:44:02 +0800
Message-ID: <20191111044402.11408-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(376002)(396003)(136003)(39860400002)(428003)(199004)(189003)(478600001)(51416003)(7696005)(47776003)(6636002)(356004)(50466002)(8676002)(426003)(50226002)(53416004)(336012)(486006)(476003)(2616005)(5660300002)(36756003)(126002)(8936002)(2906002)(186003)(26005)(70206006)(70586007)(110136005)(1076003)(81166006)(81156014)(4326008)(316002)(86362001)(16586007)(305945005)(14444005)(48376002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR12MB1518; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f1e1c827-369d-45e1-5b53-08d76661c97c
X-MS-TrafficTypeDiagnostic: MWHPR12MB1518:
X-Microsoft-Antispam-PRVS: <MWHPR12MB151822BEA653E08A414854A6FC740@MWHPR12MB1518.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0218A015FA
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fKORt7fxWcPwCErPJjMPgSBLkYj5Aj5fgryGU3CDvy0Uoy2VuE1uAOZesSajowMQK8ohIJcakGuy/vO+Cg6v/e7mqjlEErjtk47+zhsVMEaUIbFRlVGHULhqze/cnEwhEKh3oFzO884RcMr3sqTA+1u4GeKDOKaMknQc2SecEUp0CKAJXHDvhp/itGC0A38SUYE6T1hd4AZzOj7H1eZZOIYUOCSdqIvpKqJyX8o52RMM6vouf9edFslJJF1nQz3n8zxSKDASQ43jiH8+4+RnOjXG94ByGEPrxcmsUiua1KosujAx1qzfZo5yTCeEDXT62Kv9I3Oxf5sWxnye78euvMJ1DUmDEaO17R5N8zwAsYBywiICdh/AfdUF9pr6X3tZ9ap6Z1JXAkx5FUbJiWsWwFb9AvOGmzz2/slbkWZSMG9WOwb1z5g0xDJB4ANFzgyg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2019 04:44:07.2874 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1e1c827-369d-45e1-5b53-08d76661c97c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1518
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YVl83OtmDs+61Fb4W7eHFSTB/amE1JPUi0MBhm9VU9Q=;
 b=z9xvaIlNDUljk0kgd2jB7N0EASPQkPkUdQ78T+fRViRATI8iHo8K/7tsY8dVjegThg66dZ1wZ/oow1CShpuTd++46YwGKGqerC6ZET+R9yX+mHnbzP5TedrGSGkBfO05N1eDogioyyfVNCJD5htC+DCgtaKjqm6pJQUXkAzD2Sc=
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
Message-ID: <20191111044402.Ufx4QQ2seiNI64Sd7OzQJ_HW7PJUp_omasqVRB7r6DE@z>

eGdtaSwgcmFzLCBoZGNwIGFuZCBkdG0gdGEgYXJlIGFjdHVhbGx5IHNlcGFyYXRlZCB1Y29kZSBh
bmQKbmVlZCB0byBoYW5kbGVkIGNhc2UgYnkgY2FzZSB0byB1cGxvYWQgdG8gcHNwLgoKV2Ugc3Vw
cG9ydCB0aGUgY2FzZSB0aGF0IHRhIGJpbmFyeSBoYXZlIG9uZSBvciBtdWx0aXBsZSBvZgp0aGVt
IGJ1aWx0LWluLiBBcyBhIHJlc3VsdCwgdGhlIGRyaXZlciBzaG91bGQgY2hlY2sgZWFjaCB0YQpi
aW5hcml5J3MgYXZhaWxhYmxpdHkgYmVmb3JlIGRlY2lkZSB0byB1cGxvYWQgdGhlbSB0byBwc3Au
CgpJbiB0aGUgdGVybWluYXRlICh1bmxvYWQpIGNhc2UsIHRoZSBkcml2ZXIgd2lsbCBjaGVjayB0
aGUKY29udGV4dCByZWFkaW5lc3MgYmVmb3JlIHBlcmZvcm0gdW5sb2FkIGFjdGl2aXR5LiBJdCdz
IGZpbmUKdG8ga2VlcCBpdCBhcyBpcy4KCkNoYW5nZS1JZDogSTQ5MzExNjk3MGZmYjU1N2YzM2Mw
NmRlMTBmNzg2Njg0ZmRjZWY4NWIKU2lnbmVkLW9mZi1ieTogSGF3a2luZyBaaGFuZyA8SGF3a2lu
Zy5aaGFuZ0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9w
c3AuYyB8IDIyICsrKysrKysrKysrKysrKysrKysrKy0KIDEgZmlsZSBjaGFuZ2VkLCAyMSBpbnNl
cnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X3BzcC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3BzcC5jCmluZGV4IDQ1NmFjMDRiMjQ2Yy4uOTYyMWUyMDdhOWNhIDEwMDY0NAotLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMKKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5jCkBAIC01NTgsNyArNTU4LDkgQEAgc3RhdGljIGludCBw
c3BfeGdtaV9pbml0aWFsaXplKHN0cnVjdCBwc3BfY29udGV4dCAqcHNwKQogCXN0cnVjdCB0YV94
Z21pX3NoYXJlZF9tZW1vcnkgKnhnbWlfY21kOwogCWludCByZXQ7CiAKLQlpZiAoIXBzcC0+YWRl
di0+cHNwLnRhX2Z3KQorCWlmICghcHNwLT5hZGV2LT5wc3AudGFfZncgfHwKKwkgICAgIXBzcC0+
YWRldi0+cHNwLnRhX3hnbWlfdWNvZGVfc2l6ZSB8fAorCSAgICAhcHNwLT5hZGV2LT5wc3AudGFf
eGdtaV9zdGFydF9hZGRyKQogCQlyZXR1cm4gLUVOT0VOVDsKIAogCWlmICghcHNwLT54Z21pX2Nv
bnRleHQuaW5pdGlhbGl6ZWQpIHsKQEAgLTc2OCw2ICs3NzAsMTIgQEAgc3RhdGljIGludCBwc3Bf
cmFzX2luaXRpYWxpemUoc3RydWN0IHBzcF9jb250ZXh0ICpwc3ApCiB7CiAJaW50IHJldDsKIAor
CWlmICghcHNwLT5hZGV2LT5wc3AudGFfcmFzX3Vjb2RlX3NpemUgfHwKKwkgICAgIXBzcC0+YWRl
di0+cHNwLnRhX3Jhc19zdGFydF9hZGRyKSB7CisJCWRldl93YXJuKHBzcC0+YWRldi0+ZGV2LCAi
UkFTOiByYXMgdGEgdWNvZGUgaXMgbm90IGF2YWlsYWJsZVxuIik7CisJCXJldHVybiAwOworCX0K
KwogCWlmICghcHNwLT5yYXMucmFzX2luaXRpYWxpemVkKSB7CiAJCXJldCA9IHBzcF9yYXNfaW5p
dF9zaGFyZWRfYnVmKHBzcCk7CiAJCWlmIChyZXQpCkBAIC04NTcsNiArODY1LDEyIEBAIHN0YXRp
YyBpbnQgcHNwX2hkY3BfaW5pdGlhbGl6ZShzdHJ1Y3QgcHNwX2NvbnRleHQgKnBzcCkKIHsKIAlp
bnQgcmV0OwogCisJaWYgKCFwc3AtPmFkZXYtPnBzcC50YV9oZGNwX3Vjb2RlX3NpemUgfHwKKwkg
ICAgIXBzcC0+YWRldi0+cHNwLnRhX2hkY3Bfc3RhcnRfYWRkcikgeworCQlkZXZfd2Fybihwc3At
PmFkZXYtPmRldiwgIkhEQ1A6IGhkY3AgdGEgdWNvZGUgaXMgbm90IGF2YWlsYWJsZVxuIik7CisJ
CXJldHVybiAwOworCX0KKwogCWlmICghcHNwLT5oZGNwX2NvbnRleHQuaGRjcF9pbml0aWFsaXpl
ZCkgewogCQlyZXQgPSBwc3BfaGRjcF9pbml0X3NoYXJlZF9idWYocHNwKTsKIAkJaWYgKHJldCkK
QEAgLTEwMzAsNiArMTA0NCwxMiBAQCBzdGF0aWMgaW50IHBzcF9kdG1faW5pdGlhbGl6ZShzdHJ1
Y3QgcHNwX2NvbnRleHQgKnBzcCkKIHsKIAlpbnQgcmV0OwogCisJaWYgKCFwc3AtPmFkZXYtPnBz
cC50YV9kdG1fdWNvZGVfc2l6ZSB8fAorCSAgICAhcHNwLT5hZGV2LT5wc3AudGFfZHRtX3N0YXJ0
X2FkZHIpIHsKKwkJZGV2X3dhcm4ocHNwLT5hZGV2LT5kZXYsICJEVE06IGR0bSB0YSB1Y29kZSBp
cyBub3QgYXZhaWxhYmxlXG4iKTsKKwkJcmV0dXJuIDA7CisJfQorCiAJaWYgKCFwc3AtPmR0bV9j
b250ZXh0LmR0bV9pbml0aWFsaXplZCkgewogCQlyZXQgPSBwc3BfZHRtX2luaXRfc2hhcmVkX2J1
Zihwc3ApOwogCQlpZiAocmV0KQotLSAKMi4xNy4xCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2FtZC1nZng=
