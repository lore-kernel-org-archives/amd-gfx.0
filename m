Return-Path: <SRS0=U5eA=Y5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF85C5DF60
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2019 16:16:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 706292087E
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2019 16:16:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 706292087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3ECE28982C;
	Tue,  5 Nov 2019 16:16:34 +0000 (UTC)
Received: from NAM03-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr790073.outbound.protection.outlook.com [40.107.79.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13D268982C
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Nov 2019 16:16:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CagkzPJQyi+rHfVYK7iNtVPdjys7ZZ/8NPxTt6Thq1l0N79Ghe1jQ4R+x0O2YjMRn0HQGIBQ9USlFZr9lwnWvWWC1/E/0n20ZChomV4YogOZZOCwK7cEjtHokYp99Q37JMsvl+Xf7wXtveUdjikeztc6U0ACk9w6th/Jftswx901BgyjzX9b4efVvANcwzcN1wDyV4MaxTiOuQ+iff497XFpRvoK2I0hbnT35QUEUyO8lG+ATxFWPcqHa7DQSEcwYwLzQ/7Uk2g4D+b/ifr0m9EtSrhtcice57B1iqMjc9GeRUMdtPdPpZMBe8yedIQTSVS3YMzRGjGbktFMK8polQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NVwQhy+MnNke4f3g0eXW35K0savbHxoPF1ruRmzTqnU=;
 b=Ao5j7bfvrgums5xHd2Z1xDN9V0MZPMKbLjC8PQKJl02SIoEBttMSKXSTIq9lI3uLnVJkNDKZae/8ruRDQjVOTBT06SfxdW2k2xl53VZyWfdcoiYWGoXsbiBdv7rLcvwzIKeRkqY/WiGxfK9N0YnH9gd1amiZnarGfNTh85pAjijV5nYp68q4YokKD9s9NcbeztQ5qam7SYfVzOc7E+d+1dxzhC4QVoGAWerdfj9Fm2p3bgBrGTY9myqxd45vW7BknTMfCJmOzjLwa80r3qYeOyPiW3yRuGHs8S3owL2A370ONBBzg04UTwa8j1Hcd/cjtqCVY7aTravfwkvpXELxoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BYAPR12MB3560.namprd12.prod.outlook.com (20.178.197.10) by
 BYAPR12MB3237.namprd12.prod.outlook.com (20.179.94.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Tue, 5 Nov 2019 16:16:31 +0000
Received: from BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::f950:f7be:9139:7c26]) by BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::f950:f7be:9139:7c26%7]) with mapi id 15.20.2408.024; Tue, 5 Nov 2019
 16:16:31 +0000
From: "Kazlauskas, Nicholas" <Nicholas.Kazlauskas@amd.com>
To: "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/2 v2] drm/amd/display: Disable VUpdate interrupt for DCN
 hardware
Thread-Topic: [PATCH 2/2 v2] drm/amd/display: Disable VUpdate interrupt for
 DCN hardware
Thread-Index: AQHVk/HhMTs/pkK6tUmyPDKZEaOhmKd8wNyA
Date: Tue, 5 Nov 2019 16:16:31 +0000
Message-ID: <47f9dd1b-66c1-a521-d6c8-b9422616cf2e@amd.com>
References: <20191105153416.32049-2-sunpeng.li@amd.com>
 <20191105155802.1302-1-sunpeng.li@amd.com>
In-Reply-To: <20191105155802.1302-1-sunpeng.li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YTOPR0101CA0014.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::27) To BYAPR12MB3560.namprd12.prod.outlook.com
 (2603:10b6:a03:ae::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.55.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 971b636f-4adf-4812-3de7-08d7620b84fd
x-ms-traffictypediagnostic: BYAPR12MB3237:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB32373E726B26BE865974CE33EC7E0@BYAPR12MB3237.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1227;
x-forefront-prvs: 0212BDE3BE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(979002)(4636009)(366004)(376002)(346002)(136003)(396003)(39860400002)(189003)(199004)(2501003)(26005)(6246003)(14454004)(6512007)(478600001)(2906002)(476003)(14444005)(110136005)(36756003)(66066001)(54906003)(316002)(256004)(102836004)(76176011)(229853002)(31696002)(386003)(5660300002)(6506007)(81166006)(305945005)(7736002)(31686004)(86362001)(2616005)(11346002)(81156014)(446003)(71190400001)(53546011)(8936002)(4326008)(486006)(186003)(6116002)(66556008)(99286004)(66946007)(66476007)(71200400001)(66446008)(64756008)(25786009)(6486002)(6436002)(3846002)(52116002)(8676002)(969003)(989001)(999001)(1009001)(1019001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3237;
 H:BYAPR12MB3560.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AvdRZ356OhTDj/wqM7GTBd7dB9OHyA6koIvYHys2QvE80p3JPXRPWb8FRFdwEwhhAElkZcSNuNYEcEMEB3S4Ft40Ufs7Al4i4JEAp4MLKVvPcrn7s1Mldfh2u0+KERqDL0Tk+GIQa4GnAdTQgC4yJ8/UAaQqrdEwGtOSiLK282GmGTFgvZDCJlC9x96ovCloykWls8eHte2HDo5iLpgLeK/sStQZcnMhieZ24rCrEo+RwOE/zRjIVtTJya7F82ufIEhfnAGkHNxfGsFj56zaP0MDkY+7Dpsdzbj/PIM1ddMHaJtg35Dm6JyhIVQXgwgGhuQ+7Mh65Ja2+HnN2WJYmLK+wvvlgksXqAqy/cyqoCY5AomIMte+7IFL1W83tAawPCQypEDGT2DvEhB3D/AFARhGOUgQrAZC98kb84nRAfEHyaM4wtgDTrF2+XP7xNm/
Content-ID: <7F411613EE98C84788223C5F2CDAB697@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 971b636f-4adf-4812-3de7-08d7620b84fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2019 16:16:31.3874 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OqHVPsGUGKHVIR7H5DG1L8IYxARkA0RWw2VbPoqjwlRAFlaSVNEUDxaLMC5dHFyrWzXuV76IYuPGgRu2TdiZ3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3237
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NVwQhy+MnNke4f3g0eXW35K0savbHxoPF1ruRmzTqnU=;
 b=qKVhvJr9TYfiTizPnbjwsKaFshb7WBQ6uE1EckgdsddURZpKyA2pba43MwJkwAvnfWBuir8n1LWaUIjU3B8HoTJyYyu/bvXxqMLiJ1rJwkTAeNSK7gOmIrPgmHrazrNsyquZdXl9QboQTPdsJGmvM0m8GQTmuU4QE0NedS1yn8M=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Nicholas.Kazlauskas@amd.com; 
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
 Harry" <Harry.Wentland@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191105161631.1QL35f3MEBZzIIfq4k2G2rx5Shd_jclXiE6InDdK-bE@z>

T24gMjAxOS0xMS0wNSAxMDo1OCBhLm0uLCBzdW5wZW5nLmxpQGFtZC5jb20gd3JvdGU6DQo+IEZy
b206IExlbyBMaSA8c3VucGVuZy5saUBhbWQuY29tPg0KPiANCj4gW1doeV0NCj4gDQo+IE9uIERD
TiBoYXJkd2FyZSwgdGhlIGNydGNfaGlnaF9pcnEgaGFuZGxlciBtYWtlcyB2dXBkYXRlX2hpZ2hf
aXJxDQo+IGhhbmRsZXIgcmVkdW5kYW50Lg0KPiANCj4gQWxsIHRoZSB2dXBkYXRlIGhhbmRsZXIg
ZG9lcyBpcyBoYW5kbGUgdmJsYW5rIGV2ZW50cywgYW5kIHVwZGF0ZSB2cnINCj4gZm9yIERDRSBo
dyAoZXhjbHVkaW5nIFZFR0EsIG1vcmUgb24gdGhhdCBsYXRlcikuIEFzIGZhciBhcyB1c2VybW9k
ZSBpcw0KPiBjb25jZXJuZWQuIHZzdGFydHVwIGhhcHBlbnMgY2xvc2UgZW5vdWdoIHRvIHZ1cGRh
dGUgb24gRENOIHRoYXQgaXQgY2FuDQo+IGJlIGNvbnNpZGVyZWQgdGhlICJzYW1lIi4gSGFuZGxp
bmcgdmJsYW5rIGFuZCB1cGRhdGluZyB2cnIgYXQgdnN0YXJ0dXANCj4gZWZmZWN0aXZlbHkgcmVw
bGFjZXMgdnVwZGF0ZSBvbiBEQ04uDQo+IA0KPiBWZWdhIGlzIGEgYml0IHNwZWNpYWwuIExpa2Ug
RENOLCB0aGUgVlJSIHJlZ2lzdGVycyBvbiBWZWdhIGFyZQ0KPiBkb3VibGUtYnVmZmVyZWQsIGFu
ZCBzd2FwcGVkIGF0IHZ1cGRhdGUuIEJ1dCBVbmxpa2UgRENOLCBpdCBsYWNrcyBhDQo+IHZzdGFy
dHVwIGludGVycnVwdC4gVGhpcyBtZWFucyB3ZSBjYW4ndCBxdWl0ZSByZW1vdmUgdGhlIHZ1cGRh
dGUgaGFuZGxlcg0KPiBmb3IgaXQsIHNpbmNlIGRlbGF5ZXJkIHVzZXIgZXZlbnRzIGR1ZSB0byB2
cnIgYXJlIHNlbnQgb2ZmIHRoZXJlLg0KPiANCj4gW0hvd10NCj4gDQo+IFJlbW92ZSByZWdpc3Ry
YXRpb24gb2YgVlVwZGF0ZSBpbnRlcnJ1cHQgaGFuZGxlciBmb3IgRENOLiBEaXNhYmxlDQo+IHZ1
cGRhdGUgaW50ZXJydXB0IGlmIGFzaWMgZmFtaWx5IERDTiwgZW5hYmxlIG90aGVyd2lzZS4NCj4g
DQo+IFNpZ25lZC1vZmYtYnk6IExlbyBMaSA8c3VucGVuZy5saUBhbWQuY29tPg0KPiAtLS0NCj4g
DQo+IHYyOiBEb24ndCBleGNsdWRlIHZlZ2Egd2hlbiBlbmFibGluZyB2dXBkYXRlIGludGVycnVw
dHMNCj4gDQo+ICAgLi4uL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5j
IHwgMzQgKysrLS0tLS0tLS0tLS0tLS0tLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlv
bnMoKyksIDMwIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jDQo+IGluZGV4IDI1NmEyM2EwZWMyOC4uMzY2
NGFmM2I0MWExIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1k
Z3B1X2RtL2FtZGdwdV9kbS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9h
bWRncHVfZG0vYW1kZ3B1X2RtLmMNCj4gQEAgLTIyNDEsMzQgKzIyNDEsNiBAQCBzdGF0aWMgaW50
IGRjbjEwX3JlZ2lzdGVyX2lycV9oYW5kbGVycyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikN
Cj4gICAJCQkJZG1fZGNuX2NydGNfaGlnaF9pcnEsIGNfaXJxX3BhcmFtcyk7DQo+ICAgCX0NCj4g
DQo+IC0JLyogVXNlIFZVUERBVEVfTk9fTE9DSyBpbnRlcnJ1cHQgb24gRENOLCB3aGljaCBzZWVt
cyB0byBjb3JyZXNwb25kIHRvDQo+IC0JICogdGhlIHJlZ3VsYXIgVlVQREFURSBpbnRlcnJ1cHQg
b24gRENFLiBXZSB3YW50IERDX0lSUV9TT1VSQ0VfVlVQREFURXgNCj4gLQkgKiB0byB0cmlnZ2Vy
IGF0IGVuZCBvZiBlYWNoIHZibGFuaywgcmVnYXJkbGVzcyBvZiBzdGF0ZSBvZiB0aGUgbG9jaywN
Cj4gLQkgKiBtYXRjaGluZyBEQ0UgYmVoYXZpb3VyLg0KPiAtCSAqLw0KPiAtCWZvciAoaSA9IERD
Tl8xXzBfX1NSQ0lEX19PVEcwX0lIQ19WX1VQREFURV9OT19MT0NLX0lOVEVSUlVQVDsNCj4gLQkg
ICAgIGkgPD0gRENOXzFfMF9fU1JDSURfX09URzBfSUhDX1ZfVVBEQVRFX05PX0xPQ0tfSU5URVJS
VVBUICsgYWRldi0+bW9kZV9pbmZvLm51bV9jcnRjIC0gMTsNCj4gLQkgICAgIGkrKykgew0KPiAt
CQlyID0gYW1kZ3B1X2lycV9hZGRfaWQoYWRldiwgU09DMTVfSUhfQ0xJRU5USURfRENFLCBpLCAm
YWRldi0+dnVwZGF0ZV9pcnEpOw0KPiAtDQo+IC0JCWlmIChyKSB7DQo+IC0JCQlEUk1fRVJST1Io
IkZhaWxlZCB0byBhZGQgdnVwZGF0ZSBpcnEgaWQhXG4iKTsNCj4gLQkJCXJldHVybiByOw0KPiAt
CQl9DQo+IC0NCj4gLQkJaW50X3BhcmFtcy5pbnRfY29udGV4dCA9IElOVEVSUlVQVF9ISUdIX0lS
UV9DT05URVhUOw0KPiAtCQlpbnRfcGFyYW1zLmlycV9zb3VyY2UgPQ0KPiAtCQkJZGNfaW50ZXJy
dXB0X3RvX2lycV9zb3VyY2UoZGMsIGksIDApOw0KPiAtDQo+IC0JCWNfaXJxX3BhcmFtcyA9ICZh
ZGV2LT5kbS52dXBkYXRlX3BhcmFtc1tpbnRfcGFyYW1zLmlycV9zb3VyY2UgLSBEQ19JUlFfU09V
UkNFX1ZVUERBVEUxXTsNCj4gLQ0KPiAtCQljX2lycV9wYXJhbXMtPmFkZXYgPSBhZGV2Ow0KPiAt
CQljX2lycV9wYXJhbXMtPmlycV9zcmMgPSBpbnRfcGFyYW1zLmlycV9zb3VyY2U7DQo+IC0NCj4g
LQkJYW1kZ3B1X2RtX2lycV9yZWdpc3Rlcl9pbnRlcnJ1cHQoYWRldiwgJmludF9wYXJhbXMsDQo+
IC0JCQkJZG1fdnVwZGF0ZV9oaWdoX2lycSwgY19pcnFfcGFyYW1zKTsNCj4gLQl9DQo+IC0NCj4g
ICAJLyogVXNlIEdSUEhfUEZMSVAgaW50ZXJydXB0ICovDQo+ICAgCWZvciAoaSA9IERDTl8xXzBf
X1NSQ0lEX19IVUJQMF9GTElQX0lOVEVSUlVQVDsNCj4gICAJCQlpIDw9IERDTl8xXzBfX1NSQ0lE
X19IVUJQMF9GTElQX0lOVEVSUlVQVCArIGFkZXYtPm1vZGVfaW5mby5udW1fY3J0YyAtIDE7DQo+
IEBAIC00MjY2LDcgKzQyMzgsNyBAQCBzdGF0aWMgaW5saW5lIGludCBkbV9zZXRfdmJsYW5rKHN0
cnVjdCBkcm1fY3J0YyAqY3J0YywgYm9vbCBlbmFibGUpDQo+ICAgCXN0cnVjdCBkbV9jcnRjX3N0
YXRlICphY3J0Y19zdGF0ZSA9IHRvX2RtX2NydGNfc3RhdGUoY3J0Yy0+c3RhdGUpOw0KPiAgIAlp
bnQgcmMgPSAwOw0KPiANCj4gLQlpZiAoZW5hYmxlKSB7DQo+ICsJaWYgKGVuYWJsZSAmJiBhZGV2
LT5mYW1pbHkgPD0gQU1ER1BVX0ZBTUlMWV9BSSkgew0KPiAgIAkJLyogdmJsYW5rIGlycSBvbiAt
PiBPbmx5IG5lZWQgdnVwZGF0ZSBpcnEgaW4gdnJyIG1vZGUgKi8NCj4gICAJCWlmIChhbWRncHVf
ZG1fdnJyX2FjdGl2ZShhY3J0Y19zdGF0ZSkpDQo+ICAgCQkJcmMgPSBkbV9zZXRfdnVwZGF0ZV9p
cnEoY3J0YywgdHJ1ZSk7DQo+IEBAIC02MjQzLDYgKzYyMTUsNyBAQCBzdGF0aWMgdm9pZCBwcmVf
dXBkYXRlX2ZyZWVzeW5jX3N0YXRlX29uX3N0cmVhbSgNCj4gICBzdGF0aWMgdm9pZCBhbWRncHVf
ZG1faGFuZGxlX3Zycl90cmFuc2l0aW9uKHN0cnVjdCBkbV9jcnRjX3N0YXRlICpvbGRfc3RhdGUs
DQo+ICAgCQkJCQkgICAgc3RydWN0IGRtX2NydGNfc3RhdGUgKm5ld19zdGF0ZSkNCj4gICB7DQo+
ICsJc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSBvbGRfc3RhdGUtPmJhc2UuY3J0Yy0+ZGV2
LT5kZXZfcHJpdmF0ZTsNCj4gICAJYm9vbCBvbGRfdnJyX2FjdGl2ZSA9IGFtZGdwdV9kbV92cnJf
YWN0aXZlKG9sZF9zdGF0ZSk7DQo+ICAgCWJvb2wgbmV3X3Zycl9hY3RpdmUgPSBhbWRncHVfZG1f
dnJyX2FjdGl2ZShuZXdfc3RhdGUpOw0KPiANCj4gQEAgLTYyNTUsNyArNjIyOCw4IEBAIHN0YXRp
YyB2b2lkIGFtZGdwdV9kbV9oYW5kbGVfdnJyX3RyYW5zaXRpb24oc3RydWN0IGRtX2NydGNfc3Rh
dGUgKm9sZF9zdGF0ZSwNCj4gICAJCSAqIFdlIGFsc28gbmVlZCB2dXBkYXRlIGlycSBmb3IgdGhl
IGFjdHVhbCBjb3JlIHZibGFuayBoYW5kbGluZw0KPiAgIAkJICogYXQgZW5kIG9mIHZibGFuay4N
Cj4gICAJCSAqLw0KPiAtCQlkbV9zZXRfdnVwZGF0ZV9pcnEobmV3X3N0YXRlLT5iYXNlLmNydGMs
IHRydWUpOw0KPiArCQlpZiAoYWRldi0+ZmFtaWx5IDw9IEFNREdQVV9GQU1JTFlfQUkpDQo+ICsJ
CQlkbV9zZXRfdnVwZGF0ZV9pcnEobmV3X3N0YXRlLT5iYXNlLmNydGMsIHRydWUpOw0KDQpDYW4g
d2UgbW92ZSB0aGUgaWYgaW50byBkbV9zZXRfdnVwZGF0ZV9pcnEgZGlyZWN0bHk/IFdlJ3JlIHNl
dHRpbmcgaXQgdG8gDQpmYWxzZSBldmVuIHdoZW4gd2UgZG9uJ3QgaGF2ZSBpdCB3aXRoIHRoaXMg
cGF0Y2guDQoNCk5pY2hvbGFzIEthemxhdXNrYXMNCg0KPiAgIAkJZHJtX2NydGNfdmJsYW5rX2dl
dChuZXdfc3RhdGUtPmJhc2UuY3J0Yyk7DQo+ICAgCQlEUk1fREVCVUdfRFJJVkVSKCIlczogY3J0
Yz0ldSBWUlIgb2ZmLT5vbjogR2V0IHZibGFuayByZWZcbiIsDQo+ICAgCQkJCSBfX2Z1bmNfXywg
bmV3X3N0YXRlLT5iYXNlLmNydGMtPmJhc2UuaWQpOw0KPiAtLQ0KPiAyLjIzLjANCj4gDQoNCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFp
bGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
