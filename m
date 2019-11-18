Return-Path: <SRS0=5Use=ZK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07FC3C432C3
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Nov 2019 09:20:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D943F20692
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Nov 2019 09:20:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D943F20692
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB83889DA5;
	Mon, 18 Nov 2019 09:20:45 +0000 (UTC)
Received: from NAM03-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr790049.outbound.protection.outlook.com [40.107.79.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2537E89DA5
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Nov 2019 09:20:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l0Xy39zfKoxHmpP72Bn2R8QRP/d1oxLw829YjXjLne4KWMQ07dnwL5/S5Klnfl3V/G8mL25sGGvsPL7p52MnKaU6R8wb97mrXVgnq67ikBVh05Yu6NeeRMLj5VsFaSibVP+Pik2qoCJYpeqYX4JZTvKLOQUt9Qads6udOLppYcvPfk8kI6RiMUUnHTprlL4z0j8TZU2ds8YWMhMzGEPYTkkszRKXiT4+pjeIzL9YMBN6s2BAba3vLRPd8dMRNT9MAkVMWOFaEdPUVdYNhK3t03FG48U/XrJr/DcG9CLCYpRagzN87EcR7CsXoMsl6xHM1LfQLyVWJ+C4le1IvDGU8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jOvlacOIw30U8R6hXDOMdnyMH2cHTFytH7b2WFva1tk=;
 b=IQsp6HRcB1YdhnYxxBDPSXfl3cmVDr9Lti578DGh4S5pKBm0tPvKKPKu1urysB69R7wm4tJKigLnTN1xZrBUpzml3EEbew5ZXWFMrxmdVWTYZkquLP4QEgfvYZLbnHrXV2BAKJV4MlKvtD5dnCqvd1lwM6SNWF1NyJIiPUq984mesyhQ/c8L1rlcA3HK7ir3uDQcXsyKv+KzjeGaCWELufPYYDG4TwgwwOeSnoqJblqzeXlo1+vY41IBSRUxW5z32ok31u4Ssbr4VjTfKLiQWO1decEed8//r2lol9k17XxuMO3mE9GXbXOQYAlipGyHPod+ovlgPJNwGygXw80Uaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB4191.namprd12.prod.outlook.com (52.135.48.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.26; Mon, 18 Nov 2019 09:20:42 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::5895:bbd8:c1d6:1587]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::5895:bbd8:c1d6:1587%7]) with mapi id 15.20.2451.029; Mon, 18 Nov 2019
 09:20:42 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amd/powerplay: correct swSMU baco reset related
 settings
Date: Mon, 18 Nov 2019 17:20:18 +0800
Message-Id: <20191118092019.11127-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.24.0
X-ClientProxiedBy: HK2PR0401CA0006.apcprd04.prod.outlook.com
 (2603:1096:202:2::16) To MN2PR12MB3344.namprd12.prod.outlook.com
 (2603:10b6:208:c5::10)
MIME-Version: 1.0
X-Mailer: git-send-email 2.24.0
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 878fe127-c50f-4d58-85cf-08d76c089568
X-MS-TrafficTypeDiagnostic: MN2PR12MB4191:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB41916AAA96BC697A7D5B7B50E44D0@MN2PR12MB4191.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-Forefront-PRVS: 0225B0D5BC
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(376002)(136003)(396003)(366004)(346002)(199004)(189003)(36756003)(8676002)(486006)(99286004)(5660300002)(52116002)(14444005)(81156014)(81166006)(476003)(316002)(6506007)(386003)(478600001)(2616005)(14454004)(66556008)(66476007)(6916009)(86362001)(66946007)(6486002)(44832011)(25786009)(2870700001)(50466002)(2906002)(2361001)(8936002)(50226002)(6436002)(51416003)(6512007)(305945005)(1076003)(4326008)(6116002)(48376002)(26005)(3846002)(186003)(47776003)(2351001)(7736002)(6666004)(66066001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4191;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WpWqoHMCBVY/vS27JNDp3rSeo26wYAIu/jWK1pBSw2qBXS+UR3ckOyDagrZuWcczYvPyrHs08sSqbe2PJKVGMnSNJJKj72Y6csxgCbuSTKUG1mK7eJLf4Cux0EhBLhpKQi4RCZQPqEKArzltdp5I7Qaz2VBInymGQ7VmT5uK5jaYmLOIvQ3iHk3kKIwY7VQ8xzk0ugxYu85c/9TTE9Q5C9RoAr/HoPDXIpDAo97mqPd4e2nVAT9lEX+ctMq6TKiMs1PhWblDaoCOIB9yYfBqlzPhMD1HLmhnuegZ+KNeZHhbIa9jMtJJOu0E3FJq6UWCgjOZpH+uo+V4c0Vnze5ss8DswRO99ZSNhIyA+G9vIDFRWvrwsP9MaOrU8Ec4YcafkEe7rDolsSANacW+y0tjGVV/dorRn7vwpF+4ACcSqso8Gyj4TnF/M2qpquJ6V08+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 878fe127-c50f-4d58-85cf-08d76c089568
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2019 09:20:42.1945 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kOnOUSwKwMusT5o/5YId/cWBcBezZIkHsq+6CZ5tOpCzMulCMMfaOhCKs6Mnqpu6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4191
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jOvlacOIw30U8R6hXDOMdnyMH2cHTFytH7b2WFva1tk=;
 b=gKKKz2wMM2/rCD1yF8kmgUSTPaIh+ylFF6s1W64JVDiFD4Mg9MQAln+ADy7L91I4toAOdYpRDG0ayNDMjyiFowtupum2bpzWzCdy/W8YSmlHinmIL/2hpAeP9fRFtfsr/ITZSsldTKSdT0b0sltujSNyEt/Rv0I7CjQ29u71n/Q=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
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
Cc: Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191118092018.jqxvqc58VFQwN8bIyBoavELT3oqfkRBU_ZLb5_McnMI@z>

QWRkZWQgYmlmIGRvb3JiZWxsIGludGVycnVwdCBzZXR0aW5nIGFuZCBhcHBsaWVkIGRpZmZlcmVu
dApzZXR0aW5ncyBmb3IgQkFDTyByZXNldCBmb3IgUkFTIHJlY292ZXJ5LgoKQ2hhbmdlLUlkOiBJ
ODIzYjJkNDc4Njk5ZDQ2OWVjYzc3NDZlMmE4ZmIxMTEwYTRhMTQ2ZgpTaWduZWQtb2ZmLWJ5OiBF
dmFuIFF1YW4gPGV2YW4ucXVhbkBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG93
ZXJwbGF5L3NtdV92MTFfMC5jIHwgMzAgKysrKysrKysrKysrKysrKysrKystLS0KIDEgZmlsZSBj
aGFuZ2VkLCAyNyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L3NtdV92MTFfMC5jIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9wb3dlcnBsYXkvc211X3YxMV8wLmMKaW5kZXggOTI4ODc3ZjczZGZkLi43MWUyYmJlMjVj
ZjYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L3NtdV92MTFfMC5j
CisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L3NtdV92MTFfMC5jCkBAIC0xNjY3
LDYgKzE2NjcsMTAgQEAgaW50IHNtdV92MTFfMF9iYWNvX3NldF9zdGF0ZShzdHJ1Y3Qgc211X2Nv
bnRleHQgKnNtdSwgZW51bSBzbXVfYmFjb19zdGF0ZSBzdGF0ZSkKIHsKIAogCXN0cnVjdCBzbXVf
YmFjb19jb250ZXh0ICpzbXVfYmFjbyA9ICZzbXUtPnNtdV9iYWNvOworCXN0cnVjdCBhbWRncHVf
ZGV2aWNlICphZGV2ID0gc211LT5hZGV2OworCXN0cnVjdCBhbWRncHVfcmFzICpyYXMgPSBhbWRn
cHVfcmFzX2dldF9jb250ZXh0KGFkZXYpOworCXVpbnQzMl90IGJpZl9kb29yYmVsbF9pbnRyX2Nu
dGw7CisJdWludDMyX3QgZGF0YTsKIAlpbnQgcmV0ID0gMDsKIAogCWlmIChzbXVfdjExXzBfYmFj
b19nZXRfc3RhdGUoc211KSA9PSBzdGF0ZSkKQEAgLTE2NzQsMTAgKzE2NzgsMzAgQEAgaW50IHNt
dV92MTFfMF9iYWNvX3NldF9zdGF0ZShzdHJ1Y3Qgc211X2NvbnRleHQgKnNtdSwgZW51bSBzbXVf
YmFjb19zdGF0ZSBzdGF0ZSkKIAogCW11dGV4X2xvY2soJnNtdV9iYWNvLT5tdXRleCk7CiAKLQlp
ZiAoc3RhdGUgPT0gU01VX0JBQ09fU1RBVEVfRU5URVIpCi0JCXJldCA9IHNtdV9zZW5kX3NtY19t
c2dfd2l0aF9wYXJhbShzbXUsIFNNVV9NU0dfRW50ZXJCYWNvLCBCQUNPX1NFUV9CQUNPKTsKLQll
bHNlCisJYmlmX2Rvb3JiZWxsX2ludHJfY250bCA9IFJSRUczMl9TT0MxNShOQklPLCAwLCBtbUJJ
Rl9ET09SQkVMTF9JTlRfQ05UTCk7CisKKwlpZiAoc3RhdGUgPT0gU01VX0JBQ09fU1RBVEVfRU5U
RVIpIHsKKwkJYmlmX2Rvb3JiZWxsX2ludHJfY250bCA9IFJFR19TRVRfRklFTEQoYmlmX2Rvb3Ji
ZWxsX2ludHJfY250bCwKKwkJCQkJCUJJRl9ET09SQkVMTF9JTlRfQ05UTCwKKwkJCQkJCURPT1JC
RUxMX0lOVEVSUlVQVF9ESVNBQkxFLCAxKTsKKwkJV1JFRzMyX1NPQzE1KE5CSU8sIDAsIG1tQklG
X0RPT1JCRUxMX0lOVF9DTlRMLCBiaWZfZG9vcmJlbGxfaW50cl9jbnRsKTsKKworCQlpZiAoIXJh
cyB8fCAhcmFzLT5zdXBwb3J0ZWQpIHsKKwkJCWRhdGEgPSBSUkVHMzJfU09DMTUoVEhNLCAwLCBt
bVRITV9CQUNPX0NOVEwpOworCQkJZGF0YSB8PSAweDgwMDAwMDAwOworCQkJV1JFRzMyX1NPQzE1
KFRITSwgMCwgbW1USE1fQkFDT19DTlRMLCBkYXRhKTsKKworCQkJcmV0ID0gc211X3NlbmRfc21j
X21zZ193aXRoX3BhcmFtKHNtdSwgU01VX01TR19FbnRlckJhY28sIDApOworCQl9IGVsc2Ugewor
CQkJcmV0ID0gc211X3NlbmRfc21jX21zZ193aXRoX3BhcmFtKHNtdSwgU01VX01TR19FbnRlckJh
Y28sIDEpOworCQl9CisJfSBlbHNlIHsKIAkJcmV0ID0gc211X3NlbmRfc21jX21zZyhzbXUsIFNN
VV9NU0dfRXhpdEJhY28pOworCQliaWZfZG9vcmJlbGxfaW50cl9jbnRsID0gUkVHX1NFVF9GSUVM
RChiaWZfZG9vcmJlbGxfaW50cl9jbnRsLAorCQkJCQkJQklGX0RPT1JCRUxMX0lOVF9DTlRMLAor
CQkJCQkJRE9PUkJFTExfSU5URVJSVVBUX0RJU0FCTEUsIDApOworCQlXUkVHMzJfU09DMTUoTkJJ
TywgMCwgbW1CSUZfRE9PUkJFTExfSU5UX0NOVEwsIGJpZl9kb29yYmVsbF9pbnRyX2NudGwpOwor
CX0KIAlpZiAocmV0KQogCQlnb3RvIG91dDsKIAotLSAKMi4yNC4wCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
