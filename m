Return-Path: <SRS0=qril=YV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 562EBCA9EAF
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 02:34:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 248FB20650
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 02:34:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 248FB20650
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6E966E34D;
	Mon, 28 Oct 2019 02:34:56 +0000 (UTC)
Received: from NAM03-BY2-obe.outbound.protection.outlook.com
 (mail-eopbgr780070.outbound.protection.outlook.com [40.107.78.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 323826E34D
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2019 02:34:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vs+bL//cjnwMjLsZPW5r5vgrOP4ERAKYWPQfOyOAMLZEGCGet+aF+5IpKtwuIVoOesyZbt0nH7glQidgxUimuZUF+t6Q+kaEFZKLGGYtK4cyyrzGDnU4aFili48m5+ldDGNvNsG0UztY05U+S0vn5lNCMKGKyPvwhjxetQo/FiHXHBlSxXA4NZWelcqdifG79qhujcUseCjK2N2vGhwMIvyKbWyRhjklKiAmLzYzQpRb2QhhvRkZdzfiaPybWgeXSXBiOxaHBkIfy9X0yyxXcLSglM4UsBzBhHwMz7W0EQoStqdm0wRDUUU94FNP2jEj/Q67C9l6hlkRC79O+54QlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tPXCtUyqyoqlYdQryCrMXzrwvbhF+gsJxrA8GksHU8k=;
 b=SVTkLhBZpMD1zoHI48I1+UQwGInm1J5PSmxtXhfS11p22YDzWmaXAywlKLNMWJznfX3a/DFy1G3N3WXGZjtmX1YsvE4PiyiDK3Tuafw0ijdwz56MSCuGTUkN1AQGeGQJGBeeAO+xbJP4hWZosT+egsDoLua3UhZf6J9lIMZ6j2fC2rVvzRG8DQB4krhaSJ3cji3LvVWkuSamy1DXkfJRmV+akiO5eO7ZIey1cqUsYhs2ygLUiADXX1pEpXpm6fUNxDt2u+YxiiOkNS2IvKnUt5mmSb1RVfVezG/eGWojPvCnZ+W8JqboGRnpKXk1fwYEWtNgoU37HeUCeRXYWLhR5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3069.namprd12.prod.outlook.com (20.178.241.23) by
 MN2PR12MB2909.namprd12.prod.outlook.com (20.179.82.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.24; Mon, 28 Oct 2019 02:34:54 +0000
Received: from MN2PR12MB3069.namprd12.prod.outlook.com
 ([fe80::e95c:1043:a41f:1d14]) by MN2PR12MB3069.namprd12.prod.outlook.com
 ([fe80::e95c:1043:a41f:1d14%3]) with mapi id 15.20.2387.023; Mon, 28 Oct 2019
 02:34:54 +0000
From: "Gong, Curry" <Curry.Gong@amd.com>
To: "Huang, Ray" <Ray.Huang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/powerplay: Disable gfx CGPG when suspend smu
Thread-Topic: [PATCH] drm/amd/powerplay: Disable gfx CGPG when suspend smu
Thread-Index: AQHViyRT5N2YC1xSLkqUUgxmnBJOJqdrWTaAgAP8vvA=
Date: Mon, 28 Oct 2019 02:34:54 +0000
Message-ID:
 <MN2PR12MB3069CB862732575D4F9835BF9D660@MN2PR12MB3069.namprd12.prod.outlook.com>
References: <1572001610-9599-1-git-send-email-curry.gong@amd.com>
 <MN2PR12MB3309AD7F0E9B0911A7AC9C5CEC650@MN2PR12MB3309.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB3309AD7F0E9B0911A7AC9C5CEC650@MN2PR12MB3309.namprd12.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b3a38d09-843b-4ca7-d42f-08d75b4f6a70
x-ms-traffictypediagnostic: MN2PR12MB2909:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB290918A4E89DF086EA156D059D660@MN2PR12MB2909.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:619;
x-forefront-prvs: 0204F0BDE2
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(366004)(376002)(396003)(39860400002)(346002)(189003)(13464003)(199004)(486006)(14444005)(256004)(74316002)(33656002)(478600001)(76116006)(7736002)(305945005)(229853002)(86362001)(64756008)(6246003)(81166006)(81156014)(316002)(66946007)(6436002)(6306002)(9686003)(6116002)(3846002)(55016002)(25786009)(76176011)(5660300002)(71190400001)(71200400001)(15650500001)(99286004)(2501003)(66476007)(2906002)(66066001)(102836004)(26005)(186003)(52536014)(66446008)(110136005)(11346002)(8936002)(14454004)(966005)(476003)(6506007)(7696005)(446003)(53546011)(8676002)(66556008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB2909;
 H:MN2PR12MB3069.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KfyLvEi56ksfC0eeB08l/rPoI+w4hfa4Mbw74XbexTVnl77ZacNLJtLxxjN9b7EhM5U9sKqSFLGex3YFNEGemK+8KE2JTNvcps18J/nZvBuMyQd25akjeyh5QeEKfvhF6bLtNyXLxtmXCYk7stJ0mcCjyyk9S+8jMy4gLEaOeBtHvxL644OT8siyqu3MS0IKq0cTwt+tj+vH3tQWog71zpMdUoJt42F+W7XYXoCAUJUKWW+sVPwlwiaN4fsfZpQ2TgpvwreQmruxvsFs6r8XkZP3Cj26ks10iRXLf6z5+42j5TOgiJ8lo13z8mhYlR0JbZH8sfmCE3rKBdcV9JtrDIVwkocu1gp50Xsegs+aBnV1OTwFSs4fh5qOxPwDXj6GUimPoQhWJ06RsWK77mY7vIikse+HdANVWsALHDMNLTBwKmtzNWVESw69wk2u0yMlWzsPebFdOs2HRuJG8RqgS4s1TcHEoIbdm469s3qP1wE=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3a38d09-843b-4ca7-d42f-08d75b4f6a70
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2019 02:34:54.1428 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lhKa5lLc3tLHaqi85jPdMsdVn9Zs/ReqBSOhN2yfVS8mESCArf7dQ7rP4nb4b7CF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2909
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tPXCtUyqyoqlYdQryCrMXzrwvbhF+gsJxrA8GksHU8k=;
 b=F9v4n0a+xVfpm0FGfZpq9hpsrXA8oqu9piHFxgZQPA+BXIZltV3J5jZU4C4FUtnJ0Qylb11hJLSd+pv83B1B4Ai4mDKUujjBR8ujEMAsUv5vEcynmpPcSY87MOYeq1kEavmqPZZ5l4tlULIpD7tZf6EOjFYIdWHKPsBSS/KShkI=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Curry.Gong@amd.com; 
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191028023454.EK7RXfKDBL2a6oNMp0NtUMNu364XOx0IqiXcoF8uick@z>

SGkgUmF5Og0KDQpCZWNhdXNlIEkgZm91bmQgdGhhdCBlbmFibGUgQ0dQRyBmb3IgYWxsIEFQVSBp
biBzbXVfcmVzdW1lIGF0IDBkMmU5YjEwNDI4YTYNCg0KY29tbWl0IDBkMmU5YjEwNDI4YTZjMjYx
Yzk5ZjJkOTgyYmU3NzQ1ZjM1ZWVmOTcNCkF1dGhvcjogUHJpa2UgTGlhbmcgPFByaWtlLkxpYW5n
QGFtZC5jb20+DQpEYXRlOiAgIFR1ZSBPY3QgMTUgMTc6MTE6NDkgMjAxOSArMDgwMA0KDQogICAg
ZHJtL2FtZGdwdTogZml4IFMzIGZhaWxlZCBhcyBSTEMgc2FmZSBtb2RlIGVudHJ5IHN0dWNrZWQg
aW4gcG9sbG9pbmcgZ2Z4IGFjcQ0KDQogICAgRml4IGdmeCBjZ3BnIHNldHRpbmcgc2VxdWVuY2Ug
Zm9yIFJMQyBkZWFkbG9jayBhdCBzYWZlIG1vZGUgZW50cnkgaW4gcG9sbGluZyBnZnggcmVzcG9u
c2UuDQogICAgVGhlIHBhdGNoIGNhbiBmaXggVkNOIElCIHRlc3QgZmFpbGVkIGFuZCBEQUwgZ2V0
IGRpc3BhbHkgY291bnQgZmFpbGVkIGlzc3VlLg0KDQogICAgU2lnbmVkLW9mZi1ieTogUHJpa2Ug
TGlhbmcgPFByaWtlLkxpYW5nQGFtZC5jb20+DQogICAgUmV2aWV3ZWQtYnk6IEh1YW5nIFJ1aSA8
cmF5Lmh1YW5nQGFtZC5jb20+DQoNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
cG93ZXJwbGF5L2FtZGdwdV9zbXUuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2Ft
ZGdwdV9zbXUuYw0KaW5kZXggYWNlYzY5Yjc0NzM0Li5lMmEwM2Y0MTFkNmIgMTAwNjQ0DQotLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9hbWRncHVfc211LmMNCisrKyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2FtZGdwdV9zbXUuYw0KQEAgLTEzNTAsNiArMTM1MSw5
IEBAIHN0YXRpYyBpbnQgc211X3Jlc3VtZSh2b2lkICpoYW5kbGUpDQogICAgICAgIGlmIChyZXQp
DQogICAgICAgICAgICAgICAgZ290byBmYWlsZWQ7DQoNCisgICAgICAgaWYgKHNtdS0+aXNfYXB1
KQ0KKyAgICAgICAgICAgICAgIHNtdV9zZXRfZ2Z4X2NncGcoJmFkZXYtPnNtdSwgdHJ1ZSk7DQor
DQogICAgICAgIG11dGV4X3VubG9jaygmc211LT5tdXRleCk7DQoNCiAgICAgICAgcHJfaW5mbygi
U01VIGlzIHJlc3VtZWQgc3VjY2Vzc2Z1bGx5IVxuIik7DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQpGcm9tOiBIdWFuZywgUmF5IDxSYXkuSHVhbmdAYW1kLmNvbT4gDQpTZW50OiBGcmlk
YXksIE9jdG9iZXIgMjUsIDIwMTkgOToyNiBQTQ0KVG86IEdvbmcsIEN1cnJ5IDxDdXJyeS5Hb25n
QGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KQ2M6IEdvbmcsIEN1cnJ5
IDxDdXJyeS5Hb25nQGFtZC5jb20+DQpTdWJqZWN0OiBSRTogW1BBVENIXSBkcm0vYW1kL3Bvd2Vy
cGxheTogRGlzYWJsZSBnZnggQ0dQRyB3aGVuIHN1c3BlbmQgc211DQoNCldoeSBkbyB5b3UgZGlz
YWJsZSBDR1BHIGZvciBhbGwgQVBVPw0KDQpUaGFua3MsDQpSYXkNCg0KLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCkZyb206IGFtZC1nZnggPGFtZC1nZngtYm91bmNlc0BsaXN0cy5mcmVlZGVz
a3RvcC5vcmc+IE9uIEJlaGFsZiBPZiBjaGVuIGdvbmcNClNlbnQ6IEZyaWRheSwgT2N0b2JlciAy
NSwgMjAxOSA3OjA3IFBNDQpUbzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCkNjOiBH
b25nLCBDdXJyeSA8Q3VycnkuR29uZ0BhbWQuY29tPg0KU3ViamVjdDogW1BBVENIXSBkcm0vYW1k
L3Bvd2VycGxheTogRGlzYWJsZSBnZnggQ0dQRyB3aGVuIHN1c3BlbmQgc211DQoNCmlmIG5vIGRp
c2FibGUgZ2Z4IENHUEcgd2hlbiBzdXNwZW5kIHNtdSwgZW5hYmxpbmcgZ2Z4IENHUEcgd2lsbCBm
YWlsIHdoZW4gcmVzdW1lIHNtdS4NCg0KUGxhdGZvcm06IFJlbm9pcg0KZG1lc2cgbG9nIGluZm9y
bWF0aW9uOg0KDQpbICAxNTEuODQ0MTEwIF0gYW1kZ3B1OiBbcG93ZXJwbGF5XSBTTVUgaXMgcmVz
dW1pbmcuLi4NClsgIDE1MS44NDQxMTYgXSBhbWRncHU6IFtwb3dlcnBsYXldIGRwbSBoYXMgYmVl
biBkaXNhYmxlZCBbICAxNTEuODQ0NjA0IF0gYW1kZ3B1OiBbcG93ZXJwbGF5XSBGYWlsZWQgdG8g
c2VuZCBtZXNzYWdlIDB4MmYscmVzcG9uc2UgMHhmZmZmZmZmYiBwYXJhbSAweDEgWyAgMTUxLjg0
NDYwNSBdIGFtZGdwdTogW3Bvd2VycGxheV0gU01VIGlzIHJlc3VtZWQgc3VjY2Vzc2Z1bGx5IQ0K
DQpTaWduZWQtb2ZmLWJ5OiBjaGVuIGdvbmcgPGN1cnJ5LmdvbmdAYW1kLmNvbT4NCi0tLQ0KIGRy
aXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2FtZGdwdV9zbXUuYyB8IDIgKysNCiAxIGZpbGUg
Y2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL3Bvd2VycGxheS9hbWRncHVfc211LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxh
eS9hbWRncHVfc211LmMNCmluZGV4IDI2OTIzYWEuLjRlNDY4YjAgMTAwNjQ0DQotLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9hbWRncHVfc211LmMNCisrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvcG93ZXJwbGF5L2FtZGdwdV9zbXUuYw0KQEAgLTEzNTEsNiArMTM1MSw4IEBAIHN0
YXRpYyBpbnQgc211X3N1c3BlbmQodm9pZCAqaGFuZGxlKQ0KIAlpZiAoYWRldi0+YXNpY190eXBl
ID49IENISVBfTkFWSTEwICYmDQogCSAgICBhZGV2LT5nZngucmxjLmZ1bmNzLT5zdG9wKQ0KIAkJ
YWRldi0+Z2Z4LnJsYy5mdW5jcy0+c3RvcChhZGV2KTsNCisJaWYgKHNtdS0+aXNfYXB1KQ0KKwkJ
c211X3NldF9nZnhfY2dwZygmYWRldi0+c211LCBmYWxzZSk7DQogDQogCXJldHVybiAwOw0KIH0N
Ci0tDQoyLjcuNA0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXw0KYW1kLWdmeCBtYWlsaW5nIGxpc3QNCmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
DQpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngN
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZngg
bWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
