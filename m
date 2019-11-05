Return-Path: <SRS0=U5eA=Y5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBD13C5DF60
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2019 19:04:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7040217F4
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2019 19:04:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7040217F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 576516E120;
	Tue,  5 Nov 2019 19:04:15 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680074.outbound.protection.outlook.com [40.107.68.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94ABD6E120
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Nov 2019 19:04:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kXC2fM+k3bXMmcV5m+g4OwTccTwsFwqxAImocL2BcNgfHbM8d5bypGVrlfUh46JSIonBZMTUDdf8MdeANLdv8DyabK9DS+GtwIg4hj/W8yg9Beu6gsfvIh61ieviyDtF1YJjIHIXnLvZ0eH4cI4EgUKU8VGeInDYO4mmyiP/eKBO+DSsobBt95febPmKpFkFs5fM+e0+eOjb8SJHFrwdRsgYUtFjrjoQgXhdKBh/LCOdA2pZA4rvUISy2lbv9zFGkQ7YPcUL0Em8M3r4gR9P4hwQ5hNZlU4MQylL01dlES45F4IS7gCOS4aBOyUAsOvccAlycEdWoXjETwPZF9hmhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sCkUYqUjzvWk2dvGjfjoRrZ0t9tomN7QEWEmEyrI85M=;
 b=GwwKN6FLxqPgkCw/VvbpbgREpa8928mRWjFvL5EX+/6Y06Q6HM+4CBhvqFxMqWSsNM38vLLx7h2cJ10qNuq5zZeA5wpJpjmE0FNnGi+oB81uSiHTzMBgKfd+auvUVRlg7DwYMLzy9LRS/a3nYnK9zgOqQf+7bR9f2lEFMl9hE+g9bRHfFwaUiT0oJiCqUW1Kz3Px1A8hptkSn4DPvXHnZhK5I6sea8OxresqYHMiOQyueKVT2eaj2EUYpOmwqBmB6ZMTNKPOJYFQROeotUUeogMsiphLRz0rfg6OhffDR79OB1up8aIxFp5+9Ft0jOZHG9e6mp40jfJMuLojZfKRnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BN7PR12MB2593.namprd12.prod.outlook.com (20.176.27.87) by
 BN7PR12MB2707.namprd12.prod.outlook.com (20.176.177.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Tue, 5 Nov 2019 19:04:11 +0000
Received: from BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::c9fd:22d8:cfdb:f430]) by BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::c9fd:22d8:cfdb:f430%5]) with mapi id 15.20.2408.024; Tue, 5 Nov 2019
 19:04:11 +0000
From: "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v3] drm/amd/display: Disable VUpdate interrupt for DCN
 hardware
Thread-Topic: [PATCH v3] drm/amd/display: Disable VUpdate interrupt for DCN
 hardware
Thread-Index: AQHVlAt8P2niyC+L1USC9TUKTCJu/ad874AA
Date: Tue, 5 Nov 2019 19:04:11 +0000
Message-ID: <c87d84cf-60f6-cca2-e8e0-a021b6215af0@amd.com>
References: <20191105155802.1302-1-sunpeng.li@amd.com>
 <20191105190147.7283-1-sunpeng.li@amd.com>
In-Reply-To: <20191105190147.7283-1-sunpeng.li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YTOPR0101CA0052.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::29) To BN7PR12MB2593.namprd12.prod.outlook.com
 (2603:10b6:408:25::23)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.55.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d11da0de-9ca8-4a35-9286-08d76222ef69
x-ms-traffictypediagnostic: BN7PR12MB2707:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN7PR12MB270770C8F02AB970C2CB94BB827E0@BN7PR12MB2707.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0212BDE3BE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(346002)(39860400002)(396003)(366004)(376002)(199004)(189003)(54906003)(76176011)(8676002)(305945005)(2351001)(6512007)(7736002)(2906002)(478600001)(4326008)(6246003)(52116002)(14444005)(5640700003)(186003)(71200400001)(71190400001)(53546011)(26005)(6436002)(6486002)(256004)(6506007)(6116002)(3846002)(229853002)(102836004)(66556008)(66946007)(66446008)(66476007)(2616005)(81166006)(486006)(476003)(66066001)(64756008)(386003)(316002)(36756003)(81156014)(25786009)(86362001)(31686004)(2501003)(31696002)(5660300002)(14454004)(99286004)(446003)(11346002)(6916009)(8936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN7PR12MB2707;
 H:BN7PR12MB2593.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I2zvGqSwAatOGPqssaRIkeidouCi2T8YJdD3eEwGnBU7DY3AEmtterDPf6279w/9XdwBsO2MrQS1ctu1aQqbvkoAZxMXECXotGD9e51q+gBhHmiJhmq+ffUbu68r1z/aXlm8RqlD9XjmLwA23eBhJvl1U680pzOkBTC87E8rqP/tbzJ/YLWX2QdsN36ULwCTOMXAqMHMhxKbbd16KPH5tFoTKkzgHtEtls4eHY0HgWR7TTtf/dbhOkQ+BJEayTy/1zNta9J02CtmivH0x28qjwK/lYu3bubKTL3vY91igrPZXb9eOM5haEFgRyjgUkJk94JaP+/bsqEcAM8l5koExo+crtEgNuwQUTT5pwWLzY5cxzkBG8PEm4wPNBya+ptvjqkRhzIBw55tafubylkw3XzBdkuZ9pVn23tKVoES+oWeqN3lPxhW709L08jSADy2
Content-ID: <7DB4BF49FEFDA34A8E8C2E5D9D5BD5BE@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d11da0de-9ca8-4a35-9286-08d76222ef69
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2019 19:04:11.0361 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zHMwJbUf5HQldwgpGsnhRMqnQXA21njdtIO63Zp6iGwqLX7faYOhok/dI3JgsNZ8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2707
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sCkUYqUjzvWk2dvGjfjoRrZ0t9tomN7QEWEmEyrI85M=;
 b=cJ6E3QvKgS/T/YuZ8JLlhVfBpr+DMPIYr+GCuZE4WSvjimjgQNe8xweEhZZBsNtBYbaXliqeV5Unf29a0cIci8xY0ALBsHZLrQ8PmWLkRtp3Cr7impbEzvgUBOu3N9wfnK8InA61A2uMv2cKY25kQXlzY2EV39s8bkkH0VsNuQI=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Sunpeng.Li@amd.com; 
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
Cc: "mario.kleiner.de@gmail.com" <mario.kleiner.de@gmail.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "Kazlauskas,
 Nicholas" <Nicholas.Kazlauskas@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191105190411.3GDWKmoLH35uDqXpAX0qe5ntFjD8v6GOPiSsyYpQWVo@z>

DQoNCk9uIDIwMTktMTEtMDUgMjowMSBwLm0uLCBzdW5wZW5nLmxpQGFtZC5jb20gd3JvdGU6DQo+
IEZyb206IExlbyBMaSA8c3VucGVuZy5saUBhbWQuY29tPg0KPiANCj4gW1doeV0NCj4gDQo+IE9u
IERDTiBoYXJkd2FyZSwgdGhlIGNydGNfaGlnaF9pcnEgaGFuZGxlciBtYWtlcyB2dXBkYXRlX2hp
Z2hfaXJxDQo+IGhhbmRsZXIgcmVkdW5kYW50Lg0KPiANCj4gQWxsIHRoZSB2dXBkYXRlIGhhbmRs
ZXIgZG9lcyBpcyBoYW5kbGUgdmJsYW5rIGV2ZW50cywgYW5kIHVwZGF0ZSB2cnINCj4gZm9yIERD
RSBodyAoZXhjbHVkaW5nIFZFR0EsIG1vcmUgb24gdGhhdCBsYXRlcikuIEFzIGZhciBhcyB1c2Vy
bW9kZSBpcw0KPiBjb25jZXJuZWQuIHZzdGFydHVwIGhhcHBlbnMgY2xvc2UgZW5vdWdoIHRvIHZ1
cGRhdGUgb24gRENOIHRoYXQgaXQgY2FuDQo+IGJlIGNvbnNpZGVyZWQgdGhlICJzYW1lIi4gSGFu
ZGxpbmcgdmJsYW5rIGFuZCB1cGRhdGluZyB2cnIgYXQgdnN0YXJ0dXANCj4gZWZmZWN0aXZlbHkg
cmVwbGFjZXMgdnVwZGF0ZSBvbiBEQ04uDQo+IA0KPiBWZWdhIGlzIGEgYml0IHNwZWNpYWwuIExp
a2UgRENOLCB0aGUgVlJSIHJlZ2lzdGVycyBvbiBWZWdhIGFyZQ0KPiBkb3VibGUtYnVmZmVyZWQs
IGFuZCBzd2FwcGVkIGF0IHZ1cGRhdGUuIEJ1dCBVbmxpa2UgRENOLCBpdCBsYWNrcyBhDQo+IHZz
dGFydHVwIGludGVycnVwdC4gVGhpcyBtZWFucyB3ZSBjYW4ndCBxdWl0ZSByZW1vdmUgdGhlIHZ1
cGRhdGUgaGFuZGxlcg0KPiBmb3IgaXQsIHNpbmNlIGRlbGF5ZWQgdXNlciBldmVudHMgZHVlIHRv
IHZyciBhcmUgc2VudCBvZmYgdGhlcmUuDQo+IA0KPiBbSG93XQ0KPiANCj4gUmVtb3ZlIHJlZ2lz
dHJhdGlvbiBvZiB2dXBkYXRlIGludGVycnVwdCBoYW5kbGVyIGZvciBEQ04uIERpc2FibGUNCj4g
dnVwZGF0ZSBpbnRlcnJ1cHQgaWYgYXNpYyBmYW1pbHkgRENOLCBlbmFibGUgb3RoZXJ3aXNlLg0K
PiANCj4gU2lnbmVkLW9mZi1ieTogTGVvIExpIDxzdW5wZW5nLmxpQGFtZC5jb20+DQo+IC0tLQ0K
PiANCj4gdjI6IERvbid0IGV4Y2x1ZGUgdmVnYSB3aGVuIGVuYWJsaW5nIHZ1cGRhdGUgaW50ZXJy
dXB0cw0KPiANCj4gdjM6IE1vdmUgRkFNSUxZX0FJIGNoZWNrIGluc2lkZSBkbV9zZXRfdnVwZGF0
ZV9pcnEoKQ0KPiANCj4gIC4uLi9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVf
ZG0uYyB8IDMyICsrKy0tLS0tLS0tLS0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2Vy
dGlvbnMoKyksIDI4IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jDQo+IGluZGV4IDI1NmEyM2EwZWMyOC4u
ZDQwMTg1ZGZkMGMwIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkv
YW1kZ3B1X2RtL2FtZGdwdV9kbS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxh
eS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMNCj4gQEAgLTIyNDEsMzQgKzIyNDEsNiBAQCBzdGF0aWMg
aW50IGRjbjEwX3JlZ2lzdGVyX2lycV9oYW5kbGVycyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRl
dikNCj4gIAkJCQlkbV9kY25fY3J0Y19oaWdoX2lycSwgY19pcnFfcGFyYW1zKTsNCj4gIAl9DQo+
ICANCj4gLQkvKiBVc2UgVlVQREFURV9OT19MT0NLIGludGVycnVwdCBvbiBEQ04sIHdoaWNoIHNl
ZW1zIHRvIGNvcnJlc3BvbmQgdG8NCj4gLQkgKiB0aGUgcmVndWxhciBWVVBEQVRFIGludGVycnVw
dCBvbiBEQ0UuIFdlIHdhbnQgRENfSVJRX1NPVVJDRV9WVVBEQVRFeA0KPiAtCSAqIHRvIHRyaWdn
ZXIgYXQgZW5kIG9mIGVhY2ggdmJsYW5rLCByZWdhcmRsZXNzIG9mIHN0YXRlIG9mIHRoZSBsb2Nr
LA0KPiAtCSAqIG1hdGNoaW5nIERDRSBiZWhhdmlvdXIuDQo+IC0JICovDQo+IC0JZm9yIChpID0g
RENOXzFfMF9fU1JDSURfX09URzBfSUhDX1ZfVVBEQVRFX05PX0xPQ0tfSU5URVJSVVBUOw0KPiAt
CSAgICAgaSA8PSBEQ05fMV8wX19TUkNJRF9fT1RHMF9JSENfVl9VUERBVEVfTk9fTE9DS19JTlRF
UlJVUFQgKyBhZGV2LT5tb2RlX2luZm8ubnVtX2NydGMgLSAxOw0KPiAtCSAgICAgaSsrKSB7DQo+
IC0JCXIgPSBhbWRncHVfaXJxX2FkZF9pZChhZGV2LCBTT0MxNV9JSF9DTElFTlRJRF9EQ0UsIGks
ICZhZGV2LT52dXBkYXRlX2lycSk7DQo+IC0NCj4gLQkJaWYgKHIpIHsNCj4gLQkJCURSTV9FUlJP
UigiRmFpbGVkIHRvIGFkZCB2dXBkYXRlIGlycSBpZCFcbiIpOw0KPiAtCQkJcmV0dXJuIHI7DQo+
IC0JCX0NCj4gLQ0KPiAtCQlpbnRfcGFyYW1zLmludF9jb250ZXh0ID0gSU5URVJSVVBUX0hJR0hf
SVJRX0NPTlRFWFQ7DQo+IC0JCWludF9wYXJhbXMuaXJxX3NvdXJjZSA9DQo+IC0JCQlkY19pbnRl
cnJ1cHRfdG9faXJxX3NvdXJjZShkYywgaSwgMCk7DQo+IC0NCj4gLQkJY19pcnFfcGFyYW1zID0g
JmFkZXYtPmRtLnZ1cGRhdGVfcGFyYW1zW2ludF9wYXJhbXMuaXJxX3NvdXJjZSAtIERDX0lSUV9T
T1VSQ0VfVlVQREFURTFdOw0KPiAtDQo+IC0JCWNfaXJxX3BhcmFtcy0+YWRldiA9IGFkZXY7DQo+
IC0JCWNfaXJxX3BhcmFtcy0+aXJxX3NyYyA9IGludF9wYXJhbXMuaXJxX3NvdXJjZTsNCj4gLQ0K
PiAtCQlhbWRncHVfZG1faXJxX3JlZ2lzdGVyX2ludGVycnVwdChhZGV2LCAmaW50X3BhcmFtcywN
Cj4gLQkJCQlkbV92dXBkYXRlX2hpZ2hfaXJxLCBjX2lycV9wYXJhbXMpOw0KPiAtCX0NCj4gLQ0K
PiAgCS8qIFVzZSBHUlBIX1BGTElQIGludGVycnVwdCAqLw0KPiAgCWZvciAoaSA9IERDTl8xXzBf
X1NSQ0lEX19IVUJQMF9GTElQX0lOVEVSUlVQVDsNCj4gIAkJCWkgPD0gRENOXzFfMF9fU1JDSURf
X0hVQlAwX0ZMSVBfSU5URVJSVVBUICsgYWRldi0+bW9kZV9pbmZvLm51bV9jcnRjIC0gMTsNCj4g
QEAgLTQyNDksNiArNDIyMSwxMCBAQCBzdGF0aWMgaW5saW5lIGludCBkbV9zZXRfdnVwZGF0ZV9p
cnEoc3RydWN0IGRybV9jcnRjICpjcnRjLCBib29sIGVuYWJsZSkNCj4gIAlzdHJ1Y3QgYW1kZ3B1
X2RldmljZSAqYWRldiA9IGNydGMtPmRldi0+ZGV2X3ByaXZhdGU7DQo+ICAJaW50IHJjOw0KPiAg
DQo+ICsJLyogRG8gbm90IHNldCB2dXBkYXRlIGZvciBEQ04gaGFyZHdhcmUgKi8NCj4gKwlpZiAo
YWRldi0+ZmFtaWx5IDw9IEFNREdQVV9GQU1JTFlfQUkpDQoNCkVyciwgbm8uIHMvPD0vPi8uLi4N
Cg0KTGVvDQoNCj4gKwkJcmV0dXJuIDA7DQo+ICsNCj4gIAlpcnFfc291cmNlID0gSVJRX1RZUEVf
VlVQREFURSArIGFjcnRjLT5vdGdfaW5zdDsNCj4gIA0KPiAgCXJjID0gZGNfaW50ZXJydXB0X3Nl
dChhZGV2LT5kbS5kYywgaXJxX3NvdXJjZSwgZW5hYmxlKSA/IDAgOiAtRUJVU1k7DQo+IA0KX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWls
aW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
