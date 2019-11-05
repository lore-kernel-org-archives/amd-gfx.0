Return-Path: <SRS0=U5eA=Y5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BC4BC010A2
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2019 11:34:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CDCD206BA
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2019 11:34:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CDCD206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12D8F6E9EE;
	Tue,  5 Nov 2019 11:34:56 +0000 (UTC)
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr820047.outbound.protection.outlook.com [40.107.82.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DABF46E9EE
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Nov 2019 11:34:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F7woCZAHTIBs3b0xKBXBPc6EHGDhmbWJf/ZEqknqgHoOwA1a7zBBgEbzyQyP7oEShkf1Nq1fSNJXWpgwTPIh1L/jHH4Vx8otjU2dDiM3wRS0c9qgZYxZ4e8v0a3+Cjp6VWBf9/UUvGoAIywypZ0qC+lGkCFXKsDGXqKT0ERL1F3Bau2EyF4kWHSntj7o1+lDhLPp5VP7Q1HKbA8UfMfaWCdARHHqzlDUDVTeaeQ5ZTvCLCeg+86StY2cIaccMbV5JeKsVYH94kqBGrOZ2UxCYrNWc4rKSfz3BDmkuh8womR0id0t6dNuCXbFeO9c4rNMUSjuieGzmeGuUUJhQVYDjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W0C8hhyC5xhx1YQzOviIfN6XwqshWbn7mSLPz1M2Ino=;
 b=DVUkiwt79TcaefAyrDeC4d2FgTf4LvJ6NoA3DeZZO3q5OPZ/POfLywVYFUXExU3pN5ziGA1l/ZGGX7pRLPOC1gHCPBJGlru00hc4BdS2jLjsOtj7Irbzrp4JB2qq8WGPD+DPUXcwTGH7DLIqQiGTCVRP3xmvEUxjdi2dydBYXGN6b+36lplsWSQA2J/UR7mQvSqW5aUHdAcT0W2sWK0EJKNEJdU7GvryiBzwTJrahTc2ZOL2yT57O2KVIpWgDjOqDQyOLGXP7AUd/jUNv89iEzBB2/JQOy9ePNe2zMbeUCPReIhgfUlefBdpHjHGbrK8bo30GuWvmsk0kXxsJKA+Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from CH2PR12MB3767.namprd12.prod.outlook.com (52.132.244.213) by
 CH2PR12MB4310.namprd12.prod.outlook.com (20.180.6.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Tue, 5 Nov 2019 11:34:53 +0000
Received: from CH2PR12MB3767.namprd12.prod.outlook.com
 ([fe80::490d:3b0d:981e:cbb6]) by CH2PR12MB3767.namprd12.prod.outlook.com
 ([fe80::490d:3b0d:981e:cbb6%7]) with mapi id 15.20.2408.024; Tue, 5 Nov 2019
 11:34:53 +0000
From: "Xu, Feifei" <Feifei.Xu@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdgpu: fix possible pstate switch race condition
Thread-Topic: [PATCH 1/2] drm/amdgpu: fix possible pstate switch race condition
Thread-Index: AQHVk8MTLXvuWPGEwk6y9f91X/Kjuad8clSw
Date: Tue, 5 Nov 2019 11:34:53 +0000
Message-ID:
 <CH2PR12MB3767020FB0B3CC195AB9F454FE7E0@CH2PR12MB3767.namprd12.prod.outlook.com>
References: <20191105102310.16657-1-evan.quan@amd.com>
In-Reply-To: <20191105102310.16657-1-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: abb558ea-1946-4507-8afe-08d761e42d3e
x-ms-traffictypediagnostic: CH2PR12MB4310:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB4310D83E6F52D6A980217D21FE7E0@CH2PR12MB4310.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 0212BDE3BE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(376002)(136003)(366004)(346002)(199004)(189003)(13464003)(66556008)(66946007)(64756008)(9686003)(76176011)(76116006)(6306002)(966005)(66476007)(229853002)(256004)(55016002)(110136005)(54906003)(26005)(6506007)(53546011)(186003)(6436002)(66446008)(99286004)(7696005)(316002)(446003)(476003)(8936002)(66066001)(486006)(6246003)(305945005)(102836004)(14444005)(3846002)(6116002)(478600001)(2501003)(14454004)(86362001)(5660300002)(52536014)(71190400001)(4326008)(71200400001)(2906002)(74316002)(8676002)(33656002)(25786009)(11346002)(7736002)(81166006)(81156014);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB4310;
 H:CH2PR12MB3767.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HTMyYA/nYi4MUSUxo/RcaKc6d+gkQ00nvTBtuw/BWrQxxFz2HG2ImhwYje7CJKoNT/va0ILYBx73sS5ggA3AwUut4n6FhIVHtd6bte4rBBqDNfgVD2tjnRkKk0kRcbn+bIik848fbeZz2i+U+WttxwdXLRNq5xpu2gC0iVFVJEEa1eM0B84FbAsSyOdTAV0sXKF5RjbkxTY8kSPZgB+ICam4zsDDLOCoBxCwbmtsGKR2sP4M/amRtFXZ51FzZVukbRzUnJHQfvpk4hljMHMB6VpWE1Zija5xsLrKF3OeS7De2ys0s76I/bTPWxQSrWS0dI0B5y+MrfyjPUMOR0y7PHlYOJLcKd6WB8zGm//rErZYUyNZeEuXJe0v3cIcboAAFRobHx5JO+vhrrG6f6x7Zza99p8g8aNv6bBUjed44Q7iIuK/oPhpI6h6i6oS42x/w0PoCkZnG6GbHtCHc/v5PRTL+4/J8g4kS9u7tw146lo=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abb558ea-1946-4507-8afe-08d761e42d3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2019 11:34:53.4096 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: InrHHxxoR6gTzVqju6XYt+SUyMJLRqho7CZZpmeJ5ThGScHVt0opY5YP3Pw31wnT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4310
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W0C8hhyC5xhx1YQzOviIfN6XwqshWbn7mSLPz1M2Ino=;
 b=SsdrA2XiQJGjmPQBWmCozcCHO2w1DSENFbOP9VeXYhzz/W8nYt60wMdGLoBe00NJAzdmxq437p/ryI0XibOp/1wWFDhHDX7S0qR4eYyq6acmTzNnX3zCDrxkGiJKEVrTFRkedoO9z8PoNjlWV2WqVBU6mKLXjOWpSHfKAObDOp8=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Feifei.Xu@amd.com; 
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
Cc: "Strawbridge, Michael" <Michael.Strawbridge@amd.com>, "Quan,
 Evan" <Evan.Quan@amd.com>, "Kim, Jonathan" <Jonathan.Kim@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191105113453.1ErTFpkF7jZkQsnFQeldw4o17UazAz5MOUDIxxwqCyw@z>

DQoNClNlcmllcyBpcyBSZXZpZXdlZC1ieTogRmVpZmVpIFh1IDxGZWlmZWkuWHVAYW1kLmNvbT4N
Cg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IGFtZC1nZnggPGFtZC1nZngtYm91
bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmc+IE9uIEJlaGFsZiBPZiBRdWFuLCBFdmFuDQpTZW50
OiAyMDE55bm0MTHmnIg15pelIDE4OjI0DQpUbzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcNCkNjOiBTdHJhd2JyaWRnZSwgTWljaGFlbCA8TWljaGFlbC5TdHJhd2JyaWRnZUBhbWQuY29t
PjsgS2ltLCBKb25hdGhhbiA8Sm9uYXRoYW4uS2ltQGFtZC5jb20+OyBRdWFuLCBFdmFuIDxFdmFu
LlF1YW5AYW1kLmNvbT4NClN1YmplY3Q6IFtQQVRDSCAxLzJdIGRybS9hbWRncHU6IGZpeCBwb3Nz
aWJsZSBwc3RhdGUgc3dpdGNoIHJhY2UgY29uZGl0aW9uDQoNCkFkZGVkIGxvY2sgcHJvdGVjdGlv
biBzbyB0aGF0IHRoZSBwLXN0YXRlIHN3aXRjaCB3aWxsIGJlIGd1YXJkZWQgdG8gYmUgc2VxdWVu
dGlhbC4gQWxzbyB1cGRhdGUgdGhlIGhpdmUgcHN0YXRlIG9ubHkgYWxsIGRldmljZSBmcm9tIHRo
ZSBoaXZlIGFyZSBpbiB0aGUgc2FtZSBzdGF0ZS4NCg0KQ2hhbmdlLUlkOiBJMTY1YTZmNDRlOGFl
YzFlNmRhNTZlZWZhMGZjNDlkMzY2NzBlNTZmZQ0KU2lnbmVkLW9mZi1ieTogRXZhbiBRdWFuIDxl
dmFuLnF1YW5AYW1kLmNvbT4NCi0tLQ0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dS5oICAgICAgfCAgMyArKysNCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfeGdt
aS5jIHwgMzQgKysrKysrKysrKysrKysrKysrKysrKy0tDQogMiBmaWxlcyBjaGFuZ2VkLCAzNSBp
bnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1LmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHUuaA0KaW5kZXggMDQ2OWNjNTFhNmZiLi40MWNmMmFiZDYyMDkgMTAwNjQ0DQotLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHUuaA0KKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1LmgNCkBAIC0xMDQxLDYgKzEwNDEsOSBAQCBzdHJ1Y3QgYW1kZ3B1X2Rl
dmljZSB7DQogDQogCXVpbnQ2NF90CQkJdW5pcXVlX2lkOw0KIAl1aW50NjRfdAlkZl9wZXJmbW9u
X2NvbmZpZ19hc3NpZ25fbWFza1tBTURHUFVfTUFYX0RGX1BFUkZNT05TXTsNCisNCisJLyogZGV2
aWNlIHBzdGF0ZSAqLw0KKwlpbnQJCQkJcHN0YXRlOw0KIH07DQogDQogc3RhdGljIGlubGluZSBz
dHJ1Y3QgYW1kZ3B1X2RldmljZSAqYW1kZ3B1X3R0bV9hZGV2KHN0cnVjdCB0dG1fYm9fZGV2aWNl
ICpiZGV2KSBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3hn
bWkuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV94Z21pLmMNCmluZGV4IDE2
N2Q5ZmJkMmM0Zi4uZGUyMGE5YTFjNDQ0IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X3hnbWkuYw0KKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3hnbWkuYw0KQEAgLTI3NCwxMiArMjc0LDE4IEBAIGludCBhbWRncHVfeGdtaV9zZXRf
cHN0YXRlKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCBpbnQgcHN0YXRlKSAgew0KIAlpbnQg
cmV0ID0gMDsNCiAJc3RydWN0IGFtZGdwdV9oaXZlX2luZm8gKmhpdmUgPSBhbWRncHVfZ2V0X3hn
bWlfaGl2ZShhZGV2LCAwKTsNCisJc3RydWN0IGFtZGdwdV9kZXZpY2UgKnRtcF9hZGV2Ow0KKwli
b29sIHVwZGF0ZV9oaXZlX3BzdGF0ZSA9IHRydWU7DQogDQogCWlmICghaGl2ZSkNCiAJCXJldHVy
biAwOw0KIA0KLQlpZiAoaGl2ZS0+cHN0YXRlID09IHBzdGF0ZSkNCisJbXV0ZXhfbG9jaygmaGl2
ZS0+aGl2ZV9sb2NrKTsNCisNCisJaWYgKGhpdmUtPnBzdGF0ZSA9PSBwc3RhdGUpIHsNCisJCW11
dGV4X3VubG9jaygmaGl2ZS0+aGl2ZV9sb2NrKTsNCiAJCXJldHVybiAwOw0KKwl9DQogDQogCWRl
dl9kYmcoYWRldi0+ZGV2LCAiU2V0IHhnbWkgcHN0YXRlICVkLlxuIiwgcHN0YXRlKTsNCiANCkBA
IC0yOTAsMTEgKzI5NiwzMiBAQCBpbnQgYW1kZ3B1X3hnbWlfc2V0X3BzdGF0ZShzdHJ1Y3QgYW1k
Z3B1X2RldmljZSAqYWRldiwgaW50IHBzdGF0ZSkNCiAJCXJldCA9IGFkZXYtPnBvd2VycGxheS5w
cF9mdW5jcy0+c2V0X3hnbWlfcHN0YXRlKGFkZXYtPnBvd2VycGxheS5wcF9oYW5kbGUsDQogCQkJ
CQkJCQlwc3RhdGUpOw0KIA0KLQlpZiAocmV0KQ0KKwlpZiAocmV0KSB7DQogCQlkZXZfZXJyKGFk
ZXYtPmRldiwNCiAJCQkiWEdNSTogU2V0IHBzdGF0ZSBmYWlsdXJlIG9uIGRldmljZSAlbGx4LCBo
aXZlICVsbHgsIHJldCAlZCIsDQogCQkJYWRldi0+Z21jLnhnbWkubm9kZV9pZCwNCiAJCQlhZGV2
LT5nbWMueGdtaS5oaXZlX2lkLCByZXQpOw0KKwkJZ290byBvdXQ7DQorCX0NCisNCisJLyogVXBk
YXRlIGRldmljZSBwc3RhdGUgKi8NCisJYWRldi0+cHN0YXRlID0gcHN0YXRlOw0KKw0KKwkvKg0K
KwkgKiBVcGRhdGUgdGhlIGhpdmUgcHN0YXRlIG9ubHkgYWxsIGRldmljZXMgb2YgdGhlIGhpdmUN
CisJICogYXJlIGluIHRoZSBzYW1lIHBzdGF0ZQ0KKwkgKi8NCisJbGlzdF9mb3JfZWFjaF9lbnRy
eSh0bXBfYWRldiwgJmhpdmUtPmRldmljZV9saXN0LCBnbWMueGdtaS5oZWFkKSB7DQorCQlpZiAo
dG1wX2FkZXYtPnBzdGF0ZSAhPSBhZGV2LT5wc3RhdGUpIHsNCisJCQl1cGRhdGVfaGl2ZV9wc3Rh
dGUgPSBmYWxzZTsNCisJCQlicmVhazsNCisJCX0NCisJfQ0KKwlpZiAodXBkYXRlX2hpdmVfcHN0
YXRlKQ0KKwkJaGl2ZS0+cHN0YXRlID0gcHN0YXRlOw0KKw0KK291dDoNCisJbXV0ZXhfdW5sb2Nr
KCZoaXZlLT5oaXZlX2xvY2spOw0KIA0KIAlyZXR1cm4gcmV0Ow0KIH0NCkBAIC0zNjksNiArMzk2
LDkgQEAgaW50IGFtZGdwdV94Z21pX2FkZF9kZXZpY2Uoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFk
ZXYpDQogCQlnb3RvIGV4aXQ7DQogCX0NCiANCisJLyogU2V0IGRlZmF1bHQgZGV2aWNlIHBzdGF0
ZSAqLw0KKwlhZGV2LT5wc3RhdGUgPSAtMTsNCisNCiAJdG9wX2luZm8gPSAmYWRldi0+cHNwLnhn
bWlfY29udGV4dC50b3BfaW5mbzsNCiANCiAJbGlzdF9hZGRfdGFpbCgmYWRldi0+Z21jLnhnbWku
aGVhZCwgJmhpdmUtPmRldmljZV9saXN0KTsNCi0tDQoyLjIzLjANCg0KX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCmFtZC1nZnggbWFpbGluZyBsaXN0DQph
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4DQpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2FtZC1nZng=
