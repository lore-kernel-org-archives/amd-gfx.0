Return-Path: <SRS0=Vl9p=Y4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80BA4CA9ED3
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Nov 2019 14:34:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2ADC021D7D
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Nov 2019 14:34:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ADC021D7D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E81FA6E4FB;
	Mon,  4 Nov 2019 14:34:44 +0000 (UTC)
Received: from NAM03-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr790045.outbound.protection.outlook.com [40.107.79.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 765F16E4DE
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Nov 2019 14:34:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LGp30EY++6saLTY85jx4NWAR8aYsz2aA+wCka/iLFN6gW3SafBVRizb1RUll0Ftgx7MdyiFJBJcDmYxIXG0+y8qA7H2kspSkbRI+6E+vrW4TLwcR0O4gQXJ2Vw8DzRGiEjejcY7knO7MiZxk819zz/d9krrMh+Ty86OQglRVDpPn422bTG9Ra85WtavMcEZSz39oNQpMe7BX7vM3o7jIamrd75FzvX6BVOvcQN9scsf5rYhrjzOCcmrOe9d6K0PhAwAvJVOmHJc1phxqXxfDhAB4ewzERrG1r5ngqc0TFq8HYuJoy82i6ZnQOuZrSKEdb1KMGLSEdXG9WK8qNAE95w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d4JuqMUkhuCQcypYV92CO/jYi4V3ZIK81dGYuUr+NhY=;
 b=oMP9hwCuNOnFYbbw8o7dx/vD2n0r0bS5YHgMPQqFPra86y1DHD+T8muR+d5zAl5GsdY9Y0txNiyBYhpLuSZ0xEkP5YDitZDoJywJ3TwbqcIvtTtn+PllQLxT4natPNjybu8lp+AdD9ldAt/v73Zb1hHHdsiqbN5XYoCJ2p5jfI+OjpKDKLRV5XsIArMva0C7hPhaCLBrDWLCuEBQ84D6WFCUJr2UeeCzn9EfZJxTuRBCxw6XZ5lLFfmjWMUzLmCVMUbuQ6mZe7qGJTwWWvSd0z/Ly+RBJ6tBPn4gdOQHUniexRcuH5E4kX+JBNSm/zudydUF6yYlhkCZbWUV9JMamA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from CY4PR1201MB0230.namprd12.prod.outlook.com (10.172.79.7) by
 CY4PR1201MB0245.namprd12.prod.outlook.com (10.172.79.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Mon, 4 Nov 2019 14:34:40 +0000
Received: from CY4PR1201MB0230.namprd12.prod.outlook.com
 ([fe80::449d:52a8:2761:9195]) by CY4PR1201MB0230.namprd12.prod.outlook.com
 ([fe80::449d:52a8:2761:9195%5]) with mapi id 15.20.2408.024; Mon, 4 Nov 2019
 14:34:40 +0000
From: Harry Wentland <hwentlan@amd.com>
To: "Wu, Hersen" <hersenxs.wu@amd.com>, "Liu, Zhan" <Zhan.Liu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Kazlauskas, 
 Nicholas" <Nicholas.Kazlauskas@amd.com>, "Lakha, Bhawanpreet"
 <Bhawanpreet.Lakha@amd.com>, "Li, Roman" <Roman.Li@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Wentland, Harry"
 <Harry.Wentland@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>
Subject: Re: [PATCH] drm/amd/display: Add ENGINE_ID_DIGD condition check for
 Navi14
Thread-Topic: [PATCH] drm/amd/display: Add ENGINE_ID_DIGD condition check for
 Navi14
Thread-Index: AQHVkRtJPzPseCXxv0iiGbLb2otyPad3FY3QgAAAzXCAAAMoEIAD/kAA
Date: Mon, 4 Nov 2019 14:34:40 +0000
Message-ID: <703b8b15-dc0f-630f-b2cd-55bdd3d4337d@amd.com>
References: <DM6PR12MB3466484A8A36F85A0F3C8F289E7D0@DM6PR12MB3466.namprd12.prod.outlook.com>
 <BL0PR12MB2339B22CD38213ABB2CA34B6FD7D0@BL0PR12MB2339.namprd12.prod.outlook.com>
 <DM6PR12MB346604E3AA9D244930BCD8669E7D0@DM6PR12MB3466.namprd12.prod.outlook.com>
 <BL0PR12MB23395743667E0F1089F432F4FD7D0@BL0PR12MB2339.namprd12.prod.outlook.com>
In-Reply-To: <BL0PR12MB23395743667E0F1089F432F4FD7D0@BL0PR12MB2339.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [165.204.55.251]
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
x-clientproxiedby: YTXPR0101CA0053.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::30) To CY4PR1201MB0230.namprd12.prod.outlook.com
 (2603:10b6:910:1e::7)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0d4c087a-6b3c-485f-76dc-08d761342006
x-ms-traffictypediagnostic: CY4PR1201MB0245:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR1201MB02456738CA28622DDE96727B8C7F0@CY4PR1201MB0245.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0211965D06
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(366004)(396003)(346002)(376002)(39860400002)(13464003)(189003)(199004)(6306002)(6246003)(66946007)(2616005)(446003)(11346002)(66066001)(476003)(486006)(66446008)(14454004)(6486002)(58126008)(31696002)(186003)(316002)(110136005)(66476007)(64756008)(66556008)(966005)(52116002)(102836004)(53546011)(386003)(36756003)(2501003)(6116002)(6506007)(3846002)(26005)(54906003)(76176011)(65806001)(5660300002)(31686004)(256004)(65956001)(14444005)(25786009)(99286004)(71200400001)(4326008)(229853002)(478600001)(7736002)(6512007)(6436002)(305945005)(81166006)(2906002)(71190400001)(81156014)(6636002)(8676002)(8936002)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR1201MB0245;
 H:CY4PR1201MB0230.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m3r838ARyF40zjtvN4hDONfAgb4QnPtgZ0UO8vO5Lpg1RDJpGjgJHT/EpZ0RyjFjkgOos4DftTxaMpDWWGIzudzhq819UFM8+AbmoCdvZdXlyZqTWhadeTrIqBVBvgvh84KcZtHEg3fB0xX2ZGW91uYrZ28vycmT3S2FDFTEXfBYvNkbJJOJ33dETn5hFeq/6NYSAysIyoxqYKgr0Kv+A0nF/sGPHT2Sy7goZE9RkeNY2gUwv3y+u/BjSLgRK7NSVwbq7tlMlk14JJHcWenjjlXzHv3JUXtXaDQP2RanBQsUIaPNVT/ErzKPkh7rOFwe4NguCiHPk08i4H4MAAzMfEoScXcarjj6wrYK3a1oqkLfArL/OQAhw7Wh5H6TolsXzvsYzU0WKORdnjIEn/nW7IMftrAohlXICpCIV3EMJFAts60zb48dJKV9gK3+Dmlf+CS40+A2Lhs6JiT6Z06sSS1IOBIt/X7+5ygED0JIcrU=
Content-ID: <A308C894955F1146BB8D13C84D807413@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d4c087a-6b3c-485f-76dc-08d761342006
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2019 14:34:40.4540 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tABMhbyJAfv8z1+1V5hOYxYZRp4ulpzfJAwHAvV9PCp3TIjDCCwIu9lUt5qHcev3lr/8cZBOLCys0TWdji66Tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0245
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d4JuqMUkhuCQcypYV92CO/jYi4V3ZIK81dGYuUr+NhY=;
 b=zLu56d4GTu1Dlejw1izjwymiPYHFSeUqbR0qg30IgXIPtmrb8G9NOWDb6IICyf/TgU03qrPL17uJ/Cm5vjJHE+2TKRPsrUjiWVCwTNoedPwft99lhCCwn2YlIJR1Hjh5qIlXZyenrt89WecCnMK7GxtRGc2gUkB1bevamNCCJg8=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Harry.Wentland@amd.com; 
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
Cc: "Yeh, Eagle" <Eagle.Yeh@amd.com>, "Lazare, Jordan" <Jordan.Lazare@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191104143440.RLXvIzyRDCR13vT3GrQtzjjgiEEpdtCxLPOVgr9hSxQ@z>

T24gMjAxOS0xMS0wMSA5OjM3IHAubS4sIFd1LCBIZXJzZW4gd3JvdGU6DQo+IA0KPiBSZXZpZXdl
ZC1ieTogSGVyc2VuIFd1IDxoZXJzZW54cy53dUBhbWQuY29tPg0KPiANCj4gDQo+IA0KPiAtLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMaXUsIFpoYW4gPFpoYW4uTGl1QGFtZC5j
b20+IA0KPiBTZW50OiBGcmlkYXksIE5vdmVtYmVyIDEsIDIwMTkgOTozNSBQTQ0KPiBUbzogV3Us
IEhlcnNlbiA8aGVyc2VueHMud3VAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnOyBLYXpsYXVza2FzLCBOaWNob2xhcyA8TmljaG9sYXMuS2F6bGF1c2thc0BhbWQuY29tPjsg
TGFraGEsIEJoYXdhbnByZWV0IDxCaGF3YW5wcmVldC5MYWtoYUBhbWQuY29tPjsgTGksIFJvbWFu
IDxSb21hbi5MaUBhbWQuY29tPjsgU2lxdWVpcmEsIFJvZHJpZ28gPFJvZHJpZ28uU2lxdWVpcmFA
YW1kLmNvbT47IFdlbnRsYW5kLCBIYXJyeSA8SGFycnkuV2VudGxhbmRAYW1kLmNvbT47IFp1bywg
SmVycnkgPEplcnJ5Llp1b0BhbWQuY29tPg0KPiBDYzogWWVoLCBFYWdsZSA8RWFnbGUuWWVoQGFt
ZC5jb20+OyBMYXphcmUsIEpvcmRhbiA8Sm9yZGFuLkxhemFyZUBhbWQuY29tPg0KPiBTdWJqZWN0
OiBSRTogW1BBVENIXSBkcm0vYW1kL2Rpc3BsYXk6IEFkZCBFTkdJTkVfSURfRElHRCBjb25kaXRp
b24gY2hlY2sgZm9yIE5hdmkxNA0KPiANCj4gVGhhbmsgeW91IEhlcnNlbi4gUGxlYXNlIGNoZWNr
IHRoZSB1cGRhdGVkIHBhdGNoOg0KPiANCj4gRnJvbTogTGl1LCBaaGFuIDxaaGFuLkxpdUBhbWQu
Y29tPg0KPiBTZW50OiBGcmlkYXksIE5vdmVtYmVyIDEsIDIwMTkgOToxOCBQTQ0KPiBUbzogYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IEthemxhdXNrYXMsIE5pY2hvbGFzIDxOaWNob2xh
cy5LYXpsYXVza2FzQGFtZC5jb20+OyBMYWtoYSwgQmhhd2FucHJlZXQgPEJoYXdhbnByZWV0Lkxh
a2hhQGFtZC5jb20+OyBMaSwgUm9tYW4gPFJvbWFuLkxpQGFtZC5jb20+OyBMaXUsIFpoYW4gPFpo
YW4uTGl1QGFtZC5jb20+OyBTaXF1ZWlyYSwgUm9kcmlnbyA8Um9kcmlnby5TaXF1ZWlyYUBhbWQu
Y29tPjsgV2VudGxhbmQsIEhhcnJ5IDxIYXJyeS5XZW50bGFuZEBhbWQuY29tPjsgV3UsIEhlcnNl
biA8aGVyc2VueHMud3VAYW1kLmNvbT47IFp1bywgSmVycnkgPEplcnJ5Llp1b0BhbWQuY29tPg0K
PiBDYzogWWVoLCBFYWdsZSA8RWFnbGUuWWVoQGFtZC5jb20+OyBMYXphcmUsIEpvcmRhbiA8Sm9y
ZGFuLkxhemFyZUBhbWQuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0hdIGRybS9hbWQvZGlzcGxheTog
QWRkIEVOR0lORV9JRF9ESUdEIGNvbmRpdGlvbiBjaGVjayBmb3IgTmF2aTE0DQo+IA0KPiBGcm9t
OiBaaGFuIGxpdSA8emhhbi5saXVAYW1kLmNvbT4NCj4gRGF0ZTogRnJpLCAxIE5vdiAyMDE5IDIx
OjEwOjE3IC0wNDAwDQo+IFN1YmplY3Q6IFtQQVRDSF0gZHJtL2FtZC9kaXNwbGF5OiBBZGQgRU5H
SU5FX0lEX0RJR0QgY29uZGl0aW9uIGNoZWNrIGZvciBOYXZpMTQNCj4gDQo+IFtXaHldDQo+IE5h
dmkxMCBoYXMgNiBQSFksIGJ1dCBOYXZpMTQgb25seSBoYXMgNSBQSFksIHRoYXQgaXMgYmVjYXVz
ZSB0aGVyZSBpcyBubyBFTkdJTkVfSURfRElHRCBpbiBOYXZpMTQuIFdpdGhvdXQgdGhpcyBwYXRj
aCwgbWFueSBIRE1JIHJlbGF0ZWQgaXNzdWVzIChlLmcuIEhETUkgUzMgcmVzdW1lIGZhaWx1cmUs
IEhETUkgcGluayBzY3JlZW4gb24gYm9vdCkgd2lsbCBiZSBvYnNlcnZlZC4NCg0KQXJlIHdlIHN1
cmUgaXQncyBhbHdheXMgRElHRCB0aGF0J3MgbWlzc2luZyBvbiBOYXZpMTQ/IEl0IGp1c3Qgc2Vl
bXMgb2RkDQp0aGF0IGl0J3Mgbm90IHRoZSBsYXN0IG9uZSBvciB0aGF0IGl0J3Mgbm90IGhhcnZl
c3RlZCAoaS5lLiBwb3RlbnRpYWxseQ0KYmVpbmcgYW55IG9uZSB0aGF0J3MgbWlzc2luZykuDQoN
CkhhcnJ5DQoNCj4gDQo+IFtIb3ddDQo+IElmIGVuZ19pZCBpcyBsYXJnZXIgdGhhbiBFTkdJTkVf
SURfRElHRCwgdGhlbiBhZGQgZW5nX2lkIGJ5IDEuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBaaGFu
IGxpdSA8emhhbi5saXVAYW1kLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rp
c3BsYXkvZGMvZGNuMjAvZGNuMjBfcmVzb3VyY2UuYyB8IDMgKysrDQo+ICAxIGZpbGUgY2hhbmdl
ZCwgNSBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9kaXNwbGF5L2RjL2RjbjIwL2RjbjIwX3Jlc291cmNlLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2Rpc3BsYXkvZGMvZGNuMjAvZGNuMjBfcmVzb3VyY2UuYw0KPiBpbmRleCA5MjRjMmUzMDM1ODgu
LmNmODg2NDgzZTM4MCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5
L2RjL2RjbjIwL2RjbjIwX3Jlc291cmNlLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9k
aXNwbGF5L2RjL2RjbjIwL2RjbjIwX3Jlc291cmNlLmMNCj4gQEAgLTExNTIsNiArMTE1MiwxMSBA
QCBzdHJ1Y3Qgc3RyZWFtX2VuY29kZXIgKmRjbjIwX3N0cmVhbV9lbmNvZGVyX2NyZWF0ZSgNCj4g
ICAgICAgICBpZiAoIWVuYzEpDQo+ICAgICAgICAgICAgICAgICByZXR1cm4gTlVMTDsNCj4gDQo+
ICsJaWYgKEFTSUNfUkVWX0lTX05BVkkxNF9NKGN0eC0+YXNpY19pZC5od19pbnRlcm5hbF9yZXYp
KSB7DQo+ICsJCWlmIChlbmdfaWQgPj0gRU5HSU5FX0lEX0RJR0QpDQo+ICsJCQllbmdfaWQrKzsN
Cj4gKwl9DQo+ICsNCj4gICAgICAgICBkY24yMF9zdHJlYW1fZW5jb2Rlcl9jb25zdHJ1Y3QoZW5j
MSwgY3R4LCBjdHgtPmRjX2Jpb3MsIGVuZ19pZCwNCj4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICZzdHJlYW1fZW5jX3JlZ3NbZW5nX2lkXSwNCj4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICZzZV9zaGlmdCwgJnNlX21hc2spOw0KPiAtLQ0K
PiAyLjIxLjANCj4gDQo+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPj4gRnJvbTogV3Us
IEhlcnNlbiA8aGVyc2VueHMud3VAYW1kLmNvbT4NCj4+IFNlbnQ6IDIwMTkvTm92ZW1iZXIvMDEs
IEZyaWRheSA5OjIzIFBNDQo+PiBUbzogTGl1LCBaaGFuIDxaaGFuLkxpdUBhbWQuY29tPjsgYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IA0KPj4gS2F6bGF1c2thcywgTmljaG9sYXMgPE5p
Y2hvbGFzLkthemxhdXNrYXNAYW1kLmNvbT47IExha2hhLCBCaGF3YW5wcmVldCANCj4+IDxCaGF3
YW5wcmVldC5MYWtoYUBhbWQuY29tPjsgTGksIFJvbWFuIDxSb21hbi5MaUBhbWQuY29tPjsgU2lx
dWVpcmEsIA0KPj4gUm9kcmlnbyA8Um9kcmlnby5TaXF1ZWlyYUBhbWQuY29tPjsgV2VudGxhbmQs
IEhhcnJ5IA0KPj4gPEhhcnJ5LldlbnRsYW5kQGFtZC5jb20+OyBadW8sIEplcnJ5IDxKZXJyeS5a
dW9AYW1kLmNvbT4NCj4+IENjOiBZZWgsIEVhZ2xlIDxFYWdsZS5ZZWhAYW1kLmNvbT47IExhemFy
ZSwgSm9yZGFuIA0KPj4gPEpvcmRhbi5MYXphcmVAYW1kLmNvbT4NCj4+IFN1YmplY3Q6IFJFOiBb
UEFUQ0hdIGRybS9hbWQvZGlzcGxheTogQWRkIEVOR0lORV9JRF9ESUdEIGNvbmRpdGlvbiANCj4+
IGNoZWNrIGZvciBOYXZpMTQNCj4+DQo+PiBIaSBaaGFuLA0KPj4NCj4+IFRoZSBmdW5jdGlvbiBp
cyBzaGFyZWQgYnkgTlYxMCwxMiwxNC4NCj4+DQo+PiBQbGVhc2UgYWRkIEFTSUMgSUQgY2hlY2sg
IGZvciB0aGUgRElHIEQgc2tpcC4NCj4+DQo+PiBUaGFua3MhDQo+PiBIZXJzZW4NCj4+DQo+Pg0K
Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4+IEZyb206IExpdSwgWmhhbiA8Wmhhbi5M
aXVAYW1kLmNvbT4NCj4+IFNlbnQ6IEZyaWRheSwgTm92ZW1iZXIgMSwgMjAxOSA5OjE4IFBNDQo+
PiBUbzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IEthemxhdXNrYXMsIE5pY2hvbGFz
IA0KPj4gPE5pY2hvbGFzLkthemxhdXNrYXNAYW1kLmNvbT47IExha2hhLCBCaGF3YW5wcmVldCAN
Cj4+IDxCaGF3YW5wcmVldC5MYWtoYUBhbWQuY29tPjsgTGksIFJvbWFuIDxSb21hbi5MaUBhbWQu
Y29tPjsgTGl1LCBaaGFuIA0KPj4gPFpoYW4uTGl1QGFtZC5jb20+OyBTaXF1ZWlyYSwgUm9kcmln
byA8Um9kcmlnby5TaXF1ZWlyYUBhbWQuY29tPjsgDQo+PiBXZW50bGFuZCwgSGFycnkgPEhhcnJ5
LldlbnRsYW5kQGFtZC5jb20+OyBXdSwgSGVyc2VuIA0KPj4gPGhlcnNlbnhzLnd1QGFtZC5jb20+
OyBadW8sIEplcnJ5IDxKZXJyeS5adW9AYW1kLmNvbT4NCj4+IENjOiBZZWgsIEVhZ2xlIDxFYWds
ZS5ZZWhAYW1kLmNvbT47IExhemFyZSwgSm9yZGFuIA0KPj4gPEpvcmRhbi5MYXphcmVAYW1kLmNv
bT4NCj4+IFN1YmplY3Q6IFtQQVRDSF0gZHJtL2FtZC9kaXNwbGF5OiBBZGQgRU5HSU5FX0lEX0RJ
R0QgY29uZGl0aW9uIGNoZWNrIA0KPj4gZm9yIE5hdmkxNA0KPj4NCj4+IEZyb206IFpoYW4gbGl1
IDx6aGFuLmxpdUBhbWQuY29tPg0KPj4gRGF0ZTogRnJpLCAxIE5vdiAyMDE5IDIxOjEwOjE3IC0w
NDAwDQo+PiBTdWJqZWN0OiBbUEFUQ0hdIGRybS9hbWQvZGlzcGxheTogQWRkIEVOR0lORV9JRF9E
SUdEIGNvbmRpdGlvbiBjaGVjayANCj4+IGZvciBOYXZpMTQNCj4+DQo+PiBbV2h5XQ0KPj4gTmF2
aTEwIGhhcyA2IFBIWSwgYnV0IE5hdmkxNCBvbmx5IGhhcyA1IFBIWSwgdGhhdCBpcyBiZWNhdXNl
IHRoZXJlIGlzIA0KPj4gbm8gRU5HSU5FX0lEX0RJR0QgaW4gTmF2aTE0LiBXaXRob3V0IHRoaXMg
cGF0Y2gsIG1hbnkgSERNSSByZWxhdGVkIA0KPj4gaXNzdWVzIChlLmcuIEhETUkgUzMgcmVzdW1l
IGZhaWx1cmUsIEhETUkgcGluayBzY3JlZW4gb24gYm9vdCkgd2lsbCBiZSBvYnNlcnZlZC4NCj4+
DQo+PiBbSG93XQ0KPj4gSWYgZW5nX2lkIGlzIGxhcmdlciB0aGFuIEVOR0lORV9JRF9ESUdELCB0
aGVuIGFkZCBlbmdfaWQgYnkgMS4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBaaGFuIGxpdSA8emhh
bi5saXVAYW1kLmNvbT4NCj4+IC0tLQ0KPj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9k
Yy9kY24yMC9kY24yMF9yZXNvdXJjZS5jIHwgMyArKysNCj4+ICAxIGZpbGUgY2hhbmdlZCwgMyBp
bnNlcnRpb25zKCspDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlz
cGxheS9kYy9kY24yMC9kY24yMF9yZXNvdXJjZS5jDQo+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
ZGlzcGxheS9kYy9kY24yMC9kY24yMF9yZXNvdXJjZS5jDQo+PiBpbmRleCA5MjRjMmUzMDM1ODgu
LmNmODg2NDgzZTM4MCAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxh
eS9kYy9kY24yMC9kY24yMF9yZXNvdXJjZS5jDQo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2Rpc3BsYXkvZGMvZGNuMjAvZGNuMjBfcmVzb3VyY2UuYw0KPj4gQEAgLTExNTIsNiArMTE1Miw5
IEBAIHN0cnVjdCBzdHJlYW1fZW5jb2RlciANCj4+ICpkY24yMF9zdHJlYW1fZW5jb2Rlcl9jcmVh
dGUoDQo+PiAgICAgICAgIGlmICghZW5jMSkNCj4+ICAgICAgICAgICAgICAgICByZXR1cm4gTlVM
TDsNCj4+DQo+PiArICAgICAgIGlmIChlbmdfaWQgPj0gRU5HSU5FX0lEX0RJR0QpDQo+PiArICAg
ICAgICAgICAgICAgZW5nX2lkKys7DQo+PiArDQo+PiAgICAgICAgIGRjbjIwX3N0cmVhbV9lbmNv
ZGVyX2NvbnN0cnVjdChlbmMxLCBjdHgsIGN0eC0+ZGNfYmlvcywgZW5nX2lkLA0KPj4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZzdHJlYW1fZW5jX3JlZ3NbZW5nX2lk
XSwNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmc2Vfc2hpZnQs
ICZzZV9tYXNrKTsNCj4+IC0tDQo+PiAyLjIxLjANCj4+DQo+PiBfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KPj4NCj4+IGFtZC1nZnggbWFpbGluZyBsaXN0
DQo+Pg0KPj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4+DQo+PiBodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngNCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0
CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
