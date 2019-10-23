Return-Path: <SRS0=+G2B=YQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA4E2CA9EB7
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Oct 2019 12:50:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA36320640
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Oct 2019 12:50:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA36320640
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84F646EA8E;
	Wed, 23 Oct 2019 12:50:59 +0000 (UTC)
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr820080.outbound.protection.outlook.com [40.107.82.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 300EC6EA8E
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Oct 2019 12:50:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=klNXvKaYdvsqu7DhajspGZwU+OwAIrdQbX6EziJzXckYPfRmenJ0SFKgxFVu913NbVrPBWFCCS4M20lfjcBo3FUkHvb9BYc6kJWdZkC5JfOeBkWqN3Mxj42jvjb256GtPOT5azxrxFYhuYsaFTEjkxkOBEBsPTHmotDiB1BOAr3JaGDYvwtcPjgSX70+vB7vdis2PKRmxAzLQOLzC0a3rS1TzUuxDynJFAfVEZSiYpXSNfbsMBuqKlrKycjxYNciflL2fXgmQeBZsKO/6l4juid2UXHHrjbjDy7RquYGB+R/GOi4QzOkIAl44jigO2/RZLeUwSwnPNa7lXbT1RGmWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JrjhKII5hx/CC2MlLMDIcC2SdgJ/SgJa2JEadimetgA=;
 b=WZ5A+jhsJHeGPuYyZXCD3qvXjqxkDkwKD6/hFBZztC8ZY896aCvOybQbGby44yJvIksFWAurAI253a01rUcY07VMtCNiu4In398z3o5GQ4+kjCcBeY40HrdUJuAlUXbjOBuM/yDAwM5aarr8IOsSoVSbLfUF4EmOFFzQfvNpEZee+V0qf5AgV5doQ5SW/J66YAzDh2pcNGOVOzQfy2azQFxY06eJM9FL0n0+3lTjXHDT6/4oXYkgnXgku9MOZJR4FiePcprfvAyeGP0S1d/pOStRlg6dp8ntuYAI84iS67JGV96H8A0UepZ/q6M/MM7dYFFdFmZqVnvDfVyfUkPx7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BN6PR12MB1809.namprd12.prod.outlook.com (10.175.101.17) by
 BN6PR12MB1410.namprd12.prod.outlook.com (10.168.225.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.24; Wed, 23 Oct 2019 12:50:55 +0000
Received: from BN6PR12MB1809.namprd12.prod.outlook.com
 ([fe80::f16d:2fda:9e18:a554]) by BN6PR12MB1809.namprd12.prod.outlook.com
 ([fe80::f16d:2fda:9e18:a554%12]) with mapi id 15.20.2347.029; Wed, 23 Oct
 2019 12:50:55 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Pelloux-prayer,
 Pierre-eric" <Pierre-eric.Pelloux-prayer@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/sdma5: do not execute 0-sized IBs (v2)
Thread-Topic: [PATCH] drm/amdgpu/sdma5: do not execute 0-sized IBs (v2)
Thread-Index: AQHViP090AZEFibW0UG1vMEf2pbBC6dn1jqAgABYmVA=
Date: Wed, 23 Oct 2019 12:50:55 +0000
Message-ID:
 <BN6PR12MB1809E6469D44AE818542299DF76B0@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <20191022172136.15391-1-pierre-eric.pelloux-prayer@amd.com>
 <b3ddc981-c465-b008-705a-d01e44b783e3@gmail.com>
In-Reply-To: <b3ddc981-c465-b008-705a-d01e44b783e3@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [165.204.55.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cf9845b0-5047-4cf6-d2a2-08d757b7a51e
x-ms-traffictypediagnostic: BN6PR12MB1410:
x-ms-exchange-purlcount: 2
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR12MB1410B75CE7809B314F5D4C5CF76B0@BN6PR12MB1410.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:597;
x-forefront-prvs: 019919A9E4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(366004)(346002)(39860400002)(136003)(396003)(13464003)(189003)(199004)(14454004)(64756008)(446003)(476003)(11346002)(86362001)(8676002)(966005)(33656002)(81156014)(478600001)(81166006)(8936002)(5660300002)(66446008)(66476007)(66946007)(66066001)(486006)(66556008)(2501003)(26005)(186003)(102836004)(52536014)(25786009)(256004)(53546011)(6506007)(76116006)(71190400001)(6246003)(76176011)(7736002)(305945005)(7696005)(6116002)(3846002)(74316002)(6436002)(55016002)(6306002)(229853002)(9686003)(71200400001)(99286004)(2906002)(110136005)(316002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR12MB1410;
 H:BN6PR12MB1809.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2V++Vs5E8GWiBrsxNbDqfnxZc5ajMTFEAcpDByVKt54FfWFAddYGbRH6p9ViDcmocOgZVyGJCkkPDdXndS0dXqt4ys/RTeiUgPxv1oBqoR4yL5pLgajD0riaBewS0TWooh7LgXUsM2VqGCkALm2s2Lz5eDsClsEAYk0HjabMNWAc5AGgvDJ0Ozc4Dn9/ezS1VoF/J7f7GOtVBw7kUDd92ucaW2fbu2ICpiD0upUwwZPfRDqeV99o/3LNeAbIGg8l06LQEUdou4FX79Qi6M4TZMILmEC2Apu1fFk5NEDenECCHwlXfYEawwMxFf8HfrPvwTYXsN2OfKqW+/goZ/7XTIdQsclOU0ujXhdhMpse/ww0jqC6nIw0Fuqjf+6+o3KGTYik6WFyBLSwgFZf7UIzRkx9Ti3qZg9OSncJTODiUpoL0yf04Z2sV64YKJfadhLceOaON5OLaI6cOfgZmUvC7go5RR2sJvaTC2x292MyXc8=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf9845b0-5047-4cf6-d2a2-08d757b7a51e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2019 12:50:55.4907 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8EGPsSyzMnxUeyFyrHbFqAbRZoGZswL5WhZko1Z9+3e25yhjjrfq6BLNY1p7SgIkHisf6WcIC7SOj/X9JNDMAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1410
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JrjhKII5hx/CC2MlLMDIcC2SdgJ/SgJa2JEadimetgA=;
 b=yKaW2Kv9IXm/sI4DDbOzghCBpT5YO8w7Z8PHbHsbaaLiwnSuD9HQA2bBjIl3sXDJPdj33r5f81GbOGMUbyA2CDXKqUaeX/UoL1CztRyrlWtOXBQAD9RYev6WZU7+hjFq7GTXTwBjs5gG73ENlxN10HO6tVlkAekJgen0HiXGbUc=
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191023125055.vj_BnsM33xbLBhY81JKm1VL_myoTqnMrbeaw6Y2lyc0@z>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBhbWQtZ2Z4IDxhbWQtZ2Z4LWJv
dW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPiBPbiBCZWhhbGYgT2YNCj4gQ2hyaXN0aWFuIEvD
tm5pZw0KPiBTZW50OiBXZWRuZXNkYXksIE9jdG9iZXIgMjMsIDIwMTkgMzozMyBBTQ0KPiBUbzog
UGVsbG91eC1wcmF5ZXIsIFBpZXJyZS1lcmljIDxQaWVycmUtZXJpYy5QZWxsb3V4LXByYXllckBh
bWQuY29tPjsgYW1kLQ0KPiBnZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IFN1YmplY3Q6IFJl
OiBbUEFUQ0hdIGRybS9hbWRncHUvc2RtYTU6IGRvIG5vdCBleGVjdXRlIDAtc2l6ZWQgSUJzICh2
MikNCj4gDQo+IEFtIDIyLjEwLjE5IHVtIDE5OjIyIHNjaHJpZWIgUGVsbG91eC1wcmF5ZXIsIFBp
ZXJyZS1lcmljOg0KPiA+IFRoaXMgc2VlbXMgdG8gaGVscCB3aXRoDQo+IGh0dHBzOi8vYnVncy5m
cmVlZGVza3RvcC5vcmcvc2hvd19idWcuY2dpP2lkPTExMTQ4MS4NCj4gPg0KPiA+IHYyOiBpbnNl
cnQgYSBOT1AgaW5zdGVhZCBvZiBza2lwcGluZyBhbGwgMC1zaXplZCBJQnMgdG8gYXZvaWQgYnJl
YWtpbmcgb2xkZXINCj4gaHcNCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFBpZXJyZS1FcmljIFBl
bGxvdXgtUHJheWVyIDxwaWVycmUtZXJpYy5wZWxsb3V4LQ0KPiBwcmF5ZXJAYW1kLmNvbT4NCj4g
DQo+IFJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5j
b20+DQoNCkRvIG5vcCBwYWNrZXRzIGhhdmUgYW55IGFsaWdubWVudCByZXF1aXJlbWVudHMgb24g
U0RNQT8gIFNvbWUgb2YgdGhlIG90aGVyIHBhY2tldHMgZG8uDQoNCkFsZXgNCg0KPiANCj4gPiAt
LS0NCj4gPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192MTBfMC5jIHwgMSArDQo+
ID4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCj4gPg0KPiA+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjEwXzAuYw0KPiBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2dtY192MTBfMC5jDQo+ID4gaW5kZXggZmI0ODYyMmMyYWJkLi42ZTFi
MjViZDFmZTcgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21j
X3YxMF8wLmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjEwXzAu
Yw0KPiA+IEBAIC0zMDksNiArMzA5LDcgQEAgc3RhdGljIHZvaWQgZ21jX3YxMF8wX2ZsdXNoX2dw
dV90bGIoc3RydWN0DQo+IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHVpbnQzMl90IHZtaWQsDQo+ID4N
Cj4gPiAgIAlqb2ItPnZtX3BkX2FkZHIgPSBhbWRncHVfZ21jX3BkX2FkZHIoYWRldi0+Z2FydC5i
byk7DQo+ID4gICAJam9iLT52bV9uZWVkc19mbHVzaCA9IHRydWU7DQo+ID4gKwlqb2ItPmlicy0+
cHRyW2pvYi0+aWJzLT5sZW5ndGhfZHcrK10gPSByaW5nLT5mdW5jcy0+bm9wOw0KPiA+ICAgCWFt
ZGdwdV9yaW5nX3BhZF9pYihyaW5nLCAmam9iLT5pYnNbMF0pOw0KPiA+ICAgCXIgPSBhbWRncHVf
am9iX3N1Ym1pdChqb2IsICZhZGV2LT5tbWFuLmVudGl0eSwNCj4gPiAgIAkJCSAgICAgIEFNREdQ
VV9GRU5DRV9PV05FUl9VTkRFRklORUQsICZmZW5jZSk7DQo+IA0KPiBfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KPiBhbWQtZ2Z4IG1haWxpbmcgbGlzdA0K
PiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngNCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4v
bGlzdGluZm8vYW1kLWdmeA==
