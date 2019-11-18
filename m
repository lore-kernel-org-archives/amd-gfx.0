Return-Path: <SRS0=5Use=ZK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC74FC432C0
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Nov 2019 09:19:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0C0C2067D
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Nov 2019 09:19:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0C0C2067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 585EA89DA5;
	Mon, 18 Nov 2019 09:19:05 +0000 (UTC)
Received: from NAM05-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr720074.outbound.protection.outlook.com [40.107.72.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4231E89568
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Nov 2019 09:19:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZYDQ8Q0/Od/TXD2GFpsi0miUB2Aqjgd2fo4KTzuKVazpYWdbaEEfwUQM5WwbUf5mVb/HgphsFq8aYLTN38gGWLIWenZUGcpxl8PwIGFBuxpuuDQMHAGykNaQ620vEgr4H8FhSQ/Is9iK4XxuUNLG8aMQTXGxzWTbB3qYE3bBueYdwoo7l8shJIPrvFPkcqkcr5xrlFns7lJ9gT26etkTslFMoDQUQOvc+WVgD82uwD90fhuwEIGhtqcxshoNS7s4lZyRylHUjqTa3agnGPi/4ZRaM+BGyyUdNu6Um6pzSIUUoMq2e/CEn/6LZ8IC/jdFTTyiFh5r5IkdAgKp3LuCiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wpCF8YeNpvweguhrsLTP9xHE3hJYYmZwUJtOryZyqOs=;
 b=ian8Q0FFzfZJdYTbe+CymLb12h55dwmg7TiIGG2H60Fj+ZkzY4LeTXYb1CZ3rRGMUL4MRj+Bdi+CGjNfoxEKAOiWksBmgY/Lxnu0EoKkt8E/OE8+B5QMjXErAOtllA5ufCEshlt6ZQJkzHvN4PA3xcLzAo4LRUU+aZ9xOlFtzhT3Ya8bO/TytMyr6k6lgGU9QMWf25oDI3z60tCCyLl3O1DFtEGOjG5TnPeZy3xF7bD8KCaooZfKRiuk4iCfMIhu3zj87PEnVZ2ScK8uiZGwGmSaS3UnJRwUB3ly1UGKh/d9PiaBuR37vsQxIRrjZtn5EKjr1tXb6YYQ4BlWdmQtfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3838.namprd12.prod.outlook.com (10.255.238.203) by
 MN2PR12MB3856.namprd12.prod.outlook.com (10.255.237.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Mon, 18 Nov 2019 09:19:01 +0000
Received: from MN2PR12MB3838.namprd12.prod.outlook.com
 ([fe80::c98f:c517:b396:1bd4]) by MN2PR12MB3838.namprd12.prod.outlook.com
 ([fe80::c98f:c517:b396:1bd4%7]) with mapi id 15.20.2451.029; Mon, 18 Nov 2019
 09:19:01 +0000
From: "Liu, Aaron" <Aaron.Liu@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Huang, Ray"
 <Ray.Huang@amd.com>
Subject: RE: [PATCH 07/12] amdgpu: using IB flags for TMZ or non-TMZ
Thread-Topic: [PATCH 07/12] amdgpu: using IB flags for TMZ or non-TMZ
Thread-Index: AQHVm2W+tu3P7fNTZUOSJK7AmgL4R6eL+F2AgAA3WACABHZa4A==
Date: Mon, 18 Nov 2019 09:19:01 +0000
Message-ID:
 <MN2PR12MB3838B600C9A44A584ECFF53EF04D0@MN2PR12MB3838.namprd12.prod.outlook.com>
References: <1573788895-3936-1-git-send-email-aaron.liu@amd.com>
 <1573788895-3936-7-git-send-email-aaron.liu@amd.com>
 <20191115093220.GA20622@ray.huang@amd.com>
 <ea9f95d8-a444-270c-85e6-ab062954320f@amd.com>
In-Reply-To: <ea9f95d8-a444-270c-85e6-ab062954320f@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 565075f6-9951-44f4-2682-08d76c08597f
x-ms-traffictypediagnostic: MN2PR12MB3856:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3856B2C4D524814B25086568F04D0@MN2PR12MB3856.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0225B0D5BC
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(979002)(4636009)(396003)(366004)(39860400002)(346002)(376002)(136003)(199004)(189003)(13464003)(11346002)(52536014)(102836004)(6506007)(55016002)(33656002)(476003)(4326008)(478600001)(446003)(2906002)(7696005)(229853002)(7736002)(54906003)(305945005)(110136005)(316002)(99286004)(6636002)(74316002)(6436002)(186003)(25786009)(6246003)(3846002)(53546011)(76176011)(486006)(9686003)(26005)(66556008)(64756008)(66446008)(8936002)(76116006)(71190400001)(66476007)(14454004)(256004)(14444005)(86362001)(66946007)(8676002)(66066001)(5660300002)(81156014)(81166006)(6116002)(71200400001)(969003)(989001)(999001)(1009001)(1019001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3856;
 H:MN2PR12MB3838.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jM5pxI4HoIcCgRwA5z9PAB7G9coI3yL+y0jr3OEFbL3dgYEA6Gt71mzVI6kKTldvetVdZ8JwTBZ/Vf9z1/0FpE25WZSmzFNnilIWfirsxjqXisQflQDvvRdhJhno8xc/jyDNCJayIxBv2FvuUKoLMGIaeLnpoku/cbygUFyRWfxWYO5UrRedvYugwrK3YhhBne6oCD2bQFe1XKDzZBVvn9F6x58qy3v56dm1iPJeaNh7GU/Rt9pL7nafYEikHcB+oxsnD99XtBClHfqxZ9HRtIbJ6OjCzFII5Qe55vJVfZZnvo4cGRS5mh+7vnMrINZM8UUYnE+MDPngoB7i+WZrXqJ9ncOPim9PF0S8Q9omwQGYzFJaVWVaH5ohlbyO9QQpzpUF3bKJNAuaGd8Qhi/4Xlyp59tsPREYO2Lz4+WqBSdJ/2dox4FiTrHbKnLoQsnc
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 565075f6-9951-44f4-2682-08d76c08597f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2019 09:19:01.1788 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D4LNiS26Dd0Rsa5xEBr9gw89BoRhQWZ3HyiIrTpmRVfIN56NDx8zIAzceyDXLUzT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3856
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wpCF8YeNpvweguhrsLTP9xHE3hJYYmZwUJtOryZyqOs=;
 b=hvX7dejb715flhMshhHnkKFMNwAkXH+xWXlOHfjBqP6vxrVPKbNGM3qww7qupc3MLzRnNCe6rt65GuF5M3J9cv1pYYL/EpkcVXZbYn4RGgXlAgZHTUaL8pvc3Mu98I0eJxhxGXOE4mCdEjotDFCY3/zOZUOZPp5puFYuTLW3wd4=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Aaron.Liu@amd.com; 
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
Cc: "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Olsak, Marek" <Marek.Olsak@amd.com>,
 "Tuikov, Luben" <Luben.Tuikov@amd.com>, "Liu, Leo" <Leo.Liu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191118091901.0lCnI0mycZ9B1YKg9ZBMVVBNN4gwr385JhxRF27jwjw@z>

DQoNCkJSLA0KQWFyb24gTGl1DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJv
bTogS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT4NCj4gU2VudDog
RnJpZGF5LCBOb3ZlbWJlciAxNSwgMjAxOSA4OjUwIFBNDQo+IFRvOiBIdWFuZywgUmF5IDxSYXku
SHVhbmdAYW1kLmNvbT47IExpdSwgQWFyb24gPEFhcm9uLkxpdUBhbWQuY29tPg0KPiBDYzogYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IERldWNoZXIsIEFsZXhhbmRlcg0KPiA8QWxleGFu
ZGVyLkRldWNoZXJAYW1kLmNvbT47IE9sc2FrLCBNYXJlayA8TWFyZWsuT2xzYWtAYW1kLmNvbT47
DQo+IExpdSwgTGVvIDxMZW8uTGl1QGFtZC5jb20+OyBUdWlrb3YsIEx1YmVuIDxMdWJlbi5UdWlr
b3ZAYW1kLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAwNy8xMl0gYW1kZ3B1OiB1c2luZyBJ
QiBmbGFncyBmb3IgVE1aIG9yIG5vbi1UTVoNCj4gDQo+IEFtIDE1LjExLjE5IHVtIDEwOjMyIHNj
aHJpZWIgSHVhbmcgUnVpOg0KPiA+IE9uIEZyaSwgTm92IDE1LCAyMDE5IGF0IDExOjM0OjUwQU0g
KzA4MDAsIExpdSwgQWFyb24gd3JvdGU6DQo+ID4+IEluIGtlcm5lbCwgY3MtPmluLmZsYWdzIGlz
IHVzZWQgZm9yIFRNWi4gSGVuY2UgbGliZHJtIHNob3VsZCB0cmFuc2Zlcg0KPiA+PiB0aGUgZmxh
ZyB0byBrZXJuZWwuDQo+ID4+DQo+ID4+IFNpZ25lZC1vZmYtYnk6IEFhcm9uIExpdSA8YWFyb24u
bGl1QGFtZC5jb20+DQo+ID4+IC0tLQ0KPiA+PiAgIGFtZGdwdS9hbWRncHUuaCAgICB8IDQgKysr
LQ0KPiA+PiAgIGFtZGdwdS9hbWRncHVfY3MuYyB8IDQgKysrKw0KPiA+PiAgIDIgZmlsZXMgY2hh
bmdlZCwgNyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4+DQo+ID4+IGRpZmYgLS1n
aXQgYS9hbWRncHUvYW1kZ3B1LmggYi9hbWRncHUvYW1kZ3B1LmggaW5kZXgNCj4gZjQ1ZjlmNy4u
YWVlM2YzZA0KPiA+PiAxMDA2NDQNCj4gPj4gLS0tIGEvYW1kZ3B1L2FtZGdwdS5oDQo+ID4+ICsr
KyBiL2FtZGdwdS9hbWRncHUuaA0KPiA+PiBAQCAtMzQyLDcgKzM0Miw5IEBAIHN0cnVjdCBhbWRn
cHVfY3NfZmVuY2VfaW5mbyB7DQo+ID4+ICAgICogXHNhIGFtZGdwdV9jc19zdWJtaXQoKQ0KPiA+
PiAgICovDQo+ID4+ICAgc3RydWN0IGFtZGdwdV9jc19yZXF1ZXN0IHsNCj4gPj4gLQkvKiogU3Bl
Y2lmeSBmbGFncyB3aXRoIGFkZGl0aW9uYWwgaW5mb3JtYXRpb24gKi8NCj4gPj4gKwkvKiogU3Bl
Y2lmeSBmbGFncyB3aXRoIGFkZGl0aW9uYWwgaW5mb3JtYXRpb24NCj4gPj4gKwkgKiAwLW5vcm1h
bCwgMS10bXoNCj4gPj4gKwkgKi8NCj4gPj4gICAJdWludDY0X3QgZmxhZ3M7DQo+ID4+DQo+ID4+
ICAgCS8qKiBTcGVjaWZ5IEhXIElQIGJsb2NrIHR5cGUgdG8gd2hpY2ggdG8gc2VuZCB0aGUgSUIu
ICovIGRpZmYNCj4gPj4gLS1naXQgYS9hbWRncHUvYW1kZ3B1X2NzLmMgYi9hbWRncHUvYW1kZ3B1
X2NzLmMgaW5kZXgNCj4gPj4gNDM3YzRhNC4uNmY3MDc3MSAxMDA2NDQNCj4gPj4gLS0tIGEvYW1k
Z3B1L2FtZGdwdV9jcy5jDQo+ID4+ICsrKyBiL2FtZGdwdS9hbWRncHVfY3MuYw0KPiA+PiBAQCAt
MjU0LDYgKzI1NCwxMCBAQCBzdGF0aWMgaW50DQo+IGFtZGdwdV9jc19zdWJtaXRfb25lKGFtZGdw
dV9jb250ZXh0X2hhbmRsZSBjb250ZXh0LA0KPiA+PiAgIAltZW1zZXQoJmNzLCAwLCBzaXplb2Yo
Y3MpKTsNCj4gPj4gICAJY3MuaW4uY2h1bmtzID0gKHVpbnQ2NF90KSh1aW50cHRyX3QpY2h1bmtf
YXJyYXk7DQo+ID4+ICAgCWNzLmluLmN0eF9pZCA9IGNvbnRleHQtPmlkOw0KPiA+PiArCS8qIGlu
IGtlcm5lbCwgX3BhZCBpcyB1c2VkIGFzIGZsYWdzDQo+ID4+ICsJICogI2RlZmluZSBBTURHUFVf
Q1NfRkxBR1NfU0VDVVJFICAgICAgICAgICgxIDw8IDApDQo+ID4+ICsJICovDQo+ID4+ICsJY3Mu
aW4uX3BhZCA9ICh1aW50MzJfdClpYnNfcmVxdWVzdC0+ZmxhZ3M7DQo+ID4gX3BhZCBpcyBub3Qg
Z29vZCBoZXJlLiBCZWNhdXNlIGl0J3MgdXNlZCB0byBwYXNzIHRoZSBmbGFncyB0byBpbnB1dCBw
YXJhbS4NCj4gPg0KPiA+IEl0J3MgYmV0dGVyIHRvIHJlbmFtZSAiX3BhZCIgaW4gZHJtX2FtZGdw
dV9jc19pbiBhcyAiZmxhZ3MiIGhlcmUuDQo+IA0KPiBBY3R1YWxseSBJIGRvbid0IHRoaW5rIHdl
IG5lZWQgdGhhdCBzdHVmZiBhbHRvZ2V0aGVyLCBwbGVhc2Ugc3luYyB1cCB3aXRoDQo+IE1hcmVr
IG9uIHRoaXMuDQo+IA0KPiBBcyBmYXIgYXNJIGtub3cgdGhlIHdob2xlIGFtZGdwdV9jc19zdWJt
aXQgaW50ZXJmYWNlIHdhcyBkZXByZWNhdGVkIGluDQo+IGZhdm9yIG9mIHRoZSBuZXcgYW1kZ3B1
X2NzX3N1Ym1pdF9yYXcoKSBpbnRlcmZhY2UuDQoNCkNocmlzdGlhbiwgTWFyZWssDQpJbiBhZGRp
dGlvbiB0byBzeW5jb2JqX2NvbW1hbmRfc3VibWlzc2lvbl9oZWxwZXIgdXNlcyBhbWRncHVfY3Nf
c3VibWl0X3JhdywgDQp0aGUgb3RoZXIgdGVzdCBzdWl0ZXMgc3RpbGwgdXNlIG9sZGVyIGludGVy
ZmFjZShhbWRncHVfY3Nfc3VibWl0KS4gV2UnZCBiZXR0ZXIgdG8gDQpyZW9yZ2FuaXplIHRoZSBy
ZWxldmFudCBjb2Rlcy4gVGhpcyBkb2VzIG5vdCBtYWtlIG11Y2ggc2Vuc2UgdG8gb25seSBtb2Rp
Znkgb25lIGNhbGwuDQoNCg0KPiBSZWdhcmRzLA0KPiBDaHJpc3RpYW4uDQo+IA0KPiA+DQo+ID4g
VGhhbmtzLA0KPiA+IFJheQ0KPiA+DQo+ID4+ICAgCWlmIChpYnNfcmVxdWVzdC0+cmVzb3VyY2Vz
KQ0KPiA+PiAgIAkJY3MuaW4uYm9fbGlzdF9oYW5kbGUgPSBpYnNfcmVxdWVzdC0+cmVzb3VyY2Vz
LT5oYW5kbGU7DQo+ID4+ICAgCWNzLmluLm51bV9jaHVua3MgPSBpYnNfcmVxdWVzdC0+bnVtYmVy
X29mX2liczsNCj4gPj4gLS0NCj4gPj4gMi43LjQNCj4gPj4NCg0KX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4
