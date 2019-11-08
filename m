Return-Path: <SRS0=5//3=ZA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B79C5DF60
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Nov 2019 05:50:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E794F21848
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Nov 2019 05:50:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E794F21848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B646E6F83F;
	Fri,  8 Nov 2019 05:50:27 +0000 (UTC)
Received: from NAM05-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam05on0602.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe51::602])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88B146F83E
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Nov 2019 05:50:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bbf80c1p5AsvzPt1hqqOhXhQ5Ubr36Tit+tpBBvlJLKjVxBi4iwGXZoVsMUcrlJ8+u93lOAGIRoqpPzbx99nB1vgKNG9681hNY8fJ/gJjqtXOPmpPiEJBcKHVC6naoRGGFF5/iI4cE2Byw91PeYBAbCtpenacjuZLj6i4BHL3w9kMoAFXHHVcWG/bCcvYUhZUQXQUz0UwH4YXDLPOoGi9QsoILzksqEuau40oO0wHbeaeoJN/36yQP1Zd3vOphxP7AbOSh8SuBBeoBBvaB49RNJ6NRTctB7HXS9gUE/t4aMIv4yKvE6PO+KAWJYI2gUimHJGxg6Bg5YX8pVX7SXvIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cdAemKu4iZqkSYu49bvYi1V2npUU87Hw5WHwV0GClJQ=;
 b=UJqoFFS/yH2CTdotae7iexxhMGWdLjsiF3jHpqFqk1bYXqIZ9cS+siKQq36AiHQEKoieVJ/Ejb1w6zHvYEaiJCQJhAZ5YGJrz26iCtOhS3EoSob9DejfXVUf+0WUFxG0JN3O1MJFCtR8jcrGJGdgsMow7KJ8eRl2nJulHP9SlR73ztdK/R+dJE4C7Hs99IKSLUMMvixPALh6oyUOGIqHsiNFD4I8as6M7CYC5Up8P1H6514ismqjQ0H3PnGuEretkpjF24iIoZboX8JJvmhUT9Zf5yAgViR67sxGlIaOG4Ri67ZXugYdB/oTspti/cfLNHHC02CufeF0kn2BBwiZbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB2973.namprd12.prod.outlook.com (20.178.243.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Fri, 8 Nov 2019 05:50:25 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::5895:bbd8:c1d6:1587]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::5895:bbd8:c1d6:1587%7]) with mapi id 15.20.2430.020; Fri, 8 Nov 2019
 05:50:25 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Matt Coffin <mcoffin13@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 3/3] drm/amdgpu/navi10: Implement od clk printing
Thread-Topic: [PATCH 3/3] drm/amdgpu/navi10: Implement od clk printing
Thread-Index: AQHVlZov/VELVkp09EGVQvqt6kxZ/qeAxY7w
Date: Fri, 8 Nov 2019 05:50:24 +0000
Message-ID:
 <MN2PR12MB33445795B5D56A9D1946D1A0E47B0@MN2PR12MB3344.namprd12.prod.outlook.com>
References: <cover.1573151434.git.mcoffin13@gmail.com>
 <e091c4085ecc669ea907fe5d8515f14586863f9b.1573151434.git.mcoffin13@gmail.com>
In-Reply-To: <e091c4085ecc669ea907fe5d8515f14586863f9b.1573151434.git.mcoffin13@gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d770716d-023c-4d34-4166-08d7640f8d26
x-ms-traffictypediagnostic: MN2PR12MB2973:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <MN2PR12MB2973549502A32E1476C96B93E47B0@MN2PR12MB2973.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-forefront-prvs: 0215D7173F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(136003)(366004)(396003)(346002)(376002)(199004)(189003)(13464003)(316002)(6436002)(99286004)(256004)(6246003)(305945005)(229853002)(7736002)(8676002)(52536014)(81156014)(81166006)(110136005)(71190400001)(14454004)(25786009)(74316002)(186003)(478600001)(6306002)(33656002)(102836004)(66556008)(966005)(76116006)(66476007)(64756008)(66446008)(9686003)(66066001)(66946007)(8936002)(5660300002)(71200400001)(6116002)(486006)(86362001)(76176011)(6506007)(7696005)(446003)(55016002)(476003)(2501003)(53546011)(11346002)(3846002)(2906002)(26005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB2973;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rTWg2mtzMcfawLwOVbWleKbjAmo9UYzJVhIkN76DZovN/40i63O1rUbMIDTTbvQwK2dXb1vM7gAfU+B0g9jWp1XXLsUhg7cGYKssl+rYsyAzLDYvRKUjFKhdUDcAxdiuoRDyBE7BCqha+B0rgosOJwUWgaclbiyg8PhrDm91Dk0KMxnW8FWVnHgSP0HUjz8vFvEWhgsrSFSgL0jS8cDap4eRgFX8zw31a7Yzn7a1/EMYUSVFKvu4FJjNnoL3FTkt8EK0rEh555gtNy073MNcKL5wWDUfBsEFK0O4FkeQvAP2SmICHYz2wJGMHbXS3XWvOKeK/oFt32/8A7izbiM/yU1KBI9LnGtwlKepvfqOSdd1B1JKK/RDR9KnYzYOcnZJs3KB92J15+rQUXwpFYq8hnxHJFtgxhs+Qibt4gJ9ghv64Wd3jKy2Fvrdk1QJXOOzS5sklZmhnbr6jBVTu7V67d29miYYC+joExk1g+FQCOk=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d770716d-023c-4d34-4166-08d7640f8d26
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2019 05:50:24.9817 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T9XWkAiHdVXe2p72jg2fN4bN09x8J2JR6SnmDtzuptt6/TvEstlndsPZZIX6MncL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2973
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cdAemKu4iZqkSYu49bvYi1V2npUU87Hw5WHwV0GClJQ=;
 b=APiLY6LGMpvverrREFK1/iGnimNvqoSUhD7zDEJ4MiS2K+l1la8dyZ2ckKyo9a4JIm6Ib8+Dm7sAdzaOwL0FcfM61AQ85L8AEfMeuWI0vyW+cw3q4ja4RqEDw1jozXaFx2mw2VwwQrBL+DD8PortnOmlBvRChBrbNki9VUAgkuI=
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191108055024.ovJXEY4ofVy_dqLFfGcBIJ05u_BRSbpURilZ9ps5XHE@z>

UmV2aWV3ZWQtYnk6IEV2YW4gUXVhbiA8ZXZhbi5xdWFuQGFtZC5jb20+DQoNCj4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogYW1kLWdmeCA8YW1kLWdmeC1ib3VuY2VzQGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZz4gT24gQmVoYWxmIE9mIE1hdHQNCj4gQ29mZmluDQo+IFNlbnQ6IEZy
aWRheSwgTm92ZW1iZXIgOCwgMjAxOSAyOjM2IEFNDQo+IFRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZw0KPiBDYzogTWF0dCBDb2ZmaW4gPG1jb2ZmaW4xM0BnbWFpbC5jb20+DQo+IFN1
YmplY3Q6IFtQQVRDSCAzLzNdIGRybS9hbWRncHUvbmF2aTEwOiBJbXBsZW1lbnQgb2QgY2xrIHBy
aW50aW5nDQo+IA0KPiBbV2h5XQ0KPiBCZWZvcmUgdGhpcyBwYXRjaCwgbmF2aTEwIG92ZXJkcml2
ZSBzZXR0aW5ncyBjb3VsZCBub3QgYmUgcHJpbnRlZCB2aWENCj4gcHBfb2RfY2xrX3ZvbHRhZ2UN
Cj4gDQo+IFtIb3ddDQo+IEltcGxlbWVudCBwcmludGluZyBmb3IgdGhlIG92ZXJkcml2ZSBzZXR0
aW5ncyBmb3IgdGhlIGZvbGxvd2luZyBjbG9ja3MgaW4NCj4gbmF2aTEwJ3MgcHB0IHByaW50X2Ns
a19sZXZlbHMgaW1wbGVtZW50YXRpb246DQo+IA0KPiAqIFNNVV9PRF9TQ0xLDQo+ICogU01VX09E
X01DTEsNCj4gKiBTTVVfT0RfVkREQ19DVVJWRQ0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9h
bWQvcG93ZXJwbGF5L25hdmkxMF9wcHQuYyB8IDU2ICsrKysrKysrKysrKysrKysrKysrLS0NCj4g
IDEgZmlsZSBjaGFuZ2VkLCA1MSBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L25hdmkxMF9wcHQuYw0K
PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L25hdmkxMF9wcHQuYw0KPiBpbmRleCBl
NzE3MzI4ZjkzY2UuLjUwNmFmNTlmZjQ1ZiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9wb3dlcnBsYXkvbmF2aTEwX3BwdC5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
cG93ZXJwbGF5L25hdmkxMF9wcHQuYw0KPiBAQCAtNjc3LDEzICs2NzcsMjUgQEAgc3RhdGljIGJv
b2wNCj4gbmF2aTEwX2lzX3N1cHBvcnRfZmluZV9ncmFpbmVkX2RwbShzdHJ1Y3Qgc211X2NvbnRl
eHQgKnNtdSwgZW51bSBzbXUNCj4gIAlyZXR1cm4gZHBtX2Rlc2MtPlNuYXBUb0Rpc2NyZXRlID09
IDAgPyB0cnVlIDogZmFsc2U7ICB9DQo+IA0KPiArc3RhdGljIGlubGluZSBib29sIG5hdmkxMF9v
ZF9mZWF0dXJlX2lzX3N1cHBvcnRlZChzdHJ1Y3QNCj4gK3NtdV8xMV8wX292ZXJkcml2ZV90YWJs
ZSAqb2RfdGFibGUsIGVudW0gU01VXzExXzBfT0RGRUFUVVJFX0lEDQo+IGZlYXR1cmUpIHsNCj4g
KwlyZXR1cm4gb2RfdGFibGUtPmNhcFtmZWF0dXJlXTsNCj4gK30NCj4gKw0KPiArDQo+ICBzdGF0
aWMgaW50IG5hdmkxMF9wcmludF9jbGtfbGV2ZWxzKHN0cnVjdCBzbXVfY29udGV4dCAqc211LA0K
PiAgCQkJZW51bSBzbXVfY2xrX3R5cGUgY2xrX3R5cGUsIGNoYXIgKmJ1ZikgIHsNCj4gKwlPdmVy
RHJpdmVUYWJsZV90ICpvZF90YWJsZTsNCj4gKwlzdHJ1Y3Qgc211XzExXzBfb3ZlcmRyaXZlX3Rh
YmxlICpvZF9zZXR0aW5nczsNCj4gKwl1aW50MTZfdCAqY3VydmVfc2V0dGluZ3M7DQo+ICAJaW50
IGksIHNpemUgPSAwLCByZXQgPSAwOw0KPiAgCXVpbnQzMl90IGN1cl92YWx1ZSA9IDAsIHZhbHVl
ID0gMCwgY291bnQgPSAwOw0KPiAgCXVpbnQzMl90IGZyZXFfdmFsdWVzWzNdID0gezB9Ow0KPiAg
CXVpbnQzMl90IG1hcmtfaW5kZXggPSAwOw0KPiArCXN0cnVjdCBzbXVfdGFibGVfY29udGV4dCAq
dGFibGVfY29udGV4dCA9ICZzbXUtPnNtdV90YWJsZTsNCj4gKwlvZF90YWJsZSA9IChPdmVyRHJp
dmVUYWJsZV90ICopdGFibGVfY29udGV4dC0+b3ZlcmRyaXZlX3RhYmxlOw0KPiArCW9kX3NldHRp
bmdzID0gc211LT5vZF9zZXR0aW5nczsNCj4gDQo+ICAJc3dpdGNoIChjbGtfdHlwZSkgew0KPiAg
CWNhc2UgU01VX0dGWENMSzoNCj4gQEAgLTczNCw2ICs3NDYsNDUgQEAgc3RhdGljIGludCBuYXZp
MTBfcHJpbnRfY2xrX2xldmVscyhzdHJ1Y3Qgc211X2NvbnRleHQNCj4gKnNtdSwNCj4gDQo+ICAJ
CX0NCj4gIAkJYnJlYWs7DQo+ICsJY2FzZSBTTVVfT0RfU0NMSzoNCj4gKwkJaWYgKCFzbXUtPm9k
X2VuYWJsZWQgfHwgIW9kX3RhYmxlIHx8ICFvZF9zZXR0aW5ncykNCj4gKwkJCWJyZWFrOw0KPiAr
CQlpZiAoIW5hdmkxMF9vZF9mZWF0dXJlX2lzX3N1cHBvcnRlZChvZF9zZXR0aW5ncywNCj4gU01V
XzExXzBfT0RGRUFUVVJFX0dGWENMS19MSU1JVFMpKQ0KPiArCQkJYnJlYWs7DQo+ICsJCXNpemUg
Kz0gc3ByaW50ZihidWYgKyBzaXplLCAiT0RfU0NMSzpcbiIpOw0KPiArCQlzaXplICs9IHNwcmlu
dGYoYnVmICsgc2l6ZSwgIjA6ICV1TWh6XG4xOiAldU1oelxuIiwgb2RfdGFibGUtDQo+ID5HZnhj
bGtGbWluLCBvZF90YWJsZS0+R2Z4Y2xrRm1heCk7DQo+ICsJCWJyZWFrOw0KPiArCWNhc2UgU01V
X09EX01DTEs6DQo+ICsJCWlmICghc211LT5vZF9lbmFibGVkIHx8ICFvZF90YWJsZSB8fCAhb2Rf
c2V0dGluZ3MpDQo+ICsJCQlicmVhazsNCj4gKwkJaWYgKCFuYXZpMTBfb2RfZmVhdHVyZV9pc19z
dXBwb3J0ZWQob2Rfc2V0dGluZ3MsDQo+IFNNVV8xMV8wX09ERkVBVFVSRV9VQ0xLX01BWCkpDQo+
ICsJCQlicmVhazsNCj4gKwkJc2l6ZSArPSBzcHJpbnRmKGJ1ZiArIHNpemUsICJPRF9NQ0xLOlxu
Iik7DQo+ICsJCXNpemUgKz0gc3ByaW50ZihidWYgKyBzaXplLCAiMDogJXVNSHpcbiIsIG9kX3Rh
YmxlLT5VY2xrRm1heCk7DQo+ICsJCWJyZWFrOw0KPiArCWNhc2UgU01VX09EX1ZERENfQ1VSVkU6
DQo+ICsJCWlmICghc211LT5vZF9lbmFibGVkIHx8ICFvZF90YWJsZSB8fCAhb2Rfc2V0dGluZ3Mp
DQo+ICsJCQlicmVhazsNCj4gKwkJaWYgKCFuYXZpMTBfb2RfZmVhdHVyZV9pc19zdXBwb3J0ZWQo
b2Rfc2V0dGluZ3MsDQo+IFNNVV8xMV8wX09ERkVBVFVSRV9HRlhDTEtfQ1VSVkUpKQ0KPiArCQkJ
YnJlYWs7DQo+ICsJCXNpemUgKz0gc3ByaW50ZihidWYgKyBzaXplLCAiT0RfVkREQ19DVVJWRTpc
biIpOw0KPiArCQlmb3IgKGkgPSAwOyBpIDwgMzsgaSsrKSB7DQo+ICsJCQlzd2l0Y2ggKGkpIHsN
Cj4gKwkJCWNhc2UgMDoNCj4gKwkJCQljdXJ2ZV9zZXR0aW5ncyA9ICZvZF90YWJsZS0+R2Z4Y2xr
RnJlcTE7DQo+ICsJCQkJYnJlYWs7DQo+ICsJCQljYXNlIDE6DQo+ICsJCQkJY3VydmVfc2V0dGlu
Z3MgPSAmb2RfdGFibGUtPkdmeGNsa0ZyZXEyOw0KPiArCQkJCWJyZWFrOw0KPiArCQkJY2FzZSAy
Og0KPiArCQkJCWN1cnZlX3NldHRpbmdzID0gJm9kX3RhYmxlLT5HZnhjbGtGcmVxMzsNCj4gKwkJ
CQlicmVhazsNCj4gKwkJCWRlZmF1bHQ6DQo+ICsJCQkJYnJlYWs7DQo+ICsJCQl9DQo+ICsJCQlz
aXplICs9IHNwcmludGYoYnVmICsgc2l6ZSwgIiVkOiAldU1IeiBAICV1bVZcbiIsIGksDQo+IGN1
cnZlX3NldHRpbmdzWzBdLCBjdXJ2ZV9zZXR0aW5nc1sxXSAvIE5BVkkxMF9WT0xUQUdFX1NDQUxF
KTsNCj4gKwkJfQ0KPiArCQlicmVhazsNCj4gIAlkZWZhdWx0Og0KPiAgCQlicmVhazsNCj4gIAl9
DQo+IEBAIC0xNjAwLDExICsxNjUxLDYgQEAgc3RhdGljIGlubGluZSB2b2lkDQo+IG5hdmkxMF9k
dW1wX29kX3RhYmxlKE92ZXJEcml2ZVRhYmxlX3QgKm9kX3RhYmxlKSB7DQo+ICAJcHJfZGVidWco
Ik9EOiBPdmVyRHJpdmVQY3Q6ICVkXG4iLCBvZF90YWJsZS0+T3ZlckRyaXZlUGN0KTsgIH0NCj4g
DQo+IC1zdGF0aWMgaW5saW5lIGJvb2wgbmF2aTEwX29kX2ZlYXR1cmVfaXNfc3VwcG9ydGVkKHN0
cnVjdA0KPiBzbXVfMTFfMF9vdmVyZHJpdmVfdGFibGUgKm9kX3RhYmxlLCBlbnVtIFNNVV8xMV8w
X09ERkVBVFVSRV9JRA0KPiBmZWF0dXJlKSAtew0KPiAtCXJldHVybiBvZF90YWJsZS0+Y2FwW2Zl
YXR1cmVdOw0KPiAtfQ0KPiAtDQo+ICBzdGF0aWMgaW50IG5hdmkxMF9vZF9zZXR0aW5nX2NoZWNr
X3JhbmdlKHN0cnVjdCBzbXVfMTFfMF9vdmVyZHJpdmVfdGFibGUNCj4gKm9kX3RhYmxlLCBlbnVt
IFNNVV8xMV8wX09EU0VUVElOR19JRCBzZXR0aW5nLCB1aW50MzJfdCB2YWx1ZSkgIHsNCj4gIAlp
ZiAodmFsdWUgPCBvZF90YWJsZS0+bWluW3NldHRpbmddKSB7DQo+IC0tDQo+IDIuMjMuMA0KPiAN
Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4gYW1k
LWdmeCBtYWlsaW5nIGxpc3QNCj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4DQpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxp
bmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
