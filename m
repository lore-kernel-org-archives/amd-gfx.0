Return-Path: <SRS0=U5eA=Y5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F25C010A2
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2019 10:23:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B938B217F5
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2019 10:23:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B938B217F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B9946E9B7;
	Tue,  5 Nov 2019 10:23:38 +0000 (UTC)
Received: from NAM01-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr740044.outbound.protection.outlook.com [40.107.74.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F26C66E9B7
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Nov 2019 10:23:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rbbk9xNY3jLIzKCC0cGcVjy6aIu6KpUGQ7HJ0kL5CvuxRXCJ0jEPE5yQuBBMDeHSm2QlfNPZYKHr/8N1eUlvotsNESik7SSllXyiVVsgfYh3YNj9a3WzS6qcAF+1MSkw5NliTpTuCLHFmpMDntfo3ndC/4R6StNQigFJuCjxf5nFFrP8TOzYH7bV/G/gyx9tPgJTQqm7vs/RLHDzHB4I/9iCVAxGctCZRxMbLVolHVjF4E7NAr8xdpOl6+fqZgRH2cTuSXRpKm1g7dqzG+dMRJIVGUWlxozjwNvcg+8gbUyjC2ESC6pfLLINHtUm8CYy9eeYPEzr1R3VARtQ0y79yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dl6DHUN5Oww0d3HDwd2ZGS6XE96rRnnNYt2AD65yHXI=;
 b=WLEstXJhosoyhrifxVwxTBZvomr80PN92vvRJtmkW6d9T5bZZFp3BGr4qJWj669oMYui9C3Li5jIO0iB/LF4qRTFfC+peRIpmQhYMYqIiz3sZTC1cD9FvJyTsrRUORK+dgYRD91O0JcI28BF7IuL9DV3zgU0SE6jiSlVOF3bMDxgX4iTd29YvdTN2lyfIu0RsFYqqRdS1VRebyAD1yFwsY6kVdEBJR+yBERInitT1nmP9yxp8OvJnnQDjqVdRRRxyA/HfGKCyMjGCLjL50rCOeuJZk2hcXWV9Ho66GbG7rwwPVX+E6DXE0dmSBtNaGKvvKzE+KzscwsFySo4Grw1kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB3342.namprd12.prod.outlook.com (20.178.240.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Tue, 5 Nov 2019 10:23:33 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::5895:bbd8:c1d6:1587]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::5895:bbd8:c1d6:1587%7]) with mapi id 15.20.2408.024; Tue, 5 Nov 2019
 10:23:33 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: fix possible pstate switch race condition
Thread-Topic: [PATCH 1/2] drm/amdgpu: fix possible pstate switch race condition
Thread-Index: AQHVk8MTLXvuWPGEwk6y9f91X/KjuQ==
Date: Tue, 5 Nov 2019 10:23:33 +0000
Message-ID: <20191105102310.16657-1-evan.quan@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK2PR0401CA0004.apcprd04.prod.outlook.com
 (2603:1096:202:2::14) To MN2PR12MB3344.namprd12.prod.outlook.com
 (2603:10b6:208:c5::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.23.0
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 44f34ff6-93e6-4d13-6f2e-08d761da35bb
x-ms-traffictypediagnostic: MN2PR12MB3342:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB33427C6953CD3DF322CD2C52E47E0@MN2PR12MB3342.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 0212BDE3BE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(396003)(366004)(346002)(39860400002)(376002)(199004)(189003)(186003)(54906003)(26005)(2501003)(86362001)(6116002)(3846002)(64756008)(66066001)(66556008)(52116002)(6916009)(102836004)(8676002)(66476007)(305945005)(7736002)(5660300002)(8936002)(256004)(14444005)(476003)(5640700003)(14454004)(66446008)(71190400001)(50226002)(81166006)(71200400001)(2351001)(478600001)(6436002)(2616005)(2906002)(1076003)(6512007)(4326008)(6506007)(386003)(6486002)(486006)(81156014)(66946007)(25786009)(36756003)(99286004)(316002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3342;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZA6wTuWdnWTdPLgNUUY7lQzLsTI7I8zRUP5h3EFOC8hvrQdECDdhYyEIKOhljkF3uijkbrLBpZeiWuPn5aGA0RH6KQKPBkP9oOuepkQ6puAYAWk0u2fU+1rn9spV0M/d8ZmdRPk716sotWtmxxSdw6554zdM3iegiQ3y2Kml4zPz/ze2DvTvY4P0RG8kictmXOMU//YpLvJOmzD/p4TrnS4RThXHOoAldTxo6N35nz6VNnlsKCXBej0YL7QdL9JAzgM2fCMTZb/LmsPYS+ESZ1LoKOgxATxqQNR10tBRucUJq0ZJPEhMiRMvSGg0G4+UdaWXR7fq+PqLNyMB1qPjeDfItPoRix95FGRmCBk0Blwt6CU+huy5HhDX+RFo7X/S2zxLXqQUQBekj3muuEDdcqtiQaDZExMW+I6ktwf9ZOKLpuRX/1624NWp6OFOBMw3
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44f34ff6-93e6-4d13-6f2e-08d761da35bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2019 10:23:33.0584 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ePKwm3QBvRsUXpU/nz8NmIe8EFBv8/SJVN5MClX9chTT68ek9hZBeu3YahyCdOig
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3342
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dl6DHUN5Oww0d3HDwd2ZGS6XE96rRnnNYt2AD65yHXI=;
 b=eF3reSArO5TdD4Mausa/TeA0g0ju04LnC9/lJAB8q23oh+heG4iUGXNOhiI+uAmoINpyZCdIHYw3E5NoQreSuMwqBIztZjw5cdasnvdpErEz+ROc2zbudL6aEC2XfU67sCg02WTeFW5/fcWzkGnqwS1Pk/SWc32rXxFXKkCf52g=
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
Cc: "Strawbridge, Michael" <Michael.Strawbridge@amd.com>, "Kim,
 Jonathan" <Jonathan.Kim@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191105102333.mRo8wxObU8OUtn8_HdNRSnN-kq8wzhZ2Sbzm3GRW5O4@z>

QWRkZWQgbG9jayBwcm90ZWN0aW9uIHNvIHRoYXQgdGhlIHAtc3RhdGUgc3dpdGNoIHdpbGwKYmUg
Z3VhcmRlZCB0byBiZSBzZXF1ZW50aWFsLiBBbHNvIHVwZGF0ZSB0aGUgaGl2ZQpwc3RhdGUgb25s
eSBhbGwgZGV2aWNlIGZyb20gdGhlIGhpdmUgYXJlIGluIHRoZSBzYW1lCnN0YXRlLgoKQ2hhbmdl
LUlkOiBJMTY1YTZmNDRlOGFlYzFlNmRhNTZlZWZhMGZjNDlkMzY2NzBlNTZmZQpTaWduZWQtb2Zm
LWJ5OiBFdmFuIFF1YW4gPGV2YW4ucXVhbkBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdS5oICAgICAgfCAgMyArKysKIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV94Z21pLmMgfCAzNCArKysrKysrKysrKysrKysrKysrKysrLS0KIDIgZmlsZXMg
Y2hhbmdlZCwgMzUgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHUuaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdS5oCmluZGV4IDA0NjljYzUxYTZmYi4uNDFjZjJhYmQ2MjA5IDEwMDY0NAot
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHUuaAorKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHUuaApAQCAtMTA0MSw2ICsxMDQxLDkgQEAgc3RydWN0IGFt
ZGdwdV9kZXZpY2UgewogCiAJdWludDY0X3QJCQl1bmlxdWVfaWQ7CiAJdWludDY0X3QJZGZfcGVy
Zm1vbl9jb25maWdfYXNzaWduX21hc2tbQU1ER1BVX01BWF9ERl9QRVJGTU9OU107CisKKwkvKiBk
ZXZpY2UgcHN0YXRlICovCisJaW50CQkJCXBzdGF0ZTsKIH07CiAKIHN0YXRpYyBpbmxpbmUgc3Ry
dWN0IGFtZGdwdV9kZXZpY2UgKmFtZGdwdV90dG1fYWRldihzdHJ1Y3QgdHRtX2JvX2RldmljZSAq
YmRldikKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV94Z21p
LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfeGdtaS5jCmluZGV4IDE2N2Q5
ZmJkMmM0Zi4uZGUyMGE5YTFjNDQ0IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfeGdtaS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV94Z21pLmMKQEAgLTI3NCwxMiArMjc0LDE4IEBAIGludCBhbWRncHVfeGdtaV9zZXRfcHN0YXRl
KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCBpbnQgcHN0YXRlKQogewogCWludCByZXQgPSAw
OwogCXN0cnVjdCBhbWRncHVfaGl2ZV9pbmZvICpoaXZlID0gYW1kZ3B1X2dldF94Z21pX2hpdmUo
YWRldiwgMCk7CisJc3RydWN0IGFtZGdwdV9kZXZpY2UgKnRtcF9hZGV2OworCWJvb2wgdXBkYXRl
X2hpdmVfcHN0YXRlID0gdHJ1ZTsKIAogCWlmICghaGl2ZSkKIAkJcmV0dXJuIDA7CiAKLQlpZiAo
aGl2ZS0+cHN0YXRlID09IHBzdGF0ZSkKKwltdXRleF9sb2NrKCZoaXZlLT5oaXZlX2xvY2spOwor
CisJaWYgKGhpdmUtPnBzdGF0ZSA9PSBwc3RhdGUpIHsKKwkJbXV0ZXhfdW5sb2NrKCZoaXZlLT5o
aXZlX2xvY2spOwogCQlyZXR1cm4gMDsKKwl9CiAKIAlkZXZfZGJnKGFkZXYtPmRldiwgIlNldCB4
Z21pIHBzdGF0ZSAlZC5cbiIsIHBzdGF0ZSk7CiAKQEAgLTI5MCwxMSArMjk2LDMyIEBAIGludCBh
bWRncHVfeGdtaV9zZXRfcHN0YXRlKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCBpbnQgcHN0
YXRlKQogCQlyZXQgPSBhZGV2LT5wb3dlcnBsYXkucHBfZnVuY3MtPnNldF94Z21pX3BzdGF0ZShh
ZGV2LT5wb3dlcnBsYXkucHBfaGFuZGxlLAogCQkJCQkJCQlwc3RhdGUpOwogCi0JaWYgKHJldCkK
KwlpZiAocmV0KSB7CiAJCWRldl9lcnIoYWRldi0+ZGV2LAogCQkJIlhHTUk6IFNldCBwc3RhdGUg
ZmFpbHVyZSBvbiBkZXZpY2UgJWxseCwgaGl2ZSAlbGx4LCByZXQgJWQiLAogCQkJYWRldi0+Z21j
LnhnbWkubm9kZV9pZCwKIAkJCWFkZXYtPmdtYy54Z21pLmhpdmVfaWQsIHJldCk7CisJCWdvdG8g
b3V0OworCX0KKworCS8qIFVwZGF0ZSBkZXZpY2UgcHN0YXRlICovCisJYWRldi0+cHN0YXRlID0g
cHN0YXRlOworCisJLyoKKwkgKiBVcGRhdGUgdGhlIGhpdmUgcHN0YXRlIG9ubHkgYWxsIGRldmlj
ZXMgb2YgdGhlIGhpdmUKKwkgKiBhcmUgaW4gdGhlIHNhbWUgcHN0YXRlCisJICovCisJbGlzdF9m
b3JfZWFjaF9lbnRyeSh0bXBfYWRldiwgJmhpdmUtPmRldmljZV9saXN0LCBnbWMueGdtaS5oZWFk
KSB7CisJCWlmICh0bXBfYWRldi0+cHN0YXRlICE9IGFkZXYtPnBzdGF0ZSkgeworCQkJdXBkYXRl
X2hpdmVfcHN0YXRlID0gZmFsc2U7CisJCQlicmVhazsKKwkJfQorCX0KKwlpZiAodXBkYXRlX2hp
dmVfcHN0YXRlKQorCQloaXZlLT5wc3RhdGUgPSBwc3RhdGU7CisKK291dDoKKwltdXRleF91bmxv
Y2soJmhpdmUtPmhpdmVfbG9jayk7CiAKIAlyZXR1cm4gcmV0OwogfQpAQCAtMzY5LDYgKzM5Niw5
IEBAIGludCBhbWRncHVfeGdtaV9hZGRfZGV2aWNlKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2
KQogCQlnb3RvIGV4aXQ7CiAJfQogCisJLyogU2V0IGRlZmF1bHQgZGV2aWNlIHBzdGF0ZSAqLwor
CWFkZXYtPnBzdGF0ZSA9IC0xOworCiAJdG9wX2luZm8gPSAmYWRldi0+cHNwLnhnbWlfY29udGV4
dC50b3BfaW5mbzsKIAogCWxpc3RfYWRkX3RhaWwoJmFkZXYtPmdtYy54Z21pLmhlYWQsICZoaXZl
LT5kZXZpY2VfbGlzdCk7Ci0tIAoyLjIzLjAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeA==
