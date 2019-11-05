Return-Path: <SRS0=U5eA=Y5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49259C5DF60
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2019 18:54:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29F6F204EC
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2019 18:54:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29F6F204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5FCD6E422;
	Tue,  5 Nov 2019 18:54:28 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770054.outbound.protection.outlook.com [40.107.77.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A92996E422
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Nov 2019 18:54:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SUAcTkvDle8RRWhSvjfdQPdRWt/yVMfLueUydTQBbHPraUSE+C6zmeByuwgmrho/1inyQiEo5OeCjryaeYjEswHrW8vfhw1ZX3kwwvhf/rS4+etCkcUGCNOGreqknVrhDPvIRO2T1p0EiNiwywzyWBJfDQZNsx5nUghLJAa2IE/yR4tjSb4tVFi5AtS/ZFfsrZLOWnwwfbE+H4uzgipk0HggTjVeSJgek/UNRybS76NRnR+JE2LTr068v8042mshcw8YUWkJqjduu7Xf+ES1eRdbu4DZ0O4TvHuh5gNzfKhmhjMMMJSmhYKX3SEE0ET9c6erXleDWFP+YIhwZJAQTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wSg6fszuoeEjB88k+4teM+8sIdpZuseOFzjfD7RVyZ0=;
 b=exhdPSLjP/yQjXBpSo9KpitkX6m14NZskoVBAMLDU+pnOR5+CZfJmcpW05hmO+3ZxKYsQx/7hIL7iqRcjo8yTtoCp526JAzVkcSiRm52zAMYNwDmLH0E3ujGdqCw5I0il0DbApWrnM9evwgbRA/3V0imwp7Z+FJE0o/7ENhKwY7NpryjAV5dOpatidDK18R0Nci1VmCdA8kVfZW5D3EAS8ylgwi1udd0WzABHoMmjgv1ZFDe8lRD0mpa2eoQy04lHcC9XYWvGGPMLQAxB3PcnM1dLUw2L/FBD426/yoIvwRcbaZU5ZDCKLJRT6u3N1LNunTagnQyJW8+Uv7wQmw/PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BN7PR12MB2593.namprd12.prod.outlook.com (20.176.27.87) by
 BN7PR12MB2769.namprd12.prod.outlook.com (20.176.176.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Tue, 5 Nov 2019 18:54:24 +0000
Received: from BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::c9fd:22d8:cfdb:f430]) by BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::c9fd:22d8:cfdb:f430%5]) with mapi id 15.20.2408.024; Tue, 5 Nov 2019
 18:54:24 +0000
From: "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>
To: "Kazlauskas, Nicholas" <Nicholas.Kazlauskas@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/2 v2] drm/amd/display: Disable VUpdate interrupt for DCN
 hardware
Thread-Topic: [PATCH 2/2 v2] drm/amd/display: Disable VUpdate interrupt for
 DCN hardware
Thread-Index: AQHVk/Hi1JhT70a1BUyXSMmX3iwBqqd8wOGAgAAsGYA=
Date: Tue, 5 Nov 2019 18:54:23 +0000
Message-ID: <5255d1bb-8feb-ae3e-c326-62f4f6664fcc@amd.com>
References: <20191105153416.32049-2-sunpeng.li@amd.com>
 <20191105155802.1302-1-sunpeng.li@amd.com>
 <47f9dd1b-66c1-a521-d6c8-b9422616cf2e@amd.com>
In-Reply-To: <47f9dd1b-66c1-a521-d6c8-b9422616cf2e@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YTOPR0101CA0053.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::30) To BN7PR12MB2593.namprd12.prod.outlook.com
 (2603:10b6:408:25::23)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.55.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bb63be87-9921-4340-b6c0-08d7622192a5
x-ms-traffictypediagnostic: BN7PR12MB2769:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN7PR12MB27695B1FCF0AC415FE47BD0C827E0@BN7PR12MB2769.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-forefront-prvs: 0212BDE3BE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(366004)(346002)(376002)(136003)(396003)(199004)(189003)(2501003)(25786009)(99286004)(5660300002)(229853002)(186003)(26005)(14454004)(66446008)(7736002)(8936002)(66476007)(4326008)(2616005)(446003)(52116002)(11346002)(478600001)(54906003)(102836004)(110136005)(6506007)(305945005)(53546011)(386003)(66946007)(3846002)(476003)(81156014)(81166006)(316002)(486006)(31686004)(6246003)(64756008)(66556008)(66066001)(6436002)(86362001)(71200400001)(6486002)(36756003)(31696002)(256004)(6512007)(6116002)(76176011)(2906002)(14444005)(71190400001)(8676002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN7PR12MB2769;
 H:BN7PR12MB2593.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dt4U8ElgPkgHMrPQKrEWZ4tL9ziRazxHUAoqOxYfIxVrSIDZyr0Ey7ZbRf4gXZvxwhYPhmi7lIUanaAx9xALC/2nx2iTD54XQ9URcj0gy+wJwn2JmD8A+Nt2ClcgfJpwFm2JRBwJqZZBhITHPqHp3c+QroeK1WLTgzyStJi3CVl9PdrNOyKVwmGMZS4Y6l1exB4jk0MVAArt1WdutQU3w33Ov5FmL26765cxE2UUikePP0giZ6X+UPI0koLt2uMvM4LBsCJJXhMhsGAZW3PmufG5QCVBP8lcbkK/UHENP/Vi2CXTlxxhWa1N2gJGflakVjS8ZbMpnlHzFeO5YyiAuvYxc0a/WvxJ0AckTAOkFMHWRJm6abYB99Z24Eam4P0xN7Wd6mzSVXYX61asfE4Qua/5/laMEzr6LNF9FRtZJpgHlLcAWHGSTMzTu3oKm1iH
Content-ID: <135202EB332C974FAF7488C40F2729D0@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb63be87-9921-4340-b6c0-08d7622192a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2019 18:54:23.9655 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a87QRev9JBhEQIadyIUHdWK/NJ2UVeZUFwMH4Y7IRdTB8j6wVwyQhW7QbWbKDoHS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2769
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wSg6fszuoeEjB88k+4teM+8sIdpZuseOFzjfD7RVyZ0=;
 b=Z96bvS/5XY0CwKDf8KNxG+tijovtAuU6laszTLj+2IvfFb2sScgQVapSRcnCN1Ww+nDopokXTir1j7Ww/WNRUV55YtV22B7kocxg6+pGbt3K+GZHgSUikNeZ0OL9iwjpWKynoygAuNynRr8+SPiIbL44GA7c7iPtAzH37nQO6Ek=
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
 Harry" <Harry.Wentland@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191105185423.dxGLwdP6Dog5fOgJPMFCPZxV7g0Ynocp0mA0ToRjagc@z>

DQoNCk9uIDIwMTktMTEtMDUgMTE6MTYgYS5tLiwgS2F6bGF1c2thcywgTmljaG9sYXMgd3JvdGU6
DQo+IE9uIDIwMTktMTEtMDUgMTA6NTggYS5tLiwgc3VucGVuZy5saUBhbWQuY29tIHdyb3RlOg0K
Pj4gRnJvbTogTGVvIExpIDxzdW5wZW5nLmxpQGFtZC5jb20+DQo+Pg0KPj4gW1doeV0NCj4+DQo+
PiBPbiBEQ04gaGFyZHdhcmUsIHRoZSBjcnRjX2hpZ2hfaXJxIGhhbmRsZXIgbWFrZXMgdnVwZGF0
ZV9oaWdoX2lycQ0KPj4gaGFuZGxlciByZWR1bmRhbnQuDQo+Pg0KPj4gQWxsIHRoZSB2dXBkYXRl
IGhhbmRsZXIgZG9lcyBpcyBoYW5kbGUgdmJsYW5rIGV2ZW50cywgYW5kIHVwZGF0ZSB2cnINCj4+
IGZvciBEQ0UgaHcgKGV4Y2x1ZGluZyBWRUdBLCBtb3JlIG9uIHRoYXQgbGF0ZXIpLiBBcyBmYXIg
YXMgdXNlcm1vZGUgaXMNCj4+IGNvbmNlcm5lZC4gdnN0YXJ0dXAgaGFwcGVucyBjbG9zZSBlbm91
Z2ggdG8gdnVwZGF0ZSBvbiBEQ04gdGhhdCBpdCBjYW4NCj4+IGJlIGNvbnNpZGVyZWQgdGhlICJz
YW1lIi4gSGFuZGxpbmcgdmJsYW5rIGFuZCB1cGRhdGluZyB2cnIgYXQgdnN0YXJ0dXANCj4+IGVm
ZmVjdGl2ZWx5IHJlcGxhY2VzIHZ1cGRhdGUgb24gRENOLg0KPj4NCj4+IFZlZ2EgaXMgYSBiaXQg
c3BlY2lhbC4gTGlrZSBEQ04sIHRoZSBWUlIgcmVnaXN0ZXJzIG9uIFZlZ2EgYXJlDQo+PiBkb3Vi
bGUtYnVmZmVyZWQsIGFuZCBzd2FwcGVkIGF0IHZ1cGRhdGUuIEJ1dCBVbmxpa2UgRENOLCBpdCBs
YWNrcyBhDQo+PiB2c3RhcnR1cCBpbnRlcnJ1cHQuIFRoaXMgbWVhbnMgd2UgY2FuJ3QgcXVpdGUg
cmVtb3ZlIHRoZSB2dXBkYXRlIGhhbmRsZXINCj4+IGZvciBpdCwgc2luY2UgZGVsYXllcmQgdXNl
ciBldmVudHMgZHVlIHRvIHZyciBhcmUgc2VudCBvZmYgdGhlcmUuDQo+Pg0KPj4gW0hvd10NCj4+
DQo+PiBSZW1vdmUgcmVnaXN0cmF0aW9uIG9mIFZVcGRhdGUgaW50ZXJydXB0IGhhbmRsZXIgZm9y
IERDTi4gRGlzYWJsZQ0KPj4gdnVwZGF0ZSBpbnRlcnJ1cHQgaWYgYXNpYyBmYW1pbHkgRENOLCBl
bmFibGUgb3RoZXJ3aXNlLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IExlbyBMaSA8c3VucGVuZy5s
aUBhbWQuY29tPg0KPj4gLS0tDQo+Pg0KPj4gdjI6IERvbid0IGV4Y2x1ZGUgdmVnYSB3aGVuIGVu
YWJsaW5nIHZ1cGRhdGUgaW50ZXJydXB0cw0KPj4NCj4+ICAgLi4uL2dwdS9kcm0vYW1kL2Rpc3Bs
YXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jIHwgMzQgKysrLS0tLS0tLS0tLS0tLS0tLQ0KPj4gICAx
IGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAzMCBkZWxldGlvbnMoLSkNCj4+DQo+PiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVf
ZG0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMN
Cj4+IGluZGV4IDI1NmEyM2EwZWMyOC4uMzY2NGFmM2I0MWExIDEwMDY0NA0KPj4gLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYw0KPj4gKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYw0KPj4gQEAg
LTIyNDEsMzQgKzIyNDEsNiBAQCBzdGF0aWMgaW50IGRjbjEwX3JlZ2lzdGVyX2lycV9oYW5kbGVy
cyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikNCj4+ICAgCQkJCWRtX2Rjbl9jcnRjX2hpZ2hf
aXJxLCBjX2lycV9wYXJhbXMpOw0KPj4gICAJfQ0KPj4NCj4+IC0JLyogVXNlIFZVUERBVEVfTk9f
TE9DSyBpbnRlcnJ1cHQgb24gRENOLCB3aGljaCBzZWVtcyB0byBjb3JyZXNwb25kIHRvDQo+PiAt
CSAqIHRoZSByZWd1bGFyIFZVUERBVEUgaW50ZXJydXB0IG9uIERDRS4gV2Ugd2FudCBEQ19JUlFf
U09VUkNFX1ZVUERBVEV4DQo+PiAtCSAqIHRvIHRyaWdnZXIgYXQgZW5kIG9mIGVhY2ggdmJsYW5r
LCByZWdhcmRsZXNzIG9mIHN0YXRlIG9mIHRoZSBsb2NrLA0KPj4gLQkgKiBtYXRjaGluZyBEQ0Ug
YmVoYXZpb3VyLg0KPj4gLQkgKi8NCj4+IC0JZm9yIChpID0gRENOXzFfMF9fU1JDSURfX09URzBf
SUhDX1ZfVVBEQVRFX05PX0xPQ0tfSU5URVJSVVBUOw0KPj4gLQkgICAgIGkgPD0gRENOXzFfMF9f
U1JDSURfX09URzBfSUhDX1ZfVVBEQVRFX05PX0xPQ0tfSU5URVJSVVBUICsgYWRldi0+bW9kZV9p
bmZvLm51bV9jcnRjIC0gMTsNCj4+IC0JICAgICBpKyspIHsNCj4+IC0JCXIgPSBhbWRncHVfaXJx
X2FkZF9pZChhZGV2LCBTT0MxNV9JSF9DTElFTlRJRF9EQ0UsIGksICZhZGV2LT52dXBkYXRlX2ly
cSk7DQo+PiAtDQo+PiAtCQlpZiAocikgew0KPj4gLQkJCURSTV9FUlJPUigiRmFpbGVkIHRvIGFk
ZCB2dXBkYXRlIGlycSBpZCFcbiIpOw0KPj4gLQkJCXJldHVybiByOw0KPj4gLQkJfQ0KPj4gLQ0K
Pj4gLQkJaW50X3BhcmFtcy5pbnRfY29udGV4dCA9IElOVEVSUlVQVF9ISUdIX0lSUV9DT05URVhU
Ow0KPj4gLQkJaW50X3BhcmFtcy5pcnFfc291cmNlID0NCj4+IC0JCQlkY19pbnRlcnJ1cHRfdG9f
aXJxX3NvdXJjZShkYywgaSwgMCk7DQo+PiAtDQo+PiAtCQljX2lycV9wYXJhbXMgPSAmYWRldi0+
ZG0udnVwZGF0ZV9wYXJhbXNbaW50X3BhcmFtcy5pcnFfc291cmNlIC0gRENfSVJRX1NPVVJDRV9W
VVBEQVRFMV07DQo+PiAtDQo+PiAtCQljX2lycV9wYXJhbXMtPmFkZXYgPSBhZGV2Ow0KPj4gLQkJ
Y19pcnFfcGFyYW1zLT5pcnFfc3JjID0gaW50X3BhcmFtcy5pcnFfc291cmNlOw0KPj4gLQ0KPj4g
LQkJYW1kZ3B1X2RtX2lycV9yZWdpc3Rlcl9pbnRlcnJ1cHQoYWRldiwgJmludF9wYXJhbXMsDQo+
PiAtCQkJCWRtX3Z1cGRhdGVfaGlnaF9pcnEsIGNfaXJxX3BhcmFtcyk7DQo+PiAtCX0NCj4+IC0N
Cj4+ICAgCS8qIFVzZSBHUlBIX1BGTElQIGludGVycnVwdCAqLw0KPj4gICAJZm9yIChpID0gRENO
XzFfMF9fU1JDSURfX0hVQlAwX0ZMSVBfSU5URVJSVVBUOw0KPj4gICAJCQlpIDw9IERDTl8xXzBf
X1NSQ0lEX19IVUJQMF9GTElQX0lOVEVSUlVQVCArIGFkZXYtPm1vZGVfaW5mby5udW1fY3J0YyAt
IDE7DQo+PiBAQCAtNDI2Niw3ICs0MjM4LDcgQEAgc3RhdGljIGlubGluZSBpbnQgZG1fc2V0X3Zi
bGFuayhzdHJ1Y3QgZHJtX2NydGMgKmNydGMsIGJvb2wgZW5hYmxlKQ0KPj4gICAJc3RydWN0IGRt
X2NydGNfc3RhdGUgKmFjcnRjX3N0YXRlID0gdG9fZG1fY3J0Y19zdGF0ZShjcnRjLT5zdGF0ZSk7
DQo+PiAgIAlpbnQgcmMgPSAwOw0KPj4NCj4+IC0JaWYgKGVuYWJsZSkgew0KPj4gKwlpZiAoZW5h
YmxlICYmIGFkZXYtPmZhbWlseSA8PSBBTURHUFVfRkFNSUxZX0FJKSB7DQo+PiAgIAkJLyogdmJs
YW5rIGlycSBvbiAtPiBPbmx5IG5lZWQgdnVwZGF0ZSBpcnEgaW4gdnJyIG1vZGUgKi8NCj4+ICAg
CQlpZiAoYW1kZ3B1X2RtX3Zycl9hY3RpdmUoYWNydGNfc3RhdGUpKQ0KPj4gICAJCQlyYyA9IGRt
X3NldF92dXBkYXRlX2lycShjcnRjLCB0cnVlKTsNCj4+IEBAIC02MjQzLDYgKzYyMTUsNyBAQCBz
dGF0aWMgdm9pZCBwcmVfdXBkYXRlX2ZyZWVzeW5jX3N0YXRlX29uX3N0cmVhbSgNCj4+ICAgc3Rh
dGljIHZvaWQgYW1kZ3B1X2RtX2hhbmRsZV92cnJfdHJhbnNpdGlvbihzdHJ1Y3QgZG1fY3J0Y19z
dGF0ZSAqb2xkX3N0YXRlLA0KPj4gICAJCQkJCSAgICBzdHJ1Y3QgZG1fY3J0Y19zdGF0ZSAqbmV3
X3N0YXRlKQ0KPj4gICB7DQo+PiArCXN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0gb2xkX3N0
YXRlLT5iYXNlLmNydGMtPmRldi0+ZGV2X3ByaXZhdGU7DQo+PiAgIAlib29sIG9sZF92cnJfYWN0
aXZlID0gYW1kZ3B1X2RtX3Zycl9hY3RpdmUob2xkX3N0YXRlKTsNCj4+ICAgCWJvb2wgbmV3X3Zy
cl9hY3RpdmUgPSBhbWRncHVfZG1fdnJyX2FjdGl2ZShuZXdfc3RhdGUpOw0KPj4NCj4+IEBAIC02
MjU1LDcgKzYyMjgsOCBAQCBzdGF0aWMgdm9pZCBhbWRncHVfZG1faGFuZGxlX3Zycl90cmFuc2l0
aW9uKHN0cnVjdCBkbV9jcnRjX3N0YXRlICpvbGRfc3RhdGUsDQo+PiAgIAkJICogV2UgYWxzbyBu
ZWVkIHZ1cGRhdGUgaXJxIGZvciB0aGUgYWN0dWFsIGNvcmUgdmJsYW5rIGhhbmRsaW5nDQo+PiAg
IAkJICogYXQgZW5kIG9mIHZibGFuay4NCj4+ICAgCQkgKi8NCj4+IC0JCWRtX3NldF92dXBkYXRl
X2lycShuZXdfc3RhdGUtPmJhc2UuY3J0YywgdHJ1ZSk7DQo+PiArCQlpZiAoYWRldi0+ZmFtaWx5
IDw9IEFNREdQVV9GQU1JTFlfQUkpDQo+PiArCQkJZG1fc2V0X3Z1cGRhdGVfaXJxKG5ld19zdGF0
ZS0+YmFzZS5jcnRjLCB0cnVlKTsNCj4gDQo+IENhbiB3ZSBtb3ZlIHRoZSBpZiBpbnRvIGRtX3Nl
dF92dXBkYXRlX2lycSBkaXJlY3RseT8gV2UncmUgc2V0dGluZyBpdCB0byANCj4gZmFsc2UgZXZl
biB3aGVuIHdlIGRvbid0IGhhdmUgaXQgd2l0aCB0aGlzIHBhdGNoLg0KPiANCj4gTmljaG9sYXMg
S2F6bGF1c2thcw0KDQpHb29kIHBvaW50LCBkb24ndCBrbm93IHdoeSBJIGRpZG4ndCBkbyB0aGF0
IGluIHRoZSBmaXJzdCBwbGFjZSA6KQ0KDQpUaGFua3MsDQpMZW8NCg0KPiANCj4+ICAgCQlkcm1f
Y3J0Y192YmxhbmtfZ2V0KG5ld19zdGF0ZS0+YmFzZS5jcnRjKTsNCj4+ICAgCQlEUk1fREVCVUdf
RFJJVkVSKCIlczogY3J0Yz0ldSBWUlIgb2ZmLT5vbjogR2V0IHZibGFuayByZWZcbiIsDQo+PiAg
IAkJCQkgX19mdW5jX18sIG5ld19zdGF0ZS0+YmFzZS5jcnRjLT5iYXNlLmlkKTsNCj4+IC0tDQo+
PiAyLjIzLjANCj4+DQo+IA0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
