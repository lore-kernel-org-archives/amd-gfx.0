Return-Path: <SRS0=4UxD=ZF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA91C17441
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2019 02:09:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1631F206B6
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2019 02:09:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1631F206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D610B6EC5C;
	Wed, 13 Nov 2019 02:09:27 +0000 (UTC)
Received: from NAM05-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr730040.outbound.protection.outlook.com [40.107.73.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73B1F6EC5C
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Nov 2019 02:09:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iOzTupsxXnG+zh+gSa9PITdTVYItGedxcyctj5guwHsmbmz8hfytdy8o5ql1AgroHaU3GQaF+KfTYMCWkCWIOT/NUJ/U0n26j5OhZk7YxkEJ8mKUtjYgrmXl88JpPmuZmzHyqjN4dafwYwtsVhRzgFqrTL9dqD11VDjrv1VjHrmM/iMMATTegvSVegJi+AEhUyHsSHa8HNCiLq3zkgnfI2hD0G/c5UJoSVY2iI72bUJ30E2rJ8o6d6aRy3uCvnzJThI9fN0dm8WcNgw+yH4My8lAJSL/947tafY7v/n+tcLgbgdHAkCnwYdJvH0YDUxfz2kPPXaIJHTCCEJrK3lSzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DJw6H4ZSCFbjeL6l6SifwsnoHRLGukIW6CvbRBOoYKk=;
 b=bq40ZGlDzOhTn6PIQ0Jos8E8xMSfJ5kXjckRRXC71bkYjb9O+k8+2DIQx8rpqm8G1/sL8mWfD2R+ggl1HjYsIWszExinjwT9Bre/lrMdvOtuXHNQ5ycwJIlLASSqm2LP0L4/HL1I9xhCwmRqouFbaNsPBQdaS5l0+H2YU9Z6JpN8lhq0sWnBaS47YUZ8ht6uyXLtNFDVO1+Ss2GA6aeGVlkxa+PENJVYAsHJpDKcK57Fhp583qsdze1APNxe6Q86sMYvDquVdYPJsHSRTJpE12d88QIJiMJn4ooKJ043GYkC4K7iyCOV2aNommsv7D9qYVCgvXjUba62oklyMUtHXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB2991.namprd12.prod.outlook.com (20.178.241.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Wed, 13 Nov 2019 02:09:24 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::5895:bbd8:c1d6:1587]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::5895:bbd8:c1d6:1587%7]) with mapi id 15.20.2430.027; Wed, 13 Nov 2019
 02:09:24 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: don't read registers if gfxoff is enabled (v2)
Thread-Topic: [PATCH] drm/amdgpu: don't read registers if gfxoff is enabled
 (v2)
Thread-Index: AQHVmWvEsW9FQCfaDkueGkQckeBfGaeIWuvw
Date: Wed, 13 Nov 2019 02:09:24 +0000
Message-ID:
 <MN2PR12MB3344C97B5167EAC63AF5796FE4760@MN2PR12MB3344.namprd12.prod.outlook.com>
References: <20191112151327.108438-1-alexander.deucher@amd.com>
In-Reply-To: <20191112151327.108438-1-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ff0c8013-a3f5-4072-1d57-08d767de8160
x-ms-traffictypediagnostic: MN2PR12MB2991:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB2991A7C21BF98674DAD15B8EE4760@MN2PR12MB2991.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:415;
x-forefront-prvs: 0220D4B98D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(366004)(396003)(136003)(376002)(346002)(199004)(189003)(13464003)(8936002)(102836004)(55016002)(86362001)(74316002)(305945005)(7736002)(6116002)(3846002)(486006)(2501003)(81156014)(81166006)(476003)(66476007)(8676002)(7696005)(66946007)(64756008)(66446008)(66556008)(6506007)(5660300002)(76176011)(2906002)(52536014)(53546011)(6306002)(9686003)(6436002)(26005)(99286004)(33656002)(6246003)(71190400001)(446003)(14454004)(966005)(4326008)(229853002)(256004)(76116006)(316002)(25786009)(11346002)(478600001)(110136005)(186003)(71200400001)(66066001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB2991;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PoZ7T72sqrG9Xe083L13t0qViuwJmgYV643J9dxMyBkDHuzgR3SZ0LrxX/hiyR46c03BUHFtNVbbvX2sb712Had5M4luoLh+BaPWGvvUToVPUla9CWdbaqkROdByzicfXrufP90JWGRAWu8Z/8xqWJlO9epcogROd9LSueceisWz6RD4XfyFOkgsDvGbA5W56c30Z3QIfXeDD2WOkaXAAmqJJWjiLzso/pDFefqOvQ3qLcHRy7R6GdDw0ClDm3KC6JIpeHVyF6TeZ+hRe0IOvP8tyfCfMB1Pet6rR/J4xq18u0Ix/l4SNObfRdAV0Q9Zg6ndwtQI56pp84MKnKeOJ8Pytf9z33pXIEqqPJtVQG3LPgCAb/QDPwGTnIfM8uLohFR27EIohJs5bNLDaNL8spLSuthvN0lixrTg807EskynxqloA9XiQFTKC0WIU9EQ
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff0c8013-a3f5-4072-1d57-08d767de8160
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2019 02:09:24.4926 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4TTrtVFWUkSHL9DcUAxqWvO2Pg0uVOV819jfyL+UOvU047AtO99IhHbv6flqrKJk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2991
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DJw6H4ZSCFbjeL6l6SifwsnoHRLGukIW6CvbRBOoYKk=;
 b=nQX+j075+46bnCCyHNUXHdeQX5gCasPmmQCCbem2xgt8HWqvl7LDsF1NjorK8KGfQAUZmfafDvsCGmYHlipbGP0Wz3bLdxRbpRqSiDLfBbtWYx9IAXtOEuzTiJwDOg/5f7llnByxE3uaqiCIeewq6+Uw0Z9XHg0UQpsK1mocDis=
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191113020924.BK754g0yMEBfeFTW0mDvQBdFKVv4wQMAEtVp8LO_y3Q@z>

VGhpcyBwYXRjaCBpcyByZXZpZXdlZC1ieTogRXZhbiBRdWFuIDxldmFuLnF1YW5AYW1kLmNvbT4N
Ckhvd2V2ZXIsIGkganVzdCBmaW5kIHdlIG5lZWQgYSBzZXBhcmF0ZSBwYXRjaCB0byBjbGVhciBQ
UF9HRlhPRkZfTUFTSyBzdXBwb3J0IGZyb20gQXJjdHVydXMuDQpDYW4geW91IGRvIHRoYXQgb3Ig
eW91IHdhbnQgbWUgdG8gZG8gdGhhdD8NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
PiBGcm9tOiBhbWQtZ2Z4IDxhbWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPiBP
biBCZWhhbGYgT2YgQWxleA0KPiBEZXVjaGVyDQo+IFNlbnQ6IFR1ZXNkYXksIE5vdmVtYmVyIDEy
LCAyMDE5IDExOjEzIFBNDQo+IFRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBD
YzogRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPg0KPiBTdWJq
ZWN0OiBbUEFUQ0hdIGRybS9hbWRncHU6IGRvbid0IHJlYWQgcmVnaXN0ZXJzIGlmIGdmeG9mZiBp
cyBlbmFibGVkICh2MikNCj4gDQo+IFdoZW4gZ2Z4b2ZmIGlzIGVuYWJsZWQsIGFjY2Vzc2luZyBn
ZnggcmVnaXN0ZXJzIHZpYSBNTUlPDQo+IGNhbiBsZWFkIHRvIGEgaGFuZy4NCj4gDQo+IHYyOiBy
ZXR1cm4gY2FjaGVkIHJlZ2lzdGVycyBwcm9wZXJseS4NCj4gDQo+IEJ1ZzogaHR0cHM6Ly9idWd6
aWxsYS5rZXJuZWwub3JnL3Nob3dfYnVnLmNnaT9pZD0yMDU0OTcNCj4gU2lnbmVkLW9mZi1ieTog
QWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPg0KPiAtLS0NCj4gIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L252LmMgICAgfCAyNyArKysrKysrKysrKysrKysrLS0tLS0t
LS0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc29jMTUuYyB8IDMxICsrKysrKysr
KysrKysrKysrKy0tLS0tLS0tLS0tLQ0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAzNiBpbnNlcnRpb25z
KCspLCAyMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9udi5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbnYuYw0KPiBp
bmRleCBhZjY4Zjk4MTVmMjguLjcyODNkNjE5OGI4OSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvbnYuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9udi5jDQo+IEBAIC0yMDEsMTcgKzIwMSwyNSBAQCBzdGF0aWMgdWludDMyX3QgbnZfcmVhZF9p
bmRleGVkX3JlZ2lzdGVyKHN0cnVjdA0KPiBhbWRncHVfZGV2aWNlICphZGV2LCB1MzIgc2VfbnVt
LA0KPiAgCXJldHVybiB2YWw7DQo+ICB9DQo+IA0KPiAtc3RhdGljIHVpbnQzMl90IG52X2dldF9y
ZWdpc3Rlcl92YWx1ZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwNCj4gK3N0YXRpYyBpbnQg
bnZfZ2V0X3JlZ2lzdGVyX3ZhbHVlKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LA0KPiAgCQkJ
CSAgICAgIGJvb2wgaW5kZXhlZCwgdTMyIHNlX251bSwNCj4gLQkJCQkgICAgICB1MzIgc2hfbnVt
LCB1MzIgcmVnX29mZnNldCkNCj4gKwkJCQkgICAgICB1MzIgc2hfbnVtLCB1MzIgcmVnX29mZnNl
dCwNCj4gKwkJCQkgICAgICB1MzIgKnZhbHVlKQ0KPiAgew0KPiAgCWlmIChpbmRleGVkKSB7DQo+
IC0JCXJldHVybiBudl9yZWFkX2luZGV4ZWRfcmVnaXN0ZXIoYWRldiwgc2VfbnVtLCBzaF9udW0s
DQo+IHJlZ19vZmZzZXQpOw0KPiArCQlpZiAoYWRldi0+cG0ucHBfZmVhdHVyZSAmIFBQX0dGWE9G
Rl9NQVNLKQ0KPiArCQkJcmV0dXJuIC1FSU5WQUw7DQo+ICsJCSp2YWx1ZSA9IG52X3JlYWRfaW5k
ZXhlZF9yZWdpc3RlcihhZGV2LCBzZV9udW0sIHNoX251bSwNCj4gcmVnX29mZnNldCk7DQo+ICAJ
fSBlbHNlIHsNCj4gLQkJaWYgKHJlZ19vZmZzZXQgPT0gU09DMTVfUkVHX09GRlNFVChHQywgMCwN
Cj4gbW1HQl9BRERSX0NPTkZJRykpDQo+IC0JCQlyZXR1cm4gYWRldi0+Z2Z4LmNvbmZpZy5nYl9h
ZGRyX2NvbmZpZzsNCj4gLQkJcmV0dXJuIFJSRUczMihyZWdfb2Zmc2V0KTsNCj4gKwkJaWYgKHJl
Z19vZmZzZXQgPT0gU09DMTVfUkVHX09GRlNFVChHQywgMCwNCj4gbW1HQl9BRERSX0NPTkZJRykp
IHsNCj4gKwkJCSp2YWx1ZSA9IGFkZXYtPmdmeC5jb25maWcuZ2JfYWRkcl9jb25maWc7DQo+ICsJ
CX0gZWxzZSB7DQo+ICsJCQlpZiAoYWRldi0+cG0ucHBfZmVhdHVyZSAmIFBQX0dGWE9GRl9NQVNL
KQ0KPiArCQkJCXJldHVybiAtRUlOVkFMOw0KPiArCQkJKnZhbHVlID0gUlJFRzMyKHJlZ19vZmZz
ZXQpOw0KPiArCQl9DQo+ICAJfQ0KPiArCXJldHVybiAwOw0KPiAgfQ0KPiANCj4gIHN0YXRpYyBp
bnQgbnZfcmVhZF9yZWdpc3RlcihzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgdTMyIHNlX251
bSwNCj4gQEAgLTIyNywxMCArMjM1LDkgQEAgc3RhdGljIGludCBudl9yZWFkX3JlZ2lzdGVyKHN0
cnVjdCBhbWRncHVfZGV2aWNlDQo+ICphZGV2LCB1MzIgc2VfbnVtLA0KPiAgCQkgICAgKGFkZXYt
PnJlZ19vZmZzZXRbZW4tPmh3aXBdW2VuLT5pbnN0XVtlbi0+c2VnXSArIGVuLQ0KPiA+cmVnX29m
ZnNldCkpDQo+ICAJCQljb250aW51ZTsNCj4gDQo+IC0JCSp2YWx1ZSA9IG52X2dldF9yZWdpc3Rl
cl92YWx1ZShhZGV2LA0KPiAtDQo+IG52X2FsbG93ZWRfcmVhZF9yZWdpc3RlcnNbaV0uZ3JibV9p
bmRleGVkLA0KPiAtCQkJCQkgICAgICAgc2VfbnVtLCBzaF9udW0sIHJlZ19vZmZzZXQpOw0KPiAt
CQlyZXR1cm4gMDsNCj4gKwkJcmV0dXJuIG52X2dldF9yZWdpc3Rlcl92YWx1ZShhZGV2LA0KPiAr
DQo+IG52X2FsbG93ZWRfcmVhZF9yZWdpc3RlcnNbaV0uZ3JibV9pbmRleGVkLA0KPiArCQkJCQkg
ICAgIHNlX251bSwgc2hfbnVtLCByZWdfb2Zmc2V0LCB2YWx1ZSk7DQo+ICAJfQ0KPiAgCXJldHVy
biAtRUlOVkFMOw0KPiAgfQ0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvc29jMTUuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NvYzE1LmMNCj4gaW5k
ZXggMzA1YWQzZWVjOTg3Li4yY2MxNmU5ZjM5ZmIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L3NvYzE1LmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvc29jMTUuYw0KPiBAQCAtMzYzLDE5ICszNjMsMjcgQEAgc3RhdGljIHVpbnQzMl90IHNvYzE1
X3JlYWRfaW5kZXhlZF9yZWdpc3RlcihzdHJ1Y3QNCj4gYW1kZ3B1X2RldmljZSAqYWRldiwgdTMy
IHNlX24NCj4gIAlyZXR1cm4gdmFsOw0KPiAgfQ0KPiANCj4gLXN0YXRpYyB1aW50MzJfdCBzb2Mx
NV9nZXRfcmVnaXN0ZXJfdmFsdWUoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsDQo+ICtzdGF0
aWMgaW50IHNvYzE1X2dldF9yZWdpc3Rlcl92YWx1ZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRl
diwNCj4gIAkJCQkJIGJvb2wgaW5kZXhlZCwgdTMyIHNlX251bSwNCj4gLQkJCQkJIHUzMiBzaF9u
dW0sIHUzMiByZWdfb2Zmc2V0KQ0KPiArCQkJCQkgdTMyIHNoX251bSwgdTMyIHJlZ19vZmZzZXQs
DQo+ICsJCQkJCSB1MzIgKnZhbHVlKQ0KPiAgew0KPiAgCWlmIChpbmRleGVkKSB7DQo+IC0JCXJl
dHVybiBzb2MxNV9yZWFkX2luZGV4ZWRfcmVnaXN0ZXIoYWRldiwgc2VfbnVtLCBzaF9udW0sDQo+
IHJlZ19vZmZzZXQpOw0KPiArCQlpZiAoYWRldi0+cG0ucHBfZmVhdHVyZSAmIFBQX0dGWE9GRl9N
QVNLKQ0KPiArCQkJcmV0dXJuIC1FSU5WQUw7DQo+ICsJICAgICAgICAqdmFsdWUgPSBzb2MxNV9y
ZWFkX2luZGV4ZWRfcmVnaXN0ZXIoYWRldiwgc2VfbnVtLCBzaF9udW0sDQo+IHJlZ19vZmZzZXQp
Ow0KPiAgCX0gZWxzZSB7DQo+IC0JCWlmIChyZWdfb2Zmc2V0ID09IFNPQzE1X1JFR19PRkZTRVQo
R0MsIDAsDQo+IG1tR0JfQUREUl9DT05GSUcpKQ0KPiAtCQkJcmV0dXJuIGFkZXYtPmdmeC5jb25m
aWcuZ2JfYWRkcl9jb25maWc7DQo+IC0JCWVsc2UgaWYgKHJlZ19vZmZzZXQgPT0gU09DMTVfUkVH
X09GRlNFVChHQywgMCwNCj4gbW1EQl9ERUJVRzIpKQ0KPiAtCQkJcmV0dXJuIGFkZXYtPmdmeC5j
b25maWcuZGJfZGVidWcyOw0KPiAtCQlyZXR1cm4gUlJFRzMyKHJlZ19vZmZzZXQpOw0KPiArCQlp
ZiAocmVnX29mZnNldCA9PSBTT0MxNV9SRUdfT0ZGU0VUKEdDLCAwLA0KPiBtbUdCX0FERFJfQ09O
RklHKSkgew0KPiArCQkJKnZhbHVlID0gYWRldi0+Z2Z4LmNvbmZpZy5nYl9hZGRyX2NvbmZpZzsN
Cj4gKwkJfSBlbHNlIGlmIChyZWdfb2Zmc2V0ID09IFNPQzE1X1JFR19PRkZTRVQoR0MsIDAsDQo+
IG1tREJfREVCVUcyKSkgew0KPiArCQkJKnZhbHVlID0gYWRldi0+Z2Z4LmNvbmZpZy5kYl9kZWJ1
ZzI7DQo+ICsJCX0gZWxzZSB7DQo+ICsJCQlpZiAoYWRldi0+cG0ucHBfZmVhdHVyZSAmIFBQX0dG
WE9GRl9NQVNLKQ0KPiArCQkJCXJldHVybiAtRUlOVkFMOw0KPiArCQkJKnZhbHVlID0gUlJFRzMy
KHJlZ19vZmZzZXQpOw0KPiArCQl9DQo+ICAJfQ0KPiArCXJldHVybiAwOw0KPiAgfQ0KPiANCj4g
IHN0YXRpYyBpbnQgc29jMTVfcmVhZF9yZWdpc3RlcihzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRl
diwgdTMyIHNlX251bSwNCj4gQEAgLTM5MSwxMCArMzk5LDkgQEAgc3RhdGljIGludCBzb2MxNV9y
ZWFkX3JlZ2lzdGVyKHN0cnVjdCBhbWRncHVfZGV2aWNlDQo+ICphZGV2LCB1MzIgc2VfbnVtLA0K
PiAgCQkJCQkrIGVuLT5yZWdfb2Zmc2V0KSkNCj4gIAkJCWNvbnRpbnVlOw0KPiANCj4gLQkJKnZh
bHVlID0gc29jMTVfZ2V0X3JlZ2lzdGVyX3ZhbHVlKGFkZXYsDQo+IC0NCj4gc29jMTVfYWxsb3dl
ZF9yZWFkX3JlZ2lzdGVyc1tpXS5ncmJtX2luZGV4ZWQsDQo+IC0JCQkJCQkgIHNlX251bSwgc2hf
bnVtLCByZWdfb2Zmc2V0KTsNCj4gLQkJcmV0dXJuIDA7DQo+ICsJCXJldHVybiBzb2MxNV9nZXRf
cmVnaXN0ZXJfdmFsdWUoYWRldiwNCj4gKw0KPiAJc29jMTVfYWxsb3dlZF9yZWFkX3JlZ2lzdGVy
c1tpXS5ncmJtX2luZGV4ZWQsDQo+ICsJCQkJCQlzZV9udW0sIHNoX251bSwgcmVnX29mZnNldCwN
Cj4gdmFsdWUpOw0KPiAgCX0NCj4gIAlyZXR1cm4gLUVJTlZBTDsNCj4gIH0NCj4gLS0NCj4gMi4y
My4wDQo+IA0KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Xw0KPiBhbWQtZ2Z4IG1haWxpbmcgbGlzdA0KPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
Zw0KPiBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
ZngNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1n
ZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
