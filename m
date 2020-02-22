Return-Path: <SRS0=juic=4K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A5AC35669
	for <amd-gfx@archiver.kernel.org>; Sat, 22 Feb 2020 02:19:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EC6D206E2
	for <amd-gfx@archiver.kernel.org>; Sat, 22 Feb 2020 02:19:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="3aBJqEWa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EC6D206E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB1236E3DB;
	Sat, 22 Feb 2020 02:19:27 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700048.outbound.protection.outlook.com [40.107.70.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29F696E3DB
 for <amd-gfx@lists.freedesktop.org>; Sat, 22 Feb 2020 02:19:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fjjPClhv329njUHzV3ldg05ALckfQ7gdMJ+Z3B3DZA7EunBoaH8vFHDWioJAfw9/ehJmr0PbNtnFVBIHo5Wfm3SPBKNYuOdpO/tqj1vM0UAWWcKkbenQc0/ruy3c8jhcS9CA89Uvs14rJZkqgs2KQVjeJxhcfIMTqy8M6KJy2oSER1yjx6uO6tr3LcSM0UJjlQbX18yfZNTQmJkHsOKTqmkYuayvQLaOctgVxldQy5rimO0pgLq4Wx6P6TyPdo5KHJn0wTsxyFEAR0HY2fxQ2G6BB+o6/Cxj80KWqPfJV1+2ZnDr03ZnSlw6jtaAIB4phE/jfX8XnHFXzQHq/J/F4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JjHIpm91HvawQLF52t4/HbzSv7RTAq6K/FwoJwnhpt4=;
 b=b1dAVbokOkugdoJpyzmc/LloFVjU7qHoDNf+Lcd7iQErrSxXueyyFtjIXeVZLej3QNA0vi+Gnf27QmxjqPR3Jg2zSWzDaDQm7uikF647Atzz1Q9IBYfk1TEN/wQ24vSI74nT/gDkareAq8wAqBfiZReVMOcsNO0HpAogJzH7rUUY38W/CcMAR0NfFDWoJZzT60KH6Of0hGQ+YZPFX5UPZrt9tJxI+Zk2h16DSmGVIrtSS6Wn8PZymWOMzu/B6mfb87Izv42xIlhxBrqdHpQSjNbKkfYO6qqq8FO1upa82myKI4pLG10cw9TrFD8fLpcDRJ6A1rgy8Z2LOq/bnjVliA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JjHIpm91HvawQLF52t4/HbzSv7RTAq6K/FwoJwnhpt4=;
 b=3aBJqEWaEXOJzp0LqaBsY1p72JvwDczIKcuHZPxyk0rYK4La8YGYc5u2n189/wRkCcnHaS616z9ZBoUlqX23utlmj8sPmkzdU1LLaM5XTey90kFP9T5bUq6xPx3/hzyjBkFcPgk2eYn+EOgyu54MXiFd7rIV1QED4RStYye4hP0=
Received: from MN2PR12MB3933.namprd12.prod.outlook.com (2603:10b6:208:162::18)
 by MN2PR12MB4335.namprd12.prod.outlook.com (2603:10b6:208:1d4::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Sat, 22 Feb
 2020 02:19:21 +0000
Received: from MN2PR12MB3933.namprd12.prod.outlook.com
 ([fe80::4905:91cf:ae95:6ffb]) by MN2PR12MB3933.namprd12.prod.outlook.com
 ([fe80::4905:91cf:ae95:6ffb%7]) with mapi id 15.20.2750.021; Sat, 22 Feb 2020
 02:19:21 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "Huang, Ray" <Ray.Huang@amd.com>
Subject: =?utf-8?B?5Zue5aSNOiDlm57lpI06IFtQQVRDSF0gZHJtL2FtZC9hbWRncHU6IGRpc2Fi?=
 =?utf-8?Q?le_GFXOFF_around_debugfs_access_to_MMIO?=
Thread-Topic: =?utf-8?B?5Zue5aSNOiBbUEFUQ0hdIGRybS9hbWQvYW1kZ3B1OiBkaXNhYmxlIEdGWE9G?=
 =?utf-8?Q?F_around_debugfs_access_to_MMIO?=
Thread-Index: AQHV5zXmRTs/SpgQjE+XyOIGewaz5aginj+AgAAAkwCAAxqrAIAADCjAgAABowCAALcTYA==
Date: Sat, 22 Feb 2020 02:19:21 +0000
Message-ID: <MN2PR12MB39335FF5D354659296CB6EA784EE0@MN2PR12MB3933.namprd12.prod.outlook.com>
References: <20200219150417.510884-1-tom.stdenis@amd.com>
 <CADnq5_PaR2a4UCwQFF6y1A1MCqaDAbPbFJZSzdBcTMkRnREw5g@mail.gmail.com>
 <6f93ee3f-4fba-575a-f8eb-0441b0efd4c8@amd.com>
 <20200221143359.GF28698@jenkins-Celadon-RN>
 <DM6PR12MB393101FB6C3250020720509A84120@DM6PR12MB3931.namprd12.prod.outlook.com>
 <20200221152321.GH28698@jenkins-Celadon-RN>
In-Reply-To: <20200221152321.GH28698@jenkins-Celadon-RN>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Monk.Liu@amd.com; 
x-originating-ip: [180.167.199.185]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ec0be179-237d-4d76-8074-08d7b73da0f4
x-ms-traffictypediagnostic: MN2PR12MB4335:|MN2PR12MB4335:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB43358DBC5F2F10C77A46130C84EE0@MN2PR12MB4335.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2043;
x-forefront-prvs: 03218BFD9F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10001)(10009020)(4636009)(396003)(376002)(39860400002)(136003)(366004)(346002)(199004)(189003)(6636002)(76116006)(45080400002)(33656002)(81156014)(478600001)(966005)(52536014)(7696005)(8936002)(54906003)(4326008)(9686003)(186003)(316002)(26005)(71200400001)(55016002)(6862004)(66946007)(86362001)(64756008)(66476007)(66556008)(224303003)(5660300002)(81166006)(66446008)(53546011)(2906002)(6506007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4335;
 H:MN2PR12MB3933.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +ufI9pWdyFE40qsVXCFEyis97+/4B7loTCIJq4hsrcf34we3xaddiU4CPJ7jO0EE6Jm1sX4MgsHouYoJTHgA66Ye3JcmzcXLzzt+Hz3C7lfplkXehAPo/vTVL/iIQHgpy6lK6/cRNmJ5MRCTUzpvYPcQRpk33Qas8+jT+fgcGFh7A9swT3VCa2+VTcrZxWzajDFwi2NefLtjHdaWFTJquPD3gYHcUn089fi5SZRu1Aq7rUcYAfhzej9D6jiKGW1yM4n+3xThV038ry2qnxaL9VA0hGdD6R+LJgz3d9L7ltxYpR3RjnCrzHedIpvWZMoCl5yEcD5oN1e4o1MG0fq4WRsY43I91u8V6Qmns80f6nXsQe6rAxdFfBSntSRIIOgdrTy5/pqb2G7lZaylj6v9kC153AICIyJDLXzYdCnhOKXN6BA5Bv7+leI/7FJj6xC/0qOFKfdjhXVSha/rfBT1CyrkZwUfsfuKK6sHVNJryxG9bAfMEAFqKdZfmoNapLCv+786Pl8pNBMNKl9tb0xPuNJmw7PCr9Ps8t3mPonm1fmwEPiLCsJqIJOnsg5d6nQKNzQv891eZYdtkb0IgL54qy3w9DrTM8184ZZ9nusXkeBNX7mfPl2L6jj/zSD7O7BR
x-ms-exchange-antispam-messagedata: cafBdoFoSzOORiBjHpv42jgQalVBrpERB4cXquOa/iH71UC12zYKDMTdAjFJtURlZKR+Jxk27Gvs3yMxnpFm/Ld1cRf0G0s2gNk5ywGwHFMyR05JmCGFK9ZWnk29u87HbOQxDp0TcFZHU4fRJ2gIHg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec0be179-237d-4d76-8074-08d7b73da0f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2020 02:19:21.6561 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bto8N8MkZsUDbs/+NQ5vyn/i6rTJkAeqcN7zc6j39oPTzNCB0OIY83EmZT5zCsqh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4335
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: "StDenis, Tom" <Tom.StDenis@amd.com>, Alex Deucher <alexdeucher@gmail.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Pj4+UlJFRzMyX0tJUSBhbmQgV1JFRzMyX0tJUQ0KDQpJZiB5b3UgYXJlIHVzaW5nIFJSRUczMl9L
SVEgaXQgaXMgYWx3YXlzIGdvIHRocm91Z2ggS0lRIG5vIG1hdHRlciBHRlggaXMgIm9uIiBzdGF0
ZSBvciBub3QgDQoNCg0KDQotLS0tLemCruS7tuWOn+S7ti0tLS0tDQrlj5Hku7bkuro6IEh1YW5n
LCBSYXkgPFJheS5IdWFuZ0BhbWQuY29tPiANCuWPkemAgeaXtumXtDogMjAyMOW5tDLmnIgyMeaX
pSAyMzoyMw0K5pS25Lu25Lq6OiBMaXUsIE1vbmsgPE1vbmsuTGl1QGFtZC5jb20+DQrmioTpgIE6
IFN0RGVuaXMsIFRvbSA8VG9tLlN0RGVuaXNAYW1kLmNvbT47IEFsZXggRGV1Y2hlciA8YWxleGRl
dWNoZXJAZ21haWwuY29tPjsgYW1kLWdmeCBsaXN0IDxhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZz4NCuS4u+mimDogUmU6IOWbnuWkjTogW1BBVENIXSBkcm0vYW1kL2FtZGdwdTogZGlzYWJs
ZSBHRlhPRkYgYXJvdW5kIGRlYnVnZnMgYWNjZXNzIHRvIE1NSU8NCg0KT24gRnJpLCBGZWIgMjEs
IDIwMjAgYXQgMTE6MTg6MDdQTSArMDgwMCwgTGl1LCBNb25rIHdyb3RlOg0KPiBCZXR0ZXIgbm90
IHVzZSBLSVEsIGJlY2F1c2Ugd2hlbiB5b3UgdXNlIGRlYnVnZnMgdG8gcmVhZCByZWdpc3RlciB5
b3UgDQo+IHVzdWFsbHkgaGl0IGEgaGFuZywgYW5kIGJ5IHRoYXQgY2FzZSBLSVEgcHJvYmFibHkg
YWxyZWFkeSBkaWUNCg0KSWYgQ1AgaXMgYnVzeSwgdGhlIGdmeCBzaG91bGQgYmUgaW4gIm9uIiBz
dGF0ZSBhdCB0aGF0IHRpbWUsIHdlIG5lZWRuJ3QgdXNlIEtJUS4NCg0KVGhhbmtzLA0KUmF5DQoN
Cj4gDQo+IC0tLS0t6YKu5Lu25Y6f5Lu2LS0tLS0NCj4g5Y+R5Lu25Lq6OiBhbWQtZ2Z4IDxhbWQt
Z2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPiDku6PooaggSHVhbmcgUnVpDQo+IOWP
kemAgeaXtumXtDogMjAyMOW5tDLmnIgyMeaXpSAyMjozNA0KPiDmlLbku7bkuro6IFN0RGVuaXMs
IFRvbSA8VG9tLlN0RGVuaXNAYW1kLmNvbT4NCj4g5oqE6YCBOiBBbGV4IERldWNoZXIgPGFsZXhk
ZXVjaGVyQGdtYWlsLmNvbT47IGFtZC1nZnggbGlzdCANCj4gPGFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnPg0KPiDkuLvpopg6IFJlOiBbUEFUQ0hdIGRybS9hbWQvYW1kZ3B1OiBkaXNhYmxl
IEdGWE9GRiBhcm91bmQgZGVidWdmcyBhY2Nlc3MgDQo+IHRvIE1NSU8NCj4gDQo+IE9uIFdlZCwg
RmViIDE5LCAyMDIwIGF0IDEwOjA5OjQ2QU0gLTA1MDAsIFRvbSBTdCBEZW5pcyB3cm90ZToNCj4g
PiBJIGdvdCBzb21lIG1lc3NhZ2VzIGFmdGVyIGEgd2hpbGU6DQo+ID4gDQo+ID4gW8KgIDc0MS43
ODg1NjRdIEZhaWxlZCB0byBzZW5kIE1lc3NhZ2UgOC4NCj4gPiBbwqAgNzQ2LjY3MTUwOV0gRmFp
bGVkIHRvIHNlbmQgTWVzc2FnZSA4Lg0KPiA+IFvCoCA3NDguNzQ5NjczXSBGYWlsZWQgdG8gc2Vu
ZCBNZXNzYWdlIDJiLg0KPiA+IFvCoCA3NTkuMjQ1NDE0XSBGYWlsZWQgdG8gc2VuZCBNZXNzYWdl
IDcuDQo+ID4gW8KgIDc2My4yMTY5MDJdIEZhaWxlZCB0byBzZW5kIE1lc3NhZ2UgMmEuDQo+ID4g
DQo+ID4gQXJlIHRoZXJlIGFueSBhZGRpdGlvbmFsIGxvY2tzIHRoYXQgc2hvdWxkIGJlIGhlbGQ/
wqAgQmVjYXVzZSBzb21lIA0KPiA+IGNvbW1hbmRzIGxpa2UgLS10b3Agb3IgLS13YXZlcyBjYW4g
ZG8gYSBsb3Qgb2YgZGlzdGluY3QgcmVhZCANCj4gPiBvcGVyYXRpb25zIChjYXVzaW5nIGEgbG90
IG9mIGVuYWJsZS9kaXNhYmxlIGNhbGxzKS4NCj4gPiANCj4gPiBJJ20gZ29pbmcgdG8gc2l0IG9u
IHRoaXMgYSBiaXQgc2luY2UgSSBkb24ndCB0aGluayB0aGUgcGF0Y2ggaXMgDQo+ID4gcmVhZHkg
Zm9yIHB1c2hpbmcgb3V0Lg0KPiA+IA0KPiANCj4gSG93IGFib3V0IHVzZSBSUkVHMzJfS0lRIGFu
ZCBXUkVHMzJfS0lRPw0KPiANCj4gVGhhbmtzLA0KPiBSYXkNCj4gDQo+ID4gDQo+ID4gVG9tDQo+
ID4gDQo+ID4gT24gMjAyMC0wMi0xOSAxMDowNyBhLm0uLCBBbGV4IERldWNoZXIgd3JvdGU6DQo+
ID4gPiBPbiBXZWQsIEZlYiAxOSwgMjAyMCBhdCAxMDowNCBBTSBUb20gU3QgRGVuaXMgPHRvbS5z
dGRlbmlzQGFtZC5jb20+IHdyb3RlOg0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBUb20gU3QgRGVu
aXMgPHRvbS5zdGRlbmlzQGFtZC5jb20+DQo+ID4gPiBQbGVhc2UgYWRkIGEgcGF0Y2ggZGVzY3Jp
cHRpb24uICBXaXRoIHRoYXQgZml4ZWQ6DQo+ID4gPiBSZXZpZXdlZC1ieTogQWxleCBEZXVjaGVy
IDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPg0KPiA+ID4gDQo+ID4gPiA+IC0tLQ0KPiA+ID4g
PiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZWJ1Z2ZzLmMgfCAzICsrKw0K
PiA+ID4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykNCj4gPiA+ID4gDQo+ID4g
PiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGVidWdm
cy5jDQo+ID4gPiA+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RlYnVnZnMu
Yw0KPiA+ID4gPiBpbmRleCA3Mzc5OTEwNzkwYzkuLjY2Zjc2MzMwMGM5NiAxMDA2NDQNCj4gPiA+
ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RlYnVnZnMuYw0KPiA+
ID4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGVidWdmcy5jDQo+
ID4gPiA+IEBAIC0xNjksNiArMTY5LDcgQEAgc3RhdGljIGludCAgYW1kZ3B1X2RlYnVnZnNfcHJv
Y2Vzc19yZWdfb3AoYm9vbCByZWFkLCBzdHJ1Y3QgZmlsZSAqZiwNCj4gPiA+ID4gICAgICAgICAg
aWYgKHBtX3BnX2xvY2spDQo+ID4gPiA+ICAgICAgICAgICAgICAgICAgbXV0ZXhfbG9jaygmYWRl
di0+cG0ubXV0ZXgpOw0KPiA+ID4gPiANCj4gPiA+ID4gKyAgICAgICBhbWRncHVfZ2Z4X29mZl9j
dHJsKGFkZXYsIGZhbHNlKTsNCj4gPiA+ID4gICAgICAgICAgd2hpbGUgKHNpemUpIHsNCj4gPiA+
ID4gICAgICAgICAgICAgICAgICB1aW50MzJfdCB2YWx1ZTsNCj4gPiA+ID4gDQo+ID4gPiA+IEBA
IC0xOTIsNiArMTkzLDggQEAgc3RhdGljIGludCAgYW1kZ3B1X2RlYnVnZnNfcHJvY2Vzc19yZWdf
b3AoYm9vbCByZWFkLCBzdHJ1Y3QgZmlsZSAqZiwNCj4gPiA+ID4gICAgICAgICAgfQ0KPiA+ID4g
PiANCj4gPiA+ID4gICBlbmQ6DQo+ID4gPiA+ICsgICAgICAgYW1kZ3B1X2dmeF9vZmZfY3RybChh
ZGV2LCB0cnVlKTsNCj4gPiA+ID4gKw0KPiA+ID4gPiAgICAgICAgICBpZiAodXNlX2JhbmspIHsN
Cj4gPiA+ID4gICAgICAgICAgICAgICAgICBhbWRncHVfZ2Z4X3NlbGVjdF9zZV9zaChhZGV2LCAw
eGZmZmZmZmZmLCAweGZmZmZmZmZmLCAweGZmZmZmZmZmKTsNCj4gPiA+ID4gICAgICAgICAgICAg
ICAgICBtdXRleF91bmxvY2soJmFkZXYtPmdyYm1faWR4X211dGV4KTsNCj4gPiA+ID4gLS0NCj4g
PiA+ID4gMi4yNC4xDQo+ID4gPiA+IA0KPiA+ID4gPiBfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXw0KPiA+ID4gPiBhbWQtZ2Z4IG1haWxpbmcgbGlzdA0KPiA+
ID4gPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiA+ID4gPiBodHRwczovL25hbTEx
LnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlDQo+ID4g
PiA+IDJGDQo+ID4gPiA+IGxpc3RzLmZyZWVkZXNrdG9wLm9yZyUyRm1haWxtYW4lMkZsaXN0aW5m
byUyRmFtZC1nZngmYW1wO2RhdGE9MDINCj4gPiA+ID4gJTcNCj4gPiA+ID4gQzAxJTdDbW9uay5s
aXUlNDBhbWQuY29tJTdDYmE0NWVmYjI2YzAyNDBlZDAzNmYwOGQ3YjZkYjIwYWElN0MzZA0KPiA+
ID4gPiBkOCANCj4gPiA+ID4gOTYxZmU0ODg0ZTYwOGUxMWE4MmQ5OTRlMTgzZCU3QzAlN0MwJTdD
NjM3MTc4OTI0NjA1NTI0Mzc4JmFtcDtzZA0KPiA+ID4gPiBhdCANCj4gPiA+ID4gYT0lMkZ5SGt2
WVU1VCUyRjRpRnhSZXhzZyUyQklkbTdzRHp5WGJqek5wSFVHQ083aDRrJTNEJmFtcDtyZXNlcg0K
PiA+ID4gPiB2ZQ0KPiA+ID4gPiBkPTANCj4gPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXw0KPiA+IGFtZC1nZnggbWFpbGluZyBsaXN0DQo+ID4gYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gPiBodHRwczovL25hbTExLnNhZmVsaW5rcy5wcm90
ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZsaQ0KPiA+IHN0IA0KPiA+IHMu
ZnJlZWRlc2t0b3Aub3JnJTJGbWFpbG1hbiUyRmxpc3RpbmZvJTJGYW1kLWdmeCZhbXA7ZGF0YT0w
MiU3QzAxJTdDDQo+ID4gbW8NCj4gPiBuay5saXUlNDBhbWQuY29tJTdDYmE0NWVmYjI2YzAyNDBl
ZDAzNmYwOGQ3YjZkYjIwYWElN0MzZGQ4OTYxZmU0ODg0ZQ0KPiA+IDYwIA0KPiA+IDhlMTFhODJk
OTk0ZTE4M2QlN0MwJTdDMCU3QzYzNzE3ODkyNDYwNTUyNDM3OCZhbXA7c2RhdGE9JTJGeUhrdllV
NVQlDQo+ID4gMkYNCj4gPiA0aUZ4UmV4c2clMkJJZG03c0R6eVhianpOcEhVR0NPN2g0ayUzRCZh
bXA7cmVzZXJ2ZWQ9MA0KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXw0KPiBhbWQtZ2Z4IG1haWxpbmcgbGlzdA0KPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZw0KPiBodHRwczovL25hbTExLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29t
Lz91cmw9aHR0cHMlM0ElMkYlMkZsaXN0DQo+IHMuZnJlZWRlc2t0b3Aub3JnJTJGbWFpbG1hbiUy
Rmxpc3RpbmZvJTJGYW1kLWdmeCZhbXA7ZGF0YT0wMiU3QzAxJTdDbW8NCj4gbmsubGl1JTQwYW1k
LmNvbSU3Q2JhNDVlZmIyNmMwMjQwZWQwMzZmMDhkN2I2ZGIyMGFhJTdDM2RkODk2MWZlNDg4NGU2
MA0KPiA4ZTExYTgyZDk5NGUxODNkJTdDMCU3QzAlN0M2MzcxNzg5MjQ2MDU1MjQzNzgmYW1wO3Nk
YXRhPSUyRnlIa3ZZVTVUJTJGDQo+IDRpRnhSZXhzZyUyQklkbTdzRHp5WGJqek5wSFVHQ083aDRr
JTNEJmFtcDtyZXNlcnZlZD0wDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
ZngK
