Return-Path: <SRS0=5Use=ZK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E12C432C0
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Nov 2019 03:42:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF628206B6
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Nov 2019 03:42:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF628206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BB0889FC9;
	Mon, 18 Nov 2019 03:42:08 +0000 (UTC)
Received: from NAM05-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr720040.outbound.protection.outlook.com [40.107.72.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E77B89FC9
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Nov 2019 03:42:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BPdJjb18crv7Sx0lW5rWslnNq0f9nQZf7CoEixzArGZ1pz59T5wk/c9rCJGSbBTPNZJYmqx+MP8Djgm8gl40Ctqcpkd8wjSclroELTx+ScKYpVi9GgXvNet7qWUlEapxqcVkHoy3z43h1TZj0dF13lmn+3btyIJjYK4mvq4kWiIEdUrPfSb0hBjOmOlr2hFeLs86226IVeEfTB1GOVrERPM5HtEtnwaWpdf0UYEFCdxs0JkLJ77LVd+Ije53LkDhaotBH9ldNC7XtdHhtd1KxSNbSDr39x2BKr9q5QuI614lXKp602YKsE94yfTTZHBZLrAP8QKZeiBxn8WoX+7Lag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tUUIeT5FYLdw8IsxO6UN9Q0+WXO396eaZPewSesNqqs=;
 b=QF4e+9hngaIOw+G9mUi4rdpU+EaBFmaFQUKWxkPGRfrIobofvOLAdxqNl01FwSr+VahBhU+Gioz72z0oODMYydT5WqzTdEMx5gMp6ax8Ly5dbb7LG6u4N7bSEawjSQEZuARyUbtwPN6KC+e8SGVVtG/FJoT3MIBQa2MTxR2VhjX3zvpg6/3+WRpp4fwrmjdz/sNnQNnizkh/ttrWQ95Abskc8vnVLrgUNUREwjwbp4sihvX0WOa3NmEoGSsx9lpBOjPap0NHVepSoQci6XzGgT6t9kXWwEbJgTt/E82e0kTdOlXp7FCfcnk5fnkWwjvqxogqDSG+MRWawyva/PAxdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BL0PR12MB2580.namprd12.prod.outlook.com (52.132.27.147) by
 BL0PR12MB2547.namprd12.prod.outlook.com (52.132.27.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Mon, 18 Nov 2019 03:42:05 +0000
Received: from BL0PR12MB2580.namprd12.prod.outlook.com
 ([fe80::55f1:f8d5:e7d0:f595]) by BL0PR12MB2580.namprd12.prod.outlook.com
 ([fe80::55f1:f8d5:e7d0:f595%2]) with mapi id 15.20.2451.029; Mon, 18 Nov 2019
 03:42:05 +0000
From: "Zeng, Oak" <Oak.Zeng@amd.com>
To: "Yang, Philip" <Philip.Yang@amd.com>, "Sierra Guiza, Alejandro (Alex)"
 <Alex.Sierra@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] amd/amdgpu: force to trigger a no-retry-fault after a
 retry-fault
Thread-Topic: [PATCH] amd/amdgpu: force to trigger a no-retry-fault after a
 retry-fault
Thread-Index: AQHVm9xPRg7efMyLSkGed5lU8ulRQqeMhkAAgAO84jA=
Date: Mon, 18 Nov 2019 03:42:05 +0000
Message-ID:
 <BL0PR12MB258076EDAE60740E94C92972804D0@BL0PR12MB2580.namprd12.prod.outlook.com>
References: <20191115174314.73446-1-alex.sierra@amd.com>
 <bd9f76ca-9dc7-6c29-9c41-fc3e0d3c0bf1@amd.com>
In-Reply-To: <bd9f76ca-9dc7-6c29-9c41-fc3e0d3c0bf1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [99.228.101.96]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 22db4a4d-7cd9-4a94-19aa-08d76bd947be
x-ms-traffictypediagnostic: BL0PR12MB2547:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB2547B5AF5B4F3C1EC5BECEBE804D0@BL0PR12MB2547.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:758;
x-forefront-prvs: 0225B0D5BC
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(346002)(376002)(39860400002)(396003)(136003)(199004)(189003)(13464003)(229853002)(14444005)(26005)(256004)(8676002)(2906002)(55016002)(76116006)(6306002)(64756008)(81166006)(81156014)(66476007)(66946007)(14454004)(66556008)(7736002)(305945005)(9686003)(25786009)(966005)(6436002)(11346002)(2501003)(486006)(476003)(76176011)(446003)(102836004)(6246003)(7696005)(478600001)(186003)(74316002)(8936002)(66446008)(66066001)(71190400001)(53546011)(52536014)(6506007)(71200400001)(316002)(4001150100001)(6116002)(3846002)(33656002)(86362001)(5660300002)(99286004)(110136005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BL0PR12MB2547;
 H:BL0PR12MB2580.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KCQ1zsfqUcAn4htHVXVzwBieYN/YVDfg8pyPMZAUlLlqhfRFIFe4H7d1OvetKg4X7rYG02yd3k9J2Tx4UgGjykIJOYpl3j245H3v5qZ3PAQNdkBjBKpiLoldPrY05O0a416KKnWLvIwO6Yxknkigc0cK567dCMFjilus49ppQ/a7jsqiM9WOCQ329Dzg17HIE2sqi2jHnR/XxAGvvZjqZZN4GRmhKBovwdAdJQyVwBVtuNdtm36MRlTNwj9N21qq9oIZEVjTTZXREMZkDyJOvkBhoNBICktWOwvfVoLQyVmhJQkZursu4s06sIWNb8xGJ/5jEGlQqzgekm4WCfrZhWcVfJ/YUsmYbS0Hb6B7gdBubFxNS4hNBA24O2v/g/B8FwTyqJz59dbmDXdpkYGn8L1WtU02Azrh5r08dQr9k0YKD+KRCytgOv77d2gWkgp0
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22db4a4d-7cd9-4a94-19aa-08d76bd947be
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2019 03:42:05.0701 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gIn+C1MUlOU12LVbu+VSKCU0gvfIag44M/wVrq5s6NEpOPOvRYKsxOdDMs61qkRn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2547
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tUUIeT5FYLdw8IsxO6UN9Q0+WXO396eaZPewSesNqqs=;
 b=mHUGMJiD18F2jvO34T9y1J/QumTVako6c54Eww44lEoN8ht1cxYp+6szt82cqGbbwKh552PvECR/otMKqmXuE1aIWUv/jyMSQioxCbqknqd1MI0LCvOjx0FYYzq0EIsv0FdHyZ9Ab5JtgNwwV1qnIfoUW7wox0qI16drkja2dVw=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Oak.Zeng@amd.com; 
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
Message-ID: <20191118034205.lL8SdwpnZYyO8q-P1xy7Z_9qwx8HX9bt2qf3wQkQcXM@z>

SGkgUGhpbGlwL0FsZXgsDQoNCkkgZm91bmQgSSBjYW4ndCB1bmRlcnN0YW5kIHRoaXMgcGF0Y2gg
d2l0aG91dCBtb3JlIGRldGFpbHMgaW4gdGhlIGNvbW1pdCBtZXNzYWdlLiBJcyB0aGlzIHByZXBh
cmF0aW9uIHdvcmsgZm9yIHRoZSBwYWdlIG1pZ3JhdGlvbj8gV2h5IHNldHRpbmcgdGhlIHRyYW5z
bGF0aW9uIGZ1cnRoZXIgYml0IGNhbiBmb3JjZSBhIG5vLXJldHJ5LWZhdWx0PyBXb24ndCBzZXR0
aW5nIHRoaXMgYml0IGNhdXNlIFVUQ0wyIHRyZWF0IHRoZSBQVEUgYXMgYSBQREUgYW5kIGNvbnRp
bnVlIHRvIHdhbGsgdG8gdGhlIFBURSB0aGF0IHRoaXMgUFRFIHBvaW50aW5nIHRvPyBCdXQgZnJv
bSB0aGUgcGF0Y2ggYmVsb3csIHRoZSBuZXh0IGxldmVsIG9mIFBURSAocHNldWRvbHkgdGhlIDV0
aCBsZXZlbCBwYWdlIHRhYmxlKSBpcyBub3Qgc2V0LiANCg0KV2h5IHRoaXMgc2V0dGluZyB3aWxs
IGNhdXNlIHRoZSB3YXZlIHRvIGVudGVyIHRyYXAgaGFuZGxlcj8gQXMgSSB1bmRlcnN0YW5kIGl0
LCB3YXZlIGVudGVycyB0cmFwIGhhbmRsZXIgKHNhdmluZyBjb250ZXh0KSBlaXRoZXIgaXQgZW5j
b3VudGVyIGEgc190cmFwIGluc3RydWN0aW9uLCBvciBDUCBjYW4gaW5pdGlhbGl6ZSBzdXNwZW5z
aW9uIHRvIHByZWVtcHQgdGhlIHJ1bm5pbmcgd2F2ZXMsIG9yIGNvbnRleHQgc3dpdGNoIGNhbiBi
ZSB0cmlnZ2VyZWQgYnkgY2VydGFpbiBjb3VudGVyIChtb25pdG9yZWQgYnkgU1BJKS4gDQoNCkZ1
cnRoZXIgcXVlc3Rpb24gd2lsbCBiZSwgd2hhdCBpcyB0aGUgcGxhbm5lZCBwYWdlIG1pZ3JhdGlv
biBwcm9jZXNzPyBIYWx0IHdhdmUvc2F2ZSBjb250ZXh0IC0+IG1pZ3JhdGUgcGFnZS91cGRhdGUg
cGFnZSB0YWJsZS0+IHJlc3RvcmUgd2F2ZT8NCg0KQWxzbyB3aGVuIEkgY2hlY2sgbmF2aTEwIEdQ
VVZNIHByb2dyYW1taW5nIGd1aWRlLCBpdCBjbGVhcmx5IHNheXMgdGhhdCBjdXJyZW50bHkgdGhl
IFRyYW5zbGF0ZSBGdXJ0aGVyIChGKSBvcHRpb24gY2Fubm90IGJlIHVzZWQgaW4gY29uY2VydCB3
aXRoIHRoZSBQREUgYXMgUFRFIChQKSBvcHRpb24uIEJ1dCB0aGlzIHBhdGNoIHNldCBGIGFuZCBQ
Lg0KDQpTb3JyeSBmb3IgdG9vIG1hbnkgcXVlc3Rpb25zLg0KDQpSZWdhcmRzLA0KT2FrDQoNCi0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBhbWQtZ2Z4IDxhbWQtZ2Z4LWJvdW5jZXNA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnPiBPbiBCZWhhbGYgT2YgUGhpbGlwIFlhbmcNClNlbnQ6IEZy
aWRheSwgTm92ZW1iZXIgMTUsIDIwMTkgMTowNCBQTQ0KVG86IFNpZXJyYSBHdWl6YSwgQWxlamFu
ZHJvIChBbGV4KSA8QWxleC5TaWVycmFAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnDQpTdWJqZWN0OiBSZTogW1BBVENIXSBhbWQvYW1kZ3B1OiBmb3JjZSB0byB0cmlnZ2Vy
IGEgbm8tcmV0cnktZmF1bHQgYWZ0ZXIgYSByZXRyeS1mYXVsdA0KDQpPbmUgc3VnZ2VzdGlvbiBi
ZWxvdywgbW92ZSB0aGUgZmxhZ3Mgc2V0dGluZyBmb3IgZWxzZSBwYXRoIGludG8gZWxzZSBwYXRo
IGxvb2tzIGJldHRlci4NCg0KUGhpbGlwDQoNCk9uIDIwMTktMTEtMTUgMTI6NDMgcC5tLiwgQWxl
eCBTaWVycmEgd3JvdGU6DQo+IEFmdGVyIGEgcmV0cnktZmF1bHQgaGFwcGVucywgdGhlIGZhdWx0
IGhhbmRsZXIgd2lsbCBtb2RpZnkgdGhlIFVUQ0wyIA0KPiB0byBzZXQgUFRFIGJpdHMgdG8gZm9y
Y2UgYSBuby1yZXRyeS1mYXVsdC4gVGhpcyB3aWxsIGNhdXNlIHRoZSB3YXZlIHRvIA0KPiBlbnRl
ciB0aGUgdHJhcCBoYW5kbGVyLg0KPiANCj4gQ2hhbmdlLUlkOiBJMTc3MTAyODkxZjcxNTA2OGYx
NTYwNTk1N2ZmMjNiMGNhYjg2MjYwMw0KPiBTaWduZWQtb2ZmLWJ5OiBBbGV4IFNpZXJyYSA8YWxl
eC5zaWVycmFAYW1kLmNvbT4NCj4gLS0tDQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3ZtLmMgfCAxMyArKysrKy0tLS0tLS0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDUgaW5z
ZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYyANCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfdm0uYw0KPiBpbmRleCAzYzBiZDY0NzJhNDYuLmU0ZDFhOGZjOTdkNSAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMNCj4gKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMNCj4gQEAgLTMxNjcsNyAr
MzE2Nyw4IEBAIGJvb2wgYW1kZ3B1X3ZtX2hhbmRsZV9mYXVsdChzdHJ1Y3QgYW1kZ3B1X2Rldmlj
ZSAqYWRldiwgdW5zaWduZWQgaW50IHBhc2lkLA0KPiAgIAkJCSAgICB1aW50NjRfdCBhZGRyKQ0K
PiAgIHsNCj4gICAJc3RydWN0IGFtZGdwdV9ibyAqcm9vdDsNCj4gLQl1aW50NjRfdCB2YWx1ZSwg
ZmxhZ3M7DQo+ICsJdWludDY0X3QgdmFsdWUgPSAwOw0KPiArCXVpbnQ2NF90IGZsYWdzOw0KPiAg
IAlzdHJ1Y3QgYW1kZ3B1X3ZtICp2bTsNCj4gICAJbG9uZyByOw0KPiAgIA0KPiBAQCAtMzIwMCwx
MyArMzIwMSw5IEBAIGJvb2wgYW1kZ3B1X3ZtX2hhbmRsZV9mYXVsdChzdHJ1Y3QgYW1kZ3B1X2Rl
dmljZSAqYWRldiwgdW5zaWduZWQgaW50IHBhc2lkLA0KPiAgIAkJQU1ER1BVX1BURV9TWVNURU07
DQo+ICAgDQogPi0JZmxhZ3MgPSBBTURHUFVfUFRFX1ZBTElEIHwgQU1ER1BVX1BURV9TTk9PUEVE
IHwNCiA+LQkJQU1ER1BVX1BURV9TWVNURU07DQogPg0KPiAgIAlpZiAoYW1kZ3B1X3ZtX2ZhdWx0
X3N0b3AgPT0gQU1ER1BVX1ZNX0ZBVUxUX1NUT1BfTkVWRVIpIHsNCj4gLQkJLyogUmVkaXJlY3Qg
dGhlIGFjY2VzcyB0byB0aGUgZHVtbXkgcGFnZSAqLw0KPiAtCQl2YWx1ZSA9IGFkZXYtPmR1bW15
X3BhZ2VfYWRkcjsNCj4gLQkJZmxhZ3MgfD0gQU1ER1BVX1BURV9FWEVDVVRBQkxFIHwgQU1ER1BV
X1BURV9SRUFEQUJMRSB8DQo+IC0JCQlBTURHUFVfUFRFX1dSSVRFQUJMRTsNCiA+ICsJCS8qIFNl
dHRpbmcgUFRFIGZsYWdzIHRvIHRyaWdnZXIgYSBuby1yZXRyeS1mYXVsdCAgKi8NCiA+ICsJCWZs
YWdzID0gQU1ER1BVX1BURV9FWEVDVVRBQkxFIHwgQU1ER1BVX1BERV9QVEUgfA0KID4gKwkJCUFN
REdQVV9QVEVfVEY7DQoJfSBlbHNlIHsNCj4gLQkJdmFsdWUgPSAwOw0KID4rCQlmbGFncyA9IEFN
REdQVV9QVEVfVkFMSUQgfCBBTURHUFVfUFRFX1NOT09QRUQgfA0KID4rCQkJQU1ER1BVX1BURV9T
WVNURU07DQogPiAgIAl9DQoNCj4gICANCj4gICAJciA9IGFtZGdwdV92bV9ib191cGRhdGVfbWFw
cGluZyhhZGV2LCB2bSwgdHJ1ZSwgTlVMTCwgYWRkciwgYWRkciArIA0KPiAxLA0KPiANCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQphbWQtZ2Z4IG1haWxp
bmcgbGlzdA0KYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA0KX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4
