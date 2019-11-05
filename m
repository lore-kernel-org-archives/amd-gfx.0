Return-Path: <SRS0=U5eA=Y5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8637BC5DF60
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2019 16:15:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AE4E214B2
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2019 16:15:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AE4E214B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 074AB6EAD8;
	Tue,  5 Nov 2019 16:15:07 +0000 (UTC)
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr800041.outbound.protection.outlook.com [40.107.80.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B297C6EAD8
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Nov 2019 16:15:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NzxzIerHITx4Ye2jyCNj4yvYKWWDxvNAU8PZd/3XEGvM9mv6n6bZqFiQSdnp5vYofMBnMsuTFv3QO17iJNegSTWCi1gzIU4qkBl/285urG0W7bVYHZIIcg0P3v8IYjwClSJmzZaq2W7uFhMdQXYV9ICd/nsG7ie9uCaY8EQDvo2GzFMojX5eo/4F+78EYlkkNxHuqHawDdSv7Gg5sI2BsJ/j/SvJgk1rVbTTWVA5EBVgzyCMURKv88ECpwQMyUgeiqU/GO5CFFUVy3DQZ5Vm4x2a8LdjzQbn2z82h/+UV6UJgPlctxEnlGCxuX7DQiTCybiZnrRwZobijuK96HR6uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AGeAURLgwYzUp5uZhb5ii1sJrMNp1NXKbi/7qE+tgo4=;
 b=jojtV2uRhJFi52KHy1P5HacIpt2ooMt6zyzIiYQ4Inm47ujkaebezSPg1UUXxjXeDOaIc5UtTqPTusKtypHdghlhW05ASnDGVpSRmFulq9ORI8orxB1z1unOm/pohbTjfUf38XDok+BdpOpdyh6XB6uvb0d2mReYcuHrIMw8LbCW1K/zuf1pMbBCVAavLCxXbN+iPPkuNQGtMO0+R2zWWNg8VZwsUmqVB/MzfB6WvzrEMFWkWZqBdh3aLta4qcHaiJT1q55kxTos0/fDpPGkQcx7OFO25VAjQk/oouGBB36e2rN3oegePyh3z+IdSR+74lYt+BTkPFz+1VJ1/i/GOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BYAPR12MB3560.namprd12.prod.outlook.com (20.178.197.10) by
 BYAPR12MB3206.namprd12.prod.outlook.com (20.179.91.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Tue, 5 Nov 2019 16:15:02 +0000
Received: from BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::f950:f7be:9139:7c26]) by BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::f950:f7be:9139:7c26%7]) with mapi id 15.20.2408.024; Tue, 5 Nov 2019
 16:15:02 +0000
From: "Kazlauskas, Nicholas" <Nicholas.Kazlauskas@amd.com>
To: "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 1/2] drm/amd/display: Send vblank and user events at
 vsartup for DCN
Thread-Topic: [PATCH 1/2] drm/amd/display: Send vblank and user events at
 vsartup for DCN
Thread-Index: AQHVk+6ktQvcBIKgakaDyM9X6Te8YKd8wHgA
Date: Tue, 5 Nov 2019 16:15:02 +0000
Message-ID: <c93c503d-48dc-1ea5-19f7-42ff9392e162@amd.com>
References: <20191105153416.32049-1-sunpeng.li@amd.com>
In-Reply-To: <20191105153416.32049-1-sunpeng.li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YTOPR0101CA0015.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::28) To BYAPR12MB3560.namprd12.prod.outlook.com
 (2603:10b6:a03:ae::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.55.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ce278728-b656-4c0f-a9ee-08d7620b4ff6
x-ms-traffictypediagnostic: BYAPR12MB3206:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB3206A3E324109BC4154C1746EC7E0@BYAPR12MB3206.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0212BDE3BE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(136003)(396003)(366004)(39860400002)(346002)(189003)(199004)(66066001)(66946007)(86362001)(4326008)(6246003)(6512007)(2501003)(14444005)(31696002)(81156014)(14454004)(2906002)(256004)(81166006)(6116002)(3846002)(71200400001)(25786009)(2616005)(486006)(36756003)(71190400001)(6486002)(11346002)(99286004)(31686004)(446003)(110136005)(8936002)(316002)(229853002)(478600001)(8676002)(5660300002)(54906003)(53546011)(386003)(26005)(66476007)(66556008)(64756008)(6506007)(66446008)(186003)(102836004)(76176011)(52116002)(476003)(7736002)(305945005)(6436002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3206;
 H:BYAPR12MB3560.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xyQgiJu/ZbirCuP8dSJqnEihFKaIM52i6YDwNVA20V4CoE5rgbnAnEZE1Ljjn1QlsSg/e3t1NdQ3BWeKNfqibPAePrUavAJmwmZ3polOU0dNv9WztxobeodNsjBP8BsM5Ma3U587ljCM2KDtg8OiUCZe+lfMnNZ34aKfV8rny7gBjcb8ydZgsvoRtm48ySU7UR/fY+iCskL3A2F8r+7CCfVs0XUBB7nAZFWrXOTnURvd3XZeQoMfSWotXNSZrNmZRrb1BW3Y3HsDyi6q34H1QpfPVfcXQeyUqfbj4NHbSN9OKNOI1L10Iv5iZ4bBJ496hOx3FlVFLMxXR36ZHMAX1wdmu4Mzx2NhcxWueZCKjPFwnTj1WQ7MUJ8J4EbZ/cPXcCCQwcbfDw3sY8dZi/dZA4NaF34Y1f6SK8j34B2b+iOg6ka2pfsAQFsXLrJV2WsE
Content-ID: <08F2EFC325C5EB4F99BF24F7F3A7F2E6@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce278728-b656-4c0f-a9ee-08d7620b4ff6
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2019 16:15:02.3951 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 96StRFrgKQNYGkrAGlHe+eE+KdExb8q6Bg0BGDBJ7ILfOe663EVta+nQKmUE6b28OpJuxHHpineQge5eh6ciQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3206
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AGeAURLgwYzUp5uZhb5ii1sJrMNp1NXKbi/7qE+tgo4=;
 b=Ylb2tddL8CCBbRmezoSHUZ0JmQSxPY+eCWLi5WAVfH2WA+aiYg1jkjzO+M2jNu/cK5ycIY5bdyErfhSMGDHuNQb+I2MMpcK5GfUUkp56g/5x6Ln+b6Q4k2sDd7ocIhLgoTr4Hp/Cx6co/WLARbxyd4p8LMqvxfEvi75LTh1/gvI=
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
Message-ID: <20191105161502.bYQfvabvRDXKmu0IdCZ1AMoP6863RUNd3b5Jsqn0bcU@z>

T24gMjAxOS0xMS0wNSAxMDozNCBhLm0uLCBzdW5wZW5nLmxpQGFtZC5jb20gd3JvdGU6DQo+IEZy
b206IExlbyBMaSA8c3VucGVuZy5saUBhbWQuY29tPg0KPiANCj4gW1doeV0NCj4gDQo+IEZvciBE
Q04gaGFyZHdhcmUsIHRoZSBjcnRjX2hpZ2hfaXJxIGhhbmRsZXIgaXMgYXNzaWduZWQgdG8gdGhl
IHZzdGFydHVwDQo+IGludGVycnVwdC4gVGhpcyBpcyBkaWZmZXJlbnQgZnJvbSBEQ0UsIHdoaWNo
IGhhcyBpdCBhc3NpZ25lZCB0byB2YmxhbmsNCj4gc3RhcnQuDQo+IA0KPiBXZSdkIGxpa2UgdG8g
c2VuZCB2YmxhbmsgYW5kIHVzZXIgZXZlbnRzIGF0IHZzdGFydHVwIGJlY2F1c2U6DQo+IA0KPiAq
IEl0IGhhcHBlbnMgY2xvc2UgZW5vdWdoIHRvIHZ1cGRhdGUgLSB0aGUgcG9pbnQgb2Ygbm8gcmV0
dXJuIGZvciBIVy4NCj4gDQo+ICogSXQgaXMgcHJvZ3JhbW1lZCBhcyBsaW5lcyByZWxhdGl2ZSB0
byB2YmxhbmsgZW5kIC0gaS5lLiBpdCBpcyBub3QgaW4NCj4gICAgdGhlIHZhcmlhYmxlIHBvcnRp
b24gd2hlbiBWUlIgaXMgZW5hYmxlZC4gV2Ugc2hvdWxkIHNpZ25hbCB1c2VyDQo+ICAgIGV2ZW50
cyBoZXJlLg0KPiANCj4gKiBUaGUgcGZsaXAgaW50ZXJydXB0IHJlc3BvbnNpYmxlIGZvciBzZW5k
aW5nIHVzZXIgZXZlbnRzIHRvZGF5IG9ubHkNCj4gICAgZmlyZXMgaWYgdGhlIERDSCBIVUJQIGNv
bXBvbmVudCBpcyBub3QgY2xvY2sgZ2F0ZWQuIEluIHNpdHVhdGlvbnMNCj4gICAgd2hlcmUgcGxh
bmVzIGFyZSBkaXNhYmxlZCAtIGJ1dCB0aGUgQ1JUQyBpcyBlbmFibGVkIC0gdXNlciBldmVudHMg
d29uJ3QNCj4gICAgYmUgc2VudCBvdXQsIGxlYWRpbmcgdG8gZmxpcCBkb25lIHRpbWVvdXRzLg0K
PiANCj4gQ29uc2VxdWVudGx5LCB0aGlzIG1ha2VzIHZ1cGRhdGUgb24gRENOIGhhcmR3YXJlIHJl
ZHVuZGFudC4gSXQgd2lsbCBiZQ0KPiByZW1vdmVkIGluIHRoZSBuZXh0IGNoYW5nZS4NCj4gDQo+
IFtIb3ddDQo+IA0KPiBBZGQgYSBEQ04tc3BlY2lmaWMgY3J0Y19oaWdoX2lycSBoYW5kbGVyLCBh
bmQgaG9vayBpdCB0byB0aGUgVlN0YXJ0dXANCj4gc2lnbmFsLiBJbnNpZGUgdGhlIERDTiBoYW5k
bGVyLCB3ZSBzZW5kIG9mZiB1c2VyIGV2ZW50cyBpZiB0aGUgcGZsaXANCj4gaGFuZGxlciBoYXNu
J3QgYWxyZWFkeSBkb25lIHNvLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTGVvIExpIDxzdW5wZW5n
LmxpQGFtZC5jb20+DQo+IC0tLQ0KPiAgIC4uLi9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9k
bS9hbWRncHVfZG0uYyB8IDY1ICsrKysrKysrKysrKysrKysrKy0NCj4gICAxIGZpbGUgY2hhbmdl
ZCwgNjQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jDQo+IGluZGV4IDAwMDE3
YjkxYzkxYS4uMjU2YTIzYTBlYzI4IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMNCj4gQEAgLTQ4NSw2ICs0ODUsNjkgQEAg
c3RhdGljIHZvaWQgZG1fY3J0Y19oaWdoX2lycSh2b2lkICppbnRlcnJ1cHRfcGFyYW1zKQ0KPiAg
IAl9DQo+ICAgfQ0KPiANCj4gKw0KPiArLyoqDQo+ICsgKiBkbV9kY25fY3J0Y19oaWdoX2lycSgp
IC0gSGFuZGxlcyBWU3RhcnR1cCBpbnRlcnJ1cHQgZm9yIERDTiBnZW5lcmF0aW9uIEFTSUNzDQo+
ICsgKiBAaW50ZXJydXB0IHBhcmFtcyAtIGludGVycnVwdCBwYXJhbWV0ZXJzDQo+ICsgKg0KPiAr
ICogTm90aWZ5IERSTSdzIHZibGFuayBldmVudCBoYW5kbGVyIGF0IFZTVEFSVFVQDQo+ICsgKg0K
PiArICogVW5saWtlIERDRSBoYXJkd2FyZSwgd2UgdHJpZ2dlciB0aGUgaGFuZGxlciBhdCBWU1RB
UlRVUC4gYXQgd2hpY2g6DQo+ICsgKiAqIFdlIGFyZSBjbG9zZSBlbm91Z2ggdG8gVlVQREFURSAt
IHRoZSBwb2ludCBvZiBubyByZXR1cm4gZm9yIGh3DQo+ICsgKiAqIFdlIGFyZSBpbiB0aGUgZml4
ZWQgcG9ydGlvbiBvZiB2YXJpYWJsZSBmcm9udCBwb3JjaCB3aGVuIHZyciBpcyBlbmFibGVkDQo+
ICsgKiAqIFdlIGFyZSBiZWZvcmUgVlVQREFURSwgd2hlcmUgZG91YmxlLWJ1ZmZlcmVkIHZyciBy
ZWdpc3RlcnMgYXJlIHN3YXBwZWQNCj4gKyAqDQo+ICsgKiBJdCBpcyB0aGVyZWZvcmUgdGhlIGNv
cnJlY3QgcGxhY2UgdG8gc2lnbmFsIHZibGFuaywgc2VuZCB1c2VyIGZsaXAgZXZlbnRzLA0KPiAr
ICogYW5kIHVwZGF0ZSBWUlIuDQo+ICsgKi8NCj4gK3N0YXRpYyB2b2lkIGRtX2Rjbl9jcnRjX2hp
Z2hfaXJxKHZvaWQgKmludGVycnVwdF9wYXJhbXMpDQo+ICt7DQo+ICsJc3RydWN0IGNvbW1vbl9p
cnFfcGFyYW1zICppcnFfcGFyYW1zID0gaW50ZXJydXB0X3BhcmFtczsNCj4gKwlzdHJ1Y3QgYW1k
Z3B1X2RldmljZSAqYWRldiA9IGlycV9wYXJhbXMtPmFkZXY7DQo+ICsJc3RydWN0IGFtZGdwdV9j
cnRjICphY3J0YzsNCj4gKwlzdHJ1Y3QgZG1fY3J0Y19zdGF0ZSAqYWNydGNfc3RhdGU7DQo+ICsJ
dW5zaWduZWQgbG9uZyBmbGFnczsNCj4gKw0KPiArCWFjcnRjID0gZ2V0X2NydGNfYnlfb3RnX2lu
c3QoYWRldiwgaXJxX3BhcmFtcy0+aXJxX3NyYyAtIElSUV9UWVBFX1ZCTEFOSyk7DQo+ICsNCj4g
KwlpZiAoIWFjcnRjKQ0KPiArCQlyZXR1cm47DQo+ICsNCj4gKwlhY3J0Y19zdGF0ZSA9IHRvX2Rt
X2NydGNfc3RhdGUoYWNydGMtPmJhc2Uuc3RhdGUpOw0KPiArDQo+ICsJRFJNX0RFQlVHX0RSSVZF
UigiY3J0YzolZCwgdnVwZGF0ZS12cnI6JWRcbiIsIGFjcnRjLT5jcnRjX2lkLA0KPiArCQkJCWFt
ZGdwdV9kbV92cnJfYWN0aXZlKGFjcnRjX3N0YXRlKSk7DQo+ICsNCj4gKwlhbWRncHVfZG1fY3J0
Y19oYW5kbGVfY3JjX2lycSgmYWNydGMtPmJhc2UpOw0KPiArCWRybV9jcnRjX2hhbmRsZV92Ymxh
bmsoJmFjcnRjLT5iYXNlKTsNCg0KU2hvdWxkbid0IHRoaXMgYmUgdGhlIG90aGVyIHdheSBhcm91
bmQ/IERvbid0IHdlIHdhbnQgdGhlIENSQyBzZW50IGJhY2sgDQp0byB1c2Vyc3BhY2UgdG8gaGF2
ZSB0aGUgdXBkYXRlZCB2YmxhbmsgY291bnRlcj8NCg0KVGhpcyBpcyBob3cgaXQgd29ya2VkIGJl
Zm9yZSBhdCBsZWFzdC4NCg0KT3RoZXIgdGhhbiB0aGF0LCB0aGlzIHBhdGNoIGxvb2tzIGZpbmUg
dG8gbWUuDQoNCk5pY2hvbGFzIEthemxhdXNrYXMNCg0KPiArDQo+ICsJc3Bpbl9sb2NrX2lycXNh
dmUoJmFkZXYtPmRkZXYtPmV2ZW50X2xvY2ssIGZsYWdzKTsNCj4gKw0KPiArCWlmIChhY3J0Y19z
dGF0ZS0+dnJyX3BhcmFtcy5zdXBwb3J0ZWQgJiYNCj4gKwkgICAgYWNydGNfc3RhdGUtPmZyZWVz
eW5jX2NvbmZpZy5zdGF0ZSA9PSBWUlJfU1RBVEVfQUNUSVZFX1ZBUklBQkxFKSB7DQo+ICsJCW1v
ZF9mcmVlc3luY19oYW5kbGVfdl91cGRhdGUoDQo+ICsJCWFkZXYtPmRtLmZyZWVzeW5jX21vZHVs
ZSwNCj4gKwkJYWNydGNfc3RhdGUtPnN0cmVhbSwNCj4gKwkJJmFjcnRjX3N0YXRlLT52cnJfcGFy
YW1zKTsNCj4gKw0KPiArCQlkY19zdHJlYW1fYWRqdXN0X3ZtaW5fdm1heCgNCj4gKwkJCWFkZXYt
PmRtLmRjLA0KPiArCQkJYWNydGNfc3RhdGUtPnN0cmVhbSwNCj4gKwkJCSZhY3J0Y19zdGF0ZS0+
dnJyX3BhcmFtcy5hZGp1c3QpOw0KPiArCX0NCj4gKw0KPiArCWlmIChhY3J0Yy0+cGZsaXBfc3Rh
dHVzID09IEFNREdQVV9GTElQX1NVQk1JVFRFRCkgew0KPiArCQlpZiAoYWNydGMtPmV2ZW50KSB7
DQo+ICsJCQlkcm1fY3J0Y19zZW5kX3ZibGFua19ldmVudCgmYWNydGMtPmJhc2UsIGFjcnRjLT5l
dmVudCk7DQo+ICsJCQlhY3J0Yy0+ZXZlbnQgPSBOVUxMOw0KPiArCQkJZHJtX2NydGNfdmJsYW5r
X3B1dCgmYWNydGMtPmJhc2UpOw0KPiArCQl9DQo+ICsJCWFjcnRjLT5wZmxpcF9zdGF0dXMgPSBB
TURHUFVfRkxJUF9OT05FOw0KPiArCX0NCj4gKw0KPiArCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUo
JmFkZXYtPmRkZXYtPmV2ZW50X2xvY2ssIGZsYWdzKTsNCj4gK30NCj4gKw0KPiAgIHN0YXRpYyBp
bnQgZG1fc2V0X2Nsb2NrZ2F0aW5nX3N0YXRlKHZvaWQgKmhhbmRsZSwNCj4gICAJCSAgZW51bSBh
bWRfY2xvY2tnYXRpbmdfc3RhdGUgc3RhdGUpDQo+ICAgew0KPiBAQCAtMjE3NSw3ICsyMjM4LDcg
QEAgc3RhdGljIGludCBkY24xMF9yZWdpc3Rlcl9pcnFfaGFuZGxlcnMoc3RydWN0IGFtZGdwdV9k
ZXZpY2UgKmFkZXYpDQo+ICAgCQljX2lycV9wYXJhbXMtPmlycV9zcmMgPSBpbnRfcGFyYW1zLmly
cV9zb3VyY2U7DQo+IA0KPiAgIAkJYW1kZ3B1X2RtX2lycV9yZWdpc3Rlcl9pbnRlcnJ1cHQoYWRl
diwgJmludF9wYXJhbXMsDQo+IC0JCQkJZG1fY3J0Y19oaWdoX2lycSwgY19pcnFfcGFyYW1zKTsN
Cj4gKwkJCQlkbV9kY25fY3J0Y19oaWdoX2lycSwgY19pcnFfcGFyYW1zKTsNCj4gICAJfQ0KPiAN
Cj4gICAJLyogVXNlIFZVUERBVEVfTk9fTE9DSyBpbnRlcnJ1cHQgb24gRENOLCB3aGljaCBzZWVt
cyB0byBjb3JyZXNwb25kIHRvDQo+IC0tDQo+IDIuMjMuMA0KPiANCg0KX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
