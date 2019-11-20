Return-Path: <SRS0=Di3h=ZM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D358C432C0
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2019 08:54:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8327223D1
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2019 08:54:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8327223D1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D6496E0EF;
	Wed, 20 Nov 2019 08:54:56 +0000 (UTC)
Received: from NAM05-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr730055.outbound.protection.outlook.com [40.107.73.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 300346E0EF
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Nov 2019 08:54:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ILNgs/TWvcM2LBc25da84YjPkKdrkvEf/2IcjpgHtKtyCz/N3jR3kS46VRjxhs1fymHVB2XFDIaoV5QHHzVyA/262wkMDE4A5p0Ed67Y1ONLUVHhFT2m5h+FkHKb9b7kGdunkOQ3b9CdIBLEeh1KsYpJcqG706b3FYxHK6U/Hk2hKLc8O2ckXqNOZ7ff8eZ4VLUUA9qev+YvhQ3feXV1Yg2Uf7nV5dFjtDN1ZM7o5l6VjI4ITSxJATTmf+q+iXHBqHr+/GwB4kkxQIjHyFENrxUb2kT1KeqXCDzP03Qs/ILtQbMI7/9nTAj7uwys1Jm3AdnOZysllCL+YigTl5Ev3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DoEaMi1wtOd1plEbgU2K2ZtF/gY7AlaAObwNTNXB0YQ=;
 b=BTOil/40VJpTa3XBJDJv5k3s1PvQLo1WhSrXTecHw6ZqWHASIzeJupcT7DNHTrmhBCs5JCowliS6uuKNe0q/fYfyu/pbF45j5nvDn8XYRIa4zvaam8ZefjE5dbf9Zxp8CLba6gcZMqvs3N309En6pE8CUSGot04Ik1dxiwBRxQ9Blv3/WZfZCm2cB58dXRFE56FRPlXmnS+bSN+GKGrNbqviqdNnh2jbOvEZr6N1BWk41Bx3HiHeRk1L7eGs/jiPxobMDKu++E1OiQ8yPp0X1izD38H/TpXb42WPyiMofNYZjv3Bnp0SO3YilYfBH9H0RJ9O1JICskbsAFkvzB+cZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM5PR12MB1418.namprd12.prod.outlook.com (10.168.240.15) by
 DM5PR12MB1836.namprd12.prod.outlook.com (10.175.92.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.26; Wed, 20 Nov 2019 08:54:53 +0000
Received: from DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::b011:48ff:bf60:75a7]) by DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::b011:48ff:bf60:75a7%8]) with mapi id 15.20.2451.031; Wed, 20 Nov 2019
 08:54:53 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Yuan, Xiaojie"
 <Xiaojie.Yuan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/gfx10: re-init clear state buffer after gpu
 reset
Thread-Topic: [PATCH] drm/amdgpu/gfx10: re-init clear state buffer after gpu
 reset
Thread-Index: AQHVn25hgnJp5nBSs0qXI2gya/dmz6eTvYcwgAABGICAAACtgIAAAfWg
Date: Wed, 20 Nov 2019 08:54:53 +0000
Message-ID:
 <DM5PR12MB141866D265D123D18E289329FC4F0@DM5PR12MB1418.namprd12.prod.outlook.com>
References: <20191120064701.2765-1-xiaojie.yuan@amd.com>
 <DM5PR12MB1418A32EB8199ABFFCCAEC04FC4F0@DM5PR12MB1418.namprd12.prod.outlook.com>
 <DM5PR12MB14185B32B9CB4356233E5903FC4F0@DM5PR12MB1418.namprd12.prod.outlook.com>
 <01af7844-2fbe-fd1a-5662-c8a9ec5812f0@gmail.com>
In-Reply-To: <01af7844-2fbe-fd1a-5662-c8a9ec5812f0@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 80b6d066-ddce-4f5f-4153-08d76d974f3f
x-ms-traffictypediagnostic: DM5PR12MB1836:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1836668F84FF2B447C7257B4FC4F0@DM5PR12MB1836.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 02272225C5
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(39860400002)(376002)(366004)(136003)(396003)(189003)(199004)(13464003)(81166006)(81156014)(25786009)(6436002)(14444005)(256004)(316002)(55016002)(478600001)(7736002)(305945005)(33656002)(52536014)(966005)(74316002)(6506007)(76116006)(14454004)(6246003)(26005)(102836004)(8936002)(4326008)(2906002)(53546011)(9686003)(99286004)(76176011)(71190400001)(229853002)(71200400001)(3846002)(2501003)(66556008)(66476007)(8676002)(6306002)(5660300002)(66066001)(86362001)(486006)(66574012)(6116002)(446003)(110136005)(476003)(7696005)(186003)(54906003)(11346002)(64756008)(66446008)(66946007)(357404004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1836;
 H:DM5PR12MB1418.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YjQCHw72gJYvhldFOyBDhR8Oj8ZP3Q3aITufF4qcJ5LwCwt1MYc4WMwGr3ZOVsrgFY9cOAl7tyLD1i1maP3Cc/8XwxLkAUlSGo4AquNozgL0CbGL8SfIFYd4IAWUwC3QdXqOMMz9n8Bg6KRfnedahttr7kUlLgPwYHBn64Lk+sW8IQDgOB8L0x3/T9WWu5fg2I8OR0ZWc5Otf+T8djfBT11laj94/PgFVQ4v84WncKFc+EGaID0iUyFWVAkfYpRhhyRTmZ+uu9yAAEt5uRGNejoym6tyTpnZpD4+PRGHvnFEf59Z4cg+OJOmpSPo/YS0yaaoRmzoVA9eO7Dg6vW/ys/cwD6X1eWQg3kZG81gI+kHNngu/Yry0+ogqVP3P3bYVibU6rldhxPTYcShFiAOLGwlwP8B+YMcn6AeznhzkDed8KQl+P+aj0jL1RO5wLg1
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80b6d066-ddce-4f5f-4153-08d76d974f3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2019 08:54:53.1170 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RAHO6H4lM3IkLOzHe6SqrGaMXfUtREqSY4z4gO3PQyGrkMg/YVKI/2cas32QbfmK8C7vc+rKslHIG3EWATgZhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1836
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DoEaMi1wtOd1plEbgU2K2ZtF/gY7AlaAObwNTNXB0YQ=;
 b=rsYb8KM5JePAwyNm6tryxX8Jf3Fby8D2VhtjKPwy0imrhABU4jRMjJzsb2t9yRDWnX0lMwLEzEuPsyWzcflqPX2hBbVy1PzuPuPrlIcmRFnHYo2VBgj2pnViT+1MvEY2XvF/dtfuWZdzREioRANPXLUdumvHjm9d8pV8aqbNRMs=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Hawking.Zhang@amd.com; 
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
Cc: "Long, Gang" <Gang.Long@amd.com>, "Xiao, Jack" <Jack.Xiao@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191120085453.6mOmrZlBuiL4M3CBg83iYBJi2_NKV022vwbwv0eA6tE@z>

SSB0aGluayB3ZSBzaG91bGQgZXZpY3QgdGhlIGJvIGFuZCB0aGVuIG1vdmUgaXQgYmFjay4NCg0K
UmVnYXJkcywNCkhhd2tpbmcNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IENo
cmlzdGlhbiBLw7ZuaWcgPGNrb2VuaWcubGVpY2h0enVtZXJrZW5AZ21haWwuY29tPiANClNlbnQ6
IDIwMTnlubQxMeaciDIw5pelIDE2OjQ3DQpUbzogWmhhbmcsIEhhd2tpbmcgPEhhd2tpbmcuWmhh
bmdAYW1kLmNvbT47IFl1YW4sIFhpYW9qaWUgPFhpYW9qaWUuWXVhbkBhbWQuY29tPjsgYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCkNjOiBMb25nLCBHYW5nIDxHYW5nLkxvbmdAYW1kLmNv
bT47IFhpYW8sIEphY2sgPEphY2suWGlhb0BhbWQuY29tPg0KU3ViamVjdDogUmU6IFtQQVRDSF0g
ZHJtL2FtZGdwdS9nZngxMDogcmUtaW5pdCBjbGVhciBzdGF0ZSBidWZmZXIgYWZ0ZXIgZ3B1IHJl
c2V0DQoNCkEgYmFjbyByZXNldCBhbHNvIHJlc2V0cyB0aGUgTUMsIGRvZXNuJ3QgaXQ/IG4gdGhp
cyBjYXNlIGl0IHdvdWxkIGJlIGV4cGVjdGVkIHRoYXQgdGhlIGNvbnRlbnQgb2YgVlJBTSBpcyBj
b3JydXB0ZWQuDQoNCkNocmlzdGlhbi4NCg0KQW0gMjAuMTEuMTkgdW0gMDk6NDUgc2NocmllYiBa
aGFuZywgSGF3a2luZzoNCj4gT3IgaW4gYW5vdGhlciB3b3JkLCB3ZSBhcmUgc3RpbGwgbm90IGNs
ZWFyIHdoZW4gdGhlIGNvcnJ1cHRpb24gYWN0dWFsbHkgaGFwcGVucywgcmlnaHQ/DQo+DQo+IFJl
Z2FyZHMsDQo+IEhhd2tpbmcNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTog
YW1kLWdmeCA8YW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4gT24gQmVoYWxm
IE9mIA0KPiBaaGFuZywgSGF3a2luZw0KPiBTZW50OiAyMDE55bm0MTHmnIgyMOaXpSAxNjo0NA0K
PiBUbzogWXVhbiwgWGlhb2ppZSA8WGlhb2ppZS5ZdWFuQGFtZC5jb20+OyANCj4gYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gQ2M6IExvbmcsIEdhbmcgPEdhbmcuTG9uZ0BhbWQuY29t
PjsgWGlhbywgSmFjayA8SmFjay5YaWFvQGFtZC5jb20+DQo+IFN1YmplY3Q6IFJFOiBbUEFUQ0hd
IGRybS9hbWRncHUvZ2Z4MTA6IHJlLWluaXQgY2xlYXIgc3RhdGUgYnVmZmVyIA0KPiBhZnRlciBn
cHUgcmVzZXQNCj4NCj4gSnVzdCBtYWtlIHN1cmUgSSB1bmRlcnN0YW5kIHlvdSBjb3JyZWN0bHku
IFNvIHVudGlsIGZ3IHRlYW0gcm9vdCBjYXVzZSB0aGUgcmVhc29uIG9mIGNzYiBjb3JydXB0aW9u
LCB3ZSBrZWVwIHRoZSB3b3JrYXJvdW5kIGluIGRyaXZlciwgY29ycmVjdD8NCj4NCj4gUmVnYXJk
cywNCj4gSGF3a2luZw0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBZdWFu
LCBYaWFvamllIDxYaWFvamllLll1YW5AYW1kLmNvbT4NCj4gU2VudDogMjAxOeW5tDEx5pyIMjDm
l6UgMTQ6NDcNCj4gVG86IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IENjOiBaaGFu
ZywgSGF3a2luZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPjsgWGlhbywgSmFjayANCj4gPEphY2su
WGlhb0BhbWQuY29tPjsgTG9uZywgR2FuZyA8R2FuZy5Mb25nQGFtZC5jb20+OyBZdWFuLCBYaWFv
amllIA0KPiA8WGlhb2ppZS5ZdWFuQGFtZC5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSF0gZHJtL2Ft
ZGdwdS9nZngxMDogcmUtaW5pdCBjbGVhciBzdGF0ZSBidWZmZXIgYWZ0ZXIgDQo+IGdwdSByZXNl
dA0KPg0KPiBUaGlzIHBhdGNoIGZpeGVzIDJuZCBiYWNvIHJlc2V0IGZhaWx1cmUgd2l0aCBnZnhv
ZmYgZW5hYmxlZCBvbiBuYXZpMXguDQo+DQo+IGNsZWFyIHN0YXRlIGJ1ZmZlciAocmVzaWRlcyBp
biB2cmFtKSBpcyBjb3JydXB0ZWQgYWZ0ZXIgMXN0IGJhY28gcmVzZXQsIHVwb24gZ2Z4b2ZmIGV4
aXQsIENQRiBnZXRzIGdhcmJhZ2UgaGVhZGVyIGluIENTSUIgYW5kIGhhbmdzLg0KPg0KPiBTaWdu
ZWQtb2ZmLWJ5OiBYaWFvamllIFl1YW4gPHhpYW9qaWUueXVhbkBhbWQuY29tPg0KPiAtLS0NCj4g
ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYyB8IDQzICsrKysrKysrKysr
KysrKysrKysrKystLS0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDM3IGluc2VydGlvbnMoKyksIDYg
ZGVsZXRpb25zKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9nZnhfdjEwXzAuYyANCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAu
Yw0KPiBpbmRleCA5Mjc0YmQ0YjZjNjguLjhlMjRlYTA4Y2EzOSAxMDA2NDQNCj4gLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMNCj4gKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMNCj4gQEAgLTE3ODksMjcgKzE3ODksNTIgQEAgc3Rh
dGljIHZvaWQgZ2Z4X3YxMF8wX2VuYWJsZV9ndWlfaWRsZV9pbnRlcnJ1cHQoc3RydWN0IGFtZGdw
dV9kZXZpY2UgKmFkZXYsDQo+ICAgCVdSRUczMl9TT0MxNShHQywgMCwgbW1DUF9JTlRfQ05UTF9S
SU5HMCwgdG1wKTsgIH0NCj4gICANCj4gLXN0YXRpYyB2b2lkIGdmeF92MTBfMF9pbml0X2NzYihz
dHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikNCj4gK3N0YXRpYyBpbnQgZ2Z4X3YxMF8wX2luaXRf
Y3NiKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQ0KPiAgIHsNCj4gKwlpbnQgcjsNCj4gKw0K
PiArCWlmIChhZGV2LT5pbl9ncHVfcmVzZXQpIHsNCj4gKwkJciA9IGFtZGdwdV9ib19yZXNlcnZl
KGFkZXYtPmdmeC5ybGMuY2xlYXJfc3RhdGVfb2JqLCBmYWxzZSk7DQo+ICsJCWlmIChyKQ0KPiAr
CQkJcmV0dXJuIHI7DQo+ICsNCj4gKwkJciA9IGFtZGdwdV9ib19rbWFwKGFkZXYtPmdmeC5ybGMu
Y2xlYXJfc3RhdGVfb2JqLA0KPiArCQkJCSAgICh2b2lkICoqKSZhZGV2LT5nZngucmxjLmNzX3B0
cik7DQo+ICsJCWlmICghcikgew0KPiArCQkJYWRldi0+Z2Z4LnJsYy5mdW5jcy0+Z2V0X2NzYl9i
dWZmZXIoYWRldiwNCj4gKwkJCQkJYWRldi0+Z2Z4LnJsYy5jc19wdHIpOw0KPiArCQkJYW1kZ3B1
X2JvX2t1bm1hcChhZGV2LT5nZngucmxjLmNsZWFyX3N0YXRlX29iaik7DQo+ICsJCX0NCj4gKw0K
PiArCQlhbWRncHVfYm9fdW5yZXNlcnZlKGFkZXYtPmdmeC5ybGMuY2xlYXJfc3RhdGVfb2JqKTsN
Cj4gKwkJaWYgKHIpDQo+ICsJCQlyZXR1cm4gcjsNCj4gKwl9DQo+ICsNCj4gICAJLyogY3NpYiAq
Lw0KPiAgIAlXUkVHMzJfU09DMTUoR0MsIDAsIG1tUkxDX0NTSUJfQUREUl9ISSwNCj4gICAJCSAg
ICAgYWRldi0+Z2Z4LnJsYy5jbGVhcl9zdGF0ZV9ncHVfYWRkciA+PiAzMik7DQo+ICAgCVdSRUcz
Ml9TT0MxNShHQywgMCwgbW1STENfQ1NJQl9BRERSX0xPLA0KPiAgIAkJICAgICBhZGV2LT5nZngu
cmxjLmNsZWFyX3N0YXRlX2dwdV9hZGRyICYgMHhmZmZmZmZmYyk7DQo+ICAgCVdSRUczMl9TT0Mx
NShHQywgMCwgbW1STENfQ1NJQl9MRU5HVEgsIA0KPiBhZGV2LT5nZngucmxjLmNsZWFyX3N0YXRl
X3NpemUpOw0KPiArDQo+ICsJcmV0dXJuIDA7DQo+ICAgfQ0KPiAgIA0KPiAtc3RhdGljIHZvaWQg
Z2Z4X3YxMF8wX2luaXRfcGcoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQo+ICtzdGF0aWMg
aW50IGdmeF92MTBfMF9pbml0X3BnKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQ0KPiAgIHsN
Cj4gICAJaW50IGk7DQo+ICsJaW50IHI7DQo+ICAgDQo+IC0JZ2Z4X3YxMF8wX2luaXRfY3NiKGFk
ZXYpOw0KPiArCXIgPSBnZnhfdjEwXzBfaW5pdF9jc2IoYWRldik7DQo+ICsJaWYgKHIpDQo+ICsJ
CXJldHVybiByOw0KPiAgIA0KPiAgIAlmb3IgKGkgPSAwOyBpIDwgYWRldi0+bnVtX3ZtaHViczsg
aSsrKQ0KPiAgIAkJYW1kZ3B1X2dtY19mbHVzaF9ncHVfdGxiKGFkZXYsIDAsIGksIDApOw0KPiAg
IA0KPiAgIAkvKiBUT0RPOiBpbml0IHBvd2VyIGdhdGluZyAqLw0KPiAtCXJldHVybjsNCj4gKwly
ZXR1cm4gMDsNCj4gICB9DQo+ICAgDQo+ICAgdm9pZCBnZnhfdjEwXzBfcmxjX3N0b3Aoc3RydWN0
IGFtZGdwdV9kZXZpY2UgKmFkZXYpIEBAIC0xOTExLDcgKzE5MzYsMTAgQEAgc3RhdGljIGludCBn
ZnhfdjEwXzBfcmxjX3Jlc3VtZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikNCj4gICAJCXIg
PSBnZnhfdjEwXzBfd2FpdF9mb3JfcmxjX2F1dG9sb2FkX2NvbXBsZXRlKGFkZXYpOw0KPiAgIAkJ
aWYgKHIpDQo+ICAgCQkJcmV0dXJuIHI7DQo+IC0JCWdmeF92MTBfMF9pbml0X3BnKGFkZXYpOw0K
PiArDQo+ICsJCXIgPSBnZnhfdjEwXzBfaW5pdF9wZyhhZGV2KTsNCj4gKwkJaWYgKHIpDQo+ICsJ
CQlyZXR1cm4gcjsNCj4gICANCj4gICAJCS8qIGVuYWJsZSBSTEMgU1JNICovDQo+ICAgCQlnZnhf
djEwXzBfcmxjX2VuYWJsZV9zcm0oYWRldik7DQo+IEBAIC0xOTM3LDcgKzE5NjUsMTAgQEAgc3Rh
dGljIGludCBnZnhfdjEwXzBfcmxjX3Jlc3VtZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikN
Cj4gICAJCQkJcmV0dXJuIHI7DQo+ICAgCQl9DQo+ICAgDQo+IC0JCWdmeF92MTBfMF9pbml0X3Bn
KGFkZXYpOw0KPiArCQlyID0gZ2Z4X3YxMF8wX2luaXRfcGcoYWRldik7DQo+ICsJCWlmIChyKQ0K
PiArCQkJcmV0dXJuIHI7DQo+ICsNCj4gICAJCWFkZXYtPmdmeC5ybGMuZnVuY3MtPnN0YXJ0KGFk
ZXYpOw0KPiAgIA0KPiAgIAkJaWYgKGFkZXYtPmZpcm13YXJlLmxvYWRfdHlwZSA9PSBBTURHUFVf
RldfTE9BRF9STENfQkFDS0RPT1JfQVVUTykgDQo+IHsNCj4gLS0NCj4gMi4yMC4xDQo+DQo+IF9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQo+IGFtZC1nZngg
bWFpbGluZyBsaXN0DQo+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IGh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA0KPiBfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KPiBhbWQtZ2Z4IG1haWxp
bmcgbGlzdA0KPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBodHRwczovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngNCg0KX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QK
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
