Return-Path: <SRS0=nD/m=Y6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA85BC5DF60
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Nov 2019 00:04:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71BBE214D8
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Nov 2019 00:04:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71BBE214D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D3AA6EB91;
	Wed,  6 Nov 2019 00:04:43 +0000 (UTC)
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr800070.outbound.protection.outlook.com [40.107.80.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FBD56EB90
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Nov 2019 00:04:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BVnuCSdRBI4hjA3NdTs+d/lgNwUlRrQ0iZIzx0fidKKrW4kaDE6B43oSySAtj0lJz1ykblM7p47SEmhOdw19PkWOlII58KPWlCYna0TJM8ln3aeCZ1wYp+MFYXg86e2/GkDixlmh4RZjxWXpdO5YLYlvWCEw4sfGaJq5Rkvj8v7Ud2rEP9n6t498+xMiEhdTCiocBOKHTnAibHKImLllXMJWytGDcoIwxStluKw51Cfpne5HHmxlKpYIaw45FN4sXxFswyWe0Rn4wDk0Nb7cis+UmKksIyIX+C5GudeJUJ3tQWlEzsVLlyX4Lxv8wRxs5Mh6Qh3xSdUTRyjrFgLzNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DhdI695zzjShQHZM4g9Yjd4nrMK7NvDgeys+ZhsrsBE=;
 b=EMOCGSGMI4WS66Td08VzJHEe3igDbIr1lq+lfpJs8rA3MAjEBLBOHP8e4fN16MlOTtYFUdmDNv2+npKPRqly+foDVOUHEiwLXAY44hyp7M6S8Ju8wdN1oOFIqBNT7JS6b0iPQiBN4LSAaD18XK0jhRqRnpcAEMID8H0zhhMx+95XkcYef2ZWWMsS+3nSCvulOpf5ASkjLGbpY5byZx7jSUzBAoSBSOqX+VIQDOUhSJyQWiTMnWHtzmxbKalkKI9/FIyfK6QOGvyLnfzguiMDmJCNwaQW0QK/heOxgnZGOATWnt/u0SEZqMauMFH0vDv22mow80sC5qMXGaaiZga3Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BL0PR12MB2500.namprd12.prod.outlook.com (52.132.11.151) by
 BL0PR12MB2515.namprd12.prod.outlook.com (52.132.28.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Wed, 6 Nov 2019 00:04:39 +0000
Received: from BL0PR12MB2500.namprd12.prod.outlook.com
 ([fe80::2caa:795a:9ee2:44b1]) by BL0PR12MB2500.namprd12.prod.outlook.com
 ([fe80::2caa:795a:9ee2:44b1%3]) with mapi id 15.20.2387.028; Wed, 6 Nov 2019
 00:04:38 +0000
From: "Jiang, Jerry (SW)" <Jerry.Jiang@amd.com>
To: "Huang, JinHuiEric" <JinHuiEric.Huang@amd.com>, Alex Deucher
 <alexdeucher@gmail.com>
Subject: RE: [PATCH] drm/amdgpu: change read of GPU clock counter on Vega10 VF
Thread-Topic: [PATCH] drm/amdgpu: change read of GPU clock counter on Vega10 VF
Thread-Index: AQHVlCgfmdBRrOtnp0CjqhT72Mz92ad9MuYAgAAL0YCAAAKEcA==
Date: Wed, 6 Nov 2019 00:04:38 +0000
Message-ID:
 <BL0PR12MB250054D0D1FE729D1E0E15D3EE790@BL0PR12MB2500.namprd12.prod.outlook.com>
References: <1572992808-20397-1-git-send-email-JinhuiEric.Huang@amd.com>
 <CADnq5_NDEXUD84z8srp8NNMNvDVwLNZsZUSek=U2hMwkDKxaNw@mail.gmail.com>
 <968d3fe1-4faf-f003-3ec4-10fd5c35cdd8@amd.com>
In-Reply-To: <968d3fe1-4faf-f003-3ec4-10fd5c35cdd8@amd.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [165.204.55.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d95aad6c-7853-45b5-8007-08d7624cea9c
x-ms-traffictypediagnostic: BL0PR12MB2515:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB2515233970D878B3BACCD991EE790@BL0PR12MB2515.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 02135EB356
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(376002)(39860400002)(366004)(396003)(346002)(189003)(199004)(13464003)(8936002)(86362001)(305945005)(76176011)(6116002)(33656002)(11346002)(446003)(6436002)(74316002)(53546011)(66066001)(7736002)(14454004)(486006)(478600001)(8676002)(476003)(316002)(229853002)(26005)(966005)(81156014)(81166006)(71200400001)(110136005)(99286004)(25786009)(6506007)(102836004)(9686003)(6306002)(55016002)(6246003)(186003)(66446008)(66556008)(52536014)(66946007)(64756008)(5660300002)(66476007)(76116006)(71190400001)(2906002)(7696005)(4326008)(256004)(14444005)(3846002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BL0PR12MB2515;
 H:BL0PR12MB2500.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YlpVZoyyc81/mZ5Yb5UmgrFVccg7HnJ+RTHdeJTiG4z6jmwQ4+Ba8JMm63GFtegSPwWRUy3DRjyQwy8PBVERNOxuk6EFcMlNlhPv8c8rHyJSW1+nIfz2E8i3detXi1dXwKjlq0Gu2+m9mdy8tNWJFio1zxFrgHqaqrUYiB4UwZ9izqjYmHJ7+hBcIadpRFJOpelA1BDLpyroZftbYLFnHTnXwIVeGMyUkui5dhXMV2iVN3W7QbkMZNLAVc0z+D7nl13PJkS55N5iMzgQi/FCSkPcsPUuw2o0rYpXK+uTViM/m7gBMX+7skdsfflUubptNhOIqGs/wSeXKcnHot0R1E1pDwvr/qUc6dHB+so5Pfb0btr6jsNofWfTsZ+R4n+zBy10i59PSOKhuHF7JvuPJ0PWw8W6DTSsIEaOBHvgQNYvalcubFul5rLmmqYGDntakT1QgEufGtpIt1dB92eaPdNowafwNaaESUK/oxBU5K8=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d95aad6c-7853-45b5-8007-08d7624cea9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2019 00:04:38.7577 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BDyTFtf+pIhNGhomtJ6J3rXdVeFlVFhNJooN2gG5ZoFesbUqkITRqRMY09QP45oR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2515
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DhdI695zzjShQHZM4g9Yjd4nrMK7NvDgeys+ZhsrsBE=;
 b=iQyVuHcd0vuBO9oG9TjoXXN0vanf8htAcceHuzP09jj6Gv40LN7MXzdosW6rHcugQ56ieOK04vgI671B9/sH+2GUuksh3pLDyHkZa/BB/VR9j2HY6DpPx1Rp/9TAbehgO182+IcBLnrgDOcsBzjfWbdN3otmEgd23PYrGHY+Myo=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jerry.Jiang@amd.com; 
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191106000438.ETJGoiBdSYS1suDz659hTxuo9uRiC1mxTDgmMwDh078@z>

SGkgQWxleCwNCg0KVW5kZXIgdGhlIFNSSU9WIG1vZGUsIHRoZSBMMSBwb2xpY3kgcHJldmVudCB0
aGUgd3JpdGUgdG8gbW1STENfQ0FQVFVSRV9HUFVfQ0xPQ0tfQ09VTlQgb24gVkYsIHNvIHRoZSBS
TENfR1BVX0NMT0NLX0NPVU5UX0xTQi9NU0IgZG9lc24ndCBnZXQgdXBkYXRlZCBmb3IgZWFjaCBy
ZWFkIHVuZGVyIFNSSU9WIFZGLg0KDQpPbiB0aGUgb3RoZXIgaGFuZCwgdGhlIHJlYWQgZnJvbSBS
TENfUkVGQ0xPQ0tfVElNRVNUQU1QX0xTQi9NU0IgZG9lc24ndCByZWx5IG9uIGFueSB3cml0ZSwg
c28gaXQgaXMgYXZhaWxhYmxlIG9uIFZGLiBBbmQgb2YgY2F1c2UgaXQgaXMgYXZhaWxhYmxlIGZv
ciBiYXJlIG1ldGFsIGFsc28uIEhvd2V2ZXIsIHRoZSBSTENfUkVGQ0xPQ0tfVElNRVNUQU1QX0xT
Qi9NU0Igd2lsbCByZXNldCB0byB6ZXJvIHVuZGVyIHR3byBjYXNlczogMSkgR0ZYT0ZGIDIpIFJl
c2V0LiBTaW5jZSBTUklPViBkb2Vzbid0IGhhdmUgR0ZYT0ZGLCBhbmQgYWZ0ZXIgcmVzZXQsIHRo
ZSBndWVzdCB3aWxsIGhhdmUgdG8gcmVzdGFydCB0aGUgYXBwLCBzbyB0aGVyZSBpcyBubyBwcm9i
bGVtIGZvciBTUklPViB0byBzd2l0Y2ggdG8gdGhpcyBuZXcgcmVnaXN0ZXIgc2V0Lg0KDQpPbiBi
YXJlIG1ldGFsLCB0aGVyZSBpcyBjb25jZXJuIHdpdGggdGhlc2UgdHdvIGNhc2VzLiBXZSBkaWRu
J3QgZ2V0IGNvbmZpcm1hdGlvbiBmcm9tIFJvY20gdGVhbSB0aGF0IHRoZSBjb3VudGVyIHJlc2V0
IHRvIHplcm8gYWZ0ZXIgIDEpIEdGWE9GRiAyKSBSZXNldCB3aWxsIG5vdCBhZmZlY3QgdGhlIHVz
YWdlIG9mIEdQVSB0aW1lc3RhbXAsIHdlIGNhbid0IG1ha2UgdGhlIHN3aXRjaCBmb3IgYmFyZSBt
ZXRhbC4gSSB3b3VsZCBiZSBtb3JlIHRoYW4gaGFwcHkgdG8gc3dpdGNoIGFsbCBvdmVyIGlmIHdl
IGNhbi4uDQoNCkplcnJ5DQoNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEh1
YW5nLCBKaW5IdWlFcmljIDxKaW5IdWlFcmljLkh1YW5nQGFtZC5jb20+IA0KU2VudDogVHVlc2Rh
eSwgTm92ZW1iZXIgNSwgMjAxOSA2OjQ4IFBNDQpUbzogQWxleCBEZXVjaGVyIDxhbGV4ZGV1Y2hl
ckBnbWFpbC5jb20+DQpDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IEppYW5nLCBK
ZXJyeSAoU1cpIDxKZXJyeS5KaWFuZ0BhbWQuY29tPg0KU3ViamVjdDogUmU6IFtQQVRDSF0gZHJt
L2FtZGdwdTogY2hhbmdlIHJlYWQgb2YgR1BVIGNsb2NrIGNvdW50ZXIgb24gVmVnYTEwIFZGDQoN
Cg0KT24gMjAxOS0xMS0wNSA2OjA2IHAubS4sIEFsZXggRGV1Y2hlciB3cm90ZToNCj4gT24gVHVl
LCBOb3YgNSwgMjAxOSBhdCA1OjI2IFBNIEh1YW5nLCBKaW5IdWlFcmljIA0KPiA8SmluSHVpRXJp
Yy5IdWFuZ0BhbWQuY29tPiB3cm90ZToNCj4+IFVzaW5nIHVuaWZpZWQgVkJJT1MgaGFzIHBlcmZv
cm1hbmNlIGRyb3AgaW4gc3Jpb3YgZW52aXJvbm1lbnQuDQo+PiBUaGUgZml4IGlzIHN3aXRjaGlu
ZyB0byBhbm90aGVyIHJlZ2lzdGVyIGluc3RlYWQuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogRXJp
YyBIdWFuZyA8SmluaHVpRXJpYy5IdWFuZ0BhbWQuY29tPg0KPj4gLS0tDQo+PiAgIGRyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMgfCAxOSArKysrKysrKysrKysrKysrLS0tDQo+
PiAgIDEgZmlsZSBjaGFuZ2VkLCAxNiBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPj4N
Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jIA0K
Pj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jDQo+PiBpbmRleCA4Mjlk
NjIzLi5lNDRhM2VhIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
Z2Z4X3Y5XzAuYw0KPj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAu
Yw0KPj4gQEAgLTM4ODUsOSArMzg4NSwyMiBAQCBzdGF0aWMgdWludDY0X3QgZ2Z4X3Y5XzBfZ2V0
X2dwdV9jbG9ja19jb3VudGVyKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQ0KPj4gICAgICAg
ICAgdWludDY0X3QgY2xvY2s7DQo+Pg0KPj4gICAgICAgICAgbXV0ZXhfbG9jaygmYWRldi0+Z2Z4
LmdwdV9jbG9ja19tdXRleCk7DQo+PiAtICAgICAgIFdSRUczMl9TT0MxNShHQywgMCwgbW1STENf
Q0FQVFVSRV9HUFVfQ0xPQ0tfQ09VTlQsIDEpOw0KPj4gLSAgICAgICBjbG9jayA9ICh1aW50NjRf
dClSUkVHMzJfU09DMTUoR0MsIDAsIG1tUkxDX0dQVV9DTE9DS19DT1VOVF9MU0IpIHwNCj4+IC0g
ICAgICAgICAgICAgICAoKHVpbnQ2NF90KVJSRUczMl9TT0MxNShHQywgMCwgbW1STENfR1BVX0NM
T0NLX0NPVU5UX01TQikgPDwgMzJVTEwpOw0KPj4gKyAgICAgICBpZiAoYWRldi0+YXNpY190eXBl
ID09IENISVBfVkVHQTEwICYmIGFtZGdwdV9zcmlvdl9ydW50aW1lKGFkZXYpKSB7DQo+PiArICAg
ICAgICAgICAgICAgdWludDMyX3QgdG1wLCBsc2IsIG1zYiwgaSA9IDA7DQo+PiArICAgICAgICAg
ICAgICAgZG8gew0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgaWYgKGkgIT0gMCkNCj4+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWRlbGF5KDEpOw0KPj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgdG1wID0gUlJFRzMyX1NPQzE1KEdDLCAwLCBtbVJMQ19SRUZDTE9DS19USU1F
U1RBTVBfTVNCKTsNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgIGxzYiA9IFJSRUczMl9TT0Mx
NShHQywgMCwgbW1STENfUkVGQ0xPQ0tfVElNRVNUQU1QX0xTQik7DQo+PiArICAgICAgICAgICAg
ICAgICAgICAgICBtc2IgPSBSUkVHMzJfU09DMTUoR0MsIDAsIG1tUkxDX1JFRkNMT0NLX1RJTUVT
VEFNUF9NU0IpOw0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgaSsrOw0KPj4gKyAgICAgICAg
ICAgICAgIH0gd2hpbGUgKHVubGlrZWx5KHRtcCAhPSBtc2IpICYmIChpIDwgYWRldi0+dXNlY190
aW1lb3V0KSk7DQo+PiArICAgICAgICAgICAgICAgY2xvY2sgPSAodWludDY0X3QpbHNiIHwgKCh1
aW50NjRfdCltc2IgPDwgMzJVTEwpOw0KPj4gKyAgICAgICB9IGVsc2Ugew0KPj4gKyAgICAgICAg
ICAgICAgIFdSRUczMl9TT0MxNShHQywgMCwgbW1STENfQ0FQVFVSRV9HUFVfQ0xPQ0tfQ09VTlQs
IDEpOw0KPj4gKyAgICAgICAgICAgICAgIGNsb2NrID0gKHVpbnQ2NF90KVJSRUczMl9TT0MxNShH
QywgMCwgbW1STENfR1BVX0NMT0NLX0NPVU5UX0xTQikgfA0KPj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgKCh1aW50NjRfdClSUkVHMzJfU09DMTUoR0MsIDAsIG1tUkxDX0dQVV9DTE9DS19DT1VO
VF9NU0IpIDw8IDMyVUxMKTsNCj4+ICsgICAgICAgfQ0KPiBJcyB0aGVyZSBhIHJlYXNvbiB3ZSBj
YW4ndCB1c2UgdGhlIHNhbWUgcmVncyBvbiBiYXJlIG1ldGFsIGFuZCBTUi1JT1Y/DQo+ICAgSSdk
IGxpa2UgdG8gbWluaW1pemUgdGhlIGRlbHRhcyBpZiBwb3NzaWJsZS4NCg0KQXMgSmVycnkncyBy
ZXF1ZXN0LCB0aGlzIGNoYW5nZSB3aWxsIGF2b2lkIFAxIHBvbGljeSBwcm90ZWN0aW9uIG9uIFJM
Q19HUFVfQ0xPQ0tfQ09VTlRfTFNCL01TQi4NCg0KRXJpYw0KDQo+DQo+IEFsZXgNCj4NCj4+ICAg
ICAgICAgIG11dGV4X3VubG9jaygmYWRldi0+Z2Z4LmdwdV9jbG9ja19tdXRleCk7DQo+PiAgICAg
ICAgICByZXR1cm4gY2xvY2s7DQo+PiAgIH0NCj4+IC0tDQo+PiAyLjcuNA0KPj4NCj4+IF9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQo+PiBhbWQtZ2Z4IG1h
aWxpbmcgbGlzdA0KPj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4+IGh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA0KX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxp
c3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
