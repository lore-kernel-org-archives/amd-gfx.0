Return-Path: <SRS0=U5eA=Y5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B7D8C5DF60
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2019 20:21:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8CD921929
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2019 20:21:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8CD921929
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F9B26E4F1;
	Tue,  5 Nov 2019 20:21:20 +0000 (UTC)
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr800059.outbound.protection.outlook.com [40.107.80.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F36D6E4F1
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Nov 2019 20:21:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=coMY2TjInphJvN1XK9cwaha0EnORipu4lWuYT3ET2SQnesc9McOFcHwQv9J65Hrb+aZXvOF2+6e+oclrpx/FBlZNa/1IpToji0gfbV+eRwE5ekEXMhP5v0s8mVX9L6RBvBrZpCcaD24lIp4+42mpWWRa9+yYKKz0UyTWRVmSzEN9AroPzHg8j53kXy9pBJ9NfrmMLbjewudsmxLdWv9uCRM7PN+I+2iETZ1cYcpEwToiCtNnDG5MXiNgB0y1mL3kj/u62KRNCNt4aqkm4R5QuBClGEeFdHVr4EAVuOazqmkDCGu/bm6EiQoCcFre802ZvGPGde4YOg8pLLAom7k6BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uxRhSec3KkCRQk3H+F3Myzfp6muTbRSUeUj/SgvJIMA=;
 b=Z5UJOuJN/tytlON0U6G6u2whdBoqmlchO7Rkcp+n5nxwDi5fupeH0lxFSXvaffrwdl/tIWMj0OplEhMJWfkCMQWcnxwg5nh6T+XU42sDgeG7hNDzKMlpAT995SQMau6X8OfXIZkremyPAup7sFeAk37dqO9Or/RlPK6vMo2dMSaF5fyANGnfMNOQtAUkzyZrKQb2ddX8edIyedBZh0qGj17qfnk3/DelvDcKLKE0E8x9HxbXiZr5ELEBB5dFkUbh//O3uY3tj2DhpM93X9ALVGSWy0UAdeSDWsJN2+a4Fuzg1tLAtf+cLB4LeVfKCk/Xq/ERvNuyUi/7H7STlo6sRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BYAPR12MB3560.namprd12.prod.outlook.com (20.178.197.10) by
 BYAPR12MB2695.namprd12.prod.outlook.com (20.176.253.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Tue, 5 Nov 2019 20:21:17 +0000
Received: from BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::f950:f7be:9139:7c26]) by BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::f950:f7be:9139:7c26%7]) with mapi id 15.20.2408.024; Tue, 5 Nov 2019
 20:21:17 +0000
From: "Kazlauskas, Nicholas" <Nicholas.Kazlauskas@amd.com>
To: "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v4] drm/amd/display: Disable VUpdate interrupt for DCN
 hardware
Thread-Topic: [PATCH v4] drm/amd/display: Disable VUpdate interrupt for DCN
 hardware
Thread-Index: AQHVlAxB38qDchzNN0ezT5iRH8hnZKd9BQqA
Date: Tue, 5 Nov 2019 20:21:16 +0000
Message-ID: <0b7d332e-0ed0-6d5a-52e2-287b7c1c0a7c@amd.com>
References: <20191105155802.1302-1-sunpeng.li@amd.com>
 <20191105190709.7816-1-sunpeng.li@amd.com>
In-Reply-To: <20191105190709.7816-1-sunpeng.li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YTBPR01CA0006.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::19) To BYAPR12MB3560.namprd12.prod.outlook.com
 (2603:10b6:a03:ae::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.55.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9d7c1013-766f-48bc-a838-08d7622db63b
x-ms-traffictypediagnostic: BYAPR12MB2695:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB269596C61E4FB3F09C7EBBA3EC7E0@BYAPR12MB2695.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0212BDE3BE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(136003)(376002)(39860400002)(366004)(396003)(189003)(199004)(110136005)(966005)(71200400001)(71190400001)(86362001)(305945005)(6246003)(64756008)(6306002)(66476007)(66946007)(66556008)(6512007)(66446008)(31696002)(54906003)(256004)(14444005)(2501003)(66066001)(6436002)(478600001)(2906002)(36756003)(6486002)(25786009)(186003)(52116002)(76176011)(316002)(4326008)(99286004)(81156014)(81166006)(486006)(14454004)(446003)(476003)(11346002)(7736002)(31686004)(229853002)(3846002)(5660300002)(6506007)(53546011)(102836004)(386003)(2616005)(8676002)(8936002)(6116002)(26005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB2695;
 H:BYAPR12MB3560.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XY1NOCPIF+Xd3vLB6lbYarEm+RU1BE9bdSyk0D1C6TinQ/h7OChuv2kN0RhADLzfMBoZaTrhtZzN5eLrMnMFtWWka73jLf5hh6MVCG6VWtNAcnv4DwD4Sq7hhcgJbKaDW8zfm1wixCEYl93yHaJ8ud2W71PrVO+ptc7XszdI63HSBabc/jx5+8nVEGdoTrxE/yxW1miOIUmvLTCJqyRuxwoA7HbLwXGZyMXtbQJQzm3PqihwEUq8DeRsy0qNrlKc/HaTDb34lBiBFRT4to8UJy/ucBTdYC58VLxMXBl+l9VBb6Gi6yCn1d2YNdHQqujNfatQEZ77CeNFo2S+9FNHsvev21Oxa0TZGsb6opbuy9fOX+qVzVTTP9jhGCHj4zU1lRAVp1qrNwLkQUzcWwwamZwdAjZXE57bRAMn6zjhwl82kxYdYLcKYqq4aVVhlbnMdgh9bY4Y6UNbN61L5TAss5GiDT6i9guXzsxcRHeWWSo=
Content-ID: <950A98D540F76F4DB8DBFF79165CA736@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d7c1013-766f-48bc-a838-08d7622db63b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2019 20:21:16.8316 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CVThkHB7dKjqQOT0CcZ+qfO1+ot60DatBDZ8YF51H9o5cm4gvulAIdhnu1CDsNxNqnwFrmkyMybmQ2Hx5KgDnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2695
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uxRhSec3KkCRQk3H+F3Myzfp6muTbRSUeUj/SgvJIMA=;
 b=bqS8Ob9Jj/znIbKewEwShC5YrPCU6Px6SaCfOVjGjzA5zs6C9tIq8lpVPI17Vs3D/V25PJ1XTisRDV3WVAAtF3O3XGhNnk9mQ3xyheLkd4zvV615cDCH8l80cl1bwnlFXDM427bQQyg6ZzfV7dL4b2CxtBxYGxB3tL6df9i6G60=
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
Message-ID: <20191105202116.nlBxw5sFpFvZqnfNC5TlFJo5CF7ktP848J4B5WxOIeo@z>

T24gMjAxOS0xMS0wNSAyOjA3IHAubS4sIHN1bnBlbmcubGlAYW1kLmNvbSB3cm90ZToNCj4gRnJv
bTogTGVvIExpIDxzdW5wZW5nLmxpQGFtZC5jb20+DQo+IA0KPiBbV2h5XQ0KPiANCj4gT24gRENO
IGhhcmR3YXJlLCB0aGUgY3J0Y19oaWdoX2lycSBoYW5kbGVyIG1ha2VzIHZ1cGRhdGVfaGlnaF9p
cnENCj4gaGFuZGxlciByZWR1bmRhbnQuDQo+IA0KPiBBbGwgdGhlIHZ1cGRhdGUgaGFuZGxlciBk
b2VzIGlzIGhhbmRsZSB2YmxhbmsgZXZlbnRzLCBhbmQgdXBkYXRlIHZycg0KPiBmb3IgRENFIGh3
IChleGNsdWRpbmcgVkVHQSwgbW9yZSBvbiB0aGF0IGxhdGVyKS4gQXMgZmFyIGFzIHVzZXJtb2Rl
IGlzDQo+IGNvbmNlcm5lZC4gdnN0YXJ0dXAgaGFwcGVucyBjbG9zZSBlbm91Z2ggdG8gdnVwZGF0
ZSBvbiBEQ04gdGhhdCBpdCBjYW4NCj4gYmUgY29uc2lkZXJlZCB0aGUgInNhbWUiLiBIYW5kbGlu
ZyB2YmxhbmsgYW5kIHVwZGF0aW5nIHZyciBhdCB2c3RhcnR1cA0KPiBlZmZlY3RpdmVseSByZXBs
YWNlcyB2dXBkYXRlIG9uIERDTi4NCj4gDQo+IFZlZ2EgaXMgYSBiaXQgc3BlY2lhbC4gTGlrZSBE
Q04sIHRoZSBWUlIgcmVnaXN0ZXJzIG9uIFZlZ2EgYXJlDQo+IGRvdWJsZS1idWZmZXJlZCwgYW5k
IHN3YXBwZWQgYXQgdnVwZGF0ZS4gQnV0IFVubGlrZSBEQ04sIGl0IGxhY2tzIGENCj4gdnN0YXJ0
dXAgaW50ZXJydXB0LiBUaGlzIG1lYW5zIHdlIGNhbid0IHF1aXRlIHJlbW92ZSB0aGUgdnVwZGF0
ZSBoYW5kbGVyDQo+IGZvciBpdCwgc2luY2UgZGVsYXllZCB1c2VyIGV2ZW50cyBkdWUgdG8gdnJy
IGFyZSBzZW50IG9mZiB0aGVyZS4NCj4gDQo+IFtIb3ddDQo+IA0KPiBSZW1vdmUgcmVnaXN0cmF0
aW9uIG9mIHZ1cGRhdGUgaW50ZXJydXB0IGhhbmRsZXIgZm9yIERDTi4gRGlzYWJsZQ0KPiB2dXBk
YXRlIGludGVycnVwdCBpZiBhc2ljIGZhbWlseSBEQ04sIGVuYWJsZSBvdGhlcndpc2UuDQo+IA0K
PiBTaWduZWQtb2ZmLWJ5OiBMZW8gTGkgPHN1bnBlbmcubGlAYW1kLmNvbT4NCg0KUmV2aWV3ZWQt
Ynk6IE5pY2hvbGFzIEthemxhdXNrYXMgPG5pY2hvbGFzLmthemxhdXNrYXNAYW1kLmNvbT4NCg0K
PiAtLS0NCj4gDQo+IHYyOiBEb24ndCBleGNsdWRlIHZlZ2Egd2hlbiBlbmFibGluZyB2dXBkYXRl
IGludGVycnVwdHMNCj4gDQo+IHYzOiBNb3ZlIEZBTUlMWV9BSSBjaGVjayBpbnNpZGUgZG1fc2V0
X3Z1cGRhdGVfaXJxKCkNCj4gDQo+IHY0OiBDb3JyZWN0IGEgYnJhaW4gZmFydA0KPiANCj4gICAu
Li4vZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMgfCAzMiArKystLS0t
LS0tLS0tLS0tLS0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMjggZGVs
ZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5
L2FtZGdwdV9kbS9hbWRncHVfZG0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRn
cHVfZG0vYW1kZ3B1X2RtLmMNCj4gaW5kZXggMjU2YTIzYTBlYzI4Li5kNDAxODVkZmQwYzAgMTAw
NjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1
X2RtLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRn
cHVfZG0uYw0KPiBAQCAtMjI0MSwzNCArMjI0MSw2IEBAIHN0YXRpYyBpbnQgZGNuMTBfcmVnaXN0
ZXJfaXJxX2hhbmRsZXJzKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQ0KPiAgIAkJCQlkbV9k
Y25fY3J0Y19oaWdoX2lycSwgY19pcnFfcGFyYW1zKTsNCj4gICAJfQ0KPiANCj4gLQkvKiBVc2Ug
VlVQREFURV9OT19MT0NLIGludGVycnVwdCBvbiBEQ04sIHdoaWNoIHNlZW1zIHRvIGNvcnJlc3Bv
bmQgdG8NCj4gLQkgKiB0aGUgcmVndWxhciBWVVBEQVRFIGludGVycnVwdCBvbiBEQ0UuIFdlIHdh
bnQgRENfSVJRX1NPVVJDRV9WVVBEQVRFeA0KPiAtCSAqIHRvIHRyaWdnZXIgYXQgZW5kIG9mIGVh
Y2ggdmJsYW5rLCByZWdhcmRsZXNzIG9mIHN0YXRlIG9mIHRoZSBsb2NrLA0KPiAtCSAqIG1hdGNo
aW5nIERDRSBiZWhhdmlvdXIuDQo+IC0JICovDQo+IC0JZm9yIChpID0gRENOXzFfMF9fU1JDSURf
X09URzBfSUhDX1ZfVVBEQVRFX05PX0xPQ0tfSU5URVJSVVBUOw0KPiAtCSAgICAgaSA8PSBEQ05f
MV8wX19TUkNJRF9fT1RHMF9JSENfVl9VUERBVEVfTk9fTE9DS19JTlRFUlJVUFQgKyBhZGV2LT5t
b2RlX2luZm8ubnVtX2NydGMgLSAxOw0KPiAtCSAgICAgaSsrKSB7DQo+IC0JCXIgPSBhbWRncHVf
aXJxX2FkZF9pZChhZGV2LCBTT0MxNV9JSF9DTElFTlRJRF9EQ0UsIGksICZhZGV2LT52dXBkYXRl
X2lycSk7DQo+IC0NCj4gLQkJaWYgKHIpIHsNCj4gLQkJCURSTV9FUlJPUigiRmFpbGVkIHRvIGFk
ZCB2dXBkYXRlIGlycSBpZCFcbiIpOw0KPiAtCQkJcmV0dXJuIHI7DQo+IC0JCX0NCj4gLQ0KPiAt
CQlpbnRfcGFyYW1zLmludF9jb250ZXh0ID0gSU5URVJSVVBUX0hJR0hfSVJRX0NPTlRFWFQ7DQo+
IC0JCWludF9wYXJhbXMuaXJxX3NvdXJjZSA9DQo+IC0JCQlkY19pbnRlcnJ1cHRfdG9faXJxX3Nv
dXJjZShkYywgaSwgMCk7DQo+IC0NCj4gLQkJY19pcnFfcGFyYW1zID0gJmFkZXYtPmRtLnZ1cGRh
dGVfcGFyYW1zW2ludF9wYXJhbXMuaXJxX3NvdXJjZSAtIERDX0lSUV9TT1VSQ0VfVlVQREFURTFd
Ow0KPiAtDQo+IC0JCWNfaXJxX3BhcmFtcy0+YWRldiA9IGFkZXY7DQo+IC0JCWNfaXJxX3BhcmFt
cy0+aXJxX3NyYyA9IGludF9wYXJhbXMuaXJxX3NvdXJjZTsNCj4gLQ0KPiAtCQlhbWRncHVfZG1f
aXJxX3JlZ2lzdGVyX2ludGVycnVwdChhZGV2LCAmaW50X3BhcmFtcywNCj4gLQkJCQlkbV92dXBk
YXRlX2hpZ2hfaXJxLCBjX2lycV9wYXJhbXMpOw0KPiAtCX0NCj4gLQ0KPiAgIAkvKiBVc2UgR1JQ
SF9QRkxJUCBpbnRlcnJ1cHQgKi8NCj4gICAJZm9yIChpID0gRENOXzFfMF9fU1JDSURfX0hVQlAw
X0ZMSVBfSU5URVJSVVBUOw0KPiAgIAkJCWkgPD0gRENOXzFfMF9fU1JDSURfX0hVQlAwX0ZMSVBf
SU5URVJSVVBUICsgYWRldi0+bW9kZV9pbmZvLm51bV9jcnRjIC0gMTsNCj4gQEAgLTQyNDksNiAr
NDIyMSwxMCBAQCBzdGF0aWMgaW5saW5lIGludCBkbV9zZXRfdnVwZGF0ZV9pcnEoc3RydWN0IGRy
bV9jcnRjICpjcnRjLCBib29sIGVuYWJsZSkNCj4gICAJc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFk
ZXYgPSBjcnRjLT5kZXYtPmRldl9wcml2YXRlOw0KPiAgIAlpbnQgcmM7DQo+IA0KPiArCS8qIERv
IG5vdCBzZXQgdnVwZGF0ZSBmb3IgRENOIGhhcmR3YXJlICovDQo+ICsJaWYgKGFkZXYtPmZhbWls
eSA+IEFNREdQVV9GQU1JTFlfQUkpDQo+ICsJCXJldHVybiAwOw0KPiArDQo+ICAgCWlycV9zb3Vy
Y2UgPSBJUlFfVFlQRV9WVVBEQVRFICsgYWNydGMtPm90Z19pbnN0Ow0KPiANCj4gICAJcmMgPSBk
Y19pbnRlcnJ1cHRfc2V0KGFkZXYtPmRtLmRjLCBpcnFfc291cmNlLCBlbmFibGUpID8gMCA6IC1F
QlVTWTsNCj4gLS0NCj4gMi4yMy4wDQo+IA0KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXw0KPiBhbWQtZ2Z4IG1haWxpbmcgbGlzdA0KPiBhbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2FtZC1nZngNCj4gDQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeA==
