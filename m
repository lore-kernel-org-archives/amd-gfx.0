Return-Path: <SRS0=Gnzf=YR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31172CA9EAF
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Oct 2019 13:24:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B1442084C
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Oct 2019 13:24:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B1442084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A013B6E406;
	Thu, 24 Oct 2019 13:24:40 +0000 (UTC)
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr800044.outbound.protection.outlook.com [40.107.80.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BA886E406
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Oct 2019 13:24:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=anYXdLUEw1Ae8FtRRszoVItWIaWb08dkv1GNUgiw5wS8zzaikBP9IMgO9AU0jGbz6F+ZKbplq76sclqV3/rNsTofdBRy6l75s6HX5T1j1UzQoNJD/k5sqdtC4GOpuc8VwbAWySlqkGnUMapO/dwyxZ5UGQaV92jqgAi3Ij0n96HVnKo9g2UP6zHfke0dGZtmNulivYKar1JsWuhlGjkGe8Bq0ZM3EjEFQDv79+A6IoClfKpfosFeZXlMxX6KvUu0BVIm9LMmh5xl9fPpxcKDEG0MHYyVj058C+UXBbledcrONUwzUjkmg3hrX2T+kWoUxa1bzJBt0DvWPAhuVP7GhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vFjK8KSQgQu8HO3aMhpg1vDL4Pmf4ft/6BteDOQGWnY=;
 b=C2D8Kg3CKAAdMLWQ1FdAi6zNopl3c8aWL+tRcwItYmwZv0hfQ8aTVA7S2cCe6LQli7lkX0UuIv/ThPAsKG1hY4MHn7NnkR2vxTJoKhYszdVoyKDUXujjgQvfGlfbkD1dR+aBS6G8fAFHQKcNljyPtLrPxIzy50JTSSNvZK8+k02b+fUv27+vX4a82ynhzUpzIgYGBV+piRUmbyWrJGTxbE0krihimMMXd5LPTE+B8NNTE64CEQx/dtW8ywqLVFOhLjAi3eticsmJtaSwDjTqjafTLMHOF9LKqym6IZisVebdyLky+ryUiYMVXWpg22CAfmUwxIm+hhpgl7BCd4yGbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM5PR12MB1820.namprd12.prod.outlook.com (10.175.88.143) by
 DM5PR12MB1258.namprd12.prod.outlook.com (10.168.239.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.18; Thu, 24 Oct 2019 13:24:38 +0000
Received: from DM5PR12MB1820.namprd12.prod.outlook.com
 ([fe80::cdcf:e46c:3b50:5e68]) by DM5PR12MB1820.namprd12.prod.outlook.com
 ([fe80::cdcf:e46c:3b50:5e68%5]) with mapi id 15.20.2367.027; Thu, 24 Oct 2019
 13:24:38 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/powerplay: correct current clock level label for
 Arcturus
Thread-Topic: [PATCH] drm/amd/powerplay: correct current clock level label for
 Arcturus
Thread-Index: AQHVijOzz1U47lcEPUabQ2bBkWzWWqdpyC/g
Date: Thu, 24 Oct 2019 13:24:38 +0000
Message-ID:
 <DM5PR12MB182019E777C10343D32D0B6BF76A0@DM5PR12MB1820.namprd12.prod.outlook.com>
References: <20191024062404.21825-1-evan.quan@amd.com>
In-Reply-To: <20191024062404.21825-1-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [165.204.55.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8fcedcd7-6739-499c-aa19-08d758858522
x-ms-traffictypediagnostic: DM5PR12MB1258:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB125801117042195D5CADF908F76A0@DM5PR12MB1258.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:217;
x-forefront-prvs: 0200DDA8BE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(396003)(376002)(346002)(39860400002)(136003)(189003)(199004)(13464003)(8676002)(71200400001)(478600001)(71190400001)(14444005)(256004)(966005)(76176011)(99286004)(52536014)(316002)(110136005)(25786009)(186003)(66066001)(7736002)(7696005)(6306002)(33656002)(54906003)(74316002)(305945005)(14454004)(66556008)(76116006)(2906002)(476003)(64756008)(3846002)(9686003)(66476007)(66446008)(6506007)(53546011)(6246003)(11346002)(486006)(2501003)(5660300002)(4326008)(66946007)(6436002)(8936002)(229853002)(81156014)(81166006)(446003)(86362001)(26005)(102836004)(55016002)(6116002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1258;
 H:DM5PR12MB1820.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oHwgpWCWPAI157oG4uXsl4ue1NjDsWcTaZBWvcdYGxrqYltBD68/kl1UBf90a38OdBcfHPqKsfq3nhWyTMrPzNOMdvV5gt7X4s3DhezU9f4WU2/LxzcLBUOI/px4++tL2mMbHdlUHzLtvnLAj5nTcRJX0HToACppIoKTd8NA/gJQtjClzUio3P4L8OYELOc8zpXAixYuO/epGuMvIJ5wegDuq4yTEU/DahdCAZOR2DGq+mp29u6h8GiJ7z7AInnLj+b7jMUSORPnW6l5dYePmCKHBH4AAYuLIc/koPCuMtwxyQqUjomf+9lqIiXbd8GDF3I2GcoKRI7LiWU0Aj+xikz0QfsMhdnuNcNaSyfimJgrMrmwk7Kv66UbfroxlmqHlt9p61QVqz+eSTfS028j4sw0QPp3P9JhUsNxeCZI+R7pJkXRcUv1/xLVr7vS1gyd2p8ejkGZvJ2nAeZG8Cd1buH0YK6XFN5ZrSL42u8rCJ4=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fcedcd7-6739-499c-aa19-08d758858522
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2019 13:24:38.2471 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xaq0DIYJixMiET4vKsMDUqP3c/dHpMzYGTACbWU7oSXoBSxnFO4uFfcfFJB4BJGS3v84Xj/PqPl9SCjfSmVGow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1258
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vFjK8KSQgQu8HO3aMhpg1vDL4Pmf4ft/6BteDOQGWnY=;
 b=xbq+52km/QtmDKfy74j5dWUV/RpOia3cBOE6a6PhkePY9e6wxnnVRlSWBKLVYIoZaC/AIcTHUJx153uX9yYLgJToIPZJhKb+ZMDghOW0nrHzYz+6e5/Zlzwz2f1znDf7WfFmg+aIkQgRjvfRFlDO/8EpBurmnxQtb5jRFPI39g0=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Deucher@amd.com; 
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
Cc: "Li, Candice" <Candice.Li@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191024132438.TmEZOOW9k8FcEBDLZXPlae8Bv_1OedtLE37z37OHLkk@z>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBhbWQtZ2Z4IDxhbWQtZ2Z4LWJv
dW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPiBPbiBCZWhhbGYgT2YNCj4gUXVhbiwgRXZhbg0K
PiBTZW50OiBUaHVyc2RheSwgT2N0b2JlciAyNCwgMjAxOSAyOjI1IEFNDQo+IFRvOiBhbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBDYzogTGksIENhbmRpY2UgPENhbmRpY2UuTGlAYW1k
LmNvbT47IFF1YW4sIEV2YW4gPEV2YW4uUXVhbkBhbWQuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0hd
IGRybS9hbWQvcG93ZXJwbGF5OiBjb3JyZWN0IGN1cnJlbnQgY2xvY2sgbGV2ZWwgbGFiZWwgZm9y
DQo+IEFyY3R1cnVzDQo+IA0KPiBGb3IgZHBtIGRpc2FibGVkIGNhc2UsIGl0J3MgYXNzdW1lZCB0
aGUgb25seSBvbmUgc3VwcG9ydCBjbG9jayBsZXZlbCBpcyBhbHdheXMNCj4gY3VycmVudCBjbG9j
ayBsZXZlbC4NCj4gDQo+IENoYW5nZS1JZDogSTVjYzJiN2U4MmFmODg4ZGM1ZTgyNjg1OTdlZTc2
MWU5ZTFhMjY4NTUNCj4gU2lnbmVkLW9mZi1ieTogRXZhbiBRdWFuIDxldmFuLnF1YW5AYW1kLmNv
bT4NCg0KQWNrZWQtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4N
Cg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2FyY3R1cnVzX3BwdC5j
IHwgMjQgKysrKysrKysrKysrKy0tLS0tLQ0KPiAtDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTYgaW5z
ZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL3Bvd2VycGxheS9hcmN0dXJ1c19wcHQuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvcG93ZXJwbGF5L2FyY3R1cnVzX3BwdC5jDQo+IGluZGV4IDFiY2M1YWIyODczZC4uZmNjOWI2
ZDI0ZThlIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9hcmN0
dXJ1c19wcHQuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9hcmN0dXJ1
c19wcHQuYw0KPiBAQCAtNjcwLDEyICs2NzAsMTcgQEAgc3RhdGljIGludCBhcmN0dXJ1c19wcmlu
dF9jbGtfbGV2ZWxzKHN0cnVjdA0KPiBzbXVfY29udGV4dCAqc211LA0KPiAgCQkJcmV0dXJuIHJl
dDsNCj4gIAkJfQ0KPiANCj4gKwkJLyoNCj4gKwkJICogRm9yIERQTSBkaXNhYmxlZCBjYXNlLCB0
aGVyZSB3aWxsIGJlIG9ubHkgb25lIGNsb2NrIGxldmVsLg0KPiArCQkgKiBBbmQgaXQncyBzYWZl
IHRvIGFzc3VtZSB0aGF0IGlzIGFsd2F5cyB0aGUgY3VycmVudCBjbG9jay4NCj4gKwkJICovDQo+
ICAJCWZvciAoaSA9IDA7IGkgPCBjbG9ja3MubnVtX2xldmVsczsgaSsrKQ0KPiAgCQkJc2l6ZSAr
PSBzcHJpbnRmKGJ1ZiArIHNpemUsICIlZDogJXVNaHogJXNcbiIsIGksDQo+ICAJCQkJCWNsb2Nr
cy5kYXRhW2ldLmNsb2Nrc19pbl9raHogLyAxMDAwLA0KPiAtCQkJCQlhcmN0dXJ1c19mcmVxc19p
bl9zYW1lX2xldmVsKA0KPiArCQkJCQkoY2xvY2tzLm51bV9sZXZlbHMgPT0gMSkgPyAiKiIgOg0K
PiArCQkJCQkoYXJjdHVydXNfZnJlcXNfaW5fc2FtZV9sZXZlbCgNCj4gIAkJCQkJY2xvY2tzLmRh
dGFbaV0uY2xvY2tzX2luX2toeiAvIDEwMDAsDQo+IC0JCQkJCW5vdyAvIDEwMCkgPyAiKiIgOiAi
Iik7DQo+ICsJCQkJCW5vdyAvIDEwMCkgPyAiKiIgOiAiIikpOw0KPiAgCQlicmVhazsNCj4gDQo+
ICAJY2FzZSBTTVVfTUNMSzoNCj4gQEAgLTY5NSw5ICs3MDAsMTAgQEAgc3RhdGljIGludCBhcmN0
dXJ1c19wcmludF9jbGtfbGV2ZWxzKHN0cnVjdA0KPiBzbXVfY29udGV4dCAqc211LA0KPiAgCQlm
b3IgKGkgPSAwOyBpIDwgY2xvY2tzLm51bV9sZXZlbHM7IGkrKykNCj4gIAkJCXNpemUgKz0gc3By
aW50ZihidWYgKyBzaXplLCAiJWQ6ICV1TWh6ICVzXG4iLA0KPiAgCQkJCWksIGNsb2Nrcy5kYXRh
W2ldLmNsb2Nrc19pbl9raHogLyAxMDAwLA0KPiAtCQkJCWFyY3R1cnVzX2ZyZXFzX2luX3NhbWVf
bGV2ZWwoDQo+ICsJCQkJKGNsb2Nrcy5udW1fbGV2ZWxzID09IDEpID8gIioiIDoNCj4gKwkJCQko
YXJjdHVydXNfZnJlcXNfaW5fc2FtZV9sZXZlbCgNCj4gIAkJCQljbG9ja3MuZGF0YVtpXS5jbG9j
a3NfaW5fa2h6IC8gMTAwMCwNCj4gLQkJCQlub3cgLyAxMDApID8gIioiIDogIiIpOw0KPiArCQkJ
CW5vdyAvIDEwMCkgPyAiKiIgOiAiIikpOw0KPiAgCQlicmVhazsNCj4gDQo+ICAJY2FzZSBTTVVf
U09DQ0xLOg0KPiBAQCAtNzE3LDkgKzcyMywxMCBAQCBzdGF0aWMgaW50IGFyY3R1cnVzX3ByaW50
X2Nsa19sZXZlbHMoc3RydWN0DQo+IHNtdV9jb250ZXh0ICpzbXUsDQo+ICAJCWZvciAoaSA9IDA7
IGkgPCBjbG9ja3MubnVtX2xldmVsczsgaSsrKQ0KPiAgCQkJc2l6ZSArPSBzcHJpbnRmKGJ1ZiAr
IHNpemUsICIlZDogJXVNaHogJXNcbiIsDQo+ICAJCQkJaSwgY2xvY2tzLmRhdGFbaV0uY2xvY2tz
X2luX2toeiAvIDEwMDAsDQo+IC0JCQkJYXJjdHVydXNfZnJlcXNfaW5fc2FtZV9sZXZlbCgNCj4g
KwkJCQkoY2xvY2tzLm51bV9sZXZlbHMgPT0gMSkgPyAiKiIgOg0KPiArCQkJCShhcmN0dXJ1c19m
cmVxc19pbl9zYW1lX2xldmVsKA0KPiAgCQkJCWNsb2Nrcy5kYXRhW2ldLmNsb2Nrc19pbl9raHog
LyAxMDAwLA0KPiAtCQkJCW5vdyAvIDEwMCkgPyAiKiIgOiAiIik7DQo+ICsJCQkJbm93IC8gMTAw
KSA/ICIqIiA6ICIiKSk7DQo+ICAJCWJyZWFrOw0KPiANCj4gIAljYXNlIFNNVV9GQ0xLOg0KPiBA
QCAtNzM5LDkgKzc0NiwxMCBAQCBzdGF0aWMgaW50IGFyY3R1cnVzX3ByaW50X2Nsa19sZXZlbHMo
c3RydWN0DQo+IHNtdV9jb250ZXh0ICpzbXUsDQo+ICAJCWZvciAoaSA9IDA7IGkgPCBzaW5nbGVf
ZHBtX3RhYmxlLT5jb3VudDsgaSsrKQ0KPiAgCQkJc2l6ZSArPSBzcHJpbnRmKGJ1ZiArIHNpemUs
ICIlZDogJXVNaHogJXNcbiIsDQo+ICAJCQkJaSwgc2luZ2xlX2RwbV90YWJsZS0+ZHBtX2xldmVs
c1tpXS52YWx1ZSwNCj4gLQkJCQlhcmN0dXJ1c19mcmVxc19pbl9zYW1lX2xldmVsKA0KPiArCQkJ
CShjbG9ja3MubnVtX2xldmVscyA9PSAxKSA/ICIqIiA6DQo+ICsJCQkJKGFyY3R1cnVzX2ZyZXFz
X2luX3NhbWVfbGV2ZWwoDQo+ICAJCQkJY2xvY2tzLmRhdGFbaV0uY2xvY2tzX2luX2toeiAvIDEw
MDAsDQo+IC0JCQkJbm93IC8gMTAwKSA/ICIqIiA6ICIiKTsNCj4gKwkJCQlub3cgLyAxMDApID8g
IioiIDogIiIpKTsNCj4gIAkJYnJlYWs7DQo+IA0KPiAgCWRlZmF1bHQ6DQo+IC0tDQo+IDIuMjMu
MA0KPiANCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18N
Cj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QNCj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcN
Cj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
DQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4
IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
